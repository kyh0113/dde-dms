<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
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
//JSTL에서 사용할 수 있도록 세팅
request.setAttribute("toDay", toDay);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>데이터조회</title>
</head>
<body>
	<h2>
		데이터조회
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
	<form id="ent_frm" name="ent_frm" method="post">
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="TYPE">
		<input type="hidden" name="ENT_CODE">
		<input type="hidden" name="ENT_NAME">
		<input type="hidden" name="ENT_TYPE">
		<input type="hidden" name="ADMIN_ID">
		<input type="hidden" name="ADMIN_PW">
		<input type="hidden" name="PHONE">
		<input type="hidden" name="EMAIL">
		<input type="hidden" name="WORKER">
		<input type="hidden" name="WORKER_NAME">
		<input type="hidden" name="REG_DATE">
		<input type="hidden" name="UPD_DATE">
	</form>
	<form id="frm" name="frm" method="post">
		<input type="hidden" name="excel_flag" />
		<input type="hidden" id="url" value=""/>
		<input type="hidden" name="page" id="page" value="${paginationInfo.currentPageNo}" />
		<input type="hidden" name="page_rows" value="" />
		<section>
			<div class="tbl_box">
				<table cellspacing="0" cellpadding="0">
<%-- 					<colgroup> --%>
<%-- 						<col width="5%" /> --%>
<%-- 						<col width="25%" /> --%>
<%-- 						<col width="5%" /> --%>
<%-- 						<col width="25%" /> --%>
<%-- 						<col width="5%" /> --%>
<%-- 						<col width="25%" /> --%>
<%-- 					</colgroup> --%>
					<tr>
						<th>날짜</th>
						<td>
							<input type="text" id="A_START_DATE" class="calendar search_dtp" value="${toDay}" readonly="readonly"/>
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
								<option value="" data-base-yyyy="">= 선택 = </option>
								<c:forEach var="row" items="${cb_tbl_working_subc}" varStatus="status">
									<option value="${row.CODE}" data-base-yyyy="${row.BASE_YYYY}">${row.CODE_NAME}</option>
								</c:forEach>
							</select>
						</td>
						<th>작업자</th>
						<td>
							<input type="hidden" id="SUBC_CODE" />
							<input type="text" id="SUBC_NAME" readonly="readonly" style="background: #e5e5e5 url(/resources/yp/images/ic_search.png) 100% 50% no-repeat;"/>
							<input type="button" id="SUBC_NAME_CLS" class="btn" value="X" style="background-color: #269bf3; line-height: 13px; color: white;" />
						</td>
					</tr>
				</table>
				<div class="btn_wrap">
					<input type="button" class="btn btn_make" id="excel_btn" value="엑셀 다운로드"/>
					<input type="button" class="btn btn_search" id="search_btn" value="조회"/>
				</div>
			</div>
		</section>
	</form>
	<div class="float_wrap">
		<div class="fl">
			<div class="stitle">업체목록</div>
		</div>
		<div class="fr">
			<div class="btn_wrap">
				&nbsp;
			</div>
		</div>
	</div>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="shdsCtrl" style="height: auto;">
			<div data-ui-i18n="ko" style="height: 580px;">
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
			
			$scope.uiGridConstants = uiGridConstants;
			
			$scope.pagination = vm.pagination;

			// 세션아이디코드 스코프에저장
			$scope.s_emp_code = "${s_emp_code}";
			
			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu:true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바
				showColumnFooter : false,
				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 1000,

				enableCellEditOnFocus : false, //셀 클릭시 edit모드 
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

				columnDefs : 
				[ //컬럼 세팅
					{
						displayName : '날짜',
						field : 'DT',
						width : '150',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					}, 
					{
						displayName : '도급관리코드',
						field : 'SUBC_CODE',
						width : '10',
						visible : false,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					}, 
					{
						displayName : '작업자',
						field : 'SUBC_NAME',
						width : '10%',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					}, 
					{
						displayName : '계약코드',
						field : 'CONTRACT_CODE',
						width : '10',
						visible : false,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					}, 
					{
						displayName : '계약명',
						field : 'CONTRACT_NAME',
						visible : true,
						cellClass : "left",
						enableCellEdit : false,
						allowCellFocus : false
					}, 
					{
						displayName : '입장시간',
						field : 'A_START_DATE',
						width : '150',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					}, 
					{
						displayName : '퇴장시간',
						field : 'A_END_DATE',
						width : '150',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					}, 
					{
						displayName : '구분',
						field : 'KTEXT',
						width : '200',
						visible : true,
						cellClass : "left",
						enableCellEdit : false,
						allowCellFocus : false
					}
				]
			});

			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  

		} ]);

		$(document).ready(function() {
			// 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
			scope = angular.element(document.getElementById("shds-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
			scope.gridApi.selection.on.rowSelectionChanged(scope, function(row) { //로우 선택할때마다 이벤트
				// 				console.log("row2", row.entity);
			});
			scope.gridApi.selection.on.rowSelectionChangedBatch(scope, function(rows) { //전체선택시 가져옴
				// 				console.log("row3", rows[0].entity); //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
			});
			// pagenation option setting  그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param = {
				EXEC_RFC  : "N", // RFC 여부
				cntQuery  : "yp_zwc_ent2.grid_zwc_ent2_data_search_cnt", 	
				listQuery : "yp_zwc_ent2.grid_zwc_ent2_data_search"
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합

		
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
		});
	</script>
	<script type="text/javascript">
		var scope;
		$(document).ready(function() {
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
				fnSearchData();
			});
			
			// 작업자 초기화
			$("#SUBC_NAME_CLS").on("click", function() {
				$("#SUBC_CODE").val("");
				$("#SUBC_NAME").val("");
			});
			
			// 작업자
			$("#SUBC_NAME").on("click", function() {
// 				var target = scope.gridOptions.data.indexOf(row.entity);
				
				//파라메터 세팅
				var base_yyyy     = $("#CONTRACT_CODE :selected").data("base-yyyy");		//연도
				var vendor_code   = $("#VENDOR_CODE").val();		//거래처코드
				var vendor_name   = $("#VENDOR_CODE :selected").text();
				var contract_code = $("#CONTRACT_CODE").val();	//계약코드
				var contract_name = $("#CONTRACT_CODE :selected").text();	//계약명
				var ent_code      = "";		//협력사코드
				
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
				input5.value = vendor_name;
				input5.type  = "hidden";
				
// 				var input6   = document.createElement("input");
// 				input6.name  = "target";
// 				input6.value = target
// 				input6.type  = "hidden";
				
				window.open("","ent2_worker_popup","width=500,height=650,scrollbars=yes");
				
				form.method = "post";
				form.target = "ent2_worker_popup"
				form.action = "/yp/popup/zwc/ent2/zwc_ent2_data_search_worker_popup";
				
				form.appendChild(input0);
				form.appendChild(input1);
				form.appendChild(input2);
				form.appendChild(input3);
				form.appendChild(input4);
				form.appendChild(input5);
// 				form.appendChild(input6);
				
				document.body.appendChild(form);
				
				form.submit();
				form.remove();
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
				xlsForm.action = "/yp/xls/zwc/ent2/zwc_ent2_data_search";
	
				document.body.appendChild(xlsForm);
	
				xlsForm.appendChild(csrf_element);
				
				/*
				//페이징별 엑셀출력 필요한 경우 세팅 필수 start
				var totalItems = scope.gridOptions.totalItems;
				var pageNumber = scope.gridOptions.paginationCurrentPage;	//현재페이지
				var pageSize   = scope.gridOptions.paginationPageSize;		//한번에 보여줄 row수
				var start = 0;
				var end = 0;
				if(totalItems <= pageSize) pageNumber = 1;
				if(pageNumber == 1){
					start = (pageNumber);
					end   = pageSize;
				}else{
					start = (pageNumber-1)*pageSize+1;
					end   = (pageNumber)*pageSize;
				}
				//페이징별 엑셀출력 필요한 경우 세팅 필수 end
				*/
				
				var pr = {
					BASE_YYYY : $("#CONTRACT_CODE :selected").data("base-yyyy"),
					A_START_DATE : $("#A_START_DATE").val(),
					VENDOR_CODE : $("#VENDOR_CODE").val(),
					CONTRACT_CODE : $("#CONTRACT_CODE").val(),
					SUBC_CODE : $("#SUBC_CODE").val()
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
	
		});
		function formatDate_d(date) {
			var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
			if (month.length < 2)
				month = '0' + month;
			if (day.length < 2)
				day = '0' + day;
			return [ year, month, day ].join('/');
		}
	
		function fnSearchData(){
			scope.reloadGrid({
				BASE_YYYY : $("#CONTRACT_CODE :selected").data("base-yyyy"),
				A_START_DATE : $("#A_START_DATE").val(),
				VENDOR_CODE : $("#VENDOR_CODE").val(),
				CONTRACT_CODE : $("#CONTRACT_CODE").val(),
				SUBC_CODE : $("#SUBC_CODE").val()
			});
		}

		
		function fnImgPop(url){
			window.open("/yp/popup/imgPopup?url="+encodeURIComponent(url),"imgPop","width=580,height=780");
		}
		
		function fnEntDetail(type, row){
			//form 초기화
			 $("form[name='ent_frm']").each(function() {
			       this.reset();
			      $("input[type=hidden]").val(''); //reset만으로 hidden type은 리셋이 안되기 때문에 써줌
			 });

			 if(type=="MOD"){
			 	$("#ent_frm input[name=TYPE]").val(type);
	 			$("#ent_frm input[name=ENT_CODE]").val(row.entity.ENT_CODE);
	 			$("#ent_frm input[name=ENT_NAME]").val(row.entity.ENT_NAME);
	 			$("#ent_frm input[name=ENT_TYPE]").val(row.entity.ENT_TYPE);
	 			$("#ent_frm input[name=ADMIN_ID]").val(row.entity.ADMIN_ID);
	 			$("#ent_frm input[name=ADMIN_PW]").val(row.entity.ADMIN_PW);
	 			$("#ent_frm input[name=PHONE]").val(row.entity.PHONE);
	 			$("#ent_frm input[name=EMAIL]").val(row.entity.EMAIL);
	 			$("#ent_frm input[name=WORKER]").val(row.entity.WORKER);
	 			$("#ent_frm input[name=WORKER_NAME]").val(row.entity.WORKER_NAME);
	 			$("#ent_frm input[name=REG_DATE]").val(row.entity.REG_DATE);
	 			$("#ent_frm input[name=UPD_DATE]").val(row.entity.UPD_DATE);
			}
			 
			$("#ent_frm input[name=TYPE]").val(type);
			$("#ent_frm input[name=_csrf]").val('${_csrf.token}');
			
			window.open("","ENT_POP","scrollbars=yes,width=800,height=400");
			document.ent_frm.target = "ENT_POP";
			document.ent_frm.action = "/yp/popup/zwc/ent/entDetail"; 
			 
			$("#ent_frm").submit();
		}
	</script>
	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
</body>