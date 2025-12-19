<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
String toDay = date.format(today);

String userName = (String) request.getSession().getAttribute("userName");	//성명
String userPos  = (String) request.getSession().getAttribute("userPos")  == null ? "" : (String) request.getSession().getAttribute("userPos") ;	//직급
String userDept = (String) request.getSession().getAttribute("userDept") == null ? "" : (String) request.getSession().getAttribute("userDept");	//부서
String fullName = "";
if(!userDept.isEmpty() && !userPos.isEmpty()) fullName = userDept + " / " + userPos + " / " + userName;
else fullName = userName;


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<sec:csrfMetaTags />
	<title>캐소드블렌딩 예측등록</title>
	<script src="/resources/icm/js/jquery.js"></script>
	<script src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
	<script src="/resources/icm/js/custom.js"></script>
	<!-- 기존 프레임워크 리소스 -->
	<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/resources/icm/css/jquery-ui.css" />
	<!-- 2019-12-13 smh jquery-ui.css 변경.끝 -->
	<link href='/resources/icm/css/animate.min.css' rel='stylesheet'>
	<link rel="stylesheet" type="text/css" href="/resources/css/custom.css" />
	<link rel="stylesheet" type="text/css" href="/resources/css/all.min.css" />
	<link rel="stylesheet" href="/resources/icm/jsTree/dist/themes/default/style.min.css" />
	<link href="/resources/icm/datepicker/css/datepicker.css" rel="stylesheet" type="text/css" />
	<link id="bs-css" href="/resources/icm/css/bootstrap.min.css" rel="stylesheet">
	<!-- jQuery -->
	<script src="/resources/icm/js/jquery.js"></script>
	<script src="/resources/icm/js/jquery.validate.min.js"></script>
	<script src="/resources/icm/js/jquery-ui.js"></script>
	<script src="/resources/icm/jsTree/dist/jstree.min.js"></script>
	<script src="/resources/icm/jsTree/dist/customJstree.js"></script>
	<link rel="stylesheet" href="/resources/icm/uigrid/css/ui-grid.min.css" type="text/css">
	<script src="/resources/icm/js/custom.js"></script>
	<script src="/resources/icm/js/multiFile.js"></script>
	<script src="/resources/icm/js/fileList.js"></script>
	<script src="/resources/icm/angular/js/angular.min.js"></script>
	<script src="/resources/icm/angular/js/angular-route.min.js"></script>
	<script src="/resources/icm/uigrid/js/ui-grid.min.js"></script>
	<script src="/resources/icm/uigrid/js/ui-grid.language.ko.js"></script>
	<!-- 2019-08-15 smh 추가 시작.-->
	<!-- 	<script src="/resources/js/jquery.vicurusit.js"></script> -->
	<!-- 2019-08-15 smh 추가 끝-->
	<script src="/resources/icm/uigrid/js/uiGrid1.js"></script>
	<script src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
	<script src="/resources/icm/datepicker/js/bootstrap-datepicker.js"></script>
	<script src="/resources/icm/jsTree/dist/customJstree.js"></script>
	<link rel="stylesheet" type="text/css" href="/resources/font/ng.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/style.css">
	<script type="text/javascript" src="/resources/js/ui.js"></script>
	<!-- 20191227_khj Tooltip Add -->
	<script src="/resources/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="/resources/icm/js/bootstrap.min.js"></script>
	<!-- application script for Charisma demo -->
	<script src="/resources/icm/js/charisma.js"></script>
	<link rel="stylesheet" href="/resources/yp/css/style.css">
	<!-- 기존 프레임워크 리소스 -->
	<!-- 영풍 리소스 -->
	<script src="/resources/yp/js/common.js"></script>
	<style type="text/css">
	
	/* ui-grid header-align CENTER */
	.ui-grid-header-cell{text-align:center !important;}
	.ui-grid-header-cell-label.ng-binding{margin-left:1.2em;}
	.ui-grid-viewport
	{
		overflow-x:hidden !important;
	}
	</style>
</head>
<body data-ng-app="app">
	<style>
		table {
			border:1px solid #111111;
		}
		td {
			border:1px solid #000000;
		}
		.name_cell {
			font-size:1.0rem; color:blue; text-align:center; vertical-align:middle;
		}
		.name_cell_s {
			font-size:1.0rem; color:blue; text-align:center; vertical-align:middle;
		}
		.contents_cell
		{
			font-size:1.0rem; color:blue; text-align:center; vertical-align:middle; background-color:#D9E5FF; font-weight:bold;
		}
		.editable_bg
		{
			font-size:1.5rem; color:white; text-align:center; vertical-align:middle; background-color:#588CFC; font-weight:bold;
		}
		.edit_cell
		{
			font-size:1.5rem; width:100%; color:white; text-align:center; vertical-align:middle; background-color:#588CFC; font-weight:bold;
		}
		.tbl_def
		{
			height:30px
		}
	</style>

	<div id="popup">
		<div class="pop_header">
			캐소드 블렌딩 예측 등록
		</div>
		<div class="pop_content">
		<div style="height:50px; background-color:white"></div>
		<div class="tbl_box">
			<table id="table_1" class=tbl_def>
				<colgroup>
					<col width="20%" />
					<col width="30%" />
					<col width="20%" />
					<col width="30%" />
				</colgroup>
				<tr>
					<td class=name_cell>주조팀 조업자</td>
					<td class=contents_cell><%=fullName%></td>
					<td class=name_cell>용탕NO</td>
					<td class=contents_cell>
						<select name="machine_id">
							<option value="1">1공장 #1 - 1,000 kW</option>
							<option value="2">1공장 #2 - 1,600 kW</option>
							<option value="3">2공장 #1 - 2,200 kW</option>
							<option value="4">2공장 #2 - 2,200 kW</option>
							<option value="5">2공장 #3 - 2,200 kW</option>
 						</select>
					</td>
				</tr>
			</table>
			<div style="height:5px; background-color:white"></div>
			<table id="table_2" class=tbl_def>
				<colgroup>
					<col width="20%" />
					<col width="30%" />
					<col width="20%" />
					<col width="30%" />
				</colgroup>
				<tr>
					<td class=name_cell>캐소드 투입 시각</td>
					<td class=contents_cell>
						<select name="hour_index">
							<option value="1">01:00</option>
							<option value="2">02:00</option>
							<option value="3">03:00</option>
							<option value="4">04:00</option>
							<option value="5">05:00</option>
							<option value="6">06:00</option>
							<option value="7">07:00</option>
							<option value="8">08:00</option>
							<option value="9">09:00</option>
							<option value="10">10:00</option>
							<option value="11">11:00</option>
							<option value="12">12:00</option>
							<option value="13">13:00</option>
							<option value="14">14:00</option>
							<option value="15">15:00</option>
							<option value="16">16:00</option>
							<option value="17">17:00</option>
							<option value="18">18:00</option>
							<option value="19">19:00</option>
							<option value="20">20:00</option>
							<option value="21">21:00</option>
							<option value="22">22:00</option>
							<option value="23">23:00</option>
							<option value="24">24:00</option>
						</select>
					</td>
					<td class=name_cell>일자</td>
					<td class=contents_cell>현재 날짜</td>
				</tr>
			</table>
			<div style="height:5px; background-color:white"></div>
			<table id="table_3" class=tbl_def>
				<colgroup>
					<col width="20%" />
					<col width="10%" />
					<col width="20" />
					<col width="20%" />
					<col width="30%" />
				</colgroup>
				<tr>
					<td class=name_cell>용탕잔량 (ton)</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_1" size="20" style="height:30px; border:0;" class=edit_cell onchange="onChgText_1(this)">
						</div>
					</td>
					<td class=name_cell>용탕품위 (ppm)</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_2" size="20" style="height:30px; border:0;" class=edit_cell onchange="onChgText_2(this)">
						</div>
					</td>
					<td class=name_cell>* 4시간 전 용탕품위</td>
				</tr>
			</table>
			<div style="height:5px; background-color:white"></div>
			<table id="table_4" class=tbl_def>
				<colgroup>
					<col width="20%" />
					<col width="10%" />
					<col width="8.75%" />
					<col width="8.75%" />
					<col width="8.75%" />
					<col width="8.75%" />
					<col width="8.75%" />
					<col width="8.75%" />
					<col width="8.75%" />
					<col width="8.75%" />
				</colgroup>
				<tr>
					<td class=name_cell>구분 (ton)</td>
					<td class=name_cell>합계</td>
					<td class=name_cell_s>고품위 대형</td>
					<td class=name_cell_s>고품위 소형</td>
					<td class=name_cell_s>1차분 대형</td>
					<td class=name_cell_s>2차분 대형</td>
					<td class=name_cell_s>저품위 소형</td>
					<td class=name_cell_s>불량잉곳</td>
					<td class=name_cell_s>화성화조 대형</td>
					<td class=name_cell_s>화성화조 소형</td>
				</tr>
			</table>
			<div style="height:5px; background-color:white"></div>
			<table id="table_5" class=tbl_def>
				<colgroup>
					<col width="20%" />
					<col width="10%" />
					<col width="8.75%" />
					<col width="8.75%" />
					<col width="8.75%" />
					<col width="8.75%" />
					<col width="8.75%" />
					<col width="8.75%" />
					<col width="8.75%" />
					<col width="8.75%" />
				</colgroup>
				<tr>
					<td class=name_cell>투입Lot수량 (수)</td>
					<td class=name_cell>0.0</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_3" size="20" style="height:30px; border:0;" class=edit_cell onchange="onChgText_3(this)">
						</div>
					</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_4" size="20" style="height:30px; border:0;" class=edit_cell onchange="onChgText_4(this)">
						</div>
					</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_5" size="20" style="height:30px; border:0;" class=edit_cell onchange="onChgText_5(this)">
						</div>
					</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_6" size="20" style="height:30px; border:0;" class=edit_cell onchange="onChgText_6(this)">
						</div>
					</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_7" size="20" style="height:30px; border:0;" class=edit_cell onchange="onChgText_7(this)">
						</div>
					</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_8" size="20" style="height:30px; border:0;" class=edit_cell onchange="onChgText_8(this)">
						</div>
					</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_9" size="20" style="height:30px; border:0;" class=edit_cell onchange="onChgText_9(this)">
						</div>
					</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_10" size="20" style="height:30px; border:0;" class=edit_cell onchange="onChgText_10(this)">
						</div>
					</td>
				</tr>
			</table>
			<div style="height:5px; background-color:white"></div>
			<table id="table_6" class=tbl_def>
				<colgroup>
					<col width="20%" />
					<col width="10%" />
					<col width="8.75%" />
					<col width="8.75%" />
					<col width="8.75%" />
					<col width="8.75%" />
					<col width="8.75%" />
					<col width="8.75%" />
					<col width="8.75%" />
					<col width="8.75%" />
				</colgroup>
				<tr>
					<td class=name_cell>예상투입량 (ton)</td>
					<td class=contents_cell>0.0</td>
					<td class=contents_cell>0.0</td>
					<td class=contents_cell>0.0</td>
					<td class=contents_cell>0.0</td>
					<td class=contents_cell>0.0</td>
					<td class=contents_cell>0.0</td>
					<td class=contents_cell>0.0</td>
					<td class=contents_cell>0.0</td>
					<td class=contents_cell>0.0</td>
				</tr>
			</table>
			<div style="height:5px; background-color:white"></div>
			<table id="table_7" class=tbl_def>
				<colgroup>
					<col width="20%" />
					<col width="10%" />
					<col width="70%" />
				</colgroup>
				<tr>
					<td class=name_cell>예상용탕품위 (ppm)</td>
					<td class=contents_cell>0.0</td>
					<td class=name_cell>⋇ 캐소드 투입 시의 예상 용탕 품위</td>
				</tr>
			</table>
			<div style="height:35px; background-color:white"></div>
			<div class="btn_wrap">
				<button class="btn btn_save" id="register_btn" style="font-size:12px; width:90px; height:30px;" onclick="registerValues();">등록</button>
				<button class="btn btn_apply" id="setup_btn" style="font-size:12px; width:90px; height:30px;" onclick="callSetupPopup();">예측설정</button>
				<button class="btn btn_search" id="reload_btn" style="font-size:12px; width:100px; height:30px;" onclick="reloadValues();">재조회</button>
				<button class="btn btn_make" id="close_btn" style="font-size:12px; width:100px; height:30px;" onclick="closePopup();">닫기</button>
			</div>
		</div>
	</div>
	<script>
		var l_Result_1 = 0;
		var l_Result_2 = 0;
		var l_Result_3 = 0;
		var l_Result_4 = 0;
		var l_Result_5 = 0;
		var l_Result_6 = 0;
		var l_Result_7 = 0;
		var l_Result_8 = 0;

		var l_Result_11 = 0;
		var l_Result_12 = 0;
		var l_Result_13 = 0;
		var l_Result_14 = 0;
		var l_Result_15 = 0;
		var l_Result_16 = 0;
		var l_Result_17 = 0;
		var l_Result_18 = 0;

		//	용탕잔량
		var l_InValue_1 = 0;
		//	용탕품위
		var l_InValue_2 = 0;
		//	투입 Lot 수
		var l_InLotVal = new Array();
		//	Lot당 무게
		var l_MultipleVal = new Array();
		//	제품별 ppm
		var l_InPpm = new Array();

		function closePopup() {
			self.close();
		}

		function registerValues() {
			var table_6 = document.getElementById("table_6");
			var table_7 = document.getElementById("table_7");

			var val_1 = parseFloat(table_6.rows[0].cells[2].innerHTML);
			var val_2 = parseFloat(table_6.rows[0].cells[3].innerHTML);
			var val_3 = parseFloat(table_6.rows[0].cells[4].innerHTML);
			var val_4 = parseFloat(table_6.rows[0].cells[5].innerHTML);
			var val_5 = parseFloat(table_6.rows[0].cells[6].innerHTML);
			var val_6 = parseFloat(table_6.rows[0].cells[7].innerHTML);
			var val_7 = parseFloat(table_6.rows[0].cells[8].innerHTML);
			var val_8 = parseFloat(table_6.rows[0].cells[9].innerHTML);
			var val_9 = parseFloat(table_7.rows[0].cells[1].innerHTML);

			var workerName = "<%=fullName%>";

			var today = new Date();
			var sYear = today.getFullYear();
			var sMonth = today.getMonth() + 1;
			var sDay = today.getDate();
			var sHour = today.getHours();
			var sMinute = today.getMinutes();
			var sSecond = today.getSeconds();

			sMonth = sMonth > 9 ? sMonth : "0" + sMonth;
		    sDay  = sDay > 9 ? sDay : "0" + sDay;
		    sHour  = sHour > 9 ? sHour : "0" + sHour;
		    sMinute  = sMinute > 9 ? sMinute : "0" + sMinute;
		    sSecond  = sSecond > 9 ? sSecond : "0" + sSecond;

			var sDateStr = sYear.toString() + sMonth.toString() + sDay.toString() + sHour.toString() + sMinute.toString() + sSecond.toString();
			var machine_id = $("select[name=machine_id]").val();
			var hour_id = $("select[name=hour_index]").val();

			$.ajax({
 				url : "/yp/popup/zpp/ctd/zpp_ctd_insert_master",
				type : "POST",
			    cache:false,
			    async:true, 
				data : {
					JOB_DATE : sDateStr,
					MACHINE_NO : machine_id,
					JOB_TIME : hour_id,
					WORKER : workerName,
					REMAIN_AMOUNT : document.getElementById("input_1").value,
					REMAIN_LEVEL : document.getElementById("input_2").value,
					M1_LOT_CNT : document.getElementById("input_3").value,
					M1_WEIGHT : val_1,
					M2_LOT_CNT : document.getElementById("input_4").value,
					M2_WEIGHT : val_2,
					M3_LOT_CNT : document.getElementById("input_5").value,
					M3_WEIGHT : val_3,
					M4_LOT_CNT : document.getElementById("input_6").value,
					M4_WEIGHT : val_4,
					M5_LOT_CNT : document.getElementById("input_7").value,
					M5_WEIGHT : val_5,
					M6_LOT_CNT : document.getElementById("input_8").value,
					M6_WEIGHT : val_6,
					M7_LOT_CNT : document.getElementById("input_9").value,
					M7_WEIGHT : val_7,
					M8_LOT_CNT : document.getElementById("input_10").value,
					M8_WEIGHT : val_8,
					PREDICT_LEVEL : val_9,
					REG_DATE : sDateStr,
					_csrf : '${_csrf.token}'
					},
				dataType : "json",
				success : function(result) {
					opener.parent.swalSuccess("저장 되었습니다.");
					self.close();
				},
				beforeSend : function(xhr) {
					// 2019-10-23 khj - for csrf
					//xhr.setRequestHeader(header, token);
					$('.wrap-loading').removeClass('display-none');
				},
				complete : function() {
					$('.wrap-loading').addClass('display-none');
				},
				error : function(request, status, error) {
					//	console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
					swalDangerCB("저장에 실패하였습니다.\n관리자에게 문의해주세요.");
				}
			});
		}

		function reloadValues() {
			get_Values();
			reCalcResult();
		}

		function setValues(cellIdx, ov) {
			var table_5 = document.getElementById("table_5");
			var table_6 = document.getElementById("table_6");
			var table_7 = document.getElementById("table_7");

			l_InLotVal[cellIdx] = parseFloat(ov);
			table_6.rows[0].cells[2 + cellIdx].innerHTML = (l_InLotVal[cellIdx] * l_MultipleVal[cellIdx]).toString();
		
			var tot_val = 0;

			for(var i = 0;i < 8;i ++) {
				tot_val += l_InLotVal[i];
			}
			
			table_5.rows[0].cells[1].innerHTML = tot_val.toString();

			tot_val = 0;

			for(var i = 0;i < 8;i ++) {
				tot_val += (l_InLotVal[i] * l_MultipleVal[i]);
			}
			
			table_6.rows[0].cells[1].innerHTML = tot_val.toString();

			reCalcResult();
		}
		
		function reCalcResult() {
			//	예상용탕품위 계산
			var totWeight = 0;
			var totPpm = 0;
			var totResult = 0;

			totWeight = parseFloat(l_InValue_1);
			for(var i = 0;i < 8;i ++) {
				totWeight += parseFloat(l_InLotVal[i] * l_MultipleVal[i]);
				//	console.log("totWeight : " + i + " : " + totWeight);
			}
			if(totWeight != 0) {
				totPpm = l_InValue_1 * l_InValue_2;
				//	console.log("totWeight : " + totWeight + " totPpm : " + l_InValue_1 + ":" + l_InValue_2 + ":" + totPpm);
				for(var i = 0;i < 8;i ++) {
					totPpm += parseFloat(l_InLotVal[i] * l_MultipleVal[i] * l_InPpm[i]);
				}
				//	console.log("res totPpm : " + totPpm);
				
				totResult = totPpm / totWeight;
			}
			else {
				totResult = 0.0;
			}
			table_7.rows[0].cells[1].innerHTML = totResult.toFixed(2);
		}

		function onChgText_1(obj) {
			l_InValue_1 = obj.value;
			reCalcResult();
		}

		function onChgText_2(obj) {
			l_InValue_2 = obj.value;
			reCalcResult();
		}

		function onChgText_3(obj) {
			setValues(0, obj.value);
		}

		function onChgText_4(obj) {
			setValues(1, obj.value);
		}

		function onChgText_5(obj) {
			setValues(2, obj.value);
		}

		function onChgText_6(obj) {
			setValues(3, obj.value);
		}

		function onChgText_7(obj) {
			setValues(4, obj.value);
		}

		function onChgText_8(obj) {
			setValues(5, obj.value);
		}

		function onChgText_9(obj) {
			setValues(6, obj.value);
		}

		function onChgText_10(obj) {
			setValues(7, obj.value);
		}

		function set_Value() {
			for(var i = 0;i < 8;i ++) {
				l_InLotVal[i] = 0;
			}

			l_InPpm[0] = 20.0;
			l_InPpm[1] = 20.0;
			l_InPpm[2] = 40.0;
			l_InPpm[3] = 40.0;
			l_InPpm[4] = 40.0;
			l_InPpm[5] = 40.0;
			l_InPpm[6] = 40.0;
			l_InPpm[7] = 40.0;
			
			l_MultipleVal[0] = 3.0;
			l_MultipleVal[1] = 1.5;
			l_MultipleVal[2] = 3.0;
			l_MultipleVal[3] = 3.0;
			l_MultipleVal[4] = 1.5;
			l_MultipleVal[5] = 1.0;
			l_MultipleVal[6] = 3.0;
			l_MultipleVal[7] = 3.0;

			get_Values();

			document.getElementById("input_1").value = l_InValue_1;
			document.getElementById("input_2").value = l_InValue_2;
			document.getElementById("input_3").value = l_InLotVal[0];
			document.getElementById("input_4").value = l_InLotVal[1];
			document.getElementById("input_5").value = l_InLotVal[2];
			document.getElementById("input_6").value = l_InLotVal[3];
			document.getElementById("input_7").value = l_InLotVal[4];
			document.getElementById("input_8").value = l_InLotVal[5];
			document.getElementById("input_9").value = l_InLotVal[6];
			document.getElementById("input_10").value = l_InLotVal[7];
		}

		function get_Values() {
			$.ajax({
				url : "/yp/zpp/ctd/zpp_ctd_envdata",
				type : "POST",
			    cache:false,
			    async:true, 
				data : {
					_csrf : '${_csrf.token}'
					},
				dataType : "json",
				success : function(result) {
					l_InPpm[0] = result.M1_PPM_LEVEL;
					l_InPpm[1] = result.M2_PPM_LEVEL;
					l_InPpm[2] = result.M3_PPM_LEVEL;
					l_InPpm[3] = result.M4_PPM_LEVEL;
					l_InPpm[4] = result.M5_PPM_LEVEL;
					l_InPpm[5] = result.M6_PPM_LEVEL;
					l_InPpm[6] = result.M7_PPM_LEVEL;
					l_InPpm[7] = result.M8_PPM_LEVEL;
					
					l_MultipleVal[0] = result.M1_LOT_WEIGHT;
					l_MultipleVal[1] = result.M2_LOT_WEIGHT;
					l_MultipleVal[2] = result.M3_LOT_WEIGHT;
					l_MultipleVal[3] = result.M4_LOT_WEIGHT;
					l_MultipleVal[4] = result.M5_LOT_WEIGHT;
					l_MultipleVal[5] = result.M6_LOT_WEIGHT;
					l_MultipleVal[6] = result.M7_LOT_WEIGHT;
					l_MultipleVal[7] = result.M8_LOT_WEIGHT;
				},
				error : function(request, status, error) {
					//	console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
				}
			});
		}

		function set_Label() {
			var today = new Date();
			var todayStr = today.getFullYear().toString(10) + "년 " + (today.getMonth() + 1).toString(10) + "월 " + today.getDate().toString(10) + "일";

			var table = document.getElementById("table_1");

			if(table != null) {
				//	주조팀 조업자
				//	table.rows[0].cells[1].innerHTML = "TEST";
				//	용탕 사양 문자열
				//	table.rows[0].cells[3].innerHTML = "No2. TEST";
			}

			var table = document.getElementById("table_2");

			if(table != null) {
				//	캐소드 투입 시간
				//	table.rows[0].cells[1].innerHTML = "07:00 ~ 07:30";
				//	일자
				table.rows[0].cells[3].innerHTML = todayStr;
			}

			var table = document.getElementById("table_3");

			if(table != null) {
			}

			var table = document.getElementById("table_4");

			if(table != null) {
			}

			var table = document.getElementById("table_5");

			if(table != null) {
				//	투입 Lot 수향 (수) 합계
				table.rows[0].cells[1].innerHTML = "0.0";
			}

			var table = document.getElementById("table_6");

			if(table != null) {
				//	예상투입량
				//	합계
				table.rows[0].cells[1].innerHTML = "0.0";
				//	고품위 대형
				table.rows[0].cells[2].innerHTML = "0.0";
				//	고품위 소형
				table.rows[0].cells[3].innerHTML = "0.0";
				//	1차분
				table.rows[0].cells[4].innerHTML = "0.0";
				//	2차분
				table.rows[0].cells[5].innerHTML = "0.0";
				//	저품위 소형
				table.rows[0].cells[6].innerHTML = "0.0";
				//	불량 잉곳
				table.rows[0].cells[7].innerHTML = "0.0";
				//	화성화조 대형
				table.rows[0].cells[8].innerHTML = "0.0";
				//	화성화조 소형
				table.rows[0].cells[9].innerHTML = "0.0";
			}

			var table = document.getElementById("table_7");

			if(table != null) {
				//	예상용탕품위
				table.rows[0].cells[1].innerHTML = "0";
			}
		}

		function callSetupPopup() {
			var form    = document.createElement("form");
			var input0   = document.createElement("input");
			input0.name  = "_csrf";
			input0.value = "${_csrf.token}";
			input0.type  = "hidden";

			var input1   = document.createElement("input");
			input1.name  = "l_Weight_1";
			input1.value = l_MultipleVal[0];
			input1.type  = "hidden";
			
			var input2   = document.createElement("input");
			input2.name  = "l_Weight_2";
			input2.value = l_MultipleVal[1];
			input2.type  = "hidden";
			
			var input3   = document.createElement("input");
			input3.name  = "l_Weight_3";
			input3.value = l_MultipleVal[2];
			input3.type  = "hidden";
			
			var input4   = document.createElement("input");
			input4.name  = "l_Weight_4";
			input4.value = l_MultipleVal[3];
			input4.type  = "hidden";

			var input5   = document.createElement("input");
			input5.name  = "l_Weight_5";
			input5.value = l_MultipleVal[4];
			input5.type  = "hidden";
			
			var input6   = document.createElement("input");
			input6.name  = "l_Weight_6";
			input6.value = l_MultipleVal[5];
			input6.type  = "hidden";
			
			var input7   = document.createElement("input");
			input7.name  = "l_Weight_7";
			input7.value = l_MultipleVal[6];
			input7.type  = "hidden";
			
			var input8   = document.createElement("input");
			input8.name  = "l_Weight_8";
			input8.value = l_MultipleVal[7];
			input8.type  = "hidden";

			var input11   = document.createElement("input");
			input11.name  = "l_Ppm_1";
			input11.value = l_InPpm[0];
			input11.type  = "hidden";
			
			var input12   = document.createElement("input");
			input12.name  = "l_Ppm_2";
			input12.value = l_InPpm[1];
			input12.type  = "hidden";
			
			var input13   = document.createElement("input");
			input13.name  = "l_Ppm_3";
			input13.value = l_InPpm[2];
			input13.type  = "hidden";
			
			var input14   = document.createElement("input");
			input14.name  = "l_Ppm_4";
			input14.value = l_InPpm[3];
			input14.type  = "hidden";
			
			var input15   = document.createElement("input");
			input15.name  = "l_Ppm_5";
			input15.value = l_InPpm[4];
			input15.type  = "hidden";
			
			var input16   = document.createElement("input");
			input16.name  = "l_Ppm_6";
			input16.value = l_InPpm[5];
			input16.type  = "hidden";
			
			var input17   = document.createElement("input");
			input17.name  = "l_Ppm_7";
			input17.value = l_InPpm[6];
			input17.type  = "hidden";
			
			var input18   = document.createElement("input");
			input18.name  = "l_Ppm_8";
			input18.value = l_InPpm[7];
			input18.type  = "hidden";

			var popupX = (document.body.offsetWidth - 1400) / 2;
			var popupY = (document.body.offsetHeight - 300) / 2;
			window.open("","setup_popup","width=1400,height=300,left=" + popupX + ",top=" + popupY + ", scrollbars=no");
			
			form.method = "post";
			form.target = "setup_popup"
			form.action = "/yp/popup/zpp/ctd/zpp_ctd_setup_popup";
			
			form.appendChild(input0);

			form.appendChild(input1);
			form.appendChild(input2);
			form.appendChild(input3);
			form.appendChild(input4);
			form.appendChild(input5);
			form.appendChild(input6);
			form.appendChild(input7);
			form.appendChild(input8);
			
			form.appendChild(input11);
			form.appendChild(input12);
			form.appendChild(input13);
			form.appendChild(input14);
			form.appendChild(input15);
			form.appendChild(input16);
			form.appendChild(input17);
			form.appendChild(input18);

			document.body.appendChild(form);
			
			form.submit();
			form.remove();
		}

		$(document).ready(function() {
			set_Value();
			set_Label();
		});
	</script>
</body>
</html>