<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//MS excel로 다운로드/실행, filename에 저장될 파일명을 적어준다.
// response.setHeader("Content-Type", "application/vnd.ms-xls");
response.setHeader("Content-Disposition","attachment;filename=document_list.xls");
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
	<h3>회계전표 목록</h3>
	<table border="1">
		<caption></caption>
		<thead>
			<tr>
				<th>번호</th>
				<th>상태</th>
				<th>승인여부</th>
				<th>전자결재</th>
				<th>전표번호</th>
				<th>원화금액</th>
				<th>외화금액</th>
				<th>통화</th>
				<th>전표헤더 텍스트</th>
				<th>거래처</th>
				<th>거래처명</th>
				<th>전기일</th>
<!-- 				<th>증빙일</th> -->
				<th>입력일</th>
<!-- 				<th>시간</th> -->
<!-- 				<th>GW ID</th> -->
<!-- 				<th>사원번호</th> -->
				<th>사원이름</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(alllist) > 0}">
		<c:forEach var="list" items="${alllist}" varStatus="i">
			<tr>
				<td>${i.index+1}</td>
				<td>
					<c:if test="${list.BTEXT eq 'Parking'}">임시</c:if>
					<c:if test="${list.BTEXT eq 'Posting'}">확정</c:if>
					<input type="hidden" name="BTEXT" value="${list.BTEXT}">
				</td>
				<td>
					${list.ZACCPT_TXT}
<%-- 					<c:if test="${list.ZACCPT eq ''}"></c:if> --%>
<%-- 					<c:if test="${list.ZACCPT eq 'X'}">승인</c:if> --%>
				</td>
				<td>
					<c:choose>
						<c:when test="${list.STTXT eq '미상신'}">
							<button class="cuporder" type="button" onclick="fnDocWrite('${i.index}');">상신하기</button>
						</c:when>
						<c:otherwise>${list.STTXT}</c:otherwise>
					</c:choose>
				</td>
				<td>${list.BELNR}</td>
				<td style="mso-number-format:\@;"><fmt:formatNumber value="${fn:trim(list.DMBTR)}" type="number"/></td>
				<td style="mso-number-format:\@;"><fmt:formatNumber value="${fn:trim(list.PSWBT)}" type="number"/></td>
				<td>${list.PSWSL}</td>
				<td>${list.BKTXT}</td>
				<td>${list.LIFNR}</td>
				<td>${list.NAME1}</td>
				<td>
					<fmt:parseDate var="BUDAT" value="${list.BUDAT}" pattern="yyyyMMdd"/>
					<fmt:formatDate value="${BUDAT}" pattern="yyyy/MM/dd"/>
				</td>
<!-- 				<td> -->
<%-- 					<fmt:parseDate var="BLDAT" value="${list.BLDAT}" pattern="yyyyMMdd"/> --%>
<%-- 					<fmt:formatDate value="${BLDAT}" pattern="yyyy/MM/dd"/> --%>
<!-- 				</td> -->
				<td>
					<fmt:parseDate var="CPUDT" value="${list.CPUDT}" pattern="yyyyMMdd"/>
					<fmt:formatDate value="${CPUDT}" pattern="yyyy/MM/dd"/>
				</td>
<!-- 				<td> -->
<%-- 					<fmt:parseDate var="CPUTM" value="${list.CPUTM}" pattern="HHmmss"/> --%>
<%-- 					<fmt:formatDate value="${CPUTM}" pattern="HH:mm:ss"/> --%>
<!-- 				</td> -->
<%-- 				<td>${list.BTEXT}</td> --%>
<%-- 				<td>${list.ZPERNR}</td> --%>
				<td>${list.ZSNAME}</td>
			</tr>
		</c:forEach>
		</c:if>
		<c:if test="${fn:length(alllist) == 0}">
			<tr><td align="center" colspan="20">조회된 내역이 없습니다</td></tr>
		</c:if>
			
		</tbody>
	</table>
</body>
</html>