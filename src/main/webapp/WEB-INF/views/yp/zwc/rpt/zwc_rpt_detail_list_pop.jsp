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

%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>계약별 도급비 산출근거</title>
<style type="text/css">
.table td, .table th {
	padding: 0.4rem !important;
}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="http://malsup.github.com/jquery.form.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
</head>
<body style="margin:10px;">
	<h2>
		계약별 도급비 산출근거
		<!-- 공통 - 네비게이션 시작 -->
		<ul class="loc">
			<li>
				<img src="/resources/yp/images/ic_loc_home.png">
			</li>
			<c:if test="${menu.breadcrumb[0].top_menu_id ne null}">
				<li>${menu.breadcrumb[0].top_menu_name}</li>
				<c:if test="${menu.breadcrumb[0].top_menu_id ne menu.breadcrumb[0].up_menu_id}">
					<c:if test="${menu.breadcrumb[0].up_menu_id ne null}">
						<li>${menu.breadcrumb[0].up_menu_name}</li>
					</c:if>
				</c:if>
			</c:if>
			<c:if test="${menu.breadcrumb[0].menu_id ne null}">
				<li>${menu.breadcrumb[0].menu_name}</li>
			</c:if>
		</ul>
		<!-- 공통 - 네비게이션 종료 -->
	</h2>
	<!-- 	<div class="stitle">기본정보</div> -->
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
					<th>연도</th>
					<td>
						<input type="text" value="${BASE_YYYY}" disabled />
					</td>
					<th>거래처</th>
					<td>
						<input type="text"  value="${VENDOR_NAME}" disabled />
					</td>
					<th>계약명</th>
					<td>
						<input type="text"  value="${CONTRACT_NAME}" disabled />
					</td>
				</tr>
			</table>
		</div>
	</section>
	<section class="section">
		<form id="frm" name="frm" method="post">
			<!-- 20191023_khj for csrf -->
			<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="BASE_YYYY" />
			<input type="hidden" name="VENDOR_CODE" />
			<div class="tbl_box">
				<table border="1"  class="popup_table table">
					<colgroup>
						<col width="15%"/>
						<col width="25%"/>
						<col />
						<col width="25%" />
						<col />
					</colgroup>
					<tr class="tb-head" >
						<td style="color:white">구분</td>
						<td style="color:white">단가</td>
						<td style="color:white">인원</td>
						<td style="color:white">금액</td>
						<td style="color:white">비고</td>
				    </tr>
				    <c:set var ="total_sum" value="0"/>
					<c:forEach var="data" items="${pop_reason_list}">
						<tr>
							<td class="center vertical-center">${data.GUBUN_NAME}</td>
							<td class="right vertical-center"><fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${data.UNIT_PRICE}" /></td>
							<td class="center vertical-center">${data.MAN_QTY}</td>
							<td class="right vertical-center">
								<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${data.AMOUNT}" />
								<c:set var="total_sum" value="${total_sum + data.AMOUNT}"/>
							</td>
							<td>${data.NOTE}</td>
						</tr>
					</c:forEach>
					<!-- 데이터가 존재할 경우, 합계row 추가 -->
					<c:if test="${fn:length(pop_reason_list) > 0}">
						<tr class="sum_total">
							<td class="center vertical-center">합계</td>
							<td></td>
							<td></td>
							<td class="right vertical-center"><fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${total_sum}" /></td>
							<td></td>
						</tr>
					</c:if>
				</table>
			</div>
		</form>
	</section>
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