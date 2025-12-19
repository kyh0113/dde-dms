<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<style type="text/css">
.BASE_PAY_HOUR:not([readonly]) { background-color: #ffcc66; }
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>근무형태 등록</title>
</head>
<body>
	<h2>
		근무형태 등록
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
<!-- 						<select id="BASE_YYYY" onchange="javascript: $('#search_btn').trigger('click');"> -->
<%-- 							<c:forEach var="i" begin="0" end="${to_yyyy - from_yyyy}"> --%>
<%-- 								JSTL 역순 출력 - 연도 --%>
<%-- 								<c:set var="yearOption" value="${to_yyyy - i}" /> --%>
<%-- 								<option value="${yearOption}" <c:if test="${yearOption eq BASE_YYYY}">selected="selected"</c:if>>${yearOption}</option> --%>
<%-- 							</c:forEach> --%>
<!-- 						</select> -->
						<input type="text" id="BASE_YYYY" class="calendar search_dtp_y" value="${to_yyyy}" readonly="readonly"/>
					</td>
					<th>근무형태</th>
					<td>
						<select id="WORKTYPE_CODE" onchange="javascript: $('#search_btn').trigger('click');">
							<c:forEach items="${cb_working_master_w}" var="data">
								<option value="${data.CODE}" <c:if test="${data.CODE eq WORKTYPE_CODE}">selected="selected"</c:if>>${data.CODE_NAME}</option>
							</c:forEach>
						</select>
					</td>
					<th>&nbsp;</th>
					<td>&nbsp;</td>
				</tr>
			</table>
			<div class="btn_wrap">
				<input type="button" class="btn btn_search" id="search_btn" value="조회">
<!-- 				<button class="btn btn_search" id="search_btn2" type="">수정테스트</button> -->
			</div>
		</div>
	</section>
	<div class="float_wrap" style="margin-bottom: -25px;">
		<div class="fl" style="margin-left: 150px;">
			※자동 계산은 값이 변경되거나 <span style="background-color: #ffcc66;">　　　</span> 색상의 영역(시급)에서 엔터키를 누르세요.&nbsp;<span style="font-style: italic;">※수정 상태에서만 작동합니다.</span>
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type=button class="btn_g" id="fnModify" value="수정">
				<input type=button class="btn_g" id="fnSave" value="저장">
			</div>
		</div>
	</div>
	<section class="section">
		<form id="frm" name="frm" method="post">
			<!-- 20191023_khj for csrf -->
			<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
			<ul class="nav nav-tabs" style="display: flex !important;">
				<li class="nav-item">
					<a class="nav-link pay active" data-toggle="tab" href="#pay">임금</a>
				</li>
				<li class="nav-item">
					<a class="nav-link price" data-toggle="tab" href="#price">단가</a>
				</li>
			</ul>
			<div class="tab-content">
				<div class="tbl_box tab-pane show active" id="pay">
					<input type="hidden" name="BASE_YYYY" />
					<input type="hidden" name="WORKTYPE_CODE" />
					<table border="1">
						<colgroup>
							<col width="3%" />
							<col width="7%" />
							<col />
							<col width="8%" />
							<col width="15%" />
						</colgroup>
						<tr>
							<th colspan="2" style="text-align: center; vertical-align: middle; height: 31px;">항목</th>
							<th style="text-align: center; vertical-align: middle;">계산식</th>
							<th style="text-align: center; vertical-align: middle;">금액</th>
							<th style="text-align: center; vertical-align: middle;">비고</th>
						</tr>
						<tr>
							<th colspan="2" style="text-align: center; vertical-align: middle;">기본급</th>
							<td>
								<input type="text" size="10" class="readonly-at-search validation BASE_PAY_HOUR" name="BASE_PAY_HOUR" value="0" readonly="readonly"/>
								＊
								<input type="text" size="2" class="readonly-at-search validation" name="BASE_PAY_WORKING_HOUR" value="0" readonly="readonly" />
							</td>
							<td>
								<input type="text" class="readonly validation" name="BASE_PAY_AMOUNT" value="0" readonly="readonly" />
							</td>
							<td>시급 ＊ 근로시간</td>
						</tr>
						<tr>
							<th rowspan="7" style="text-align: center; vertical-align: middle;">수당</th>
							<th style="text-align: center; vertical-align: middle;">토요
							</td>
							<td>
								<input type="text" size="10" class="cp_base_pay_hour readonly-at-search calc-saturday" value="0" disabled="disabled" />
								＊
								<input type="text" size="2" class="readonly-at-search calc-saturday validation" name="SATURDAY_HOUR" value="0" readonly="readonly" />
								＊
								<input type="text" size="2" class="readonly-at-search calc-saturday validation" name="SATURDAY_WEEK" value="0" readonly="readonly" />
								＊
								<input type="text" size="4" class="readonly-at-search calc-saturday validation" name="SATURDAY_DOUBLE" value="0" readonly="readonly" />
							</td>
							<td>
								<input type="text" class="readonly validation" name="SATURDAY_AMOUNT" value="0" readonly="readonly" />
							</td>
							<td>시급 ＊ 시간 ＊ 주 ＊ 배수</td>
						</tr>
						<tr>
							<th style="text-align: center; vertical-align: middle;">휴일
							</td>
							<td>
								<input type="text" size="10" class="cp_base_pay_hour readonly-at-search calc-holiday" value="0" disabled="disabled" />
								＊
								<input type="text" size="2" class="readonly-at-search calc-holiday validation" name="HOLIDAY_HOUR" value="0" readonly="readonly" />
								＊
								<input type="text" size="2" class="readonly-at-search calc-holiday validation" name="HOLIDAY_WEEK" value="0" readonly="readonly" />
								＊
								<input type="text" size="4" class="readonly-at-search calc-holiday validation" name="HOLIDAY_DOUBLE" value="0" readonly="readonly" />
							</td>
							<td>
								<input type="text" class="readonly validation" name="HOLIDAY_AMOUNT" value="0" readonly="readonly" />
							</td>
							<td>시급 ＊ 시간 ＊ 주 ＊ 배수</td>
						</tr>
						<tr>
							<th style="text-align: center; vertical-align: middle;">야간
							</td>
							<td>
								<input type="text" size="10" class="cp_base_pay_hour readonly-at-search calc-night" value="0" disabled="disabled" />
								＊
								<input type="text" size="2" class="readonly-at-search calc-night validation" name="NIGHT_HOUR" value="0" readonly="readonly" />
								＊
								<input type="text" size="2" class="readonly-at-search calc-night validation" name="NIGHT_WEEK" value="0" readonly="readonly" />
								＊
								<input type="text" size="4" class="readonly-at-search calc-night validation" name="NIGHT_DOUBLE" value="0" readonly="readonly" />
							</td>
							<td>
								<input type="text" class="readonly validation" name="NIGHT_AMOUNT" value="0" readonly="readonly" />
							</td>
							<td>시급 ＊ 시간 ＊ 주 ＊ 배수</td>
						</tr>
						<tr>
							<th style="text-align: center; vertical-align: middle;">정휴일
							</td>
							<td>
								<input type="text" size="10" class="cp_base_pay_hour readonly-at-search calc-regular-holiday" value="0" disabled="disabled" />
								＊
								<input type="text" size="2" class="readonly-at-search calc-regular-holiday validation" name="REGULAR_HOLIDAY_HOUR" value="0" readonly="readonly" />
								＊
								<input type="text" size="2" class="readonly-at-search calc-regular-holiday validation" name="REGULAR_HOLIDAY_DAY" value="0" readonly="readonly" />
								＊
								<input type="text" size="4" class="readonly-at-search calc-regular-holiday validation" name="REGULAR_HOLIDAY_DOUBLE" value="0" readonly="readonly" />
								／ 12
							</td>
							<td>
								<input type="text" class="readonly validation" name="REGULAR_HOLIDAY_AMOUNT" value="0" readonly="readonly" />
							</td>
							<td>시급 ＊ 시간 ＊ 일 ＊ 배수 ／ 12</td>
						</tr>
						<tr>
							<th style="text-align: center; vertical-align: middle;">연차사용
							</td>
							<td>
								<input type="text" size="10" class="cp_base_pay_hour readonly-at-search calc-annual-leave-use" value="0" disabled="disabled" />
								＊
								<input type="text" size="2" class="readonly-at-search calc-annual-leave-use validation validation" name="ANNUAL_LEAVE_USE_HOUR" value="0" readonly="readonly" />
								＊
								<input type="text" size="2" class="readonly-at-search calc-annual-leave-use validation validation" name="ANNUAL_LEAVE_USE_DAY" value="0" readonly="readonly" />
								＊
								<input type="text" size="4" class="readonly-at-search calc-annual-leave-use validation validation" name="ANNUAL_LEAVE_USE_DOUBLE" value="0" readonly="readonly" />
								／ 12
							</td>
							<td>
								<input type="text" class="readonly validation" name="ANNUAL_LEAVE_USE_AMOUNT" value="0" readonly="readonly" />
							</td>
							<td>시급 ＊ 시간 ＊ 일 ＊ 배수 ／ 12</td>
						</tr>
						<tr>
							<th style="text-align: center; vertical-align: middle;">연차미사용
							</td>
							<td>
								<input type="text" size="10" class="cp_base_pay_hour readonly-at-search calc-annual-leave-unuse" value="0" disabled="disabled" />
								＊
								<input type="text" size="2" class="readonly-at-search calc-annual-leave-unuse validation" name="ANNUAL_LEAVE_UNUSE_HOUR" value="0" readonly="readonly" />
								＊
								<input type="text" size="2" class="readonly-at-search calc-annual-leave-unuse validation" name="ANNUAL_LEAVE_UNUSE_DAY" value="0" readonly="readonly" />
								＊
								<input type="text" size="4" class="readonly-at-search calc-annual-leave-unuse validation" name="ANNUAL_LEAVE_UNUSE_DOUBLE" value="0" readonly="readonly" />
								／ 12
							</td>
							<td>
								<input type="text" class="readonly validation" name="ANNUAL_LEAVE_UNUSE_AMOUNT" value="0" readonly="readonly" />
							</td>
							<td>시급 ＊ 시간 ＊ 일 ＊ 배수 ／ 12</td>
						</tr>
						<tr>
							<th style="text-align: center; vertical-align: middle;">소계
							</td>
							<td>&nbsp;</td>
							<td>
								<input type="text" class="readonly validation" name="EXTRA_PAY_AMOUNT" value="0" readonly="readonly" />
							</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<th colspan="2" style="text-align: center; vertical-align: middle;">임금(소계)
							</td>
							<td>&nbsp;</td>
							<td>
								<input type="text" class="readonly validation" name="PAY_AMOUNT" value="0" readonly="readonly" />
							</td>
							<td>기본급 + 수당(소계)</td>
						</tr>
					</table>
				</div>
				<div class="tbl_box tab-pane" id="price">
					<table border="1">
						<colgroup>
							<col width="3%" />
							<col width="7%" />
							<col />
							<col width="8%" />
							<col width="15%" />
						</colgroup>
						<tr>
							<th colspan="2" style="text-align: center; vertical-align: middle; height: 31px;">항목</th>
							<th style="text-align: center; vertical-align: middle;">계산식</th>
							<th style="text-align: center; vertical-align: middle;">금액</th>
							<th style="text-align: center; vertical-align: middle;">비고</th>
						</tr>
						<tr>
							<th rowspan="10" style="text-align: center; vertical-align: middle;">경비</th>
							<th style="text-align: center; vertical-align: middle;">퇴직금
							</td>
							<td>
								<input type="text" size="10" class="cp_pay_amount readonly calc-retirement-grants-amount" disabled="disabled" />
								／
								<input type="text" size="2" class="readonly" name="RETIREMENT_GRANTS" disabled="disabled" />
							</td>
							<td>
								<input type="text" class="readonly validation" name="RETIREMENT_GRANTS_AMOUNT" readonly="readonly" />
							</td>
							<td>임금 ／ 12</td>
						</tr>
						<tr>
							<th style="text-align: center; vertical-align: middle;">산재보험
							</td>
							<td>
								<input type="text" size="10" class="cp_pay_amount readonly calc-safety-insurance-amount" disabled="disabled" />
								＊
								<input type="text" size="2" class="readonly" name="SAFETY_INSURANCE" disabled="disabled" />
							</td>
							<td>
								<input type="text" class="readonly validation" name="SAFETY_INSURANCE_AMOUNT" readonly="readonly" />
							</td>
							<td>임금 ＊ 산재보험요율</td>
						</tr>
						<tr>
							<th style="text-align: center; vertical-align: middle;">국민연금
							</td>
							<td>
								<input type="text" size="10" class="cp_pay_amount readonly calc-national-pension-amount" disabled="disabled" />
								＊
								<input type="text" size="2" class="readonly" name="NATIONAL_PENSION" disabled="disabled" />
							</td>
							<td>
								<input type="text" class="readonly validation" name="NATIONAL_PENSION_AMOUNT" readonly="readonly" />
							</td>
							<td>임금 ＊ 국민연금요율</td>
						</tr>
						<tr>
							<th style="text-align: center; vertical-align: middle;">건강보험
							</td>
							<td>
								<input type="text" size="10" class="cp_pay_amount readonly calc-health-insurance-amount" disabled="disabled" />
								＊
								<input type="text" size="2" class="readonly" name="HEALTH_INSURANCE" disabled="disabled" />
							</td>
							<td>
								<input type="text" class="readonly validation" name="HEALTH_INSURANCE_AMOUNT" readonly="readonly" />
							</td>
							<td>임금 ＊ 건강보험요율</td>
						</tr>
						<tr>
							<th style="text-align: center; vertical-align: middle;">장기요양보험
							</td>
							<td>
								<input type="text" size="10" id="LONGTERM_INSURANCE" class="readonly calc-longterm-insurance-amount" disabled="disabled" />
								＊
								<input type="text" size="2" class="readonly" name="LONGTERM_INSURANCE" disabled="disabled" />
							</td>
							<td>
								<input type="text" class="readonly validation" name="LONGTERM_INSURANCE_AMOUNT" readonly="readonly" />
							</td>
							<td>건강보험료 ＊ 장기요양보험요율</td>
						</tr>
						<tr>
							<th style="text-align: center; vertical-align: middle;">고용보험
							</td>
							<td>
								<input type="text" size="10" class="cp_pay_amount readonly calc-employment-insurance-amount" disabled="disabled" />
								＊
								<input type="text" size="2" class="readonly" name="EMPLOYMENT_INSURANCE" disabled="disabled" />
							</td>
							<td>
								<input type="text" class="readonly validation" name="EMPLOYMENT_INSURANCE_AMOUNT" readonly="readonly" />
							</td>
							<td>임금 ＊ 고용보험요율</td>
						</tr>
						<tr>
							<th style="text-align: center; vertical-align: middle;">종합소득세
							</td>
							<td>
								<input type="text" size="10" class="cp_pay_amount readonly calc-general-income-tax-amount" disabled="disabled" />
								＊
								<input type="text" size="2" class="readonly" name="GENERAL_INCOME_TAX" disabled="disabled" />
							</td>
							<td>
								<input type="text" class="readonly validation" name="GENERAL_INCOME_TAX_AMOUNT" readonly="readonly" />
							</td>
							<td>임금 ＊ 종합소득세율</td>
						</tr>
						<tr>
							<th style="text-align: center; vertical-align: middle;">세무성실신고
							</td>
							<td>
								<input type="text" size="10" class="cp_pay_amount readonly calc-tax-affairs-report-amount" disabled="disabled" />
								＊
								<input type="text" size="2" class="readonly" name="TAX_AFFAIRS_REPORT" disabled="disabled" />
							</td>
							<td>
								<input type="text" class="readonly validation" name="TAX_AFFAIRS_REPORT_AMOUNT" readonly="readonly" />
							</td>
							<td>임금 ＊ 세무성실신고세율</td>
						</tr>
						<tr>
							<th style="text-align: center; vertical-align: middle;">사업주이윤
							</td>
							<td>
								<input type="text" size="10" class="readonly calc-profit-amount" name="PROFIT" disabled="disabled" />
							</td>
							<td>
								<input type="text" class="readonly validation" name="PROFIT_AMOUNT" readonly="readonly" />
							</td>
							<td>사업주이윤</td>
						</tr>
						<tr>
							<th style="text-align: center; vertical-align: middle;">소계
							</td>
							<td>&nbsp;</td>
							<td>
								<input type="text" class="readonly validation" name="EXPENSE_AMOUNT" readonly="readonly" />
							</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<th colspan="2" style="text-align: center; vertical-align: middle;">단가
							</td>
							<td>&nbsp;</td>
							<td>
								<input type="text" class="readonly validation" name="UNIT_PRICE_AMOUNT" readonly="readonly" />
							</td>
							<td>임금(소계) + 경비(소계)</td>
						</tr>
					</table>
				</div>
			</div>
		</form>
	</section>
	<script>
		var enable_calc = false; // 계산 여부 - true: 가능, false: 불가
		var enable_mod = false; // 수정 가능 여부 - true: 가능, false: 불가
		var enable_save = false; // 저장 가능 여부 - true: 가능, false: 불가
		$(document).ready(function() {
			// 부트스트랩 날짜객체
			$(".search_dtp_y").datepicker({
				format: " yyyy",
				viewMode: "years",
				minViewMode: "years",
				language : "ko",
				todayHighlight : true,
				autoclose : true,
				clearBtn : true,
				updateViewDate : false
			}).on('changeDate', function(e) {
				$(this).val(formatDate_y(e.date.valueOf())).trigger("change");
				$("#search_btn").trigger("click");
				$('.datepicker').hide();
			});
			
			// 조회
			$("#search_btn2").on("click", function() {
				f_href("/yp/zwc/upw/zwc_upw_create", {
					BASE_YYYY : "2019", // 선택한 데이터의 연도
					WORKTYPE_CODE : "W2", // 선택한 데이터의 근무형태코드
					hierarchy :  "000005" // 하드코딩
				});
			});
			// 조회
			$("#search_btn").on("click", function() {
				enable_save = false;
				$(".readonly").val("0");
				$(".readonly-at-search").prop("readonly", true).val("0");
				
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					url : "/yp/zwc/upw/select_zwc_upw_create",
					type : "post",
					cache : false,
					async : true,
					data : {
						BASE_YYYY : $("#BASE_YYYY").val(),
						WORKTYPE_CODE : $("#WORKTYPE_CODE").val()
					},
					dataType : "json",
					success : function(result) {
						if(result.list2.length > 0){
							enable_mod = true;
							if(result.list1.length > 0){
								enable_calc = false;
								$(".readonly-at-search").prop("readonly", true);
								
								var row = result.list1[0];
								$.each(row, function(k, v){
									if(k === "BASE_PAY_HOUR"){
										$("[name=BASE_PAY_HOUR]").val(addComma(v));
										$(".cp_base_pay_hour").val(addComma(v));
									}else if(k === "PAY_AMOUNT"){
										$("[name=PAY_AMOUNT]").val(addComma(v));
										$(".cp_pay_amount").val(addComma(v));
									}else if(k === "HEALTH_INSURANCE_AMOUNT"){
										$("[name=HEALTH_INSURANCE_AMOUNT]").val(addComma(v));
										$("#LONGTERM_INSURANCE").val(addComma(v));
									}else{
										$("#frm").find("[name=" + k + "]").val(addComma(Number(v)));
									}
								});
							}else{
								$("#fnModify").trigger("click");
							}
							var row = result.list2[0];
							$.each(row, function(k, v){
								if(k === "PROFIT"){
									$("#frm").find("[name=" + k + "]").val(addComma(v));
									$("#frm").find("[name=PROFIT_AMOUNT]").val(addComma(v));
								}else{
									$("#frm").find("[name=" + k + "]").val(addComma(v));
								}
							});
						}else{
							enable_mod = false;
							enable_calc = false;
							swalWarningCB("해당 연도에 통합 경비가 등록되지 않았습니다.\n연도별 통합 경비 등록 메뉴에서 추가해주세요.");
						}
						$("[name=BASE_YYYY]").val($("#BASE_YYYY").val());
						$("[name=WORKTYPE_CODE]").val($("#WORKTYPE_CODE").val());
					},
					beforeSend : function(xhr) {
						// 2019-10-23 khj - for csrf
						xhr.setRequestHeader(header, token);
						$('.wrap-loading').removeClass('display-none');
					},
					complete : function() {
						$('.wrap-loading').addClass('display-none');
					},
					error : function(request, status, error) {
						console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
						swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
					}
				});
			});

			// 수정
			$("#fnModify").on("click", function() {
				if(!enable_mod){
					swalWarningCB("해당 연도에 통합 경비가 등록되지 않았습니다.\n연도별 통합 경비 등록 메뉴에서 추가해주세요.");
					return false;
				}
				enable_calc = true;
				enable_save = true;
				$(".readonly-at-search").prop("readonly", false);
				$(".pay").trigger("click");
				$(".BASE_PAY_HOUR:not([readonly])").focus();
			});

			// 선택 저장
			$("#fnSave").on("click", function() {
				if(enable_save){
					if (!fnValidation()) {
						return false;
					}
					if (confirm("등록하겠습니까?")) {
						var token = $("meta[name='_csrf']").attr("content");
						var header = $("meta[name='_csrf_header']").attr("content");
						var data = $("#frm").serializeArray();
						$.ajax({
							url : "/yp/zwc/upw/save_zwc_upw_create",
							type : "POST",
							cache : false,
							async : true,
							dataType : "json",
							data : data,
							success : function(result) {
								if (result.code > 0) {
									$("#search_btn").trigger("click");
								}
							},
							beforeSend : function(xhr) {
								// 2019-10-23 khj - for csrf
								xhr.setRequestHeader(header, token);
								$('.wrap-loading').removeClass('display-none');
							},
							complete : function() {
								$('.wrap-loading').addClass('display-none');
							},
							error : function(request, status, error) {
								console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
								swalDangerCB("등록에 실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
					}
				}else{
					swalWarningCB("저장할 수 있는 상태가 아닙니다.\n수정 버튼을 클릭하세요.");
					return false;
				}
			});
			
			$("#search_btn").trigger("click");
			
			// 시급 변경 엔터키 이벤트(수정모드인 경우에만 작동)
			$(".BASE_PAY_HOUR").on("keyup", function(e){
				if($(".BASE_PAY_HOUR").is("[readonly]") || e.which !== 13){
					return false;
				}
				if(!enable_calc){
					return false;
				}
				// 시급 영역복사
				var x = unComma($("[name=BASE_PAY_HOUR]").val());
				var y = unComma($("[name=BASE_PAY_WORKING_HOUR]").val());
				$(".cp_base_pay_hour").val(addComma(x)).change();
				$(this).val(addComma(x));
				var r = x * y;
				$("[name=BASE_PAY_AMOUNT]").val(addComma(r));
				// 임금 계산
				calc_PAY_AMOUNT();
			});
			// 시급 변경
			$("[name=BASE_PAY_HOUR]").on("change", function(){
				if(!enable_calc){
					return false;
				}
				// 시급 영역복사
				var x = unComma($("[name=BASE_PAY_HOUR]").val());
				var y = unComma($("[name=BASE_PAY_WORKING_HOUR]").val());
				$(".cp_base_pay_hour").val(addComma(x)).change();
				$(this).val(addComma(x));
				var r = x * y;
				$("[name=BASE_PAY_AMOUNT]").val(addComma(r));
				// 임금 계산
				calc_PAY_AMOUNT();
			});
			// 근로시간 변경
			$("[name=BASE_PAY_WORKING_HOUR]").on("change", function(){
				if(!enable_calc){
					return false;
				}
				var x = unComma($("[name=BASE_PAY_HOUR]").val());
				var y = unComma($("[name=BASE_PAY_WORKING_HOUR]").val());
				var r = x * y;
				$("[name=BASE_PAY_AMOUNT]").val(addComma(r));
				// 임금 계산
				calc_PAY_AMOUNT();
			});
			//수당 - 토요 변경
			$(".calc-saturday").on("change", function(){
				if(!enable_calc){
					return false;
				}
				var m = Number(unComma($("[name=BASE_PAY_HOUR]").val()));
				var x = Number(unComma($("[name=SATURDAY_HOUR]").val()));
				var y = Number(unComma($("[name=SATURDAY_WEEK]").val()));
				var z = Number(unComma($("[name=SATURDAY_DOUBLE]").val()));
				console.log(m * x * y * z, Math.round(m * x * y * z));
				var r = Math.round(m * x * y * z);
				$("[name=SATURDAY_AMOUNT]").val(addComma(r));
				// 수당 소계 계산
				calc_EXTRA_PAY_AMOUNT();
			});
			//수당 - 휴일 변경
			$(".calc-holiday").on("change", function(){
				if(!enable_calc){
					return false;
				}
				var m = Number(unComma($("[name=BASE_PAY_HOUR]").val()));
				var x = Number(unComma($("[name=HOLIDAY_HOUR]").val()));
				var y = Number(unComma($("[name=HOLIDAY_WEEK]").val()));
				var z = Number(unComma($("[name=HOLIDAY_DOUBLE]").val()));
				console.log(m * x * y * z, Math.round(m * x * y * z));
				var r = Math.round(m * x * y * z);
				$("[name=HOLIDAY_AMOUNT]").val(addComma(r));
				// 수당 소계 계산
				calc_EXTRA_PAY_AMOUNT();
			});
			//수당 - 야간 변경
			$(".calc-night").on("change", function(){
				if(!enable_calc){
					return false;
				}
				var m = Number(unComma($("[name=BASE_PAY_HOUR]").val()));
				var x = Number(unComma($("[name=NIGHT_HOUR]").val()));
				var y = Number(unComma($("[name=NIGHT_WEEK]").val()));
				var z = Number(unComma($("[name=NIGHT_DOUBLE]").val()));
				console.log(m * x * y * z, Math.round(m * x * y * z));
				var r = Math.round(m * x * y * z);
				$("[name=NIGHT_AMOUNT]").val(addComma(r));
				// 수당 소계 계산
				calc_EXTRA_PAY_AMOUNT();
			});
			//수당 - 정휴일 변경
			$(".calc-regular-holiday").on("change", function(){
				if(!enable_calc){
					return false;
				}
				var m = Number(unComma($("[name=BASE_PAY_HOUR]").val()));
				var x = Number(unComma($("[name=REGULAR_HOLIDAY_HOUR]").val()));
				var y = Number(unComma($("[name=REGULAR_HOLIDAY_DAY]").val()));
				var z = Number(unComma($("[name=REGULAR_HOLIDAY_DOUBLE]").val()));
				console.log(m * x * y * z / 12, Math.round(m * x * y * z / 12));
				var r = Math.round(m * x * y * z / 12);
				$("[name=REGULAR_HOLIDAY_AMOUNT]").val(addComma(r));
				// 수당 소계 계산
				calc_EXTRA_PAY_AMOUNT();
			});
			//수당 - 연차사용 변경
			$(".calc-annual-leave-use").on("change", function(){
				if(!enable_calc){
					return false;
				}
				var m = Number(unComma($("[name=BASE_PAY_HOUR]").val()));
				var x = Number(unComma($("[name=ANNUAL_LEAVE_USE_HOUR]").val()));
				var y = Number(unComma($("[name=ANNUAL_LEAVE_USE_DAY]").val()));
				var z = Number(unComma($("[name=ANNUAL_LEAVE_USE_DOUBLE]").val()));
				console.log(m * x * y * z / 12, Math.round(m * x * y * z / 12));
				var r = Math.round(m * x * y * z / 12);
				$("[name=ANNUAL_LEAVE_USE_AMOUNT]").val(addComma(r));
				// 수당 소계 계산
				calc_EXTRA_PAY_AMOUNT();
			});
			//수당 - 연차미사용 변경
			$(".calc-annual-leave-unuse").on("change", function(){
				if(!enable_calc){
					return false;
				}
				var m = Number(unComma($("[name=BASE_PAY_HOUR]").val()));
				var x = Number(unComma($("[name=ANNUAL_LEAVE_UNUSE_HOUR]").val()));
				var y = Number(unComma($("[name=ANNUAL_LEAVE_UNUSE_DAY]").val()));
				var z = Number(unComma($("[name=ANNUAL_LEAVE_UNUSE_DOUBLE]").val()));
				console.log(m * x * y * z / 12, Math.round(m * x * y * z / 12));
				var r = Math.round(m * x * y * z / 12);
				$("[name=ANNUAL_LEAVE_UNUSE_AMOUNT]").val(addComma(r));
				// 수당 소계 계산
				calc_EXTRA_PAY_AMOUNT();
			});
			
			// 경비 - 퇴직금 변경
			$(".calc-retirement-grants-amount").on("change", function(){
				if(!enable_calc){
					return false;
				}
				var x = Number(unComma($("[name=PAY_AMOUNT]").val()));
				var y = Number(unComma($("[name=RETIREMENT_GRANTS]").val()));
				console.log(x / y, Math.round(x / y));
				var r = Math.round(x / y);
				$("[name=RETIREMENT_GRANTS_AMOUNT]").val(addComma(r));
				calc_PRICE();
			});
			
			// 경비 - 산재보험 변경
			$(".calc-safety-insurance-amount").on("change", function(){
				if(!enable_calc){
					return false;
				}
				var x = Number(unComma($("[name=PAY_AMOUNT]").val()));
				var y = Number(unComma($("[name=SAFETY_INSURANCE]").val()));
				console.log(x * y / 100, Math.round(x * y / 100));
				var r = Math.round(x * y / 100);
				$("[name=SAFETY_INSURANCE_AMOUNT]").val(addComma(r));
				calc_PRICE();
			});
			
			// 경비 - 국민연금 변경
			$(".calc-national-pension-amount").on("change", function(){
				if(!enable_calc){
					return false;
				}
				var x = Number(unComma($("[name=PAY_AMOUNT]").val()));
				var y = Number(unComma($("[name=NATIONAL_PENSION]").val()));
				console.log(x * y / 100, Math.round(x * y / 100));
				var r = Math.round(x * y / 100);
				$("[name=NATIONAL_PENSION_AMOUNT]").val(addComma(r));
				calc_PRICE();
			});
			
			// 경비 - 건강보험 변경
			$(".calc-health-insurance-amount").on("change", function(){
				if(!enable_calc){
					return false;
				}
				var x = Number(unComma($("[name=PAY_AMOUNT]").val()));
				var y = Number(unComma($("[name=HEALTH_INSURANCE]").val()));
				console.log(x * y / 100, Math.round(x * y / 100));
				var r = Math.round(x * y / 100);
				$("[name=HEALTH_INSURANCE_AMOUNT]").val(addComma(r));
				$("#LONGTERM_INSURANCE").val(addComma(r)).change();
				calc_PRICE();
			});
			
			// 경비 - 장기요양보험 변경
			$(".calc-longterm-insurance-amount").on("change", function(){
				if(!enable_calc){
					return false;
				}
				var x = Number(unComma($("#LONGTERM_INSURANCE").val()));
				var y = Number(unComma($("[name=LONGTERM_INSURANCE]").val()));
				console.log(x * y / 100, Math.round(x * y / 100));
				var r = Math.round(x * y / 100);
				$("[name=LONGTERM_INSURANCE_AMOUNT]").val(addComma(r));
				calc_PRICE();
			});
			
			// 경비 - 고용보험 변경
			$(".calc-employment-insurance-amount").on("change", function(){
				if(!enable_calc){
					return false;
				}
				var x = Number(unComma($("[name=PAY_AMOUNT]").val()));
				var y = Number(unComma($("[name=EMPLOYMENT_INSURANCE]").val()));
				console.log(x * y / 100, Math.round(x * y / 100));
				var r = Math.round(x * y / 100);
				$("[name=EMPLOYMENT_INSURANCE_AMOUNT]").val(addComma(r));
				calc_PRICE();
			});
			
			// 경비 - 종합소득세 변경
			$(".calc-general-income-tax-amount").on("change", function(){
				if(!enable_calc){
					return false;
				}
				var x = Number(unComma($("[name=PAY_AMOUNT]").val()));
				var y = Number(unComma($("[name=GENERAL_INCOME_TAX]").val()));
				console.log(x * y / 100, Math.round(x * y / 100));
				var r = Math.round(x * y / 100);
				$("[name=GENERAL_INCOME_TAX_AMOUNT]").val(addComma(r));
				calc_PRICE();
			});
			
			// 경비 - 세무성실신고 변경
			$(".calc-tax-affairs-report-amount").on("change", function(){
				if(!enable_calc){
					return false;
				}
				var x = Number(unComma($("[name=PAY_AMOUNT]").val()));
				var y = Number(unComma($("[name=TAX_AFFAIRS_REPORT]").val()));
				console.log(x * y / 100, Math.round(x * y / 100));
				var r = Math.round(x * y / 100);
				$("[name=TAX_AFFAIRS_REPORT_AMOUNT]").val(addComma(r));
				calc_PRICE();
			});
			
			// 경비 - 사업주이윤
			$(".calc-profit-amount").on("change", function(){
				if(!enable_calc){
					return false;
				}
				var x = Number(unComma($("[name=PROFIT]").val()));
				var y = 1
				var r = Math.round(x * y);
				$("[name=PROFIT_AMOUNT]").val(addComma(r));
				calc_PRICE();
			});
		});
		// 수당 소계 계산
		function calc_EXTRA_PAY_AMOUNT(){
			var r =  
				Number(unComma($("[name=SATURDAY_AMOUNT]").val())) + 
				Number(unComma($("[name=HOLIDAY_AMOUNT]").val())) + 
				Number(unComma($("[name=NIGHT_AMOUNT]").val())) + 
				Number(unComma($("[name=REGULAR_HOLIDAY_AMOUNT]").val())) + 
				Number(unComma($("[name=ANNUAL_LEAVE_USE_AMOUNT]").val())) + 
				Number(unComma($("[name=ANNUAL_LEAVE_UNUSE_AMOUNT]").val()));
			$("[name=EXTRA_PAY_AMOUNT]").val(addComma(r));
			// 임금 계산
			calc_PAY_AMOUNT();
		}
		// 임금 계산
		function calc_PAY_AMOUNT(){
			var r = 
				Number(unComma($("[name=BASE_PAY_AMOUNT]").val())) + 
				Number(unComma($("[name=SATURDAY_AMOUNT]").val())) + 
				Number(unComma($("[name=HOLIDAY_AMOUNT]").val())) + 
				Number(unComma($("[name=NIGHT_AMOUNT]").val())) + 
				Number(unComma($("[name=REGULAR_HOLIDAY_AMOUNT]").val())) + 
				Number(unComma($("[name=ANNUAL_LEAVE_USE_AMOUNT]").val())) + 
				Number(unComma($("[name=ANNUAL_LEAVE_UNUSE_AMOUNT]").val()));
			$("[name=PAY_AMOUNT]").val(addComma(r));
			// 단가 탭 임금 항목에 값 복사 및 이벤트 작동
			$(".cp_pay_amount").val(addComma(r)).change();
		}
		
		// 경비 소계 계산 및 단가 계산
		function calc_PRICE(){
			var r =
				Number(unComma($("[name=RETIREMENT_GRANTS_AMOUNT]").val())) +
				Number(unComma($("[name=SAFETY_INSURANCE_AMOUNT]").val())) +
				Number(unComma($("[name=NATIONAL_PENSION_AMOUNT]").val())) +
				Number(unComma($("[name=HEALTH_INSURANCE_AMOUNT]").val())) +
				Number(unComma($("[name=LONGTERM_INSURANCE_AMOUNT]").val())) +
				Number(unComma($("[name=EMPLOYMENT_INSURANCE_AMOUNT]").val())) +
				Number(unComma($("[name=GENERAL_INCOME_TAX_AMOUNT]").val())) +
				Number(unComma($("[name=TAX_AFFAIRS_REPORT_AMOUNT]").val())) +
				Number(unComma($("[name=PROFIT_AMOUNT]").val()));
			$("[name=EXPENSE_AMOUNT]").val(addComma(r));
			var x = Number(unComma($("[name=PAY_AMOUNT]").val()));
			var y = r;
			r = x + y;
			$("[name=UNIT_PRICE_AMOUNT]").val(addComma(r));
		}
		
		/*콤마 추가*/
		function addComma(num) {
			return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		}

		/*콤마 제거*/
		function unComma(num) {
			return num.replace(/[^0-9.]/gi, '');
		}
		
		function fnValidation(){
			var check = true;
			$(".validation").each(function(i, d){
				if(isNaN(Number(unComma($(d).val())))){
					swalWarningCB("수식에 사용된 항목값을 확인해주세요.", function(){
						$(d).focus();
					});
					check = false;
					return false;
				}
			});
// 			console.log("결과", check);
			return check;
		}
		function formatDate_y(date) {
			var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
			if (month.length < 2)
				month = '0' + month;
			if (day.length < 2)
				day = '0' + day;
			return [ year ].join('/');
		}
	</script>
</body>