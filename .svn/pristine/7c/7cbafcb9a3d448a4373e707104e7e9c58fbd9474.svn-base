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
<title>유해인자 등록</title>
</head>
<body>
	<h2>
		유해인자 등록
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
							<input type="text" id="BASE_YYYY" name="BASE_YYYY" class="calendar search_dtp_y" value="${to_yyyy}" readonly="readonly"/>
<!-- 							<select id="BASE_YYYY" name="BASE_YYYY"> -->
<%-- 								<c:forEach var="i" begin="0" end="${to_yyyy - from_yyyy}"> --%>
<%-- 									JSTL 역순 출력 - 연도 --%>
<%-- 									<c:set var="yearOption" value="${to_yyyy - i}" /> --%>
<%-- 									<option value="${yearOption}">${yearOption}</option> --%>
<%-- 								</c:forEach> --%>
<!-- 							</select>  -->
						</td>
						<th>거래처</th>
						<td >
							<select id="VENDOR_CODE" name="VENDOR_CODE">
							<option value="">-- 전체 --</option>
							<c:forEach items="${cb_working_master_v}" var="data">
								<option value="${data.CODE}">${data.CODE_NAME}</option>
							</c:forEach>
							</select>
						</td>
						<th>계약명</th>
						<td><input type="text" name="CONTRACT_NAME" ></td>
					</tr>
				</table>
				<div class="btn_wrap">
					<input type="button" class="btn btn_search" id="search_btn" value="조회"/>
				</div>
			</div>
		</section>
	</form>
	<div class="float_wrap" style="margin-bottom: 2px;">
		<div class="fr">
			<div class="btn_wrap">
				<input type="button" class="btn_g" id="modify_btn"  value="수정"/>
				<input type="button" class="btn_g" id="save_btn"    value="저장"/>
			</div>
		</div>
	</div>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="shdsCtrl" style="height: auto;">
			<div data-ui-i18n="ko" style="height: 620px;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter ui-grid-pinning>
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
	        
	     	// formater - 천단위 콤마
			$scope.formatter_decimal = function(str_date) {
				if (!isNaN(Number(str_date))) {
					return Number(str_date).toLocaleString()
				} else {
					return str_date;
				}
			};
			
			//cellClass
			$scope.cellClassSet = function(grid, row, col, rowRenderIndex, colRenderIndex){
				var className = "";
				switch(col.field){
					
				}
				return className;
			}
			
			//월간(원) 계산
			$scope.calYAmount= function(row){
				var year_amount = row.entity.YEAR_AMOUNT; //연간(원)
				var month_amount = row.entity.MONTH_AMOUNT; //월간(원)
				var second_test_rate = row.entity.SECOND_TEST_RATE; //2차검진비율
				
				//올림
				month_amount = Math.round((year_amount * second_test_rate) / 12);
				
				row.entity.MONTH_AMOUNT = month_amount;
				scope.gridApi.core.notifyDataChange(scope.uiGridConstants.dataChange.ALL);	//그리드 새로고침
			}
			
			var columnDefs = [
				{
					displayName : '연도',
					field : 'BASE_YYYY',
					width : '100',
					pinnedLeft : true,
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				},
				{
					displayName : '거래처',
					field : 'VENDOR_NAME',
					width : '120',
					pinnedLeft : true,
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				},
				{
					displayName : '거래처코드',
					field : 'VENDOR_CODE',
					width : '120',
					pinnedLeft : true,
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				},
				{
					displayName : '계약코드',
					field : 'CONTRACT_CODE',
					width : '100',
					pinnedLeft : true,
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				},
				{
					displayName : '계약명',
					field : 'CONTRACT_NAME',
					width : '170',
					pinnedLeft : true,
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}
			];
			
			<c:forEach var="item" items="${cb_working_master_n}">
				var data = 
				{
						displayName : "${item.CODE_NAME}",
						field : "${item.CODE}",
						width : '130',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : ''+
							'<input ng-if="row.entity.IS_MOD == null" class="" type="checkbox" ng-model="row.entity.'+'${item.CODE}'+'" ng-true-value="\'Y\'" ng-false-value="\'N\'" style="width: 100%; text-align:center; cursor:pointer;" disabled/>'+
							'<input ng-if="row.entity.IS_MOD == \'Y\'" class="" type="checkbox" ng-model="row.entity.'+'${item.CODE}'+'" ng-true-value="\'Y\'" ng-false-value="\'N\'" style="width: 100%; text-align:center; cursor:pointer;"/>'
				}
				columnDefs.push(data);
			</c:forEach>
			columnDefs.push(
				{
					displayName : '연간(원)',
					field : 'YEAR_AMOUNT',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				},
				{
					displayName : '2차검진비율',
					field : 'SECOND_TEST_RATE',
					width : '125',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				},
				{
					displayName : '월간(원)',
					field : 'MONTH_AMOUNT',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				});
			//기본 컬럼 저장
			$scope.columnDefsDefault = columnDefs;
			

			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바
				showColumnFooter : true,
				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 1000,

				enableCellEditOnFocus : true, //셀 클릭시 edit모드 
				enableSelectAll : true, //전체선택 체크박스
				enableRowSelection : true, //로우 선택
				enableRowHeaderSelection : true, //맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 35, //체크박스 컬럼 길이
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

		$(document).ready(function() {
			// 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
			scope = angular.element(document.getElementById("shds-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
			
			scope.gridApi.core.on.rowsRendered(scope, function() {	//그리드 렌더링 후 이벤트
				
			});
			scope.gridApi.selection.on.rowSelectionChanged(scope, function(row) { //로우 선택할때마다 이벤트
				//console.log("row2", row.entity);
			});
			scope.gridApi.selection.on.rowSelectionChangedBatch(scope, function(rows) { //전체선택시 가져옴
				// 				console.log("row3", rows[0].entity); //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
			});
			
			// pagenation option setting  그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param = {
					
			};
			
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
			
			
			/****************************************엑셀 다운로드 공통 시작****************************************/		
			
			/****************************************엑셀 다운로드 공통  끝  ****************************************/
			
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
				$.ajax({
					url: "/yp/zwc/nft/select_zwc_nft_list",
				    type: "POST",
				    cache:false,
				    async:true, 
				    dataType:"json",
				    data:gPostArray($("#frm").serializeArray()), //폼을 그리드 파라메터로 전송
				    success: function(data) {
				    	//계약리스트
				    	var subc_list = data.subc_list;
				    	//default 유해인자
				    	var cb_working_master_n = data.cb_working_master_n;
				    	//유해인자 DT 리스트
				    	nft_dt_list = data.nft_dt_list;
				    	//가변컬럼 리스트
				    	var nft_column_make_list = data.nft_column_make_list
				    	
				    	var row_list = new Array();
				    	var row_data = new Object();
				    	var unit_price_obj = new Object();
				    	
				    	//공통 컬럼 세팅
				    	var col_list = [
				    		{
								displayName : '연도',
								field : 'BASE_YYYY',
								width : '100',
								pinnedLeft : true,
								visible : false,
								cellClass : "center",
								enableCellEdit : false,
								allowCellFocus : false
							},
							{
								displayName : '거래처',
								field : 'VENDOR_NAME',
								width : '120',
								pinnedLeft : true,
								visible : true,
								cellClass : "center",
								enableCellEdit : false,
								allowCellFocus : false
							},
							{
								displayName : '거래처코드',
								field : 'VENDOR_CODE',
								width : '120',
								pinnedLeft : true,
								visible : false,
								cellClass : "center",
								enableCellEdit : false,
								allowCellFocus : false
							},
							{
								displayName : '계약코드',
								field : 'CONTRACT_CODE',
								width : '100',
								pinnedLeft : true,
								visible : true,
								cellClass : "center",
								enableCellEdit : false,
								allowCellFocus : false,
								footerCellTemplate: '<div class="ui-grid-cell-contents center">합계</div>'
							},
							{
								displayName : '계약명',
								field : 'CONTRACT_NAME',
								width : '170',
								pinnedLeft : true,
								visible : true,
								cellClass : "center",
								enableCellEdit : false,
								allowCellFocus : false
							}
						  ];
				    	
				    	//유해인자 데이터가 존재할 경우
				    	//2020-10-13 동적컬럼(dt데이터기준) => 정적컬럼(기준정보기준) 으로 변경
				    	if(nft_dt_list.length > 0 ){
				    		//컬럼 세팅
				    		//2020-10-13 동적컬럼(dt데이터기준) => 정적컬럼(기준정보기준) 으로 변경 
				    		//nft_column_make_list => cb_working_master_n
				    		$.each(cb_working_master_n, function(i, data){
				    			var column = 
					    		{
			    					//2020-10-13 동적컬럼(dt데이터기준) => 정적컬럼(기준정보기준) 으로 변경 
						    		//NOXIOUS_FACTOR_NAME => CODE_NAME
						    		//NOXIOUS_FACTOR_CODE = > CODE
									displayName : data.CODE_NAME,
									field : data.CODE,
									width : '130',
									visible : true,
									cellClass : "center",
									enableCellEdit : false,
									allowCellFocus : false,
									cellTemplate : ''+
									'<input ng-if="row.entity.IS_MOD == null" class="" type="checkbox" ng-model="row.entity.'+data.CODE+'" ng-true-value="\'Y\'" ng-false-value="\'N\'" style="width: 100%; text-align:center; cursor:pointer;" disabled/>'+
									'<input ng-if="row.entity.IS_MOD == \'Y\'" class="" type="checkbox" ng-model="row.entity.'+data.CODE+'" ng-true-value="\'Y\'" ng-false-value="\'N\'" style="width: 100%; text-align:center; cursor:pointer;"/>'
													
								};
				    			col_list.push(column);
				    		});
				    		//데이터 세팅
				    		$.each(subc_list, function(i, data){
				    			//유해인자 데이터 세팅
				    			$.each(nft_dt_list, function(j, dt_data){
				    				//기준월, 계약코드, 거래처에 맞는 보호구 세팅
				    				if(
				    						data.BASE_YYYY == dt_data.BASE_YYYY 
				    						&& data.CONTRACT_CODE == dt_data.CONTRACT_CODE
				    						&& data.VENDOR_CODE == dt_data.VENDOR_CODE){
				    					row_data[dt_data.NOXIOUS_FACTOR_CODE] = dt_data.CHECK_YN;
				    				}
				    			});
				    			
				    			//기본 데이터 세팅
				    			row_data.BASE_YYYY = data.BASE_YYYY; //연도
					    		row_data.VENDOR_CODE = data.VENDOR_CODE; //거래처코드
					    		row_data.VENDOR_NAME = data.VENDOR_NAME; //거래처
					    		row_data.CONTRACT_CODE = data.CONTRACT_CODE; //계약코드
					    		row_data.CONTRACT_NAME = data.CONTRACT_NAME; //계약명
					    		row_data.SECOND_TEST_RATE = data.SECOND_TEST_RATE; //2차검진비율
					    		row_data.YEAR_AMOUNT = data.YEAR_AMOUNT; //연간(원)
					    		row_data.MONTH_AMOUNT = data.MONTH_AMOUNT; //월간(원)
					    		
					    		row_list.push(row_data);
					    		row_data = {};//초기화
				    		}); 
			    		//유해인자 데이터가 존재하지 않을 경우
				    	}else{
				    		$.each(subc_list, function(i, data){
				    			//컬럼세팅(기준정보의 유해인자 데이터 기준으로 세팅)
				    			$.each(cb_working_master_n, function(j, data){
				    				if(i == 0){
				    					var column = 
							    		{
											displayName : data.CODE_NAME,
											field : data.CODE,
											width : '130',
											visible : true,
											cellClass : "center",
											enableCellEdit : false,
											allowCellFocus : false,
											cellTemplate : ''+
											'<input ng-if="row.entity.IS_MOD == null" class="" type="checkbox" ng-model="row.entity.'+data.CODE+'" ng-true-value="\'Y\'" ng-false-value="\'N\'" style="width: 100%; text-align:center; cursor:pointer;" disabled/>'+
											'<input ng-if="row.entity.IS_MOD == \'Y\'" class="" type="checkbox" ng-model="row.entity.'+data.CODE+'" ng-true-value="\'Y\'" ng-false-value="\'N\'" style="width: 100%; text-align:center; cursor:pointer;"/>'
															
										};
						    			col_list.push(column);
					    			}
					    			//유해인자YN 디폴트 N 으로세팅
				    				row_data[data.CODE] = 'N';
				    			});
				    			
				    			//데이터가 존재하지 않을때 기본세팅
				    			row_data.BASE_YYYY = data.BASE_YYYY; //연도
					    		row_data.VENDOR_CODE = data.VENDOR_CODE; //거래처코드
					    		row_data.VENDOR_NAME = data.VENDOR_NAME; //거래처
					    		row_data.CONTRACT_CODE = data.CONTRACT_CODE; //계약코드
					    		row_data.CONTRACT_NAME = data.CONTRACT_NAME; //계약명
					    		row_data.SECOND_TEST_RATE = data.SECOND_TEST_RATE; //2차검진비율
					    		row_data.YEAR_AMOUNT = data.YEAR_AMOUNT; //연간(원)
					    		row_data.MONTH_AMOUNT = data.MONTH_AMOUNT; //월간(원)
					    		
					    		
					    		row_list.push(row_data);
					    		row_data = {};//초기화
				    		}); 
				    	}
				    	//공통 컬럼 세팅
				    	col_list.push(
						{
							displayName : '연간(원)',
							field : 'YEAR_AMOUNT',
							width : '120',
							visible : true,
							cellClass : "right",
							enableCellEdit : false,
							allowCellFocus : false,
							cellTemplate : '<input class="year_amount_input" type="text" ng-model="row.entity.YEAR_AMOUNT" ng-change="grid.appScope.calYAmount(row)" style="width: 100%; text-align:right;"/>',
							aggregationType: scope.uiGridConstants.aggregationTypes.sum,
							footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
						},
						{
							displayName : '2차검진비율',
							field : 'SECOND_TEST_RATE',
							width : '125',
							visible : true,
							cellClass : "right",
							enableCellEdit : false,
							allowCellFocus : false,
							cellTemplate : '<input class="" type="text" ng-model="row.entity.SECOND_TEST_RATE" ng-change="grid.appScope.calYAmount(row)" style="width: 100%; text-align:right;"/>'
						},
						{
							displayName : '월간(원)',
							field : 'MONTH_AMOUNT',
							width : '120',
							visible : true,
							cellClass : "right",
							enableCellEdit : false,
							allowCellFocus : false,
							cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.MONTH_AMOUNT)}}</div>',
							aggregationType: scope.uiGridConstants.aggregationTypes.sum,
							footerCellTemplate: '<div class="ui-grid-cell-contents right">{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
						});
				    	 
				    	
				    	
				    	//계약리스트 데이터가 존재할 경우
			    		if(subc_list.length > 0){
			    			scope.gridOptions.columnDefs = col_list;
		    			//계약리스트 데이터가 존재하지 않을 경우
			    		}else{
			    			scope.gridOptions.columnDefs = scope.columnDefsDefault;
			    		}
				    	
				    	
				    	scope.gridOptions.data = row_list;
				    	scope.gridApi.core.notifyDataChange(scope.uiGridConstants.dataChange.ALL);	//그리드 새로고침
				    },
					beforeSend:function(){
						$('.wrap-loading').removeClass('display-none');
					},
					complete:function(){
				        $('.wrap-loading').addClass('display-none');
				    },
				    error:function(request,status,error){
				    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
				    	swalDanger("처리중 오류가 발생하였습니다.\n관리자에게 문의해주세요.");
				    }
				});
			});
			
			// 수정
			$("#modify_btn").on("click",function(){
				var rows = scope.gridApi.selection.getSelectedRows();
				if (isEmpty(rows)) {
					swalWarning("항목을 선택하세요.");
					return false;
				}
				// 2020-10-14 jamerl - 횡 스크롤 이동시 엘리먼트가 다시 잠기는 현상이 발견되어 ng-if 로 처리되도록 변경
				$.each(rows, function(i, d){
					d.IS_MOD = 'Y';
				});
				scope.gridApi.grid.refresh();
			});
			
			//저장
			$("#save_btn").on("click",function(){
				$this = $(this);
				var selectedRows = scope.gridApi.selection.getSelectedRows();	//그리드 선택된 rows data
				if(selectedRows.length > 0){
					
					//연간(원) 숫자 체크
					for(var  i=0; i<selectedRows.length; i++){
						var row = selectedRows[i];
						var value = row['YEAR_AMOUNT'];
						if(!$.isNumeric(value)){
							swalWarning("연간(원)에 숫자를 넣어주십시오.");
							return false;
						}
					}
					
					//form데이터 + 그리드데이터 json으로 변환 및 추가해서 서버로 전송
					var data = $("#frm").serializeArray();
					data.push({name: "gridData", value: JSON.stringify(selectedRows)}); //Grid데이터
					$.ajax({
					    url: "/yp/zwc/nft/zwc_nft_create_save",
					    type: "POST",
					    cache:false,
					    async:true, 
					    data : data,
					    dataType:"json",
					    success: function(data) {
					    	swalSuccess(data.result+'건이 저장됐습니다.');
					    	$("#search_btn").trigger("click");
					    	scope.gridApi.selection.clearSelectedRows();			//그리드 selection 초기화
						},
						beforeSend:function(){
							$('.wrap-loading').removeClass('display-none');
						},
						complete:function(){
					        $('.wrap-loading').addClass('display-none');
					    },
					    error:function(request,status,error){
					    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
					    	swalDanger("처리중 오류가 발생하였습니다.\n관리자에게 문의해주세요.");
					    }
				 	});
				}else{
					swalWarning("등록할 항목을 선택해 주세요.");
					return false;
				}
			});
			
		});
		
		/*콤마 제거*/
		function unComma(num) {
			return num.replace(/[^0-9.]/gi, '');
		}
		
		/*콤마 추가*/
		function addComma(num) {
			var rnum = "0";
			if(num !== null){
				rnum = num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			}
			return rnum;
		}
		function formatDate_y(date) {
			var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
			if (month.length < 2)
				month = '0' + month;
			if (day.length < 2)
				day = '0' + day;
			return [ year ].join('/');
		}
	</script>
	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
</body>