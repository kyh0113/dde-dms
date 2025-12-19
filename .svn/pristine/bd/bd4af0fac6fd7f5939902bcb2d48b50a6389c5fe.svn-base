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
SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/dd");
String toDay = date.format(today);

//한달 
Calendar mon = Calendar.getInstance();
mon.add(Calendar.MONTH , -1);
String beforeMonthDay = date.format(mon.getTime());
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>계약 등록</title>
<script type="text/javascript">
	var gongsu_expense_scope;
	var work_labor_scope;
	var work_expense_scope;
	$(document).ready(function() {
		// 부트스트랩 날짜객체
		$(".dtp").datepicker({
			format : "yyyy/mm/dd",
			language : "ko",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		});
		
		//조회조건 default
		//오늘날짜 세팅
		if($("input[name=edate]").val() == ""){
			$("input[name=edate]").val("<%=toDay%>");	
		}
		//1달전 날짜 세팅
		if($("input[name=sdate]").val() == ""){
			$("input[name=sdate]").val("<%=beforeMonthDay%>");
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
		계약 등록
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
	
	<div class="wrap">
		<span>계약코드</span>
		<input type="text" disabled="disabled"  name="contract_code"/>
	</div>
	
	<form id="frm" name="frm">
	
		<div class="float_wrap">
			<div class="fl">
				<div class="stitle">
					계약기준
				</div>
			</div>
		</div>
		
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<section>
			<div class="tbl_box">
				<table class="contract_standard_table" cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="5%" />
						<col width="25%" />
						<col width="5%" />
						<col width="25%" />
						<col width="5%" />
						<col width="15%" />
						<col width="5%" />
						<col width="15%" />
					</colgroup>
					<tr>
						<th>지급기준</th>
						<td>
							<select name="PAY_STANDARD" >
								<c:forEach var="data" items="${pay_code_list}">
						        	<option value="${data.detail_code}" >${data.detail_name}</option>
						        </c:forEach>
							</select>
							<select name="pay_gubun_month" style="display:none;">
								<option value="1" selected>1개월</option>
								<option value="2" >2개월</option>
								<option value="3" >3개월</option>
								<option value="4" >4개월</option>
								<option value="5" >5개월</option>
								<option value="6" >6개월</option>
								<option value="7" >7개월</option>
								<option value="8" >8개월</option>
								<option value="9" >9개월</option>
								<option value="10" >10개월</option>
								<option value="11" >11개월</option>
								<option value="12" >12개월</option>
							</select>
						</td>
						<th>계약명</th>
						<td>
							<input type="text" name="CONTRACT_NAME" style="width: 100%;"/>
						</td>
						<th>계약기간</th>
						<td colspan="3">
							<input type="text" class="calendar dtp" name="sdate" id="sdate" size="10" value="${req_data.CONTRACT_START_DATE}"/>
							 ~ 
							<input type="text" class="calendar dtp" name="edate" id="edate" size="10" value="${req_data.CONTRACT_END_DATE}"/>
						</td>
					</tr>
					<tr>
						<th>WBS코드_1</th>
						<td>
							<input class="WBS_CODE" type="text" name="WBS_CODE1">
							<a href="#" onclick="fnSearchPopup('2',1);"><img src="/resources/yp/images/ic_search.png"></a>
							<input type="button" style="margin-left:10px;" class="btn_g" id="wbs_add_btn" value="추가">
							<input type="button" style="margin-left:10px;" class="btn_g" id="wbs_remove_btn" value="삭제">
						</td>
						<th>거래처</th>
						<td>
							<input type="text" name="SAP_CODE" size="10" readonly="readonly" style="background-color: #e5e5e5;"/>
							<input type="hidden" name="VENDOR_CODE" size="10"/>
							<a href="#" onclick="fnSearchPopup('1');"><img src="/resources/yp/images/ic_search.png"></a>
							<input type="text" name="VENDOR_NAME" disabled="disabled"  />
						</td>
						<th>
							계약 인원
						</th>
						<td>
							<input type="number" name="CONTRACT_PEOPLE_CNT" step="1"/>
						</td>
						<th>
							일일 필수 출근 인원
						</th>
						<td>
							<input type="number" name="DAILY_REQ_PEOPLE_CNT" step="1"/>
						</td>
					</tr>
				</table>
			</div>
		</section>
		
		<div class="float_wrap">
			<div class="fl">
				<div class="stitle">
					비용
				</div>
			</div>
		</div>
		<!-- 공수 -->
		<div class="float_wrap" style="margin-bottom: -25px;">
			<div class="fr">
				<div class="btn_wrap">
					<input type=button class="btn_g target_btn_save" id="gongsu_save" style="display:none;" value="저장"><!-- 공수저장 -->
				</div>
			</div>
		</div>
		<section class="gongsu_section">
			<!-- 탭 부분 -->
			<!-- 
			<ul class="tabs">
				<li class="tab-link labor_cost current">인건비</li>
				<li class="tab-link expense_other">경비/기타</li>
				<li class="save_class" style="border:none; float:right;"><input type=button class="btn_g" id="gongsu_save" value="저장"></li>
			</ul>
			-->
			<ul class="nav nav-tabs" style="display: flex !important;">
				<li class="nav-item">
					<a class="nav-link labor_cost active" data-toggle="tab" href="#gongsu_labor_cost_content">인건비</a>
				</li>
				<li class="nav-item">
					<a class="nav-link expense_other" data-toggle="tab" href="#gongsu_expense_other_content">경비/기타</a>
				</li>
			</ul>
			<div class="tab-content tbl_box">
				<!-- 인건비 -->
				<!-- <div class="tab-content-contract labor_cost_content current"> -->
				<div class="tab-pane show active labor_cost_content" id="gongsu_labor_cost_content">
					<table class="cost_table" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="5%" />
							<col width="25%" />
							<col width="5%" />
							<col width="25%" />
							<col width="5%" />
							<col width="25%" />
						</colgroup>
						<tr>
							<th>1工</th>
							<td>
								<input type="text" name="EMPLOYMENT_COSTS"/><span>&nbsp;&nbsp;￦</span>
							</td>
							<th></th><td></td>
							<th></th><td></td>
						</tr>
						<tr>
							<th>근무시간</th>
							<td>
								<input type="text" name="WORK_START_TIME" numberOnly size="10" />
								 ~ 
								<input type="text" name="WORK_END_TIME" numberOnly size="10" />
							</td>
							<th></th><td></td>
							<th></th><td></td>
						</tr>
					</table>
				</div>
				<!-- 경비/기타 -->
				<!-- <div class="tab-content-contract expense_other_content"> -->
				<div class="tab-pane expense_other_content" id="gongsu_expense_other_content">
					<div class="float_wrap">
						<div class="fr">
							<div class="btn_wrap" style="margin-bottom:5px;">
								<input type="button" class="btn_g add" value="추가"/>
								<input type="button" class="btn_g remove" value="삭제"/>
							</div>
						</div>
					</div>
					<section class="section">
						<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
						<div id="gongsu-expense-uiGrid" data-ng-controller="gongsu-expense-ctrl">
							<div data-ui-i18n="ko" style="height: 620px;">
								<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
									<div data-ng-if="loader" class="loader"></div>
									<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
								</div>
							</div>
						</div>
						<!-- 복붙영역(html) 끝 -->
					</section>
				</div>
			</div>
		</section>
		
		<!-- 작업 -->
		<div class="float_wrap" style="margin-bottom: -25px;">
			<div class="fr">
				<div class="btn_wrap">
					<input type=button class="btn_g target_btn_save" style="display:none;" id="work_save" value="저장"><!-- 작업저장 -->
				</div>
			</div>
		</div>
		<section class="work_section" style="display:none;">
			<!-- 탭 부분 -->
			<!-- 
			<ul class="tabs">
				<li class="tab-link labor_cost current">인건비</li>
				<li class="tab-link expense_other">경비/기타</li>
				<li class="save_class" style="border:none; float:right;"><input type=button class="btn_g" id="work_save" value="저장"></li>
			</ul>
			-->
			<ul class="nav nav-tabs" style="display: flex !important;">
				<li class="nav-item">
					<a class="nav-link labor_cost active" data-toggle="tab" href="#work_labor_cost_content">인건비</a>
				</li>
				<li class="nav-item">
					<a class="nav-link expense_other" data-toggle="tab" href="#work_expense_other_content">경비/기타</a>
				</li>
			</ul>
			<div class="tab-content tbl_box">
				<!-- 인건비 -->
				<!-- <div class="tab-content-contract labor_cost_content"> -->
				<div class="tab-pane show active labor_cost_content" id="work_labor_cost_content">
					<div class="float_wrap">
						<div class="fr">
							<div class="btn_wrap" style="margin-bottom:5px;">
								<input type="button" class="btn_g add" value="추가"/>
								<input type="button" class="btn_g remove" value="삭제"/>
							</div>
						</div>
					</div>
					<section class="section">
						<!-- 작업 인건비 Grid -->
						<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
						<div id="work-labor-uiGrid" data-ng-controller="work-labor-ctrl">
							<div data-ui-i18n="ko" style="height: 620px;">
								<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
									<div data-ng-if="loader" class="loader"></div>
									<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
								</div>
							</div>
						</div>
						<!-- 복붙영역(html) 끝 -->
					</section>
				</div>
				<!-- 경비/기타 -->
				<!-- <div class="tab-content-contract expense_other_content"> -->
				<div class="tab-pane expense_other_content" id="work_expense_other_content">
					<div class="float_wrap">
						<div class="fr">
							<div class="btn_wrap" style="margin-bottom:5px;">
								<input type="button" class="btn_g add" value="추가"/>
								<input type="button" class="btn_g remove" value="삭제"/>
							</div>
						</div>
					</div>
					<section class="section">
						<!-- 작업 경비/기타 Grid -->
						<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
						<div id="work-expense-uiGrid" data-ng-controller="work-expense-ctrl">
							<div data-ui-i18n="ko" style="height: 620px;">
								<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
									<div data-ng-if="loader" class="loader"></div>
									<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
								</div>
							</div>
						</div>
						<!-- 복붙영역(html) 끝 -->
					</section>
				</div>
			</div>
		</section>
		
		<!-- 월정액 -->
		<div class="float_wrap" style="margin-bottom: -25px;">
			<div class="fr">
				<div class="btn_wrap">
					<input type=button class="btn_g target_btn_save" style="display:none;" id="monthly_save" value="저장"><!-- 월정액저장 -->
				</div>
			</div>
		</div>
		<section class="monthly_section" style="display:none;">
			<!-- 탭 부분 -->
			<!-- 
			<ul class="tabs">
				<li class="tab-link labor_cost current">인건비</li>
				<li class="save_class" style="border:none; float:right;"><input type=button class="btn_g" id="monthly_save" value="저장"></li>
			</ul>
			-->
			<ul class="nav nav-tabs" style="display: flex !important;">
				<li class="nav-item">
					<a class="nav-link labor_cost active" data-toggle="tab" href="#monthly_labor_cost_content">인건비</a>
				</li>
			</ul>
			<div class="tab-content tbl_box">
				<!-- 인건비 -->
				<!-- <div class="tab-content-contract-contract labor_cost_content current"> -->
				<div class="tab-pane show active labor_cost_content" id="monthly_labor_cost_content">
					<table class="cost_table" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="5%" />
							<col width="25%" />
							<col width="5%" />
							<col width="25%" />
							<col width="5%" />
							<col width="25%" />
						</colgroup>
						<tr>
							<th>1년</th>
							<td>
								<input class="right" type="text" name="EMPLOYMENT_COSTS_YEAR"/><span>&nbsp;&nbsp;￦</span>
							</td>
							<th></th><td></td>
							<th></th><td></td>
						</tr>
						<tr>
							<th class="monthly">1개월</th>
							<td>
								<input class="right" type="text" name="EMPLOYMENT_COSTS_MONTH" disabled/><span>&nbsp;&nbsp;￦</span>
							</td>
							<th></th><td></td>
							<th></th><td></td>
						</tr>
					</table>
				</div>
			</div>
		</section>
	</form>
	
<!----------------------------------------------------------- 공통 & 공수(경비/기타)Grid ----------------------------------------------------->
<script>
	//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
	app.controller('gongsu-expense-ctrl', [ '$scope', '$window', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $window, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
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

		
		//cellClass
		$scope.cellClassSet = function(grid, row, col, rowRenderIndex, colRenderIndex){
			var className = "";
			switch(col.field){
				
			}

			return className;
		}
		
		var columnDefs1 = [
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
				displayName : '순번',
				field : 'SEQ',
				width : '100',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, 
			{
				displayName : '순번',
				field : 'RN',
				width : '100',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, 
			{
				displayName : '내용',
				field : 'CONTENTS',
				minWidth : '400',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><input on-clipboard-pasted class="absolute_center width_90_percent" type="text" ng-model="row.entity.CONTENTS"/></div>'
			}, 
			{
				displayName : '검수 보고서 표시 단위',
				field : 'MARK_UNIT',
				width : '160',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><input on-clipboard-pasted class="absolute_center width_90_percent" type="text" ng-model="row.entity.MARK_UNIT"/></div>'
			}, 
			{
				displayName : '비율/금액',
				field : 'RATE_AMOUNT',
				width : '150',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><input on-clipboard-pasted class="absolute_center width_90_percent" type="text" ng-model="row.entity.RATE_AMOUNT" on-model-change="grid.appScope.gridAddComma(row)"/></div>'
			}, 
			{
				displayName : '단위',
				field : 'UNIT',
				width : '100',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				//cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><input on-clipboard-pasted class="absolute_center width_90_percent" type="text" ng-model="row.entity.UNIT"/></div>'
				cellTemplate : '<select class="ui-grid-template ui-grid-custom-select" style="width:100%; min-width: fit-content;" ng-model="row.entity.UNIT" on-model-change="grid.appScope.gridRemoveComma(row)">' + '	<option ng-repeat="SB_UNIT in grid.appScope.SB_UNIT" ng-selected="row.entity.UNIT == SB_UNIT.code_id" value="{{SB_UNIT.code_id}}" >{{SB_UNIT.code_name}}</option>' + '</select>'
			}
		  ];
		$scope.SB_UNIT = [{
			"code_name" : "선택",
			"code_id" : ""
		}, {
			"code_name" : "％",
			"code_id" : "%"
		}, {
			"code_name" : "￦",
			"code_id" : "\\"
		} ];
		
		// 천단위 찍어주기
		$scope.gridAddComma = function(row) {
			if(row.entity.RATE_AMOUNT !== null && row.entity.UNIT === "\\"){
				var d = row.entity.RATE_AMOUNT.toString().replace(/[^0-9]/g, '');
				var num = unComma(d);
				num = num * 1;
				row.entity.RATE_AMOUNT = addComma(num);
			}
			gongsu_expense_scope.gridApi.grid.refresh();
		};
		
		// 단위변경
		$scope.gridRemoveComma = function(row) {
			if(row.entity.UNIT === "\\"){
				var d = row.entity.RATE_AMOUNT.toString().replace(/[^0-9]/g, '');
				var num = unComma(d);
				num = num * 1;
				row.entity.RATE_AMOUNT = addComma(num);
			}else{
				var d = row.entity.RATE_AMOUNT.toString().replace(/[,]/g, '');
				row.entity.RATE_AMOUNT = d;
			}
			gongsu_expense_scope.gridApi.grid.refresh();
		};
		
		$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
		{
			enableGridMenu: true,	 //필터버튼
			enableFiltering : false, //각 컬럼에 검색바
			showColumnFooter : false,
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
		gongsu_expense_scope = angular.element(document.getElementById("gongsu-expense-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
		work_labor_scope = angular.element(document.getElementById("work-labor-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
		work_expense_scope = angular.element(document.getElementById("work-expense-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
		
		gongsu_expense_scope.gridApi.core.on.rowsRendered(gongsu_expense_scope, function() {	//그리드 렌더링 후 이벤트
			
		});
		gongsu_expense_scope.gridApi.selection.on.rowSelectionChanged(gongsu_expense_scope, function(row) { //로우 선택할때마다 이벤트
			//console.log("row2", row.entity);
		});
		gongsu_expense_scope.gridApi.selection.on.rowSelectionChangedBatch(gongsu_expense_scope, function(rows) { //전체선택시 가져옴
			//console.log("row3", rows[0].entity); //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
		});
		// pagenation option setting  그리드를 부르기 전에 반드시 선언
		// 테이블 조회는 
		// EXEC_RFC : "FI"
		var param = {
				EXEC_RFC  : "N", // RFC 여부
				cntQuery  : "yp_zcs_ctr.select_construction_subc_cost_cnt", 	
				listQuery : "yp_zcs_ctr.select_construction_subc_cost"
		};
		gongsu_expense_scope.paginationOptions = customExtend(gongsu_expense_scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
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
		
		//WBS코드 추가
		$("#wbs_add_btn").on("click", function() {
			var wbs_count = $(".WBS_CODE").length;
			if(wbs_count == 6){
				swalWarningCB("WBS코드는 6개가 최대입니다.");
				return;
			}
			wbs_count++;
			
			var innerHtml = "";
			innerHtml += "<tr>";
			innerHtml += "	<th>WBS코드_"+wbs_count+"</th>";
			innerHtml += "	<td>";
			innerHtml += "		<input class='WBS_CODE' type='text' name='WBS_CODE"+wbs_count+"'>";
			innerHtml += "		<a href='#' onclick='fnSearchPopup(2,"+wbs_count+");'><img src='/resources/yp/images/ic_search.png'></a>";
			innerHtml += "	</td>";
			innerHtml += "</tr>";
			
			$(".contract_standard_table").append(innerHtml);
		});
		
		//WBS코드 삭제
		$("#wbs_remove_btn").on("click", function() {
			var wbs_count = $(".WBS_CODE").length;
			if(wbs_count == 1){
				swalWarningCB("WBS코드는 1개가 최소입니다.");
				return;
			}
			$(".WBS_CODE:last").parent().parent().remove();
		});
		
		//숫자만 입력 가능
		$("input:text[numberOnly]").on("keyup", function() {
		    $(this).val($(this).val().replace(/[^0-9]/g,""));
		});
		
		//시작 근무시간
		$("input[name=WORK_START_TIME]").on("blur", function() {
			var data = $("input[name=WORK_START_TIME]").val();
			
			if(data.length == 0){
				return;
			}
			
			if(data.indexOf(":") == 2 && data.length == 5){
				return;
			}
			
			
			//숫자만 입력가능
			if(isNaN(data)){
				swalWarningCB("시작시간에는 숫자만 입력가능합니다.");
				$("input[name=WORK_START_TIME]").val('');
				return;
			}
			
			if(data.length != 4){
				swalWarningCB("시작시간은 4글자 입력해야합니다.");
				$("input[name=WORK_START_TIME]").val('');
				return;
			}
			
			//숫자 사이에 ':' 문자 넣어주기
			var splitData = data.split("");
			var temp1 = splitData[2];
			var temp2 = splitData[3];
			splitData[2] = ":";
			splitData[3] = temp1;
			splitData[4] = temp2;
			splitData = splitData.join('');
			$("input[name=WORK_START_TIME]").val(splitData);
		});
		
		//종료 근무시간
		$("input[name=WORK_END_TIME]").on("blur", function() {
			var data = $("input[name=WORK_END_TIME]").val();
			
			if(data.indexOf(":") == 2 && data.length == 5){
				return;
			}
			
			if(data.length == 0){
				return;
			}
			
			//숫자만 입력가능
			if(isNaN(data)){
				swalWarningCB("종료시간에는 숫자만 입력가능합니다.");
				$("input[name=WORK_END_TIME]").val('');
				return;
			}
			
			if(data.length != 4){
				swalWarningCB("종료시간은 4글자 입력해야합니다.");
				$("input[name=WORK_END_TIME]").val('');
				return;
			}
			
			//숫자 사이에 ':' 문자 넣어주기
			var splitData = data.split("");
			var temp1 = splitData[2];
			var temp2 = splitData[3];
			splitData[2] = ":";
			splitData[3] = temp1;
			splitData[4] = temp2;
			splitData = splitData.join('');
			$("input[name=WORK_END_TIME]").val(splitData);
		});
		
		/* 공수 인건비 탭 클릭 */
		$(".gongsu_section .labor_cost").on("click", function() {
			console.log('공수 인건비 탭클릭');
			/* 탭 표시 */
			$('.gongsu_section ul.tabs li').removeClass('current');
			$(this).addClass('current');
			
			/* 테이블 표시 */
			$('.gongsu_section .tab-content-contract').removeClass('current');
			$('.gongsu_section .labor_cost_content').addClass('current');
			
			//저장버튼 비활성화
			$(".target_btn_save").hide();
// 			$("#gongsu_save").hide();
			
			/* 2020-11-11 jamerl - 탭 이동시 체크박스 영역 일부가 숨겨지는 현상 수정
			체크박스 영역이 숨겨져서 클릭할 수 없는 상황이 발생됨. $(".ui-grid-viewport") 스타일이 height: 0px이 적용되는 경우가 발생
			모든 $(".ui-grid-viewport")의 스타일 heigh를 제거함 
			*/
			$(".ui-grid-viewport").each(function(v,k){
				$(k).css("height", "");
			});
		});
			
		/* 공수 비용/기타 탭 클릭 */
		$(".gongsu_section .expense_other").on("click", function() {
			$('.gongsu_section ul.tabs li').removeClass('current');
// 			$(this).addClass('current');
			
			/* 테이블 표시 */
			$('.gongsu_section .tab-content-contract').removeClass('current');
// 			$('.gongsu_section .expense_other_content').addClass('current');
			
			//저장버튼 활성화
			$("#gongsu_save").show();
			
			/* 2020-11-11 jamerl - 탭 이동시 체크박스 영역 일부가 숨겨지는 현상 수정
			체크박스 영역이 숨겨져서 클릭할 수 없는 상황이 발생됨. $(".ui-grid-viewport") 스타일이 height: 0px이 적용되는 경우가 발생
			모든 $(".ui-grid-viewport")의 스타일 heigh를 제거함 
			*/
			$(".ui-grid-viewport").each(function(v,k){
				$(k).css("height", "");
			});
		});
		
		/* 공수 한줄 추가 */
		$(".gongsu_section .add").on("click", function() {
			var seq = gongsu_expense_scope.gridOptions.data.length+1;
			var data = {};
			gongsu_expense_scope.addRow(data, true, "asc");
			gongsu_expense_scope.gridApi.grid.refresh();
		});
		
		/* 공수 한줄 삭제 */
		$(".gongsu_section .remove").on("click", function() {
			var selectedRows = gongsu_expense_scope.gridApi.selection.getSelectedRows();
			if(selectedRows.length === 0){
				swalWarningCB("삭제할 항목을 선택하세요.");
				return false;
			}
			
			var length = selectedRows.length;
			//계약코드가 없을 시
			if(isEmpty(selectedRows[length-1].CONTRACT_CODE)){
				console.log(selectedRows);
				$.each(selectedRows, function(i, d) {
					// 선택된 데이터 삭제
					gongsu_expense_scope.gridOptions.data.splice(gongsu_expense_scope.gridOptions.data.indexOf(d), 1);
				});
// 				gongsu_expense_scope.gridOptions.data.pop(selectedRows);
				gongsu_expense_scope.gridApi.grid.refresh();
			//계약코드가 존재할 시 
			}else{
				if (confirm("삭제하겠습니까?")) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					
					var data = $("#frm").serializeArray();
					data.push({name: "gridData", value: JSON.stringify(selectedRows)});
					
					$.ajax({
						url : "/yp/zcs/ctr/zcs_ctr_manh_delete",
						type : "POST",
						cache : false,
						async : true,
						dataType : "json",
						data : data,
						success : function(result) {
							//swalSuccessCB(result.result+"건이 삭제 완료됐습니다.");
							swalSuccessCB("삭제 완료됐습니다.");
							//Grid리로드
							gongsu_expense_scope.reloadGrid({
								CONTRACT_CODE : $("input[name=contract_code]").val()
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
							swalDangerCB("삭제에 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
				}
			}
		});
		
		/* 공수 저장 클릭 */
		$("#gongsu_save").on("click", function() {
			// 2020-12-01 jamerl - 최승빈 : 결재 진행중 혹은 완료된 계약은 변경불가
			if($("input[name=contract_code]").val() !== ""){
				if(!select_chk_enable_proc(null, null, null, $("input[name=contract_code]").val(), null)){
					return false;
				}
			}
			//공통 빈값 체크
			if(commonValidation()){
				return;
			}
			
			// 계약 인원
			if( isNaN( $("input[name=CONTRACT_PEOPLE_CNT]").val() ) ){
				$("input[name=CONTRACT_PEOPLE_CNT]").val("0");
			}
			// 일일 필수 출근 인원
			if( isNaN( $("input[name=DAILY_REQ_PEOPLE_CNT]").val() ) ){
				$("input[name=DAILY_REQ_PEOPLE_CNT]").val("0");
			}
			
			//1工 빈값 체크
			var EMPLOYMENT_COSTS = $("input[name=EMPLOYMENT_COSTS]").val();
			if(isEmpty(EMPLOYMENT_COSTS)){
				swalWarningCB("인건비 1工을 입력해주세요.");
				return;
			}
			
			//시작 근무시간 빈값 체크
			var WORK_START_TIME = $("input[name=WORK_START_TIME]").val();
			if(isEmpty(WORK_START_TIME)){
				swalWarningCB("시작 근무시간을 입력해주세요.");
				return;
			}
			
			//종료 근무시간 빈값 체크
			var WORK_END_TIME = $("input[name=WORK_END_TIME]").val();
			if(isEmpty(WORK_END_TIME)){
				swalWarningCB("종료 근무시간을 입력해주세요.");
				return;
			}
			
			//(경비/기타) 빈값 체크
			var gridDatas = gongsu_expense_scope.gridOptions.data;
			for(var i=0; i<gridDatas.length; i++){
				if(isEmpty(gridDatas[i].CONTENTS)){
					swalWarningCB("경비/기타 "+(i+1)+"번째 행 \r\n 내용을 입력해주세요.");
					return;
				}
				if(isEmpty(gridDatas[i].MARK_UNIT)){
					swalWarningCB("경비/기타 "+(i+1)+"번째 행 \r\n 검수 보고서 표시 단위을 입력해주세요.");
					return;			
				}
				if(isEmpty(gridDatas[i].RATE_AMOUNT)){
					swalWarningCB("경비/기타 "+(i+1)+"번째 행 \r\n 비율/금액을 입력해주세요.");
					return;
				}
				if(isEmpty(gridDatas[i].UNIT)){
					swalWarningCB("경비/기타 "+(i+1)+"번째 행 \r\n 단위를 입력해주세요.");
					return;
				}
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
					  var selectedRows = gongsu_expense_scope.gridApi.selection.getSelectedRows();	//그리드 선택된 rows data
						//form데이터 + 그리드데이터 json으로 변환 및 추가해서 서버로 전송
						var data = $("#frm").serializeArray();
						var yyyy = '<%=toDay%>'.split("/")[0];
						
						//시작&끝 날짜 '/'문자 없애기
						var CONTRACT_START_DATE = $("#sdate").val().replace("/","").replace("/","");
						var CONTRACT_END_DATE = $("#edate").val().replace("/","").replace("/","");
						//계약코드 - 처음엔 없기 때문에 서버에서 계약코드 생성. INSERT쿼리 실행
						//      - 다시 저장버튼을 클릭할 경우, 계약코드 값이 존재한다. 그렇다면, UPDATE쿼리를 실행
						var CONTRACT_CODE = $("input[name=contract_code]").val();
						
						//EMPLOYMENT_COSTS 콤마 없앤 값으로  교체
						var EMPLOYMENT_COSTS = unComma($("input[name=EMPLOYMENT_COSTS]").val());
						for(var i=0; i<data.length; i++){
							if(data[i].name == 'EMPLOYMENT_COSTS'){
								data.splice(i, 1);
							}
						}
						data.push({name: "EMPLOYMENT_COSTS", value: EMPLOYMENT_COSTS});
						
						
						data.push({name: "gridData", value: JSON.stringify(selectedRows)});
						data.push({name: "YYYY", value: yyyy});
						data.push({name: "CONTRACT_START_DATE", value: CONTRACT_START_DATE});
						data.push({name: "CONTRACT_END_DATE", value: CONTRACT_END_DATE});
						data.push({name: "CONTRACT_CODE", value: CONTRACT_CODE});
						
						$.ajax({
							url : "/yp/zcs/ctr/zcs_ctr_manh_save",
							type : "post",
							cache : false,
							async : false,//동기화
							data : data,
							dataType : "json",
							success : function(result) {
								swalSuccessCB("데이터가 저장됐습니다.");
								//계약코드 값 넣어주기
								$("input[name=contract_code]").val(result.CONTRACT_CODE);
								//Grid리로드
								gongsu_expense_scope.reloadGrid({
									CONTRACT_CODE : result.CONTRACT_CODE
								});
							}
						});
				  }
			});   
			
		});
		
		//지급기준 변경
		$("select[name=PAY_STANDARD]").on("change", function() {
			var PAY_STANDARD = $("select[name=PAY_STANDARD]").val();
			//계약기준 초기화
			init();
			
			// 저장버튼 숨김
			$(".target_btn_save").hide();
			
			//비용 section 모두 display none
			$(".gongsu_section").hide();
			$(".work_section").hide();
			$(".monthly_section").hide();
			
			//지급기준:1  (공수)
			if(PAY_STANDARD == 1){
				$(".gongsu_section").show();
				$(".gongsu_section .labor_cost").trigger("click");
				// 계약 인원 디피 판단
				$("input[name=CONTRACT_PEOPLE_CNT]").show().val("0").prop("disabled", false).parent().prev().text("계약 인원");
				$("input[name=DAILY_REQ_PEOPLE_CNT]").show().val("0").prop("disabled", false).parent().prev().text("일일 필수 출근 인원");
			//지급기준:2 (작업)
			}else if(PAY_STANDARD == 2){
				$(".work_section").show();
				$(".work_section .labor_cost").trigger("click");
				// 계약 인원 디피 판단
				$("input[name=CONTRACT_PEOPLE_CNT]").hide().val("").prop("disabled", true).parent().prev().text("");
				$("input[name=DAILY_REQ_PEOPLE_CNT]").hide().val("").prop("disabled", true).parent().prev().text("");
			//지급기준:3 (월정액)
			}else if(PAY_STANDARD == 3){
				$(".monthly_section").show();
				$("select[name=pay_gubun_month]").show();
				$(".monthly_section").show();
				$(".monthly_section .labor_cost").trigger("click");
				$("#monthly_save").show();
				// 계약 인원 디피 판단
				$("input[name=CONTRACT_PEOPLE_CNT]").hide().val("").prop("disabled", true).parent().prev().text("");
				$("input[name=DAILY_REQ_PEOPLE_CNT]").hide().val("").prop("disabled", true).parent().prev().text("");
			}
			
		});
		
		//인건비(1工) 콤마추가
		$("input[name=EMPLOYMENT_COSTS]").on("blur", function() {
			$(this).val(addComma($(this).val()));
		});
		
	});
	
	/* 팝업 */
	function fnSearchPopup(type, num) {
		if (type == "1") {
			window.open("/yp/popup/zcs/ctr/select_working_master_v", "업체 검색", "width=600, height=800");
		}else if(type == "2"){
			window.open("","WBS 검색","width=600,height=800,scrollbars=yes");
			fnHrefPopup("/yp/popup/zcs/ctr/retrievePOSID", "WBS 검색", {
				num : num
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
	
	//계약기준 초기화
	function init(){
		//계약기간 초기화
		$("input[name=edate]").val("<%=toDay%>");	
		$("input[name=sdate]").val("<%=beforeMonthDay%>");
		//계약명 초기화
		$("input[name=CONTRACT_NAME]").val('');
		//WBS코드 초기화		
		var wbs_count = $(".WBS_CODE").length;
		$("input[name=WBS_CODE1]").val('');
		for(var i=1; i<wbs_count; i++){
			$("input[name=WBS_CODE"+(i+1)+"]").parent().parent('tr').remove();
		}
		//거래처 초기화
		$("input[name=VENDOR_CODE]").val('');
		$("input[name=VENDOR_NAME]").val('');
		//계약코드 초기화
		$("input[name=contract_code]").val('');
		//그리드 데이터 초기화
		gongsu_expense_scope.gridOptions.data.length = 0;
		work_labor_scope.gridOptions.data.length = 0;
		work_expense_scope.gridOptions.data.length = 0;
		
		gongsu_expense_scope.gridApi.grid.refresh();
		work_labor_scope.gridApi.grid.refresh();
		work_expense_scope.gridApi.grid.refresh();
		//지급기준 월 숨기기
		$("select[name=pay_gubun_month]").hide();
		
		//공수(인건비) 초기화
		$("input[name=EMPLOYMENT_COSTS]").val('');
		$("input[name=WORK_START_TIME]").val('');
		$("input[name=WORK_END_TIME]").val('');
		
		//월정액(인건비) 초기화
		$("input[name=EMPLOYMENT_COSTS_YEAR]").val('');
		$("input[name=EMPLOYMENT_COSTS_MONTH]").val('');
		
	}
	
	/*콤마 추가*/
	function addComma(num) {
		return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}

	/*콤마 제거*/
	function unComma(num) {
		return num.replace(/,/gi, '');
	}
	
	function commonValidation(){
		var VENDOR_CODE = $("input[name=VENDOR_CODE]").val();
		var CONTRACT_NAME = $("input[name=CONTRACT_NAME]").val();
		//거래처 빈값 체크
		if(isEmpty(VENDOR_CODE)){
			swalWarningCB("거래처를 입력해주세요.");
			return true;
		}
		
		//계약명 빈값 체크
		if(isEmpty(CONTRACT_NAME)){
			swalWarningCB("계약명을 입력해주세요.");
			return true;
		}
	}
</script>

<!------------------------------------------------------ 작업(인건비)Grid ------------------------------------------------------------------>
<script>
	//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
	app.controller('work-labor-ctrl', [ '$scope', '$window', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $window, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
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

		
		//cellClass
		$scope.cellClassSet = function(grid, row, col, rowRenderIndex, colRenderIndex){
			var className = "";
			switch(col.field){
				
			}

			return className;
		}

		
		var columnDefs1 = [
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
				displayName : '순번',
				field : 'SEQ',
				width : '100',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, 
			{
				displayName : '순번',
				field : 'RN',
				width : '100',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, 
			{
				displayName : '작업',
				field : 'CONTENTS',
				minWidth : '400',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><input on-clipboard-pasted class="absolute_center width_90_percent" type="text" ng-model="row.entity.CONTENTS"/></div>'
			}, 
			{
				displayName : '검수 보고서 표시 단위',
				field : 'MARK_UNIT',
				width : '160',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><input on-clipboard-pasted class="absolute_center width_90_percent" type="text" ng-model="row.entity.MARK_UNIT"/></div>'
			}, 
			{
				displayName : '금액',
				field : 'AMOUNT',
				width : '150',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><input on-clipboard-pasted class="absolute_center width_90_percent" type="text" ng-model="row.entity.AMOUNT" on-model-change="grid.appScope.gridAddComma(row)"/></div>'
			}, 
			{
				displayName : '단위',
				field : 'UNIT',
				width : '100',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				//cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><input on-clipboard-pasted class="absolute_center width_90_percent" type="text" ng-model="row.entity.UNIT"/></div>'
				cellTemplate : '<select class="ui-grid-template ui-grid-custom-select" style="width:100%; min-width: fit-content;" ng-model="row.entity.UNIT" on-model-change="grid.appScope.gridRemoveComma(row)">' + '	<option ng-repeat="SB_UNIT in grid.appScope.SB_UNIT" ng-selected="row.entity.UNIT == SB_UNIT.code_id" value="{{SB_UNIT.code_id}}" >{{SB_UNIT.code_name}}</option>' + '</select>'
			}
		  ];
		$scope.SB_UNIT = [{
			"code_name" : "선택",
			"code_id" : ""
		}, {	"code_name" : "％",
			"code_id" : "%"
		}, {
			"code_name" : "￦",
			"code_id" : "\\"
		} ];
		
		// 천단위 찍어주기
		$scope.gridAddComma = function(row) {
			if(row.entity.AMOUNT !== null && row.entity.UNIT === "\\"){
				var d = row.entity.AMOUNT.toString().replace(/[^0-9]/g, '');
				var num = unComma(d);
				num = num * 1;
				row.entity.AMOUNT = addComma(num);
			}
			work_labor_scope.gridApi.grid.refresh();
		};
		
		// 단위변경
		$scope.gridRemoveComma = function(row) {
			if(row.entity.UNIT === "\\"){
				var d = row.entity.AMOUNT.toString().replace(/[^0-9]/g, '');
				var num = unComma(d);
				num = num * 1;
				row.entity.AMOUNT = addComma(num);
			}else{
				var d = row.entity.AMOUNT.toString().replace(/[,]/g, '');
				row.entity.AMOUNT = d;
			}
			work_labor_scope.gridApi.grid.refresh();
		};
		
		$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
		{
			enableGridMenu: true,	 //필터버튼
			enableFiltering : false, //각 컬럼에 검색바
			showColumnFooter : false,
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
		//var scope = angular.element(document.getElementById("work-labor-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
		
		work_labor_scope.gridApi.core.on.rowsRendered(work_labor_scope, function() {	//그리드 렌더링 후 이벤트
			
		});
		work_labor_scope.gridApi.selection.on.rowSelectionChanged(work_labor_scope, function(row) { //로우 선택할때마다 이벤트
			//console.log("row2", row.entity);
		});
		work_labor_scope.gridApi.selection.on.rowSelectionChangedBatch(work_labor_scope, function(rows) { //전체선택시 가져옴
			//console.log("row3", rows[0].entity); //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
		});
		// pagenation option setting  그리드를 부르기 전에 반드시 선언
		// 테이블 조회는 
		// EXEC_RFC : "FI"
		var param = {
				EXEC_RFC  : "N", // RFC 여부
				cntQuery  : "yp_zcs_ctr.select_construction_subc_emp_cost_cnt", 	
				listQuery : "yp_zcs_ctr.select_construction_subc_emp_cost"
		};
		work_labor_scope.paginationOptions = customExtend(work_labor_scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
		//복붙영역(앵귤러 이벤트들 가져오기) 끝
		
		/* 작업(인건비) 탭 클릭 */
		$(".work_section .labor_cost").on("click", function() {
			/* 탭 표시 */
			$('.work_section ul.tabs li').removeClass('current');
			$(this).addClass('current');
			
			/* 테이블 표시 */
			$('.work_section .tab-content-contract').removeClass('current');
			$('.work_section .labor_cost_content').addClass('current');
			
			//저장버튼 비활성화
			$(".target_btn_save").hide();
// 			$("#work_save").hide();
			
			/* 2020-11-11 jamerl - 탭 이동시 체크박스 영역 일부가 숨겨지는 현상 수정
				체크박스 영역이 숨겨져서 클릭할 수 없는 상황이 발생됨. $(".ui-grid-viewport") 스타일이 height: 0px이 적용되는 경우가 발생
				모든 $(".ui-grid-viewport")의 스타일 heigh를 제거함 
			*/
			$(".ui-grid-viewport").each(function(v,k){
				$(k).css("height", "");
			});
		});
			
		/* 작업(비용/기타) 탭 클릭 */
		$(".work_section .expense_other").on("click", function() {
			$('.work_section ul.tabs li').removeClass('current');
			$(this).addClass('current');
			
			/* 테이블 표시 */
			$('.work_section .tab-content-contract').removeClass('current');
			$('.work_section .expense_other_content').addClass('current');
			
			//저장버튼 활성화
			$("#work_save").show();
			
			/* 2020-11-11 jamerl - 탭 이동시 체크박스 영역 일부가 숨겨지는 현상 수정
			체크박스 영역이 숨겨져서 클릭할 수 없는 상황이 발생됨. $(".ui-grid-viewport") 스타일이 height: 0px이 적용되는 경우가 발생
			모든 $(".ui-grid-viewport")의 스타일 heigh를 제거함 
			*/
			$(".ui-grid-viewport").each(function(v,k){
				$(k).css("height", "");
			});
		});
		
		/* 작업(인건비) 한줄 추가 */
		$(".work_section .labor_cost_content .add").on("click", function() {
			console.log('[TEST]공수 1줄 추가');
			var seq = work_labor_scope.gridOptions.data.length+1;
			var data = {};
			work_labor_scope.addRow(data,true,"asc");
			work_labor_scope.gridApi.grid.refresh();
		});
		
		/* 작업 인건비 한줄 삭제 */
		$(".work_section .labor_cost_content .remove").on("click", function() {
			var selectedRows = work_labor_scope.gridApi.selection.getSelectedRows();
			if(selectedRows.length === 0){
				swalWarningCB("삭제할 항목을 선택하세요.");
				return false;
			}
			
			var length = selectedRows.length;
			//계약코드가 없을 시
			if(isEmpty(selectedRows[length-1].CONTRACT_CODE)){
				console.log(selectedRows);
				$.each(selectedRows, function(i, d) {
					// 선택된 데이터 삭제
					work_labor_scope.gridOptions.data.splice(work_labor_scope.gridOptions.data.indexOf(d), 1);
				});
// 				work_labor_scope.gridOptions.data.pop(selectedRows);
				work_labor_scope.gridApi.grid.refresh();
			//계약코드가 존재할 시 
			}else{
				if (confirm("삭제하겠습니까?")) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					
					var data = $("#frm").serializeArray();
					data.push({name: "laborGridData", value: JSON.stringify(selectedRows)});
					data.push({name: "flag", value: 'labor'}); //작업(인건비) 
					
					$.ajax({
						url : "/yp/zcs/ctr/zcs_ctr_manh_delete",
						type : "POST",
						cache : false,
						async : true,
						dataType : "json",
						data : data,
						success : function(result) {
							//swalSuccessCB(result.result+"건이 삭제 완료됐습니다.");
							swalSuccessCB("삭제 완료됐습니다.");
							//Grid리로드
							work_labor_scope.reloadGrid({
								CONTRACT_CODE : $("input[name=contract_code]").val()
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
							swalDangerCB("삭제에 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
				}
			}
			
		});
		
	});
</script>

<!-------------------------------------------------------------------------- 작업(경비/기타)Grid -------------------------------------------------------->
<script>
	//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
	app.controller('work-expense-ctrl', [ '$scope', '$window', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $window, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
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

		
		//cellClass
		$scope.cellClassSet = function(grid, row, col, rowRenderIndex, colRenderIndex){
			var className = "";
			switch(col.field){
				
			}

			return className;
		}

		
		var columnDefs1 = [
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
				displayName : '순번',
				field : 'SEQ',
				width : '100',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, 
			{
				displayName : '순번',
				field : 'RN',
				width : '100',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, 
			{
				displayName : '내용',
				field : 'CONTENTS',
				minWidth : '400',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><input on-clipboard-pasted class="absolute_center width_90_percent" type="text" ng-model="row.entity.CONTENTS"/></div>'
			}, 
			{
				displayName : '검수 보고서 표시 단위',
				field : 'MARK_UNIT',
				width : '160',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><input on-clipboard-pasted class="absolute_center width_90_percent" type="text" ng-model="row.entity.MARK_UNIT"/></div>'
			}, 
			{
				displayName : '비율/금액',
				field : 'RATE_AMOUNT',
				width : '150',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><input on-clipboard-pasted class="absolute_center width_90_percent" type="text" ng-model="row.entity.RATE_AMOUNT" on-model-change="grid.appScope.gridAddComma(row)"/></div>'
			}, 
			{
				displayName : '단위',
				field : 'UNIT',
				width : '100',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				//cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><input on-clipboard-pasted class="absolute_center width_90_percent" type="text" ng-model="row.entity.UNIT"/></div>'
				cellTemplate : '<select class="ui-grid-template ui-grid-custom-select" style="width:100%; min-width: fit-content;" ng-model="row.entity.UNIT" on-model-change="grid.appScope.gridRemoveComma(row)">' + '	<option ng-repeat="SB_UNIT in grid.appScope.SB_UNIT" ng-selected="row.entity.UNIT == SB_UNIT.code_id" value="{{SB_UNIT.code_id}}" >{{SB_UNIT.code_name}}</option>' + '</select>'
			}
		  ];
		$scope.SB_UNIT = [{
			"code_name" : "선택",
			"code_id" : ""
		}, {	"code_name" : "％",
			"code_id" : "%"
		}, {
			"code_name" : "￦",
			"code_id" : "\\"
		} ];
		
		// 천단위 찍어주기
		$scope.gridAddComma = function(row) {
			if(row.entity.RATE_AMOUNT !== null && row.entity.UNIT === "\\"){
				var d = row.entity.RATE_AMOUNT.toString().replace(/[^0-9]/g, '');
				var num = unComma(d);
				num = num * 1;
				row.entity.RATE_AMOUNT = addComma(num);
			}
			work_expense_scope.gridApi.grid.refresh();
		};
		
		// 단위변경
		$scope.gridRemoveComma = function(row) {
			if(row.entity.UNIT === "\\"){
				var d = row.entity.RATE_AMOUNT.toString().replace(/[^0-9]/g, '');
				var num = unComma(d);
				num = num * 1;
				row.entity.RATE_AMOUNT = addComma(num);
			}else{
				var d = row.entity.RATE_AMOUNT.toString().replace(/[,]/g, '');
				row.entity.RATE_AMOUNT = d;
			}
			work_expense_scope.gridApi.grid.refresh();
		};
		
		$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
		{
			enableGridMenu: true,	 //필터버튼
			enableFiltering : false, //각 컬럼에 검색바
			showColumnFooter : false,
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
		//var work_labor_scope = angular.element(document.getElementById("work-labor-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
		//var scope = angular.element(document.getElementById("work-expense-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
		
		work_expense_scope.gridApi.core.on.rowsRendered(work_expense_scope, function() {	//그리드 렌더링 후 이벤트
			
		});
		work_expense_scope.gridApi.selection.on.rowSelectionChanged(work_expense_scope, function(row) { //로우 선택할때마다 이벤트
			//console.log("row2", row.entity);
		});
		work_expense_scope.gridApi.selection.on.rowSelectionChangedBatch(work_expense_scope, function(rows) { //전체선택시 가져옴
			//console.log("row3", rows[0].entity); //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
		});
		// pagenation option setting  그리드를 부르기 전에 반드시 선언
		// 테이블 조회는 
		// EXEC_RFC : "FI"
		var param = {
				EXEC_RFC  : "N", // RFC 여부
				cntQuery  : "yp_zcs_ctr.select_construction_subc_cost_cnt", 	
				listQuery : "yp_zcs_ctr.select_construction_subc_cost"
		};
		work_expense_scope.paginationOptions = customExtend(work_expense_scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
		//복붙영역(앵귤러 이벤트들 가져오기) 끝
		
		/* 작업(경비/기타) 한줄 추가 */
		$(".work_section .expense_other_content .add").on("click", function() {
			var seq = work_expense_scope.gridOptions.data.length+1;
			var data = {};
			work_expense_scope.addRow(data,true,"asc");
			work_expense_scope.gridApi.grid.refresh();
		});
		
		/* 작업(경비/기타) 한줄 삭제 */
		$(".work_section .expense_other_content .remove").on("click", function() {
			var selectedRows = work_expense_scope.gridApi.selection.getSelectedRows();
			if(selectedRows.length === 0){
				swalWarningCB("삭제할 항목을 선택하세요.");
				return false;
			}
			
			var length = selectedRows.length;
			//계약코드가 없을 시
			if(isEmpty(selectedRows[length-1].CONTRACT_CODE)){
				console.log(selectedRows);
				$.each(selectedRows, function(i, d) {
					// 선택된 데이터 삭제
					work_expense_scope.gridOptions.data.splice(work_expense_scope.gridOptions.data.indexOf(d), 1);
				});
// 				work_expense_scope.gridOptions.data.pop(selectedRows);
				work_expense_scope.gridApi.grid.refresh();
			//계약코드가 존재할 시 
			}else{
				if (confirm("삭제하겠습니까?")) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					
					var data = $("#frm").serializeArray();
					data.push({name: "expenseGridData", value: JSON.stringify(selectedRows)});
					data.push({name: "flag", value: 'expense'});
					
					$.ajax({
						url : "/yp/zcs/ctr/zcs_ctr_manh_delete",
						type : "POST",
						cache : false,
						async : true,
						dataType : "json",
						data : data,
						success : function(result) {
							//swalSuccessCB(result.result+"건이 삭제 완료됐습니다.");
							swalSuccessCB("삭제 완료됐습니다.");
							//Grid리로드
							work_expense_scope.reloadGrid({
								CONTRACT_CODE : $("input[name=contract_code]").val()
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
							swalDangerCB("삭제에 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
				}
			}
			
		});
		
		/* 작업 저장 클릭 */
		$("#work_save").on("click", function() {
			// 2020-12-01 jamerl - 최승빈 : 결재 진행중 혹은 완료된 계약은 변경불가
			if($("input[name=contract_code]").val() !== ""){
				if(!select_chk_enable_proc(null, null, null, $("input[name=contract_code]").val(), null)){
					return false;
				}
			}
			//공통 빈값 체크
			if(commonValidation()){
				return;
			}
			
			//인건비 빈값 체크
			var laborGridDatas = work_labor_scope.gridOptions.data;
			for(var i=0; i<laborGridDatas.length; i++){
				if(isEmpty(laborGridDatas[i].CONTENTS)){
					swalWarningCB("인건비 "+(i+1)+"번째 행 \r\n 작업을 입력해주세요.");
					return;
				}
				if(isEmpty(laborGridDatas[i].MARK_UNIT)){
					swalWarningCB("인건비"+(i+1)+"번째 행 \r\n 검수 보고서 표시 단위을 입력해주세요.");
					return;			
				}
				if(isEmpty(laborGridDatas[i].AMOUNT)){
					swalWarningCB("인건비 "+(i+1)+"번째 행 \r\n 금액을 입력해주세요.");
					return;
				}
				if(isEmpty(laborGridDatas[i].UNIT)){
					swalWarningCB("인건비 "+(i+1)+"번째 행 \r\n 단위를 입력해주세요.");
					return;
				}
			}
			
			//경비/기타 빈값 체크
			var expenseGridDatas = work_expense_scope.gridOptions.data;
			for(var i=0; i<expenseGridDatas.length; i++){
				if(isEmpty(expenseGridDatas[i].CONTENTS)){
					swalWarningCB("경비/기타 "+(i+1)+"번째 행 \r\n 내용을 입력해주세요.");
					return;
				}
				if(isEmpty(expenseGridDatas[i].MARK_UNIT)){
					swalWarningCB("경비/기타 "+(i+1)+"번째 행 \r\n 검수 보고서 표시 단위을 입력해주세요.");
					return;			
				}
				if(isEmpty(expenseGridDatas[i].RATE_AMOUNT)){
					swalWarningCB("경비/기타 "+(i+1)+"번째 행 \r\n 비율/금액을 입력해주세요.");
					return;
				}
				if(isEmpty(expenseGridDatas[i].UNIT)){
					swalWarningCB("경비/기타 "+(i+1)+"번째 행 \r\n 단위를 입력해주세요.");
					return;
				}
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
					    var laborSelectedRows = work_labor_scope.gridApi.selection.getSelectedRows();	//그리드 선택된 rows data(인건비)
					    var expenseSelectedRows = work_expense_scope.gridApi.selection.getSelectedRows();	//그리드 선택된 rows data(비용/기타)
						//form데이터 + 그리드데이터 json으로 변환 및 추가해서 서버로 전송
						var data = $("#frm").serializeArray();
						var yyyy = '<%=toDay%>'.split("/")[0];
						//시작&끝 날짜 '/'문자 없애기
						var CONTRACT_START_DATE = $("#sdate").val().replace("/","").replace("/","");
						var CONTRACT_END_DATE = $("#edate").val().replace("/","").replace("/","");
						//계약코드 - 처음엔 없기 때문에 서버에서 계약코드 생성. INSERT쿼리 실행
						//      - 다시 저장버튼을 클릭할 경우, 계약코드 값이 존재한다. 그렇다면, UPDATE쿼리를 실행
						var CONTRACT_CODE = $("input[name=contract_code]").val();
						
						data.push({name: "laborGridData", value: JSON.stringify(laborSelectedRows)});
						data.push({name: "expenseGridData", value: JSON.stringify(expenseSelectedRows)});
						data.push({name: "YYYY", value: yyyy});
						data.push({name: "CONTRACT_START_DATE", value: CONTRACT_START_DATE});
						data.push({name: "CONTRACT_END_DATE", value: CONTRACT_END_DATE});
						data.push({name: "CONTRACT_CODE", value: CONTRACT_CODE});
						
						$.ajax({
							url : "/yp/zcs/ctr/zcs_ctr_manh_save",
							type : "post",
							cache : false,
							async : false,//동기화
							data : data,
							dataType : "json",
							success : function(result) {
								swalSuccessCB("데이터가 저장됐습니다.");
								//계약코드 값 넣어주기
								$("input[name=contract_code]").val(result.CONTRACT_CODE);
								
								//Grid리로드 (작업 - 인건비)
								work_labor_scope.reloadGrid({
									CONTRACT_CODE : result.CONTRACT_CODE
								});
								
								//Grid리로드 (작업 - 경비/기타)
								work_expense_scope.reloadGrid({
									CONTRACT_CODE : result.CONTRACT_CODE
								});
							}
						}); 
				  }
			});   
			
		});
		
		/* 공수 인건비 트리거 클릭 */
		$(".gongsu_section .labor_cost").trigger("click");
		
	});
</script>

<!-------------------------------------------------------------------------- 월정액 -------------------------------------------------------->
<script>
$(document).ready(function(){
	
	/* 지급기준 월 변경 */
	$("select[name=pay_gubun_month]").on("change", function() {
		$(".monthly").html($(this).val()+"개월");
		
		//1년값을 해당개월로 계산
		var data = unComma($("input[name=EMPLOYMENT_COSTS_YEAR]").val());
		var monthly = $("select[name=pay_gubun_month]").val();		
		data = data/12*monthly;
		$("input[name=EMPLOYMENT_COSTS_MONTH]").val(addComma(Math.floor(data)));
	});
	
	/* 1년 input 변경 */
	$("input[name=EMPLOYMENT_COSTS_YEAR]").on("blur", function() {
		//1년값을 해당개월로 계산
		var data = unComma($(this).val());
		var monthly = $("select[name=pay_gubun_month]").val();
		data = data/(12/monthly);
		$("input[name=EMPLOYMENT_COSTS_MONTH]").val(addComma(Math.floor(data)));
		
		//1년 input에 콤마추가
		$(this).val(addComma($(this).val()));
	});
	
	/* 월정액 저장 클릭 */
	$("#monthly_save").on("click", function() {
		// 2020-12-01 jamerl - 최승빈 : 결재 진행중 혹은 완료된 계약은 변경불가
		if($("input[name=contract_code]").val() !== ""){
			if(!select_chk_enable_proc(null, null, null, $("input[name=contract_code]").val(), null)){
				return false;
			}
		}
		//공통 빈값 체크
		if(commonValidation()){
			return;
		}
		
		//1년 인건비 빈값 체크
		var EMPLOYMENT_COSTS_YEAR = $("input[name=EMPLOYMENT_COSTS_YEAR]").val();
		if(isEmpty(EMPLOYMENT_COSTS_YEAR)){
			swalWarningCB("1년 인건비를 입력해주세요.");
			return;
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
					//form데이터 + 그리드데이터 json으로 변환 및 추가해서 서버로 전송
					var data = $("#frm").serializeArray();
					var yyyy = '<%=toDay%>'.split("/")[0];
					//시작&끝 날짜 '/'문자 없애기
					var CONTRACT_START_DATE = $("#sdate").val().replace("/","").replace("/","");
					var CONTRACT_END_DATE = $("#edate").val().replace("/","").replace("/","");
					//계약코드 - 처음엔 없기 때문에 서버에서 계약코드 생성. INSERT쿼리 실행
					//      - 다시 저장버튼을 클릭할 경우, 계약코드 값이 존재한다. 그렇다면, UPDATE쿼리를 실행
					var CONTRACT_CODE = $("input[name=contract_code]").val();
					//1년 인건비 콤마제거
					var EMPLOYMENT_COSTS_YEAR = unComma($("input[name=EMPLOYMENT_COSTS_YEAR]").val());
					//월 인건비 콤마제거
					var EMPLOYMENT_COSTS_MONTH = unComma($("input[name=EMPLOYMENT_COSTS_MONTH]").val());
					
					data.push({name: "YYYY", value: yyyy});
					data.push({name: "CONTRACT_CODE", value: CONTRACT_CODE});
					//EMPLOYMENT_COSTS_YEAR 콤마 없앤 값으로  교체
					for(var i=0; i<data.length; i++){
						if(data[i].name == 'EMPLOYMENT_COSTS_YEAR'){
							data.splice(i, 1);
						}
						if(data[i].name == 'EMPLOYMENT_COSTS_MONTH'){
							data.splice(i, 1);
						}
					}
					data.push({name: "EMPLOYMENT_COSTS_YEAR", value: EMPLOYMENT_COSTS_YEAR});
					data.push({name: "EMPLOYMENT_COSTS_MONTH", value: EMPLOYMENT_COSTS_MONTH});
					data.push({name: "CONTRACT_START_DATE", value: CONTRACT_START_DATE});
					data.push({name: "CONTRACT_END_DATE", value: CONTRACT_END_DATE});
					
					$.ajax({
						url : "/yp/zcs/ctr/zcs_ctr_manh_save",
						type : "post",
						cache : false,
						async : false,//동기화
						data : data,
						dataType : "json",
						success : function(result) {
							swalSuccessCB("데이터가 저장됐습니다.");
							//계약코드 값 넣어주기
							$("input[name=contract_code]").val(result.CONTRACT_CODE);
						}
					}); 
			  }
		});   
		
	});
	
	
	//계약조회에서 계약등록화면으로 넘어올 경우
	if(!isEmpty('${CONTRACT_CODE}')){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		var contract_code = '${CONTRACT_CODE}';
		
		var data = {'CONTRACT_CODE':contract_code};
		
		$.ajax({
			url : "/yp/zcs/ctr/zcs_ctr_manh_create_select",
			type : "post",
			cache : false,
			async : false,//동기화
			data : data,
			dataType : "json",
			success : function(result) {
				var contstruction_subc_list = result.contstruction_subc_list;
				
				//contstruction_subc_list
				for(var i in contstruction_subc_list){
					var obj = contstruction_subc_list[i];
					for(var key in obj){
						//제일 처음으로 지급기준 선택! (지급기준 선택하면 모든 정보가 초기화되기 떄문에 제일먼저 선택)
						if(key == 'PAY_STANDARD'){
							// 계약 인원 디피 판단
							if( obj[key] === "1" ){
								$("input[name=CONTRACT_PEOPLE_CNT]").show().parent().prev().text("계약 인원");
								$("input[name=DAILY_REQ_PEOPLE_CNT]").show().parent().prev().text("일일 필수 출근 인원");
							}else{
								$("input[name=CONTRACT_PEOPLE_CNT]").hide().prop("disabled", true).parent().prev().text("");
								$("input[name=DAILY_REQ_PEOPLE_CNT]").hide().prop("disabled", true).parent().prev().text("");
							}
							//지급기준 선택
							$("select[name=PAY_STANDARD]").val(obj[key]).trigger('change');
							//지급기준 선택후 계약코드에 값 넣어주기
							$("input[name=contract_code]").val(contract_code);
							//WBS_CODE 전부 열어주기
							for(var i=0; i<5; i++){
								$("#wbs_add_btn").trigger("click");
							}
						//계약명 넣어주기
						}else if(key == "CONTRACT_NAME"){
							$("input[name=CONTRACT_NAME]").val(obj[key]);
						//계약 시작 기간 넣어주기
						}else if(key == "CONTRACT_START_DATE"){
							$("#sdate").val(obj[key]);
						//계약 종료 기간 넣어주기
						}else if(key == "CONTRACT_END_DATE"){
							$("#edate").val(obj[key]);
						}else if(key == "WBS_CODE1"){
							$("input[name=WBS_CODE1]").val(obj[key]);
						}else if(key == "WBS_CODE2"){
							$("input[name=WBS_CODE2]").val(obj[key]);
						}else if(key == "WBS_CODE3"){
							$("input[name=WBS_CODE3]").val(obj[key]);
						}else if(key == "WBS_CODE4"){
							$("input[name=WBS_CODE4]").val(obj[key]);
						}else if(key == "WBS_CODE5"){
							$("input[name=WBS_CODE5]").val(obj[key]);
						}else if(key == "WBS_CODE6"){
							$("input[name=WBS_CODE6]").val(obj[key]);
						//거래처 코드 넣어주기
						}else if(key == "VENDOR_CODE"){
							$("input[name=VENDOR_CODE]").val(obj[key]);
						//거래처 명 넣어주기
						}else if(key == "VENDOR_NAME"){
							$("input[name=VENDOR_NAME]").val(obj[key]);
						//SAP_CODE 넣어주기
						}else if(key == "SAP_CODE"){
							$("input[name=SAP_CODE]").val(obj[key]);
						//공수 인건비
						}else if(key == "EMPLOYMENT_COSTS"){
							$("input[name=EMPLOYMENT_COSTS]").val(obj[key]);
						//시작근무시간
						}else if(key == "WORK_START_TIME"){
							$("input[name=WORK_START_TIME]").val(obj[key]);
						//종료근무시간
						}else if(key == "WORK_END_TIME"){
							$("input[name=WORK_END_TIME]").val(obj[key]);
						//연별 인건비
						}else if(key == "EMPLOYMENT_COSTS_MONTH"){
							$("input[name=EMPLOYMENT_COSTS_MONTH]").val(obj[key]);
						//월별 인건비
						}else if(key == "EMPLOYMENT_COSTS_YEAR"){
							$("input[name=EMPLOYMENT_COSTS_YEAR]").val(obj[key]);
						}else if(key == "CONTRACT_PEOPLE_CNT"){
							//계약 인원
							$("input[name=CONTRACT_PEOPLE_CNT]").val(obj[key]);
						}else if(key == "DAILY_REQ_PEOPLE_CNT"){
							//일일 필수 출근 인원
							$("input[name=DAILY_REQ_PEOPLE_CNT]").val(obj[key]);
						}
					}
				}
				
				//Grid리로드 (작업 - 인건비)
				work_labor_scope.reloadGrid({
					CONTRACT_CODE : contract_code
				});
				
				//Grid리로드 (작업 - 경비/기타)
				work_expense_scope.reloadGrid({
					CONTRACT_CODE : contract_code
				});
				
				//Grid리로드 (공수 - 경비/기타)
				gongsu_expense_scope.reloadGrid({
					CONTRACT_CODE : contract_code
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
				swalDangerCB("삭제에 실패하였습니다.\n관리자에게 문의해주세요.");
			}
		}); 
	}
});

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