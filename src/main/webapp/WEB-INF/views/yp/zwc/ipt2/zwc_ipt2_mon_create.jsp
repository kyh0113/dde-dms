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
<title>월보 등록</title>
</head>
<body>
	<!-- 20191023_khj for csrf -->
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<h2>
		월보 등록
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
						<th>검수년월</th>
						<td>
							<input type="text" id="BASE_YYYY" class="calendar search_dtp" value="${to_yyyy}" readonly="readonly"/>
						</td>
						<th>부서명</th>
						<td>
							<c:choose>
								<%-- 2020-11-23 jamerl - 조용래 : 시스템권한 CA 전체 추가 --%>
								<c:when test="${'SA' eq sessionScope.WC_AUTH || 'MA' eq sessionScope.WC_AUTH || 'WM' eq sessionScope.WC_AUTH || 'CA' eq sessionScope.WC_AUTH}">
									<select id="DEPT_CODE">
<!-- 										<option value="" selected="selected">-전체-</option> -->
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
						<td>
							<select id="VENDOR_CODE">
								<option value="" selected="selected">-전체-</option>
								<c:forEach var="row" items="${cb_working_master_v}" varStatus="status">
									<option value="${row.CODE}">${row.CODE_NAME}</option>
								</c:forEach>
							</select>
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
				※지급액 계산은 <span style="background-color: #ffcc66;">　　　</span> 색상의 영역(변경물량, 보상률, 추가금, 패널티)에서 엔터키를 누르세요.
			</div>
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<span id="STATUS_VIEW" style="display: none; border: 1px solid #626262; padding: 1px 10px 2PX; font-size: 12px; vertical-align: middle; color: #000;"></span>
				<input type=button class="btn_g" id="fnApp"	value="전자결재">
				<c:if test="${'MA' eq sessionScope.s_authogrp_code || 'CA' eq sessionScope.s_authogrp_code}">
				<input type="button" class="btn_g" id="fnReset"	value="전자결재 초기화">
				</c:if>
				<input type=button class="btn_g" id="fnIns"	value="집계후 저장">
				<input type=button class="btn_g" id="fnCalc"	value="지급액 산출">
<!-- 				<input type=button class="btn_g" id="fnMod"	value="저장"> -->
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
		app.controller('shdsCtrl', [ '$scope', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
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
			
			// formater - 천단위 콤마
			$scope.formatter_decimal = function(str) {
				if (str === "" || str === null) {
					return str;
				} else if (!isNaN(Number(str))) {
					return Number(str).toLocaleString();
				} else {
					return str;
				}
			};
			
			// formater - 전자결재여부
			$scope.formatter_yn = function(str) {
				if (str === "Y") {
					return "◎";
				}else{
					return "";
				}
			};
			
			// 변경물량
			var QUANTITY_CHANGED = '<div ng-if="row.entity.GUBUN_CODE != \'1\'" class="ui-grid-cell-contents" ng-model="row.entity.QUANTITY_CHANGED" >{{row.entity.QUANTITY_CHANGED}}</div>';
			var QUANTITY_CHANGED_MOD = '<input ng-if="row.entity.GUBUN_CODE == \'1\'" type="text" ng-model="row.entity.QUANTITY_CHANGED" style="height: 100%; width: 100%; text-align: right; background-color: #ffcc66;" ng-keyup="grid.appScope.fn_quantity_changed(row, $event)">';
			
			// 변경물량 이벤트
			$scope.fn_quantity_changed = function(row, e) {
				if (e.which == 13) {
					var data = row.entity;
					
					// 2020-11-09 jamerl - 조용래 : 변경물량 변경이 되어도 보상률 자동계산 및 보상금액 자동 계산기능 제거
					/*
					if (row.entity.GUBUN_CODE == "1") {
						row.entity.QUANTITY_CHANGED = Number(row.entity.QUANTITY_CHANGED);
						if(row.entity.QUANTITY_CHANGED / row.entity.MONTH_STANDARD_AMOUNT * 100 < 95){
							row.entity.REWARD_RATE = 95;
							row.entity.REWARD_AMOUNT = (row.entity.MONTH_STANDARD_AMOUNT * 95 / 100 - row.entity.QUANTITY_CHANGED) * row.entity.UNIT_PRICE;
						}else{
							row.entity.REWARD_RATE = null;
							row.entity.REWARD_AMOUNT = null;
						}
					}
					*/
					
					// 2020-10-21 jamerl - 실적물량(집계)값 변경시 월도급비 재계산
					row.entity.SUBCONTRACTING_COST = roundXL(Number(row.entity.UNIT_PRICE) * Number(row.entity.QUANTITY_CHANGED), 0);
					
					// 2021-03-03 jamerl - 조용래 : 지급액 재계산은 별도의 버튼 이벤트를 통해 산출하도록 변경
					/*
					row.entity.PAY_AMOUNT = roundXL(
						row.entity.SUBCONTRACTING_COST + 
						row.entity.EXTENSION_AMOUNT + 
						row.entity.NIGHT_AMOUNT + 
						row.entity.SATURDAY_AMOUNT + 
						row.entity.HOLIDAY_AMOUNT + 
						(row.entity.REWARD_AMOUNT === null ? 0 : Number(row.entity.REWARD_AMOUNT)) + 
						(row.entity.ADDITIONAL_AMOUNT === null ? 0 : Number(row.entity.ADDITIONAL_AMOUNT.toString().replace(/[^0-9]/g, ''))) - 
						(row.entity.PENALTY_AMOUNT === null ? 0 : Number(row.entity.PENALTY_AMOUNT.toString().replace(/[^0-9]/g, '')))
					, 0);
					*/
				}else{
					// row.entity.QUANTITY_CHANGED = Number(row.entity.QUANTITY_CHANGED.toString().replace(/[^0-9]/g, ''));
					// 2020-12-07 jamerl - 조용래 : 소수점 입력가능
					row.entity.QUANTITY_CHANGED = unComma(row.entity.QUANTITY_CHANGED.toString());
				}
				scope.gridApi.grid.refresh();
			}
			
			// 보상률
			var REWARD_RATE = '<div ng-if="row.entity.GUBUN_CODE != \'1\'" class="ui-grid-cell-contents" ng-model="row.entity.REWARD_RATE" >{{row.entity.REWARD_RATE}}</div>';
			var REWARD_RATE_MOD = '<input ng-if="row.entity.GUBUN_CODE == \'1\'" type="text" ng-model="row.entity.REWARD_RATE" style="height: 100%; width: 100%; text-align: center; background-color: #ffcc66;" ng-keyup="grid.appScope.fn_calc(row, $event)">';
			
			// 보상금
			var REWARD_AMOUNT = '<div ng-if="row.entity.GUBUN_CODE != \'1\'" class="ui-grid-cell-contents" ng-model="row.entity.REWARD_AMOUNT" >{{grid.appScope.formatter_decimal(row.entity.REWARD_AMOUNT)}}</div>';
// 			var REWARD_AMOUNT_MOD = '<input ng-if="row.entity.GUBUN_CODE == \'1\'" type="text" ng-model="row.entity.REWARD_AMOUNT" style="height: 100%; width: 100%; text-align: right;" ng-keyup="grid.appScope.fn_calc(row, $event)" on-model-change="grid.appScope.fn_reward_amount_change(row)" readonly="readonly">';
			var REWARD_AMOUNT_MOD = '<div ng-if="row.entity.GUBUN_CODE == \'1\'" class="ui-grid-cell-contents" ng-model="row.entity.REWARD_AMOUNT" >{{grid.appScope.formatter_decimal(row.entity.REWARD_AMOUNT)}}</div>';
			
			// 보상사유
			var REWARD_REASON = '<div ng-if="row.entity.GUBUN_CODE != \'1\'" class="ui-grid-cell-contents" ng-model="row.entity.REWARD_REASON" >{{row.entity.REWARD_REASON}}</div>';
			var REWARD_REASON_MOD = '<input ng-if="row.entity.GUBUN_CODE == \'1\'" type="text" ng-model="row.entity.REWARD_REASON" style="height: 100%; width: 100%;">';
			
			// 보상률 이벤트
			$scope.fn_calc = function(row, e) {
				if (e.which == 13) {
					var data = row.entity;
					if (row.entity.GUBUN_CODE == "1") {
						var target = Number(row.entity.QUANTITY_CHANGED) === 0 ? Number(row.entity.QUANTITY) : Number(row.entity.QUANTITY_CHANGED);
						if(target / row.entity.MONTH_STANDARD_AMOUNT * 100 < row.entity.REWARD_RATE){
							row.entity.REWARD_AMOUNT = roundXL((row.entity.MONTH_STANDARD_AMOUNT * row.entity.REWARD_RATE / 100 - target) * row.entity.UNIT_PRICE, 0);
						}else{
							row.entity.REWARD_RATE = null;
							row.entity.REWARD_AMOUNT = null;
						}
						// 2021-03-03 jamerl - 조용래 : 지급액 재계산은 별도의 버튼 이벤트를 통해 산출하도록 변경
						/*
						row.entity.PAY_AMOUNT = roundXL(
							row.entity.SUBCONTRACTING_COST + 
							row.entity.EXTENSION_AMOUNT + 
							row.entity.NIGHT_AMOUNT + 
							row.entity.SATURDAY_AMOUNT + 
							row.entity.HOLIDAY_AMOUNT + 
							(row.entity.REWARD_AMOUNT === null ? 0 : Number(row.entity.REWARD_AMOUNT)) + 
							(row.entity.ADDITIONAL_AMOUNT === null ? 0 : Number(row.entity.ADDITIONAL_AMOUNT.toString().replace(/[^0-9]/g, ''))) - 
							(row.entity.PENALTY_AMOUNT === null ? 0 : Number(row.entity.PENALTY_AMOUNT.toString().replace(/[^0-9]/g, '')))
						, 0);
						*/
					}else{
						// 2021-03-03 jamerl - 조용래 : 지급액 재계산은 별도의 버튼 이벤트를 통해 산출하도록 변경
						/*
						row.entity.PAY_AMOUNT = roundXL(
							row.entity.SUBCONTRACTING_COST + 
							row.entity.EXTENSION_AMOUNT + 
							row.entity.NIGHT_AMOUNT + 
							row.entity.SATURDAY_AMOUNT + 
							row.entity.HOLIDAY_AMOUNT + 
							(row.entity.REWARD_AMOUNT === null ? 0 : Number(row.entity.REWARD_AMOUNT)) + 
							(row.entity.ADDITIONAL_AMOUNT === null ? 0 : Number(row.entity.ADDITIONAL_AMOUNT.toString().replace(/[^0-9]/g, ''))) - 
							(row.entity.PENALTY_AMOUNT === null ? 0 : Number(row.entity.PENALTY_AMOUNT.toString().replace(/[^0-9]/g, '')))
						, 0);
						*/
						;
					}
				}
				scope.gridApi.grid.refresh();
			};
			
			// 보상금 이벤트
			$scope.fn_reward_amount_change = function(row) {
				if(row.entity.REWARD_AMOUNT !== null){
					var d = row.entity.REWARD_AMOUNT.toString().replace(/[^0-9]/g, '');
					var num = unComma(d);
					num = num * 1;
					row.entity.REWARD_AMOUNT = num;
				}
				if(row.entity.ADDITIONAL_AMOUNT !== null){
					var d = row.entity.ADDITIONAL_AMOUNT.toString().replace(/[^0-9]/g, '');
					var num = unComma(d);
					num = num * 1;
					row.entity.ADDITIONAL_AMOUNT = addComma(num);
				}
				if(row.entity.PENALTY_AMOUNT !== null){
					var d = row.entity.PENALTY_AMOUNT.toString().replace(/[^0-9]/g, '');
					var num = unComma(d);
					num = num * 1;
					row.entity.PENALTY_AMOUNT = addComma(num);
				}
				scope.gridApi.grid.refresh();
			};
			
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
			
			var columnDefs = [
				{
					displayName : '연도',
					field : 'BASE_YYYY',
					width : '75',
					pinnedLeft : true,
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '거래처',
					field : 'VENDOR_CODE',
					width : '75',
					pinnedLeft : true,
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '거래처명',
					field : 'VENDOR_NAME',
					width : '95',
					pinnedLeft : true,
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '계약코드',
					field : 'CONTRACT_CODE',
					width : '75',
					pinnedLeft : true,
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '계약명',
					field : 'CONTRACT_NAME',
					width : '150',
					pinnedLeft : true,
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '부서코드',
					field : 'DEPT_CODE',
					width : '75',
					pinnedLeft : true,
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '부서명',
					field : 'DEPT_NAME',
					width : '85',
					pinnedLeft : true,
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '공수',
					field : 'MANHOUR',
					width : '75',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '단가',
					field : 'UNIT_PRICE',
					width : '75',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.UNIT_PRICE)}}</div>'
				}, {
					displayName : '단가(집계)',
					field : 'UNIT_PRICE_V',
					width : '105',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.UNIT_PRICE_V)}}</div>'
				}, {
					displayName : '월기준량',
					field : 'MONTH_STANDARD_AMOUNT',
					width : '95',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.MONTH_STANDARD_AMOUNT)}}</div>'
				}, {
					displayName : '단위',
					field : 'UNIT_NAME',
					width : '75',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '실적물량(일보)',
					field : 'QUANTITY',
					width : '125',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{row.entity.QUANTITY}}</div>'
				}, {
					displayName : '실적물량(집계)', /* 2021-11-03 jamerl - 일보승인에서 작업량 보정을 입력하므로 화면에서 숨겨서, 다시 보정하지 못하도록 변경 */
					field : 'QUANTITY_CHANGED',
					width : '125',
					visible : false,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : QUANTITY_CHANGED + QUANTITY_CHANGED_MOD
				}, {
					displayName : '월도급비',
					field : 'SUBCONTRACTING_COST',
					width : '95',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.SUBCONTRACTING_COST)}}</div>',
					aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
				}, {
					displayName : '월도급비(집계)',
					field : 'SUBCONTRACTING_COST_V',
					width : '125',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.SUBCONTRACTING_COST_V)}}</div>',
					aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
				}, {
					displayName : '연장',
					field : 'EXTENSION_HOUR',
					width : '95',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents center">{{col.getAggregationValue()}}</div>'
				}, {
					displayName : '연장금액',
					field : 'EXTENSION_AMOUNT',
					width : '95',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.EXTENSION_AMOUNT)}}</div>',
					aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
				}, {
					displayName : '휴일',
					field : 'HOLIDAY_MANHOUR',
					width : '95',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents center">{{col.getAggregationValue()}}</div>'
				}, {
					displayName : '휴일금액',
					field : 'HOLIDAY_AMOUNT',
					width : '95',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.HOLIDAY_AMOUNT)}}</div>',
					aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
				}, {
					displayName : '야간',
					field : 'NIGHT_HOUR',
					width : '95',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents center">{{col.getAggregationValue()}}</div>'
				}, {
					displayName : '야간금액',
					field : 'NIGHT_AMOUNT',
					width : '95',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.NIGHT_AMOUNT)}}</div>',
					aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
				}, {
					displayName : '지각',
					field : 'LATE_HOUR',
					width : '95',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents center">{{col.getAggregationValue()}}</div>'
				}, {
					displayName : '토요공수',
					field : 'SATURDAY_MANHOUR',
					width : '95',
					visible : false, /* 2021-11-02 jamerl - 토요공수 미사용 */
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents center">{{col.getAggregationValue()}}</div>'
				}, {
					displayName : '토요금액',
					field : 'SATURDAY_AMOUNT',
					width : '95',
					visible : false, /* 2021-11-02 jamerl - 토요공수 미사용 */
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.SATURDAY_AMOUNT)}}</div>',
					aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
				}, {
					displayName : '보상률(보상금)',
					field : 'REWARD_RATE',
					width : '125',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : REWARD_RATE + REWARD_RATE_MOD,
					aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents center">{{col.getAggregationValue()}}</div>'
				}, {
					displayName : '금액(보상금)',
					field : 'REWARD_AMOUNT',
					width : '115',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : REWARD_AMOUNT + REWARD_AMOUNT_MOD,
					aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
				}, {
					displayName : '사유(보상금)',
					field : 'REWARD_REASON',
					width : '115',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : REWARD_REASON + REWARD_REASON_MOD
				}, {
					displayName : '금액(추가금)',
					field : 'ADDITIONAL_AMOUNT',
					width : '115',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.ADDITIONAL_AMOUNT" style="height: 100%; width: 100%; text-align: right; background-color: #ffcc66;" ng-keyup="grid.appScope.fn_calc(row, $event)" on-model-change="grid.appScope.fn_reward_amount_change(row)">',
					aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
				}, {
					displayName : '근거(추가금)',
					field : 'ADDITIONAL_BASIS',
					width : '115',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.ADDITIONAL_BASIS" style="height: 100%; width: 100%;">'
				}, {
					displayName : '사유(추가금)',
					field : 'ADDITIONAL_REASON',
					width : '115',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.ADDITIONAL_REASON" style="height: 100%; width: 100%;">'
				}, {
					displayName : '금액(패널티)',
					field : 'PENALTY_AMOUNT',
					width : '115',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.PENALTY_AMOUNT" style="height: 100%; width: 100%; text-align: right; background-color: #ffcc66;" ng-keyup="grid.appScope.fn_calc(row, $event)" on-model-change="grid.appScope.fn_reward_amount_change(row)">',
					aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
				}, {
					displayName : '근거(패널티)',
					field : 'PENALTY_BASIS',
					width : '115',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.PENALTY_BASIS" style="height: 100%; width: 100%;">'
				}, {
					displayName : '사유(패널티)',
					field : 'PENALTY_REASON',
					width : '115',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.PENALTY_REASON" style="height: 100%; width: 100%;">'
				}, {
					displayName : '지급액',
					field : 'PAY_AMOUNT',
					width : '85',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.PAY_AMOUNT)}}</div>',
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
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="background-color: {{grid.appScope.formatter_bg_color(row.entity.STATUS)}}">{{row.entity.STATUS_TXT}}&nbsp;</div>'
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
			// 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope)
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
				listQuery : "yp_zwc_ipt2.select_tbl_working_monthly_report", //list가져오는 마이바티스 쿼리 아이디
				cntQuery : "yp_zwc_ipt2.select_tbl_working_monthly_report_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
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
			
			// 이벤트(변경) - 거래처
			$("#VENDOR_CODE").on("change", function() {
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					url : "/yp/zwc/ipt2/select_cb_tbl_working_subc",
					type : "POST",
					cache : false,
					async : true,
					dataType : "json",
					data : {
						BASE_YYYY: $("#BASE_YYYY").val().replace("/", "").substring(0, 4),
						VENDOR_CODE: $(this).val()
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
				var uigrid_data;
				scope.reloadGrid({
					BASE_YYYY : $("#BASE_YYYY").val(),
					VENDOR_CODE : $("#VENDOR_CODE").val(),
					CONTRACT_CODE : $("#CONTRACT_CODE").val(),
					DEPT_CODE : $("#DEPT_CODE").val(),
					CONTRACT_BASE_YYYY : $("#CONTRACT_CODE :selected").data("base-yyyy")
				}, function(uigrid_data){ // uigrid_data <-- 조회된 데이터(JSON)
					console.log("그리드 수신 데이터 확인", uigrid_data);
					// 2020-11-23 jamerl - 조용래 : 부서가 선택된 상태로 조회된 그리드의 첫 행의 결과에 따라 결재상태를 표시
					if(uigrid_data.length > 0 && $("#DEPT_CODE").val() !== ""){
						var t = uigrid_data[0].STATUS;
						var v = uigrid_data[0].STATUS_TXT;
						var rgb;
						if(t === null || t === ""){
							$("#STATUS_VIEW").hide();
							return true;
						}
						switch(t){
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
						$("#STATUS_VIEW").text(v)
										 .css("background-color", rgb)
										 .show();
					}else{
						$("#STATUS_VIEW").hide();
					}
				});
			});
			
			// 전재결재 초기화
			$("#fnReset").on("click", function() {
				if($("#DEPT_CODE").val() === ""){
					swalInfoCB("전자결재 초기화 대상 부서정보가 없습니다.");
					return false;
				}else if($("#BASE_YYYY").val() === ""){
					swalInfoCB("전자결재 초기화 대상 검수년월 정보가 없습니다.");
					return false;
				}else{
					// 2020-11-09 jamerl - 조용래 : 대상 조회조건의 데이터(도급월보)가 모두 결재여부 확인.
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zwc/ipt/zwc_ipt_mon_create_status_reset",
						type : "POST",
						cache : false,
						async : false,
						dataType : "json",
						data : {
							CHECK_YYYYMM : $("#BASE_YYYY").val().replace("/", ""),
							DEPT_CODE : $("#DEPT_CODE").val()
						},
						success : function(data) {
							swalInfoCB("전자결재 초기화 되었습니다.", function(){
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
							swalDangerCB("전자결재 초기화 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
				}
			});
			
			// 전재결재
			$("#fnApp").on("click", function() {
				if($("#DEPT_CODE").val() === ""){
					swalInfoCB("부서정보가 없습니다.");
					return false;
				}else if($("#BASE_YYYY").val() === ""){
					swalInfoCB("검수년월 정보가 없습니다.");
					return false;
				}else{
					// 2020-11-09 jamerl - 조용래 : 대상 조회조건의 데이터(도급월보)가 모두 결재여부 확인.
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zwc/ipt/zwc_ipt_mon_create_check",
						type : "POST",
						cache : false,
						async : false,
						dataType : "json",
						data : {
							BASE_YYYY : $("#BASE_YYYY").val().replace("/", ""),
							DEPT_CODE : $("#DEPT_CODE").val()
						},
						success : function(data) {
							console.log("전자결재 가능여부", data.result);
							// 2020-11-13 jamerl - 조용래 : 체크로직 구현 후 전자결재 테스트 할 수 있도록 무조건 전자결재 할 수 있게 처리
// 							data.result = "Y";
							// 2020-11-23 jamerl - 조용래 : 시스템권한 CA, MA는 집계및 저장, 전자결재에 제한이 없도록 요청 -> 제거
// 							if("${sessionScope.s_authogrp_code}" === "CA" || "${sessionScope.s_authogrp_code}" === "MA" ){
// 								var w = window.open("about:blank", "도급월보", "width=1200,height=900,location=yes,scrollbars=yes");
// 								w.location.href = "http://ypgw.ypzinc.co.kr/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=EF160326495662695" + 
// 										"&BASE_YYYY=" + $("#BASE_YYYY").val().replace("/", "") + 
// 										"&DEPT_CODE=" + $("#DEPT_CODE").val() + 
// 										"&PKSTR=" + $("#BASE_YYYY").val().replace("/", "") + ";" + $("#DEPT_CODE").val();
// 							}else if(data.result === 'N2'){
							if(data.result === 'N2'){
								swalWarningCB("대상 도급월보가 없습니다.");
							}else if(data.result === 'Y'){
								var w = window.open("about:blank", "도급월보", "width=1200,height=900,location=yes,scrollbars=yes");
								w.location.href = "http://ypgw.ypzinc.co.kr/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=EF160326495662695" + 
										"&BASE_YYYY=" + $("#BASE_YYYY").val().replace("/", "") + 
										"&DEPT_CODE=" + $("#DEPT_CODE").val() + 
										"&PKSTR=" + $("#BASE_YYYY").val().replace("/", "") + ";" + $("#DEPT_CODE").val();
							}else{
								swalWarningCB("도급월보 전자결재가 진행중이거나 완료되었습니다.");
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
				}
			});
			
			// 지급액산출
			$("#fnCalc").on("click", function() {
				var rows = scope.gridApi.selection.getSelectedRows();
				if(rows.length === 0){
					swalWarningCB("지급액을 산출할 항목을 선택하세요.");
					return false;
				}
				
				$.each(rows, function(i, d){
					// 전자결재 프로세스 정해지면 전자결재 여부도 확인필요.
					d.PAY_AMOUNT = roundXL(
						d.SUBCONTRACTING_COST + 
						d.EXTENSION_AMOUNT + 
						d.NIGHT_AMOUNT + 
						d.SATURDAY_AMOUNT + 
						d.HOLIDAY_AMOUNT + 
						(d.REWARD_AMOUNT === null ? 0 : Number(d.REWARD_AMOUNT)) + 
						(d.ADDITIONAL_AMOUNT === null ? 0 : Number(d.ADDITIONAL_AMOUNT.toString().replace(/[^0-9]/g, ''))) - 
						(d.PENALTY_AMOUNT === null ? 0 : Number(d.PENALTY_AMOUNT.toString().replace(/[^0-9]/g, '')))
					, 0);
				});
				scope.gridApi.grid.refresh();
			});
			
			// 집계
			$("#fnIns").on("click", function() {
				var rows = scope.gridApi.selection.getSelectedRows();
				if(rows.length === 0){
					swalWarningCB("집계할 항목을 선택하세요.");
					return false;
				}
				if (!fnValidation(rows)){
					return false;
				}
				
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					url : "/yp/zwc/ipt/pre_select_tbl_working_monthly_report",
					type : "POST",
					cache : false,
					async : false,
					dataType : "json",
					data : {
						BASE_YYYY : $("#BASE_YYYY").val().replace("/", ""),
						ROW_NO: JSON.stringify(rows)
					},
					success : function(data) {
						// 2020-11-23 jamerl - 조용래 : 시스템권한 CA, MA는 집계및 저장, 전자결재에 제한이 없도록 요청. -> 제거
// 						if(data.result === 0 || "${sessionScope.s_authogrp_code}" === "CA" || "${sessionScope.s_authogrp_code}" === "MA" ){
						if(data.result === 0){
							if (confirm("집계하시겠습니까?")) {
								$.ajax({
									url : "/yp/zwc/ipt/insert_tbl_working_monthly_report",
									type : "POST",
									cache : false,
									async : false,
									dataType : "json",
									data : {
										BASE_YYYY : $("#BASE_YYYY").val().replace("/", ""),
										ROW_NO: JSON.stringify(rows)
									},
									success : function(data) {
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
										swalDangerCB("집계 실패하였습니다.\n관리자에게 문의해주세요.");
									}
								});
							}
						}else if(data.result > 0){
							swalWarningCB("전자결재가 진행 및 완료 된 계약이 선택되었습니다.");
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
			
			// 저장
			$("#fnMod").on("click", function() {
				var rows = scope.gridApi.selection.getSelectedRows();
				if(rows.length === 0){
					swalWarningCB("저장할 항목을 선택하세요.");
					return false;
				}
				if (!fnValidation(rows)){
					return false;
				}
				var mod_chk = false;
				$.each(rows, function(i, d){
					// 전자결재 프로세스 정해지면 전자결재 여부도 확인필요.
					if(d.CHECK_YYYYMM === null){
						swalWarningCB("집계되지 않은 계약이 선택되었습니다.");
						mod_chk = true;
						return false;
					}
				});
				if(mod_chk){
					return false;
				}
				console.log(rows);
				if (confirm("저장하시겠습니까?")) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zwc/ipt/update_tbl_working_monthly_report",
						type : "POST",
						cache : false,
						async : false,
						dataType : "json",
						data : {
							ROW_NO: JSON.stringify(rows)
						},
						success : function(data) {
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
		});
		function formatDate_m(date) {
			var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
			if (month.length < 2)
				month = '0' + month;
			if (day.length < 2)
				day = '0' + day;
			return [ year, month ].join('/');
		}
		function fnValidation(rows){
			var check = true;
			$.each(rows, function(i, d){
				if(d.REWARD_AMOUNT !== null && (d.REWARD_REASON === null || d.REWARD_REASON.trim() === "")){
					swalWarningCB("사유를 입력해주세요.");
					check = false;
					return false;
				}
				if(d.ADDITIONAL_AMOUNT !== null && (d.ADDITIONAL_BASIS === null || d.ADDITIONAL_BASIS.trim() === "" || d.ADDITIONAL_REASON === null || d.ADDITIONAL_REASON.trim() === "")){
					swalWarningCB("산출근거와 사유를 입력해주세요.");
					check = false;
					return false;
				}
				if(d.PENALTY_BASIS !== null && (d.PENALTY_BASIS === null || d.PENALTY_BASIS.trim() === "" || d.PENALTY_REASON === null || d.PENALTY_REASON.trim() === "")){
					swalWarningCB("산출근거와 사유를 입력해주세요.");
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
		// 엑셀 스타일의 반올림 함수 정의
		function roundXL(n, digits) {
			if (digits >= 0) return parseFloat(n.toFixed(digits)); // 소수부 반올림
			digits = Math.pow(10, digits); // 정수부 반올림
			var t = Math.round(n * digits) / digits;
			return parseFloat(t.toFixed(0));
		}
	</script>
	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
</body>