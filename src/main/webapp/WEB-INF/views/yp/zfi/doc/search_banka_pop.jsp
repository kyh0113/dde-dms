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
<title>은행 검색</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="http://malsup.github.com/jquery.form.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
<script type="text/javascript">
	$(document).ready(function() {
		$("#E_FLAG").on("change",function(){
			if($("#E_FLAG").val() == "E") alert($("#E_MESSAGE").val());
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
		$("#E_FLAG").val("");
		var form = $("#frm")[0];
		form.submit();
	}
	function fnSendData(i){
		$("input[name=WAERS]", opener.document).val($("input[name=WAERS]:eq("+i+")").val());		//계정과목
		$("input[name=KURSF]", opener.document).val($("input[name=UKURS]:eq("+i+")").val());		//계정과목 설명
		
		self.close();
	}
</script>
</head>
<body>
	<div id="popup">
		<div class="pop_header">은행 검색</div>
		<div class="pop_content">
			<form id="frm" name="frm" method="post" accept-charset="UTF-8">
				<!-- 20191023_khj for csrf -->
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" id="E_FLAG" value="${req_data.E_FLAG}" />
				<input type="hidden" id="E_MESSAGE" value="${req_data.E_MESSAGE}" />
				<section>
				<div class="tbl_box">
					<select name="search_type">
						<option value="I_BANKL" <c:if test="${req_data.search_type eq 'I_BANKL'}">selected</c:if>>은행번호</option>
						<option value="I_BANKA" <c:if test="${req_data.search_type eq 'I_BANKA'}">selected</c:if>>은행명</option>
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
							<th>은행번호</th>
							<th>은행이름</th>
						</tr>
						<c:if test="${fn:length(list) > 0}">
							<c:forEach var="list" items="${list}" varStatus="i">
								<tr onclick="fnSendData(${i.index});" style="cursor: pointer;">
									<td>${(pagination.curPage-1) * pagination.pageSize + (i.index+1)}</td>
									<td>${list.BANKL}<input type="hidden" name="BANKL" value="${list.BANKL}">
									</td>
									<td>${list.BANKA}<input type="hidden" name="BANKA" value="${list.BANKA}">
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
			<div class="btn_wrap">
				<button class="btn" onclick="self.close();">닫기</button>
			</div>
		</div>
</body>
</html>