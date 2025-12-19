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
<meta http-equiv="X-UA-Compatible" content="IE=edge" >
<sec:csrfMetaTags />
<title>계약명 검색</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="http://malsup.github.com/jquery.form.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
<script type="text/javascript">
	$(document).ready(function() {
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
		if($("input[name=SAP_CODE]", opener.document)){
			console.log($("input[name=SAP_CODE]", opener.document).val());
			$("#popup input[name=SAP_CODE]").val($("input[name=SAP_CODE]", opener.document).val());
		}else{
			$("#popup input[name=SAP_CODE]").val("");
		}
		var form = $("#frm")[0];
		form.submit();
	}
	function fnSendData(i){		
		var type = "${req_data.type}";
		var target = Number("${req_data.target}");
		console.log(i);
		
		$("input[name=CONTRACT_CODE]", opener.document).val($("input[name=CONTRACT_CODE_INPUT]:eq("+i+")").val());		//계약명
		$("input[name=CONTRACT_NAME]", opener.document).val($("input[name=CONTRACT_NAME_INPUT]:eq("+i+")").val());		//계약명
		
		$("input[name=SAP_CODE]", opener.document).val($("input[name=SAP_CODE_INPUT]:eq("+i+")").val()); //SAP코드
		$("input[name=VENDOR_CODE]", opener.document).val($("input[name=VENDOR_CODE_INPUT]:eq("+i+")").val()); // 거래처코드
		$("input[name=VENDOR_NAME]", opener.document).val($("input[name=VENDOR_NAME_INPUT]:eq("+i+")").val()); // 거래처명
		
		// 거래처명 readOnly처리
		$("#name1",opener.document).prop('readonly', true);
		
		<c:if test='${req_data.PAY_STANDARD eq "1"}'>
		$("input[name=CONTRACT_PEOPLE_CNT]", opener.document).val($("input[name=CONTRACT_PEOPLE_CNT]:eq("+i+")").val()); // 계약 인원
		$("input[name=DAILY_REQ_PEOPLE_CNT]", opener.document).val($("input[name=DAILY_REQ_PEOPLE_CNT]:eq("+i+")").val()); // 일일 필수 출근 인원
		</c:if>
		
		self.close();
	}
</script>
</head>
<body>
	<div id="popup">
		<div class="pop_header">계약명 검색</div>
		<div class="pop_content">
			<form id="frm" name="frm" method="post" accept-charset="UTF-8">
				<!-- 20191023_khj for csrf -->
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="type" value="${req_data.type}" />
				<input type="hidden" name="target" value="${req_data.target}" />
				<input type="hidden" name="I_GUBUN" value="X" />
				<input type="hidden" name="AGKOA" value="" />
				<input type="hidden" name="doc_type" value="" />
				<input type="hidden" name="pageSize" value="15" />
				<input type="hidden" name="rangeSize" value="10" />
				<input type="hidden" name="page" value="${pagination.getCurPage()}" />
				<input type="hidden" name="PAY_STANDARD" value="${req_data.PAY_STANDARD}" />
				<input type="hidden" name="SAP_CODE" value="" />
				<section>
				<div class="tbl_box">
					<select name="search_type">
						<option value="CONTRACT_NAME" <c:if test="${req_data.search_type eq 'CONTRACT_NAME'}">selected</c:if>>계약명</option>
						<option value="CONTRACT_CODE" <c:if test="${req_data.search_type eq 'CONTRACT_CODE'}">selected</c:if>>계약코드</option>
						<option value="VENDOR_CODE" <c:if test="${req_data.search_type eq 'VENDOR_CODE'}">selected</c:if>>SAP코드</option>
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
							<col />
							<col />
						</colgroup>
						<tr>
							<th>번호</th>
							<th>지급기준</th>
							<th>계약명</th>
							<th>계약코드</th>
							<th>SAP코드</th>
						</tr>
						<c:if test="${fn:length(list) > 0}">
							<c:forEach var="list" items="${list}" varStatus="i">
								<tr onclick="fnSendData(${i.index});" style="cursor: pointer;">
									<input type="hidden" name="VENDOR_CODE_INPUT" value="${list.VENDOR_CODE}">
									<input type="hidden" name="VENDOR_NAME_INPUT" value="${list.VENDOR_NAME}">
									<input type="hidden" name="SAP_CODE_INPUT" value="${list.SAP_CODE}">
									<input type="hidden" name="CONTRACT_PEOPLE_CNT" value="${list.CONTRACT_PEOPLE_CNT}">
									<input type="hidden" name="DAILY_REQ_PEOPLE_CNT" value="${list.DAILY_REQ_PEOPLE_CNT}">
									<td>${(pagination.curPage-1) * pagination.pageSize + (i.index+1)}</td>
									<td>${list.PAY_STANDARD_NAME}</td>
									<td>${list.CONTRACT_NAME}<input type="hidden" name="CONTRACT_NAME_INPUT" value="${list.CONTRACT_NAME}"></td>
									<td>${list.CONTRACT_CODE}<input type="hidden" name="CONTRACT_CODE_INPUT" value="${list.CONTRACT_CODE}"></td>
									<td>${list.SAP_CODE}</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${fn:length(list) == 0}">
							<tr>
								<td align="center" colspan="5">조회된 내역이 없습니다</td>
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