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

//한달 전
Calendar mon = Calendar.getInstance();
mon.add(Calendar.MONTH , -1);
String beforeMonthDay = date.format(mon.getTime());
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>도시락 기간 집계 조회
</title>
<script type="text/javascript">
	var scope;
	$(document).ready(function() {
		// 부트스트랩 날짜객체
		$(".dtp").datepicker({
			format : "yyyy/mm/dd",
			language : "ko",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		});
		
		//조회조건 default
		//오늘날짜 세팅
		if($("input[name=edate]").val() == ""){
			$("input[name=edate]").val("<%=toDay%>");	
		}
		//1달전 날짜 세팅
		if($("input[name=sdate]").val() == ""){
			$("input[name=sdate]").val("<%=beforeMonthDay%>");
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
		도시락 기간 집계 조회
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
		<input type="hidden" name="excel_flag" />
		<input type="hidden" name="page" id="page" value="${req_data.paginationInfo.currentPageNo}" />
		<input type="hidden" name="page_rows" value="" />
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
						<th>신청일자</th>
						<td>
							<input type="text" class="calendar dtp" name="sdate" id="sdate" size="10" value="${req_data.sdate}"/>
							 ~ 
							<input type="text" class="calendar dtp" name="edate" id="edate" size="10" value="${req_data.edate}"/>
						</td>
						<th>부서명</th>
						<td>
							<input type="text" name="dept_name" value="${req_data.dept_name}" >
						</td>
						<th>&nbsp;</th>
						<td>&nbsp;</td>
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
		<div class="fl"><div class="stitle">기간 집계현황</div></div>
	</div>
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
			
			//신청 건수
			$scope.regCnt = 0;

			
			// formater - String yyyyMM -> String yyyy.MM
			$scope.formatter_yyyymm = function(str_date) {
				return str_date.substring(0,4)+"/"+str_date.substring(4,6)
			};

			
			// onchange 이벤트 시작
			$scope.fnAjaxKOSTL = function(type, row) {
				var target = scope.gridOptions.data.indexOf(row.entity);
				fnAjaxKOSTL(type, target);
			};
			$scope.fnAjaxBACT = function(row) {
				var target = scope.gridOptions.data.indexOf(row.entity);
				fnAjaxBACT(target);
			};
			// onchange 이벤트 끝
			
			//cellClass
			$scope.cellClassSet = function(grid, row, col, rowRenderIndex, colRenderIndex){
				var className = "";
				switch(col.field){
					
				}

				return className;
			}
			
			var columnDefs1 = [
				{
					displayName : '부서명',
					field : 'DEPT_NAME',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, 
				{
					displayName : '사번',
					field : 'EMP_CD',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				},
				{
					displayName : '성명',
					field : 'EMP_NAME',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					footerCellTemplate : '<div class="ui-grid-cell-contents center">총합계</div>'
				},
				{
					displayName : '조식',
					field : 'A_CNT',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents center">{{col.getAggregationValue()}}</div>'
				},
				{
					displayName : '중식',
					field : 'B_CNT',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents center">{{col.getAggregationValue()}}</div>'
				},
				{
					displayName : '석식',
					field : 'C_CNT',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents center">{{col.getAggregationValue()}}</div>'
				},
				{
					displayName : '야식',
					field : 'D_CNT',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents center">{{col.getAggregationValue()}}</div>'
					
				},
				{
					displayName : '합계',
					field : 'TOTAL_CNT',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					aggregationType: uiGridConstants.aggregationTypes.sum,
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
				enableRowSelection : true, //로우 선택
				enableRowHeaderSelection : true, //맨앞 컬럼 체크박스 컬럼으로
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

		$(document).ready(function() {
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
			var param = {
					EXEC_RFC  : "N", // RFC 여부
					cntQuery  : "yp_ZHR.retrievePeoridDosilakListCnt", 	
					listQuery : "yp_ZHR.retrievePeoridDosilakList"
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
			
			// 부트스트랩 날짜객체
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
			
			/****************************************엑셀 다운로드 공통 시작****************************************/		
			$("#excel_btn").click(function(e){
				if(scope.gridOptions.data.length > 0){	//그리드 데이터 존재여부 확인
					var query_name = "yp_ZHR.retrievePeoridDosilakList_excel";	//다운 받을 엑셀쿼리명
					var excel_name = "도시락 기간집계 조회현황";							//다운 받을 엑셀파일명
					excelDownload('/core/excel/excelDownloadWithQuery.do', $("#frm").serializeArray(), {list:query_name, excel_name:excel_name});	//url, 조회영역 폼(폼 이름 확인), 필수파라메터
				}else{
					swalInfo("조회된 데이터가 없습니다.\n1건 이상의 데이터만 엑셀다운로드 가능 합니다.");
				}		
			});
			/****************************************엑셀 다운로드 공통  끝  ****************************************/
			
			// 조회
			$("#search_btn").on("click", function() {
				var data = gPostArray($("#frm").serializeArray());
				if(${!empty req_data.dept_cd}){
					//data.dept_cd = "${req_data.dept_cd}";
				}
				if (fnValidation()) {
					scope.reloadGrid(
							data	//폼을 그리드 파라메터로 전송
					);	
				} 
			});
			
			// 집계
			$("#reg_btn").on("click", function() {
				console.log("집계 클릭");
				fnUpdateDosilakOk();
			});
			
			// 집계취소
			$("#rmv_btn").on("click", function() {
				console.log("집계 취소 클릭");
				fnupdateDosilakOkCancel();
			});
			
			
			
			
		});
	</script>
	
	<script type="text/javascript">
		
		function fnGoSearch(pageIndex) {
		    if (pageIndex) {
		        $("#page").val(pageIndex);
		    } else {
		        $("#page").val("1");
		    }
		    fnSearchData();
		}
		
		function fnSearchData(){
			$("input[name=excel_flag]").val("2");
			$("input[name=page_rows]").val($("#page_rows").val());
			if(fnValidation()){
				$.ajax({
				    url: "/yp/zhr/lbm/zhr_lbm_peorid_sum_list",
				    type: "POST",
				    cache:false,
				    async:true, 
				    data:$("#frm").serialize(),
				    success: function(result) {
				    	$("#main_body").empty();
				    	$("#main_body").html(result);
					},
					beforeSend:function(){
						$('.wrap-loading').removeClass('display-none');
					},
					complete:function(){
				        $('.wrap-loading').addClass('display-none');
				    },
				    error:function(request,status,error){
				    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
				    	swalDangerCB("조회에 실패하였습니다.\n관리자에게 문의해주세요.");
				    }
			 	});
			}
		}
		
		function fnExelDown(){
			 $("input[name=excel_flag]").val("1");
			 $("#frm").attr("action", "/hr/retrievePeoridDosilakList");
			 $("#frm").submit();
			 $('.wrap-excelloading').removeClass('display-none');
			 setTimeout(function() {
				  $('.wrap-excelloading').addClass('display-none');
			 },5000); //5초
		}
		
		
		function fnValidation(){
			if($("input[name=date]").val() == ''){
				swalWarningCB("신청일자를 입력해 주세요.");
				return false;
			} 
			return true;
		}
		
	</script>
</body>
