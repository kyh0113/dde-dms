<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//MS excel로 다운로드/실행, filename에 저장될 파일명을 적어준다.
// response.setHeader("Content-Type", "application/vnd.ms-xls");
response.setHeader("Content-Disposition","attachment;filename=budget_list.xls");
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
	<h3>예산 조회</h3>
	<table border="1">
		<caption></caption>
		<thead>
			<tr>
				<th>입력년월</th>
				<th>집행부서</th>
				<th>집행부서명</th>
				<th>예산조직</th>
				<th>예산조직명</th>
				<th>계정분류</th>
				<th>예산계정</th>
				<th>예산계정명</th>
				<th>계획금액</th>
				<th>예산금액</th>
				<th>사용금액</th>
				<th>가용금액</th>
				<th>통제구분</th>
				<th>통제시기</th>
				<th>통제부서</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(alllist) > 0}">
		<c:set var="sum_base" value="0"/>
		<c:set var="sum_bud" value="0"/>
		<c:set var="sum_act" value="0"/>
		<c:set var="sum_rem" value="0"/>
		<c:forEach var="list" items="${alllist}" varStatus="i">
			<tr>
				<td>
					${fn:substring(list.SPMON,0,4)}.${fn:substring(list.SPMON,4,6)}
					<input type="hidden" id="SPMON_${i.index}" value="${list.SPMON}">
					<input type="hidden" id="GSBER_${i.index}" value="${list.GSBER}">
				</td>
				<td>${list.RORG}<input type="hidden" id="RORG_${i.index}" value="${list.RORG}"></td>
				<td>${list.RORGTXT}</td>
				<td>${list.BORG}<input type="hidden" id="BORG_${i.index}" value="${list.BORG}"></td>
				<td>${list.BORGTXT}</td>
				<td>${list.CLASS}</td>
				<td>${list.BACT}<input type="hidden" id="BACT_${i.index}" value="${list.BACT}"></td>
				<td>${list.BACTTXT}</td>
				<td style="text-align:right;">
					<fmt:formatNumber value="${list.BASEAMT}" pattern="#,###" />
					<c:set var="sum_base" value="${sum_base + list.BASEAMT}"/>
				</td>
				<td style="text-align:right;">
					<c:if test="${list.BUDAMT ne '0.00'}">
						<fmt:formatNumber value="${list.BUDAMT}" pattern="#,###" />
					</c:if>
					<c:if test="${list.BUDAMT eq '0.00'}">0</c:if>
					<c:set var="sum_bud" value="${sum_bud + list.BUDAMT}"/>
				</td>
				<td style="text-align:right;">
					<c:if test="${list.ACTAMT ne '0.00'}">
						<fmt:formatNumber value="${list.ACTAMT}" pattern="#,###" />
					</c:if>
					<c:if test="${list.ACTAMT eq '0.00'}">0</c:if>
					<c:set var="sum_act" value="${sum_act + list.ACTAMT}"/>
				</td>
				<td style="text-align:right;">
					<fmt:formatNumber value="${list.REMAMT}" pattern="#,###" />
					<c:set var="sum_rem" value="${sum_rem + list.REMAMT}"/>
				</td>
				<td>${list.ACDETTXT}</td>
				<td>${list.ACTIMETXT}<input type="hidden" id="ACTIME_${i.index}" value="${list.ACTIME}"></td>
				<td>${list.ACSLFTXT}</td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="7">합 계<td>
			<td style="text-align:right;"><fmt:formatNumber value="${sum_base}" pattern="#,###" /></td>
			<td style="text-align:right;"><fmt:formatNumber value="${sum_bud}" pattern="#,###" /></td>
			<td style="text-align:right;"><fmt:formatNumber value="${sum_act}" pattern="#,###" /></td>
			<td style="text-align:right;"><fmt:formatNumber value="${sum_rem}" pattern="#,###" /></td>
			<td colspan="3"></td>
		</tr>
		</c:if>
		<c:if test="${fn:length(alllist) == 0}">
			<tr><td align="center" colspan="15">조회된 내역이 없습니다</td></tr>
		</c:if>
			
		</tbody>
	</table>
</body>
</html>