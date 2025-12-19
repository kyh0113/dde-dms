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

Date dt = new Date();
SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/dd");
String today = date.format(dt);
// JSTL에서 사용할 수 있도록 세팅
request.setAttribute("today", today);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>작업자 출입현황</title>
</head>
<body>
	<form id="frm" name="frm" method="post">
		<!-- 20191023_khj for csrf -->
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
	<h2>
		작업자 출입현황
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
	<section>
		<div class="tbl_box">
			<table cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="3%" />
					<col width="30%" />
					<col width="3%" />
					<col width="30%" />
					<col width="3%" />
					<col width="30%" />
				</colgroup>
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
					<th>공장</th>
					<td>
						<select id="FACTORY_CODE">
							<option value="">전체</option>
							<c:forEach var="row" items="${cb_gubun2}" varStatus="status">
								<option value="${row.CODE}">${row.CODE_NAME}</option>
							</c:forEach>
						</select>
					</td>
					<th>코스트센터</th>
					<td>
						<input type="text" name="COST_CODE" id="COST_CODE" size="6" maxlength="6"/>
						<a href="#" onclick="fnSearchPopup();"><img src="/resources/yp/images/ic_search.png"></a>
						<input type="text" name="COST_NAME" id="COST_NAME" readonly="readonly" style="background-color: #e5e5e5;"/>
					</td>
				</tr>
				<tr>
					<th>작업명</th>
					<td>
						<input type="text" name="CONTRACT_NAME" id="CONTRACT_NAME" />
					</td>
					<th>작업자</th>
					<td>
						<input type="text" name="SUBC_NAME" id="SUBC_NAME" />
					</td>
					<th>기간</th>
					<td>
						<input type="text" id="S_START_DATE_FROM" class="default_hide calendar search_dtp_d" value="${today}" readonly="readonly"/>&nbsp;~&nbsp;
						<input type="text" id="S_START_DATE_TO" class="default_hide calendar search_dtp_d" value="${today}" readonly="readonly"/>
					</td>
				</tr>
			</table>
			<div class="btn_wrap">
				<input type=button class="btn btn_search" id="search_btn" value="조회">
			</div>
		</div>
	</section>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="shdsCtrl">
			<div data-ui-i18n="ko" style="height: 615px;">
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
			paginationOptions.pageSize = 1000; //초기 한번에 보여질 로우수
			$scope.paginationOptions = paginationOptions;

			$scope.gridApi = vm.gridApi; //외부에서 grid의 클릭이벤트와 같은것들을 쓰기 위해서
			$scope.loader = vm.loader;
			$scope.addRow = vm.addRow;

			$scope.pagination = vm.pagination;

			// 세션아이드코드 스코프에저장
			$scope.s_emp_code = "${s_emp_code}";

			$scope.uiGridConstants = uiGridConstants;
			
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
				enableAutoFitColumns : true, //컬럼 width를 자동조정
				multiSelect : true, //여러로우선택
				enablePagination : true,
				enablePaginationControls : true,

				columnDefs : [ //컬럼 세팅
				{
					displayName : '업체명',
					field : 'CODE_NAME',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '작업자',
					field : 'USER_NAME',
					width : '85',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '수시구분',
					field : 'WORKING_GUBUN',
					width : '95',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '단말기 이름',
					field : 'COMPANY_NAME',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '공장',
					field : 'FACTORY_CODE',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div ng-if="row.entity.FACTORY_CODE != null && row.entity.FACTORY_CODE != \'\'" class="ui-grid-cell-contents ng-binding ng-scope">{{row.entity.FACTORY_CODE}}공장</div>',
					footerCellTemplate: '<div class="ui-grid-cell-contents right" >{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
				}, {
					displayName : '코스트센터',
					field : 'COST_NAME',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '작업명',
					field : 'CONTRACT_NAME',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '출퇴근',
					field : 'ACCESS_STATUS',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div ng-if="row.entity.ACCESS_STATUS == \'1\'" class="ui-grid-cell-contents ng-binding ng-scope">출근</div> <div ng-if="row.entity.ACCESS_STATUS == \'2\'" class="ui-grid-cell-contents ng-binding ng-scope">퇴근</div>'
				}, {
					displayName : '체크시간',
					field : 'A_DATE',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}]
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
				listQuery : "yp_zwc_cmt.select_zwc_cmt_list_dt", //list가져오는 마이바티스 쿼리 아이디
				cntQuery : "yp_zwc_cmt.select_zwc_cmt_list_dt_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
			
			// 부트스트랩 날짜객체
			$(".search_dtp_d").datepicker({
				format: "yyyy/mm/dd",
				viewMode: "days",
				minViewMode: "days",
				language : "ko",
				todayHighlight : true,
				autoclose : true,
				clearBtn : true,
				updateViewDate : false
			}).on('changeDate', function(e) {
				$(this).val(formatDate_d(e.date.valueOf())).trigger("change");
				$("#search_btn").trigger("click");
				$('.datepicker').hide();
			});
			
			// 조회
			$("#search_btn").on("click", function() {
				scope.reloadGrid({
					VENDOR_CODE   : $("#VENDOR_CODE").val(),		//거래처코드
					CONTRACT_NAME : $("#CONTRACT_NAME").val(),		//작업명
					SUBC_NAME     : $("#SUBC_NAME").val(),			//작업자명
					FACTORY_CODE  : $("#FACTORY_CODE").val(),		//공장코드
					COST_CODE     : $("#COST_CODE").val(),			//코스트센터
					S_START_DATE_FROM: $("#S_START_DATE_FROM").val(),	//날짜(출입일FROM)
					S_START_DATE_TO  : $("#S_START_DATE_TO").val(),		//날짜(출입일TO)
				});
			});
			
			// 필터 토글
			$("#filter_btn").on("click", function() {
				scope.gridOptions.enableFiltering = !scope.gridOptions.enableFiltering;
				scope.gridApi.core.notifyDataChange( scope.uiGridConstants.dataChange.COLUMN );
			});
		});
		
		function fnSearchPopup(){
			window.open("", "코스트센터 검색", "width=600, height=800");
			fnHrefPopup("/yp/popup/zwc/cmt/retrieveKOSTL", "코스트센터 검색", {
				type : "C"
			});
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
		
		function fnValidation(){
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
		
		function formatDate_d(date) {
			var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
			if (month.length < 2)
				month = '0' + month;
			if (day.length < 2)
				day = '0' + day;
			return [ year, month, day ].join('/');
		}
	</script>
</body>