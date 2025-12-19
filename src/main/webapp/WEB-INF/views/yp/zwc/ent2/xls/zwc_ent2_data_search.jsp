<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//MS excel로 다운로드/실행, filename에 저장될 파일명을 적어준다.
// response.setHeader("Content-Type", "application/vnd.ms-xls");
response.setHeader("Content-Disposition","attachment;filename=data_search_list.xls");
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
	<h3>데이터 조회</h3>
	<table border="1">
		<caption></caption>
		<thead>
			<tr>
				<th>날짜</th>
				<th>작업자</th>
				<th>계약명</th>
				<th>입장시간</th>
				<th>퇴장시간</th>
				<th>구분</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(list) > 0}">
		<c:forEach var="list" items="${list}" varStatus="i">
			<tr>
				<td>${list.DT}</td>
				<td>${list.SUBC_NAME}</td>
				<td>${list.CONTRACT_NAME}</td>
				<td>${list.A_START_DATE}</td>
				<td>${list.A_END_DATE}</td>
				<td>${list.KTEXT}</td>
			</tr>
		</c:forEach>
		</c:if>
		<c:if test="${fn:length(list) == 0}">
			<tr><td align="center" colspan="6">조회된 내역이 없습니다</td></tr>
		</c:if>
		</tbody>
	</table>
 </body>
</html>