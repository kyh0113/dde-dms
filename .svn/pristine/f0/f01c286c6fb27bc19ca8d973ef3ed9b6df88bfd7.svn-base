<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
	
	Date today = new Date();
	SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/dd");
	String toDay = date.format(today);
	String sDate = toDay.substring(0, 8) + "01";
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>차량 계량데이터 조회</title>
<script type="text/javascript">
	var scope;
	$(document).ready(function() {
		// 부트스트랩 날짜객체
		$(".dtp").datepicker({
			format : "yyyy/mm/dd",
			language : "ko",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		}).on('changeDate', function(){
		 	$('.datepicker').hide();
		});
		
		
		// 추가
		$("#add_btn").on("click", function() {
			scope.addRow({
				IS_NEW : "Y",
				IS_MOD : "",
				ENT : "",
				ENT_CODE : "",
				TRUCK_NO : "",
				P_DETAIL_CODE : "",
				P_DETAIL_NAME : "",
				WEIGHT1 : "",
				DATE1 : "",
				WEIGHT2 : "",
				DATE2 : "",
				FINAL_WEIGHT : "",
				LOADING_PLACE : "",
				BIGO: ""
			}, true, "desc");
		});
		
		
		// 엑셀 다운로드
		$("#excel_btn").on("click", function() {
			//20191023_khj for csrf
			var csrf_element = document.createElement("input");
			csrf_element.name = "_csrf";
			csrf_element.value = "${_csrf.token}";
			csrf_element.type = "hidden";
			//20191023_khj for csrf
			var xlsForm = document.createElement("form");
			
			xlsForm.target = "xlsx_download";
			xlsForm.name = "sndFrm";
			xlsForm.method = "post";
			xlsForm.action = "/yp/xls/zmm/aw/zmm_weight_list";
			
			document.body.appendChild(xlsForm);
			
			xlsForm.appendChild(csrf_element);
			
			//페이징별 엑셀출력 필요한 경우 세팅 필수 start
			var totalItems = scope.gridOptions.totalItems;
			var pageNumber = scope.gridOptions.paginationCurrentPage;	//현재페이지
			var pageSize   = scope.gridOptions.paginationPageSize;		//한번에 보여줄 row수
			var start = 0;
			var end = 0;
			if(totalItems <= pageSize) pageNumber = 1;
			if(pageNumber == 1){
				start = (pageNumber);
				end   = pageSize;
			}else{
				start = (pageNumber-1)*pageSize+1;
				end   = (pageNumber)*pageSize;
			}
			//페이징별 엑셀출력 필요한 경우 세팅 필수 end
			
			var pr = {
					sdate : $("#sdate").val() + " 00:00:00",
					edate : $("#edate").val() + " 23:59:59",
					srch_p_name : $("input[name=srch_p_name]").val(),
					srch_p_detail_code : $("input[name=srch_p_detail_code]").val(),
					srch_ent_code : $("input[name=srch_ent_code]").val(),
					srch_daily_confirm : $("input:radio[name=srch_daily_confirm]:checked").val(),
					srch_monthly_confirm : $("input:radio[name=srch_monthly_confirm]:checked").val(),
					srch_status : $("input:radio[name=srch_status]:checked").val(),
					srch_waste : $("input:radio[name=srch_waste]:checked").val(),
					//엑셀출력시 페이징처리 위한 파라메터
					paging   : "Y",
					start    : start,
					end      : end
			};
			
			$.each(pr, function(k, v) {
				console.log(k, v);
				var el = document.createElement("input");
				el.name = k;
				el.value = v;
				el.type = "hidden";
				xlsForm.appendChild(el);
			});
			
			xlsForm.submit();
			xlsForm.remove();
			$('.wrap-loading').removeClass('display-none');
			setTimeout(function() {
				$('.wrap-loading').addClass('display-none');
			}, 5000); //5초
		});
		
		
		// 조회
		$("#search_btn").on("click", function() {
			scope.reloadGrid({
				sdate : $("#sdate").val() + " 00:00:00",
				edate : $("#edate").val() + " 23:59:59",
				srch_p_name : $("input[name=srch_p_name]").val(),
				srch_p_detail_code : $("input[name=srch_p_detail_code]").val(),
				srch_ent_code : $("input[name=srch_ent_code]").val(),
				srch_daily_confirm : $("input:radio[name=srch_daily_confirm]:checked").val(),
				srch_monthly_confirm : $("input:radio[name=srch_monthly_confirm]:checked").val(),
				srch_status : $("input:radio[name=srch_status]:checked").val(),
				srch_waste : $("input:radio[name=srch_waste]:checked").val()
			});
		});
		
		
		// 삭제
		$("#remove_btn").on("click", function() {
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			var rows = scope.gridApi.selection.getSelectedRows();
			if(rows.length === 0){
				swalWarningCB("삭제할 항목을 선택하세요.");
				return false;
			}else if(rows.length > 999){
				swalWarningCB("선택한 항목이 너무 많습니다.\n1000개 미만으로 선택해주세요.");
				return false;
			}
			if (confirm("선택된 항목이 삭제됩니다.\n\n 정말 삭제하시겠습니까?")) {
				var data_rows = new Array();
				var cnt = 0;
				$.each(rows, function(i, d){
					cnt++;
					data_rows.push({SEQ: d.SEQ});
				});
				$.ajax({
					url : "/yp/zmm/aw/zmm_weight_delete",
					type : "POST",
					cache : false,
					async : true,
					dataType : "json",
					data : {
						SEQ: JSON.stringify(data_rows)
					},
					success : function(data) {
						swalSuccessCB(data.result + "건 삭제했습니다.", function(){
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
						swalDangerCB("삭제중 오류가 발생하였습니다.\n관리자에게 문의해주세요.");
					}
				});
			}
		});
		
		
		//계량표 인쇄
		$("#print_btn").on("click", function() {
			swalWarningCB("개발중입니다.");
			return false;
		});
		
		
		//전자결재 연동
		$("#edoc_btn").on("click", function() {
		
			/*
			  2022-06-21
			  YPWEBPOTAL-12 차량계량 정산 - 전자결재 재상신 불가 로직 추가
			  - CALC_CODE 가 null 이거나 undefined 일경우에 "저장된 항목만 결재상신 가능합니다." 메세지 처리후 상신안됨
			  - EDOC_STATUS 가 0 일경우에 "진행중인 결재항목이 있습니다." 메세지 처리후 상신안됨
			  - EDOC_STATUS 가 S 일경우에 "완료된 결재항목이 있습니다." 메세지 처리후 상신안됨
			*/
			var isPossibleSubmit = true;
			var rows = scope.gridApi.selection.getSelectedRows();
			console.log(rows);
			if(rows.length === 0){
				swalWarningCB("결재 상신 항목을 선택하세요.");
				isPossibleSubmit = false;
				return false;
			}else{
				
				$.each(rows, function(i, d){
					if(d.M_INPUT == null || d.M_INPUT == "undefined") {
						swalWarningCB("수정한 항목만 결재상신 가능합니다.");
						isPossibleSubmit = false;
						return false;
					}
					else if(d.EDOC_STATUS == "0") {
						swalWarningCB("진행중인 결재항목이 있습니다.");
						isPossibleSubmit = false;
						return false;
					}
					else if(d.EDOC_STATUS == "S") {
						swalWarningCB("완료된 결재항목이 있습니다.");
						isPossibleSubmit = false;
						return false;
					}
				});
				
			}
			
			if(isPossibleSubmit){
				
				var codes = "";
				$.each(rows, function(i, d){
					if(i == 0) codes = d.SEQ;
					else codes += ";" + d.SEQ;
				});
				var url = "http://ypgw.ypzinc.co.kr/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=EF174736209151760&CALC_CODE="+codes; //운영
				//var url = "http://gwdev.ypzinc.co.kr/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=EF165836491715541&CALC_CODE="+codes; //개발
				
				window.open(url,"전자결재","scrollbars=auto,width=1000,height=900");
				
			}
			
		});
		
		
		// 저장
		$("#save_btn").on("click", function() {
			var rows = scope.gridApi.selection.getSelectedRows();
			
			if(rows.length === 0){
				swalWarningCB("저장할 항목을 선택하세요.");
				return false;
			}else if(rows.length > 999){
				swalWarningCB("선택한 항목이 너무 많습니다.\n1000개 미만으로 선택해주세요.");
				return false;
			}
			if (!fnValidation(rows)){
				return false;
			}
			
			//$.each(rows, function(i, d){
				//if(d.IS_NEW === "Y"){
					//IS_NEW = "Y";
				//}
				//else{
					//IS_MOD = "Y";
				//}
			//});
			
			$.each(rows, function(i, d){
				
				alert(d.BIGO);
				
				if(d.BIGO == "" || d.BIGO == null || d.BIGO == "undefined"){
					swalWarningCB("사유가 입력되지 않았습니다.");
					return false;
				}
			});
			
			//console.log(rows);
			if (confirm("저장하시겠습니까?")) {
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					url : "/yp/zmm/aw/zmm_weight_save",
					type : "POST",
					cache : false,
					async : true,
					dataType : "json",
					data : {
						ROW_NO: JSON.stringify(rows)
					},
					success : function(data) {
						swalSuccessCB(data.result + "건 저장했습니다.", function(){
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
			}
		});
		
		
		// 일마감
		$("#dailycompl_btn").on("click", function() {
			var rows = scope.gridApi.selection.getSelectedRows();
			if(rows.length === 0){
				swalWarningCB("처리할 항목을 선택하세요.");
				return false;
			}else if(rows.length > 999){
				swalWarningCB("선택한 항목이 너무 많습니다.\n1000개 미만으로 선택해주세요.");
				return false;
			}
			
			//if(!fnDateCompare()){
				//swalWarningCB("일마감 기한이 만료된 건 입니다.");
				//return false;
			//}
			
			if (confirm("마감 처리된 건은 수정이 불가합니다.\n\n마감처리 하시겠습니까?")) {
				
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				var data_rows = new Array();
				
				$.each(rows, function(i, d){
					data_rows.push({SEQ: d.SEQ});
				});
				
				$.ajax({
					url : "/yp/zmm/aw/zmm_weight_dailyclosing",
					type : "POST",
					cache : false,
					async : true,
					dataType : "json",
					data : {
						SEQ : JSON.stringify(data_rows)
					},
					success : function(data) {
						swalSuccessCB(data.result + "건 일마감 처리됐습니다.", function(){
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
						swalDangerCB("마감처리에 실패하였습니다.\n관리자에게 문의해주세요.");
					}
				});
			}
		});
		
		
		// 월마감
		$("#monthlycompl_btn").on("click", function() {
			var rows = scope.gridApi.selection.getSelectedRows();
			
			if(rows.length === 0){
				swalWarningCB("처리할 항목을 선택하세요.");
				return false;
			}else if(rows.length > 999){
				swalWarningCB("선택한 항목이 너무 많습니다.\n1000개 미만으로 선택해주세요.");
				return false;
			}
			
			if (!fnValidation_1(rows)){
				return false;
			}
						
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			var data_rows = new Array();
			var cnt = 0;
			
			$.each(rows, function(i, d){
			
				cnt++;
				data_rows.push({SEQ: d.SEQ});
			
			});
			
			$.ajax({
				url : "/yp/zmm/aw/zmm_weight_monthlyclosing",
				type : "POST",
				cache : false,
				async : true,
				dataType : "json",
				data : {
					SEQ: JSON.stringify(data_rows)
				},
				success : function(data) {
					swalSuccessCB(data.result + "건 월마감 처리됐습니다.", function(){
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
					swalDangerCB("마감처리에 실패하였습니다.\n관리자에게 문의해주세요.");
				}
			});
			
		});
	});
	
	
	function fnValidation(rows) {
		var check = true;
		$.each(rows, function(i, d){
			if(d.BIGO == "" || d.BIGO == "null"){
				swalWarningCB("사유가 입력되지 않았습니다.");
				check = false;
				return false;
			}
			
		});
		return check;
	}
	
	
	function fnValidation_1(rows) {
		var check = true;
		$.each(rows, function(i, d){
						
			if(d.M_INPUT == "Y" && d.EDOC_STATUS != "F"){
				swalWarningCB("전자결재가 승인되지 않았습니다.");
				check = false;
				return false;
			}
		});
		return check;
	}
	
	
	function fnDateCompare() {
		var result = true;
		var rows = scope.gridApi.selection.getSelectedRows();
		var today = new Date();
		var sevenAgo = new Date();
		sevenAgo.setDate(today.getDate() - 7);
		
		$.each(rows, function(i, d){
			var wdate = d.SDATE;
			var selday = wdate.split("-");
			var weightday = new Date(selday[0], selday[1] - 1, selday[2]);
			console.log("7일전:"+sevenAgo);
			console.log("계량일자:"+weightday);
			console.log(sevenAgo >= weightday);
			
			if(sevenAgo > weightday){
				result = false;
				return false;
			}
		});
		return result;
	}
	
	
	/* 팝업 */
	function fnSearchPopup(type, target) {
		console.log("target:"+target);
		window.open("", "검색 팝업", "width=600, height=800");
		if(type == "K"){
			fnHrefPopup("/yp/popup/zmm/aw/retrieveKUNNR", "검색 팝업", {
				type : "srch",
				target : target
			});
		}else if(type == "M"){
			fnHrefPopup("/yp/popup/zmm/aw/retrieveMATNR", "검색 팝업", {
				type : "srch",
				target : target
			});
		}else if(type == "P"){
			fnHrefPopup("/yp/popup/zmm/aw/retrievePname", "검색 팝업", {
				type : "srch",
				target : target
			});
		}
	}
	
	
	/* 팝업 submit */
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
			//console.log(k, v);
			var el = document.createElement("input");
			el.name = k;
			el.value = v;
			el.type = "hidden";
			popForm.appendChild(el);
		});
		
		popForm.submit();
		popForm.remove();
	}
	
	
	function enterkey() {
		if (window.event.keyCode == 13) { // 엔터키가 눌렸을 때
			
			scope.reloadGrid({
				sdate : $("#sdate").val() + " 00:00:00",
				edate : $("#edate").val() + " 23:59:59",
				srch_p_name : $("input[name=srch_p_name]").val(),
				srch_p_detail_code : $("input[name=srch_p_detail_code]").val(),
				srch_ent_code : $("input[name=srch_ent_code]").val(),
				srch_daily_confirm : $("input:radio[name=srch_daily_confirm]:checked").val(),
				srch_monthly_confirm : $("input:radio[name=srch_monthly_confirm]:checked").val(),
				srch_status : $("input:radio[name=srch_status]:checked").val(),
				srch_waste : $("input:radio[name=srch_waste]:checked").val()
			});
			
	    }
	}
	
</script>
</head>
<body>
	<!-- 20191023_khj for csrf -->
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<h2>
		차량 계량데이터 조회
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
					<col width="25%"/>
					<col width="5%" />
					<col width="25%"/>
					<col width="5%" />
					<col width="25%"/>
				</colgroup>
				<tr>
					<th>일자</th>
					<td>
						<input class="calendar dtp" type="text" name="sdate" id="sdate" autocomplete="off" value="<c:choose><c:when test="${empty req_data.sdate}"><%=toDay%></c:when><c:otherwise>${req_data.sdate}</c:otherwise></c:choose>">
						~
						<input class="calendar dtp" type="text" name="edate" id="edate" autocomplete="off" value="<c:choose><c:when test="${empty req_data.edate}"><%=toDay%></c:when><c:otherwise>${req_data.edate}</c:otherwise></c:choose>">
					</td>
					<th>&nbsp;</th>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<th>거래처</th>
					<td>
						<input type="text" name="srch_ent" style="width:100px;" value="${req_data.srch_ent}" onkeyup="enterkey()">
						<input type="hidden" name="srch_ent_code" style="width:100px;" value="${req_data.srch_ent_code}">
						<a href="#" onclick="javascript:fnSearchPopup('K',null);"><img src="/resources/yp/images/ic_search.png"></a>
						<input type="text" name="srch_ent" style="width:170px;" value="${req_data.srch_ent}" readonly="readonly">
					</td>
					<!-- <th>품목</th>
					<td>
						<input type="text" name="srch_p_name" value="${req_data.srch_p_name}"><img src="/resources/yp/images/ic_search.png" style="cursor: pointer;" onclick="javascript:fnSearchPopup('P', null);">
					</td> -->
					<th>품목</th>
					<td>
						<input type="text" name="srch_p_name" value="${req_data.srch_p_name}" onkeyup="enterkey()"><img src="/resources/yp/images/ic_search.png" style="cursor: pointer;" onclick="javascript:fnSearchPopup('M', null);">
						<input type="hidden" name="srch_p_detail_code" value="${req_data.srch_p_detail_code}">
						<input type="text" name="srch_p_detail_name" readonly="readonly" value="${req_data.p_detail_name}">
					</td>
				</tr>
				<tr>
					<!--
					<th>일마감</th>
					<td>
						<input type="radio" name="srch_daily_confirm" value="" <c:if test="${req_data.srch_daily_confirm eq '' || req_data.srch_daily_confirm eq null}">checked</c:if>/><label for="">전체</label>&nbsp;&nbsp;
						<input type="radio" name="srch_daily_confirm" value="Y" <c:if test="${req_data.srch_daily_confirm eq 'Y'}">checked</c:if>/><label for="Y">승인</label>&nbsp;&nbsp;
						<input type="radio" name="srch_daily_confirm" value="N" <c:if test="${req_data.srch_daily_confirm eq 'N'}">checked</c:if>/><label for="N">미승인</label>&nbsp;&nbsp;
					</td>
					-->
					<th>월마감</th>
					<td>
						<input type="radio" name="srch_monthly_confirm" value="" <c:if test="${req_data.srch_monthly_confirm eq '' || req_data.srch_monthly_confirm eq null}">checked</c:if>/><label for="">전체</label>&nbsp;&nbsp;
						<input type="radio" name="srch_monthly_confirm" value="Y" <c:if test="${req_data.srch_monthly_confirm eq 'Y'}">checked</c:if>/><label for="Y">승인</label>&nbsp;&nbsp;
						<input type="radio" name="srch_monthly_confirm" value="N" <c:if test="${req_data.srch_monthly_confirm eq 'N'}">checked</c:if>/><label for="N">미승인</label>&nbsp;&nbsp;
					</td>
 					<th>변경여부</th>
 					<td>
 						<input type="radio" name="srch_status" value="" <c:if test="${req_data.srch_status eq '' || req_data.srch_status eq null}">checked</c:if>/><label for="">전체</label>&nbsp;&nbsp;
 						<input type="radio" name="srch_status" value="Y" <c:if test="${req_data.srch_status eq 'Y'}">checked</c:if>/><label for="Y">예</label>&nbsp;&nbsp;
 						<input type="radio" name="srch_status" value="N" <c:if test="${req_data.srch_status eq 'N'}">checked</c:if>/><label for="N">아니오</label>&nbsp;&nbsp;
 					</td>
					<th>폐기물여부</th>
 					<td>
 						<input type="radio" name="srch_waste" value="" <c:if test="${req_data.srch_waste eq '' || req_data.srch_waste eq null}">checked</c:if>/><label for="">전체</label>&nbsp;&nbsp;
 						<input type="radio" name="srch_waste" value="Y" <c:if test="${req_data.srch_waste eq 'Y'}">checked</c:if>/><label for="Y">예</label>&nbsp;&nbsp;
 						<input type="radio" name="srch_waste" value="N" <c:if test="${req_data.srch_waste eq 'N'}">checked</c:if>/><label for="N">아니오</label>&nbsp;&nbsp;
 					</td>
				</tr>
			</table>
			<div class="btn_wrap">
				<button class="btn btn_make" id="excel_btn" type="">엑셀 다운로드</button>
				<button class="btn btn_search" id="search_btn" type="">조회</button>
			</div>
		</div>
	</section>
	<div class="float_wrap">
	<!-- 		<div class="fl"> -->
	<!-- 			<div class="btn_wrap"> -->
	<!-- 			</div> -->
	<!-- 		</div> -->
		<div class="fr">
			<div class="btn_wrap">
				<input type="button" value="계량표 인쇄" class="btn_g" id="print_btn" />
				<input type="button" value="전자결재" class="btn_g" id="edoc_btn" />
				<input type="button" value="추가" class="btn_g" id="add_btn" />
				<input type="button" value="수정" class="btn_g" id="mod_btn">
				<input type="button" value="삭제" class="btn_g" id="remove_btn">
				<input type="button" value="저장" class="btn_g h_w_appr" id="save_btn">
				<!--
				<input type="button" value="일마감" class="btn_g h_w_appr" id="dailycompl_btn">
				-->
				<input type="button" value="월마감" class="btn_g h_w_appr" id="monthlycompl_btn">
			</div>
			<div class="btn_wrap">단위 : Kg</div>
		</div>
	</div>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller -->
		<div id="shds-uiGrid" data-ng-controller="weightCtrl" style="height: auto;">
			<div data-ui-i18n="ko" style="height: 540px;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
	</section>
	<script>
		/*복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  */
		app.controller('weightCtrl', [ '$scope', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
			var vm = this; //this를 vm에 대입, 아래에서 부모의 $scope를 vm에 추가하기 위해
			angular.extend(vm, $controller('CodeCtrl', { //CodeCtrl(ui-grid 커스텀 api)를 상속받는다
				// 자식컨트롤러의 vm에 부모 컨트롤러의 $scope를 합, 이로써 자식 컨트롤러에서 부모의 모든 $scope(this)를 사용 할 수 있음
				$scope : $scope
			}));
			var paginationOptions = vm.paginationOptions; //부모의 paginationOptions를 자식의 paginationOptions에 대입,즉시실행 함수
			
			paginationOptions.pageNumber = 1; //초기 page number
			paginationOptions.pageSize = 100; //초기 한번에 보여질 로우수
			$scope.paginationOptions = paginationOptions;
			
			$scope.gridApi = vm.gridApi; //외부에서 grid의 클릭이벤트와 같은것들을 쓰기 위해서
			$scope.loader = vm.loader;
			$scope.addRow = vm.addRow;
			
			$scope.pagination = vm.pagination;
			
			// 세션아이드코드 스코프에저장
			$scope.s_emp_code = "${s_emp_code}";
			
			$scope.uiGridConstants = uiGridConstants;
			
			// formater - String yyyyMMdd -> String yyyy/MM/dd
			$scope.formatter_date = function(str_date) {
				if (str_date.length === 8) {
					return str_date.replace(/(\d{4})(\d{2})(\d{2})/g, '$1/$2/$3');
				} else {
					return str_date;
				}
			};
			
			// formater - 천단위 콤마
			$scope.formatter_decimal = function(str_date) {
				if (!isNaN(Number(str_date))) {
					return Number(str_date).toLocaleString()
				} else {
					return str_date;
				}
			};
			
			// 수정
			$("#mod_btn").on("click", function() {
				var rows = scope.gridApi.selection.getSelectedRows();
				
				if (isEmpty(rows)) {
					swalWarning("항목을 선택하세요.");
					return false;
				}
				$.each(rows, function(i, d){
					if(d.BIGO == "" || d.BIGO == "undefined"){
						swalWarning("사유가 입력되지 않았습니다.");
						return false;
					}
					if(d.IS_NEW === "Y"){
						return true;
					}
					d.IS_MOD = "Y";
				});
				scope.gridApi.grid.refresh();
			});
			
			$scope.fnSearchPopup = function(type, row) {
				var target = scope.gridOptions.data.indexOf(row.entity);
				fnSearchPopup(type, target);
			};
			
			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바
				
				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트
				paginationPageSize : 10,
				
				enableCellEditOnFocus : false, //셀 클릭시 edit모드
				enableSelectAll : true, //전체선택 체크박스
				enableRowSelection : false, //로우 선택
				enableRowHeaderSelection : true, //맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 35, //체크박스 컬럼 길이
				enableHorizontalScrollbar : "1",
				enableVerticalScrollbar : "1",
				rowHeight : 27, //체크박스 컬럼 높이
				//useExternalPagination : true, //pagination을 직접 세팅
				enableAutoFitColumns : false, //컬럼 width를 자동조정
				multiSelect : true, //여러로우선택
				enablePagination : true,
				enablePaginationControls : true,
				
				columnDefs : [ //컬럼 세팅
				{
					displayName : 'IS_NEW',
					field : 'IS_NEW',
					width : '20',
					visible : false,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'IS_MOD',
					field : 'IS_MOD',
					width : '20',
					visible : false,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'SEQ',
					field : 'SEQ',
					width : '1',
					visible : false,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'NO',
					field : 'ROWNO',
					width : '70',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.renderContainers.body.visibleRowCache.indexOf(row)+1}}</div>'
				}, {
					displayName : '거래처코드',
					field : 'ENT_CODE',
					width : '1',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '거래처',
					field : 'ENT',
					width : '100',
					visible : true,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div ng-if="row.entity.IS_MOD == null" class="ui-grid-cell-contents">{{row.entity.ENT}}</div>'
								+'<div ng-if="row.entity.IS_MOD != null" class="ui-grid-cell-contents" ng-model="row.entity.ENT"><img ng-if="row.entity.IS_MOD != null" src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(\'K\', row)">{{row.entity.ENT}}</div>'
				}, {
					displayName : '계량일자',
					field : 'SDATE',
					width : '95',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
					,cellTemplate : '<div ng-if="row.entity.IS_MOD == null" class="ui-grid-cell-contents">{{row.entity.SDATE}}</div>' 
								+'<input ng-if="row.entity.IS_MOD != null" type="number" ng-model="row.entity.SDATE" style="height: 100%; width: 100%;" maxlength="8" oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);">'
				}, {
					displayName : '차량번호',
					field : 'TRUCK_NO',
					width : '95',
					visible : true,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div ng-if="row.entity.IS_MOD == null" class="ui-grid-cell-contents">{{row.entity.TRUCK_NO}}</div>' 
								+'<input ng-if="row.entity.IS_MOD != null" type="text" ng-model="row.entity.TRUCK_NO" style="height: 100%; width: 100%;">'
				//}, {
					//displayName : '품목코드',
					//field : 'P_CODE',
					//width : '100',
					//visible : false,
					//cellClass : "center",
					//enableCellEdit : false,
					//allowCellFocus : false
				//}, {
					//displayName : '품목',
					//field : 'P_NAME',
					//width : '100',
					//visible : true,
					//cellClass : "center",
					//enableCellEdit : false,
					//allowCellFocus : false
				}, {
					displayName : '품목코드',
					field : 'P_DETAIL_CODE',
					width : '100',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '품목',
					field : 'P_DETAIL_NAME',
					width : '200',
					visible : true,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div ng-if="row.entity.IS_MOD == null" class="ui-grid-cell-contents">{{row.entity.P_DETAIL_NAME}}</div>'
								+'<div ng-if="row.entity.IS_MOD != null" class="ui-grid-cell-contents" ng-model="row.entity.P_DETAIL_NAME"><img ng-if="row.entity.IS_MOD != null" src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(\'M\', row)">{{row.entity.P_DETAIL_NAME}}</div>'
// 				}, {
// 					displayName : '구분코드',
// 					field : 'TYPE_CODE',
// 					width : '80',
// 					visible : false,
// 					cellClass : "center",
// 					enableCellEdit : false,
// 					allowCellFocus : false
// 				}, {
// 					displayName : '구분',
// 					field : 'TYPE',
// 					width : '80',
// 					visible : true,
// 					cellClass : "center",
// 					enableCellEdit : false,
// 					allowCellFocus : false,
// 					cellTemplate : '<div ng-if="row.entity.IS_MOD == null" class="ui-grid-cell-contents">{{row.entity.TYPE}}</div>' 
// 						+'<select ng-if="row.entity.IS_MOD != null" ng-model="row.entity.TYPE" style="height: 100%; width: 100%;"><option value=""></option><option value="정기">정기</option><option value="비정기">비정기</option></select>'
// 				}, {
// 					displayName : '폐기물종류코드',
// 					field : 'WASTE_TYPE_CODE',
// 					width : '100',
// 					visible : false,
// 					cellClass : "center",
// 					enableCellEdit : false,
// 					allowCellFocus : false
// 				}, {
// 					displayName : '폐기물종류',
// 					field : 'WASTE_TYPE',
// 					width : '100',
// 					visible : true,
// 					cellClass : "center",
// 					enableCellEdit : false,
// 					allowCellFocus : false,
// 					cellTemplate : '<div ng-if="row.entity.IS_MOD == null" class="ui-grid-cell-contents">{{row.entity.WASTE_TYPE}}</div>' 
// 						+'<input ng-if="row.entity.IS_MOD != null" type="text" ng-model="row.entity.WASTE_TYPE" style="height: 100%; width: 100%;">'
				}, {
					displayName : '상차계량(KG)',
					field : 'WEIGHT1',
					width : '95',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false
					//,cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.WEIGHT1)}}</div>'
					,cellTemplate : '<div ng-if="row.entity.IS_MOD == null" class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.WEIGHT1)}}</div>'
								+'<input ng-if="row.entity.IS_MOD != null" type="number" ng-model="row.entity.WEIGHT1" style="height: 100%; width: 100%;">'
				}, {
					displayName : '상차시간',
					field : 'DATE1',
					width : '95',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
					,cellTemplate : '<div ng-if="row.entity.IS_MOD == null" class="ui-grid-cell-contents">{{row.entity.DATE1}}</div>'
								+'<input ng-if="row.entity.IS_MOD != null" type="number" ng-model="row.entity.DATE1" style="height: 100%; width: 100%;" maxlength="4" oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);">'
				}, {
					displayName : '공차계량(KG)',
					field : 'WEIGHT2',
					width : '95',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false
					//,cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.WEIGHT2)}}</div>'
					,cellTemplate : '<div ng-if="row.entity.IS_MOD == null" class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.WEIGHT2)}}</div>'
								+'<input ng-if="row.entity.IS_MOD != null" type="number" ng-model="row.entity.WEIGHT2" style="height: 100%; width: 100%;">'
				}, {
					displayName : '공차시간',
					field : 'DATE2',
					width : '95',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
					,cellTemplate : '<div ng-if="row.entity.IS_MOD == null" class="ui-grid-cell-contents">{{row.entity.DATE2}}</div>'
								+'<input ng-if="row.entity.IS_MOD != null" type="number" ng-model="row.entity.DATE2" style="height: 100%; width: 100%;" maxlength="4" oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);">'
				}, {
					displayName : '실중량(KG)',
					field : 'FINAL_WEIGHT',
					width : '95',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false
					//,cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.FINAL_WEIGHT)}}</div>'
					,cellTemplate : '<div ng-if="row.entity.IS_MOD == null" class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.FINAL_WEIGHT)}}</div>'
								+'<input ng-if="row.entity.IS_MOD != null" type="number" ng-model="row.entity.FINAL_WEIGHT" style="height: 100%; width: 100%;">'
				}, {
					displayName : '상하차장소',
					field : 'LOADING_PLACE',
					width : '120',
					visible : true,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div ng-if="row.entity.IS_MOD == null" class="ui-grid-cell-contents">{{row.entity.LOADING_PLACE}}</div>' 
								+'<input ng-if="row.entity.IS_MOD != null" type="text" ng-model="row.entity.LOADING_PLACE" style="height: 100%; width: 100%;">'
				//}, {
					//displayName : '하차장소',
					//field : 'STACKING_PLACE',
					//width : '140',
					//visible : true,
					//cellClass : "center",
					//enableCellEdit : false,
					//allowCellFocus : false,
					//cellTemplate : '<div ng-if="row.entity.IS_MOD == null" class="ui-grid-cell-contents">{{row.entity.STACKING_PLACE}}</div>' 
					//			+'<input ng-if="row.entity.IS_MOD != null" type="text" ng-model="row.entity.STACKING_PLACE" style="height: 100%; width: 100%;">'
				//}, {
					//displayName : '일마감',
					//field : 'DAILY_CLOSING',
					//width : '80',
					//visible : true,
					//cellClass : "center",
					//enableCellEdit : false,
					//allowCellFocus : false
				}, {
					displayName : '월마감',
					field : 'MONTHLY_CLOSING',
					width : '95',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '변경상태',
					field : 'M_INPUT',
					width : '95',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '전자결재상신여부',
					field : 'EDOC_STATUS',
					width : '95',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '변경여부',
					field : 'M_GUBUN',
					width : '95',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '사유',
					field : 'BIGO',
					width : '300',
					visible : true,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div ng-if="row.entity.IS_MOD == null" class="ui-grid-cell-contents">{{row.entity.BIGO}}</div>' 
								+'<input ng-if="row.entity.IS_MOD != null" type="text" ng-model="row.entity.BIGO" style="height: 100%; width: 100%;">'
				} ],
				onRegisterApi: function(gridApi){
				      $scope.gridApi = gridApi;
				      $scope.gridApi.pagination.on.paginationChanged( $scope, function( currentPage, pageSize){
				      	$scope.getPage(currentPage, pageSize);
					});
				}
			});
			
			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능
		
		} ]);
		
		$(document).ready(function() {
			// 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
			scope = angular.element(document.getElementById("shds-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
			scope.gridApi.selection.on.rowSelectionChanged(scope, function(row) { //로우 선택할때마다 이벤트
			// console.log("row2", row.entity);
			});
			scope.gridApi.selection.on.rowSelectionChangedBatch(scope, function(rows) { //전체선택시 가져옴
				var grid = this.grid;
                var isAllSelected = grid.api.selection.getSelectAllState();
                grid.api.selection.clearSelectedRows(null);
                if (isAllSelected) {
                    var startIndex = (grid.options.paginationCurrentPage - 1) * grid.options.paginationPageSize;
                    var endIndex = startIndex + grid.options.paginationPageSize;
                    for (let i = startIndex; i < endIndex; i++) {
                        let row = grid.rows[i];
                        row.isSelected = true;
                    }
                }
                //console.log(scope.gridApi.selection.getSelectedRows());
			});
			// pagenation option setting 그리드를 부르기 전에 반드시 선언
			// 테이블 조회는
			// EXEC_RFC : "FI"
			var param = {
					listQuery : "yp_zmm_aw.select_zmm_weight_data_list", //list가져오는 마이바티스 쿼리 아이디
					cntQuery  : "yp_zmm_aw.select_zmm_weight_data_list_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
			
			$("#search_btn").trigger("click");
		});
	</script>
</body>
