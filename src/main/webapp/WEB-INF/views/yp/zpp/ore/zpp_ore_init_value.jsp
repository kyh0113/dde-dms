<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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
<title>정광 성분분석 결과 초기값 등록</title>
<script src="/resources/icm/js/jquery.js"></script>
<script src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
<script src="/resources/icm/js/custom.js"></script>
<!-- 기존 프레임워크 리소스 -->
<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="/resources/icm/css/jquery-ui.css" />
<!-- 2019-12-13 smh jquery-ui.css 변경.끝 -->
<link href='/resources/icm/css/animate.min.css' rel='stylesheet'>
<link rel="stylesheet" type="text/css" href="/resources/css/custom.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/all.min.css" />
<link rel="stylesheet"
	href="/resources/icm/jsTree/dist/themes/default/style.min.css" />
<link href="/resources/icm/datepicker/css/datepicker.css"
	rel="stylesheet" type="text/css" />
<link id="bs-css" href="/resources/icm/css/bootstrap.min.css"
	rel="stylesheet">
<!-- jQuery -->
<script src="/resources/icm/js/jquery.js"></script>
<script src="/resources/icm/js/jquery.validate.min.js"></script>
<script src="/resources/icm/js/jquery-ui.js"></script>
<script src="/resources/icm/jsTree/dist/jstree.min.js"></script>
<script src="/resources/icm/jsTree/dist/customJstree.js"></script>
<link rel="stylesheet" href="/resources/icm/uigrid/css/ui-grid.min.css"
	type="text/css">
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
.ui-grid-header-cell {
	text-align: center !important;
}

.ui-grid-header-cell-label.ng-binding {
	margin-left: 1.2em;
}

.ui-grid-viewport {
	overflow-x: hidden !important;
}
</style>
</head>
<body data-ng-app="app">
	<style>
table {
	border: 1px solid #111111;
}

td {
	border: 1px solid #000000;
}

.name_cell {
	font-size: 1.0rem;
	color: blue;
	text-align: center;
	vertical-align: middle;
}

.name_cell_s {
	font-size: 1.0rem;
	color: blue;
	text-align: center;
	vertical-align: middle;
}

.contents_cell {
	font-size: 1.0rem;
	color: blue;
	text-align: center;
	vertical-align: middle;
	background-color: #D9E5FF;
	font-weight: bold;
}

.editable_bg {
	font-size: 1.5rem;
	color: white;
	text-align: center;
	vertical-align: middle;
	background-color: #588CFC;
	font-weight: bold;
}

.edit_cell {
	font-size: 1.5rem;
	width: 100%;
	color: white;
	text-align: center;
	vertical-align: middle;
	background-color: #588CFC;
	font-weight: bold;
}

.tbl_def {
	height: 30px
}
</style>

	<div id="popup">
		<div class="pop_header">정광 성분분석 결과 초기값 등록</div>
		<div class="pop_content">
			<div style="float: left; width: 100%; padding: 10px">
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
							<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_MATERIAL_ID"></td>
							<th>업체명</th>
							<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_SELLER_ID"></td>
							<th>입항일자</th>
							<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IMPORT_DATE"></td>
							<th>LOT COUNT</th>
							<td><input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_LOT_COUNT"></td>
						</tr>
					</table>

					<div style="height: 15px; background-color: white"></div>

					<div class="btn_wrap">
						<button class="btn btn_search" id="register_btn" type="">초기값 등록</button>
					</div>
				</div>
				</section>
			</div>

			<div style="float: left; width: 25%; padding: 10px">
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
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_1"></td>
					</tr>
					<tr>
						<td>Fe</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_2"></td>
					</tr>
					<tr>
						<td>T.S</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_3"></td>
					</tr>
					<tr>
						<td>Pb</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_4"></td>
					</tr>
					<tr>
						<td>Cu</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_5"></td>
					</tr>
					<tr>
						<td>Cd</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_6"></td>
					</tr>
					<tr>
						<td>Ag(g/T)</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_7"></td>
					</tr>
					<tr>
						<td>MgO</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_8"></td>
					</tr>
					<tr>
						<td>CaO</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_9"></td>
					</tr>
					<tr>
						<td>Mn</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_10"></td>
					</tr>
					<tr>
						<td>Ni</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_11"></td>
					</tr>
					<tr>
						<td>Sb</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_12"></td>
					</tr>
					<tr>
						<td>As</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_13"></td>
					</tr>
					<tr>
						<td>Co</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_14"></td>
					</tr>
					<tr>
						<td>Ge</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_15"></td>
					</tr>
					<tr>
						<td>Fe</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_16"></td>
					</tr>
					<tr>
						<td>Sn</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_17"></td>
					</tr>
					<tr>
						<td>Hg</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_18"></td>
					</tr>
					<tr>
						<td>Al2So3</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_19"></td>
					</tr>
					<tr>
						<td>In(g/T)</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_20"></td>
					</tr>
					<tr>
						<td>Cr</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_21"></td>
					</tr>
					<tr>
						<td>Cl</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_22"></td>
					</tr>
					<tr>
						<td>SiO2</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_23"></td>
					</tr>
					<tr>
						<td>B</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_24"></td>
					</tr>
					<tr>
						<td>Se</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_25"></td>
					</tr>
					<tr>
						<td>Ga</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_26"></td>
					</tr>
					<tr>
						<td>Mo</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_27"></td>
					</tr>
					<tr>
						<td>Ti</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_28"></td>
					</tr>
					<tr>
						<td>Bi</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_29"></td>
					</tr>
					<tr>
						<td>K</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_30"></td>
					</tr>
					<tr>
						<td>Au(g/T)</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_IG_VALUE_31"></td>
					</tr>
				</table>
			</div>
			<div style="float: left; width: 25%; padding: 10px">
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
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_PM_100_VALUE"></td>
					</tr>
					<tr>
						<td>200</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_PM_200_VALUE"></td>
					</tr>
					<tr>
						<td>325</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_PM_325_VALUE"></td>
					</tr>
					<tr>
						<td>400</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_PM_400_VALUE"></td>
					</tr>
					<tr>
						<td>-400</td>
						<td><input type="number" maxlength="6" oninput="numberMaxLength(this);" id="edt_PM_M400_VALUE"></td>
					</tr>
				</table>
			</div>
			<div style="float: left; width: 40%; padding: 10px">
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

		var s_IG_CODE = new Array();
		var s_IG_VALUE = new Array();

		var s_IG_LIST = new Array();
		var s_LOT_IG_VALUE_1 = new Array();
		var s_LOT_IG_VALUE_2 = new Array();
		var s_LOT_IG_VALUE_3 = new Array();
		var s_LOT_IG_VALUE_4 = new Array();

		var l_INGREDIENT_CNT;
		var l_INGREDIENT_ID = new Array();
		var	l_INGREDIENT_NAME = new Array();

		var s_PM_100_VALUE = 0;
		var s_PM_200_VALUE = 0;
		var s_PM_325_VALUE = 0;
		var s_PM_400_VALUE = 0;
		var s_PM_M400_VALUE = 0;

		var s_LOT_COUNT = 0;

		//	1:INSERT, 2:UPDATE
		var l_EditMode = 1;

		function AddColumn(row, contents) {
			var table_data = document.createElement('td');

			table_data.innerHTML = contents;
			row.appendChild(table_data);
		}

		function numberMaxLength(e) {
			if(e.value.length > e.maxLength) {
				e.value = e.value.slice(0, e.maxLength);
	        }
	    }

		function setLotCountTable(lotCount) {
			var table = document.getElementById('table_3');
			var row_count = table.rows.length;

			for (var ri = 0; ri < row_count; ri++)
				table.deleteRow(0);

			var row1 = document.createElement('tr');

			AddColumn(row1, 'Lot');

			for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++) {
				AddColumn(row1, l_INGREDIENT_NAME[ac] + '(%)');
			}

			table.appendChild(row1);

			for (var i = 0; i < lotCount; i++) {
				idx = Number(i) + 1;

				var table_row = document.createElement('tr');

				AddColumn(table_row, idx);

				for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++) {
					var cn = "edt_LOT_" + (idx).toString() + "_IG_" + (ac + 1).toString() + "_VALUE";

					//	console.log(cn);

					AddColumn(table_row, '<input type="number" maxlength="6" oninput="numberMaxLength(this);" id="' + cn + '">');
				}

				table.appendChild(table_row);
			}
		}

		function get_Values() {
		}

		function closePopup() {
			self.close();
		}

		function load_Def() {
			for (var si = 0; si < 22; si++) {
				s_LOT_IG_VALUE_1[si] = 0;
				s_LOT_IG_VALUE_2[si] = 0;
				s_LOT_IG_VALUE_3[si] = 0;
				s_LOT_IG_VALUE_4[si] = 0;
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
		}).on('changeDate', function() {
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
			set_Value();
			load_ingredient_info();
			load_component_analysis_info();
		});

		// 초기값 등록
		$("#register_btn").on("click", function() {
			//	console.log("초기값 등록");
			saveInitValue();
		});

		function get_material_name(material_id, sheet_id) {
			var sheet_str;
			
			if(sheet_id == "0") sheet_str = "";
			else sheet_str = "(" + sheet_id + ")";

			for (var i = 0; i < l_MaterialID.length; i++) {
				if (l_MaterialID[i] == material_id) return l_MaterialName[i] + sheet_str;
			}
			return material_id + sheet_str;
		};

		function get_seller_name(seller_id) {
			for (var i = 0; i < l_SellerID.length; i++) {
				if (l_SellerID[i] == seller_id)
					return l_SellerName[i];
			}
			return seller_id;
		};

		function set_Value() {
			l_MASTER_ID = '${req_data.MASTER_ID}';
			document.getElementById("edt_MATERIAL_ID").value = get_material_name('${req_data.MATERIAL_ID}', '${req_data.SHEET_ID}');
			document.getElementById("edt_SELLER_ID").value = get_seller_name('${req_data.SELLER_ID}');
			document.getElementById("edt_IMPORT_DATE").value = '${req_data.IMPORT_DATE}';
		}

		function get_NS(id) {
			return document.getElementById(id).value == "" ? "0" : document.getElementById(id).value;
		}

		function cn(nv) {
			if(nv == null) return 0;
			else return nv;
		}

		function set_NS(id, value) {
			if(value == null) document.getElementById(id).value = 0;
			else document.getElementById(id).value = value;
		}

		function fillZero(str, width) {
			return str.length >= width ? str
					: new Array(width - str.length + 1).join('0') + str;//남는 길이만큼 0으로 채움
		}

		function display_component_analysis_info() {
			var cn = "";

			set_NS("edt_LOT_COUNT", s_LOT_COUNT);
			for (var si = 0; si < 31; si++) {
				cn = "edt_IG_VALUE_" + (si + 1).toString();
				set_NS(cn, s_IG_VALUE[si]);
			}

			set_NS("edt_PM_100_VALUE", s_PM_100_VALUE);
			set_NS("edt_PM_200_VALUE", s_PM_200_VALUE);
			set_NS("edt_PM_325_VALUE", s_PM_325_VALUE);
			set_NS("edt_PM_400_VALUE", s_PM_400_VALUE);
			set_NS("edt_PM_M400_VALUE", s_PM_M400_VALUE);

			for (var si = 0; si < s_LOT_COUNT; si++) {
				for(var ac = 0;ac < l_INGREDIENT_CNT;ac ++) {
					cn = "edt_LOT_" + (si + 1).toString() + "_IG_" + (ac + 1).toString() + "_VALUE";
					
					switch(ac) {
					case 0:
						set_NS(cn, s_LOT_IG_VALUE_1[si]);
						break;
					case 1:
						set_NS(cn, s_LOT_IG_VALUE_2[si]);
						break;
					case 2:
						set_NS(cn, s_LOT_IG_VALUE_3[si]);
						break;
					case 3:
						set_NS(cn, s_LOT_IG_VALUE_4[si]);
						break;
					}
				}
			}
		}

		function load_component_analysis_info() {
			$.ajax({
				url : "/yp/zpp/ore/zpp_ore_req_component_analysis_info",
				type : "POST",
				cache : false,
				async : true,
				data : {
					MASTER_ID : l_MASTER_ID,
					_csrf : '${_csrf.token}'
				},
				dataType : "json",
				success : function(result) {
					//	console.log("/yp/zpp/ore/zpp_ore_req_component_analysis_info success : " + result.data_count);

					if (result.data_count > 0) {
						//	UPDATE MODE
						l_EditMode = 2;

						s_LOT_COUNT = result.data.LOT_COUNT;

						//	console.log('lot count : ' + s_LOT_COUNT);

						set_NS('edt_LOT_COUNT', s_LOT_COUNT);

						setLotCountTable(s_LOT_COUNT);

						s_IG_CODE[0] = result.data.IG_CODE_1;
						s_IG_CODE[1] = result.data.IG_CODE_2;
						s_IG_CODE[2] = result.data.IG_CODE_3;
						s_IG_CODE[3] = result.data.IG_CODE_4;
						s_IG_CODE[4] = result.data.IG_CODE_5;
						s_IG_CODE[5] = result.data.IG_CODE_6;
						s_IG_CODE[6] = result.data.IG_CODE_7;
						s_IG_CODE[7] = result.data.IG_CODE_8;
						s_IG_CODE[8] = result.data.IG_CODE_9;
						s_IG_CODE[9] = result.data.IG_CODE_10;
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

						s_IG_VALUE[0] = result.data.IG_VALUE_1;
						s_IG_VALUE[1] = result.data.IG_VALUE_2;
						s_IG_VALUE[2] = result.data.IG_VALUE_3;
						s_IG_VALUE[3] = result.data.IG_VALUE_4;
						s_IG_VALUE[4] = result.data.IG_VALUE_5;
						s_IG_VALUE[5] = result.data.IG_VALUE_6;
						s_IG_VALUE[6] = result.data.IG_VALUE_7;
						s_IG_VALUE[7] = result.data.IG_VALUE_8;
						s_IG_VALUE[8] = result.data.IG_VALUE_9;
						s_IG_VALUE[9] = result.data.IG_VALUE_10;
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

						s_LOT_IG_VALUE_1[0] = result.data.LOT_1_IG_1_VALUE;
						s_LOT_IG_VALUE_1[1] = result.data.LOT_2_IG_1_VALUE;
						s_LOT_IG_VALUE_1[2] = result.data.LOT_3_IG_1_VALUE;
						s_LOT_IG_VALUE_1[3] = result.data.LOT_4_IG_1_VALUE;
						s_LOT_IG_VALUE_1[4] = result.data.LOT_5_IG_1_VALUE;
						s_LOT_IG_VALUE_1[5] = result.data.LOT_6_IG_1_VALUE;
						s_LOT_IG_VALUE_1[6] = result.data.LOT_7_IG_1_VALUE;
						s_LOT_IG_VALUE_1[7] = result.data.LOT_8_IG_1_VALUE;
						s_LOT_IG_VALUE_1[8] = result.data.LOT_9_IG_1_VALUE;
						s_LOT_IG_VALUE_1[9] = result.data.LOT_10_IG_1_VALUE;
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

						s_LOT_IG_VALUE_2[0] = result.data.LOT_1_IG_2_VALUE;
						s_LOT_IG_VALUE_2[1] = result.data.LOT_2_IG_2_VALUE;
						s_LOT_IG_VALUE_2[2] = result.data.LOT_3_IG_2_VALUE;
						s_LOT_IG_VALUE_2[3] = result.data.LOT_4_IG_2_VALUE;
						s_LOT_IG_VALUE_2[4] = result.data.LOT_5_IG_2_VALUE;
						s_LOT_IG_VALUE_2[5] = result.data.LOT_6_IG_2_VALUE;
						s_LOT_IG_VALUE_2[6] = result.data.LOT_7_IG_2_VALUE;
						s_LOT_IG_VALUE_2[7] = result.data.LOT_8_IG_2_VALUE;
						s_LOT_IG_VALUE_2[8] = result.data.LOT_9_IG_2_VALUE;
						s_LOT_IG_VALUE_2[9] = result.data.LOT_10_IG_2_VALUE;
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

						s_LOT_IG_VALUE_3[0] = result.data.LOT_1_IG_3_VALUE;
						s_LOT_IG_VALUE_3[1] = result.data.LOT_2_IG_3_VALUE;
						s_LOT_IG_VALUE_3[2] = result.data.LOT_3_IG_3_VALUE;
						s_LOT_IG_VALUE_3[3] = result.data.LOT_4_IG_3_VALUE;
						s_LOT_IG_VALUE_3[4] = result.data.LOT_5_IG_3_VALUE;
						s_LOT_IG_VALUE_3[5] = result.data.LOT_6_IG_3_VALUE;
						s_LOT_IG_VALUE_3[6] = result.data.LOT_7_IG_3_VALUE;
						s_LOT_IG_VALUE_3[7] = result.data.LOT_8_IG_3_VALUE;
						s_LOT_IG_VALUE_3[8] = result.data.LOT_9_IG_3_VALUE;
						s_LOT_IG_VALUE_3[9] = result.data.LOT_10_IG_3_VALUE;
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

						s_LOT_IG_VALUE_4[0] = cn(result.data.LOT_1_IG_4_VALUE);
						s_LOT_IG_VALUE_4[1] = cn(result.data.LOT_2_IG_4_VALUE);
						s_LOT_IG_VALUE_4[2] = cn(result.data.LOT_3_IG_4_VALUE);
						s_LOT_IG_VALUE_4[3] = cn(result.data.LOT_4_IG_4_VALUE);
						s_LOT_IG_VALUE_4[4] = cn(result.data.LOT_5_IG_4_VALUE);
						s_LOT_IG_VALUE_4[5] = cn(result.data.LOT_6_IG_4_VALUE);
						s_LOT_IG_VALUE_4[6] = cn(result.data.LOT_7_IG_4_VALUE);
						s_LOT_IG_VALUE_4[7] = cn(result.data.LOT_8_IG_4_VALUE);
						s_LOT_IG_VALUE_4[8] = cn(result.data.LOT_9_IG_4_VALUE);
						s_LOT_IG_VALUE_4[9] = cn(result.data.LOT_10_IG_4_VALUE);
						s_LOT_IG_VALUE_4[10] = cn(result.data.LOT_11_IG_4_VALUE);
						s_LOT_IG_VALUE_4[11] = cn(result.data.LOT_12_IG_4_VALUE);
						s_LOT_IG_VALUE_4[12] = cn(result.data.LOT_13_IG_4_VALUE);
						s_LOT_IG_VALUE_4[13] = cn(result.data.LOT_14_IG_4_VALUE);
						s_LOT_IG_VALUE_4[14] = cn(result.data.LOT_15_IG_4_VALUE);
						s_LOT_IG_VALUE_4[15] = cn(result.data.LOT_16_IG_4_VALUE);
						s_LOT_IG_VALUE_4[16] = cn(result.data.LOT_17_IG_4_VALUE);
						s_LOT_IG_VALUE_4[17] = cn(result.data.LOT_18_IG_4_VALUE);
						s_LOT_IG_VALUE_4[18] = cn(result.data.LOT_19_IG_4_VALUE);
						s_LOT_IG_VALUE_4[19] = cn(result.data.LOT_20_IG_4_VALUE);
						s_LOT_IG_VALUE_4[20] = cn(result.data.LOT_21_IG_4_VALUE);
						s_LOT_IG_VALUE_4[21] = cn(result.data.LOT_22_IG_4_VALUE);
					} else {
						//	INSERT MODE
						l_EditMode = 1;

						s_LOT_COUNT = result.data.LOT_COUNT;
						set_NS('edt_LOT_COUNT', s_LOT_COUNT);
						setLotCountTable(s_LOT_COUNT);

						for (var si = 0; si < 31; si++) {
							s_IG_CODE[si] = "YPIG-00" + fillZero((si + 1).toString(), 2);
						}

						for (var si = 0; si < 31; si++) {
							s_IG_VALUE[si] = 0;
						}

						s_PM_100_VALUE = 0;
						s_PM_200_VALUE = 0;
						s_PM_325_VALUE = 0;
						s_PM_400_VALUE = 0;
						s_PM_M400_VALUE = 0;

						for (var si = 0; si < 22; si++) {
							s_LOT_IG_VALUE_1[si] = 0;
							s_LOT_IG_VALUE_2[si] = 0;
							s_LOT_IG_VALUE_3[si] = 0;
							s_LOT_IG_VALUE_4[si] = 0;
						}
					}

					display_component_analysis_info();
				},
				error : function(request, status, error) {
					//	console.log("code:" + request.status + "\n"
					//			+ "message:" + request.json + "\n"
					//			+ "error:" + error);
				}
			});
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

		function saveInitValue() {
			for (var si = 0; si < 31; si++) {
				s_IG_CODE[si] = "YPIG-00" + fillZero((si + 1).toString(), 2);
				//	console.log(s_IG_CODE[si]);
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

			var cn = "";

			for (var si = 0; si < s_LOT_COUNT; si++) {
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

			$.ajax({
				url : "/yp/popup/zpp/ore/zpp_ore_insert_init_value",
				type : "POST",
				cache : false,
				async : true,
				data : {
					MASTER_ID : l_MASTER_ID,
					MODE : l_EditMode,
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
					IG_CODE_32 : " ",

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
					LOT_23_IG_1_VALUE : 0,
					LOT_23_IG_2_VALUE : 0,
					LOT_23_IG_3_VALUE : 0,
					LOT_23_IG_4_VALUE : 0,
					LOT_24_IG_1_VALUE : 0,
					LOT_24_IG_2_VALUE : 0,
					LOT_24_IG_3_VALUE : 0,
					LOT_24_IG_4_VALUE : 0,
					LOT_25_IG_1_VALUE : 0,
					LOT_25_IG_2_VALUE : 0,
					LOT_25_IG_3_VALUE : 0,
					LOT_25_IG_4_VALUE : 0,
					LOT_26_IG_1_VALUE : 0,
					LOT_26_IG_2_VALUE : 0,
					LOT_26_IG_3_VALUE : 0,
					LOT_26_IG_4_VALUE : 0,
					LOT_27_IG_1_VALUE : 0,
					LOT_27_IG_2_VALUE : 0,
					LOT_27_IG_3_VALUE : 0,
					LOT_27_IG_4_VALUE : 0,
					LOT_28_IG_1_VALUE : 0,
					LOT_28_IG_2_VALUE : 0,
					LOT_28_IG_3_VALUE : 0,
					LOT_28_IG_4_VALUE : 0,
					LOT_29_IG_1_VALUE : 0,
					LOT_29_IG_2_VALUE : 0,
					LOT_29_IG_3_VALUE : 0,
					LOT_29_IG_4_VALUE : 0,
					LOT_30_IG_1_VALUE : 0,
					LOT_30_IG_2_VALUE : 0,
					LOT_30_IG_3_VALUE : 0,
					LOT_30_IG_4_VALUE : 0,
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

		opener.popup = this;
	</script>
</body>
</html>