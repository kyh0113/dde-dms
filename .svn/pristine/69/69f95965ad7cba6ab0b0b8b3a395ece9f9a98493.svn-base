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
	<title>정광 심판판정 결과등록</title>
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
			font-size:1.5rem; width:20px; color:white; text-align:center; vertical-align:middle; background-color:#588CFC; font-weight:bold;
		}
		.tbl_def
		{
			height:30px
		}
		.label_cell {
			height:16px; width:100%; border:0; text-align:center;  readonly;
		}
	</style>

	<div id="popup">
		<div class="pop_header">
			정광 심판판정 결과등록
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
									<input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_MATERIAL_ID">
								</td>
								<th>업체명</th>
								<td>
									<input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_SELLER_ID">
								</td>
								<th>입항일자</th>
								<td>
									<input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IMPORT_DATE">
								</td>
								<th>LOT COUNT</th>
								<td>
									<input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_LOT_COUNT">
								</td>
							</tr>
						</table>

						<div style="height:15px; background-color:white"></div>
					</div>
				</section>
			</div>

			<div style="height:5px; background-color:white"></div>

			<div class="btn_wrap">
				<button class="btn btn_search" id="register_btn" type="">심판 판정 결과 등록</button>
			</div>

			<div style="height:5px; background-color:white"></div>

			<table>
				<tr>
					<table id="table_1" class=tbl_def>
						<colgroup>
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
						</colgroup>
					</table>
				</tr>

				<div style="height:25px; background-color:white"></div>

				<tr>
					<table id="table_2" class=tbl_def>
						<colgroup>
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
						</colgroup>
					</table>
				</tr>

				<div style="height:25px; background-color:white"></div>

				<tr>
					<table id="table_3" class=tbl_def>
						<colgroup>
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
						</colgroup>
					</table>
				</tr>

				<div style="height:25px; background-color:white"></div>

				<tr>
					<table id="table_4" class=tbl_def>
						<colgroup>
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
						</colgroup>
					</table>
				</tr>
			</table>
		</div>
	</div>
	<script>
		var l_MASTER_ID;
		var l_MaterialName = new Array();
		var l_MaterialID = new Array();
		var l_SellerName = new Array();
		var l_SellerID = new Array();

		//	1:INSERT, 2:UPDATE
		var l_EditMode = 1;

		var l_LOT_COUNT;

		var l_Umpire_Res = create2DArray(30, 4);
		var l_Umpire_YP = create2DArray(30, 4);
		var l_Umpire_SL = create2DArray(30, 4);
		var l_DMT = create2DArray(30, 4);
		var l_YP = create2DArray(30, 4);
		var l_SELLER = create2DArray(30, 4);
		var l_SETTLE = create2DArray(30, 4);
		var l_UMPIRE = create2DArray(30, 4);
		var l_STATE = create2DArray(30, 4);

		var l_INGREDIENT_CNT;
		var l_INGREDIENT_ID = new Array();
		var	l_INGREDIENT_NAME = new Array();

		function create2DArray(rows, columns) {
		    var arr = new Array(rows);
		    for (var i = 0; i < rows; i++) {
		        arr[i] = new Array(columns);
		    }
	
		    return arr;
		}

		function AddColumn(row, contents)
		{
			var table_data = document.createElement('td');

			table_data.innerHTML = contents;
			row.appendChild(table_data);
		}

		function numberMaxLength(e) {
			if(e.value.length > e.maxLength) {
				e.value = e.value.slice(0, e.maxLength);
	        }
	    }

		function
		setLotCountTable(lotCount)
		{
			for(var tableIdx = 0;tableIdx < l_INGREDIENT_CNT;tableIdx ++)
			{
				var table = document.getElementById('table_' + String(Number(tableIdx) + 1));
				var row_count = table.rows.length;
	
				for(var ri = 0;ri < row_count;ri ++) table.deleteRow(0);
	
				var row1 = document.createElement('tr');
	
				AddColumn(row1, "Lot");
				AddColumn(row1, "DMT");
				AddColumn(row1, "YP");
				AddColumn(row1, "SELLER");
				AddColumn(row1, "SPLIT");
				AddColumn(row1, "AVERAGE");
				AddColumn(row1, "SELLER의견");
				AddColumn(row1, "YP의견");
				AddColumn(row1, "SETTLE");
				AddColumn(row1, "UMPIRE");

				table.appendChild(row1);
	
				for(var i = 0;i < lotCount; i ++)
				{
					idx = Number(i) + 1;
	
					var table_row = document.createElement('tr');
	
					AddColumn(table_row, idx);

					cid = 'edt_dmt_' + (idx).toString() + '_' + String(tableIdx + 1);
					AddColumn(table_row, '<td><input readonly onfocus="this.blur()" style="color:black; font-weight:bold; border:0px; background-color:transparent; width:70px;" id="' + cid + '"></td>');

					cid = 'edt_yp_' + (idx).toString() + '_' + String(tableIdx + 1);
					AddColumn(table_row, '<td><input readonly onfocus="this.blur()" style="color:black; font-weight:bold; border:0px; background-color:transparent; width:70px;" id="' + cid + '"></td>');

					cid = 'edt_seller_' + (idx).toString() + '_' + String(tableIdx + 1);
					AddColumn(table_row, '<td><input readonly onfocus="this.blur()" style="color:black; font-weight:bold; border:0px; background-color:transparent; width:70px;" id="' + cid + '"></td>');

					cid = 'edt_split_' + (idx).toString() + '_' + String(tableIdx + 1);
					AddColumn(table_row, '<td><input readonly onfocus="this.blur()" style="color:black; font-weight:bold; border:0px; background-color:transparent; width:70px;" id="' + cid + '"></td>');

					cid = 'edt_average_' + (idx).toString() + '_' + String(tableIdx + 1);
					AddColumn(table_row, '<td><input readonly onfocus="this.blur()" style="color:black; font-weight:bold; border:0px; background-color:transparent; width:70px;" id="' + cid + '"></td>');

					cid = 'edt_seller_action_' + (idx).toString() + '_' + String(tableIdx + 1);
					AddColumn(table_row, '<td><input readonly onfocus="this.blur()" style="color:black; font-weight:bold; border:0px; background-color:transparent; width:80px;" id="' + cid + '"></td>');

					cid = 'edt_yp_action_' + (idx).toString() + '_' + String(tableIdx + 1);
					AddColumn(table_row, '<td><input readonly onfocus="this.blur()" style="color:black; font-weight:bold; border:0px; background-color:transparent; width:80px;" id="' + cid + '"></td>');

					cid = 'edt_settle_' + (idx).toString() + '_' + String(tableIdx + 1);
					AddColumn(table_row, '<td><input readonly onfocus="this.blur()" style="color:black; font-weight:bold; border:0px; background-color:transparent; width:70px;" id="' + cid + '"></td>');

					var onChgStr = 'onchange="onChgUmpire(' + (i).toString() + ', ' + (tableIdx).toString() + ');"';

					AddColumn(table_row, '<td><input type="number" maxlength="10" oninput="numberMaxLength(this);" id="edt_umpire_' + (idx).toString() + '_' + String(Number(tableIdx) + 1) + '" ' + onChgStr + '></td>');

					table.appendChild(table_row);						
				}
			}
		}

		function onChgUmpire(idx1, idx2) {
			var settle, umpire, yp_u, seller_u;
			var cn;
			var objStr = 'edt_umpire_' + (idx1 + 1).toString() + '_' + (idx2 + 1).toString();

			umpire = Number(get_NS(objStr));
			yp_u = Number(l_YP[idx1][idx2]) - Number(umpire);
			seller_u = Number(l_SELLER[idx1][idx2]) - Number(umpire);

			if(Math.abs(yp_u) > Math.abs(seller_u))
			{
				//	loose
				settle = Number(Number(l_SELLER[idx1][idx2]) + umpire) / 2;
				l_STATE[idx1][idx2] = 2;
			}
			else if(Math.abs(yp_u) == Math.abs(seller_u))
			{
				settle = Number(Number(l_SELLER[idx1][idx2]) + umpire) / 2;
				l_STATE[idx1][idx2] = 0;
			}
			else
			{
				settle = Number(Number(l_YP[idx1][idx2]) + umpire) / 2;
				l_STATE[idx1][idx2] = 1;
			}

			//	console.log('onChgUmpire : ' + umpire + ',' + yp_u + ',' + seller_u + ',' + settle);

			l_UMPIRE[idx1][idx2] = umpire;			
			l_SETTLE[idx1][idx2] = settle;

			cn = "edt_settle_" + (idx1 + 1).toString() + "_" + (idx2 + 1).toString();
			set_NS(cn, settle);
		}

		function get_Values() {
		}

		function closePopup() {
			self.close();	
		}

		function load_ingredient_info() {
			$.ajax({
				url : "/yp/zpp/ore/zpp_ore_req_ig_list",
				type : "POST",
				cache : false,
				async : false,
				data : {
					MASTER_ID : l_MASTER_ID,
					_csrf : '${_csrf.token}'
				},
				dataType : "json",
				success : function(result) {
					//	console.log("/yp/zpp/ore/zpp_ore_req_ig_list success : " + result.ig_list);

					l_INGREDIENT_CNT = result.ig_list.length;

					for (var i in result.ig_list) {
						l_INGREDIENT_ID[i] = result.ig_list[i].INGREDIENT_ID;
						l_INGREDIENT_NAME[i] = result.ig_list[i].INGREDIENT_NAME;

						//	console.log(l_INGREDIENT_ID[i] + " " + l_INGREDIENT_NAME[i]);
					}
				},
				error : function(request, status, error) {
					//	console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
				}
			});
		}

		function load_Def() {
			for(var i = 0;i < 30; i ++) {
				l_Umpire_YP[i][0] = 0;
				l_Umpire_YP[i][1] = 0;
				l_Umpire_YP[i][2] = 0;
				l_Umpire_YP[i][3] = 0;

				l_Umpire_SL[i][0] = 0;
				l_Umpire_SL[i][1] = 0;
				l_Umpire_SL[i][2] = 0;
				l_Umpire_SL[i][3] = 0;

				l_SETTLE[i][0] = 0;
				l_SETTLE[i][1] = 0;
				l_SETTLE[i][2] = 0;
				l_SETTLE[i][3] = 0;

				l_UMPIRE[i][0] = 0;
				l_UMPIRE[i][1] = 0;
				l_UMPIRE[i][2] = 0;
				l_UMPIRE[i][3] = 0;

				l_STATE[i][0] = 0;
				l_STATE[i][1] = 0;
				l_STATE[i][2] = 0;
				l_STATE[i][3] = 0;
			}
		}

		function
		load_InitValue() {
			$.ajax({
				url : "/yp/zpp/ore/zpp_ore_get_umpire_result",
				type : "POST",
			    cache:false,
			    async:true, 
				data : {
					MASTER_ID : l_MASTER_ID,
					_csrf : '${_csrf.token}'
					},
				dataType : "json",
				success : function(result) {
					//	console.log("/yp/zpp/ore/zpp_ore_get_umpire_result");

					//	console.log(result);
					
					l_LOT_COUNT = result.LOT_COUNT;
					document.getElementById("edt_LOT_COUNT").value = l_LOT_COUNT;
					setLotCountTable(l_LOT_COUNT);

					l_DMT[ 0][0] = result.DMT_1_1;
					l_DMT[ 1][0] = result.DMT_2_1;
					l_DMT[ 2][0] = result.DMT_3_1;
					l_DMT[ 3][0] = result.DMT_4_1;
					l_DMT[ 4][0] = result.DMT_5_1;
					l_DMT[ 5][0] = result.DMT_6_1;
					l_DMT[ 6][0] = result.DMT_7_1;
					l_DMT[ 7][0] = result.DMT_8_1;
					l_DMT[ 8][0] = result.DMT_9_1;
					l_DMT[ 9][0] = result.DMT_10_1;
					l_DMT[10][0] = result.DMT_11_1;
					l_DMT[11][0] = result.DMT_12_1;
					l_DMT[12][0] = result.DMT_13_1;
					l_DMT[13][0] = result.DMT_14_1;
					l_DMT[14][0] = result.DMT_15_1;
					l_DMT[15][0] = result.DMT_16_1;
					l_DMT[16][0] = result.DMT_17_1;
					l_DMT[17][0] = result.DMT_18_1;
					l_DMT[18][0] = result.DMT_19_1;
					l_DMT[19][0] = result.DMT_20_1;
					l_DMT[20][0] = result.DMT_21_1;
					l_DMT[21][0] = result.DMT_22_1;

					l_YP[ 0][0] = result.YP_1_1;
					l_YP[ 1][0] = result.YP_2_1;
					l_YP[ 2][0] = result.YP_3_1;
					l_YP[ 3][0] = result.YP_4_1;
					l_YP[ 4][0] = result.YP_5_1;
					l_YP[ 5][0] = result.YP_6_1;
					l_YP[ 6][0] = result.YP_7_1;
					l_YP[ 7][0] = result.YP_8_1;
					l_YP[ 8][0] = result.YP_9_1;
					l_YP[ 9][0] = result.YP_10_1;
					l_YP[10][0] = result.YP_11_1;
					l_YP[11][0] = result.YP_12_1;
					l_YP[12][0] = result.YP_13_1;
					l_YP[13][0] = result.YP_14_1;
					l_YP[14][0] = result.YP_15_1;
					l_YP[15][0] = result.YP_16_1;
					l_YP[16][0] = result.YP_17_1;
					l_YP[17][0] = result.YP_18_1;
					l_YP[18][0] = result.YP_19_1;
					l_YP[19][0] = result.YP_20_1;
					l_YP[20][0] = result.YP_21_1;
					l_YP[21][0] = result.YP_22_1;

					l_SELLER[ 0][0] = result.SELLER_1_1;
					l_SELLER[ 1][0] = result.SELLER_2_1;
					l_SELLER[ 2][0] = result.SELLER_3_1;
					l_SELLER[ 3][0] = result.SELLER_4_1;
					l_SELLER[ 4][0] = result.SELLER_5_1;
					l_SELLER[ 5][0] = result.SELLER_6_1;
					l_SELLER[ 6][0] = result.SELLER_7_1;
					l_SELLER[ 7][0] = result.SELLER_8_1;
					l_SELLER[ 8][0] = result.SELLER_9_1;
					l_SELLER[ 9][0] = result.SELLER_10_1;
					l_SELLER[10][0] = result.SELLER_11_1;
					l_SELLER[11][0] = result.SELLER_12_1;
					l_SELLER[12][0] = result.SELLER_13_1;
					l_SELLER[13][0] = result.SELLER_14_1;
					l_SELLER[14][0] = result.SELLER_15_1;
					l_SELLER[15][0] = result.SELLER_16_1;
					l_SELLER[16][0] = result.SELLER_17_1;
					l_SELLER[17][0] = result.SELLER_18_1;
					l_SELLER[18][0] = result.SELLER_19_1;
					l_SELLER[19][0] = result.SELLER_20_1;
					l_SELLER[20][0] = result.SELLER_21_1;
					l_SELLER[21][0] = result.SELLER_22_1;

					l_Umpire_YP[0][0] = result.YP_ACTION_1_1;
					l_Umpire_YP[1][0] = result.YP_ACTION_2_1;
					l_Umpire_YP[2][0] = result.YP_ACTION_3_1;
					l_Umpire_YP[3][0] = result.YP_ACTION_4_1;
					l_Umpire_YP[4][0] = result.YP_ACTION_5_1;
					l_Umpire_YP[5][0] = result.YP_ACTION_6_1;
					l_Umpire_YP[6][0] = result.YP_ACTION_7_1;
					l_Umpire_YP[7][0] = result.YP_ACTION_8_1;
					l_Umpire_YP[8][0] = result.YP_ACTION_9_1;
					l_Umpire_YP[9][0] = result.YP_ACTION_10_1;
					l_Umpire_YP[10][0] = result.YP_ACTION_11_1;
					l_Umpire_YP[11][0] = result.YP_ACTION_12_1;
					l_Umpire_YP[12][0] = result.YP_ACTION_13_1;
					l_Umpire_YP[13][0] = result.YP_ACTION_14_1;
					l_Umpire_YP[14][0] = result.YP_ACTION_15_1;
					l_Umpire_YP[15][0] = result.YP_ACTION_16_1;
					l_Umpire_YP[16][0] = result.YP_ACTION_17_1;
					l_Umpire_YP[17][0] = result.YP_ACTION_18_1;
					l_Umpire_YP[18][0] = result.YP_ACTION_19_1;
					l_Umpire_YP[19][0] = result.YP_ACTION_20_1;
					l_Umpire_YP[20][0] = result.YP_ACTION_21_1;
					l_Umpire_YP[21][0] = result.YP_ACTION_22_1;

					l_Umpire_SL[0][0] = result.SELLER_ACTION_1_1;
					l_Umpire_SL[1][0] = result.SELLER_ACTION_2_1;
					l_Umpire_SL[2][0] = result.SELLER_ACTION_3_1;
					l_Umpire_SL[3][0] = result.SELLER_ACTION_4_1;
					l_Umpire_SL[4][0] = result.SELLER_ACTION_5_1;
					l_Umpire_SL[5][0] = result.SELLER_ACTION_6_1;
					l_Umpire_SL[6][0] = result.SELLER_ACTION_7_1;
					l_Umpire_SL[7][0] = result.SELLER_ACTION_8_1;
					l_Umpire_SL[8][0] = result.SELLER_ACTION_9_1;
					l_Umpire_SL[9][0] = result.SELLER_ACTION_10_1;
					l_Umpire_SL[10][0] = result.SELLER_ACTION_11_1;
					l_Umpire_SL[11][0] = result.SELLER_ACTION_12_1;
					l_Umpire_SL[12][0] = result.SELLER_ACTION_13_1;
					l_Umpire_SL[13][0] = result.SELLER_ACTION_14_1;
					l_Umpire_SL[14][0] = result.SELLER_ACTION_15_1;
					l_Umpire_SL[15][0] = result.SELLER_ACTION_16_1;
					l_Umpire_SL[16][0] = result.SELLER_ACTION_17_1;
					l_Umpire_SL[17][0] = result.SELLER_ACTION_18_1;
					l_Umpire_SL[18][0] = result.SELLER_ACTION_19_1;
					l_Umpire_SL[19][0] = result.SELLER_ACTION_20_1;
					l_Umpire_SL[20][0] = result.SELLER_ACTION_21_1;
					l_Umpire_SL[21][0] = result.SELLER_ACTION_22_1;

					l_SETTLE[0][0] = result.SETTLE_1_1;
					l_SETTLE[1][0] = result.SETTLE_2_1;
					l_SETTLE[2][0] = result.SETTLE_3_1;
					l_SETTLE[3][0] = result.SETTLE_4_1;
					l_SETTLE[4][0] = result.SETTLE_5_1;
					l_SETTLE[5][0] = result.SETTLE_6_1;
					l_SETTLE[6][0] = result.SETTLE_7_1;
					l_SETTLE[7][0] = result.SETTLE_8_1;
					l_SETTLE[8][0] = result.SETTLE_9_1;
					l_SETTLE[9][0] = result.SETTLE_10_1;
					l_SETTLE[10][0] = result.SETTLE_11_1;
					l_SETTLE[11][0] = result.SETTLE_12_1;
					l_SETTLE[12][0] = result.SETTLE_13_1;
					l_SETTLE[13][0] = result.SETTLE_14_1;
					l_SETTLE[14][0] = result.SETTLE_15_1;
					l_SETTLE[15][0] = result.SETTLE_16_1;
					l_SETTLE[16][0] = result.SETTLE_17_1;
					l_SETTLE[17][0] = result.SETTLE_18_1;
					l_SETTLE[18][0] = result.SETTLE_19_1;
					l_SETTLE[19][0] = result.SETTLE_20_1;
					l_SETTLE[20][0] = result.SETTLE_21_1;
					l_SETTLE[21][0] = result.SETTLE_22_1;

					l_UMPIRE[0][0] = result.UMPIRE_1_1;
					l_UMPIRE[1][0] = result.UMPIRE_2_1;
					l_UMPIRE[2][0] = result.UMPIRE_3_1;
					l_UMPIRE[3][0] = result.UMPIRE_4_1;
					l_UMPIRE[4][0] = result.UMPIRE_5_1;
					l_UMPIRE[5][0] = result.UMPIRE_6_1;
					l_UMPIRE[6][0] = result.UMPIRE_7_1;
					l_UMPIRE[7][0] = result.UMPIRE_8_1;
					l_UMPIRE[8][0] = result.UMPIRE_9_1;
					l_UMPIRE[9][0] = result.UMPIRE_10_1;
					l_UMPIRE[10][0] = result.UMPIRE_11_1;
					l_UMPIRE[11][0] = result.UMPIRE_12_1;
					l_UMPIRE[12][0] = result.UMPIRE_13_1;
					l_UMPIRE[13][0] = result.UMPIRE_14_1;
					l_UMPIRE[14][0] = result.UMPIRE_15_1;
					l_UMPIRE[15][0] = result.UMPIRE_16_1;
					l_UMPIRE[16][0] = result.UMPIRE_17_1;
					l_UMPIRE[17][0] = result.UMPIRE_18_1;
					l_UMPIRE[18][0] = result.UMPIRE_19_1;
					l_UMPIRE[19][0] = result.UMPIRE_20_1;
					l_UMPIRE[20][0] = result.UMPIRE_21_1;
					l_UMPIRE[21][0] = result.UMPIRE_22_1;

					l_STATE[0][0] = result.STATE_1_1;
					l_STATE[1][0] = result.STATE_2_1;
					l_STATE[2][0] = result.STATE_3_1;
					l_STATE[3][0] = result.STATE_4_1;
					l_STATE[4][0] = result.STATE_5_1;
					l_STATE[5][0] = result.STATE_6_1;
					l_STATE[6][0] = result.STATE_7_1;
					l_STATE[7][0] = result.STATE_8_1;
					l_STATE[8][0] = result.STATE_9_1;
					l_STATE[9][0] = result.STATE_10_1;
					l_STATE[10][0] = result.STATE_11_1;
					l_STATE[11][0] = result.STATE_12_1;
					l_STATE[12][0] = result.STATE_13_1;
					l_STATE[13][0] = result.STATE_14_1;
					l_STATE[14][0] = result.STATE_15_1;
					l_STATE[15][0] = result.STATE_16_1;
					l_STATE[16][0] = result.STATE_17_1;
					l_STATE[17][0] = result.STATE_18_1;
					l_STATE[18][0] = result.STATE_19_1;
					l_STATE[19][0] = result.STATE_20_1;
					l_STATE[20][0] = result.STATE_21_1;
					l_STATE[21][0] = result.STATE_22_1;

					l_DMT[ 0][1] = result.DMT_1_2;
					l_DMT[ 1][1] = result.DMT_2_2;
					l_DMT[ 2][1] = result.DMT_3_2;
					l_DMT[ 3][1] = result.DMT_4_2;
					l_DMT[ 4][1] = result.DMT_5_2;
					l_DMT[ 5][1] = result.DMT_6_2;
					l_DMT[ 6][1] = result.DMT_7_2;
					l_DMT[ 7][1] = result.DMT_8_2;
					l_DMT[ 8][1] = result.DMT_9_2;
					l_DMT[ 9][1] = result.DMT_10_2;
					l_DMT[10][1] = result.DMT_11_2;
					l_DMT[11][1] = result.DMT_12_2;
					l_DMT[12][1] = result.DMT_13_2;
					l_DMT[13][1] = result.DMT_14_2;
					l_DMT[14][1] = result.DMT_15_2;
					l_DMT[15][1] = result.DMT_16_2;
					l_DMT[16][1] = result.DMT_17_2;
					l_DMT[17][1] = result.DMT_18_2;
					l_DMT[18][1] = result.DMT_19_2;
					l_DMT[19][1] = result.DMT_20_2;
					l_DMT[20][1] = result.DMT_21_2;
					l_DMT[21][1] = result.DMT_22_2;

					l_YP[ 0][1] = result.YP_1_2;
					l_YP[ 1][1] = result.YP_2_2;
					l_YP[ 2][1] = result.YP_3_2;
					l_YP[ 3][1] = result.YP_4_2;
					l_YP[ 4][1] = result.YP_5_2;
					l_YP[ 5][1] = result.YP_6_2;
					l_YP[ 6][1] = result.YP_7_2;
					l_YP[ 7][1] = result.YP_8_2;
					l_YP[ 8][1] = result.YP_9_2;
					l_YP[ 9][1] = result.YP_10_2;
					l_YP[10][1] = result.YP_11_2;
					l_YP[11][1] = result.YP_12_2;
					l_YP[12][1] = result.YP_13_2;
					l_YP[13][1] = result.YP_14_2;
					l_YP[14][1] = result.YP_15_2;
					l_YP[15][1] = result.YP_16_2;
					l_YP[16][1] = result.YP_17_2;
					l_YP[17][1] = result.YP_18_2;
					l_YP[18][1] = result.YP_19_2;
					l_YP[19][1] = result.YP_20_2;
					l_YP[20][1] = result.YP_21_2;
					l_YP[21][1] = result.YP_22_2;

					l_SELLER[ 0][1] = result.SELLER_1_2;
					l_SELLER[ 1][1] = result.SELLER_2_2;
					l_SELLER[ 2][1] = result.SELLER_3_2;
					l_SELLER[ 3][1] = result.SELLER_4_2;
					l_SELLER[ 4][1] = result.SELLER_5_2;
					l_SELLER[ 5][1] = result.SELLER_6_2;
					l_SELLER[ 6][1] = result.SELLER_7_2;
					l_SELLER[ 7][1] = result.SELLER_8_2;
					l_SELLER[ 8][1] = result.SELLER_9_2;
					l_SELLER[ 9][1] = result.SELLER_10_2;
					l_SELLER[10][1] = result.SELLER_11_2;
					l_SELLER[11][1] = result.SELLER_12_2;
					l_SELLER[12][1] = result.SELLER_13_2;
					l_SELLER[13][1] = result.SELLER_14_2;
					l_SELLER[14][1] = result.SELLER_15_2;
					l_SELLER[15][1] = result.SELLER_16_2;
					l_SELLER[16][1] = result.SELLER_17_2;
					l_SELLER[17][1] = result.SELLER_18_2;
					l_SELLER[18][1] = result.SELLER_19_2;
					l_SELLER[19][1] = result.SELLER_20_2;
					l_SELLER[20][1] = result.SELLER_21_2;
					l_SELLER[21][1] = result.SELLER_22_2;

					l_Umpire_YP[0][1] = result.YP_ACTION_1_2;
					l_Umpire_YP[1][1] = result.YP_ACTION_2_2;
					l_Umpire_YP[2][1] = result.YP_ACTION_3_2;
					l_Umpire_YP[3][1] = result.YP_ACTION_4_2;
					l_Umpire_YP[4][1] = result.YP_ACTION_5_2;
					l_Umpire_YP[5][1] = result.YP_ACTION_6_2;
					l_Umpire_YP[6][1] = result.YP_ACTION_7_2;
					l_Umpire_YP[7][1] = result.YP_ACTION_8_2;
					l_Umpire_YP[8][1] = result.YP_ACTION_9_2;
					l_Umpire_YP[9][1] = result.YP_ACTION_10_2;
					l_Umpire_YP[10][1] = result.YP_ACTION_11_2;
					l_Umpire_YP[11][1] = result.YP_ACTION_12_2;
					l_Umpire_YP[12][1] = result.YP_ACTION_13_2;
					l_Umpire_YP[13][1] = result.YP_ACTION_14_2;
					l_Umpire_YP[14][1] = result.YP_ACTION_15_2;
					l_Umpire_YP[15][1] = result.YP_ACTION_16_2;
					l_Umpire_YP[16][1] = result.YP_ACTION_17_2;
					l_Umpire_YP[17][1] = result.YP_ACTION_18_2;
					l_Umpire_YP[18][1] = result.YP_ACTION_19_2;
					l_Umpire_YP[19][1] = result.YP_ACTION_20_2;
					l_Umpire_YP[20][1] = result.YP_ACTION_21_2;
					l_Umpire_YP[21][1] = result.YP_ACTION_22_2;

					l_Umpire_SL[0][1] = result.SELLER_ACTION_1_2;
					l_Umpire_SL[1][1] = result.SELLER_ACTION_2_2;
					l_Umpire_SL[2][1] = result.SELLER_ACTION_3_2;
					l_Umpire_SL[3][1] = result.SELLER_ACTION_4_2;
					l_Umpire_SL[4][1] = result.SELLER_ACTION_5_2;
					l_Umpire_SL[5][1] = result.SELLER_ACTION_6_2;
					l_Umpire_SL[6][1] = result.SELLER_ACTION_7_2;
					l_Umpire_SL[7][1] = result.SELLER_ACTION_8_2;
					l_Umpire_SL[8][1] = result.SELLER_ACTION_9_2;
					l_Umpire_SL[9][1] = result.SELLER_ACTION_10_2;
					l_Umpire_SL[10][1] = result.SELLER_ACTION_11_2;
					l_Umpire_SL[11][1] = result.SELLER_ACTION_12_2;
					l_Umpire_SL[12][1] = result.SELLER_ACTION_13_2;
					l_Umpire_SL[13][1] = result.SELLER_ACTION_14_2;
					l_Umpire_SL[14][1] = result.SELLER_ACTION_15_2;
					l_Umpire_SL[15][1] = result.SELLER_ACTION_16_2;
					l_Umpire_SL[16][1] = result.SELLER_ACTION_17_2;
					l_Umpire_SL[17][1] = result.SELLER_ACTION_18_2;
					l_Umpire_SL[18][1] = result.SELLER_ACTION_19_2;
					l_Umpire_SL[19][1] = result.SELLER_ACTION_20_2;
					l_Umpire_SL[20][1] = result.SELLER_ACTION_21_2;
					l_Umpire_SL[21][1] = result.SELLER_ACTION_22_2;

					l_SETTLE[0][1] = result.SETTLE_1_2;
					l_SETTLE[1][1] = result.SETTLE_2_2;
					l_SETTLE[2][1] = result.SETTLE_3_2;
					l_SETTLE[3][1] = result.SETTLE_4_2;
					l_SETTLE[4][1] = result.SETTLE_5_2;
					l_SETTLE[5][1] = result.SETTLE_6_2;
					l_SETTLE[6][1] = result.SETTLE_7_2;
					l_SETTLE[7][1] = result.SETTLE_8_2;
					l_SETTLE[8][1] = result.SETTLE_9_2;
					l_SETTLE[9][1] = result.SETTLE_10_2;
					l_SETTLE[10][1] = result.SETTLE_11_2;
					l_SETTLE[11][1] = result.SETTLE_12_2;
					l_SETTLE[12][1] = result.SETTLE_13_2;
					l_SETTLE[13][1] = result.SETTLE_14_2;
					l_SETTLE[14][1] = result.SETTLE_15_2;
					l_SETTLE[15][1] = result.SETTLE_16_2;
					l_SETTLE[16][1] = result.SETTLE_17_2;
					l_SETTLE[17][1] = result.SETTLE_18_2;
					l_SETTLE[18][1] = result.SETTLE_19_2;
					l_SETTLE[19][1] = result.SETTLE_20_2;
					l_SETTLE[20][1] = result.SETTLE_21_2;
					l_SETTLE[21][1] = result.SETTLE_22_2;

					l_UMPIRE[0][1] = result.UMPIRE_1_2;
					l_UMPIRE[1][1] = result.UMPIRE_2_2;
					l_UMPIRE[2][1] = result.UMPIRE_3_2;
					l_UMPIRE[3][1] = result.UMPIRE_4_2;
					l_UMPIRE[4][1] = result.UMPIRE_5_2;
					l_UMPIRE[5][1] = result.UMPIRE_6_2;
					l_UMPIRE[6][1] = result.UMPIRE_7_2;
					l_UMPIRE[7][1] = result.UMPIRE_8_2;
					l_UMPIRE[8][1] = result.UMPIRE_9_2;
					l_UMPIRE[9][1] = result.UMPIRE_10_2;
					l_UMPIRE[10][1] = result.UMPIRE_11_2;
					l_UMPIRE[11][1] = result.UMPIRE_12_2;
					l_UMPIRE[12][1] = result.UMPIRE_13_2;
					l_UMPIRE[13][1] = result.UMPIRE_14_2;
					l_UMPIRE[14][1] = result.UMPIRE_15_2;
					l_UMPIRE[15][1] = result.UMPIRE_16_2;
					l_UMPIRE[16][1] = result.UMPIRE_17_2;
					l_UMPIRE[17][1] = result.UMPIRE_18_2;
					l_UMPIRE[18][1] = result.UMPIRE_19_2;
					l_UMPIRE[19][1] = result.UMPIRE_20_2;
					l_UMPIRE[20][1] = result.UMPIRE_21_2;
					l_UMPIRE[21][1] = result.UMPIRE_22_2;

					l_STATE[0][1] = result.STATE_1_2;
					l_STATE[1][1] = result.STATE_2_2;
					l_STATE[2][1] = result.STATE_3_2;
					l_STATE[3][1] = result.STATE_4_2;
					l_STATE[4][1] = result.STATE_5_2;
					l_STATE[5][1] = result.STATE_6_2;
					l_STATE[6][1] = result.STATE_7_2;
					l_STATE[7][1] = result.STATE_8_2;
					l_STATE[8][1] = result.STATE_9_2;
					l_STATE[9][1] = result.STATE_10_2;
					l_STATE[10][1] = result.STATE_11_2;
					l_STATE[11][1] = result.STATE_12_2;
					l_STATE[12][1] = result.STATE_13_2;
					l_STATE[13][1] = result.STATE_14_2;
					l_STATE[14][1] = result.STATE_15_2;
					l_STATE[15][1] = result.STATE_16_2;
					l_STATE[16][1] = result.STATE_17_2;
					l_STATE[17][1] = result.STATE_18_2;
					l_STATE[18][1] = result.STATE_19_2;
					l_STATE[19][1] = result.STATE_20_2;
					l_STATE[20][1] = result.STATE_21_2;
					l_STATE[21][1] = result.STATE_22_2;

					l_DMT[ 0][2] = result.DMT_1_3;
					l_DMT[ 1][2] = result.DMT_2_3;
					l_DMT[ 2][2] = result.DMT_3_3;
					l_DMT[ 3][2] = result.DMT_4_3;
					l_DMT[ 4][2] = result.DMT_5_3;
					l_DMT[ 5][2] = result.DMT_6_3;
					l_DMT[ 6][2] = result.DMT_7_3;
					l_DMT[ 7][2] = result.DMT_8_3;
					l_DMT[ 8][2] = result.DMT_9_3;
					l_DMT[ 9][2] = result.DMT_10_3;
					l_DMT[10][2] = result.DMT_11_3;
					l_DMT[11][2] = result.DMT_12_3;
					l_DMT[12][2] = result.DMT_13_3;
					l_DMT[13][2] = result.DMT_14_3;
					l_DMT[14][2] = result.DMT_15_3;
					l_DMT[15][2] = result.DMT_16_3;
					l_DMT[16][2] = result.DMT_17_3;
					l_DMT[17][2] = result.DMT_18_3;
					l_DMT[18][2] = result.DMT_19_3;
					l_DMT[19][2] = result.DMT_20_3;
					l_DMT[20][2] = result.DMT_21_3;
					l_DMT[21][2] = result.DMT_22_3;

					l_YP[ 0][2] = result.YP_1_3;
					l_YP[ 1][2] = result.YP_2_3;
					l_YP[ 2][2] = result.YP_3_3;
					l_YP[ 3][2] = result.YP_4_3;
					l_YP[ 4][2] = result.YP_5_3;
					l_YP[ 5][2] = result.YP_6_3;
					l_YP[ 6][2] = result.YP_7_3;
					l_YP[ 7][2] = result.YP_8_3;
					l_YP[ 8][2] = result.YP_9_3;
					l_YP[ 9][2] = result.YP_10_3;
					l_YP[10][2] = result.YP_11_3;
					l_YP[11][2] = result.YP_12_3;
					l_YP[12][2] = result.YP_13_3;
					l_YP[13][2] = result.YP_14_3;
					l_YP[14][2] = result.YP_15_3;
					l_YP[15][2] = result.YP_16_3;
					l_YP[16][2] = result.YP_17_3;
					l_YP[17][2] = result.YP_18_3;
					l_YP[18][2] = result.YP_19_3;
					l_YP[19][2] = result.YP_20_3;
					l_YP[20][2] = result.YP_21_3;
					l_YP[21][2] = result.YP_22_3;

					l_SELLER[ 0][2] = result.SELLER_1_3;
					l_SELLER[ 1][2] = result.SELLER_2_3;
					l_SELLER[ 2][2] = result.SELLER_3_3;
					l_SELLER[ 3][2] = result.SELLER_4_3;
					l_SELLER[ 4][2] = result.SELLER_5_3;
					l_SELLER[ 5][2] = result.SELLER_6_3;
					l_SELLER[ 6][2] = result.SELLER_7_3;
					l_SELLER[ 7][2] = result.SELLER_8_3;
					l_SELLER[ 8][2] = result.SELLER_9_3;
					l_SELLER[ 9][2] = result.SELLER_10_3;
					l_SELLER[10][2] = result.SELLER_11_3;
					l_SELLER[11][2] = result.SELLER_12_3;
					l_SELLER[12][2] = result.SELLER_13_3;
					l_SELLER[13][2] = result.SELLER_14_3;
					l_SELLER[14][2] = result.SELLER_15_3;
					l_SELLER[15][2] = result.SELLER_16_3;
					l_SELLER[16][2] = result.SELLER_17_3;
					l_SELLER[17][2] = result.SELLER_18_3;
					l_SELLER[18][2] = result.SELLER_19_3;
					l_SELLER[19][2] = result.SELLER_20_3;
					l_SELLER[20][2] = result.SELLER_21_3;
					l_SELLER[21][2] = result.SELLER_22_3;

					l_Umpire_YP[0][2] = result.YP_ACTION_1_3;
					l_Umpire_YP[1][2] = result.YP_ACTION_2_3;
					l_Umpire_YP[2][2] = result.YP_ACTION_3_3;
					l_Umpire_YP[3][2] = result.YP_ACTION_4_3;
					l_Umpire_YP[4][2] = result.YP_ACTION_5_3;
					l_Umpire_YP[5][2] = result.YP_ACTION_6_3;
					l_Umpire_YP[6][2] = result.YP_ACTION_7_3;
					l_Umpire_YP[7][2] = result.YP_ACTION_8_3;
					l_Umpire_YP[8][2] = result.YP_ACTION_9_3;
					l_Umpire_YP[9][2] = result.YP_ACTION_10_3;
					l_Umpire_YP[10][2] = result.YP_ACTION_11_3;
					l_Umpire_YP[11][2] = result.YP_ACTION_12_3;
					l_Umpire_YP[12][2] = result.YP_ACTION_13_3;
					l_Umpire_YP[13][2] = result.YP_ACTION_14_3;
					l_Umpire_YP[14][2] = result.YP_ACTION_15_3;
					l_Umpire_YP[15][2] = result.YP_ACTION_16_3;
					l_Umpire_YP[16][2] = result.YP_ACTION_17_3;
					l_Umpire_YP[17][2] = result.YP_ACTION_18_3;
					l_Umpire_YP[18][2] = result.YP_ACTION_19_3;
					l_Umpire_YP[19][2] = result.YP_ACTION_20_3;
					l_Umpire_YP[20][2] = result.YP_ACTION_21_3;
					l_Umpire_YP[21][2] = result.YP_ACTION_22_3;

					l_Umpire_SL[0][2] = result.SELLER_ACTION_1_3;
					l_Umpire_SL[1][2] = result.SELLER_ACTION_2_3;
					l_Umpire_SL[2][2] = result.SELLER_ACTION_3_3;
					l_Umpire_SL[3][2] = result.SELLER_ACTION_4_3;
					l_Umpire_SL[4][2] = result.SELLER_ACTION_5_3;
					l_Umpire_SL[5][2] = result.SELLER_ACTION_6_3;
					l_Umpire_SL[6][2] = result.SELLER_ACTION_7_3;
					l_Umpire_SL[7][2] = result.SELLER_ACTION_8_3;
					l_Umpire_SL[8][2] = result.SELLER_ACTION_9_3;
					l_Umpire_SL[9][2] = result.SELLER_ACTION_10_3;
					l_Umpire_SL[10][2] = result.SELLER_ACTION_11_3;
					l_Umpire_SL[11][2] = result.SELLER_ACTION_12_3;
					l_Umpire_SL[12][2] = result.SELLER_ACTION_13_3;
					l_Umpire_SL[13][2] = result.SELLER_ACTION_14_3;
					l_Umpire_SL[14][2] = result.SELLER_ACTION_15_3;
					l_Umpire_SL[15][2] = result.SELLER_ACTION_16_3;
					l_Umpire_SL[16][2] = result.SELLER_ACTION_17_3;
					l_Umpire_SL[17][2] = result.SELLER_ACTION_18_3;
					l_Umpire_SL[18][2] = result.SELLER_ACTION_19_3;
					l_Umpire_SL[19][2] = result.SELLER_ACTION_20_3;
					l_Umpire_SL[20][2] = result.SELLER_ACTION_21_3;
					l_Umpire_SL[21][2] = result.SELLER_ACTION_22_3;

					l_SETTLE[0][2] = result.SETTLE_1_3;
					l_SETTLE[1][2] = result.SETTLE_2_3;
					l_SETTLE[2][2] = result.SETTLE_3_3;
					l_SETTLE[3][2] = result.SETTLE_4_3;
					l_SETTLE[4][2] = result.SETTLE_5_3;
					l_SETTLE[5][2] = result.SETTLE_6_3;
					l_SETTLE[6][2] = result.SETTLE_7_3;
					l_SETTLE[7][2] = result.SETTLE_8_3;
					l_SETTLE[8][2] = result.SETTLE_9_3;
					l_SETTLE[9][2] = result.SETTLE_10_3;
					l_SETTLE[10][2] = result.SETTLE_11_3;
					l_SETTLE[11][2] = result.SETTLE_12_3;
					l_SETTLE[12][2] = result.SETTLE_13_3;
					l_SETTLE[13][2] = result.SETTLE_14_3;
					l_SETTLE[14][2] = result.SETTLE_15_3;
					l_SETTLE[15][2] = result.SETTLE_16_3;
					l_SETTLE[16][2] = result.SETTLE_17_3;
					l_SETTLE[17][2] = result.SETTLE_18_3;
					l_SETTLE[18][2] = result.SETTLE_19_3;
					l_SETTLE[19][2] = result.SETTLE_20_3;
					l_SETTLE[20][2] = result.SETTLE_21_3;
					l_SETTLE[21][2] = result.SETTLE_22_3;

					l_UMPIRE[0][2] = result.UMPIRE_1_3;
					l_UMPIRE[1][2] = result.UMPIRE_2_3;
					l_UMPIRE[2][2] = result.UMPIRE_3_3;
					l_UMPIRE[3][2] = result.UMPIRE_4_3;
					l_UMPIRE[4][2] = result.UMPIRE_5_3;
					l_UMPIRE[5][2] = result.UMPIRE_6_3;
					l_UMPIRE[6][2] = result.UMPIRE_7_3;
					l_UMPIRE[7][2] = result.UMPIRE_8_3;
					l_UMPIRE[8][2] = result.UMPIRE_9_3;
					l_UMPIRE[9][2] = result.UMPIRE_10_3;
					l_UMPIRE[10][2] = result.UMPIRE_11_3;
					l_UMPIRE[11][2] = result.UMPIRE_12_3;
					l_UMPIRE[12][2] = result.UMPIRE_13_3;
					l_UMPIRE[13][2] = result.UMPIRE_14_3;
					l_UMPIRE[14][2] = result.UMPIRE_15_3;
					l_UMPIRE[15][2] = result.UMPIRE_16_3;
					l_UMPIRE[16][2] = result.UMPIRE_17_3;
					l_UMPIRE[17][2] = result.UMPIRE_18_3;
					l_UMPIRE[18][2] = result.UMPIRE_19_3;
					l_UMPIRE[19][2] = result.UMPIRE_20_3;
					l_UMPIRE[20][2] = result.UMPIRE_21_3;
					l_UMPIRE[21][2] = result.UMPIRE_22_3;

					l_STATE[0][2] = result.STATE_1_3;
					l_STATE[1][2] = result.STATE_2_3;
					l_STATE[2][2] = result.STATE_3_3;
					l_STATE[3][2] = result.STATE_4_3;
					l_STATE[4][2] = result.STATE_5_3;
					l_STATE[5][2] = result.STATE_6_3;
					l_STATE[6][2] = result.STATE_7_3;
					l_STATE[7][2] = result.STATE_8_3;
					l_STATE[8][2] = result.STATE_9_3;
					l_STATE[9][2] = result.STATE_10_3;
					l_STATE[10][2] = result.STATE_11_3;
					l_STATE[11][2] = result.STATE_12_3;
					l_STATE[12][2] = result.STATE_13_3;
					l_STATE[13][2] = result.STATE_14_3;
					l_STATE[14][2] = result.STATE_15_3;
					l_STATE[15][2] = result.STATE_16_3;
					l_STATE[16][2] = result.STATE_17_3;
					l_STATE[17][2] = result.STATE_18_3;
					l_STATE[18][2] = result.STATE_19_3;
					l_STATE[19][2] = result.STATE_20_3;
					l_STATE[20][2] = result.STATE_21_3;
					l_STATE[21][2] = result.STATE_22_3;

					l_DMT[ 0][3] = result.DMT_1_4;
					l_DMT[ 1][3] = result.DMT_2_4;
					l_DMT[ 2][3] = result.DMT_3_4;
					l_DMT[ 3][3] = result.DMT_4_4;
					l_DMT[ 4][3] = result.DMT_5_4;
					l_DMT[ 5][3] = result.DMT_6_4;
					l_DMT[ 6][3] = result.DMT_7_4;
					l_DMT[ 7][3] = result.DMT_8_4;
					l_DMT[ 8][3] = result.DMT_9_4;
					l_DMT[ 9][3] = result.DMT_10_4;
					l_DMT[10][3] = result.DMT_11_4;
					l_DMT[11][3] = result.DMT_12_4;
					l_DMT[12][3] = result.DMT_13_4;
					l_DMT[13][3] = result.DMT_14_4;
					l_DMT[14][3] = result.DMT_15_4;
					l_DMT[15][3] = result.DMT_16_4;
					l_DMT[16][3] = result.DMT_17_4;
					l_DMT[17][3] = result.DMT_18_4;
					l_DMT[18][3] = result.DMT_19_4;
					l_DMT[19][3] = result.DMT_20_4;
					l_DMT[20][3] = result.DMT_21_4;
					l_DMT[21][3] = result.DMT_22_4;

					l_YP[ 0][3] = result.YP_1_4;
					l_YP[ 1][3] = result.YP_2_4;
					l_YP[ 2][3] = result.YP_3_4;
					l_YP[ 3][3] = result.YP_4_4;
					l_YP[ 4][3] = result.YP_5_4;
					l_YP[ 5][3] = result.YP_6_4;
					l_YP[ 6][3] = result.YP_7_4;
					l_YP[ 7][3] = result.YP_8_4;
					l_YP[ 8][3] = result.YP_9_4;
					l_YP[ 9][3] = result.YP_10_4;
					l_YP[10][3] = result.YP_11_4;
					l_YP[11][3] = result.YP_12_4;
					l_YP[12][3] = result.YP_13_4;
					l_YP[13][3] = result.YP_14_4;
					l_YP[14][3] = result.YP_15_4;
					l_YP[15][3] = result.YP_16_4;
					l_YP[16][3] = result.YP_17_4;
					l_YP[17][3] = result.YP_18_4;
					l_YP[18][3] = result.YP_19_4;
					l_YP[19][3] = result.YP_20_4;
					l_YP[20][3] = result.YP_21_4;
					l_YP[21][3] = result.YP_22_4;

					l_SELLER[ 0][3] = result.SELLER_1_4;
					l_SELLER[ 1][3] = result.SELLER_2_4;
					l_SELLER[ 2][3] = result.SELLER_3_4;
					l_SELLER[ 3][3] = result.SELLER_4_4;
					l_SELLER[ 4][3] = result.SELLER_5_4;
					l_SELLER[ 5][3] = result.SELLER_6_4;
					l_SELLER[ 6][3] = result.SELLER_7_4;
					l_SELLER[ 7][3] = result.SELLER_8_4;
					l_SELLER[ 8][3] = result.SELLER_9_4;
					l_SELLER[ 9][3] = result.SELLER_10_4;
					l_SELLER[10][3] = result.SELLER_11_4;
					l_SELLER[11][3] = result.SELLER_12_4;
					l_SELLER[12][3] = result.SELLER_13_4;
					l_SELLER[13][3] = result.SELLER_14_4;
					l_SELLER[14][3] = result.SELLER_15_4;
					l_SELLER[15][3] = result.SELLER_16_4;
					l_SELLER[16][3] = result.SELLER_17_4;
					l_SELLER[17][3] = result.SELLER_18_4;
					l_SELLER[18][3] = result.SELLER_19_4;
					l_SELLER[19][3] = result.SELLER_20_4;
					l_SELLER[20][3] = result.SELLER_21_4;
					l_SELLER[21][3] = result.SELLER_22_4;

					l_Umpire_YP[0][3] = result.YP_ACTION_1_4;
					l_Umpire_YP[1][3] = result.YP_ACTION_2_4;
					l_Umpire_YP[2][3] = result.YP_ACTION_3_4;
					l_Umpire_YP[3][3] = result.YP_ACTION_4_4;
					l_Umpire_YP[4][3] = result.YP_ACTION_5_4;
					l_Umpire_YP[5][3] = result.YP_ACTION_6_4;
					l_Umpire_YP[6][3] = result.YP_ACTION_7_4;
					l_Umpire_YP[7][3] = result.YP_ACTION_8_4;
					l_Umpire_YP[8][3] = result.YP_ACTION_9_4;
					l_Umpire_YP[9][3] = result.YP_ACTION_10_4;
					l_Umpire_YP[10][3] = result.YP_ACTION_11_4;
					l_Umpire_YP[11][3] = result.YP_ACTION_12_4;
					l_Umpire_YP[12][3] = result.YP_ACTION_13_4;
					l_Umpire_YP[13][3] = result.YP_ACTION_14_4;
					l_Umpire_YP[14][3] = result.YP_ACTION_15_4;
					l_Umpire_YP[15][3] = result.YP_ACTION_16_4;
					l_Umpire_YP[16][3] = result.YP_ACTION_17_4;
					l_Umpire_YP[17][3] = result.YP_ACTION_18_4;
					l_Umpire_YP[18][3] = result.YP_ACTION_19_4;
					l_Umpire_YP[19][3] = result.YP_ACTION_20_4;
					l_Umpire_YP[20][3] = result.YP_ACTION_21_4;
					l_Umpire_YP[21][3] = result.YP_ACTION_22_4;

					l_Umpire_SL[0][3] = result.SELLER_ACTION_1_4;
					l_Umpire_SL[1][3] = result.SELLER_ACTION_2_4;
					l_Umpire_SL[2][3] = result.SELLER_ACTION_3_4;
					l_Umpire_SL[3][3] = result.SELLER_ACTION_4_4;
					l_Umpire_SL[4][3] = result.SELLER_ACTION_5_4;
					l_Umpire_SL[5][3] = result.SELLER_ACTION_6_4;
					l_Umpire_SL[6][3] = result.SELLER_ACTION_7_4;
					l_Umpire_SL[7][3] = result.SELLER_ACTION_8_4;
					l_Umpire_SL[8][3] = result.SELLER_ACTION_9_4;
					l_Umpire_SL[9][3] = result.SELLER_ACTION_10_4;
					l_Umpire_SL[10][3] = result.SELLER_ACTION_11_4;
					l_Umpire_SL[11][3] = result.SELLER_ACTION_12_4;
					l_Umpire_SL[12][3] = result.SELLER_ACTION_13_4;
					l_Umpire_SL[13][3] = result.SELLER_ACTION_14_4;
					l_Umpire_SL[14][3] = result.SELLER_ACTION_15_4;
					l_Umpire_SL[15][3] = result.SELLER_ACTION_16_4;
					l_Umpire_SL[16][3] = result.SELLER_ACTION_17_4;
					l_Umpire_SL[17][3] = result.SELLER_ACTION_18_4;
					l_Umpire_SL[18][3] = result.SELLER_ACTION_19_4;
					l_Umpire_SL[19][3] = result.SELLER_ACTION_20_4;
					l_Umpire_SL[20][3] = result.SELLER_ACTION_21_4;
					l_Umpire_SL[21][3] = result.SELLER_ACTION_22_4;

					l_SETTLE[0][3] = result.SETTLE_1_4;
					l_SETTLE[1][3] = result.SETTLE_2_4;
					l_SETTLE[2][3] = result.SETTLE_3_4;
					l_SETTLE[3][3] = result.SETTLE_4_4;
					l_SETTLE[4][3] = result.SETTLE_5_4;
					l_SETTLE[5][3] = result.SETTLE_6_4;
					l_SETTLE[6][3] = result.SETTLE_7_4;
					l_SETTLE[7][3] = result.SETTLE_8_4;
					l_SETTLE[8][3] = result.SETTLE_9_1;
					l_SETTLE[9][3] = result.SETTLE_10_4;
					l_SETTLE[10][3] = result.SETTLE_11_4;
					l_SETTLE[11][3] = result.SETTLE_12_4;
					l_SETTLE[12][3] = result.SETTLE_13_4;
					l_SETTLE[13][3] = result.SETTLE_14_4;
					l_SETTLE[14][3] = result.SETTLE_15_4;
					l_SETTLE[15][3] = result.SETTLE_16_4;
					l_SETTLE[16][3] = result.SETTLE_17_4;
					l_SETTLE[17][3] = result.SETTLE_18_4;
					l_SETTLE[18][3] = result.SETTLE_19_4;
					l_SETTLE[19][3] = result.SETTLE_20_4;
					l_SETTLE[20][3] = result.SETTLE_21_4;
					l_SETTLE[21][3] = result.SETTLE_22_4;

					l_UMPIRE[0][3] = result.UMPIRE_1_4;
					l_UMPIRE[1][3] = result.UMPIRE_2_4;
					l_UMPIRE[2][3] = result.UMPIRE_3_4;
					l_UMPIRE[3][3] = result.UMPIRE_4_4;
					l_UMPIRE[4][3] = result.UMPIRE_5_4;
					l_UMPIRE[5][3] = result.UMPIRE_6_4;
					l_UMPIRE[6][3] = result.UMPIRE_7_4;
					l_UMPIRE[7][3] = result.UMPIRE_8_4;
					l_UMPIRE[8][3] = result.UMPIRE_9_4;
					l_UMPIRE[9][3] = result.UMPIRE_10_4;
					l_UMPIRE[10][3] = result.UMPIRE_11_4;
					l_UMPIRE[11][3] = result.UMPIRE_12_4;
					l_UMPIRE[12][3] = result.UMPIRE_13_4;
					l_UMPIRE[13][3] = result.UMPIRE_14_4;
					l_UMPIRE[14][3] = result.UMPIRE_15_4;
					l_UMPIRE[15][3] = result.UMPIRE_16_4;
					l_UMPIRE[16][3] = result.UMPIRE_17_4;
					l_UMPIRE[17][3] = result.UMPIRE_18_4;
					l_UMPIRE[18][3] = result.UMPIRE_19_4;
					l_UMPIRE[19][3] = result.UMPIRE_20_4;
					l_UMPIRE[20][3] = result.UMPIRE_21_4;
					l_UMPIRE[21][3] = result.UMPIRE_22_4;

					l_STATE[0][3] = result.STATE_1_4;
					l_STATE[1][3] = result.STATE_2_4;
					l_STATE[2][3] = result.STATE_3_4;
					l_STATE[3][3] = result.STATE_4_4;
					l_STATE[4][3] = result.STATE_5_4;
					l_STATE[5][3] = result.STATE_6_4;
					l_STATE[6][3] = result.STATE_7_4;
					l_STATE[7][3] = result.STATE_8_4;
					l_STATE[8][3] = result.STATE_9_4;
					l_STATE[9][3] = result.STATE_10_4;
					l_STATE[10][3] = result.STATE_11_4;
					l_STATE[11][3] = result.STATE_12_4;
					l_STATE[12][3] = result.STATE_13_4;
					l_STATE[13][3] = result.STATE_14_4;
					l_STATE[14][3] = result.STATE_15_4;
					l_STATE[15][3] = result.STATE_16_4;
					l_STATE[16][3] = result.STATE_17_4;
					l_STATE[17][3] = result.STATE_18_4;
					l_STATE[18][3] = result.STATE_19_4;
					l_STATE[19][3] = result.STATE_20_4;
					l_STATE[20][3] = result.STATE_21_4;
					l_STATE[21][3] = result.STATE_22_4;

					set_Value();
				},
				error : function(request, status, error) {
					//	console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
				}
			});
		}

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

			load_Def();

			l_MASTER_ID = '${req_data.MASTER_ID}';

			document.getElementById("edt_MATERIAL_ID").value = get_material_name('${req_data.MATERIAL_ID}', '${req_data.SHEET_ID}');
			document.getElementById("edt_SELLER_ID").value = get_seller_name('${req_data.SELLER_ID}');
			document.getElementById("edt_IMPORT_DATE").value = '${req_data.IMPORT_DATE}';

			load_ingredient_info();
			load_InitValue();
		});

		// 결과값 등록
		$("#register_btn").on("click", function() {
			//	console.log("결과값 등록");
			saveUmpireSet();
		});

		function saveUmpireSet() {
			$.ajax({
 				url : "/yp/zpp/ore/zpp_ore_save_umpire_result",
				type : "POST",
			    cache:false,
			    async:true, 
				data : {
					MASTER_ID : l_MASTER_ID,

					SETTLE_1_1 : l_SETTLE[0][0],
					SETTLE_2_1 : l_SETTLE[1][0],
					SETTLE_3_1 : l_SETTLE[2][0],
					SETTLE_4_1 : l_SETTLE[3][0],
					SETTLE_5_1 : l_SETTLE[4][0],
					SETTLE_6_1 : l_SETTLE[5][0],
					SETTLE_7_1 : l_SETTLE[6][0],
					SETTLE_8_1 : l_SETTLE[7][0],
					SETTLE_9_1 : l_SETTLE[8][0],
					SETTLE_10_1 : l_SETTLE[9][0],
					SETTLE_11_1 : l_SETTLE[10][0],
					SETTLE_12_1 : l_SETTLE[11][0],
					SETTLE_13_1 : l_SETTLE[12][0],
					SETTLE_14_1 : l_SETTLE[13][0],
					SETTLE_15_1 : l_SETTLE[14][0],
					SETTLE_16_1 : l_SETTLE[15][0],
					SETTLE_17_1 : l_SETTLE[16][0],
					SETTLE_18_1 : l_SETTLE[17][0],
					SETTLE_19_1 : l_SETTLE[18][0],
					SETTLE_20_1 : l_SETTLE[19][0],
					SETTLE_21_1 : l_SETTLE[20][0],
					SETTLE_22_1 : l_SETTLE[21][0],

					SETTLE_1_2 : l_SETTLE[0][1],
					SETTLE_2_2 : l_SETTLE[1][1],
					SETTLE_3_2 : l_SETTLE[2][1],
					SETTLE_4_2 : l_SETTLE[3][1],
					SETTLE_5_2 : l_SETTLE[4][1],
					SETTLE_6_2 : l_SETTLE[5][1],
					SETTLE_7_2 : l_SETTLE[6][1],
					SETTLE_8_2 : l_SETTLE[7][1],
					SETTLE_9_2 : l_SETTLE[8][1],
					SETTLE_10_2 : l_SETTLE[9][1],
					SETTLE_11_2 : l_SETTLE[10][1],
					SETTLE_12_2 : l_SETTLE[11][1],
					SETTLE_13_2 : l_SETTLE[12][1],
					SETTLE_14_2 : l_SETTLE[13][1],
					SETTLE_15_2 : l_SETTLE[14][1],
					SETTLE_16_2 : l_SETTLE[15][1],
					SETTLE_17_2 : l_SETTLE[16][1],
					SETTLE_18_2 : l_SETTLE[17][1],
					SETTLE_19_2 : l_SETTLE[18][1],
					SETTLE_20_2 : l_SETTLE[19][1],
					SETTLE_21_2 : l_SETTLE[20][1],
					SETTLE_22_2 : l_SETTLE[21][1],

					SETTLE_1_3 : l_SETTLE[0][2],
					SETTLE_2_3 : l_SETTLE[1][2],
					SETTLE_3_3 : l_SETTLE[2][2],
					SETTLE_4_3 : l_SETTLE[3][2],
					SETTLE_5_3 : l_SETTLE[4][2],
					SETTLE_6_3 : l_SETTLE[5][2],
					SETTLE_7_3 : l_SETTLE[6][2],
					SETTLE_8_3 : l_SETTLE[7][2],
					SETTLE_9_3 : l_SETTLE[8][2],
					SETTLE_10_3 : l_SETTLE[9][2],
					SETTLE_11_3 : l_SETTLE[10][2],
					SETTLE_12_3 : l_SETTLE[11][2],
					SETTLE_13_3 : l_SETTLE[12][2],
					SETTLE_14_3 : l_SETTLE[13][2],
					SETTLE_15_3 : l_SETTLE[14][2],
					SETTLE_16_3 : l_SETTLE[15][2],
					SETTLE_17_3 : l_SETTLE[16][2],
					SETTLE_18_3 : l_SETTLE[17][2],
					SETTLE_19_3 : l_SETTLE[18][2],
					SETTLE_20_3 : l_SETTLE[19][2],
					SETTLE_21_3 : l_SETTLE[20][2],
					SETTLE_22_3 : l_SETTLE[21][2],

					SETTLE_1_4 : l_SETTLE[0][3],
					SETTLE_2_4 : l_SETTLE[1][3],
					SETTLE_3_4 : l_SETTLE[2][3],
					SETTLE_4_4 : l_SETTLE[3][3],
					SETTLE_5_4 : l_SETTLE[4][3],
					SETTLE_6_4 : l_SETTLE[5][3],
					SETTLE_7_4 : l_SETTLE[6][3],
					SETTLE_8_4 : l_SETTLE[7][3],
					SETTLE_9_4 : l_SETTLE[8][3],
					SETTLE_10_4 : l_SETTLE[9][3],
					SETTLE_11_4 : l_SETTLE[10][3],
					SETTLE_12_4 : l_SETTLE[11][3],
					SETTLE_13_4 : l_SETTLE[12][3],
					SETTLE_14_4 : l_SETTLE[13][3],
					SETTLE_15_4 : l_SETTLE[14][3],
					SETTLE_16_4 : l_SETTLE[15][3],
					SETTLE_17_4 : l_SETTLE[16][3],
					SETTLE_18_4 : l_SETTLE[17][3],
					SETTLE_19_4 : l_SETTLE[18][3],
					SETTLE_20_4 : l_SETTLE[19][3],
					SETTLE_21_4 : l_SETTLE[20][3],
					SETTLE_22_4 : l_SETTLE[21][3],

					UMPIRE_1_1 : l_UMPIRE[0][0],
					UMPIRE_2_1 : l_UMPIRE[1][0],
					UMPIRE_3_1 : l_UMPIRE[2][0],
					UMPIRE_4_1 : l_UMPIRE[3][0],
					UMPIRE_5_1 : l_UMPIRE[4][0],
					UMPIRE_6_1 : l_UMPIRE[5][0],
					UMPIRE_7_1 : l_UMPIRE[6][0],
					UMPIRE_8_1 : l_UMPIRE[7][0],
					UMPIRE_9_1 : l_UMPIRE[8][0],
					UMPIRE_10_1 : l_UMPIRE[9][0],
					UMPIRE_11_1 : l_UMPIRE[10][0],
					UMPIRE_12_1 : l_UMPIRE[11][0],
					UMPIRE_13_1 : l_UMPIRE[12][0],
					UMPIRE_14_1 : l_UMPIRE[13][0],
					UMPIRE_15_1 : l_UMPIRE[14][0],
					UMPIRE_16_1 : l_UMPIRE[15][0],
					UMPIRE_17_1 : l_UMPIRE[16][0],
					UMPIRE_18_1 : l_UMPIRE[17][0],
					UMPIRE_19_1 : l_UMPIRE[18][0],
					UMPIRE_20_1 : l_UMPIRE[19][0],
					UMPIRE_21_1 : l_UMPIRE[20][0],
					UMPIRE_22_1 : l_UMPIRE[21][0],

					UMPIRE_1_2 : l_UMPIRE[0][1],
					UMPIRE_2_2 : l_UMPIRE[1][1],
					UMPIRE_3_2 : l_UMPIRE[2][1],
					UMPIRE_4_2 : l_UMPIRE[3][1],
					UMPIRE_5_2 : l_UMPIRE[4][1],
					UMPIRE_6_2 : l_UMPIRE[5][1],
					UMPIRE_7_2 : l_UMPIRE[6][1],
					UMPIRE_8_2 : l_UMPIRE[7][1],
					UMPIRE_9_2 : l_UMPIRE[8][1],
					UMPIRE_10_2 : l_UMPIRE[9][1],
					UMPIRE_11_2 : l_UMPIRE[10][1],
					UMPIRE_12_2 : l_UMPIRE[11][1],
					UMPIRE_13_2 : l_UMPIRE[12][1],
					UMPIRE_14_2 : l_UMPIRE[13][1],
					UMPIRE_15_2 : l_UMPIRE[14][1],
					UMPIRE_16_2 : l_UMPIRE[15][1],
					UMPIRE_17_2 : l_UMPIRE[16][1],
					UMPIRE_18_2 : l_UMPIRE[17][1],
					UMPIRE_19_2 : l_UMPIRE[18][1],
					UMPIRE_20_2 : l_UMPIRE[19][1],
					UMPIRE_21_2 : l_UMPIRE[20][1],
					UMPIRE_22_2 : l_UMPIRE[21][1],

					UMPIRE_1_3 : l_UMPIRE[0][2],
					UMPIRE_2_3 : l_UMPIRE[1][2],
					UMPIRE_3_3 : l_UMPIRE[2][2],
					UMPIRE_4_3 : l_UMPIRE[3][2],
					UMPIRE_5_3 : l_UMPIRE[4][2],
					UMPIRE_6_3 : l_UMPIRE[5][2],
					UMPIRE_7_3 : l_UMPIRE[6][2],
					UMPIRE_8_3 : l_UMPIRE[7][2],
					UMPIRE_9_3 : l_UMPIRE[8][2],
					UMPIRE_10_3 : l_UMPIRE[9][2],
					UMPIRE_11_3 : l_UMPIRE[10][2],
					UMPIRE_12_3 : l_UMPIRE[11][2],
					UMPIRE_13_3 : l_UMPIRE[12][2],
					UMPIRE_14_3 : l_UMPIRE[13][2],
					UMPIRE_15_3 : l_UMPIRE[14][2],
					UMPIRE_16_3 : l_UMPIRE[15][2],
					UMPIRE_17_3 : l_UMPIRE[16][2],
					UMPIRE_18_3 : l_UMPIRE[17][2],
					UMPIRE_19_3 : l_UMPIRE[18][2],
					UMPIRE_20_3 : l_UMPIRE[19][2],
					UMPIRE_21_3 : l_UMPIRE[20][2],
					UMPIRE_22_3 : l_UMPIRE[21][2],

					UMPIRE_1_4 : l_UMPIRE[0][3],
					UMPIRE_2_4 : l_UMPIRE[1][3],
					UMPIRE_3_4 : l_UMPIRE[2][3],
					UMPIRE_4_4 : l_UMPIRE[3][3],
					UMPIRE_5_4 : l_UMPIRE[4][3],
					UMPIRE_6_4 : l_UMPIRE[5][3],
					UMPIRE_7_4 : l_UMPIRE[6][3],
					UMPIRE_8_4 : l_UMPIRE[7][3],
					UMPIRE_9_4 : l_UMPIRE[8][3],
					UMPIRE_10_4 : l_UMPIRE[9][3],
					UMPIRE_11_4 : l_UMPIRE[10][3],
					UMPIRE_12_4 : l_UMPIRE[11][3],
					UMPIRE_13_4 : l_UMPIRE[12][3],
					UMPIRE_14_4 : l_UMPIRE[13][3],
					UMPIRE_15_4 : l_UMPIRE[14][3],
					UMPIRE_16_4 : l_UMPIRE[15][3],
					UMPIRE_17_4 : l_UMPIRE[16][3],
					UMPIRE_18_4 : l_UMPIRE[17][3],
					UMPIRE_19_4 : l_UMPIRE[18][3],
					UMPIRE_20_4 : l_UMPIRE[19][3],
					UMPIRE_21_4 : l_UMPIRE[20][3],
					UMPIRE_22_4 : l_UMPIRE[21][3],

					STATE_1_1 : l_STATE[0][0],
					STATE_2_1 : l_STATE[1][0],
					STATE_3_1 : l_STATE[2][0],
					STATE_4_1 : l_STATE[3][0],
					STATE_5_1 : l_STATE[4][0],
					STATE_6_1 : l_STATE[5][0],
					STATE_7_1 : l_STATE[6][0],
					STATE_8_1 : l_STATE[7][0],
					STATE_9_1 : l_STATE[8][0],
					STATE_10_1 : l_STATE[9][0],
					STATE_11_1 : l_STATE[10][0],
					STATE_12_1 : l_STATE[11][0],
					STATE_13_1 : l_STATE[12][0],
					STATE_14_1 : l_STATE[13][0],
					STATE_15_1 : l_STATE[14][0],
					STATE_16_1 : l_STATE[15][0],
					STATE_17_1 : l_STATE[16][0],
					STATE_18_1 : l_STATE[17][0],
					STATE_19_1 : l_STATE[18][0],
					STATE_20_1 : l_STATE[19][0],
					STATE_21_1 : l_STATE[20][0],
					STATE_22_1 : l_STATE[21][0],

					STATE_1_2 : l_STATE[0][1],
					STATE_2_2 : l_STATE[1][1],
					STATE_3_2 : l_STATE[2][1],
					STATE_4_2 : l_STATE[3][1],
					STATE_5_2 : l_STATE[4][1],
					STATE_6_2 : l_STATE[5][1],
					STATE_7_2 : l_STATE[6][1],
					STATE_8_2 : l_STATE[7][1],
					STATE_9_2 : l_STATE[8][1],
					STATE_10_2 : l_STATE[9][1],
					STATE_11_2 : l_STATE[10][1],
					STATE_12_2 : l_STATE[11][1],
					STATE_13_2 : l_STATE[12][1],
					STATE_14_2 : l_STATE[13][1],
					STATE_15_2 : l_STATE[14][1],
					STATE_16_2 : l_STATE[15][1],
					STATE_17_2 : l_STATE[16][1],
					STATE_18_2 : l_STATE[17][1],
					STATE_19_2 : l_STATE[18][1],
					STATE_20_2 : l_STATE[19][1],
					STATE_21_2 : l_STATE[20][1],
					STATE_22_2 : l_STATE[21][1],

					STATE_1_3 : l_STATE[0][2],
					STATE_2_3 : l_STATE[1][2],
					STATE_3_3 : l_STATE[2][2],
					STATE_4_3 : l_STATE[3][2],
					STATE_5_3 : l_STATE[4][2],
					STATE_6_3 : l_STATE[5][2],
					STATE_7_3 : l_STATE[6][2],
					STATE_8_3 : l_STATE[7][2],
					STATE_9_3 : l_STATE[8][2],
					STATE_10_3 : l_STATE[9][2],
					STATE_11_3 : l_STATE[10][2],
					STATE_12_3 : l_STATE[11][2],
					STATE_13_3 : l_STATE[12][2],
					STATE_14_3 : l_STATE[13][2],
					STATE_15_3 : l_STATE[14][2],
					STATE_16_3 : l_STATE[15][2],
					STATE_17_3 : l_STATE[16][2],
					STATE_18_3 : l_STATE[17][2],
					STATE_19_3 : l_STATE[18][2],
					STATE_20_3 : l_STATE[19][2],
					STATE_21_3 : l_STATE[20][2],
					STATE_22_3 : l_STATE[21][2],

					STATE_1_4 : l_STATE[0][3],
					STATE_2_4 : l_STATE[1][3],
					STATE_3_4 : l_STATE[2][3],
					STATE_4_4 : l_STATE[3][3],
					STATE_5_4 : l_STATE[4][3],
					STATE_6_4 : l_STATE[5][3],
					STATE_7_4 : l_STATE[6][3],
					STATE_8_4 : l_STATE[7][3],
					STATE_9_4 : l_STATE[8][3],
					STATE_10_4 : l_STATE[9][3],
					STATE_11_4 : l_STATE[10][3],
					STATE_12_4 : l_STATE[11][3],
					STATE_13_4 : l_STATE[12][3],
					STATE_14_4 : l_STATE[13][3],
					STATE_15_4 : l_STATE[14][3],
					STATE_16_4 : l_STATE[15][3],
					STATE_17_4 : l_STATE[16][3],
					STATE_18_4 : l_STATE[17][3],
					STATE_19_4 : l_STATE[18][3],
					STATE_20_4 : l_STATE[19][3],
					STATE_21_4 : l_STATE[20][3],
					STATE_22_4 : l_STATE[21][3],

					_csrf : '${_csrf.token}'
					},
				dataType : "json",
				success : function(result) {
					opener.load_bl_grid();
					opener.parent.swalSuccess("저장 되었습니다.");
					opener.sel_prv_idx();
					
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

		function set_Value() {
			for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++)
			{
				for(var si = 0;si < l_LOT_COUNT;si ++)
				{
					cn = "edt_dmt_" + (si + 1).toString() + "_" + (ac + 1).toString();
					set_NS(cn, l_DMT[si][ac]);
	
					cn = "edt_yp_" + (si + 1).toString() + "_" + (ac + 1).toString();
					set_NS(cn, l_YP[si][ac]);
	
					cn = "edt_seller_" + (si + 1).toString() + "_" + (ac + 1).toString();
					set_NS(cn, l_SELLER[si][ac]);
	
					cn = "edt_split_" + (si + 1).toString() + "_" + (ac + 1).toString();
					set_NS(cn, (Number(l_YP[si][ac]) - Number(l_SELLER[si][ac])).toFixed(3));
	
					cn = "edt_average_" + (si + 1).toString() + "_" + (ac + 1).toString();
					set_NS(cn, ((Number(l_YP[si][ac]) + Number(l_SELLER[si][ac])) / 2).toFixed(3));
	
					cn = "edt_seller_action_" + (si + 1).toString() + "_" + (ac + 1).toString();
					if(l_Umpire_SL[si][ac] == 0) set_NS(cn, "");
					else if(l_Umpire_SL[si][ac] == 1) set_NS(cn, "UMPIRE");
					else set_NS(cn, "SPLIT");
					
					cn = "edt_yp_action_" + (si + 1).toString() + "_" + (ac + 1).toString();
					if(l_Umpire_YP[si][ac] == 0) set_NS(cn, "");
					else if(l_Umpire_YP[si][ac] == 1) set_NS(cn, "UMPIRE");
					else set_NS(cn, "SPLIT");
					
					cn = "edt_settle_" + (si + 1).toString() + "_" + (ac + 1).toString();
					set_NS(cn, l_SETTLE[si][ac]);
					
					cn = "edt_umpire_" + (si + 1).toString() + "_" + (ac + 1).toString();
					set_NS(cn, l_UMPIRE[si][ac]);
				}
			}
		}

		function get_NS(id) {
			return document.getElementById(id).value == "" ? "0":document.getElementById(id).value;
		}
		
		function set_NS(id, value) {
			document.getElementById(id).value = value;
		}

		function fillZero(str, width) {
		    return str.length >= width ? str:new Array(width-str.length+1).join('0')+str;//남는 길이만큼 0으로 채움
		}

		opener.popup = this;

	</script>
</body>
</html>