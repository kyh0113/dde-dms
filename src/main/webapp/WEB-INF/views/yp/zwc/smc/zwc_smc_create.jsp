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
<title>분할입금 등록</title>
</head>
<body>
	<!-- 20191023_khj for csrf -->
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<h2>
		분할입금 등록
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
<!-- 							<select id="BASE_YYYY" onchange="javascript: $('#search_btn').trigger('click');"> -->
<%-- 								<c:forEach var="i" begin="0" end="${to_yyyy - from_yyyy}">JSTL 역순 출력 - 연도 --%>
<%-- 									<c:set var="yearOption" value="${to_yyyy - i}" /> --%>
<%-- 									<option value="${yearOption}">${yearOption}</option> --%>
<%-- 								</c:forEach> --%>
<!-- 							</select> -->
							<input type="text" id="BASE_YYYY" class="calendar search_dtp_y" value="${to_yyyy}" readonly="readonly"/>
						</td>
						<th>거래처</th>
						<td>
							<select id="VENDOR_CODE" onchange="javascript: $('#search_btn').trigger('click');">
								<option value="">전체</option>
								<c:forEach var="row" items="${cb_working_master_v}" varStatus="status">
									<option value="${row.CODE}">${row.CODE_NAME}</option>
								</c:forEach>
							</select>
						</td>
						<th>&nbsp;</th>
						<td>&nbsp;</td>
					</tr>
				</table>
				<div class="btn_wrap">
					<button class="btn btn_make" id="excel_btn" type="">엑셀 다운로드</button>
					<button class="btn btn_search" id="search_btn" type="">조회</button>
				</div>
			</div>
		</section>
	</form>
	<div class="float_wrap" style="margin-bottom: 2px;">
		<div class="fl">
			<div class="btn_wrap">&nbsp;</div>
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type=button class="btn_g" id="fnStr"	value="저장">
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
				enableAutoFitColumns : true, //컬럼 width를 자동조정
				multiSelect : true, //여러로우선택
				enablePagination : true,
				enablePaginationControls : true,

				columnDefs : [ //컬럼 세팅
				{
					displayName : '연도',
					field : 'BASE_YYYY',
					width : '80',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '거래처',
					field : 'VENDOR_CODE',
					width : '1',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '거래처명',
					field : 'VENDOR_NAME',
// 					width : '200',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '1월',
					field : 'MONTH1',
					width : '80',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.MONTH1" class="number" style="width: 100%; height: 100% !important; text-align: right;">'
				}, {
					displayName : '2월',
					field : 'MONTH2',
					width : '80',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.MONTH2" class="number" style="width: 100%; height: 100% !important; text-align: right;">'
				}, {
					displayName : '3월',
					field : 'MONTH3',
					width : '80',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.MONTH3" class="number" style="width: 100%; height: 100% !important; text-align: right;">'
				}, {
					displayName : '4월',
					field : 'MONTH4',
					width : '80',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.MONTH4" class="number" style="width: 100%; height: 100% !important; text-align: right;">'
				}, {
					displayName : '5월',
					field : 'MONTH5',
					width : '80',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.MONTH5" class="number" style="width: 100%; height: 100% !important; text-align: right;">'
				}, {
					displayName : '6월',
					field : 'MONTH6',
					width : '80',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.MONTH6" class="number" style="width: 100%; height: 100% !important; text-align: right;">'
				}, {
					displayName : '7월',
					field : 'MONTH7',
					width : '80',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.MONTH7" class="number" style="width: 100%; height: 100% !important; text-align: right;">'
				}, {
					displayName : '8월',
					field : 'MONTH8',
					width : '80',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.MONTH8" class="number" style="width: 100%; height: 100% !important; text-align: right;">'
				}, {
					displayName : '9월',
					field : 'MONTH9',
					width : '80',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.MONTH9" class="number" style="width: 100%; height: 100% !important; text-align: right;">'
				}, {
					displayName : '10월',
					field : 'MONTH10',
					width : '80',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.MONTH10" class="number" style="width: 100%; height: 100% !important; text-align: right;">'
				}, {
					displayName : '11월',
					field : 'MONTH11',
					width : '80',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.MONTH11" class="number" style="width: 100%; height: 100% !important; text-align: right;">'
				}, {
					displayName : '12월',
					field : 'MONTH12',
					width : '80',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.MONTH12" class="number" style="width: 100%; height: 100% !important; text-align: right;">'
				} ]
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
				listQuery : "yp_zwc_smc.select_zwc_smc", //list가져오는 마이바티스 쿼리 아이디
				cntQuery : "yp_zwc_smc.select_zwc_smc_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
			
			// 숫자포멧터
			$(document).on('change', '.number', function(){
				$(this).val(Number($(this).val()));
			});
			
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
			
			// 조회
			$("#search_btn").on("click", function() {
				scope.reloadGrid({
					BASE_YYYY : $("#BASE_YYYY").val(),
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
				xlsForm.action = "/yp/xls/zwc/smc/zwc_smc_select";

				document.body.appendChild(xlsForm);

				xlsForm.appendChild(csrf_element);

				var pr = {
						BASE_YYYY : $("#BASE_YYYY").val(),
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
					START_YYYYMM : "",
					END_YYYYMM : "",
					VENDOR_CODE : "",
					DEPT_CODE : "",
					DEPT_NAME : "",
					COST_CODE : "",
					COST_NAME : "",
					GUBUN_CODE : "",
					UNIT_CODE : ""
				}, true, "asc");
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
						url : "/yp/zwc/smc/zwc_smc_save",
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
				swalInfoCB("설계 대기중");
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
		function fnValidation(rows){
			var check = true;
			$.each(rows, function(i, d){
				if(isNaN(Number(d.MONTH1))){
					swalWarningCB("입력 내용을 확인하세요.");
					check = false;
					return false;
				}else if(isNaN(Number(d.MONTH2))){
					swalWarningCB("입력 내용을 확인하세요.");
					check = false;
					return false;
				}else if(isNaN(Number(d.MONTH3))){
					swalWarningCB("입력 내용을 확인하세요.");
					check = false;
					return false;
				}else if(isNaN(Number(d.MONTH4))){
					swalWarningCB("입력 내용을 확인하세요.");
					check = false;
					return false;
				}else if(isNaN(Number(d.MONTH5))){
					swalWarningCB("입력 내용을 확인하세요.");
					check = false;
					return false;
				}else if(isNaN(Number(d.MONTH6))){
					swalWarningCB("입력 내용을 확인하세요.");
					check = false;
					return false;
				}else if(isNaN(Number(d.MONTH7))){
					swalWarningCB("입력 내용을 확인하세요.");
					check = false;
					return false;
				}else if(isNaN(Number(d.MONTH8))){
					swalWarningCB("입력 내용을 확인하세요.");
					check = false;
					return false;
				}else if(isNaN(Number(d.MONTH9))){
					swalWarningCB("입력 내용을 확인하세요.");
					check = false;
					return false;
				}else if(isNaN(Number(d.MONTH10))){
					swalWarningCB("입력 내용을 확인하세요.");
					check = false;
					return false;
				}else if(isNaN(Number(d.MONTH11))){
					swalWarningCB("입력 내용을 확인하세요.");
					check = false;
					return false;
				}else if(isNaN(Number(d.MONTH12))){
					swalWarningCB("입력 내용을 확인하세요.");
					check = false;
					return false;
				}
			});
			return check;
		}
	</script>
	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
</body>