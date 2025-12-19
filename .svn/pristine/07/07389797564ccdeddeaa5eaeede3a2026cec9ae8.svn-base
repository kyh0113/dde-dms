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
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<sec:csrfMetaTags />
<title>【${RECEIVE_VENDOR_NAME}】 계약별 조정(안) 상세보기</title>
<style type="text/css">
.table td, .table th {
	padding: 0.4rem !important;
}
</style>
</head>
<body>
	<h2>
		【${RECEIVE_BASE_YYYY} - ${RECEIVE_VENDOR_NAME}】 계약별 조정(안) 상세보기
	</h2>
	<div class="float_wrap" style="margin-bottom: 2px;">
		<div class="fl">
			<div class="btn_wrap">
				&nbsp;
			</div>
		</div>
		<div class="fr">
			<div class="btn_wrap">
				&nbsp;
			</div>
		</div>
	</div>
	<section class="section">
		<form id="frm" name="frm" method="post">
			<!-- 20191023_khj for csrf -->
			<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" id="BASE_YYYY" value="${RECEIVE_BASE_YYYY}"/>
			<input type="hidden" id="VENDOR_CODE" value="${RECEIVE_VENDOR_CODE}"/>
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
	var json_for_tbl_working_subc_cost_basis = new Array();
	
	$(document).ready(function() {
		search_on_load();
	});
	// 조회
	function search_on_load(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var BASE_YYYY = $("#BASE_YYYY").val().trim();
		var VENDOR_CODE = $("#VENDOR_CODE").val();
// 		var data = {'BASE_YYYY':BASE_YYYY, 'VENDOR_CODE':VENDOR_CODE, '${_csrf.parameterName}' : '${_csrf.token}'};
		var data = {'BASE_YYYY':BASE_YYYY, 'VENDOR_CODE':VENDOR_CODE};
		$.ajax({
			url: "/yp/zwc/rpt/select_zwc_rpt_intervention_list_view",
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
					if(obj.ADJUST_SUBCONTRACTING_COST != 0){
						variation_rate = (obj.ADJUST_SUBCONTRACTING_COST - obj.CURRENT_SUBCONTRACTING_COST)/obj.ADJUST_SUBCONTRACTING_COST * 100;
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
						sub_total_variation_rate = (sub_total_adjust_cost - sub_total_current_cost)/sub_total_adjust_cost * 100;
						//합계 증감률
						sum_total_variation_rate = (sum_total_adjust_cost - sum_total_current_cost)/sum_total_adjust_cost * 100;
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
								innerHtml += '<td class="right vertical-center" data-row="'+i+'">'+ addComma(obj[key]) +'</td>';
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
							innerHtml += '<td>' + obj[key] + '</td>';
						}
					}
					innerHtml += '</tr>';
					$('.table').append(innerHtml);
					
					//현재 구분에서 몇번째 위치나타내기 위해서
					count++;
					
					//제일 마지막에는 소계와 합계 넣어주기
					if(i == rpt_intervention_list.length-1){
						
						//소계 증감률 계산
						if(sub_total_adjust_cost == 0){
							sub_total_variation_rate = 0; 
						}else{
							sub_total_variation_rate = (sub_total_adjust_cost - sub_total_current_cost)/sub_total_adjust_cost * 100; 
						}
						//합계 증감률 계산
						if(sum_total_adjust_cost == 0){
							sum_total_variation_rate = 0; 
						}else{
							sum_total_variation_rate = (sum_total_adjust_cost - sum_total_current_cost)/sum_total_adjust_cost * 100;		
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
	}
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
	</script>
</body>