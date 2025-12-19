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
String toDay = date.format(today);

//한달 
Calendar mon = Calendar.getInstance();
mon.add(Calendar.MONTH , -1);
String beforeMonthDay = date.format(mon.getTime());
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>월보등록(공수)</title>
<script type="text/javascript">
	var scope;
	$(document).ready(function() {
		// 부트스트랩 날짜객체
		$(".dtp").datepicker({
			format : "yyyy/mm",
			language : "ko",
			viewMode: "months", 
		    minViewMode: "months",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		});
		
		//조회조건 default
		//오늘날짜 세팅
		if($("input[name=BASE_YYYYMM]").val() == ""){
			$("input[name=BASE_YYYYMM]").val("<%=toDay%>");	
		}
		
		$('input').on('keydown', function(event) {
			if(event.keyCode==13) 
				return false;
		});
	});
</script>
</head>
<body>
	<h2>
		월보등록(공수)
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
	
	<form id="frm" name="frm">
		<div class="float_wrap">
			<div class="fl">
				<div class="stitle">
				</div>
			</div>
		</div>
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<!-- 엑셀업로드 insertQuery -->
		<input type='hidden' id='insertQuery' name='insertQuery' value='oracle.yp_zcs_ipt.create_construction_monthly_rpt1'>
		<section>
			<div class="tbl_box">
				<table class="contract_standard_table" cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="5%" />
						<col width="25%" />
						<col width="5%" />
						<col width="25%" />
						<col width="5%" />
						<col width="25%" />
					</colgroup>
					<tr>
						<th>거래처</th>
						<td>
							<input type="text" name="SAP_CODE" size="10" readonly="readonly" style="background-color: #e5e5e5;"/>
							<input type="hidden" name="VENDOR_CODE" size="10"/>
							<a href="#" onclick="fnSearchPopup('1');"><img src="/resources/yp/images/ic_search.png"></a>
							<input type="text" name="VENDOR_NAME" disabled="disabled"  style="width:200px;"/>
						</td>
						<th>월보년월</th>
						<td>
							<input type="text" style="cursor: pointer;" class="calendar dtp" name="BASE_YYYYMM" id="sdate" size="10" value="${req_data.sdate}"/>
							
						</td>
						
						<th>작업월보</th>
						<td>
							<input type="file" name="excelfile" id="upload" value="" style="width:300px;"/>
							<input type="button" class="btn_g" id="upload_btn" value="파일등록" onclick="fnExcelUpload();"/>
						</td>
					</tr>
					<tr>
						<th>계약코드</th>
						<td>
							<input type="text" name="CONTRACT_CODE" size="10"/>
							<a href="#" onclick="fnSearchPopup('2');"><img src="/resources/yp/images/ic_search.png"></a>
							<input type="text" name="CONTRACT_NAME" disabled="disabled"  style="width:200px;"/>
						</td>
						<th></th><td></td>
						<th>양식 다운로드</th>
						<td><input type="button" class="btn btn_make" id=excelTemplate_btn value="ExcelDown"/></td>
					</tr>
				</table>
				<div class="btn_wrap">
				<button class="btn btn_search" id="search_btn" type="button">조회</button>
			</div>
			</div>
		</section>
		
		<div class="float_wrap">
			<div class="fr">
				<div class="btn_wrap" style="margin-bottom:5px;">
					<input type="button" class="btn_g" id="add" value="추가"/>
					<input type="button" class="btn_g" id="remove" value="삭제"/>
					<input type="button" class="btn_g" id="save" value="저장"/>
				</div>
			</div>
		</div>
		<section class="section">
			<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
			<div id="shds-uiGrid" data-ng-controller="shdsCtrl">
				<div data-ui-i18n="ko" style="height: 620px;">
					<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
						<div data-ng-if="loader" class="loader"></div>
						<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
					</div>
				</div>
			</div>
			<!-- 복붙영역(html) 끝 -->
		</section>
		<input type="hidden" name="ie_bug" id="ie_bug" value=""/> 
	</form>
<script>
	//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
	app.controller('shdsCtrl', [ '$scope', '$window', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $window, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
		var vm = this; //this를 vm에 대입, 아래에서 부모의 $scope를 vm에 추가하기 위해 			
		angular.extend(vm, $controller('CodeCtrl', { //CodeCtrl(ui-grid 커스텀 api)를 상속받는다
			// 자식컨트롤러의 vm에 부모 컨트롤러의 $scope를 합, 이로써 자식 컨트롤러에서 부모의 모든 $scope(this)를 사용 할 수 있음
			$scope : $scope
		}));
		var paginationOptions = vm.paginationOptions; //부모의 paginationOptions를 자식의 paginationOptions에 대입,즉시실행 함수
		paginationOptions.pageNumber = 1; //초기 page number
		paginationOptions.pageSize = 1000; //초기 한번에 보여질 로우수
		$scope.paginationOptions = paginationOptions;

		$scope.gridApi = vm.gridApi; //외부에서 grid의 클릭이벤트와 같은것들을 쓰기 위해서
		$scope.loader = vm.loader;
		$scope.addRow = vm.addRow;
		$scope.deleteRow = vm.deleteRow;
		$scope.deleteRowOne = vm.deleteRowOne;
    	$scope.searchCnt = vm.searchCnt;
		$scope.uiGridConstants = uiGridConstants;
		
		$scope.pagination = vm.pagination;
		
		// 세션아이디코드 스코프에저장
		$scope.s_emp_code = "${s_emp_code}";

		//자식팝업에서 부모창의 콜백함수 실행
		$window.inviteCallback = function() {
        
        };
       
		
		// formater - String yyyyMMdd -> String yyyy/MM/dd
		$scope.formatter_date = function(str_date) {
			if (str_date.length === 8) {
				return str_date.replace(/(\d{4})(\d{2})(\d{2})/g, '$1/$2/$3');
			} else {
				return str_date;
			}
		};
		
		// formater - String yyyyMM -> String yyyy.MM
		$scope.formatter_yyyymm = function(str_date) {
			return str_date.substring(0,4)+"/"+str_date.substring(4,6)
		};

		// formater - 소수점 2째자리 표현
		$scope.formatter_decimal = function(str_date) {
			return Math.round(str_date * 100) / 100;
		};
		
		//cellClass
		$scope.cellClassSet = function(grid, row, col, rowRenderIndex, colRenderIndex){
			var className = "";
			switch(col.field){
				
			}

			return className;
		}
		
		// 팝업 조회
		$scope.fnSearchPopup = function(type, row) {
			var target = scope.gridOptions.data.indexOf(row.entity);
			fnSearchPopup(type, target);
		};
		
		// 코스트센터 AJAX 이벤트
		$scope.fnAjaxKOSTL = function(type, row) {
			if(row.entity.COST_CODE != null && row.entity.COST_CODE.length == 6){
				var data = row.entity;
				data.type = type;
				if (type == "C") {
					if (row.entity.COST_CODE == "" ) {
						swalWarningCB("코스트센터코드를 입력하세요.");
						// 							$("input[name=ZKOSTL_"+target+"]").focus();
						return false;
					}
					if (row.entity.COST_CODE != null && row.entity.COST_CODE.length >= 6) {
						var token = $("meta[name='_csrf']").attr("content");
						var header = $("meta[name='_csrf_header']").attr("content");
						$.ajax({
							url : "/yp/zcs/ipt/retrieveAjaxKOSTL",
							type : "post",
							cache : false,
							async : true,
							data : data,
							dataType : "json",
							success : function(result) {
								if (result.KOST1 == "" || result.KOST1 == null) {
									swalWarningCB("일치하는 데이터가 없습니다.");
								} else {
									row.entity.COST_CODE = result.KOST1; //코스트센터 코드
									row.entity.COST_NAME = result.VERAK; //코스트센터 코드설명
								}
								scope.gridApi.grid.refresh();
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
								swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
					}
				}
			}
		};

		
		// 코스트센터
		var COST_CODE = '<div ng-if="row.entity.IS_NEW == null" class="ui-grid-cell-contents" ng-model="row.entity.COST_CODE" >{{row.entity.COST_CODE}}</div>';
		var COST_CODE_NEW = '<input ng-if="row.entity.IS_NEW != null" type="text" ng-model="row.entity.COST_CODE" style="height: 100%; width: calc(100% - 24px);" ng-keyup="grid.appScope.fnAjaxKOSTL(\'C\', row, $event)"><img ng-if="row.entity.IS_NEW != null" src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(3, row)">';

		
		var columnDefs1 = [
			{
				displayName : '월보년월',
				field : 'BASE_YYYYMM',
				width : '100',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, 
			{
				displayName : '계약코드',
				field : 'CONTRACT_CODE',
				width : '100',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, 
			{
				displayName : '업체코드',
				field : 'VENDOR_CODE',
				width : '120',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, 
			{
				displayName : '순번',
				field : 'SEQ',
				width : '100',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, 
			{
				displayName : '년',
				field : 'YYYY',
				width : '80',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><input class="absolute_center width_90_percent" type="text" ng-model="row.entity.YYYY"/></div>'
			}, 
			{
				displayName : '월',
				field : 'MM',
				width : '80',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><input class="absolute_center width_90_percent" type="text" ng-model="row.entity.MM"/></div>',
				footerCellTemplate: '<div class="ui-grid-cell-contents center">합계</div>'
			}, 
			{
				displayName : '일',
				field : 'DD',
				width : '80',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><input class="absolute_center width_90_percent" type="text" ng-model="row.entity.DD"/></div>'
			},
			{
				displayName : '작업시작시간',
				field : 'WORK_START_TIME',
				width : '140',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><input class="absolute_center width_90_percent" type="text" ng-model="row.entity.WORK_START_TIME"/></div>'
			},
			{
				displayName : '작업종료시간',
				field : 'WORK_END_TIME',
				width : '140',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><input class="absolute_center width_90_percent" type="text" ng-model="row.entity.WORK_END_TIME"/></div>'
			},
			{
				displayName : '코스트센터코드',
				field : 'COST_CODE',
				width : '140',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				//cellTemplate : COST_CODE + COST_CODE_NEW
				cellTemplate : '<input ng-style="{\'background-color\' : row.entity.COST_CODE != null? \'white\' : \'red\'}" type="text" ng-model="row.entity.COST_CODE" style="height: 100%; width: calc(100% - 24px);"  ng-change="grid.appScope.fnAjaxKOSTL(\'C\', row)"><img src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(3, row)">'
			},
			{
				displayName : '코스트센터명',
				field : 'COST_NAME',
				width : '140',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			},
			{
				displayName : '작업내역',
				field : 'WORK_CONTENTS',
				minWidth : '150',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><input class="absolute_center width_90_percent" type="text" ng-model="row.entity.WORK_CONTENTS"/></div>'
			},
			{
				displayName : 'SAP오더번호',
				field : 'ORDER_NUMBER',
				width : '140',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><input class="absolute_center width_90_percent" type="text" ng-model="row.entity.ORDER_NUMBER"/></div>'
			},
			{
				displayName : '공수',
				field : 'MANHOUR',
				width : '100',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
				cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><input class="absolute_center width_90_percent" type="text" ng-model="row.entity.MANHOUR"/></div>',
				footerCellTemplate: '<div class="ui-grid-cell-contents right" >{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
			}
		  ];
		
		
		$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
		{
			enableGridMenu: true,	 //필터버튼
			enableFiltering : false, //각 컬럼에 검색바
			showColumnFooter : true,
			paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
			paginationPageSize : 1000,

			enableCellEditOnFocus : true, //셀 클릭시 edit모드 
			enableSelectAll : true, //전체선택 체크박스
			enableRowSelection : true, //로우 선택
			enableRowHeaderSelection : true, //맨앞 컬럼 체크박스 컬럼으로
			selectionRowHeaderWidth : 35, //체크박스 컬럼 길이
			enableHorizontalScrollbar : "1",
			enableVerticalScrollbar : "1",
			rowHeight : 27, //체크박스 컬럼 높이
			// useExternalPagination : true, //pagination을 직접 세팅
			enableAutoFitColumns : true, //컬럼 width를 자동조정
			multiSelect : true, //여러로우선택
			enablePagination : true,
			enablePaginationControls : true,

			columnDefs : columnDefs1,
			
			onRegisterApi: function( gridApi ) {
			      $scope.gridApi = gridApi;
			 }
		});

		$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
		$scope.reloadGrid = vm.reloadGrid;
		//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  

	} ]);

	$(document).ready(function(){
		// 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
		scope = angular.element(document.getElementById("shds-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
		
		scope.gridApi.core.on.rowsRendered(scope, function() {	//그리드 렌더링 후 이벤트
			
		});
		scope.gridApi.selection.on.rowSelectionChanged(scope, function(row) { //로우 선택할때마다 이벤트
			//console.log("row2", row.entity);
		});
		scope.gridApi.selection.on.rowSelectionChangedBatch(scope, function(rows) { //전체선택시 가져옴
			//console.log("row3", rows[0].entity); //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
		});
		// pagenation option setting  그리드를 부르기 전에 반드시 선언
		// 테이블 조회는 
		// EXEC_RFC : "FI"
		var param = {
				EXEC_RFC  : "N", // RFC 여부
				cntQuery  : "yp_zcs_ipt.select_construction_monthly_rpt1_cnt", 	
				listQuery : "yp_zcs_ipt.select_construction_monthly_rpt1"
		};
		scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
		//복붙영역(앵귤러 이벤트들 가져오기) 끝
		
		// 부트스트랩 날짜객체 hide
		$(document).on("focus", ".dtp", function() {
			$(this).datepicker({
				format : "yyyy/mm",
				language : "ko",
				todayHighlight : true,
				autoclose : true,
				clearBtn : true,
				updateViewDate : false
			}).on('changeDate', function (ev) {
				$(this).trigger("change");
				$('.datepicker').hide();
			});
		});
		
		/****************************************엑셀 템플릿 다운로드 시작****************************************/		
		$("#excelTemplate_btn").on("click",function(){
			
			var form = document.createElement("form");
	    	var input = document.createElement("input");
	    	input.name = "file_name";
	    	input.value = "mon_create_sample1.xlsx";
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
		/****************************************엑셀 템플릿 다운로드  끝  ****************************************/
		
		// 조회
		$("#search_btn").on("click", function() {
			
			//거래처 빈값체크
			var SAP_CODE = $("input[name=SAP_CODE]").val();
			if(isEmpty(SAP_CODE)){
				swalWarningCB("거래처를 입력해주세요.");
				return false;
			}
			//계약코드 빈값체크
			var CONTRACT_CODE = $("input[name=CONTRACT_CODE]").val();
			if(isEmpty(CONTRACT_CODE)){
				swalWarningCB("계약코드를 입력해주세요.");
				return false;
			}
			
			var data = $("#frm").serializeArray();
			for(var i=0; i<data.length; i++){
				if(data[i]["name"] == "BASE_YYYYMM"){
//						data[i]["value"] = data[i]["value"].replace(/ /gi, "");// 모든 공백을 제거
					data[i]["value"] = data[i]["value"].replace("/", "");
					break;
				}
			}
			
			scope.reloadGrid(
				gPostArray(data)	
			);
		});
		
		/* 한줄 추가 */
		$("#add").on("click", function() {
			if(scope.gridOptions.data.length < 1){
				swalWarningCB("조회하여 데이터가 1개 이상 존재할 때만 추가할 수 있습니다.");
				return false;
			}
			// 2020-12-01 jamerl - 최승빈 : 결재 진행중 혹은 완료된 계약은 변경불가
			if(!select_chk_enable_proc("UIG", null, null, null, null)){
				return false;
			}
			var length = scope.gridOptions.data.length;
			var SEQ = scope.gridOptions.data[length-1].SEQ + 1;
			var BASE_YYYYMM = $("input[name=BASE_YYYYMM]").val().replace("/","");
			var CONTRACT_CODE = $("input[name=CONTRACT_CODE]").val();
			var VENDOR_CODE = $("input[name=VENDOR_CODE]").val();
			var data = {
					IS_NEW : "Y",
					BASE_YYYYMM : BASE_YYYYMM,
					CONTRACT_CODE : CONTRACT_CODE,
					VENDOR_CODE : VENDOR_CODE,
					SEQ : SEQ
			};
			scope.addRow(data, true, "asc");
		});
		
		/* 한줄 삭제 */
		$("#remove").on("click", function() {
			var selectedRows = scope.gridApi.selection.getSelectedRows();
			if(selectedRows.length === 0){
				swalWarningCB("삭제할 항목을 선택하세요.");
				return false;
			}
			// 2020-12-01 jamerl - 최승빈 : 결재 진행중 혹은 완료된 계약은 변경불가
			if(!select_chk_enable_proc("UIG", null, null, null, null)){
				return false;
			}
			
			var length = selectedRows.length;
			//IS_NEW가 Y일때
			if(selectedRows[length-1].IS_NEW == "Y"){
				scope.gridOptions.data.pop(selectedRows);
				scope.gridApi.grid.refresh();
			//IS_NEW가 Y가 아닐때 
			}else{
				if (confirm("삭제하겠습니까?")) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					
					var data = $("#frm").serializeArray();
					data.push({name: "gridData", value: JSON.stringify(selectedRows)});
					
					$.ajax({
						url : "/yp/zcs/ipt/month_manh_delete",
						type : "POST",
						cache : false,
						async : true,
						dataType : "json",
						data : data,
						success : function(result) {
							swalSuccessCB(result.result+"건이 삭제 완료됐습니다.");
							scope.gridApi.selection.clearSelectedRows();	//그리드 체크박스 클리어
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
							swalDangerCB("삭제에 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
					
				}
			}
		});
		
		/* 저장 */
		$("#save").on("click", function() {
			
			var selectedRows = scope.gridApi.selection.getSelectedRows();
			if(selectedRows.length === 0){
				swalWarningCB("저장할 항목을 선택하세요.");
				return false;
			}
			// 2020-12-01 jamerl - 최승빈 : 결재 진행중 혹은 완료된 계약은 변경불가
			if(!select_chk_enable_proc("UIG", null, null, null, null)){
				return false;
			}
			
			if (!fnValidation(selectedRows)){
				return false;
			}
			
			
			swal({
				  icon : "info",
				  text: "저장하시겠습니까?",
				  closeOnClickOutside : false,
				  closeOnEsc : false,
				  buttons: {
						confirm: {
						  text: "확인",
						  value: true,
						  visible: true,
						  className: "",
						  closeModal: true
						},
						cancel: {
						  text: "취소",
						  value: null,
						  visible: true,
						  className: "",
						  closeModal: true
						}
				  }
				})
				.then(function(result){
				  if(result){
					    var token = $("meta[name='_csrf']").attr("content");
						var header = $("meta[name='_csrf_header']").attr("content");
						
						var data = $("#frm").serializeArray();
						data.push({name: "gridData", value: JSON.stringify(selectedRows)});
						
						$.ajax({
							url : "/yp/zcs/ipt/zcs_ipt_mon_manh_create_save",
							type : "POST",
							cache : false,
							async : true,
							dataType : "json",
							data : data,
							success : function(result) {
								swalSuccessCB(result.result+"건이 저장 완료됐습니다.", function(){
									scope.gridApi.selection.clearSelectedRows();	//그리드 체크박스 클리어
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
								swalDangerCB("저장에 실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
				  }
				});
			
		});
		
		
	});
	
	/* 팝업 */
	function fnSearchPopup(type, target) {
		if (type == "1") {
			window.open("/yp/popup/zcs/ctr/select_working_master_v", "업체 검색", "width=600, height=800");
		}else if(type == "2"){
			window.open("","계약명 검색","width=600,height=800,scrollbars=yes");
			// 지급기준별 조회 조건 추가 - {1:공수, 2: 작업, 3: 월정액} 
			fnHrefPopup("/yp/popup/zcs/ctr/retrieveContarctName", "계약명 검색", {
				PAY_STANDARD : "1"
			});
		}else if (type == "3") {
			window.open("", "코스트센터 검색", "width=600, height=800");
			fnHrefPopup("/yp/popup/zcs/ipt/retrieveKOSTL", "코스트센터 검색", {
				type : "C",
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
			// 				console.log(k, v);
			var el = document.createElement("input");
			el.name = k;
			el.value = v;
			el.type = "hidden";
			popForm.appendChild(el);
		});

		popForm.submit();
		popForm.remove();
	}
	
	/* 파일업로드 */
	function fnExcelUpload(){
		  var form = $("#frm")[0];
		  
		  //BASE_YYYYMM 값 '/' 없애기
	  	  var before_BASE_YYYYMMM = $("input[name=BASE_YYYYMM]").val();
	  	  var change_BASE_YYYYMMM = $("input[name=BASE_YYYYMM]").val().replace("/", "");
	  	  $("input[name=BASE_YYYYMM]").val(change_BASE_YYYYMMM);
	  	  
	  	  var formData = new FormData(form);
	  	  
	  	  //BASE_YYYYMM 값 원상복귀
	  	  $("input[name=BASE_YYYYMM]").val(before_BASE_YYYYMMM);
		  
	  	  //거래처 빈값 체크
	  	  if(isEmpty($("input[name=VENDOR_CODE]").val())){
	  		swalWarningCB("파일등록할 상태가 아닙니다.\n거래처를 입력해주세요.");
			return false;
	  	  }
	  	  //계약코드 빈값 체크
	  	  if(isEmpty($("input[name=CONTRACT_CODE]").val())){
	  		swalWarningCB("파일등록할 상태가 아닙니다.\n계약코드를 입력해주세요.");
			return false;
	  	  }
	  	  //월보년월 빈값 체크
	  	  if(isEmpty($("input[name=BASE_YYYYMM]").val())){
	  		swalWarningCB("파일등록할 상태가 아닙니다.\n월보년월을 입력해주세요.");
			return false;
	  	  }
	  	  //월보년월 길이 체크
	  	  if($("input[name=BASE_YYYYMM]").val().length < 6){
	  		swalWarningCB("파일등록할 상태가 아닙니다.\n월보년월을 YYYY/MM 형태로 입력해주세요.");
			return false;
	  	  }
	  	// 2020-12-01 jamerl - 최승빈 : 결재 진행중 혹은 완료된 계약은 변경불가
	  	if(!select_chk_enable_proc(null, $("input[name=BASE_YYYYMM]").val().trim().replace(/\//gi, ''), $("input[name=VENDOR_CODE]").val(), $("input[name=CONTRACT_CODE]").val(), null)){
	  		return false;
	  	}
	  	//--------------엑셀 업로드전 데이터 존재하는지 판별-------------------------------------------------
	  	var isExistMonthlyRpt;
	  	var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var data = $("#frm").serializeArray();
		for(var i=0; i<data.length; i++){
			if(data[i]["name"] == "BASE_YYYYMM"){
//					data[i]["value"] = data[i]["value"].replace(/ /gi, "");// 모든 공백을 제거
				data[i]["value"] = data[i]["value"].replace("/", "");
				break;
			}
		}
		$.ajax({
			url : "/yp/zcs/ipt/month_manh_excelUpload_check",
			type : "POST",
			cache : false,
			async : false, //동기화
			dataType : "json",
			data : data,
			success : function(result) {
				isExistMonthlyRpt = result.result;
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
				swalDangerCB("엑셀업로드 체크에 실패하였습니다.\n관리자에게 문의해주세요.");
			}
		});
		
		if(isExistMonthlyRpt){
			swalWarningCB("이미 등록된 데이터입니다.");
			return;
		}
	  	//--------------------------------------------------------------------------------------------------  
	  	  
		  $.ajax({
	            url: "/file/excelUpload_Mon",
	            processData: false,
	            contentType: false,
	            data: formData,
	            type: 'POST',
	            success: function(data){
	            	if(JSON.parse(data).result > 0){
	            		swalSuccess("업로드 되었습니다.");
	            		//그리드 리로드
	            		scope.gridApi.selection.clearSelectedRows();	//그리드 체크박스 클리어
	            		$("#search_btn").trigger("click");
	            		//파일 input 초기화
	            		$("#upload").val("");
	            	}else{
	            		swalWarning("업로드가 진행되지 않았습니다. 엑셀 데이터 확인 후 다시 업로드 해주십시오.");
	            	}
	            },
	            beforeSend:function(){
					$('.wrap-loading').removeClass('display-none');
				},
				complete:function(){
			        $('.wrap-loading').addClass('display-none');
			    },
			    error:function(request,status,error){
			    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
			    	if(error.status == "200"){
	            		location.href = "/core/login/sessionOut.do";
	            	}
	    			if(error.status == "402"){	//인터셉터-밸리데이션 이슈
	    				swalWarning(error.responseJSON.icm_validation_message);
	    			}
	            	if(error.status == "403"){
	            		location.href = "/core/login/sessionOut.do";
	            	}
	            	if(error.status == "500"){
	            		swalDanger("엑셀업로드가 실패했습니다.\n아래의 사항 조치 후 재시도 해주십시오.\n\n1.올바른 엑셀템플릿인지 확인\n2.중복 코드(PK) 삽입여부 확인\n3.입력된 엑셀데이터 길이 확인\n4.데이터 마지막행 이후 모든 행 삭제");
	            	}
	            	swalDangerCB("엑셀업로드에 실패하였습니다.\n관리자에게 문의해주세요.");
			    }
	        });
	}
	
	function fnValidation(rows){
		var check = true;
		$.each(rows, function(i, d){
			if(d.COST_CODE === null || d.COST_CODE === "" || d.COST_CODE.length < 6){
				swalWarningCB("코스트센터를 입력해주세요.");
				check = false;
				return false;
			}
			if(d.COST_NAME === null || d.COST_NAME === ""){
				swalWarningCB("코스트센터를 입력해주세요.");
				check = false;
				return false;
			}
		});
		return check;
	}
	
	/*콤마 추가*/
	function addComma(num) {
		return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}

	/*콤마 제거*/
	function unComma(num) {
		return num.replace(/,/gi, '');
	}
	function select_chk_enable_proc(mode, p1, p2, p3, p4){
		var result = false;
		
		var data = {};
		if (mode === "UIG") {
			if(scope.gridOptions.data.length < 1){
				swalWarningCB("조회하여 데이터가 1개 이상 존재할 때만 추가할 수 있습니다.");
				return false;
			}
			data = scope.gridOptions.data[0];
		}else{
			data.BASE_YYYYMM = p1;
			data.VENDOR_CODE = p2;
			data.CONTRACT_CODE = p3;
			data.REPORT_CODE = p4;
		}
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		$.ajax({
			url : "/yp/zcs/ipt/select_chk_enable_proc",
			type : "POST",
			cache : false,
			async : false,
			dataType : "json",
			data : data,
			success : function(data) {
				if( data.result === 0 ) {
					result = true;
				}else{
					swalWarningCB("전자결재 상태에 의해 작업할 수 없습니다.");
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
				swalDangerCB("작업을 실패하였습니다.\n관리자에게 문의해주세요.");
			}
		});
		return result;
	}
</script>

</body>