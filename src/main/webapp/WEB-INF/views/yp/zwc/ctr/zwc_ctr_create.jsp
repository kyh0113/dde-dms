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
<title>계약 등록</title>
</head>
<body>
	<!-- 20191023_khj for csrf -->
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
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
<!-- 							<select id="BASE_YYYY_S"> -->
<%-- 								<c:forEach var="i" begin="0" end="${to_yyyy - from_yyyy}">JSTL 역순 출력 - 연도 --%>
<%-- 									<c:set var="yearOption" value="${to_yyyy - i}" /> --%>
<%-- 									<option value="${yearOption}">${yearOption}</option> --%>
<%-- 								</c:forEach> --%>
<!-- 							</select> -->
							<input type="text" id="BASE_YYYY_S" class="calendar search_dtp_y" value="${to_yyyy}" readonly="readonly"/>　~　
<!-- 							<select id="BASE_YYYY_E"> -->
<%-- 								<c:forEach var="i" begin="0" end="${to_yyyy - from_yyyy}">JSTL 역순 출력 - 연도 --%>
<%-- 									<c:set var="yearOption" value="${to_yyyy - i}" /> --%>
<%-- 									<option value="${yearOption}">${yearOption}</option> --%>
<%-- 								</c:forEach> --%>
<!-- 							</select> -->
							<input type="text" id="BASE_YYYY_E" class="calendar search_dtp_y" value="${to_yyyy}" readonly="readonly"/>
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
					<input type=button class="btn btn_make" id="excel_btn"		value="엑셀 다운로드">
					<input type=button class="btn btn_search" id="search_btn"	value="조회">
				</div>
			</div>
		</section>
	</form>
	<div class="float_wrap" style="margin-bottom: 2px;">
		<div class="fl">
			<div class="btn_wrap">
				<input type=button class="btn_g" id="fnAdd"	value="추가">
				<input type=button class="btn_g" id="fnMod"	value="수정">
			</div>
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type=button class="btn_g" id="fnRem"	value="삭제">
				<input type=button class="btn_g" id="fnCtr"	value="저장">
				<input type=button class="btn_g" id="fnRef"	value="참조생성">
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
			
			// 연도
			var BASE_YYYY = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.BASE_YYYY" >{{row.entity.BASE_YYYY}}</div>';
			var BASE_YYYY_NEW = '<input ng-if="row.entity.IS_NEW != null" type="text" class="calendar dtp_y" on-model-change="grid.appScope.fn_base_yyyy_change(row)" ng-model="row.entity.BASE_YYYY" style="width: 100%; height: 100% !important;" readonly="readonly"/>';
			var BASE_YYYY_MOD = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" class="ui-grid-cell-contents" ng-model="row.entity.BASE_YYYY" >{{row.entity.BASE_YYYY}}</div>';
			
			// 추가건 연도 변경 이벤트 - 변경한 연도의 1월 12월로 계약기간 기본값 설정
			$scope.fn_base_yyyy_change = function(row) {
				row.entity.START_YYYYMM = row.entity.BASE_YYYY + '/01';
				row.entity.END_YYYYMM = row.entity.BASE_YYYY + '/12';
				scope.gridApi.grid.refresh();
			}
			
			// 계약명
			var CONTRACT_NAME = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.CONTRACT_NAME" >{{row.entity.CONTRACT_NAME}}</div>';
			var CONTRACT_NAME_NEW = '<input ng-if="row.entity.IS_NEW != null" type="text" class="" ng-model="row.entity.CONTRACT_NAME" style="width: 100%; height: 100% !important;"/>';
			var CONTRACT_NAME_MOD = '<input ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" type="text" class="" ng-model="row.entity.CONTRACT_NAME" style="width: 100%; height: 100% !important;"/>';
			
			// 계약기간(시작)
			var START_YYYYMM = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.START_YYYYMM" >{{row.entity.START_YYYYMM}}</div>';
			var START_YYYYMM_NEW = '<input ng-if="row.entity.IS_NEW != null" type="text" class="calendar dtp_m" ng-model="row.entity.START_YYYYMM" style="width: 100%; height: 100% !important;" readonly="readonly"/>';
			var START_YYYYMM_MOD = '<input ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" type="text" class="calendar dtp_m" ng-model="row.entity.START_YYYYMM" style="width: 100%; height: 100% !important;" readonly="readonly"/>';
			
			// 계약기간(시작)
			var END_YYYYMM = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.END_YYYYMM" >{{row.entity.END_YYYYMM}}</div>';
			var END_YYYYMM_NEW = '<input ng-if="row.entity.IS_NEW != null" type="text" class="calendar dtp_m" ng-model="row.entity.END_YYYYMM" style="width: 100%; height: 100% !important;" readonly="readonly"/>';
			var END_YYYYMM_MOD = '<input ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" type="text" class="calendar dtp_m" ng-model="row.entity.END_YYYYMM" style="width: 100%; height: 100% !important;" readonly="readonly"/>';
			
			// 거래처
			var VENDOR_CODE = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.VENDOR_NAME" >{{row.entity.VENDOR_NAME}}</div>';
			var VENDOR_CODE_NEW =
				'<select ng-if="row.entity.IS_NEW != null" ng-model="row.entity.VENDOR_CODE" style="width: 100%; height: 100% !important;" >' + 
				'	<option ng-repeat="SB_VENDOR_CODE in grid.appScope.SB_VENDOR_CODE" ng-selected="row.entity.VENDOR_CODE == SB_VENDOR_CODE.CODE" value="{{SB_VENDOR_CODE.CODE}}" >{{SB_VENDOR_CODE.CODE_NAME}}</option>' + 
				'</select>';
			var VENDOR_CODE_MOD = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" class="ui-grid-cell-contents" ng-model="row.entity.VENDOR_NAME" >{{row.entity.VENDOR_NAME}}</div>';
			<%
			List<HashMap<String, Object>> cb_working_master_v = (List<HashMap<String, Object>>) request.getAttribute("cb_working_master_v");
			JSONArray json_cb_working_master_v = new JSONArray();
			for (int i = 0; i < cb_working_master_v.size(); i++) {
				JSONObject data= new JSONObject();
				data.put("CODE", cb_working_master_v.get(i).get("CODE"));
				data.put("CODE_NAME", cb_working_master_v.get(i).get("CODE_NAME"));
				json_cb_working_master_v.add(i, data);
			}
			%>
			// 거래처 콤보
			$scope.SB_VENDOR_CODE = <%=json_cb_working_master_v%>;
			$scope.SB_VENDOR_CODE.unshift({CODE:"", CODE_NAME:"선택"});
			
			// 담당부서
			var DEPT_CODE = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.DEPT_CODE" >{{row.entity.DEPT_CODE}}</div>';
			var DEPT_CODE_NEW = '<input ng-if="row.entity.IS_NEW != null" type="text" ng-model="row.entity.DEPT_CODE" style="height: 100%; width: calc(100% - 24px);" ng-keyup="grid.appScope.fnAjaxKOSTL(\'Z\', row, $event)"><img ng-if="row.entity.IS_NEW != null" src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(11, row)">';
			var DEPT_CODE_MOD = '<input ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" type="text" ng-model="row.entity.DEPT_CODE" style="height: 100%; width: calc(100% - 24px);" ng-keyup="grid.appScope.fnAjaxKOSTL(\'Z\', row, $event)"><img ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(11, row)">';
			
			// 코스트센터
			var COST_CODE = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.COST_CODE" >{{row.entity.COST_CODE}}</div>';
			var COST_CODE_NEW = '<input ng-if="row.entity.IS_NEW != null" type="text" ng-model="row.entity.COST_CODE" style="height: 100%; width: calc(100% - 24px);" ng-keyup="grid.appScope.fnAjaxKOSTL(\'C\', row, $event)"><img ng-if="row.entity.IS_NEW != null" src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(12, row)">';
			var COST_CODE_MOD = '<input ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" type="text" ng-model="row.entity.COST_CODE" style="height: 100%; width: calc(100% - 24px);" ng-keyup="grid.appScope.fnAjaxKOSTL(\'C\', row, $event)"><img ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(12, row)">';
			
			// 담당부서, 코스트센터 AJAX 이벤트
			$scope.fnAjaxKOSTL = function(type, row, event) {
				if(event.which !== 13){
					return false;
				}
				var data = row.entity;
				data.type = type;
				if (type == "Z") {
					if (row.entity.DEPT_CODE.length >= 8) {
						var token = $("meta[name='_csrf']").attr("content");
						var header = $("meta[name='_csrf_header']").attr("content");
						$.ajax({
							url : "/yp/zwc/ctr/retrieveAjaxDEPT",
							type : "post",
							cache : false,
							async : true,
							data : {
								type : data.type,
								DEPT_CODE : data.DEPT_CODE
							},
							dataType : "json",
							success : function(data) {
								if (data.result.KOST1 == "" || data.result.KOST1 == null || typeof data.result.KOST1 == "undefined") {
									swalWarningCB("일치하는 데이터가 없습니다.", function(){
										row.entity.DEPT_CODE = ""; //담당부서 코드
										row.entity.DEPT_NAME = ""; //담당부서 코드설명
										scope.gridApi.grid.refresh();
									});
								} else {
									row.entity.DEPT_CODE = data.result.KOST1; //담당부서 코드
									row.entity.DEPT_NAME = data.result.VERAK; //담당부서 코드설명
									scope.gridApi.grid.refresh();
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
								swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
					}
				} else {
					if (row.entity.COST_CODE.length >= 6) {
						var token = $("meta[name='_csrf']").attr("content");
						var header = $("meta[name='_csrf_header']").attr("content");
						$.ajax({
							url : "/yp/zfi/doc/retrieveAjaxKOSTL",
							type : "post",
							cache : false,
							async : true,
							data : {
								type : data.type,
								BUDAT : "${to_yyyy}",
								KOSTL : data.COST_CODE
							},
							dataType : "json",
							success : function(result) {
								if (result.KOST1 == "" || result.KOST1 == null) {
									swalWarningCB("일치하는 데이터가 없습니다.", function(){
										row.entity.COST_CODE = ""; //코스트센터 코드
										row.entity.COST_NAME = ""; //코스트센터 코드설명
										scope.gridApi.grid.refresh();
									});
								} else {
									row.entity.COST_CODE = result.KOST1; //코스트센터 코드
									row.entity.COST_NAME = result.VERAK; //코스트센터 코드설명
									scope.gridApi.grid.refresh();
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
								swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
					}
				}
			};
			
			// 팝업 조회
			$scope.fnSearchPopup = function(type, row) {
				var target = scope.gridOptions.data.indexOf(row.entity);
				fnSearchPopup(type, target);
			};
			
			// 도급구분
			var GUBUN_CODE = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.GUBUN_NAME" >{{row.entity.GUBUN_NAME}}</div>';
			var GUBUN_CODE_NEW =
				'<select ng-if="row.entity.IS_NEW != null" ng-model="row.entity.GUBUN_CODE" style="width: 100%; height: 100% !important;" >' + 
				'	<option ng-repeat="SB_GUBUN_CODE in grid.appScope.SB_GUBUN_CODE" ng-selected="row.entity.GUBUN_CODE == SB_GUBUN_CODE.CODE" value="{{SB_GUBUN_CODE.CODE}}" >{{SB_GUBUN_CODE.CODE_NAME}}</option>' + 
				'</select>';
			var GUBUN_CODE_MOD =
				'<select ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" ng-model="row.entity.GUBUN_CODE" style="width: 100%; height: 100% !important;" >' + 
				'	<option ng-repeat="SB_GUBUN_CODE in grid.appScope.SB_GUBUN_CODE" ng-selected="row.entity.GUBUN_CODE == SB_GUBUN_CODE.CODE" value="{{SB_GUBUN_CODE.CODE}}" >{{SB_GUBUN_CODE.CODE_NAME}}</option>' + 
				'</select>';
			<%
			List<HashMap<String, Object>> cb_gubun = (List<HashMap<String, Object>>) request.getAttribute("cb_gubun");
			JSONArray json_cb_gubun = new JSONArray();
			for (int i = 0; i < cb_gubun.size(); i++) {
				JSONObject data= new JSONObject();
				data.put("CODE", cb_gubun.get(i).get("CODE"));
				data.put("CODE_NAME", cb_gubun.get(i).get("CODE_NAME"));
				json_cb_gubun.add(i, data);
			}
			%>
			// 도급구분 콤보
			$scope.SB_GUBUN_CODE = <%=json_cb_gubun%>;
			$scope.SB_GUBUN_CODE.unshift({CODE:"", CODE_NAME:"선택"});
			
			// 공장구분
			var FACTORY_CODE = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.FACTORY_NAME" >{{row.entity.FACTORY_NAME}}</div>';
			var FACTORY_CODE_NEW =
				'<select ng-if="row.entity.IS_NEW != null" ng-model="row.entity.FACTORY_CODE" style="width: 100%; height: 100% !important;" >' + 
				'	<option ng-repeat="SB_FACTORY_CODE in grid.appScope.SB_FACTORY_CODE" ng-selected="row.entity.FACTORY_CODE == SB_FACTORY_CODE.CODE" value="{{SB_FACTORY_CODE.CODE}}" >{{SB_FACTORY_CODE.CODE_NAME}}</option>' + 
				'</select>';
			var FACTORY_CODE_MOD =
				'<select ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" ng-model="row.entity.FACTORY_CODE" style="width: 100%; height: 100% !important;" >' + 
				'	<option ng-repeat="SB_FACTORY_CODE in grid.appScope.SB_FACTORY_CODE" ng-selected="row.entity.FACTORY_CODE == SB_FACTORY_CODE.CODE" value="{{SB_FACTORY_CODE.CODE}}" >{{SB_FACTORY_CODE.CODE_NAME}}</option>' + 
				'</select>';
			<%
			List<HashMap<String, Object>> cb_gubun2 = (List<HashMap<String, Object>>) request.getAttribute("cb_gubun2");
			JSONArray json_cb_gubun2 = new JSONArray();
			for (int i = 0; i < cb_gubun2.size(); i++) {
				JSONObject data= new JSONObject();
				data.put("CODE", cb_gubun2.get(i).get("CODE"));
				data.put("CODE_NAME", cb_gubun2.get(i).get("CODE_NAME"));
				json_cb_gubun2.add(i, data);
			}
			%>
			// 공장구분 콤보
			$scope.SB_FACTORY_CODE = <%=json_cb_gubun2%>;
			$scope.SB_FACTORY_CODE.unshift({CODE:"", CODE_NAME:"선택"});
			
			// 단위
			var UNIT_CODE = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.UNIT_NAME" >{{row.entity.UNIT_NAME}}</div>';
			var UNIT_CODE_NEW =
				'<select ng-if="row.entity.IS_NEW != null" ng-model="row.entity.UNIT_CODE" style="width: 100%; height: 100% !important;" >' + 
				'	<option ng-repeat="SB_UNIT_CODE in grid.appScope.SB_UNIT_CODE" ng-selected="row.entity.UNIT_CODE == SB_UNIT_CODE.CODE" value="{{SB_UNIT_CODE.CODE}}" >{{SB_UNIT_CODE.CODE_NAME}}</option>' + 
				'</select>';
			var UNIT_CODE_MOD =
				'<select ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" ng-model="row.entity.UNIT_CODE" style="width: 100%; height: 100% !important;" >' + 
				'	<option ng-repeat="SB_UNIT_CODE in grid.appScope.SB_UNIT_CODE" ng-selected="row.entity.UNIT_CODE == SB_UNIT_CODE.CODE" value="{{SB_UNIT_CODE.CODE}}" >{{SB_UNIT_CODE.CODE_NAME}}</option>' + 
				'</select>';
			<%
			List<HashMap<String, Object>> cb_working_master_u = (List<HashMap<String, Object>>) request.getAttribute("cb_working_master_u");
			JSONArray json_cb_working_master_u = new JSONArray();
			for (int i = 0; i < cb_working_master_u.size(); i++) {
				JSONObject data= new JSONObject();
				data.put("CODE", cb_working_master_u.get(i).get("CODE"));
				data.put("CODE_NAME", cb_working_master_u.get(i).get("CODE_NAME"));
				json_cb_working_master_u.add(i, data);
			}
			%>
			// 단위 콤보
			$scope.SB_UNIT_CODE = <%=json_cb_working_master_u%>;
			$scope.SB_UNIT_CODE.unshift({CODE:"", CODE_NAME:"선택"});
			
			// 소급시작일
			var RETROACT_START_DATE = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.RETROACT_START_DATE" >{{row.entity.RETROACT_START_DATE}}</div>';
			var RETROACT_START_DATE_NEW = '<input ng-if="row.entity.IS_NEW != null" type="text" class="calendar dtp_d" ng-model="row.entity.RETROACT_START_DATE" style="width: 100%; height: 100% !important;" readonly="readonly"/>';
			var RETROACT_START_DATE_MOD = '<input ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" type="text" class="calendar dtp_d" ng-model="row.entity.RETROACT_START_DATE" style="width: 100%; height: 100% !important;" readonly="readonly"/>';
			
			// 소급종료일
			var RETROACT_END_DATE = '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.RETROACT_END_DATE" >{{row.entity.RETROACT_END_DATE}}</div>';
			var RETROACT_END_DATE_NEW = '<input ng-if="row.entity.IS_NEW != null" type="text" class="calendar dtp_d" ng-model="row.entity.RETROACT_END_DATE" style="width: 100%; height: 100% !important;" readonly="readonly"/>';
			var RETROACT_END_DATE_MOD = '<input ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" type="text" class="calendar dtp_d" ng-model="row.entity.RETROACT_END_DATE" style="width: 100%; height: 100% !important;" readonly="readonly"/>';
			
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
					displayName : '연도',
					field : 'BASE_YYYY',
					width : '80',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : BASE_YYYY + BASE_YYYY_NEW + BASE_YYYY_MOD
				}, {
					displayName : '코드',
					field : 'CONTRACT_CODE',
					width : '80',
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
					allowCellFocus : false,
					cellTemplate : CONTRACT_NAME + CONTRACT_NAME_NEW + CONTRACT_NAME_MOD
				}, {
					displayName : '계약기간(시작)',
					field : 'START_YYYYMM',
					width : '130',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : START_YYYYMM + START_YYYYMM_NEW + START_YYYYMM_MOD
				}, {
					displayName : '계약기간(종료)',
					field : 'END_YYYYMM',
					width : '130',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : END_YYYYMM + END_YYYYMM_NEW + END_YYYYMM_MOD
				}, {
					displayName : '거래처',
					field : 'VENDOR_CODE',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : VENDOR_CODE + VENDOR_CODE_NEW + VENDOR_CODE_MOD
				}, {
					displayName : '담당부서',
					field : 'DEPT_CODE',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : DEPT_CODE + DEPT_CODE_NEW + DEPT_CODE_MOD
				}, {
					displayName : '담당부서명',
					field : 'DEPT_NAME',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '코스트센터',
					field : 'COST_CODE',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : COST_CODE + COST_CODE_NEW + COST_CODE_MOD
				}, {
					displayName : '코스트센터명',
					field : 'COST_NAME',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '도급구분',
					field : 'GUBUN_CODE',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : GUBUN_CODE + GUBUN_CODE_NEW + GUBUN_CODE_MOD
				}, {
					displayName : '단위',
					field : 'UNIT_CODE',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : UNIT_CODE + UNIT_CODE_NEW + UNIT_CODE_MOD
				}, {
					displayName : '소급시작일',
					field : 'RETROACT_START_DATE',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : RETROACT_START_DATE + RETROACT_START_DATE_NEW + RETROACT_START_DATE_MOD
				}, {
					displayName : '소급종료일',
					field : 'RETROACT_END_DATE',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : RETROACT_END_DATE + RETROACT_END_DATE_NEW + RETROACT_END_DATE_MOD
				}, {
					displayName : '연장',
					field : 'EXTENSION_YN',
					width : '80',
					visible : false,
					cellClass : "relatvie_box",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input class="absolute_center" type="checkbox" style="margin:0 0 0 0; width:15%; height:auto;" ng-checked="row.entity.EXTENSION_YN ==\'Y\'" disabled>'
				}, {
					displayName : '종료',
					field : 'END_YN',
					width : '80',
					visible : false,
					cellClass : "relatvie_box",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input class="absolute_center" type="checkbox" style="margin:0 0 0 0; width:15%; height:auto;" ng-checked="row.entity.END_YN ==\'Y\'" disabled>'
				}, {
					displayName : '수시작업',
					field : 'WORKING_GUBUN',
					width : '100',
					visible : true,
					cellClass : "relatvie_box",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input class="absolute_center" type="checkbox" style="margin:0 0 0 0; width:15%; height:auto;" ng-checked="row.entity.WORKING_GUBUN ==\'Y\'" ng-click="grid.appScope.checkboxClick(\'WORKING_GUBUN\', row)">'
				}, {
					displayName : '공장구분',
					field : 'FACTORY_CODE',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : FACTORY_CODE + FACTORY_CODE_NEW + FACTORY_CODE_MOD 
				}]
			});
			$scope.checkboxClick = function(fieldName, row){
				if(row.entity[fieldName] == "N"){
					row.entity[fieldName] = "Y";
				}else if(row.entity[fieldName] == "Y"){
					row.entity[fieldName] = "N";
				}
			}
			
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
				listQuery : "yp_zwc_ctr.select_zwc_ctr", //list가져오는 마이바티스 쿼리 아이디
				cntQuery : "yp_zwc_ctr.select_zwc_ctr_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
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
			$(".modal_dtp_y").datepicker({
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
				$('.datepicker').hide();
			});
			
			// 부트스트랩 날짜객체
			$(document).on("focus", ".dtp_y", function() {
				$(this).datepicker({
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
					$('.datepicker').hide();
				});
			});
			
			// 부트스트랩 날짜객체
			$(document).on("focus", ".dtp_m", function() {
				$(this).datepicker({
					format: "yyyy/mm",
					viewMode: "months",
					minViewMode: "months",
					language : "ko",
					todayHighlight : true,
					autoclose : true,
					clearBtn : true,
					updateViewDate : false
				}).on('changeDate', function(e) {
					$(this).val(formatDate_m(e.date.valueOf())).trigger("change");
					$('.datepicker').hide();
				});
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
				scope.reloadGrid({
					BASE_YYYY_S : $("#BASE_YYYY_S").val(),
					BASE_YYYY_E : $("#BASE_YYYY_E").val(),
					VENDOR_CODE : $("#VENDOR_CODE").val(),
					CONTRACT_NAME : $("#CONTRACT_NAME").val(),
					DEPT_CODE : $("#DEPT_CODE").val(),
					DEPT_NAME : $("#DEPT_NAME").val(),
					GUBUN_CODE : $("#GUBUN_CODE").val(),
					UNIT_CODE : $("#UNIT_CODE").val()
				});
			});
			
			// 엑셀 다운로드
			$("#excel_btn").on("click", function() {
				//20191023_khj for csrf
				var csrf_element = document.createElement("input");
				csrf_element.name = "_csrf";
				csrf_element.value = "${_csrf.token}";
				csrf_element.type = "hidden";
				//20191023_khj for csrf
				var xlsForm = document.createElement("form");

				xlsForm.target = "xlsx_download";
				xlsForm.name = "sndFrm";
				xlsForm.method = "post";
				xlsForm.action = "/yp/xls/zwc/ctr/zwc_ctr_select";

				document.body.appendChild(xlsForm);

				xlsForm.appendChild(csrf_element);

				var pr = {
						BASE_YYYY_S : $("#BASE_YYYY_S").val(),
						BASE_YYYY_E : $("#BASE_YYYY_E").val(),
						VENDOR_CODE : $("#VENDOR_CODE").val(),
						CONTRACT_NAME : $("#CONTRACT_NAME").val(),
						DEPT_CODE : $("#DEPT_CODE").val(),
						DEPT_NAME : $("#DEPT_NAME").val(),
						GUBUN_CODE : $("#GUBUN_CODE").val(),
						UNIT_CODE : $("#UNIT_CODE").val()
				};

				$.each(pr, function(k, v) {
					console.log(k, v);
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

			// 추가
			$("#fnAdd").on("click", function() {
				scope.addRow({
					IS_NEW : "Y",
					IS_MOD : "",
					BASE_YYYY : "${to_yyyy}",
					CONTRACT_CODE : "",
					CONTRACT_NAME : "",
					START_YYYYMM : "${to_yyyy}/01", // 1월 기본값
					END_YYYYMM : "${to_yyyy}/12", // 12월 기본값
					VENDOR_CODE : "",
					DEPT_CODE : "",
					DEPT_NAME : "",
					COST_CODE : "",
					COST_NAME : "",
					GUBUN_CODE : "",
					UNIT_CODE : "",
					RETROACT_START_DATE : "",
					RETROACT_END_DATE : "",
					EXTENSION_YN : "N",
					END_YN : "N",
					WORKING_GUBUN : "N"
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
					if(d.IS_NEW === "Y"){
						return true;
					}
					d.IS_MOD = "Y";
				});
				scope.gridApi.grid.refresh();
			});
			
			// 삭제
			$("#fnRem").on("click", function() {
				var rows = scope.gridApi.selection.getSelectedRows();
				if(rows.length === 0){
					swalWarningCB("삭제할 항목을 선택하세요.");
					return false;
				}
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				var exist_yn = false;
				$.ajax({
					url : "/yp/zwc/ctr/zwc_ctr_delete_chk",
					type : "POST",
					cache : false,
					async : false,
					dataType : "json",
					data : {
						ROW_NO: JSON.stringify(rows)
					},
					success : function(data) {
						if(data.cnt > 0){
							exist_yn = true;
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
						swalDangerCB("삭제 실패하였습니다.\n관리자에게 문의해주세요.");
					}
				});
				if(exist_yn){
					swalWarningCB("도급일보가 등록된 계약이 선택되어 삭제할 수 없습니다.");
					return false;
				}
				if (confirm("선택된 도급계약의 【계약내용】, 【계약별 보호구 수량】, 【계약별 유해인자】가 함께 삭제됩니다.\n\n 정말 삭제하시겠습니까?")) {
					$.ajax({
						url : "/yp/zwc/ctr/zwc_ctr_delete",
						type : "POST",
						cache : false,
						async : true,
						dataType : "json",
						data : {
							ROW_NO: JSON.stringify(rows)
						},
						success : function(data) {
							swalSuccessCB(data.result + "건 삭제했습니다.", function(){
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
							swalDangerCB("삭제 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
				}
			});
			
			// 저장
			$("#fnCtr").on("click", function() {
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
						url : "/yp/zwc/ctr/zwc_ctr_save",
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
			
			// 참조생성
			$("#fnRef").on("click", function() {
				var rows = scope.gridApi.selection.getSelectedRows();
				ref_rows = [];
				
				$.each(rows, function(i, d){
					if(d.IS_NEW === "Y"){
						return true;
					}else{
						ref_rows.push(d);
					}
				});
				
				// 초기화
				$("#RefModal #BASE_YYYY_NEW").val("${to_yyyy}");
				$("#RefModal #info").empty();
				$("#RefModal #ctr_cnt").text(ref_rows.length + " 건");
				$.each(ref_rows, function(i, d){
					if(i === 0){
						$("#RefModal #info").append("【연도: " + d.BASE_YYYY + ", 계약코드: " + d.CONTRACT_CODE + ", 거래처명: " + d.VENDOR_NAME + "】");
					}else{
						$("#RefModal #info").append("<br>【연도: " + d.BASE_YYYY + ", 계약코드: " + d.CONTRACT_CODE + ", 거래처명: " + d.VENDOR_NAME + "】");
					}
				});
				
				if(ref_rows.length === 0){
					swalWarningCB("참조생성할 항목을 선택하세요.");
					return false;
				}
				
				$("#RefModal").modal({
					backdrop : false,
					keyboard: false
				});
			});
			
			// 처음에 바로 조회
			$("#search_btn").trigger("click");
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
				fnHrefPopup("/yp/popup/zwc/ctr/retrieveDEPT", "담당부서 검색", {
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
			$.each(rows, function(i, d){
				if(d.BASE_YYYY == ""){
					swalWarningCB("연도를 입력하세요.");
					check = false;
					return false;
				}else if(d.CONTRACT_NAME == ""){
					swalWarningCB("계약명을 입력하세요.");
					check = false;
					return false;
				}else if(d.START_YYYYMM == ""){
					swalWarningCB("계약기간(시작)을 입력하세요.");
					check = false;
					return false;
				}else if(d.END_YYYYMM == ""){
					swalWarningCB("계약기간(종료)을 입력하세요.");
					check = false;
					return false;
				}else if(d.VENDOR_CODE == ""){
					swalWarningCB("거래처를 입력하세요.");
					check = false;
					return false;
				}else if(d.DEPT_CODE == ""){
					swalWarningCB("담당부서를 입력하세요.");
					check = false;
					return false;
				}else if(d.GUBUN_CODE == ""){
					swalWarningCB("도급구분을 입력하세요.");
					check = false;
					return false;
				}else if(d.UNIT_CODE == ""){
					swalWarningCB("단위를 입력하세요.");
					check = false;
					return false;
				}else if(d.GUBUN_CODE == "2" && d.UNIT_CODE !== "U7" && d.UNIT_CODE !== "U8"){
					// 2020-11-04 jamerl - 조용래 : 인력 계약은 단위 인, 매만 입력 가능
					swalWarningCB("도급구분 【인력】계약은 단위【인】,【매】만 선택할 수 있습니다.");
					check = false;
					return false;
				}else if(d.GUBUN_CODE == "1" && (d.UNIT_CODE === "U7" || d.UNIT_CODE === "U8")){
					// 2020-11-04 jamerl - 조용래 : 물량 계약은 단위 인, 매로 입력 불가능
					swalWarningCB("도급구분 【물량】계약은 단위【인】,【매】를 선택할 수 없습니다.");
					check = false;
					return false;
				}
			});
			return check;
		}
	</script>
	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
	<script>
		var ref_rows = [];
		$(document).ready(function(){
			$("#ref_save").on("click",function(){
				if (confirm("참조생성하시겠습니까?")) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zwc/ctr/zwc_ctr_ref_save",
						type : "POST",
						cache : false,
						async : true,
						dataType : "json",
						data : {
							BASE_YYYY_NEW: $("#BASE_YYYY_NEW").val().trim(),
							ROW_NO: JSON.stringify(ref_rows)
						},
						success : function(result) {
							console.log(result);
							swalWarningCB("작업완료했습니다.\n결과를 확인해주세요.", function(){
								$("#ref_exit").trigger("click");
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
							swalDangerCB("참조생성 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
				}
			});
			
			$("#RefModal").on("hide.bs.modal",function(){});
		});
	</script>
	<div class="modal fade" id="RefModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="width: 600px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title">참조생성</h4>
				</div>
				<div class="modal-body">
					<div class="popup_tblType01" style="margin: 0">
						<table class="tableTypeInput" border="0" cellpadding="0" cellspacing="0">
							<colgroup>
								<col width="110px;"/>
								<col />
							</colgroup>
							<tr>
								<th>생성년도</th>
								<td>
									<input type="text" id="BASE_YYYY_NEW" class="calendar modal_dtp_y" value="${to_yyyy}" readonly="readonly"/>
								</td>
							</tr>
							<tr>
								<th>대상정보</th>
								<td id="info">
								</td>
							</tr>
							<tr>
								<th>계약건수</th>
								<td id="ctr_cnt">
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="modal-footer">
					<input type="button" class="btn" id="ref_save" value="저장" />
					<input type="button" class="btn" id="ref_exit" data-dismiss="modal" value="닫기" >
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
</body>