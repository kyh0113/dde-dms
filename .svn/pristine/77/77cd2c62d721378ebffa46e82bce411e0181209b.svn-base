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

	<h3>예산금액 상세보기</h3>
	
	<table border="1">
		<caption style="padding-top:0px;"></caption>
		<thead>
			<tr>
				<th>집행부서</th>
				<th>집행부서명</th>
				<th>년월</th>
				<th>예산조직</th>
				<th>예산조직 이름</th>
				<th>예산계정</th>
				<th>예산계정 이름</th>
				<th>값 유형</th>
				<th>금액</th>
				<th>내역</th>
				<th>전용기간</th>
				<th>전용 사업영역</th>
				<th>전용 예산조직</th>
				<th>전용 예산조직명</th>
				<th>전용 예산계정</th>
				<th>전용 예산계정명</th>
				<th>승인상태</th>
				<th>생성자명</th>
				<th>생성일</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(list) > 0}">
		<c:forEach var="list" items="${list}" varStatus="i">
			<tr>
				<td>${list.RORG}</td>
				<td>${list.RORGTXT}</td>
				<td>${fn:substring(list.SPMON,0,4)}.${fn:substring(list.SPMON,4,6)}</td>
				<td>${list.BORG}</td>
				<td>${list.BORGTXT}</td>
				<td>${list.BACT}</td>
				<td>${list.BACTTXT}</td>
				<td>${list.VALTPTXT}</td>
				<td style="text-align:right;"><fmt:formatNumber value="${list.VALUE}" pattern="#,###" /></td>
				<td>${list.DOCUM}</td>
				<td>
					<c:if test="${list.C_SPMON ne '000000'}">${list.C_SPMON}</c:if>
				</td>
				<td>${list.C_GSBER}</td>
				<td>${list.C_BORG}</td>
				<td>${list.C_BORGTXT}</td>
				<td>${list.C_BACT}</td>
				<td>${list.C_BACTTXT}</td>
				<td>${list.STATUTXT}</td>
				<td>${list.ERNAM}</td>
				<td>${fn:substring(list.ERDAT,0,4)}.${fn:substring(list.ERDAT,4,6)}.${fn:substring(list.ERDAT,6,8)}</td>
			</tr>
		</c:forEach>
		</c:if>
		<c:if test="${fn:length(list) == 0}">
			<tr><td align="center" colspan="19">조회된 내역이 없습니다</td></tr>
		</c:if>
		</tbody>
	</table>
</div>
</body>
</html>