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
SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/dd");
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
.ui-grid-canvas{

       width:auto;
       min-height:100px;
/*     height:auto !important; */
}
</style>
<title>투보수 예산 상세조회
</title>
</head>
<body>
	<h2>
		투보수 예산 상세조회
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
		<input type="hidden" name="excel_flag"/>
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
						<th>유형</th>
						<td>
							<input type="radio" name="GUBUN" value="1" <c:if test="${req_data.GUBUN eq '1'}">checked</c:if>/><label for="1">투자</label>&nbsp;&nbsp;
							<input type="radio" name="GUBUN" value="8" <c:if test="${req_data.GUBUN eq '8'}">checked</c:if>/><label for="8">보수</label>&nbsp;&nbsp;
						</td>
						<th>부서</th>
						<td>
							<input type="text" name="RORG_S" id="RORG_S" value="${req_data.RORG_S}">
							<a href="#" onclick="fnSearchPopup('1');"><img src="/resources/yp/images/ic_search.png"></a>
						</td>
						<th>전기일</th>
						<td>
							<input class="calendar dtp" type="text" name="BUDAT_S" id="BUDAT_S" value="<c:choose><c:when test="${empty req_data.BUDAT_S}"><%=toDay%></c:when><c:otherwise>${req_data.BUDAT_S}</c:otherwise></c:choose>">
							~
							<input class="calendar dtp" type="text" name="BUDAT_E" id="BUDAT_E" value="<c:choose><c:when test="${empty req_data.BUDAT_E}"><%=toDay%></c:when><c:otherwise>${req_data.BUDAT_E}</c:otherwise></c:choose>">
						</td>
					</tr>
					<tr>
						<th>WBS코드</th>
						<td>
							<input type="text" name="POSID" id="POSID" value="${req_data.POSID}">
							<a href="#" onclick="fnSearchPopup('2');"><img src="/resources/yp/images/ic_search.png"></a>
						</td>
						<th>프로젝트 속성</th>
						<td>
							<input type="checkbox" name="PRJ1" id="PRJ1"><label for="PRJ1">환경개선</label>&nbsp;&nbsp;
							<input type="checkbox" name="PRJ2" id="PRJ2"><label for="PRJ2">생산증대</label>&nbsp;&nbsp;
							<input type="checkbox" name="PRJ3" id="PRJ3"><label for="PRJ3">설비대체</label>&nbsp;&nbsp;
							<input type="checkbox" name="PRJ4" id="PRJ4"><label for="PRJ4">안전관리</label>&nbsp;&nbsp;
							<input type="checkbox" name="PRJ5" id="PRJ5"><label for="PRJ5">기타</label>&nbsp;&nbsp;
						</td>
						<th>&nbsp;</th>
						<td>
							<input type="checkbox" name="GRIR" id="GRIR" value="1" <c:if test="${req_data.GRIR eq '1'}">checked</c:if>><label for="GRIR">GR/IR 계정 포함</label>
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
		<div id="shds-uiGrid" data-ng-controller="shdsCtrl" style="height: auto;">
			<div data-ui-i18n="ko" style="height: 550px;"><!-- 높이조절이 원하는대로 안됨. 확인필요. -->
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav data-ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter data-ui-grid-grouping>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
	</section>
	
	<script>
		//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
		/* WBS 목록 그리드 */
		app.controller('shdsCtrl', [ '$scope', '$window', '$controller', '$log', 'StudentService', 'uiGridConstants', 'uiGridGroupingConstants', 'uiGridTreeViewConstants', function($scope, $window, $controller, $log, StudentService, uiGridConstants, uiGridGroupingConstants, uiGridTreeViewConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
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
			$scope.searchCnt = vm.searchCnt;
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
			
			$scope.openPop_WbsDetail = function(type, row) {
				fnDetailPopup(type, row.POSID);
			}
			
			//구분마다 그리드 컬럼정보 변경
			$scope.gridColChange = function(value){
				var gubun = $("input[name='GUBUN']:checked").val();		//선택된 유형
				if(gubun == "1"){	//유형:투자
					if(value == "Y"){	//프로젝트 속성 1개라도 체크된 경우 조회시 그리드 컬럼변경
						$scope.gridoptions = {};
						$scope.gridOptions.columnDefs = columnDefs2;							
						$scope.gridOptions.multiSelect = false;
						$scope.gridOptions.columnDefs[5].displayName = '계약금액';
						$scope.gridOptions.columnDefs[6].displayName = '투자금액';
					}else{
						$scope.gridoptions = {};
						$scope.gridOptions.columnDefs = columnDefs1;							
						$scope.gridOptions.multiSelect = true;
						$scope.gridOptions.columnDefs[3].displayName = '계약금액';
						$scope.gridOptions.columnDefs[4].displayName = '투자금액';
					}
				}else{				//유형:보수
					if(value == "Y"){	//프로젝트 속성 1개라도 체크된 경우 조회시 그리드 컬럼변경
						$scope.gridoptions = {};
						$scope.gridOptions.columnDefs = columnDefs2;							
						$scope.gridOptions.multiSelect = false;
						$scope.gridOptions.columnDefs[5].displayName = '오더금액';
						$scope.gridOptions.columnDefs[6].displayName = '집행금액';
					}else{
						$scope.gridoptions = {};
						$scope.gridOptions.columnDefs = columnDefs1;							
						$scope.gridOptions.multiSelect = true;
						$scope.gridOptions.columnDefs[3].displayName = '오더금액';
						$scope.gridOptions.columnDefs[4].displayName = '집행금액';
					}
				}
				
				//그리드 초기화 모음
 				$scope.gridOptions.data.length = 0;											//그리드 data 초기화
 				$scope.gridApi.selection.clearSelectedRows();								//그리드 selection 초기화
 			    $scope.gridApi.core.notifyDataChange(uiGridConstants.dataChange.ALL);		//그리드 컬럼 변경내용 즉시적용	
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
			
			
			
			var columnDefs1 =
			[
				{
					displayName : 'WBS 코드',
					field : 'POSID',
					width : "10%",
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
				}, 
				{
					displayName : 'WBS 코드 내역',
					field : 'POST1',
					visible : true,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false,
					footerCellTemplate: '<div class="ui-grid-cell-contents center">합 계</div>'
				}, 
				{
					displayName : '품의금액',
					field : 'DMBTR_CS',
					width : '12%',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.DMBTR_CS)}}</div>',
// 			        aggregationType: uiGridConstants.aggregationTypes.sum,
			        footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>',
					treeAggregationType: uiGridGroupingConstants.aggregation.SUM,
					treeAggregationUpdateEntity: true,
					customTreeAggregationFinalizerFn: function( aggregation ) {
						aggregation.rendered = $scope.formatter_decimal(aggregation.value);
					},
				}, 
				{
					displayName : '계약금액',
					field : 'DMBTR_CO',
					width : '12%',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents ng-binding ng-scope ui-grid-click-column cursor blue" style="text-decoration: underline;" ng-click="grid.appScope.openPop_WbsDetail(1, row.entity)">{{grid.appScope.formatter_decimal(row.entity.DMBTR_CO)}}</div>',
// 			        aggregationType: uiGridConstants.aggregationTypes.sum,
			        footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>',
					treeAggregationType: uiGridGroupingConstants.aggregation.SUM,
					treeAggregationUpdateEntity: true,
					customTreeAggregationFinalizerFn: function( aggregation ) {
						aggregation.rendered = $scope.formatter_decimal(aggregation.value);
					},
				}, 
				{
					displayName : '투자금액',
					field : 'DMBTR_OR',
					width : '12%',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents ng-binding ng-scope ui-grid-click-column cursor blue" style="text-decoration: underline;" ng-click="grid.appScope.openPop_WbsDetail(2, row.entity)">{{grid.appScope.formatter_decimal(row.entity.DMBTR_OR)}}</div>',
// 			        aggregationType: uiGridConstants.aggregationTypes.sum,
			        footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>',
					treeAggregationType: uiGridGroupingConstants.aggregation.SUM,
					treeAggregationUpdateEntity: true,
					customTreeAggregationFinalizerFn: function( aggregation ) {
						aggregation.rendered = $scope.formatter_decimal(aggregation.value);
					},
				}, 
				{
					displayName : '지급금액',
					field : 'DMBTR_PR',
					width : '12%',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents ng-binding ng-scope ui-grid-click-column cursor blue" style="text-decoration: underline;" ng-click="grid.appScope.openPop_WbsDetail(3, row.entity)">{{grid.appScope.formatter_decimal(row.entity.DMBTR_PR)}}</div>',
// 			        aggregationType: uiGridConstants.aggregationTypes.sum,
			        footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>',
					treeAggregationType: uiGridGroupingConstants.aggregation.SUM,
					treeAggregationUpdateEntity: true,
					customTreeAggregationFinalizerFn: function( aggregation ) {
						aggregation.rendered = $scope.formatter_decimal(aggregation.value);
					},
				}, 
			];	
			
			var columnDefs2 =
			[
				{
					displayName : '프로젝트 목적',
					field : 'TITLE',
					width : "10%",
					visible : true,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: '<div ng-if="row.groupHeader !== undefined && col.grouping.groupPriority === row.treeLevel" class="ui-grid-cell-contents">{{row.treeNode.aggregations[0].groupVal}} ({{row.treeNode.aggregations[0].value}}건)</div>',
					grouping: { groupPriority: 0 }, sort: { priority: 0, direction: 'asc' },
				}, 
				{
					displayName : '보조 목적',
					field : 'TITLE2',
					width : "10%",
					visible : true,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: '<div ng-if="row.groupHeader !== undefined && col.grouping.groupPriority === row.treeLevel" class="ui-grid-cell-contents">{{row.treeNode.aggregations[1].groupVal}} ({{row.treeNode.aggregations[1].value}}건)</div>',
					grouping: { groupPriority: 1 }, sort: { priority: 1, direction: 'asc' },
				}, 
				{
					displayName : 'WBS 코드',
					field : 'POSID',
					width : "10%",
					visible : true,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false,
				}, 
				{
					displayName : 'WBS 코드 내역',
					field : 'POST1',
					visible : true,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false,
					footerCellTemplate: '<div class="ui-grid-cell-contents center">합 계</div>'
				}, 
				{
					displayName : '품의금액',
					field : 'DMBTR_CS',
					width : '12%',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: '<div ng-if="row.groupHeader !== undefined" class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.treeNode.aggregations[2].rendered)}}</div>'+ 
				      			  '<div ng-if="row.groupHeader === undefined" class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.DMBTR_CS)}}</div>',
					footerCellTemplate: '<div class="ui-grid-cell-contents right" >{{grid.appScope.formatter_decimal(col.getAggregationValue().replace("소계: ", ""))}}</div>',
// 			        aggregationType: uiGridConstants.aggregationTypes.sum,
					treeAggregationType: uiGridGroupingConstants.aggregation.SUM,
					treeAggregationUpdateEntity: true,
					customTreeAggregationFinalizerFn: function( aggregation ) {
				        aggregation.rendered = "소계: " + $scope.formatter_decimal(aggregation.value);
					},
				}, 
				{
					displayName : '계약금액',
					field : 'DMBTR_CO',
					width : '12%',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: '<div ng-if="row.groupHeader !== undefined" class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.treeNode.aggregations[3].rendered)}}</div>'+ 
				      			  '<div ng-if="row.groupHeader === undefined" class="ui-grid-cell-contents ng-binding ng-scope ui-grid-click-column cursor blue" style="text-decoration: underline;" ng-click="grid.appScope.openPop_WbsDetail(1, row.entity)">{{grid.appScope.formatter_decimal(row.entity.DMBTR_CO)}}</div>',
				    footerCellTemplate: '<div class="ui-grid-cell-contents right" >{{grid.appScope.formatter_decimal(col.getAggregationValue().replace("소계: ", ""))}}</div>',
// 			        aggregationType: uiGridConstants.aggregationTypes.sum,
					treeAggregationType: uiGridGroupingConstants.aggregation.SUM,
					treeAggregationUpdateEntity: true,
					customTreeAggregationFinalizerFn: function( aggregation ) {
				        aggregation.rendered = "소계: " + $scope.formatter_decimal(aggregation.value);
					},
				}, 
				{
					displayName : '투자금액',
					field : 'DMBTR_OR',
					width : '12%',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: '<div ng-if="row.groupHeader !== undefined" class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.treeNode.aggregations[4].rendered)}}</div>'+ 
				      			  '<div ng-if="row.groupHeader === undefined" class="ui-grid-cell-contents ng-binding ng-scope ui-grid-click-column cursor blue" style="text-decoration: underline;" ng-click="grid.appScope.openPop_WbsDetail(2, row.entity)">{{grid.appScope.formatter_decimal(row.entity.DMBTR_OR)}}</div>',
				    footerCellTemplate: '<div class="ui-grid-cell-contents right" >{{grid.appScope.formatter_decimal(col.getAggregationValue().replace("소계: ", ""))}}</div>',
// 			        aggregationType: uiGridConstants.aggregationTypes.sum,
					treeAggregationType: uiGridGroupingConstants.aggregation.SUM,
					treeAggregationUpdateEntity: true,
					customTreeAggregationFinalizerFn: function( aggregation ) {
				        aggregation.rendered = "소계: " + $scope.formatter_decimal(aggregation.value);
					},
				}, 
				{
					displayName : '지급금액',
					field : 'DMBTR_PR',
					width : '12%',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: '<div ng-if="row.groupHeader !== undefined" class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.treeNode.aggregations[5].rendered)}}</div>'+ 
				      			  '<div ng-if="row.groupHeader === undefined" class="ui-grid-cell-contents ng-binding ng-scope ui-grid-click-column cursor blue" style="text-decoration: underline;" ng-click="grid.appScope.openPop_WbsDetail(3, row.entity)">{{grid.appScope.formatter_decimal(row.entity.DMBTR_PR)}}</div>',
				    footerCellTemplate: '<div class="ui-grid-cell-contents right" >{{grid.appScope.formatter_decimal(col.getAggregationValue().replace("소계: ", ""))}}</div>',
// 			        aggregationType: uiGridConstants.aggregationTypes.sum,
					treeAggregationType: uiGridGroupingConstants.aggregation.SUM,
					treeAggregationUpdateEntity: true,
					customTreeAggregationFinalizerFn: function( aggregation ) {
				        aggregation.rendered = "소계: " + $scope.formatter_decimal(aggregation.value);
					},
				}, 
			];
			

			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바
				showColumnFooter : true,
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
				
				treeRowHeaderAlwaysVisible: false,
				enableGroupHeaderSelection: true,
				fastWatch: true,
				
				columnDefs : columnDefs1,
				
				onRegisterApi: function( gridApi ) {
			    	$scope.gridApi = gridApi;
				}
			});

			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			$scope.reloadGrid_custom = vm.reloadGrid_custom;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  

		} ]);
		
		

		$(document).ready(function() {
			// 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
			scope = angular.element(document.getElementById("shds-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
			
			scope.gridApi.core.on.rowsRendered(scope, function() {	//그리드 렌더링 후 이벤트
			 	//console.log(scope);
				//alert(scope.searchCnt);
			});
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
				RFC_FUNC : "ZWEB_BUDGET_WBS_LIST" // RFC 함수명
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
		});
	</script>
	<script type="text/javascript">
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
			
			//조회조건 default
			if("${req_data.GUBUN}" == ""){
				$("input:radio[name='GUBUN']:radio[value='1']").prop('checked', true); 
			}
			
			// 조회
			$("#search_btn").on("click", function() {
				if($("input:checkbox[name^='PRJ']:checked").length > 0){	//프로젝트 속성 한개라도 체크되었으면 그리드컬럼 변경
					scope.gridColChange("Y");
				}else{
					scope.gridColChange("");
				}
				
				$("input[name=excel_flag]").val("");

				var objParams = $("#frm").serializeArray();	//폼을 그리드 파라메터로 전송
				$("input:checkbox[name^='PRJ']").each(function(i,d){
					objParams.push({name:"PRJ"+parseInt(i+1), value:$("input[name=PRJ"+parseInt(i+1)+"]").is(":checked")?"1":""}); //체크가 되었다면 Y 아니면 N
				})
								
				scope.reloadGrid_custom(
					gPostArray(objParams)	
				);	
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
				
				xlsForm.target = "xlsx_download";
				xlsForm.name   = "sndFrm";
				xlsForm.method = "post";
				xlsForm.action = "/yp/xls/zfi/bud/zfi_bud_wbs_detail_read";

				document.body.appendChild(xlsForm);

				xlsForm.appendChild(csrf_element);

				var pr = gPostArray($("#frm").serializeArray());	//form parameters to array

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
	
	
		function fnSearchPopup(type){
			if(type=="1"){
				window.open("/yp/popup/zfi/bud/retrieveKOSTL2?type=ZM","집행부서","width=600,height=800,scrollbars=yes");
			}else if(type=="2"){
				window.open("/yp/popup/zfi/bud/retrievePOSID","WBS 검색","width=600,height=800,scrollbars=yes");	
			}
		}
	
		function fnDetailPopup(type,posid){
			var gubun = $("input[name=GUBUN]:checked").val();
			var budats = $("input[name=BUDAT_S]").val();
			var budate = $("input[name=BUDAT_E]").val();
			var grir = $("input:checkbox[name=GRIR]").is(":checked")?"1":"0";
			window.open("/yp/popup/zfi/bud/zfi_bud_wbs_detail_read_pop?GUBUN="+gubun+"&GUBUN2="+type+"&PSPID="+posid+"&BUDAT_S="+budats+"&BUDAT_E="+budate+"&GRIR="+grir,"상세보기","width=1000,height=800,scrollbars=yes");
		}
	
	</script>
	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
</body>