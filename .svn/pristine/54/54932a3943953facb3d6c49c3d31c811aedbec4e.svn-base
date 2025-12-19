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
<title>계정과목 검색</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="http://malsup.github.com/jquery.form.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
<script type="text/javascript">
	$(document).ready(function() {
		$("input[name=LIFNR]").val($("input[name=LIFNR]",opener.document).val());
		$("input[name=AGKOA]").val($("select[name=AGKOA]",opener.document).val());
		$("input[name=doc_type]").val($("input[name=doc_type]:checked",opener.document).val());
		
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
		$("input[name=HKONT]", opener.document).val($("input[name=ABWHK]:eq("+i+")").val());		//계정과목
		$("input[name=TXT_50]", opener.document).val($("input[name=TXT_50]:eq("+i+")").val());		//계정과목 설명
		
		self.close();
	}
</script>
</head>
<body>
	<div id="popup">
		<div class="pop_header">계정과목 검색</div>
		<div class="pop_content">
			<form id="frm" name="frm" method="post" accept-charset="UTF-8">
				<!-- 20191023_khj for csrf -->
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="I_GUBUN" value="X" />
				<input type="hidden" name="LIFNR" value="" />
				<input type="hidden" name="AGKOA" value="" />
				<input type="hidden" name="doc_type" value="" />
				<input type="hidden" name="pageSize" value="15" />
				<input type="hidden" name="rangeSize" value="10" />
				<input type="hidden" name="page" value="${pagination.getCurPage()}" />
				<section>
				<div class="tbl_box">
					<select name="search_type">
						<option value="I_HKONT">코드</option>
						<option value="I_TXT_50" selected>설명</option>
					</select>
					<input type="text" name="search_text" size="20" value="${req_data.search_text}" />
					<a href="#" onclick="fnSearchData();"><img src="/resources/yp/images/ic_search.png"></a>
				</div>
				</section>
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
							<th>코드</th>
							<th>설명</th>
						</tr>
						<c:if test="${fn:length(list) > 0}">
							<c:forEach var="list" items="${list}" varStatus="i">
								<tr onclick="fnSendData(${i.index});" style="cursor: pointer;">
									<td>${(pagination.curPage-1) * pagination.pageSize + (i.index+1)}</td>
									<td>
										<fmt:parseNumber value="${list.ABWHK}" />
										<input type="hidden" name="ABWHK" value="<fmt:parseNumber value="${list.ABWHK}"/>">
									</td>
									<td>${list.TXT20}<input type="hidden" name="TXT_50" value="${list.TXT20}">
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
			</form>
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