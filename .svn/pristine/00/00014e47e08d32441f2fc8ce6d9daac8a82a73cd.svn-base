<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//MS excel로 다운로드/실행, filename에 저장될 파일명을 적어준다.
// response.setHeader("Content-Type", "application/vnd.ms-xls");
response.setHeader("Content-Disposition","attachment;filename=budget_wbs_detail_list.xls");
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
	
	<c:choose>
		
		<c:when test="${req_data.GUBUN2 eq '1'}">
			<h3>
				<c:if test="${req_data.GUBUN eq '1'}">계약내역 조회</c:if>
				<c:if test="${req_data.GUBUN eq '8'}">오더금액 조회</c:if>
			</h3>
			<table border="1">
				<c:set var="sum_BRTWR" value="0"/>
				<c:set var="sum_BRTWR_KRW" value="0"/>
				<caption style="padding-top:0px;"></caption>
				<thead>
					<tr>
						<th style="width:70px;">투자코드</th>
						<th style="width:150px;">투자내역</th>
						<th style="width:130px;">WBS 코드</th>
						<th>WBS 내역</th>
						<th>계약번호</th>
						<th>품목</th>
						<th>계약일</th>
						<th>구매처</th>
						<th>구매처 명</th>
						<th>계정과목</th>
						<th>계정과목 명</th>
						<th>자재코드</th>
						<th>내역</th>
						<th>수량</th>
						<th>단위</th>
						<th>단가</th>
						<th>통화</th>
						<th>계약금액</th>
						<th>계약금액(원화)</th>
						<th>구매그룹</th>
						<th>구매그룹 내역</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${fn:length(listwbs) > 0}">
					<c:forEach var="list" items="${listwbs}" varStatus="i">
						<tr>
							<td>${list.PSPNR}</td>
							<td>${list.POST1}</td>
							<td>${list.PS_PSP_PNR}</td>
							<td>${list.POST2}</td>
							<td style="text-align:center;">${list.EBELN}</td>
							<td style="text-align:center;">${list.EBELP}</td>
							<td style="text-align:center;">${list.BEDAT}</td>
							<td style="text-align:center;">${list.LIFNR}</td>
							<td>${list.NAME1}</td>
							<td style="text-align:center;">${list.SAKTO}</td>
							<td>${list.TXT50}</td>
							<td style="text-align:center;">${list.MATNR}</td>
							<td>${list.TXZ01}</td>
							<td style="text-align:right;">${list.KTMNG}</td>
							<td style="text-align:center;">${list.MEINS}</td>
							<td style="text-align:right;"><fmt:formatNumber value="${list.NETPR}" pattern="#,###" /></td>
							<td style="text-align:center;">${list.WAERS}</td>
							<td style="text-align:right;"><fmt:formatNumber value="${list.BRTWR}" pattern="#,###" /></td>
							<td style="text-align:right;"><fmt:formatNumber value="${list.BRTWR_KRW}" pattern="#,###" /></td>
							<td style="text-align:center;">${list.EKGRP}</td>
							<td style="text-align:center;">${list.EKNAM}</td>
							<c:set var="sum_BRTWR" value="${sum_BRTWR + list.BRTWR}"/>
							<c:set var="sum_BRTWR_KRW" value="${sum_BRTWR_KRW + list.BRTWR_KRW}"/>
						</tr>
						<c:set var="nextwbs" value="${listwbs[i.index+1].PS_PSP_PNR}"/>
						<c:if test="${list.PS_PSP_PNR ne nextwbs}">
							<tr>
								<td colspan="17" style="text-align:center;">소 계</td>
								<td style="text-align:right;"><fmt:formatNumber value="${sum_BRTWR}" pattern="#,###" /></td>
								<td style="text-align:right;"><fmt:formatNumber value="${sum_BRTWR_KRW}" pattern="#,###" /></td>
								<td colspan="2"></td>
								<c:set var="sum_BRTWR" value="0"/>
								<c:set var="sum_BRTWR_KRW" value="0"/>
							</tr>
						</c:if>
					</c:forEach>
				</c:if>
				<c:if test="${fn:length(listwbs) == 0}">
					<tr><td align="center" colspan="21">조회된 내역이 없습니다</td></tr>
				</c:if>
				</tbody>
			</table>
		</c:when>
		
		<c:when test="${req_data.GUBUN2 eq '2'}">
			<h3>
				<c:if test="${req_data.GUBUN eq '1'}">투자내역 조회</c:if>
				<c:if test="${req_data.GUBUN eq '8'}">집행금액 조회</c:if>
			</h3>
			<table border="1">
				<c:set var="sum_WRBTR" value="0"/>
				<c:set var="sum_DMBTR" value="0"/>
				<caption style="padding-top:0px;"></caption>
				<thead>
					<tr>
						<th style="width:70px;">투자코드</th>
						<th style="width:150px;">투자내역</th>
						<th style="width:130px;">WBS 코드</th>
						<th>WBS 내역</th>
						<th>전표유형</th>
						<th>전표유형 명</th>
						<th>회계 전표번호</th>
						<th>개별항목</th>
						<th>적요</th>
						<th>전기일</th>
						<th>구매처</th>
						<th>구매처 명</th>
						<th>계정과목</th>
						<th>계정과목 명</th>
						<th>자재코드</th>
						<th>수량</th>
						<th>단위</th>
						<th>금액(전표 통화)</th>
						<th>통화키</th>
						<th>금액(현지 통화)</th>
						<th>반제일</th>
						<th>반제전표번호</th>
						<th>반제전표유형</th>
						<th>반제전표유형 내역</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${fn:length(listwbs) > 0}">
					<c:forEach var="list" items="${listwbs}" varStatus="i">
						<tr>
							<td>${list.PSPNR}</td>
							<td>${list.POST1}</td>
							<td>${list.PROJK}</td>
							<td>${list.POST2}</td>
							<td style="text-align: center;">${list.BLART}</td>
							<td style="text-align: center;">${list.LTEXT}</td>
							<td style="text-align: center;">${list.BELNR}</td>
							<td style="text-align: center;">${list.BUZEI}</td>
							<td>${list.SGTXT}</td>
							<td style="text-align: center;">${list.BUDAT}</td>
							<td style="text-align: center;">${list.LIFNR}</td>
							<td>${list.NAME1}</td>
							<td style="text-align: center;">${list.HKONT}</td>
							<td>${list.ZGLTXT}</td>
							<td style="text-align: center;">${list.MATNR}</td>
							<td style="text-align: right;">${list.MENGE}</td>
							<td style="text-align: center;">${list.MEINS}</td>
							<td style="text-align: right;"><fmt:formatNumber value="${list.WRBTR}" pattern="#,###" /></td>
							<td style="text-align: center;">${list.WAERS}</td>
							<td style="text-align: right;"><fmt:formatNumber value="${list.DMBTR}" pattern="#,###" /></td>
							<td style="text-align: center;">${list.AUGDT}</td>
							<td style="text-align: center;">${list.AUGBL}</td>
							<td style="text-align: center;">${list.BLART2}</td>
							<td style="text-align: center;">${list.LTEXT2}</td>
							<c:set var="sum_WRBTR" value="${sum_WRBTR + list.WRBTR}" />
							<c:set var="sum_DMBTR" value="${sum_DMBTR + list.DMBTR}" />
						</tr>
						<c:set var="nextwbs" value="${listwbs[i.index+1].PROJK}"/>
						<c:if test="${list.PROJK ne nextwbs}">
							<tr>
								<td colspan="17" style="text-align:center;">소 계</td>
								<td style="text-align:right;"><fmt:formatNumber value="${sum_WRBTR}" pattern="#,###" /></td>
								<td></td>
								<td style="text-align:right;"><fmt:formatNumber value="${sum_DMBTR}" pattern="#,###" /></td>
								<td colspan="4"></td>
								<c:set var="sum_WRBTR" value="0"/>
								<c:set var="sum_DMBTR" value="0"/>
							</tr>
						</c:if>
					</c:forEach>
				</c:if>
				<c:if test="${fn:length(listwbs) == 0}">
					<tr><td align="center" colspan="23">조회된 내역이 없습니다</td></tr>
				</c:if>
				</tbody>
			</table>
		</c:when>
		
		<c:otherwise>
			<h3>지급내역 조회</h3>
			<table border="1">
				<c:set var="sum_WRBTR" value="0"/>
				<c:set var="sum_DMBTR" value="0"/>
				<caption style="padding-top:0px;"></caption>
				<thead>
					<tr>
						<th style="width:70px;">투자코드</th>
						<th style="width:150px;">투자내역</th>
						<th style="width:130px;">WBS 코드</th>
						<th>WBS 내역</th>
						<th>전표유형</th>
						<th>전표유형 명</th>
						<th>회계 전표번호</th>
						<th>개별항목</th>
						<th>적요</th>
						<th>전기일</th>
						<th>구매처</th>
						<th>구매처 명</th>
						<th>계정과목</th>
						<th>계정과목 명</th>
						<th>자재코드</th>
						<th>수량</th>
						<th>단위</th>
						<th>금액(전표 통화)</th>
						<th>통화키</th>
						<th>금액(현지 통화)</th>
						<th>반제일</th>
						<th>반제전표번호</th>
						<th>반제전표유형</th>
						<th>반제전표유형 내역</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${fn:length(listwbs) > 0}">
					<c:forEach var="list" items="${listwbs}" varStatus="i">
						<tr>
							<td>${list.PSPNR}</td>
							<td>${list.POST1}</td>
							<td>${list.PROJK}</td>
							<td>${list.POST2}</td>
							<td style="text-align:center;">${list.BLART}</td>
							<td style="text-align:center;">${list.LTEXT}</td>
							<td style="text-align:center;">${list.BELNR}</td>
							<td style="text-align:center;">${list.BUZEI}</td>
							<td>${list.SGTXT}</td>
							<td style="text-align:center;">${list.BUDAT}</td>
							<td style="text-align:center;">${list.LIFNR}</td>
							<td>${list.NAME1}</td>
							<td style="text-align:center;">${list.HKONT}</td>
							<td>${list.ZGLTXT}</td>
							<td style="text-align:center;">${list.MATNR}</td>
							<td style="text-align:right;">${list.MENGE}</td>
							<td style="text-align:center;">${list.MEINS}</td>
							<td style="text-align:right;"><fmt:formatNumber value="${list.WRBTR}" pattern="#,###" /></td>
							<td style="text-align:center;">${list.WAERS}</td>
							<td style="text-align:right;"><fmt:formatNumber value="${list.DMBTR}" pattern="#,###" /></td>
							<td style="text-align:center;">${list.AUGDT}</td>
							<td style="text-align:center;">${list.AUGBL}</td>
							<td style="text-align:center;">${list.BLART2}</td>
							<td style="text-align:center;">${list.LTEXT2}</td>
							<c:set var="sum_WRBTR" value="${sum_WRBTR + list.WRBTR}"/>
							<c:set var="sum_DMBTR" value="${sum_DMBTR + list.DMBTR}"/>
						</tr>
						<c:set var="nextwbs" value="${listwbs[i.index+1].PROJK}"/>
						<c:if test="${list.PROJK ne nextwbs}">
							<tr>
								<td colspan="17" style="text-align:center;">소 계</td>
								<td style="text-align:right;"><fmt:formatNumber value="${sum_WRBTR}" pattern="#,###" /></td>
								<td></td>
								<td style="text-align:right;"><fmt:formatNumber value="${sum_DMBTR}" pattern="#,###" /></td>
								<td colspan="4"></td>
								<c:set var="sum_WRBTR" value="0"/>
								<c:set var="sum_DMBTR" value="0"/>
							</tr>
						</c:if>
					</c:forEach>
				</c:if>
				<c:if test="${fn:length(listwbs) == 0}">
					<tr><td align="center" colspan="23">조회된 내역이 없습니다</td></tr>
				</c:if>
				</tbody>
			</table>
		
		</c:otherwise>
		
	</c:choose>

</body>
</html>