<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
if (request.getProtocol().equals("HTTP/1.1"))
	response.setHeader("Cache-Control", "no-cache");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>테블릿 모니터링</title>
<style>
.ui-grid-cell-contents{
	white-space : pre !important;
}

</style>
</head>
<body>
	<h2>
		테블릿 모니터링
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
	<form id="tabletForm">
		<!-- 20191023_khj for csrf -->
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<section>
			<div class="tbl_box">
				<%-- <table>
					<colgroup>
						<col width="12%" />
						<col />
						<col width="12%" />
						<col />
					</colgroup>
					<tbody>
						<tr>
							<th scope="col">권한명</th>
							<td>
								<input class="inputTxt"  type="text" name="tablet_name" id="tablet_name"> 
							</td>
							<th scope="col"></th>
							<td></td>
						</tr>
					</tbody>
				</table> --%>
				<div class="btn_wrap">
					<input type="button" class="btn btn_search" id="btn_search" value="조회"/>
				</div>
			</div>
		</section>
	</form>
	
 	<div class="float_wrap" style="margin-bottom:5px;">
<!--		<div class="fr">
			<div class="btn_wrap">
				<input type="button" class="btn_g" id="btn_app"  value="앱 재실행 "/>
				<input type="button" class="btn_g" id="btn_tablet"  value="태블릿 재시작"/>
			</div>
		</div>
-->	</div> 
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="tabletCtrl-uiGrid"  data-ng-controller="tabletCtrl" style="height: auto;">
			<div data-ui-i18n="ko" style="height: auto;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav data-ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
	</section>


<script>
	//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
	app.controller('tabletCtrl', ['$scope','$controller','$log','StudentService', 
	function ($scope,$controller,$log,StudentService) {		//$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
		var vm = this; 										//this를 vm에 대입, 아래에서 부모의 $scope를 vm에 추가하기 위해 			
		angular.extend(vm, $controller('CodeCtrl',{ 		//CodeCtrl(ui-grid 커스텀 api)를 상속받는다
			$scope : $scope									// 자식컨트롤러의 vm에 부모 컨트롤러의 $scope를 합, 이로써 자식 컨트롤러에서 부모의 모든 $scope(this)를 사용 할 수 있음			
		}));	
		var paginationOptions = vm.paginationOptions;		//부모의 paginationOptions를 자식의 paginationOptions에 대입,즉시실행 함수
		
		paginationOptions.pageNumber = 1;					//초기 page number
		paginationOptions.pageSize = 500;					//초기 한번에 보여질 로우수
		$scope.paginationOptions = paginationOptions;
		
		$scope.gridApi = vm.gridApi;						//외부에서 grid의 클릭이벤트와 같은것들을 쓰기 위해서
		$scope.loader = vm.loader;
		
		$scope.addRow = vm.addRow;
		
		$scope.pagination = vm.pagination;
		
		$scope.gridOptions = vm.gridOptions(  				// 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableFiltering : false, 					//칵 컬럼에 검색바
				paginationPageSizes : [500, 1500, 5000, 10000], 		//한번에 보여질 로우수 셀렉트리스트
				enableCellEditOnFocus : true, 				//셀 클릭시 edit모드 
				enableSelectAll : true, 					//전체선택 체크박스
				enableRowSelection : true, 					//로우 선택
				enableRowHeaderSelection : true, 			//맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 35, 				//체크박스 컬럼 길이
				rowHeight : 27, 							//체크박스 컬럼 높이
				useExternalPagination : true, 				//pagination을 직접 세팅
				enableAutoFitColumns: true,					//컬럼 width를 자동조정
				multiSelect : false, 						//여러로우선택
				enablePagination : false,
				enablePaginationControls: false,
				
		columnDefs : [ //컬럼 세팅
			{
				displayName : '회사명(COMPANY_NAME)',
				field : 'com_nm',
				visible : true,
				enableCellEdit : false,
				allowCellFocus : false,
				cellClass : "center"
			}, {
				displayName : '기기 ID(DEVICE_ID)',
				field : 'dev_id',
				visible : true,
				enableCellEdit : false,
				allowCellFocus : false,
				cellClass : "center"
			}, {
				width : "195",
				displayName : 'WIFI 연결상태',
				field : 'lte_sts',
				visible : true,
				enableCellEdit : false,
				allowCellFocus : false,
				cellClass : function(grid, row, col, rowRenderIndex, colRenderIndex) {
			          if (grid.getCellValue(row,col) === 'Offline') {
			            return 'red center';
           			 } else {
           				return 'green center'
           			 } }
			}, {
				displayName : 'WIFI 상태 확인 일시',
				field : 'up_dt',
				visible : true,
				enableCellEdit : false,
				allowCellFocus : false,
				cellClass : "center"
			}, {
				width : "195",
				displayName : '리더기 연결상태',
				field : 'ble_sts',
				visible : true,
				enableCellEdit : false,
				allowCellFocus : false,
				cellClass : function(grid, row, col, rowRenderIndex, colRenderIndex) {
			          if (grid.getCellValue(row,col) === 'Offline') {
			            return 'red center';
         			 } else {
         				return 'green center'
         			 } }
			}, {
				displayName : '리더기 연결 확인 일시',
				field : 'rf_up_dt',
				visible : true,
				enableCellEdit : false,
				allowCellFocus : false,
				cellClass : "center"
			}]
		});

		$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
		$scope.reloadGrid = vm.reloadGrid;
		//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  

	} ]);
	//복붙영역(앵귤러단) 끝
</script>
<script>
$(document).ready(function(){
	
	//복붙영역(앵귤러 이벤트들 가져오기) 시작, 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
	var scope = angular.element(document.getElementById("tabletCtrl-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
	scope.gridApi.selection.on.rowSelectionChanged(scope,function(row){			//로우 선택할때마다 이벤트
		
	});
	
	/* scope.gridApi.selection.on.rowSelectionChangedBatch(scope,function(rows){	//전체선택시 가져옴
		console.log(rows);		   //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
	});	 */
	
	//pagenation option setting  그리드를 부르기 전에 반드시 선언
	var param = {
		listQuery : "yp_zhw_tablet.tabletList", 				//list가져오는 마이바티스 쿼리 아이디
		cntQuery : "yp_zhw_tablet.tabletListCnt"				//list cnt 가져오는 마이바티스 쿼리 아이디
	}; 
	scope.paginationOptions = customExtend(scope.paginationOptions,param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합	
	//복붙영역(앵귤러 이벤트들 가져오기) 끝
	
	scope.reloadGrid({
	});
	
	$("#btn_search").on("click",function(){
		scope.reloadGrid({
		});
	});
	
	$("#btn_app").on("click",function(){
		var test = $("#com_nm").val()
		console.log(test);
	});
});
</script>
</body>