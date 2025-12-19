<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//MS excel로 다운로드/실행, filename에 저장될 파일명을 적어준다.
// response.setHeader("Content-Type", "application/vnd.ms-xls");
response.setHeader("Content-Disposition","attachment;filename=budget_status_y_pop.xls");
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

	<h3>약정 개별항목 조회</h3>
	<table border="1">
		<caption></caption>
		<thead>
			<tr>
				<th>참조전표범주</th>
				<th>차변일자</th>
				<th>오브젝트<br>유형</th>
				<th style="width:130px;">WBS 코드</th>
				<th>원가 요소</th>
				<th>금액<br>(CO 톻화)</th>
				<th>총 수량</th>
				<th>단위</th>
				<th>자재 번호</th>
				<th>자재내역</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(listy) > 0}">
			<c:set var="sum_yw" value="0"/>
			<c:set var="sum_ym" value="0"/>
			<c:forEach var="list" items="${listy}" varStatus="i">
				<tr>
					<td>${list.REFBTXT}</td>
					<td>${list.BUDAT}</td>
					<td>${list.OBART}</td>
					<td>${list.OBJID}</td>
					<td>${list.SAKTO}</td>
					<td style="text-align:right;"><fmt:formatNumber value="${list.WKGBTR}" pattern="#,###" /><c:set var="sum_yw" value="${sum_yw + list.WKGBTR}"/></td>
					<td style="text-align:right;"><fmt:formatNumber value="${list.MEGBTR}" pattern="#,###" /><c:set var="sum_ym" value="${sum_ym + list.MEGBTR}"/></td>
					<td>${list.MEINH}</td>
					<td>${list.MATNR}</td>
					<td>${list.SGTXT}</td>
				</tr>
			</c:forEach>
			<tr id="sum">
				<td colspan="5" style="text-align:center;">합 계</td>
				<td style="text-align:right;"><fmt:formatNumber value="${sum_yw}" pattern="#,###" /></td>
				<td style="text-align:right;"><fmt:formatNumber value="${sum_ym}" pattern="#,###" /></td>
				<td colspan="3"></td>
			</tr>
		</c:if>
		<c:if test="${fn:length(listy) == 0}">
			<tr><td align="center" colspan="8">조회된 내역이 없습니다</td></tr>
		</c:if>
		</tbody>
	</table>

</body>
</html>