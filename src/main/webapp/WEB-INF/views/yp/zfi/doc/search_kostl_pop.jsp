<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<sec:csrfMetaTags />
<title>
	<c:if test="${req_data.type eq 'Z'}">집행부서 검색</c:if>
	<c:if test="${req_data.type eq 'C'}">코스트센터 검색</c:if>
	<c:if test="${req_data.type eq 'R'}">집행부서 검색</c:if>
	<c:if test="${req_data.type eq 'B'}">예산조직 검색</c:if>
</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="http://malsup.github.com/jquery.form.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
<script type="text/javascript">
	$(document).ready(function() {
		$(".fn_paging").on("click", function() {
			$("input[name=page]").val($(this).attr("page"));
			fnSearchData();
		});
		
		$('input').on('keydown', function(e) {
			if (e.which == 13) {
				e.preventDefault();
				fnSearchData();
			}
		});
	});
	// 조회
	function fnSearchData() {
		if ($("input[name=search_text]").val().length >= 2) {
			var form = $("#frm")[0];
			form.submit();
		} else {
			alert("검색어는 2자 이상 입력하세요.");
		}
	}
	function fnSendData(i){
		var type = "${req_data.type}";
		var target = Number("${req_data.target}");
		if(type=="Z"){//집행부서
			$("input[name=I_GUBUN]").val("Z");
			opener.scope.gridOptions.data[target].ZKOSTL = $("input[name=KOST1]:eq("+i+")").val();	//집행부서
			opener.scope.gridOptions.data[target].ZKTEXT = $("input[name=VERAK]:eq("+i+")").val();	//집행부서 설명
		}else if(type=="C"){
			$("input[name=I_GUBUN]").val("C");
			opener.scope.gridOptions.data[target].KOSTL = $("input[name=KOST1]:eq("+i+")").val();	//계정과목
			opener.scope.gridOptions.data[target].LTEXT = $("input[name=VERAK]:eq("+i+")").val();	//계정과목 설명
		}else if(type=="R"){
			// 2020-07-23 jamerl - type=="BACT" 패턴 없음
			opener.scope.gridOptions.data[target].RORG = $("input[name=KOST1]:eq("+i+")").val();	//집행부서
			opener.scope.gridOptions.data[target].RORGTXT = $("input[name=VERAK]:eq("+i+")").val();	//집행부서 명
		}else if(type=="B"){
			// 2020-07-23 jamerl - type=="BACT" 패턴 없음
			opener.scope.gridOptions.data[target].BORG = $("input[name=KOST1]:eq("+i+")").val();	//예산조직
			opener.scope.gridOptions.data[target].BORGTXT = $("input[name=VERAK]:eq("+i+")").val();	//예산조직 명
		}
		opener.scope.gridApi.grid.refresh();
		
		self.close();
	}
</script>
</head>
<body>
	<div id="popup">
		<div class="pop_header">
			<c:if test="${req_data.type eq 'Z'}">집행부서 검색</c:if>
			<c:if test="${req_data.type eq 'C'}">코스트센터 검색</c:if>
			<c:if test="${req_data.type eq 'R'}">집행부서 검색</c:if>
			<c:if test="${req_data.type eq 'B'}">예산조직 검색</c:if>
		</div>
		<div class="pop_content">
			<form id="frm" name="frm" method="post" accept-charset="UTF-8">
				<!-- 20191023_khj for csrf -->
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="type" value="${req_data.type}" />
				<input type="hidden" name="target" value="${req_data.target}" />
				<input type="hidden" name="I_GUBUN" value="" />
				<input type="hidden" name="pageSize" value="15" />
				<input type="hidden" name="rangeSize" value="10" />
				<input type="hidden" name="page" value="${pagination.getCurPage()}" />
				<section>
				<div class="tbl_box">
					<select name="search_type">
						<option value="I_KOSTL">코스트센터</option>
						<option value="I_LTEXT" selected>설명</option>
					</select>
					<input type="text" name="search_text" size="20" value="${req_data.search_text}" />
					<a href="#" onclick="fnSearchData();"><img src="/resources/yp/images/ic_search.png"></a>
				</div>
				</section>
			</form>
			<section>
			<div class="lst">
				<table cellspacing="0" cellpadding="0">
					<colgroup>
						<col />
						<col />
						<col />
					</colgroup>
					<tr>
						<th>번호</th>
						<th>코스트센터</th>
						<th>설명</th>
					</tr>
					<c:if test="${fn:length(list) > 0}">
						<c:forEach var="list" items="${list}" varStatus="i">
							<tr onclick="fnSendData(${i.index});" style="cursor: pointer;">
								<!-- 			<tr style="cursor:pointer;"> -->
								<td>${(pagination.curPage-1) * pagination.pageSize + (i.index+1)}</td>
								<td>
									<fmt:parseNumber value="${list.KOST1}" />
									<input type="hidden" name="KOST1" value="<fmt:parseNumber value="${list.KOST1}"/>">
								</td>
								<td>${list.VERAK}<input type="hidden" name="VERAK" value="${list.VERAK}">
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${fn:length(list) == 0}">
						<tr>
							<td align="center" colspan="3">조회된 내역이 없습니다</td>
						</tr>
					</c:if>
				</table>
			</div>
			</section>
			<c:if test="${!empty pagination}">
				<div class="paginavi">
					<div class="paging">
						<c:if test="${pagination.curRange ne 1 }">
							<a href="javascript:void(0);" class="btnCtrl start fn_paging" page="1">◀◀</a>
						</c:if>
						<c:if test="${pagination.curPage ne 1}">
							<a href="javascript:void(0);" class="btnCtrl prev fn_paging" page="${pagination.getPrevPage()}">◀</a>
						</c:if>
						<c:forEach var="pageNum" begin="${pagination.getStartPage()}" end="${pagination.getEndPage()}">
							<c:choose>
								<c:when test="${pageNum eq  pagination.getCurPage()}">
									<a href="javascript:void(0);" class="page on fn_paging" page="${pageNum}">${pageNum}</a>
								</c:when>
								<c:otherwise>
									<a href="javascript:void(0);" class="page fn_paging" page="${pageNum}">${pageNum}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${pagination.getCurPage() ne pagination.getPageCnt() && pagination.getPageCnt() > 0}">
							<a href="javascript:void(0);" class="btnCtrl next fn_paging" page="${pagination.getNextPage()}">▶</a>
						</c:if>
						<c:if test="${pagination.getCurRange() ne pagination.getRangeCnt() && pagination.getRangeCnt() > 0}">
							<a href="javascript:void(0);" class="btnCtrl last fn_paging" page="${pagination.getPageCnt()}">▶▶</a>
						</c:if>
					</div>
				</div>
			</c:if>
			<div class="btn_wrap">
				<button class="btn" onclick="self.close();">닫기</button>
			</div>
		</div>
</body>
</html>