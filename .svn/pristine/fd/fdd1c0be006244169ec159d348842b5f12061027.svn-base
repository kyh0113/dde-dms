<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//MS excel로 다운로드/실행, filename에 저장될 파일명을 적어준다.
// response.setHeader("Content-Type", "application/vnd.ms-xls");
response.setHeader("Content-Disposition","attachment;filename=budget_status_list.xls");
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
	<h3>투보수 예산현황 조회</h3>
	<table border="1">
		<caption></caption>
		<thead>
			<tr>
				<th>WBS 코드</th>
				<th>예산</th>
				<th>실적</th>
				<th>약정</th>
				<th>지정(실적+약정)</th>
				<th>사용가능</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(list) > 0}">
			<c:set var="sum_b" value="0"/>
			<c:set var="sum_s" value="0"/>
			<c:set var="sum_y" value="0"/>
			<c:set var="sum_sy" value="0"/>
			<c:set var="sum_a" value="0"/>
			<c:forEach var="list" items="${list}" varStatus="i">
				<tr>
					<td style="text-align:left;">
						<c:if test="${list.LEVEL eq 1}">
							<c:set var="sum_b" value="${sum_b + list.DMBTR_B}"/>
							<c:set var="sum_s" value="${sum_s + list.DMBTR_S}"/>
							<c:set var="sum_y" value="${sum_y + list.DMBTR_Y}"/>
							<c:set var="sum_sy" value="${sum_sy + list.DMBTR_SY}"/>
							<c:set var="sum_a" value="${sum_a + list.DMBTR_A}"/>
						</c:if>
						<c:if test="${list.LEVEL ge 2}">&nbsp;&nbsp;</c:if><c:if test="${list.LEVEL ge 3}">&nbsp;&nbsp;</c:if>
						${list.PSPID} ${list.POST1}
					</td>
					<td style="text-align:right;"><fmt:formatNumber value="${list.DMBTR_B}" pattern="#,###" /></td>
					<td style="text-align:right;"><fmt:formatNumber value="${list.DMBTR_S}" pattern="#,###" /></td>
					<td style="text-align:right;"><fmt:formatNumber value="${list.DMBTR_Y}" pattern="#,###" /></td>
					<td style="text-align:right;"><fmt:formatNumber value="${list.DMBTR_SY}" pattern="#,###" /></td>
					<td style="text-align:right;"><fmt:formatNumber value="${list.DMBTR_A}" pattern="#,###" /></td>
				</tr>
			</c:forEach>
			<tr id="total">
				<td>합 계</td>
				<td style="text-align:right;"><fmt:formatNumber value="${sum_b}" pattern="#,###" /></td>
				<td style="text-align:right;"><fmt:formatNumber value="${sum_s}" pattern="#,###" /></td>
				<td style="text-align:right;"><fmt:formatNumber value="${sum_y}" pattern="#,###" /></td>
				<td style="text-align:right;"><fmt:formatNumber value="${sum_sy}" pattern="#,###" /></td>
				<td style="text-align:right;"><fmt:formatNumber value="${sum_a}" pattern="#,###" /></td>
			</tr>
		</c:if>
		<c:if test="${fn:length(list) == 0}">
			<tr><td align="center" colspan="6">조회된 내역이 없습니다</td></tr>
		</c:if>
		</tbody>
	</table>

</body>
</html>