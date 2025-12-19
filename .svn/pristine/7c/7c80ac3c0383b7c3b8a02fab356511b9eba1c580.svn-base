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

%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>식당 관리 페이지
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
		if($("input[name=date]").val() == ""){
			$("input[name=date]").val("<%=toDay%>");	
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
		식당 관리 페이지
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
	</form>
	
	<!-- 도시락 수기 등록 -->
	<div class="float_wrap">
		<div class="fl"><div class="stitle">도시락 수기 등록</div></div>
		<div class="fr">
			<div class="btn_wrap">
				<input type="button" class="btn_g" id="d_reg" value="등록"/>
				<input type="button" class="btn_g" id="d_add" value="1줄 추가"/>
				<input type="button" class="btn_g" id="d_add5" value="5줄 추가"/>
			</div>
		</div>
	</div>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="d-shds-uiGrid" data-ng-controller="dShdsCtrl">
			<div data-ui-i18n="ko" style="height: 360px;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter ui-grid-expandable>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
	</section>
	
	<!-- 식당 수기 등록 -->
	<div class="float_wrap">
		<div class="fl"><div class="stitle">식당 수기 등록</div></div>
		<div class="fr">
			<div class="btn_wrap">
				<input type="button" class="btn_g" id="r_reg" value="등록"/>
				<input type="button" class="btn_g" id="r_add" value="1줄 추가"/>
				<input type="button" class="btn_g" id="r_add5" value="5줄 추가"/>
			</div>
		</div>
	</div>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="r-shds-uiGrid" data-ng-controller="rShdsCtrl">
			<div data-ui-i18n="ko" style="height: 360px;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter ui-grid-expandable>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
	</section>
	
	<!-- 식당데이터 엑셀등록 -->
	<div class="float_wrap">
		<div class="fl"><div class="stitle">식당자료 엑셀저장</div></div>
	</div>
	<form id="mfrm" name="mfrm"  method="post" enctype="multipart/form-data" style="margin-bottom:100px;">
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type='hidden' id='insertQuery' name='insertQuery' value='oracle.yp_ZHR.createRestaurantData'>
		<div class="tbl_box">
			<table cellspacing="0" cellpadding="0">
				<colgroup>
					<col/>
					<col/>
					<col/>
					<col/>
				</colgroup>
				<tr>
					<th><input type="file" name="excelfile" id="upload" value=""/></th>
					<td><input type="button" id="upload_btn" value="파일등록" onclick="fnExcelUpload();"/></td>
					<th>샘플파일 다운</th>
					<td><input type="button" class="btn btn_make" id=excelTemplate_btn value="ExcelDown"/></td>
				</tr>
			</table>
			<span>*셀이 비어있으면 오류의 원인이 될 수 있습니다. 값이 없으면 null을 입력해 주세요.</span>
		</div>
	</form>
	
	
	<!-- <<<<<<<<  도시락 script >>>>>>>> -->
	<script>
		//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
		app.controller('dShdsCtrl', [ '$scope', '$window', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $window, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
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
			
			var dColumnDefs = [
				{
					displayName : '일자',
					field : 'DATE',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full">'+
										'<input ng-if="!row.entity.isAddedRow" type="text" class="absolute_center calendar dtp width_90_percent" size="10" ng-model="row.entity.DATE" />'+
										'<div ng-if="row.entity.isAddedRow" class="absolute_center">상동</div>'+
									'</div>'
				}, 
				{
					displayName : '식사',
					field : 'MEAL_TYPE',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : 
						'<div class="ui-grid-cell-contents relatvie_box height_full">'+
							'<select ng-if="!row.entity.isAddedRow" class="absolute_center" style="margin-left:5px;" ng-model="row.entity.MEAL_TYPE">'+
								'<option value="2" selected>중식</option>'+
								'<option value="3" >석식</option>'+
							'</select>'+
							'<div ng-if="row.entity.isAddedRow" class="absolute_center">상동</div>'+
						'</div>'
				}, 
				{
					displayName : '성명',
					field : 'EMP_NAME',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><input class="absolute_center width_90_percent" type="text" ng-model="row.entity.EMP_NAME" ng-blur="grid.appScope.fnDEmpNameSearch(row)" /></div>'
				},
				{
					displayName : '사번',
					field : 'EMP_CD',
					visible : true,
					cellClass : "center",
					cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><div class="absolute_center">{{row.entity.EMP_CD}}</div></div>',
					enableCellEdit : false,
					allowCellFocus : false
				},
				{
					displayName : '부서',
					field : 'EMP_DEPT',
					visible : true,
					cellClass : "center",
					cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><div class="absolute_center">{{row.entity.EMP_DEPT}}</div></div>',
					enableCellEdit : false,
					allowCellFocus : false
				},
				{
					displayName : '근무반',
					field : 'EMP_CLASS',
					visible : true,
					cellClass : "center",
					cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><div class="absolute_center">{{row.entity.EMP_CLASS}}</div></div>',
					enableCellEdit : false,
					allowCellFocus : false
				},
				{
					displayName : '근무조',
					field : 'EMP_SHIFT',
					visible : true,
					cellClass : "center",
					cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><div class="absolute_center">{{row.entity.EMP_SHIFT}}</div></div>',
					enableCellEdit : false,
					allowCellFocus : false
				}
			]; 
			  		
			
			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바
 				showGridFooter: true,
				showColumnFooter : false,
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
				enableAutoFitColumns : true, //컬럼 width를 자동조정
				multiSelect : true, //여러로우선택
				enablePagination : false,
				enablePaginationControls : false,

				columnDefs : dColumnDefs,
				
				onRegisterApi: function( gridApi ) {
				      $scope.gridApi = gridApi;
				 }
			});

			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			
			//기본 데이터
			var dData = [
			    {
			      "DATE": "<%=toDay%>",
			      "MEAL_TYPE" : "2"
			    }
			]; 
			$scope.gridOptions.data = dData;
			
			$scope.fnDEmpNameSearch = function (row) {
				var name = row.entity.EMP_NAME
			    var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
			    $.ajax({
					url : "/yp/zhr/tna/retrieveEmpWorkInfo",
					type : "post",
					cache : false,
					async : true,
					data : {
						"search_name" : name
					},
					dataType : "json",
					success : function(result) {
						if (result.list == null || result.list.length == 0) {
							swalWarningCB("데이터가 없습니다.");
							row.entity.EMP_CD = "";
							row.entity.EMP_DEPT = "";
							row.entity.EMP_CLASS = "";
							row.entity.EMP_SHIFT = "";
						} else if (result.list.length > 1) {
							//사용자선택 팝업 **나중에 구축하자
							swalWarningCB("동명자가 있습니다. 관리자에게 문의하세요.");
						} else {
							row.entity.EMP_CD = result.list[0].EMP_CD;
							row.entity.EMP_DEPT = result.list[0].ORGTX;
							row.entity.EMP_CLASS = result.list[0].ZCLST;
							row.entity.EMP_SHIFT = result.list[0].JO_NAME;
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
			
			
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  

		} ]);

		$(document).ready(function() {
			// 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
			scope = angular.element(document.getElementById("d-shds-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
			
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
					cntQuery  : "yp_ZHR.retrieveMonthlyMealListCnt", 	
					listQuery : "yp_ZHR.retrieveMonthlyMealList"
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
			
			// 부트스트랩 날짜객체
			$(document).on("focus", ".dtp", function() {
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
			
			/****************************************엑셀 다운로드 공통 시작****************************************/		
			$("#excel_btn").click(function(e){
				if(scope.gridOptions.data.length > 0){	//그리드 데이터 존재여부 확인
					var query_name = "yp_ZHR.retrieveMonthlyMealList_excel";	//다운 받을 엑셀쿼리명
					var excel_name = "월간 식대 조회현황";							//다운 받을 엑셀파일명
					
					excelDownload('/core/excel/excelDownloadWithQuery.do', data, {list:query_name, excel_name:excel_name});	//url, 조회영역 폼(폼 이름 확인), 필수파라메터
				}else{
					swalInfo("조회된 데이터가 없습니다.\n1건 이상의 데이터만 엑셀다운로드 가능 합니다.");
				}		
			});
			/****************************************엑셀 다운로드 공통  끝  ****************************************/
			/****************************************엑셀 템플릿 다운로드 시작****************************************/		
			$("#excelTemplate_btn").on("click",function(){
				
				var form = document.createElement("form");
		    	var input = document.createElement("input");
		    	input.name = "file_name";
		    	input.value = "restaurant_sample.xlsx";
		    	input.type = "hidden";
		    	form.appendChild(input);
		    	
		    	input = document.createElement("input");
		    	input.name = "${_csrf.parameterName}";
		    	input.value = "${_csrf.token}";
		    	input.type = "hidden";
		    	form.appendChild(input);
		    	
		    	form.method = "post";
		    	form.action = "/file/templateDownload";
		    	
		    	document.body.appendChild(form);
		    	
		    	form.submit();
		    	form.remove();
				
			});
			/****************************************엑셀 템플릿 다운로드  끝  ****************************************/
			
			$("#d_add").click(function(){
		    	fnAddRowD(scope);
			});
		    $("#d_add5").click(function(){
		    	for(var i=0;i<5;i++){
		    		fnAddRowD(scope);
		    	}
		    });
		    
		    $("#d_reg").click(function(){
		    	var selectedRows = scope.gridApi.selection.getSelectedRows();	//그리드 선택된 rows data
		    	if(selectedRows.length > 0){
			    	if(confirm("등록하겠습니까?")){
			    		//form데이터 + 그리드데이터 json으로 변환 및 추가해서 서버로 전송
						var data = $("#frm").serializeArray();
			    		//첫번째 row의 날짜, 식사 정보 가져오기
			    		var date = scope.gridApi.grid.rows[0].entity.DATE;
			    		var meal_type = scope.gridApi.grid.rows[0].entity.MEAL_TYPE;
			    		data.push({name: "date", value: date});
			    		data.push({name: "meal_type", value: meal_type});
						data.push({name: "gridData", value: JSON.stringify(selectedRows)});
						$.ajax({
						    url: "/yp/zhr/lbm/createDosilakAppli",
						    type: "POST",
						    cache:false,
						    async:true, 
						    data : data,
						    dataType:"json",
						    success: function(result) {
						    	swalSuccess(result.msg);
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
					}
		    	}else{
		    		swalWarning("등록할 항목을 선택해 주세요.");
					return false;
		    	}
			});
		    
		});
	</script>
	
	<!-- <<<<<<< 식당 script >>>>>>>>>  -->
	<script>
		//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
		app.controller('rShdsCtrl', [ '$scope', '$window', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $window, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
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
			
			var dColumnDefs = [
				{
					displayName : '일자',
					field : 'DATE',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full">'+
										'<input ng-if="!row.entity.isAddedRow" type="text" class="absolute_center calendar dtp width_90_percent" size="10" ng-model="row.entity.DATE" />'+
										'<div ng-if="row.entity.isAddedRow" class="absolute_center">상동</div>'+
									'</div>'
				}, 
				{
					displayName : '식사',
					field : 'MEAL_TYPE',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : 
						'<div class="ui-grid-cell-contents relatvie_box height_full">'+
							'<select ng-if="!row.entity.isAddedRow" class="absolute_center" style="margin-left:5px;" ng-model="row.entity.MEAL_TYPE">'+
								'<option value="조식">조식</option>'+
								'<option value="중식">중식</option>'+
								'<option value="석식" >석식</option>'+
							'</select>'+
							'<div ng-if="row.entity.isAddedRow" class="absolute_center">상동</div>'+
						'</div>'
				}, 
				{
					displayName : '성명',
					field : 'EMP_NAME',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><input class="absolute_center width_90_percent" type="text" ng-model="row.entity.EMP_NAME" ng-blur="grid.appScope.fnDEmpNameSearch(row)" /></div>'
				},
				{
					displayName : '사번',
					field : 'EMP_CD',
					visible : true,
					cellClass : "center",
					cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><div class="absolute_center">{{row.entity.EMP_CD}}</div></div>',
					enableCellEdit : false,
					allowCellFocus : false
				},
				{
					displayName : '부서',
					field : 'EMP_DEPT',
					visible : true,
					cellClass : "center",
					cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><div class="absolute_center">{{row.entity.EMP_DEPT}}</div></div>',
					enableCellEdit : false,
					allowCellFocus : false
				},
				{
					displayName : '근무반',
					field : 'EMP_CLASS',
					visible : true,
					cellClass : "center",
					cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><div class="absolute_center">{{row.entity.EMP_CLASS}}</div></div>',
					enableCellEdit : false,
					allowCellFocus : false
				},
				{
					displayName : '근무조',
					field : 'EMP_SHIFT',
					visible : true,
					cellClass : "center",
					cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full"><div class="absolute_center">{{row.entity.EMP_SHIFT}}</div></div>',
					enableCellEdit : false,
					allowCellFocus : false
				}
			]; 
			  		
			
			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바
 				showGridFooter: true,
				showColumnFooter : false,
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
				enableAutoFitColumns : true, //컬럼 width를 자동조정
				multiSelect : true, //여러로우선택
				enablePagination : false,
				enablePaginationControls : false,

				columnDefs : dColumnDefs,
				
				onRegisterApi: function( gridApi ) {
				      $scope.gridApi = gridApi;
				 }
			});

			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			
			//기본 데이터
			var dData = [
			    {
			      "DATE": "<%=toDay%>",
			      "MEAL_TYPE" : "조식"
			    }
			]; 
			$scope.gridOptions.data = dData;
			
			$scope.fnDEmpNameSearch = function (row) {
				var name = row.entity.EMP_NAME
			    var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
			    $.ajax({
					url : "/yp/zhr/tna/retrieveEmpWorkInfo",
					type : "post",
					cache : false,
					async : true,
					data : {
						"search_name" : name
					},
					dataType : "json",
					success : function(result) {
						if (result.list == null || result.list.length == 0) {
							swalWarningCB("데이터가 없습니다.");
							row.entity.EMP_CD = "";
							row.entity.EMP_DEPT = "";
							row.entity.EMP_CLASS = "";
							row.entity.EMP_SHIFT = "";
						} else if (result.list.length > 1) {
							//사용자선택 팝업 **나중에 구축하자
							swalWarningCB("동명자가 있습니다. 관리자에게 문의하세요.");
						} else {
							row.entity.EMP_CD = result.list[0].EMP_CD;
							row.entity.EMP_DEPT = result.list[0].ORGTX;
							row.entity.EMP_CLASS = result.list[0].ZCLST;
							row.entity.EMP_SHIFT = result.list[0].JO_NAME;
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
			
			
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  

		} ]);

		$(document).ready(function() {
			// 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
			r_scope = angular.element(document.getElementById("r-shds-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
			
			r_scope.gridApi.core.on.rowsRendered(r_scope, function() {	//그리드 렌더링 후 이벤트
				
			});
			r_scope.gridApi.selection.on.rowSelectionChanged(r_scope, function(row) { //로우 선택할때마다 이벤트
				//console.log("row2", row.entity);
			});
			r_scope.gridApi.selection.on.rowSelectionChangedBatch(r_scope, function(rows) { //전체선택시 가져옴
				//console.log("row3", rows[0].entity); //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
			});
			// pagenation option setting  그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param = {
					EXEC_RFC  : "N", // RFC 여부
					cntQuery  : "yp_ZHR.retrieveMonthlyMealListCnt", 	
					listQuery : "yp_ZHR.retrieveMonthlyMealList"
			};
			r_scope.paginationOptions = customExtend(r_scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
			
			// 부트스트랩 날짜객체
			$(document).on("focus", ".dtp", function() {
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
			
			/****************************************엑셀 다운로드 공통 시작****************************************/		
			$("#excel_btn").click(function(e){
				if(r_scope.gridOptions.data.length > 0){	//그리드 데이터 존재여부 확인
					var query_name = "yp_ZHR.retrieveMonthlyMealList_excel";	//다운 받을 엑셀쿼리명
					var excel_name = "월간 식대 조회현황";							//다운 받을 엑셀파일명
					
					excelDownload('/core/excel/excelDownloadWithQuery.do', data, {list:query_name, excel_name:excel_name});	//url, 조회영역 폼(폼 이름 확인), 필수파라메터
				}else{
					swalInfo("조회된 데이터가 없습니다.\n1건 이상의 데이터만 엑셀다운로드 가능 합니다.");
				}		
			});
			/****************************************엑셀 다운로드 공통  끝  ****************************************/
			
		    $("#r_add").click(function(){
		    	fnAddRowR(r_scope);
			});
		    $("#r_add5").click(function(){
		    	for(var i=0;i<5;i++){
		    		fnAddRowR(r_scope);
		    	}
		    });
		    
		    $("#r_reg").click(function(){
		    	var selectedRows = r_scope.gridApi.selection.getSelectedRows();	//그리드 선택된 rows data
		    	if(selectedRows.length > 0){
			    	if(confirm("등록하겠습니까?")){
			    		//form데이터 + 그리드데이터 json으로 변환 및 추가해서 서버로 전송
						var data = $("#frm").serializeArray();
						//첫번째 row의 날짜, 식사 정보 가져오기
			    		var date = r_scope.gridApi.grid.rows[0].entity.DATE;
			    		var meal_type = r_scope.gridApi.grid.rows[0].entity.MEAL_TYPE;
			    		data.push({name: "date", value: date});
			    		data.push({name: "meal_type", value: meal_type});
						data.push({name: "gridData", value: JSON.stringify(selectedRows)});
						$.ajax({
						    url: "/yp/zhr/lbm/createRestaurant",
						    type: "POST",
						    cache:false,
						    async:true, 
						    data : data,
						    dataType:"json",
						    success: function(result) {
						    	swalSuccess(result.msg);
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
					}
		    	}else{
		    		swalWarning("등록할 항목을 선택해 주세요.");
					return false;
		    	}
			});
			
		});
	</script>
	
	
	<script type="text/javascript">
		//도시락 행 추가
		function fnAddRowD(scope){
			var data = {
				"isAddedRow" : true
			};
			scope.gridOptions.data.push(data);
			scope.gridApi.grid.refresh();
		}
	
		function fnAddRowR(r_scope){
			var data = {
				"isAddedRow" : true
			};
			r_scope.gridOptions.data.push(data);
			r_scope.gridApi.grid.refresh();
		}
	
	
		function fnExcelUpload(){
			  var form = $("#mfrm")[0];
	    	  var formData = new FormData(form);
			  $.ajax({
		            url: "/file/excelUpload",
		            processData: false,
		            contentType: false,
		            data: formData,
		            type: 'POST',
		            success: function(data){
		            	if(JSON.parse(data).result > 0){
		            		swalSuccess("업로드 되었습니다.");
		            	}else{
		            		swalWarning("업로드가 진행되지 않았습니다. 엑셀 데이터 확인 후 다시 업로드 해주십시오.");
		            	}
		            },
		            beforeSend:function(){
						$('.wrap-loading').removeClass('display-none');
					},
					complete:function(){
				        $('.wrap-loading').addClass('display-none');
				    },
				    error:function(request,status,error){
				    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
				    	if(error.status == "200"){
		            		location.href = "/core/login/sessionOut.do";
		            	}
		    			if(error.status == "402"){	//인터셉터-밸리데이션 이슈
		    				swalWarning(error.responseJSON.icm_validation_message);
		    			}
		            	if(error.status == "403"){
		            		location.href = "/core/login/sessionOut.do";
		            	}
		            	if(error.status == "500"){
		            		swalDanger("엑셀업로드가 실패했습니다.\n아래의 사항 조치 후 재시도 해주십시오.\n\n1.올바른 엑셀템플릿인지 확인\n2.중복 코드(PK) 삽입여부 확인\n3.입력된 엑셀데이터 길이 확인\n4.데이터 마지막행 이후 모든 행 삭제");
		            	}
		            	swalDangerCB("조회에 실패하였습니다.\n관리자에게 문의해주세요.");
				    }
		        });
		  
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
	
		function fnDChkAll(checkFlag) { 
			var f = $("input[name=no]");
		    for(var i=0; i<f.length; i++) { 
				f[i].checked = checkFlag;
			} 
		}
	
		function fnRChkAll(checkFlag) { 
			var f = $("input[name=r_emp_cd]");
		    for(var i=0; i<f.length; i++) { 
				f[i].checked = checkFlag;
			} 
		}
	
		function fnREmpNameSearch(name,index){
			$.ajax({
			    url: "/hr/retrieveEmpWorkInfo",
			    type: "POST",
			    cache:false,
			    async:true, 
			    dataType:"json",
			    data:{"search_name":name},
			    success: function(result) {
			    	console.log(result);
			    	if(result.list.length == 0){
			    		swalWarningCB("데이터가 없습니다.");
			    		$("select[name=meal_type]").focus();//무한 알림창 방지(chrome)
			    	}else if(result.list.length > 1){
			    		//사용자선택 팝업 **나중에 구축하자()
			    	}else{
			    		var idx = index - 1;
			    		$("input[name=r_emp_cd]:eq("+idx+")").val(result.list[0].EMP_CD);
			    		$("#r_emp_cd_"+index).text(result.list[0].EMP_CD);
			    		$("#r_emp_dept_"+index).text(result.list[0].ORGTX);
			    		$("#r_emp_class_"+index).text(result.list[0].ZCLST);
			    		$("#r_emp_shift_"+index).text(result.list[0].JO_NAME);
			    	}
			    	
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
		
	</script>
</body>
