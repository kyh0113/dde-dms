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

	<h3>사용금액 상세보기</h3>
	
	<table border="1">
		<caption style="padding-top:0px;"></caption>
		<thead>
			<tr>
				<th>지정</th>
				<th>전표번호</th>
				<th>참조키3</th>
				<th>전기일</th>
				<th>유형</th>
				<th>통화</th>
				<th>전표통화액</th>
				<th>현지통화금액</th>
				<th>텍스트</th>
				<th>코스트센터명</th>
				<th>사업영역</th>
				<th>계정명</th>
				<th>손익센터</th>
				<th>반제전표</th>
				<th>WBS요소</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(list) > 0}">
		<c:forEach var="list" items="${list}" varStatus="i">
			<tr>
				<td>${list.ZUONR}</td>
				<td>${list.BELNR}</td>
				<td>${list.XREF3}</td>
				<td>${fn:substring(list.BUDAT,0,4)}.${fn:substring(list.BUDAT,4,6)}.${fn:substring(list.BUDAT,6,8)}</td>
				<td>${list.BLART}</td>
				<td>${list.WAERS}</td>
				<td style="text-align:right;"><fmt:formatNumber value="${list.DMSHB}" pattern="#,###" /></td>
				<td style="text-align:right;"><fmt:formatNumber value="${list.BWWRT}" pattern="#,###" /></td>
				<td>${list.SGTXT}</td>
 				<td>${list.KTEXT}</td>
				<td>${list.GSBER}</td>
				<td>${list.TXT50}</td>
				<td>${list.PRCTR}</td>
				<td>${list.AUGBL}</td>
				<td>${list.PROJK}</td>
			</tr>
		</c:forEach>
		</c:if>
		<c:if test="${fn:length(list) == 0}">
			<tr><td align="center" colspan="15">조회된 내역이 없습니다</td></tr>
		</c:if>
		</tbody>
	</table>
</body>
</html>