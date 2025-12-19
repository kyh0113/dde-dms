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
String toDay = date.format(today);

//한달 
Calendar mon = Calendar.getInstance();
mon.add(Calendar.MONTH , -1);
String beforeMonthDay = date.format(mon.getTime());
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>검수보고서(월정액) 상세보기</title>
<script type="text/javascript">
	var scope;
	$(document).ready(function() {
		// 부트스트랩 날짜객체
		$(".dtp").datepicker({
			format : "yyyy/mm",
			language : "ko",
			viewMode: "months", 
		    minViewMode: "months",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		});
		
		$(".dtp2").datepicker({
			format : "yyyy/mm/dd",
			language : "ko",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		});
		
		//조회조건 default
		//오늘날짜 세팅
		if($("input[name=BASE_YYYYMM]").val() == ""){
			$("input[name=BASE_YYYYMM]").val("<%=toDay%>");	
		}
		
		$('input').on('keydown', function(event) {
			if(event.keyCode==13) 
				return false;
		});
	});
</script>
</head>
<body>
	<h2>
		검수보고서(월정액) 상세보기
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
	
	<form id="frm" name="frm">
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="SAP_CODE" size="10" readonly="readonly" style="background-color: #e5e5e5;"/>
		<input type="hidden" name="VENDOR_CODE" size="10"/>
		<input type="hidden" name="VENDOR_NAME" disabled="disabled"  style="width:200px;"/>
		<input type="hidden" name="CONTRACT_CODE" size="10"/>
		<input type="hidden" name="CONTRACT_NAME" disabled="disabled"  style="width:200px;"/>
		<input type="hidden" name="BASE_YYYYMM" id="sdate" size="10" value="${req_data.sdate}"/>
		<div class="wrap" style="float:right;">
			<span>보고서코드</span>
			<input type="text" disabled="disabled"  name="REPORT_CODE"/>
		</div><div style="clear:both;"></div>
		
		
		<div class="float_wrap" style="margin-bottom: -25px;">
			<div class="fr">
				<div class="btn_wrap">
					<input type=button class="btn_g" id="save" value="저장">
				</div>
			</div>
		</div>
		<section class="section">
			<!-- 탭 부분 -->
			<!-- 
			<ul class="tabs">
				<li class="tab-link inspection_report current">검수보고서</li>
				<li class="tab-link work_history">작업내역</li>
				<li class="save_class" style="border:none; float:right;"><input type=button class="btn_g" id="save" value="저장"></li>
			</ul>
			-->
			<ul class="nav nav-tabs" style="display: flex !important;">
				<li class="nav-item">
					<a class="nav-link inspection_report active" data-toggle="tab" href="#inspection_report_content">검수보고서</a>
				</li>
				<li class="nav-item">
					<a class="nav-link work_history" data-toggle="tab" href="#work_history_content">작업내역</a>
				</li>
			</ul>
			<div class="tab-content tbl_box">
					<!-- 공통 테이블 ( 작업시작 ~ 작업종료 )  -->
					<table id="inspection_table_date" border="1" class="inspection_table" cellspacing="0" cellpadding="0" style="margin:auto; margin-top:10px; margin-bottom:10px; width:450px;">
						<colgroup>
							<col width="25%" />
							<col width="25%" />
							<col width="25%" />
							<col width="25%" />
						</colgroup>
					</table>
						
					<!-- 검수보고서 -->
					<div class="tab-pane show active" id="inspection_report_content">
					<!-- <div class="tab-content-contract inspection_report_content current"> -->
						<!-- 
						<input type="hidden"  name="VENDOR_CODE_RESULT" />
						<input type="hidden"  name="VENDOR_NAME_RESULT" />
						<input type="hidden"  name="CONTRACT_CODE_RESULT" />
						<input type="hidden"  name="CONTRACT_NAME_RESULT" />
						<input type="hidden"  name="BASE_YYYYMM_RESULT" />
						 -->
						<input type="hidden"  name="WBS_CODE1" />
						<input type="hidden"  name="WBS_CODE2" />
						<input type="hidden"  name="WBS_CODE3" />
						<input type="hidden"  name="WBS_CODE4" />
						<input type="hidden"  name="WBS_CODE5" />
						<input type="hidden"  name="WBS_CODE6" />
						<table border="1" class="inspection_table" id="inspection_table" cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="35%" />
								<col width="35%" />
								<col width="15%" />
								<col width="15%" />
							</colgroup>
						</table>
					</div>
					<!-- 작업내역 -->
					<div class="tab-pane" id="work_history_content">
					<!-- <div class="tab-content-contract work_history_content"> -->
						<section class="section">
							<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
							<div id="shds-uiGrid" data-ng-controller="shdsCtrl">
								<div data-ui-i18n="ko" style="height: 620px;">
									<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
										<div data-ng-if="loader" class="loader"></div>
										<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
									</div>
								</div>
							</div>
							<!-- 복붙영역(html) 끝 -->
						</section>
					</div>
				</div>
			</div>
		</section>
		<input type="hidden" name="ie_bug" id="ie_bug" value=""/> 
	</form>
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
		$window.inviteCallback = function() {
        
        };
       
		
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
		
		// 팝업 조회
		$scope.fnSearchPopup = function(type, row) {
			var target = scope.gridOptions.data.indexOf(row.entity);
			fnSearchPopup(type, target);
		};
		
		// 코스트센터 AJAX 이벤트
		$scope.fnAjaxKOSTL = function(type, row) {
			
			var data = row.entity;
			data.type = type;
			if (type == "C") {
				if (row.entity.COST_CODE == "" ) {
					swalWarningCB("코스트센터코드를 입력하세요.");
					// 							$("input[name=ZKOSTL_"+target+"]").focus();
					return false;
				}
				if (row.entity.COST_CODE != null && row.entity.COST_CODE.length >= 6) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zcs/ipt/retrieveAjaxKOSTL",
						type : "post",
						cache : false,
						async : true,
						data : data,
						dataType : "json",
						success : function(result) {
							if (result.KOST1 == "" || result.KOST1 == null) {
								swalWarningCB("일치하는 데이터가 없습니다.");
							} else {
								row.entity.COST_CODE = result.KOST1; //코스트센터 코드
								row.entity.COST_NAME = result.VERAK; //코스트센터 코드설명
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
							swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
				}
			}
		};

		var columnDefs1 = [
			{
				displayName : '월보년월',
				field : 'BASE_YYYYMM',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, 
			{
				displayName : '계약코드',
				field : 'CONTRACT_CODE',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, 
			{
				displayName : '업체코드',
				field : 'VENDOR_CODE',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, 
			{
				displayName : '순번',
				field : 'SEQ',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, 
			{
				displayName : '년',
				field : 'YYYY',
				width : '100',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, 
			{
				displayName : '월',
				field : 'MM',
				width : '100',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				footerCellTemplate: '<div class="ui-grid-cell-contents center">합계</div>'
			}, 
			{
				displayName : '일',
				field : 'DD',
				width : '100',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			},
			{
				displayName : '작업시작시간',
				field : 'WORK_START_TIME',
				width : '130',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			},
			{
				displayName : '작업종료시간',
				field : 'WORK_END_TIME',
				width : '130',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			},
			{
				displayName : '코스트센터코드',
				field : 'COST_CODE',
				width : '130',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			},
			{
				displayName : '코스트센터명',
				field : 'COST_NAME',
				width : '130',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			},
			{
				displayName : '작업내역',
				field : 'WORK_CONTENTS',
				visible : true,
				cellClass : "left",
				enableCellEdit : false,
				allowCellFocus : false
			},
			{
				displayName : 'SAP오더번호',
				field : 'ORDER_NUMBER',
				width : '130',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			},
			{
				displayName : '공수',
				field : 'MANHOUR',
				width : '100',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				aggregationType: $scope.uiGridConstants.aggregationTypes.sum,
				footerCellTemplate: '<div class="ui-grid-cell-contents center">{{col.getAggregationValue()}}</div>'
			}
		  ];
		
		
		$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
		{
			enableGridMenu: true,	 //필터버튼
			enableFiltering : false, //각 컬럼에 검색바
			showColumnFooter : true,
			paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
			paginationPageSize : 1000,
			enableCellEditOnFocus : true, //셀 클릭시 edit모드 
			enableSelectAll : false, //전체선택 체크박스
			enableRowSelection : false, //로우 선택
			enableRowHeaderSelection : false, //맨앞 컬럼 체크박스 컬럼으로
			selectionRowHeaderWidth : 35, //체크박스 컬럼 길이
			enableHorizontalScrollbar : "1",
			enableVerticalScrollbar : "1",
			rowHeight : 27, //체크박스 컬럼 높이
			// useExternalPagination : true, //pagination을 직접 세팅
			enableAutoFitColumns : true, //컬럼 width를 자동조정
			multiSelect : true, //여러로우선택
			enablePagination : true,
			enablePaginationControls : true,

			columnDefs : columnDefs1,
			
			onRegisterApi: function( gridApi ) {
			      $scope.gridApi = gridApi;
			 }
		});

		$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
		$scope.reloadGrid = vm.reloadGrid;
		//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  

	} ]);

	$(document).ready(function(){
		// 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
		scope = angular.element(document.getElementById("shds-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
		
		scope.gridApi.core.on.rowsRendered(scope, function() {	//그리드 렌더링 후 이벤트
			
		});
		scope.gridApi.selection.on.rowSelectionChanged(scope, function(row) { //로우 선택할때마다 이벤트
			//console.log("row2", row.entity);
		});
		scope.gridApi.selection.on.rowSelectionChangedBatch(scope, function(rows) { //전체선택시 가져옴
			//console.log("row3", rows[0].entity); //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
		});
		// pagenation option setting  그리드를 부르기 전에 반드시 선언
		// 테이블 조회는 
		// EXEC_RFC : "FI"
		
		var param = {};
		//보고서 코드가 있을때
		if(isEmpty('${REPORT_CODE}')){
			param = {
					EXEC_RFC  : "N", // RFC 여부
					cntQuery  : "yp_zcs_cpt.select_construction_monthly_rpt3_cnt", 	
					listQuery : "yp_zcs_cpt.select_construction_monthly_rpt3"
			};
		//보고서 코드가 없을때
		}else{
			param = {
					EXEC_RFC  : "N", // RFC 여부
					cntQuery  : "yp_zcs_cpt.select_construction_chk_rpt_dt2_cnt", 	
					listQuery : "yp_zcs_cpt.select_construction_chk_rpt_dt2",
					REPORT_CODE : '${REPORT_CODE}'
			};
		}
		scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
		//복붙영역(앵귤러 이벤트들 가져오기) 끝
		
		// 부트스트랩 날짜객체 hide
		$(document).on("focus", ".dtp", function() {
			$(this).datepicker({
				format : "yyyy/mm",
				language : "ko",
				todayHighlight : true,
				autoclose : true,
				clearBtn : true,
				updateViewDate : false
			}).on('changeDate', function (ev) {
				$(this).trigger("change");
				$('.datepicker').hide();
			});
		});
		
		$(document).on("focus", ".dtp2", function() {
			$(this).datepicker({
				format : "yyyy/mm/dd",
				language : "ko",
				todayHighlight : true,
				autoclose : true,
				clearBtn : true,
				updateViewDate : false
			}).on('changeDate', function (ev) {
				$(this).trigger("change");
				$('.datepicker').hide();
			});
		});
		
		//도급시작기간 변경 감지
		$('input[name=SUBCONTRACT_START_DATE]').datepicker({
			format : "yyyy/mm/dd",
			language : "ko",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		}).on('changeDate', function (ev) {
			$('.SUBCONTRACT_START_DATE_DISPLAY').html($(this).val());
		});
		
		//도급종료기간 변경 감지
		$('input[name=SUBCONTRACT_END_DATE]').datepicker({
			format : "yyyy/mm/dd",
			language : "ko",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		}).on('changeDate', function (ev) {
			$('.SUBCONTRACT_END_DATE_DISPLAY').html($(this).val());
		});
		
		// 조회
		$("#search_btn").on("click", function() {
			
			//거래처 빈값체크
			var SAP_CODE = $("input[name=SAP_CODE]").val();
			if(isEmpty(SAP_CODE)){
				swalWarningCB("거래처를 입력해주세요.");
				return false;
			}
			//계약코드 빈값체크
			var CONTRACT_CODE = $("input[name=CONTRACT_CODE]").val();
			if(isEmpty(CONTRACT_CODE)){
				swalWarningCB("계약코드를 입력해주세요.");
				return false;
			}
			
			var data = $("#frm").serializeArray();
			for(var i=0; i<data.length; i++){
				if(data[i]["name"] == "BASE_YYYYMM"){
//						data[i]["value"] = data[i]["value"].replace(/ /gi, "");// 모든 공백을 제거
					data[i]["value"] = data[i]["value"].replace("/", "");
					break;
				}
			}
			
			//보고서코드 초기화
			$('input[name=REPORT_CODE]').val('');
			
			//검수보고서 데이터 가져오기
			//1:거래처,계약코드,월보년월로 데이터가져오기
			//2:보고서코드로 데이터가져오기
			inspection_report('1');
			
			//작업내역 Grid 데이터 가져오기
			work_history('1');
			
		});
		
		/* 검수보고서 탭 클릭 */
		$(".section .inspection_report").on("click", function() {
			/* 탭 표시 */
			/* $('.section ul.tabs li').removeClass('current');
			$(this).addClass('current'); */
			
			/* 테이블 표시 */
			/* $('.section .tab-content-contract').removeClass('current');
			$('.section .inspection_report_content').addClass('current'); */
			
			//저장버튼 비활성화
			$("#save").hide();
			
		});
		
		/* 작업내역 탭 클릭 */
		$(".section .work_history").on("click", function() {
			
			/* $('.section ul.tabs li').removeClass('current');
			$(this).addClass('current'); */
			
			/* 테이블 표시 */
			/* $('.section .tab-content-contract').removeClass('current');
			$('.section .work_history_content').addClass('current'); */
			
			//저장버튼 활성화
			$("#save").show();
			
			scope.gridApi.grid.refresh();	//그리드 새로고침
		});
		
		/* 저장 */
		$("#save").on("click", function() {
			
			//검수기준일자
			var CHECK_BASE_DATE = $("input[name=CHECK_BASE_DATE]").val();
			//도급시작기간
			var SUBCONTRACT_START_DATE = $("input[name=SUBCONTRACT_START_DATE]").val();
			//도급종료기간
			var SUBCONTRACT_END_DATE = $("input[name=SUBCONTRACT_END_DATE]").val();
			//감독자
			var SUPERVISOR = $("input[name=SUPERVISOR]").val();
			//검수자
			var INSPECTOR = $("input[name=INSPECTOR]").val();
			
			//검수기준일자 빈값 체크
			if(isEmpty(CHECK_BASE_DATE)){
				swalWarningCB("검수보고서탭의 검수기준일자를 입력해주세요.");
				return;
			}
			
			//도급시작기간 빈값 체크
			if(isEmpty(SUBCONTRACT_START_DATE)){
				swalWarningCB("도급시작기간를 입력해주세요.");
				return;
			}
			
			//도급종료기간 빈값 체크
			if(isEmpty(SUBCONTRACT_END_DATE)){
				swalWarningCB("도급종료기간를 입력해주세요.");
				return;
			}
			
			//감독자 빈값 체크
			if(isEmpty(SUPERVISOR)){
				swalWarningCB("감독자를 입력해주세요.");
				return;
			}
			
			//검수자 빈값 체크
			if(isEmpty(INSPECTOR)){
				swalWarningCB("검수자를 입력해주세요.");
				return;
			}
			
			swal({
				  icon : "info",
				  text: "저장하시겠습니까?",
				  closeOnClickOutside : false,
				  closeOnEsc : false,
				  buttons: {
						confirm: {
						  text: "확인",
						  value: true,
						  visible: true,
						  className: "",
						  closeModal: true
						},
						cancel: {
						  text: "취소",
						  value: null,
						  visible: true,
						  className: "",
						  closeModal: true
						}
				  }
				})
				.then(function(result){
				  if(result){
					    var token = $("meta[name='_csrf']").attr("content");
						var header = $("meta[name='_csrf_header']").attr("content");
						
						var data = {
							REPORT_CODE : $("input[name=REPORT_CODE]").val(),
							/*  
							VENDOR_CODE : $("input[name=VENDOR_CODE_RESULT]").val(),
							VENDOR_NAME : $("input[name=VENDOR_NAME_RESULT]").val(),
							CONTRACT_CODE : $("input[name=CONTRACT_CODE_RESULT]").val(),
							CONTRACT_NAME : $("input[name=CONTRACT_NAME_RESULT]").val(),
							BASE_YYYYMM : $("input[name=BASE_YYYYMM_RESULT]").val().replace("/",""),
							*/
							VENDOR_CODE : $("input[name=VENDOR_CODE]").val(),
							VENDOR_NAME : $("input[name=VENDOR_NAME]").val(),
							CONTRACT_CODE : $("input[name=CONTRACT_CODE]").val(),
							CONTRACT_NAME : $("input[name=CONTRACT_NAME]").val(),
							BASE_YYYYMM : $("input[name=BASE_YYYYMM]").val().replace("/",""),
							WBS_CODE1 : $("input[name=WBS_CODE1]").val(),
							WBS_CODE2 :	$("input[name=WBS_CODE2]").val(),
							WBS_CODE3 : $("input[name=WBS_CODE3]").val(),
							WBS_CODE4 :	$("input[name=WBS_CODE4]").val(),
							WBS_CODE5 :	$("input[name=WBS_CODE5]").val(),
							WBS_CODE6 :	$("input[name=WBS_CODE6]").val(),
							CHECK_BASE_DATE : CHECK_BASE_DATE.replace("/","").replace("/",""),
							SUBCONTRACT_AMOUNT : unComma($(".SUBCONTRACT_AMOUNT ").html()),
							SUBCONTRACT_START_DATE : SUBCONTRACT_START_DATE.replace("/","").replace("/",""),
							SUBCONTRACT_END_DATE : SUBCONTRACT_END_DATE.replace("/","").replace("/",""),
							SUPERVISOR : SUPERVISOR,
							INSPECTOR : INSPECTOR
						};

						$.ajax({
							url : "/yp/zcs/cpt/zcs_cpt_mon_create_save",
							type : "POST",
							cache : false,
							async : true,
							dataType : "json",
							data : data,
							success : function(result) {
								//swalSuccessCB(result.result+"건이 저장 완료됐습니다.");
								if(result.result > 0){
									swalSuccessCB("저장 완료되었습니다.");
									$("input[name=REPORT_CODE]").val(result.REPORT_CODE);
								}else{
									swalWarningCB("이미 생성된 보고서는 새로 생성할 수 없습니다.");
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
								swalDangerCB("저장에 실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
						
				  }
				});
			
		});
		
		
		//검수보고서조회에서 검수보고서등록화면으로 넘어올 경우
		if(!isEmpty('${REPORT_CODE}')){
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			
			var report_code = '${REPORT_CODE}';
			var data = {'REPORT_CODE':report_code};
			
			//보고서코드에 값넣어주기
			$("input[name=REPORT_CODE]").val(report_code);
			
			$.ajax({
				url : "/yp/zcs/cpt/zcs_cpt_mon_create_select",
				type : "post",
				cache : false,
				async : false,//동기화
				data : data,
				dataType : "json",
				success : function(result) {
					var contstruction_report_list = result.contstruction_report_list;
					
					console.log('[TEST]contstruction_report_list:',contstruction_report_list);		
					var obj = contstruction_report_list[0];
					for(var key in obj){
						//계약코드 넣어주기
						if(key == "CONTRACT_CODE"){
							$("input[name=CONTRACT_CODE]").val(obj[key]);
						//계약명 넣어주기
						}else if(key == "CONTRACT_NAME"){
							$("input[name=CONTRACT_NAME]").val(obj[key]);
						//거래처 코드 넣어주기
						}else if(key == "VENDOR_CODE"){
							$("input[name=VENDOR_CODE]").val(obj[key]);
						//거래처 명 넣어주기
						}else if(key == "VENDOR_NAME"){
							$("input[name=VENDOR_NAME]").val(obj[key]);
						//월보년월 넣어주기
						}else if(key == "BASE_YYYYMM"){
							$("input[name=BASE_YYYYMM]").val(YYYYMM_format(obj[key]));
						//SAP_CODE 넣어주기
						}else if(key == "SAP_CODE"){
							$("input[name=SAP_CODE]").val(obj[key]);
						}
					}
					
					//검수보고서 데이터 가져오기
					//1:거래처,계약코드,월보년월로 데이터가져오기
					//2:보고서코드로 데이터가져오기
					inspection_report('2');
					
					//작업내역 Grid 데이터 가져오기
					work_history();
					
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
					swalDangerCB("조회에 실패하였습니다.\n관리자에게 문의해주세요.");
				}
			}); 
		}
		
		/* 검수보고서 트리거 클릭 */
		$(".section .inspection_report").trigger("click");
		
		
	});
	
	/* 팝업 */
	function fnSearchPopup(type, target) {
		if (type == "1") {
			window.open("/yp/popup/zcs/ctr/select_working_master_v", "업체 검색", "width=600, height=800");
		}else if(type == "2"){
			window.open("","계약명 검색","width=600,height=800,scrollbars=yes");
			// 지급기준별 조회 조건 추가 - {1:공수, 2: 작업, 3: 월정액}
			fnHrefPopup("/yp/popup/zcs/ctr/retrieveContarctName", "계약명 검색", {
				PAY_STANDARD : "3"
			});
		}else if (type == "3") {
			window.open("", "코스트센터 검색", "width=600, height=800");
			fnHrefPopup("/yp/popup/zcs/ipt/retrieveKOSTL", "코스트센터 검색", {
				type : "C",
				target : target
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
			var el = document.createElement("input");
			el.name = k;
			el.value = v;
			el.type = "hidden";
			popForm.appendChild(el);
		});

		popForm.submit();
		popForm.remove();
	}
	
	/*콤마 추가*/
	function addComma(num) {
		if(num != null && num != undefined) return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		else return "";
	}

	/*콤마 제거*/
	function unComma(num) {
		if(num != null && num != undefined) return num.replace(/,/gi, '');
		else return "";
	}
	
	//검수보고서 데이터 가져오기
	//1:거래처,계약코드,월보년월로 데이터가져오기
	//2:보고서코드로 데이터가져오기
	function inspection_report(flag){
		var data = $("#frm").serializeArray();
		for(var i=0; i<data.length; i++){
			if(data[i]["name"] == "BASE_YYYYMM"){
//					data[i]["value"] = data[i]["value"].replace(/ /gi, "");// 모든 공백을 제거
				data[i]["value"] = data[i]["value"].replace("/", "");
				break;
			}
		}
		
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		var url = "";
		//1:거래처,계약코드,월보년월로 데이터가져오기
		if(flag == '1'){
			url = "/yp/zcs/cpt/select_zcs_cpt_mon_create"
		//2:보고서코드로 데이터가져오기
		}else if(flag == "2"){
			url = "/yp/zcs/cpt/select_zcs_cpt_mon_create2"
			data.push({name: "REPORT_CODE", value: '${REPORT_CODE}'});
		}
		
		//검수보고서
		$.ajax({
			url : url,
			type : "POST",
			cache : false,
			async : false, //--동기화
			dataType : "json",
			data : data,
			success : function(result) {
				//상단
				var inspection_mon_list1 = result.inspection_mon_list1;
				//하단
				var inspection_mon_list2 = result.inspection_mon_list2;
				//construction_rpt_chk
				var construction_chk_rpt = result.construction_chk_rpt;
				
				console.log('[TEST]construction_chk_rpt:',construction_chk_rpt);
				console.log('[TEST]inspection_mon_list1:',inspection_mon_list1);
				console.log('[TEST]inspection_mon_list2:',inspection_mon_list2);
				
				//1:거래처,계약코드,월보년월로 데이터가져오기
				if(flag == '1'){
					//거래처, 계약코드, 월보년월중 값이 1개라도 null이면 그리지 말기
					if(inspection_mon_list2.length == 0 || isEmpty(inspection_mon_list2[0].VENDOR_CODE) || isEmpty(inspection_mon_list2[0].CONTRACT_CODE) || isEmpty(inspection_mon_list2[0].BASE_YYYYMM)){
						//table tr 초기화
				    	$("#inspection_table tr").remove();
				    	$("#inspection_table_date tr").remove();
						console.log('[TEST]하단 그리지 말기');
						return;
					}
				//2:보고서코드로 데이터가져오기
				}else if(flag == '2'){
					//거래처, 계약코드, 월보년월중 값이 1개라도 null이면 그리지 말기
					if(construction_chk_rpt.length == 0 || isEmpty(construction_chk_rpt[0].VENDOR_CODE) || isEmpty(construction_chk_rpt[0].CONTRACT_CODE) || isEmpty(construction_chk_rpt[0].BASE_YYYYMM)){
						//table tr 초기화
				    	$("#inspection_table tr").remove();
				    	$("#inspection_table_date tr").remove();
						console.log('[TEST]하단 그리지 말기(flag = 2)');
						return;
					}
				}
				
				//검수보고서 테이블 초기화
		    	tableInit();
				
				/*---------------- SUBCONTRACT_AMOUNT, SUBCONTRACT_START_DATE, SUBCONTRACT_END_DATE, SUPERVISOR, INSPECTOR 
				값 넣어주기 ---------------------*/
				if(!isEmpty(construction_chk_rpt)){
					$('input[name=CHECK_BASE_DATE]').val(YYYYMMDD_format(construction_chk_rpt[0].CHECK_BASE_DATE));
					$('input[name=SUBCONTRACT_START_DATE]').val(YYYYMMDD_format(construction_chk_rpt[0].SUBCONTRACT_START_DATE));
					$('input[name=SUBCONTRACT_END_DATE]').val(YYYYMMDD_format(construction_chk_rpt[0].SUBCONTRACT_END_DATE));
					$('input[name=SUPERVISOR]').val(construction_chk_rpt[0].SUPERVISOR);
					$('input[name=INSPECTOR]').val(construction_chk_rpt[0].INSPECTOR);
					$('.SUBCONTRACT_START_DATE_DISPLAY').html(YYYYMMDD_format(construction_chk_rpt[0].SUBCONTRACT_START_DATE));
					$('.SUBCONTRACT_END_DATE_DISPLAY').html(YYYYMMDD_format(construction_chk_rpt[0].SUBCONTRACT_END_DATE));
					
					/*  
					$("input[name=CONTRACT_CODE_RESULT]").val(construction_chk_rpt[0].CONTRACT_CODE);
					$("input[name=CONTRACT_NAME_RESULT]").val(construction_chk_rpt[0].CONTRACT_NAME);
					$("input[name=VENDOR_CODE_RESULT]").val(construction_chk_rpt[0].VENDOR_CODE);
					$("input[name=VENDOR_NAME_RESULT]").val(construction_chk_rpt[0].VENDOR_NAME);
					*/
					$("input[name=WBS_CODE1]").val(construction_chk_rpt[0].WBS_CODE1);
					$("input[name=WBS_CODE2]").val(construction_chk_rpt[0].WBS_CODE2);
					$("input[name=WBS_CODE3]").val(construction_chk_rpt[0].WBS_CODE3);
					$("input[name=WBS_CODE4]").val(construction_chk_rpt[0].WBS_CODE4);
					$("input[name=WBS_CODE5]").val(construction_chk_rpt[0].WBS_CODE5);
					$("input[name=WBS_CODE6]").val(construction_chk_rpt[0].WBS_CODE6);
					//$("input[name=BASE_YYYYMM_RESULT]").val(YYYYMM_format(construction_chk_rpt[0].BASE_YYYYMM));
					//---------------- 상단 테이블 데이터 넣어주기 ---------------------------
					//상단 : 맨위부터 ~ 공정구분행 까지.
					var WBS_CODE = construction_chk_rpt[0].WBS_CODE;
					var CONTRACT_NAME = construction_chk_rpt[0].CONTRACT_NAME;
					var VENDOR_NAME = construction_chk_rpt[0].VENDOR_NAME;
					
					$(".WBS_CODE").html(WBS_CODE);
					$(".CONTRACT_NAME").html(CONTRACT_NAME);
					$(".VENDOR_NAME").html(VENDOR_NAME);
					//----------------------------------------------------------------
				}
				
				/*---------------- VENDOR_CODE, VENDOR_NAME,CONTRACT_CODE, CONTRACT_NAME,
				WBS_CODE1~6, BASE_YYYYMM 값 넣어주기 ---------- */
				if(!isEmpty(inspection_mon_list1)){
					//$("input[name=CONTRACT_CODE_RESULT]").val(inspection_mon_list1[0].CONTRACT_CODE);
					//$("input[name=CONTRACT_NAME_RESULT]").val(inspection_mon_list1[0].CONTRACT_NAME);
					//$("input[name=VENDOR_CODE_RESULT]").val(inspection_mon_list1[0].VENDOR_CODE);
					//$("input[name=VENDOR_NAME_RESULT]").val(inspection_mon_list1[0].VENDOR_NAME);
					$("input[name=WBS_CODE1]").val(inspection_mon_list1[0].WBS_CODE1);
					$("input[name=WBS_CODE2]").val(inspection_mon_list1[0].WBS_CODE2);
					$("input[name=WBS_CODE3]").val(inspection_mon_list1[0].WBS_CODE3);
					$("input[name=WBS_CODE4]").val(inspection_mon_list1[0].WBS_CODE4);
					$("input[name=WBS_CODE5]").val(inspection_mon_list1[0].WBS_CODE5);
					$("input[name=WBS_CODE6]").val(inspection_mon_list1[0].WBS_CODE6);
					//$("input[name=BASE_YYYYMM_RESULT]").val(YYYYMM_format(inspection_mon_list2[0].BASE_YYYYMM));
					
					//---------------- 상단 테이블 데이터 넣어주기 ---------------------------
					//상단 : 맨위부터 ~ 공정구분행 까지.
					var WBS_CODE = inspection_mon_list1[0].WBS_CODE;
					var CONTRACT_NAME = inspection_mon_list1[0].CONTRACT_NAME;
					var VENDOR_NAME = inspection_mon_list1[0].VENDOR_NAME;
					
					$(".WBS_CODE").html(WBS_CODE);
					$(".CONTRACT_NAME").html(CONTRACT_NAME);
					$(".VENDOR_NAME").html(VENDOR_NAME);
					//----------------------------------------------------------------
				}
				//--------------------------------------------------------------
				
				
				//---------소계 합계 변수 -----------------------------
		    	var sub_total_amount = 0;			//소계 금액
		    	//--------------------------------------------------
				
				//코스트 코드를 기준으로 묶기 위한 변수
				var BEFORE_COST_CODE = "";
				//코스트 코드 순서 번호를 표시하기 위한 변수
				var order = 0;
				
				for(var i=0; i<inspection_mon_list2.length; i++){
					var obj = inspection_mon_list2[i];
					var innerHtml = "";
					
					//코스트 코드를 기준으로 묶기 위한 변수
					var CURRENT_COST_CODE = obj.COST_CODE;
					
					//대표 COST_NAME 넣어주기 && 소계 넣어주기
					if(BEFORE_COST_CODE != CURRENT_COST_CODE){
						//대표 COST_NAME 넣어주기
						innerHtml = '<tr>';
						innerHtml += '	<td colspan="4" class="vertical-center tb-head" style="text-align:left;">'+(++order)+'. '+obj.COST_NAME+'</td>';
		    			innerHtml += '</tr>';
		    			
						BEFORE_COST_CODE = obj.COST_CODE;
						$('#inspection_table').append(innerHtml);
					}
					
					innerHtml  = '<tr>';
					innerHtml += '	<td colspan="2" class="center vertical-center tb-head" >'+obj.WORK_CONTENTS+'</td>';
					innerHtml += '	<td colspan="2" class="center vertical-center" >'+obj.RATE_AMOUNT+'</td>';
	    			innerHtml += '</tr>';
	    			$('#inspection_table').append(innerHtml);
	    			
	    			//소계 계산
	    			sub_total_amount += parseInt(obj.CNT);

	    			//제일 마지막에는 소계와 합계 넣어주기
		    		if(i == inspection_mon_list2.length-1){
		    			//소계 만들어주기
		    			innerHtml = '<tr class="sub_total ">';
		    			innerHtml += '	<td colspan="2" class="center vertical-center">합 계</td>';
		    			innerHtml += '	<td colspan="2" class="center vertical-center">'+sub_total_amount+'건</td>';	//소계 건수
		    			innerHtml += '</tr>';
		    			$('#inspection_table').append(innerHtml);
		    			
		    			//합계 만들어주기
		    			innerHtml = "";
		    			innerHtml = '<tr class="sum_total">';
		    			innerHtml += '	<td colspan="2" class="center vertical-center">금 액</td>';
		    			if(!isEmpty(inspection_mon_list1)){
		    				innerHtml += '	<td class="right vertical-center">'+addComma(inspection_mon_list1[0].EMPLOYMENT_COSTS_MONTH)+'</td>';	//금액
		    				$('.SUBCONTRACT_AMOUNT').html(addComma(inspection_mon_list1[0].EMPLOYMENT_COSTS_MONTH));
		    			}else if(!isEmpty(construction_chk_rpt)){
		    				innerHtml += '	<td class="right vertical-center">'+addComma(construction_chk_rpt[0].EMPLOYMENT_COSTS_MONTH)+'</td>';	//금액
		    				$('.SUBCONTRACT_AMOUNT').html(addComma(construction_chk_rpt[0].EMPLOYMENT_COSTS_MONTH));
		    			}
		    			innerHtml += '	<td class="center vertical-center">'+'KRW'+'</td>';
		    			innerHtml += '</tr>';
		    			$('#inspection_table').append(innerHtml);
		    		}
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
				swalDangerCB("저장에 실패하였습니다.\n관리자에게 문의해주세요.");
			}
		});
	}
	
	//검수보고서 테이블 초기화
	function tableInit() {
		//table tr 초기화
    	$("#inspection_table tr").remove();
    	$("#inspection_table_date tr").remove();
    	
    	var innerHtml = 
	    	'<tr>'+
			'	<th class="tb-head VENDOR_NAME"></th><td class="SUBCONTRACT_START_DATE_DISPLAY"></td>'+
			'	<th class="tb-head">~</th><td class="SUBCONTRACT_END_DATE_DISPLAY"></td>'+
			'</tr>';
    	$("#inspection_table_date").append(innerHtml);
	    
    	innerHtml = 
	    	'<tr>'+
				'<th class="tb-head">WBS코드</th>'+
				'<td class="WBS_CODE center vertical-center"></td>'+
				'<th class="tb-head">검수기준일자</th>'+
				'<td><input type="text" style="cursor: pointer;" class="calendar dtp2" name="CHECK_BASE_DATE" readonly/></td>'+
			'</tr>'+
			'<tr>'+
				'<th class="tb-head">계약명</th>'+
				'<td class="CONTRACT_NAME center vertical-center"></td>'+
				'<th class="tb-head">도급 시작 기간</th>'+
				'<td><input type="text" style="cursor: pointer;" class="calendar dtp2" name="SUBCONTRACT_START_DATE" readonly/></td>'+
			'</tr>'+
			'<tr>'+
				'<th class="tb-head">도급(지급)금액</th>'+
				'<td class="SUBCONTRACT_AMOUNT right vertical-center"></td>'+
				'<th class="tb-head">도급 종료 기간</th>'+
				'<td><input type="text" style="cursor: pointer;" class="calendar dtp2" name="SUBCONTRACT_END_DATE" readonly/></td>'+
			'</tr>'+
			'<tr>'+
				'<th rowspan="2" class="tb-head">거래처</th>'+
				'<td rowspan="2" class="VENDOR_NAME center vertical-center"></td>'+
				'<th class="tb-head">감독자</th>'+
				'<td><input type="text" name="SUPERVISOR" /></td>'+
			'</tr>'+
			'<tr>'+
				'<th class="tb-head">검수자</th>'+
				'<td><input type="text" name="INSPECTOR" /></td>'+
			'</tr>'+
			'<tr>'+
				'<th colspan="2" class="tb-head">공정구분</th>'+
				'<th colspan="2" class="tb-head">건수</td>'+
			'</tr>';
    	$("#inspection_table").append(innerHtml);
    	
    	//도급시작기간 변경 감지
		$('input[name=SUBCONTRACT_START_DATE]').datepicker({
			format : "yyyy/mm/dd",
			language : "ko",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		}).on('changeDate', function (ev) {
			$('.SUBCONTRACT_START_DATE_DISPLAY').html($(this).val());
		});
		
		//도급종료기간 변경 감지
		$('input[name=SUBCONTRACT_END_DATE]').datepicker({
			format : "yyyy/mm/dd",
			language : "ko",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		}).on('changeDate', function (ev) {
			$('.SUBCONTRACT_END_DATE_DISPLAY').html($(this).val());
		});
	}
	
	//작업내역 Grid 데이턱 가져오기
	function work_history(){
		var param = {};
		//보고서 코드가 있을때
		if(isEmpty($('input[name=REPORT_CODE]').val())){
			param = {
					EXEC_RFC  : "N", // RFC 여부
					cntQuery  : "yp_zcs_cpt.select_construction_monthly_rpt3_cnt", 	
					listQuery : "yp_zcs_cpt.select_construction_monthly_rpt3"
			};
		//보고서 코드가 없을때
		}else{
			param = {
					EXEC_RFC  : "N", // RFC 여부
					cntQuery  : "yp_zcs_cpt.select_construction_chk_rpt_dt2_cnt", 	
					listQuery : "yp_zcs_cpt.select_construction_chk_rpt_dt2",
					REPORT_CODE : '${REPORT_CODE}'
			};
		}
		scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
		
		var data = {
				BASE_YYYYMM : $("input[name=BASE_YYYYMM]").val().replace("/",""),
				/*  
				CONTRACT_CODE : $("input[name=CONTRACT_CODE_RESULT]").val(),
				VENDOR_CODE : $("input[name=VENDOR_CODE_RESULT]").val()
				*/
				CONTRACT_CODE : $("input[name=CONTRACT_CODE]").val(),
				VENDOR_CODE : $("input[name=VENDOR_CODE]").val()
				
			};
		scope.reloadGrid(data);
	}
	
	//YYYY/MM/DD형식으로 만들어주기
	function YYYYMMDD_format(str) {
	    var y = str.substr(0, 4);
	    var m = str.substr(4, 2);
	    var d = str.substr(6, 2);
	    return y+'/'+m+'/'+d
	}

	//YYYY/MM형식으로 만들어주기
	function YYYYMM_format(str) {
	    var y = str.substr(0, 4);
	    var m = str.substr(4, 2);
	    return y+'/'+m
	}
</script>

</body>