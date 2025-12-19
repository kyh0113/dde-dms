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
String to_yyyy = date.format(today);
// JSTL에서 사용할 수 있도록 세팅
request.setAttribute("to_yyyy", to_yyyy);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>일보 등록</title>
	<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
	<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
</head>
<body>
	<!-- 20191023_khj for csrf --> 
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<h2>
		일보 등록
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
							<input type="text" id="BASE_YYYYMMDD" class="calendar search_dtp" value="${to_yyyy}" readonly="readonly"/>
						</td>
						<th>업체명</th>
						<td colspan="3">
							<select id="VENDOR_CODE">
								<c:forEach var="row" items="${cb_working_master_v}" varStatus="status">
									<option value="${row.CODE}">${row.CODE_NAME}</option>
								</c:forEach>
							</select>
						</td>
						<th>계약명</th>
						<td>
							<select id="CONTRACT_CODE">
								<c:forEach var="row" items="${cb_tbl_working_subc}" varStatus="status">
									<option value="${row.CODE}" data-base-yyyy="${row.BASE_YYYY}">${row.CODE_NAME}</option>
								</c:forEach>
							</select>
						</td>
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
			<div class="btn_wrap" style="text-align: left; float: left;">
				※【유형】은 【<i class="far fa-id-card" > 태그 데이터</i>】와 【<i class="far fa-keyboard" > 추가 데이터</i>】입니다.<br>
				※【<i class="far fa-id-card" > 태그 데이터</i>】는 【비고】항목만 변경할 수 있습니다.
			</div>
			<div class="btn_wrap" style="text-align: left; float: left;">
				&nbsp;&nbsp;※【작업자】는 중복될 수 없습니다. 단, 【<i class="far fa-keyboard" > 추가 데이터</i>】를 입력하기 위한 선택은 가능합니다.<br>
				&nbsp;&nbsp;※【저장】시 【<i class="far fa-keyboard" > 추가 데이터</i>】는 【<i class="far fa-id-card" > 태그 데이터</i>】를 덮어쓰기 합니다.
			</div>
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type=button class="btn_g" id="fn_add"		value="추가">
				<input type=button class="btn_g" id="fn_remove"		value="삭제">
				<input type=button class="btn_g" id="fn_save"		value="저장">
				<input type=button class="btn_g" id="fn_confirm"	value="확정">
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

			// formater - String yyyyMMdd -> String yyyy/MM/dd
			$scope.formatter_date = function(str_date) {
				if (str_date.length === 8) {
					return str_date.replace(/(\d{4})(\d{2})(\d{2})/g, '$1/$2/$3');
				} else {
					return str_date;
				}
			};
			
			// formater - 천단위 콤마
			$scope.formatter_decimal = function(str_no) {
				if (!isNaN(Number(str_no))) {
					return Number(str_no).toLocaleString()
				} else {
					return str_no;
				}
			};
			// 연장시간 이벤트
			$scope.fn_validate_time = function(row) {
				var start_time = row.entity.A_START_DATE_TIME;
				var end_time = row.entity.A_END_DATE_TIME;
				var timeRegExp = /^([1-9]|[01][0-9]|2[0-3]):([0-5][0-9])$/;//시간포맷
				
				if(start_time.length == 2){
					row.entity.A_START_DATE_TIME = start_time + ":";
					scope.gridApi.grid.refresh();
					return false; // 리턴 시키고 다시 본 이벤트를 타도록 유도
				}
				if(end_time.length == 2){
					row.entity.A_END_DATE_TIME = end_time + ":";
					scope.gridApi.grid.refresh();
					return false; // 리턴 시키고 다시 본 이벤트를 타도록 유도
				}
				
				if(start_time.length > 4 && !timeRegExp.test(start_time)){
					swalWarningCB("시간형식에 맞지 않습니다. 00:00 ~ 23:59 포맷으로 입력해주세요.\n초기화 됩니다.", function(){
						row.entity.A_START_DATE_TIME = "";
						scope.gridApi.grid.refresh();
					});
					return false;
				}
				if(end_time.length > 4 && !timeRegExp.test(end_time)){
					swalWarningCB("시간형식에 맞지 않습니다. 00:00 ~ 23:59 포맷으로 입력해주세요.\n초기화 됩니다.", function(){
						row.entity.A_END_DATE_TIME = "";
						scope.gridApi.grid.refresh();
					});
					return false;
				}
			}
			
			//작업자 리스트 팝업
			$scope.PopWorker = function(row) {
				var target = scope.gridOptions.data.indexOf(row.entity);
				
				//파라메터 세팅
				var base_yyyy     = row.entity.BASE_YYYY;		//연도
				var vendor_code   = row.entity.VENDOR_CODE;		//거래처코드
				var contract_code = row.entity.CONTRACT_CODE;	//계약코드
				var contract_name = row.entity.CONTRACT_NAME;	//계약명
				var ent_code      = row.entity.ENT_CODE;		//협력사코드
				
				var form    = document.createElement("form");
				var input0   = document.createElement("input");
				input0.name  = "_csrf";
				input0.value = "${_csrf.token}";
				input0.type  = "hidden";
				
				var input1   = document.createElement("input");
				input1.name  = "BASE_YYYY";
				input1.value = base_yyyy;
				input1.type  = "hidden";
				
				var input2   = document.createElement("input");
				input2.name  = "VENDOR_CODE";
				input2.value = vendor_code;
				input2.type  = "hidden";
				
				var input3   = document.createElement("input");
				input3.name  = "CONTRACT_CODE";
				input3.value = contract_code;
				input3.type  = "hidden";
				
				var input4   = document.createElement("input");
				input4.name  = "CONTRACT_NAME";
				input4.value = contract_name;
				input4.type  = "hidden";
				
				var input5   = document.createElement("input");
				input5.name  = "VENDOR_NAME";
				input5.value = row.entity.VENDOR_NAME;	//벤더명
				input5.type  = "hidden";
				
				var input6   = document.createElement("input");
				input6.name  = "target";
				input6.value = target
				input6.type  = "hidden";
				
				window.open("","worker_popup","width=500,height=650,scrollbars=yes");
				
				form.method = "post";
				form.target = "worker_popup"
				form.action = "/yp/popup/zwc/ipt2/zwc_ipt2_daily_create_worker_popup";
				
				form.appendChild(input0);
				form.appendChild(input1);
				form.appendChild(input2);
				form.appendChild(input3);
				form.appendChild(input4);
				form.appendChild(input5);
				form.appendChild(input6);
				
				document.body.appendChild(form);
				
				form.submit();
				form.remove();
			};

			//차변, 대변
			$scope.SB_WORKTYPE_CODE = [ {
				"code_name" : "= 선택 =",
				"code_id" : ""
			}, {
				"code_name" : "상갑반",
				"code_id" : "W1"
			}, {
				"code_name" : "갑반",
				"code_id" : "W2"
			}, {
				"code_name" : "을반",
				"code_id" : "W3"
			}, {
				"code_name" : "병반",
				"code_id" : "W4"
			} ];
			
			var columnDefs = [
				{
					pinnedLeft : true,
					displayName : '연도',
					field : 'BASE_YYYY',
					width : '75',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					pinnedLeft : true,
					displayName : '날짜',
					field : 'BASE_YYYYMMDD',
					width : '75',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					pinnedLeft : true,
					displayName : '업체코드',
					field : 'VENDOR_CODE',
					width : '75',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					pinnedLeft : true,
					displayName : '계약코드',
					field : 'CONTRACT_CODE',
					width : '75',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					pinnedLeft : true,
					displayName : '계약명',
					field : 'CONTRACT_NAME',
					width : '300',
					visible : true,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '근무조',
					field : 'WORKTYPE_CODE',
					width : '85',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : 
						'<select ng-if="row.entity.DATA_TYPE == \'M\'" class="ui-grid-template ui-grid-custom-select" style="width:100%; min-width: fit-content; height: 100% !important;" ng-model="row.entity.WORKTYPE_CODE">' + 
						'	<option ng-repeat="SB_WORKTYPE_CODE in grid.appScope.SB_WORKTYPE_CODE" ng-selected="row.entity.WORKTYPE_CODE == SB_WORKTYPE_CODE.code_id" value="{{SB_WORKTYPE_CODE.code_id}}" >{{SB_WORKTYPE_CODE.code_name}}</option>' + 
						'</select>' + 
						'<select ng-if="row.entity.DATA_TYPE != \'M\'" class="ui-grid-template ui-grid-custom-select" style="width:100%; min-width: fit-content; height: 100% !important;" ng-model="row.entity.WORKTYPE_CODE" disabled="disabled">' + 
						'	<option ng-repeat="SB_WORKTYPE_CODE in grid.appScope.SB_WORKTYPE_CODE" ng-selected="row.entity.WORKTYPE_CODE == SB_WORKTYPE_CODE.code_id" value="{{SB_WORKTYPE_CODE.code_id}}" >{{SB_WORKTYPE_CODE.code_name}}</option>' + 
						'</select>'
				}, {
					displayName : '도급관리번호PK',
					field : 'SUBC_CODE_PK',
					width : '10',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '도급관리번호',
					field : 'SUBC_CODE',
					width : '125',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '작업자',
					field : 'SUBC_NAME',
					width : '105',
					visible : true,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : 
						'<div ng-if="row.entity.DATA_TYPE == \'M\'" class="ui-grid-cell-contents ng-binding ng-scope">{{row.entity.SUBC_NAME}}<img src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.PopWorker(row)" style="float: right;"></div>' + 
						'<div ng-if="row.entity.DATA_TYPE != \'M\'" class="ui-grid-cell-contents ng-binding ng-scope">{{row.entity.SUBC_NAME}}</div>'
				}, {
					displayName : '입장일',
					field : 'A_START_DATE',
					width : '115',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : 
						'<input ng-if="row.entity.DATA_TYPE == \'M\'" class="calendar dtp" type="text" ng-model="row.entity.A_START_DATE" style="width: 100%; height: 100% !important;"/>' + 
						'<div ng-if="row.entity.DATA_TYPE != \'M\'" class="ui-grid-cell-contents ng-binding ng-scope">{{row.entity.A_START_DATE}}</div>'
				}, {
					displayName : '입장시간',
					field : 'A_START_DATE_TIME',
					width : '95',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : 
						'<input ng-if="row.entity.DATA_TYPE == \'M\'" type="text" ng-model="row.entity.A_START_DATE_TIME" ng-change="grid.appScope.fn_validate_time(row)" style="width: 100%; height: 100% !important;"/>' + 
						'<div ng-if="row.entity.DATA_TYPE != \'M\'" class="ui-grid-cell-contents ng-binding ng-scope">{{row.entity.A_START_DATE_TIME}}</div>'
				}, {
					displayName : '퇴장일',
					field : 'A_END_DATE',
					width : '115',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : 
						'<input ng-if="row.entity.DATA_TYPE == \'M\'" class="calendar dtp" type="text" ng-model="row.entity.A_END_DATE" style="width: 100%; height: 100% !important;"/>' + 
						'<div ng-if="row.entity.DATA_TYPE != \'M\'" class="ui-grid-cell-contents ng-binding ng-scope">{{row.entity.A_END_DATE}}</div>'
				}, {
					displayName : '퇴장시간',
					field : 'A_END_DATE_TIME',
					width : '95',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : 
						'<input ng-if="row.entity.DATA_TYPE == \'M\'" type="text" ng-model="row.entity.A_END_DATE_TIME" ng-change="grid.appScope.fn_validate_time(row)" style="width: 100%; height: 100% !important;"/>' + 
						'<div ng-if="row.entity.DATA_TYPE != \'M\'" class="ui-grid-cell-contents ng-binding ng-scope">{{row.entity.A_END_DATE_TIME}}</div>'
				}, {
					displayName : '연장',
					field : 'EXTENSION_HOUR',
					width : '75',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '휴일',
					field : 'HOLIDAY_HOUR',
					width : '75',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '야간',
					field : 'NIGHT_HOUR',
					width : '75',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '지각',
					field : 'LATE_HOUR',
					width : '75',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '비고',
					field : 'COMMENTS',
					width : '300',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.COMMENTS" style="width: 100%; height: 100% !important;"/>'
				}, {
					pinnedRight : true,
					displayName : '유형',
					field : 'DATA_TYPE',
					width : '105',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : 
						'<i ng-if="row.entity.DATA_TYPE ==\'A\'" class="far fa-id-card ng-scope" style="font-size: 22px;"></i>' +
						'<i ng-if="row.entity.DATA_TYPE ==\'M\'" class="far fa-keyboard ng-scope" style="font-size: 22px;"></i>'
				}, {
					pinnedRight : true,
					displayName : '저장',
					field : 'DATA_STATUS',
					width : '105',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : 
						'<i ng-if="row.entity.DATA_STATUS ==\'N\'" class="fas fa-check green ng-scope" style="font-size: 22px;"></i>' +
						'<i ng-if="row.entity.DATA_STATUS ==\'Y\'" class="fas fa-times red ng-scope" style="font-size: 22px;"></i>'
				}, {
					pinnedRight : true,
					displayName : '확정',
					field : 'CONFIRM_YN',
					width : '105',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : 
						'<i ng-if="row.entity.CONFIRM_YN ==\'Y\'" class="fas fa-check green ng-scope" style="font-size: 22px;"></i>' +
						'<i ng-if="row.entity.CONFIRM_YN !=\'Y\'" class="fas fa-times red ng-scope" style="font-size: 22px;"></i>'
				}
			];
			
			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바
				showColumnFooter : false,
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
				listQuery : "yp_zwc_ipt2.select_tbl_working_daily_report", //list가져오는 마이바티스 쿼리 아이디
				cntQuery : "yp_zwc_ipt2.select_tbl_working_daily_report_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
			
			// 그리드용 부트스트랩 날짜객체
			$(document).on("focus", ".dtp", function() {
				$(this).datepicker({
					format : "yyyy/mm/dd",
					language : "ko",
					todayHighlight : true,
					autoclose : true,
					clearBtn : true,
					updateViewDate : false
				}).on('changeDate', function(ev) {
					if(ev.viewMode !== "days"){
						return false;
					}
					$(this).val(formatDate_d(ev.date.valueOf())).trigger("change");
					$('.datepicker').hide();
				});
			});
			// 부트스트랩 날짜객체
			$(".search_dtp").datepicker({
				format: "yyyy/mm/dd",
				language : "ko",
				todayHighlight : true,
				autoclose : true,
				clearBtn : true,
				updateViewDate : false
			}).on('changeDate', function(e) {
				if(e.viewMode !== "days"){
					return false;
				}
				$(this).val(formatDate_d(e.date.valueOf())).trigger("change");
// 				$("#search_btn").trigger("click");
				$('.datepicker').hide();
			});
			
			// 계약, 날짜 변경 - 입력화면이기에 데이터가 섞이는 가능성 배제시킴
			$("#CONTRACT_CODE, #BASE_YYYYMMDD").on("change", function() {
				$("#search_btn").trigger("click");
			});
			// 조회
			$("#search_btn").on("click", function() {
				scope.reloadGrid({
					BASE_YYYY : $("#CONTRACT_CODE :selected").data("base-yyyy"),
					BASE_YYYYMMDD : $("#BASE_YYYYMMDD").val().replace(/\//gi, '-'),
					VENDOR_CODE : $("#VENDOR_CODE").val(),
					CONTRACT_CODE : $("#CONTRACT_CODE").val()
				});
			});
			
			// 추가
			$("#fn_add").on("click", function() {
				scope.addRow({
					INSERT_YN : "Y",
					BASE_YYYY : $("#CONTRACT_CODE :selected").data("base-yyyy"),
					BASE_YYYYMMDD : $("#BASE_YYYYMMDD").val().replaceAll(/\//gi, ''),
					VENDOR_CODE : $("#VENDOR_CODE").val(),
					VENDOR_NAME : $("#VENDOR_CODE :selected").text(),
					CONTRACT_CODE : $("#CONTRACT_CODE").val(),
					CONTRACT_NAME : $("#CONTRACT_CODE :selected").text(),
					DATA_STATUS : "Y",
					WORKTYPE_CODE : "",
					WORKTYPE_NAME : "",
					SUBC_CODE_PK : null,
					SUBC_CODE : "",
					SUBC_NAME : "",
					A_START_DATE : "",
					A_START_DATE_TIME : "",
					A_END_DATE : "",
					A_END_DATE_TIME : "",
					EXTENSION_HOUR : "",
					HOLIDAY_HOUR : "",
					NIGHT_HOUR : "",
					LATE_HOUR : "",
					COMMENTS : "",
					DATA_TYPE : "M"
				}, false, "desc");
			});
			
			// 저장
			$("#fn_save").on("click", function() {
				var rows = scope.gridApi.selection.getSelectedRows();
				if(rows.length === 0){
					swalWarningCB("【저장】할 항목을 선택하세요.");
					return false;
				}
				var auto_rows = [];
				var manual_rows = [];
				$.each(rows, function(i, d){
					if(d.DATA_TYPE === "A"){ // 태그데이터
						auto_rows.push(d);
					}else if(d.DATA_TYPE === "M"){ // 추가데이터
						manual_rows.push(d);
					}
				});
				
				if (!fn_validate_save(rows)){
					return false;
				}
				
				swal({
					icon : "info",
					text : "【저장】하시겠습니까?",
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
					if (result) {
						var token = $("meta[name='_csrf']").attr("content");
						var header = $("meta[name='_csrf_header']").attr("content");
						$.ajax({
							url : "/yp/zwc/ipt2/save_tbl_working_daily_report",
							type : "POST",
							cache : false,
							async : true,
							dataType : "json",
							data : {
								auto_rows: JSON.stringify(auto_rows),
								manual_rows: JSON.stringify(manual_rows)
							},
							success : function(result) {
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
								swalDangerCB("【저장】실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
					}
				});
			});
			
			// 삭제
			$("#fn_remove").on("click", function() {
				var all_rows = scope.gridOptions.data;
				var rows = scope.gridApi.selection.getSelectedRows();
				if(rows.length === 0){
					swalWarningCB("【삭제】할 항목을 선택하세요.");
					return false;
				}
				
				var delete_rows = [];
				$.each(rows, function(i, d){
					if(d.DATA_STATUS === "N"){ // delete from db
						delete_rows.push(d);
					}
				});
				
				swal({
					icon : "info",
					text : "【삭제】하시겠습니까?",
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
					if (result) {
						var token = $("meta[name='_csrf']").attr("content");
						var header = $("meta[name='_csrf_header']").attr("content");
						$.ajax({
							url : "/yp/zwc/ipt2/delete_tbl_working_daily_report",
							type : "POST",
							cache : false,
							async : true,
							dataType : "json",
							data : {
								ROW_NO: JSON.stringify(delete_rows)
							},
							success : function(result) {
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
								swalDangerCB("【삭제】실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
					}
				});
			});
			
			// 확정
			$("#fn_confirm").on("click", function() {
				var all_rows = scope.gridOptions.data;
				var rows = scope.gridApi.selection.getSelectedRows();
				if(rows.length === 0){
					swalWarningCB("【확정】할 항목을 선택하세요.");
					return false;
				}
				
				if (!fn_validate_confirm(rows)){
					return false;
				}
				
				// 확정(승인) 가능 여부 확인
				if( !fn_possible(rows) ){
					return false;
				}
				
				swal({
					icon : "info",
					text : "【확정】하시겠습니까?",
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
					if (result) {
						var token = $("meta[name='_csrf']").attr("content");
						var header = $("meta[name='_csrf_header']").attr("content");
						$.ajax({
							url : "/yp/zwc/ipt2/confirm_tbl_working_daily_report",
							type : "POST",
							cache : false,
							async : true,
							dataType : "json",
							data : {
								ROW_NO: JSON.stringify(rows)
							},
							success : function(result) {
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
								swalDangerCB("【확정】실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
					}
				});
			});
		});
		function formatDate_d(date) {
			var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
			if (month.length < 2)
				month = '0' + month;
			if (day.length < 2)
				day = '0' + day;
			return [ year, month, day ].join('/');
		}
		function fn_validate_save(rows){
			var check = true;
			$.each(rows, function(i, d){
				if(d.WORKTYPE_CODE === ""){
					swalWarningCB("근무조를 선택하세요.");
					check = false;
					return false;
				}
				if(d.SUBC_CODE === ""){
					swalWarningCB("작업자를 선택하세요.");
					check = false;
					return false;
				}
				if(d.A_START_DATE === ""){
					swalWarningCB("입장일을 입력하세요.");
					check = false;
					return false;
				}
				if(d.A_START_DATE_TIME === ""){
					swalWarningCB("입장시간을 입력하세요.");
					check = false;
					return false;
				}
				if( !validateHhMm( d.A_START_DATE_TIME ) ){
					check = false;
					return false;
				}
				if(d.A_END_DATE_TIME === ""){
					swalWarningCB("입장시간을 입력하세요.");
					check = false;
					return false;
				}
				if( !validateHhMm( d.A_END_DATE_TIME ) ){
					check = false;
					return false;
				}
				if(isNaN(d.EXTENSION_HOUR)){
					swalWarningCB("입력 내용을 확인해주세요.");
					check = false;
					return false;
				}else{
					d.EXTENSION_HOUR = Number(d.EXTENSION_HOUR);
				}
				if(isNaN(d.HOLIDAY_HOUR)){
					swalWarningCB("입력 내용을 확인해주세요.");
					check = false;
					return false;
				}else{
					d.HOLIDAY_HOUR = Number(d.HOLIDAY_HOUR);
				}
				if(isNaN(d.NIGHT_HOUR)){
					swalWarningCB("입력 내용을 확인해주세요.");
					check = false;
					return false;
				}else{
					d.NIGHT_HOUR = Number(d.NIGHT_HOUR);
				}
				if(isNaN(d.LATE_HOUR)){
					swalWarningCB("입력 내용을 확인해주세요.");
					check = false;
					return false;
				}else{
					d.LATE_HOUR = Number(d.LATE_HOUR);
				}
			});
			return check;
		}
		function fn_validate_confirm(rows){
			var check = true;
			$.each(rows, function(i, d){
				if(d.DATA_STATUS !== "N"){
					swalWarningCB("저장되지 않은 데이터는 확정할 수 없습니다.");
					check = false;
					return false;
				}
			});
			return check;
		}
		/* Validate time format  */
		function validateHhMm(o) {
			var isValid = /^(0[0-9]|1[0-9]|2[0-3]):([0-5][0-9])$/.test(o);
			if (!isValid) {
				swalWarningCB("입력 내용을 확인해주세요.");
			}
			return isValid;
		}
		/*콤마 추가*/
		function addComma(num) {
			return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		}

		/*콤마 제거*/
		function unComma(num) {
			return num.replace(/,/gi, '');
		}
		
		function fnSearchPopup(type) {
			if(type == "1"){
				window.open("", "작업장 검색", "width=600, height=800");
				fnHrefPopup("/yp/popup/zcs/ipt/retrieveVAPLZ", "작업장 검색", {
					type : "C"
				});
			}else if (type == "2") {
				window.open("", "코스트센터 검색", "width=600, height=800");
				fnHrefPopup("/yp/popup/zcs/ipt/retrieveKOSTL_search", "코스트센터 검색", {
					type : "C"
				});
			}
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
		
		// 확정(승인) 가능 여부 확인
		function fn_possible(rows){
			var rt = false;
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				url : "/yp/zwc/ipt2/possible",
				type : "POST",
				cache : false,
				async : false,
				dataType : "json",
				data : {
					  POSSIBLE : "C" /* C : 확정, A : 승인 */
					, ROW_NO: JSON.stringify(rows)
				},
				success : function(data) {
// 					console.log("확정(승인) 가능 여부 확인", data);
					rt = data.possible;
					if( !data.possible ){
						swalWarningCB(data.possible_msg);
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
					swalDangerCB("확정 가능 여부 확인【조회】실패하였습니다.\n관리자에게 문의해주세요.");
				}
			});
			return rt;
		}
	</script>
	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
</body>