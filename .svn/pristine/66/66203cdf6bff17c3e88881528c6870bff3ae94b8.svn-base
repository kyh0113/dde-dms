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
SimpleDateFormat date_y = new SimpleDateFormat("yyyy");
SimpleDateFormat date_m = new SimpleDateFormat("MM");
SimpleDateFormat date_d = new SimpleDateFormat("dd");
String yyyy = date_y.format(today);
String mm = date_m.format(today);
String dd = date_d.format(today);
// JSTL에서 사용할 수 있도록 세팅
request.setAttribute("yyyy", yyyy);
request.setAttribute("mm", mm);
request.setAttribute("dd", dd);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>소급비청구서</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="/resources/yp/wp/printThis.js"></script>
<!-- <link rel="stylesheet" href="/resources/yp/css/style.css"> -->
<style type="text/css">
@page a4sheet { size: 21.0cm 29.7cm } 
.a4 { page: a4sheet; page-break-after: always } 
div, td {font-size:10px "Malgun Gothic", candara, dotum; color:#000000;}
table {
border-collapse: collapse;
border-spacing: 0;
}
.datatable {width:100%;font-size:10px;}
.datatable th {text-align: center; padding:6px 10px 5px; color:#000000; border-top:1px solid #000000; border-bottom:1px solid #000000; border-left:1px solid #000000; border-right:1px solid #000000; background:#F9F9F9;}
.datatable td {text-align: center; padding:6px 10px 5px; border-top:1px solid #000000; border-bottom:1px solid #000000; border-left:1px solid #000000; border-right:1px solid #000000; height: 50px;}
</style>
</head>
<body style="margin:10px;">
<div id="popup">
	<div class="pop_content">
		<form id="frm" name="frm" method="post" accept-charset="UTF-8">
			<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
			<section>
			<div style="margin-bottom: 15px;">
				<input type="button" value="인쇄" onclick="javascript:fnPrint();"/>
				<a href="http://ypgw.ypzinc.co.kr/ekp/view/board/article/brdAtclViewPopup?atclId=BA26792524877628076874&access="><span>*인쇄초기설정 방법 보기</span></a>
			</div>
			<div id="print_area" class="a4">
				<table class="datatable" style="border-top:0px;"><!-- 제목 테이블 -->
					<caption style="padding-top:0px;"></caption>
					<thead>
						<tr>
							<td colspan="13" style="border:0px;height:50px;">
								<strong style="font-size: 28px; text-decoration: underline;">소 급 비 청 구 서</strong><br>
								<span style="font-size: 9pt;">${BASE_YYYY}</span>
							</td>
						</tr>
						<tr>
							<td colspan="13" style="border:0px;height:50px;"></td>
						</tr>
						<tr>
							<th>작업코드</th>
							<th>작업명</th>
							<th>단위</th>
							<th>작업량</th>
							<th>단가</th>
							<th>보상</th>
							<th>추가</th>
							<th>패널티</th>
							<th>휴일근무</th>
							<th>토요근무</th>
							<th>연장근무</th>
							<th>야간근무</th>
							<th>금액</th>
							<th>기지급액</th>
							<th>소급액</th>
						</tr>
					</thead>
					<tbody>
					<c:if test="${fn:length(list) > 0}">
						<c:set var="sum_A" value="0"/>
						<c:set var="sum_B" value="0"/>
						<c:set var="sum_C" value="0"/>
						<c:forEach var="data" items="${list}" varStatus="i">
							<tr style="height: 25px;">
								<td style="text-align:center;">${data.CONTRACT_CODE}</td><!-- 작업코드 -->
								<td style="text-align:left;">${data.CONTRACT_NAME}</td><!-- 작업명 -->
								<td style="text-align:center;">${data.UNIT_NAME}</td><!-- 단위 -->
								<td style="text-align:right;">${data.QUANTITY}</td><!-- 작업량 -->
								<td style="text-align:right;">
									<fmt:formatNumber value="${data.UNIT_PRICE}" pattern="#,###" />
								</td><!-- 단가 -->
								<td style="text-align:right;">
									<fmt:formatNumber value="${data.REWARD_AMOUNT}" pattern="#,###" />
								</td><!-- 보상 -->
								<td style="text-align:right;">
									<fmt:formatNumber value="${data.ADDITIONAL_AMOUNT}" pattern="#,###" />
								</td><!-- 추가 -->
								<td style="text-align:right;">
									<fmt:formatNumber value="${data.PENALTY_AMOUNT}" pattern="#,###" />
								</td><!-- 패널티 -->
								<td style="text-align:right;">
									<fmt:formatNumber value="${data.HOLIDAY_AMOUNT}" pattern="#,###" />
								</td><!-- 휴일근무 -->
								<td style="text-align:right;">
									<fmt:formatNumber value="${data.SATURDAY_AMOUNT}" pattern="#,###" />
								</td><!-- 토요근무 -->
								<td style="text-align:right;">
									<fmt:formatNumber value="${data.EXTENSION_AMOUNT}" pattern="#,###" />
								</td><!-- 연장근무 -->
								<td style="text-align:right;">
									<fmt:formatNumber value="${data.NIGHT_AMOUNT}" pattern="#,###" />
								</td><!-- 야간근무 -->
								<td style="text-align:right;">
									<fmt:formatNumber value="${data.PAY_AMOUNT}" pattern="#,###" />
									<c:set var="sum_A" value="${sum_A + data.PAY_AMOUNT}"/>
								</td><!-- 금액 -->
								<td style="text-align:right;">
									<fmt:formatNumber value="${data.PRE_PAY_AMOUNT}" pattern="#,###" />
									<c:set var="sum_B" value="${sum_B + data.PRE_PAY_AMOUNT}"/>
								</td><!-- 기지급액 -->
								<td style="text-align:right;">
									<fmt:formatNumber value="${data.RETROACTIVE_AMOUNT}" pattern="#,###" />
									<c:set var="sum_C" value="${sum_C + data.RETROACTIVE_AMOUNT}"/>
								</td><!-- 소급액 -->
							</tr>
						</c:forEach>
						<tr style="height: 25px;">
							<td>합 계</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td style="text-align:right;">
								<fmt:formatNumber value="${sum_A}" pattern="#,###" /></td>
							</td>
							<td style="text-align:right;">
								<fmt:formatNumber value="${sum_B}" pattern="#,###" /></td>
							</td>
							<td style="text-align:right;">
								<fmt:formatNumber value="${sum_C}" pattern="#,###" /></td>
							</td>
						</tr>
					</c:if>
					<c:if test="${fn:length(list) == 0}">
						<tr style="height: 25px;">
							<td align="center" colspan="15">조회된 내역이 없습니다</td>
						</tr>
					</c:if>
						<tr style="height: 25px;">
							<td style="text-align: right; border: 0px;" colspan="15">&nbsp;</td>
						<tr style="height: 25px;">
							<td style="text-align: center; border: 0px; font-size: 20px;" colspan="13">위와 같이 청구합니다.</td>
						</tr>
						<tr style="height: 25px;">
							<td style="text-align: right; border: 0px; font-size: 20px;" colspan="13">${yyyy} 년 ${mm} 월 ${dd} 일</td>
						</tr>
						<tr style="height: 25px;">
							<td style="text-align: right; border: 0px; font-size: 20px;" colspan="13">${VENDOR_NAME} 대표 ${REPRESENTATIVE} (인)</td>
						</tr>
					</tbody>
				</table>
			</div>
			</section>
		</form>
	</div>
</div>
	<script>
		var enable_calc = false; // 계산 여부 - true: 가능, false: 불가
		var enable_save = false; // 저장 가능 여부 - true: 가능, false: 불가
		$(document).ready(function() {
			
		});
		
		function fnPrint(){
			$("#print_area").printThis();
		}
		
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