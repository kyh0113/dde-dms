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
SimpleDateFormat date = new SimpleDateFormat("yyyy/MM");
String toDay = date.format(today);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
/* 20200611_khj 메인화면의 역할별 스케줄테이블 동적으로 행높이 조절 추가 */
.ui-grid-pager-panel
{   
       position:relative !important;
}
.ui-grid-grid-footer
{
	float:none;
}
.grid, .ui-grid
{   
       height:auto;
}
.ng-isolate-scope
{
       height:auto !important;
/*        overflow: scroll ; */
}
#shds-uiGrid .ui-grid-canvas{

       width:auto;
       min-height:150px;
/*        height:auto !important; */
}
#shds-uiGrid .ui-grid-canvas{

       width:auto;
/*        min-height:150px; */
       height:auto !important;
}
.ui-grid-viewport{
       height:auto !important;
       overflow-x: hidden !important;
       overflow-y: scroll !important;
}
/* .ui-grid-pager-container,.ui-grid-pager-count-container */
/* { */
/*        padding-top:5px; */
/* } */
</style>
<title>투보수 예산 조회
</title>
</head>
<body>
	<h2>
		투보수 예산 조회
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
	<form id="frm" name="frm" method="post">
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="GUBUN" value="${req_data.GUBUN}">
		<input type="hidden" name="excel_flag"/>
		<section>
			<div class="tbl_box">
				<table cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="12%" />
						<col />
						<col width="12%" />
						<col />
					</colgroup>
					<tr>
						<th>WBS코드</th>
						<td>
							<input type="text" name="POSID" id="POSID" value="${req_data.POSID}">
							<a href="#" onclick="fnSearchPopup('1');"><img src="/resources/yp/images/ic_search.png"></a>
						</td>
					</tr>
				</table>
				<div class="btn_wrap">
					<input type="button" class="btn btn_make" id="excel_btn" value="엑셀 다운로드"/>
					<input type="button" class="btn btn_search" id="search_btn" value="조회"/>
				</div>
			</div>
		</section>
	</form>
	<div class="float_wrap">
		<div class="fl">
			<div class="stitle">WBS 목록</div>
		</div>
		<div class="fr">
			<div class="btn_wrap">
			</div>
		</div>
	</div>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="shdsCtrl">
			<div data-ui-i18n="ko">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
	</section>
	<br><br>
	<div id="wbs2" style="display:none; width:85%;">
	<div class="float_wrap">
		<div class="fl">
			<div class="stitle">월별 WBS 코드 내역</div>
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type="button" class="btn btn_make" id="excel_btn2" value="엑셀 다운로드"/>
			</div>
		</div>
	</div>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid2" data-ng-controller="shdsCtrl2">
			<div data-ui-i18n="ko" style="height: 100%;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
	</section>
	<br><br>
	</div>
	<script>
		//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
		/* WBS 목록 그리드 */
		app.controller('shdsCtrl', [ '$scope', '$window', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $window, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
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

			// 세션아이디코드 스코프에저장
			$scope.s_emp_code = "${s_emp_code}";
 
			
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
			
			// formater - String yyyyMM -> String yyyy.MM
			$scope.formatter_yyyymm = function(str_date) {
				return str_date.substring(0,4)+"."+str_date.substring(4,6)
			};
			
			//WBS 상세보기
			$scope.openDetail_WBS = function(row){
				fnSearchReport(row);
			};
			
			//cellClass
			$scope.cellClassSet = function(grid, row, col, rowRenderIndex, colRenderIndex){
				var className = "";
				switch(col.field){
					case "PSPID" :	className = "left"; 
					break;
				}
				if(col.field == "PSPID"){
					className = className + " blue cursor-underline";
				}
				
				return className;
			}
			
			

			var cellTmp =  '<div class="ui-grid-cell-contents"><span ng-if="row.entity.LEVEL == 2">&emsp;&emsp;</span><span ng-if="row.entity.LEVEL == 3">&emsp;&emsp;&emsp;&emsp;</span><a class="blue" style="text-decoration: underline;" ng-click="grid.appScope.openDetail_WBS(row.entity.PSPID)">{{row.entity.PSPID}}</a>&nbsp;&nbsp;&nbsp;&nbsp;{{row.entity.POST1}}</div>';

			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{   
				enableGridMenu: true,   //필터버튼
				enableFiltering : false, //각 컬럼에 검색바
				showColumnFooter : true,
				showGridFooter : false,
				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 1000,

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
				enablePagination : false,
				enablePaginationControls : false,

				columnDefs : 
				[ //컬럼 세팅
					{
						displayName : 'WBS 코드',
						field : 'PSPID',
						visible : true,
// 						cellClass : $scope.cellClassSet,
						cellClass : "left",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : cellTmp,
						footerCellTemplate: '<div class="ui-grid-cell-contents center">합 계</div>'
					}, 
					{
						displayName : '예산',
						field : 'DMBTR_B',
						width : '12%',
						visible : true,
						cellClass : "right",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.DMBTR_B)}}</div>',
						aggregationType: function ()
				        {
				            if(!$scope.gridApi)
				                return 0;
				            var sum = 0;
				            var visibleRows = $scope.gridApi.core.getVisibleRows($scope.gridApi.grid);
				            for (var i = 0; i < visibleRows.length; i++) {
				              if(visibleRows[i].entity.LEVEL === "1") {
				                  sum += parseInt(visibleRows[i].entity.DMBTR_B);
				              }
				            }
				            return sum;
				        },
				        footerCellTemplate: '<div class="ui-grid-cell-contents right" >{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
					}, 
					{
						displayName : '실적',
						field : 'DMBTR_S',
						width : '12%',
						visible : true,
						cellClass : "right",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.DMBTR_S)}}</div>',
						aggregationType: function ()
				        {
				            if(!$scope.gridApi)
				                return 0;
				            var sum = 0;
				            var visibleRows = $scope.gridApi.core.getVisibleRows($scope.gridApi.grid);
				            for (var i = 0; i < visibleRows.length; i++) {
				              if(visibleRows[i].entity.LEVEL === "1") {
				                  sum += parseInt(visibleRows[i].entity.DMBTR_S);
				              }
				            }
				            return sum;
				        },
				        footerCellTemplate: '<div class="ui-grid-cell-contents right" >{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
					}, 
					{
						displayName : '약정',
						field : 'DMBTR_Y',
						width : '12%',
						visible : true,
						cellClass : "right",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.DMBTR_Y)}}</div>',
						aggregationType: function ()
				        {
				            if(!$scope.gridApi)
				                return 0;
				            var sum = 0;
				            var visibleRows = $scope.gridApi.core.getVisibleRows($scope.gridApi.grid);
				            for (var i = 0; i < visibleRows.length; i++) {
				              if(visibleRows[i].entity.LEVEL === "1") {
				                  sum += parseInt(visibleRows[i].entity.DMBTR_Y);
				              }
				            }
				            return sum;
				        },
				        footerCellTemplate: '<div class="ui-grid-cell-contents right" >{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
					}, 
					{
						displayName : '지정(실적+약정)',
						field : 'DMBTR_SY',
						width : '12%',
						visible : true,
						cellClass : "right",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.DMBTR_SY)}}</div>',
						aggregationType: function ()
				        {
				            if(!$scope.gridApi)
				                return 0;
				            var sum = 0;
				            var visibleRows = $scope.gridApi.core.getVisibleRows($scope.gridApi.grid);
				            for (var i = 0; i < visibleRows.length; i++) {
				              if(visibleRows[i].entity.LEVEL === "1") {
				                  sum += parseInt(visibleRows[i].entity.DMBTR_SY);
				              }
				            }
				            return sum;
				        },
				        footerCellTemplate: '<div class="ui-grid-cell-contents right" >{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
					}, 
					{
						displayName : '사용가능',
						field : 'DMBTR_A',
						width : '12%',
						visible : true,
						cellClass : "right",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.DMBTR_A)}}</div>',
						aggregationType: function ()
				        {
				            if(!$scope.gridApi)
				                return 0;
				            var sum = 0;
				            var visibleRows = $scope.gridApi.core.getVisibleRows($scope.gridApi.grid);
				            for (var i = 0; i < visibleRows.length; i++) {
				              if(visibleRows[i].entity.LEVEL === "1") {
				                  sum += parseInt(visibleRows[i].entity.DMBTR_A);
				              }
				            }
				            return sum;
				        },
				        footerCellTemplate: '<div class="ui-grid-cell-contents right" >{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
					}, 
					
				],
				onRegisterApi: function( gridApi ) {
			    	$scope.gridApi = gridApi;
				}
			});

			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  

		} ]);
		
		
		/* 월별 WBS 코드 내역 그리드*/
		app.controller('shdsCtrl2', [ '$scope', '$window', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $window, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
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

			// 세션아이디코드 스코프에저장
			$scope.s_emp_code = "${s_emp_code}";

			
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
			
			// formater - String yyyyMM -> String yyyy.MM
			$scope.formatter_yyyymm = function(str_date) {
				return str_date.substring(0,4)+"."+str_date.substring(4,6)
			};
	
			
			//월별 WBS 상세보기
			$scope.TYPE1 = "B";
			$scope.TYPE2 = "S";
			$scope.TYPE3 = "Y";
			$scope.openPop_WBS = function(gubun, row_param1, row_param2){
				fnDetailPopup(gubun, row_param1, row_param2);
			};
			
			//cellClass
			$scope.cellClassSet = function(grid, row, col, rowRenderIndex, colRenderIndex){
				var className = "";
				switch(col.field){
					case "PSPID" :	className = "left"; 
					break;
				}
				if(col.field == "PSPID"){
					className = className + " blue cursor-underline";
				}
				
				return className;
			}
			

			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,    //필터버튼
				enableFiltering : false, //각 컬럼에 검색바
				showColumnFooter : true,
				showGridFooter : false,
				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 1000,

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
				enablePagination : false,
				enablePaginationControls : false,
				
				columnDefs : 
				[ //컬럼 세팅
					{
						displayName : 'WBS 코드',
						field : 'PSPID',
						visible : true,
						cellClass : "left",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents">{{row.entity.PSPID}}&nbsp;&nbsp;&nbsp;&nbsp;{{row.entity.POST1}}</div>'
					}, 
					{
						displayName : '기간',
						field : 'YYYYMM',
						width : '10%',
						visible : true,
						cellClass : "left",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div ng-if="row.entity.YYYYMM != 000000" class="ui-grid-cell-contents">{{row.entity.YYYYMM}}&nbsp;&nbsp;{{row.entity.TXT}}</div><div ng-if="row.entity.YYYYMM == 000000" class="ui-grid-cell-contents">{{row.entity.TXT}}</div>',
						footerCellTemplate: '<div class="ui-grid-cell-contents center">합 계</div>'
					}, 
					{
						displayName : '예산',
						field : 'DMBTR_B',
						width : '12%',
						visible : true,
						cellClass : "right",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents"><a class="blue" style="text-decoration: underline;" ng-click="grid.appScope.openPop_WBS(grid.appScope.TYPE1, row.entity.PSPID, row.entity.YYYYMM)">{{grid.appScope.formatter_decimal(row.entity.DMBTR_B)}}</a></div>',
						aggregationType: function ()
				        {
				            if(!$scope.gridApi)
				                return 0;
				            var sum = 0;
				            var visibleRows = $scope.gridApi.core.getVisibleRows($scope.gridApi.grid);
				            for (var i = 0; i < visibleRows.length; i++) {
				              if(visibleRows[i].entity.TXT != '잔여금액') {
				                  sum += parseInt(visibleRows[i].entity.DMBTR_B);
				              }
				            }
				            return sum;
				        },
						footerCellTemplate: '<div class="ui-grid-cell-contents right" >{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
					}, 
					{
						displayName : '실적',
						field : 'DMBTR_S',
						width : '12%',
						visible : true,
						cellClass : "right",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents"><a class="blue" style="text-decoration: underline;" ng-click="grid.appScope.openPop_WBS(grid.appScope.TYPE2, row.entity.PSPID, row.entity.YYYYMM)">{{grid.appScope.formatter_decimal(row.entity.DMBTR_S)}}</a></div>',
						aggregationType: function ()
				        {
				            if(!$scope.gridApi)
				                return 0;
				            var sum = 0;
				            var visibleRows = $scope.gridApi.core.getVisibleRows($scope.gridApi.grid);
				            for (var i = 0; i < visibleRows.length; i++) {
				              if(visibleRows[i].entity.TXT != '잔여금액') {
				                  sum += parseInt(visibleRows[i].entity.DMBTR_S);
				              }
				            }
				            return sum;
				        },
						footerCellTemplate: '<div class="ui-grid-cell-contents right" >{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
					}, 
					{
						displayName : '약정',
						field : 'DMBTR_Y',
						width : '12%',
						visible : true,
						cellClass : "right",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents"><a class="blue" style="text-decoration: underline;" ng-click="grid.appScope.openPop_WBS(grid.appScope.TYPE3, row.entity.PSPID, row.entity.YYYYMM)">{{grid.appScope.formatter_decimal(row.entity.DMBTR_Y)}}</a></div>',
						aggregationType: function ()
				        {
				            if(!$scope.gridApi)
				                return 0;
				            var sum = 0;
				            var visibleRows = $scope.gridApi.core.getVisibleRows($scope.gridApi.grid);
				            for (var i = 0; i < visibleRows.length; i++) {
				              if(visibleRows[i].entity.TXT != '잔여금액') {
				                  sum += parseInt(visibleRows[i].entity.DMBTR_Y);
				              }
				            }
				            return sum;
				        },
						footerCellTemplate: '<div class="ui-grid-cell-contents right" >{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
					}, 
					{
						displayName : '지정(실적+약정)',
						field : 'DMBTR_SY',
						width : '12%',
						visible : true,
						cellClass : "right",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.DMBTR_SY)}}</div>',
						aggregationType: function ()
				        {
				            if(!$scope.gridApi)
				                return 0;
				            var sum = 0; 
				            var visibleRows = $scope.gridApi.core.getVisibleRows($scope.gridApi.grid);
				            for (var i = 0; i < visibleRows.length; i++) {
				              if(visibleRows[i].entity.TXT != '잔여금액') {
				                  sum += parseInt(visibleRows[i].entity.DMBTR_SY);
				              }
				            }
				            return sum;
				        },
						footerCellTemplate: '<div class="ui-grid-cell-contents right" >{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
					}, 
					{
						displayName : '사용가능',
						field : 'DMBTR_A',
						width : '12%',
						visible : true,
						cellClass : "right",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.DMBTR_A)}}</div>',
						aggregationType: function ()
				        {
				            if(!$scope.gridApi)
				                return 0;
				            var sum = 0;
				            var visibleRows = $scope.gridApi.core.getVisibleRows($scope.gridApi.grid);
				            for (var i = 0; i < visibleRows.length; i++) {
				                  sum += parseInt(visibleRows[i].entity.DMBTR_A);
				            }
				            return sum;
				        },
						footerCellTemplate: '<div class="ui-grid-cell-contents right" >{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
					}, 
					
				],
				onRegisterApi: function( gridApi ) {
			    	$scope.gridApi = gridApi;
				}
			});

			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  

		} ]);
		
		
		

		$(document).ready(function() {
			// 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
			scope = angular.element(document.getElementById("shds-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
			scope2 = angular.element(document.getElementById("shds-uiGrid2")).scope(); //html id를 통해서 controller scope(this) 가져옴
			scope.gridApi.selection.on.rowSelectionChanged(scope, function(row) { //로우 선택할때마다 이벤트
				// 				console.log("row2", row.entity);
			});
			scope.gridApi.selection.on.rowSelectionChangedBatch(scope, function(rows) { //전체선택시 가져옴
				// 				console.log("row3", rows[0].entity); //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
			});
			// pagenation option setting  그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param = {
				EXEC_RFC : "Y", // RFC 여부
				RFC_TYPE : "ZFI_BUD", // RFC 구분
				RFC_FUNC : "ZWEB_BUDGET_CJE0_LIST" // RFC 함수명
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합

			var param2 = {
				EXEC_RFC : "Y", // RFC 여부
				RFC_TYPE : "ZFI_BUD", // RFC 구분
				RFC_FUNC : "ZWEB_BUDGET_CJE0_LIST", // RFC 함수명
				GUBUN    : "X"  //추가 파라메터
			};
			scope2.paginationOptions = customExtend(scope2.paginationOptions, param2); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
		
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
		});
	</script>
	<script type="text/javascript">
		$(document).ready(function() {	
			// 조회
			$("#search_btn").on("click", function() {
				$("input[name=excel_flag]").val("");
				scope.reloadGrid({
					POSID  : $("input[name=POSID]").val()
				});
				$("#wbs2").hide();	//월별 WBS 그리드 숨김	
				
	// 			 scope.gridOptions.data = content;
	// 			 scope.gridApi.core.notifyDataChange(scope.uiGridConstants.dataChange.ALL);
	// 			 setTimeout(function(){
	// 				 scope.gridApi.treeBase.expandAllRows();
	// 			 }, 0)
				 
			});
	
			// 엑셀 다운로드
			$("#excel_btn").on("click", function() {
				$("input[name=excel_flag]").val("1");
				//20191023_khj for csrf
				var csrf_element = document.createElement("input");
				csrf_element.name = "_csrf";
				csrf_element.value = "${_csrf.token}";
				csrf_element.type = "hidden";
				//20191023_khj for csrf
				var xlsForm = document.createElement("form");

				xlsForm.name = "sndFrm";
				xlsForm.method = "post";
				xlsForm.action = "/yp/zfi/bud/xls/zfi_bud_wbs_read";

				document.body.appendChild(xlsForm);

				xlsForm.appendChild(csrf_element);

				var pr = {
					POSID   : $('input[name=POSID]').val(),
	 				empCode : "${req_data.emp_code}", 
				};

				$.each(pr, function(k, v) {
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
			
			// 엑셀 다운로드
			$("#excel_btn2").on("click", function() {
				$("input[name=excel_flag]").val("1");
				//20191023_khj for csrf
				var csrf_element = document.createElement("input");
				csrf_element.name = "_csrf";
				csrf_element.value = "${_csrf.token}";
				csrf_element.type = "hidden";
				//20191023_khj for csrf
				var xlsForm = document.createElement("form");

				xlsForm.name = "sndFrm";
				xlsForm.method = "post";
				xlsForm.action = "/yp/zfi/bud/xls/zfi_bud_wbs_read_detail";

				document.body.appendChild(xlsForm);

				xlsForm.appendChild(csrf_element);

				var pr = {
					POSID   : scope2.gridApi.grid.rows[0].entity.PSPID,
					GUBUN   : "X",
	 				empCode : "${req_data.emp_code}", 
				};

				$.each(pr, function(k, v) {
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
		});
	
	
		function fnSearchReport(id){
			scope2.reloadGrid({
				POSID  : id
			});
			
			$("#wbs2").show();	//월별 WBS 그리드 표시	
		}
	
	
		function fnSearchPopup(type){
			if(type=="1"){
				window.open("/yp/popup/zfi/bud/retrievePOSID","WBS 검색","width=600,height=800,scrollbars=yes");	
			}
		}
	
		function fnDetailPopup(type,posid,date){
			window.open("/yp/popup/bud/retrieveBudgetStatusReportPop?POSID="+posid+"&GUBUN="+type+"&YYYYMM="+date,"상세보기","width=1000,height=800,scrollbars=yes");
		}
	
	
		function fnExelDownReport(posid){
			 $("input[name=excel_flag]").val("1");	
			 $("#frm").attr("action", "/fi/retrieveBudgetStatusReport?POSID="+posid);
			 $("#frm").submit();
			 $('.wrap-excelloading').removeClass('display-none');
			 setTimeout(function() {
				  $('.wrap-excelloading').addClass('display-none');
			 },5000); //5초
		}
	
	</script>
</body>