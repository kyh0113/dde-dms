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
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<sec:csrfMetaTags />
	<title>정광 성분분석 요청 (B/L 수량통지) [현재는 사용하지 않음]</title>
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

<!-- 
 2022-12-13 smh - 개발, 로컬, 운영 분기처리
 -->
<spring:eval expression="@config['gw.url']" var="gw_url" />
<spring:eval expression="@systemProperties.getProperty('spring.profiles.active')" var="activeProfile" />

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
			정광 성분분석 요청 (B/L 수량통지)
		</div>
		<div class="pop_content">
			<div style="float:left;width:40%;padding:10px">
				<table id="table_1" class=tbl_def>
					<colgroup>
						<col width="40%" />
						<col width="10%" />
						<col width="40%" />
						<col width="10%" />
					</colgroup>
					<tr>
						<th>항목</th>
						<th>구분</th>
						<th>값</th>
						<th>단위</th>
					</tr>
					<tr>
						<td>광종</td>
						<td></td>
						<td>
							<div style="display:flex; flex-direction:row;">
								<select id="sel_MATERIAL_ID">
								</select>
		 						<div style='width:5px;'></div>
								<select id="sel_SHEET_ID">
									<option value="0">없음</option>
									<option value="A">A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
		 						</select>
		 					</div>
						</td>
						<td></td>
					</tr>
					<tr>
						<td>SELLER</td>
						<td></td>
						<td>
							<select id="sel_SELLER_ID" style="width:300px;">
							</select>
						</td>
						<td></td>
					</tr>
					<tr>
						<td>입항일</td>
						<td></td>
						<td>
							<input type="text" class="calendar dtp" id="cal_IMPORT_DATE" size="10">
						</td>
						<td></td>
					</tr>
					<tr>
						<td>입고번호</td>
						<td></td>
						<td>
							<input type="text" id="edt_IMPORT_NO" >
						</td>
						<td></td>
					</tr>
					<tr>
						<td>PO No</td>
						<td></td>
						<td>
							<input type="text" id="edt_PO_NO" >
						</td>
						<td></td>
					</tr>
					<tr>
						<td>선박명</td>
						<td></td>
						<td>
							<input type="text" id="edt_VESSEL_NAME" >
						</td>
						<td></td>
					</tr>
					<tr>
						<td>Discharging Rate</td>
						<td></td>
						<td>
							<input type="text" id="edt_DISCHARGING_RATE" >
						</td>
						<td></td>
					</tr>
					<tr>
						<td>Dem/Des</td>
						<td></td>
						<td>
							<input type="text" id="edt_DEM_DES" >
						</td>
						<td></td>
					</tr>
					<tr>
						<td>수량-DMT</td>
						<td></td>
						<td>
							<input type="text" id="edt_DMT">
						</td>
						<td></td>
					</tr>
					<tr>
						<td>수량-WMT</td>
						<td></td>
						<td>
							<input type="text" id="edt_WMT">
						</td>
						<td></td>
					</tr>
					<tr>
						<td>수분</td>
						<td></td>
						<td>
							<input type="text" id="edt_MOISTURE" >
						</td>
						<td>%</td>
					</tr>
					<tr>
						<td rowspan='4'>Assay Exchange</td>
						<td></td>
						<td>
							<select id="sel_LBL_IG_1" style="width:120px;">
	 						</select>
						</td>
						<td></td>
					</tr>
					<tr>
						<!--<td rowspan='4'>Assay Exchange</td>-->
						<td></td>
						<td>
							<select id="sel_LBL_IG_2" style="width:120px;">
	 						</select>
						</td>
						<td></td>
					</tr>
					<tr>
						<!--<td rowspan='4'>Assay Exchange</td>-->
						<td></td>
						<td>
							<select id="sel_LBL_IG_3" style="width:120px;">
	 						</select>
						</td>
						<td></td>
					</tr>
					<tr>
						<!--<td rowspan='4'>Assay Exchange</td>-->
						<td></td>
						<td>
							<select id="sel_LBL_IG_4" style="width:120px;">
								<option value="">해당없음</option>
	 						</select>
						</td>
						<td></td>
					</tr>
				</table>
			</div>
			<div style="float:left;width:40%;padding:10px">
				<table id="table_2" class=tbl_def>
					<colgroup>
						<col width="40%" />
						<col width="10%" />
						<col width="40%" />
						<col width="10%" />
					</colgroup>
					<tr>
						<td rowspan='11'>Assay Limit</td>
						<td>Zn</td>
						<td>
							<input type="text" id="edt_ASSAY_LIMIT_AMT_1">
						</td>
						<td>%</td>
					</tr>
					<tr>
						<!--<td rowspan='11'>Assay Limit</td>-->
						<td>Ag</td>
						<td>
							<input type="text" id="edt_ASSAY_LIMIT_AMT_2">
						</td>
						<td>g/t</td>
					</tr>
					<tr>
						<!--<td rowspan='11'>Assay Limit</td>-->
						<td>Au</td>
						<td>
							<input type="text" id="edt_ASSAY_LIMIT_AMT_3">
						</td>
						<td>g/t</td>
					</tr>
					<tr>
						<!--<td rowspan='11'>Assay Limit</td>-->
						<td>Fe</td>
						<td>
							<input type="text" id="edt_ASSAY_LIMIT_AMT_4">
						</td>
						<td>%</td>
					</tr>
					<tr>
						<!--<td rowspan='11'>Assay Limit</td>-->
						<td>SiO2</td>
						<td>
							<input type="text" id="edt_ASSAY_LIMIT_AMT_5">
						</td>
						<td>%</td>
					</tr>
					<tr>
						<!--<td rowspan='11'>Assay Limit</td>-->
						<td>Hg</td>
						<td>
							<input type="text" id="edt_ASSAY_LIMIT_AMT_6">
						</td>
						<td>ppm</td>
					</tr>
					<tr>
						<!--<td rowspan='11'>Assay Limit</td>-->
						<td>Cl+F</td>
						<td>
							<input type="text" id="edt_ASSAY_LIMIT_AMT_7">
						</td>
						<td>ppm</td>
					</tr>
					<tr>
						<!--<td rowspan='11'>Assay Limit</td>-->
						<td>As</td>
						<td>
							<input type="text" id="edt_ASSAY_LIMIT_AMT_8">
						</td>
						<td>%</td>
					</tr>
					<tr>
						<!--<td rowspan='11'>Assay Limit</td>-->
						<td>Co</td>
						<td>
							<input type="text" id="edt_ASSAY_LIMIT_AMT_9">
						</td>
						<td>ppm</td>
					</tr>
					<tr>
						<!--<td rowspan='11'>Assay Limit</td>-->
						<td>MgO</td>
						<td>
							<input type="text" id="edt_ASSAY_LIMIT_AMT_10">
						</td>
						<td>%</td>
					</tr>
					<tr>
						<!--<td rowspan='11'>Assay Limit</td>-->
						<td>Mn</td>
						<td>
							<input type="text" id="edt_ASSAY_LIMIT_AMT_11">
						</td>
						<td>%</td>
					</tr>
					<tr>
						<td>QP</td>
						<td></td>
						<td>
							<input type="text" id="edt_QP">
						</td>
						<td></td>
					</tr>
					<tr>
						<td>Surveyor</td>
						<td></td>
						<td>
							<input type="text" id="edt_SURVEYOR">
						</td>
						<td></td>
					</tr>
					<tr>
						<td>L/C No</td>
						<td></td>
						<td>
							<input type="text" id="edt_LC_NO">
						</td>
						<td></td>
					</tr>
					<tr>
						<td>통관일</td>
						<td></td>
						<td>
							<input type="text" class="calendar dtp" id="cal_CLEARANCE_DATE" size="10" value="2022/10/11">
						</td>
						<td></td>
					</tr>
					<tr>
						<td>수량결정방법</td>
						<td></td>
						<td>
							<input type="text" id="edt_AMOUNT_DECISION">
						</td>
						<td></td>
					</tr>
					<tr>
						<td>하역사</td>
						<td></td>
						<td>
							<input type="text" id="edt_UNLOADING">
						</td>
						<td></td>
					</tr>
					<tr>
						<td>입고창고</td>
						<td></td>
						<td>
							<input type="text" id="edt_IMPORT_STORAGE">
						</td>
						<td></td>
					</tr>
					<tr>
						<td>접안부두</td>
						<td></td>
						<td>
							<input type="text" id="edt_DOCK_NO">
						</td>
						<td></td>
					</tr>
					<tr>
						<td>야간/주휴작업일정</td>
						<td></td>
						<td>
							<input type="text" id="edt_SPECIAL_SCHEDULE">
						</td>
						<td></td>
					</tr>
				</table>
			</div>
			<div style="height:35px; background-color:white"></div>
			<div class="btn_wrap">
				<button class="btn btn_save" id="reg_btn" onclick="saveSetup();" >저장</button>
				<button class="btn btn_edoc" style="display:none;" >공문발송</button>
				<button class="btn" id="reg_btn" onclick="closePopup();" >닫기</button>
			</div>
		</div>
	</div>
	<script>
		/**
		 * 2022-12-13 smh
		 * 개발, 로컬, 운영 분기처리 변수 
		 */
		var gw_url = '<c:out value="${gw_url }"/>';
		var active_profile = '<c:out value="${activeProfile }"/>';
		
		//	1:INSERT, 2:UPDATE
		var l_EditMode = 1;

		var l_MASTER_ID = "";
		var s_MATERIAL_ID = "";
		var s_SHEET_ID = "";
		var s_SELLER_ID = "";
		var s_IMPORT_DATE = "";
		var s_IMPORT_NO = "";
		var s_PO_NO = "";
		var s_VESSEL_NAME = "";
		var f_DISCHARGING_RATE = 0.0;
		var f_DEM_DES = 0.0;
		var f_DMT = 0.0;
		var f_WMT = 0.0;
		var f_MOISTURE = 0.0;
		var s_LBL_IG_1 = "YPIG-0001";
		var s_LBL_IG_2 = "YPIG-0007";
		var s_LBL_IG_3 = "YPIG-0031";
		var s_LBL_IG_4 = "YPIG-0023";
		var s_ASSAY_LIMIT_IG = new Array();
		var f_ASSAY_LIMIT_AMT = new Array();
		var s_ASSAY_LIMIT_UNIT = new Array();
		var s_QP = "";
		var s_SURVEYOR = "";
		var s_LC_NO = "";
		var s_CLEARANCE_DATE = "";
		var s_AMOUNT_DECISION = "";
		var s_UNLOADING = "";
		var s_IMPORT_STORAGE = "";
		var s_DOCK_NO = "";
		var s_SPECIAL_SCHEDULE = ""; 

		function get_Values() {
		}

		function get_NS(id) {
			return document.getElementById(id).value == "" ? "0":document.getElementById(id).value;
		}
		
		function set_NS(id, value) {
			document.getElementById(id).value = value;
		}

		function display_bl_info() {
			//	console.log(s_MATERIAL_ID + ',' + s_SHEET_ID);

			set_NS("sel_MATERIAL_ID", s_MATERIAL_ID);
			set_NS("sel_SHEET_ID", s_SHEET_ID);
			set_NS("sel_SELLER_ID", s_SELLER_ID);
			set_NS("cal_IMPORT_DATE", s_IMPORT_DATE);
			set_NS("edt_IMPORT_NO", s_IMPORT_NO);
			set_NS("edt_PO_NO", s_PO_NO);
			set_NS("edt_VESSEL_NAME", s_VESSEL_NAME);
			set_NS("edt_DISCHARGING_RATE", f_DISCHARGING_RATE)
			set_NS("edt_DEM_DES", f_DEM_DES)
			set_NS("edt_DMT", f_DMT)
			set_NS("edt_WMT", f_WMT)
			set_NS("edt_MOISTURE", f_MOISTURE)
			set_NS("sel_LBL_IG_1", s_LBL_IG_1);
			set_NS("sel_LBL_IG_2", s_LBL_IG_2);
			set_NS("sel_LBL_IG_3", s_LBL_IG_3);
			set_NS("sel_LBL_IG_4", s_LBL_IG_4);
			set_NS("edt_ASSAY_LIMIT_AMT_1", f_ASSAY_LIMIT_AMT[0]);
			set_NS("edt_ASSAY_LIMIT_AMT_2", f_ASSAY_LIMIT_AMT[1]);
			set_NS("edt_ASSAY_LIMIT_AMT_3", f_ASSAY_LIMIT_AMT[2]);
			set_NS("edt_ASSAY_LIMIT_AMT_4", f_ASSAY_LIMIT_AMT[3]);
			set_NS("edt_ASSAY_LIMIT_AMT_5", f_ASSAY_LIMIT_AMT[4]);
			set_NS("edt_ASSAY_LIMIT_AMT_6", f_ASSAY_LIMIT_AMT[5]);
			set_NS("edt_ASSAY_LIMIT_AMT_7", f_ASSAY_LIMIT_AMT[6]);
			set_NS("edt_ASSAY_LIMIT_AMT_8", f_ASSAY_LIMIT_AMT[7]);
			set_NS("edt_ASSAY_LIMIT_AMT_9", f_ASSAY_LIMIT_AMT[8]);
			set_NS("edt_ASSAY_LIMIT_AMT_10", f_ASSAY_LIMIT_AMT[9]);
			set_NS("edt_ASSAY_LIMIT_AMT_11", f_ASSAY_LIMIT_AMT[10]);
			set_NS("edt_QP", s_QP);
			set_NS("edt_SURVEYOR", s_SURVEYOR);
			set_NS("edt_LC_NO", s_LC_NO);
			set_NS("cal_CLEARANCE_DATE", s_CLEARANCE_DATE);
			set_NS("edt_AMOUNT_DECISION", s_AMOUNT_DECISION);
			set_NS("edt_UNLOADING", s_UNLOADING);
			set_NS("edt_IMPORT_STORAGE", s_IMPORT_STORAGE);
			set_NS("edt_DOCK_NO", s_DOCK_NO);
			set_NS("edt_SPECIAL_SCHEDULE", s_SPECIAL_SCHEDULE);
		}

		function saveSetup() {
			s_MATERIAL_ID = $("select[id=sel_MATERIAL_ID]").val();
			s_SHEET_ID = $("select[id=sel_SHEET_ID]").val();
			s_SELLER_ID = $("select[id=sel_SELLER_ID]").val();
			s_IMPORT_DATE_var = $("input[id=cal_IMPORT_DATE]").val();
			s_IMPORT_DATE = s_IMPORT_DATE_var.substring(0, 4) + "-" + s_IMPORT_DATE_var.substring(5, 7) + "-" + s_IMPORT_DATE_var.substring(8, 10);
			l_MASTER_ID = s_SELLER_ID + "_" + s_MATERIAL_ID + "_" + s_IMPORT_DATE;
			s_IMPORT_NO = get_NS("edt_IMPORT_NO");
			s_VESSEL_NAME = get_NS("edt_VESSEL_NAME");
			s_PO_NO = get_NS("edt_PO_NO");
			f_DISCHARGING_RATE = get_NS("edt_DISCHARGING_RATE");
			f_DEM_DES = get_NS("edt_DEM_DES");
			f_DMT = get_NS("edt_DMT");
			f_WMT = get_NS("edt_WMT");
			f_MOISTURE = get_NS("edt_MOISTURE");
			s_LBL_IG_1 = $("select[id=sel_LBL_IG_1]").val();
			s_LBL_IG_2 = $("select[id=sel_LBL_IG_2]").val();
			s_LBL_IG_3 = $("select[id=sel_LBL_IG_3]").val();
			s_LBL_IG_4 = $("select[id=sel_LBL_IG_4]").val();
			f_ASSAY_LIMIT_AMT[0] = get_NS("edt_ASSAY_LIMIT_AMT_1");
			f_ASSAY_LIMIT_AMT[1] = get_NS("edt_ASSAY_LIMIT_AMT_2");
			f_ASSAY_LIMIT_AMT[2] = get_NS("edt_ASSAY_LIMIT_AMT_3");
			f_ASSAY_LIMIT_AMT[3] = get_NS("edt_ASSAY_LIMIT_AMT_4");
			f_ASSAY_LIMIT_AMT[4] = get_NS("edt_ASSAY_LIMIT_AMT_5");
			f_ASSAY_LIMIT_AMT[5] = get_NS("edt_ASSAY_LIMIT_AMT_6");
			f_ASSAY_LIMIT_AMT[6] = get_NS("edt_ASSAY_LIMIT_AMT_7");
			f_ASSAY_LIMIT_AMT[7] = get_NS("edt_ASSAY_LIMIT_AMT_8");
			f_ASSAY_LIMIT_AMT[8] = get_NS("edt_ASSAY_LIMIT_AMT_9");
			f_ASSAY_LIMIT_AMT[9] = get_NS("edt_ASSAY_LIMIT_AMT_10");
			f_ASSAY_LIMIT_AMT[10] = get_NS("edt_ASSAY_LIMIT_AMT_11");
			s_QP = get_NS("edt_QP");
			s_SURVEYOR = get_NS("edt_SURVEYOR");
			s_LC_NO = get_NS("edt_LC_NO");
			s_CLEARANCE_DATE_var = $("input[id=cal_CLEARANCE_DATE]").val();
			s_CLEARANCE_DATE = s_CLEARANCE_DATE_var.substring(0, 4) + "-" + s_CLEARANCE_DATE_var.substring(5, 7) + "-" + s_CLEARANCE_DATE_var.substring(8, 10);
			s_AMOUNT_DECISION = get_NS("edt_AMOUNT_DECISION");
			s_UNLOADING = get_NS("edt_UNLOADING");
			s_IMPORT_STORAGE = get_NS("edt_IMPORT_STORAGE");
			s_DOCK_NO = get_NS("edt_DOCK_NO");
			s_SPECIAL_SCHEDULE = get_NS("edt_SPECIAL_SCHEDULE");

			//	console.log(s_MATERIAL_ID,
			//			s_SHEET_ID,
			//			s_SELLER_ID,
			//			s_IMPORT_DATE,
			//			l_MASTER_ID,
			//			s_IMPORT_NO,
			//			s_PO_NO,
			//			f_DISCHARGING_RATE,
			//			f_DEM_DES,
			//			f_DMT,
			//			f_WMT,
			//			f_MOISTURE,
			//			s_LBL_IG_1,
			//			s_LBL_IG_2,
			//			s_LBL_IG_3,
			//			f_ASSAY_LIMIT_AMT[0],
			//			f_ASSAY_LIMIT_AMT[1],
			//			f_ASSAY_LIMIT_AMT[2],
			//			f_ASSAY_LIMIT_AMT[3],
			//			f_ASSAY_LIMIT_AMT[4],
			//			f_ASSAY_LIMIT_AMT[5],
			//			f_ASSAY_LIMIT_AMT[6],
			//			f_ASSAY_LIMIT_AMT[7],
			//			f_ASSAY_LIMIT_AMT[8],
			//			f_ASSAY_LIMIT_AMT[9],
			//			f_ASSAY_LIMIT_AMT[10],
			//			s_QP,
			//			s_SURVEYOR,
			//			s_LC_NO,
			//			s_CLEARANCE_DATE,
			//			s_AMOUNT_DECISION,
			//			s_UNLOADING,
			//			s_IMPORT_STORAGE,
			//			s_DOCK_NO,
			//			s_SPECIAL_SCHEDULE);

			$.ajax({
 				url : "/yp/popup/zpp/ore/zpp_ore_insert_bl_info",
				type : "POST",
			    cache:false,
			    async:true, 
				data : {
					MASTER_ID : l_MASTER_ID,
					MODE : l_EditMode,
					MATERIAL_ID : s_MATERIAL_ID,
					SHEET_ID : s_SHEET_ID,
					SELLER_ID : s_SELLER_ID,
					IMPORT_DATE : s_IMPORT_DATE,
					IMPORT_NO : s_IMPORT_NO,
					VESSEL_NAME : s_VESSEL_NAME,
					PO_NO : s_PO_NO,
					DISCHARGING_RATE : f_DISCHARGING_RATE,
					DEM_DES : f_DEM_DES,
					DMT : f_DMT,
					WMT : f_WMT,
					MOISTURE : f_MOISTURE,
					LBL_IG_1 : s_LBL_IG_1,
					LBL_IG_2 : s_LBL_IG_2,
					LBL_IG_3 : s_LBL_IG_3,
					LBL_IG_4 : s_LBL_IG_4,
					ASSAY_LIMIT_IG_1 : s_ASSAY_LIMIT_IG[0],
					ASSAY_LIMIT_IG_2 : s_ASSAY_LIMIT_IG[1],
					ASSAY_LIMIT_IG_3 : s_ASSAY_LIMIT_IG[2],
					ASSAY_LIMIT_IG_4 : s_ASSAY_LIMIT_IG[3],
					ASSAY_LIMIT_IG_5 : s_ASSAY_LIMIT_IG[4],
					ASSAY_LIMIT_IG_6 : s_ASSAY_LIMIT_IG[5],
					ASSAY_LIMIT_IG_7 : s_ASSAY_LIMIT_IG[6],
					ASSAY_LIMIT_IG_8 : s_ASSAY_LIMIT_IG[7],
					ASSAY_LIMIT_IG_9 : s_ASSAY_LIMIT_IG[8],
					ASSAY_LIMIT_IG_10 : s_ASSAY_LIMIT_IG[9],
					ASSAY_LIMIT_IG_11 : s_ASSAY_LIMIT_IG[10],
					ASSAY_LIMIT_IG_12 : s_ASSAY_LIMIT_IG[11],
					ASSAY_LIMIT_AMT_1 : f_ASSAY_LIMIT_AMT[0],
					ASSAY_LIMIT_AMT_2 : f_ASSAY_LIMIT_AMT[1],
					ASSAY_LIMIT_AMT_3 : f_ASSAY_LIMIT_AMT[2],
					ASSAY_LIMIT_AMT_4 : f_ASSAY_LIMIT_AMT[3],
					ASSAY_LIMIT_AMT_5 : f_ASSAY_LIMIT_AMT[4],
					ASSAY_LIMIT_AMT_6 : f_ASSAY_LIMIT_AMT[5],
					ASSAY_LIMIT_AMT_7 : f_ASSAY_LIMIT_AMT[6],
					ASSAY_LIMIT_AMT_8 : f_ASSAY_LIMIT_AMT[7],
					ASSAY_LIMIT_AMT_9 : f_ASSAY_LIMIT_AMT[8],
					ASSAY_LIMIT_AMT_10 : f_ASSAY_LIMIT_AMT[9],
					ASSAY_LIMIT_AMT_11 : f_ASSAY_LIMIT_AMT[10],
					ASSAY_LIMIT_AMT_12 : f_ASSAY_LIMIT_AMT[11],
					ASSAY_LIMIT_UNIT_1 : s_ASSAY_LIMIT_UNIT[0],
					ASSAY_LIMIT_UNIT_2 : s_ASSAY_LIMIT_UNIT[1],
					ASSAY_LIMIT_UNIT_3 : s_ASSAY_LIMIT_UNIT[2],
					ASSAY_LIMIT_UNIT_4 : s_ASSAY_LIMIT_UNIT[3],
					ASSAY_LIMIT_UNIT_5 : s_ASSAY_LIMIT_UNIT[4],
					ASSAY_LIMIT_UNIT_6 : s_ASSAY_LIMIT_UNIT[5],
					ASSAY_LIMIT_UNIT_7 : s_ASSAY_LIMIT_UNIT[6],
					ASSAY_LIMIT_UNIT_8 :s_ASSAY_LIMIT_UNIT[7],
					ASSAY_LIMIT_UNIT_9 : s_ASSAY_LIMIT_UNIT[8],
					ASSAY_LIMIT_UNIT_10 : s_ASSAY_LIMIT_UNIT[9],
					ASSAY_LIMIT_UNIT_11 : s_ASSAY_LIMIT_UNIT[10],
					ASSAY_LIMIT_UNIT_12 : s_ASSAY_LIMIT_UNIT[11],
					QP : s_QP,
					SURVEYOR : s_SURVEYOR,
					LC_NO : s_LC_NO,
					CLEARANCE_DATE : s_CLEARANCE_DATE,
					AMOUNT_DECISION : s_AMOUNT_DECISION,
					UNLOADING : s_UNLOADING,
					IMPORT_STORAGE : s_IMPORT_STORAGE,
					DOCK_NO : s_DOCK_NO,
					SPECIAL_SCHEDULE : s_SPECIAL_SCHEDULE,
					_csrf : '${_csrf.token}'
					},
				dataType : "json",
				success : function(result) {
					opener.parent.swalSuccess("저장 되었습니다.");
					
					l_EditMode = 2;
					render_edoc();
					
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

		function set_Value() {
			//	console.log('${req_data.MATERIAL_ID}', '${req_data.SHEET_ID}', '${req_data.SELLER_ID}', '${req_data.IMPORT_DATE}');

			l_MASTER_ID = '${req_data.MASTER_ID}';

			s_MATERIAL_ID = '${req_data.MATERIAL_ID}';
			s_SHEET_ID = '${req_data.SHEET_ID}';
			s_SELLER_ID = '${req_data.SELLER_ID}';
			s_IMPORT_DATE = '${req_data.IMPORT_DATE}';

			set_NS("sel_MATERIAL_ID", s_MATERIAL_ID);
			set_NS("sel_SHEET_ID", s_SHEET_ID);
			set_NS("sel_SELLER_ID", s_SELLER_ID);
			set_NS("cal_IMPORT_DATE", s_IMPORT_DATE);
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

					if(result.data_count > 0) {
						//	UPDATE MODE
						l_EditMode = 2;

						s_IMPORT_NO = result.data.IMPORT_NO;
						s_PO_NO = result.data.PO_NO;
						f_DISCHARGING_RATE = result.data.DISCHARGING_RATE;
						f_DEM_DES = result.data.DEM_DES;
						f_DMT = result.data.DMT;
						f_WMT = result.data.WMT;
						f_MOISTURE = result.data.MOISTURE;
						s_LBL_IG_1 = result.data.LBL_IG_1;
						s_LBL_IG_2 = result.data.LBL_IG_2;
						s_LBL_IG_3 = result.data.LBL_IG_3;
						s_LBL_IG_4 = result.data.LBL_IG_4;
						s_ASSAY_LIMIT_IG[ 0] = result.data.ASSAY_LIMIT_IG_1;
						s_ASSAY_LIMIT_IG[ 1] = result.data.ASSAY_LIMIT_IG_2;
						s_ASSAY_LIMIT_IG[ 2] = result.data.ASSAY_LIMIT_IG_3;
						s_ASSAY_LIMIT_IG[ 3] = result.data.ASSAY_LIMIT_IG_4;
						s_ASSAY_LIMIT_IG[ 4] = result.data.ASSAY_LIMIT_IG_5;
						s_ASSAY_LIMIT_IG[ 5] = result.data.ASSAY_LIMIT_IG_6;
						s_ASSAY_LIMIT_IG[ 6] = result.data.ASSAY_LIMIT_IG_7;
						s_ASSAY_LIMIT_IG[ 7] = result.data.ASSAY_LIMIT_IG_8;
						s_ASSAY_LIMIT_IG[ 8] = result.data.ASSAY_LIMIT_IG_9;
						s_ASSAY_LIMIT_IG[ 9] = result.data.ASSAY_LIMIT_IG_10;
						s_ASSAY_LIMIT_IG[10] = result.data.ASSAY_LIMIT_IG_11;
						s_ASSAY_LIMIT_IG[11] = result.data.ASSAY_LIMIT_IG_12;

						f_ASSAY_LIMIT_AMT[ 0] = result.data.ASSAY_LIMIT_AMT_1;
						f_ASSAY_LIMIT_AMT[ 1] = result.data.ASSAY_LIMIT_AMT_2;
						f_ASSAY_LIMIT_AMT[ 2] = result.data.ASSAY_LIMIT_AMT_3;
						f_ASSAY_LIMIT_AMT[ 3] = result.data.ASSAY_LIMIT_AMT_4;
						f_ASSAY_LIMIT_AMT[ 4] = result.data.ASSAY_LIMIT_AMT_5;
						f_ASSAY_LIMIT_AMT[ 5] = result.data.ASSAY_LIMIT_AMT_6;
						f_ASSAY_LIMIT_AMT[ 6] = result.data.ASSAY_LIMIT_AMT_7;
						f_ASSAY_LIMIT_AMT[ 7] = result.data.ASSAY_LIMIT_AMT_8;
						f_ASSAY_LIMIT_AMT[ 8] = result.data.ASSAY_LIMIT_AMT_9;
						f_ASSAY_LIMIT_AMT[ 9] = result.data.ASSAY_LIMIT_AMT_10;
						f_ASSAY_LIMIT_AMT[10] = result.data.ASSAY_LIMIT_AMT_11;
						f_ASSAY_LIMIT_AMT[11] = result.data.ASSAY_LIMIT_AMT_12;

						s_ASSAY_LIMIT_UNIT[ 0] = result.data.ASSAY_LIMIT_UNIT_1;
						s_ASSAY_LIMIT_UNIT[ 1] = result.data.ASSAY_LIMIT_UNIT_2;
						s_ASSAY_LIMIT_UNIT[ 2] = result.data.ASSAY_LIMIT_UNIT_3;
						s_ASSAY_LIMIT_UNIT[ 3] = result.data.ASSAY_LIMIT_UNIT_4;
						s_ASSAY_LIMIT_UNIT[ 4] = result.data.ASSAY_LIMIT_UNIT_5;
						s_ASSAY_LIMIT_UNIT[ 5] = result.data.ASSAY_LIMIT_UNIT_6;
						s_ASSAY_LIMIT_UNIT[ 6] = result.data.ASSAY_LIMIT_UNIT_7;
						s_ASSAY_LIMIT_UNIT[ 7] = result.data.ASSAY_LIMIT_UNIT_8;
						s_ASSAY_LIMIT_UNIT[ 8] = result.data.ASSAY_LIMIT_UNIT_9;
						s_ASSAY_LIMIT_UNIT[ 9] = result.data.ASSAY_LIMIT_UNIT_10;
						s_ASSAY_LIMIT_UNIT[10] = result.data.ASSAY_LIMIT_UNIT_11;
						s_ASSAY_LIMIT_UNIT[11] = result.data.ASSAY_LIMIT_UNIT_12;

						s_QP = result.data.QP;
						s_SURVEYOR = result.data.SURVEYOR;
						s_LC_NO = result.data.LC_NO;
						s_CLEARANCE_DATE = result.data.CLEARANCE_DATE;
						s_AMOUNT_DECISION = result.data.AMOUNT_DECISION;
						s_UNLOADING = result.data.UNLOADING;
						s_IMPORT_STORAGE = result.data.IMPORT_STORAGE;
						s_DOCK_NO = result.data.DOCK_NO;
						s_SPECIAL_SCHEDULE = result.data.SPECIAL_SCHEDULE; 
					}
					else {
						//	INSERT MODE
						l_EditMode = 1;

						s_IMPORT_NO = "";
						s_PO_NO = "";
						s_VESSEL_NAME = "";
						f_DISCHARGING_RATE = 0.0;
						f_DEM_DES = 0.0;
						f_DMT = 0.0;
						f_WMT = 0.0;
						f_MOISTURE = 0.0;
						s_LBL_IG_1 = "YPIG-0001";
						s_LBL_IG_2 = "YPIG-0007";
						s_LBL_IG_3 = "YPIG-0031";
						s_LBL_IG_4 = "YPIG-0023";
						s_ASSAY_LIMIT_IG[0] = "YPIG-0001";
						f_ASSAY_LIMIT_AMT[0] = 0.0;
						s_ASSAY_LIMIT_UNIT[0] = "%";
						s_ASSAY_LIMIT_IG[1] = "YPIG-0007";
						f_ASSAY_LIMIT_AMT[1] = 0.0;
						s_ASSAY_LIMIT_UNIT[1] = "g/t";
						s_ASSAY_LIMIT_IG[2] = "YPIG-0031";
						f_ASSAY_LIMIT_AMT[2] = 0.0;
						s_ASSAY_LIMIT_UNIT[2] = "g/t";
						s_ASSAY_LIMIT_IG[3] = "YPIG-0016";
						f_ASSAY_LIMIT_AMT[3] = 0.0;
						s_ASSAY_LIMIT_UNIT[3] = "%";
						s_ASSAY_LIMIT_IG[4] = "YPIG-0023";
						f_ASSAY_LIMIT_AMT[4] = 0.0;
						s_ASSAY_LIMIT_UNIT[4] = "%";
						s_ASSAY_LIMIT_IG[5] = "YPIG-0018";
						f_ASSAY_LIMIT_AMT[5] = 0.0;
						s_ASSAY_LIMIT_UNIT[5] = "ppm";
						s_ASSAY_LIMIT_IG[6] = "YPIG-0032";
						f_ASSAY_LIMIT_AMT[6] = 0.0;
						s_ASSAY_LIMIT_UNIT[6] = "ppm";
						s_ASSAY_LIMIT_IG[7] = "YPIG-0013";
						f_ASSAY_LIMIT_AMT[7] = 0.0;
						s_ASSAY_LIMIT_UNIT[7] = "%";
						s_ASSAY_LIMIT_IG[8] = "YPIG-0014";
						f_ASSAY_LIMIT_AMT[8] = 0.0;
						s_ASSAY_LIMIT_UNIT[8] = "ppm";
						s_ASSAY_LIMIT_IG[9] = "YPIG-0008";
						f_ASSAY_LIMIT_AMT[9] = 0.0;
						s_ASSAY_LIMIT_UNIT[9] = "%";
						s_ASSAY_LIMIT_IG[10] = "YPIG-0010";
						f_ASSAY_LIMIT_AMT[10] = 0.0;
						s_ASSAY_LIMIT_UNIT[10] = "%";
						s_ASSAY_LIMIT_IG[11] = "";
						f_ASSAY_LIMIT_AMT[11] = 0.0,
						s_ASSAY_LIMIT_UNIT[11] = "";
						s_QP = "";
						s_SURVEYOR = "";
						s_LC_NO = "";
						s_CLEARANCE_DATE = "";
						s_AMOUNT_DECISION = "";
						s_UNLOADING = "";
						s_IMPORT_STORAGE = "";
						s_DOCK_NO = "";
						s_SPECIAL_SCHEDULE = ""; 
					}

					display_bl_info();
					render_edoc();
				},
				error : function(request, status, error) {
					//	console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
				}
			});
		}
		
		// 공문 발송
		$(".btn_edoc").on("click", function() {
			var form_id = '',
				master_id = l_MASTER_ID,
				url = '';
				 
			// 로컬 개발
			if(active_profile === 'local' || active_profile === 'dev'){
				form_id = 'EF167088836245056';
				url = `\${gw_url}/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=\${form_id}&MASTER_ID=\${master_id}`;
			// 운영
			}else if(active_profile === 'prd'){
				form_id = 'EF167088836245056';
				url = `\${gw_url}/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=\${form_id}&MASTER_ID=\${master_id}`;
			}else{
				alert('톰캣 서버 환경 변수 설정을 확인해주세요.');
				return;
			}				  
			//	console.log('[TEST]url:',url);
			window.open(url, "전자결재", "scrollbars=auto,width=1000,height=900");
		});
		
		/**
		 * 전자결재 화면 표시 렌더링
		 */
		function render_edoc(){
			const $oEdocButton = $(".btn_edoc");
			
			$oEdocButton.hide();
			/** 
			 * [l_EditMode 상태표]
			 * 1 : INSERT MODE
			 * 2 : UPDATE MODE
		     */
			if(l_EditMode === 1){
				$oEdocButton.hide();
			}else if(l_EditMode === 2){
				$oEdocButton.show();
			}else{
				$oEdocButton.hide();
			}
		}

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

						$("select[id=sel_MATERIAL_ID]").append("<option value='" + material_id + "'>" + material_name + "</option>");
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

						$("select[id=sel_SELLER_ID]").append("<option value='" + seller_id + "'>" + seller_name + "</option>");
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

						$("select[id=sel_LBL_IG_1]").append("<option value='" + ig_id + "'>" + ig_name + "</option>");
						$("select[id=sel_LBL_IG_2]").append("<option value='" + ig_id + "'>" + ig_name + "</option>");
						$("select[id=sel_LBL_IG_3]").append("<option value='" + ig_id + "'>" + ig_name + "</option>");
						$("select[id=sel_LBL_IG_4]").append("<option value='" + ig_id + "'>" + ig_name + "</option>");
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

			set_Value();
			load_bl_info();
		});
		
		
	</script>
</body>
</html>