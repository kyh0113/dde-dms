<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<sec:csrfMetaTags />
	<title>정광 심판 판정 결과조회 - 상세</title>
	<script src="/resources/icm/js/jquery.js"></script>
	<script src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
	<script src="/resources/icm/js/custom.js"></script>
	<!-- 기존 프레임워크 리소스 -->
	<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/resources/icm/css/jquery-ui.css" />
	<!-- 2019-12-13 smh jquery-ui.css 변경.끝 -->
	<link href='/resources/icm/css/animate.min.css' rel='stylesheet'>
	<link rel="stylesheet" type="text/css" href="/resources/css/custom.css" />
	<link rel="stylesheet" type="text/css" href="/resources/css/all.min.css" />
	<link rel="stylesheet" href="/resources/icm/jsTree/dist/themes/default/style.min.css" />
	<link href="/resources/icm/datepicker/css/datepicker.css" rel="stylesheet" type="text/css" />
	<link id="bs-css" href="/resources/icm/css/bootstrap.min.css" rel="stylesheet">
	<!-- jQuery -->
	<script src="/resources/icm/js/jquery.js"></script>
	<script src="/resources/icm/js/jquery.validate.min.js"></script>
	<script src="/resources/icm/js/jquery-ui.js"></script>
	<script src="/resources/icm/jsTree/dist/jstree.min.js"></script>
	<script src="/resources/icm/jsTree/dist/customJstree.js"></script>
	<link rel="stylesheet" href="/resources/icm/uigrid/css/ui-grid.min.css" type="text/css">
	<script src="/resources/icm/js/custom.js"></script>
	<script src="/resources/icm/js/multiFile.js"></script>
	<script src="/resources/icm/js/fileList.js"></script>
	<script src="/resources/icm/angular/js/angular.min.js"></script>
	<script src="/resources/icm/angular/js/angular-route.min.js"></script>
	<script src="/resources/icm/uigrid/js/ui-grid.min.js"></script>
	<script src="/resources/icm/uigrid/js/ui-grid.language.ko.js"></script>
	<!-- 2019-08-15 smh 추가 시작.-->
	<!-- 	<script src="/resources/js/jquery.vicurusit.js"></script> -->
	<!-- 2019-08-15 smh 추가 끝-->
	<script src="/resources/icm/uigrid/js/uiGrid1.js"></script>
	<script src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
	<script src="/resources/icm/datepicker/js/bootstrap-datepicker.js"></script>
	<script src="/resources/icm/jsTree/dist/customJstree.js"></script>
	<link rel="stylesheet" type="text/css" href="/resources/font/ng.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/style.css">
	<script type="text/javascript" src="/resources/js/ui.js"></script>
	<!-- 20191227_khj Tooltip Add -->
	<script src="/resources/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="/resources/icm/js/bootstrap.min.js"></script>
	<!-- application script for Charisma demo -->
	<script src="/resources/icm/js/charisma.js"></script>
	<link rel="stylesheet" href="/resources/yp/css/style.css">
	<!-- 기존 프레임워크 리소스 -->
	<!-- 영풍 리소스 -->
	<script src="/resources/yp/js/common.js"></script>
	<style type="text/css">
	
	/* ui-grid header-align CENTER */
	.ui-grid-header-cell{text-align:center !important;}
	.ui-grid-header-cell-label.ng-binding{margin-left:1.2em;}
	.ui-grid-viewport
	{
		overflow-x:hidden !important;
	}
	</style>
</head>
<body data-ng-app="app">
	<style>
		table {
			border:1px solid #111111;
			text-align:center;
			vertical-align:middle;
		}
		td {
			border:1px solid #000000;
			text-align:center;
			vertical-align:middle;
		}
		.label_cell {
			height:16px; width:100%; border:0; text-align:center;  readonly;
		}
	</style>
	<form id="frm" name="frm" method="post">
		<!-- 20191023_khj for csrf -->
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
	<h2>
		정광 심판 판정 결과 조회
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
	<section>
		<div class="tbl_box">
			<table cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="5%" />
					<col width="20%" />
					<col width="5%" />
					<col width="20%" />
					<col width="5%" />
					<col width="20%" />
				</colgroup>
				<tr>
					<th>광종명</th>
					<td>
						<input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_MATERIAL_ID">
					</td>
					<th>업체명</th>
					<td>
						<input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_SELLER_ID">
					</td>
					<th>입항일자</th>
					<td>
						<input readonly onfocus='this.blur()' style="color:black; font-weight:bold; border:0px; background-color:transparent" id="edt_IMPORT_DATE">
					</td>
				</tr>
			</table>
		</div>
	</section>
	<div style="height:1px; background-color:white"></div>

	<div style="height:10px; background-color:white"></div>

	<div style="overflow:scroll; height:800px;">
		<section class="section">
			<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
			<div id="data-uiGrid-1" data-ng-controller="dataCtrl-1" style="height: auto;width:1200px;">
				<div data-ui-i18n="ko" style="height: 240px;">
					<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter ui-grid-pinning>
						<div data-ng-if="loader" class="loader"></div>
						<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
					</div>
				</div>
			</div>
			<!-- 복붙영역(html) 끝 -->
		</section>
	
		<div style="height:10px; background-color:white"></div>
	
		<section class="section">
			<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
			<div id="data-uiGrid-2" data-ng-controller="dataCtrl-2" style="height: auto;width:1200px;">
				<div data-ui-i18n="ko" style="height: 240px;">
					<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter ui-grid-pinning>
						<div data-ng-if="loader" class="loader"></div>
						<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
					</div>
				</div>
			</div>
			<!-- 복붙영역(html) 끝 -->
		</section>
	
		<div style="height:10px; background-color:white"></div>
	
		<section class="section">
			<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
			<div id="data-uiGrid-3" data-ng-controller="dataCtrl-3" style="height: auto;width:1200px;">
				<div data-ui-i18n="ko" style="height: 240px;">
					<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter ui-grid-pinning>
						<div data-ng-if="loader" class="loader"></div>
						<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
					</div>
				</div>
			</div>
			<!-- 복붙영역(html) 끝 -->
		</section>
	
		<section class="section">
			<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
			<div id="data-uiGrid-4" data-ng-controller="dataCtrl-4" style="height: auto;width:1200px;">
				<div data-ui-i18n="ko" style="height: 240px;">
					<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter ui-grid-pinning>
						<div data-ng-if="loader" class="loader"></div>
						<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
					</div>
				</div>
			</div>
			<!-- 복붙영역(html) 끝 -->
		</section>
	</div>

	<script>
		var l_INGREDIENT_CNT;
		var l_INGREDIENT_ID = new Array();
		var	l_INGREDIENT_NAME = new Array();

		var l_Rx_List = [];
		var l_MaterialName = new Array();
		var l_MaterialID = new Array();
		var l_SellerName = new Array();
		var l_SellerID = new Array();
		var l_MASTER_ID = '';

		function cell_click(idx1) {
			//	console.log(l_Rx_List[idx1].MASTER_ID);
		}

		//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
		app.controller('dataCtrl-1', [ '$scope', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
			var vm = this; //this를 vm에 대입, 아래에서 부모의 $scope를 vm에 추가하기 위해 			
			angular.extend(vm, $controller('CodeCtrl', { //CodeCtrl(ui-grid 커스텀 api)를 상속받는다
				// 자식컨트롤러의 vm에 부모 컨트롤러의 $scope를 합, 이로써 자식 컨트롤러에서 부모의 모든 $scope(this)를 사용 할 수 있음
				$scope : $scope
			}));
			var paginationOptions = vm.paginationOptions; //부모의 paginationOptions를 자식의 paginationOptions에 대입,즉시실행 함수

			paginationOptions.pageNumber = 1; //초기 page number
			paginationOptions.pageSize = 5; //초기 한번에 보여질 로우수
			$scope.paginationOptions = paginationOptions;

			$scope.gridApi = vm.gridApi; //외부에서 grid의 클릭이벤트와 같은것들을 쓰기 위해서
			$scope.loader = vm.loader;
			$scope.addRow = vm.addRow;
			$scope.uiGridConstants = uiGridConstants;
			$scope.pagination = vm.pagination;

			// 세션아이드코드 스코프에저장
			$scope.s_emp_code = "${s_emp_code}";

			$scope.formatter_yp_value = function(yp) {
				var r = Number(yp);
				return r.toFixed(2);
			};

			$scope.formatter_split_value = function(yp, seller) {
				var c1, c2;

				if(yp == undefined) c1 = 0.0; else c1 = parseFloat(yp);
				if(seller == undefined) c2 = 0.0; else c2 = parseFloat(seller);

				var r = c2 - c1;
				
				return r.toFixed(2);
			};

			$scope.formatter_average_value = function(yp, seller) {
				var c1, c2;

				if(yp == undefined) c1 = 0.0; else c1 = parseFloat(yp);
				if(seller == undefined) c2 = 0.0; else c2 = parseFloat(seller);

				var r = (c2 + c1) / 2.0;
				
				return r.toFixed(2);
			};

			$scope.formatter_yp_u_value = function(yp, umpire) {
				var c1, c2;

				if(umpire == undefined) c1 = 0.0; else c1 = parseFloat(umpire);
				if(yp == undefined) c2 = 0.0; else c2 = parseFloat(yp);

				var r = c2 - c1;
				
				return r.toFixed(2);
			};

			$scope.formatter_umpire_value = function(umpire) {
				var r = Number(umpire);
				return r.toFixed(2);
			};

			$scope.formatter_seller_u_value = function(seller, umpire) {
				var c1, c2;

				if(umpire == undefined) c1 = 0.0; else c1 = parseFloat(umpire);
				if(seller == undefined) c2 = 0.0; else c2 = parseFloat(seller);

				var r = c2 - c1;
				
				return r.toFixed(2);
			};

			$scope.formatter_win_value = function(state) {
				if(state == 1) return "O";
				else return " ";
			};

			$scope.formatter_settle_value = function(settle) {
				var r = Number(settle);
				return r.toFixed(2);
			};

			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바

				paginationPageSizes : [ 5, 10, 20, 30, 40, 50, 60, 70 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 5,

				enableCellEditOnFocus : false, //셀 클릭시 edit모드 
				enableSelectAll : false, //전체선택 체크박스
				enableRowSelection : false, //로우 선택
				enableRowHeaderSelection : false, //맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 35, //체크박스 컬럼 길이
				enableHorizontalScrollbar : "1",
				enableVerticalScrollbar : "1",
				rowHeight : 27, //체크박스 컬럼 높이
				// useExternalPagination : true, //pagination을 직접 세팅
				enableAutoFitColumns : true, //컬럼 width를 자동조정
				multiSelect : false, //여러로우선택
				enablePagination : true,
				enablePaginationControls : true,

				columnDefs : [ //컬럼 세팅
				{
					displayName : 'NO',
					field : 'LOT_NO',
					width : '60',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'DMT',
					field : 'DMT',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'Y.P.',
					field : 'YP',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_yp_value(row.entity.YP)}}</div>'
				}, {
					displayName : 'SELLER',
					field : 'SELLER',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'SPLIT',
					field : 'DMT',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_split_value(row.entity.YP, row.entity.SELLER)}}</div>'
				}, {
					displayName : 'AVERAGE',
					field : 'YP',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_average_value(row.entity.YP, row.entity.SELLER)}}</div>'
				}, {
					displayName : 'Y.P.-U',
					field : 'UMPIRE',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_yp_u_value(row.entity.YP, row.entity.UMPIRE)}}</div>'
				}, {
					displayName : 'UMPIRE',
					field : 'UMPIRE',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_umpire_value(row.entity.UMPIRE)}}</div>'
				}, {
					displayName : 'SEL-U',
					field : 'UMPIRE',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_seller_u_value(row.entity.SELLER, row.entity.UMPIRE)}}</div>'
				}, {
					displayName : 'WIN',
					field : 'WIN',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_win_value(row.entity.STATE)}}</div>'
				}, {
					displayName : 'SETTLE',
					field : 'SETTLE',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_settle_value(row.entity.SETTLE)}}</div>'
				}]
			});

			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  
		} ]);

		//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
		app.controller('dataCtrl-2', [ '$scope', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
			var vm = this; //this를 vm에 대입, 아래에서 부모의 $scope를 vm에 추가하기 위해 			
			angular.extend(vm, $controller('CodeCtrl', { //CodeCtrl(ui-grid 커스텀 api)를 상속받는다
				// 자식컨트롤러의 vm에 부모 컨트롤러의 $scope를 합, 이로써 자식 컨트롤러에서 부모의 모든 $scope(this)를 사용 할 수 있음
				$scope : $scope
			}));
			var paginationOptions = vm.paginationOptions; //부모의 paginationOptions를 자식의 paginationOptions에 대입,즉시실행 함수

			paginationOptions.pageNumber = 1; //초기 page number
			paginationOptions.pageSize = 5; //초기 한번에 보여질 로우수
			$scope.paginationOptions = paginationOptions;

			$scope.gridApi = vm.gridApi; //외부에서 grid의 클릭이벤트와 같은것들을 쓰기 위해서
			$scope.loader = vm.loader;
			$scope.addRow = vm.addRow;
			$scope.uiGridConstants = uiGridConstants;
			$scope.pagination = vm.pagination;

			// 세션아이드코드 스코프에저장
			$scope.s_emp_code = "${s_emp_code}";

			$scope.formatter_yp_value = function(yp) {
				var r = Number(yp);
				return r.toFixed(2);
			};

			$scope.formatter_split_value = function(yp, seller) {
				var c1, c2;

				if(yp == undefined) c1 = 0.0; else c1 = parseFloat(yp);
				if(seller == undefined) c2 = 0.0; else c2 = parseFloat(seller);

				var r = c2 - c1;
				
				return r.toFixed(2);
			};

			$scope.formatter_average_value = function(yp, seller) {
				var c1, c2;

				if(yp == undefined) c1 = 0.0; else c1 = parseFloat(yp);
				if(seller == undefined) c2 = 0.0; else c2 = parseFloat(seller);

				var r = (c2 + c1) / 2.0;
				
				return r.toFixed(2);
			};

			$scope.formatter_yp_u_value = function(yp, umpire) {
				var c1, c2;

				if(umpire == undefined) c1 = 0.0; else c1 = parseFloat(umpire);
				if(yp == undefined) c2 = 0.0; else c2 = parseFloat(yp);

				var r = c2 - c1;
				
				return r.toFixed(2);
			};

			$scope.formatter_umpire_value = function(umpire) {
				var r = Number(umpire);
				return r.toFixed(2);
			};

			$scope.formatter_seller_u_value = function(seller, umpire) {
				var c1, c2;

				if(umpire == undefined) c1 = 0.0; else c1 = parseFloat(umpire);
				if(seller == undefined) c2 = 0.0; else c2 = parseFloat(seller);

				var r = c2 - c1;
				
				return r.toFixed(2);
			};

			$scope.formatter_win_value = function(state) {
				if(state == 1) return "O";
				else return " ";
			};

			$scope.formatter_settle_value = function(settle) {
				var r = Number(settle);
				return r.toFixed(2);
			};

			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바

				paginationPageSizes : [ 5, 10, 20, 30, 40, 50, 60, 70 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 5,

				enableCellEditOnFocus : false, //셀 클릭시 edit모드 
				enableSelectAll : false, //전체선택 체크박스
				enableRowSelection : false, //로우 선택
				enableRowHeaderSelection : false, //맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 35, //체크박스 컬럼 길이
				enableHorizontalScrollbar : "1",
				enableVerticalScrollbar : "1",
				rowHeight : 27, //체크박스 컬럼 높이
				// useExternalPagination : true, //pagination을 직접 세팅
				enableAutoFitColumns : true, //컬럼 width를 자동조정
				multiSelect : false, //여러로우선택
				enablePagination : true,
				enablePaginationControls : true,

				columnDefs : [ //컬럼 세팅
				{
					displayName : 'NO',
					field : 'LOT_NO',
					width : '60',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'DMT',
					field : 'DMT',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'Y.P.',
					field : 'YP',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_yp_value(row.entity.YP)}}</div>'
				}, {
					displayName : 'SELLER',
					field : 'SELLER',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'SPLIT',
					field : 'DMT',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_split_value(row.entity.YP, row.entity.SELLER)}}</div>'
				}, {
					displayName : 'AVERAGE',
					field : 'YP',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_average_value(row.entity.YP, row.entity.SELLER)}}</div>'
				}, {
					displayName : 'Y.P.-U',
					field : 'UMPIRE',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_yp_u_value(row.entity.YP, row.entity.UMPIRE)}}</div>'
				}, {
					displayName : 'UMPIRE',
					field : 'UMPIRE',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_umpire_value(row.entity.UMPIRE)}}</div>'
				}, {
					displayName : 'SEL-U',
					field : 'UMPIRE',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_seller_u_value(row.entity.SELLER, row.entity.UMPIRE)}}</div>'
				}, {
					displayName : 'WIN',
					field : 'WIN',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_win_value(row.entity.STATE)}}</div>'
				}, {
					displayName : 'SETTLE',
					field : 'SETTLE',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_settle_value(row.entity.SETTLE)}}</div>'
				}]
			});

			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  
		} ]);

		//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
		app.controller('dataCtrl-3', [ '$scope', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
			var vm = this; //this를 vm에 대입, 아래에서 부모의 $scope를 vm에 추가하기 위해 			
			angular.extend(vm, $controller('CodeCtrl', { //CodeCtrl(ui-grid 커스텀 api)를 상속받는다
				// 자식컨트롤러의 vm에 부모 컨트롤러의 $scope를 합, 이로써 자식 컨트롤러에서 부모의 모든 $scope(this)를 사용 할 수 있음
				$scope : $scope
			}));
			var paginationOptions = vm.paginationOptions; //부모의 paginationOptions를 자식의 paginationOptions에 대입,즉시실행 함수

			paginationOptions.pageNumber = 1; //초기 page number
			paginationOptions.pageSize = 5; //초기 한번에 보여질 로우수
			$scope.paginationOptions = paginationOptions;

			$scope.gridApi = vm.gridApi; //외부에서 grid의 클릭이벤트와 같은것들을 쓰기 위해서
			$scope.loader = vm.loader;
			$scope.addRow = vm.addRow;
			$scope.uiGridConstants = uiGridConstants;
			$scope.pagination = vm.pagination;

			// 세션아이드코드 스코프에저장
			$scope.s_emp_code = "${s_emp_code}";

			$scope.formatter_yp_value = function(yp) {
				var r = Number(yp);
				return r.toFixed(2);
			};

			$scope.formatter_split_value = function(yp, seller) {
				var c1, c2;

				if(yp == undefined) c1 = 0.0; else c1 = parseFloat(yp);
				if(seller == undefined) c2 = 0.0; else c2 = parseFloat(seller);

				var r = c2 - c1;
				
				return r.toFixed(2);
			};

			$scope.formatter_average_value = function(yp, seller) {
				var c1, c2;

				if(yp == undefined) c1 = 0.0; else c1 = parseFloat(yp);
				if(seller == undefined) c2 = 0.0; else c2 = parseFloat(seller);

				var r = (c2 + c1) / 2.0;
				
				return r.toFixed(2);
			};

			$scope.formatter_yp_u_value = function(yp, umpire) {
				var c1, c2;

				if(umpire == undefined) c1 = 0.0; else c1 = parseFloat(umpire);
				if(yp == undefined) c2 = 0.0; else c2 = parseFloat(yp);

				var r = c2 - c1;
				
				return r.toFixed(2);
			};

			$scope.formatter_umpire_value = function(umpire) {
				var r = Number(umpire);
				return r.toFixed(2);
			};

			$scope.formatter_seller_u_value = function(seller, umpire) {
				var c1, c2;

				if(umpire == undefined) c1 = 0.0; else c1 = parseFloat(umpire);
				if(seller == undefined) c2 = 0.0; else c2 = parseFloat(seller);

				var r = c2 - c1;
				
				return r.toFixed(2);
			};

			$scope.formatter_win_value = function(state) {
				if(state == 1) return "O";
				else return " ";
			};

			$scope.formatter_settle_value = function(settle) {
				var r = Number(settle);
				return r.toFixed(2);
			};

			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바

				paginationPageSizes : [ 5, 10, 20, 30, 40, 50, 60, 70 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 5,

				enableCellEditOnFocus : false, //셀 클릭시 edit모드 
				enableSelectAll : false, //전체선택 체크박스
				enableRowSelection : false, //로우 선택
				enableRowHeaderSelection : false, //맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 35, //체크박스 컬럼 길이
				enableHorizontalScrollbar : "1",
				enableVerticalScrollbar : "1",
				rowHeight : 27, //체크박스 컬럼 높이
				// useExternalPagination : true, //pagination을 직접 세팅
				enableAutoFitColumns : true, //컬럼 width를 자동조정
				multiSelect : false, //여러로우선택
				enablePagination : true,
				enablePaginationControls : true,

				columnDefs : [ //컬럼 세팅
				{
					displayName : 'NO',
					field : 'LOT_NO',
					width : '60',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'DMT',
					field : 'DMT',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'Y.P.',
					field : 'YP',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_yp_value(row.entity.YP)}}</div>'
				}, {
					displayName : 'SELLER',
					field : 'SELLER',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'SPLIT',
					field : 'DMT',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_split_value(row.entity.YP, row.entity.SELLER)}}</div>'
				}, {
					displayName : 'AVERAGE',
					field : 'YP',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_average_value(row.entity.YP, row.entity.SELLER)}}</div>'
				}, {
					displayName : 'Y.P.-U',
					field : 'UMPIRE',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_yp_u_value(row.entity.YP, row.entity.UMPIRE)}}</div>'
				}, {
					displayName : 'UMPIRE',
					field : 'UMPIRE',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_umpire_value(row.entity.UMPIRE)}}</div>'
				}, {
					displayName : 'SEL-U',
					field : 'UMPIRE',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_seller_u_value(row.entity.SELLER, row.entity.UMPIRE)}}</div>'
				}, {
					displayName : 'WIN',
					field : 'WIN',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_win_value(row.entity.STATE)}}</div>'
				}, {
					displayName : 'SETTLE',
					field : 'SETTLE',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_settle_value(row.entity.SETTLE)}}</div>'
				}]
			});

			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  
		} ]);


		//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
		app.controller('dataCtrl-4', [ '$scope', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
			var vm = this; //this를 vm에 대입, 아래에서 부모의 $scope를 vm에 추가하기 위해 			
			angular.extend(vm, $controller('CodeCtrl', { //CodeCtrl(ui-grid 커스텀 api)를 상속받는다
				// 자식컨트롤러의 vm에 부모 컨트롤러의 $scope를 합, 이로써 자식 컨트롤러에서 부모의 모든 $scope(this)를 사용 할 수 있음
				$scope : $scope
			}));
			var paginationOptions = vm.paginationOptions; //부모의 paginationOptions를 자식의 paginationOptions에 대입,즉시실행 함수

			paginationOptions.pageNumber = 1; //초기 page number
			paginationOptions.pageSize = 5; //초기 한번에 보여질 로우수
			$scope.paginationOptions = paginationOptions;

			$scope.gridApi = vm.gridApi; //외부에서 grid의 클릭이벤트와 같은것들을 쓰기 위해서
			$scope.loader = vm.loader;
			$scope.addRow = vm.addRow;
			$scope.uiGridConstants = uiGridConstants;
			$scope.pagination = vm.pagination;

			// 세션아이드코드 스코프에저장
			$scope.s_emp_code = "${s_emp_code}";

			$scope.formatter_yp_value = function(yp) {
				var r = Number(yp);
				return r.toFixed(2);
			};

			$scope.formatter_split_value = function(yp, seller) {
				var c1, c2;

				if(yp == undefined) c1 = 0.0; else c1 = parseFloat(yp);
				if(seller == undefined) c2 = 0.0; else c2 = parseFloat(seller);

				var r = c2 - c1;
				
				return r.toFixed(2);
			};

			$scope.formatter_average_value = function(yp, seller) {
				var c1, c2;

				if(yp == undefined) c1 = 0.0; else c1 = parseFloat(yp);
				if(seller == undefined) c2 = 0.0; else c2 = parseFloat(seller);

				var r = (c2 + c1) / 2.0;
				
				return r.toFixed(2);
			};

			$scope.formatter_yp_u_value = function(yp, umpire) {
				var c1, c2;

				if(umpire == undefined) c1 = 0.0; else c1 = parseFloat(umpire);
				if(yp == undefined) c2 = 0.0; else c2 = parseFloat(yp);

				var r = c2 - c1;
				
				return r.toFixed(2);
			};

			$scope.formatter_umpire_value = function(umpire) {
				var r = Number(umpire);
				return r.toFixed(2);
			};

			$scope.formatter_seller_u_value = function(seller, umpire) {
				var c1, c2;

				if(umpire == undefined) c1 = 0.0; else c1 = parseFloat(umpire);
				if(seller == undefined) c2 = 0.0; else c2 = parseFloat(seller);

				var r = c2 - c1;
				
				return r.toFixed(2);
			};

			$scope.formatter_win_value = function(state) {
				if(state == 1) return "O";
				else return " ";
			};

			$scope.formatter_settle_value = function(settle) {
				var r = Number(settle);
				return r.toFixed(2);
			};

			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바

				paginationPageSizes : [ 5, 10, 20, 30, 40, 50, 60, 70 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 5,

				enableCellEditOnFocus : false, //셀 클릭시 edit모드 
				enableSelectAll : false, //전체선택 체크박스
				enableRowSelection : false, //로우 선택
				enableRowHeaderSelection : false, //맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 35, //체크박스 컬럼 길이
				enableHorizontalScrollbar : "1",
				enableVerticalScrollbar : "1",
				rowHeight : 27, //체크박스 컬럼 높이
				// useExternalPagination : true, //pagination을 직접 세팅
				enableAutoFitColumns : true, //컬럼 width를 자동조정
				multiSelect : false, //여러로우선택
				enablePagination : true,
				enablePaginationControls : true,

				columnDefs : [ //컬럼 세팅
				{
					displayName : 'NO',
					field : 'LOT_NO',
					width : '60',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'DMT',
					field : 'DMT',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'Y.P.',
					field : 'YP',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_yp_value(row.entity.YP)}}</div>'
				}, {
					displayName : 'SELLER',
					field : 'SELLER',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'SPLIT',
					field : 'DMT',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_split_value(row.entity.YP, row.entity.SELLER)}}</div>'
				}, {
					displayName : 'AVERAGE',
					field : 'YP',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_average_value(row.entity.YP, row.entity.SELLER)}}</div>'
				}, {
					displayName : 'Y.P.-U',
					field : 'UMPIRE',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_yp_u_value(row.entity.YP, row.entity.UMPIRE)}}</div>'
				}, {
					displayName : 'UMPIRE',
					field : 'UMPIRE',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_umpire_value(row.entity.UMPIRE)}}</div>'
				}, {
					displayName : 'SEL-U',
					field : 'UMPIRE',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_seller_u_value(row.entity.SELLER, row.entity.UMPIRE)}}</div>'
				}, {
					displayName : 'WIN',
					field : 'WIN',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_win_value(row.entity.STATE)}}</div>'
				}, {
					displayName : 'SETTLE',
					field : 'SETTLE',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_settle_value(row.entity.SETTLE)}}</div>'
				}]
			});

			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  
		} ]);

		function getMaterialList()
		{
			$.ajax({
				url : "/yp/zpp/ore/zpp_ore_get_material_list",
				type : "POST",
				cache : false,
				async : false,
				data : {
					_csrf : '${_csrf.token}'
				},
				dataType : "json",
				success : function(result) {
					for (var i in result.listValue) {
						var material_id = result.listValue[i].MATERIAL_ID;
						var material_name = result.listValue[i].MATERIAL_NAME;

						l_MaterialName[i] = material_name;
						l_MaterialID[i] = material_id;
					}
				},
				error : function(request, status, error) {
					//	console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
				}
			});
		}

		function getSellerList()
		{
			$.ajax({
				url : "/yp/zpp/ore/zpp_ore_get_seller_list",
				type : "POST",
				cache : false,
				async : false,
				data : {
					_csrf : '${_csrf.token}'
				},
				dataType : "json",
				success : function(result) {
					for (var i in result.listValue) {
						var seller_id = result.listValue[i].SELLER_ID;
						var seller_name = result.listValue[i].SELLER_NAME;

						l_SellerName[i] = seller_name;
						l_SellerID[i] = seller_id;
					}
				},
				error : function(request, status, error) {
					//	console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
				}
			});
		}

		$(document).ready(function() {
			//	console.log('document ready');

			getMaterialList();
			getSellerList();

			l_MASTER_ID = '${req_data.MASTER_ID}';

			document.getElementById("edt_MATERIAL_ID").value = get_material_name('${req_data.MATERIAL_ID}');
			document.getElementById("edt_SELLER_ID").value = get_seller_name('${req_data.SELLER_ID}');
			document.getElementById("edt_IMPORT_DATE").value = '${req_data.IMPORT_DATE}';

			load_ingredient_info();

			var data_scope_1;

			data_scope_1 = angular.element(document.getElementById("data-uiGrid-1")).scope(); //html id를 통해서 controller scope(this) 가져옴
			data_scope_1.gridApi.selection.on.rowSelectionChanged(
					data_scope_1,
					function(row) {});
			data_scope_1.gridApi.selection.on.rowSelectionChangedBatch(
					data_scope_1,
					function(rows) { //전체선택시 가져옴
			});
			// pagenation option setting  그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param1 = {
				listQuery : "yp_zpp.zpp_ore_umpire_detail_list", //list가져오는 마이바티스 쿼리 아이디
				cntQuery :  "yp_zpp.zpp_ore_umpire_detail_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
			};
			data_scope_1.paginationOptions = customExtend(data_scope_1.paginationOptions, param1); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝

			data_scope_1.reloadGrid({
				MASTER_ID : l_MASTER_ID,
				INGREDIENT_ID : l_INGREDIENT_ID[0]
			});

			var data_scope_2;

			data_scope_2 = angular.element(document.getElementById("data-uiGrid-2")).scope(); //html id를 통해서 controller scope(this) 가져옴
			data_scope_2.gridApi.selection.on.rowSelectionChanged(
					data_scope_2,
					function(row) {});
			data_scope_2.gridApi.selection.on.rowSelectionChangedBatch(
					data_scope_2,
					function(rows) { //전체선택시 가져옴
			});
			// pagenation option setting  그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param2 = {
				listQuery : "yp_zpp.zpp_ore_umpire_detail_list", //list가져오는 마이바티스 쿼리 아이디
				cntQuery :  "yp_zpp.zpp_ore_umpire_detail_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
			};
			data_scope_2.paginationOptions = customExtend(data_scope_2.paginationOptions, param2); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝

			data_scope_2.reloadGrid({
				MASTER_ID : l_MASTER_ID,
				INGREDIENT_ID : l_INGREDIENT_ID[1]
			});

			var data_scope_3;

			data_scope_3 = angular.element(document.getElementById("data-uiGrid-3")).scope(); //html id를 통해서 controller scope(this) 가져옴
			data_scope_3.gridApi.selection.on.rowSelectionChanged(
					data_scope_3,
					function(row) {});
			data_scope_3.gridApi.selection.on.rowSelectionChangedBatch(
					data_scope_3,
					function(rows) { //전체선택시 가져옴
			});
			// pagenation option setting  그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param3 = {
				listQuery : "yp_zpp.zpp_ore_umpire_detail_list", //list가져오는 마이바티스 쿼리 아이디
				cntQuery :  "yp_zpp.zpp_ore_umpire_detail_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
			};
			data_scope_3.paginationOptions = customExtend(data_scope_3.paginationOptions, param3); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝

			data_scope_3.reloadGrid({
				MASTER_ID : l_MASTER_ID,
				INGREDIENT_ID : l_INGREDIENT_ID[2]
			});

			var data_scope_4;

			data_scope_4 = angular.element(document.getElementById("data-uiGrid-4")).scope(); //html id를 통해서 controller scope(this) 가져옴
			data_scope_4.gridApi.selection.on.rowSelectionChanged(
					data_scope_4,
					function(row) {});
			data_scope_4.gridApi.selection.on.rowSelectionChangedBatch(
					data_scope_4,
					function(rows) { //전체선택시 가져옴
			});
			// pagenation option setting  그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param4 = {
				listQuery : "yp_zpp.zpp_ore_umpire_detail_list", //list가져오는 마이바티스 쿼리 아이디
				cntQuery :  "yp_zpp.zpp_ore_umpire_detail_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
			};
			data_scope_4.paginationOptions = customExtend(data_scope_4.paginationOptions, param4); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝

			data_scope_4.reloadGrid({
				MASTER_ID : l_MASTER_ID,
				INGREDIENT_ID : l_INGREDIENT_ID[3]
			});

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

			// 조회
			$("#search_btn").on("click", function() {
				//	console.log("search_btn clicked");

				load_umpire_list();
			});

			// 엑셀 다운로드
			$("#excel_btn").on("click", function() {
			});

			// 선택 저장
			$("#fnReg").on("click", function() {
			});
		});

		function set_NS(id, value) {
			//	console.log(id + ":" + value);
			if(value == null) document.getElementById(id).value = '';
			else document.getElementById(id).value = value;
		}

		function fnTimeForm(time){
			var h = time.substring(0,2);
			var m = time.substring(2,4);
			return h+":"+m;
		}

		function setCookie(name, value, expiredays) {
	        var date = new Date();
	        date.setDate(date.getDate() + expiredays);
	        document.cookie = escape(name) + "=" + escape(value) + "; expires=" + date.toUTCString();
	    }

		function getCookie(name) {
			var cookie = document.cookie;
			//	console.log(cookie);
			if (document.cookie != "") {
				var cookie_array = cookie.split("; ");
				for ( var index in cookie_array) {
					var cookie_name = cookie_array[index].split("=");
					if (cookie_name[0] == "ot_notice") {
						return cookie_name[1];
					}
				}
			}
			return ;
		}

		function get_material_name(material_id) {
			for(var i = 0;i < l_MaterialID.length;i ++) {
				if(l_MaterialID[i] == material_id) return l_MaterialName[i];
			}
			return material_id;
		};

		function get_seller_name(seller_id) {
			for(var i = 0;i < l_SellerID.length;i ++) {
				if(l_SellerID[i] == seller_id) return l_SellerName[i];
			}
			return seller_id;
		};
		
		function load_ingredient_info() {
			$.ajax({
				url : "/yp/zpp/ore/zpp_ore_req_ig_list",
				type : "POST",
				cache : false,
				async : false,
				data : {
					MASTER_ID : l_MASTER_ID,
					_csrf : '${_csrf.token}'
				},
				dataType : "json",
				success : function(result) {
					//	console.log("/yp/zpp/ore/zpp_ore_req_ig_list success : " + result.ig_list);

					l_INGREDIENT_CNT = result.ig_list.length;

					for (var i in result.ig_list) {
						l_INGREDIENT_ID[i] = result.ig_list[i].INGREDIENT_ID;
						l_INGREDIENT_NAME[i] = result.ig_list[i].INGREDIENT_NAME;

						//	console.log(l_INGREDIENT_ID[i] + " " + l_INGREDIENT_NAME[i]);
					}
				},
				error : function(request, status, error) {
					//	console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
				}
			});
		}

	</script>
	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
</body>