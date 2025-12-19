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
						<th>일자</th>
						<td>
							<input type="text" id="BASE_YYYY_S" class="calendar search_dtp" value="${to_yyyy}" readonly="readonly"/>　~　
							<input type="text" id="BASE_YYYY_E" class="calendar search_dtp" value="${to_yyyy}" readonly="readonly"/>
						</td>
						<th>코스트센터</th>
						<td>
							<input type="text" id="KOSTL" size="6"/>
							<a href="#" onclick="fnSearchPopup('2');"><img src="/resources/yp/images/ic_search.png"></a>
							<input type="text" id="KTEXT" disabled="disabled"/>
						</td>
						<th>계약명</th>
						<td>
							<select id="CONTRACT_CODE">
								<option value="" data-base-yyyy="">전체</option>
								<c:forEach var="row" items="${cb_tbl_working_subc}" varStatus="status">
									<option value="${row.CODE}" data-base-yyyy="${row.BASE_YYYY}">${row.CODE_NAME}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>부서명</th>
						<td>
							<c:choose>
								<c:when test="${'CA' eq sessionScope.WC_AUTH || 'SA' eq sessionScope.WC_AUTH || 'MA' eq sessionScope.WC_AUTH || 'WM' eq sessionScope.WC_AUTH}">
									<select id="DEPT_CODE">
										<option value="" selected="selected">-전체-</option>
										<c:forEach var="t" items="${teamList}" varStatus="status">
											<option value="${t.OBJID}">${t.STEXT}</option>
										</c:forEach>
									</select>
								</c:when>
								<c:otherwise>
									<input type="hidden" id="DEPT_CODE" value="${orgeh}">
<%-- 									<input type="hidden" id="DEPT_CODE" value="${sessionScope.userDeptCd}"> --%>
									<input type="text" value="${sessionScope.userDept}" readonly="readonly">
								</c:otherwise>
							</c:choose>
						</td>
						<th>거래처</th>
						<td colspan="3">
							<select id="VENDOR_CODE">
								<option value="">전체</option>
								<c:forEach var="row" items="${cb_working_master_v}" varStatus="status">
									<option value="${row.CODE}">${row.CODE_NAME}</option>
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
		<div class="fl">
			<div class="btn_wrap">
				※【계약명】을 클릭하면 해당일의 상세정보가 두 번째 그리드에 조회됩니다.  ※【근무】가 『휴일』상태면 저장시 투입공수, 실공수, 작업량이 『0』으로 저장됩니다.
			</div>
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<c:if test="${'SA' eq sessionScope.WC_AUTH || 'MA' eq sessionScope.WC_AUTH || 'TM' eq sessionScope.WC_AUTH || 'CA' eq sessionScope.WC_AUTH}">
				<input type=button class="btn_g" id="tlc_y"	value="팀장승인">
				<input type=button class="btn_g" id="tlc_n"	value="승인취소">
				</c:if>
				<input type=button class="btn_g" id="fnSave_daily_report"	value="저장">
			</div>
		</div>
	</div>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="shdsCtrl">
			<div data-ui-i18n="ko" style="height: 300px;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter ui-grid-pinning>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
	</section>
	<div class="float_wrap" style="margin-bottom: 2px; margin-top: -20px;">
		<div class="fl">
			<div class="btn_wrap">
				&nbsp;
			</div>
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type=button class="btn_g" id="fnSave_daily_report_dt"	value="저장">
			</div>
		</div>
	</div>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid-2" data-ng-controller="shdsCtrlDt">
			<div data-ui-i18n="ko" style="height: 260px;">
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

			// 작업구분 콤보
			$scope.SB_GUBUN = [
				{
					"code_id" : "0",
					"code_name" : "근무"
				}, {
					"code_id" : "1",
					"code_name" : "휴일"
				}
			];
			
			var columnDefs = [
				{
					displayName : '연도',
					field : 'BASE_YYYY',
					width : '75',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '일자',
					field : 'BASE_YYYYMMDD_VIEW',
					width : '75',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_date(row.entity.BASE_YYYYMMDD_VIEW)}}</div>'
				}, {
					displayName : '근무',
					field : 'GUBUN',
					width : '75',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : 
						'<div ng-if="row.entity.TEAM_LEADER_CONFIRM == \'Y\' && row.entity.GUBUN == \'0\'" class="ui-grid-cell-contents">근무</div>' + 
						'<div ng-if="row.entity.TEAM_LEADER_CONFIRM == \'Y\' && row.entity.GUBUN == \'1\'" class="ui-grid-cell-contents">휴일</div>' + 
						'<select ng-if="row.entity.TEAM_LEADER_CONFIRM != \'Y\'" ng-model="row.entity.GUBUN" style="width: 100%; padding: 0; min-width: 0;" >' + 
						'	<option ng-repeat="SB_GUBUN in grid.appScope.SB_GUBUN" ng-selected="row.entity.GUBUN == SB_GUBUN.code_id" value="{{SB_GUBUN.code_id}}" >{{SB_GUBUN.code_name}}</option>' + 
						'</select>'
				}, {
					displayName : '일자_데이터',
					field : 'BASE_YYYYMMDD',
					width : '75',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '거래처',
					field : 'VENDOR_CODE',
					width : '75',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '거래처명',
					field : 'VENDOR_NAME',
					width : '110',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '계약코드',
					field : 'CONTRACT_CODE',
					width : '75',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '계약명',
					field : 'CONTRACT_NAME',
// 					width : '170',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-model="row.entity.CONTRACT_NAME" style="text-decoration: underline; font-weight: bold; cursor: pointer;" ng-click="grid.appScope.fn_SELECT_DT(row)">{{row.entity.CONTRACT_NAME}}</div>',
					footerCellTemplate: '<div class="ui-grid-cell-contents center">합 계</div>'
				}, {
					displayName : '조업',
					field : 'WORKING_GUBUN',
					width : '75',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '구분코드',
					field : 'GUBUN_CODE',
					width : '75',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '구분',
					field : 'GUBUN_NAME',
					width : '75',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '단위',
					field : 'UNIT_CODE',
					width : '75',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '단위',
					field : 'UNIT_NAME',
					width : '75',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '연장',
					field : 'EXTENSION_HOUR',
					width : '75',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : 
						'<input type="text" ng-if="row.entity.TEAM_LEADER_CONFIRM != \'Y\'" class="ng-scope" ng-model="row.entity.EXTENSION_HOUR" style="width: 100%; height: 100% !important; text-align: center;"/>'+
						'<div ng-if="row.entity.TEAM_LEADER_CONFIRM == \'Y\'" class="ui-grid-cell-contents" ng-model="row.entity.EXTENSION_HOUR" >{{row.entity.EXTENSION_HOUR}}</div>',
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents center">{{col.getAggregationValue()}}</div>'
				}, {
					displayName : '야간',
					field : 'NIGHT_HOUR',
					width : '75',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : 
						'<input type="text" ng-if="row.entity.TEAM_LEADER_CONFIRM != \'Y\'" class="" ng-model="row.entity.NIGHT_HOUR" style="width: 100%; height: 100% !important; text-align: center;"/>'+
						'<div ng-if="row.entity.TEAM_LEADER_CONFIRM == \'Y\'" class="ui-grid-cell-contents" ng-model="row.entity.NIGHT_HOUR" >{{row.entity.NIGHT_HOUR}}</div>',
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents center">{{col.getAggregationValue()}}</div>'
				}, {
					displayName : '토요',
					field : 'SATURDAY_HOUR',
					width : '75',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : 
						'<input type="text" ng-if="row.entity.TEAM_LEADER_CONFIRM != \'Y\'" class="" ng-model="row.entity.SATURDAY_HOUR" style="width: 100%; height: 100% !important; text-align: center;"/>'+
						'<div ng-if="row.entity.TEAM_LEADER_CONFIRM == \'Y\'" class="ui-grid-cell-contents" ng-model="row.entity.SATURDAY_HOUR" >{{row.entity.SATURDAY_HOUR}}</div>',
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents center">{{col.getAggregationValue()}}</div>'
	 			}, {
					displayName : '휴일',
					field : 'HOLIDAY_HOUR',
					width : '75',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : 
						'<input type="text" ng-if="row.entity.TEAM_LEADER_CONFIRM != \'Y\'" class="" ng-model="row.entity.HOLIDAY_HOUR" style="width: 100%; height: 100% !important; text-align: center;"/>'+
						'<div ng-if="row.entity.TEAM_LEADER_CONFIRM == \'Y\'" class="ui-grid-cell-contents" ng-model="row.entity.HOLIDAY_HOUR" >{{row.entity.HOLIDAY_HOUR}}</div>',
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents center">{{col.getAggregationValue()}}</div>'
				}, {
					displayName : '투입공수',
					field : 'MANHOUR',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents center">{{col.getAggregationValue()}}</div>'
				}, {
					displayName : '실공수',
					field : 'COLLECTION_MANHOUR',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents center">{{col.getAggregationValue()}}</div>'
				}, {
					displayName : '작업량(생산량)',
					field : 'WORKLOAD',
					width : '150',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.WORKLOAD)}}</div>',
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents center">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
				}, {
					displayName : '팀장확인',
					field : 'TEAM_LEADER_CONFIRM',
					width : '95',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '팀장확인',
					field : 'TEAM_LEADER_CONFIRM',
					width : '95',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : 
						'<div ng-if="row.entity.TEAM_LEADER_CONFIRM == \'Y\'" class="ui-grid-cell-contents">승인</div>'+
						'<div ng-if="row.entity.TEAM_LEADER_CONFIRM == \'N\'" class="ui-grid-cell-contents">미승인</div>'+
						'<div ng-if="row.entity.TEAM_LEADER_CONFIRM == null" class="ui-grid-cell-contents"></div>'
// 						'<div style="margin: 1px 0;"><input type="button" class="btn_g tlc_single" value="확인" ng-if="row.entity.TEAM_LEADER_CONFIRM == \'N\'" style="border-radius: 3px; display: inline-block; border: 1px solid #626262; padding: 3px 10px 4px 10px; cursor: pointer; color: #fff; font-weight: 100; font-size: 12px; vertical-align: middle; width: auto;"'+
// 							'data-base-yyyy="{{row.entity.BASE_YYYY}}"' +
// 							'data-contract-code="{{row.entity.CONTRACT_CODE}}"' +
// 							'data-vendor-code="{{row.entity.VENDOR_CODE}}"' +
// 							'data-base-yyyymmdd="{{row.entity.BASE_YYYYMMDD}}"' +
// 							'data-team-leader-confirm-str="Y"' +
// 						'/></div>' +
// 						'<div style="margin: 1px 0;"><input type="button" class="btn_g tlc_single" value="취소" ng-if="row.entity.TEAM_LEADER_CONFIRM == \'Y\'" style="border-radius: 3px; display: inline-block; border: 1px solid #626262; padding: 3px 10px 4px 10px; cursor: pointer; color: #fff; font-weight: 100; font-size: 12px; vertical-align: middle; width: auto;"'+
// 							'data-base-yyyy="{{row.entity.BASE_YYYY}}"' +
// 							'data-contract-code="{{row.entity.CONTRACT_CODE}}"' +
// 							'data-vendor-code="{{row.entity.VENDOR_CODE}}"' +
// 							'data-base-yyyymmdd="{{row.entity.BASE_YYYYMMDD}}"' +
// 							'data-team-leader-confirm-str="N"' +
// 						'/></div>'
				}
			];
			// 계약명 클릭
			$scope.fn_SELECT_DT = function(row) {
				scope2.reloadGrid({
					BASE_YYYYMMDD : row.entity.BASE_YYYYMMDD_VIEW,
					BASE_YYYY : row.entity.BASE_YYYY,
					VENDOR_CODE : row.entity.VENDOR_CODE,
					CONTRACT_CODE : row.entity.CONTRACT_CODE,
					WORKING_GUBUN : row.entity.WORKING_GUBUN,
					GUBUN_CODE : row.entity.GUBUN_CODE
				});
			}
			
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
		//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
		app.controller('shdsCtrlDt', [ '$scope', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
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

			var columnDefs = [
				{
					displayName : '연도',
					field : 'BASE_YYYY',
					width : '75',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '일자',
					field : 'BASE_YYYYMMDD',
					width : '75',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_date(row.entity.BASE_YYYYMMDD)}}</div>'
				}, {
					displayName : '계약명',
					field : 'CONTRACT_NAME',
// 					width : '170',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
				}, {
					displayName : '거래처',
					field : 'VENDOR_CODE',
					width : '75',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '계약코드',
					field : 'CONTRACT_CODE',
					width : '75',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '근무형태코드',
					field : 'WORKTYPE_CODE',
					width : '75',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '근무형태',
					field : 'WORKTYPE_NAME',
					width : '150',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '근무자',
					field : 'WORKER',
					width : '75',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '근무자_DT',
					field : 'WORKER_DT',
					width : '75',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '공수',
					field : 'MANHOUR',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '보정공수',
					field : 'COLLECTION_MANHOUR',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : 
						'<input type="text" ng-if="row.entity.TEAM_LEADER_CONFIRM != \'Y\'" class="" ng-model="row.entity.COLLECTION_MANHOUR" style="width: 100%; height: 100% !important; text-align: center;"/>' +
						'<div ng-if="row.entity.TEAM_LEADER_CONFIRM == \'Y\'" class="ui-grid-cell-contents" ng-model="row.entity.COLLECTION_MANHOUR" >{{row.entity.COLLECTION_MANHOUR}}</div>'
				}, {
					displayName : '작업량(생산량)',
					field : 'WORKLOAD',
					width : '150',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : 
						'<input type="text" ng-if="row.entity.TEAM_LEADER_CONFIRM != \'Y\'" class="" ng-model="row.entity.WORKLOAD" style="width: 100%; height: 100% !important; text-align: center;"/>' +
						'<div ng-if="row.entity.TEAM_LEADER_CONFIRM == \'Y\'" class="ui-grid-cell-contents" ng-model="row.entity.WORKLOAD" >{{row.entity.WORKLOAD}}</div>'
				}, {
					displayName : '내역',
					field : 'NOTE',
					width : '300',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : 
						'<input type="text" ng-if="row.entity.TEAM_LEADER_CONFIRM != \'Y\'" class="" ng-model="row.entity.NOTE" style="width: 100%; height: 100% !important;"/>' +
						'<div ng-if="row.entity.TEAM_LEADER_CONFIRM == \'Y\'" class="ui-grid-cell-contents" ng-model="row.entity.NOTE" >{{row.entity.NOTE}}</div>'
				}
			];
			
			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바
				
				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 100,

				enableCellEditOnFocus : true, //셀 클릭시 edit모드 
				enableSelectAll : false, //전체선택 체크박스
				enableRowSelection : false, //로우 선택
				enableRowHeaderSelection : false, //맨앞 컬럼 체크박스 컬럼으로
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
		var scope2;
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
				listQuery : "yp_zwc_ipt.select_tbl_working_daily_report", //list가져오는 마이바티스 쿼리 아이디
				cntQuery : "yp_zwc_ipt.select_tbl_working_daily_report_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
			
			// 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
			scope2 = angular.element(document.getElementById("shds-uiGrid-2")).scope(); //html id를 통해서 controller scope(this) 가져옴
			scope2.gridApi.selection.on.rowSelectionChanged(scope2, function(row) { //로우 선택할때마다 이벤트
				// console.log("row2", row.entity);
			});
			scope2.gridApi.selection.on.rowSelectionChangedBatch(scope2, function(rows) { //전체선택시 가져옴
				// console.log("row3", rows[0].entity); //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
			});
			// pagenation option setting  그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param2 = {
				listQuery : "yp_zwc_ipt.select_tbl_working_daily_report_dt", //list가져오는 마이바티스 쿼리 아이디
				cntQuery : "yp_zwc_ipt.select_tbl_working_daily_report_dt_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
			};
			scope2.paginationOptions = customExtend(scope2.paginationOptions, param2); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
			
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
			
			// 이벤트(변경) - 거래처
			$("#VENDOR_CODE").on("change", function() {
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					url : "/yp/zwc/ipt/select_cb_tbl_working_subc",
					type : "POST",
					cache : false,
					async : true,
					dataType : "json",
					data : {
						VENDOR_CODE: $(this).val(),
						BASE_YYYY: $("#BASE_YYYY_S").val().substr(0,4)
					},
					success : function(data) {
						$("#CONTRACT_CODE option:not(option:eq(0))").remove();
						$.each(data.result, function(i, d){
							$("#CONTRACT_CODE").append("<option value='" + d.CODE + "' data-base-yyyy='" + d.BASE_YYYY + "'>" + d.CODE_NAME + "</option>");
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
						swalDangerCB("조회 실패하였습니다.\n관리자에게 문의해주세요.");
					}
				});
			});
			
			// 조회
			$("#search_btn").on("click", function() {
				scope.reloadGrid({
					BASE_YYYY_S : $("#BASE_YYYY_S").val(),
					BASE_YYYY_E : $("#BASE_YYYY_E").val(),
					VENDOR_CODE : $("#VENDOR_CODE").val(),
					CONTRACT_CODE : $("#CONTRACT_CODE").val(),
					DEPT_CODE : $("#DEPT_CODE").val(),
					COST_CODE : $("#KOSTL").val(),
					BASE_YYYY : $("#CONTRACT_CODE :selected").data("base-yyyy")
				});
				// 내용 변경시 일보상세 그리드 초기화 - 저장, 팀장확
				scope2.gridOptions.data = [];
				scope2.gridApi.grid.refresh();
			});
			
			// 팀장확인, 취소 - 단일
			$(document).on("click", ".tlc_single", function() {
				if("${sessionScope.WC_AUTH}" === "TM" || "${sessionScope.WC_AUTH}" === "MA" || "${sessionScope.WC_AUTH}" === "CA" || "${sessionScope.WC_AUTH}" === "SA"){
					;
				}else{
					swalWarningCB("해당권한이 없습니다.");
					return false;
				}
				
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				var rows = [{
						BASE_YYYY: $(this).data("base-yyyy"),
						CONTRACT_CODE: $(this).data("contract-code"),
						VENDOR_CODE: $(this).data("vendor-code"),
						BASE_YYYYMMDD: $(this).data("base-yyyymmdd"),
						TEAM_LEADER_CONFIRM_STR: $(this).data("team-leader-confirm-str"),
				}];
				$.ajax({
					url : "/yp/zwc/ipt/update_tbl_working_daily_report_tlc",
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
						swalDangerCB("저장 실패하였습니다.\n관리자에게 문의해주세요.");
					}
				});
			});
			
			// 팀장확인 - 일괄
			$("#tlc_y").on("click", function() {
				if("${sessionScope.WC_AUTH}" === "TM" || "${sessionScope.WC_AUTH}" === "MA" || "${sessionScope.WC_AUTH}" === "CA" || "${sessionScope.WC_AUTH}" === "SA"){
					;
				}else{
					swalWarningCB("해당권한이 없습니다.");
					return false;
				}
				
				var rows = scope.gridApi.selection.getSelectedRows();
				if(rows.length === 0){
					swalWarningCB("저장할 항목을 선택하세요.");
					return false;
				}
				var bool = false;
				$.each(rows, function(i, d){
					// 2021-05-03 jamerl - 조용래 : 실공수와 작업량(생산량) 모두 0인 경우에만 미등록건 알림 메세지 처리
					if(d.GUBUN_ORI === "0" && ( Number( d.COLLECTION_MANHOUR ) === 0 && Number( d.WORKLOAD ) === 0)){
					//if(d.GUBUN_ORI === "0" && ( Number( d.COLLECTION_MANHOUR ) === 0 || Number( d.WORKLOAD ) === 0)){
						// 2021-03-29 jamerl - 조용래 : 단위가 인/공( U7/U8 ) 계약은 팀장승인이 가능하도록 요청
						if(d.UNIT_CODE !== "U7" && d.UNIT_CODE !== "U8"){
							swalWarningCB("미등록 건이 있습니다.");
							bool = true;
							return false;
						}
					}
				});
				if(bool){
					return false;
				}
				
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					url : "/yp/zwc/ipt/update_tbl_working_daily_report_tlc_y",
					type : "POST",
					cache : false,
					async : true,
					dataType : "json",
					data : {
						ROW_NO: JSON.stringify(rows)
					},
					success : function(data) {
						if(data.result === -99){
							swalWarningCB("도급월보 전자결재가 진행 혹은 완료되어 팀장승인 할 수 없습니다.");
							return false;
						}
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
						swalDangerCB("저장 실패하였습니다.\n관리자에게 문의해주세요.");
					}
				});
			});
			
			// 팀장취소 - 일괄
			$("#tlc_n").on("click", function() {
				if("${sessionScope.WC_AUTH}" === "TM" || "${sessionScope.WC_AUTH}" === "MA" || "${sessionScope.WC_AUTH}" === "CA" || "${sessionScope.WC_AUTH}" === "SA"){
					;
				}else{
					swalWarningCB("해당권한이 없습니다.");
					return false;
				}
				
				var rows = scope.gridApi.selection.getSelectedRows();
				if(rows.length === 0){
					swalWarningCB("저장할 항목을 선택하세요.");
					return false;
				}
				var bool = false;
				$.each(rows, function(i, d){
					if(d.TEAM_LEADER_CONFIRM !== "Y"){
						swalWarningCB("승인상태가 아닙니다.");
						bool = true;
						return false;
					}
				});
				if(bool){
					return false;
				}
				if(!confirm("승인취소시 도급월보 집계 데이터가 삭제됩니다.\n승인취소 하시겠습니까?")){
					return false;
				}
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					url : "/yp/zwc/ipt/update_tbl_working_daily_report_tlc_n",
					type : "POST",
					cache : false,
					async : true,
					dataType : "json",
					data : {
						ROW_NO: JSON.stringify(rows)
					},
					success : function(data) {
						if(data.result === -99){
							swalWarningCB("도급월보 전자결재가 진행 혹은 완료되어 승인취소 할 수 없습니다.");
							return false;
						}
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
						swalDangerCB("저장 실패하였습니다.\n관리자에게 문의해주세요.");
					}
				});
			});
			
			// 저장 - 마스터
			$("#fnSave_daily_report").on("click", function() {
				var rows = scope.gridApi.selection.getSelectedRows();
				if(rows.length === 0){
					swalWarningCB("저장할 항목을 선택하세요.");
					return false;
				}
				if (!fnValidation(rows)){
					return false;
				}
				
				if (confirm("저장하시겠습니까?")) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zwc/ipt/merge_tbl_working_daily_report",
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
							swalDangerCB("저장 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
				}
			});
			
			// 저장 - 상세
			$("#fnSave_daily_report_dt").on("click", function() {
				var rows = scope2.gridOptions.data;
// 				var rows = scope2.gridApi.selection.getSelectedRows();
// 				if(rows.length === 0){
// 					swalWarningCB("저장할 항목을 선택하세요.");
// 					return false;
// 				}
				if (!fnValidation2(rows)){
					return false;
				}else{
					var data;
					$.each(rows, function(i, d){
						if(isNaN(d.COLLECTION_MANHOUR)){
							swalWarningCB("입력 내용을 확인해주세요.");
							check = false;
							return false;
						}else{
// 							if(Number(d.COLLECTION_MANHOUR) % 1 === 0){
// 								d.COLLECTION_MANHOUR = Number(d.COLLECTION_MANHOUR) + ".0";
// 							}else{
// 								d.COLLECTION_MANHOUR = Number(d.COLLECTION_MANHOUR) + "";
// 							}
						}
						if(isNaN(d.WORKLOAD)){
							swalWarningCB("입력 내용을 확인해주세요.");
							check = false;
							return false;
						}else{
							if(Number(d.WORKLOAD) % 1 === 0){
								d.WORKLOAD = Number(d.WORKLOAD) + ".0";
							}else{
								d.WORKLOAD = Number(d.WORKLOAD) + "";
							}
						}
					});
					data = rows;
					console.log(data);
				}
				if (confirm("저장하시겠습니까?")) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zwc/ipt/merge_tbl_working_daily_report_dt",
						type : "POST",
						cache : false,
						async : true,
						dataType : "json",
						data : {
							ROW_NO: JSON.stringify(rows)
						},
						success : function(data) {
							if(data.result === -1){
								swalWarningCB("상세정보를 저장 할 마스터정보를 먼저 저장해 주세요.");
							} else {
								$("#search_btn").trigger("click");
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
							swalDangerCB("저장 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
				}
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
		function fnValidation(rows){
			var check = true;
			$.each(rows, function(i, d){
				if(isNaN(d.NIGHT_HOUR)){
					swalWarningCB("입력 내용을 확인해주세요.");
					check = false;
					return false;
				}else{
					d.NIGHT_HOUR = Number(d.NIGHT_HOUR);
				}
				if(isNaN(d.EXTENSION_HOUR)){
					swalWarningCB("입력 내용을 확인해주세요.");
					check = false;
					return false;
				}else{
					d.EXTENSION_HOUR = Number(d.EXTENSION_HOUR);
				}
				if(isNaN(d.SATURDAY_HOUR)){
					swalWarningCB("입력 내용을 확인해주세요.");
					check = false;
					return false;
				}else{
					d.SATURDAY_HOUR = Number(d.SATURDAY_HOUR);
				}
				if(isNaN(d.HOLIDAY_HOUR)){
					swalWarningCB("입력 내용을 확인해주세요.");
					check = false;
					return false;
				}else{
					d.HOLIDAY_HOUR = Number(d.HOLIDAY_HOUR);
				}
				/* 특정상황 예외로 인한 주석처리 21.07.02
				if(d.SATURDAY_HOUR > 0 && d.HOLIDAY_HOUR > 0){
					swalWarningCB("토요, 휴일 중 하나만 입력해주세요.");
					check = false;
					return false;
				}*/
			});
			return check;
		}
		function fnValidation2(rows){
			var check = true;
			$.each(rows, function(i, d){
				if(isNaN(d.COLLECTION_MANHOUR)){
					swalWarningCB("입력 내용을 확인해주세요.");
					check = false;
					return false;
				}
				if(d.WORKLOAD === null || d.WORKLOAD === ""){
					swalWarningCB("작업량을 입력해주세요.");
					check = false;
					return false;
				}
				if(isNaN(d.WORKLOAD)){
					swalWarningCB("입력 내용을 확인해주세요.");
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
	</script>
	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
</body>