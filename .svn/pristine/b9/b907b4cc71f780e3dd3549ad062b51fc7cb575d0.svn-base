<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//MS excel로 다운로드/실행, filename에 저장될 파일명을 적어준다.
// response.setHeader("Content-Type", "application/vnd.ms-xls");
response.setHeader("Content-Disposition","attachment;filename=accesscontrol_list.xls");
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
	<h3>출입인원 목록</h3>
	<table border="1">
		<caption></caption>
		<thead>
			<tr>
				<th>순번</th>
				<th>구분</th>
				<th>소속업체</th>
				<th>출입번호</th>
				<th>성명</th>
				<th>생년월일</th>
				<th>주소</th>
				<th>연락처</th>
				<th>비상연락</th>
				<th>차종</th>
				<th>차량번호</th>
				<th>입사일</th>
				<th>퇴사일</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(list) > 0}">
		<c:forEach var="list" items="${list}" varStatus="i">
			<tr>
				<td>${list.RNUM}</td>
				<td>${list.ENT_TYPE_NAME}</td>
				<td>${list.ENT_NAME}</td>
				<td>${list.SUBC_CODE}</td>
				<td>${list.SUBC_NAME}</td>
				<td>${list.JUMIN}</td>
				<td>${list.ADDR}</td>
				<td style="mso-number-format:\@;">${list.CELL_PHONE}</td>
				<td style="mso-number-format:\@;">${list.PHONE}</td>
				<td>${list.VEHICLE_NAME}</td>
				<td>${list.VEHICLE_NO}</td>
				<td>${list.HIRED_DATE}</td>
				<td>${list.RESIGN_DATE}</td>
				<td>${list.STATUS_NAME}</td>
			</tr>
		</c:forEach>
		</c:if>
		<c:if test="${fn:length(list) == 0}">
			<tr><td align="center" colspan="14">조회된 내역이 없습니다</td></tr>
		</c:if>
			
		</tbody>
	</table>
 </body>
</html>