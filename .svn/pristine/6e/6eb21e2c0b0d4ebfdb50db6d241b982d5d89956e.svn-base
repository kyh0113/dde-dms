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
	<title>캐소드 블렌딩 예측 등록 설정 화면</title>
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
			캐소드 블렌딩 예측 등록 설정 화면
		</div>
		<div class="pop_content">
			<table id="table_1" class=tbl_def>
				<colgroup>
					<col width="20%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
				</colgroup>
				<tr>
					<td class=name_cell>구분 (ton)</td>
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
			<table id="table_2" class=tbl_def>
				<colgroup>
					<col width="20%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
				</colgroup>
				<tr>
					<td class=name_cell>투입Lot 당 무게 (ton)</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_1" size="20" style="height:30px; border:0;" class=edit_cell>
						</div>
					</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_2" size="20" style="height:30px; border:0;" class=edit_cell>
						</div>
					</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_3" size="20" style="height:30px; border:0;" class=edit_cell>
						</div>
					</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_4" size="20" style="height:30px; border:0;" class=edit_cell>
						</div>
					</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_5" size="20" style="height:30px; border:0;" class=edit_cell>
						</div>
					</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_6" size="20" style="height:30px; border:0;" class=edit_cell>
						</div>
					</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_7" size="20" style="height:30px; border:0;" class=edit_cell>
						</div>
					</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_8" size="20" style="height:30px; border:0;" class=edit_cell>
						</div>
					</td>
				</tr>
			</table>
			<div style="height:5px; background-color:white"></div>
			<table id="table_2" class=tbl_def>
				<colgroup>
					<col width="20%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
				</colgroup>
				<tr>
					<td class=name_cell>제품별 ppm 지정</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_11" size="20" style="height:30px; border:0;" class=edit_cell>
						</div>
					</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_12" size="20" style="height:30px; border:0;" class=edit_cell>
						</div>
					</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_13" size="20" style="height:30px; border:0;" class=edit_cell>
						</div>
					</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_14" size="20" style="height:30px; border:0;" class=edit_cell>
						</div>
					</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_15" size="20" style="height:30px; border:0;" class=edit_cell>
						</div>
					</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_16" size="20" style="height:30px; border:0;" class=edit_cell>
						</div>
					</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_17" size="20" style="height:30px; border:0;" class=edit_cell>
						</div>
					</td>
					<td class=editable_bg>
						<div>
							<input type="number" step="0.5" id="input_18" size="20" style="height:30px; border:0;" class=edit_cell>
						</div>
					</td>
				</tr>
			</table>
			<div style="height:35px; background-color:white"></div>
			<div class="btn_wrap">
				<button class="btn btn_save" id="reg_btn" onclick="saveSetup();" style="font-size:12px; width:90px; height:30px;">저장</button>
				<button class="btn btn_save" id="reg_btn" onclick="closePopup();" style="font-size:12px; width:90px; height:30px;">닫기</button>
			</div>
		</div>
	</div>
	<script>
		//	Lot당 무게
		var l_MultipleVal = new Array();
		//	제품별 ppm
		var l_InPpm = new Array();

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
					//	console.log("/yp/zpp/ctd/zpp_ctd_envdata success : " + result.REG_DATE + "," + result.M1_LOT_WEIGHT);
	
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
	
					//	console.log("data : " + l_InPpm[0] + "," + l_MultipleVal[0] + ","  + l_InPpm[1] + "," + l_MultipleVal[1] + ","  + l_InPpm[2] + "," + l_MultipleVal[2]);

					set_Value();
				},
				error : function(request, status, error) {
					//	console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
				}
			});
		}

		function saveSetup() {
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

			var sDateStr = sYear + sMonth + sDay + sHour + sMinute + sSecond;

			$.ajax({
 				url : "/yp/popup/zpp/ctd/zpp_ctd_insert_envdata",
				type : "POST",
			    cache:false,
			    async:true, 
				data : {
					REG_DATE : sDateStr,
					M1_LOT_WEIGHT : document.getElementById("input_1").value,
					M1_PPM_LEVEL : document.getElementById("input_11").value,
					M2_LOT_WEIGHT : document.getElementById("input_2").value,
					M2_PPM_LEVEL : document.getElementById("input_12").value,
					M3_LOT_WEIGHT : document.getElementById("input_3").value,
					M3_PPM_LEVEL : document.getElementById("input_13").value,
					M4_LOT_WEIGHT : document.getElementById("input_4").value,
					M4_PPM_LEVEL : document.getElementById("input_14").value,
					M5_LOT_WEIGHT : document.getElementById("input_5").value,
					M5_PPM_LEVEL : document.getElementById("input_15").value,
					M6_LOT_WEIGHT : document.getElementById("input_6").value,
					M6_PPM_LEVEL : document.getElementById("input_16").value,
					M7_LOT_WEIGHT : document.getElementById("input_7").value,
					M7_PPM_LEVEL : document.getElementById("input_17").value,
					M8_LOT_WEIGHT : document.getElementById("input_8").value,
					M8_PPM_LEVEL : document.getElementById("input_18").value,
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

			//	self.close();
		}

		function closePopup() {
			self.close();	
		}

		function set_Value() {
			document.getElementById("input_1").value = l_MultipleVal[0];
			document.getElementById("input_2").value = l_MultipleVal[1];
			document.getElementById("input_3").value = l_MultipleVal[2];
			document.getElementById("input_4").value = l_MultipleVal[3];
			document.getElementById("input_5").value = l_MultipleVal[4];
			document.getElementById("input_6").value = l_MultipleVal[5];
			document.getElementById("input_7").value = l_MultipleVal[6];
			document.getElementById("input_8").value = l_MultipleVal[7];

			document.getElementById("input_11").value = l_InPpm[0];
			document.getElementById("input_12").value = l_InPpm[1];
			document.getElementById("input_13").value = l_InPpm[2];
			document.getElementById("input_14").value = l_InPpm[3];
			document.getElementById("input_15").value = l_InPpm[4];
			document.getElementById("input_16").value = l_InPpm[5];
			document.getElementById("input_17").value = l_InPpm[6];
			document.getElementById("input_18").value = l_InPpm[7];
		}

		$(document).ready(function() {
			get_Values();
		});
	</script>
</body>
</html>