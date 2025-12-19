<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
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

	//하루 전
	Calendar day = Calendar.getInstance();
	day.add(Calendar.DATE , -1);
	String yesterday = date.format(day.getTime());
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>전해조 청소실적 현황</title>
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
		});

		//조회조건 default
		//오늘날짜 세팅
		if($("input[name=date]").val() == "") {
			$("input[name=date]").val("<%=toDay%>");
		}

		$('input').on('keydown', function(event) {
			if(event.keyCode==13)
				return false;
		});

	});
</script>

</head>
<body>
	<!-- 20191023_khj for csrf -->
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<h2>
		전해조 청소실적 등록
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
	<!-- <div class="stitle">기본정보</div> -->
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
					<th>기준일자</th>
					<td>
						<input type="text" class="calendar dtp" name="date" id="date" size="10" value="${toDay}" readonly />
					</td>
				</tr>
			</table>
			<div class="btn_wrap">
				<button class="btn btn_search" id="search_btn">조회</button>
			</div>
		</div>
	</section>
	</form>
	<div class="float_wrap" style="margin-bottom: 2px;">
		<div class="fl">
			<div class="btn_wrap">
				<input type="button" class="btn_g" id="fnAdd" value="추가" />
				<input type="button" class="btn_g" id="fnMod" value="수정" />
			</div>
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type=button class="btn_g" id="fnRem" value="삭제" />
				<input type=button class="btn_g" id="fnReg" value="저장" />
			</div>
		</div>
	</div>

	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="shdsCtrl" style="height: auto;">
			<div data-ui-i18n="ko" style="height: 540px;">
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

			// 계정 AJAX 이벤트
			$scope.fnAjaxHKONT = function(row) {

				//if (row.entity.HKONT != null && row.entity.HKONT.length >= 8) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zpp/cre/retrieveAjaxBFDT",
						type : "post",
						cache : false,
						async : true,
						data : {FACTORY_NM : row.entity.FACTORY_NM, F_LINE : row.entity.F_LINE, F_ROW : row.entity.F_ROW, CLEAN_DT : row.entity.CLEAN_DT},

						dataType : "json",
						success : function(result) {
							if (result.BF_DT == "" || result.CALC_CLEAN == null) {
	
								swalWarningCB("일치하는 데이터가 없습니다.");
								row.entity.BF_DT = ""; //이전청소일
							} else {
								row.entity.BF_DT = result.BF_DT1; //이전청소일
								row.entity.CALC_CLEAN = result.CALC_CLEAN; //청소경과일
								//fnAvailAMT(row);
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
				//}
			};

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

			var FACTORY_NM = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents">{{row.entity.FACTORY_NM}}공장</div>';

			var FACTORY_NM_N = 
				'<select ng-if="row.entity.IS_NEW != null" ng-model="row.entity.FACTORY_NM" style="width: 100%; height: 100% !important;">' + 
				'	<option value="1" selected>1공장</option>' + 
				//'	<option value="1">1공장</option>' + 
				//'	<option value="2">2공장</option>' + 
				'</select>';

			var FACTORY_NM_C = 
				'<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" class="ui-grid-cell-contents" ng-model="row.entity.FACTORY_NM">{{row.entity.FACTORY_NM}}공장</div>';

			var F_LINE = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.F_LINE">{{row.entity.F_LINE1}}</div>';

			var F_LINE_N = 
				'<select ng-if="row.entity.IS_NEW != null" ng-model="row.entity.F_LINE" style="width: 100%; height: 100% !important;">' + 
				'	<option value="" selected>선택</option>' + 
				'	<option value="1">#1</option>' + 
				'	<option value="2">#2</option>' + 
				'	<option value="3">#3</option>' + 
				'	<option value="4">#4</option>' + 
				'	<option value="5">#5</option>' + 
				'	<option value="6">#6</option>' + 
				'	<option value="7">#7</option>' + 
				//'	<option value="8">#8</option>' + 
				'</select>';

			var F_LINE_C = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" class="ui-grid-cell-contents" ng-model="row.entity.F_LINE">{{row.entity.F_LINE1}}</div>';

			var F_ROW = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.F_ROW">{{row.entity.F_ROW1}}</div>';

			var F_ROW_N =
				'<select ng-if="row.entity.IS_NEW != null" ng-model="row.entity.F_ROW" style="width: 100%; height: 100% !important;">' + 
				'	<option value="" selected>선택</option>' + 
				'	<option value="A">남</option>' + 
				'	<option value="B">북</option>' + 
				//'	<option value="R1">R1</option>' + 
				//'	<option value="R2">R2</option>' + 
				'</select>';

			var F_ROW_C = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" class="ui-grid-cell-contents" ng-model="row.entity.F_ROW">{{row.entity.F_ROW1}}</div>';

			var CLEAN_GB = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.CLEAN_GB">{{row.entity.CLEAN_GB1}}</div>';

			var CLEAN_GB_N =
				'<select ng-if="row.entity.IS_NEW != null" ng-model="row.entity.CLEAN_GB" ng-change="grid.appScope.change_GB(row)" style="width: 100%; height: 100% !important;">' + 
				'	<option value="" selected>선택</option>' + 
				'	<option value="A">완전청소</option>' + 
				'	<option value="B">부분청소</option>' + 
				//'	<option value="C">아노드청소</option>' + 
				'</select>';

			var CLEAN_GB_C =
				'<select ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" ng-model="row.entity.CLEAN_GB" ng-change="grid.appScope.change_GB(row)" style="width: 100%; height: 100% !important;">' + 
				'	<option value="" selected>선택</option>' + 
				'	<option value="A">완전청소</option>' + 
				'	<option value="B">부분청소</option>' + 
				//'	<option value="C">아노드청소</option>' + 
				'</select>';

			// 청소구분 이벤트
			$scope.change_GB = function(row) {
				
				//row.entity.CLEAN_GB = "";

				var code = row.entity.CLEAN_GB;

				if(code == "A"){
					row.entity.CLEAN_ECELL = "1-36";
				}
				else{
					row.entity.CLEAN_ECELL = "";
				}
				scope.gridApi.grid.refresh();

			}

			// 청소전해조
			var CLEAN_ECELL = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.CLEAN_ECELL">{{row.entity.CLEAN_ECELL}}</div>';

			var CLEAN_ECELL_N = '<input ng-if="row.entity.IS_NEW != null" type="text" style="height: 100%;" ng-model="row.entity.CLEAN_ECELL">';

			var CLEAN_ECELL_C = '<input ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" type="text" style="height: 100%;" ng-model="row.entity.CLEAN_ECELL">';

			// 청소일자
			var CLEAN_DT = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.CLEAN_DT">{{row.entity.CLEAN_DT1}}</div>';
		
			var CLEAN_DT_N = '<input ng-if="row.entity.IS_NEW != null" type="text" class="calendar dtp_d" ng-model="row.entity.CLEAN_DT" style="width: 100%; height: 100% !important;" on-model-change="grid.appScope.fnAjaxHKONT(row)" />';

			var CLEAN_DT_C = '<input ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" type="text" class="calendar dtp_d" ng-model="row.entity.CLEAN_DT" style="width: 100%; height: 100% !important;" readonly="readonly"/>';

			// 이전청소일
			//var BF_DT = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.BF_DT">{{row.entity.BF_DT}}</div>';

			//청소경과일
			//var CALC_CLEAN = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.CALC_CLEAN">{{row.entity.CALC_CLEAN}}</div>';

			//var CALC_CLEAN_N = '<input ng-if="row.entity.IS_NEW != null" type="text" ng-model="row.entity.CALC_CLEAN" style="width: 100%; height: 100% !important;" readonly="readonly"/>';

			//var CALC_CLEAN_C = '<input ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" type="text" ng-model="row.entity.CALC_CLEAN" style="width: 100%; height: 100% !important;" readonly="readonly"/>';

			// 이월전해조
			//var OVER_ECELL = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.OVER_ECELL">{{row.entity.OVER_ECELL}}</div>';

			//var OVER_ECELL_N = '<input ng-if="row.entity.IS_NEW != null" type="text" style="height: 100%;" ng-model="row.entity.OVER_ECELL">';

			//var OVER_ECELL_C = '<input ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" type="text" style="height: 100%;" ng-model="row.entity.OVER_ECELL">';

			// 이월청소일
			//var OVER_DT = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.OVER_DT">{{row.entity.OVER_DT1}}</div>';

			//var OVER_DT_N = '<input ng-if="row.entity.IS_NEW != null" type="text" class="calendar dtp_d" ng-model="row.entity.OVER_DT" style="width: 100%; height: 100% !important;" readonly="readonly"/>';

			//var OVER_DT_C = '<input ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" type="text" class="calendar dtp_d" ng-model="row.entity.OVER_DT" style="width: 100%; height: 100% !important;" readonly="readonly"/>';

			// 이월경과일
			//var CALC_OVER = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.CALC_OVER">{{row.entity.CALC_OVER}}</div>';

			//var CALC_OVER_N = '<input ng-if="row.entity.IS_NEW != null" type="text" ng-model="row.entity.CALC_OVER" style="width: 100%; height: 100% !important;" readonly="readonly"/>';

			//var CALC_OVER_C = '<input ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" type="text" ng-model="row.entity.CALC_OVER" style="width: 100%; height: 100% !important;" readonly="readonly"/>';

			// 아노드교체량
			//var CH_ANODE = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.CH_ANODE">{{row.entity.CH_ANODE}}</div>';

			//var CH_ANODE_N = '<input ng-if="row.entity.IS_NEW != null" type="text" style="height: 100%;" ng-model="row.entity.CH_ANODE">';

			//var CH_ANODE_C = '<input ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" type="text" style="height: 100%;" ng-model="row.entity.CH_ANODE">';

			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바

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
				//useExternalPagination : true, //pagination을 직접 세팅
				enableAutoFitColumns : false, //컬럼 width를 자동조정
				multiSelect : true, //여러로우선택
				enablePagination : true,
				enablePaginationControls : true,

				columnDefs : [ //컬럼 세팅
				{
					displayName : 'IS_NEW',
					field : 'IS_NEW',
					width : '1',
					visible : false,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'IS_MOD',
					field : 'IS_MOD',
					width : '1',
					visible : false,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '공장',
					field : 'FACTORY_NM',
					//width : '80',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : FACTORY_NM + FACTORY_NM_N + FACTORY_NM_C
				}, {
					displayName : '계열',
					field : 'F_LINE',
					//width : '130',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : F_LINE + F_LINE_N + F_LINE_C
				}, {
					displayName : '열',
					field : 'F_ROW',
					//width : '80',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : F_ROW + F_ROW_N + F_ROW_C
				}, {
					displayName : '청소구분',
					field : 'CLEAN_GB',
					//width : '120',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : CLEAN_GB + CLEAN_GB_N + CLEAN_GB_C
				}, {
					displayName : '청소전해조',
					field : 'CLEAN_ECELL',
					//width : '120',
					visible : true,
					cellClass : "right",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : CLEAN_ECELL + CLEAN_ECELL_N + CLEAN_ECELL_C
				}, {
					displayName : '청소일',
					field : 'CLEAN_DT',
					//width : '120',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : CLEAN_DT + CLEAN_DT_N + CLEAN_DT_C
				},
				{
					displayName : '이전청소일',
					field : 'BF_DT',
					//width : '120',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_date(row.entity.BF_DT)}}</div>'
				},
				//{
					//displayName : '청소경과일',
					//field : 'CALC_CLEAN',
					//width : '120',
					//visible : true,
					//cellClass : "right",
					//pinnedLeft : true,
					//enableCellEdit : false,
					//allowCellFocus : false,
					//cellTemplate : CALC_CLEAN + CALC_CLEAN_N + CALC_CLEAN_C
				//},
				//{
					//displayName : '이월전해조',
					//field : 'OVER_ECELL',
					//width : '120',
					//visible : true,
					//cellClass : "right",
					//pinnedLeft : true,
					//enableCellEdit : false,
					//allowCellFocus : false,
					//cellTemplate : OVER_ECELL + OVER_ECELL_N + OVER_ECELL_C
				//},
				//{
					//displayName : '이월청소일',
					//field : 'OVER_DT',
					//width : '120',
					//visible : true,
					//cellClass : "center",
					//pinnedLeft : true,
					//enableCellEdit : false,
					//allowCellFocus : false,
					//cellTemplate : OVER_DT + OVER_DT_N + OVER_DT_C
				//},
				{
					displayName : '청소경과일',
					field : 'CALC_CLEAN',
					width : '120',
					visible : true,
					cellClass : "right",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_date(row.entity.CALC_CLEAN)}}</div>'
				}
				//{
					//displayName : '아노드교체량',
					//field : 'CH_ANODE',
					//width : '120',
					//visible : true,
					//cellClass : "right",
					//pinnedLeft : true,
					//enableCellEdit : false,
					//allowCellFocus : false,
					//cellTemplate : CH_ANODE + CH_ANODE_N + CH_ANODE_C
				//}
				]
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
			// EXEC_RFC : "PP"
			var param = {
				EXEC_RFC  : "N", // RFC 여부
				listQuery : "yp_zpp.select_zpp_cre_list_c", //list가져오는 마이바티스 쿼리 아이디
				cntQuery : "yp_zpp.select_zpp_cre_list_cnt_c" //list cnt 가져오는 마이바티스 쿼리 아이디
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝

			// 부트스트랩 날짜객체
			$(document).on("focus", ".dtp_d", function() {
				$(this).datepicker({
					format : "yyyy/mm/dd",
					language : "ko",
					todayHighlight : true,
					autoclose : true,
					clearBtn : true,
					updateViewDate : false
				}).on('changeDate', function(ev) {
					$(this).trigger("change");
					$('.datepicker').hide();
				});
			});

			// 처음에 바로 조회
			$("#search_btn").trigger("click");

		});

		// 조회
		$("#search_btn").on("click", function() {
			scope.reloadGrid({
				date : $("input[name=date]").val()
			});
		});

		//추가
		$("#fnAdd").on("click", function() {
			scope.addRow({
				IS_NEW : "Y",
				IS_MOD : "",
				FACTORY_NM : "1",
				F_LINE : "",
				F_ROW : "",
				CLEAN_GB : "",
				CLEAN_ECELL : "",
				CLEAN_DT : "",
				BF_DT : "",
				CALC_CLEAN : "",
				//OVER_ECELL : "",
				//OVER_DT : "",
				//CALC_OVER : "",
				//CH_ANODE : ""
			}, true, "desc");
		});

		// 수정
		$("#fnMod").on("click", function() {
			var rows = scope.gridApi.selection.getSelectedRows();
			if (isEmpty(rows)) {
				swalWarning("항목을 선택하세요.");
				return false;
			}
			$.each(rows, function(i, d){
				if(d.IS_NEW === "Y") {
					return true;
				}
				d.IS_MOD = "Y";
			});
			scope.gridApi.grid.refresh();
		});

	    $("#fnReg").on("click", function() {
			var rows = scope.gridApi.selection.getSelectedRows();

			if (!fnValidation() && fnValidationRow(rows)) {
				return false;

				console.log(rows);
			}
			if(rows.length === 0) {
				swalWarningCB("저장할 항목을 선택하세요.");
				return false;
			}

			if (confirm("저장하시겠습니까?")) {
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");

				//var data = $("#frm").serializeArray();
				//data.push({name: "ROW_NO", value: JSON.stringify(rows)});
				//data.push({name: "STD_DT", value: $("input[name=date]").val()});

				var data = $("#frm").serializeArray();

				$.ajax({
				    url: "/yp/zpp/cre/zpp_cre_save",
				    type: "POST",
				    cache:false,
				    async:true, 
				    dataType:"json",
					data : {
						ROW_NO: JSON.stringify(rows),
						STD_DT: $("input[name=date]").val()
					},
				    success: function(result) {
						swalSuccessCB("저장 완료하였습니다.", function(){
							$("#search_btn").trigger("click");
						});
					},

					beforeSend : function(xhr) {
						// 2019-10-23 khj - for csrf
						xhr.setRequestHeader(header, token);
						$('.wrap-loading').removeClass('display-none');
					},
					complete:function() {
				        $('.wrap-loading').addClass('display-none');
				    },
				    error:function(request,status,error) {
				    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
				    	swalDanger("처리중 오류가 발생하였습니다.\n관리자에게 문의해주세요.");
				    }
			 	});
			}

		});

		function fnValidation() {
			
			if("" == $("input[name=date]").val()){
				swalWarning("기준일자를 입력해 주세요.");
				return false;
			}

			return true;
		}

		function fnValidationRow(rows) {

			$.each(rows, function(i, d){
				console.log("each.idx="+i);
				if(d.FACTORY_NM == null || d.FACTORY_NM == "") {
					swalWarningCB("공장을 선택해주세요.");
					return false;
				} else if(d.F_LINE == null || d.F_LINE == "") {
					swalWarningCB("계열을 선택해주세요.");
					return false;
				} else if(d.F_ROW == null || d.F_ROW == "") {
					swalWarningCB("열을 선택해주세요.");
					return false;
				} else if(d.CLEAN_GB == null || d.CLEAN_GB == "") {
					swalWarningCB("청소구분을 선택해주세요.");
					return false;
				} else if(d.CLEAN_ECELL == null || d.CLEAN_ECELL == "") {
					swalWarningCB("청소전해조를 입력해주세요.");
					return false;
				} else if(d.CLEAN_DT == null || d.CLEAN_DT == "") {
					swalWarningCB("청소일을 선택해주세요.");
					return false;
				//} else if(d.CH_ANODE == null || d.CH_ANODE == "") {
					//swalWarningCB("아노드교체량을 입력해주세요.");
					//return false;
				}
			});
			return true;
		}

		// 삭제
		$("#fnRem").click(function() {

			var rows = scope.gridApi.selection.getSelectedRows();
			if(rows.length == 0){
				swalWarning("삭제할 항목을 선택해 주세요.");
				return false;
			}

			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");

			swal({
				icon : "info",
				text : "삭제하면 복구가 불가능 합니다.\n삭제 하시겠습니까?",
				closeOnClickOutside : false,
				closeOnEsc : false,
				buttons : {
					confirm : {
						text : "확인",
						value : true,
						visible : true,
						className : "",
						closeModal : true
					},
					cancel : {
						text : "취소",
						value : null,
						visible : true,
						className : "",
						closeModal : true
					}
				}
			}).then(function(result) {
				 if(result) {

					$.ajax({
					    url: "/yp/zpp/cre/deleteAccessControl",
					    type: "POST",
					    cache:false,
					    async:true,
					    dataType:"json",
						data : {
							ROW_NO: JSON.stringify(rows),
							STD_DT: $("input[name=date]").val()
						},
					    success: function(data) {
							swalSuccessCB("삭제 완료하였습니다.", function(){
								$("#search_btn").trigger("click");
							});
						},
						beforeSend : function(xhr) {
							// 2019-10-23 khj - for csrf
							xhr.setRequestHeader(header, token);
							$('.wrap-loading').removeClass('display-none');
						},
						complete:function() {
							$('.wrap-loading').addClass('display-none');
						},
   
					    error:function(request,status,error) {
					    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
					    	swalDanger("삭제 진행중 오류가 발생하였습니다.\n관리자에게 문의해주세요.");
					    }
					});
				}
			});

		});

	</script>

</body>