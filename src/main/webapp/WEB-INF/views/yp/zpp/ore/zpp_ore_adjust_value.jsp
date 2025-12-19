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
	<title>정광 성분분석 초기값 조정</title>
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
		.input_cell
		{
			width:110px;
		}
		.tbl_box th {
			border: 1px solid #000000;
			height:30px;
			vertical-align: middle;
		}
	</style>

	<div id="popup">
		<div class="pop_header">
			정광 성분분석 초기값 조정
		</div>
		<div class="pop_content">
			<div style="width:100%;padding:10px">
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
									<input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_MATERIAL_NAME">
								</td>
								<th>업체명</th>
								<td>
									<input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_SELLER_NAME">
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

						<div class="btn_wrap">
							<button class="btn btn_search" id="register_btn" type="">조정값 등록</button>
						</div>
					</div>
				</section>
			</div>

			<div style="width:60%;padding:10px">
				<section>
					<div class="tbl_box">
						<table id="table_1" cellspacing="0" cellpadding="0">
						</table>
						<button class="btn btn_search" id="adjust_btn" type="">조정값 반영</button>
					</div>
				</section>
			</div>

			<div style="width:100%;padding:10px">
				<section>
					<div class="tbl_box">
						<table id="table_grid">
						</table>
					</div>
				</section>
			</div>
		</div>
	</div>
	<script>
		var l_MASTER_ID;
		var l_MaterialName;
		var l_SheetName;
		var l_SellerName;
		var l_ImportDate;
		var l_ADJUST_IG_1;
		var l_ADJUST_IG_2;
		var l_ADJUST_IG_3;
		var l_ADJUST_IG_4;

		var l_INGREDIENT_CNT;
		var l_INGREDIENT_ID = new Array();
		var	l_INGREDIENT_NAME = new Array();

		var l_LOT_COUNT;

		var l_LOT_IG_VALUE = create2DArray(30, 4);


		function create2DArray(rows, columns) {
		    var arr = new Array(rows);
		    for (var i = 0; i < rows; i++) {
		        arr[i] = new Array(columns);
		    }

		    return arr;
		}

		function numberMaxLength(e) {
			if(e.value.length > e.maxLength) {
				e.value = e.value.slice(0, e.maxLength);
	        }
	    }
		 
		/**
		 * 2022-12-14 smh 속성 추가 
		 * 추가된 Param : oAttributes
		 */
		function AddColumn(row, contents, oAttributes)
		{
			var table_data = document.createElement('td');

			table_data.innerHTML = contents;
			
			// 속성 적용 			
			for (const key in oAttributes) {
				table_data.setAttribute(key , oAttributes[key]);
			}
			
			row.appendChild(table_data);
		}

		function setIngredientTable()
		{
			var table = document.getElementById('table_1');
			var row_count = table.rows.length;

			for (var ri = 0; ri < row_count; ri++) table.deleteRow(0);

			var row1 = document.createElement('tr');

			AddColumn(row1, '성분');

			for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++) {
				AddColumn(row1, l_INGREDIENT_NAME[ac] + '(%)');
			}

			table.appendChild(row1);

			var table_row = document.createElement('tr');

			AddColumn(table_row, '조정값');

			for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++) {
				var cn = "edt_ADJUST_IG_" + (ac + 1).toString();

				AddColumn(table_row, '<input type="number" id="' + cn + '" maxlength="6" oninput="numberMaxLength(this);">');
			}

			table.appendChild(table_row);
		}

		function setLotCountTable(lotCount)
		{
			var table = document.getElementById('table_grid');
			var row_count = table.rows.length;

			for(var ri = 0;ri < row_count;ri ++) table.deleteRow(0);

			var row1 = document.createElement('tr');

			if(l_INGREDIENT_CNT == 2)
			{
				AddColumn(row1, "Lot", { rowspan : 2 });
				AddColumn(row1, "초기확정", { colspan : 2 });
				AddColumn(row1, "조정", { colspan : 2 });
				AddColumn(row1, "최종확정", { colspan : 2 });
			}
			else if(l_INGREDIENT_CNT == 3)
			{
				AddColumn(row1, "Lot", { rowspan : 2 });
				AddColumn(row1, "초기확정", { colspan : 3 });
				AddColumn(row1, "조정", { colspan : 3 });
				AddColumn(row1, "최종확정", { colspan : 3 });
			}
			else if(l_INGREDIENT_CNT == 4)
			{
				AddColumn(row1, "Lot", { rowspan : 2 });
				AddColumn(row1, "초기확정", { colspan : 4 });
				AddColumn(row1, "조정", { colspan : 4 });
				AddColumn(row1, "최종확정", { colspan : 4 });
			}

			table.appendChild(row1);

			var row2 = document.createElement('tr');

			for(var ti = 0;ti < 3;ti ++)
			{
				for(var ac = 0;ac < l_INGREDIENT_CNT; ac ++)
				{
					AddColumn(row2, l_INGREDIENT_NAME[ac] + '(%)');
				}
			}

			table.appendChild(row2);

			for(var i = 0;i < lotCount; i ++)
			{
				idx = Number(i) + 1;

				var table_row = document.createElement('tr');

				AddColumn(table_row, idx);

				//	edt_ig1_1_1
				for(var ti = 0;ti < 3;ti ++)
				{
					for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++)
					{
						var cn  = "edt_ig" + (ac + 1).toString() + "_" + (ti + 1).toString() + "_" + (idx).toString();

						AddColumn(table_row, '<input readonly onfocus="this.blur()" style="color:black; font-weight:bold; border:0px; background-color:transparent; width:110px" id="' + cn + '">');
					}
				}

				table.appendChild(table_row);						
			}
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

		function
		load_InitValue() {
			$.ajax({
				url : "/yp/zpp/ore/zpp_ore_get_init_value",
				type : "POST",
			    cache:false,
			    async:true, 
				data : {
					MASTER_ID : l_MASTER_ID,
					_csrf : '${_csrf.token}'
					},
				dataType : "json",
				success : function(result) {
					//	console.log("/yp/zpp/ore/zpp_ore_get_init_value success : " +
					//			result.initValueList[0].ADJUST_IG_1 + "," + result.initValueList[0].ADJUST_IG_2 + "," + result.initValueList[0].ADJUST_IG_3);

					var sheet_id = '${req_data.SHEET_ID}';

					//	console.log(sheet_id);

					if(sheet_id == "0") l_SheetName = "";
					else l_SheetName = "(" + sheet_id + ")";

					l_MaterialName = result.initValueList[0].MATERIAL_NAME;
					l_SellerName = result.initValueList[0].SELLER_NAME;
					l_ImportDate = result.initValueList[0].IMPORT_DATE;

					l_LOT_COUNT = result.initValueList[0].LOT_COUNT;
					setLotCountTable(l_LOT_COUNT);
					setIngredientTable();
					
					l_ADJUST_IG_1 = result.initValueList[0].ADJUST_IG_1;
					l_ADJUST_IG_2 = result.initValueList[0].ADJUST_IG_2;
					l_ADJUST_IG_3 = result.initValueList[0].ADJUST_IG_3;
					l_ADJUST_IG_4 = result.initValueList[0].ADJUST_IG_4;

					l_LOT_IG_VALUE[0][0] = result.initValueList[0].LOT_1_IG_1_VALUE;
					l_LOT_IG_VALUE[0][1] = result.initValueList[0].LOT_1_IG_2_VALUE;
					l_LOT_IG_VALUE[0][2] = result.initValueList[0].LOT_1_IG_3_VALUE;
					l_LOT_IG_VALUE[0][3] = result.initValueList[0].LOT_1_IG_4_VALUE;
					l_LOT_IG_VALUE[1][0] = result.initValueList[0].LOT_2_IG_1_VALUE;
					l_LOT_IG_VALUE[1][1] = result.initValueList[0].LOT_2_IG_2_VALUE;
					l_LOT_IG_VALUE[1][2] = result.initValueList[0].LOT_2_IG_3_VALUE;
					l_LOT_IG_VALUE[1][3] = result.initValueList[0].LOT_2_IG_4_VALUE;
					l_LOT_IG_VALUE[2][0] = result.initValueList[0].LOT_3_IG_1_VALUE;
					l_LOT_IG_VALUE[2][1] = result.initValueList[0].LOT_3_IG_2_VALUE;
					l_LOT_IG_VALUE[2][2] = result.initValueList[0].LOT_3_IG_3_VALUE;
					l_LOT_IG_VALUE[2][3] = result.initValueList[0].LOT_3_IG_4_VALUE;
					l_LOT_IG_VALUE[3][0] = result.initValueList[0].LOT_4_IG_1_VALUE;
					l_LOT_IG_VALUE[3][1] = result.initValueList[0].LOT_4_IG_2_VALUE;
					l_LOT_IG_VALUE[3][2] = result.initValueList[0].LOT_4_IG_3_VALUE;
					l_LOT_IG_VALUE[3][3] = result.initValueList[0].LOT_4_IG_4_VALUE;
					l_LOT_IG_VALUE[4][0] = result.initValueList[0].LOT_5_IG_1_VALUE;
					l_LOT_IG_VALUE[4][1] = result.initValueList[0].LOT_5_IG_2_VALUE;
					l_LOT_IG_VALUE[4][2] = result.initValueList[0].LOT_5_IG_3_VALUE;
					l_LOT_IG_VALUE[4][3] = result.initValueList[0].LOT_5_IG_4_VALUE;
					l_LOT_IG_VALUE[5][0] = result.initValueList[0].LOT_6_IG_1_VALUE;
					l_LOT_IG_VALUE[5][1] = result.initValueList[0].LOT_6_IG_2_VALUE;
					l_LOT_IG_VALUE[5][2] = result.initValueList[0].LOT_6_IG_3_VALUE;
					l_LOT_IG_VALUE[5][3] = result.initValueList[0].LOT_6_IG_4_VALUE;
					l_LOT_IG_VALUE[6][0] = result.initValueList[0].LOT_7_IG_1_VALUE;
					l_LOT_IG_VALUE[6][1] = result.initValueList[0].LOT_7_IG_2_VALUE;
					l_LOT_IG_VALUE[6][2] = result.initValueList[0].LOT_7_IG_3_VALUE;
					l_LOT_IG_VALUE[6][3] = result.initValueList[0].LOT_7_IG_4_VALUE;
					l_LOT_IG_VALUE[7][0] = result.initValueList[0].LOT_8_IG_1_VALUE;
					l_LOT_IG_VALUE[7][1] = result.initValueList[0].LOT_8_IG_2_VALUE;
					l_LOT_IG_VALUE[7][2] = result.initValueList[0].LOT_8_IG_3_VALUE;
					l_LOT_IG_VALUE[7][3] = result.initValueList[0].LOT_8_IG_4_VALUE;
					l_LOT_IG_VALUE[8][0] = result.initValueList[0].LOT_9_IG_1_VALUE;
					l_LOT_IG_VALUE[8][1] = result.initValueList[0].LOT_9_IG_2_VALUE;
					l_LOT_IG_VALUE[8][2] = result.initValueList[0].LOT_9_IG_3_VALUE;
					l_LOT_IG_VALUE[8][3] = result.initValueList[0].LOT_9_IG_4_VALUE;
					l_LOT_IG_VALUE[9][0] = result.initValueList[0].LOT_10_IG_1_VALUE;
					l_LOT_IG_VALUE[9][1] = result.initValueList[0].LOT_10_IG_2_VALUE;
					l_LOT_IG_VALUE[9][2] = result.initValueList[0].LOT_10_IG_3_VALUE;
					l_LOT_IG_VALUE[9][3] = result.initValueList[0].LOT_10_IG_4_VALUE;
					l_LOT_IG_VALUE[10][0] = result.initValueList[0].LOT_11_IG_1_VALUE;
					l_LOT_IG_VALUE[10][1] = result.initValueList[0].LOT_11_IG_2_VALUE;
					l_LOT_IG_VALUE[10][2] = result.initValueList[0].LOT_11_IG_3_VALUE;
					l_LOT_IG_VALUE[10][3] = result.initValueList[0].LOT_11_IG_4_VALUE;
					l_LOT_IG_VALUE[11][0] = result.initValueList[0].LOT_12_IG_1_VALUE;
					l_LOT_IG_VALUE[11][1] = result.initValueList[0].LOT_12_IG_2_VALUE;
					l_LOT_IG_VALUE[11][2] = result.initValueList[0].LOT_12_IG_3_VALUE;
					l_LOT_IG_VALUE[11][3] = result.initValueList[0].LOT_12_IG_4_VALUE;
					l_LOT_IG_VALUE[12][0] = result.initValueList[0].LOT_13_IG_1_VALUE;
					l_LOT_IG_VALUE[12][1] = result.initValueList[0].LOT_13_IG_2_VALUE;
					l_LOT_IG_VALUE[12][2] = result.initValueList[0].LOT_13_IG_3_VALUE;
					l_LOT_IG_VALUE[12][3] = result.initValueList[0].LOT_13_IG_4_VALUE;
					l_LOT_IG_VALUE[13][0] = result.initValueList[0].LOT_14_IG_1_VALUE;
					l_LOT_IG_VALUE[13][1] = result.initValueList[0].LOT_14_IG_2_VALUE;
					l_LOT_IG_VALUE[13][2] = result.initValueList[0].LOT_14_IG_3_VALUE;
					l_LOT_IG_VALUE[13][3] = result.initValueList[0].LOT_14_IG_4_VALUE;
					l_LOT_IG_VALUE[14][0] = result.initValueList[0].LOT_15_IG_1_VALUE;
					l_LOT_IG_VALUE[14][1] = result.initValueList[0].LOT_15_IG_2_VALUE;
					l_LOT_IG_VALUE[14][2] = result.initValueList[0].LOT_15_IG_3_VALUE;
					l_LOT_IG_VALUE[14][3] = result.initValueList[0].LOT_15_IG_4_VALUE;
					l_LOT_IG_VALUE[15][0] = result.initValueList[0].LOT_16_IG_1_VALUE;
					l_LOT_IG_VALUE[15][1] = result.initValueList[0].LOT_16_IG_2_VALUE;
					l_LOT_IG_VALUE[15][2] = result.initValueList[0].LOT_16_IG_3_VALUE;
					l_LOT_IG_VALUE[15][3] = result.initValueList[0].LOT_16_IG_4_VALUE;
					l_LOT_IG_VALUE[16][0] = result.initValueList[0].LOT_17_IG_1_VALUE;
					l_LOT_IG_VALUE[16][1] = result.initValueList[0].LOT_17_IG_2_VALUE;
					l_LOT_IG_VALUE[16][2] = result.initValueList[0].LOT_17_IG_3_VALUE;
					l_LOT_IG_VALUE[16][3] = result.initValueList[0].LOT_17_IG_4_VALUE;
					l_LOT_IG_VALUE[17][0] = result.initValueList[0].LOT_18_IG_1_VALUE;
					l_LOT_IG_VALUE[17][1] = result.initValueList[0].LOT_18_IG_2_VALUE;
					l_LOT_IG_VALUE[17][2] = result.initValueList[0].LOT_18_IG_3_VALUE;
					l_LOT_IG_VALUE[17][3] = result.initValueList[0].LOT_18_IG_4_VALUE;
					l_LOT_IG_VALUE[18][0] = result.initValueList[0].LOT_19_IG_1_VALUE;
					l_LOT_IG_VALUE[18][1] = result.initValueList[0].LOT_19_IG_2_VALUE;
					l_LOT_IG_VALUE[18][2] = result.initValueList[0].LOT_19_IG_3_VALUE;
					l_LOT_IG_VALUE[18][3] = result.initValueList[0].LOT_19_IG_4_VALUE;
					l_LOT_IG_VALUE[19][0] = result.initValueList[0].LOT_20_IG_1_VALUE;
					l_LOT_IG_VALUE[19][1] = result.initValueList[0].LOT_20_IG_2_VALUE;
					l_LOT_IG_VALUE[19][2] = result.initValueList[0].LOT_20_IG_3_VALUE;
					l_LOT_IG_VALUE[19][3] = result.initValueList[0].LOT_20_IG_4_VALUE;
					l_LOT_IG_VALUE[20][0] = result.initValueList[0].LOT_21_IG_1_VALUE;
					l_LOT_IG_VALUE[20][1] = result.initValueList[0].LOT_21_IG_2_VALUE;
					l_LOT_IG_VALUE[20][2] = result.initValueList[0].LOT_21_IG_3_VALUE;
					l_LOT_IG_VALUE[20][3] = result.initValueList[0].LOT_21_IG_4_VALUE;
					l_LOT_IG_VALUE[21][0] = result.initValueList[0].LOT_22_IG_1_VALUE;
					l_LOT_IG_VALUE[21][1] = result.initValueList[0].LOT_22_IG_2_VALUE;
					l_LOT_IG_VALUE[21][2] = result.initValueList[0].LOT_22_IG_3_VALUE;
					l_LOT_IG_VALUE[21][3] = result.initValueList[0].LOT_22_IG_4_VALUE;
					l_LOT_IG_VALUE[22][0] = result.initValueList[0].LOT_23_IG_1_VALUE;
					l_LOT_IG_VALUE[22][1] = result.initValueList[0].LOT_23_IG_2_VALUE;
					l_LOT_IG_VALUE[22][2] = result.initValueList[0].LOT_23_IG_3_VALUE;
					l_LOT_IG_VALUE[22][3] = result.initValueList[0].LOT_23_IG_4_VALUE;
					l_LOT_IG_VALUE[23][0] = result.initValueList[0].LOT_24_IG_1_VALUE;
					l_LOT_IG_VALUE[23][1] = result.initValueList[0].LOT_24_IG_2_VALUE;
					l_LOT_IG_VALUE[23][2] = result.initValueList[0].LOT_24_IG_3_VALUE;
					l_LOT_IG_VALUE[23][3] = result.initValueList[0].LOT_24_IG_4_VALUE;
					l_LOT_IG_VALUE[24][0] = result.initValueList[0].LOT_25_IG_1_VALUE;
					l_LOT_IG_VALUE[24][1] = result.initValueList[0].LOT_25_IG_2_VALUE;
					l_LOT_IG_VALUE[24][2] = result.initValueList[0].LOT_25_IG_3_VALUE;
					l_LOT_IG_VALUE[24][3] = result.initValueList[0].LOT_25_IG_4_VALUE;
					l_LOT_IG_VALUE[25][0] = result.initValueList[0].LOT_26_IG_1_VALUE;
					l_LOT_IG_VALUE[25][1] = result.initValueList[0].LOT_26_IG_2_VALUE;
					l_LOT_IG_VALUE[25][2] = result.initValueList[0].LOT_26_IG_3_VALUE;
					l_LOT_IG_VALUE[25][3] = result.initValueList[0].LOT_26_IG_4_VALUE;
					l_LOT_IG_VALUE[26][0] = result.initValueList[0].LOT_27_IG_1_VALUE;
					l_LOT_IG_VALUE[26][1] = result.initValueList[0].LOT_27_IG_2_VALUE;
					l_LOT_IG_VALUE[26][2] = result.initValueList[0].LOT_27_IG_3_VALUE;
					l_LOT_IG_VALUE[26][3] = result.initValueList[0].LOT_27_IG_4_VALUE;
					l_LOT_IG_VALUE[27][0] = result.initValueList[0].LOT_28_IG_1_VALUE;
					l_LOT_IG_VALUE[27][1] = result.initValueList[0].LOT_28_IG_2_VALUE;
					l_LOT_IG_VALUE[27][2] = result.initValueList[0].LOT_28_IG_3_VALUE;
					l_LOT_IG_VALUE[27][3] = result.initValueList[0].LOT_28_IG_4_VALUE;
					l_LOT_IG_VALUE[28][0] = result.initValueList[0].LOT_29_IG_1_VALUE;
					l_LOT_IG_VALUE[28][1] = result.initValueList[0].LOT_29_IG_2_VALUE;
					l_LOT_IG_VALUE[28][2] = result.initValueList[0].LOT_29_IG_3_VALUE;
					l_LOT_IG_VALUE[28][3] = result.initValueList[0].LOT_29_IG_4_VALUE;
					l_LOT_IG_VALUE[29][0] = result.initValueList[0].LOT_30_IG_1_VALUE;
					l_LOT_IG_VALUE[29][1] = result.initValueList[0].LOT_30_IG_2_VALUE;
					l_LOT_IG_VALUE[29][2] = result.initValueList[0].LOT_30_IG_3_VALUE;
					l_LOT_IG_VALUE[29][3] = result.initValueList[0].LOT_30_IG_4_VALUE;

					set_Value();
					applyAdjustValue();
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

		$(document).ready(function() {
			l_MASTER_ID = '${req_data.MASTER_ID}';
// 			document.getElementById("edt_MATERIAL_ID").value = get_material_name('${req_data.MATERIAL_ID}');
// 			document.getElementById("edt_SELLER_ID").value = get_seller_name('${req_data.SELLER_ID}');
// 			document.getElementById("edt_IMPORT_DATE").value = '${req_data.IMPORT_DATE}';

// 			load_Def();

			load_ingredient_info();
			load_InitValue();
		});

		// 조정값 등록
		$("#register_btn").on("click", function() {
			//	console.log("조정값 등록");
			saveAdjustValue();
		});

		// 조정값 적용
		$("#adjust_btn").on("click", function() {
			//	console.log("조정값 적용");
			applyAdjustValue();
		});

		function set_Value() {
			document.getElementById("edt_MATERIAL_NAME").value = l_MaterialName + l_SheetName;
			document.getElementById("edt_SELLER_NAME").value = l_SellerName;
			document.getElementById("edt_IMPORT_DATE").value = l_ImportDate;
			
			document.getElementById("edt_LOT_COUNT").value = l_LOT_COUNT;

			for(ac = 0;ac < l_INGREDIENT_CNT;ac ++)
			{
				switch(ac){
				case 0:	set_NS("edt_ADJUST_IG_1", l_ADJUST_IG_1);	break;
				case 1:	set_NS("edt_ADJUST_IG_2", l_ADJUST_IG_2);	break;
				case 2:	set_NS("edt_ADJUST_IG_3", l_ADJUST_IG_3);	break;
				case 3:	set_NS("edt_ADJUST_IG_4", l_ADJUST_IG_4);	break;
				}
			}

			for(var li = 0;li < l_LOT_COUNT;li ++)
			{
				var idx = Number(li) + 1;
				
				for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++)
				{
					var cn  = "edt_ig" + (ac + 1).toString() + "_1_" + (idx).toString();

					set_NS(cn, l_LOT_IG_VALUE[li][ac]);
				}
			}
		}

		function get_NS(id) {
			return document.getElementById(id).value == "" ? "0":document.getElementById(id).value;
		}

		function set_NS(id, value) {
			document.getElementById(id).value = value;
		}

		function saveAdjustValue() {
			var s_ADJUST_IG_1 = get_NS("edt_ADJUST_IG_1");
			var s_ADJUST_IG_2 = get_NS("edt_ADJUST_IG_2");
			var s_ADJUST_IG_3 = get_NS("edt_ADJUST_IG_3");
			var s_ADJUST_IG_4 = 0;

			if(l_INGREDIENT_CNT >= 4) s_ADJUST_IG_4 = get_NS("edt_ADJUST_IG_4");

			var s_IG_1 = new Array();
			var s_IG_2 = new Array();
			var s_IG_3 = new Array();
			var s_IG_4 = new Array();

			for(var i = 1;i <= l_LOT_COUNT;i ++) {
				for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++)
				{
					fn = "edt_ig" + (ac + 1).toString() + "_3_" + String(i);

					switch(ac)
					{
					case 0:	s_IG_1[Number(i) - 1] = get_NS(fn);	break;
					case 1:	s_IG_2[Number(i) - 1] = get_NS(fn);	break;
					case 2:	s_IG_3[Number(i) - 1] = get_NS(fn);	break;
					case 3:	s_IG_4[Number(i) - 1] = get_NS(fn);	break;
					}
				}
			}

			for(var i = (l_LOT_COUNT + 1);i <= 22;i ++) {
				s_IG_1[Number(i) - 1] = 0;
				s_IG_2[Number(i) - 1] = 0;
				s_IG_3[Number(i) - 1] = 0;
				s_IG_4[Number(i) - 1] = 0;
			}

			$.ajax({
 				url : "/yp/popup/zpp/ore/zpp_ore_update_adjust_value",
				type : "POST",
			    cache:false,
			    async:true, 
				data : {
					MASTER_ID : l_MASTER_ID,
					ADJUST_IG_1 : s_ADJUST_IG_1,
					ADJUST_IG_2 : s_ADJUST_IG_2,
					ADJUST_IG_3 : s_ADJUST_IG_3,
					ADJUST_IG_4 : s_ADJUST_IG_4,
					IG_1_1 : s_IG_1[0],
					IG_2_1 : s_IG_2[0],
					IG_3_1 : s_IG_3[0],
					IG_4_1 : s_IG_4[0],
					IG_1_2 : s_IG_1[1],
					IG_2_2 : s_IG_2[1],
					IG_3_2 : s_IG_3[1],
					IG_4_2 : s_IG_4[1],
					IG_1_3 : s_IG_1[2],
					IG_2_3 : s_IG_2[2],
					IG_3_3 : s_IG_3[2],
					IG_4_3 : s_IG_4[2],
					IG_1_4 : s_IG_1[3],
					IG_2_4 : s_IG_2[3],
					IG_3_4 : s_IG_3[3],
					IG_4_4 : s_IG_4[3],
					IG_1_5 : s_IG_1[4],
					IG_2_5 : s_IG_2[4],
					IG_3_5 : s_IG_3[4],
					IG_4_5 : s_IG_4[4],
					IG_1_6 : s_IG_1[5],
					IG_2_6 : s_IG_2[5],
					IG_3_6 : s_IG_3[5],
					IG_4_6 : s_IG_4[5],
					IG_1_7 : s_IG_1[6],
					IG_2_7 : s_IG_2[6],
					IG_3_7 : s_IG_3[6],
					IG_4_7 : s_IG_4[6],
					IG_1_8 : s_IG_1[7],
					IG_2_8 : s_IG_2[7],
					IG_3_8 : s_IG_3[7],
					IG_4_8 : s_IG_4[7],
					IG_1_9 : s_IG_1[8],
					IG_2_9 : s_IG_2[8],
					IG_3_9 : s_IG_3[8],
					IG_4_9 : s_IG_4[8],
					IG_1_10 : s_IG_1[9],
					IG_2_10 : s_IG_2[9],
					IG_3_10 : s_IG_3[9],
					IG_4_10 : s_IG_4[9],
					IG_1_11 : s_IG_1[10],
					IG_2_11 : s_IG_2[10],
					IG_3_11 : s_IG_3[10],
					IG_4_11 : s_IG_4[10],
					IG_1_12 : s_IG_1[11],
					IG_2_12 : s_IG_2[11],
					IG_3_12 : s_IG_3[11],
					IG_4_12 : s_IG_4[11],
					IG_1_13 : s_IG_1[12],
					IG_2_13 : s_IG_2[12],
					IG_3_13 : s_IG_3[12],
					IG_4_13 : s_IG_4[12],
					IG_1_14 : s_IG_1[13],
					IG_2_14 : s_IG_2[13],
					IG_3_14 : s_IG_3[13],
					IG_4_14 : s_IG_4[13],
					IG_1_15 : s_IG_1[14],
					IG_2_15 : s_IG_2[14],
					IG_3_15 : s_IG_3[14],
					IG_4_15 : s_IG_4[14],
					IG_1_16 : s_IG_1[15],
					IG_2_16 : s_IG_2[15],
					IG_3_16 : s_IG_3[15],
					IG_4_16 : s_IG_4[15],
					IG_1_17 : s_IG_1[16],
					IG_2_17 : s_IG_2[16],
					IG_3_17 : s_IG_3[16],
					IG_4_17 : s_IG_4[16],
					IG_1_18 : s_IG_1[17],
					IG_2_18 : s_IG_2[17],
					IG_3_18 : s_IG_3[17],
					IG_4_18 : s_IG_4[17],
					IG_1_19 : s_IG_1[18],
					IG_2_19 : s_IG_2[18],
					IG_3_19 : s_IG_3[18],
					IG_4_19 : s_IG_4[18],
					IG_1_20 : s_IG_1[19],
					IG_2_20 : s_IG_2[19],
					IG_3_20 : s_IG_3[19],
					IG_4_20 : s_IG_4[19],
					IG_1_21 : s_IG_1[20],
					IG_2_21 : s_IG_2[20],
					IG_3_21 : s_IG_3[20],
					IG_4_21 : s_IG_4[20],
					IG_1_22 : s_IG_1[21],
					IG_2_22 : s_IG_2[21],
					IG_3_22 : s_IG_3[21],
					IG_4_22 : s_IG_4[21],

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

		function applyAdjustValue() {
			var val1, val2, val3, val4;
			var fn;

			for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++)
			{
				switch(ac)
				{
				case 0:	val1 = get_NS("edt_ADJUST_IG_1");	break;
				case 1:	val2 = get_NS("edt_ADJUST_IG_2");	break;
				case 2:	val3 = get_NS("edt_ADJUST_IG_3");	break;
				case 3:	val4 = get_NS("edt_ADJUST_IG_4");	break;
				}
			}

			for(var i = 1;i <= l_LOT_COUNT;i ++) {
				for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++)
				{
					fn = "edt_ig" + (ac + 1).toString() + "_2_" + String(i);
					switch(ac)
					{
					case 0:	set_NS(fn, val1);	break;
					case 1:	set_NS(fn, val2);	break;
					case 2:	set_NS(fn, val3);	break;
					case 3:	set_NS(fn, val4);	break;
					}

					fn = "edt_ig" + (ac + 1).toString() + "_3_" + String(i);
					switch(ac)
					{
					case 0:	set_NS(fn, Number(l_LOT_IG_VALUE[Number(i) - 1][ac]) - Number(val1));	break;
					case 1:	set_NS(fn, Number(l_LOT_IG_VALUE[Number(i) - 1][ac]) - Number(val2));	break;
					case 2:	set_NS(fn, (Number(l_LOT_IG_VALUE[Number(i) - 1][ac]) - Number(val3)).toFixed(3));	break;
					case 3:	set_NS(fn, (Number(l_LOT_IG_VALUE[Number(i) - 1][ac]) - Number(val4)).toFixed(3));	break;
					}
				}
			}
		}

		opener.popup = this;

	</script>
</body>
</html>