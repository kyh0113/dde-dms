<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
if (request.getProtocol().equals("HTTP/1.1")) {
	response.setHeader("Cache-Control", "no-cache");
}

Date today = new Date();
SimpleDateFormat date = new SimpleDateFormat("yyyy/MM");
String to_yyyy = date.format(today);
// JSTL에서 사용할 수 있도록 세팅
request.setAttribute("to_yyyy", to_yyyy);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>도급비청구서</title>
	<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
	<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
</head>
<body>
	<!-- 20191023_khj for csrf --> 
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<h2>
		도급비청구서
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
	<!-- 	<div class="stitle">기본정보</div> -->
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
						<th>날짜</th>
						<td>
							<input type="text" id="BASE_YYYY" class="calendar search_dtp" value="${to_yyyy}" readonly="readonly"/>
						</td>
						<th>업체명</th>
						<td>
							<select id="VENDOR_CODE">
								<c:forEach var="row" items="${cb_working_master_v}" varStatus="status">
									<option value="${row.CODE}">${row.CODE_NAME}</option>
								</c:forEach>
							</select>
						</td>
						<th>&nbsp;</th>
						<td><input id="storage_chk_box" name="storage_chk_box" type="checkbox" style="cursor:pointer; vertical-align: middle;"/><label for="storage_chk_box" style="cursor:pointer; vertical-align: middle; margin: 0;">&nbsp;&nbsp;저장품</label></td>
					</tr>
				</table>
				<div class="btn_wrap">
					<input type=button class="btn btn_search" id="search_btn"	value="조회">
				</div>
			</div>
		</section>
	</form>
	<div class="float_wrap" style="margin-bottom: 2px;">
		<div class="fl" style="font-size: 14px;">
			&nbsp;
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type=button class="btn_g" id="fn_print"		value="출력">
				<input type=button class="btn_g" id="fn_attach"		value="첨부">
				<input type=button class="btn_g" id="fn_preview"	value="보기">
			</div>
		</div>
	</div>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="shdsCtrl">
			<div data-ui-i18n="ko" style="height: 620px;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter ui-grid-pinning>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
	</section>
	<script>
		//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
		app.controller('shdsCtrl', [ '$scope', '$controller', '$log', 'StudentService', 'uiGridConstants', 'uiGridGroupingConstants', 'uiGridTreeViewConstants', function($scope, $controller, $log, StudentService, uiGridConstants, uiGridGroupingConstants, uiGridTreeViewConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
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
			$scope.uiGridConstants = uiGridConstants;
			
			$scope.pagination = vm.pagination;
			
			// 세션아이드코드 스코프에저장
			$scope.s_emp_code = "${s_emp_code}";
			
			// formater - 천단위 콤마
			$scope.formatter_decimal = function(str_no) {
				if (!isNaN(Number(str_no))) {
					return Number(str_no).toLocaleString()
				} else {
					return str_no;
				}
			};
			
			var columnDefs = [
				{
					displayName : '조회년월',
					field : 'BASE_YYYY',
					width : '100',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '업체코드',
					field : 'VENDOR_CODE',
					width : '100',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '저장품여부',
					field : 'GUBUN_CODE_AGGREGATION',
					width : '100',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '작업코드',
					field : 'CONTRACT_CODE',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '작업명',
					field : 'CONTRACT_NAME',
// 					width : '200',
					visible : true,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '단위',
					field : 'UNIT_NAME',
					width : '95',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					footerCellTemplate: '<div class="ui-grid-cell-contents center">합 계</div>'
				}, {
					displayName : '작업량',
					field : 'QUANTITY',
					width : '105',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.QUANTITY)}}</div>',
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
				}, {
					displayName : '단가',
					field : 'UNIT_PRICE',
					width : '105',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.UNIT_PRICE)}}</div>',
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
				}, {
					displayName : '보상',
					field : 'REWARD_AMOUNT',
					width : '105',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.REWARD_AMOUNT)}}</div>',
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
				}, {
					displayName : '추가',
					field : 'ADDITIONAL_AMOUNT',
					width : '105',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.ADDITIONAL_AMOUNT)}}</div>',
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
				}, {
					displayName : '패널티',
					field : 'PENALTY_AMOUNT',
					width : '105',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.PENALTY_AMOUNT)}}</div>',
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
				}, {
					displayName : '연장근무',
					field : 'EXTENSION_AMOUNT',
					width : '105',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.EXTENSION_AMOUNT)}}</div>',
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
				}, {
					displayName : '휴일근무',
					field : 'HOLIDAY_HOUR',
					width : '105',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.HOLIDAY_HOUR)}}</div>',
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
				}, {
					displayName : '야간근무',
					field : 'NIGHT_HOUR',
					width : '105',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.NIGHT_HOUR)}}</div>',
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
				}, {
					displayName : '지각',
					field : 'LATE_HOUR',
					width : '105',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents center">{{col.getAggregationValue()}}</div>'
				}, {
					displayName : '금액',
					field : 'PAY_AMOUNT',
					width : '150',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.PAY_AMOUNT)}}</div>',
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
				}
			];
			
			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바
				showColumnFooter : true,
				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 100,

				enableCellEditOnFocus : true, //셀 클릭시 edit모드 
				enableSelectAll : true, //전체선택 체크박스
				enableRowSelection : false, //로우 선택
				enableRowHeaderSelection : true, //맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 27, //체크박스 컬럼 길이
				enableHorizontalScrollbar : "1",
				enableVerticalScrollbar : "1",
				rowHeight : 27, //체크박스 컬럼 높이
				// useExternalPagination : true, //pagination을 직접 세팅
				enableAutoFitColumns : false, //컬럼 width를 자동조정
				multiSelect : true, //여러로우선택
				enablePagination : true,
				enablePaginationControls : true,

				columnDefs : columnDefs,
				
				onRegisterApi: function( gridApi ) {
					$scope.gridApi = gridApi;
				}
			});
			
			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  
		} ]);
		var scope;
		$(document).ready(function() {
			// 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
			scope = angular.element(document.getElementById("shds-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
			scope.gridApi.selection.on.rowSelectionChanged(scope, function(row) { //로우 선택할때마다 이벤트
				// console.log("row2", row.entity);
			});
			scope.gridApi.selection.on.rowSelectionChangedBatch(scope, function(rows) { //전체선택시 가져옴
				// console.log("row3", rows[0].entity); //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
			});
			// pagenation option setting  그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param = {
				listQuery : "yp_zwc_ipt2.grid_ipt2_contract_bill", //list가져오는 마이바티스 쿼리 아이디
				cntQuery : "yp_zwc_ipt2.grid_ipt2_contract_bill_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
			
			// 부트스트랩 날짜객체
			$(".search_dtp").datepicker({
				format: "yyyy/mm",
				viewMode: "months",
				minViewMode: "months",
				language : "ko",
				todayHighlight : true,
				autoclose : true,
				clearBtn : true,
				updateViewDate : false
			}).on('changeDate', function(e) {
				if(e.viewMode !== "months"){
					return false;
				}
				$(this).val(formatDate_m(e.date.valueOf())).trigger("change");
// 				$("#search_btn").trigger("click");
				$('.datepicker').hide();
			});
			
			// 조회
			$("#search_btn").on("click", function() {
				scope.reloadGrid({
					BASE_YYYY : $("#BASE_YYYY").val(),
					VENDOR_CODE : $("#VENDOR_CODE").val(),
					GUBUN_CODE_AGGREGATION : $("#storage_chk_box").is(":checked") ? "0" : "1"
				});
			});
			
			// 출력
			$("#fn_print").on("click", function() {
				var rows = scope.gridOptions.data;
				if(rows.length === 0){
					swalWarningCB("데이터가 없습니다.");
					return false;
				}
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					url : "/yp/zwc/ipt2/pre_select_ipt2_contract_bill",
					type : "POST",
					cache : false,
					async : false,
					dataType : "json",
					data : {
						BASE_YYYY: rows[0].BASE_YYYY,
						VENDOR_CODE: rows[0].VENDOR_CODE,
						GUBUN_CODE_AGGREGATION: rows[0].GUBUN_CODE_AGGREGATION
					},
// 					data : {
// 						BASE_YYYY: $("#BASE_YYYY").val(),
// 						VENDOR_CODE: $("#VENDOR_CODE").val(),
// 						GUBUN_CODE_AGGREGATION: $("#storage_chk_box").is(":checked") ? "0" : "1"
// 					},
					success : function(data) {
						if(data.result === -90){
							swalWarningCB("첨부할 수 없습니다.\n도급비집계 데이터가 존재하지 않습니다.");
							return false;
						}
						if(data.result === -80){
							swalWarningCB("첨부할 수 없습니다.\n도급비집계 결재가 진행중이거나 완료되었습니다.");
							return false;
						}
						//20191023_khj for csrf
						var csrf_element = document.createElement("input");
						csrf_element.name = "_csrf";
						csrf_element.value = "${_csrf.token}";
						csrf_element.type = "hidden";
						//20191023_khj for csrf
						
						var input1   = document.createElement("input");
						input1.name  = "p_report";
						input1.value = rows[0].GUBUN_CODE_AGGREGATION === "0" ? "report2" : "report1";
						input1.type  = "hidden";
						
						var input2   = document.createElement("input");
						input2.name  = "BASE_YYYY";
						input2.value = rows[0].BASE_YYYY;
						input2.type  = "hidden";
						
						var input3   = document.createElement("input");
						input3.name  = "VENDOR_CODE";
						input3.value = rows[0].VENDOR_CODE;
						input3.type  = "hidden";
						
						var input4   = document.createElement("input");
						input4.name  = "p1";
						input4.value = rows[0].P1;
						input4.type  = "hidden";
						
						var input5   = document.createElement("input");
						input5.name  = "p2";
						input5.value = rows[0].P2;
						input5.type  = "hidden";
						
						var popForm = document.createElement("form");
						
						popForm.name = "popForm";
						popForm.method = "post";
						popForm.target = "new_print";
						popForm.action = "/yp/popup/ipt2/print_contract_bill";
						
						document.body.appendChild(popForm);
						
						popForm.appendChild(csrf_element);
						popForm.appendChild(input1);
						popForm.appendChild(input2);
						popForm.appendChild(input3);
						popForm.appendChild(input4);
						popForm.appendChild(input5);

						window.open('','new_print',"scrollbars=yes,width=1024,height=768");
						popForm.submit();
						popForm.remove();
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
			
			// 첨부
			$("#fn_attach").on("click", function() {
				var rows = scope.gridOptions.data;
				if(rows.length === 0){
					swalWarningCB("데이터가 없습니다.");
					return false;
				}
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					url : "/yp/zwc/ipt2/pre_select_ipt2_contract_bill",
					type : "POST",
					cache : false,
					async : false,
					dataType : "json",
					data : {
						BASE_YYYY: rows[0].BASE_YYYY,
						VENDOR_CODE: rows[0].VENDOR_CODE,
						GUBUN_CODE_AGGREGATION: rows[0].GUBUN_CODE_AGGREGATION
					},
// 					data : {
// 						BASE_YYYY: $("#BASE_YYYY").val(),
// 						VENDOR_CODE: $("#VENDOR_CODE").val(),
// 						GUBUN_CODE_AGGREGATION: $("#storage_chk_box").is(":checked") ? "0" : "1"
// 					},
					success : function(data) {
						if(data.result === -90){
							swalWarningCB("첨부할 수 없습니다.\n도급비집계 데이터가 존재하지 않습니다.");
							return false;
						}
						if(data.result === -80){
							swalWarningCB("첨부할 수 없습니다.\n도급비집계 결재가 진행중이거나 완료되었습니다.");
							return false;
						}
						//20191023_khj for csrf
						var csrf_element = document.createElement("input");
						csrf_element.name = "_csrf";
						csrf_element.value = "${_csrf.token}";
						csrf_element.type = "hidden";
						//20191023_khj for csrf
						
						var input1   = document.createElement("input");
						input1.name  = "type";
						input1.value = "zwc_ipt2_contract_bill";
						input1.type  = "hidden";
						
						var input2   = document.createElement("input");
						input2.name  = "BASE_YYYY";
						input2.value = rows[0].BASE_YYYY;
						input2.type  = "hidden";
						
						var input3   = document.createElement("input");
						input3.name  = "VENDOR_CODE";
						input3.value = rows[0].VENDOR_CODE;
						input3.type  = "hidden";
						
						var input4   = document.createElement("input");
						input4.name  = "GUBUN_CODE_AGGREGATION";
						input4.value = rows[0].GUBUN_CODE_AGGREGATION;
						input4.type  = "hidden";
						
						var popForm = document.createElement("form");
						
						popForm.name = "popForm";
						popForm.method = "post";
						popForm.target = "IMG_REG_POP";
						popForm.action = "/yp/popup/imgReg";
						
						document.body.appendChild(popForm);
						
						popForm.appendChild(csrf_element);
						
						popForm.appendChild(input1);
						popForm.appendChild(input2);
						popForm.appendChild(input3);
						popForm.appendChild(input4);
						
						window.open("","IMG_REG_POP","scrollbars=yes,width=600,height=300");
						
						popForm.submit();
						popForm.remove();
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
			
			// 보기
			$("#fn_preview").on("click", function() {
				var rows = scope.gridOptions.data;
				if(rows.length === 0){
					swalWarningCB("데이터가 없습니다.");
					return false;
				}
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					url : "/yp/zwc/ipt2/select_zwc_ipt2_contract_bill_upload",
					type : "POST",
					cache : false,
					async : false,
					dataType : "json",
					data : {
						BASE_YYYY: rows[0].BASE_YYYY,
						VENDOR_CODE: rows[0].VENDOR_CODE,
						GUBUN_CODE_AGGREGATION: rows[0].GUBUN_CODE_AGGREGATION
					},
// 					data : {
// 						BASE_YYYY: rows[0].BASE_YYYY,
// 						VENDOR_CODE: rows[0].VENDOR_CODE,
// 						GUBUN_CODE_AGGREGATION: rows[0].GUBUN_CODE_AGGREGATION
// 					},
					success : function(data) {
						if(data.result.CNT === 0){
							swalWarningCB("도급비집계 데이터가 존재하지 않습니다.");
							return false;
						}else if(data.result.ATTACH_YN === "N"){
							swalWarningCB("업로드된 도급비청구서가 존재하지 않습니다.");
							return false;
						}else{
							window.open("/yp/popup/imgPopup?url="+encodeURIComponent(data.result.ATTACH_URL),"imgPop","width=580,height=780");
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
		});
		
		function formatDate_m(date) {
			var d = new Date(date), year = d.getFullYear(), month = '' + (d.getMonth() + 1), day = '' + d.getDate();
			if (month.length < 2)
				month = '0' + month;
// 			if (day.length < 2)
// 				day = '0' + day;
			return [ year, month ].join('/');
		}
	</script>
</body>