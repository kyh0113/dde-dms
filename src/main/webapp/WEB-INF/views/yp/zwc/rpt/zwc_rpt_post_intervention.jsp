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
<title>도급계약 조정(안)</title>
<style type="text/css">
.table td, .table th {
	padding: 0.4rem !important;
}
</style>
</head>
<body>
	<h2>
		도급계약 조정(안)
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
					<th>검수년도</th>
					<td>
						<input type="text" id="BASE_YYYY" class="calendar search_dtp_y" value="${to_yyyy}" readonly="readonly"/>
					</td>
					<th>거래처</th>
					<td >
						<select id="VENDOR_CODE" name="VENDOR_CODE">
							<option value="">전체</option>
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
				&nbsp;
			</div>
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type="button" class="btn_g" id="electronic_payment_btn" value="전자결재"/>
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
					</colgroup>
					<tr class="tb-head" >
						<td rowspan="2" style="color:white">업체명</td>
						<td colspan="2" style="color:white">현행</td>
						<td colspan="2" style="color:white">조정(안)</td>
						<td colspan="3" style="color:white">증감</td>
						<td rowspan="2" style="color:white">비고</td>
					</tr>
					<tr class="tb-head">
						<td style="color:white">인원</td>
						<td style="color:white">도급비</td>
						<td style="color:white">인원</td>
						<td style="color:white">도급비</td>
						<td style="color:white">인원</td>
						<td style="color:white">도급비</td>
						<td style="color:white">증감률</td>
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
		
		$("#search_btn").trigger("click");
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
		var enable_approval = false;
		// 조회
		$("#search_btn").on("click", function() {
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			var BASE_YYYY = $("#BASE_YYYY").val().trim();
			var VENDOR_CODE = $("#VENDOR_CODE option:selected").val();
			var data = {'BASE_YYYY':BASE_YYYY, 'VENDOR_CODE':VENDOR_CODE, '${_csrf.parameterName}' : '${_csrf.token}'};
			$.ajax({
				url: "/yp/zwc/rpt/select_tbl_working_subc_pst_adj",
				type: "POST",
				cache: false,
				async: false, 
				dataType:"json",
				data: {
					BASE_YYYY : $("#BASE_YYYY").val().trim(),
					VENDOR_CODE : $("#VENDOR_CODE").val(),
				},
				success: function(data) {
					//테이블 초기화
					tableInit();
					
					//도금비 조정안 리스트
					var rpt_intervention_list = data.rpt_intervention_list;
					
					//도금비 조정안 데이터 없을경우, return
					if(rpt_intervention_list.length > 0){
						var SUM_CURRENT_MAN_QTY = 0;
						var SUM_CURRENT_SUBCONTRACTING_COST = 0;
						var SUM_ADJUST_MAN_QTY = 0;
						var SUM_ADJUST_SUBCONTRACTING_COST = 0;
						var SUM_VARIATION_MAN_QTY = 0;
						var SUM_VARIATION_SUBCONTRACTING_COST = 0;
						var SUM_VARIATION_RATE = 0;
						
						var SUM_TOTAL_CURRENT_COST = 0;
						var SUM_TOTAL_ADJUST_COST = 0;
						var SUM_TOTAL_VARIATION_RATE = 0;
						
						//도급비 조정안 row
						for(var i=0; i<rpt_intervention_list.length; i++){
							var obj = rpt_intervention_list[i];
							var innerHtml = "";
							
							var BASE_YYYY, VENDOR_CODE;
							
							//증감률 = (조절안 월도급비 - 현행월도급비)/(조정안 월도급비) * 100
							var VARIATION_RATE = 0;
							//조정안 월도급비가 0이 아닐경우에만 증감률 계산 
							if(obj.CURRENT_SUBCONTRACTING_COST != 0){
								VARIATION_RATE = (obj.ADJUST_SUBCONTRACTING_COST - obj.CURRENT_SUBCONTRACTING_COST) / obj.CURRENT_SUBCONTRACTING_COST * 100;
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
									innerHtml += '<td class="center vertical-center">'+obj[key]+'</td>';
								}else if(key == "CURRENT_MAN_QTY"){
									innerHtml += '<td class="center vertical-center">'+obj[key]+'</td>';
									SUM_CURRENT_MAN_QTY += obj[key];
								}else if(key == "CURRENT_SUBCONTRACTING_COST"){
									innerHtml += '<td class="right vertical-center">'+addComma(obj[key])+'</td>';
									SUM_CURRENT_SUBCONTRACTING_COST += obj[key];
								}else if(key == "ADJUST_MAN_QTY"){
									innerHtml += '<td class="center vertical-center">'+obj[key]+'</td>';
									SUM_ADJUST_MAN_QTY += obj[key];
								}else if(key == "ADJUST_SUBCONTRACTING_COST"){
									innerHtml += '<td class="right vertical-center">'+addComma(obj[key])+'</td>';
									SUM_ADJUST_SUBCONTRACTING_COST += obj[key];
								}else if(key == "VARIATION_MAN_QTY"){
									innerHtml += '<td class="center vertical-center">'+obj[key]+'</td>';
									SUM_VARIATION_MAN_QTY += obj[key];
								}else if(key == "VARIATION_SUBCONTRACTING_COST"){
									innerHtml += '<td class="right vertical-center">'+addComma(obj[key])+'</td>';
									SUM_VARIATION_SUBCONTRACTING_COST += obj[key];
								}else if(key == "VARIATION_RATE"){
									innerHtml += '<td class="center vertical-center">' + VARIATION_RATE + ' %</td>';
								}else if(key == "NOTE"){
									innerHtml += '<td><input style="width:100%;" class="NOTE" value="' + (obj[key] === null ? "" : obj[key]) + '" data-base_yyyy="'+BASE_YYYY+'" data-vendor_code="'+VENDOR_CODE+'"></td>';
								}
							}
							innerHtml += '</tr>';
							$('.table').append(innerHtml);
						}
						
						//조정안 월도급비가 0이 아닐경우에만 증감률 계산 
						if(SUM_CURRENT_SUBCONTRACTING_COST != 0){
							SUM_VARIATION_RATE = (SUM_ADJUST_SUBCONTRACTING_COST - SUM_CURRENT_SUBCONTRACTING_COST) / SUM_CURRENT_SUBCONTRACTING_COST * 100;
						}
						//합계 만들어주기
						innerHtml = "";
						innerHtml += '<tr class="sum_total">';
						innerHtml += '	<td class="center vertical-center">합계</td>';
						innerHtml += '	<td class="center vertical-center">' + SUM_CURRENT_MAN_QTY + '</td>';
						innerHtml += '	<td class="right vertical-center">' + addComma(SUM_CURRENT_SUBCONTRACTING_COST) + '</td>';
						innerHtml += '	<td class="center vertical-center">' + SUM_ADJUST_MAN_QTY + '</td>';
						innerHtml += '	<td class="right vertical-center">' + addComma(SUM_ADJUST_SUBCONTRACTING_COST) + '</td>';
						innerHtml += '	<td class="center vertical-center">' + SUM_VARIATION_MAN_QTY + '</td>';
						innerHtml += '	<td class="right vertical-center">' + addComma(SUM_VARIATION_SUBCONTRACTING_COST) + '</td>';
						innerHtml += '	<td class="center vertical-center">' + SUM_VARIATION_RATE + ' %</td>';//합계 증감률
						innerHtml += '	<td></td>';
						innerHtml += '</tr>';
						$('.table').append(innerHtml);
						
						// 전체조회를 성공했을 경우에만 전자결재가 가능하다.
						if($("#VENDOR_CODE").val() === ""){
							enable_approval = true;
						}else{
							enable_approval = false;
						}
					}else{
						$('.table').append('<tr><td class="center vertical-center" colspan="9">데이터가 없습니다.</td></tr>');
					}
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
		
		//전자결재
		$("#electronic_payment_btn").on("click",function(){
			if($("#BASE_YYYY").val() === ""){
				swalInfoCB("검수년도 정보가 없습니다.");
				return false;
			}else{
				// 2020-11-09 jamerl - 조용래 : 대상 조회조건의 데이터(도급월보)가 모두 결재여부 확인.
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					url : "/yp/zwc/ipt/zwc_rpt_post_intervention_check",
					type : "POST",
					cache : false,
					async : false,
					dataType : "json",
					data : {
						BASE_YYYY : $("#BASE_YYYY").val().trim()
					},
					success : function(data) {
						console.log("전자결재 가능여부", data.result);
						// 2020-11-13 jamerl - 조용래 : 체크로직 구현 후 전자결재 테스트 할 수 있도록 무조건 전자결재 할 수 있게 처리
// 						data.result = "Y";
						if(data.result === 'N2'){
							swalWarningCB("대상 도급계약 조정(안)이 없습니다.");
						}else if(data.result === 'Y'){
							var w = window.open("about:blank", "도급계약 조정(안)", "width=1200,height=900,location=yes,scrollbars=yes");
							w.location.href = "http://ypgw.ypzinc.co.kr/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=EF160393522503521" + 
									"&BASE_YYYY=" + $("#BASE_YYYY").val().trim() + 
									"&PKSTR=" + $("#BASE_YYYY").val().trim();
						}else{
							swalWarningCB("도급계약 조정(안) 전자결재가 완료되지 않았습니다.");
						}
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
		});
		
		//집계
		$("#total_btn").on("click",function(){
			if($("#BASE_YYYY").val().trim() === ""){
				swalWarningCB("연도를 입력하세요.");
			}
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				url: "/yp/zwc/rpt/merge_zwc_rpt_post_intervention",
				type: "POST",
				cache: false,
				async: false, 
				dataType:"json",
				data: {
					BASE_YYYY : $("#BASE_YYYY").val().trim(),
					VENDOR_CODE : $("#VENDOR_CODE").val()
				},
				success: function(data) {
					swalSuccessCB('집계 완료되었습니다.', function(){
						$("#search_btn").trigger("click");
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
					swalDangerCB("집계 실패하였습니다.\n관리자에게 문의해주세요.");
				}
			});
		});
		
		//저장
		$("#save_btn").on("click",function(){
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			//데이터 세팅
			var data = new Array();
			$(".NOTE").each(function(index, item){
				var value = $(item).val();
				var BASE_YYYY = $(item).data('base_yyyy');
				var VENDOR_CODE = $(item).data('vendor_code');
				data.push({
					'BASE_YYYY':BASE_YYYY+'' , 
					'VENDOR_CODE' : VENDOR_CODE, 
					'NOTE' : value
				});
			});
			
			$.ajax({
				url: "/yp/zwc/rpt/update_tbl_working_subc_pst_adj",
				type: "POST",
				cache:false,
				async:true, 
				dataType:"json",
				data: {
					"dataList" : JSON.stringify(data),
				},
				success: function(data) {
					swalSuccessCB("저장 완료되었습니다.", function(){
						$("#search_btn").trigger("click");
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
					swalDangerCB("저장 실패하였습니다.\n관리자에게 문의해주세요.");
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
				'	<td rowspan="2" style="color:white">업체명</td>'+
				'	<td colspan="2" style="color:white">현행</td>'+
				'	<td colspan="2" style="color:white">조정(안)</td>'+
				'	<td colspan="3" style="color:white">증감</td>'+
				'	<td rowspan="2" style="color:white">비고</td>'+
				'	</tr>'+
				'<tr class="tb-head">'+
				'	<td style="color:white">인원</td>'+
				'	<td style="color:white">도급비</td>'+
				'	<td style="color:white">인원</td>'+
				'	<td style="color:white">도급비</td>'+
				'	<td style="color:white">인원</td>'+
				'	<td style="color:white">도급비</td>'+
				'	<td style="color:white">증감률</td>'+
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