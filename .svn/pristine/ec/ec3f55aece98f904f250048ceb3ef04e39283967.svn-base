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
String to_yyyy = date.format(today);

Calendar cal = Calendar.getInstance();
cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.getActualMinimum(Calendar.DATE));
String from_yyyy = date.format(cal.getTime());

date = new SimpleDateFormat("yyyy/MM");
String base_yyyymm = date.format(today);

// JSTL에서 사용할 수 있도록 세팅
request.setAttribute("to_yyyy", to_yyyy);
request.setAttribute("from_yyyy", from_yyyy);
request.setAttribute("base_yyyymm", base_yyyymm);
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
	<!-- 엑셀업로드 insertQuery -->
	<input type='hidden' id='insertQuery' name='insertQuery' value='oracle.yp_zcs_ipt.create_construction_monthly_rpt3'>
	<section>
		<div class="tbl_box">
			<table class="contract_standard_table" cellspacing="0" cellpadding="0">
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
						<input type="text" name="SAP_CODE" id="SAP_CODE" size="10" readonly="readonly" style="background-color: #e5e5e5;"/>
						<input type="hidden" name="VENDOR_CODE" id="VENDOR_CODE" size="10"/>
						<a href="#" onclick="fnSearchPopup('1');"><img src="/resources/yp/images/ic_search.png"></a>
						<input type="text" name="VENDOR_NAME" id="VENDOR_NAME" disabled="disabled"  style="width:200px;"/>
					</td>
					<th>계약코드</th>
					<td>
						<input type="text" name="CONTRACT_CODE" id="CONTRACT_CODE" size="10"/>
						<a href="#" onclick="fnSearchPopup('2');"><img src="/resources/yp/images/ic_search.png"></a>
						<input type="text" name="CONTRACT_NAME" disabled="disabled"  style="width:200px;"/>
					</td>
					<th>일보기간</th>
					<td>
						<input type="text" id="WORK_DT_S" class="calendar dtp_ymd" value="${from_yyyy}" readonly="readonly"/>　~　
						<input type="text" id="WORK_DT_E" class="calendar dtp_ymd" value="${to_yyyy}" readonly="readonly"/>
					</td>
					<th>월보년월</th>
					<td>
						<c:choose>
							<c:when test="${not empty req_data.sdate}">
								<input type="text" style="cursor: pointer;" class="calendar dtp_ym" name="BASE_YYYYMM" id="BASE_YYYYMM" size="10" value="${req_data.sdate}"/>
							</c:when>
							<c:otherwise>
								<input type="text" style="cursor: pointer;" class="calendar dtp_ym" name="BASE_YYYYMM" id="BASE_YYYYMM" size="10" value="${base_yyyymm}"/>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</table>
			<div class="btn_wrap">
			<button class="btn btn_search" id="search_btn" type="button">조회</button>
		</div>
		</div>
	</section>
	
	<div class="float_wrap">
		<div class="fl">
			<div>
				※　일보승인에서 내용이 변경되어도 저장된 월보에는 반영되지 않습니다.
			</div>
			<div>
				※　반영하려면 월보를【삭제】삭제한 후, 일보승인를 조회, 월보를【저장】하여 반영할 수 있습니다.
			</div>
		</div>
		<div class="fr">
			<div class="btn_wrap" style="margin-bottom:5px;">
				<input type="button" class="btn_g" id="remove" value="삭제"/>
				<input type="button" class="btn_g" id="save" value="저장"/>
			</div>
		</div>
	</div>
	<section class="section">
		<div class="tbl_box" style="background: none;">
			<table border="1" class="table">
				<tr class="tb-head">
					<td style="color: white; width: 33px;"><input type="checkbox" style="zoom: 1.5; display: none;" class="all-check" onchange="javascript: batch_checkbox(this);"></td>
					<td style="color: white; width: 50px;">저장<br>여부</td>
					<td style="color: white; width: 160px;">SAP<br>오더번호</td>
					<td style="color: white; width: 10%;">코스트<br>센터</td>
					<td style="color: white;">작업내역</td>
					<td style="color: white; width: 130px;">시작일자</td>
					<td style="color: white; width: 80px;">시작시간</td>
					<td style="color: white; width: 130px;">종료일자</td>
					<td style="color: white; width: 80px;">종료시간</td>
					<td style="color: white; width: 100px;">공수<br>(M/D)</td>
					<td style="color: white; width: 100px;">보정</td>
					<td style="color: white; width: 100px;">계</td>
<!-- 					<td style="color: white; width: 200px;">비고</td> -->
				</tr>
				<tr style="background-color: white;">
					<td class="center vertical-center" colspan="12">데이터가 없습니다.</td>
<!-- 					<td class="center vertical-center" colspan="12">데이터가 없습니다.</td> -->
				</tr>
			</table>
		</div>
	</section>
	<script type="text/javascript">
		var save_datas = new Array();

		$(document).ready(function() {
			var param = {
				EXEC_RFC : "N", // RFC 여부
				cntQuery : "yp_zcs_ipt2.select_construction_monthly_rpt3_cnt",
				listQuery : "yp_zcs_ipt2.select_construction_monthly_rpt3"
			};

			$('input').on('keydown', function(event) {
				if (event.keyCode == 13)
					return false;
			});

			// 부트스트랩 날짜객체
			$(".dtp_ym").datepicker({
				format : "yyyy/mm",
				language : "ko",
				viewMode : "months",
				minViewMode : "months",
				todayHighlight : true,
				autoclose : true,
				clearBtn : true,
				updateViewDate : false
			}).on('changeDate', function(e) {
				if (e.viewMode !== "months") {
					return false;
				}
				$(this).val(formatDate_m(e.date.valueOf())).trigger("change");
				$('.datepicker').hide();
			});

			$(document).on("focus", ".dtp_ymd", function() {
				$(this).datepicker({
					format : "yyyy/mm/dd",
					language : "ko",
					todayHighlight : true,
					autoclose : true,
					clearBtn : true,
					updateViewDate : false
				}).on('changeDate', function(e) {
					if (e.viewMode !== "days") {
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
				if (isEmpty(VENDOR_CODE)) {
					swalWarningCB("거래처를 입력해주세요.");
					return false;
				}
				//계약코드 빈값체크
				var CONTRACT_CODE = $("#CONTRACT_CODE").val().trim();
				if (isEmpty(CONTRACT_CODE)) {
					swalWarningCB("계약코드를 입력해주세요.");
					return false;
				}
				// 시작일자
				var WORK_DT_S = $("#WORK_DT_S").val().trim();
				if (isEmpty(WORK_DT_S)) {
					swalWarningCB("시작일자를 입력해주세요.");
					return false;
				}
				// 종료일자
				var WORK_DT_E = $("#WORK_DT_E").val().trim();
				if (isEmpty(WORK_DT_E)) {
					swalWarningCB("종료일자를 입력해주세요.");
					return false;
				}
				// 월보년월
				var BASE_YYYYMM = $("#BASE_YYYYMM").val().trim();
				if (isEmpty(CONTRACT_CODE)) {
					swalWarningCB("월보년월를 입력해주세요.");
					return false;
				}
				var data = {
					'BASE_YYYYMM' : $("#BASE_YYYYMM").val().trim(),
					'VENDOR_CODE' : $("#VENDOR_CODE").val().trim(),
					'CONTRACT_CODE' : $("#CONTRACT_CODE").val().trim(),
					'WORK_DT_S' : $("#WORK_DT_S").val().trim(),
					'WORK_DT_E' : $("#WORK_DT_E").val().trim(),
					// 				'TEAM' : "성우공업사"
					'VENDOR_NAME' : $("#VENDOR_NAME").val().trim()
				};

				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					url : "/yp/zcs/ipt2/select_zcs_ipt2_month_rpt3",
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

						if (result1.length === 0) {
							innerHtml = '<tr><td class="center vertical-center" colspan="11">데이터가 없습니다.</td></tr>';
// 							innerHtml = '<tr><td class="center vertical-center" colspan="12">데이터가 없습니다.</td></tr>';
							$('.table').append(innerHtml);
							return false;
						}

						$.each(result1, function(i, d) {
							innerHtml += '<tr class="data-base" data-rn="' + (i + 1) + '">';
							innerHtml += '	<td class="center vertical-center"	style="width: 33px;">';
							innerHtml += '		<input type="checkbox" class="rows-checkbox rows-no-' + i + '" data-rn="' + (i + 1) + '" style="zoom: 1.5; display: none;"';
							innerHtml += '			DBYN="' + d.DBYN + '"';
							innerHtml += '			BASE_YYYYMM="' + d.BASE_YYYYMM + '"';
							innerHtml += '			VENDOR_CODE="' + d.VENDOR_CODE + '"';
							innerHtml += '			CONTRACT_CODE="' + d.CONTRACT_CODE + '"';
							innerHtml += '			SEQ="' + d.SEQ + '"';
							innerHtml += '			ORDER_NUMBER="' + d.ORDER_NUMBER + '"';
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
							innerHtml += '			MEMO="' + (isEmpty(d.MEMO) ? '' : d.MEMO) + '"';
							innerHtml += '			SECTION_START_DT="' + d.SECTION_START_DT + '"';
							innerHtml += '			SECTION_END_DT="' + d.SECTION_END_DT + '"';
							innerHtml += '		/>';
							innerHtml += '	</td>';
							innerHtml += '	<td class="center vertical-center"	style="width: 50px;"><div style="padding: 4px 3px;">' + ( d.DBYN === "Y" ? "○" : "&nbsp;" ) + '</div></td>';
							innerHtml += '	<td class="center vertical-center"	style="width: 160px;"><div style="padding: 4px 3px;">' + d.ORDER_NUMBER + '</div></td>';
							innerHtml += '	<td class="center vertical-center"	style="width: 10%;"><div style="padding: 4px 3px;">' + d.COST_NAME + '</div></td>';
							innerHtml += '	<td class="left vertical-center"	><div style="padding: 4px 3px;">' + d.WORK_CONTENTS + '</div></td>';
							innerHtml += '	<td class="center vertical-center"	style="width: 130px;"><div style="padding: 4px 3px;">' + d.WORK_START_DT + '</div></td>';
							innerHtml += '	<td class="center vertical-center"	style="width: 80px;"><div style="padding: 4px 3px;">' + d.WORK_START_TIME + '</div></td>';
							innerHtml += '	<td class="center vertical-center"	style="width: 130px;"><div style="padding: 4px 3px;">' + d.WORK_END_DT + '</div></td>';
							innerHtml += '	<td class="center vertical-center"	style="width: 80px;"><div style="padding: 4px 3px;">' + d.WORK_END_TIME + '</div></td>';
							innerHtml += '	<td class="right vertical-center"	style="width: 100px;"><input type="number" value="' + d.MANHOUR + '" data-rn="' + i + '" class="data-col-1 data" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
							innerHtml += '	<td class="right vertical-center"	style="width: 100px;"><input type="number" value="' + d.MANHOUR_CORRECTION + '" data-rn="' + i + '" class="data-col-2 data" step="0.01" readonly="readonly" onchange="javascript: reflectManHour(this);" style="width: 100%; text-align: right;"/></td>';
							innerHtml += '	<td class="right vertical-center"	style="width: 100px;"><input type="number" value="' + d.MANHOUR_SUM + '" data-rn="' + i + '" class="data-col-3 data" step="0.01" readonly="readonly" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
// 							innerHtml += '	<td class="right vertical-center"	style="width: 200px;"><input type="text" data-rn="' + i + '" onchange="javascript: reflectCommon(this, \'MEMO\');" readonly="readonly" value="' + (isEmpty(d.MEMO) ? '' : d.MEMO) + '" style="width: 100%;"/></td>';
							innerHtml += '</tr>';
							manhour += Number(d.MANHOUR);
							manhour_correction += Number(d.MANHOUR_CORRECTION);
							manhour_sum += Number(d.MANHOUR_SUM);
						});
						// 					console.log("manhour", manhour);
						// 					console.log("manhour_correction", manhour_correction);
						// 					console.log("manhour_sum", manhour_sum);
						innerHtml += '<tr>';
						innerHtml += '	<td class="center vertical-center" colspan="9"><div style="padding: 4px 3px;">공수합계</div></td>';
						innerHtml += '	<td class="right vertical-center"><input type="number" value="' + manhour.toFixed(2) + '" class="data-col-1 sub1" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
						innerHtml += '	<td class="right vertical-center"><input type="number" value="' + manhour_correction.toFixed(2) + '" class="data-col-2 sub1" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
						innerHtml += '	<td class="right vertical-center"><input type="number" value="' + manhour_sum.toFixed(2) + '" class="data-col-3 sub1" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
// 						innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">&nbsp;</div></td>';
						innerHtml += '</tr>';

						<%--
						// 출퇴근 조회결과에서 가져온 값을 출력한다.
						if (result2 === null) {
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
						} else {
							innerHtml += '<tr class="data-commute">';
							innerHtml += '	<td class="center vertical-center" colspan="8"><div style="padding: 4px 3px;">출퇴근합계</div></td>';
							innerHtml += '	<td class="right vertical-center"><input type="number" value="' + result2.COMMUTE + '" class="data-col-1 sub2" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
							innerHtml += '	<td class="right vertical-center"><input type="number" value="' + result2.COMMUTE_CORRECTION + '" class="data-col-2 sub2" step="0.01" onchange="javascript: reflectManHour(this);" style="width: 100%; text-align: right;"/></td>';
							innerHtml += '	<td class="right vertical-center"><input type="number" value="' + result2.COMMUTE_SUM + '" class="data-col-3 sub2" step="0.01" readonly="readonly" style="width: 100%; text-align: right;"/></td>';
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

			// 삭제
			$("#remove").on("click", function() {
				// DB 삭제 대상
				var delete_datas = new Array();
				var chk_cnt = 0;

				$(".data-base input.rows-checkbox").each(function(i, obj) {
					if ($(obj).attr("DBYN") !== "Y") {
						chk_cnt++;
						return false;
					}else{
						delete_datas.push({
							BASE_YYYYMM : $(obj).attr("BASE_YYYYMM"),
							VENDOR_CODE : $(obj).attr("VENDOR_CODE"),
							CONTRACT_CODE : $(obj).attr("CONTRACT_CODE"),
							SEQ : $(obj).attr("SEQ"),
							DBYN : $(obj).attr("DBYN"),
							ORDER_NUMBER : $(obj).attr("ORDER_NUMBER"),
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
					}
				});

				if( chk_cnt > 0 ){
					swalWarningCB("저장된 월보가 없습니다.");
					return false;
				}
				// DB 삭제 대상 없으면 종료
				if (delete_datas.length > 0) {
					// 검수보고서 확인
					if (!select_chk_enable_proc()) {
						return false;
					}
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
						// 합계, 차이 부분 계산
						reflectFooter();
	
						if (delete_datas.length > 0) {
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
	
							var token = $("meta[name='_csrf']").attr("content");
							var header = $("meta[name='_csrf_header']").attr("content");
							$.ajax({
								url : "/yp/zcs/ipt2/delete_zcs_ipt2_month_rpt3",
								type : "POST",
								cache : false,
								async : false,
								dataType : "json",
								data : {
									ROW_NO : JSON.stringify(delete_datas),
									ROW_NO2 : JSON.stringify(commute_datas)
								},
								success : function(data) {
									if(data.result > 0){
										swalSuccessCB("【삭제】완료되었습니다.", function() {
											$("#search_btn").trigger("click");
										});
									}else{
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
									swalDangerCB("【삭제】실패하였습니다.\n관리자에게 문의해주세요.");
								}
							});
						}
					}
				});
			});

			/* 저장 */
			$("#save").on("click", function() {
				// 검수보고서 확인
				if (!select_chk_enable_proc()) {
					return false;
				}

				if (fnValidation()) {
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
							var commute_datas = new Array();
							commute_datas.push({
								BASE_YYYYMM : save_datas[0].BASE_YYYYMM,
								VENDOR_CODE : save_datas[0].VENDOR_CODE,
								CONTRACT_CODE : save_datas[0].CONTRACT_CODE,
								COMMUTE : $(".data-commute .sub2.data-col-1").val(),
								COMMUTE_CORRECTION : $(".data-commute .sub2.data-col-2").val(),
								COMMUTE_SUM : $(".data-commute .sub2.data-col-3").val(),
								SUBTRACTION : $(".data-commute .sub3.data-col-3").val()
							});
							var token = $("meta[name='_csrf']").attr("content");
							var header = $("meta[name='_csrf_header']").attr("content");
							$.ajax({
								url : "/yp/zcs/ipt2/merge_zcs_ipt2_month_rpt3",
								type : "POST",
								cache : false,
								async : false,
								dataType : "json",
								data : {
									ROW_NO : JSON.stringify(save_datas),
									ROW_NO2 : JSON.stringify(commute_datas)
								},
								success : function(data) {
									console.log(data);
									swalSuccessCB("【저장】완료되었습니다.", function() {
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
									swalDangerCB("【저장】실패하였습니다.\n관리자에게 문의해주세요.");
								}
							});
						}
					});
				}
			});
		});

		/* 팝업 */
		function fnSearchPopup(type, target) {
			var w;
			if (type == "1") {
				w = window.open("/yp/popup/zcs/ctr/select_working_master_v", "업체 검색", "width=600, height=800");
			} else if (type == "2") {
				w = window.open("", "계약명 검색", "width=600,height=800,scrollbars=yes");
				// 지급기준별 조회 조건 추가 - {1:공수, 2: 작업, 3: 월정액} 
				fnHrefPopup("/yp/popup/zcs/ctr/retrieveContarctName", "계약명 검색", {
					PAY_STANDARD : "3"
				});
			} else if (type == "3") {
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
				var el = document.createElement("input");
				el.name = k;
				el.value = v;
				el.type = "hidden";
				popForm.appendChild(el);
			});

			popForm.submit();
			popForm.remove();
		}

		function fnValidation(rows) {
			var check = true;
			save_datas = new Array();

			$(".data-base input.rows-checkbox").each(function(i, obj) {
				save_datas.push({
					BASE_YYYYMM : $(obj).attr("DBYN") === "Y" ? $(obj).attr("BASE_YYYYMM") : $("#BASE_YYYYMM").val().trim(),
					VENDOR_CODE : $(obj).attr("DBYN") === "Y" ? $(obj).attr("VENDOR_CODE") : $("#VENDOR_CODE").val().trim(),
					CONTRACT_CODE : $(obj).attr("DBYN") === "Y" ? $(obj).attr("CONTRACT_CODE") : $("#CONTRACT_CODE").val().trim(),
					SEQ : $(obj).attr("DBYN") === "Y" ? $(obj).attr("SEQ") : "",
					DBYN : $(obj).attr("DBYN"),
					ORDER_NUMBER : $(obj).attr("ORDER_NUMBER"),
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
					MEMO : $(obj).attr("MEMO"),
					SECTION_START_DT : $(obj).attr("SECTION_START_DT"),
					SECTION_END_DT : $(obj).attr("SECTION_END_DT")
				});
			});

			if (save_datas.length === 0) {
				return false;
			}

			$.each(save_datas, function(i, d) {
				console.log(i, d);
				if (d.BASE_YYYYMM === "") {
					swalWarningCB("월보년월을 선택하세요.");
					check = false;
					return false;
				}
				if (d.VENDOR_CODE === "") {
					swalWarningCB("거래처를 선택하세요.");
					check = false;
					return false;
				}
				if (d.CONTRACT_CODE === "") {
					swalWarningCB("계약을 선택하세요.");
					check = false;
					return false;
				}
				if (d.ORDER_NUMBER === "") {
					swalWarningCB("SAP오더번호를 선택하세요.");
					check = false;
					return false;
				}
				if (d.WORK_START_DT === "") {
					swalWarningCB("시작일자를 선택하세요.");
					check = false;
					return false;
				}
				if (d.WORK_END_DT === "") {
					swalWarningCB("종료일자를 입력하세요.");
					check = false;
					return false;
				}
				if (d.WORK_START_TIME === "") {
					swalWarningCB("시작시간을 입력하세요.");
					check = false;
					return false;
				}
				if (d.WORK_END_TIME === "") {
					swalWarningCB("종료시간을 입력하세요.");
					check = false;
					return false;
				}
				if (isNaN(d.WORK_START_TIME.replaceAll(":", "")) || isNaN(d.WORK_END_TIME.replaceAll(":", ""))) {
					swalWarningCB("시간은 숫자만 입력하세요.");
					check = false;
					return false;
				}
				var tf = /^([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$/; // 시간형식 체크 정규화 HH24:MI:SS
				if (!tf.test(d.WORK_START_TIME)) {
					swalWarningCB("시작시간 포멧을 확인하세요.");
					check = false;
					return false;
				}
				if (!tf.test(d.WORK_END_TIME)) {
					swalWarningCB("종료시간 포멧을 확인하세요.");
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
			var calc = Number($(obj).val().replace(/[^\d+(\.\d{1,2})$]/g, '')).toFixed(2);

			// 변경한 행의 공수, 보정, 합계 계산
			var prev = $(obj).parent().prev().children();
			var next = $(obj).parent().next().children();
			var mc = Number(calc).toFixed(2);
			var ms = (Number(calc) + Number($(prev).val())).toFixed(2);

			$(obj).val(mc);
			$(next).val(ms);

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

			$(".data-base .rows-checkbox.rows-no-" + rows_no).attr(gb, d);
			<%--
			var timeFormat = /^([01][0-9]|2[0-3])([0-5][0-9])([0-5][0-9])$/; // 시간형식 체크 정규화 HH24:MI:SS
			timeFormat.test(startDt);
			--%>
		}

		function reflectFooter() {
			// 공수합계 계산
			var addition_col2 = 0;
			var addition_col3 = 0;
			$('.data.data-col-2').each(function(i, d) {
				addition_col2 += Number($(d).val());
			});
			$('.sub1.data-col-2').val(addition_col2.toFixed(2));

			$('.data.data-col-3').each(function(i, d) {
				addition_col3 += Number($(d).val());
			});
			$('.sub1.data-col-3').val(addition_col3.toFixed(2));

			// 차이 계산
			var subtraction_3 = 0;
			$('.sub3.data-col-3').val((Number($('.sub1.data-col-3').val()) - Number($('.sub2.data-col-3').val())).toFixed(2));
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
		function select_chk_enable_proc() {
			var result = false;
			var data = {};

			if ($(".data-base .rows-checkbox").length > 0) {
				data.BASE_YYYYMM = $(".data-base .rows-checkbox:eq(0)").attr("BASE_YYYYMM");
				data.VENDOR_CODE = $(".data-base .rows-checkbox:eq(0)").attr("VENDOR_CODE");
				data.CONTRACT_CODE = $(".data-base .rows-checkbox:eq(0)").attr("CONTRACT_CODE");
				data.REPORT_CODE = $(".data-base .rows-checkbox:eq(0)").attr("REPORT_CODE");
			} else {
				swalWarningCB("데이터가 없습니다.");
				return false;
			}

			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");

			$.ajax({
				url : "/yp/zcs/ipt/select_chk_enable_proc",
				type : "POST",
				cache : false,
				async : false,
				dataType : "json",
				data : data,
				success : function(data) {
					if (data.result === 0) {
						result = true;
					} else {
						swalWarningCB("전자결재 상태에 의해 작업할 수 없습니다.");
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
					swalDangerCB("작업을 실패하였습니다.\n관리자에게 문의해주세요.");
				}
			});
			return result;
		}
	</script>
</body>