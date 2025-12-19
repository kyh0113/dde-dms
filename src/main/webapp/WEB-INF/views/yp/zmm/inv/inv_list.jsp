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

<style type="text/css">
.table td, .table th, .lst th, .lst td {
	height: 25.05px;
}

@page { size: A4 landscape; margin:0; }   //A4 가로 출력
@media print {
     .page-divide {
            page-break-after: always;
     }
}
</style>

<script language='javascript'>

    function getInputDayLabel(tp) {

        var week = new Array('일', '월', '화', '수', '목', '금', '토');
        
        var today = new Date(tp).getDay();
        var todayLabel = week[today];

        return todayLabel;
    }

    function print(printArea)

    {

    win = window.open(); 

    self.focus(); 

    win.document.open();

    /*

    1. div 안의 모든 태그들을 innerHTML을 사용하여 매개변수로 받는다.

    2. window.open() 을 사용하여 새 팝업창을 띄운다.

    3. 열린 새 팝업창에 기본 <html><head><body>를 추가한다.

    4. <body> 안에 매개변수로 받은 printArea를 추가한다.

    5. window.print() 로 인쇄

    6. 인쇄 확인이 되면 팝업창은 자동으로 window.close()를 호출하여 닫힘

    */

    win.document.write('<html><head><title></title><style>');

    win.document.write('body, td {font-falmily: Verdana; font-size: 10pt; .parent {display: flex;}.child {flex: 1;}}');

    win.document.write('</style></head><body>');

    win.document.write(printArea);

    win.document.write('</body></html>');

    win.document.close();

    win.print();

    win.close();

    }
</script>

</head>
<body>
	<!-- 20191023_khj for csrf -->
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<h2>
	주요 재고 현황(속보)
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
						<th>기준일자</th>
						<td>
							<input class="calendar search_dtp" type="text" name="CHK_DT" id="CHK_DT" value="${today}" readonly="readonly">
						</td>
					</tr>
				</table>
				<div class="btn_wrap">
					<!-- <input type="button" class="btn btn_make" id="print_btn" value="인쇄" OnClick="print(document.getElementById('printArea').innerHTML);" />
					<input type="button" class="btn btn_excel" id="excel_btn" value="엑셀 다운로드" /> -->
					<input type="button" class="btn btn_search" id="search_btn" value="조회" />
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
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;" bgcolor="whitesmoke">'+addComma(obj.EXTIN_INV)+'</td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;" bgcolor="whitesmoke">'+addComma(obj.CAKE_C)+'</td>';
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
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
							innerHtml += '	<td style="text-align: right; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
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
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">수출대기, 선출고, 판매 미처리분等 포함</td>';
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
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;" bgcolor="whitesmoke">'+obj.EXTIN_INV_B+'</td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;" bgcolor="whitesmoke">'+obj.CAKE_C_B+'</td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">'+obj.CATHODE_H_B+'</td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">'+obj.CATHODE_L_B+'</td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">'+obj.ZINC_A_B+'</td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">'+obj.ZINC_C_B+'</td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">'+obj.ZINC_S_B+'</td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">'+obj.ZINC_T_B+'</td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;" bgcolor="whitesmoke"></td>';
							innerHtml2 += '	<td style="text-align: left; vertical-align: middle; display: block;">수출대기, 선출고, 판매 미처리분等 포함</td>';
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
			
			
			/****************************************엑셀 다운로드 공통 시작****************************************/		
			$("#excel_btn").click(function(e){
				//if(scope.gridOptions.data.length > 0) {	//그리드 데이터 존재여부 확인
					//var query_name = "yp_zmm.select_tbl_inv_list";	//다운 받을 엑셀쿼리명
					//var excel_name = "주요재고현황";							//다운 받을 엑셀파일명
					//excelDownload('/core/excel/excelDownloadWithQuery.do', $("#frm").serializeArray(), {list:query_name, excel_name:excel_name});	//url, 조회영역 폼(폼 이름 확인), 필수파라메터
				//} else {
					//swalWarningCB("조회된 데이터가 없습니다.\n1건 이상의 데이터만 엑셀다운로드 가능 합니다.");
				//}

				//20191023_khj for csrf
				var csrf_element = document.createElement("input");
				csrf_element.name = "_csrf";
				csrf_element.value = "${_csrf.token}";
				csrf_element.type = "hidden";
				//20191023_khj for csrf
				
				//BASE_YYYY
				var base_yyyy_element = document.createElement("input");
				base_yyyy_element.name = "BASE_YYYY";
				base_yyyy_element.value = $("#BASE_YYYY").val();
				base_yyyy_element.type = "hidden";
				//VENDOR_CODE
				var vendor_code_element = document.createElement("input");
				vendor_code_element.name = "VENDOR_CODE";
				vendor_code_element.value = $("#VENDOR_CODE option:selected").val();
				vendor_code_element.type = "hidden";
				
				var xlsForm = document.createElement("form");
	
				xlsForm.target = "xlsx_download";
				xlsForm.name = "sndFrm";
				xlsForm.method = "post";
				xlsForm.action = "/yp/xls/zwc/rpt/zwc_rpt_intervention";
	
				document.body.appendChild(xlsForm);
	
				xlsForm.appendChild(csrf_element);
				xlsForm.appendChild(base_yyyy_element);
				xlsForm.appendChild(vendor_code_element);

				xlsForm.submit();
				xlsForm.remove();
			});

			/****************************************엑셀 다운로드 공통  끝  ****************************************/

		</script>

	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
</body>