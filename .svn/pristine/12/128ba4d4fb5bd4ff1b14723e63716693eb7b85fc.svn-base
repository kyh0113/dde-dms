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

Calendar cal = Calendar.getInstance();
cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.getActualMinimum(Calendar.DATE));
String from_yyyy = date.format(cal.getTime());

// JSTL에서 사용할 수 있도록 세팅
request.setAttribute("to_yyyy", to_yyyy);
request.setAttribute("from_yyyy", from_yyyy);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>일보등록 모니터링 현황</title>
</head>
<body>
	<!-- 20191023_khj for csrf -->
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<h2>
		일보등록 모니터링 현황
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
							<input type="text" id="BASE_YYYY_S" class="calendar search_dtp" value="${from_yyyy}" readonly="readonly"/>　~　
							<input type="text" id="BASE_YYYY_E" class="calendar search_dtp" value="${to_yyyy}" readonly="readonly"/>
						</td>
						<th>부서명</th>
						<td>
							<c:choose>
								<c:when test="${'SA' eq auth || 'MA' eq auth || 'IM' eq auth || 'CA' eq auth}">
<%-- 								<c:when test="${'SA' eq sessionScope.WC_AUTH || 'MA' eq sessionScope.WC_AUTH || 'IM' eq sessionScope.WC_AUTH}"> --%>
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
						<th>&nbsp;</th>
						<td>&nbsp;</td>
					</tr>
				</table>
				<div class="btn_wrap">
					<input type=button class="btn btn_search" id="search_btn"	value="조회">
				</div>
			</div>
		</section>
	</form>
<!-- 	<div class="float_wrap" style="margin-bottom: 2px;"> -->
<!-- 		<div class="fl"> -->
<!-- 		</div> -->
<!-- 		<div class="fr"> -->
<!-- 		</div> -->
<!-- 	</div> -->
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="shdsCtrl">
			<div data-ui-i18n="ko" style="height: 640px;">
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

			// 콤마
			$scope.fnAddComma = function(obj) {
				return addComma(obj);
			};
			
			$scope.fnPercent = function(obj) {
				return obj + "%";
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
					displayName : '계약명',
					field : 'CONTRACT_NAME',
// 					width : '105',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '담당부서',
					field : 'DEPT_NAME',
					width : '115',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '입력대상',
					field : 'INPUT_TARGET',
					width : '115',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.fnAddComma(row.entity.INPUT_TARGET)}}</div>'
				}, {
					displayName : '입력수',
					field : 'INPUT_CNT',
					width : '105',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.fnAddComma(row.entity.INPUT_CNT)}}</div>'
				}, {
					displayName : '입력률',
					field : 'INPUT_RATE',
					width : '105',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.fnPercent(row.entity.INPUT_RATE)}}</div>'
				}, {
					displayName : '작업량입력대상',
					field : 'WORK_INPUT_TARGET',
					width : '145',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.fnAddComma(row.entity.WORK_INPUT_TARGET)}}</div>'
				}, {
					displayName : '작업량입력수',
					field : 'WORK_INPUT_CNT',
					width : '135',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.fnAddComma(row.entity.WORK_INPUT_CNT)}}</div>'
				}, {
					displayName : '작업량입력률',
					field : 'WORK_INPUT_RATE',
					width : '135',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.fnPercent(row.entity.WORK_INPUT_RATE)}}</div>'
				}, {
					displayName : '팀장승인률',
					field : 'TEAM_LEADER_CONFIRM_RATE',
					width : '125',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.fnPercent(row.entity.TEAM_LEADER_CONFIRM_RATE)}}</div>'
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
				multiSelect : false, //여러로우선택
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
				listQuery :	"yp_zwc_ipt.select_tbl_working_daily_monitor", //list가져오는 마이바티스 쿼리 아이디
				cntQuery :	"yp_zwc_ipt.select_tbl_working_daily_monitor_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
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
			
			// 조회
			$("#search_btn").on("click", function() {
				var base_yyyy_s = Number($("#BASE_YYYY_S").val().replace(/\//gi, ''));
				var base_yyyy_e = Number($("#BASE_YYYY_E").val().replace(/\//gi, ''));
				if(base_yyyy_s > base_yyyy_e){
					swalWarningCB("일자 구간을 정확히 입력하세요.");
					return false;
				}
				
				scope.reloadGrid({
					BASE_YYYY_S : $("#BASE_YYYY_S").val(),
					BASE_YYYY_E : $("#BASE_YYYY_E").val(),
					DEPT_CODE : $("#DEPT_CODE").val()
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
		/*콤마 추가*/
		function addComma(num) {
			return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		}

		/*콤마 제거*/
		function unComma(num) {
			return num.replace(/,/gi, '');
		}
	</script>
</body>