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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<sec:csrfMetaTags />
	<title>정광 입고 검수 결과 등록</title>
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
			font-size:1.0rem; color:blue; text-align:center; vertical-align:middle; background-color:#FFFFFF; font-weight:bold;
		}
		.editable_bg
		{
			font-size:1.0rem; color:white; text-align:center; vertical-align:middle; background-color:#FFFFFF; font-weight:bold;
		}
		.edit_cell
		{
			font-size:1.0rem; width:100%; color:black; text-align:center; vertical-align:middle; background-color:#FFFFFF; font-weight:bold;
		}
		.tbl_def
		{
			height:20px
		}
	</style>

	<div id="popup">
		<div class="pop_header">
			정광 입고 검수 결과 등록
		</div>
		<div class="pop_content">
			<div style="float:left;width:100%;padding:10px">
				<section>
					<div class="tbl_box">
						<table cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="5%" />
								<col width="20%" />
								<col width="5%" />
								<col width="20%" />
								<col width="5%" />
								<col width="20%" />
								<col width="5%" />
								<col width="20%" />
							</colgroup>
							<tr>
								<th>광종명</th>
								<td>
									<input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_MATERIAL_ID"/>
								</td>
								<th>업체명</th>
								<td>
									<input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_SELLER_ID"/>
								</td>
								<th>입항일자</th>
								<td>
									<input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IMPORT_DATE"/>
								</td>
								<th>LOT COUNT</th>
								<td>
									<input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="sel_LC"/>
								</td>
							</tr>
						</table>
					</div>
				</section>
			</div>
			<div style="height:35px; background-color:white"></div>
			<table id="table_2" class=tbl_def>
				<colgroup>
					<col width="10%" />
					<col width="30%" />
					<col width="20%" />
					<col width="40%" />
				</colgroup>
				<tr>
					<td>Lot</td>
					<td>Wet Weight(M/T)</td>
					<td>Moisture(%)</td>
					<td>Dry Weight(M/T)</td>
				</tr>
			</table>
			<div style="height:35px; background-color:white"></div>
			<div class="btn_wrap">
				<button class="btn btn_save" id="reg_btn" onclick="saveSetup();" style="font-size:12px; width:90px; height:30px;">저장</button>
				<button class="btn" id="reg_btn" onclick="closePopup();" style="font-size:12px; height:30px;">닫기</button>
			</div>
		</div>
	</div>
	<script>
		var l_LOT_COUNT = 20;
		var l_MaterialName = new Array();
		var l_MaterialID = new Array();
		var l_SellerName = new Array();
		var l_SellerID = new Array();

		var l_MASTER_ID;
		var l_WMT_Val = new Array();
		var l_DMT_Val = new Array();
		var l_MOISTURE_Val = new Array();

		//	1:INSERT, 2:UPDATE
		var l_EditMode = 1;
		
		function numberMaxLength(e) {
			if(e.value.length > e.maxLength) {
				e.value = e.value.slice(0, e.maxLength);
	        }
	    }

		function AddColumn(row, contents)
		{
			var table_data = document.createElement('td');

			table_data.innerHTML = contents;
			row.appendChild(table_data);
		}

		function
		setLotCountTable(lotCount)
		{
			var table = document.getElementById('table_2');
			var row_count = table.rows.length;

			for(var ri = 0;ri < row_count;ri ++) table.deleteRow(0);

			var row1 = document.createElement('tr');

			AddColumn(row1, 'Lot');
			AddColumn(row1, 'Wet Weight(M/T)');
			AddColumn(row1, 'Moisture(%)');
			AddColumn(row1, 'Dry Weight(M/T)');

			table.appendChild(row1);

			for(var i = 0;i < lotCount; i ++)
			{
				idx = Number(i) + 1;

				var table_row = document.createElement('tr');

				var cn1  = "input_" + (idx).toString() + "_1";
				var cn2  = "input_" + (idx).toString() + "_2";
				var cn3  = "input_" + (idx).toString() + "_3";

				//	LOT
				AddColumn(table_row, '<td class=name_cell>' + (idx).toString() + '</td>');
				//	WET WEIGHT
				AddColumn(table_row, '<input type="number" id="' + cn1 + '" maxlength="6" oninput="numberMaxLength(this);" size="20" style="height:20px; border:0;" class=edit_cell>');
				//	MOISTURE
				var opt_str = 'onchange="onChgMoisture(' + (idx).toString() + ')"';

				AddColumn(table_row, '<input type="number" id="' + cn2 + '" maxlength="6" oninput="numberMaxLength(this);" size="20" style="height:20px; border:0;" class=edit_cell ' + opt_str + '>');
				//	DRY WEIGHT
				AddColumn(table_row, '<input type="number" id="' + cn3 + '" maxlength="6" oninput="numberMaxLength(this);" size="20" style="height:20px; border:0;" class=edit_cell>');

				table.appendChild(table_row);						
			}
		}

		function get_NS(id) {
			return document.getElementById(id).value == "" ? "0":document.getElementById(id).value;
		}
		
		function set_NS(id, value) {
			document.getElementById(id).value = value;
		}

		function
		onChgMoisture(idx_str)
		{
			var cn1  = "input_" + idx_str + "_1";
			var cn2  = "input_" + idx_str + "_2";
			var cn3  = "input_" + idx_str + "_3";

			set_NS(cn3, (100 - Number(get_NS(cn2))) * Number(get_NS(cn1)) / 100.0);
		}

		function display_mt_info() {
			document.getElementById("sel_LC").value = l_LOT_COUNT;

			var fn = "";

			for(var si = 0;si < l_LOT_COUNT;si ++) {
				fn = "input_" + (si + 1).toString() + "_1";
				set_NS(fn,  l_WMT_Val[si]);
			}

			for(var si = 0;si < l_LOT_COUNT;si ++) {
				fn = "input_" + (si + 1).toString() + "_2";
				set_NS(fn,  l_MOISTURE_Val[si]);
			}

			for(var si = 0;si < l_LOT_COUNT;si ++) {
				fn = "input_" + (si + 1).toString() + "_3";
				set_NS(fn,  l_DMT_Val[si]);
			}
		}

		function saveSetup() {
			var fn = "";
			
			for(var si = 0;si < l_LOT_COUNT;si ++) {
				fn = "input_" + (si + 1).toString() + "_1";
				l_WMT_Val[si] = get_NS(fn);
			}

			for(var si = 0;si < l_LOT_COUNT;si ++) {
				fn = "input_" + (si + 1).toString() + "_2";
				l_MOISTURE_Val[si] = get_NS(fn);
			}

			for(var si = 0;si < l_LOT_COUNT;si ++) {
				fn = "input_" + (si + 1).toString() + "_3";
				l_DMT_Val[si] = get_NS(fn);
			}

			$.ajax({
 				url : "/yp/popup/zpp/ore/zpp_ore_insert_result",
				type : "POST",
			    cache:false,
			    async:true, 
				data : {
					MASTER_ID : l_MASTER_ID,
					LOT_COUNT : l_LOT_COUNT,
					MODE : l_EditMode,
					WMT_1 : l_WMT_Val[0],
					WMT_2 : l_WMT_Val[1],
					WMT_3 : l_WMT_Val[2],
					WMT_4 : l_WMT_Val[3],
					WMT_5 : l_WMT_Val[4],
					WMT_6 : l_WMT_Val[5],
					WMT_7 : l_WMT_Val[6],
					WMT_8 : l_WMT_Val[7],
					WMT_9 : l_WMT_Val[8],
					WMT_10 : l_WMT_Val[9],
					WMT_11 : l_WMT_Val[10],
					WMT_12 : l_WMT_Val[11],
					WMT_13 : l_WMT_Val[12],
					WMT_14 : l_WMT_Val[13],
					WMT_15 : l_WMT_Val[14],
					WMT_16 : l_WMT_Val[15],
					WMT_17 : l_WMT_Val[16],
					WMT_18 : l_WMT_Val[17],
					WMT_19 : l_WMT_Val[18],
					WMT_20 : l_WMT_Val[19],
					WMT_21 : l_WMT_Val[20],
					WMT_22 : l_WMT_Val[21],
					WMT_23 : l_WMT_Val[22],
					WMT_24 : l_WMT_Val[23],
					WMT_25 : l_WMT_Val[24],
					WMT_26 : l_WMT_Val[25],
					WMT_27 : l_WMT_Val[26],
					WMT_28 : l_WMT_Val[27],
					WMT_29 : l_WMT_Val[28],
					WMT_30 : l_WMT_Val[29],
					MOISTURE_1 : l_MOISTURE_Val[0],
					MOISTURE_2 : l_MOISTURE_Val[1],
					MOISTURE_3 : l_MOISTURE_Val[2],
					MOISTURE_4 : l_MOISTURE_Val[3],
					MOISTURE_5 : l_MOISTURE_Val[4],
					MOISTURE_6 : l_MOISTURE_Val[5],
					MOISTURE_7 : l_MOISTURE_Val[6],
					MOISTURE_8 : l_MOISTURE_Val[7],
					MOISTURE_9 : l_MOISTURE_Val[8],
					MOISTURE_10 : l_MOISTURE_Val[9],
					MOISTURE_11 : l_MOISTURE_Val[10],
					MOISTURE_12 : l_MOISTURE_Val[11],
					MOISTURE_13 : l_MOISTURE_Val[12],
					MOISTURE_14 : l_MOISTURE_Val[13],
					MOISTURE_15 : l_MOISTURE_Val[14],
					MOISTURE_16 : l_MOISTURE_Val[15],
					MOISTURE_17 : l_MOISTURE_Val[16],
					MOISTURE_18 : l_MOISTURE_Val[17],
					MOISTURE_19 : l_MOISTURE_Val[18],
					MOISTURE_20 : l_MOISTURE_Val[19],
					MOISTURE_21 : l_MOISTURE_Val[20],
					MOISTURE_22 : l_MOISTURE_Val[21],
					MOISTURE_23 : l_MOISTURE_Val[22],
					MOISTURE_24 : l_MOISTURE_Val[23],
					MOISTURE_25 : l_MOISTURE_Val[24],
					MOISTURE_26 : l_MOISTURE_Val[25],
					MOISTURE_27 : l_MOISTURE_Val[26],
					MOISTURE_28 : l_MOISTURE_Val[27],
					MOISTURE_29 : l_MOISTURE_Val[28],
					MOISTURE_30 : l_MOISTURE_Val[29],
					DMT_1 : l_DMT_Val[0],
					DMT_2 : l_DMT_Val[1],
					DMT_3 : l_DMT_Val[2],
					DMT_4 : l_DMT_Val[3],
					DMT_5 : l_DMT_Val[4],
					DMT_6 : l_DMT_Val[5],
					DMT_7 : l_DMT_Val[6],
					DMT_8 : l_DMT_Val[7],
					DMT_9 : l_DMT_Val[8],
					DMT_10 : l_DMT_Val[9],
					DMT_11 : l_DMT_Val[10],
					DMT_12 : l_DMT_Val[11],
					DMT_13 : l_DMT_Val[12],
					DMT_14 : l_DMT_Val[13],
					DMT_15 : l_DMT_Val[14],
					DMT_16 : l_DMT_Val[15],
					DMT_17 : l_DMT_Val[16],
					DMT_18 : l_DMT_Val[17],
					DMT_19 : l_DMT_Val[18],
					DMT_20 : l_DMT_Val[19],
					DMT_21 : l_DMT_Val[20],
					DMT_22 : l_DMT_Val[21],
					DMT_23 : l_DMT_Val[22],
					DMT_24 : l_DMT_Val[23],
					DMT_25 : l_DMT_Val[24],
					DMT_26 : l_DMT_Val[25],
					DMT_27 : l_DMT_Val[26],
					DMT_28 : l_DMT_Val[27],
					DMT_29 : l_DMT_Val[28],
					DMT_30 : l_DMT_Val[29],
					_csrf : '${_csrf.token}'
					},
				dataType : "json",
				success : function(result) {
					opener.load_bl_grid();
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

		function closePopup() {
			self.close();	
		}

		function load_mt_info() {
			$.ajax({
				url : "/yp/zpp/ore/zpp_ore_req_mt_info",
				type : "POST",
			    cache:false,
			    async:true, 
				data : {
					MASTER_ID : l_MASTER_ID,
					_csrf : '${_csrf.token}'
					},
				dataType : "json",
				success : function(result) {
					//	console.log("/yp/zpp/ore/zpp_ore_req_mt_info success : " + result.data_count);

					if(result.data_count > 0) {
						//	UPDATE MODE
						l_EditMode = 2;

						l_LOT_COUNT = result.data.LOT_COUNT;

						var countSel = document.getElementById("sel_LC");
						countSel.value = l_LOT_COUNT;
						
						setLotCountTable(l_LOT_COUNT);						

						l_WMT_Val[ 0] = result.data.WMT_1;
						l_WMT_Val[ 1] = result.data.WMT_2;
						l_WMT_Val[ 2] = result.data.WMT_3;
						l_WMT_Val[ 3] = result.data.WMT_4;
						l_WMT_Val[ 4] = result.data.WMT_5;
						l_WMT_Val[ 5] = result.data.WMT_6;
						l_WMT_Val[ 6] = result.data.WMT_7;
						l_WMT_Val[ 7] = result.data.WMT_8;
						l_WMT_Val[ 8] = result.data.WMT_9;
						l_WMT_Val[ 9] = result.data.WMT_10;
						l_WMT_Val[10] = result.data.WMT_11;
						l_WMT_Val[11] = result.data.WMT_12;
						l_WMT_Val[12] = result.data.WMT_13;
						l_WMT_Val[13] = result.data.WMT_14;
						l_WMT_Val[14] = result.data.WMT_15;
						l_WMT_Val[15] = result.data.WMT_16;
						l_WMT_Val[16] = result.data.WMT_17;
						l_WMT_Val[17] = result.data.WMT_18;
						l_WMT_Val[18] = result.data.WMT_19;
						l_WMT_Val[19] = result.data.WMT_20;
						l_WMT_Val[20] = result.data.WMT_21;
						l_WMT_Val[21] = result.data.WMT_22;
						l_WMT_Val[22] = result.data.WMT_23;
						l_WMT_Val[23] = result.data.WMT_24;
						l_WMT_Val[24] = result.data.WMT_25;
						l_WMT_Val[25] = result.data.WMT_26;
						l_WMT_Val[26] = result.data.WMT_27;
						l_WMT_Val[27] = result.data.WMT_28;
						l_WMT_Val[28] = result.data.WMT_29;
						l_WMT_Val[29] = result.data.WMT_30;
						l_MOISTURE_Val[ 0] = result.data.MOISTURE_1;
						l_MOISTURE_Val[ 1] = result.data.MOISTURE_2;
						l_MOISTURE_Val[ 2] = result.data.MOISTURE_3;
						l_MOISTURE_Val[ 3] = result.data.MOISTURE_4;
						l_MOISTURE_Val[ 4] = result.data.MOISTURE_5;
						l_MOISTURE_Val[ 5] = result.data.MOISTURE_6;
						l_MOISTURE_Val[ 6] = result.data.MOISTURE_7;
						l_MOISTURE_Val[ 7] = result.data.MOISTURE_8;
						l_MOISTURE_Val[ 8] = result.data.MOISTURE_9;
						l_MOISTURE_Val[ 9] = result.data.MOISTURE_10;
						l_MOISTURE_Val[10] = result.data.MOISTURE_11;
						l_MOISTURE_Val[11] = result.data.MOISTURE_12;
						l_MOISTURE_Val[12] = result.data.MOISTURE_13;
						l_MOISTURE_Val[13] = result.data.MOISTURE_14;
						l_MOISTURE_Val[14] = result.data.MOISTURE_15;
						l_MOISTURE_Val[15] = result.data.MOISTURE_16;
						l_MOISTURE_Val[16] = result.data.MOISTURE_17;
						l_MOISTURE_Val[17] = result.data.MOISTURE_18;
						l_MOISTURE_Val[18] = result.data.MOISTURE_19;
						l_MOISTURE_Val[19] = result.data.MOISTURE_20;
						l_MOISTURE_Val[20] = result.data.MOISTURE_21;
						l_MOISTURE_Val[21] = result.data.MOISTURE_22;
						l_MOISTURE_Val[22] = result.data.MOISTURE_23;
						l_MOISTURE_Val[23] = result.data.MOISTURE_24;
						l_MOISTURE_Val[24] = result.data.MOISTURE_25;
						l_MOISTURE_Val[25] = result.data.MOISTURE_26;
						l_MOISTURE_Val[26] = result.data.MOISTURE_27;
						l_MOISTURE_Val[27] = result.data.MOISTURE_28;
						l_MOISTURE_Val[28] = result.data.MOISTURE_29;
						l_MOISTURE_Val[29] = result.data.MOISTURE_30;
						l_DMT_Val[ 0] = result.data.DMT_1;
						l_DMT_Val[ 1] = result.data.DMT_2;
						l_DMT_Val[ 2] = result.data.DMT_3;
						l_DMT_Val[ 3] = result.data.DMT_4;
						l_DMT_Val[ 4] = result.data.DMT_5;
						l_DMT_Val[ 5] = result.data.DMT_6;
						l_DMT_Val[ 6] = result.data.DMT_7;
						l_DMT_Val[ 7] = result.data.DMT_8;
						l_DMT_Val[ 8] = result.data.DMT_9;
						l_DMT_Val[ 9] = result.data.DMT_10;
						l_DMT_Val[10] = result.data.DMT_11;
						l_DMT_Val[11] = result.data.DMT_12;
						l_DMT_Val[12] = result.data.DMT_13;
						l_DMT_Val[13] = result.data.DMT_14;
						l_DMT_Val[14] = result.data.DMT_15;
						l_DMT_Val[15] = result.data.DMT_16;
						l_DMT_Val[16] = result.data.DMT_17;
						l_DMT_Val[17] = result.data.DMT_18;
						l_DMT_Val[18] = result.data.DMT_19;
						l_DMT_Val[19] = result.data.DMT_20;
						l_DMT_Val[20] = result.data.DMT_21;
						l_DMT_Val[21] = result.data.DMT_22;
						l_DMT_Val[22] = result.data.DMT_23;
						l_DMT_Val[23] = result.data.DMT_24;
						l_DMT_Val[24] = result.data.DMT_25;
						l_DMT_Val[25] = result.data.DMT_26;
						l_DMT_Val[26] = result.data.DMT_27;
						l_DMT_Val[27] = result.data.DMT_28;
						l_DMT_Val[28] = result.data.DMT_29;
						l_DMT_Val[29] = result.data.DMT_30;
					}
					else {
						//	INSERT MODE
						l_EditMode = 1;
						l_LOT_COUNT = 0;

						for(var si = 0;si < 30;si ++) {
							l_WMT_Val[si] = 0;
							l_MOISTURE_Val[si] = 0;
							l_DMT_Val[si] = 0;
						}
					}

					display_mt_info();
				},
				error : function(request, status, error) {
					//	console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
				}
			});
		}

		function set_Value() {
			l_MASTER_ID = '${req_data.MASTER_ID}';
			document.getElementById("edt_MATERIAL_ID").value = get_material_name('${req_data.MATERIAL_ID}', '${req_data.SHEET_ID}');
			document.getElementById("edt_SELLER_ID").value = get_seller_name('${req_data.SELLER_ID}');
			document.getElementById("edt_IMPORT_DATE").value = '${req_data.IMPORT_DATE}';

			//	console.log(l_MASTER_ID);
		}

		function get_material_name(material_id, sheet_id) {
			var sheet_str;
			
			if(sheet_id == "0") sheet_str = "";
			else sheet_str = "(" + sheet_id + ")";

			for(var i = 0;i < l_MaterialID.length;i ++) {
				if(l_MaterialID[i] == material_id) return l_MaterialName[i] + sheet_str;
			}
			return material_id + sheet_str;
		};

		function get_seller_name(seller_id) {
			for(var i = 0;i < l_SellerID.length;i ++) {
				if(l_SellerID[i] == seller_id) return l_SellerName[i];
			}
			return seller_id;
		};

		// 부트스트랩 날짜객체
		$(".dtp").datepicker({
			format : "yyyy/mm/dd",
			language : "ko",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		}).on('changeDate', function(){
		 	$('.datepicker').hide();
		});

		function getMaterialList()
		{
			$.ajax({
				url : "/yp/zpp/ore/zpp_ore_get_material_list",
				type : "POST",
				cache : false,
				async : false,
				data : {
					_csrf : '${_csrf.token}'
				},
				dataType : "json",
				success : function(result) {
					for (var i in result.listValue) {
						var material_id = result.listValue[i].MATERIAL_ID;
						var material_name = result.listValue[i].MATERIAL_NAME;

						l_MaterialName[i] = material_name;
						l_MaterialID[i] = material_id;
					}
				},
				error : function(request, status, error) {
					//	console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
				}
			});
		}

		function getSellerList()
		{
			$.ajax({
				url : "/yp/zpp/ore/zpp_ore_get_seller_list",
				type : "POST",
				cache : false,
				async : false,
				data : {
					_csrf : '${_csrf.token}'
				},
				dataType : "json",
				success : function(result) {
					for (var i in result.listValue) {
						var seller_id = result.listValue[i].SELLER_ID;
						var seller_name = result.listValue[i].SELLER_NAME;

						l_SellerName[i] = seller_name;
						l_SellerID[i] = seller_id;
					}
				},
				error : function(request, status, error) {
					//	console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
				}
			});
		}

		$(document).ready(function() {
			getMaterialList();
			getSellerList();

			set_Value();
			load_mt_info();
		});

		opener.popup = this;
	</script>
</body>
</html>