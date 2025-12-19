<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//MS excel로 다운로드/실행, filename에 저장될 파일명을 적어준다.
// response.setHeader("Content-Type", "application/vnd.ms-xls");
response.setHeader("Content-Disposition","attachment;filename=budget_status_b_pop.xls");
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

	<h3>예산 개별항목 조회</h3>

	<table border="1">
		<caption></caption>
		<thead>
			<tr>
				<th>생성일</th>
				<th>WBS 코드</th>
				<th>회계연도</th>
				<th>오브젝트</th>
				<th>금액(거래 통화)</th>
				<th>통화 키</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(listb) > 0}">
			<c:set var="sum_b" value="0"/>
			<c:forEach var="list" items="${listb}" varStatus="i">
				<tr>
					<td>${list.CPUDT}</td>
					<td>${list.OBJID}</td>
					<td>${list.GJAHR}</td>
					<td>${list.OBART}</td>
					<td style="text-align:right;"><fmt:formatNumber value="${list.WTJHR}" pattern="#,###" /><c:set var="sum_b" value="${sum_b + list.WTJHR}"/></td>
					<td>${list.TWAER}</td>
				</tr>
			</c:forEach>
			<tr id="sum">
				<td colspan="4" style="text-align:center;">합 계</td>
				<td style="text-align:right;"><fmt:formatNumber value="${sum_b}" pattern="#,###" /></td>
				<td></td>
			</tr>
		</c:if>
		<c:if test="${fn:length(listb) == 0}">
			<tr><td align="center" colspan="6">조회된 내역이 없습니다</td></tr>
		</c:if>
		</tbody>
	</table>

</body>
</html>