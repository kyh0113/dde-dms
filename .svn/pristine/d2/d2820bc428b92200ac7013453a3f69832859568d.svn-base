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
<title>부서원 검색</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="http://malsup.github.com/jquery.form.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
<script type="text/javascript">
	$(document).ready(function() {
		
	});
	
	function fnGoSearch(pageIndex) {
	    if (pageIndex) {
	        $("#page").val(pageIndex);
	    } else {
	        $("#page").val("1");
	    }
	    fnSearchData();
	}

	function fnSearchData(){
		if($("input[name=search_text]").val().length >= 2){
			$("#frm").submit();	
		}else{
			swalWarningCB("검색어는 2자 이상 입력하세요.");
		}
	}

	function fnSendData(i){
		opener.fnAddRow($("input[name=emp_cd]:eq("+i+")").val(),$("input[name=emp_name]:eq("+i+")").val(),$("input[name=orgtx]:eq("+i+")").val());
		self.close();
	}
</script>
</head>
<body>
	<div id="popup">
		<div class="pop_header">부서원 검색</div>
		<div class="pop_content">
			<form id="frm" name="frm" method="post" accept-charset="UTF-8">
				<!-- 20191023_khj for csrf -->
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" id="page" name="page" value=""/>
			
			<section>
			<div class="tbl_box">
				<select name="search_type">
					<option value="NAME" <c:if test="${req_data.search_type eq 'NAME'}">selected</c:if>>이름</option>
					<option value="SABUN" <c:if test="${req_data.search_type eq 'SABUN'}">selected</c:if>>사번</option>
				</select>
				<input type="text" name="search_text" size="20" value="${req_data.search_text}" />
				<a href="#" onclick="fnSearchData();"><img src="/resources/yp/images/ic_search.png"></a>
			</div>
			</form>
			<div class="lst">
				<table cellspacing="0" cellpadding="0">
					<colgroup>
						<col />
						<col />
						<col />
						<col />
					</colgroup>
					<tr>
						<th>사번</th>
						<th>성명</th>
						<th>근무반</th>
						<th>근무조</th>
					</tr>
					<c:if test="${fn:length(list) > 0}">
						<c:forEach var="list" items="${list}" varStatus="i">
						<tr onclick="fnSendData('${i.index}');" style="cursor:pointer;">
							<td>${list.EMP_CD}<input type="hidden" name="emp_cd" value="${list.EMP_CD}"></td>
							<td>${list.EMP_NAME}<input type="hidden" name="emp_name" value="${list.EMP_NAME}"></td>
							<td>
								${list.ZCLST}
								<input type="hidden" name="orgtx" value="${list.ORGTX}">
								<input type="hidden" name="zclst" value="${list.ZCLST}">
							</td>
							<td>
								${list.JO_NAME}
								<input type="hidden" name="jo_name" value="${list.JO_NAME}">
							</td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${fn:length(list) == 0}">
						<tr>
							<td align="center" colspan="6">조회된 내역이 없습니다</td>
						</tr>
					</c:if>
				</table>
			</div>
			</section>
			<div class="btn_wrap">
				<button class="btn" onclick="self.close();">닫기</button>
			</div>
		</div>
</body>
</html>