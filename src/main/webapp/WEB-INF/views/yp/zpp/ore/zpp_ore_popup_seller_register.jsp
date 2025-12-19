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
	<title>SELLER 성분 분석 결과 등록</title>
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
			SELLER 성분 분석 결과 등록
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

						<div class="btn_wrap">
							<button class="btn btn_search" id="register_btn" type="">결과값 등록</button>
						</div>
					</div>
				</section>
			</div>

			<div style="float:left;width:40%;padding:10px">
				<table id="table_1" class=tbl_def>
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

		//	1:INSERT, 2:UPDATE
		var l_EditMode = 1;

		var l_LOT_COUNT;

		var l_INGREDIENT_CNT;
		var l_INGREDIENT_ID = new Array();
		var	l_INGREDIENT_NAME = new Array();

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

					AddColumn(table_row, '<td><input type="number" id="' + cn + '" maxlength="6" oninput="numberMaxLength(this);"></td>');
				}

				table.appendChild(table_row);						
			}
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

		function get_Values() {
		}

		function closePopup() {
			self.close();	
		}

		function load_Def() {
		}

		function saveSellerValue() {
			for(var si = 0;si < l_LOT_COUNT;si ++) {
				for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++)
				{
					cn = "edt_ig_" + (ac + 1).toString() + "_" + (si + 1).toString();
					l_LOT_IG_VALUE[si][ac] = get_NS(cn);
				}
			}

			$.ajax({
 				url : "/yp/zpp/ore/zpp_ore_set_seller_value",
				type : "POST",
			    cache:false,
			    async:true, 
				data : {
					MASTER_ID : l_MASTER_ID,
					LOT_1_IG_1_VALUE : l_LOT_IG_VALUE[0][0],
					LOT_1_IG_2_VALUE : l_LOT_IG_VALUE[0][1],
					LOT_1_IG_3_VALUE : l_LOT_IG_VALUE[0][2],
					LOT_1_IG_4_VALUE : l_LOT_IG_VALUE[0][3],
					LOT_2_IG_1_VALUE : l_LOT_IG_VALUE[1][0],
					LOT_2_IG_2_VALUE : l_LOT_IG_VALUE[1][1],
					LOT_2_IG_3_VALUE : l_LOT_IG_VALUE[1][2],
					LOT_2_IG_4_VALUE : l_LOT_IG_VALUE[1][3],
					LOT_3_IG_1_VALUE : l_LOT_IG_VALUE[2][0],
					LOT_3_IG_2_VALUE : l_LOT_IG_VALUE[2][1],
					LOT_3_IG_3_VALUE : l_LOT_IG_VALUE[2][2],
					LOT_3_IG_4_VALUE : l_LOT_IG_VALUE[2][3],
					LOT_4_IG_1_VALUE : l_LOT_IG_VALUE[3][0],
					LOT_4_IG_2_VALUE : l_LOT_IG_VALUE[3][1],
					LOT_4_IG_3_VALUE : l_LOT_IG_VALUE[3][2],
					LOT_4_IG_4_VALUE : l_LOT_IG_VALUE[3][3],
					LOT_5_IG_1_VALUE : l_LOT_IG_VALUE[4][0],
					LOT_5_IG_2_VALUE : l_LOT_IG_VALUE[4][1],
					LOT_5_IG_3_VALUE : l_LOT_IG_VALUE[4][2],
					LOT_5_IG_4_VALUE : l_LOT_IG_VALUE[4][3],
					LOT_6_IG_1_VALUE : l_LOT_IG_VALUE[5][0],
					LOT_6_IG_2_VALUE : l_LOT_IG_VALUE[5][1],
					LOT_6_IG_3_VALUE : l_LOT_IG_VALUE[5][2],
					LOT_6_IG_4_VALUE : l_LOT_IG_VALUE[5][3],
					LOT_7_IG_1_VALUE : l_LOT_IG_VALUE[6][0],
					LOT_7_IG_2_VALUE : l_LOT_IG_VALUE[6][1],
					LOT_7_IG_3_VALUE : l_LOT_IG_VALUE[6][2],
					LOT_7_IG_4_VALUE : l_LOT_IG_VALUE[6][3],
					LOT_8_IG_1_VALUE : l_LOT_IG_VALUE[7][0],
					LOT_8_IG_2_VALUE : l_LOT_IG_VALUE[7][1],
					LOT_8_IG_3_VALUE : l_LOT_IG_VALUE[7][2],
					LOT_8_IG_4_VALUE : l_LOT_IG_VALUE[7][3],
					LOT_9_IG_1_VALUE : l_LOT_IG_VALUE[8][0],
					LOT_9_IG_2_VALUE : l_LOT_IG_VALUE[8][1],
					LOT_9_IG_3_VALUE : l_LOT_IG_VALUE[8][2],
					LOT_9_IG_4_VALUE : l_LOT_IG_VALUE[8][3],
					LOT_10_IG_1_VALUE : l_LOT_IG_VALUE[9][0],
					LOT_10_IG_2_VALUE : l_LOT_IG_VALUE[9][1],
					LOT_10_IG_3_VALUE : l_LOT_IG_VALUE[9][2],
					LOT_10_IG_4_VALUE : l_LOT_IG_VALUE[9][3],
					LOT_11_IG_1_VALUE : l_LOT_IG_VALUE[10][0],
					LOT_11_IG_2_VALUE : l_LOT_IG_VALUE[10][1],
					LOT_11_IG_3_VALUE : l_LOT_IG_VALUE[10][2],
					LOT_11_IG_4_VALUE : l_LOT_IG_VALUE[10][3],
					LOT_12_IG_1_VALUE : l_LOT_IG_VALUE[11][0],
					LOT_12_IG_2_VALUE : l_LOT_IG_VALUE[11][1],
					LOT_12_IG_3_VALUE : l_LOT_IG_VALUE[11][2],
					LOT_12_IG_4_VALUE : l_LOT_IG_VALUE[11][3],
					LOT_13_IG_1_VALUE : l_LOT_IG_VALUE[12][0],
					LOT_13_IG_2_VALUE : l_LOT_IG_VALUE[12][1],
					LOT_13_IG_3_VALUE : l_LOT_IG_VALUE[12][2],
					LOT_13_IG_4_VALUE : l_LOT_IG_VALUE[12][3],
					LOT_14_IG_1_VALUE : l_LOT_IG_VALUE[13][0],
					LOT_14_IG_2_VALUE : l_LOT_IG_VALUE[13][1],
					LOT_14_IG_3_VALUE : l_LOT_IG_VALUE[13][2],
					LOT_14_IG_4_VALUE : l_LOT_IG_VALUE[13][3],
					LOT_15_IG_1_VALUE : l_LOT_IG_VALUE[14][0],
					LOT_15_IG_2_VALUE : l_LOT_IG_VALUE[14][1],
					LOT_15_IG_3_VALUE : l_LOT_IG_VALUE[14][2],
					LOT_15_IG_4_VALUE : l_LOT_IG_VALUE[14][3],
					LOT_16_IG_1_VALUE : l_LOT_IG_VALUE[15][0],
					LOT_16_IG_2_VALUE : l_LOT_IG_VALUE[15][1],
					LOT_16_IG_3_VALUE : l_LOT_IG_VALUE[15][2],
					LOT_16_IG_4_VALUE : l_LOT_IG_VALUE[15][3],
					LOT_17_IG_1_VALUE : l_LOT_IG_VALUE[16][0],
					LOT_17_IG_2_VALUE : l_LOT_IG_VALUE[16][1],
					LOT_17_IG_3_VALUE : l_LOT_IG_VALUE[16][2],
					LOT_17_IG_4_VALUE : l_LOT_IG_VALUE[16][3],
					LOT_18_IG_1_VALUE : l_LOT_IG_VALUE[17][0],
					LOT_18_IG_2_VALUE : l_LOT_IG_VALUE[17][1],
					LOT_18_IG_3_VALUE : l_LOT_IG_VALUE[17][2],
					LOT_18_IG_4_VALUE : l_LOT_IG_VALUE[17][3],
					LOT_19_IG_1_VALUE : l_LOT_IG_VALUE[18][0],
					LOT_19_IG_2_VALUE : l_LOT_IG_VALUE[18][1],
					LOT_19_IG_3_VALUE : l_LOT_IG_VALUE[18][2],
					LOT_19_IG_4_VALUE : l_LOT_IG_VALUE[18][3],
					LOT_20_IG_1_VALUE : l_LOT_IG_VALUE[19][0],
					LOT_20_IG_2_VALUE : l_LOT_IG_VALUE[19][1],
					LOT_20_IG_3_VALUE : l_LOT_IG_VALUE[19][2],
					LOT_20_IG_4_VALUE : l_LOT_IG_VALUE[19][3],
					LOT_21_IG_1_VALUE : l_LOT_IG_VALUE[20][0],
					LOT_21_IG_2_VALUE : l_LOT_IG_VALUE[20][1],
					LOT_21_IG_3_VALUE : l_LOT_IG_VALUE[20][2],
					LOT_21_IG_4_VALUE : l_LOT_IG_VALUE[20][3],
					LOT_22_IG_1_VALUE : l_LOT_IG_VALUE[21][0],
					LOT_22_IG_2_VALUE : l_LOT_IG_VALUE[21][1],
					LOT_22_IG_3_VALUE : l_LOT_IG_VALUE[21][2],
					LOT_22_IG_4_VALUE : l_LOT_IG_VALUE[21][3],
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

		function
		load_InitValue() {
			$.ajax({
				url : "/yp/zpp/ore/zpp_ore_get_seller_value",
				type : "POST",
			    cache:false,
			    async:true, 
				data : {
					MASTER_ID : l_MASTER_ID,
					_csrf : '${_csrf.token}'
					},
				dataType : "json",
				success : function(result) {
					//	console.log("/yp/zpp/ore/zpp_ore_get_seller_value success : " + result.LOT_1_IG_1_VALUE + result.LOT_1_IG_2_VALUE + result.LOT_1_IG_3_VALUE);

					l_LOT_COUNT = result.LOT_COUNT;
					document.getElementById("edt_LOT_COUNT").value = l_LOT_COUNT;

					setLotCountTable(l_LOT_COUNT);

					l_LOT_IG_VALUE[0][0] = result.LOT_1_IG_1_VALUE;
					l_LOT_IG_VALUE[0][1] = result.LOT_1_IG_2_VALUE;
					l_LOT_IG_VALUE[0][2] = result.LOT_1_IG_3_VALUE;
					l_LOT_IG_VALUE[0][3] = result.LOT_1_IG_4_VALUE;
					l_LOT_IG_VALUE[1][0] = result.LOT_2_IG_1_VALUE;
					l_LOT_IG_VALUE[1][1] = result.LOT_2_IG_2_VALUE;
					l_LOT_IG_VALUE[1][2] = result.LOT_2_IG_3_VALUE;
					l_LOT_IG_VALUE[1][3] = result.LOT_2_IG_4_VALUE;
					l_LOT_IG_VALUE[2][0] = result.LOT_3_IG_1_VALUE;
					l_LOT_IG_VALUE[2][1] = result.LOT_3_IG_2_VALUE;
					l_LOT_IG_VALUE[2][2] = result.LOT_3_IG_3_VALUE;
					l_LOT_IG_VALUE[2][3] = result.LOT_3_IG_4_VALUE;
					l_LOT_IG_VALUE[3][0] = result.LOT_4_IG_1_VALUE;
					l_LOT_IG_VALUE[3][1] = result.LOT_4_IG_2_VALUE;
					l_LOT_IG_VALUE[3][2] = result.LOT_4_IG_3_VALUE;
					l_LOT_IG_VALUE[3][3] = result.LOT_4_IG_4_VALUE;
					l_LOT_IG_VALUE[4][0] = result.LOT_5_IG_1_VALUE;
					l_LOT_IG_VALUE[4][1] = result.LOT_5_IG_2_VALUE;
					l_LOT_IG_VALUE[4][2] = result.LOT_5_IG_3_VALUE;
					l_LOT_IG_VALUE[4][3] = result.LOT_5_IG_4_VALUE;
					l_LOT_IG_VALUE[5][0] = result.LOT_6_IG_1_VALUE;
					l_LOT_IG_VALUE[5][1] = result.LOT_6_IG_2_VALUE;
					l_LOT_IG_VALUE[5][2] = result.LOT_6_IG_3_VALUE;
					l_LOT_IG_VALUE[5][3] = result.LOT_6_IG_4_VALUE;
					l_LOT_IG_VALUE[6][0] = result.LOT_7_IG_1_VALUE;
					l_LOT_IG_VALUE[6][1] = result.LOT_7_IG_2_VALUE;
					l_LOT_IG_VALUE[6][2] = result.LOT_7_IG_3_VALUE;
					l_LOT_IG_VALUE[6][3] = result.LOT_7_IG_4_VALUE;
					l_LOT_IG_VALUE[7][0] = result.LOT_8_IG_1_VALUE;
					l_LOT_IG_VALUE[7][1] = result.LOT_8_IG_2_VALUE;
					l_LOT_IG_VALUE[7][2] = result.LOT_8_IG_3_VALUE;
					l_LOT_IG_VALUE[7][3] = result.LOT_8_IG_4_VALUE;
					l_LOT_IG_VALUE[8][0] = result.LOT_9_IG_1_VALUE;
					l_LOT_IG_VALUE[8][1] = result.LOT_9_IG_2_VALUE;
					l_LOT_IG_VALUE[8][2] = result.LOT_9_IG_3_VALUE;
					l_LOT_IG_VALUE[8][3] = result.LOT_9_IG_4_VALUE;
					l_LOT_IG_VALUE[9][0] = result.LOT_10_IG_1_VALUE;
					l_LOT_IG_VALUE[9][1] = result.LOT_10_IG_2_VALUE;
					l_LOT_IG_VALUE[9][2] = result.LOT_10_IG_3_VALUE;
					l_LOT_IG_VALUE[9][3] = result.LOT_10_IG_4_VALUE;
					l_LOT_IG_VALUE[10][0] = result.LOT_11_IG_1_VALUE;
					l_LOT_IG_VALUE[10][1] = result.LOT_11_IG_2_VALUE;
					l_LOT_IG_VALUE[10][2] = result.LOT_11_IG_3_VALUE;
					l_LOT_IG_VALUE[10][3] = result.LOT_11_IG_4_VALUE;
					l_LOT_IG_VALUE[11][0] = result.LOT_12_IG_1_VALUE;
					l_LOT_IG_VALUE[11][1] = result.LOT_12_IG_2_VALUE;
					l_LOT_IG_VALUE[11][2] = result.LOT_12_IG_3_VALUE;
					l_LOT_IG_VALUE[11][3] = result.LOT_12_IG_4_VALUE;
					l_LOT_IG_VALUE[12][0] = result.LOT_13_IG_1_VALUE;
					l_LOT_IG_VALUE[12][1] = result.LOT_13_IG_2_VALUE;
					l_LOT_IG_VALUE[12][2] = result.LOT_13_IG_3_VALUE;
					l_LOT_IG_VALUE[12][3] = result.LOT_13_IG_4_VALUE;
					l_LOT_IG_VALUE[13][0] = result.LOT_14_IG_1_VALUE;
					l_LOT_IG_VALUE[13][1] = result.LOT_14_IG_2_VALUE;
					l_LOT_IG_VALUE[13][2] = result.LOT_14_IG_3_VALUE;
					l_LOT_IG_VALUE[13][3] = result.LOT_14_IG_4_VALUE;
					l_LOT_IG_VALUE[14][0] = result.LOT_15_IG_1_VALUE;
					l_LOT_IG_VALUE[14][1] = result.LOT_15_IG_2_VALUE;
					l_LOT_IG_VALUE[14][2] = result.LOT_15_IG_3_VALUE;
					l_LOT_IG_VALUE[14][3] = result.LOT_15_IG_4_VALUE;
					l_LOT_IG_VALUE[15][0] = result.LOT_16_IG_1_VALUE;
					l_LOT_IG_VALUE[15][1] = result.LOT_16_IG_2_VALUE;
					l_LOT_IG_VALUE[15][2] = result.LOT_16_IG_3_VALUE;
					l_LOT_IG_VALUE[15][3] = result.LOT_16_IG_4_VALUE;
					l_LOT_IG_VALUE[16][0] = result.LOT_17_IG_1_VALUE;
					l_LOT_IG_VALUE[16][1] = result.LOT_17_IG_2_VALUE;
					l_LOT_IG_VALUE[16][2] = result.LOT_17_IG_3_VALUE;
					l_LOT_IG_VALUE[16][3] = result.LOT_17_IG_4_VALUE;
					l_LOT_IG_VALUE[17][0] = result.LOT_18_IG_1_VALUE;
					l_LOT_IG_VALUE[17][1] = result.LOT_18_IG_2_VALUE;
					l_LOT_IG_VALUE[17][2] = result.LOT_18_IG_3_VALUE;
					l_LOT_IG_VALUE[17][3] = result.LOT_18_IG_4_VALUE;
					l_LOT_IG_VALUE[18][0] = result.LOT_19_IG_1_VALUE;
					l_LOT_IG_VALUE[18][1] = result.LOT_19_IG_2_VALUE;
					l_LOT_IG_VALUE[18][2] = result.LOT_19_IG_3_VALUE;
					l_LOT_IG_VALUE[18][3] = result.LOT_19_IG_4_VALUE;
					l_LOT_IG_VALUE[19][0] = result.LOT_20_IG_1_VALUE;
					l_LOT_IG_VALUE[19][1] = result.LOT_20_IG_2_VALUE;
					l_LOT_IG_VALUE[19][2] = result.LOT_20_IG_3_VALUE;
					l_LOT_IG_VALUE[19][3] = result.LOT_20_IG_4_VALUE;
					l_LOT_IG_VALUE[20][0] = result.LOT_21_IG_1_VALUE;
					l_LOT_IG_VALUE[20][1] = result.LOT_21_IG_2_VALUE;
					l_LOT_IG_VALUE[20][2] = result.LOT_21_IG_3_VALUE;
					l_LOT_IG_VALUE[20][3] = result.LOT_21_IG_4_VALUE;
					l_LOT_IG_VALUE[21][0] = result.LOT_22_IG_1_VALUE;
					l_LOT_IG_VALUE[21][1] = result.LOT_22_IG_2_VALUE;
					l_LOT_IG_VALUE[21][2] = result.LOT_22_IG_3_VALUE;
					l_LOT_IG_VALUE[21][3] = result.LOT_22_IG_4_VALUE;
					l_LOT_IG_VALUE[22][0] = result.LOT_23_IG_1_VALUE;
					l_LOT_IG_VALUE[22][1] = result.LOT_23_IG_2_VALUE;
					l_LOT_IG_VALUE[22][2] = result.LOT_23_IG_3_VALUE;
					l_LOT_IG_VALUE[22][3] = result.LOT_23_IG_4_VALUE;
					l_LOT_IG_VALUE[23][0] = result.LOT_24_IG_1_VALUE;
					l_LOT_IG_VALUE[23][1] = result.LOT_24_IG_2_VALUE;
					l_LOT_IG_VALUE[23][2] = result.LOT_24_IG_3_VALUE;
					l_LOT_IG_VALUE[23][3] = result.LOT_24_IG_4_VALUE;
					l_LOT_IG_VALUE[24][0] = result.LOT_25_IG_1_VALUE;
					l_LOT_IG_VALUE[24][1] = result.LOT_25_IG_2_VALUE;
					l_LOT_IG_VALUE[24][2] = result.LOT_25_IG_3_VALUE;
					l_LOT_IG_VALUE[24][3] = result.LOT_25_IG_4_VALUE;
					l_LOT_IG_VALUE[25][0] = result.LOT_26_IG_1_VALUE;
					l_LOT_IG_VALUE[25][1] = result.LOT_26_IG_2_VALUE;
					l_LOT_IG_VALUE[25][2] = result.LOT_26_IG_3_VALUE;
					l_LOT_IG_VALUE[25][3] = result.LOT_26_IG_4_VALUE;
					l_LOT_IG_VALUE[26][0] = result.LOT_27_IG_1_VALUE;
					l_LOT_IG_VALUE[26][1] = result.LOT_27_IG_2_VALUE;
					l_LOT_IG_VALUE[26][2] = result.LOT_27_IG_3_VALUE;
					l_LOT_IG_VALUE[26][3] = result.LOT_27_IG_4_VALUE;
					l_LOT_IG_VALUE[27][0] = result.LOT_28_IG_1_VALUE;
					l_LOT_IG_VALUE[27][1] = result.LOT_28_IG_2_VALUE;
					l_LOT_IG_VALUE[27][2] = result.LOT_28_IG_3_VALUE;
					l_LOT_IG_VALUE[27][3] = result.LOT_28_IG_4_VALUE;
					l_LOT_IG_VALUE[28][0] = result.LOT_29_IG_1_VALUE;
					l_LOT_IG_VALUE[28][1] = result.LOT_29_IG_2_VALUE;
					l_LOT_IG_VALUE[28][2] = result.LOT_29_IG_3_VALUE;
					l_LOT_IG_VALUE[28][3] = result.LOT_29_IG_4_VALUE;
					l_LOT_IG_VALUE[29][0] = result.LOT_30_IG_1_VALUE;
					l_LOT_IG_VALUE[29][1] = result.LOT_30_IG_2_VALUE;
					l_LOT_IG_VALUE[29][2] = result.LOT_30_IG_3_VALUE;
					l_LOT_IG_VALUE[29][3] = result.LOT_30_IG_4_VALUE;

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
			saveSellerValue();
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
			for(var si = 0;si < l_LOT_COUNT;si ++) {
				for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++)
				{
					cn = "edt_ig_" + (ac + 1).toString() + "_" + (si + 1).toString();
					set_NS(cn, l_LOT_IG_VALUE[si][ac]);
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