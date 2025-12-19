<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}

	Date dt = new Date();
	SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/dd");
	String today = date.format(dt);
	//JSTL에서 사용할 수 있도록 세팅
	request.setAttribute("today", today);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주요재고등록</title>

<script language='javascript'>

    function getInputDayLabel(tp) {

        var week = new Array('일', '월', '화', '수', '목', '금', '토');

        var today = new Date(tp).getDay();
        var todayLabel = week[today];

        return todayLabel;
    }

</script>

</head>
<body>
	<!-- 20191023_khj for csrf -->
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<h2>
		주요 재고 등록
		<!-- 공통 - 네비게이션 시작 -->
		<ul class="loc">
			<li>
				<img src="/resources/yp/images/ic_loc_home.png">
			</li>
			<c:if test="${menu.breadcrumb[0].top_menu_id ne null}">
				<li>${menu.breadcrumb[0].top_menu_name}</li>
				<c:if test="${menu.breadcrumb[0].top_menu_id ne menu.breadcrumb[0].up_menu_id}">
					<c:if test="${menu.breadcrumb[0].up_menu_id ne null}">
						<li>${menu.breadcrumb[0].up_menu_name}</li>
					</c:if>
				</c:if>
			</c:if>
			<c:if test="${menu.breadcrumb[0].menu_id ne null}">
				<li>${menu.breadcrumb[0].menu_name}</li>
			</c:if>
		</ul>
		<!-- 공통 - 네비게이션 종료 -->
	</h2>
	<!-- <div class="stitle">기본정보</div> -->
		<section>
			<div class="tbl_box">
				<table cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="5%" />
						<col width="25%" />
						<col width="5%" />
						<col width="25%" />
						<col width="5%" />
						<col width="25%" />
					</colgroup>
					<tr>
						<th>기준일자</th>
						<td>
							<input class="calendar search_dtp" type="text" name="CHK_DT" id="CHK_DT" value="${today}" readonly="readonly">
						</td>
					</tr>
				</table>
				<div class="btn_wrap">
					<input type="button" class="btn btn_search" id="search_btn" value="조회" />
				</div>
				<form id="mfrm" name="mfrm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type='hidden' id='insertQuery' name='insertQuery' value='oracle.yp_zmm.update_zmm_inv_Upload'>
				<div class="btn_wrap">
					<input type="file" name="excelfile" id="upload" value="" />
					<input type="button" class="btn btn_excel" id="upload_btn" value="파일등록" onclick="fnExcelUpload();" />
					<input type="button" class="btn btn_make" id=excelTemplate_btn value="ExcelDown" />
				</div>
				</form>
			</div>
		</section>

		<form id="frm" name="frm" method="post">
		<div class="float_wrap">
			<div class="fl">
				<div class="stitle">재고현황</div>
			</div>
			<div class="fr">
				<div class="btn_wrap">
					<!-- <input type=button class="btn_g" id="fnModify" value="수정"> -->
					<input type=button class="btn_g" id="fnSave" value="저장">
				</div>
			</div>
		</div>

		<style>
			.parent {
			    display: flex;
			}
			.child {
			    flex: 1;
			}
			input[type=text] {
				margin-top: -2.5px;
				height: 18.5px;
				border: 1px solid #ced4da;;
			}
		</style>

		<div class="parent">
			<section>
				<div class="lst">
				<table cellspacing="1" cellpadding="0" style="width:300px">
					<colgroup>
						<col width="8.5%" />
						<col width="5%" />
						<col width="5%" />
					</colgroup>
					<tr>
						<td colspan="3" style="text-align: center; vertical-align: middle;" bgcolor="whitesmoke"><b>항목</b></td>
					</tr>
					<tr>
						<td rowspan="4" style="text-align: center; vertical-align: middle;"><b>정광</b></td>
						<td colspan="2">통관재고</td>
					</tr>
					<tr>
						<td rowspan="3" style="text-align: center; vertical-align: middle;">현장<br>재고</td>
						<td>동해</td>
					</tr>
					<tr>
						<td>석포</td>
					</tr>
					<tr>
						<td bgcolor="whitesmoke">계</td>
					</tr>
					<tr>
						<td rowspan="2" style="text-align: center; vertical-align: middle;"><b>생산</b></td>
						<td colspan="2">Cathode</td>
					</tr>
					<tr>
						<td colspan="2">Ingot</td>
					</tr>
					<tr>
						<td rowspan="1" style="text-align: center; vertical-align: middle;"><b>소광</b></td>
						<td colspan="2" bgcolor="whitesmoke">소광재고</td>
					</tr>
					<tr>
						<td rowspan="1" style="text-align: center; vertical-align: middle;"><b>Cake</b></td>
						<td colspan="2" bgcolor="whitesmoke">Conv. Cake 재고</td>
					</tr>
					<tr>
						<td rowspan="3" style="text-align: center; vertical-align: middle;"><b>Cathode</b></td>
						<td colspan="2">고품위</td>
					</tr>
					<tr>
						<td colspan="2">저품위</td>
					</tr>
					<tr>
						<td colspan="2" bgcolor="whitesmoke">계</td>
					</tr>
					<tr>
						<td rowspan="7" style="text-align: center; vertical-align: middle;"><b>아연괴</b></td>
						<td rowspan="5" style="text-align: center; vertical-align: middle;">석포<br>실물<br>재고</td>
						<td>합금</td>
					</tr>
					<tr>
						<td>일반</td>
					</tr>
					<tr>
						<td>Slab</td>
					</tr>
					<tr>
						<td>조합</td>
					</tr>
					<tr>
						<td bgcolor="whitesmoke">계</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center; vertical-align: middle;">* 석포 外 재고</td>
					</tr>
					<tr>
						<td colspan="2" bgcolor="whitesmoke">합 계</td>
					</tr>
				</table>
				</div>
			</section>

			<section>
				<div class="lst">
					<table cellspacing="1" cellpadding="0" class="inv_table">
					</table>
				</div>
			</section>

			<section style="width:300px">
				<div class="lst">
					<table cellspacing="1" cellpadding="0" class="inv_table2">
					</table>
				</div>
			</section>

		</div>
	</form>

	<div class="float_wrap">
		<div class="fl">
			<div><br><b>* 석포 外 재고 中 현대, 동부항 약 5,000 톤은 월 마감 時, 일괄 판매 처리하고 있으며 수출향도 판매 처리시점에 따라 재고차이 발생 가능.</b></div>
		</div>
	</div>

		<script>

			$(document).ready(function() {
				$(".search_dtp").datepicker({
					format : "yyyy/mm/dd",
					language : "ko",
					todayHighlight : true,
					autoclose : true,
					clearBtn : true,
					updateViewDate : false
				}).on('changeDate', function(){
				 	$('.datepicker').hide();
				});
				
				$("#search_btn").trigger("click");
			});

			function formatDate_y(date) {
				var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
				if (month.length < 2)
					month = '0' + month;
				if (day.length < 2)
					day = '0' + day;
				return [ year ].join('/');
			}

			function formatDate_m(date) {
				var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
				if (month.length < 2)
					month = '0' + month;
				if (day.length < 2)
					day = '0' + day;
				return [ year, month ].join('/');
			}

			function formatDate_d(date) {
				var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
				if (month.length < 2)
					month = '0' + month;
				if (day.length < 2)
					day = '0' + day;
				return [ year, month, day ].join('');
			}

			// 조회
			$("#search_btn").on("click", function() {
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");

				$.ajax({
					url : "/yp/zmm/inv/select_tbl_inv_list",
					type : "POST",
					cache : false,
					async : false,
					dataType:"json",
					data : {
						CHK_DT : $("#CHK_DT").val().replace(/\//gi, "").trim()
					},
					success: function(data) {
						//테이블 초기화
						tableInit();
						var innerHtml = "";
						var innerHtml2 = "";
						var list = data.list1;
						var list2 = data.list2;
						//if(list.length > 0) {

							var cal = 7-list.length;

							for(var i=0; i < list.length; i++) {
								var obj = list[i];

								innerHtml += '<tr style="display: block; float: left; width:130px;" id="listTable" name="listTable" class="data-base" data-rn="' + ( i+1 ) + '">';
								innerHtml += '	<td style="display: block;"><input type="checkbox" class="rows-checkbox rows-no-' + i + '" data-rn="' + ( i+1 ) + '" checked style="zoom: 0.0001;"';
								innerHtml += '			CREATE_DT="'+obj.CHK_DT+'"';
								innerHtml += '			CONCENT_T="'+obj.CONCENT_T+'"';
								innerHtml += '			CONCENT_D="'+obj.CONCENT_D+'"';
								innerHtml += '			CONCENT_S="'+obj.CONCENT_S+'"';
								innerHtml += '			CONCENT_SUM="'+obj.CONCENT_SUM+'"';
								innerHtml += '			PROD_C="'+obj.PROD_C+'"';
								innerHtml += '			PROD_I="'+obj.PROD_I+'"';
								innerHtml += '			EXTIN_INV="'+obj.EXTIN_INV+'"';
								innerHtml += '			CAKE_C="'+obj.CAKE_C+'"';
								innerHtml += '			CATHODE_H="'+obj.CATHODE_H+'"';
								innerHtml += '			CATHODE_L="'+obj.CATHODE_L+'"';
								innerHtml += '			CATHODE_SUM="'+obj.CATHODE_SUM+'"';
								innerHtml += '			ZINC_A="'+obj.ZINC_A+'"';
								innerHtml += '			ZINC_C="'+obj.ZINC_C+'"';
								innerHtml += '			ZINC_S="'+obj.ZINC_S+'"';
								innerHtml += '			ZINC_T="'+obj.ZINC_T+'"';
								innerHtml += '			ZINC_SUM="'+obj.ZINC_SUM+'"';
								innerHtml += '			ZINC_EX="'+obj.ZINC_EX+'"';
								innerHtml += '			ZINC_TOT="'+obj.ZINC_TOT+'"';
								innerHtml += '	/>';
								innerHtml += '	<input type="text" class="" id="CHK_DD" name="CHK_DD" style="text-align:center" value="'+obj.CHK_DD1+'/'+obj.CHK_DD2+' ('+obj.CHK_YOIL+')" readonly /></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="CONCENT_T" name="CONCENT_T" style="text-align:right" data-rn="' + i + '" value="'+addComma(obj.CONCENT_T)+'" maxlength="10" onchange="javascript: reflectCommon(this, \'CONCENT_T\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="CONCENT_D" name="CONCENT_D" style="text-align:right" data-rn="' + i + '" value="'+addComma(obj.CONCENT_D)+'" maxlength="10" onchange="javascript: reflectCommon(this, \'CONCENT_D\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="CONCENT_S" name="CONCENT_S" style="text-align:right" data-rn="' + i + '" value="'+addComma(obj.CONCENT_S)+'" maxlength="10" onchange="javascript: reflectCommon(this, \'CONCENT_S\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;" bgcolor="whitesmoke"><input type="text" id="CONCENT_SUM" name="CONCENT_SUM" style="text-align:right" value="'+addComma(obj.CONCENT_SUM)+'" readonly /></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="PROD_C" name="PROD_C" style="text-align:right" data-rn="' + i + '" value="'+addComma(obj.PROD_C)+'" maxlength="10" onchange="javascript: reflectCommon(this, \'PROD_C\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="PROD_I" name="PROD_I" style="text-align:right" data-rn="' + i + '" value="'+addComma(obj.PROD_I)+'" maxlength="10" onchange="javascript: reflectCommon(this, \'PROD_I\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="EXTIN_INV" name="EXTIN_INV" style="text-align:right" data-rn="' + i + '" value="'+addComma(obj.EXTIN_INV)+'" maxlength="10" onchange="javascript: reflectCommon(this, \'EXTIN_INV\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="CAKE_C" name="CAKE_C" style="text-align:right" data-rn="' + i + '" value="'+addComma(obj.CAKE_C)+'" maxlength="10" onchange="javascript: reflectCommon(this, \'CAKE_C\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="CATHODE_H" name="CATHODE_H" style="text-align:right" data-rn="' + i + '" value="'+addComma(obj.CATHODE_H)+'" maxlength="10" onchange="javascript: reflectCommon(this, \'CATHODE_H\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="CATHODE_L" name="CATHODE_L" style="text-align:right" data-rn="' + i + '" value="'+addComma(obj.CATHODE_L)+'" maxlength="10" onchange="javascript: reflectCommon(this, \'CATHODE_L\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;" bgcolor="whitesmoke"><input type="text" id="CATHODE_SUM" name="CATHODE_SUM" style="text-align:right" value="'+addComma(obj.CATHODE_SUM)+'" readonly /></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="ZINC_A" name="ZINC_A" style="text-align:right" data-rn="' + i + '" value="'+addComma(obj.ZINC_A)+'" maxlength="10" onchange="javascript: reflectCommon(this, \'ZINC_A\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="ZINC_C" name="ZINC_C" style="text-align:right" data-rn="' + i + '" value="'+addComma(obj.ZINC_C)+'" maxlength="10" onchange="javascript: reflectCommon(this, \'ZINC_C\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="ZINC_S" name="ZINC_S" style="text-align:right" data-rn="' + i + '" value="'+addComma(obj.ZINC_S)+'" maxlength="10" onchange="javascript: reflectCommon(this, \'ZINC_S\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="ZINC_T" name="ZINC_T" style="text-align:right" data-rn="' + i + '" value="'+addComma(obj.ZINC_T)+'" maxlength="10" onchange="javascript: reflectCommon(this, \'ZINC_T\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;" bgcolor="whitesmoke"><input type="text" id="ZINC_SUM" name="ZINC_SUM" style="text-align:right" value="'+addComma(obj.ZINC_SUM)+'" readonly /></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="ZINC_EX" name="ZINC_EX" style="text-align:right" data-rn="' + i + '" value="'+addComma(obj.ZINC_EX)+'" maxlength="10" onchange="javascript: reflectCommon(this, \'ZINC_EX\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;" bgcolor="whitesmoke"><input type="text" id="ZINC_TOT" name="ZINC_TOT" style="text-align:right" value="'+addComma(obj.ZINC_TOT)+'" readonly /></td>';
								innerHtml += '</tr>';
								var i2 = i+1;
							}

							for (var j=cal; j >= 1; j--) {

								if (i2 > 0) {

								}
								else {
									
									var i2 = 0;
								}

								var now = new Date(document.getElementById('CHK_DT').value);
								var yesterday = new Date(now.setDate(now.getDate() - j));
								var str = formatDate_d(yesterday);
								var cal_yy = str.toString().substr(0,4)
								var cal_mm = str.toString().substr(4,2)
								var cal_dd = str.toString().substr(6,2)
								var cal_day = cal_yy+"-"+cal_mm+"-"+cal_dd

								innerHtml += '<tr style="display: block; float: left; width:130px;" class="data-base" data-rn="' + ( i2+j ) + '">';
								innerHtml += '	<td style="display: block;" bgcolor="whitesmoke"><input type="checkbox" class="rows-checkbox rows-no-' + ( i2+j ) + '" data-rn="' + ( i2+j ) + '" checked style="zoom: 0.0001"';
								innerHtml += '			CREATE_DT="'+str+'"';
								innerHtml += '			CONCENT_T=""';
								innerHtml += '			CONCENT_D=""';
								innerHtml += '			CONCENT_S=""';
								innerHtml += '			CONCENT_SUM=""';
								innerHtml += '			PROD_C=""';
								innerHtml += '			PROD_I=""';
								innerHtml += '			EXTIN_INV=""';
								innerHtml += '			CAKE_C=""';
								innerHtml += '			CATHODE_H=""';
								innerHtml += '			CATHODE_L=""';
								innerHtml += '			CATHODE_SUM=""';
								innerHtml += '			ZINC_A=""';
								innerHtml += '			ZINC_C=""';
								innerHtml += '			ZINC_S=""';
								innerHtml += '			ZINC_T=""';
								innerHtml += '			ZINC_SUM=""';
								innerHtml += '			ZINC_EX=""';
								innerHtml += '			ZINC_TOT=""';
								innerHtml += '	/>';
								innerHtml += '	<input type="text" class="" id="CHK_DD" name="CHK_DD" value="'+cal_mm+'/'+cal_dd+' ('+getInputDayLabel(cal_day)+')" readonly /></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="CONCENT_T" name="CONCENT_T" style="text-align:right" value="" maxlength="10" data-rn="' + ( i2+j ) + '" onchange="javascript: reflectCommon(this, \'CONCENT_T\');" onkeypress="inNumber();"></td>';				
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="CONCENT_D" name="CONCENT_D" style="text-align:right" value="" maxlength="10" data-rn="' + ( i2+j ) + '" onchange="javascript: reflectCommon(this, \'CONCENT_D\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="CONCENT_S" name="CONCENT_S" style="text-align:right" value="" maxlength="10" data-rn="' + ( i2+j ) + '" onchange="javascript: reflectCommon(this, \'CONCENT_S\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;" bgcolor="whitesmoke"><input type="text" class="inv_table_inputs" id="CONCENT_SUM" name="CONCENT_SUM" style="text-align:right" value="" readonly /></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="PROD_C" name="PROD_C" style="text-align:right" value="" maxlength="10" data-rn="' + ( i2+j ) + '" onchange="javascript: reflectCommon(this, \'PROD_C\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="PROD_I" name="PROD_I" style="text-align:right" value="" maxlength="10" data-rn="' + ( i2+j ) + '" onchange="javascript: reflectCommon(this, \'PROD_I\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="EXTIN_INV" name="EXTIN_INV" style="text-align:right" value="" maxlength="10" data-rn="' + ( i2+j ) + '" onchange="javascript: reflectCommon(this, \'EXTIN_INV\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="CAKE_C" name="CAKE_C" style="text-align:right" value="" maxlength="10" data-rn="' + ( i2+j ) + '" onchange="javascript: reflectCommon(this, \'CAKE_C\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="CATHODE_H" name="CATHODE_H" style="text-align:right" value="" maxlength="10" data-rn="' + ( i2+j ) + '" onchange="javascript: reflectCommon(this, \'CATHODE_H\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="CATHODE_L" name="CATHODE_L" style="text-align:right" value="" maxlength="10" data-rn="' + ( i2+j ) + '" onchange="javascript: reflectCommon(this, \'CATHODE_L\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;" bgcolor="whitesmoke"><input type="text" class="inv_table_inputs" id="CATHODE_SUM" name="CATHODE_SUM" style="text-align:right" value="" readonly /></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="ZINC_A" name="ZINC_A" style="text-align:right" value="" maxlength="10" data-rn="' + ( i2+j ) + '" onchange="javascript: reflectCommon(this, \'ZINC_A\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="ZINC_C" name="ZINC_C" style="text-align:right" value="" maxlength="10" data-rn="' + ( i2+j ) + '" onchange="javascript: reflectCommon(this, \'ZINC_C\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="ZINC_S" name="ZINC_S" style="text-align:right" value="" maxlength="10" data-rn="' + ( i2+j ) + '" onchange="javascript: reflectCommon(this, \'ZINC_S\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="ZINC_T" name="ZINC_T" style="text-align:right" value="" maxlength="10" data-rn="' + ( i2+j ) + '" onchange="javascript: reflectCommon(this, \'ZINC_T\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;" bgcolor="whitesmoke"><input type="text" class="inv_table_inputs" id="ZINC_SUM" name="ZINC_SUM" style="text-align:right" value="" readonly /></td>';
								innerHtml += '	<td style="display: block;"><input type="text" class="inv_table_inputs" id="ZINC_EX" name="ZINC_EX" style="text-align:right" value="" maxlength="10" data-rn="' + ( i2+j ) + '" onchange="javascript: reflectCommon(this, \'ZINC_EX\');" onkeypress="inNumber();"></td>';
								innerHtml += '	<td style="display: block;" bgcolor="whitesmoke"><input type="text" class="inv_table_inputs" id="ZINC_TOT" name="ZINC_TOT" style="text-align:right" value="" readonly /></td>';
								innerHtml += '</tr>';
							}

							$('.inv_table').append(innerHtml);

							if(list2 === null) {
								innerHtml2 += '<tr style="display: block; float: left;">';
								innerHtml2 += '	<td style="text-align: center; vertical-align: middle; display: block;" bgcolor="whitesmoke"><b>비고</b></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="CONCENT_T_B" name="CONCENT_T_B" style="text-align:left; width:100%;" value="" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="CONCENT_D_B" name="CONCENT_D_B" style="text-align:left; width:100%;" value="" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="CONCENT_S_B" name="CONCENT_S_B" style="text-align:left; width:100%;" value="" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="PROD_C_B" name="PROD_C_B" style="text-align:left; width:100%;" value="" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="PROD_I_B" name="PROD_I_B" style="text-align:left; width:100%;" value="" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="EXTIN_INV_B" name="EXTIN_INV_B" style="text-align:left; width:100%;" value="" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="CAKE_C_B" name="CAKE_C_B" style="text-align:left; width:100%;" value="" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="CATHODE_H_B" name="CATHODE_H_B" style="text-align:left; width:100%;" value="" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="CATHODE_L_B" name="CATHODE_L_B" style="text-align:left; width:100%;" value="" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="ZINC_A_B" name="ZINC_A_B" style="text-align:left; width:100%;" value="" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="ZINC_C_B" name="ZINC_C_B" style="text-align:left; width:100%;" value="" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="ZINC_S_B" name="ZINC_S_B" style="text-align:left; width:100%;" value="" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="ZINC_T_B" name="ZINC_T_B" style="text-align:left; width:100%;" value="" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">수출대기, 선출고, 판매 미처리분等 포함</td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
								innerHtml2 += '</tr>';
							} else {
								innerHtml2 += '<tr style="display: block; float: left;">';
								innerHtml2 += '	<td style="text-align: center; vertical-align: middle; display: block;" bgcolor="whitesmoke"><b>비고</b></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="CONCENT_T_B" name="CONCENT_T_B" style="text-align:left; width:100%;" value="'+list2.CONCENT_T_B+'" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="CONCENT_D_B" name="CONCENT_D_B" style="text-align:left; width:100%;" value="'+list2.CONCENT_D_B+'" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="CONCENT_S_B" name="CONCENT_S_B" style="text-align:left; width:100%;" value="'+list2.CONCENT_S_B+'" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="PROD_C_B" name="PROD_C_B" style="text-align:left; width:100%;" value="'+list2.PROD_C_B+'" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="PROD_I_B" name="PROD_I_B" style="text-align:left; width:100%;" value="'+list2.PROD_I_B+'" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="EXTIN_INV_B" name="EXTIN_INV_B" style="text-align:left; width:100%;" value="'+list2.EXTIN_INV_B+'" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="CAKE_C_B" name="CAKE_C_B" style="text-align:left; width:100%;" value="'+list2.CAKE_C_B+'" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="CATHODE_H_B" name="CATHODE_H_B" style="text-align:left; width:100%;" value="'+list2.CATHODE_H_B+'" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="CATHODE_L_B" name="CATHODE_L_B" style="text-align:left; width:100%;" value="'+list2.CATHODE_L_B+'" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="ZINC_A_B" name="ZINC_A_B" style="text-align:left; width:100%;" value="'+list2.ZINC_A_B+'" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="ZINC_C_B" name="ZINC_C_B" style="text-align:left; width:100%;" value="'+list2.ZINC_C_B+'" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="ZINC_S_B" name="ZINC_S_B" style="text-align:left; width:100%;" value="'+list2.ZINC_S_B+'" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"><input type="text" class="inv_table_inputs" id="ZINC_T_B" name="ZINC_T_B" style="text-align:left; width:100%;" value="'+list2.ZINC_T_B+'" maxlength="100" /></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">수출대기, 선출고, 판매 미처리분等 포함</td>';
								innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
								innerHtml2 += '</tr>';	
							}
							
							$('.inv_table2').append(innerHtml2);

						//} else {
							//swalDangerCB("데이터가 없습니다.");
						//}
					},
					beforeSend : function(xhr) {
						// 2019-10-23 khj - for csrf
						xhr.setRequestHeader(header, token);
						$('.wrap-loading').removeClass('display-none');
					},
					complete : function() {
						$('.wrap-loading').addClass('display-none');
					},
					error : function(request, status, error) {
						console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
						swalDangerCB("조회 실패하였습니다.\n관리자에게 문의해주세요.");
					}
				});
			});

			//테이블 초기화
			function tableInit() {
				//table tr 초기화
				$(".inv_table tr").remove();
				$(".inv_table2 tr").remove();
			}

			/*콤마 추가*/
			function addComma(num) {
				return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			}

			/*콤마 제거*/
			function unComma(num) {
				return num.replace(/[^0-9.]/gi, '');
			}

			function inNumber() {
	          if(event.keyCode<48 || event.keyCode>57) {
	             event.returnValue = false;
	          }
			}

			function reflectCommon(obj, gb) {
				// 변경된 값
				var d = $(obj).val();
				// 반영대상 행
				var rows_no = $(obj).data("rn");

				//alert(rows_no)
				$(".data-base .rows-checkbox.rows-no-" + rows_no).attr(gb, d);
			}

			function fnValidation(rows){

				var check = true;
				save_datas = new Array();
				
				$(".data-base input.rows-checkbox").each(function(i, obj) {

					save_datas.push({
						CREATE_DT : $(obj).attr("CREATE_DT"),
						CONCENT_T : $(obj).attr("CONCENT_T"),
						CONCENT_D : $(obj).attr("CONCENT_D"),
						CONCENT_S : $(obj).attr("CONCENT_S"),
						CONCENT_SUM : parseInt($(obj).attr("CONCENT_T"))+parseInt($(obj).attr("CONCENT_D"))+parseInt($(obj).attr("CONCENT_S")),
						PROD_C : $(obj).attr("PROD_C"),
						PROD_I : $(obj).attr("PROD_I"),
						EXTIN_INV : $(obj).attr("EXTIN_INV"),
						CAKE_C : $(obj).attr("CAKE_C"),
						CATHODE_H : $(obj).attr("CATHODE_H"),
						CATHODE_L : $(obj).attr("CATHODE_L"),
						CATHODE_SUM : parseInt($(obj).attr("CATHODE_H"))+parseInt($(obj).attr("CATHODE_L")),
						ZINC_A : $(obj).attr("ZINC_A"),
						ZINC_C : $(obj).attr("ZINC_C"),
						ZINC_S : $(obj).attr("ZINC_S"),
						ZINC_T : $(obj).attr("ZINC_T"),
						ZINC_EX : $(obj).attr("ZINC_EX"),
						ZINC_SUM : parseInt($(obj).attr("ZINC_A"))+parseInt($(obj).attr("ZINC_C"))+parseInt($(obj).attr("ZINC_S"))+parseInt($(obj).attr("ZINC_T")),
						ZINC_TOT : parseInt($(obj).attr("ZINC_A"))+parseInt($(obj).attr("ZINC_C"))+parseInt($(obj).attr("ZINC_S"))+parseInt($(obj).attr("ZINC_T"))+parseInt($(obj).attr("ZINC_EX")),
						CHK_DT : $("#CHK_DT").val().replace(/\//gi, "").trim(),
						CONCENT_T_B : $("#CONCENT_T_B").val(),
						CONCENT_D_B : $("#CONCENT_D_B").val(),
						CONCENT_S_B : $("#CONCENT_S_B").val(),
						PROD_C_B : $("#PROD_C_B").val(),
						PROD_I_B : $("#PROD_I_B").val(),
						EXTIN_INV_B : $("#EXTIN_INV_B").val(),
						CAKE_C_B : $("#CAKE_C_B").val(),
						CATHODE_H_B : $("#CATHODE_H_B").val(),
						CATHODE_L_B : $("#CATHODE_L_B").val(),
						ZINC_A_B : $("#ZINC_A_B").val(),
						ZINC_C_B : $("#ZINC_C_B").val(),
						ZINC_S_B : $("#ZINC_S_B").val(),
						ZINC_T_B : $("#ZINC_T_B").val(),
						ZINC_EX_B : $("#ZINC_EX_B").val(),
					});
				});

				if( save_datas.length === 0 ) {
					return false;
				}

				$.each(save_datas, function(i, d) {

					if(d.CONCENT_T === "") {
						swalWarningCB("통관재고를 입력하세요.");
						check = false;
						return false;
					}
					if(d.CONCENT_D === "") {
						swalWarningCB("현장재고 동해를 입력하세요.");
						check = false;
						return false;
					}
					if(d.CONCENT_S === "") {
						swalWarningCB("현장재고 석포를 입력하세요.");
						check = false;
						return false;
					}
					if(d.PROD_C === "") {
						swalWarningCB("생산 Cathode를 입력하세요.");
						check = false;
						return false;
					}
					if(d.PROD_I === "") {
						swalWarningCB("생산 Ingot을 입력하세요.");
						check = false;
						return false;
					}
					if(d.EXTIN_INV === "") {
						swalWarningCB("소광재고를 입력하세요.");
						check = false;
						return false;
					}
					if(d.CAKE_C === "") {
						swalWarningCB("Conv, Cake 재고를 입력하세요.");
						check = false;
						return false;
					}
					if(d.CATHODE_H === "") {
						swalWarningCB("Cathode 고품위를 입력하세요");
						check = false;
						return false;
					}
					if(d.CATHODE_L === "") {
						swalWarningCB("Cathode 저품위를 입력하세요");
						check = false;
						return false;
					}
					if(d.ZINC_A === "") {
						swalWarningCB("아연괴 합금을 입력하세요");
						check = false;
						return false;
					}
					if(d.ZINC_C === "") {
						swalWarningCB("아연괴 일반을 입력하세요");
						check = false;
						return false;
					}
					if(d.ZINC_S === "") {
						swalWarningCB("아연괴 Slab을 입력하세요");
						check = false;
						return false;
					}
					if(d.ZINC_T === "") {
						swalWarningCB("아연괴 조합을 입력하세요");
						check = false;
						return false;
					}
					if(d.ZINC_EX === "") {
						swalWarningCB("석포 외 재고를 입력하세요");
						check = false;
						return false;
					}
				});

				return check;
			}

			// 저장
			$("#fnSave").on("click", function() {

				if(fnValidation()) {
					if (confirm("저장 하겠습니까?")) {

						var token = $("meta[name='_csrf']").attr("content");
						var header = $("meta[name='_csrf_header']").attr("content");

						$.ajax({
							url : "/yp/zmm/inv/zmm_inv_save",
							type : "POST",
							cache : false,
							async : true,
							dataType : "json",
							data : {
								ROW_NO: JSON.stringify(save_datas)
							},

							success : function(data) {
								swalSuccess("저장 되었습니다.");
								$("#search_btn").trigger("click");
							},

							beforeSend : function(xhr) {
								// 2019-10-23 khj - for csrf
								xhr.setRequestHeader(header, token);
								$('.wrap-loading').removeClass('display-none');
							},

							complete : function() {
								$('.wrap-loading').addClass('display-none');
							},

							error : function(request, status, error) {
								console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
								swalDangerCB("저장 실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
					}
				}
			});

			/****************************************엑셀 템플릿 다운로드 시작****************************************/
			$("#excelTemplate_btn").on("click",function() {

				var form = document.createElement("form");
				var input = document.createElement("input");
				input.name = "file_name";
				input.value = "주요 재고 현황_230719_Upload.xlsx";
				input.type = "hidden";
				form.appendChild(input);

				input = document.createElement("input");
				input.name = "${_csrf.parameterName}";
				input.value = "${_csrf.token}";
				input.type = "hidden";
				form.appendChild(input);

				form.method = "post";
				form.action = "/file/templateDownload";

				document.body.appendChild(form);

				form.submit();
				form.remove();
			});
			/****************************************엑셀 템플릿 다운로드  끝 ****************************************/

			/* 파일업로드 */
			function fnExcelUpload() {
				var form = $("#mfrm")[0],
					formData = new FormData(form);

				if($("#upload").val().length < 1) {
					swalWarning("파일을 먼저 선택해주세요.");
					return
				}

				$.ajax({
					url: "/file/excelUpload_Inv",
					processData: false,
					contentType: false,
					data: formData,
					type: 'POST',
					success: function(data) {
		            	if(JSON.parse(data).result > 0) {
		            		swalSuccess("업로드 되었습니다.");
		            		$("#search_btn").trigger("click");
						} else {
							swalWarning("업로드가 진행되지 않았습니다. 엑셀 데이터 확인 후 다시 업로드 해주십시오.");
						}
					},
					beforeSend:function() {
						$('.wrap-loading').removeClass('display-none');
					},
					complete:function() {
						$('.wrap-loading').addClass('display-none');
					},
					error:function(request,status,error) {
						console.error("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
						if(error.status == "200") {
							location.href = "/core/login/sessionOut.do";
						}
						if(error.status == "402") {	//인터셉터-밸리데이션 이슈
							swalWarning(error.responseJSON.icm_validation_message);
						}
						if(error.status == "403") {
							location.href = "/core/login/sessionOut.do";
						}
						if(error.status == "500") {
							swalDanger("엑셀업로드가 실패했습니다.\n아래의 사항 조치 후 재시도 해주십시오.\n\n1.올바른 엑셀템플릿인지 확인\n2.중복 코드(PK) 삽입여부 확인\n3.입력된 엑셀데이터 길이 확인\n4.데이터 마지막행 이후 모든 행 삭제");
						}
						swalDangerCB("엑셀업로드에 실패하였습니다.\n관리자에게 문의해주세요.");
					}
				});
			}
	
		</script>

</body>