<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//MS excel로 다운로드/실행, filename에 저장될 파일명을 적어준다.
// response.setHeader("Content-Type", "application/vnd.ms-xls");
response.setHeader("Content-Disposition","attachment;filename=budget_status_s_pop.xls");
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

	<h3>실적 개별항목 조회</h3>
	<table border="1">
		<caption></caption>
		<thead>
			<tr>
				<th>전기일</th>
				<th>오브젝트</th>
				<th style="width:130px;">WBS 코드</th>
				<th>원가요소</th>
				<th>원가요소내역</th>
				<th>금액(CO 통화)</th>
				<th>통화키</th>
				<th>총수량</th>
				<th>단위</th>
				<th>자재번호</th>
				<th>자재내역</th>
				<th>전표번호</th>
				<th>전기행</th>
				<th>관계사 사업영역</th>
				<th>참조 전표 번호</th>
				<th>잠조전표의 회계연도</th>
				<th>참조절차</th>
				<th>집행부서명</th>
				<th>코스트센터명</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(lists) > 0}">
			<c:set var="sum_s" value="0"/>
			<c:forEach var="list" items="${lists}" varStatus="i">
				<tr>
					<td>${list.BUDAT}</td>
					<td>${list.OBART}</td>
					<td>${list.OBJID}</td>
					<td>${list.KSTAR}</td>
					<td>${list.ZGLTXT}</td>
					<td style="text-align:right;"><fmt:formatNumber value="${list.WKGBTR}" pattern="#,###" /><c:set var="sum_s" value="${sum_s + list.WKGBTR}"/></td>
					<td>${list.KWAER}</td>
					<td>${list.MEGBTR}</td>
					<td>${list.MEINH}</td>
					<td>${list.MATNR}</td>
					<td style="text-align:left;">${list.SGTXT}</td>
					<td>${list.BELNR}</td>
					<td>${list.BUZEI}</td>
					<td>${list.GSBER}</td>
					<td>${list.REFBN}</td>
					<td>${list.REFGJ}</td>
					<td>${list.AWTYP}</td>
					<td>${list.ZKTEXT}</td>
					<td>${list.ZCERTNO}</td>
				</tr>
			</c:forEach>
			<tr id="sum">
				<td colspan="5" style="text-align:center;">합 계</td>
				<td style="text-align:right;"><fmt:formatNumber value="${sum_s}" pattern="#,###" /></td>
				<td colspan="15"></td>
			</tr>
		</c:if>
		<c:if test="${fn:length(lists) == 0}">
			<tr><td align="center" colspan="21">조회된 내역이 없습니다</td></tr>
		</c:if>
		</tbody>
	</table>
	<div style="height:30px;"></div>

</body>
</html>