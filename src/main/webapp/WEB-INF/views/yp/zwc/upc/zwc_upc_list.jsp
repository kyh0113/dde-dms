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
<title>업체별 단가 책정
</title>
</head>
<body>
	<h2>
		업체별 단가 책정
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
<!-- 							<select id="BASE_YYYY" name="BASE_YYYY"> -->
<%-- 								<c:forEach var="i" begin="0" end="${to_yyyy - from_yyyy}"> --%>
<%-- 									JSTL 역순 출력 - 연도 --%>
<%-- 									<c:set var="yearOption" value="${to_yyyy - i}"/> --%>
<%-- 									<option value="${yearOption}">${yearOption}</option> --%>
<%-- 								</c:forEach> --%>
<!-- 							</select> -->
							<input type="text" id="BASE_YYYY" name="BASE_YYYY" class="calendar search_dtp_y" value="${to_yyyy}" readonly="readonly"/>
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
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="shdsCtrl" style="height: auto;">
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
			
			var columnDefs = [
				{
					displayName : '연도',
					field : 'BASE_YYYY',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents pointer">{{row.entity.BASE_YYYY}}</div>'
				},
				{
					displayName : '거래처',
					field : 'VENDOR_NAME',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents pointer">{{row.entity.VENDOR_NAME}}</div>'
				},
				{
					displayName : '거래처',
					field : 'VENDOR_CODE',
					width : '120',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents pointer" ng-dblclick="grid.appScope.openPopup(row.entit)">{{row.entity.VENDOR_CODE}}</div>'
				}
			  ];
			
			<c:forEach var="item" items="${cb_working_master_w}">
				var data = 
				{
					displayName : '${item.CODE_NAME}',
					field : '${item.CODE}',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents pointer" ng-dblclick="grid.appScope.openPopup(row.entity, \'${item.CODE}\')">{{row.entity.${item.CODE}}}</div>'
				}
				columnDefs.push(data);
			</c:forEach>
			//기본 컬럼 저장
			$scope.columnDefsDefault = columnDefs;
			
			
			$scope.openPopup = function(target, worktype_code, worktype_name){
				var BASE_YYYY = target.BASE_YYYY;
				var VENDOR_CODE = target.VENDOR_CODE;
				var VENDOR_NAME = target.VENDOR_NAME;
				
				window.open("", "업체별 단가 상세조회", "width=1200, height=775");
				fnHrefPopup("/yp/popup/zwc/upc/zwc_upc_detail_list", "업체별 단가 상세조회", {
					BASE_YYYY : BASE_YYYY,
					VENDOR_CODE : VENDOR_CODE,
					VENDOR_NAME : VENDOR_NAME,
					WORKTYPE_CODE : worktype_code,
					WORKTYPE_NAME : worktype_name
				});
			};
			
			

			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바
				showColumnFooter : false,
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

		$(document).ready(function() {
			// 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
			scope = angular.element(document.getElementById("shds-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
			
			scope.gridApi.core.on.rowsRendered(scope, function() {	//그리드 렌더링 후 이벤트
				//var key = 'W1';
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
				EXEC_RFC  : "N", // RFC 여부
				BASE_YYYY : $("#BASE_YYYY option:selected").val(), //시작연도
				VENDOR_CODE : $("#VENDOR_CODE option:selected").val(), //근무형태
				cntQuery  : "yp_zwc_upc.select_zwc_upc_list_cnt", 	
				listQuery : "yp_zwc_upc.select_zwc_upc_list"
			};
			
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
			
			
			/****************************************엑셀 다운로드 공통 시작****************************************/		
			$("#excel_btn").click(function(e){
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
				xlsForm.action = "/yp/xls/zwc/upc/zwc_upc_list";

				document.body.appendChild(xlsForm);

				xlsForm.appendChild(csrf_element);

				var pr = gPostArray($("#frm").serializeArray());

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
				//$('.wrap-loading').removeClass('display-none');
				//setTimeout(function() {
				//	$('.wrap-loading').addClass('display-none');
				//}, 5000); //5초
			});
			/****************************************엑셀 다운로드 공통  끝  ****************************************/
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
				$.ajax({
					url: "/yp/zwc/upc/select_zwc_upc_list",
				    type: "POST",
				    cache:false,
				    async:true, 
				    dataType:"json",
				    data:gPostArray($("#frm").serializeArray()), //폼을 그리드 파라메터로 전송
				    success: function(result) {
				    	//실데이터
				    	var list = result.list;
				    	//거래처 별로 나누기위한 
				    	//vendor데이터
				    	var vendor_list = result.vendor_list;
				    	
				    	var row_list = new Array();;
				    	var row_data = new Object();
				    	
				    	//공통 컬럼 세팅
				    	var col_list = [
							{
								displayName : '연도',
								field : 'BASE_YYYY',
								width : '100',
								visible : true,
								cellClass : "center",
								enableCellEdit : false,
								allowCellFocus : false,
								cellTemplate : '<div class="ui-grid-cell-contents pointer">{{row.entity.BASE_YYYY}}</div>'
							},
							{
								displayName : '거래처',
								field : 'VENDOR_NAME',
								width : '120',
								visible : true,
								cellClass : "center",
								enableCellEdit : false,
								allowCellFocus : false,
								cellTemplate : '<div class="ui-grid-cell-contents pointer">{{row.entity.VENDOR_NAME}}</div>'
							},
							{
								displayName : '거래처',
								field : 'VENDOR_CODE',
								width : '100',
								visible : false,
								cellClass : "center",
								enableCellEdit : false,
								allowCellFocus : false,
								cellTemplate : '<div class="ui-grid-cell-contents pointer">{{row.entity.VENDOR_CODE}}</div>'
							}
						  ];
				    	
				    	//컬럼과 데이터 세팅
		    			$.each(vendor_list, function(i, vendor){
				    		$.each(list, function(j, data){
					    		//첫번째 거래처를 이용하여 컬럼 세팅
					    		if(i == 0 && vendor.VENDOR_CODE == data.VENDOR_CODE){
					    			var column = 
						    		{
										displayName : data.WORKTYPE_NAME,
										field : data.WORKTYPE_CODE,
										visible : true,
										cellClass : "center",
										enableCellEdit : false,
										allowCellFocus : false,
										cellTemplate : '<div class="ui-grid-cell-contents pointer" ng-dblclick="grid.appScope.openPopup(row.entity,\''+data.WORKTYPE_CODE+'\',\''+data.WORKTYPE_NAME+'\')">{{grid.appScope.formatter_decimal(row.entity.'+data.WORKTYPE_CODE+')}}</div>'
									};
					    			col_list.push(column);
					    		}
					    		
					    		//거래처 별로 행나누기
					    		//데이터 넣기
					    		if(vendor.VENDOR_CODE == data.VENDOR_CODE){
					    			row_data.BASE_YYYY = data.BASE_YYYY;
						    		row_data.VENDOR_CODE = data.VENDOR_CODE;
						    		row_data.VENDOR_NAME = data.VENDOR_NAME;
						    		row_data[data.WORKTYPE_CODE] = data.FINAL_UNIT_PRICE;
					    		}
					    	});
				    		row_list.push(row_data);
				    		row_data = {};//초기화
			    		});
				    	
				    	//데이터가 존재할때 컬럼 세팅
				    	if(list.length > 0){
				    		scope.gridOptions.columnDefs = col_list;
			    		//데이터가 존재하지 않을때 기본 컬럼 세팅
				    	}else{
				    		scope.gridOptions.columnDefs = scope.columnDefsDefault;
				    	}
				    	
				    	scope.gridOptions.data = row_list;
				    	scope.gridApi.core.notifyDataChange(scope.uiGridConstants.dataChange.ALL);	//그리드 새로고침
				    }
				    
				});
			});
			
		});
		
		
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
				console.log(k, v);
				var el = document.createElement("input");
				el.name = k;
				el.value = v;
				el.type = "hidden";
				popForm.appendChild(el);
			});

			popForm.submit();
			popForm.remove();
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