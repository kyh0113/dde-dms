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
SimpleDateFormat date = new SimpleDateFormat("yyyy");
int to_yyyy = Integer.parseInt(date.format(today));
// JSTL에서 사용할 수 있도록 세팅
request.setAttribute("to_yyyy", to_yyyy);

Calendar cal = Calendar.getInstance();
cal.set(Calendar.YEAR, 2010);
int from_yyyy = Integer.parseInt(date.format(cal.getTime()));
//JSTL에서 사용할 수 있도록 세팅
request.setAttribute("from_yyyy", from_yyyy);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>계약 단가 책정</title>
</head>
<body>
	<!-- 20191023_khj for csrf -->
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<h2>
		계약 단가 책정
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
						<th>연도</th>
						<td>
							<input type="text" id="BASE_YYYY" class="calendar search_dtp_y" value="${to_yyyy}" readonly="readonly"/>
						</td>
						<th>계약명</th>
						<td>
							<input type="text" id="CONTRACT_NAME">
						</td>
						<th>담당부서</th>
						<td>
							<select id="DEPT_CODE">
								<c:choose>
									<c:when test="${'CA' eq sessionScope.WC_AUTH || 'SA' eq sessionScope.WC_AUTH || 'MA' eq sessionScope.WC_AUTH || 'WM' eq sessionScope.WC_AUTH}">
										<option value="" selected="selected">-전체-</option>
										<c:forEach var="t" items="${teamList}" varStatus="status">
											<option value="${t.OBJID}">${t.STEXT}</option>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<c:forEach var="t" items="${teamList}" varStatus="status">
											<option value="${t.OBJID}" <c:if test="${status.first}">selected</c:if>>${t.STEXT}</option>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</select>
						</td>
					</tr>
					<tr>
						<th>거래처</th>
						<td>
							<select id="VENDOR_CODE">
								<option value="">전체</option>
								<c:forEach var="row" items="${cb_working_master_v}" varStatus="status">
									<option value="${row.CODE}">${row.CODE_NAME}</option>
								</c:forEach>
							</select>
						</td>
						<th>도급구분</th>
						<td>
							<select id="GUBUN_CODE">
								<option value="">전체</option>
								<c:forEach var="row" items="${cb_gubun}" varStatus="status">
									<option value="${row.CODE}">${row.CODE_NAME}</option>
								</c:forEach>
							</select>
						</td>
						<th>단위</th>
						<td>
							<select id="UNIT_CODE">
								<option value="">전체</option>
								<c:forEach var="row" items="${cb_working_master_u}" varStatus="status">
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
				※단가 계산은 <span style="background-color: #ffcc66;">　　　</span> 색상의 영역(월기준량, 근무형태)에서 엔터키를 누르세요. <span style="font-style: italic;">※저장품 및 조업계약은 단가계산 제외됩니다.</span>
			</div>
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type=button class="btn_g" id="fnMod"	value="수정">
				<input type=button class="btn_g" id="fnStr"	value="저장">
			</div>
		</div>
	</div>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="shdsCtrl">
			<div data-ui-i18n="ko" style="height: 590px;">
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

			// 월기준량
			var MONTH_STANDARD_AMOUNT = '<div ng-if="row.entity.IS_MOD != \'Y\'" class="ui-grid-cell-contents" ng-model="row.entity.MONTH_STANDARD_AMOUNT" >{{row.entity.MONTH_STANDARD_AMOUNT}}</div>';
			var MONTH_STANDARD_AMOUNT_MOD = '<input ng-if="row.entity.IS_MOD == \'Y\'" type="text" class="" ng-model="row.entity.MONTH_STANDARD_AMOUNT" ng-keyup="grid.appScope.fn_AJAX_CALC(row, $event, \'MONTH_STANDARD_AMOUNT\')" style="width: 100%; height: 100% !important; text-align: right; background-color: #ffcc66;"/>';
			
			var columnDefs = [ //컬럼 세팅
				{
					displayName : '연도',
					field : 'BASE_YYYY',
					width : '75',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '거래처',
					field : 'VENDOR_CODE',
					width : '75',
					visible : false,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '거래처명',
					field : 'VENDOR_NAME',
					width : '110',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '코드',
					field : 'CONTRACT_CODE',
					width : '75',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '계약명',
					field : 'CONTRACT_NAME',
					width : '170',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '단위',
					field : 'UNIT_CODE',
					width : '75',
					visible : false,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '단위',
					field : 'UNIT_NAME',
					width : '75',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '구분',
					field : 'GUBUN_CODE',
					width : '75',
					visible : false,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '구분',
					field : 'GUBUN_NAME',
					width : '75',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '월기준량',
					field : 'MONTH_STANDARD_AMOUNT',
					width : '110',
					visible : true,
					cellClass : "right",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : MONTH_STANDARD_AMOUNT + MONTH_STANDARD_AMOUNT_MOD
				}
			];
			
			$scope.fn_AJAX_CALC = function(row, event, target) {
// 				if(isNaN(row.entity[worktype_code])){
// 					row.entity[worktype_code] = 0;
// 					return false;
// 				}
// 				console.log(event);
				if(event.keyCode !== 13){
					if(target === null) return false; // 근무형태 천단위 콤마 제외
					
					row.entity[target] = addComma(unComma(row.entity[target]));
					scope.gridApi.grid.refresh();
					return false;
				}
				// 물량, 인력 외 단가계산 제외
				if(row.entity.GUBUN_CODE !== '1' && row.entity.GUBUN_CODE !== '2'){
					return false;
				}
				// 조업계약 단가계산 제외
				if(row.entity.WORKING_GUBUN === 'Y'){
					return false;
				}
				if(isNaN(Number(unComma(row.entity.MONTH_STANDARD_AMOUNT.toString())))){
					row.entity.MONTH_STANDARD_AMOUNT = 0;
				}
				if(row.entity.MONTH_STANDARD_AMOUNT.toString().trim() === "0" && row.entity.GUBUN_CODE === "1"){
					swalWarning("월기준량을 입력하세요.");
					return false;
				}
				// 2020-10-13 jamerl - 기타수당 수식 추가
				if(isNaN(Number(unComma(row.entity.EXTRA_PAY.toString())))){
					row.entity.EXTRA_PAY = 0;
				}
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					url: "/yp/zwc/ctr/select_zwc_ctr_detail_create_unit_price",
					type: "POST",
					cache: false,
					async: true, 
					dataType: "json",
					data: {
						ROW_NO: JSON.stringify(row.entity)
					},
					success: function(data) {
						var UNIT_PRICE = 0;
						
						var month_standard_amount = Number(unComma(row.entity.MONTH_STANDARD_AMOUNT.toString())); // 월기준량
						var final_unit_price = 0; // 업체별 근무형태별 단가
						var extra_pay = Number(unComma(row.entity.EXTRA_PAY.toString())); // 기타수당
						var total_human = 0; // 인원
						var worktype_human = 0; // 근무형태별인원 - 인원 수식에서 사용
						var month_amount_ptc = 0; // 보호구비
						var month_amount_nft = 0; // 건강검진비
						
						month_amount_ptc = data.month_amount_ptc;
						month_amount_nft = data.month_amount_nft;
						if(row.entity.GUBUN_CODE === "1"){ // 물량 로직
							if(data.final_unit_price.length > 0){
								$.each(data.final_unit_price, function(i, d){
// 									console.log(i, d);
									final_unit_price += (d.FINAL_UNIT_PRICE) * Number(row.entity[d.WORKTYPE_CODE]); // 업체별 근무형태별 단가 * 근무형태별 인원
									total_human += Number(row.entity[d.WORKTYPE_CODE]); // 인원 누적 계산
								});
							}
							console.log("물량", "((업체별 근무형태별 단가 * 근무형태별 인원) / 월기준량) + (((보호구비 * 인원) + (건강검진비 * 인원)) / 월기준량) + (기타수당 / 월기준량)");
							UNIT_PRICE = 
								(final_unit_price / month_standard_amount) + 
								(((month_amount_ptc * total_human) + (month_amount_nft * total_human)) / month_standard_amount) + 
								(extra_pay / month_standard_amount);
							row.entity.UNIT_PRICE = addComma(roundXL(UNIT_PRICE, 0));
						}else if(row.entity.GUBUN_CODE === "2"){ // 인력 로직
							var bool_month_standard_amount = false;
							// 2020-10-16 jamerl - 입력된 근무형태의 시간외 수당 계산
							var P_BASE_YYYY, P_WORKTYPE_CODE;
							
							if(data.final_unit_price.length > 0){
								var bool_worktype_human = false; // 인원입력 확인여부
								$.each(data.final_unit_price, function(i, d){
// 									console.log(i, d);
									// 나머지 근무형태별 인원 입력값 0으로 처리
									if(bool_worktype_human || row.entity[d.WORKTYPE_CODE] === ""){
										row.entity[d.WORKTYPE_CODE] = 0;
									}
									// 근무형태별 인원이 입력된 것을 찾아서 입력
									// 근무형태별 단가
									if(Number(row.entity[d.WORKTYPE_CODE]) > 0){
										worktype_human += Number(row.entity[d.WORKTYPE_CODE]);
										final_unit_price += Number(d.FINAL_UNIT_PRICE) * Number(row.entity[d.WORKTYPE_CODE]);
										
										// 2020-10-14 jamerl - 조용래 : 단위가 '인'이면서 구분이 '인력'인 경우에만 월기준량과 금무형태별 인원이 같아야 한다고 요청
										// 2020-11-04 jamerl - 기준정보 > 단위 새로 입력되어 "U4"에서 "U8"
										if(row.entity.UNIT_CODE === "U8" && row.entity.GUBUN_CODE === "2"){
											bool_worktype_human = true;
										}else{
											bool_worktype_human = false;
										}
										if(bool_worktype_human && Number(row.entity[d.WORKTYPE_CODE]) !== month_standard_amount){
											swalWarning("월기준량과 근무형태별 인원이 일치하지 않습니다.");
											bool_month_standard_amount = true;
											return false;
										}
										
										if(bool_worktype_human){
											// 2020-10-16 jamerl - 입력된 근무형태의 시간외 수당 계산
											// 2002-11-04 jamerl - 조용래 : {구분: 인력, 단위: 인}인 경우에만 값을 가져옴
											P_BASE_YYYY = row.entity.BASE_YYYY;
											P_WORKTYPE_CODE = d.WORKTYPE_CODE;
											
											var token = $("meta[name='_csrf']").attr("content");
											var header = $("meta[name='_csrf_header']").attr("content");
											$.ajax({
												url: "/yp/zwc/ctr/select_overtime_pay",
												type: "POST",
												cache: false,
												async: false,
												dataType: "json",
												data: {
													BASE_YYYY: P_BASE_YYYY,
													WORKTYPE_CODE: P_WORKTYPE_CODE
												},
												success: function(data) {
													console.log(data.result);
													row.entity.OVERTIME_NIGHT = addComma(data.result.OVERTIME_NIGHT);
													row.entity.OVERTIME_EXTENSION = addComma(data.result.OVERTIME_EXTENSION);
													row.entity.OVERTIME_SATURDAY = addComma(data.result.OVERTIME_SATURDAY);
													row.entity.OVERTIME_HOLIDAY = addComma(data.result.OVERTIME_HOLIDAY);
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
										}else{
											// {구분: 인력, 단위: 인}이 아닌경우 값이 없으면 0으로 세팅
											if(row.entity.OVERTIME_NIGHT === "" || row.entity.OVERTIME_NIGHT === null)
												row.entity.OVERTIME_NIGHT = 0;
											if(row.entity.OVERTIME_EXTENSION === "" || row.entity.OVERTIME_EXTENSION === null)
												row.entity.OVERTIME_EXTENSION = 0;
											if(row.entity.OVERTIME_SATURDAY === "" || row.entity.OVERTIME_SATURDAY === null)
												row.entity.OVERTIME_SATURDAY = 0;
											if(row.entity.OVERTIME_HOLIDAY === "" || row.entity.OVERTIME_HOLIDAY === null)
												row.entity.OVERTIME_HOLIDAY = 0;
										}
									}
								});
							}
							if(bool_month_standard_amount){
								return false;
							}
							console.log("인력", "업체별 근무형태별 단가 + 보호구비 + 건강검진비");
							console.log("인력", final_unit_price + " + " + month_amount_ptc + " + " + month_amount_nft);
							// 업체별 근무형태별 단가 + 보호구비 + 건강검진비
							UNIT_PRICE = 
								(final_unit_price / month_standard_amount) +
								(((month_amount_ptc * worktype_human) + (month_amount_nft * worktype_human)) / month_standard_amount) +
								(extra_pay / month_standard_amount);
							row.entity.UNIT_PRICE = addComma(roundXL(UNIT_PRICE, 0));
							
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
						swalDangerCB("조회 실패하였습니다.\n관리자에게 문의해주세요.");
					}
				});
			}
			<c:forEach var="item" items="${cb_working_master_w}">
				var ${item.CODE} = '<div ng-if="row.entity.IS_MOD != \'Y\'" class="ui-grid-cell-contents right" ng-model="row.entity.${item.CODE}" >{{row.entity.${item.CODE}}}</div>';
				var ${item.CODE}_MOD = '<input ng-if="row.entity.IS_MOD == \'Y\' && row.entity.WORKING_GUBUN != \'Y\' && row.entity.GUBUN_CODE != \'3\'" type="text" class="" ng-model="row.entity.${item.CODE}" ng-keyup="grid.appScope.fn_AJAX_CALC(row, $event, null)" style="width: 100%; height: 100% !important; text-align: right; background-color: #ffcc66;"/>';
				var ${item.CODE}_MOD_VIEW = '<div ng-if="row.entity.IS_MOD == \'Y\' && (row.entity.WORKING_GUBUN == \'Y\' || row.entity.GUBUN_CODE == \'3\')" class="ui-grid-cell-contents right" ng-model="row.entity.${item.CODE}" >{{row.entity.${item.CODE}}}</div>';
			
				var data = 
				{
					displayName : '${item.CODE_NAME}',
					field : '${item.CODE}',
					width : '95',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : ${item.CODE} + ${item.CODE}_MOD + ${item.CODE}_MOD_VIEW
				}
				columnDefs.push(data);
			</c:forEach>
			
			// 야간
			var OVERTIME_NIGHT = '<div ng-if="row.entity.IS_MOD != \'Y\'" class="ui-grid-cell-contents right" ng-model="row.entity.OVERTIME_NIGHT" >{{row.entity.OVERTIME_NIGHT}}</div>';
			var OVERTIME_NIGHT_MOD = '<input ng-if="row.entity.IS_MOD == \'Y\' && row.entity.GUBUN_CODE == 2" type="text" class="" ng-model="row.entity.OVERTIME_NIGHT" style="width: 100%; height: 100% !important; text-align: right;"/>';
			var OVERTIME_NIGHT_MOD_VIEW = '<div ng-if="row.entity.IS_MOD == \'Y\' && (row.entity.GUBUN_CODE != 2 || row.entity.WORKING_GUBUN == \'Y\')" class="ui-grid-cell-contents right" ng-model="row.entity.OVERTIME_NIGHT">{{row.entity.OVERTIME_NIGHT}}</div>';
			
			// 연장
			var OVERTIME_EXTENSION = '<div ng-if="row.entity.IS_MOD != \'Y\'" class="ui-grid-cell-contents right" ng-model="row.entity.OVERTIME_EXTENSION" >{{row.entity.OVERTIME_EXTENSION}}</div>';
			var OVERTIME_EXTENSION_MOD = '<input ng-if="row.entity.IS_MOD == \'Y\' && row.entity.GUBUN_CODE == 2" type="text" class="" ng-model="row.entity.OVERTIME_EXTENSION" style="width: 100%; height: 100% !important; text-align: right;"/>';
			var OVERTIME_EXTENSION_MOD_VIEW = '<div ng-if="row.entity.IS_MOD == \'Y\' && (row.entity.GUBUN_CODE != 2 || row.entity.WORKING_GUBUN == \'Y\')" class="ui-grid-cell-contents right" ng-model="row.entity.OVERTIME_EXTENSION">{{row.entity.OVERTIME_EXTENSION}}</div>';
			
			// 토요
			var OVERTIME_SATURDAY = '<div ng-if="row.entity.IS_MOD != \'Y\'" class="ui-grid-cell-contents right" ng-model="row.entity.OVERTIME_SATURDAY" >{{row.entity.OVERTIME_SATURDAY}}</div>';
			var OVERTIME_SATURDAY_MOD = '<input ng-if="row.entity.IS_MOD == \'Y\' && row.entity.GUBUN_CODE == 2" type="text" class="" ng-model="row.entity.OVERTIME_SATURDAY" style="width: 100%; height: 100% !important; text-align: right;"/>';
			var OVERTIME_SATURDAY_MOD_VIEW = '<div ng-if="row.entity.IS_MOD == \'Y\' && (row.entity.GUBUN_CODE != 2 || row.entity.WORKING_GUBUN == \'Y\')" class="ui-grid-cell-contents right" ng-model="row.entity.OVERTIME_SATURDAY">{{row.entity.OVERTIME_SATURDAY}}</div>';
			
			// 휴일
			var OVERTIME_HOLIDAY = '<div ng-if="row.entity.IS_MOD != \'Y\'" class="ui-grid-cell-contents right" ng-model="row.entity.OVERTIME_HOLIDAY" >{{row.entity.OVERTIME_HOLIDAY}}</div>';
			var OVERTIME_HOLIDAY_MOD = '<input ng-if="row.entity.IS_MOD == \'Y\' && row.entity.GUBUN_CODE == 2" type="text" class="" ng-model="row.entity.OVERTIME_HOLIDAY" style="width: 100%; height: 100% !important; text-align: right;"/>';
			var OVERTIME_HOLIDAY_MOD_VIEW = '<div ng-if="row.entity.IS_MOD == \'Y\' && (row.entity.GUBUN_CODE != 2 || row.entity.WORKING_GUBUN == \'Y\')" class="ui-grid-cell-contents right" ng-model="row.entity.OVERTIME_HOLIDAY">{{row.entity.OVERTIME_HOLIDAY}}</div>';
			
			// 기타수당
			var EXTRA_PAY = '<div ng-if="row.entity.IS_MOD != \'Y\'" class="ui-grid-cell-contents right" ng-model="row.entity.EXTRA_PAY" >{{row.entity.EXTRA_PAY}}</div>';
			var EXTRA_PAY_MOD = '<input ng-if="row.entity.IS_MOD == \'Y\' && row.entity.WORKING_GUBUN != \'Y\' && row.entity.GUBUN_CODE != 3" type="text" class="" ng-model="row.entity.EXTRA_PAY" ng-keyup="grid.appScope.fn_AJAX_CALC(row, $event, \'EXTRA_PAY\')" style="width: 100%; height: 100% !important; text-align: right; background-color: #ffcc66;"/>';
			var EXTRA_PAY_MOD_VIEW = '<div ng-if="row.entity.IS_MOD == \'Y\' && (row.entity.WORKING_GUBUN == \'Y\' || row.entity.GUBUN_CODE == 3)" class="ui-grid-cell-contents right" ng-model="row.entity.EXTRA_PAY">{{row.entity.EXTRA_PAY}}</div>';
			
			// 단가
			var UNIT_PRICE = '<div ng-if="row.entity.IS_MOD != \'Y\'" class="ui-grid-cell-contents right" ng-model="row.entity.UNIT_PRICE" >{{row.entity.UNIT_PRICE}}</div>';
			var UNIT_PRICE_MOD = '<input ng-if="row.entity.IS_MOD == \'Y\' && (row.entity.GUBUN_CODE == 3 || row.entity.WORKING_GUBUN == \'Y\')" type="text" class="" ng-model="row.entity.UNIT_PRICE" style="width: 100%; height: 100% !important; text-align: right;"/>';
			var UNIT_PRICE_MOD_VIEW = '<div ng-if="row.entity.IS_MOD == \'Y\' && row.entity.GUBUN_CODE != 3 && row.entity.WORKING_GUBUN != \'Y\'" class="ui-grid-cell-contents right" ng-model="row.entity.UNIT_PRICE" >{{row.entity.UNIT_PRICE}}</div>';
			
			columnDefs.push(
				{
					displayName : '야간',
					field : 'OVERTIME_NIGHT',
					width : '75',
					visible : true,
					cellClass : "center",
// 					pinnedRight : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : OVERTIME_NIGHT + OVERTIME_NIGHT_MOD + OVERTIME_NIGHT_MOD_VIEW
				}, {
					displayName : '연장',
					field : 'OVERTIME_EXTENSION',
					width : '75',
					visible : true,
					cellClass : "center",
// 					pinnedRight : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : OVERTIME_EXTENSION + OVERTIME_EXTENSION_MOD + OVERTIME_EXTENSION_MOD_VIEW
				}, {
					displayName : '토요',
					field : 'OVERTIME_SATURDAY',
					width : '75',
					visible : true,
					cellClass : "center",
// 					pinnedRight : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : OVERTIME_SATURDAY + OVERTIME_SATURDAY_MOD + OVERTIME_SATURDAY_MOD_VIEW
				}, {
					displayName : '휴일',
					field : 'OVERTIME_HOLIDAY',
					width : '75',
					visible : true,
					cellClass : "center",
// 					pinnedRight : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : OVERTIME_HOLIDAY + OVERTIME_HOLIDAY_MOD + OVERTIME_HOLIDAY_MOD_VIEW
				}, {
					displayName : '기타수당(원)',
					field : 'EXTRA_PAY',
					width : '120',
					visible : true,
					cellClass : "center",
// 					pinnedRight : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : EXTRA_PAY + EXTRA_PAY_MOD + EXTRA_PAY_MOD_VIEW
				}, {
					displayName : '단가(원)',
					field : 'UNIT_PRICE',
					width : '120',
					visible : true,
					cellClass : "center",
// 					pinnedRight : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : UNIT_PRICE + UNIT_PRICE_MOD + UNIT_PRICE_MOD_VIEW
				});
			//기본 컬럼 저장
			$scope.columnDefsDefault = columnDefs;
		
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
				listQuery : "yp_zwc_ctr.select_zwc_ctr_detail_create", //list가져오는 마이바티스 쿼리 아이디
				cntQuery : "yp_zwc_ctr.select_zwc_ctr_detail_create_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
			
			// 부트스트랩 날짜객체
			$(".search_dtp_y").datepicker({
				format: " yyyy",
				viewMode: "years",
				minViewMode: "years",
				language : "ko",
				todayHighlight : true,
				autoclose : true,
				clearBtn : true,
				updateViewDate : false
			}).on('changeDate', function(e) {
				$(this).val(formatDate_y(e.date.valueOf())).trigger("change");
				$("#search_btn").trigger("click");
				$('.datepicker').hide();
			});
			
			// 부트스트랩 날짜객체
			$(document).on("focus", ".dtp_d", function() {
				$(this).datepicker({
					format: "yyyy/mm/dd",
					language : "ko",
					todayHighlight : true,
					autoclose : true,
					clearBtn : true,
					updateViewDate : false
				}).on('changeDate', function(e) {
					$(this).val(formatDate_d(e.date.valueOf())).trigger("change");
					$('.datepicker').hide();
				});
			});
			
			// 조회
			$("#search_btn").on("click", function() {
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					url: "/yp/zwc/ctr/select_zwc_ctr_detail_create",
					type: "POST",
					cache: false,
					async: true, 
					dataType: "json",
					data: {
						BASE_YYYY : $("#BASE_YYYY").val(),
						VENDOR_CODE : $("#VENDOR_CODE").val(),
						CONTRACT_NAME : $("#CONTRACT_NAME").val(),
						DEPT_CODE : $("#DEPT_CODE").val(),
						DEPT_NAME : $("#DEPT_NAME").val(),
						GUBUN_CODE : $("#GUBUN_CODE").val(),
						UNIT_CODE : $("#UNIT_CODE").val()
					},
					success: function(data) {
						if(data.result != null && data.result.length > 0){
							scope.gridOptions.data = data.result;
						}else{
							scope.gridOptions.data = [];
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
						swalDangerCB("조회 실패하였습니다.\n관리자에게 문의해주세요.");
					}
				});
			});
			
			// 수정
			$("#fnMod").on("click", function() {
				var rows = scope.gridApi.selection.getSelectedRows();
				if (isEmpty(rows)) {
					swalWarning("항목을 선택하세요.");
					return false;
				}
				$.each(rows, function(i, d){
					if(d.IS_NEW === "Y"){
						return true;
					}
					d.IS_MOD = "Y";
				});
				scope.gridApi.grid.refresh();
			});
			
			// 저장
			$("#fnStr").on("click", function() {
				var rows = scope.gridApi.selection.getSelectedRows();
				if(rows.length === 0){
					swalWarningCB("저장할 항목을 선택하세요.");
					return false;
				}
				if (!fnValidation(rows)){
					return false;
				}
				console.log(rows);
				if (confirm("저장하시겠습니까?")) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zwc/ctr/zwc_ctr_detail_create_save",
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
		});
		
		function formatDate_y(date) {
			var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
			if (month.length < 2)
				month = '0' + month;
			if (day.length < 2)
				day = '0' + day;
			return [ year ].join('/');
		}
		function formatDate_m(date) {
			var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
			if (month.length < 2)
				month = '0' + month;
			if (day.length < 2)
				day = '0' + day;
			return [ year, month ].join('/');
		}
		function formatDate_d(date) {
			var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
			if (month.length < 2)
				month = '0' + month;
			if (day.length < 2)
				day = '0' + day;
			return [ year, month, day ].join('/');
		}
		function fnSearchPopup(type, target) {
			if (type == "11") {
				window.open("", "담당부서 검색", "width=600, height=800");
				fnHrefPopup("/yp/popup/zwc/ctr/retrieveKOSTL", "담당부서 검색", {
					type : "Z",
					target : target
				});
			} else if (type == "12") {
				window.open("", "코스트센터 검색", "width=600, height=800");
				fnHrefPopup("/yp/popup/zwc/ctr/retrieveKOSTL", "코스트센터 검색", {
					type : "C",
					target : target
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
		function fnValidation(rows){
			var check = true;
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