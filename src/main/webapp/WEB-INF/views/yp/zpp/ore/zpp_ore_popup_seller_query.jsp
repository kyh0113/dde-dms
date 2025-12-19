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
	<title>SELLER 송부용 분석 결과 조회</title>
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
		.tbl_box th {
			border: 1px solid #000000;
			height:30px;
			vertical-align: middle;
		}
	</style>

	<div id="popup">
		<div class="pop_header">
			SELLER 송부용 분석 결과 조회
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
							<tr>
								<th>전자결재</th>
								<td>
									<button style="display:none;" class="btn btn_edoc">전자결재</button>
									<p style="display:none;" class="edoc_status_txt"></p>
								</td>
								<th></th>
								<td></td>
								<th></th>
								<td></td>
								<th></th>
								<td></td>
							</tr>
						</table>

<!-- 						<div style="height:15px; background-color:white"></div> -->
					</div>
				</section>
			</div>

			<div style="width:100%">
				<table style='border:none'>
					<colgroup>
						<col width="900px" />
						<col width="900px" />
					</colgroup>
					<tr align='center'>
						<th style='font-size:28px; font-weight:bold; width:500px'>
							CERTIFICATE OF ANALYSIS
						</th>
						<th style='font-size:28px; font-weight:bold;'>
							분석결과서
						</th>
					</tr>
					<tr style='border:none'>
						<td style='border:none'>
							<table style='border:none'>
								<tr style='border:none'>
									<td style='border:none'>
										<table style='border:none'>
											<tr style='border:none'>
												<td style='border:none'>
													COMMODITY
												</td>
												<td style='border:none'>
													<input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id='lb_Material'>
												</td>
											</tr>
											<tr style='border:none'>
												<td style='border:none'>
													VESSEL
												</td>
												<td style='border:none'>
													<input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id='lb_Vessel'>
												</td>
											</tr>
											<tr style='border:none'>
												<td style='border:none'>
													DATE OF ARRIVAL
												</td>
												<td style='border:none'>
													<input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id='lb_ImportDate'>
												</td>
											</tr>
											<tr style='border:none'>
												<td style='border:none'>
													SELLER
												</td>
												<td style='border:none'>
													<input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id='lb_Seller'>
												</td>
											</tr>
											<tr style='border:none'>
												<td style='border:none'>
													BUYER
												</td>
												<td style='border:none; font-weight:bold;'>
													: YOUNG POONG CORPORATION
												</td>
											</tr>
											<tr style='border:none'>
												<td  style='border:none' align='center' colspan="2">
													We have examined the samples for the above hereby certify our assays as follows:
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr style='border:none'>
									<td style='border:none'>
										<table id="tbl_Assay" style="order:none" width="400px">
										</table>
									</td>
								</tr>
								<tr style='border:none'>
									<td style='border:none'>
										<table id='tbl_Composite' style='border:none'>
										</table>
									</td>
								</tr>
							</table>
						</td>
						<td style='border:none'>
							<table id="table_1" class=tbl_def>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<script>
		var l_MASTER_ID;
		var l_MaterialName = new Array();
		var l_MaterialID = new Array();
		var l_SellerName = new Array();
		var l_SellerID = new Array();

		var l_IG_VALUE = new Array();
		var l_PM_VALUE = new Array();

		var l_ADJUST_IG_1;
		var l_ADJUST_IG_2;
		var l_ADJUST_IG_3;
		var l_ADJUST_IG_4;

		var l_LOT_IG_VALUE = create2DArray(30, 4);
		var l_LOT_COUNT = 0;

		var l_INGREDIENT_CNT;
		var l_INGREDIENT_ID = new Array();
		var	l_INGREDIENT_NAME = new Array();

		var l_CPS_IG = new Array();

		var l_COMPOSITE_CNT;
		var l_COMPOSITE_ID = new Array();
		var l_COMPOSITE_NAME = new Array();

		var f_DMT;

		var l_DMT_Val = new Array();

		var MENU_ID;

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

		function
		setLotCountTable(lotCount)
		{
			var table = document.getElementById('table_1');
			var row_count = table.rows.length;

			for(var ri = 0;ri < row_count;ri ++) table.deleteRow(0);

			var row1 = document.createElement('tr');

			AddColumn(row1, "Lot");
			
			for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++)
			{
				AddColumn(row1, l_INGREDIENT_NAME[ac] + "(%)");
			}

			table.appendChild(row1);

			for(var i = 0;i < lotCount; i ++)
			{
				idx = Number(i) + 1;

				var table_row = document.createElement('tr');

				AddColumn(table_row, idx);

				//	edt_ig1_1_1
				for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++)
				{
					var cn  = "edt_ig_" + (ac + 1).toString() + "_" + (idx).toString();

					AddColumn(table_row, '<td><input readonly onfocus="this.blur()" style="color:black; font-weight:bold; border:0px; background-color:transparent" id="' + cn + '" style="width:50px;"></td>');
				}

				table.appendChild(table_row);						
			}
			table.width = "900px";
		}

		function
		setAssayTable(lotCount)
		{
			//	console.log('setAssayTable : ' + lotCount);

			var table = document.getElementById('tbl_Assay');
			var row_count = table.rows.length;

			for(var ri = 0;ri < row_count;ri ++) table.deleteRow(0);

			var row1 = document.createElement('tr');

			AddColumn(row1, "LOT NO");
			AddColumn(row1, "Weight(dmt)");
			
			for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++)
			{
				AddColumn(row1, l_INGREDIENT_NAME[ac] + "(%)");
			}

			table.appendChild(row1);

			for(var i = 0;i < lotCount; i ++)
			{
				idx = Number(i) + 1;

				var table_row = document.createElement('tr');

				AddColumn(table_row, idx);

				//	edt_ig1_1_1
				//	dmt 추가됨
				for(var ac = 0;ac < (l_INGREDIENT_CNT + 1);ac ++)
				{
					var cn  = "edt_assay_ig_" + (ac + 1).toString() + "_" + (idx).toString();

					//	console.log(cn);
					AddColumn(table_row, '<td><input readonly onfocus="this.blur()" style="color:black; font-weight:bold; border:0px; background-color:transparent" id="' + cn + '" style="width:50px;"></td>');
				}

				table.appendChild(table_row);						
			}

			table.width = "900px";
		}

		function
		findIGCode(ig_code)
		{
			//	console.log(l_CPS_IG.length + ',' + ig_code);

			for(var i = 0;i < l_CPS_IG.length;i ++)
			{
				if(l_CPS_IG[i] == ig_code)
				{
					//	console.log('findIGCode : ' + i);
					return i;
				}
			}

			//	console.log('findIGCode : NG');

			return 0;
		}

		function
		setCompositeTable()
		{
			//	console.log('setCompositeTable');

			var table = document.getElementById('tbl_Composite');
			var row_count = table.rows.length;

			for(var ri = 0;ri < row_count;ri ++) table.deleteRow(0);

			var row1 = document.createElement('tr');

			AddColumn(row1, "LOT");
			AddColumn(row1, "Weight(dmt)");

			//	console.log(l_COMPOSITE_CNT);
			
			for(var ac = 0;ac < l_COMPOSITE_CNT;ac ++)
			{
				AddColumn(row1, l_COMPOSITE_NAME[ac] + "(%)");
			}

			table.appendChild(row1);

			var row2 = document.createElement('tr');

			AddColumn(row2, "Composite");
			AddColumn(row2, f_DMT);

			for(var ac = 0;ac < l_COMPOSITE_CNT;ac ++)
			{
				var ig_idx = findIGCode(l_COMPOSITE_ID[ac]);

				//	console.log(l_IG_VALUE.length + ',' + ig_idx + ',' + l_IG_VALUE[ig_idx]);
				AddColumn(row2, l_IG_VALUE[ig_idx]);
			}

			table.appendChild(row2);
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

		function load_composite_ig_info() {
			$.ajax({
				url : "/yp/zpp/ore/zpp_ore_req_cps_ig_list",
				type : "POST",
				cache : false,
				async : false,
				data : {
					MASTER_ID : l_MASTER_ID,
					_csrf : '${_csrf.token}'
				},
				dataType : "json",
				success : function(result) {
					//	console.log("/yp/zpp/ore/zpp_ore_req_cps_ig_list success : " + result.cps_ig_list);

					l_COMPOSITE_CNT = 0;

					for (var i in result.cps_ig_list) {
						l_COMPOSITE_ID[i] = result.cps_ig_list[i].INGREDIENT_ID;
						l_COMPOSITE_NAME[i] = result.cps_ig_list[i].INGREDIENT_NAME;

						if(l_COMPOSITE_ID[i] != "") l_COMPOSITE_CNT ++;

						//	console.log(l_COMPOSITE_ID[i] + " " + l_COMPOSITE_NAME[i]);
					}

					setCompositeTable();
				},
				error : function(request, status, error) {
					//	console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
				}
			});
		}

		function get_Values() {
		}

		function closePopup() {
			self.close();	
		}

		function load_Def() {
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
						l_LOT_COUNT = result.data.LOT_COUNT;

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

						setAssayTable(l_LOT_COUNT);
						set_Assay_Value();
					}
					else {
						for(var si = 0;si < 30;si ++) {
							l_DMT_Val[si] = 0;
						}
					}
				},
				error : function(request, status, error) {
					//	console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
				}
			});
		}

		function
		load_InitValue() {
			$.ajax({
				url : "/yp/zpp/ore/zpp_ore_get_fixed_value",
				type : "POST",
			    cache:false,
			    async:true, 
				data : {
					MASTER_ID : l_MASTER_ID,
					MENU_ID : MENU_ID,
					_csrf : '${_csrf.token}'
					},
				dataType : "json",
				success : function(result) {
					//	console.log("/yp/zpp/ore/zpp_ore_get_fixed_value success : " +
					//			result.fixedValueList.ADJUST_IG_1 + "," +
					//			result.fixedValueList.ADJUST_IG_2 + "," +
					//			result.fixedValueList.ADJUST_IG_3 + "," +
					//			result.fixedValueList.ADJUST_IG_4);
					
					/**
					 * 2022-12-16 smh 전자결재 유무
					 */
					render_edoc(result.oreEdocInfoMap);

					l_LOT_COUNT = result.LOT_COUNT;
					document.getElementById("edt_LOT_COUNT").value = l_LOT_COUNT;

					l_IG_VALUE[0] = result.fixedValueList.IG_VALUE_1;
					l_IG_VALUE[1] = result.fixedValueList.IG_VALUE_2;
					l_IG_VALUE[2] = result.fixedValueList.IG_VALUE_3;
					l_IG_VALUE[3] = result.fixedValueList.IG_VALUE_4;
					l_IG_VALUE[4] = result.fixedValueList.IG_VALUE_5;
					l_IG_VALUE[5] = result.fixedValueList.IG_VALUE_6;
					l_IG_VALUE[6] = result.fixedValueList.IG_VALUE_7;
					l_IG_VALUE[7] = result.fixedValueList.IG_VALUE_8;
					l_IG_VALUE[8] = result.fixedValueList.IG_VALUE_9;
					l_IG_VALUE[9] = result.fixedValueList.IG_VALUE_10;
					l_IG_VALUE[10] = result.fixedValueList.IG_VALUE_11;
					l_IG_VALUE[11] = result.fixedValueList.IG_VALUE_12;
					l_IG_VALUE[12] = result.fixedValueList.IG_VALUE_13;
					l_IG_VALUE[13] = result.fixedValueList.IG_VALUE_14;
					l_IG_VALUE[14] = result.fixedValueList.IG_VALUE_15;
					l_IG_VALUE[15] = result.fixedValueList.IG_VALUE_16;
					l_IG_VALUE[16] = result.fixedValueList.IG_VALUE_17;
					l_IG_VALUE[17] = result.fixedValueList.IG_VALUE_18;
					l_IG_VALUE[18] = result.fixedValueList.IG_VALUE_19;
					l_IG_VALUE[19] = result.fixedValueList.IG_VALUE_20;
					l_IG_VALUE[20] = result.fixedValueList.IG_VALUE_21;
					l_IG_VALUE[21] = result.fixedValueList.IG_VALUE_22;
					l_IG_VALUE[22] = result.fixedValueList.IG_VALUE_23;
					l_IG_VALUE[23] = result.fixedValueList.IG_VALUE_24;
					l_IG_VALUE[24] = result.fixedValueList.IG_VALUE_25;
					l_IG_VALUE[25] = result.fixedValueList.IG_VALUE_26;
					l_IG_VALUE[26] = result.fixedValueList.IG_VALUE_27;
					l_IG_VALUE[27] = result.fixedValueList.IG_VALUE_28;
					l_IG_VALUE[28] = result.fixedValueList.IG_VALUE_29;
					l_IG_VALUE[29] = result.fixedValueList.IG_VALUE_30;
					l_IG_VALUE[30] = result.fixedValueList.IG_VALUE_31;

					l_PM_VALUE[0] =  result.fixedValueList.PM_100_VALUE;
					l_PM_VALUE[1] =  result.fixedValueList.PM_200_VALUE;
					l_PM_VALUE[2] =  result.fixedValueList.PM_325_VALUE;
					l_PM_VALUE[3] =  result.fixedValueList.PM_400_VALUE;
					l_PM_VALUE[4] =  result.fixedValueList.PM_M400_VALUE;

					l_ADJUST_IG_1 = result.fixedValueList.ADJUST_IG_1;
					l_ADJUST_IG_2 = result.fixedValueList.ADJUST_IG_2;
					l_ADJUST_IG_3 = result.fixedValueList.ADJUST_IG_3;
					l_ADJUST_IG_4 = result.fixedValueList.ADJUST_IG_4;

					l_LOT_IG_VALUE[0][0] = result.fixedValueList.LOT_1_IG_1_VALUE;
					l_LOT_IG_VALUE[0][1] = result.fixedValueList.LOT_1_IG_2_VALUE;
					l_LOT_IG_VALUE[0][2] = result.fixedValueList.LOT_1_IG_3_VALUE;
					l_LOT_IG_VALUE[0][3] = result.fixedValueList.LOT_1_IG_4_VALUE;
					l_LOT_IG_VALUE[1][0] = result.fixedValueList.LOT_2_IG_1_VALUE;
					l_LOT_IG_VALUE[1][1] = result.fixedValueList.LOT_2_IG_2_VALUE;
					l_LOT_IG_VALUE[1][2] = result.fixedValueList.LOT_2_IG_3_VALUE;
					l_LOT_IG_VALUE[1][3] = result.fixedValueList.LOT_2_IG_4_VALUE;
					l_LOT_IG_VALUE[2][0] = result.fixedValueList.LOT_3_IG_1_VALUE;
					l_LOT_IG_VALUE[2][1] = result.fixedValueList.LOT_3_IG_2_VALUE;
					l_LOT_IG_VALUE[2][2] = result.fixedValueList.LOT_3_IG_3_VALUE;
					l_LOT_IG_VALUE[2][3] = result.fixedValueList.LOT_3_IG_4_VALUE;
					l_LOT_IG_VALUE[3][0] = result.fixedValueList.LOT_4_IG_1_VALUE;
					l_LOT_IG_VALUE[3][1] = result.fixedValueList.LOT_4_IG_2_VALUE;
					l_LOT_IG_VALUE[3][2] = result.fixedValueList.LOT_4_IG_3_VALUE;
					l_LOT_IG_VALUE[3][3] = result.fixedValueList.LOT_4_IG_4_VALUE;
					l_LOT_IG_VALUE[4][0] = result.fixedValueList.LOT_5_IG_1_VALUE;
					l_LOT_IG_VALUE[4][1] = result.fixedValueList.LOT_5_IG_2_VALUE;
					l_LOT_IG_VALUE[4][2] = result.fixedValueList.LOT_5_IG_3_VALUE;
					l_LOT_IG_VALUE[4][3] = result.fixedValueList.LOT_5_IG_4_VALUE;
					l_LOT_IG_VALUE[5][0] = result.fixedValueList.LOT_6_IG_1_VALUE;
					l_LOT_IG_VALUE[5][1] = result.fixedValueList.LOT_6_IG_2_VALUE;
					l_LOT_IG_VALUE[5][2] = result.fixedValueList.LOT_6_IG_3_VALUE;
					l_LOT_IG_VALUE[5][3] = result.fixedValueList.LOT_6_IG_4_VALUE;
					l_LOT_IG_VALUE[6][0] = result.fixedValueList.LOT_7_IG_1_VALUE;
					l_LOT_IG_VALUE[6][1] = result.fixedValueList.LOT_7_IG_2_VALUE;
					l_LOT_IG_VALUE[6][2] = result.fixedValueList.LOT_7_IG_3_VALUE;
					l_LOT_IG_VALUE[6][3] = result.fixedValueList.LOT_7_IG_4_VALUE;
					l_LOT_IG_VALUE[7][0] = result.fixedValueList.LOT_8_IG_1_VALUE;
					l_LOT_IG_VALUE[7][1] = result.fixedValueList.LOT_8_IG_2_VALUE;
					l_LOT_IG_VALUE[7][2] = result.fixedValueList.LOT_8_IG_3_VALUE;
					l_LOT_IG_VALUE[7][3] = result.fixedValueList.LOT_8_IG_4_VALUE;
					l_LOT_IG_VALUE[8][0] = result.fixedValueList.LOT_9_IG_1_VALUE;
					l_LOT_IG_VALUE[8][1] = result.fixedValueList.LOT_9_IG_2_VALUE;
					l_LOT_IG_VALUE[8][2] = result.fixedValueList.LOT_9_IG_3_VALUE;
					l_LOT_IG_VALUE[8][3] = result.fixedValueList.LOT_9_IG_4_VALUE;
					l_LOT_IG_VALUE[9][0] = result.fixedValueList.LOT_10_IG_1_VALUE;
					l_LOT_IG_VALUE[9][1] = result.fixedValueList.LOT_10_IG_2_VALUE;
					l_LOT_IG_VALUE[9][2] = result.fixedValueList.LOT_10_IG_3_VALUE;
					l_LOT_IG_VALUE[9][3] = result.fixedValueList.LOT_10_IG_4_VALUE;
					l_LOT_IG_VALUE[10][0] = result.fixedValueList.LOT_11_IG_1_VALUE;
					l_LOT_IG_VALUE[10][1] = result.fixedValueList.LOT_11_IG_2_VALUE;
					l_LOT_IG_VALUE[10][2] = result.fixedValueList.LOT_11_IG_3_VALUE;
					l_LOT_IG_VALUE[10][3] = result.fixedValueList.LOT_11_IG_4_VALUE;
					l_LOT_IG_VALUE[11][0] = result.fixedValueList.LOT_12_IG_1_VALUE;
					l_LOT_IG_VALUE[11][1] = result.fixedValueList.LOT_12_IG_2_VALUE;
					l_LOT_IG_VALUE[11][2] = result.fixedValueList.LOT_12_IG_3_VALUE;
					l_LOT_IG_VALUE[11][3] = result.fixedValueList.LOT_12_IG_4_VALUE;
					l_LOT_IG_VALUE[12][0] = result.fixedValueList.LOT_13_IG_1_VALUE;
					l_LOT_IG_VALUE[12][1] = result.fixedValueList.LOT_13_IG_2_VALUE;
					l_LOT_IG_VALUE[12][2] = result.fixedValueList.LOT_13_IG_3_VALUE;
					l_LOT_IG_VALUE[12][3] = result.fixedValueList.LOT_13_IG_4_VALUE;
					l_LOT_IG_VALUE[13][0] = result.fixedValueList.LOT_14_IG_1_VALUE;
					l_LOT_IG_VALUE[13][1] = result.fixedValueList.LOT_14_IG_2_VALUE;
					l_LOT_IG_VALUE[13][2] = result.fixedValueList.LOT_14_IG_3_VALUE;
					l_LOT_IG_VALUE[13][3] = result.fixedValueList.LOT_14_IG_4_VALUE;
					l_LOT_IG_VALUE[14][0] = result.fixedValueList.LOT_15_IG_1_VALUE;
					l_LOT_IG_VALUE[14][1] = result.fixedValueList.LOT_15_IG_2_VALUE;
					l_LOT_IG_VALUE[14][2] = result.fixedValueList.LOT_15_IG_3_VALUE;
					l_LOT_IG_VALUE[14][3] = result.fixedValueList.LOT_15_IG_4_VALUE;
					l_LOT_IG_VALUE[15][0] = result.fixedValueList.LOT_16_IG_1_VALUE;
					l_LOT_IG_VALUE[15][1] = result.fixedValueList.LOT_16_IG_2_VALUE;
					l_LOT_IG_VALUE[15][2] = result.fixedValueList.LOT_16_IG_3_VALUE;
					l_LOT_IG_VALUE[15][3] = result.fixedValueList.LOT_16_IG_4_VALUE;
					l_LOT_IG_VALUE[16][0] = result.fixedValueList.LOT_17_IG_1_VALUE;
					l_LOT_IG_VALUE[16][1] = result.fixedValueList.LOT_17_IG_2_VALUE;
					l_LOT_IG_VALUE[16][2] = result.fixedValueList.LOT_17_IG_3_VALUE;
					l_LOT_IG_VALUE[16][3] = result.fixedValueList.LOT_17_IG_4_VALUE;
					l_LOT_IG_VALUE[17][0] = result.fixedValueList.LOT_18_IG_1_VALUE;
					l_LOT_IG_VALUE[17][1] = result.fixedValueList.LOT_18_IG_2_VALUE;
					l_LOT_IG_VALUE[17][2] = result.fixedValueList.LOT_18_IG_3_VALUE;
					l_LOT_IG_VALUE[17][3] = result.fixedValueList.LOT_18_IG_4_VALUE;
					l_LOT_IG_VALUE[18][0] = result.fixedValueList.LOT_19_IG_1_VALUE;
					l_LOT_IG_VALUE[18][1] = result.fixedValueList.LOT_19_IG_2_VALUE;
					l_LOT_IG_VALUE[18][2] = result.fixedValueList.LOT_19_IG_3_VALUE;
					l_LOT_IG_VALUE[18][3] = result.fixedValueList.LOT_19_IG_4_VALUE;
					l_LOT_IG_VALUE[19][0] = result.fixedValueList.LOT_20_IG_1_VALUE;
					l_LOT_IG_VALUE[19][1] = result.fixedValueList.LOT_20_IG_2_VALUE;
					l_LOT_IG_VALUE[19][2] = result.fixedValueList.LOT_20_IG_3_VALUE;
					l_LOT_IG_VALUE[19][3] = result.fixedValueList.LOT_20_IG_4_VALUE;
					l_LOT_IG_VALUE[20][0] = result.fixedValueList.LOT_21_IG_1_VALUE;
					l_LOT_IG_VALUE[20][1] = result.fixedValueList.LOT_21_IG_2_VALUE;
					l_LOT_IG_VALUE[20][2] = result.fixedValueList.LOT_21_IG_3_VALUE;
					l_LOT_IG_VALUE[20][3] = result.fixedValueList.LOT_21_IG_4_VALUE;
					l_LOT_IG_VALUE[21][0] = result.fixedValueList.LOT_22_IG_1_VALUE;
					l_LOT_IG_VALUE[21][1] = result.fixedValueList.LOT_22_IG_2_VALUE;
					l_LOT_IG_VALUE[21][2] = result.fixedValueList.LOT_22_IG_3_VALUE;
					l_LOT_IG_VALUE[21][3] = result.fixedValueList.LOT_22_IG_4_VALUE;
					l_LOT_IG_VALUE[22][0] = result.fixedValueList.LOT_23_IG_1_VALUE;
					l_LOT_IG_VALUE[22][1] = result.fixedValueList.LOT_23_IG_2_VALUE;
					l_LOT_IG_VALUE[22][2] = result.fixedValueList.LOT_23_IG_3_VALUE;
					l_LOT_IG_VALUE[22][3] = result.fixedValueList.LOT_23_IG_4_VALUE;
					l_LOT_IG_VALUE[23][0] = result.fixedValueList.LOT_24_IG_1_VALUE;
					l_LOT_IG_VALUE[23][1] = result.fixedValueList.LOT_24_IG_2_VALUE;
					l_LOT_IG_VALUE[23][2] = result.fixedValueList.LOT_24_IG_3_VALUE;
					l_LOT_IG_VALUE[23][3] = result.fixedValueList.LOT_24_IG_4_VALUE;
					l_LOT_IG_VALUE[24][0] = result.fixedValueList.LOT_25_IG_1_VALUE;
					l_LOT_IG_VALUE[24][1] = result.fixedValueList.LOT_25_IG_2_VALUE;
					l_LOT_IG_VALUE[24][2] = result.fixedValueList.LOT_25_IG_3_VALUE;
					l_LOT_IG_VALUE[24][3] = result.fixedValueList.LOT_25_IG_4_VALUE;
					l_LOT_IG_VALUE[25][0] = result.fixedValueList.LOT_26_IG_1_VALUE;
					l_LOT_IG_VALUE[25][1] = result.fixedValueList.LOT_26_IG_2_VALUE;
					l_LOT_IG_VALUE[25][2] = result.fixedValueList.LOT_26_IG_3_VALUE;
					l_LOT_IG_VALUE[25][3] = result.fixedValueList.LOT_26_IG_4_VALUE;
					l_LOT_IG_VALUE[26][0] = result.fixedValueList.LOT_27_IG_1_VALUE;
					l_LOT_IG_VALUE[26][1] = result.fixedValueList.LOT_27_IG_2_VALUE;
					l_LOT_IG_VALUE[26][2] = result.fixedValueList.LOT_27_IG_3_VALUE;
					l_LOT_IG_VALUE[26][3] = result.fixedValueList.LOT_27_IG_4_VALUE;
					l_LOT_IG_VALUE[27][0] = result.fixedValueList.LOT_28_IG_1_VALUE;
					l_LOT_IG_VALUE[27][1] = result.fixedValueList.LOT_28_IG_2_VALUE;
					l_LOT_IG_VALUE[27][2] = result.fixedValueList.LOT_28_IG_3_VALUE;
					l_LOT_IG_VALUE[27][3] = result.fixedValueList.LOT_28_IG_4_VALUE;
					l_LOT_IG_VALUE[28][0] = result.fixedValueList.LOT_29_IG_1_VALUE;
					l_LOT_IG_VALUE[28][1] = result.fixedValueList.LOT_29_IG_2_VALUE;
					l_LOT_IG_VALUE[28][2] = result.fixedValueList.LOT_29_IG_3_VALUE;
					l_LOT_IG_VALUE[28][3] = result.fixedValueList.LOT_29_IG_4_VALUE;
					l_LOT_IG_VALUE[29][0] = result.fixedValueList.LOT_30_IG_1_VALUE;
					l_LOT_IG_VALUE[29][1] = result.fixedValueList.LOT_30_IG_2_VALUE;
					l_LOT_IG_VALUE[29][2] = result.fixedValueList.LOT_30_IG_3_VALUE;
					l_LOT_IG_VALUE[29][3] = result.fixedValueList.LOT_30_IG_4_VALUE;
					
					setLotCountTable(l_LOT_COUNT);
					set_Value();
					setAssayTable(l_LOT_COUNT);
					set_Assay_Value();
					load_composite_ig_info();
				},
				error : function(request, status, error) {
					//	console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
				}
			});
		}

		function load_bl_info() {
			$.ajax({
				url : "/yp/zpp/ore/zpp_ore_req_bl_info",
				type : "POST",
			    cache:false,
			    async:true, 
				data : {
					MASTER_ID : l_MASTER_ID,
					_csrf : '${_csrf.token}'
					},
				dataType : "json",
				success : function(result) {
					//	console.log("/yp/zpp/ore/zpp_ore_req_bl_info success : " + result.data_count);
					//	console.log(result);
					
					if(result.data_count > 0) {
						f_DMT = result.data.DMT;
					}
					else {
						f_DMT = 0.0;
					}
					
					//	console.log(f_DMT);
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

		// 전자결재
		$(".btn_edoc").on("click", function() {
			const form_id = 'EF167115238248813',
				  master_id = l_MASTER_ID,
				  menu_id = MENU_ID,
				  url = `http:\/\/gwdev.ypzinc.co.kr/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=\${form_id}&MASTER_ID=\${master_id}&MENU_ID=\${menu_id}`;
				  
			//	console.log('[TEST]url:',url);
			window.open(url, "전자결재", "scrollbars=auto,width=1000,height=900");
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

						$('select[name="seller_id"]').append("<option value='" + seller_id + "'>" + seller_name + "</option>");
					}
				},
				error : function(request, status, error) {
					//	console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
				}
			});
		}

		function getIGList()
		{
			$.ajax({
				url : "/yp/zpp/ore/zpp_ore_get_ingredient_list",
				type : "POST",
				cache : false,
				async : false,
				data : {
					_csrf : '${_csrf.token}'
				},
				dataType : "json",
				success : function(result) {
					for (var i in result.listValue) {
						var ig_id = result.listValue[i].INGREDIENT_ID;
						var ig_name = result.listValue[i].INGREDIENT_NAME;

						l_CPS_IG[i] = ig_id;
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
			getIGList();

			load_Def();

			l_MASTER_ID = '${req_data.MASTER_ID}';
			MENU_ID = '${req_data.MENU_ID}';
			
			document.getElementById("edt_MATERIAL_ID").value = get_material_name('${req_data.MATERIAL_ID}', '${req_data.SHEET_ID}');
			document.getElementById("edt_SELLER_ID").value = get_seller_name('${req_data.SELLER_ID}');
			document.getElementById("edt_IMPORT_DATE").value = '${req_data.IMPORT_DATE}';

			set_NS('lb_Material', ': ' + get_material_name('${req_data.MATERIAL_ID}', '${req_data.SHEET_ID}'));
			set_NS('lb_Vessel', ': ' + '${req_data.VESSEL_NAME}');
			set_NS('lb_ImportDate', ': ' + '${req_data.IMPORT_DATE}');
			set_NS('lb_Seller', ': ' + get_seller_name('${req_data.SELLER_ID}'));

			const oreEdocInfoMap = JSON.parse('${oreEdocInfoMap}');
			render_edoc(oreEdocInfoMap);

			load_bl_info();
			load_ingredient_info();
			load_InitValue();
			load_mt_info();
		});

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
			//	console.log('set_Value : ' + l_LOT_COUNT);
			for(var si = 0;si < l_LOT_COUNT;si ++) {
				for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++)
				{
					cn = "edt_ig_" + (ac + 1).toString() + "_" + (si + 1).toString();
					
					switch(ac)
					{
					case 0:
						set_NS(cn, l_LOT_IG_VALUE[si][ac] - Number(l_ADJUST_IG_1));
						break;
					case 1:
						set_NS(cn, l_LOT_IG_VALUE[si][ac] - Number(l_ADJUST_IG_2));
						break;
					case 2:
						set_NS(cn, (l_LOT_IG_VALUE[si][ac] - Number(l_ADJUST_IG_3)).toFixed(3));
						break;
					case 3:
						set_NS(cn, (l_LOT_IG_VALUE[si][ac] - Number(l_ADJUST_IG_4)).toFixed(3));
						break;
					}
				}
			}
		}

		function set_Assay_Value() {
			//	console.log('set_Assay_Value : ' + l_LOT_COUNT);
			for(var si = 0;si < l_LOT_COUNT;si ++) {
				cn = "edt_assay_ig_1_" + (si + 1).toString();
				set_NS(cn, l_DMT_Val[si]);

				for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++)
				{
					cn = "edt_assay_ig_" + (ac + 2).toString() + "_" + (si + 1).toString();

					//	console.log('sav : ' + cn);
					switch(ac)
					{
					case 0:
						set_NS(cn, l_LOT_IG_VALUE[si][ac] - Number(l_ADJUST_IG_1));
						break;
					case 1:
						set_NS(cn, l_LOT_IG_VALUE[si][ac] - Number(l_ADJUST_IG_2));
						break;
					case 2:
						set_NS(cn, (l_LOT_IG_VALUE[si][ac] - Number(l_ADJUST_IG_3)).toFixed(3));
						break;
					case 3:
						set_NS(cn, (l_LOT_IG_VALUE[si][ac] - Number(l_ADJUST_IG_4)).toFixed(3));
						break;
					}
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
		
		/**
		 * 전자결재 화면 표시 렌더링
		 */
		function render_edoc(oreEdocInfoMap) {
			const edoc_status = isEmpty(oreEdocInfoMap) ? '' : oreEdocInfoMap.EDOC_STATUS,
				  $oEdocStatusText = $(".edoc_status_txt"),
				  $oEdocButton = $(".btn_edoc");
			
			/** 
			 * [전자결재 상태표]
			 * A : SAP에서 작성완료  => X
			 * 0 : 결재진행중 => 결재중
			 * 4 : 결재진행중 => X
			 * 5 : 반려상태 => 반려
			 * 7 : 결재상신을 취소한 상태 => 회수
			 * F : 수신결재완료 => 완료
			 * D : 사용자에의한 삭제 => 삭제
			 * U : 수신결재완료 => X
			 * J : 수신결재반려후 반송 => X
			 * E : 내부결재종료 => 완료
			 * R : 수신접수 => X
			 * S : 내부결재완료 => 완료
			 * C : 완전삭제 => X
			 * Z : 미상신
		     */
		    $oEdocButton.hide();
			$oEdocStatusText.hide();
			 
			if(edoc_status === 'E' || edoc_status === 'F'){
				$oEdocStatusText.html('결재완료');
				$oEdocStatusText.show();
			}else if(edoc_status === '0'){
				$oEdocStatusText.html('결재중');
				$oEdocStatusText.show();
			}else if(edoc_status === '5'){
				$oEdocStatusText.html('반려');
				$oEdocStatusText.show();
			}else{
				$oEdocStatusText.val('');
				$oEdocButton.show();
			}
		}

	</script>
</body>
</html>