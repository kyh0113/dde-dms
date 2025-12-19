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
	<title>시험연구팀 등록 화면 (B/L 수량통지)</title>
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
			시험연구팀 등록 화면 (B/L 수량통지)
		</div>
		<div class="pop_content">
			<div class="btn_wrap">
				<button class="btn btn_save" id="reg_btn" onclick="saveSetup();" >저장</button>
				<button class="btn btn_edoc" style="display:none;" >공문발송</button>
				<button class="btn" id="reg_btn" onclick="closePopup();" >닫기</button>
			</div>
			<div style="height:35px; background-color:white"></div>
			<table>
				<colgroup>
					<col width="50%" />
					<col width="50%" />
				</colgroup>
				<tr style='border:none;'>
					<td>
						<table id="table_1" class=tbl_def>
							<colgroup>
								<col width="50%" />
								<col width="50%" />
							</colgroup>
							<tr>
								<th>항목</th>
								<th>값</th>
							</tr>
							<tr>
								<td>광종</td>
								<td>
									<div style="display:flex;flex-wrap:wrap;flex-direction:row;">
										<select id="sel_MATERIAL_ID" style="width:180px;">
										</select>
				 						<div style='width:20px;'></div>
										<select id="sel_SHEET_ID" style="width:70px;">
											<option value="0">없음</option>
											<option value="A">A</option>
											<option value="B">B</option>
											<option value="C">C</option>
											<option value="D">D</option>
				 						</select>
			 						</div>
								</td>
							</tr>
							<tr>
								<td>SELLER</td>
								<td>
									<select id="sel_SELLER_ID" style="width:300px;">
									</select>
								</td>
							</tr>
							<tr>
								<td>입항일</td>
								<td>
									<input type="text" class="calendar dtp" id="cal_IMPORT_DATE" size="10">
								</td>
							</tr>
							<tr>
								<td>선박명</td>
								<td>
									<input type="text" maxlength="20" id="edt_VESSEL_NAME" >
								</td>
							</tr>
							<tr>
								<td>수량-DMT</td>
								<td>
									<input type="number" maxlength="10" oninput="numberMaxLength(this);" id="edt_DMT">
								</td>
							</tr>
							<tr>
								<td rowspan='4'>Assay Exchange</td>
								<td>
									<select id="sel_LBL_IG_1" style="width:120px;" onchange="changeIG_1()">
			 						</select>
								</td>
							</tr>
							<tr>
								<!--<td rowspan='4'>Assay Exchange</td>-->
								<td>
									<select id="sel_LBL_IG_2" style="width:120px;" onchange="changeIG_2()">
			 						</select>
								</td>
							</tr>
							<tr>
								<!--<td rowspan='4'>Assay Exchange</td>-->
								<td>
									<select id="sel_LBL_IG_3" style="width:120px;" onchange="changeIG_3()">
										<option value="">해당없음</option>
			 						</select>
								</td>
							</tr>
							<tr>
								<!--<td rowspan='4'>Assay Exchange</td>-->
								<td>
									<select id="sel_LBL_IG_4" style="width:120px;" onchange="changeIG_4()">
										<option value="">해당없음</option>
			 						</select>
								</td>
							</tr>
						</table>
					</td>
					<td rowspan="2">
						LOT COUNT :&nbsp;
						<select id="sel_LC" onchange="changeLotCount()">
							<option value=1>1</option>
							<option value=2>2</option>
							<option value=3>3</option>
							<option value=4>4</option>
							<option value=5>5</option>
							<option value=6>6</option>
							<option value=7>7</option>
							<option value=8>8</option>
							<option value=9>9</option>
							<option value=10>10</option>
							<option value=11>11</option>
							<option value=12>12</option>
							<option value=13>13</option>
							<option value=14>14</option>
							<option value=15>15</option>
							<option value=16>16</option>
							<option value=17>17</option>
							<option value=18>18</option>
							<option value=19>19</option>
							<option value=20>20</option>
							<option value=21>21</option>
							<option value=22>22</option>
							<option value=23>23</option>
							<option value=24>24</option>
							<option value=25>25</option>
							<option value=26>26</option>
							<option value=27>27</option>
							<option value=28>28</option>
							<option value=29>29</option>
							<option value=30>30</option>
						</select>
						<div style='height:15px;'></div>
						<table id="table_2" class=tbl_def>
							<colgroup>
								<col width="10%" />
								<col width="14%" />
							</colgroup>
							<tr>
								<td/>
								<td/>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table id="table_3" class=tbl_def>
							<colgroup>
								<col width="13%" />
								<col width="20%" />
								<col width="13%" />
								<col width="20%" />
								<col width="13%" />
								<col width="20%" />
							</colgroup>
							<tr>
								<th>성분</th>
								<th>품위</th>
								<th>성분</th>
								<th>품위</th>
								<th>Particle Size mesh</th>
								<th>Particle Size (%)</th>
							</tr>
							<tr>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_1" onClick="chkIG(1)"> Zn
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_1" style="width:90px;"></td>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_17" onClick="chkIG(17)"> Sn
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_17" style="width:90px;"></td>
								<td>100</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_PM_100_VALUE" style="width:90px;"></td>
							</tr>
							<tr>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_2" onClick="chkIG(2)"> Fe
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_2" style="width:90px;"></td>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_18" onClick="chkIG(18)"> Hg
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_18" style="width:90px;"></td>
								<td>200</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_PM_200_VALUE" style="width:90px;"></td>
							</tr>
							<tr>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_3" onClick="chkIG(3)"> T.S
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_3" style="width:90px;"></td>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_19" onClick="chkIG(19)"> Al2So3
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_19" style="width:90px;"></td>
								<td>325</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_PM_325_VALUE" style="width:90px;"></td>
							</tr>
							<tr>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_4" onClick="chkIG(4)"> Pb
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_4" style="width:90px;"></td>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_20" onClick="chkIG(20)"> In(g/T)
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_20" style="width:90px;"></td>
								<td>400</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_PM_400_VALUE" style="width:90px;"></td>
							</tr>
							<tr>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_5" onClick="chkIG(5)"> Cu
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_5" style="width:90px;"></td>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_21" onClick="chkIG(21)"> Cr
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_21" style="width:90px;"></td>
								<td>-400</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_PM_M400_VALUE" style="width:90px;"></td>
							</tr>
							<tr>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_6" onClick="chkIG(6)"> Cd
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_6" style="width:90px;"></td>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_22" onClick="chkIG(22)"> Cl
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_22" style="width:90px;"></td>
							</tr>
							<tr>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_7" onClick="chkIG(7)"> Ag(g/T)
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_7" style="width:90px;"></td>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_23" onClick="chkIG(23)"> SiO2
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_23" style="width:90px;"></td>
							</tr>
							<tr>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_8" onClick="chkIG(8)"> MgO
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_8" style="width:90px;"></td>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_24" onClick="chkIG(24)"> B
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_24" style="width:90px;"></td>
							</tr>
							<tr>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_9" onClick="chkIG(9)"> CaO
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_9" style="width:90px;"></td>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_25" onClick="chkIG(25)"> Se
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_25" style="width:90px;"></td>
							</tr>
							<tr>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_10" onClick="chkIG(10)"> Mn
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_10" style="width:90px;"></td>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_26" onClick="chkIG(26)"> Ga
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_26" style="width:90px;"></td>
							</tr>
							<tr>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_11" onClick="chkIG(11)"> Ni
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_11" style="width:90px;"></td>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_27" onClick="chkIG(27)"> Mo
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_27" style="width:90px;"></td>
							</tr>
							<tr>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_12" onClick="chkIG(12)"> Sb
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_12" style="width:90px;"></td>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_28" onClick="chkIG(28)"> Ti
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_28" style="width:90px;"></td>
							</tr>
							<tr>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_13" onClick="chkIG(13)"> As
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_13" style="width:90px;"></td>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_29" onClick="chkIG(29)"> Bi
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_29" style="width:90px;"></td>
							</tr>
							<tr>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_14" onClick="chkIG(14)"> Co
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_14" style="width:90px;"></td>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_30" onClick="chkIG(30)"> K
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_30" style="width:90px;"></td>
							</tr>
							<tr>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_15" onClick="chkIG(15)"> Ge
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_15" style="width:90px;"></td>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_31" onClick="chkIG(31)"> Au(g/T)
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_31" style="width:90px;"></td>
							</tr>
							<tr>
								<td>
									<input type="checkbox" id="cb_IG_VALUE_16" onClick="chkIG(16)"> Fe
								</td>
								<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_16" style="width:90px;"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
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
		var s_VESSEL_NAME = "";
		var f_DMT = 0.0;
		var s_LBL_IG_1 = "YPIG-0001";
		var s_LBL_IG_2 = "YPIG-0007";
		var s_LBL_IG_3 = "YPIG-0031";
		var s_LBL_IG_4 = "";

		var l_Edit_ID = 0;
		
		var s_CPS_IG = new Array();

		var s_IG_LIST = new Array();
		var s_LOT_IG_VALUE_1 = new Array();
		var s_LOT_IG_VALUE_2 = new Array();
		var s_LOT_IG_VALUE_3 = new Array();
		var s_LOT_IG_VALUE_4 = new Array();

		var s_IG_CODE = new Array();
		var s_IG_VALUE = new Array();

		var l_IG_CODE = new Array();
		var l_IG_NAME = new Array();

		var s_PM_100_VALUE;
		var s_PM_200_VALUE;
		var s_PM_325_VALUE;
		var s_PM_400_VALUE;
		var s_PM_M400_VALUE;

		var l_LOT_COUNT = 10;

		var l_INGREDIENT_CNT;
		var l_INGREDIENT_ID = new Array();
		var	l_INGREDIENT_NAME = new Array();

		var l_WMT_Val = new Array();
		var l_DMT_Val = new Array();
		var l_MOISTURE_Val = new Array();

		var l_Error_Msg = '';

		var l_Edited_Val = new create2DArray(30, 6);

		function
		chkIG(id)
		{
			var ig_cnt = 0;
			var cb_id = 'cb_IG_VALUE_' + (id).toString();
			var ed_id = 'edt_IG_VALUE_' + (id).toString();

			for(var i = 1;i <= 31;i ++)
			{
				var cb_name = 'cb_IG_VALUE_' + i.toString();

				if(get_Checked(cb_name) == true)
				{
					ig_cnt ++;
				}
			}

			if(ig_cnt > 5)
			{
				document.getElementById(cb_id).checked = false;
				swalInfoCB("최대 5개 까지 지정가능합니다.");
			}
			else
			{
				if(document.getElementById(cb_id).checked == true)
				{
					document.getElementById(ed_id).focus();
				}
			}
		}

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
		 
		function get_Values() {
		}

		function get_NS(id) {
			if((document.getElementById(id).value == 'undefined') ||
			   (document.getElementById(id).value == '')) return 0;
			else return document.getElementById(id).value;
		}
		
		function set_NS(id, value) {
			document.getElementById(id).value = value;
		}

		function get_Checked(id) {
			return document.getElementById(id).checked;
		}

		function set_Checked(id, value) {
			document.getElementById(id).checked = value;
		}

		function display_bl_info() {
			//	선박명
			set_NS("edt_VESSEL_NAME", s_VESSEL_NAME);
			set_NS("edt_DMT", f_DMT);

			set_NS("sel_LBL_IG_1", s_LBL_IG_1);
			set_NS("sel_LBL_IG_2", s_LBL_IG_2);
			set_NS("sel_LBL_IG_3", s_LBL_IG_3);
			set_NS("sel_LBL_IG_4", s_LBL_IG_4);

			set_NS("edt_PM_100_VALUE", s_PM_100_VALUE);
			set_NS("edt_PM_200_VALUE", s_PM_200_VALUE);
			set_NS("edt_PM_325_VALUE", s_PM_325_VALUE);
			set_NS("edt_PM_400_VALUE", s_PM_400_VALUE);
			set_NS("edt_PM_M400_VALUE", s_PM_M400_VALUE);

			for (var si = 0; si < 31; si++) {
				var cn = "edt_IG_VALUE_" + (si + 1).toString();
				set_NS(cn, s_IG_VALUE[si]);

				if((s_IG_CODE[si] == s_CPS_IG[0]) ||
				   (s_IG_CODE[si] == s_CPS_IG[1]) ||
				   (s_IG_CODE[si] == s_CPS_IG[2]) ||
				   (s_IG_CODE[si] == s_CPS_IG[3]) ||
				   (s_IG_CODE[si] == s_CPS_IG[4]))
				{
					//	console.log(s_IG_CODE[si] + ',' + s_CPS_IG[0] + ',' + s_CPS_IG[1] + ',' + s_CPS_IG[2] + ',' + s_CPS_IG[3] + ',' + s_CPS_IG[4]);

					var ch = "cb_IG_VALUE_" + (si + 1).toString();
					var ed = "edt_IG_VALUE_" + (si + 1).toString();
					set_Checked(ch, true);
				}
				else
				{
					var ch = "cb_IG_VALUE_" + (si + 1).toString();
					set_Checked(ch, false);
				}
			}

			set_NS("sel_LC", l_LOT_COUNT);
			setLotCountTable(l_LOT_COUNT);

			for (var si = 0; si < l_LOT_COUNT; si++) {
				var fn = "input_" + (si + 1).toString() + "_1";

				set_NS(fn, l_DMT_Val[si]);

				for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++)
				{
					cn = "edt_LOT_" + (si + 1).toString() + "_IG_" + (ac + 1).toString() + "_VALUE";
					switch(ac)
					{
					case 0:	set_NS(cn, s_LOT_IG_VALUE_1[si]);	break;
					case 1:	set_NS(cn, s_LOT_IG_VALUE_2[si]);	break;
					case 2:	set_NS(cn, s_LOT_IG_VALUE_3[si]);	break;
					case 3:	set_NS(cn, s_LOT_IG_VALUE_4[si]);	break;
					}
				}
			}
		}

		function
		setErrorMsg(msg)
		{
			l_Error_Msg = msg;
		}

		function
		getErrorMsg()
		{
			return l_Error_Msg;
		}

		function
		findArrayCnt(lblArray, lblIg)
		{
			var ret = 0;

			lblArray.forEach(
				function (item, index, array)
				{
				  	if(item === lblIg) ret ++;
				});

			return ret;
		}

		function
		validCheck()
		{
			//	광종 / SELLER / 입항일 / 선박명 / 수량
			//	AssayExchange 중복 선택

			var materialID = $("select[id=sel_MATERIAL_ID]").val();
			var sheetID = $("select[id=sel_SHEET_ID]").val();
			var sellerID = $("select[id=sel_SELLER_ID]").val();
			var importDate = $("input[id=cal_IMPORT_DATE]").val();
			var vesselName = $("input[id=edt_VESSEL_NAME]").val();
			var dmt = get_NS("edt_DMT");
			var dmtAmount = Number(dmt);

			//	console.log(materialID + ',' + sellerID + ',' + importDate + ',' + vesselName + ',' + dmt + ',' + dmtAmount);

			if(materialID == null)
			{
				setErrorMsg('[광종] 항목이 선택되지 않았습니다.');
				$("#sel_MATERIAL_ID").select().focus();
				return 1;
			}

			if(sheetID == null)
			{
				setErrorMsg('[SHEET] 항목이 선택되지 않았습니다.');
				$("#sel_SHEET_ID").select().focus();
				return 2;
			}

			if(sellerID == null)
			{
				setErrorMsg('[SELLER] 항목이 선택되지 않았습니다.');
				return 3;
			}

			if((importDate == null) || (importDate == ''))
			{
				setErrorMsg('[입항일] 항목이 선택되지 않았습니다.');
				return 4;
			}

			if((vesselName == null) || (vesselName == ''))
			{
				setErrorMsg('[선박명] 항목이 입력되지 않았습니다.');
				return 5;
			}

			if((dmt == null) || (dmtAmount == 0))
			{
				setErrorMsg('[DMT] 항목이 입력되지 않았습니다.');
				return 6;
			}

			//	성분 중복 선택 여부 확인
			var lblIg1 = $("select[id=sel_LBL_IG_1]").val();
			var lblIg2 = $("select[id=sel_LBL_IG_2]").val();
			var lblIg3 = $("select[id=sel_LBL_IG_3]").val();
			var lblIg4 = $("select[id=sel_LBL_IG_4]").val();
			var lblArray = [];

			lblArray.push(lblIg1);
			lblArray.push(lblIg2);
			lblArray.push(lblIg3);
			lblArray.push(lblIg4);

			if((findArrayCnt(lblArray, lblIg1) > 1) ||
			   (findArrayCnt(lblArray, lblIg2) > 1) ||					
			   (findArrayCnt(lblArray, lblIg3) > 1) ||					
			   (findArrayCnt(lblArray, lblIg4) > 1))					
			{
				setErrorMsg('[AssayExchange성분]이 중복 선택되었습니다.');
				return 7;
			}

			for(var i = 1;i <= 31;i ++)
			{
				var cb_name = 'cb_IG_VALUE_' + i.toString();
				var ed_name = 'edt_IG_VALUE_' + i.toString();

				if(get_Checked(cb_name) == true)
				{
					if(get_NS(ed_name) == 0)
					{
						setErrorMsg('성분의 품위 값이 입력되지 않았습니다.');
						return 7 + i;
					}
				}
			}

			return 0;
		}

		function
		warningCheck()
		{
			//	성분 선택이 전혀 없는 경우
			//	LOT 값 (DMT / 성분) 중 0이 있는 경우
			
			return true;
		}

		function
		sf_sel_MATERIAL_ID()
		{
			$("#sel_MATERIAL_ID").select().focus();
		}

		function
		sf_sel_SHEET_ID()
		{
			$("#sel_SHEET_ID").select().focus();
		}

		function
		sf_sel_SELLER_ID()
		{
			$("#sel_SELLER_ID").select().focus();
		}

		function
		sf_cal_IMPORT_DATE()
		{
			$("#cal_IMPORT_DATE").select().focus();
		}

		function
		sf_edt_VESSEL_NAME()
		{
			$("#edt_VESSEL_NAME").select().focus();
		}

		function
		sf_edt_DMT()
		{
			$("#edt_DMT").select().focus();
		}

		function
		sf_sel_LBL_IG_1()
		{
			$("#sel_LBL_IG_1").select().focus();
		}

		function
		sf_ed()
		{
			var ed_name = 'edt_IG_VALUE_' + l_Edit_ID.toString();
			document.getElementById(ed_name).focus();

			//	console.log(ed_name);
		}

		function saveSetup() {
			var rs = validCheck();
			
			if(rs != 0)
			{
				if(rs == 1) swalInfoCB(getErrorMsg(), sf_sel_MATERIAL_ID);
				else if(rs == 2) swalInfoCB(getErrorMsg(), sf_sel_SHEET_ID);
				else if(rs == 3) swalInfoCB(getErrorMsg(), sf_sel_SELLER_ID);
				else if(rs == 4) swalInfoCB(getErrorMsg(), sf_cal_IMPORT_DATE);
				else if(rs == 5) swalInfoCB(getErrorMsg(), sf_edt_VESSEL_NAME);
				else if(rs == 6) swalInfoCB(getErrorMsg(), sf_edt_DMT);
				else if(rs == 7) swalInfoCB(getErrorMsg(), sf_sel_LBL_IG_1);
				else if((rs >= 8) && (rs <= 38))
				{
					l_Edit_ID = rs - 7;
					swalInfoCB(getErrorMsg(), sf_ed);
				}

				return;
			}

			if(warningCheck() == false)
			{
				swalDangerCB("입력 값 중 '0'인 항목이 있습니다.");
				return;
			}

			//	광종
			s_MATERIAL_ID = $("select[id=sel_MATERIAL_ID]").val();
			//	SHEET
			s_SHEET_ID = $("select[id=sel_SHEET_ID]").val();
			//	SELLER
			s_SELLER_ID = $("select[id=sel_SELLER_ID]").val();
			//	입항일
			s_IMPORT_DATE_var = $("input[id=cal_IMPORT_DATE]").val();
			s_IMPORT_DATE = s_IMPORT_DATE_var.substring(0, 4) + "-" + s_IMPORT_DATE_var.substring(5, 7) + "-" + s_IMPORT_DATE_var.substring(8, 10);
			//	MASTER ID
			l_MASTER_ID = s_SELLER_ID + "_" + s_MATERIAL_ID + "_" + s_IMPORT_DATE + "_" + s_SHEET_ID;

			//	MASTER ID가 이미 등록되어있는 항목인지 검사
			if(l_EditMode == 1)
			{
				$.ajax({
	 				url : "/yp/zpp/ore/zpp_ore_select_bl_info",
					type : "POST",
				    cache:false,
				    async:true, 
					data : {
						MASTER_ID : l_MASTER_ID,
						_csrf : '${_csrf.token}'
						},
					dataType : "json",
					success : function(result) {
						//	저장
						if(result.data_count == 0)
						{
							ReqRegBLInfo();
						}
						else
						{
							swalDangerCB("같은 광종/SELLER/입항일/SHEET에 해당하는 데이터가 이미 등록되어 있습니다. 다시 확인해주시기 바랍니다.");
						}
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
			else
			{
				ReqRegBLInfo();
			}
		}

		function
		ReqRegBLInfo()
		{
			//	선박명
			s_VESSEL_NAME = get_NS("edt_VESSEL_NAME");
			//	수량-DMT
			f_DMT = get_NS("edt_DMT");
			//	AssayExchange
			s_LBL_IG_1 = $("select[id=sel_LBL_IG_1]").val();
			s_LBL_IG_2 = $("select[id=sel_LBL_IG_2]").val();
			s_LBL_IG_3 = $("select[id=sel_LBL_IG_3]").val();
			s_LBL_IG_4 = $("select[id=sel_LBL_IG_4]").val();

			for (var si = 0; si < 31; si++) {
				s_IG_CODE[si] = "YPIG-00" + fillZero((si + 1).toString(), 2);
			}

			for (var si = 0; si < 31; si++) {
				var cn = "edt_IG_VALUE_" + (si + 1).toString();
				s_IG_VALUE[si] = get_NS(cn);
			}

			s_PM_100_VALUE = get_NS("edt_PM_100_VALUE");
			s_PM_200_VALUE = get_NS("edt_PM_200_VALUE");
			s_PM_325_VALUE = get_NS("edt_PM_325_VALUE");
			s_PM_400_VALUE = get_NS("edt_PM_400_VALUE");
			s_PM_M400_VALUE = get_NS("edt_PM_M400_VALUE");

			for (var si = 0; si < l_LOT_COUNT; si++) {
				var fn = "input_" + (si + 1).toString() + "_1";
				l_WMT_Val[si] = get_NS(fn);
				l_DMT_Val[si] = get_NS(fn);
				l_MOISTURE_Val[si] = 0;

				for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++)
				{
					cn = "edt_LOT_" + (si + 1).toString() + "_IG_" + (ac + 1).toString() + "_VALUE";
					switch(ac)
					{
					case 0:	s_LOT_IG_VALUE_1[si] = get_NS(cn);	break;
					case 1:	s_LOT_IG_VALUE_2[si] = get_NS(cn);	break;
					case 2:	s_LOT_IG_VALUE_3[si] = get_NS(cn);	break;
					case 3:	s_LOT_IG_VALUE_4[si] = get_NS(cn);	break;
					}
				}
			}

			var ig_cnt = 0;

			for(var i = 0;i < 5;i ++)
			{
				s_CPS_IG[i] = "";
			}

			for(var i = 1;i <= 31;i ++)
			{
				var cb_name = 'cb_IG_VALUE_' + i.toString();

				if(get_Checked(cb_name) == true)
				{
					s_CPS_IG[ig_cnt] = s_IG_CODE[i - 1];
					ig_cnt ++;

					//	최대 5개
					if(ig_cnt >= 5) break;
				}
			}

			//	console.log(
			//			s_MATERIAL_ID,
			//			s_SHEET_ID,
			//			s_SELLER_ID,
			//			s_IMPORT_DATE,
			//			l_MASTER_ID,
			//			s_VESSEL_NAME,
			//			f_DMT,
			//			s_LBL_IG_1,
			//			s_LBL_IG_2,
			//			s_LBL_IG_3,
			//			s_LBL_IG_4,
			//			s_IG_VALUE[ 0],
			//			s_IG_VALUE[ 1],
			//			s_IG_VALUE[ 2],
			//			s_IG_VALUE[ 3],
			//			s_IG_VALUE[ 4],
			//			s_IG_VALUE[ 5],
			//			s_IG_VALUE[ 6],
			//			s_IG_VALUE[ 7],
			//			s_IG_VALUE[ 8],
			//			s_IG_VALUE[ 9],
			//			s_IG_VALUE[10],
			//			s_IG_VALUE[11],
			//			s_IG_VALUE[12],
			//			s_IG_VALUE[13],
			//			s_IG_VALUE[14],
			//			s_IG_VALUE[15],
			//			s_IG_VALUE[16],
			//			s_IG_VALUE[17],
			//			s_IG_VALUE[18],
			//			s_IG_VALUE[19],
			//			s_IG_VALUE[20],
			//			s_IG_VALUE[21],
			//			s_IG_VALUE[22],
			//			s_IG_VALUE[23],
			//			s_IG_VALUE[24],
			//			s_IG_VALUE[25],
			//			s_IG_VALUE[26],
			//			s_IG_VALUE[27],
			//			s_IG_VALUE[28],
			//			s_IG_VALUE[29],
			//			s_IG_VALUE[30],
			//			s_PM_100_VALUE,
			//			s_PM_200_VALUE,
			//			s_PM_325_VALUE,
			//			s_PM_400_VALUE,
			//			s_PM_M400_VALUE,
			//			s_CPS_IG[0],
			//			s_CPS_IG[1],
			//			s_CPS_IG[2],
			//			s_CPS_IG[3],
			//			s_CPS_IG[4]
			//			);

			//	for (var si = 0; si < l_LOT_COUNT; si++) {
			//		for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++)
			//		{
			//			switch(ac)
			//			{
			//			case 0:	console.log(s_LOT_IG_VALUE_1[si]);	break;
			//			case 1:	console.log(s_LOT_IG_VALUE_2[si]);	break;
			//			case 2:	console.log(s_LOT_IG_VALUE_3[si]);	break;
			//			case 3:	console.log(s_LOT_IG_VALUE_4[si]);	break;
			//			}
			//		}
			//	}

			$.ajax({
 				url : "/yp/popup/zpp/ore/zpp_ore_insert_bl_info2",
				type : "POST",
			    cache:false,
			    async:true, 
				data : {
					MODE : l_EditMode,
					MATERIAL_ID : s_MATERIAL_ID,
					SHEET_ID : s_SHEET_ID,
					SELLER_ID : s_SELLER_ID,
					IMPORT_DATE : s_IMPORT_DATE,
					MASTER_ID : l_MASTER_ID,
					VESSEL_NAME : s_VESSEL_NAME,
					DMT : f_DMT,
					LBL_IG_1 : s_LBL_IG_1,
					LBL_IG_2 : s_LBL_IG_2,
					LBL_IG_3 : s_LBL_IG_3,
					LBL_IG_4 : s_LBL_IG_4,

					IG_CODE_1 : s_IG_CODE[0],
					IG_CODE_2 : s_IG_CODE[1],
					IG_CODE_3 : s_IG_CODE[2],
					IG_CODE_4 : s_IG_CODE[3],
					IG_CODE_5 : s_IG_CODE[4],
					IG_CODE_6 : s_IG_CODE[5],
					IG_CODE_7 : s_IG_CODE[6],
					IG_CODE_8 : s_IG_CODE[7],
					IG_CODE_9 : s_IG_CODE[8],
					IG_CODE_10 : s_IG_CODE[9],
					IG_CODE_11 : s_IG_CODE[10],
					IG_CODE_12 : s_IG_CODE[11],
					IG_CODE_13 : s_IG_CODE[12],
					IG_CODE_14 : s_IG_CODE[13],
					IG_CODE_15 : s_IG_CODE[14],
					IG_CODE_16 : s_IG_CODE[15],
					IG_CODE_17 : s_IG_CODE[16],
					IG_CODE_18 : s_IG_CODE[17],
					IG_CODE_19 : s_IG_CODE[18],
					IG_CODE_20 : s_IG_CODE[19],
					IG_CODE_21 : s_IG_CODE[20],
					IG_CODE_22 : s_IG_CODE[21],
					IG_CODE_23 : s_IG_CODE[22],
					IG_CODE_24 : s_IG_CODE[23],
					IG_CODE_25 : s_IG_CODE[24],
					IG_CODE_26 : s_IG_CODE[25],
					IG_CODE_27 : s_IG_CODE[26],
					IG_CODE_28 : s_IG_CODE[27],
					IG_CODE_29 : s_IG_CODE[28],
					IG_CODE_30 : s_IG_CODE[29],
					IG_CODE_31 : s_IG_CODE[30],
					IG_CODE_32 : '',

					IG_VALUE_1 : s_IG_VALUE[0],
					IG_VALUE_2 : s_IG_VALUE[1],
					IG_VALUE_3 : s_IG_VALUE[2],
					IG_VALUE_4 : s_IG_VALUE[3],
					IG_VALUE_5 : s_IG_VALUE[4],
					IG_VALUE_6 : s_IG_VALUE[5],
					IG_VALUE_7 : s_IG_VALUE[6],
					IG_VALUE_8 : s_IG_VALUE[7],
					IG_VALUE_9 : s_IG_VALUE[8],
					IG_VALUE_10 : s_IG_VALUE[9],
					IG_VALUE_11 : s_IG_VALUE[10],
					IG_VALUE_12 : s_IG_VALUE[11],
					IG_VALUE_13 : s_IG_VALUE[12],
					IG_VALUE_14 : s_IG_VALUE[13],
					IG_VALUE_15 : s_IG_VALUE[14],
					IG_VALUE_16 : s_IG_VALUE[15],
					IG_VALUE_17 : s_IG_VALUE[16],
					IG_VALUE_18 : s_IG_VALUE[17],
					IG_VALUE_19 : s_IG_VALUE[18],
					IG_VALUE_20 : s_IG_VALUE[19],
					IG_VALUE_21 : s_IG_VALUE[20],
					IG_VALUE_22 : s_IG_VALUE[21],
					IG_VALUE_23 : s_IG_VALUE[22],
					IG_VALUE_24 : s_IG_VALUE[23],
					IG_VALUE_25 : s_IG_VALUE[24],
					IG_VALUE_26 : s_IG_VALUE[25],
					IG_VALUE_27 : s_IG_VALUE[26],
					IG_VALUE_28 : s_IG_VALUE[27],
					IG_VALUE_29 : s_IG_VALUE[28],
					IG_VALUE_30 : s_IG_VALUE[29],
					IG_VALUE_31 : s_IG_VALUE[30],
					IG_VALUE_32 : 0,

					PM_100_VALUE : s_PM_100_VALUE,
					PM_200_VALUE : s_PM_200_VALUE,
					PM_325_VALUE : s_PM_325_VALUE,
					PM_400_VALUE : s_PM_400_VALUE,
					PM_M400_VALUE : s_PM_M400_VALUE,

					LOT_1_IG_1_VALUE : s_LOT_IG_VALUE_1[0],
					LOT_2_IG_1_VALUE : s_LOT_IG_VALUE_1[1],
					LOT_3_IG_1_VALUE : s_LOT_IG_VALUE_1[2],
					LOT_4_IG_1_VALUE : s_LOT_IG_VALUE_1[3],
					LOT_5_IG_1_VALUE : s_LOT_IG_VALUE_1[4],
					LOT_6_IG_1_VALUE : s_LOT_IG_VALUE_1[5],
					LOT_7_IG_1_VALUE : s_LOT_IG_VALUE_1[6],
					LOT_8_IG_1_VALUE : s_LOT_IG_VALUE_1[7],
					LOT_9_IG_1_VALUE : s_LOT_IG_VALUE_1[8],
					LOT_10_IG_1_VALUE : s_LOT_IG_VALUE_1[9],
					LOT_11_IG_1_VALUE : s_LOT_IG_VALUE_1[10],
					LOT_12_IG_1_VALUE : s_LOT_IG_VALUE_1[11],
					LOT_13_IG_1_VALUE : s_LOT_IG_VALUE_1[12],
					LOT_14_IG_1_VALUE : s_LOT_IG_VALUE_1[13],
					LOT_15_IG_1_VALUE : s_LOT_IG_VALUE_1[14],
					LOT_16_IG_1_VALUE : s_LOT_IG_VALUE_1[15],
					LOT_17_IG_1_VALUE : s_LOT_IG_VALUE_1[16],
					LOT_18_IG_1_VALUE : s_LOT_IG_VALUE_1[17],
					LOT_19_IG_1_VALUE : s_LOT_IG_VALUE_1[18],
					LOT_20_IG_1_VALUE : s_LOT_IG_VALUE_1[19],
					LOT_21_IG_1_VALUE : s_LOT_IG_VALUE_1[20],
					LOT_22_IG_1_VALUE : s_LOT_IG_VALUE_1[21],
					LOT_23_IG_1_VALUE : 0,
					LOT_24_IG_1_VALUE : 0,
					LOT_25_IG_1_VALUE : 0,
					LOT_26_IG_1_VALUE : 0,
					LOT_27_IG_1_VALUE : 0,
					LOT_28_IG_1_VALUE : 0,
					LOT_29_IG_1_VALUE : 0,
					LOT_30_IG_1_VALUE : 0,

					LOT_1_IG_2_VALUE : s_LOT_IG_VALUE_2[0],
					LOT_2_IG_2_VALUE : s_LOT_IG_VALUE_2[1],
					LOT_3_IG_2_VALUE : s_LOT_IG_VALUE_2[2],
					LOT_4_IG_2_VALUE : s_LOT_IG_VALUE_2[3],
					LOT_5_IG_2_VALUE : s_LOT_IG_VALUE_2[4],
					LOT_6_IG_2_VALUE : s_LOT_IG_VALUE_2[5],
					LOT_7_IG_2_VALUE : s_LOT_IG_VALUE_2[6],
					LOT_8_IG_2_VALUE : s_LOT_IG_VALUE_2[7],
					LOT_9_IG_2_VALUE : s_LOT_IG_VALUE_2[8],
					LOT_10_IG_2_VALUE : s_LOT_IG_VALUE_2[9],
					LOT_11_IG_2_VALUE : s_LOT_IG_VALUE_2[10],
					LOT_12_IG_2_VALUE : s_LOT_IG_VALUE_2[11],
					LOT_13_IG_2_VALUE : s_LOT_IG_VALUE_2[12],
					LOT_14_IG_2_VALUE : s_LOT_IG_VALUE_2[13],
					LOT_15_IG_2_VALUE : s_LOT_IG_VALUE_2[14],
					LOT_16_IG_2_VALUE : s_LOT_IG_VALUE_2[15],
					LOT_17_IG_2_VALUE : s_LOT_IG_VALUE_2[16],
					LOT_18_IG_2_VALUE : s_LOT_IG_VALUE_2[17],
					LOT_19_IG_2_VALUE : s_LOT_IG_VALUE_2[18],
					LOT_20_IG_2_VALUE : s_LOT_IG_VALUE_2[19],
					LOT_21_IG_2_VALUE : s_LOT_IG_VALUE_2[20],
					LOT_22_IG_2_VALUE : s_LOT_IG_VALUE_2[21],
					LOT_23_IG_2_VALUE : 0,
					LOT_24_IG_2_VALUE : 0,
					LOT_25_IG_2_VALUE : 0,
					LOT_26_IG_2_VALUE : 0,
					LOT_27_IG_2_VALUE : 0,
					LOT_28_IG_2_VALUE : 0,
					LOT_29_IG_2_VALUE : 0,
					LOT_30_IG_2_VALUE : 0,

					LOT_1_IG_3_VALUE : s_LOT_IG_VALUE_3[0],
					LOT_2_IG_3_VALUE : s_LOT_IG_VALUE_3[1],
					LOT_3_IG_3_VALUE : s_LOT_IG_VALUE_3[2],
					LOT_4_IG_3_VALUE : s_LOT_IG_VALUE_3[3],
					LOT_5_IG_3_VALUE : s_LOT_IG_VALUE_3[4],
					LOT_6_IG_3_VALUE : s_LOT_IG_VALUE_3[5],
					LOT_7_IG_3_VALUE : s_LOT_IG_VALUE_3[6],
					LOT_8_IG_3_VALUE : s_LOT_IG_VALUE_3[7],
					LOT_9_IG_3_VALUE : s_LOT_IG_VALUE_3[8],
					LOT_10_IG_3_VALUE : s_LOT_IG_VALUE_3[9],
					LOT_11_IG_3_VALUE : s_LOT_IG_VALUE_3[10],
					LOT_12_IG_3_VALUE : s_LOT_IG_VALUE_3[11],
					LOT_13_IG_3_VALUE : s_LOT_IG_VALUE_3[12],
					LOT_14_IG_3_VALUE : s_LOT_IG_VALUE_3[13],
					LOT_15_IG_3_VALUE : s_LOT_IG_VALUE_3[14],
					LOT_16_IG_3_VALUE : s_LOT_IG_VALUE_3[15],
					LOT_17_IG_3_VALUE : s_LOT_IG_VALUE_3[16],
					LOT_18_IG_3_VALUE : s_LOT_IG_VALUE_3[17],
					LOT_19_IG_3_VALUE : s_LOT_IG_VALUE_3[18],
					LOT_20_IG_3_VALUE : s_LOT_IG_VALUE_3[19],
					LOT_21_IG_3_VALUE : s_LOT_IG_VALUE_3[20],
					LOT_22_IG_3_VALUE : s_LOT_IG_VALUE_3[21],
					LOT_23_IG_3_VALUE : 0,
					LOT_24_IG_3_VALUE : 0,
					LOT_25_IG_3_VALUE : 0,
					LOT_26_IG_3_VALUE : 0,
					LOT_27_IG_3_VALUE : 0,
					LOT_28_IG_3_VALUE : 0,
					LOT_29_IG_3_VALUE : 0,
					LOT_30_IG_3_VALUE : 0,

					LOT_1_IG_4_VALUE : s_LOT_IG_VALUE_4[0],
					LOT_2_IG_4_VALUE : s_LOT_IG_VALUE_4[1],
					LOT_3_IG_4_VALUE : s_LOT_IG_VALUE_4[2],
					LOT_4_IG_4_VALUE : s_LOT_IG_VALUE_4[3],
					LOT_5_IG_4_VALUE : s_LOT_IG_VALUE_4[4],
					LOT_6_IG_4_VALUE : s_LOT_IG_VALUE_4[5],
					LOT_7_IG_4_VALUE : s_LOT_IG_VALUE_4[6],
					LOT_8_IG_4_VALUE : s_LOT_IG_VALUE_4[7],
					LOT_9_IG_4_VALUE : s_LOT_IG_VALUE_4[8],
					LOT_10_IG_4_VALUE : s_LOT_IG_VALUE_4[9],
					LOT_11_IG_4_VALUE : s_LOT_IG_VALUE_4[10],
					LOT_12_IG_4_VALUE : s_LOT_IG_VALUE_4[11],
					LOT_13_IG_4_VALUE : s_LOT_IG_VALUE_4[12],
					LOT_14_IG_4_VALUE : s_LOT_IG_VALUE_4[13],
					LOT_15_IG_4_VALUE : s_LOT_IG_VALUE_4[14],
					LOT_16_IG_4_VALUE : s_LOT_IG_VALUE_4[15],
					LOT_17_IG_4_VALUE : s_LOT_IG_VALUE_4[16],
					LOT_18_IG_4_VALUE : s_LOT_IG_VALUE_4[17],
					LOT_19_IG_4_VALUE : s_LOT_IG_VALUE_4[18],
					LOT_20_IG_4_VALUE : s_LOT_IG_VALUE_4[19],
					LOT_21_IG_4_VALUE : s_LOT_IG_VALUE_4[20],
					LOT_22_IG_4_VALUE : s_LOT_IG_VALUE_4[21],
					LOT_23_IG_4_VALUE : 0,
					LOT_24_IG_4_VALUE : 0,
					LOT_25_IG_4_VALUE : 0,
					LOT_26_IG_4_VALUE : 0,
					LOT_27_IG_4_VALUE : 0,
					LOT_28_IG_4_VALUE : 0,
					LOT_29_IG_4_VALUE : 0,
					LOT_30_IG_4_VALUE : 0,

					LOT_COUNT : l_LOT_COUNT,
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

					IMPORT_NO : '',
					PO_NO : '',
					DISCHARGING_RATE : 0.0,
					DEM_DES : 0.0,
					WMT : 0.0,
					MOISTURE : 0.0,

					ASSAY_LIMIT_IG_1 : "YPIG-0001",
					ASSAY_LIMIT_AMT_1 : 0.0,
					ASSAY_LIMIT_UNIT_1 : "%",
					ASSAY_LIMIT_IG_2 : "YPIG-0007",
					ASSAY_LIMIT_AMT_2 : 0.0,
					ASSAY_LIMIT_UNIT_2 : "g/t",
					ASSAY_LIMIT_IG_3 : "YPIG-0031",
					ASSAY_LIMIT_AMT_3 : 0.0,
					ASSAY_LIMIT_UNIT_3 : "g/t",
					ASSAY_LIMIT_IG_4 : "YPIG-0016",
					ASSAY_LIMIT_AMT_4 : 0.0,
					ASSAY_LIMIT_UNIT_4 : "%",
					ASSAY_LIMIT_IG_5 : "YPIG-0023",
					ASSAY_LIMIT_AMT_5 : 0.0,
					ASSAY_LIMIT_UNIT_5 : "%",
					ASSAY_LIMIT_IG_6 : "YPIG-0018",
					ASSAY_LIMIT_AMT_6 : 0.0,
					ASSAY_LIMIT_UNIT_6 : "ppm",
					ASSAY_LIMIT_IG_7 : "YPIG-0032",
					ASSAY_LIMIT_AMT_7 : 0.0,
					ASSAY_LIMIT_UNIT_7 : "ppm",
					ASSAY_LIMIT_IG_8 : "YPIG-0013",
					ASSAY_LIMIT_AMT_8 : 0.0,
					ASSAY_LIMIT_UNIT_8 : "%",
					ASSAY_LIMIT_IG_9 : "YPIG-0014",
					ASSAY_LIMIT_AMT_9 : 0.0,
					ASSAY_LIMIT_UNIT_9 : "ppm",
					ASSAY_LIMIT_IG_10 : "YPIG-0008",
					ASSAY_LIMIT_AMT_10 : 0.0,
					ASSAY_LIMIT_UNIT_10 : "%",
					ASSAY_LIMIT_IG1_11 : "YPIG-0010",
					ASSAY_LIMIT_AMT_11 : 0.0,
					ASSAY_LIMIT_UNIT_11 : "%",
					ASSAY_LIMIT_IG_12 : "",
					ASSAY_LIMIT_AMT_12 : 0.0,
					ASSAY_LIMIT_UNIT_12 : "",
					QP : "",
					SURVEYOR : "",
					LC_NO : "",
					CLEARANCE_DATE : "",
					AMOUNT_DECISION : "",
					UNLOADING : "",
					IMPORT_STORAGE : "",
					DOCK_NO : "",
					SPECIAL_SCHEDULE : "",

					CPS_IG_1 : s_CPS_IG[0],
					CPS_IG_2 : s_CPS_IG[1],
					CPS_IG_3 : s_CPS_IG[2],
					CPS_IG_4 : s_CPS_IG[3],
					CPS_IG_5 : s_CPS_IG[4],

					_csrf : '${_csrf.token}'
					},
				dataType : "json",
				success : function(result) {
					opener.load_bl_grid();
					opener.parent.swalSuccess("저장 되었습니다.");
					opener.sel_prv_idx();

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

		function
		getIgName(ig_code)
		{
			for(var i = 0;i < l_IG_CODE.length;i ++)
			{
				if(l_IG_CODE[i] == ig_code) return l_IG_NAME[i];
			}

			return "";
		}

		function set_Value() {
			//	console.log('${req_data.MATERIAL_ID}', '${req_data.SELLER_ID}', '${req_data.IMPORT_DATE}');

			l_MASTER_ID = '${req_data.MASTER_ID}';

			s_MATERIAL_ID = '${req_data.MATERIAL_ID}';
			s_SHEET_ID = '${req_data.SHEET_ID}';
			s_SELLER_ID = '${req_data.SELLER_ID}';
			s_IMPORT_DATE = '${req_data.IMPORT_DATE}';

			set_NS("sel_MATERIAL_ID", s_MATERIAL_ID);
			set_NS("sel_SELLER_ID", s_SELLER_ID);
			set_NS("cal_IMPORT_DATE", s_IMPORT_DATE);
			set_NS("sel_SHEET_ID", s_SHEET_ID);

			l_INGREDIENT_CNT = 3;
			l_INGREDIENT_ID[0] = s_LBL_IG_1;
			l_INGREDIENT_ID[1] = s_LBL_IG_2;
			l_INGREDIENT_ID[2] = s_LBL_IG_3;
			l_INGREDIENT_ID[3] = s_LBL_IG_4;
			l_INGREDIENT_NAME[0] = 'Zn';
			l_INGREDIENT_NAME[1] = 'Ag';
			l_INGREDIENT_NAME[2] = 'Au';
			l_INGREDIENT_NAME[3] = '';
			
			set_NS('sel_LBL_IG_1', 'YPIG-0001');
			set_NS('sel_LBL_IG_2', 'YPIG-0007');
			set_NS('sel_LBL_IG_3', 'YPIG-0031');
			set_NS('sel_LBL_IG_4', '');

			for(var i = 0;i < 30;i ++)
			{
				for(var j = 0;j < 6;j ++) l_Edited_Val[i][j] = 0;
			}

			for (var si = 0; si < 22; si++) {
				s_LOT_IG_VALUE_1[si] = 0;
				s_LOT_IG_VALUE_2[si] = 0;
				s_LOT_IG_VALUE_3[si] = 0;
				s_LOT_IG_VALUE_4[si] = 0;
			}

			for(var si = 0;si < 30;si ++) {
				l_WMT_Val[si] = 0;
				l_MOISTURE_Val[si] = 0;
				l_DMT_Val[si] = 0;
			}
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
				url : "/yp/zpp/ore/zpp_ore_req_bl_info2",
				type : "POST",
			    cache:false,
			    async:true, 
				data : {
					MASTER_ID : l_MASTER_ID,
					_csrf : '${_csrf.token}'
					},
				dataType : "json",
				success : function(result) {
					//	console.log("/yp/zpp/ore/zpp_ore_req_bl_info2 success : " + result.data_count);

					if(result.data_count > 0) {
						//	UPDATE MODE
						l_EditMode = 2;

						//	console.log(result.data);

						document.getElementById("sel_MATERIAL_ID").disabled = true;
						document.getElementById("sel_SELLER_ID").disabled = true;
						document.getElementById("cal_IMPORT_DATE").disabled = true;
						document.getElementById("sel_SHEET_ID").disabled = true;

						document.getElementById("sel_LBL_IG_1").disabled = true;
						document.getElementById("sel_LBL_IG_2").disabled = true;
						document.getElementById("sel_LBL_IG_3").disabled = true;
						document.getElementById("sel_LBL_IG_4").disabled = true;

						f_DMT = result.data.DMT;

						s_VESSEL_NAME = result.data.VESSEL_NAME;

						l_LOT_COUNT = result.data.LOT_COUNT;

						s_LBL_IG_1 = result.data.LBL_IG_1;
						s_LBL_IG_2 = result.data.LBL_IG_2;
						s_LBL_IG_3 = result.data.LBL_IG_3;
						s_LBL_IG_4 = result.data.LBL_IG_4;

						l_INGREDIENT_ID[0] = s_LBL_IG_1;
						l_INGREDIENT_NAME[0] = getIgName(s_LBL_IG_1);
						l_INGREDIENT_ID[1] = s_LBL_IG_2;
						l_INGREDIENT_NAME[1] = getIgName(s_LBL_IG_2);
						l_INGREDIENT_ID[2] = s_LBL_IG_3;
						l_INGREDIENT_NAME[2] = getIgName(s_LBL_IG_3);
						l_INGREDIENT_ID[3] = s_LBL_IG_4;
						l_INGREDIENT_NAME[3] = getIgName(s_LBL_IG_4);

						if(s_LBL_IG_4 == "")
						{
							if(s_LBL_IG_3 == "")
							{
								l_INGREDIENT_CNT = 2;
							}
							else
							{
								l_INGREDIENT_CNT = 3;
							}
						}
						else l_INGREDIENT_CNT = 4;

						s_CPS_IG[0] = result.data.CPS_IG_1;
						s_CPS_IG[1] = result.data.CPS_IG_2;
						s_CPS_IG[2] = result.data.CPS_IG_3;
						s_CPS_IG[3] = result.data.CPS_IG_4;
						s_CPS_IG[4] = result.data.CPS_IG_5;

						s_IG_CODE[ 0] = result.data.IG_CODE_1;
						s_IG_CODE[ 1] = result.data.IG_CODE_2;
						s_IG_CODE[ 2] = result.data.IG_CODE_3;
						s_IG_CODE[ 3] = result.data.IG_CODE_4;
						s_IG_CODE[ 4] = result.data.IG_CODE_5;
						s_IG_CODE[ 5] = result.data.IG_CODE_6;
						s_IG_CODE[ 6] = result.data.IG_CODE_7;
						s_IG_CODE[ 7] = result.data.IG_CODE_8;
						s_IG_CODE[ 8] = result.data.IG_CODE_9;
						s_IG_CODE[ 9] = result.data.IG_CODE_10;
						s_IG_CODE[10] = result.data.IG_CODE_11;
						s_IG_CODE[11] = result.data.IG_CODE_12;
						s_IG_CODE[12] = result.data.IG_CODE_13;
						s_IG_CODE[13] = result.data.IG_CODE_14;
						s_IG_CODE[14] = result.data.IG_CODE_15;
						s_IG_CODE[15] = result.data.IG_CODE_16;
						s_IG_CODE[16] = result.data.IG_CODE_17;
						s_IG_CODE[17] = result.data.IG_CODE_18;
						s_IG_CODE[18] = result.data.IG_CODE_19;
						s_IG_CODE[19] = result.data.IG_CODE_20;
						s_IG_CODE[20] = result.data.IG_CODE_21;
						s_IG_CODE[21] = result.data.IG_CODE_22;
						s_IG_CODE[22] = result.data.IG_CODE_23;
						s_IG_CODE[23] = result.data.IG_CODE_24;
						s_IG_CODE[24] = result.data.IG_CODE_25;
						s_IG_CODE[25] = result.data.IG_CODE_26;
						s_IG_CODE[26] = result.data.IG_CODE_27;
						s_IG_CODE[27] = result.data.IG_CODE_28;
						s_IG_CODE[28] = result.data.IG_CODE_29;
						s_IG_CODE[29] = result.data.IG_CODE_30;
						s_IG_CODE[30] = result.data.IG_CODE_31;

						s_IG_VALUE[ 0] = result.data.IG_VALUE_1;
						s_IG_VALUE[ 1] = result.data.IG_VALUE_2;
						s_IG_VALUE[ 2] = result.data.IG_VALUE_3;
						s_IG_VALUE[ 3] = result.data.IG_VALUE_4;
						s_IG_VALUE[ 4] = result.data.IG_VALUE_5;
						s_IG_VALUE[ 5] = result.data.IG_VALUE_6;
						s_IG_VALUE[ 6] = result.data.IG_VALUE_7;
						s_IG_VALUE[ 7] = result.data.IG_VALUE_8;
						s_IG_VALUE[ 8] = result.data.IG_VALUE_9;
						s_IG_VALUE[ 9] = result.data.IG_VALUE_10;
						s_IG_VALUE[10] = result.data.IG_VALUE_11;
						s_IG_VALUE[11] = result.data.IG_VALUE_12;
						s_IG_VALUE[12] = result.data.IG_VALUE_13;
						s_IG_VALUE[13] = result.data.IG_VALUE_14;
						s_IG_VALUE[14] = result.data.IG_VALUE_15;
						s_IG_VALUE[15] = result.data.IG_VALUE_16;
						s_IG_VALUE[16] = result.data.IG_VALUE_17;
						s_IG_VALUE[17] = result.data.IG_VALUE_18;
						s_IG_VALUE[18] = result.data.IG_VALUE_19;
						s_IG_VALUE[19] = result.data.IG_VALUE_20;
						s_IG_VALUE[20] = result.data.IG_VALUE_21;
						s_IG_VALUE[21] = result.data.IG_VALUE_22;
						s_IG_VALUE[22] = result.data.IG_VALUE_23;
						s_IG_VALUE[23] = result.data.IG_VALUE_24;
						s_IG_VALUE[24] = result.data.IG_VALUE_25;
						s_IG_VALUE[25] = result.data.IG_VALUE_26;
						s_IG_VALUE[26] = result.data.IG_VALUE_27;
						s_IG_VALUE[27] = result.data.IG_VALUE_28;
						s_IG_VALUE[28] = result.data.IG_VALUE_29;
						s_IG_VALUE[29] = result.data.IG_VALUE_30;
						s_IG_VALUE[30] = result.data.IG_VALUE_31;

						s_PM_100_VALUE = result.data.PM_100_VALUE;
						s_PM_200_VALUE = result.data.PM_200_VALUE;
						s_PM_325_VALUE = result.data.PM_325_VALUE;
						s_PM_400_VALUE = result.data.PM_400_VALUE;
						s_PM_M400_VALUE = result.data.PM_M400_VALUE;

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

						s_LOT_IG_VALUE_1[ 0] = result.data.LOT_1_IG_1_VALUE;
						s_LOT_IG_VALUE_1[ 1] = result.data.LOT_2_IG_1_VALUE;
						s_LOT_IG_VALUE_1[ 2] = result.data.LOT_3_IG_1_VALUE;
						s_LOT_IG_VALUE_1[ 3] = result.data.LOT_4_IG_1_VALUE;
						s_LOT_IG_VALUE_1[ 4] = result.data.LOT_5_IG_1_VALUE;
						s_LOT_IG_VALUE_1[ 5] = result.data.LOT_6_IG_1_VALUE;
						s_LOT_IG_VALUE_1[ 6] = result.data.LOT_7_IG_1_VALUE;
						s_LOT_IG_VALUE_1[ 7] = result.data.LOT_8_IG_1_VALUE;
						s_LOT_IG_VALUE_1[ 8] = result.data.LOT_9_IG_1_VALUE;
						s_LOT_IG_VALUE_1[ 9] = result.data.LOT_10_IG_1_VALUE;
						s_LOT_IG_VALUE_1[10] = result.data.LOT_11_IG_1_VALUE;
						s_LOT_IG_VALUE_1[11] = result.data.LOT_12_IG_1_VALUE;
						s_LOT_IG_VALUE_1[12] = result.data.LOT_13_IG_1_VALUE;
						s_LOT_IG_VALUE_1[13] = result.data.LOT_14_IG_1_VALUE;
						s_LOT_IG_VALUE_1[14] = result.data.LOT_15_IG_1_VALUE;
						s_LOT_IG_VALUE_1[15] = result.data.LOT_16_IG_1_VALUE;
						s_LOT_IG_VALUE_1[16] = result.data.LOT_17_IG_1_VALUE;
						s_LOT_IG_VALUE_1[17] = result.data.LOT_18_IG_1_VALUE;
						s_LOT_IG_VALUE_1[18] = result.data.LOT_19_IG_1_VALUE;
						s_LOT_IG_VALUE_1[19] = result.data.LOT_20_IG_1_VALUE;
						s_LOT_IG_VALUE_1[20] = result.data.LOT_21_IG_1_VALUE;
						s_LOT_IG_VALUE_1[21] = result.data.LOT_22_IG_1_VALUE;
						s_LOT_IG_VALUE_1[22] = 0;
						s_LOT_IG_VALUE_1[23] = 0;
						s_LOT_IG_VALUE_1[24] = 0;
						s_LOT_IG_VALUE_1[25] = 0;
						s_LOT_IG_VALUE_1[26] = 0;
						s_LOT_IG_VALUE_1[27] = 0;
						s_LOT_IG_VALUE_1[28] = 0;
						s_LOT_IG_VALUE_1[29] = 0;

						s_LOT_IG_VALUE_2[ 0] = result.data.LOT_1_IG_2_VALUE;
						s_LOT_IG_VALUE_2[ 1] = result.data.LOT_2_IG_2_VALUE;
						s_LOT_IG_VALUE_2[ 2] = result.data.LOT_3_IG_2_VALUE;
						s_LOT_IG_VALUE_2[ 3] = result.data.LOT_4_IG_2_VALUE;
						s_LOT_IG_VALUE_2[ 4] = result.data.LOT_5_IG_2_VALUE;
						s_LOT_IG_VALUE_2[ 5] = result.data.LOT_6_IG_2_VALUE;
						s_LOT_IG_VALUE_2[ 6] = result.data.LOT_7_IG_2_VALUE;
						s_LOT_IG_VALUE_2[ 7] = result.data.LOT_8_IG_2_VALUE;
						s_LOT_IG_VALUE_2[ 8] = result.data.LOT_9_IG_2_VALUE;
						s_LOT_IG_VALUE_2[ 9] = result.data.LOT_10_IG_2_VALUE;
						s_LOT_IG_VALUE_2[10] = result.data.LOT_11_IG_2_VALUE;
						s_LOT_IG_VALUE_2[11] = result.data.LOT_12_IG_2_VALUE;
						s_LOT_IG_VALUE_2[12] = result.data.LOT_13_IG_2_VALUE;
						s_LOT_IG_VALUE_2[13] = result.data.LOT_14_IG_2_VALUE;
						s_LOT_IG_VALUE_2[14] = result.data.LOT_15_IG_2_VALUE;
						s_LOT_IG_VALUE_2[15] = result.data.LOT_16_IG_2_VALUE;
						s_LOT_IG_VALUE_2[16] = result.data.LOT_17_IG_2_VALUE;
						s_LOT_IG_VALUE_2[17] = result.data.LOT_18_IG_2_VALUE;
						s_LOT_IG_VALUE_2[18] = result.data.LOT_19_IG_2_VALUE;
						s_LOT_IG_VALUE_2[19] = result.data.LOT_20_IG_2_VALUE;
						s_LOT_IG_VALUE_2[20] = result.data.LOT_21_IG_2_VALUE;
						s_LOT_IG_VALUE_2[21] = result.data.LOT_22_IG_2_VALUE;
						s_LOT_IG_VALUE_2[22] = 0;
						s_LOT_IG_VALUE_2[23] = 0;
						s_LOT_IG_VALUE_2[24] = 0;
						s_LOT_IG_VALUE_2[25] = 0;
						s_LOT_IG_VALUE_2[26] = 0;
						s_LOT_IG_VALUE_2[27] = 0;
						s_LOT_IG_VALUE_2[28] = 0;
						s_LOT_IG_VALUE_2[29] = 0;

						s_LOT_IG_VALUE_3[ 0] = result.data.LOT_1_IG_3_VALUE;
						s_LOT_IG_VALUE_3[ 1] = result.data.LOT_2_IG_3_VALUE;
						s_LOT_IG_VALUE_3[ 2] = result.data.LOT_3_IG_3_VALUE;
						s_LOT_IG_VALUE_3[ 3] = result.data.LOT_4_IG_3_VALUE;
						s_LOT_IG_VALUE_3[ 4] = result.data.LOT_5_IG_3_VALUE;
						s_LOT_IG_VALUE_3[ 5] = result.data.LOT_6_IG_3_VALUE;
						s_LOT_IG_VALUE_3[ 6] = result.data.LOT_7_IG_3_VALUE;
						s_LOT_IG_VALUE_3[ 7] = result.data.LOT_8_IG_3_VALUE;
						s_LOT_IG_VALUE_3[ 8] = result.data.LOT_9_IG_3_VALUE;
						s_LOT_IG_VALUE_3[ 9] = result.data.LOT_10_IG_3_VALUE;
						s_LOT_IG_VALUE_3[10] = result.data.LOT_11_IG_3_VALUE;
						s_LOT_IG_VALUE_3[11] = result.data.LOT_12_IG_3_VALUE;
						s_LOT_IG_VALUE_3[12] = result.data.LOT_13_IG_3_VALUE;
						s_LOT_IG_VALUE_3[13] = result.data.LOT_14_IG_3_VALUE;
						s_LOT_IG_VALUE_3[14] = result.data.LOT_15_IG_3_VALUE;
						s_LOT_IG_VALUE_3[15] = result.data.LOT_16_IG_3_VALUE;
						s_LOT_IG_VALUE_3[16] = result.data.LOT_17_IG_3_VALUE;
						s_LOT_IG_VALUE_3[17] = result.data.LOT_18_IG_3_VALUE;
						s_LOT_IG_VALUE_3[18] = result.data.LOT_19_IG_3_VALUE;
						s_LOT_IG_VALUE_3[19] = result.data.LOT_20_IG_3_VALUE;
						s_LOT_IG_VALUE_3[20] = result.data.LOT_21_IG_3_VALUE;
						s_LOT_IG_VALUE_3[21] = result.data.LOT_22_IG_3_VALUE;
						s_LOT_IG_VALUE_3[22] = 0;
						s_LOT_IG_VALUE_3[23] = 0;
						s_LOT_IG_VALUE_3[24] = 0;
						s_LOT_IG_VALUE_3[25] = 0;
						s_LOT_IG_VALUE_3[26] = 0;
						s_LOT_IG_VALUE_3[27] = 0;
						s_LOT_IG_VALUE_3[28] = 0;
						s_LOT_IG_VALUE_3[29] = 0;

						s_LOT_IG_VALUE_4[ 0] = result.data.LOT_1_IG_4_VALUE;
						s_LOT_IG_VALUE_4[ 1] = result.data.LOT_2_IG_4_VALUE;
						s_LOT_IG_VALUE_4[ 2] = result.data.LOT_3_IG_4_VALUE;
						s_LOT_IG_VALUE_4[ 3] = result.data.LOT_4_IG_4_VALUE;
						s_LOT_IG_VALUE_4[ 4] = result.data.LOT_5_IG_4_VALUE;
						s_LOT_IG_VALUE_4[ 5] = result.data.LOT_6_IG_4_VALUE;
						s_LOT_IG_VALUE_4[ 6] = result.data.LOT_7_IG_4_VALUE;
						s_LOT_IG_VALUE_4[ 7] = result.data.LOT_8_IG_4_VALUE;
						s_LOT_IG_VALUE_4[ 8] = result.data.LOT_9_IG_4_VALUE;
						s_LOT_IG_VALUE_4[ 9] = result.data.LOT_10_IG_4_VALUE;
						s_LOT_IG_VALUE_4[10] = result.data.LOT_11_IG_4_VALUE;
						s_LOT_IG_VALUE_4[11] = result.data.LOT_12_IG_4_VALUE;
						s_LOT_IG_VALUE_4[12] = result.data.LOT_13_IG_4_VALUE;
						s_LOT_IG_VALUE_4[13] = result.data.LOT_14_IG_4_VALUE;
						s_LOT_IG_VALUE_4[14] = result.data.LOT_15_IG_4_VALUE;
						s_LOT_IG_VALUE_4[15] = result.data.LOT_16_IG_4_VALUE;
						s_LOT_IG_VALUE_4[16] = result.data.LOT_17_IG_4_VALUE;
						s_LOT_IG_VALUE_4[17] = result.data.LOT_18_IG_4_VALUE;
						s_LOT_IG_VALUE_4[18] = result.data.LOT_19_IG_4_VALUE;
						s_LOT_IG_VALUE_4[19] = result.data.LOT_20_IG_4_VALUE;
						s_LOT_IG_VALUE_4[20] = result.data.LOT_21_IG_4_VALUE;
						s_LOT_IG_VALUE_4[21] = result.data.LOT_22_IG_4_VALUE;
						s_LOT_IG_VALUE_4[22] = 0;
						s_LOT_IG_VALUE_4[23] = 0;
						s_LOT_IG_VALUE_4[24] = 0;
						s_LOT_IG_VALUE_4[25] = 0;
						s_LOT_IG_VALUE_4[26] = 0;
						s_LOT_IG_VALUE_4[27] = 0;
						s_LOT_IG_VALUE_4[28] = 0;
						s_LOT_IG_VALUE_4[29] = 0;

						//	console.log(l_DMT_Val[ 0], l_DMT_Val[ 1], l_DMT_Val[ 2]);
					}
					else {
						//	INSERT MODE
						l_EditMode = 1;

						f_DMT = 0.0;
						s_LBL_IG_1 = "YPIG-0001";
						s_LBL_IG_2 = "YPIG-0007";
						s_LBL_IG_3 = "YPIG-0031";
						s_LBL_IG_4 = "YPIG-0023";

						set_NS('sel_SHEET_ID', '0');
					}

					if(l_EditMode == 2) display_bl_info();
					else
					{
						set_NS("sel_LC", l_LOT_COUNT);
						setLotCountTable(l_LOT_COUNT);
					}

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

		function display_mt_info() {
			document.getElementById("sel_LC").value = l_LOT_COUNT;

			var fn = "";

			for(var si = 0;si < l_LOT_COUNT;si ++) {
				fn = "input_" + (si + 1).toString() + "_1";
				set_NS(fn,  l_DMT_Val[si]);
			}
		}

		function
		changeLotCount(){  
			var countSel = document.getElementById("sel_LC");  
			var lotCount = countSel.options[countSel.selectedIndex].value;

			l_LOT_COUNT = lotCount;

			setLotCountTable(lotCount);
			display_mt_info();
		}

		function
		changeIG_1(){  
			var igSel = document.getElementById("sel_LBL_IG_1");  
			var igIdx = igSel.options[igSel.selectedIndex].value;

			l_INGREDIENT_ID[0] = igIdx;
			l_INGREDIENT_NAME[0] = getIgName(igIdx);

			setLotCountTable(l_LOT_COUNT);
			display_mt_info();
		}

		function
		changeIG_2(){  
			var igSel = document.getElementById("sel_LBL_IG_2");  
			var igIdx = igSel.options[igSel.selectedIndex].value;

			l_INGREDIENT_ID[1] = igIdx;
			l_INGREDIENT_NAME[1] = getIgName(igIdx);

			setLotCountTable(l_LOT_COUNT);
			display_mt_info();
		}

		function
		changeIG_3(){
			var igSel = document.getElementById("sel_LBL_IG_3");  
			var igIdx = igSel.options[igSel.selectedIndex].value;

			l_INGREDIENT_ID[2] = igIdx;
			l_INGREDIENT_NAME[2] = getIgName(igIdx);

			setLotCountTable(l_LOT_COUNT);
			display_mt_info();
		}

		function
		changeIG_4(){
			var igSel = document.getElementById("sel_LBL_IG_4");  
			var igIdx = igSel.options[igSel.selectedIndex].value;

			if(igSel.selectedIndex == 0)
			{
				l_INGREDIENT_CNT = 3;
				l_INGREDIENT_ID[3] = "";
				l_INGREDIENT_NAME[3] = "";
			}
			else
			{
				l_INGREDIENT_CNT = 4;
				l_INGREDIENT_ID[3] = igIdx;
				l_INGREDIENT_NAME[3] = getIgName(igIdx);
			}

			setLotCountTable(l_LOT_COUNT);
			display_mt_info();
		}

		function AddColumn(row, contents) {
			var table_data = document.createElement('td');

			table_data.innerHTML = contents;
			row.appendChild(table_data);
		}

		function setLotCountTable(lotCount) {
			var table = document.getElementById('table_2');
			var col_count = table.rows[0].cells.length;
			var row_count = table.rows.length;

			for(var i = 1;i < row_count;i ++)
			{
				var fn = "input_" + (i).toString() + "_1";
				l_Edited_Val[i][1] = get_NS(fn);
				l_DMT_Val[i - 1] = get_NS(fn);

				for(var ac = 2;ac < col_count;ac ++) {
					var cn = "edt_LOT_" + (i).toString() + "_IG_" + (ac - 1).toString() + "_VALUE";

					l_Edited_Val[i][ac] = get_NS(cn);
				}
			}

			for (var ri = 0; ri < row_count; ri ++) table.deleteRow(0);

			var row1 = document.createElement('tr');

			AddColumn(row1, 'Lot');
			AddColumn(row1, 'Dry Weight(M/T)');

			//	console.log('l_INGREDIENT_CNT : ' + l_INGREDIENT_CNT);

			for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++) {
				AddColumn(row1, l_INGREDIENT_NAME[ac] + '(%)');
			}

			table.appendChild(row1);

			for (var i = 0; i < lotCount; i++) {
				idx = Number(i) + 1;

				var table_row = document.createElement('tr');
				var cn1  = "input_" + (idx).toString() + "_1";

				AddColumn(table_row, idx);
				AddColumn(table_row, '<input type="number" id="' + cn1 + '" size="20" maxlength="6" oninput="numberMaxLength(this);" style="width:90px; height:20px; border:1;">');

				for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++) {
					var cn = "edt_LOT_" + (idx).toString() + "_IG_" + (ac + 1).toString() + "_VALUE";

					AddColumn(table_row, '<input type="number" id="' + cn + '" maxlength="6" oninput="numberMaxLength(this);" style="width:90px;"">');
				}

				table.appendChild(table_row);
			}

			var col_count = table.rows[0].cells.length;
			var row_count = table.rows.length;

			for(var i = 1;i < row_count;i ++)
			{
				var fn = "input_" + (i).toString() + "_1";
				if(l_Edited_Val[i][1] === undefined)
				{
					//	console.log('정의되지 않음');
					l_Edited_Val[i][1] = 0;
				}
				set_NS(fn, l_Edited_Val[i][1]);

				for(var ac = 2;ac < col_count;ac ++) {
					var cn = "edt_LOT_" + (i).toString() + "_IG_" + (ac - 1).toString() + "_VALUE";

					if(l_Edited_Val[i][ac] === undefined) l_Edited_Val[i][ac] = 0;
					set_NS(cn, l_Edited_Val[i][ac]);
				}
			}
		}

		$(document).ready(function() {
			getMaterialList();
			getSellerList();
			getIGList();

			set_Value();
			load_bl_info();
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

						l_IG_CODE[i] = ig_id;
						l_IG_NAME[i] = ig_name;
					}
				},
				error : function(request, status, error) {
					//	console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
				}
			});
		}

		opener.popup = this;
	</script>
</body>
</html>