<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
if (request.getProtocol().equals("HTTP/1.1")) {
	response.setHeader("Cache-Control", "no-cache");
}

Date today = new Date();
SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/dd");
String to_day = date.format(today);
// JSTL에서 사용할 수 있도록 세팅
request.setAttribute("today", to_day);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>
	<c:if test="${menu.breadcrumb[0].menu_id ne null}">
		${menu.breadcrumb[0].menu_name}
	</c:if>
</title>
<style type="text/css">
.table td, .table th {
	padding: 0.4rem !important;
}
.btn_e { border-radius:3px; display:inline-block; vertical-align:baseline; border:1px solid #626262;  padding:3px 10px 4px 10px; cursor:pointer; color:#fff; font-weight:100; font-size:12px; vertical-align: middle;} 
.btn_e { background:#d83838; }
.btn_e:hover { background:#900b0b; border: 1px solid #f10000; }
</style>
</head>
<body>
	<h2>
		<c:if test="${menu.breadcrumb[0].menu_id ne null}">
			${menu.breadcrumb[0].menu_name}
		</c:if>
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
	
	<form id="frm" name="frm">
		<div class="float_wrap">
			<div class="fl">
				<div class="stitle">
				</div>
			</div>
		</div>
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<section>
			<div class="tbl_box">
				<table class="contract_standard_table" cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="5%" />
						<col width="28%" />
						<col width="5%" />
						<col width="28%" />
						<col width="5%" />
						<col width="28%" />
					</colgroup>
			<c:choose>
				<c:when test="${P_RESPONSE_VIEW eq 'Y'}">
				<tr>
					<th>일보일자</th>
					<td>
						<input type="text" id="WORK_DT" name="WORK_DT" class="calendar dtp_ymd" value="${P_WORK_DT}" readonly="readonly"/>
					</td>
					<th>거래처</th>
					<td>
						<input type="text" id="SAP_CODE" name="SAP_CODE" size="10" readonly="readonly" value="${P_ENT_CODE}" style="background-color: #e5e5e5;"/>
						<input type="hidden" id="VENDOR_CODE" name="VENDOR_CODE" size="10" value="${P_VENDOR_CODE}"/>
						<a href="#" onclick="fnSearchPopup('1');"><img src="/resources/yp/images/ic_search.png"></a>
						<input type="text" id="VENDOR_NAME" name="VENDOR_NAME" disabled="disabled"  style="width:200px;" value="${P_VENDOR_NAME}"/>
					</td>
					<th>계약</th>
					<td>
						<input type="text" id="CONTRACT_CODE" name="CONTRACT_CODE" size="10" readonly="readonly" value="${P_CONTRACT_CODE}"/>
						<a href="#" onclick="fnSearchPopup('2');"><img src="/resources/yp/images/ic_search.png"></a>
						<input type="text" id="CONTRACT_NAME" name="CONTRACT_NAME" disabled="disabled" value="${P_CONTRACT_NAME}" style="width:200px;"/>
					</td>
				</tr>
				</c:when>
				<c:otherwise>
				<tr>
					<th>일보일자</th>
					<td>
						<input type="text" id="WORK_DT" name="WORK_DT" class="calendar dtp_ymd" value="${today}" readonly="readonly"/>
					</td>
					<th>거래처</th>
					<td>
						<input type="text" id="SAP_CODE" name="SAP_CODE" size="10" readonly="readonly" value="" style="background-color: #e5e5e5;"/>
						<input type="hidden" id="VENDOR_CODE" name="VENDOR_CODE" size="10" value=""/>
						<a href="#" onclick="fnSearchPopup('1');"><img src="/resources/yp/images/ic_search.png"></a>
						<input type="text" id="VENDOR_NAME" name="VENDOR_NAME" disabled="disabled"  style="width:200px;" value=""/>
					</td>
					<th>계약</th>
					<td>
						<input type="text" id="CONTRACT_CODE" name="CONTRACT_CODE" size="10" readonly="readonly" />
						<a href="#" onclick="fnSearchPopup('2');"><img src="/resources/yp/images/ic_search.png"></a>
						<input type="text" id="CONTRACT_NAME" name="CONTRACT_NAME" disabled="disabled"  style="width:200px;"/>
					</td>
				</tr>
				</c:otherwise>
			</c:choose>
				</table>
				<div class="btn_wrap">
					<button class="btn btn_search" id="search_btn" type="button">조회</button>
				</div>
			</div>
		</section>
		<div class="float_wrap">
			<div class="fl">
			<c:if test="${'SA' eq sessionScope.WC_AUTH}">
				<div>
					※　【기한설정, 기한해제】버튼을 클릭하여 전체 항목의 확정/승인의 기한확인 여부를 변경할 수 있습니다.
				</div>
			</c:if>
				<div>
					※　【체크박스】에 선택된 항목이 【승인, 승인취소】처리 대상입니다.
				</div>
				<div>
					※　【승인】버튼을 클릭하면 【보정공수, 공수합계, 비고】항목이 반영됩니다.
				</div>
			</div>
			<div class="fr">
				<div class="btn_wrap" style="margin-bottom:5px;">
					<input type="button" class="btn_g" id="btn_confirm" value="　승인　" data-exec="CF"/>
					<input type="button" class="btn_g" id="btn_cancel" value="승인취소" data-exec="CC"/>
				<c:if test="${'SA' eq sessionScope.WC_AUTH}">
					<input type="button" class="btn_e" id="btn_lock" value="기한설정" data-exec="L"/>
					<input type="button" class="btn_e" id="btn_release" value="기한해제" data-exec="R"/>
				</c:if>
				</div>
			</div>
		</div>
		<section class="section">
			<form id="frm" name="frm" method="post">
				<div class="tbl_box" style="background: none;">
					<table border="1" class="table">
						<tr class="tb-head">
							<td style="color: white; width: 33px;"><input type="checkbox" style="zoom: 1.5;" class="all-check" onchange="javascript: batch_checkbox(this);"></td>
							<td style="color: white; width: 50px;">승인<br>여부</td>
							<td style="color: white; width: 80px;">년</td>
							<td style="color: white; width: 50px;">월</td>
							<td style="color: white; width: 50px;">일</td>
							<td style="color: white; width: 80px;">작업<br>시작시간</td>
							<td style="color: white; width: 80px;">작업<br>종료시간</td>
							<td style="color: white; width: 80px;">코스트<br>센터</td>
							<td style="color: white; width: 100px;">코스트<br>센터명</td>
							<td style="color: white;">작업내역</td>
							<td style="color: white; width: 120px;">SAP<br>오더번호</td>
							<td style="color: white; width: 100px;">공수<br>(M/D)</td>
							<td style="color: white; width: 100px;">보정</td>
							<td style="color: white; width: 100px;">계</td>
							<td style="color: white; width: 200px;">비고</td>
						</tr>
						<tr><td class="center vertical-center" colspan="15">데이터가 없습니다.</td></tr>
					</table>
				</div>
			</form>
		</section>
	</form>
	<script type="text/javascript">
	var save_datas = new Array();
	var target_contract_code, target_vendor_code, target_work_dt;
	$(document).ready(function(){
		$('input').on('keydown', function(event) {
			if(event.keyCode==13) 
				return false;
		});

		$(document).on("focus", ".dtp_ymd", function() {
			$(this).datepicker({
				format: "yyyy/mm/dd",
				language : "ko",
				todayHighlight : true,
				autoclose : true,
				clearBtn : true,
				updateViewDate : false
			}).on('changeDate', function(e) {
				if(e.viewMode !== "days"){
					return false;
				}
				$(this).val(formatDate_d(e.date.valueOf())).trigger("change");
				$('.datepicker').hide();
			});
		});
		
		// 조회
		$("#search_btn").on("click", function() {
			//거래처 빈값체크
			var VENDOR_CODE = $("#VENDOR_CODE").val().trim();
			if(isEmpty(VENDOR_CODE)){
				swalWarningCB("거래처를 입력해주세요.");
				return false;
			}
			//계약코드 빈값체크
			var CONTRACT_CODE = $("#CONTRACT_CODE").val().trim();
			if(isEmpty(CONTRACT_CODE)){
				swalWarningCB("계약을 선택해주세요.");
				return false;
			}
			// 시작일자
			var WORK_DT = $("#WORK_DT").val().trim();
			if(isEmpty(WORK_DT)){
				swalWarningCB("일보일자를 입력해주세요.");
				return false;
			}
			var data = {
				'CONTRACT_CODE' : $("#CONTRACT_CODE").val().trim(),
				'VENDOR_CODE' : $("#VENDOR_CODE").val().trim(),
				'VENDOR_NAME' : $("#VENDOR_NAME").val().trim(),
				'WORK_DT' : $("#WORK_DT").val().trim()
			};
			
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				url : "/yp/zcs/ipt2/select_zcs_ipt2_daily_aprv3",
				type : "POST",
				cache : false,
				async : true,
				dataType : "json",
				data : data, //폼을 그리드 파라메터로 전송
				success : function(data) {
					//테이블 초기화
					tableInit();
					
					var innerHtml = '';
					var manhour = 0;
					var manhour_correction = 0;
					var manhour_sum = 0;
					
					var result1 = data.list1;
					var result2 = data.list2;
					
					if(result1.length === 0){
						innerHtml = '<tr><td class="center vertical-center" colspan="15">데이터가 없습니다.</td></tr>';
						$('.table').append(innerHtml);
						return false;
					}
					
					$.each(result1, function(i, d){
						innerHtml += '<tr class="data-base" data-rn="' + ( i + 1 ) + '" ' + ( d.DATA_TYPE === "M" ? ' style="background-color: lightpink;"' : '' ) + '>';
						innerHtml += '	<td class="center vertical-center"	style="width: 33px;">';
						innerHtml += '		<input type="checkbox" class="rows-checkbox rows-no-' + i + '" data-rn="' + ( i + 1 ) + '" style="zoom: 1.5;"';
						innerHtml += '			DATA_TYPE="' + d.DATA_TYPE + '"';
						innerHtml += '			CONTRACT_CODE="' + d.CONTRACT_CODE + '"';
						innerHtml += '			VENDOR_CODE="' + d.VENDOR_CODE + '"';
						innerHtml += '			ORDER_NUMBER="' + d.ORDER_NUMBER + '"';
						innerHtml += '			WORK_DT="' + d.WORK_DT + '"';
						innerHtml += '			RELEASE_YN="' + d.RELEASE_YN + '"';
						innerHtml += '			WORK_CONTENTS="' + d.WORK_CONTENTS + '"';
						innerHtml += '			COST_CODE="' + d.COST_CODE + '"';
						innerHtml += '			COST_NAME="' + d.COST_NAME + '"';
						innerHtml += '			WORK_START_DT="' + d.WORK_START_DT + '"';
						innerHtml += '			WORK_START_TIME="' + d.WORK_START_TIME + '"';
						innerHtml += '			WORK_END_DT="' + d.WORK_END_DT + '"';
						innerHtml += '			WORK_END_TIME="' + d.WORK_END_TIME + '"';
						innerHtml += '			MANHOUR="' + d.MANHOUR + '"';
						innerHtml += '			MANHOUR_CORRECTION="' + d.MANHOUR_CORRECTION + '"';
						innerHtml += '			MANHOUR_SUM="' + d.MANHOUR_SUM + '"';
						innerHtml += '			MEMO="' + ( isEmpty( d.MEMO ) ? '' : d.MEMO ) + '"';
						innerHtml += '			APRV_YN="' + ( isEmpty( d.APRV_YN ) ? '' : d.APRV_YN ) + '"';
						innerHtml += '		/>';
						innerHtml += '	</td>';
						innerHtml += '	<td class="center vertical-center"	style="width: 50px;"><div style="padding: 4px 3px;">' + ( d.APRV_YN === "Y" ? "○" : "&nbsp;" ) + '</div></td>';
						innerHtml += '	<td class="center vertical-center"	style="width: 80px;"><div style="padding: 4px 3px;">' + d.VIEW_Y + '</div></td>';
						innerHtml += '	<td class="center vertical-center"	style="width: 50px;"><div style="padding: 4px 3px;">' + d.VIEW_M + '</div></td>';
						innerHtml += '	<td class="center vertical-center"	style="width: 50px;"><div style="padding: 4px 3px;">' + d.VIEW_D + '</div></td>';
						innerHtml += '	<td class="center vertical-center"	style="width: 80px;"><div style="padding: 4px 3px;">' + d.WORK_START_TIME + '</div></td>';
						innerHtml += '	<td class="center vertical-center"	style="width: 80px;"><div style="padding: 4px 3px;">' + d.WORK_END_TIME + '</div></td>';
						innerHtml += '	<td class="center vertical-center"	style="width: 80px;"><div style="padding: 4px 3px;">' + d.COST_CODE + '</div></td>';
						innerHtml += '	<td class="center vertical-center"	style="width: 100px;"><div style="padding: 4px 3px;">' + d.COST_NAME + '</div></td>';
						innerHtml += '	<td class="left vertical-center"	><div style="padding: 4px 3px;">' + d.WORK_CONTENTS + '</div></td>';
						innerHtml += '	<td class="center vertical-center"	style="width: 120px;"><div style="padding: 4px 3px;">' + d.ORDER_NUMBER + '</div></td>';
						innerHtml += '	<td class="right vertical-center"	style="width: 100px;"><input type="number" value="' + d.MANHOUR +				'" data-rn="' + i + '" class="data-col-1 data" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
						innerHtml += '	<td class="right vertical-center"	style="width: 100px;"><input type="number" value="' + d.MANHOUR_CORRECTION +	'" data-rn="' + i + '" class="data-col-2 data" step="0.01" onchange="javascript: reflectManHour(this);" style="width: 100%; text-align: right;"/></td>';
						innerHtml += '	<td class="right vertical-center"	style="width: 100px;"><input type="number" value="' + d.MANHOUR_SUM +			'" data-rn="' + i + '" class="data-col-3 data" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
						innerHtml += '	<td class="right vertical-center"	style="width: 200px;"><input type="text" data-rn="' + i + '" onchange="javascript: reflectCommon(this, \'MEMO\');" value="' + ( isEmpty( d.MEMO ) ? '' : d.MEMO ) + '" style="width: 100%;"/></td>';
// 						innerHtml += '	<td class="right vertical-center"	style="width: 100px;"><div style="padding: 4px 3px;">' + d.MANHOUR + '</div></td>';
// 						innerHtml += '	<td class="right vertical-center"	style="width: 100px;"><div style="padding: 4px 3px;">' + d.MANHOUR_CORRECTION + '</div></td>';
// 						innerHtml += '	<td class="right vertical-center"	style="width: 100px;"><div style="padding: 4px 3px;">' + d.MANHOUR_SUM + '</div></td>';
// 						innerHtml += '	<td class="left vertical-center"	style="width: 200px;"><div style="padding: 4px 3px;">' + ( isEmpty( d.MEMO ) ? '' : d.MEMO ) + '</div></td>';
						innerHtml += '</tr>';
						manhour += Number( d.MANHOUR );
						manhour_correction += Number( d.MANHOUR_CORRECTION );
						manhour_sum += Number( d.MANHOUR_SUM );
					});
// 					console.log("manhour", manhour);
// 					console.log("manhour_correction", manhour_correction);
// 					console.log("manhour_sum", manhour_sum);
					innerHtml += '<tr>';
					innerHtml += '	<td class="center vertical-center" colspan="11"><div style="padding: 4px 3px;">공수합계</div></td>';
					innerHtml += '	<td class="right vertical-center"><input type="number" value="' + manhour.toFixed(2) +				'" class="data-col-1 sub1" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
					innerHtml += '	<td class="right vertical-center"><input type="number" value="' + manhour_correction.toFixed(2) +	'" class="data-col-2 sub1" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
					innerHtml += '	<td class="right vertical-center"><input type="number" value="' + manhour_sum.toFixed(2) +			'" class="data-col-3 sub1" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
					innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">&nbsp;</div></td>';
					innerHtml += '</tr>';
// 					innerHtml += '<tr>';
// 					innerHtml += '	<td class="center vertical-center" colspan="11"><div style="padding: 4px 3px;">공수합계</div></td>';
// 					innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;" class="data-col-1 sub1">' + manhour.toFixed(2) + '</div></td>';
// 					innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;" class="data-col-2 sub1">' + manhour_correction.toFixed(2) + '</div></td>';
// 					innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;" class="data-col-3 sub1">' + manhour_sum.toFixed(2) + '</div></td>';
// 					innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">&nbsp;</div></td>';
// 					innerHtml += '</tr>';
					<%--
					// 출퇴근 조회결과에서 가져온 값을 출력한다.
					if(result2 === null){
						innerHtml += '<tr class="data-commute">';
						innerHtml += '	<td class="center vertical-center" colspan="8"><div style="padding: 4px 3px;">출퇴근합계</div></td>';
						innerHtml += '	<td class="right vertical-center"><input type="number" value="' + 0 + '" class="data-col-1 sub2" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
						innerHtml += '	<td class="right vertical-center"><input type="number" value="' + 0 + '" class="data-col-2 sub2" step="0.01" onchange="javascript: reflectManHour(this);" style="width: 100%; text-align: right;"/></td>';
						innerHtml += '	<td class="right vertical-center"><input type="number" value="' + 0 + '" class="data-col-3 sub2" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
						innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">&nbsp;</div></td>';
						innerHtml += '</tr>';
						innerHtml += '<tr class="data-commute">';
						innerHtml += '	<td class="center vertical-center" colspan="10"><div style="padding: 4px 3px;">차이( 공수 - 출퇴근 )</div></td>';
// 						innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">' + ( manhour_sum - manhour_cnt ) + '</div></td>';
						innerHtml += '	<td class="right vertical-center"><input type="number" value="' + manhour_sum.toFixed(2) + '" class="data-col-3 sub3" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
						innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">&nbsp;</div></td>';
						innerHtml += '</tr>';
					}else{
						innerHtml += '<tr class="data-commute">';
						innerHtml += '	<td class="center vertical-center" colspan="8"><div style="padding: 4px 3px;">출퇴근합계</div></td>';
						innerHtml += '	<td class="right vertical-center"><input type="number" value="' + result2.COMMUTE +				'" class="data-col-1 sub2" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
						innerHtml += '	<td class="right vertical-center"><input type="number" value="' + result2.COMMUTE_CORRECTION +	'" class="data-col-2 sub2" step="0.01" onchange="javascript: reflectManHour(this);" style="width: 100%; text-align: right;"/></td>';
						innerHtml += '	<td class="right vertical-center"><input type="number" value="' + result2.COMMUTE_SUM +			'" class="data-col-3 sub2" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
						innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">&nbsp;</div></td>';
						innerHtml += '</tr>';
						innerHtml += '<tr class="data-commute">';
						innerHtml += '	<td class="center vertical-center" colspan="10"><div style="padding: 4px 3px;">차이( 공수 - 출퇴근 )</div></td>';
						innerHtml += '	<td class="right vertical-center"><input type="number" value="' + result2.SUBTRACTION + '" class="data-col-3 sub3" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
						innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">&nbsp;</div></td>';
						innerHtml += '</tr>';
					}
					--%>
					$('.table').append(innerHtml);
					
					reflectFooter();
					
				},
				beforeSend : function(xhr) {
					// 2019-10-23 khj - for csrf
					xhr.setRequestHeader(header, token);
					$('.wrap-loading').removeClass('display-none');
					$('.all-check').prop("checked", false);
					
					target_contract_code = $("#CONTRACT_CODE").val().trim();
					target_vendor_code = $("#VENDOR_CODE").val().trim();
					target_work_dt = $("#WORK_DT").val().trim();
				},
				complete : function() {
					$('.wrap-loading').addClass('display-none');
				},
				error : function(request, status, error) {
					console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
					swalDangerCB("조회 실패하였습니다.\n관리자에게 문의해주세요.");
				}
			});
		});
		
		/* 기한설정, 기한해제 */
		$("#btn_lock, #btn_release").on("click", function() {
			var exec = $(this).data("exec");
			var exec_msg = ( exec === "L" ? "기한설정" : "기한해제" );
			var exec_url = ( exec === "L" ? "/yp/zcs/ipt2/lock_zcs_ipt2_daily_aprv3" : "/yp/zcs/ipt2/release_zcs_ipt2_daily_aprv3" );
			if( fnValidation_limit( exec_msg ) ){
				swal({
					icon : "info",
					text : "【" + exec_msg + "】하시겠습니까?",
					closeOnClickOutside : false,
					closeOnEsc : false,
					buttons : {
						confirm : {
							text : "확인",
							value : true,
							visible : true,
							className : "",
							closeModal : true
						},
						cancel : {
							text : "취소",
							value : null,
							visible : true,
							className : "",
							closeModal : true
						}
					}
				}).then(function(result) {
					if(result){
						var token = $("meta[name='_csrf']").attr("content");
						var header = $("meta[name='_csrf_header']").attr("content");
						$.ajax({
							url : exec_url,
							type : "POST",
							cache : false,
							async : false,
							dataType : "json",
							data : {
								ROW_NO: JSON.stringify(save_datas)
							},
							success : function(data) {
								console.log(data);
								swalSuccessCB("【" + exec_msg + "】완료되었습니다.", function(){
									$("#search_btn").trigger("click");
								});
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
								swalDangerCB("【" + exec_msg + "】실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
					}
				});
			}
		});
		
		/* 승인 */
		$("#btn_confirm, #btn_cancel").on("click", function() {
			if( select_chk_enable_proc() ){
				return false;
			}
			var exec = $(this).data("exec");
			if(fnValidation_confirm( ( exec === "CF" ? "승인" : "승인취소" ) )){

				// 확정(승인) 가능 여부 확인
				if( !fn_possible(save_datas) ){
					return false;
				}

				swal({
					icon : "info",
					text : "【" + ( exec === "CF" ? "승인" : "승인취소" ) + "】하시겠습니까?",
					closeOnClickOutside : false,
					closeOnEsc : false,
					buttons : {
						confirm : {
							text : "확인",
							value : true,
							visible : true,
							className : "",
							closeModal : true
						},
						cancel : {
							text : "취소",
							value : null,
							visible : true,
							className : "",
							closeModal : true
						}
					}
				}).then(function(result) {
					if(result){
						var token = $("meta[name='_csrf']").attr("content");
						var header = $("meta[name='_csrf_header']").attr("content");
						$.ajax({
							url : ( exec === "CF" ? "/yp/zcs/ipt2/update_aprv_zcs_ipt2_daily_aprv3" : "/yp/zcs/ipt2/update_reject_zcs_ipt2_daily_aprv3" ),
							type : "POST",
							cache : false,
							async : false,
							dataType : "json",
							data : {
								ROW_NO: JSON.stringify(save_datas)
							},
							success : function(data) {
								console.log(data);
								swalSuccessCB(( exec === "CF" ? "승인" : "승인취소" ) + " 완료되었습니다.", function(){
									$("#search_btn").trigger("click");
								});
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
								swalDangerCB(( exec === "CF" ? "승인" : "승인취소" ) + " 실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
					}
				});
			}
		});
		<c:if test="${P_RESPONSE_VIEW eq 'Y'}">
		$("#search_btn").trigger("click");
		</c:if>
	});
	
	/* 팝업 */
	function fnSearchPopup(type, target) {
		var w;
		if (type == "1") {
			w = window.open("/yp/popup/zcs/ctr/select_working_master_v", "업체 검색", "width=600, height=800");
		}else if(type == "2"){
			w = window.open("","계약명 검색","width=600,height=800,scrollbars=yes");
			// 지급기준별 조회 조건 추가 - {1:공수, 2: 작업, 3: 월정액} 
			fnHrefPopup("/yp/popup/zcs/ctr/retrieveContarctName", "계약명 검색", {
				PAY_STANDARD : "3"
			});
		}else if (type == "3") {
			w = window.open("", "SAP 오더 검색", "width=900, height=800, scrollbars=yes");
			fnHrefPopup("/yp/popup/zcs/ipt/sapPop", "SAP 오더 검색", {
				target : target,
			});
		}
	}
	
	/* 팝업 submit */
	function fnHrefPopup(url, target, pr) {
		//20191023_khj for csrf
		var csrf_element = document.createElement("input");
		csrf_element.name = "_csrf";
		csrf_element.value = "${_csrf.token}";
		csrf_element.type = "hidden";
		//20191023_khj for csrf
		var popForm = document.createElement("form");

		popForm.name = "popForm";
		popForm.method = "post";
		popForm.target = target;
		popForm.action = url;

		document.body.appendChild(popForm);

		popForm.appendChild(csrf_element);

		$.each(pr, function(k, v) {
			// 				console.log(k, v);
			var el = document.createElement("input");
			el.name = k;
			el.value = v;
			el.type = "hidden";
			popForm.appendChild(el);
		});

		popForm.submit();
		popForm.remove();
	}

	function fnValidation_limit(msg){
		if(typeof target_contract_code === "undefined"){
			swalWarningCB("【" + msg + "】할 항목이 없습니다.");
			return false;
		}
		save_datas = new Array();
		$(".data-base input.rows-checkbox:checked").each(function(i, obj){
			save_datas.push({
				CONTRACT_CODE : $(obj).attr("CONTRACT_CODE"),
				VENDOR_CODE : $(obj).attr("VENDOR_CODE"),
				ORDER_NUMBER : $(obj).attr("ORDER_NUMBER"),
				WORK_DT : $(obj).attr("WORK_DT"),
				DATA_TYPE : $(obj).attr("DATA_TYPE")
			});
		});
		if( save_datas.length === 0 ) {
			swalWarningCB("【" + msg + "】할 항목이 없습니다.");
			return false;
		}
		return true;
	}

	function fnValidation_confirm(msg){
		if( $(".data-base input.rows-checkbox:checked").length === 0 ){
			swalWarningCB("【" + msg + "】할 항목이 없습니다.");
			return false;
		}
		var check = true;
		save_datas = new Array();
		<%--
		// 전체 저장
		$(".data-base input.rows-checkbox").each(function(i, obj){
		// 선택 저장
		$(".data-base input.rows-checkbox:checked").each(function(i, obj){
		--%>
		var aprv_cnt = 0;
		// 선택 저장
		$(".data-base input.rows-checkbox:checked").each(function(i, obj){
// 			save_datas.push({
// 				CONTRACT_CODE : $(obj).attr("CONTRACT_CODE"),
// 				VENDOR_CODE : $(obj).attr("VENDOR_CODE"),
// 				ORDER_NUMBER : $(obj).attr("ORDER_NUMBER"),
// 				WORK_DT : $(obj).attr("WORK_DT"),
// 				DATA_TYPE : $(obj).attr("DATA_TYPE")
// 			});
			save_datas.push({
				CONTRACT_CODE : $(obj).attr("CONTRACT_CODE"),
				VENDOR_CODE : $(obj).attr("VENDOR_CODE"),
				ORDER_NUMBER : $(obj).attr("ORDER_NUMBER"),
				WORK_DT : $(obj).attr("WORK_DT"),
				DATA_TYPE : $(obj).attr("DATA_TYPE"),
				RELEASE_YN : $(obj).attr("RELEASE_YN"),
				MANHOUR : $(obj).attr("MANHOUR"),
				MANHOUR_CORRECTION : $(obj).attr("MANHOUR_CORRECTION"),
				MANHOUR_SUM : $(obj).attr("MANHOUR_SUM"),
				MEMO : $(obj).attr("MEMO")
			});
		});
		
		$.each(save_datas, function(i, d){
// 			console.log(i, d);
			if(d.VENDOR_CODE === ""){
				swalWarningCB("거래처를 선택하세요.");
				check = false;
				return false;
			}
			if(d.CONTRACT_CODE === ""){
				swalWarningCB("계약을 선택하세요.");
				check = false;
				return false;
			}
			if(d.ORDER_NUMBER === ""){
				swalWarningCB("SAP오더번호를 선택하세요.");
				check = false;
				return false;
			}
		});
		
		return check;
	}

	//테이블 초기화
	function tableInit() {
		//table tr 초기화
		$(".table tr:not(.tb-head)").remove();
	}
	
	function reflectManHour(obj) {
		// 변경된 보정값
		var calc = Number( $(obj).val().replace(/[^\d+(\.\d{1,2})$]/g, '') ).toFixed(2);
		
		// 변경한 행의 공수, 보정, 합계 계산
		var prev = $(obj).parent().prev().children();
		var next = $(obj).parent().next().children();
		var mc = Number( calc ).toFixed(2);
		var ms = ( Number( calc ) + Number( $(prev).val() ) ).toFixed(2);
		
		$(obj).val( mc );
		$(next).val( ms );
		
		// 합계, 차이 부분 계산
		reflectFooter();
		
		// 저장 데이터 반영
		var rows_no = $(obj).data("rn");
		$(".data-base .rows-checkbox.rows-no-" + rows_no).attr("MANHOUR_CORRECTION", mc);
		$(".data-base .rows-checkbox.rows-no-" + rows_no).attr("MANHOUR_SUM", ms);
	}
	
	function reflectCommon(obj, gb) {
		// 변경된 값
		var d = $(obj).val();
		// 반영대상 행
		var rows_no = $(obj).data("rn");
		
		var rt = false;
		if("WORK_START_TIME" === gb){
			var timeFormat = /^([01][0-9]|2[0-3])([0-5][0-9])([0-5][0-9])$/; // 시간형식 체크 정규화 HH24:MI:SS
			rt = timeFormat.test(d);
		}else if("WORK_END_TIME" === gb){
			var timeFormat = /^([01][0-9]|2[0-3])([0-5][0-9])([0-5][0-9])$/; // 시간형식 체크 정규화 HH24:MI:SS
			rt = timeFormat.test(d);
		}else{
			rt = true;
		}
		if(!rt){
			alert("시간을 정확히 입력하세요.");
			$(obj).val("").focus();
			return false;
		}
		$(".data-base .rows-checkbox.rows-no-" + rows_no).attr(gb, d);
		
		
	}
	
	function reflectFooter() {
		// 공수합계 계산
		var addition_col2 = 0;
		var addition_col3 = 0;
		$('.data.data-col-2').each(function(i, d){
			addition_col2 += Number( $(d).val() );
		});
		$('.sub1.data-col-2').val(addition_col2.toFixed(2));
		
		$('.data.data-col-3').each(function(i, d){
			addition_col3 += Number( $(d).val() );
		});
		$('.sub1.data-col-3').val(addition_col3.toFixed(2));
		
		// 차이 계산
		var subtraction_3 = 0;
		$('.sub3.data-col-3').val( ( Number( $('.sub1.data-col-3').val() ) - Number( $('.sub2.data-col-3').val() ) ).toFixed(2) );
	}
	
	function batch_checkbox(obj) {
		$(".rows-checkbox").prop("checked", $(obj).is(":checked"));
	}
	
	/*콤마 추가*/
	function addComma(num) {
		return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}

	/*콤마 제거*/
	function unComma(num) {
		return num.replace(/,/gi, '');
	}

	function formatDate_y(date) {
		var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
		if (month.length < 2)
			month = '0' + month;
		if (day.length < 2)
			day = '0' + day;
		return [ year ].join('/');
	}

	function formatDate_m(date) {
		var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
		if (month.length < 2)
			month = '0' + month;
		if (day.length < 2)
			day = '0' + day;
		return [ year, month ].join('/');
	}

	function formatDate_d(date) {
		var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
		if (month.length < 2)
			month = '0' + month;
		if (day.length < 2)
			day = '0' + day;
		return [ year, month, day ].join('/');
	}
	
	/* 검수보고서 결재여부 확인 */
	function select_chk_enable_proc(){
		var result = false;
		if( $(".data-base .rows-checkbox").length === 0 ){
			swalWarningCB("데이터가 없습니다.");
			result = true;
		}
		// 결재완료, 진행중 항목 변경 불가
		// 여기에 추가
		return result;
	}
	
	// 확정(승인) 가능 여부 확인
	function fn_possible(rows){
		var rt = false;
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			url : "/yp/zcs/ipt2/possible",
			type : "POST",
			cache : false,
			async : false,
			dataType : "json",
			data : {
				  POSSIBLE : "A" /* C : 확정, A : 승인 */
				, ROW_NO: JSON.stringify(rows)
			},
			success : function(data) {
//					console.log("확정(승인) 가능 여부 확인", data);
				rt = data.possible;
				if( !data.possible ){
					swalWarningCB(data.possible_msg);
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
				swalDangerCB("승인/승인취소 가능 여부 확인【조회】실패하였습니다.\n관리자에게 문의해주세요.");
			}
		});
		return rt;
	}
	
// 	function fnSearchPopup(target){
// 		window.open("", "SAP 오더 검색", "width=900, height=800, scrollbars=yes");
// 		fnHrefPopup("/yp/popup/zcs/ipt/sapPop", "SAP 오더 검색", {
// 			target : idx,
// 		});
// 	}
	</script>
</body>