<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
if (request.getProtocol().equals("HTTP/1.1"))
	response.setHeader("Cache-Control", "no-cache");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${current_menu.menu_name}</title>
<style>
.ui-grid-cell-contents{
	white-space : pre !important;
}

</style>
</head>

<body>
	<h2>
		${current_menu.menu_name}
		<!-- 공통 - 네비게이션 시작 -->
		<ul class="loc">
			<li>
				<img src="/resources/yp/images/ic_loc_home.png">
			</li>
			
			<c:forEach var="menu" items="${breadcrumbList}">
				<li>${menu.menu_name}</li>
			</c:forEach>
		</ul>
		<!-- 공통 - 네비게이션 종료 -->
	</h2>
	
	<form  id="searchFrm">
		<!-- 20191023_khj for csrf -->
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<section>
			<div class="tbl_box">
				<table>
					<colgroup>
						<col width="5%" />
						<col width="25%"/>
						<col width="5%" />
						<col width="25%"/>
						<col width="5%" />
						<col width="25%"/>
					</colgroup>
					<tr>
						<th>비품명</th>
						<td>
							<input type="text" name="fixture_name" value="${req_data.srch_ent_code}">
						</td>
						<th>비품유형</th>
						<td>
							<input type="text" name="fixture_type" value="${req_data.srch_ent_code}">
						</td>
						<th>제조사</th>
						<td>
							<input type="text" name="manufacturer" value="${req_data.srch_ent_code}">
						</td>
			        </tr>
			        <tr>
						<th>규격</th>
						<td>
							<input type="text" name="regulation_measurement" value="${req_data.srch_ent_code}">
						</td>
			        </tr>
				</table>
				<div class="btn_wrap">
					<input type="button" class="btn btn_search" id="search_btn" value="조회"/>
				</div>
			</div>
		</section>
	</form>
	
	<div class="float_wrap" style="margin-bottom:5px;">
		<div class="fr">
			<div class="btn_wrap">
				<input type="button" class="btn_g" id="fixture_req_btn"  value="비품요청"/>
			</div>
		</div>
	</div>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="fixture-uiGrid"  data-ng-controller="fixtureListCtrl" style="height: 600px;">
			<div data-ui-i18n="ko" style="height: auto;">
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
	app.controller('fixtureListCtrl', ['$scope','$controller','$log','StudentService', 'uiGridConstants', 
	function ($scope, $controller, $log, StudentService, uiGridConstants) {		//$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
		var vm = this; 										//this를 vm에 대입, 아래에서 부모의 $scope를 vm에 추가하기 위해 			
		angular.extend(vm, $controller('CodeCtrl',{ 		//CodeCtrl(ui-grid 커스텀 api)를 상속받는다
			$scope : $scope									// 자식컨트롤러의 vm에 부모 컨트롤러의 $scope를 합, 이로써 자식 컨트롤러에서 부모의 모든 $scope(this)를 사용 할 수 있음			
		}));	
		var paginationOptions = vm.paginationOptions;		//부모의 paginationOptions를 자식의 paginationOptions에 대입,즉시실행 함수
		
		paginationOptions.pageNumber = 1;					//초기 page number
		paginationOptions.pageSize = 10;					//초기 한번에 보여질 로우수
		$scope.paginationOptions = paginationOptions;
		
		$scope.gridApi = vm.gridApi;						//외부에서 grid의 클릭이벤트와 같은것들을 쓰기 위해서
		$scope.loader = vm.loader;
		$scope.addRow = vm.addRow;
		
		$scope.pagination = vm.pagination;
		
		// 세션아이드코드 스코프에저장
		$scope.s_emp_code = "${s_emp_code}";
		
		$scope.uiGridConstants = uiGridConstants;
		
		// formater - String yyyyMMdd -> String yyyy/MM/dd
		$scope.formatter_date = function(str_date) {
			if (str_date.length === 8) {
				return str_date.replace(/(\d{4})(\d{2})(\d{2})/g, '$1/$2/$3');
			} else {
				return str_date;
			}
		};

		// formater - 천단위 콤마
		$scope.formatter_decimal = function(str_date) {
			if (!isNaN(Number(str_date))) {
				return Number(str_date).toLocaleString()
			} else {
				return str_date;
			}
		};
		
		$scope.fnSearchPopup = function(type, row) {
			var target = scope.gridOptions.data.indexOf(row.entity);
			fnSearchPopup(type, target);
		};
		
		
		$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
		{
			enableGridMenu: true,	 //필터버튼
			enableFiltering : false, //각 컬럼에 검색바

			paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
			paginationPageSize : 10,

			enableCellEditOnFocus : false, //셀 클릭시 edit모드 
			enableSelectAll : true, //전체선택 체크박스
			enableRowSelection : false, //로우 선택
			enableRowHeaderSelection : true, //맨앞 컬럼 체크박스 컬럼으로
			selectionRowHeaderWidth : 35, //체크박스 컬럼 길이
			enableHorizontalScrollbar : "1",
			enableVerticalScrollbar : "1",
			rowHeight : 27, //체크박스 컬럼 높이
			//useExternalPagination : true, //pagination을 직접 세팅
			enableAutoFitColumns : false, //컬럼 width를 자동조정
			multiSelect : true, //여러로우선택
			enablePagination : true,
			enablePaginationControls : true,

			columnDefs : [ //컬럼 세팅
// 			{
// 				displayName : '제조사',
// 				field : 'MANUFACTURER',
// 				/* width : '100', */
// 				visible : true,
// 				cellClass : "center",
// 				pinnedLeft : true,
// 				enableCellEdit : false,
// 				allowCellFocus : false
// 			}, 
			{
				displayName : '비품명',
				field : 'FIXTURE_NAME',
				/* width : '100', */
				visible : true,
				cellClass : "center",
				pinnedLeft : true,
				enableCellEdit : false,
				allowCellFocus : false
			}, 
// 			{
// 				displayName : '규격',
// 				field : 'REGULATION_MEASUREMENT',
// 				/* width : '100', */
// 				visible : true,
// 				cellClass : "center",
// 				pinnedLeft : true,
// 				enableCellEdit : false,
// 				allowCellFocus : false
// 			}, 
			{
				displayName : '비품 유형',
				field : 'FIXTURE_TYPE',
				/* width : '100', */
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, {
				displayName : '단가',
				field : 'UNIT_PRICE',
				/* width : '100', */
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, {
				displayName : '재고수량',
				field : 'STOCK_AMOUNT',
				/* width : '100', */
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, {
				displayName : '재고이용가능수량',
				field : 'AVAILABLE_STOCK_AMOUNT',
				/* width : '100', */
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, {
				displayName : 'CREATE_USER',
				field : 'CREATE_USER',
				width : '100',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, {
				displayName : 'CREATE_DATE',
				field : 'CREATE_DATE',
				width : '100',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, {
				displayName : 'UPDATE_USER',
				field : 'UPDATE_USER',
				width : '100',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, {
				displayName : 'UPDATE_DATE',
				field : 'UPDATE_DATE',
				width : '100',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}],
			onRegisterApi: function(gridApi){
			      $scope.gridApi = gridApi;
			      $scope.gridApi.pagination.on.paginationChanged( $scope, function( currentPage, pageSize){
			      	$scope.getPage(currentPage, pageSize);
				});
			}
		});

		$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
		$scope.reloadGrid = vm.reloadGrid;
		//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  
															
	}]);
	//복붙영역(앵귤러단) 끝
</script>

<script>
$(document).ready(function(){
	//복붙영역(앵귤러 이벤트들 가져오기) 시작, 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
	var scope = angular.element(document.getElementById("fixture-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
	scope.gridApi.selection.on.rowSelectionChanged(scope,function(row){			//로우 선택할때마다 이벤트
		
    });
	
	/* scope.gridApi.selection.on.rowSelectionChangedBatch(scope,function(rows){	//전체선택시 가져옴
		console.log(rows);           //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
    });	 */
	
	//pagenation option setting  그리드를 부르기 전에 반드시 선언
	var param = {
		listQuery : "yp_fixture.grid_fixture_list", 				//list가져오는 마이바티스 쿼리 아이디
		cntQuery : "yp_fixture.grid_fixtrue_list_cnt"						//list cnt 가져오는 마이바티스 쿼리 아이디
	}; 
	scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합	
	
	scope.reloadGrid({
		
	});
	//복붙영역(앵귤러 이벤트들 가져오기) 끝
	
	//rows렌더링된 후에 동작 이벤트 추가
	scope.gridApi.core.on.rowsRendered(scope, function() {
        
	});
	
	$("#search_btn").on("click",function(){		
		/**
		 * Param 1 : parameters
	     * Param 2 : callback 
		 */
		scope.reloadGrid({
			manufacturer : $("input[name=manufacturer]").val(),
			fixture_name : $("input[name=fixture_name]").val(),
			fixture_type : $("input[name=fixture_type]").val(),
			regulation_measurement : $("input[name=regulation_measurement]").val()
		});
	});
	
	$("#fixture_req_btn").on("click",function(){		
		var rows = scope.gridApi.selection.getSelectedRows();
		console.log(rows);
		if(rows.length === 0){
			swalWarningCB("비품을 먼저 선택하세요.");
			return false;
		}else{
			//비품요청 팝업 open
			fnFixtureReqPopup();
		}
	});
	
	$("#purchase_req_btn").on("click",function(){		
		var rows = scope.gridApi.selection.getSelectedRows();
		console.log(rows);
		if(rows.length === 0){
			swalWarningCB("비품을 먼저 선택하세요.");
			return false;
		}else{
			
		}
	});
	
	//비품요청 팝업
	function fnFixtureReqPopup() {
		var rows = scope.gridApi.selection.getSelectedRows();
		
		console.log(rows);
		
		/**
		 * window.open(URL, name, specs, replace)
		 * 비품요청서 : EF165657639809073
		 * Parameter : FIXTURE_REQ_CODE
		 * parameter 여러개일 경우 ';'로 합쳐서 보내주자.
		 */
		window.open("", "비품요청", "width=800, height=500");
		 
		/**
		 * fnHrefPopup(url, target, pr)
		 */
		fnHrefPopup("/yp/popup/fixture/fixtureReqPop", "비품요청", {
			"gridData" : JSON.stringify(rows)
		});
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

		/**
		 * [form 속성]
		 * action : form 데이터를 보낼 URL
		 * target : 네이밍 된 iframe
		 */
		popForm.name = "popForm";
		popForm.method = "post";
		popForm.target = target;
		popForm.action = url;

		document.body.appendChild(popForm);

		popForm.appendChild(csrf_element);

		/**
		 * parameter를 input으로 form에 추가
		 */
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
	
	
});

</script>

</body>