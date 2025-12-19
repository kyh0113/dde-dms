<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
if (request.getProtocol().equals("HTTP/1.1")) {
	response.setHeader("Cache-Control", "no-cache");
}

Date today = new Date();
SimpleDateFormat date = new SimpleDateFormat("yyyy");
int to_yyyy = Integer.parseInt(date.format(today));
// JSTL에서 사용할 수 있도록 세팅
request.setAttribute("to_yyyy", to_yyyy);

Calendar cal = Calendar.getInstance();
cal.set(Calendar.YEAR, 2010);
int from_yyyy = Integer.parseInt(date.format(cal.getTime()));
//JSTL에서 사용할 수 있도록 세팅
request.setAttribute("from_yyyy", from_yyyy);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>도급비집계 상세조회</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="http://malsup.github.com/jquery.form.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
</head>
<body style="margin:10px;">
<div id="popup">
	<div class="pop_header">도급비집계 상세조회</div>
	<div class="pop_content">
		<form id="frm" name="frm" method="post" accept-charset="UTF-8">
			<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
			<section>
				<div class="tbl_box">
					<table cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="5%" />
							<col width="25%" />
							<col width="5%" />
							<col width="25%" />
							<col width="5%" />
							<col width="25%" />
						</colgroup>
						<tr>
							<th>거래처</th>
							<td>
								<input type="text" name="vendor_name" value="${VENDOR_NAME}" disabled/>
							</td>
							<th></th>
							<td></td>
							<th></th>
							<td></td>
						</tr>
					</table>
				</div>
			</section>
			<section>
			<div class="lst">
				<table cellspacing="0" cellpadding="0">
					<caption style="padding-top:0px;"></caption>
					<thead>
						<tr>
							<th style="width:10%;">부서명</th>
					        <th style="width:20%;">계약명</th>
					        <th>계약기준월도급비</th>
					        <th>도급비(실적)</th>
					        <th>차액</th>
					        <th>전월도급비</th>
					        <th>증감</th>
					        <th>물량</th>
					        <th>전월물량</th>
					        <th>물량증감</th>
					        <th>전자결재</th>
						</tr>
					</thead>
					<tbody>
					<c:if test="${fn:length(detail_list) > 0}">
						<c:set var="sum_A" value="0"/>
						<c:set var="sum_B" value="0"/>
						<c:set var="sum_C" value="0"/>
						<c:set var="sum_D" value="0"/>
						<c:set var="sum_E" value="0"/>
						<c:set var="sum_F" value="0"/>
						<c:set var="sum_G" value="0"/>
						<c:set var="sum_H" value="0"/>
						<c:forEach var="data" items="${detail_list}" varStatus="i">
							<tr>
								<td style="text-align:center;">${data.DEPT_NAME}</td>
								<td style="text-align:center;">${data.CONTRACT_NAME}</td>
								<td style="text-align:right;">
									<fmt:formatNumber value="${data.ADJUST_SUBCONTRACTING_COST}" pattern="#,###" />
									<c:set var="sum_D" value="${sum_D + data.ADJUST_SUBCONTRACTING_COST}"/>
								</td>
								<td style="text-align:right;">
									<fmt:formatNumber value="${data.SUB_TOTAL}" pattern="#,###" />
									<c:set var="sum_A" value="${sum_A + data.SUB_TOTAL}"/>
								</td>
								<td style="text-align:right;">
									<fmt:formatNumber value="${data.DIFF}" pattern="#,###" />
									<c:set var="sum_E" value="${sum_E + data.DIFF}"/>
								</td>
								<td style="text-align:right;">
									<fmt:formatNumber value="${data.P_TOTAL}" pattern="#,###" />
									<c:set var="sum_B" value="${sum_B + data.P_TOTAL}"/>
								</td>
								<td style="text-align:right;">
									<fmt:formatNumber value="${data.VARIATION}" pattern="#,###" />
									<c:set var="sum_C" value="${sum_C + data.VARIATION}"/>
								</td>
								<td style="text-align:right;">
									<fmt:formatNumber value="${data.QUANTITY}" pattern="#,###" />
									<c:set var="sum_F" value="${sum_F + data.QUANTITY}"/>
								</td>
								<td style="text-align:right;">
									<fmt:formatNumber value="${data.P_QUANTITY}" pattern="#,###" />
									<c:set var="sum_G" value="${sum_G + data.P_QUANTITY}"/>
								</td>
								<td style="text-align:right;">
									<fmt:formatNumber value="${data.QUANTITY_VARIATION}" pattern="#,###" />
									<c:set var="sum_H" value="${sum_H + data.QUANTITY_VARIATION}"/>
								</td>
								<td style="text-align:center;">${data.STATUS_TXT}</td>
							</tr>
						</c:forEach>
							<tr class="tbl_box">
								<td>합 계<td>
								<td style="text-align:right;"><fmt:formatNumber value="${sum_D}" pattern="#,###" /></td>
								<td style="text-align:right;"><fmt:formatNumber value="${sum_A}" pattern="#,###" /></td>
								<td style="text-align:right;"><fmt:formatNumber value="${sum_E}" pattern="#,###" /></td>
								<td style="text-align:right;"><fmt:formatNumber value="${sum_B}" pattern="#,###" /></td>
								<td style="text-align:right;"><fmt:formatNumber value="${sum_C}" pattern="#,###" /></td>
								<td style="text-align:right;"><fmt:formatNumber value="${sum_F}" pattern="#,###" /></td>
								<td style="text-align:right;"><fmt:formatNumber value="${sum_G}" pattern="#,###" /></td>
								<td style="text-align:right;"><fmt:formatNumber value="${sum_H}" pattern="#,###" /></td>
								<td></td>
							</tr>
					</c:if>
					<c:if test="${fn:length(detail_list) == 0}">
						<tr>
							<td align="center" colspan="11">조회된 내역이 없습니다</td>
						</tr>
					</c:if>
					</tbody>
				</table>
			</div>
			</section>
		</form>
		<div class="btn_wrap">
			<button class="btn" onclick="self.close();">닫기</button>
		</div>
	</div>
</div>
	<script>
		var enable_calc = false; // 계산 여부 - true: 가능, false: 불가
		var enable_save = false; // 저장 가능 여부 - true: 가능, false: 불가
		$(document).ready(function() {
			
			
		});
		
		/*콤마 추가*/
		function addComma(num) {
			var rnum = "0";
			if(num !== null){
				rnum = num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			}
			return rnum;
		}

		/*콤마 제거*/
		function unComma(num) {
			return num.replace(/[^0-9.]/gi, '');
		}
		
		function fnValidation(){
			var check = true;
			$(".validation").each(function(i, d){
				// 빈 값은 0으로 설정
				if($(d).val().trim() === ""){
					$(d).val(0);
				}
				if($(d).is(".not-null") && $(d).val() === "0"){
					console.log($(d));
					swalWarningCB("인원값을 확인해주세요.", function(){
						$(d).focus();
					});
					check = false;
					return false;
				}
				if(isNaN(Number(unComma($(d).val())))){
					swalWarningCB("항목값을 확인해주세요.", function(){
						$(d).focus();
					});
					check = false;
					return false;
				}
			});
// 			console.log("결과", check);
			return check;
		}
	</script>
</body>