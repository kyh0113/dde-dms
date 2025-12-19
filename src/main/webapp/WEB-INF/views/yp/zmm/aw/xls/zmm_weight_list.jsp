<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//MS excel로 다운로드/실행, filename에 저장될 파일명을 적어준다.
// response.setHeader("Content-Type", "application/vnd.ms-xls");
response.setHeader("Content-Disposition","attachment;filename=weight_data_list.xls");
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
	<h3>계량 데이터 조회</h3>
	<table border="1">
		<caption></caption>
		<thead>
			<tr>
				<th>번호</th>
				<th>거래처 코드</th>
				<th>거래처명</th>>
				<th>계량일자</th>
				<th>차량번호</th>
				<%--<th>품목코드</th>--%>
				<th>품목명</th>
				<th>상세품목코드</th>
				<th>상세품목명</th>
				<th>1차계량</th>
				<th>1차 시간</th>
				<th>2차계량</th>
				<th>2차 시간</th>
				<th>실중량</th>
				<th>상차장소</th>
				<th>하차장소</th>
				<th>일마감</th>
				<th>월마감</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(list) > 0}">
		<c:forEach var="list" items="${list}" varStatus="i">
			<tr>
				<td> ${i.index+1}</td>
<%-- 				<td>${list.ROWNO}</td> --%>
				<td>${list.ENT_CODE}</td>
				<td>${list.ENT}</td>
				<td>${list.SDATE}</td>
				<td>${list.TRUCK_NO}</td>
				<%--<td>${list.P_CODE}</td>--%>
				<td>${list.P_NAME}</td>
				<td>${list.P_DETAIL_CODE_SAP}</td>
				<td>${list.P_DETAIL_NAME}</td>
				<td style="mso-number-format:\@;">${list.WEIGHT1}</td>
				<td>${list.DATE1}</td>
				<td style="mso-number-format:\@;">${list.WEIGHT2}</td>
				<td>${list.DATE2}</td>
				<td style="mso-number-format:\@;">${list.FINAL_WEIGHT}</td>
				<td>${list.LOADING_PLACE}</td>
				<td>${list.STACKING_PLACE}</td>
				<td>${list.DAILY_CLOSING}</td>
				<td>${list.MONTHLY_CLOSING}</td>
				<td>${list.BIGO}</td>
			</tr>
		</c:forEach>
		</c:if>
		<c:if test="${fn:length(list) == 0}">
			<tr><td align="center" colspan="18">조회된 내역이 없습니다</td></tr>
		</c:if>
		</tbody>
	</table>
 </body>
</html>