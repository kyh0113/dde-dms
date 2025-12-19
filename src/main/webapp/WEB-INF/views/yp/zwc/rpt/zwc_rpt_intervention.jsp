<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
if (request.getProtocol().equals("HTTP/1.1")) {
	response.setHeader("Cache-Control", "no-cache");
}

Date today = new Date();
SimpleDateFormat date = new SimpleDateFormat("yyyy");
int to_yyyy = Integer.parseInt(date.format(today));
// JSTL에서 사용할 수 있도록 세팅
request.setAttribute("to_yyyy", to_yyyy);

Calendar cal = Calendar.getInstance();
cal.set(Calendar.YEAR, 2010);
int from_yyyy = Integer.parseInt(date.format(cal.getTime()));
//JSTL에서 사용할 수 있도록 세팅
request.setAttribute("from_yyyy", from_yyyy);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>계약별 조정(안)</title>
<style type="text/css">
.table td, .table th {
	padding: 0.4rem !important;
}
</style>
</head>
<body>
	<h2>
		계약별 조정(안)
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
					<th>연도</th>
					<td>
						<input type="text" id="BASE_YYYY" class="calendar search_dtp_y" value="${to_yyyy}" readonly="readonly"/>
<!-- 						<select id="BASE_YYYY" name="BASE_YYYY"> -->
<%-- 							<c:forEach var="i" begin="0" end="${to_yyyy - from_yyyy}"> --%>
<%-- 								JSTL 역순 출력 - 연도 --%>
<%-- 								<c:set var="yearOption" value="${to_yyyy - i}" /> --%>
<%-- 								<option value="${yearOption}">${yearOption}</option> --%>
<%-- 							</c:forEach> --%>
<!-- 						</select>  -->
					</td>
					<th>거래처</th>
					<td >
						<select id="VENDOR_CODE" name="VENDOR_CODE">
						<c:forEach items="${cb_working_master_v}" var="data">
							<option value="${data.CODE}">${data.CODE_NAME}</option>
						</c:forEach>
						</select>
					</td>
					<th></th>
					<td></td>
				</tr>
			</table>
			<div class="btn_wrap">
				<input type="button" class="btn btn_make" id="excel_btn" value="엑셀 다운로드"/>
				<input type="button" class="btn btn_search" id="search_btn" value="조회"/>
			</div>
		</div>
	</section>
	
	<div class="float_wrap" style="margin-bottom: 2px;">
		<div class="fl">
			<div class="btn_wrap">
				※비조업 시간외수당 항목의 조정안 월도급비 계산은 <span style="background-color: #ffcc66;">　　　</span> 색상의 영역(조정안 물량)에서 엔터키를 누르세요. <span style="font-style: italic;">※저장후 다시 조회됩니다.</span>
			</div>
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type="button" class="btn_g" id="total_btn" value="집계"/>
				<input type="button" class="btn_g" id="save_btn" value="저장"/>
			</div>
		</div>
	</div>
	<section class="section">
		<form id="frm" name="frm" method="post">
			<!-- 20191023_khj for csrf -->
			<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="BASE_YYYY" />
			<input type="hidden" name="VENDOR_CODE" />
			<div class="tbl_box">
				<table border="1" class="table">
					<colgroup>
						<col />
						<col />
						<col />
						<col />
						<col />
						<col />
						<col />
						<col />
						<col />
						<col />
						<col />
						<col />
						<col />
						<col />
					</colgroup>
					<tr class="tb-head" >
						<td rowspan="2" style="color:white">구분</td>
						<td rowspan="2" style="color:white">작업명</td>
						<td rowspan="2" style="color:white">팀별</td>
						<td rowspan="2" style="color:white">단위</td>
						<td colspan="4" style="color:white">현행</td>
						<td colspan="4" style="color:white">조정안</td>
						<td rowspan="2" style="color:white">증감률</td>
						<td rowspan="2" style="color:white">비고</td>
				    </tr>
				    <tr class="tb-head">
						<td style="color:white">인원</td>
						<td style="color:white">단가</td>
						<td style="color:white">물량</td>
						<td style="color:white">월도급비</td>
						<td style="color:white">인원</td>
						<td style="color:white">단가</td>
						<td style="color:white">물량</td>
						<td style="color:white">월도급비</td>
				    </tr>
				</table>
			</div>
		</form>
	</section>
	<script>
	$(document).ready(function() {
		$(".search_dtp_y").datepicker({
			format: " yyyy",
			viewMode: "years",
			minViewMode: "years",
			language : "ko",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		}).on('changeDate', function(e) {
			$(this).val(formatDate_y(e.date.valueOf())).trigger("change");
			$("#search_btn").trigger("click");
			$('.datepicker').hide();
		});
	});
		/****************************************엑셀 다운로드 공통 시작****************************************/		
		$("#excel_btn").click(function(e){
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
	
				/* var pr = gPostArray($("#frm").serializeArray());
	
				$.each(pr, function(k, v) {
					console.log(k, v);
					var el = document.createElement("input");
					el.name = k;
					el.value = v;
					el.type = "hidden";
					xlsForm.appendChild(el);
				}); */
	
				xlsForm.submit();
				xlsForm.remove();
				//$('.wrap-loading').removeClass('display-none');
				//setTimeout(function() {
				//	$('.wrap-loading').addClass('display-none');
				//}, 5000); //5초
		});
		/****************************************엑셀 다운로드 공통  끝  ****************************************/
		var json_for_tbl_working_subc_cost_basis = new Array();
		// 조회
		$("#search_btn").on("click", function() {
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			var BASE_YYYY = $("#BASE_YYYY").val().trim();
			var VENDOR_CODE = $("#VENDOR_CODE option:selected").val();
			var data = {'BASE_YYYY':BASE_YYYY, 'VENDOR_CODE':VENDOR_CODE, '${_csrf.parameterName}' : '${_csrf.token}'};
			$.ajax({
				url: "/yp/zwc/rpt/select_zwc_rpt_intervention_list",
			    type: "POST",
			    cache:false,
			    async:true, 
			    dataType:"json",
			    data:data, //폼을 그리드 파라메터로 전송
			    success: function(data) {
			    	json_for_tbl_working_subc_cost_basis = new Array();
			    	//테이블 초기화
			    	tableInit();
			    	
			    	//도금비 조정안 리스트
			    	var rpt_intervention_list = data.rpt_intervention_list;
			    	//도금비 조정안 데이터 없을경우, return
			    	if(rpt_intervention_list.length == 0){
			    		return;
			    	}
			    	
			    	//-------구분 별로 세로로 묶기위한 변수 ------------------------
			    	//구분별로 몇개 row있는지에 대한 정보 list
			    	var rpt_gubun_list = data.rpt_gubun_list;
			    	
			    	//현재 구분에서 몇번째 위치인지 판별
			    	var count = 0;
			    	//현재 진행중인 구분이 몇번째인지 판별
			    	var gubun_pos = 0;
			    	//현재 구분이 몇번 반복되는지 판별
			    	var gubun_cnt = rpt_gubun_list[gubun_pos].CNT;
			    	//-----------------------------------------------
			    	
			    	//---------소계 합계 변수 -----------------------------
			    	var sub_total_current_man_qty = 0;	//소계 현행 인원
			    	var sub_total_current_cost = 0;		//소계 현행 월도급비
					var sub_total_adjust_man_qty = 0;	//소계 조정안 인원
					var sub_total_adjust_cost = 0;	//소계 조정안 월도급비
					var sub_total_variation_rate = 0;	//소계 증감률
					
					var sum_total_current_man_qty = 0;	//합계 현행 인원
			    	var sum_total_current_cost = 0;		//합계 현행 월도급비
					var sum_total_adjust_man_qty = 0;	//합계 조정안 인원
					var sum_total_adjust_cost = 0;	//합계 조정안 월도급비
					var sum_total_variation_rate = 0;	//합계 증감률
			    	//--------------------------------------------------
			    	
			    	//----------비고 저장을 위한 TBL_WORKING_SUBC_COST_ADJUST테이블의 PK 변수들 ----------------
			    	var BASE_YYYY;
					var VENDOR_CODE;
					var VENDOR_NAME;
					var CONTRACT_CODE;
					var CONTRACT_NAME;
					//-----------------------------------------------------------------------------------

			    	//도급비 조정안 row
			    	for(var i=0; i<rpt_intervention_list.length; i++){
			    		
			    		var obj = rpt_intervention_list[i];
			    		var innerHtml = "";
			    		
			    		// 2020-10-08 jamerl - 조업계약, 저장품 링크 제거
			    		var GUBUN_CODE = obj.GUBUN_CODE;
			    		var WORKING_GUBUN = obj.WORKING_GUBUN;
			    		var CONTRACT_TYPE = obj.CONTRACT_TYPE;
			    		
			    		// 2020-10-15 jamerl - 비조업 시간외 조정안 저장 데이터 세팅
			    		json_for_tbl_working_subc_cost_basis.push({
			    			BASE_YYYY: obj.BASE_YYYY,
			    			VENDOR_CODE: obj.VENDOR_CODE,
			    			CONTRACT_CODE: obj.CONTRACT_CODE,
			    			CURRENT_SUBCONTRACTING_COST: obj.CURRENT_SUBCONTRACTING_COST,
			    			ADJUST_UNIT_PRICE: obj.ADJUST_UNIT_PRICE,
			    			ADJUST_QUANTITY: obj.ADJUST_QUANTITY,
			    			ADJUST_SUBCONTRACTING_COST: obj.ADJUST_SUBCONTRACTING_COST,
			    			ADJUST_SUBCONTRACTING_COST_OLD: obj.ADJUST_SUBCONTRACTING_COST
			    		});
			    		
			    		//증감률 = (조절안 월도급비 - 현행월도급비)/(조정안 월도급비) * 100
			    		var variation_rate = 0;
			    		//조정안 월도급비가 0이 아닐경우에만 증감률 계산 
			    		if(obj.CURRENT_SUBCONTRACTING_COST != 0){
			    			variation_rate = (obj.ADJUST_SUBCONTRACTING_COST - obj.CURRENT_SUBCONTRACTING_COST) / obj.CURRENT_SUBCONTRACTING_COST * 100;
			    		}
			    		
			    		//다음 구분으로 넘어갈때
			    		//count초기화
			    		//다음 구분은 몇번 반복되는지 계산
			    		//소계 만들어주기
			    		if(i != 0 && count == rpt_gubun_list[gubun_pos].CNT){
			    			count = 0;
			    			gubun_pos++;
			    			gubun_cnt = rpt_gubun_list[gubun_pos].CNT;
			    			//소계 증감률
			    			if(sum_total_current_cost != 0){
				    			sub_total_variation_rate = (sub_total_adjust_cost - sub_total_current_cost) / sub_total_current_cost * 100;
			    			}
			    			//합계 증감률
			    			if(sum_total_current_cost != 0){
								sum_total_variation_rate = (sum_total_adjust_cost - sum_total_current_cost) / sum_total_current_cost * 100;
			    			}
			    			//소계 만들어주기
			    			innerHtml = "";
			    			innerHtml += '<tr class="sub_total '+gubun_pos+'">';
			    			innerHtml += '	<td class="center vertical-center">소계</td>';
			    			innerHtml += '	<td></td>';
			    			innerHtml += '	<td></td>';
			    			innerHtml += '	<td class="center vertical-center">'+sub_total_current_man_qty+'</td>';	//소계 현행 인원
			    			innerHtml += '	<td></td>';
			    			innerHtml += '	<td></td>';
			    			innerHtml += '	<td class="right vertical-center SUB_CURRENT_SUBCONTRACTING_COST">'+ addComma(sub_total_current_cost) +'</td>';		//소계 현행 월도급비
			    			innerHtml += '	<td class="center vertical-center">'+sub_total_adjust_man_qty+'</td>';	//소계 조정안 인원
			    			innerHtml += '	<td></td>';
			    			innerHtml += '	<td></td>';
			    			innerHtml += '	<td class="right vertical-center SUB_ADJUST_SUBCONTRACTING_COST">'+ addComma(sub_total_adjust_cost) +'</td>';		//소계 조정안 월도급비
			    			innerHtml += '	<td class="center vertical-center SUB_VARIATION_RATE">'+sub_total_variation_rate+' %</td>';//소계 증감률
			    			innerHtml += '	<td></td>';
			    			innerHtml += '</tr>';
			    			$('.table').append(innerHtml);
			    			
			    			//---------소계 합계 변수 초기화 ---------
			    			sub_total_current_man_qty = 0;	
					    	sub_total_current_cost = 0;		
							sub_total_adjust_man_qty = 0;
							sub_total_adjust_cost = 0;	
							sub_total_variation_rate = 0;	
			    			//---------------------------------
							innerHtml = "";
			    		}
			    		//도급비 조정안 col
			    		innerHtml += '<tr>';
			    		for(var key in obj){
			    			//구분 데이터일경우
			    			if(key == "GUBUN_NAME"){
			    				//구분의 제일 처음만 행병합을 해준다. 
			    				//1더해주는이유 : 소계때문에
			    				if( count == 0){
				    				innerHtml += '	<td class="center vertical-center" rowspan='+(gubun_cnt+1)+'>'+obj[key]+'</td>';
			    				}
			    			}else if(key == "BASE_YYYY"){
			    				BASE_YYYY = obj[key];
			    			}else if(key == "VENDOR_CODE"){
			    				VENDOR_CODE = obj[key];
			    			}else if(key == "VENDOR_NAME"){
			    				VENDOR_NAME = obj[key];
			    			}else if(key == "CONTRACT_CODE"){
			    				CONTRACT_CODE = obj[key];
			    			}else if(key == "CONTRACT_NAME"){
			    				innerHtml += '<td class="center vertical-center">'+obj[key]+'</td>';
			    				CONTRACT_NAME = obj[key];
			    			}else if(key == "DEPT_NAME"){
			    				innerHtml += '<td class="center vertical-center">'+obj[key]+'</td>';
			    			}else if(key == "UNIT_NAME"){
			    				innerHtml += '<td class="center vertical-center">'+obj[key]+'</td>';
			    			}else if(key == "CURRENT_MAN_QTY"){
			    				innerHtml += '<td class="center vertical-center">'+obj[key]+'</td>';
			    				//현행 인원 소계 계산
			    				sub_total_current_man_qty += obj[key];
			    				//현행 인원 합계 계산
			    				sum_total_current_man_qty += obj[key];
			    			}else if(key == "CURRENT_UNIT_PRICE"){
			    				innerHtml += '<td class="right vertical-center">'+ addComma(obj[key]) +'</td>';
			    			}else if(key == "CURRENT_QUANTITY"){
			    				innerHtml += '<td class="right vertical-center">'+ addComma(obj[key]) +'</td>';
			    			}else if(key == "CURRENT_SUBCONTRACTING_COST"){
			    				innerHtml += '<td class="right vertical-center CURRENT_SUBCONTRACTING_COST" data-row="'+i+'">'+ addComma(obj[key]) +'</td>';
			    				//현행 월도급비 소계 계산
			    				sub_total_current_cost += obj[key];
			    				//현행 월도급비 합계 계산
			    				sum_total_current_cost += obj[key];
			    			}else if(key == "ADJUST_MAN_QTY"){
			    				innerHtml += '<td class="center vertical-center">'+obj[key]+'</td>';
			    				//조정안 인원 소계 계산
			    				sub_total_adjust_man_qty += obj[key];
			    				//조정안 인원 합계 계산
			    				sum_total_adjust_man_qty += obj[key];
			    			}else if(key == "ADJUST_UNIT_PRICE"){
			    				innerHtml += '<td class="right vertical-center ADJUST_UNIT_PRICE" data-row="'+i+'">'+ addComma(obj[key]) +'</td>';
			    			}else if(key == "ADJUST_QUANTITY"){
			    				if(CONTRACT_TYPE > 0){
			    					// 시간외 물량 변경 가능
			    					innerHtml += '<td class="right vertical-center"><input class="ADJUST_QUANTITY" style="text-align: right; width: 100px; background-color: #ffcc66;" value="' + addComma(obj[key]) + '" data-row="'+i+'" data-gubun="'+(gubun_pos+1)+'"></td>';
			    				}else{
				    				innerHtml += '<td class="right vertical-center" data-row="'+i+'">'+ addComma(obj[key]) +'</td>';
			    				}
			    			}else if(key == "ADJUST_SUBCONTRACTING_COST"){
			    				if(WORKING_GUBUN === "Y"){
			    					// 조업계약 팝업 X
			    					innerHtml += '<td class="right vertical-center ADJUST_SUBCONTRACTING_COST" data-row="'+i+'">'+ addComma(obj[key]) +'</td>';
			    				}else if(GUBUN_CODE === "3"){
			    					// 저장품 팝업 X
			    					innerHtml += '<td class="right vertical-center ADJUST_SUBCONTRACTING_COST" data-row="'+i+'">'+ addComma(obj[key]) +'</td>';
			    				}else if(CONTRACT_TYPE > 0){
			    					// 시간외 팝업 X
			    					innerHtml += '<td class="right vertical-center ADJUST_SUBCONTRACTING_COST" data-row="'+i+'">'+ addComma(obj[key]) +'</td>';
			    				}else{
			    					innerHtml += '<td style="color:blue; cursor:pointer;" name="ADJUST_SUBCONTRACTING_COST" data-base_yyyy="'+BASE_YYYY+'" data-vendor_code="'+VENDOR_CODE+'" data-vendor_name="'+VENDOR_NAME+'" data-contract_code="'+CONTRACT_CODE+'" data-contract_name="'+CONTRACT_NAME+'" class="right vertical-center ADJUST_SUBCONTRACTING_COST" data-row="'+i+'">'+ addComma(obj[key]) +'</td>';
			    				}
			    				//조정안 월도급비 소계 계산
			    				sub_total_adjust_cost += obj[key];
			    				//조정안 월도급비 합계 계산
			    				sum_total_adjust_cost += obj[key];
			    			}else if(key == "VARIATION_RATE"){
			    				innerHtml += '<td class="center vertical-center VARIATION_RATE" data-row="'+i+'">'+variation_rate+' %</td>';
			    			}else if(key == "NOTE"){
			    				innerHtml += '<td><input style="width:100%;" name="NOTE" value="'+obj[key]+'" data-base_yyyy="'+BASE_YYYY+'" data-vendor_code="'+VENDOR_CODE+'" data-contract_code="'+CONTRACT_CODE+'"></td>';
			    			}
			    		}
			    		innerHtml += '</tr>';
			    		$('.table').append(innerHtml);
			    		
			    		//현재 구분에서 몇번째 위치나타내기 위해서
			    		count++;
			    		
			    		//제일 마지막에는 소계와 합계 넣어주기
			    		if(i == rpt_intervention_list.length-1){
			    			
			    			//소계 증감률 계산
			    			if(sub_total_current_cost == 0){
			    				sub_total_variation_rate = 0; 
			    			}else{
			    				sub_total_variation_rate = (sub_total_adjust_cost - sub_total_current_cost) / sub_total_current_cost * 100;
			    			}
			    			//합계 증감률 계산
			    			if(sum_total_current_cost == 0){
			    				sum_total_variation_rate = 0; 
			    			}else{
			    				sum_total_variation_rate = (sum_total_adjust_cost - sum_total_current_cost) / sum_total_current_cost * 100;
			    			}
							
			    			//소계 만들어주기
			    			innerHtml = "";
			    			innerHtml += '<tr class="sub_total '+(gubun_pos+1)+'">';
			    			innerHtml += '	<td class="center vertical-center">소계</td>';
			    			innerHtml += '	<td></td>';
			    			innerHtml += '	<td></td>';
			    			innerHtml += '	<td class="center vertical-center">'+sub_total_current_man_qty+'</td>';	//소계 현행 인원
			    			innerHtml += '	<td></td>';
			    			innerHtml += '	<td></td>';
			    			innerHtml += '	<td class="right vertical-center SUB_CURRENT_SUBCONTRACTING_COST">'+ addComma(sub_total_current_cost) +'</td>';		//소계 현행 월도급비
			    			innerHtml += '	<td class="center vertical-center">'+sub_total_adjust_man_qty+'</td>';	//소계 조정안 인원
			    			innerHtml += '	<td></td>';
			    			innerHtml += '	<td></td>';
			    			innerHtml += '	<td class="right vertical-center SUB_ADJUST_SUBCONTRACTING_COST">'+ addComma(sub_total_adjust_cost) +'</td>';		//소계 조정안 월도급비
			    			innerHtml += '	<td class="center vertical-center SUB_VARIATION_RATE">'+sub_total_variation_rate+' %</td>';//소계 증감률
			    			innerHtml += '	<td></td>';
			    			innerHtml += '</tr>';
			    			$('.table').append(innerHtml);
			    			
			    			//합계 만들어주기
			    			innerHtml = "";
			    			innerHtml += '<tr class="sum_total">';
			    			innerHtml += '	<td></td>';
			    			innerHtml += '	<td class="center vertical-center">합계</td>';
			    			innerHtml += '	<td></td>';
			    			innerHtml += '	<td></td>';
			    			innerHtml += '	<td class="center vertical-center">'+sum_total_current_man_qty+'</td>';	//합계 현행 인원
			    			innerHtml += '	<td></td>';
			    			innerHtml += '	<td></td>';
			    			innerHtml += '	<td class="right vertical-center SUM_CURRENT_SUBCONTRACTING_COST">'+ addComma(sum_total_current_cost) +'</td>';		//합계 현행 월도급비
			    			innerHtml += '	<td class="center vertical-center">'+sum_total_adjust_man_qty+'</td>';	//합계 조정안 인원
			    			innerHtml += '	<td></td>';
			    			innerHtml += '	<td></td>';
			    			innerHtml += '	<td class="right vertical-center SUM_ADJUST_SUBCONTRACTING_COST">'+ addComma(sum_total_adjust_cost) +'</td>';	//합계 조정안 월도급비
			    			innerHtml += '	<td class="center vertical-center SUM_VARIATION_RATE">'+sum_total_variation_rate+' %</td>';//합계 증감률
			    			innerHtml += '	<td></td>';
			    			innerHtml += '</tr>';
			    			$('.table').append(innerHtml);
			    		}
			    	}
					//월도급비 열 클릭시, 계약별 도급비 산출근거 팝업창 띄우기
			    	$('td[name=ADJUST_SUBCONTRACTING_COST]').on("click",function(){
			    		$this = $(this);
			    		var BASE_YYYY = $this.data('base_yyyy');
						var VENDOR_CODE = $this.data('vendor_code');
						var VENDOR_NAME = $this.data('vendor_name');
						var CONTRACT_CODE = $this.data('contract_code');
						var CONTRACT_NAME = $this.data('contract_name');
						
						window.open("", "계약별 도급비 산출근거", "width=1200, height=700");
						fnHrefPopup("/yp/popup/zwc/rpt/zwc_rpt_pop_reason", "계약별 도급비 산출근거", {
							BASE_YYYY : BASE_YYYY,
							VENDOR_CODE : VENDOR_CODE,
							VENDOR_NAME : VENDOR_NAME,
							CONTRACT_CODE : CONTRACT_CODE,
							CONTRACT_NAME : CONTRACT_NAME
						});
		    		});
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
		
		//집계
		$("#total_btn").on("click",function(){
			var BASE_YYYY = $("#BASE_YYYY").val();
			var VENDOR_CODE = $("#VENDOR_CODE option:selected").val();
			var BEFORE_BASE_YYYY = BASE_YYYY - 1;
			var data = {'BASE_YYYY':BASE_YYYY, 'VENDOR_CODE':VENDOR_CODE, 'BEFORE_BASE_YYYY': BEFORE_BASE_YYYY, '${_csrf.parameterName}' : '${_csrf.token}'};
			$.ajax({
				url: "/yp/zwc/rpt/select_zwc_rpt_total",
			    type: "POST",
			    cache:false,
			    async:true, 
			    dataType:"json",
			    data:data, //폼을 그리드 파라메터로 전송
			    success: function(data) {
					$("#search_btn").trigger("click");
					swalSuccess('집계가 완료됐습니다.');
			    }
			});
		});
		
		//저장
		$("#save_btn").on("click",function(){
			
			//데이터 세팅
			var data = new Array();
			$("input[name=NOTE]").each(function(index, item){
				var value = $(item).val();
				var BASE_YYYY = $(item).data('base_yyyy');
				var VENDOR_CODE = $(item).data('vendor_code');
				var CONTRACT_CODE = $(item).data('contract_code');
				data.push({'BASE_YYYY':BASE_YYYY+'' , 'VENDOR_CODE' : VENDOR_CODE, 'CONTRACT_CODE' : CONTRACT_CODE+'', 'NOTE' : value});
			});
			
			$.ajax({
				url: "/yp/zwc/rpt/zwc_rpt_intervention_save",
			    type: "POST",
			    cache:false,
			    async:true, 
			    dataType:"json",
			    data: {
			    	"dataList" : JSON.stringify(data), 
			    	"dataList2" : JSON.stringify(json_for_tbl_working_subc_cost_basis), 
			    	"${_csrf.parameterName}" : "${_csrf.token}"
			    }, //폼을 그리드 파라메터로 전송
			    success: function(data) {
			    	swalSuccess(data.result+'건이 저장됐습니다.');
			    	$("#search_btn").trigger("click");
			    }
			}); 
		});
		
		$(document).on("keyup", ".ADJUST_QUANTITY", function(e){
			if(e.which === 13){
				var idx = $(this).data("row");
				var gubun = $(this).data("gubun");
				console.log(json_for_tbl_working_subc_cost_basis[idx]);
				
				var adjust_subcontracting_cost = 0;
				var adjust_subcontracting_cost_old = json_for_tbl_working_subc_cost_basis[idx].ADJUST_SUBCONTRACTING_COST_OLD;
				var adjust_unit_price = json_for_tbl_working_subc_cost_basis[idx].ADJUST_UNIT_PRICE;
				var adjust_quantity = Number(unComma($(this).val()));
				
				// 조정안 월도급비 재계산
				adjust_subcontracting_cost = adjust_unit_price * adjust_quantity;
				$(".ADJUST_SUBCONTRACTING_COST:eq(" + idx + ")").text(addComma(adjust_subcontracting_cost));
				// 저장용 물량 및 월도급비 설정
				json_for_tbl_working_subc_cost_basis[idx].ADJUST_QUANTITY = adjust_quantity;
				json_for_tbl_working_subc_cost_basis[idx].ADJUST_SUBCONTRACTING_COST = adjust_subcontracting_cost;
				
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				var row = new Array();
				row.push(json_for_tbl_working_subc_cost_basis[idx]);
				$.ajax({
					url: "/yp/zwc/rpt/zwc_rpt_intervention_save2",
					type: "POST",
					cache:false,
					async: false, 
					dataType:"json",
					data: { 
						"dataList2" : JSON.stringify(row)
					}, //폼을 그리드 파라메터로 전송
					success: function(data) {
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
				return false;
				// 조정안 증감률 재계산
				if(json_for_tbl_working_subc_cost_basis[idx].CURRENT_SUBCONTRACTING_COST != 0){
					variation_rate = (adjust_subcontracting_cost - json_for_tbl_working_subc_cost_basis[idx].CURRENT_SUBCONTRACTING_COST) / json_for_tbl_working_subc_cost_basis[idx].CURRENT_SUBCONTRACTING_COST * 100;
					$(".VARIATION_RATE:eq(" + idx + ")").text(variation_rate + " %");
				}else{
					$(".VARIATION_RATE:eq(" + idx + ")").text("0 %");
				}
				
				// 조정안 소계 재계산 - .sub_total
				var sub_total_old = Number(unComma($(".sub_total."+gubun+" > .SUB_ADJUST_SUBCONTRACTING_COST").text()));
				var sub_total = sub_total_old - adjust_subcontracting_cost_old + adjust_subcontracting_cost;
				$(".sub_total."+gubun+" > .SUB_ADJUST_SUBCONTRACTING_COST").text(addComma(sub_total));
				
				// 조정안 소계 증감률 재계산
				var sub_total_current = Number(unComma($(".sub_total."+gubun+" > .SUB_CURRENT_SUBCONTRACTING_COST").text()));
				var sub_variation_rate = 0;
				if(sub_total_current != 0){
					sub_variation_rate = (sub_total - sub_total_current) / sub_total_current * 100;
				}
				$(".sub_total."+gubun+" > .SUM_VARIATION_RATE").text(sub_variation_rate + " %");
				
				// 조정안 합계 재계산 - .sum_total
				var sum_total_old = Number(unComma($(".sum_total > .SUM_ADJUST_SUBCONTRACTING_COST").text()));
				var sum_total = sum_total_old - adjust_subcontracting_cost_old + adjust_subcontracting_cost;
				$(".sum_total > .SUM_ADJUST_SUBCONTRACTING_COST").text(addComma(sum_total));
				
				// 조정안 합계 증감률 재계산
				var sum_total_current = Number(unComma($(".sum_total."+gubun+" > .SUM_CURRENT_SUBCONTRACTING_COST").text()));
				var sum_variation_rate = 0;
				if(sum_total_current != 0){
					sum_variation_rate = (sum_total - sum_total_current) / sum_total_current * 100;
				}
				$(".sum_total."+gubun+" > .SUM_VARIATION_RATE").text(sum_variation_rate + " %");
			}else{
				$(this).val(addComma(Number(unComma($(this).val()))));
			}
		});
		
		//테이블 초기화
		function tableInit() {
			//table tr 초기화
	    	$(".table tr").remove();
	    	var innerHtml = 
		    	'<tr class="tb-head" >'+
		    	'	<td rowspan="2" style="color:white">구분</td>'+
		    	'	<td rowspan="2" style="color:white">작업명</td>'+
		    	'	<td rowspan="2" style="color:white">팀별</td>'+
		    	'	<td rowspan="2" style="color:white">단위</td>'+
		    	'	<td colspan="4" style="color:white">현행</td>'+
		    	'	<td colspan="4" style="color:white">조정안</td>'+
		    	'	<td rowspan="2" style="color:white">증감률</td>'+
		    	'	<td rowspan="2" style="color:white">비고</td>'+
		    	'	</tr>'+
		    	'<tr class="tb-head">'+
		    	'	<td style="color:white">인원</td>'+
		    	'	<td style="color:white">단가</td>'+
		    	'	<td style="color:white">물량</td>'+
		    	'	<td style="color:white">월도급비</td>'+
		    	'	<td style="color:white">인원</td>'+
		    	'	<td style="color:white">단가</td>'+
		    	'	<td style="color:white">물량</td>'+
		    	'	<td style="color:white">월도급비</td>'+
		    	'</tr>';
	    	$('.table').append(innerHtml);
		}
		
		function fnHrefPopup(url, target, pr) {
			//20191023_khj for csrf
			var csrf_element = document.createElement("input");
			csrf_element.name = "_csrf";
			csrf_element.value = "${_csrf.token}";
			csrf_element.type = "hidden";
			//20191023_khj for csrf
			var popForm = document.createElement("form");

			popForm.name = "popForm";
			popForm.method = "post";
			popForm.target = target;
			popForm.action = url;

			document.body.appendChild(popForm);

			popForm.appendChild(csrf_element);

			$.each(pr, function(k, v) {
				console.log(k, v);
				var el = document.createElement("input");
				el.name = k;
				el.value = v;
				el.type = "hidden";
				popForm.appendChild(el);
			});

			popForm.submit();
			popForm.remove();
		}
		/*콤마 추가*/
		function addComma(num) {
			return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		}
		/*콤마 제거*/
		function unComma(num) {
			return num.replace(/,/gi, '');
		}
		
		function formatDate_y(date) {
			var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
			if (month.length < 2)
				month = '0' + month;
			if (day.length < 2)
				day = '0' + day;
			return [ year ].join('/');
		}
	</script>
	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
</body>