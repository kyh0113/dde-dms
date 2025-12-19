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
<title>동명인 조회</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="http://malsup.github.com/jquery.form.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
<script type="text/javascript">
	$(document).ready(function() {
		
	});
	
	function fnSendData(i) {
		var target = Number("${target}");
		opener.scope.gridOptions.data[target].EMP_CODE = $("input[name=EMP_CD]:eq(" + i + ")").val(); 		//사번
		opener.scope.gridOptions.data[target].EMP_NAME = $("input[name=EMP_NAME]:eq(" + i + ")").val(); 	//성명
		opener.scope.gridOptions.data[target].TEAM_CODE = $("input[name=ORGEH]:eq(" + i + ")").val(); 		//부서코드
		opener.scope.gridOptions.data[target].TEAM_NAME = $("input[name=ORGTX]:eq(" + i + ")").val(); 		//부서명
		opener.scope.gridOptions.data[target].WORK_GROUP_CODE = $("input[name=ZCLSS]:eq(" + i + ")").val(); //반코드
		opener.scope.gridOptions.data[target].WORK_GROUP = $("input[name=ZCLST]:eq(" + i + ")").val(); 		//반명
		opener.scope.gridOptions.data[target].WORK_SHIFT_CODE = $("input[name=SCHKZ]:eq(" + i + ")").val(); //조코드
		opener.scope.gridOptions.data[target].WORK_SHIFT = $("input[name=JO_NAME]:eq(" + i + ")").val(); 	//조명
		opener.scope.gridApi.grid.refresh();
		opener.parent.fnPopCallOriginWork(target);
		self.close();
	}
</script>
</head>
<body>
	<div id="popup">
		<div class="pop_header">동명인 조회</div>
		<div class="pop_content">
			<section>
			<div class="lst">
				<table cellspacing="0" cellpadding="0">
					<colgroup>
						<col />
						<col />
						<col />
					</colgroup>
					<tr>
						<th>사번</th>
						<th>성명</th>
						<th>부서명</th>
					</tr>
					<c:if test="${fn:length(list) > 0}">
						<c:forEach var="list" items="${list}" varStatus="i">
							<tr onclick="fnSendData(${i.index});">
								<td>${list.EMP_CD}<input type="hidden" name="EMP_CD" value="${list.EMP_CD}"></td>
								<td>${list.EMP_NAME}<input type="hidden" name="EMP_NAME" value="${list.EMP_NAME}"></td>
								<td>${list.ORGTX}<input type="hidden" name="ORGTX" value="${list.ORGTX}">
									<input type="hidden" name="ORGEH" value="${list.ORGEH}">
									<input type="hidden" name="SCHKZ" value="${list.SCHKZ}">
									<input type="hidden" name="JO_NAME" value="${list.JO_NAME}">
									<input type="hidden" name="ZCLSS" value="${list.ZCLSS}">
									<input type="hidden" name="ZCLST" value="${list.ZCLST}">
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
			
			<div class="btn_wrap">
				<button class="btn" onclick="self.close();">닫기</button>
			</div>
		</div>
</body>
</html>