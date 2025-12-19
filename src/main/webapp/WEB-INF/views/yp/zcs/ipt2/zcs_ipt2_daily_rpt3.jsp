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
					<col width="11%" />
					<col width="5%" />
					<col width="11%" />
					<col width="5%" />
					<col width="11%" />
					<col width="5%" />
					<col width="11%" />
					<col width="5%" />
					<col width="11%" />
					<col width="5%" />
					<col width="11%" />
				</colgroup>
			<c:choose>
				<c:when test="${P_RESPONSE_VIEW eq 'Y'}">
				<tr>
					<th>일보일자</th>
					<td>
						<input type="text" id="WORK_DT" name="WORK_DT" class="calendar dtp_ymd" value="${P_WORK_DT}" readonly="readonly" onchange="javascript: flag_reset();"/>
					</td>
					<th>거래처</th>
					<td colspan="3">
						<input type="text" id="SAP_CODE" name="SAP_CODE" size="10" readonly="readonly" value="${P_ENT_CODE}" style="background-color: #e5e5e5;"/>
						<input type="hidden" id="VENDOR_CODE" name="VENDOR_CODE" size="10" value="${P_VENDOR_CODE}" onchange="javascript: flag_reset();" />
						<a href="#" onclick="fnSearchPopup('1');"><img src="/resources/yp/images/ic_search.png"></a>
						<input type="text" id="VENDOR_NAME" name="VENDOR_NAME" disabled="disabled"  style="width:200px;" value="${P_VENDOR_NAME}" />
					</td>
					<th>계약</th>
					<td colspan="3">
						<input type="text" id="CONTRACT_CODE" name="CONTRACT_CODE" size="10" value="${P_CONTRACT_CODE}" readonly="readonly" onchange="javascript: flag_reset();" />
						<a href="#" onclick="fnSearchPopup('2');"><img src="/resources/yp/images/ic_search.png"></a>
						<input type="text" id="CONTRACT_NAME" name="CONTRACT_NAME" disabled="disabled" value="${P_CONTRACT_NAME}" style="width:200px;"/>
					</td>
					<th>확정기한</th>
					<td>
						<input type="text" id="CONFIRM_REMAIN" name="CONFIRM_REMAIN" readonly="readonly" style="color: red;"/>
					</td>
				</tr>
				</c:when>
				<c:otherwise>
				<tr>
					<th>일보일자</th>
					<td>
						<input type="text" id="WORK_DT" name="WORK_DT" class="calendar dtp_ymd" value="${today}" readonly="readonly" onchange="javascript: flag_reset();"/>
					</td>
					<th>거래처</th>
					<td colspan="3">
						<input type="text" id="SAP_CODE" name="SAP_CODE" size="10" readonly="readonly" value="${ent_ent_code}" style="background-color: #e5e5e5;"/>
						<input type="hidden" id="VENDOR_CODE" name="VENDOR_CODE" size="10" value="${ent_vendor_code}" onchange="javascript: flag_reset();"/>
<!-- 							<a href="#" onclick="fnSearchPopup('1');"><img src="/resources/yp/images/ic_search.png"></a> -->
						<input type="text" id="VENDOR_NAME" name="VENDOR_NAME" disabled="disabled"  style="width:200px;" value="${ent_vendor_name}"/>
					</td>
					<th>계약</th>
					<td colspan="3">
						<input type="text" id="CONTRACT_CODE" name="CONTRACT_CODE" size="10" readonly="readonly" onchange="javascript: flag_reset();" />
						<a href="#" onclick="fnSearchPopup('2');"><img src="/resources/yp/images/ic_search.png"></a>
						<input type="text" id="CONTRACT_NAME" name="CONTRACT_NAME" disabled="disabled"  style="width:200px;"/>
					</td>
					<th>확정기한</th>
					<td>
						<input type="text" id="CONFIRM_REMAIN" name="CONFIRM_REMAIN" readonly="readonly" style="color: red;"/>
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
			<div>
				※　【시작시간】,【종료시간】은 여섯 자리 숫자로 입력하세요. 입력가능한 구간은 『000000 ~ 235959』입니다.
			</div>
			<div>
				※　【체크박스】에 선택된 항목이 【삭제, 저장, 확정, 확정취소】처리 대상입니다.
			</div>
		</div>
		<div class="fr">
			<div class="btn_wrap" style="margin-bottom:5px;">
				<input type="button" class="btn_g" id="add" value="　추가　"/>
				<input type="button" class="btn_g" id="remove" value="　삭제　"/>
				<input type="button" class="btn_g" id="save" value="　저장　"/>
				<input type="button" class="btn_g" id="btn_confirm" value="　확정　" data-exec="CF"/>
				<input type="button" class="btn_g" id="btn_cancel" value="확정취소" data-exec="CC"/>
			</div>
		</div>
	</div>
	<section class="section">
		<div class="tbl_box" style="background: none;">
			<table border="1" class="table">
				<tr class="tb-head data-head">
					<td style="color: white; width: 33px;"><input type="checkbox" style="zoom: 1.5;" class="all-check" onchange="javascript: batch_checkbox(this);"></td>
					<td style="color: white; width: 50px;">저장<br>여부</td>
					<td style="color: white; width: 50px;">확정<br>여부</td>
					<td style="color: white; width: 80px;">년</td>
					<td style="color: white; width: 50px;">월</td>
					<td style="color: white; width: 50px;">일</td>
					<td style="color: white; width: 80px;">작업<br>시작시간</td>
					<td style="color: white; width: 80px;">작업<br>종료시간</td>
					<%-- 2022-01-04 jamerl - 돌발작업 로직 추가 --%>
					<td style="color: white; width: 100px;">코스트<br>센터</td>
					<td style="color: white; width: 100px;">코스트<br>센터명</td>
					<td style="color: white;">작업내역</td>
					<td style="color: white; width: 120px;">SAP<br>오더번호</td>
					<td style="color: white; width: 100px;">공수<br>(M/D)</td>
					<td style="color: white; width: 100px;">보정</td>
					<td style="color: white; width: 100px;">계</td>
					<td style="color: white; width: 200px;">비고</td>
				</tr>
				<tr class="data-rpt"><td class="center vertical-center" colspan="16">데이터가 없습니다.</td></tr>
			</table>
		</div>
	</section>
	<script type="text/javascript">
	var save_datas = new Array();
	var target_contract_code, target_vendor_code, target_work_dt;
	function flag_reset(){
		target_contract_code = "";
	}
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
				url : "/yp/zcs/ipt2/select_zcs_ipt2_daily_rpt3",
				type : "POST",
				cache : false,
				async : true,
				dataType : "json",
				data : data, //폼을 그리드 파라메터로 전송
				success : function(data) {
//					console.log("확정기한", data.remain);
					$("#CONFIRM_REMAIN").val(data.remain.remain_time);
					
					//테이블 초기화
					tableInit();
					
					var innerHtml = '';
					var manhour = 0;
					var manhour_correction = 0;
					var manhour_sum = 0;
					
					var result1 = data.list1;
					
					if(result1.length === 0){
						innerHtml = '<tr class="data-rpt"><td class="center vertical-center" colspan="16">데이터가 없습니다.</td></tr>';
						$('.table').append(innerHtml);
						return false;
					}
					
					$.each(result1, function(i, d){
						innerHtml += '<tr class="data-base" data-rn="' + ( i + 1 ) + '" ' + ( d.DATA_TYPE === "M" ? ' style="background-color: lightpink;"' : '' ) + '>';
						innerHtml += '	<td class="center vertical-center"	style="width: 33px;">';
						innerHtml += '		<input type="checkbox" class="rows-checkbox rows-no-' + i + '" data-rn="' + ( i + 1 ) + '" style="zoom: 1.5;"';
						innerHtml += '			DBYN="' + d.DBYN + '"';
						innerHtml += '			DATA_TYPE="' + d.DATA_TYPE + '"';
						innerHtml += '			RELEASE_YN="' + d.RELEASE_YN + '"';
						innerHtml += '			CONTRACT_CODE="' + d.CONTRACT_CODE + '"';
						innerHtml += '			VENDOR_CODE="' + d.VENDOR_CODE + '"';
						innerHtml += '			ORDER_NUMBER="' + d.ORDER_NUMBER + '"';
						innerHtml += '			WORK_DT="' + d.WORK_DT + '"';
						innerHtml += '			WORK_CONTENTS="' + d.WORK_CONTENTS + '"';
						<%-- 2022-01-04 jamerl - 돌발작업 로직 추가 --%>
						innerHtml += '			OLD_ORDER_NUMBER="' + d.ORDER_NUMBER + '"';
						innerHtml += '			UNEXPECTED_YN="' + ( d.COST_CODE === null ? 'Y' : 'N' ) + '"';
						innerHtml += '			COST_CODE="' + ( d.COST_CODE === null ? '' : d.COST_CODE ) + '"';
						innerHtml += '			COST_NAME="' + ( d.COST_NAME === null ? '' : d.COST_NAME ) + '"';
						innerHtml += '			WORK_START_DT="' + d.WORK_START_DT + '"';
						innerHtml += '			WORK_START_TIME="' + d.WORK_START_TIME + '"';
						innerHtml += '			WORK_END_DT="' + d.WORK_END_DT + '"';
						innerHtml += '			WORK_END_TIME="' + d.WORK_END_TIME + '"';
						innerHtml += '			MANHOUR="' + d.MANHOUR + '"';
						innerHtml += '			MANHOUR_CORRECTION="' + d.MANHOUR_CORRECTION + '"';
						innerHtml += '			MANHOUR_SUM="' + d.MANHOUR_SUM + '"';
						innerHtml += '			MEMO="' + ( isEmpty( d.MEMO ) ? '' : d.MEMO ) + '"';
						innerHtml += '			CONFIRM_YN="' + ( isEmpty( d.CONFIRM_YN ) ? '' : d.CONFIRM_YN ) + '"';
						innerHtml += '			APRV_YN="' + ( isEmpty( d.APRV_YN ) ? '' : d.APRV_YN ) + '"';
						innerHtml += '		/>';
						innerHtml += '	</td>';
						innerHtml += '	<td class="center vertical-center"	style="width: 50px;"><div style="padding: 4px 3px;">' + ( d.DBYN === "Y" ? "○" : "&nbsp;" ) + '</div></td>';
						innerHtml += '	<td class="center vertical-center"	style="width: 50px;"><div style="padding: 4px 3px;">' + ( d.CONFIRM_YN === "Y" ? "○" : "&nbsp;" ) + '</div></td>';
						innerHtml += '	<td class="center vertical-center"	style="width: 80px;"><div style="padding: 4px 3px;">' + d.VIEW_Y + '</div></td>';
						innerHtml += '	<td class="center vertical-center"	style="width: 50px;"><div style="padding: 4px 3px;">' + d.VIEW_M + '</div></td>';
						innerHtml += '	<td class="center vertical-center"	style="width: 50px;"><div style="padding: 4px 3px;">' + d.VIEW_D + '</div></td>';
// 						innerHtml += '	<td class="center vertical-center"	style="width: 80px;"><div style="padding: 4px 3px;">' + d.WORK_START_TIME + '</div></td>';
// 						innerHtml += '	<td class="center vertical-center"	style="width: 80px;"><div style="padding: 4px 3px;">' + d.WORK_END_TIME + '</div></td>';
// 						innerHtml += '	<td class="center vertical-center"	style="width: 80px;"><div style="padding: 4px 3px;">' + d.COST_CODE + '</div></td>';
// 						innerHtml += '	<td class="center vertical-center"	style="width: 100px;"><div style="padding: 4px 3px;">' + d.COST_NAME + '</div></td>';
// 						innerHtml += '	<td class="left vertical-center"	><div style="padding: 4px 3px;">' + d.WORK_CONTENTS + '</div></td>';
// 						innerHtml += '	<td class="center vertical-center"	style="width: 120px;"><div style="padding: 4px 3px;">' + d.ORDER_NUMBER + '</div></td>';
// 						innerHtml += '	<td class="right vertical-center"	style="width: 100px;"><input type="number" value="' + d.MANHOUR +				'" data-rn="' + i + '" class="data-col-1 data" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
						if( d.CONFIRM_YN !== "Y" && d.DATA_TYPE === "M" ) {
							// 미확정, 추가 데이터는 월보 수정 가능
							innerHtml += '	<td class="center vertical-center"	style="width: 80px;">	<input type="text"	value="' + d.WORK_START_TIME.replace(/\:/gi, '') + '" data-rn="' + i + '" onchange="javascript: reflectCommon(this, \'WORK_START_TIME\');" style="width: 100%; text-indent: 0;"/></td>';
							innerHtml += '	<td class="center vertical-center"	style="width: 80px;">	<input type="text"	value="' + d.WORK_END_TIME.replace(/\:/gi, '') + '" data-rn="' + i + '" onchange="javascript: reflectCommon(this, \'WORK_END_TIME\');" style="width: 100%; text-indent: 0;"/></td>';
							innerHtml += '	<td class="center vertical-center"	style="width: 80px;"><div style="padding: 4px 3px;">' + d.COST_CODE + '</div></td>';
							innerHtml += '	<td class="center vertical-center"	style="width: 100px;"><div style="padding: 4px 3px;">' + d.COST_NAME + '</div></td>';
							innerHtml += '	<td class="left vertical-center"	><div style="padding: 4px 3px;">' + d.WORK_CONTENTS + '</div></td>';
							innerHtml += '	<td class="center vertical-center"	style="width: 100px;"><div style="padding: 4px 3px;">' + d.ORDER_NUMBER + '</div></td>';
							innerHtml += '	<td class="right vertical-center"	style="width: 100px;"><input type="number" value="' + d.MANHOUR +				'" data-rn="' + i + '" class="data-col-1 data" step="0.01" onchange="javascript: reflectManHour(this);" style="width: 100%; text-align: right;"/></td>';
						} else {
							innerHtml += '	<td class="center vertical-center"	style="width: 80px;"><div style="padding: 4px 3px;">' + d.WORK_START_TIME + '</div></td>';
							innerHtml += '	<td class="center vertical-center"	style="width: 80px;"><div style="padding: 4px 3px;">' + d.WORK_END_TIME + '</div></td>';
							<%-- 2022-01-04 jamerl - 돌발작업 로직 추가 --%>
							if( d.COST_CODE === null ){
								innerHtml += '	<td class="left vertical-center"	style="width: 80px;"><input type="text" class="cost_code rows-no-' + i + '" data-rn="' + i + '" value="" style="width: 100%; text-indent: 0;" readonly="readonly"/></td>';
								innerHtml += '	<td class="left vertical-center"	style="width: 100px;"><input type="text" class="cost_name rows-no-' + i + '" data-rn="' + i + '" value="" style="width: 100%;" readonly="readonly"/></td>';
								innerHtml += '	<td class="left vertical-center"	>					  <input type="text" class="work_contents rows-no-' + i + '" data-rn="' + i + '" value="' + d.WORK_CONTENTS + '" style="width: 100%;" readonly="readonly"/></td>';
								innerHtml += '	<td class="left vertical-center"	style="width: 100px;"><input type="text" class="order_number rows-no-' + i + '" data-rn="' + i + '" value="' + d.ORDER_NUMBER + '" style="width: calc( 100% - 27px ); text-indent: 0;" readonly="readonly"/>';
								innerHtml += '		<a href="#" onclick="fnSearchPopup(\'3\', ' + i + ', \'unexpected\');"><img src="/resources/yp/images/ic_search.png"></a>';
								innerHtml += '	</td>';
							} else {
								innerHtml += '	<td class="center vertical-center"	style="width: 80px;"><div style="padding: 4px 3px;">' + d.COST_CODE + '</div></td>';
								innerHtml += '	<td class="center vertical-center"	style="width: 100px;"><div style="padding: 4px 3px;">' + d.COST_NAME + '</div></td>';
								innerHtml += '	<td class="left vertical-center"	><div style="padding: 4px 3px;">' + d.WORK_CONTENTS + '</div></td>';
								innerHtml += '	<td class="center vertical-center"	style="width: 100px;"><div style="padding: 4px 3px;">' + d.ORDER_NUMBER + '</div></td>';
							}
							innerHtml += '	<td class="right vertical-center"	style="width: 100px;"><input type="number" value="' + d.MANHOUR +				'" data-rn="' + i + '" class="data-col-1 data" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
						}
						innerHtml += '	<td class="right vertical-center"	style="width: 100px;"><input type="number" value="' + d.MANHOUR_CORRECTION +	'" data-rn="' + i + '" class="data-col-2 data" step="0.01" readonly="readonly" onchange="javascript: reflectManHour(this);" style="width: 100%; text-align: right;"/></td>';
						innerHtml += '	<td class="right vertical-center"	style="width: 100px;"><input type="number" value="' + d.MANHOUR_SUM +			'" data-rn="' + i + '" class="data-col-3 data" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
						innerHtml += '	<td class="right vertical-center"	style="width: 200px;"><input type="text" data-rn="' + i + '" onchange="javascript: reflectCommon(this, \'MEMO\');" value="' + ( isEmpty( d.MEMO ) ? '' : d.MEMO ) + '" readonly="readonly" style="width: 100%;"/></td>';
						innerHtml += '</tr>';
						manhour += Number( d.MANHOUR );
						manhour_correction += Number( d.MANHOUR_CORRECTION );
						manhour_sum += Number( d.MANHOUR_SUM );
					});
// 					console.log("manhour", manhour);
// 					console.log("manhour_correction", manhour_correction);
// 					console.log("manhour_sum", manhour_sum);
					innerHtml += '<tr>';
					innerHtml += '	<td class="center vertical-center" colspan="12"><div style="padding: 4px 3px;">공수합계</div></td>';
					innerHtml += '	<td class="right vertical-center"><input type="number" value="' + manhour.toFixed(2) +				'" class="data-col-1 sub1" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
					innerHtml += '	<td class="right vertical-center"><input type="number" value="' + manhour_correction.toFixed(2) +	'" class="data-col-2 sub1" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
					innerHtml += '	<td class="right vertical-center"><input type="number" value="' + manhour_sum.toFixed(2) +			'" class="data-col-3 sub1" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
					innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">&nbsp;</div></td>';
					innerHtml += '</tr>';
					
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
		
		/* 한줄 추가 */
		$("#add").on("click", function() {
// 			if( select_chk_enable_proc() ){
// 				return false;
// 			}
			// 2022-01-04 jamerl - 최승빈 : 조회후 작업가능
			if(typeof target_contract_code === "undefined" || target_contract_code === ""){
				swalWarningCB("조회후 작업할 수 있습니다.");
				return false;
			}
			
			var innerHtml = '';
			innerHtml += '<tr class="data-base" data-rn="' + ( $(".data-base:last").data("rn") + 1 ) + '" style="background-color: lightpink;">';
			innerHtml += '	<td class="center vertical-center"	style="width: 33px;">';
			innerHtml += '		<input type="checkbox" class="rows-checkbox rows-no-' + ( $(".data-base:last").data("rn") + 1 ) + '" data-rn="' + ( $(".data-base:last").data("rn") + 1 ) + '" style="zoom: 1.5;"';
			innerHtml += '			DBYN="N"';
			innerHtml += '			DATA_TYPE="M"';
			innerHtml += '			RELEASE_YN="N"';
			innerHtml += '			CONTRACT_CODE="' + target_contract_code + '" ';
			innerHtml += '			VENDOR_CODE="' + target_vendor_code + '" ';
			innerHtml += '			ORDER_NUMBER="" ';
			innerHtml += '			WORK_DT="' + target_work_dt.replace(/\//gi, '') + '" ';
			innerHtml += '			WORK_CONTENTS="" ';
			innerHtml += '			COST_CODE="" ';
			innerHtml += '			COST_NAME="" ';
			innerHtml += '			WORK_START_DT="' + target_work_dt + '" ';
			innerHtml += '			WORK_START_TIME="" ';
			innerHtml += '			WORK_END_DT="' + target_work_dt + '" ';
			innerHtml += '			WORK_END_TIME="" ';
			innerHtml += '			MANHOUR="0" ';
			innerHtml += '			MANHOUR_CORRECTION="0" ';
			innerHtml += '			MANHOUR_SUM="0" ';
			innerHtml += '			MEMO="" ';
			innerHtml += '			CONFIRM_YN="" ';
			innerHtml += '			APRV_YN="" ';
			innerHtml += '		/>';
			innerHtml += '	</td>';
			innerHtml += '	<td class="center vertical-center"	style="width: 50px;"></td>';
			innerHtml += '	<td class="center vertical-center"	style="width: 50px;"></td>';
			innerHtml += '	<td class="center vertical-center"	style="width: 80px;">	' + target_work_dt.replace(/\//gi, '').substring(0, 4) + '</td>';
			innerHtml += '	<td class="center vertical-center"	style="width: 50px;">	' + target_work_dt.replace(/\//gi, '').substring(4, 6) + '</td>';
			innerHtml += '	<td class="center vertical-center"	style="width: 50px;">	' + target_work_dt.replace(/\//gi, '').substring(6, 8) + '</td>';
			innerHtml += '	<td class="center vertical-center"	style="width: 80px;">	<input type="text"	value="" data-rn="' + ( $(".data-base:last").data("rn") + 1 ) + '" onchange="javascript: reflectCommon(this, \'WORK_START_TIME\');" style="width: 100%;"/></td>';
			innerHtml += '	<td class="center vertical-center"	style="width: 80px;">	<input type="text"	value="" data-rn="' + ( $(".data-base:last").data("rn") + 1 ) + '" onchange="javascript: reflectCommon(this, \'WORK_END_TIME\');" style="width: 100%;"/></td>';
			innerHtml += '	<td class="left vertical-center"	style="width: 80px;">	<input type="text"	class="rows-no-' + ( $(".data-base:last").data("rn") + 1 ) + ' cost_code" value="" style="width: 100%;" readonly="readonly"/></td>';
			innerHtml += '	<td class="left vertical-center"	style="width: 100px;">	<input type="text"	class="rows-no-' + ( $(".data-base:last").data("rn") + 1 ) + ' cost_name" value="" style="width: 100%;" readonly="readonly"/></td>';
			innerHtml += '	<td class="left vertical-center"	>						<input type="text"	class="rows-no-' + ( $(".data-base:last").data("rn") + 1 ) + ' work_contents" value="" style="width: 100%;" readonly="readonly"/></td>';
			innerHtml += '	<td class="left vertical-center"	style="width: 100px;">';
			innerHtml += '		<input type="text"															class="rows-no-' + ( $(".data-base:last").data("rn") + 1 ) + ' order_number" value="" style="width: calc( 100% - 27px );" readonly="readonly"/>';
			innerHtml += '		<a href="#" onclick="fnSearchPopup(\'3\', ' + ( $(".data-base:last").data("rn") + 1 ) + ');"><img src="/resources/yp/images/ic_search.png"></a>';
			innerHtml += '	</td>';
// 			innerHtml += '	<td class="right vertical-center"	style="width: 100px;">	<input type="number" value="0" data-rn="' + ( $(".data-base:last").data("rn") + 1 ) + '" class="data-col-1 data" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
// 			innerHtml += '	<td class="right vertical-center"	style="width: 100px;">	<input type="number" value="0" data-rn="' + ( $(".data-base:last").data("rn") + 1 ) + '" class="data-col-2 data" step="0.01" onchange="javascript: reflectManHour(this);" style="width: 100%; text-align: right;"/></td>';
			innerHtml += '	<td class="right vertical-center"	style="width: 100px;">	<input type="number" value="0" data-rn="' + ( $(".data-base:last").data("rn") + 1 ) + '" class="data-col-1 data" step="0.01" onchange="javascript: reflectManHour(this);" style="width: 100%; text-align: right;"/></td>';
			innerHtml += '	<td class="right vertical-center"	style="width: 100px;">	<input type="number" value="0" data-rn="' + ( $(".data-base:last").data("rn") + 1 ) + '" class="data-col-2 data" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
			innerHtml += '	<td class="right vertical-center"	style="width: 100px;">	<input type="number" value="0" data-rn="' + ( $(".data-base:last").data("rn") + 1 ) + '" class="data-col-3 data" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
			innerHtml += '	<td class="right vertical-center"	style="width: 200px;">	<input type="text" value="" data-rn="' + ( $(".data-base:last").data("rn") + 1 ) + '" onchange="javascript: reflectCommon(this, \'MEMO\');" style="width: 100%;"/></td>';
			innerHtml += '</tr>';
			if($(".data-base").length === 0){
				$(".data-rpt").remove();
				$(".data-head").after(innerHtml);
			}else{
				$(".data-base:last").after(innerHtml);
			}
		});
		
		/* 한줄 삭제 */
		$("#remove").on("click", function() {
// 			if( select_chk_enable_proc() ){
// 				return false;
// 			}
			// 2022-01-04 jamerl - 최승빈 : 조회후 작업가능
			if(typeof target_contract_code === "undefined" || target_contract_code === ""){
				swalWarningCB("조회후 작업할 수 있습니다.");
				return false;
			}
			if( $(".data-base input.rows-checkbox:checked").length === 0 ){
				swalWarningCB("삭제할 항목을 선택하세요.");
				return false;
			}
			
			// 추가행 삭제 대상
			var remove_datas = new Array();
			// DB 삭제 대상
			var delete_datas = new Array();
			var aprv_cnt = 0;
			$(".data-base input.rows-checkbox:checked").each(function(i, obj){
				if( $(obj).attr("DBYN") === "Y" ){
					// 승인된 항목 변경 불가
					// 여기에 추가
					if($(obj).attr("APRV_YN") === "Y"){
						aprv_cnt++;
					}
					delete_datas.push({
						CONTRACT_CODE : $(obj).attr("CONTRACT_CODE"),
						VENDOR_CODE : $(obj).attr("VENDOR_CODE"),
						ORDER_NUMBER : $(obj).attr("ORDER_NUMBER"),
						WORK_DT : $(obj).attr("WORK_DT"),
						DATA_TYPE : $(obj).attr("DATA_TYPE")
					});
				}else if( $(obj).attr("DBYN") === "N" && $(obj).attr("DATA_TYPE") === "M" ){
					remove_datas.push({
						SEQ : $(obj).data("rn")
					});
				}
			});
			if( aprv_cnt > 0 ){
				delete_datas = new Array();
				remove_datas = new Array();
				swalWarningCB("승인된 항목은 【삭제】할 수 없습니다.");
				return false;
			}
			// 추가 대상과 삭제 대상 모두 없으면 종료
			if( delete_datas.length === 0 && remove_datas.length === 0 ){
				return false;
			}
			// DB 삭제 대상 없으면 종료
			if( delete_datas.length === 0 && remove_datas.length > 0 ){
				$("#search_btn").trigger("click");
				return false;
			}
			
			// DB 삭제
			swal({
				icon : "info",
				text : "【삭제】하시겠습니까?",
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
					// 추가행 삭제
					$.each(remove_datas, function(i, d){
						$(".data-base[data-rn=" + d.SEQ + "]").remove();
					});
					<%--
					$.each(delete_datas, function(i, d){
						$(".data-base[data-rn=" + d.SEQ + "]").remove();
					});
					--%>
					
					// 합계, 차이 부분 계산
					reflectFooter();
					
					if( delete_datas.length > 0 ){
						<%--
						// 하단 대상
						var commute_datas = new Array();
						commute_datas.push({
							BASE_YYYYMM : delete_datas[0].BASE_YYYYMM,
							VENDOR_CODE : delete_datas[0].VENDOR_CODE,
							CONTRACT_CODE : delete_datas[0].CONTRACT_CODE,
							COMMUTE : $(".data-commute .sub2.data-col-1").val(),
							COMMUTE_CORRECTION : $(".data-commute .sub2.data-col-2").val(),
							COMMUTE_SUM : $(".data-commute .sub2.data-col-3").val(),
							SUBTRACTION : $(".data-commute .sub3.data-col-3").val()
						});
						--%>
						var token = $("meta[name='_csrf']").attr("content");
						var header = $("meta[name='_csrf_header']").attr("content");
						$.ajax({
							url : "/yp/zcs/ipt2/delete_zcs_ipt2_daily_rpt3",
							type : "POST",
							cache : false,
							async : false,
							dataType : "json",
							data : {
								ROW_NO: JSON.stringify(delete_datas)
							},
							success : function(result) {
								swalSuccessCB("삭제 되었습니다.", function(){
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
								swalDangerCB("삭제에 실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
					}
					if( remove_datas.length > 0 ){
						$("#search_btn").trigger("click");
					}
				}
			});
		});
		
		/* 저장 */
		$("#save").on("click", function() {
// 			if( select_chk_enable_proc() ){
// 				return false;
// 			}
			// 2022-01-04 jamerl - 최승빈 : 조회후 작업가능
			if(typeof target_contract_code === "undefined" || target_contract_code === ""){
				swalWarningCB("조회후 작업할 수 있습니다.");
				return false;
			}
			
			if(fnValidation()){
				swal({
					icon : "info",
					text : "【저장】하시겠습니까?",
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
							url : "/yp/zcs/ipt2/merge_zcs_ipt2_daily_rpt3",
							type : "POST",
							cache : false,
							async : false,
							dataType : "json",
							data : {
								ROW_NO: JSON.stringify(save_datas)
							},
							success : function(data) {
								console.log(data);
								swalSuccessCB("저장 완료되었습니다.", function(){
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
								swalDangerCB("저장 실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
					}
				});
			}
		});
		
		/* 확정 */
		$("#btn_confirm, #btn_cancel").on("click", function() {
// 			if( select_chk_enable_proc() ){
// 				return false;
// 			}
			// 2022-01-04 jamerl - 최승빈 : 조회후 작업가능
			if(typeof target_contract_code === "undefined" || target_contract_code === ""){
				swalWarningCB("조회후 작업할 수 있습니다.");
				return false;
			}
			var exec = $(this).data("exec");
			if(fnValidation_confirm( ( exec === "CF" ? "확정" : "확정취소" ) )){

				// 확정(승인) 가능 여부 확인
				if( !fn_possible(save_datas) ){
					return false;
				}

				swal({
					icon : "info",
					text : "【" + ( exec === "CF" ? "확정" : "확정취소" ) + "】하시겠습니까?",
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
							url : ( exec === "CF" ? "/yp/zcs/ipt2/update_confirm_zcs_ipt2_daily_rpt3" : "/yp/zcs/ipt2/update_cancel_zcs_ipt2_daily_rpt3" ),
							type : "POST",
							cache : false,
							async : false,
							dataType : "json",
							data : {
								ROW_NO: JSON.stringify(save_datas)
							},
							success : function(data) {
								console.log(data);
								swalSuccessCB(( exec === "CF" ? "확정" : "확정취소" ) + " 완료되었습니다.", function(){
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
								swalDangerCB(( exec === "CF" ? "확정" : "확정취소" ) + " 실패하였습니다.\n관리자에게 문의해주세요.");
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
	function fnSearchPopup(type, target, type2) {
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
				<%-- 2022-01-04 jamerl - 돌발작업 로직 추가 --%>
				target_gubun2 : type2
			});
		} else if (type == "4") {
			<%-- 2022-01-04 jamerl - 돌발작업 로직 추가(코스트센터 검색 미사용) --%>
			w = window.open("", "코스트센터 검색", "width=600, height=800");
			fnHrefPopup("/yp/popup/zwc/ctr/retrieveKOSTL", "코스트센터 검색", {
				target : target,
				type : 'CT'
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

	function fnValidation(rows){
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
			// 승인된 항목 변경 불가
			// 여기에 추가
			if($(obj).attr("APRV_YN") === "Y"){
				aprv_cnt++;
				return false;
			}
			save_datas.push({
				CONTRACT_CODE : $(obj).attr("DBYN") === "Y" ? $(obj).attr("CONTRACT_CODE") : $("#CONTRACT_CODE").val().trim(),
				VENDOR_CODE : $(obj).attr("DBYN") === "Y" ? $(obj).attr("VENDOR_CODE") : $("#VENDOR_CODE").val().trim(),
				ORDER_NUMBER : $(obj).attr("ORDER_NUMBER"),
				<%-- 2022-01-04 jamerl - 돌발작업 로직 추가 --%>
				OLD_ORDER_NUMBER : $(obj).attr("OLD_ORDER_NUMBER"),
				UNEXPECTED_YN : $(obj).attr("UNEXPECTED_YN"),
				VENDOR_NAME : $("#VENDOR_NAME").val().trim(),
				WORK_DT : $(obj).attr("WORK_DT"),
				DATA_TYPE : $(obj).attr("DATA_TYPE"),
				DBYN : $(obj).attr("DBYN"),
				WORK_CONTENTS : $(obj).attr("WORK_CONTENTS"),
				COST_CODE : $(obj).attr("COST_CODE"),
				COST_NAME : $(obj).attr("COST_NAME"),
				WORK_START_DT : $(obj).attr("WORK_START_DT"),
				WORK_START_TIME : $(obj).attr("WORK_START_TIME").replaceAll(":", "").replace(/(\d{2})(\d{2})(\d{2})/g, '$1:$2:$3'),
				WORK_END_DT : $(obj).attr("WORK_END_DT"),
				WORK_END_TIME : $(obj).attr("WORK_END_TIME").replaceAll(":", "").replace(/(\d{2})(\d{2})(\d{2})/g, '$1:$2:$3'),
				MANHOUR : $(obj).attr("MANHOUR"),
				MANHOUR_CORRECTION : $(obj).attr("MANHOUR_CORRECTION"),
				MANHOUR_SUM : $(obj).attr("MANHOUR_SUM"),
				MEMO : $(obj).attr("MEMO")
			});
		});
		if( aprv_cnt > 0 ){
			swalWarningCB("승인된 항목은 【저장】할 수 없습니다.");
			check = false;
			return false;
		}
		if( save_datas.length === 0 ){
			swalWarningCB("【저장】할 항목이 없습니다.");
			check = false;
			return false;
		}
		
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
			<%-- 2022-01-04 jamerl - 돌발작업 로직 추가 --%>
			if(d.COST_CODE === ""){
				swalWarningCB("코스트센터를 선택하세요.");
				check = false;
				return false;
			}
			if(d.WORK_START_TIME === ""){
				swalWarningCB("시작시간을 입력하세요.");
				check = false;
				return false;
			}
			if(d.WORK_END_TIME === ""){
				swalWarningCB("종료시간을 입력하세요.");
				check = false;
				return false;
			}
			if(isNaN( d.WORK_START_TIME.replaceAll(":", "") ) || isNaN( d.WORK_END_TIME.replaceAll(":", "") )){
				swalWarningCB("시간은 숫자만 입력하세요.");
				check = false;
				return false;
			}
			var tf = /^([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$/; // 시간형식 체크 정규화 HH24:MI:SS
			if(!tf.test(d.WORK_START_TIME)){
				swalWarningCB("시작시간 포멧을 확인하세요.");
				check = false;
				return false;
			}
			if(!tf.test(d.WORK_END_TIME)){
				swalWarningCB("종료시간 포멧을 확인하세요.");
				check = false;
				return false;
			}
		});
		
		return check;
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
		var cannot_save_cnt = 0;
		var aprv_cnt = 0;
		// 선택 저장
		$(".data-base input.rows-checkbox:checked").each(function(i, obj){
			if($(obj).attr("DBYN") !== "Y"){
				cannot_save_cnt++;
			}
			// 승인된 항목 변경 불가
			// 여기에 추가
// 			if($(obj).attr("APRV_YN") === "Y"){
// 				aprv_cnt++;
// 			}
			save_datas.push({
				CONTRACT_CODE : $(obj).attr("DBYN") === "Y" ? $(obj).attr("CONTRACT_CODE") : $("#CONTRACT_CODE").val().trim(),
				VENDOR_CODE : $(obj).attr("DBYN") === "Y" ? $(obj).attr("VENDOR_CODE") : $("#VENDOR_CODE").val().trim(),
				ORDER_NUMBER : $(obj).attr("ORDER_NUMBER"),
				WORK_DT : $(obj).attr("WORK_DT"),
				DATA_TYPE : $(obj).attr("DATA_TYPE"),
				RELEASE_YN : $(obj).attr("RELEASE_YN"),
				DBYN : $(obj).attr("DBYN"),
				WORK_CONTENTS : $(obj).attr("WORK_CONTENTS"),
				COST_CODE : $(obj).attr("COST_CODE"),
				COST_NAME : $(obj).attr("COST_NAME"),
				WORK_START_DT : $(obj).attr("WORK_START_DT"),
				WORK_START_TIME : $(obj).attr("WORK_START_TIME").replaceAll(":", "").replace(/(\d{2})(\d{2})(\d{2})/g, '$1:$2:$3'),
				WORK_END_DT : $(obj).attr("WORK_END_DT"),
				WORK_END_TIME : $(obj).attr("WORK_END_TIME").replaceAll(":", "").replace(/(\d{2})(\d{2})(\d{2})/g, '$1:$2:$3'),
				MANHOUR : $(obj).attr("MANHOUR"),
				MANHOUR_CORRECTION : $(obj).attr("MANHOUR_CORRECTION"),
				MANHOUR_SUM : $(obj).attr("MANHOUR_SUM"),
				MEMO : $(obj).attr("MEMO")
			});
		});
// 		if( aprv_cnt > 0 ){
// 			save_datas = new Array();
// 			swalWarningCB("승인된 항목은 【" + msg + "】할 수 없습니다.");
// 			check = false;
// 			return false;
// 		}
		if( cannot_save_cnt > 0 ){
			save_datas = new Array();
			swalWarningCB("저장되지 않은 항목이 선택되어 【" + msg + "】할 수 없습니다.");
			check = false;
			return false;
		}
		
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

		// 승인된 항목 변경 불가
		// 여기에 추가
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			url : "/yp/zcs/ipt2/pre_select_zcs_ipt2_daily_rpt3",
			type : "POST",
			cache : false,
			async : false,
			dataType : "json",
			data : {
				ROW_NO: JSON.stringify(save_datas)
			},
			success : function(data) {
// 				console.log(data);
				if(data.result > 0){
					swalWarningCB("승인된 항목은 【" + msg + "】할 수 없습니다.");
					check = false;
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
				swalDangerCB("【" + msg + "】실패하였습니다.\n관리자에게 문의해주세요.");
				check = false;
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
// 		var prev = $(obj).parent().prev().children();
// 		var next = $(obj).parent().next().children();
		var prev = $(obj).parent().next().children();
		var next = $(obj).parent().next().next().children();
		var mc = Number( calc ).toFixed(2);
		var ms = ( Number( calc ) + Number( $(prev).val() ) ).toFixed(2);
		
		$(obj).val( mc );
		$(next).val( ms );
		
		// 합계, 차이 부분 계산
		reflectFooter();
		
		// 저장 데이터 반영
		var rows_no = $(obj).data("rn");
// 		$(".data-base .rows-checkbox.rows-no-" + rows_no).attr("MANHOUR_CORRECTION", mc);
		$(".data-base .rows-checkbox.rows-no-" + rows_no).attr("MANHOUR", mc);
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
		$('.data.data-col-1').each(function(i, d){
			addition_col2 += Number( $(d).val() );
		});
		$('.sub1.data-col-1').val(addition_col2.toFixed(2));
		
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
				  POSSIBLE : "C" /* C : 확정, A : 승인 */
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
				swalDangerCB("확정/확정취소 가능 여부 확인【조회】실패하였습니다.\n관리자에게 문의해주세요.");
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