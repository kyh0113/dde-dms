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
//JSTL에서 사용할 수 있도록 세팅
request.setAttribute("to_yyyy", toDay);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>도급비 상세조회
</title>
<script type="text/javascript">
</script>
</head>
<body>
	<h2>
		도급비 상세조회
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
	<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
	<div id="shds-uiGrid" data-ng-controller="shdsCtrl">
	<form id="frm" name="frm">
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
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
						<th>검수년월</th>
						<td>
							<input type="text" id="BASE_YYYY" class="calendar dtp" value="${to_yyyy}"/>
						</td>
						<th>거래처</th>
						<td>
							<select id="VENDOR_CODE">
								<c:forEach var="row" items="${cb_working_master_v}" varStatus="status">
									<option value="${row.CODE}">${row.CODE_NAME}</option>
								</c:forEach>
							</select>
						</td>
						<th>
							<input id="storage_chk_box" name="storage_chk_box" type="checkbox" style="cursor:pointer;"/>
							<label for="storage_chk_box" style="cursor:pointer;">&nbsp;&nbsp;저장품</label>
						</th>
						<td>&nbsp;</td>
					</tr>
				</table>
				<div class="btn_wrap">
					<input type="button" class="btn btn_search" id="search_btn" value="조회"/>
				</div>
			</div>
		</section>
	</form>
	<div class="float_wrap">
		<div class="fl">
			&nbsp;
		</div>
		<div class="fr" style="margin-bottom:5px;">
			&nbsp;
		</div>
	</div>
	<section class="section">
			<div data-ui-i18n="ko" style="height: 620px;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
	</section>
	</div>
	<script>
	var scope;
	var columnDefs;
	//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
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
		$scope.deleteRow = vm.deleteRow;
		$scope.deleteRowOne = vm.deleteRowOne;
		$scope.searchCnt = vm.searchCnt;
		$scope.uiGridConstants = uiGridConstants;
		
		$scope.pagination = vm.pagination;
		
		// formater - 천단위 콤마
		$scope.formatter_decimal = function(str_date) {
			if (!isNaN(Number(str_date))) {
				return Number(str_date).toLocaleString()
			} else {
				return str_date;
			}
		};
		
		// 세션아이디코드 스코프에저장
		$scope.s_emp_code = "${s_emp_code}";
		
		columnDefs1 = [
			{
				displayName : '부서명',
				field : 'DEPT_NAME',
				visible : true,
				width : '150',
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			},{
				displayName : '계약명',
				field : 'CONTRACT_NAME',
				visible : true,
// 				width : '115',
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			},{
				displayName : '계약기준 월도급비',
				field : 'ADJUST_SUBCONTRACTING_COST',
				visible : true,
				width : '150',
				cellClass : "right",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents" >{{grid.appScope.formatter_decimal(row.entity.ADJUST_SUBCONTRACTING_COST)}}</div>',
				aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
				footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
			},{
				displayName : '도급비(실적)',
				field : 'SUB_TOTAL',
				visible : true,
				width : '150',
				cellClass : "right",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents" >{{grid.appScope.formatter_decimal(row.entity.SUB_TOTAL)}}</div>',
				aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
				footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
			},{
				displayName : '차액',
				field : 'DIFF',
				visible : true,
				width : '150',
				cellClass : "right",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents" >{{grid.appScope.formatter_decimal(row.entity.DIFF)}}</div>',
				aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
				footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
			},{
				displayName : '전월도급비',
				field : 'P_TOTAL',
				visible : true,
				width : '150',
				cellClass : "right",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents" >{{grid.appScope.formatter_decimal(row.entity.P_TOTAL)}}</div>',
				aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
				footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
			},{
				displayName : '증감',
				field : 'VARIATION',
				visible : true,
				width : '150',
				cellClass : "right",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents" >{{grid.appScope.formatter_decimal(row.entity.VARIATION)}}</div>',
				aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
				footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
			},{
				displayName : '물량',
				field : 'QUANTITY',
				visible : true,
				width : '150',
				cellClass : "right",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents" >{{grid.appScope.formatter_decimal(row.entity.QUANTITY)}}</div>',
				aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
				footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
			},{
				displayName : '전월물량',
				field : 'P_QUANTITY',
				visible : true,
				width : '150',
				cellClass : "right",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents" >{{grid.appScope.formatter_decimal(row.entity.P_QUANTITY)}}</div>',
				aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
				footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
			},{
				displayName : '물량증감',
				field : 'QUANTITY_VARIATION',
				visible : true,
				width : '150',
				cellClass : "right",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents" >{{grid.appScope.formatter_decimal(row.entity.QUANTITY_VARIATION)}}</div>',
				aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
				footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
			}, {
				displayName : '전자결재',
				field : 'STATUS',
				width : '95',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, {
				displayName : '전자결재',
				field : 'STATUS_TXT',
				width : '95',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents" style="background-color: {{grid.appScope.formatter_bg_color(row.entity.STATUS)}}">{{row.entity.STATUS_TXT}}&nbsp;</div>'
			}
		];
		
		$scope.formatter_bg_color = function(data) {
			var rgb;
			switch(data){
				case "0" :
					rgb = "#ff5e00";
					break;
				case "4" :
					rgb = "#ff5e00";
					break;
				case "5" :
					rgb = "#ff0000";
					break;
				case "7" :
					rgb = "#ff0000";
					break;
				case "F" :
					rgb = "#abf200";
					break;
				case "S" :
					rgb = "#abf200";
					break;
				default :
					rgb = "";
			}
			return rgb;
		};
		
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
			enablePagination : true,
			enablePaginationControls : true,
			columnDefs : columnDefs1,	//헤더 세팅
			onRegisterApi: function( gridApi ) {
				$scope.gridApi = gridApi;
			}
		});
		
		$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
		$scope.reloadGrid = vm.reloadGrid;
		//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  
		
	}]);
	$(document).ready(function() {
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
				cntQuery  : "yp_zwc_ipt.select_zwc_ipt_detail_list_dt_cnt",
				listQuery : "yp_zwc_ipt.select_zwc_ipt_detail_list_dt"
		};
		scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
		//복붙영역(앵귤러 이벤트들 가져오기) 끝
		
		// 부트스트랩 날짜객체
		$(document).on("focus", ".dtp", function() {
			$(this).datepicker({
				format : "yyyy/mm",
				language : "ko",
				viewMode: "months",
				minViewMode: "months",
				todayHighlight : true,
				autoclose : true,
				clearBtn : true,
				updateViewDate : false
			}).on('changeDate', function (e) {
				if(e.viewMode !== "months"){
					return false;
				}
				$(this).val(formatDate_m(e.date.valueOf())).trigger("change");
				$('.datepicker').hide();
			});
		});
		
		// 조회
		$("#search_btn").on("click", function() {
			var base_yyyymm, prev_yyyymm;
			base_yyyymm = $("#BASE_YYYY").val().trim().replace("/", "");
			var pre = $("#BASE_YYYY").val().trim().split("/");
			var pre_dt = new Date(pre[0], pre[1] - 1, 1);
			pre_dt.setMonth(pre_dt.getMonth() - 1);
			var pre_mm = (pre_dt.getMonth() + 1);
// 			prev_yyyymm = pre_dt.getFullYear() + "" + (pre_dt.getMonth() + 1);
			prev_yyyymm = pre_dt.getFullYear() + "" + ( ( "00" + new String(pre_mm).toString() ).slice( -2 ) );
// 			return false;
			scope.reloadGrid({
				BASE_YYYYMM : base_yyyymm,
				PREV_YYYYMM : prev_yyyymm,
				VENDOR_CODE : $("#VENDOR_CODE").val(),
				GUBUN_CODE : $("#storage_chk_box").is(":checked") ? "0" : "1"
			});
		});
	});
	function formatDate_m(date) {
		var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
		if (month.length < 2)
			month = '0' + month;
		if (day.length < 2)
			day = '0' + day;
		return [ year, month ].join('/');
	}
	</script>
</body>