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
	<title>정광 성분분석 최종값 조회</title>
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
		th {
			border: 1px solid #000000;
		}
	</style>

	<div id="popup">
		<div class="pop_header">
			정광 성분분석 최종값 조회
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
					</div>
				</section>
			</div>

			<div style="float:left;width:25%;padding:10px">
				<table id="table_1" class=tbl_def>
					<colgroup>
						<col width="50%" />
						<col width="50%" />
					</colgroup>
					<tr>
						<th>성분</th>
						<th>품위</th>
					</tr>
					<tr>
						<td>Zn</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_1" ></td>
					</tr>
					<tr>
						<td>Fe</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_2" ></td>
					</tr>
					<tr>
						<td>T.S</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_3" ></td>
					</tr>
					<tr>
						<td>Pb</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_4" ></td>
					</tr>
					<tr>
						<td>Cu</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_5" ></td>
					</tr>
					<tr>
						<td>Cd</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_6" ></td>
					</tr>
					<tr>
						<td>Ag(g/T)</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_7" ></td>
					</tr>
					<tr>
						<td>MgO</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_8" ></td>
					</tr>
					<tr>
						<td>CaO</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_9" ></td>
					</tr>
					<tr>
						<td>Mn</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_10" ></td>
					</tr>
					<tr>
						<td>Ni</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_11" ></td>
					</tr>
					<tr>
						<td>Sb</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_12" ></td>
					</tr>
					<tr>
						<td>As</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_13" ></td>
					</tr>
					<tr>
						<td>Co</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_14" ></td>
					</tr>
					<tr>
						<td>Ge</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_15" ></td>
					</tr>
					<tr>
						<td>Fe</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_16" ></td>
					</tr>
					<tr>
						<td>Sn</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_17" ></td>
					</tr>
					<tr>
						<td>Hg</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_18" ></td>
					</tr>
					<tr>
						<td>Al2So3</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_19" ></td>
					</tr>
					<tr>
						<td>In(g/T)</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_20" ></td>
					</tr>
					<tr>
						<td>Cr</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_21" ></td>
					</tr>
					<tr>
						<td>Cl</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_22" ></td>
					</tr>
					<tr>
						<td>SiO2</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_23" ></td>
					</tr>
					<tr>
						<td>B</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_24" ></td>
					</tr>
					<tr>
						<td>Se</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_25" ></td>
					</tr>
					<tr>
						<td>Ga</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_26" ></td>
					</tr>
					<tr>
						<td>Mo</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_27" ></td>
					</tr>
					<tr>
						<td>Ti</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_28" ></td>
					</tr>
					<tr>
						<td>Bi</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_29" ></td>
					</tr>
					<tr>
						<td>K</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_30" ></td>
					</tr>
					<tr>
						<td>Au(g/T)</td>
						<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IG_VALUE_31" ></td>
					</tr>
				</table>
			</div>
			<div style="float:left;width:25%;padding:10px">
				<table id="table_2" class=tbl_def>
					<colgroup>
						<col width="40%" />
						<col width="60%" />
					</colgroup>
					<tr>
						<td colspan='2'>Particle Size</td>
					</tr>
					<tr>
						<td>mesh</td>
						<td>%</td>
					</tr>
					<tr>
						<td>100</td>
						<td>
							<input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_PM_100_VALUE">
						</td>
					</tr>
					<tr>
						<td>200</td>
						<td>
							<input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_PM_200_VALUE">
						</td>
					</tr>
					<tr>
						<td>325</td>
						<td>
							<input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_PM_325_VALUE">
						</td>
					</tr>
					<tr>
						<td>400</td>
						<td>
							<input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_PM_400_VALUE">
						</td>
					</tr>
					<tr>
						<td>-400</td>
						<td>
							<input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_PM_M400_VALUE">
						</td>
					</tr>
				</table>
			</div>
			<div style="float:left;width:40%;padding:10px">
				<table id="table_3" class=tbl_def>
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
	
	var l_LOT_COUNT;

	var l_LOT_IG_VALUE = create2DArray(30, 4);
	var MENU_ID;

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

	function get_Values() {
	}

	function closePopup() {
		self.close();	
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
		var table = document.getElementById('table_3');
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

			for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++)
			{
				//	edt_ig1_1_1
				var cn  = "edt_ig_" + (ac + 1).toString() + "_" + (idx).toString();

				AddColumn(table_row, '<td><input readonly onfocus="this.blur()" style="color:black; font-weight:bold; border:0px; background-color:transparent" id="' + cn + '"></td>');
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

	function load_Def() {
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
				//			result.fixedValueList.ADJUST_IG_1 + "," + result.fixedValueList.ADJUST_IG_2 + "," + result.fixedValueList.ADJUST_IG_3);
				
				/**
				 * 2022-11-18 smh 전자결재 유무
				 */
				render_edoc(result.oreEdocInfoMap);

				l_LOT_COUNT = result.LOT_COUNT;
				document.getElementById("edt_LOT_COUNT").value = l_LOT_COUNT;

				setLotCountTable(l_LOT_COUNT);

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
		MENU_ID = '${req_data.menu_id}';
		document.getElementById("edt_MATERIAL_ID").value = get_material_name('${req_data.MATERIAL_ID}', '${req_data.SHEET_ID}');
		document.getElementById("edt_SELLER_ID").value = get_seller_name('${req_data.SELLER_ID}');
		document.getElementById("edt_IMPORT_DATE").value = '${req_data.IMPORT_DATE}';
		
		const oreEdocInfoMap = JSON.parse('${oreEdocInfoMap}');
		render_edoc(oreEdocInfoMap);

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
	
	// 전자결재
	$(".btn_edoc").on("click", function() {
		//EF166441989478594		
		const form_id = 'EF166441989478594',
			  master_id = l_MASTER_ID,
			  menu_id = MENU_ID,
			  url = `http:\/\/gwdev.ypzinc.co.kr/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=\${form_id}&MASTER_ID=\${master_id}&MENU_ID=\${menu_id}`;
			  
		//	console.log('[TEST]url:',url);
		window.open(url, "전자결재", "scrollbars=auto,width=1000,height=900");
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
	
	/**
	 * 전자결재 화면 표시 렌더링
	 */
	function render_edoc(oreEdocInfoMap){
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

	function set_Value() {
		document.getElementById("edt_IG_VALUE_1").value = l_IG_VALUE[0];
		document.getElementById("edt_IG_VALUE_2").value = l_IG_VALUE[1];
		document.getElementById("edt_IG_VALUE_3").value = l_IG_VALUE[2];
		document.getElementById("edt_IG_VALUE_4").value = l_IG_VALUE[3];
		document.getElementById("edt_IG_VALUE_5").value = l_IG_VALUE[4];
		document.getElementById("edt_IG_VALUE_6").value = l_IG_VALUE[5];
		document.getElementById("edt_IG_VALUE_7").value = l_IG_VALUE[6];
		document.getElementById("edt_IG_VALUE_8").value = l_IG_VALUE[7];
		document.getElementById("edt_IG_VALUE_9").value = l_IG_VALUE[8];
		document.getElementById("edt_IG_VALUE_10").value = l_IG_VALUE[9];
		document.getElementById("edt_IG_VALUE_11").value = l_IG_VALUE[10];
		document.getElementById("edt_IG_VALUE_12").value = l_IG_VALUE[11];
		document.getElementById("edt_IG_VALUE_13").value = l_IG_VALUE[12];
		document.getElementById("edt_IG_VALUE_14").value = l_IG_VALUE[13];
		document.getElementById("edt_IG_VALUE_15").value = l_IG_VALUE[14];
		document.getElementById("edt_IG_VALUE_16").value = l_IG_VALUE[15];
		document.getElementById("edt_IG_VALUE_17").value = l_IG_VALUE[16];
		document.getElementById("edt_IG_VALUE_18").value = l_IG_VALUE[17];
		document.getElementById("edt_IG_VALUE_19").value = l_IG_VALUE[18];
		document.getElementById("edt_IG_VALUE_20").value = l_IG_VALUE[19];
		document.getElementById("edt_IG_VALUE_21").value = l_IG_VALUE[20];
		document.getElementById("edt_IG_VALUE_22").value = l_IG_VALUE[21];
		document.getElementById("edt_IG_VALUE_23").value = l_IG_VALUE[22];
		document.getElementById("edt_IG_VALUE_24").value = l_IG_VALUE[23];
		document.getElementById("edt_IG_VALUE_25").value = l_IG_VALUE[24];
		document.getElementById("edt_IG_VALUE_26").value = l_IG_VALUE[25];
		document.getElementById("edt_IG_VALUE_27").value = l_IG_VALUE[26];
		document.getElementById("edt_IG_VALUE_28").value = l_IG_VALUE[27];
		document.getElementById("edt_IG_VALUE_29").value = l_IG_VALUE[28];
		document.getElementById("edt_IG_VALUE_30").value = l_IG_VALUE[29];
		document.getElementById("edt_IG_VALUE_31").value = l_IG_VALUE[30];

		document.getElementById("edt_PM_100_VALUE").value = l_PM_VALUE[0];
		document.getElementById("edt_PM_200_VALUE").value = l_PM_VALUE[1];
		document.getElementById("edt_PM_325_VALUE").value = l_PM_VALUE[2];
		document.getElementById("edt_PM_400_VALUE").value = l_PM_VALUE[3];
		document.getElementById("edt_PM_M400_VALUE").value = l_PM_VALUE[4];

		for(var li = 0;li < l_LOT_COUNT;li ++)
		{
			for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++)
			{
				var cn = "edt_ig_" + (ac + 1).toString() + "_" + String(li + 1);

				switch(ac)
				{
				case 0:	set_NS(cn, Number(l_LOT_IG_VALUE[li][ac]) - Number(l_ADJUST_IG_1));	break;
				case 1:	set_NS(cn, Number(l_LOT_IG_VALUE[li][ac]) - Number(l_ADJUST_IG_2));	break;
				case 2:	set_NS(cn, Number(l_LOT_IG_VALUE[li][ac]) - Number(l_ADJUST_IG_3));	break;
				case 3:	set_NS(cn, Number(l_LOT_IG_VALUE[li][ac]) - Number(l_ADJUST_IG_4));	break;
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

	</script>
</body>
</html>