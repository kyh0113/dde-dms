<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<sec:csrfMetaTags />
<title>월별청소실적현황</title>
<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
<script type="text/javascript" src="/resources/icm/js/custom.js"></script>
<script type="text/javascript" src="/resources/icm/js/jquery.form.js"></script>
<script src="/resources/icm/js/bootstrap.min.js"></script>
<script src="/resources/icm/datepicker/js/bootstrap-datepicker.js"></script>
<link href="/resources/icm/datepicker/css/datepicker.css" rel="stylesheet" type="text/css" />
<link id="bs-css" href="/resources/icm/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/yp/css/style.css">
<!-- 기존 프레임워크 리소스 -->
<!-- 영풍 리소스 -->
<script src="/resources/yp/js/common.js"></script>

<script language='javascript'>

</script>

<style type="text/css">
	.table td, .table th, .lst th, .lst td {
		height: 25.05px;
	}
</style>

</head>
<body>
	<!-- 20191023_khj for csrf -->
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />

	<!-- <div class="stitle">기본정보</div> -->
	<form id="frm" name="frm" method="post">
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
						<th><b>연도</b></th>
						<td>
							<select name="ser_yy" id="ser_yy">
								<option value="2023">2023</option>
								<option value="2024" selected />2024</option>
								<option value="2025">2025</option>
								<option value="2026">2026</option>
								<option value="2027">2027</option>
								<option value="2028">2028</option>
								<option value="2029">2029</option>
								<option value="2030">2030</option>
							</select>
						<th><b>전해조 월별 청소 실적현황</b></th>
						</td>
					</tr>
				</table>
				<div class="btn_wrap">
					<input type="button" class="btn btn_search" id="search_btn" value="조회" />
				</div>
			</div>
		</section>

		<style>
			.parent {
			    display: flex;
			}
			.child {
			    flex: 1;
			}
		</style>
		
		<div class="parent">
			<section>
				<div class="lst" style="background: none;">
				<table cellspacing="1" cellpadding="0" style="width:1200px" class="table">
				</table>
				</div>
			</section>
		</div>
		</form>

		<div class="float_wrap">
			<div class="fl">
				<div style="float:left; margin:10px;"><br><b>* 전해조 월별 청소 실적현황의 수치는 월 기준으로 (청소경과일 합계 / 각 공장, 계열, 열별 기준임)</b></div>
			</div>
		</div>

		<script>

			$(document).ready(function() {

				$("#search_btn").trigger("click");
			});

			// 조회
			$("#search_btn").on("click", function() {

				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");

				$.ajax({
					url : "/yp/zpp/cre/select_tbl_cre_list_pop",
					type : "POST",
					cache : false,
					async : false,
					dataType: "json",
					data : {
						ser_yy : $("#ser_yy").val(),
						//ser_mm : $("#ser_mm").val()
					},
					success: function(data) {
						//테이블 초기화
						tableInit();
						var innerHtml = "";
						var list = data.list1;

						innerHtml += '<tr>';
						innerHtml += 	'<td rowspan="2" style="text-align: center; vertical-align: middle; width:120px;" bgcolor="whitesmoke"><b>월</b></td>';
						innerHtml += 	'<td colspan="2" style="text-align: center; vertical-align: middle;" bgcolor="whitesmoke"><b>#1</b></td>';
						innerHtml += 	'<td colspan="2" style="text-align: center; vertical-align: middle;" bgcolor="whitesmoke"><b>#2</b></td>';
						innerHtml += 	'<td colspan="2" style="text-align: center; vertical-align: middle;" bgcolor="whitesmoke"><b>#3</b></td>';
						innerHtml += 	'<td colspan="2" style="text-align: center; vertical-align: middle;" bgcolor="whitesmoke"><b>#4</b></td>';
						innerHtml += 	'<td colspan="2" style="text-align: center; vertical-align: middle;" bgcolor="whitesmoke"><b>#5</b></td>';
						innerHtml += 	'<td colspan="2" style="text-align: center; vertical-align: middle;" bgcolor="whitesmoke"><b>#6</b></td>';
						innerHtml += 	'<td colspan="2" style="text-align: center; vertical-align: middle;" bgcolor="whitesmoke"><b>#7</b></td>';
						innerHtml += '</tr>';
						innerHtml += '<tr>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle; bgcolor="whitesmoke"><b>남</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle; bgcolor="whitesmoke"><b>북</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle; bgcolor="whitesmoke"><b>남</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle; bgcolor="whitesmoke"><b>북</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle; bgcolor="whitesmoke"><b>남</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle; bgcolor="whitesmoke"><b>북</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle; bgcolor="whitesmoke"><b>남</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle; bgcolor="whitesmoke"><b>북</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle; bgcolor="whitesmoke"><b>남</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle; bgcolor="whitesmoke"><b>북</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle; bgcolor="whitesmoke"><b>남</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle; bgcolor="whitesmoke"><b>북</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle; bgcolor="whitesmoke"><b>남</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle; bgcolor="whitesmoke"><b>북</b></td>';
						innerHtml += '</tr>';

						var sum_A1 = 0;
						var sum_B1 = 0;
						var sum_A2 = 0;
						var sum_B2 = 0;
						var sum_A3 = 0;
						var sum_B3 = 0;
						var sum_A4 = 0;
						var sum_B4 = 0;
						var sum_A5 = 0;
						var sum_B5 = 0;
						var sum_A6 = 0;
						var sum_B6 = 0;
						var sum_A7 = 0;
						var sum_B7 = 0;

						var cnt_A1 = 0;
						var cnt_B1 = 0;
						var cnt_A2 = 0;
						var cnt_B2 = 0;
						var cnt_A3 = 0;
						var cnt_B3 = 0;
						var cnt_A4 = 0;
						var cnt_B4 = 0;
						var cnt_A5 = 0;
						var cnt_B5 = 0;
						var cnt_A6 = 0;
						var cnt_B6 = 0;
						var cnt_A7 = 0;
						var cnt_B7 = 0;

						var tot_A1 = 0;
						var tot_B1 = 0;
						var tot_A2 = 0;
						var tot_B2 = 0;
						var tot_A3 = 0;
						var tot_B3 = 0;
						var tot_A4 = 0;
						var tot_B4 = 0;
						var tot_A5 = 0;
						var tot_B5 = 0;
						var tot_A6 = 0;
						var tot_B6 = 0;
						var tot_A7 = 0;
						var tot_B7 = 0;

						//if(list.length > 0) {
						for(var i=0; i < list.length; i++) {
							var obj = list[i];
							
							if(obj.A1 == null) {
								obj.A1 = 0;
							}
							if(obj.B1 == null) {
								obj.B1 = 0;
							}
							if(obj.A2 == null) {
								obj.A2 = 0;
							}
							if(obj.B2 == null) {
								obj.B2 = 0;
							}
							if(obj.A3 == null) {
								obj.A3 = 0;
							}
							if(obj.B3 == null) {
								obj.B3 = 0;
							}
							if(obj.A4 == null) {
								obj.A4 = 0;
							}
							if(obj.B4 == null) {
								obj.B4 = 0;
							}
							if(obj.A5 == null) {
								obj.A5 = 0;
							}
							if(obj.B5 == null) {
								obj.B5 = 0;
							}
							if(obj.A6 == null) {
								obj.A6 = 0;
							}
							if(obj.B6 == null) {
								obj.B6 = 0;
							}
							if(obj.A7 == null) {
								obj.A7 = 0;
							}
							if(obj.B7 == null) {
								obj.B7 = 0;
							}

							sum_A1 += obj.A1;
							sum_B1 += obj.B1;
							sum_A2 += obj.A2;
							sum_B2 += obj.B2;
							sum_A3 += obj.A3;
							sum_B3 += obj.B3;
							sum_A4 += obj.A4;
							sum_B4 += obj.B4;
							sum_A5 += obj.A5;
							sum_B5 += obj.B5;
							sum_A6 += obj.A6;
							sum_B6 += obj.B6;
							sum_A7 += obj.A7;
							sum_B7 += obj.B7;

							if(obj.A1 > 0) {
								cnt_A1 = cnt_A1+1
							}
							if(obj.B1 > 0) {
								cnt_B1 = cnt_B1+1
							}
							if(obj.A2 > 0) {
								cnt_A2 = cnt_A2+1
							}
							if(obj.B2 > 0) {
								cnt_B2 = cnt_B2+1
							}
							if(obj.A3 > 0) {
								cnt_A3 = cnt_A3+1
							}
							if(obj.B3 > 0) {
								cnt_B3 = cnt_B3+1
							}
							if(obj.A4 > 0) {
								cnt_A4 = cnt_A4+1
							}
							if(obj.B4 > 0) {
								cnt_B4 = cnt_B4+1
							}
							if(obj.A5 > 0) {
								cnt_A5 = cnt_A5+1
							}
							if(obj.B5 > 0) {
								cnt_B5 = cnt_B5+1
							}
							if(obj.A6 > 0) {
								cnt_A6 = cnt_A6+1
							}
							if(obj.B6 > 0) {
								cnt_B6 = cnt_B6+1
							}
							if(obj.A7 > 0) {
								cnt_A7 = cnt_A7+1
							}
							if(obj.B7 > 0) {
								cnt_B7 = cnt_B7+1
							}

							innerHtml += '<tr>';
							innerHtml += 	'<td style="text-align: center; vertical-align: middle;" bgcolor="whitesmoke"><b>'+obj.MM+'</b></td>';
							innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+obj.A1+'</b></td>';
							innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+obj.B1+'</b></td>';
							innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+obj.A2+'</b></td>';
							innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+obj.B2+'</b></td>';
							innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+obj.A3+'</b></td>';
							innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+obj.B3+'</b></td>';
							innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+obj.A4+'</b></td>';
							innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+obj.B4+'</b></td>';
							innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+obj.A5+'</b></td>';
							innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+obj.B5+'</b></td>';
							innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+obj.A6+'</b></td>';
							innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+obj.B6+'</b></td>';
							innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+obj.A7+'</b></td>';
							innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+obj.B7+'</b></td>';
							innerHtml += '</tr>';

						}

						tot_A1 = Math.round(sum_A1/cnt_A1);
						tot_B1 = Math.round(sum_B1/cnt_B1);
						tot_A2 = Math.round(sum_A2/cnt_A2);
						tot_B2 = Math.round(sum_B2/cnt_B2);
						tot_A3 = Math.round(sum_A3/cnt_A3);
						tot_B3 = Math.round(sum_B3/cnt_B3);
						tot_A4 = Math.round(sum_A4/cnt_A4);
						tot_B4 = Math.round(sum_B4/cnt_B4);
						tot_A5 = Math.round(sum_A5/cnt_A5);
						tot_B5 = Math.round(sum_B5/cnt_B5);
						tot_A6 = Math.round(sum_A6/cnt_A6);
						tot_B6 = Math.round(sum_B6/cnt_B6);
						tot_A7 = Math.round(sum_A7/cnt_A7);
						tot_B7 = Math.round(sum_B7/cnt_B7);
						
						if (isNaN(tot_A1)) { // 값이 없어서 NaN값이 나올 경우
							tot_A1 = 0;
						}
						if (isNaN(tot_B1)) { // 값이 없어서 NaN값이 나올 경우
							tot_B1 = 0;
						}
						if (isNaN(tot_A2)) { // 값이 없어서 NaN값이 나올 경우
							tot_A2 = 0;
						}
						if (isNaN(tot_B2)) { // 값이 없어서 NaN값이 나올 경우
							tot_B2 = 0;
						}
						if (isNaN(tot_A3)) { // 값이 없어서 NaN값이 나올 경우
							tot_A3 = 0;
						}
						if (isNaN(tot_B3)) { // 값이 없어서 NaN값이 나올 경우
							tot_B3 = 0;
						}
						if (isNaN(tot_A4)) { // 값이 없어서 NaN값이 나올 경우
							tot_A4 = 0;
						}
						if (isNaN(tot_B4)) { // 값이 없어서 NaN값이 나올 경우
							tot_B4 = 0;
						}
						if (isNaN(tot_A5)) { // 값이 없어서 NaN값이 나올 경우
							tot_A5 = 0;
						}
						if (isNaN(tot_B5)) { // 값이 없어서 NaN값이 나올 경우
							tot_B5 = 0;
						}
						if (isNaN(tot_A6)) { // 값이 없어서 NaN값이 나올 경우
							tot_A6 = 0;
						}
						if (isNaN(tot_B6)) { // 값이 없어서 NaN값이 나올 경우
							tot_B6 = 0;
						}
						if (isNaN(tot_A7)) { // 값이 없어서 NaN값이 나올 경우
							tot_A7 = 0;
						}
						if (isNaN(tot_B7)) { // 값이 없어서 NaN값이 나올 경우
							tot_B7 = 0;
						}

						innerHtml += '<tr>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;" bgcolor="whitesmoke"><b>합계</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+sum_A1+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+sum_B1+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+sum_A2+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+sum_B2+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+sum_A3+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+sum_B3+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+sum_A4+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+sum_B4+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+sum_A5+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+sum_B5+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+sum_A6+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+sum_B6+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+sum_A7+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+sum_B7+'</b></td>';
						innerHtml += '</tr>';

						innerHtml += '<tr>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;" bgcolor="whitesmoke"><b>계(평균)</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+tot_A1+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+tot_B1+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+tot_A2+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+tot_B2+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+tot_A3+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+tot_B3+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+tot_A4+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+tot_B4+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+tot_A5+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+tot_B5+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+tot_A6+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+tot_B6+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+tot_A7+'</b></td>';
						innerHtml += 	'<td style="text-align: center; vertical-align: middle;"><b>'+tot_B7+'</b></td>';
						innerHtml += '</tr>';

						$('.table').append(innerHtml);
						
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
				$(".table tr").remove();
			}

		</script>

	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
</body>