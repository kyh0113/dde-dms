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

Calendar cal = Calendar.getInstance();
cal.setTime(today);
cal.add(Calendar.DATE, -3);
String from_yyyy = date.format(cal.getTime());
//JSTL에서 사용할 수 있도록 세팅
request.setAttribute("from_yyyy", from_yyyy);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>
<c:if test="${menu.breadcrumb[0].menu_id ne null}">
	${menu.breadcrumb[0].menu_name}
</c:if>
</title>
<style type="text/css">
.table td, .table th {
	padding: 0.4rem !important;
}
</style>
</head>
<body>
	<h2>
		<c:if test="${menu.breadcrumb[0].menu_id ne null}">
			${menu.breadcrumb[0].menu_name}
		</c:if>
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
	<div class="float_wrap">
		<div class="fl">
			<div class="stitle"></div>
		</div>
	</div>
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<section style="margin-bottom: 1em;">
		<div class="tbl_box">
			<table class="contract_standard_table" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="5%" />
					<col width="28%" />
					<col width="5%" />
					<col width="28%" />
					<col width="5%" />
					<col width="28%" />
				</colgroup>
				<tr>
					<th>거래처</th>
					<td>
						<input type="text" id="SAP_CODE" name="SAP_CODE" size="10" readonly="readonly" value="" style="background-color: #e5e5e5;" />
						<input type="hidden" id="VENDOR_CODE" name="VENDOR_CODE" size="10" value="" />
						<a href="#" onclick="fnSearchPopup('1');"><img src="/resources/yp/images/ic_search.png"></a>
						<input type="text" id="VENDOR_NAME" name="VENDOR_NAME" disabled="disabled" style="width: 200px;" value="" />
					</td>
					<th>계약</th>
					<td>
						<input type="text" id="CONTRACT_CODE" name="CONTRACT_CODE" size="10" readonly="readonly" />
						<a href="#" onclick="fnSearchPopup('2');"><img src="/resources/yp/images/ic_search.png"></a>
						<input type="text" id="CONTRACT_NAME" name="CONTRACT_NAME" disabled="disabled" style="width: 200px;" />
					</td>
					<th>일보기간</th>
					<td>
						<input type="text" id="WORK_DT_S" name="WORK_DT_S" class="calendar search_dtp" value="${from_yyyy}" readonly="readonly" />　~　
						<input type="text" id="WORK_DT_E" name="WORK_DT_E" class="calendar search_dtp" value="${to_yyyy}" readonly="readonly" />
					</td>
				</tr>
				<tr>
					<th>승인여부</th>
					<td>
						<select id="APRV_CHK">
							<option value="">= 전체 =</option>
							<option value="미승인">미승인</option>
							<option value="승인">승인</option>
						</select>
					</td>
					<th>지급기준</th>
					<td colspan="3">
						<select id="PAY_STANDARD">
							<option value="">= 전체 =</option>
							<option value="1">공수</option>
							<option value="2">작업</option>
							<option value="3">월정액</option>
						</select>
					</td>
				</tr>
			</table>
			<div class="btn_wrap">
				<button class="btn btn_search" id="search_btn" type="button">조회</button>
			</div>
		</div>
	</section>
	<div class="float_wrap" style="margin-bottom: 1em;">
		<div class="fl">
			<div class="btn_wrap">
				※【일보일자】를 더블클릭하면 【일보승인】화면으로 이동합니다.
			</div>
			<div class="btn_wrap">
				※【계약코드】를 더블클릭하면 【계약등록】화면으로 이동합니다.
			</div>
		</div>
		<div class="fr">
			<div class="btn_wrap" style="margin-bottom: 5px;">&nbsp;</div>
		</div>
	</div>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="shdsCtrl">
			<div data-ui-i18n="ko" style="height: 575px;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
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
		$scope.deleteRow = vm.deleteRow;
		$scope.deleteRowOne = vm.deleteRowOne;
		$scope.searchCnt = vm.searchCnt;
		$scope.uiGridConstants = uiGridConstants;
		$scope.pagination = vm.pagination;
		
		// 세션아이디코드 스코프에저장
		$scope.s_emp_code = "${s_emp_code}";

		//자식팝업에서 부모창의 콜백함수 실행
		$window.inviteCallback = function() { };

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

		//계약등록 페이지 이동
		$scope.link_contract = function(row) {
			f_href("/yp/zcs/ctr/zcs_ctr_manh_create", {
				CONTRACT_CODE : row.CONTRACT_CODE,
				hierarchy : "000006"
			});
		};

		//일보승인 페이지 이동
		$scope.link_aprv = function(row) {
			var u, h, cc, cn, vc, vn, ec, wd, cpc, drpc;
			if(row.PAY_STANDARD === "1"){
				u = "/yp/zcs/ipt2/zcs_ipt2_daily_aprv1";
			}else if(row.PAY_STANDARD === "2"){
				u = "/yp/zcs/ipt2/zcs_ipt2_daily_aprv2";
			}else if(row.PAY_STANDARD === "3"){
				u = "/yp/zcs/ipt2/zcs_ipt2_daily_aprv3";
			}else{
				return false;
			}
			f_href(u, {
				  P_RESPONSE_VIEW : "Y"
				, P_CONTRACT_CODE : row.CONTRACT_CODE
				, P_CONTRACT_NAME : row.CONTRACT_NAME
				, P_VENDOR_CODE : row.VENDOR_CODE
				, P_VENDOR_NAME : row.VENDOR_NAME
				, P_ENT_CODE : row.ENT_CODE
				, P_CONTRACT_PEOPLE_CNT : row.CONTRACT_PEOPLE_CNT
				, P_DAILY_REQ_PEOPLE_CNT : row.DAILY_REQ_PEOPLE_CNT
				, P_WORK_DT : row.WORK_DT_VIEW
				, hierarchy : "000006"
			});
		};

		var columnDefs1 = [ 
			{
				displayName : '지급기준코드',
				field : 'PAY_STANDARD',
				width : '100',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, {
				displayName : '거래처코드',
				field : 'VENDOR_CODE',
				width : '100',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, {
				displayName : '거래처SAP코드',
				field : 'ENT_CODE',
				width : '100',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, {
				displayName : '계약인원',
				field : 'CONTRACT_PEOPLE_CNT',
				width : '100',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, {
				displayName : '일일 필수 출근 인원',
				field : 'DAILY_REQ_PEOPLE_CNT',
				width : '100',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, {
				displayName : '일보일자',
				field : 'WORK_DT',
				width : '115',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, {
				displayName : '확정여부',
				field : 'CONFIRM_CHK',
				width : '115',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents">{{row.entity.CONFIRM_CHK}} ( {{row.entity.CNT_CONFIRM}} / {{row.entity.CNT}} )</div>'
			}, {
				displayName : '승인여부',
				field : 'APRV_CHK',
				width : '115',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents">{{row.entity.APRV_CHK}} ( {{row.entity.CNT_APRV}} / {{row.entity.CNT}} )</div>'
			}, {
				displayName : '거래처',
				field : 'VENDOR_NAME',
				width : '155',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, {
				displayName : '일보일자',
				field : 'WORK_DT_VIEW',
				width : '115',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full pointer" style="color:blue" ng-dblclick="grid.appScope.link_aprv(row.entity)" ng-model="row.entity.WORK_DT_VIEW">{{row.entity.WORK_DT_VIEW}}</div>'
			}, {
				displayName : '지급기준',
				field : 'PAY_STANDARD_TXT',
				width : '115',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, {
				displayName : '계약명',
				field : 'CONTRACT_NAME',
				visible : true,
				cellClass : "left",
				enableCellEdit : false,
				allowCellFocus : false
			}, {
				displayName : '계약코드',
				field : 'CONTRACT_CODE',
				width : '115',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full pointer" style="color:blue" ng-dblclick="grid.appScope.link_contract(row.entity)" ng-model="row.entity.CONTRACT_CODE">{{row.entity.CONTRACT_CODE}}</div>'
			}, {
				displayName : '남은시간',
				field : 'CONTRACT_START_DATE',
				width : '115',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents">실시간 불가</div>'
			} ];

			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu : true, //필터버튼
				enableFiltering : false, //각 컬럼에 검색바
				showColumnFooter : false,
				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 1000,
				enableCellEditOnFocus : true, //셀 클릭시 edit모드 
				enableSelectAll : false, //전체선택 체크박스
				enableRowSelection : true, //로우 선택
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
				columnDefs : columnDefs1,
				onRegisterApi : function(gridApi) {
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
			//그리드 렌더링 후 이벤트
			scope.gridApi.core.on.rowsRendered(scope, function() {  });
			//로우 선택할때마다 이벤트 
			//console.log("row2", row.entity);
			scope.gridApi.selection.on.rowSelectionChanged(scope, function(row) {  });//전체선택시 가져옴
			//console.log("row3", rows[0].entity);
			//전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
			scope.gridApi.selection.on.rowSelectionChangedBatch(scope, function(rows) {  });
			// pagenation option setting  그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param = {
				EXEC_RFC : "N", // RFC 여부
				cntQuery : "yp_zcs_ipt2.select_grid_daily_rpt_view_cnt",
				listQuery : "yp_zcs_ipt2.select_grid_daily_rpt_view"
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
				scope.reloadGrid({
					  WORK_DT_S : $("#WORK_DT_S").val()
					, WORK_DT_E : $("#WORK_DT_E").val()
					, CONTRACT_CODE : $("#CONTRACT_CODE").val()
					, VENDOR_CODE : $("#VENDOR_CODE").val()
					, PAY_STANDARD : $("#PAY_STANDARD").val()
					, APRV_CHK : $("#APRV_CHK").val()
// 					  WORK_DT_S : '2021/11/01'
// 					, WORK_DT_E : '2021/11/30'
// 					, CONTRACT_CODE : '202125003'
// 					, VENDOR_CODE : 'V25'
// 					, PAY_STANDARD : '3'
// 					, APRV_CHK : '미승인'
				});
			});
		});
		
		/* 팝업 */
		function fnSearchPopup(type, target) {
			var w;
			if (type == "1") {
				w = window.open("/yp/popup/zcs/ctr/select_working_master_v", "업체 검색", "width=600, height=800");
			}else if(type == "2"){
				w = window.open("","계약명 검색","width=600,height=800,scrollbars=yes");
				// 지급기준별 조회 조건 추가 - {1:공수, 2: 작업, 3: 월정액} 
				fnHrefPopup("/yp/popup/zcs/ctr/retrieveContarctName", "계약명 검색", {
					PAY_STANDARD : $("#PAY_STANDARD").val()
				});
			}else if (type == "3") {
				w = window.open("", "SAP 오더 검색", "width=900, height=800, scrollbars=yes");
				fnHrefPopup("/yp/popup/zcs/ipt/sapPop", "SAP 오더 검색", {
					target : target,
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