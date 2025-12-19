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
<title>주요재고현황</title>
<script type="text/javascript" src="/resources/yp/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="/resources/yp/js/printThis.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
<style type="text/css">
body
{
  margin: 0 auto;
  width: 1700px;
}
.table td, .table th {
	height: 28.05px;
}
.lst td {
    border: 1px solid #ddd;
    text-align: center;
    height: 28px;
}
</style>

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
	주요 재고 현황(속보)
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
							<input type="text" name="CHK_DT" id="CHK_DT" value="${today}" readonly="readonly">
						</td>
					</tr>
				</table>
				<div class="btn_wrap">
					<!-- <input type="button" class="btn btn_make" id="search_btn1" value="인쇄" />
					<input type="button" class="btn btn_excel" id="search_btn1" value="엑셀 다운로드" /> 
					<input type="button" class="btn btn_search" id="search_btn" value="조회" /> -->
				</div>
			</div>
		</section>
		
		<div class="float_wrap">
			<div class="fl">
				<div class="stitle">재고현황</div>
			</div>
			<div class="fr">
				<div class="btn_wrap">
					(단위 : DMT, 톤)
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
		</style>

		<div class="parent">
			<section class="section">
				<div class="lst" style="background: none;">
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
						<td colspan="2">소광재고</td>
					</tr>
					<tr>
						<td rowspan="1" style="text-align: center; vertical-align: middle;"><b>Cake</b></td>
						<td colspan="2">Conv. Cake 재고</td>
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
						<td colspan="2" style="text-align: center; vertical-align: middle;">* 석포 외 재고</td>
					</tr>
					<tr>
						<td colspan="2" bgcolor="whitesmoke">합 계</td>
					</tr>
				</table>
				</div>
			</section>
			<section class="section">
				<div class="lst" style="background: none;">
				<table cellspacing="1" cellpadding="0" class="table">
				</table>
				</div>
			</section>
			<section class="section" style="width:300px">
				<div class="lst" style="background: none;">
				<table cellspacing="1" cellpadding="0" class="table2">
				</table>
				</div>
			</section>
		</div>

		<div class="float_wrap">
			<div class="fl">
				<div><br><b>* 석포 외 재고 중 현대1, 동부항 약 5,000 톤은 월 마감, 일괄 판매 처리하고 있으며 수출향도 판매 처리시점에 따라 재고차이 발생 가능.</b></div>
			</div>
		</div>

		<script>

			$(document).ready(function() {

		        var token = $("meta[name='_csrf']").attr('content');
		        var header = $("meta[name='_csrf_header']").attr('content');

		        if(token && header) {
		            $(document).ajaxSend(function(event, xhr, options) {
		                xhr.setRequestHeader(header, token);
		            });
		        }

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

						//if(list.length > 0){
							
						var cal = 7-list.length;

						for(var i=0; i < list.length; i++) {
							var obj = list[i];
							innerHtml += '<tr style="display: block; float: left; width:130px;">';
							innerHtml += '	<input type="hidden" class="inv_table_inputs" id="CREATE_DT" name="CREATE_DT" data-row="'+i+'" value="'+obj.CHK_DT+'" CREATE_DT="'+obj.CHK_DT+'"/>';
							innerHtml += '	<td style="text-align: center; vertical-align: middle; display: block;" bgcolor="whitesmoke"><b>'+obj.CHK_DD1+'/'+obj.CHK_DD2+' ('+obj.CHK_YOIL+')</b></td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;">'+addComma(obj.CONCENT_T)+'</td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;">'+addComma(obj.CONCENT_D)+'</td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;">'+addComma(obj.CONCENT_S)+'</td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;" bgcolor="whitesmoke">'+addComma(obj.CONCENT_SUM)+'</td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;">'+addComma(obj.PROD_C)+'</td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;">'+addComma(obj.PROD_I)+'</td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;">'+addComma(obj.EXTIN_INV)+'</td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;">'+addComma(obj.CAKE_C)+'</td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;">'+addComma(obj.CATHODE_H)+'</td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;">'+addComma(obj.CATHODE_L)+'</td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;" bgcolor="whitesmoke">'+addComma(obj.CATHODE_SUM)+'</td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;">'+addComma(obj.ZINC_A)+'</td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;">'+addComma(obj.ZINC_C)+'</td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;">'+addComma(obj.ZINC_S)+'</td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;">'+addComma(obj.ZINC_T)+'</td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;" bgcolor="whitesmoke">'+addComma(obj.ZINC_SUM)+'</td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;">'+addComma(obj.ZINC_EX)+'</td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;" bgcolor="whitesmoke">'+addComma(obj.ZINC_TOT)+'</td>';
							innerHtml += '</tr>';
						}

						for (var j=cal; j >= 1; j--) {

							var now = new Date(document.getElementById('CHK_DT').value);
							var yesterday = new Date(now.setDate(now.getDate() - j));
							var str = formatDate_d(yesterday);
							var cal_yy = str.toString().substr(0,4)
							var cal_mm = str.toString().substr(4,2)
							var cal_dd = str.toString().substr(6,2)
							var cal_day = cal_yy+"-"+cal_mm+"-"+cal_dd

							innerHtml += '<tr style="display: block; float: left; width:130px;">';
							innerHtml += '	<td style="display: block;" bgcolor="whitesmoke"><b>'+cal_mm+'/'+cal_dd+' ('+getInputDayLabel(cal_day)+')</b></td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;"></td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;"></td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;"></td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;"></td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;"></td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;"></td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;"></td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;"></td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;"></td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;"></td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;"></td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;"></td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;"></td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;"></td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
							innerHtml += '</tr>';
						}

						$('.table').append(innerHtml);

						if(list2 === null) {
							innerHtml2 += '<tr style="display: block; float: left;">';
							innerHtml2 += '	<td style="text-align: center; vertical-align: middle; display: block;" bgcolor="whitesmoke"><b>비고</b></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">수출대기, 선출고, 판매 미처리분 포함</td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
							innerHtml2 += '</tr>';
						} else {
							innerHtml2 += '<tr style="display: block; float: left;">';
							innerHtml2 += '	<td style="text-align: center; vertical-align: middle; display: block;" bgcolor="whitesmoke"><b>비고</b></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">'+obj.CONCENT_T_B+'</td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">'+obj.CONCENT_D_B+'</td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">'+obj.CONCENT_S_B+'</td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">'+obj.PROD_C_B+'</td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">'+obj.PROD_I_B+'</td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">'+obj.EXTIN_INV_B+'</td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">'+obj.CAKE_C_B+'</td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">'+obj.CATHODE_H_B+'</td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">'+obj.CATHODE_L_B+'</td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">'+obj.ZINC_A_B+'</td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">'+obj.ZINC_C_B+'</td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">'+obj.ZINC_S_B+'</td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">'+obj.ZINC_T_B+'</td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">수출대기, 선출고, 판매 미처리분 포함</td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
							innerHtml2 += '</tr>';
						}

						$('.table2').append(innerHtml2);

						//} else {
							//swalDangerCB("데이터가 없습니다.");
						//}
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
						console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
						//swalDangerCB("조회 실패하였습니다.\n관리자에게 문의해주세요.");
					}
				});
			});

			//테이블 초기화
			function tableInit() {
				//table tr 초기화
				$(".table tr").remove();
				$(".table2 tr").remove();
			}

			/*콤마 추가*/
			function addComma(num) {
				return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			}

			function formatDate_d(date) {
				var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
				if (month.length < 2)
					month = '0' + month;
				if (day.length < 2)
					day = '0' + day;
				return [ year, month, day ].join('');
			}
		</script>

</body>