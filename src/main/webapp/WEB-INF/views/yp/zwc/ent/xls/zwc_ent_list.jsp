<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//MS excel로 다운로드/실행, filename에 저장될 파일명을 적어준다.
// response.setHeader("Content-Type", "application/vnd.ms-xls");
response.setHeader("Content-Disposition","attachment;filename=enterprise_list.xls");
response.setHeader("Content-Description", "JSP Generated Data");
 
// ↓ 이걸 풀어주면 열기/저장 선택창이 뜨는 게 아니라 그냥 바로 저장된다.
response.setContentType("application/vnd.ms-excel");
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
	<h3>협력업체 목록</h3>
	<table border="1">
		<caption></caption>
		<thead>
			<tr>
				<th>번호</th>
				<th>업체구분</th>
				<th>업체코드</th>
				<th>업체명</th>
				<th>대표전화</th>
				<th>E-Mail</th>
				<th>관리자 ID</th>
				<th>관리자 PW</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(list) > 0}">
		<c:forEach var="list" items="${list}" varStatus="i">
			<tr>
<%-- 				<td> ${i.index+1}</td> --%>
				<td> ${list.RNUM}</td>
				<td>
					<c:if test="${list.ENT_TYPE eq 'D'}">협력업체</c:if>
					<c:if test="${list.ENT_TYPE eq 'J'}">공사업체</c:if>
				</td>
				<td style="mso-number-format:\@;">${list.ENT_CODE}</td>
				<td>${list.ENT_NAME}</td>
				<td style="mso-number-format:\@;">${list.PHONE}</td>
				<td>${list.EMAIL}</td>
				<td>${list.ADMIN_ID}</td>
				<td>${list.ADMIN_PW}</td>
			</tr>
		</c:forEach>
		</c:if>
		<c:if test="${fn:length(list) == 0}">
			<tr><td align="center" colspan="8">조회된 내역이 없습니다</td></tr>
		</c:if>
		</tbody>
	</table>
 </body>
</html>