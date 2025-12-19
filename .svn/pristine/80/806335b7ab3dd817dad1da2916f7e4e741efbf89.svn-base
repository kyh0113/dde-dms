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
<title>계약별 산출근거</title>
<style type="text/css">
.table td, .table th {
	padding: 0.4rem !important;
}
</style>
</head>
<body>
	<h2>
		계약별 산출근거
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
			<form id="frm" name="frm" method="post">
			<!-- 20191023_khj for csrf -->
			<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
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
						<input type="text" id="BASE_YYYY" name="BASE_YYYY" class="calendar search_dtp_y" value="${to_yyyy}" readonly="readonly"/>
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
					<th>계약명</th>
					<td>
						<select id="CONTRACT_NAME" name="CONTRACT_NAME">
							<option value="">[존재하지 않음]</option>
						</select>
					</td>
				</tr>
			</table>
			</form>
			<div class="btn_wrap">
				<input type="button" class="btn btn_search" id="search_btn" value="조회"/>
			</div>
		</div>
	</section>
	
	<h3 id="contract_name_sign" style="color:black;"></h3>
	
	<div class="float_wrap" style="margin-bottom: 2px;">
		<div class="fr">
			<div class="btn_wrap">
				<input type="button" class="btn_g" id="save_btn" value="저장"/>
			</div>
		</div>
	</div>
	<section class="section">
		<form id="frm2" name="frm2" method="post">
			<!-- 20191023_khj for csrf -->
			<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="BASE_YYYY" />
			<input type="hidden" name="VENDOR_CODE" />
			<div class="tbl_box">
				<table class="table" border="1" class="table">
					<colgroup>
						<col width="15%"/>
						<col width="25%"/>
						<col />
						<col width="25%" />
						<col />
					</colgroup>
					<tr class="tb-head" >
						<td style="color:white">구분</td>
						<td style="color:white">단가</td>
						<td style="color:white">인원</td>
						<td style="color:white">금액</td>
						<td style="color:white">비고</td>
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
		
		$("#BASE_YYYY").trigger("change");
	});
		/****************************************엑셀 다운로드 공통 시작****************************************/		
		/****************************************엑셀 다운로드 공통  끝  ****************************************/
		
		// 조회
		$("#search_btn").on("click", function() {
			var frmData = $("#frm").serializeArray();
			$.ajax({
				url: "/yp/zwc/rpt/select_rpt_reason_list",
			    type: "POST",
			    cache:false,
			    async:true, 
			    dataType:"json",
			    data: frmData, //조회 데이터 전송
			    success: function(data) {
			    	//테이블 초기화
			    	tableInit();
			    	
			    	//도급비산출근거 리스트
			    	var rpt_reason_list = data.rpt_reason_list;
			    	//도금비 조정안 데이터 없을경우, return
			    	if(rpt_reason_list.length == 0){
			    		return;
			    	}
			    	//----------비고 저장을 위한 TBL_WORKING_SUBC_COST_BASIS테이블의 PK 변수들 ----------------
			    	var BASE_YYYY;
					var VENDOR_CODE;
					var CONTRACT_CODE;
					var GUBUN_NAME;
					//--------------------------------------------------------------------------------
					
					//--------- 합계 변수 -----------------------------
			    	var total_amount = 0;	//금액 합계
			    	//--------------------------------------------------
			    	
			    	$.each(rpt_reason_list, function (index, item) {
			    		
				    	innerHtml = "";
			    		innerHtml += '<tr>';
			    		for(var key in item){
			    			if(key == "BASE_YYYY"){
			    				BASE_YYYY = item[key];
			    			}else if(key == "VENDOR_CODE"){
			    				VENDOR_CODE = item[key];
			    			}else if(key == "CONTRACT_CODE"){
			    				CONTRACT_CODE = item[key];
			    			}else if(key == "GUBUN_CODE"){
			    				GUBUN_CODE = item[key];
			    			}else if(key == "GUBUN_NAME"){
			    				innerHtml += '<td class="center vertical-center">'+item[key]+'</td>';
			    				GUBUN_NAME = item[key];
			    			}else if(key == "UNIT_PRICE"){
			    				innerHtml += '<td class="right vertical-center">'+item[key]+'</td>';
			    			}else if(key == "MAN_QTY"){
			    				innerHtml += '<td class="center vertical-center">'+item[key]+'</td>';
			    			}else if(key == "AMOUNT"){
			    				innerHtml += '<td class="right vertical-center">'+item[key]+'</td>';
			    				total_amount += Number(unComma(item[key]));
			    			}else if(key == "NOTE"){
			    				innerHtml += '<td><input style="width:100%;" name="NOTE" value="'+item[key]+'" data-base_yyyy="'+BASE_YYYY+'" data-vendor_code="'+VENDOR_CODE+'" data-contract_code="'+CONTRACT_CODE+'" data-gubun_name="'+GUBUN_NAME+'"></td>';
			    			}
			    		}
			    		innerHtml += '</tr>';
			    		$('.table').append(innerHtml);
			    	});
			    	
			    	//합계 만들어주기
	    			innerHtml = "";
	    			innerHtml += '<tr class="sum_total">';
	    			innerHtml += '	<td class="center vertical-center">합계</td>';
	    			innerHtml += '	<td></td>';
	    			innerHtml += '	<td></td>';
	    			innerHtml += '	<td class="right vertical-center">' + addComma(total_amount) + '</td>';		//합계 현행 월도급비
	    			innerHtml += '	<td></td>';
	    			innerHtml += '</tr>';
	    			$('.table').append(innerHtml);
			    	
			    }
			}); 
		});
		
		//연도 변경시, 계약명 리로드
		$("#BASE_YYYY").on("change", function() {
			var frmData = $("#frm").serializeArray();
			$.ajax({
				url: "/yp/zwc/rpt/select_contract_name",
			    type: "POST",
			    cache:false,
			    async:true, 
			    dataType:"json",
			    data: frmData, //조회 데이터 전송
			    success: function(data) {
			    	var contract_name_list = data.contract_name_list;
			    	
			    	$("select#CONTRACT_NAME option").remove();
			    	
			    	if(contract_name_list.length == 0){
			    		$("select#CONTRACT_NAME").append("<option value=''>[존재하지 않음]</option>");
			    		return;
			    	}
			    	
			    	$.each(contract_name_list, function (index, item) {
			    		$("select#CONTRACT_NAME").append("<option value='"+item.CONTRACT_NAME+"'>"+item.CONTRACT_NAME+"</option>");
			    	});
			    }
			}); 
		});
		
		//거래처 변경시, 계약명 리로드
		$("#VENDOR_CODE").on("change", function() {
			var frmData = $("#frm").serializeArray();
			$.ajax({
				url: "/yp/zwc/rpt/select_contract_name",
			    type: "POST",
			    cache:false,
			    async:true, 
			    dataType:"json",
			    data: frmData, //조회 데이터 전송
			    success: function(data) {
			    	var contract_name_list = data.contract_name_list;
			    	
			    	$("select#CONTRACT_NAME option").remove();
			    	
			    	if(contract_name_list.length == 0){
			    		$("select#CONTRACT_NAME").append("<option value=''>[존재하지 않음]</option>");
			    	}
			    	
			    	
			    	$.each(contract_name_list, function (index, item) {
			    		$("select#CONTRACT_NAME").append("<option value='"+item.CONTRACT_NAME+"'>"+item.CONTRACT_NAME+"</option>");
			    	});
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
				var GUBUN_NAME =  $(item).data('gubun_name');
				data.push({'BASE_YYYY':BASE_YYYY+'' , 'VENDOR_CODE' : VENDOR_CODE, 'CONTRACT_CODE' : CONTRACT_CODE+'', 'GUBUN_NAME' : GUBUN_NAME+'', 'NOTE' : value});
			});
			$.ajax({
				url: "/yp/zwc/rpt/zwc_rpt_reason_save",
			    type: "POST",
			    cache:false,
			    async:true, 
			    dataType:"json",
			    data: {"dataList" : JSON.stringify(data), "${_csrf.parameterName}" : "${_csrf.token}"}, //폼을 그리드 파라메터로 전송
			    success: function(data) {
			    	swalSuccess(data.result+'건이 저장됐습니다.');
			    	$("#search_btn").trigger("click");
			    }
			}); 
		});
		
		//테이블 초기화
		function tableInit() {
			//table tr 초기화
	    	$(".table tr").remove();
	    	var innerHtml = 
		    	'<tr class="tb-head" >'+
					'<td style="color:white">구분</td>'+
					'<td style="color:white">단가</td>'+
					'<td style="color:white">인원</td>'+
					'<td style="color:white">금액</td>'+
					'<td style="color:white">비고</td>'+
			    '</tr>';
	    	$('.table').append(innerHtml);
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
</body>