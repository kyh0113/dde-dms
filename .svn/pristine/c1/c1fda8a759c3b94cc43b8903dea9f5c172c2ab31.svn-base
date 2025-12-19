<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//MS excel로 다운로드/실행, filename에 저장될 파일명을 적어준다.
// response.setHeader("Content-Type", "application/vnd.ms-xls");
response.setHeader("Content-Disposition","attachment;filename=fixture_req_dtl.xls");
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
	<h3>비품요청 현황 상세목록</h3>
	<table border="1">
		<caption></caption>
		<thead>
			<tr>
				<th>번호</th>
				<th>제조사</th>
				<th>요청부서</th>
				<th>요청자</th>
				<th>비품명</th>
				<th>비품항목</th>
				<th>요청수량</th>
				<th>불출수량</th>
				<th>구매수량</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(alllist) > 0}">
			<c:forEach var="list" items="${alllist}" varStatus="i">
				<tr>
					<td>${i.index+1}</td>
					<td>${list.manufacturer}</td>
					<td>${list.req_dept_name}</td>
					<td>${list.req_user_name}</td>
					<td>${list.fixture_name}</td>
					<td>${list.fixture_type}</td>
					<td>${list.req_amount}</td>
					<td>${list.dispense_req_amount}</td>
					<td>${list.purchase_req_amount}</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${fn:length(alllist) == 0}">
			<tr><td align="center" colspan="9">조회된 내역이 없습니다</td></tr>
		</c:if>
			
		</tbody>
	</table>
</body>
</html>