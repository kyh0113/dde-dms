<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//MS excel로 다운로드/실행, filename에 저장될 파일명을 적어준다.
// response.setHeader("Content-Type", "application/vnd.ms-xls");
response.setHeader("Content-Disposition","attachment;filename=budget_status_x_list.xls");
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
<title>투보수 예산상세 조회</title>
</head>
<body>

	<h3>투보수 예산상세 조회</h3>

	<table id="tableData" border="1">
		<caption></caption>
		<thead>
			<tr>
				<c:if test="${list[0].TITLE ne ''}">
					<th>프로젝트목적</th>
					<th>보조목적</th>
					<c:set var="table_type" value="A"/>
				</c:if>
				<th>WBS코드</th>
				<th>WBS코드 내역</th>
				<th>품의금액</th>
				<c:if test="${req_data.GUBUN eq '1'}">
					<th>계약금액</th>
					<th>투자금액</th>
				</c:if>
				<c:if test="${req_data.GUBUN ne '1'}">
					<th>오더금액</th>
					<th>집행금액</th>
				</c:if>
				<th>지급금액</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(list) > 0}">
			<c:set var="sum_cs" value="0"/><c:set var="sum_co" value="0"/><c:set var="sum_or" value="0"/><c:set var="sum_pr" value="0"/>
			<c:set var="total_cs" value="0"/><c:set var="total_co" value="0"/><c:set var="total_or" value="0"/><c:set var="total_pr" value="0"/>
			<c:forEach var="list" items="${list}" varStatus="i">
				<tr>
					<c:if test="${table_type eq 'A'}">
						<td style="text-align:left;vertical-align: top;" class="firstColumn">${list.TITLE}</td>
						<td style="text-align:left;vertical-align: top;" class="secondColumn">${list.TITLE2}</td>
					</c:if>
					<td>${list.POSID}</td>
					<td style="text-align:left;">${list.POST1}</td>
					<td style="text-align:right;">
						<fmt:formatNumber value="${fn:trim(list.DMBTR_CS)}" pattern="#,###" />
					</td>
					<td style="text-align:right;">                 
						<fmt:formatNumber value="${fn:trim(list.DMBTR_CO)}" pattern="#,###" />
					</td>
					<td style="text-align:right;">
						<fmt:formatNumber value="${fn:trim(list.DMBTR_OR)}" pattern="#,###" />
					</td>
					<td style="text-align:right;">
						<fmt:formatNumber value="${fn:trim(list.DMBTR_PR)}" pattern="#,###" />
					</td>
					
					<c:set var="sum_cs" value="${sum_cs + fn:trim(list.DMBTR_CS)}"/>
					<c:set var="sum_co" value="${sum_co + fn:trim(list.DMBTR_CO)}"/>
					<c:set var="sum_or" value="${sum_or + fn:trim(list.DMBTR_OR)}"/>
					<c:set var="sum_pr" value="${sum_pr + fn:trim(list.DMBTR_PR)}"/>
				</tr>
				
				<c:set var="nexttitle" value="${list[i.index+1].TITLE}"/>
				<c:if test="${list.TITLE ne nexttitle}">
					<tr id="sum">
						<c:if test="${table_type eq 'A'}">
							<td colspan="4">소 계</td>
						</c:if>
						<c:if test="${table_type ne 'A'}">
							<td colspan="2">소 계</td>
						</c:if>
						<td style="text-align:right;"><fmt:formatNumber value="${sum_cs}" pattern="#,###" /></td>
						<td style="text-align:right;"><fmt:formatNumber value="${sum_co}" pattern="#,###" /></td>
						<td style="text-align:right;"><fmt:formatNumber value="${sum_or}" pattern="#,###" /></td>
						<td style="text-align:right;"><fmt:formatNumber value="${sum_pr}" pattern="#,###" /></td>
						<c:set var="total_cs" value="${total_cs + sum_cs}"/>
						<c:set var="total_co" value="${total_co + sum_co}"/>
						<c:set var="total_or" value="${total_or + sum_or}"/>
						<c:set var="total_pr" value="${total_pr + sum_pr}"/>
						<c:set var="sum_cs" value="0"/><c:set var="sum_co" value="0"/><c:set var="sum_or" value="0"/><c:set var="sum_pr" value="0"/>
					</tr>
				</c:if>
			</c:forEach>
			
			<tr id="total">
				<c:if test="${table_type eq 'A'}">
					<td colspan="4">합 계</td>
				</c:if>
				<c:if test="${table_type ne 'A'}">
					<td colspan="2">합 계</td>
				</c:if>
				<td style="text-align:right;"><fmt:formatNumber value="${total_cs}" pattern="#,###" /></td>
				<td style="text-align:right;"><fmt:formatNumber value="${total_co}" pattern="#,###" /></td>
				<td style="text-align:right;"><fmt:formatNumber value="${total_or}" pattern="#,###" /></td>
				<td style="text-align:right;"><fmt:formatNumber value="${total_pr}" pattern="#,###" /></td>
			</tr>
		</c:if>
		<c:if test="${fn:length(list) == 0}">
			<tr><td align="center" colspan="8">조회된 내역이 없습니다</td></tr>
		</c:if>
		</tbody>
	</table>

 </body>
</html> 