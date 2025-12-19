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
	
	<form id="frm" name="frm">
		<!-- 20191023_khj for csrf -->
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<!-- 엑셀업로드 insertQuery -->
		<input type='hidden' id='insertQuery' name='insertQuery' value='oracle.yp_fixture.fixture_master_insert'>
		<!-- 엑셀업로드 updateQuery -->
		<input type='hidden' id='updateQuery' name='updateQuery' value='oracle.yp_fixture.fixture_master_update'>
		
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
						<th>템플릿 다운로드</th>
						<td><input type="button" class="btn btn_make" id="excelTemplate_btn" value="ExcelDown"/></td>
						<th>엑셀 업로드</th>
						<td>
							<input type="file" name="excelfile" id="upload" value="" style="width:300px;"/>
							<input type="button" class="btn_g" id="upload_btn" value="엑셀 업로드" onclick="fnExcelUpload();"/>
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
				<input type="button" class="btn_g" id="mod_btn" value="수정" >
				<input type="button" class="btn_g" id="mod_cancel_btn" value="수정취소" style="display:none;">
				<input type="button" class="btn_g" id="add_btn" value="추가" style="display:none;">
				<input type="button" class="btn_g" id="remove_btn" value="삭제" style="display:none;">
				<input type="button" class="btn_g" id="save_btn" value="저장" style="display:none;">
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
		
		/**
		 * Grid Mode
		 * R : Read 모드
		 * U : Update 모드
		 */
		$scope.mode = 'R';
		
		$scope.fnSearchPopup = function(type, row) {
			var target = scope.gridOptions.data.indexOf(row.entity);
			fnSearchPopup(type, target);
		};
		
		$scope.change = function(oRow){
			if(isEmpty(oRow.entity.ROW_STATUS)){
				oRow.entity.ROW_STATUS = 'U';	
			}
			
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
			{
				displayName : '상태',
				field : 'ROW_STATUS',
				width : '80',
				visible : true,
				cellClass : "center",
				pinnedLeft : true,
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<img ng-if="row.entity.ROW_STATUS === \'C\'" class="ui-grid-cell-contents" ng-model="row.entity.ROW_STATUS" src="/resources/yp/images/icon_create.png"></img>'
					+ '<img ng-if="row.entity.ROW_STATUS === \'U\'" class="ui-grid-cell-contents" ng-model="row.entity.ROW_STATUS" src=\'/resources/yp/images/icon_update.png\'></img>'
					+ '<img ng-if="row.entity.ROW_STATUS === \'D\'" class="ui-grid-cell-contents" ng-model="row.entity.ROW_STATUS" src=\'/resources/yp/images/icon_delete.png\'></img>'
			}, 
			{
				displayName : '제조사',
				field : 'MANUFACTURER',
				/* width : '100', */
				visible : true,
				cellClass : "center",
				pinnedLeft : true,
				enableCellEdit : true,
				allowCellFocus : false,
				cellTemplate : '<div ng-if="grid.appScope.mode === \'R\'" class="ui-grid-cell-contents" ng-model="row.entity.FIXTURE_NAME">{{row.entity.MANUFACTURER}}</div>'
					+ '<input ng-if="grid.appScope.mode === \'U\'" type="text" class="" ng-model="row.entity.MANUFACTURER" style="width: 75%; height: 100% !important;" ng-change="grid.appScope.change(row)" />'
			}, 
			{
				displayName : '비품명',
				field : 'FIXTURE_NAME',
				/* width : '100', */
				visible : true,
				cellClass : "center",
				pinnedLeft : true,
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div ng-if="row.entity.ROW_STATUS != \'C\'" class="ui-grid-cell-contents" ng-model="row.entity.FIXTURE_NAME" >{{row.entity.FIXTURE_NAME}}</div>'
				+ '<input ng-if="row.entity.ROW_STATUS === \'C\'" type="text" class="" ng-model="row.entity.FIXTURE_NAME" style="width: 75%; height: 100% !important;" ng-change="grid.appScope.change(row)" />'
			}, 
			{
				displayName : '규격',
				field : 'REGULATION_MEASUREMENT',
				/* width : '100', */
				visible : true,
				cellClass : "center",
				pinnedLeft : true,
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div ng-if="grid.appScope.mode === \'R\'" class="ui-grid-cell-contents" ng-model="row.entity.FIXTURE_NAME" >{{row.entity.REGULATION_MEASUREMENT}}</div>'
					+ '<input ng-if="grid.appScope.mode === \'U\'" type="text" class="" ng-model="row.entity.REGULATION_MEASUREMENT" style="width: 75%; height: 100% !important;" ng-change="grid.appScope.change(row)" />'
			}, 
			{
				displayName : '비품 유형',
				field : 'FIXTURE_TYPE',
				/* width : '100', */
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div ng-if="grid.appScope.mode === \'R\'" class="ui-grid-cell-contents" ng-model="row.entity.FIXTURE_TYPE" >{{row.entity.FIXTURE_TYPE}}</div>'
					+ '<input ng-if="grid.appScope.mode === \'U\'" type="text" class="" ng-model="row.entity.FIXTURE_TYPE" style="width: 75%; height: 100% !important;" ng-change="grid.appScope.change(row)" />'
			}, {
				displayName : '단가',
				field : 'UNIT_PRICE',
				/* width : '100', */
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div ng-if="grid.appScope.mode === \'R\'" class="ui-grid-cell-contents" ng-model="row.entity.UNIT_PRICE" >{{row.entity.UNIT_PRICE}}</div>'
					+ '<input ng-if="grid.appScope.mode === \'U\'" type="text" class="" ng-model="row.entity.UNIT_PRICE" style="width: 75%; height: 100% !important;" ng-change="grid.appScope.change(row)" />'
			}, {
				displayName : '재고수량',
				field : 'STOCK_AMOUNT',
				/* width : '100', */
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div ng-if="grid.appScope.mode === \'R\'" class="ui-grid-cell-contents" ng-model="row.entity.STOCK_AMOUNT" >{{row.entity.STOCK_AMOUNT}}</div>'
					+ '<input ng-if="grid.appScope.mode === \'U\'" type="text" class="" ng-model="row.entity.STOCK_AMOUNT" style="width: 75%; height: 100% !important;" ng-change="grid.appScope.change(row)" />'
			}, {
				displayName : '재고이용가능수량',
				field : 'AVAILABLE_STOCK_AMOUNT',
				/* width : '100', */
				visible : false,
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
	
	scope.isEmpty = function(oData){
		console.log('[TEST]oData:',oData);
		return isEmpty(oData);
	}
	
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
	
	// 추가
	$("#add_btn").on("click", function() {
		scope.addRow({
			ROW_STATUS : 'C',
			FIXTURE_NAME : '',
			MANUFACTURER : '',
			REGULATION_MEASUREMENT : '',
			FIXTURE_TYPE : '',
			UNIT_PRICE : '',
			STOCK_AMOUNT : 0
		}, true, "desc");
	});
	
	$("#save_btn").on("click", function(){
		var token = $("meta[name='_csrf']").attr("content"),
			header = $("meta[name='_csrf_header']").attr("content"),
			rows = scope.gridOptions.data;
		
		/**
		 * 추가, 수정, 삭제 건만 필터링
		 */
		var filtered_rows = rows.filter(function(row){
			return !isEmpty(row.ROW_STATUS);
		});
		
		/** 
		 * 저장할 데이터 존재 여부 체크
		 */
		if(filtered_rows.length === 0){
			swalWarning("저장할 데이터가 없습니다.");
			return;
		}
		
		/**
		 * Validation 체크
		 */
		if(!validation(filtered_rows)){
			return;
		}
		
		console.log(filtered_rows);
		 
		$.ajax({
			url : "/yp/fixture/fixture_master_save",
			type : "POST",
			cache : false,
			async : true,
			dataType : "json",
			data : "grid_data="+JSON.stringify(filtered_rows),
			success : function(data) {
				view_mode();
				
				swalSuccessCB(data.result + "건 저장했습니다.", function(){
					$("#search_btn").trigger("click");
				});
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
	});
	
	$("#remove_btn").on("click", function(){
		var rows = scope.gridOptions.data,
			selectedRows = scope.gridApi.selection.getSelectedRows();
		
		if (isEmpty(selectedRows)) {
			swalWarning("삭제할 항목을 선택하세요.");
			return false;
		}
		
		selectedRows.forEach(function(oRow, Index){
			if(isEmpty(oRow.ROW_STATUS) || oRow.ROW_STATUS === 'U'){
				oRow.ROW_STATUS = 'D';				
			}else if(oRow.ROW_STATUS === 'C'){
				rows.splice(rows.indexOf(oRow), 1);
			}
		}.bind(this));
		
		// 그리드 새로고침
		scope.gridApi.grid.refresh();
		scope.gridApi.selection.clearSelectedRows();
		
	});
	
	$("#mod_btn").on("click", function(){
		edit_mode();
	});
	
	$("#mod_cancel_btn").on("click", function(){
		function mod_cancel(){
			view_mode();
			$("#search_btn").trigger("click");	
		};
		
		if(is_changed()){
			swal({
				icon : "warning",
				text : "변경사항이 존재합니다. 정말 취소하시겠습니까?",
				closeOnClickOutside : false,
				closeOnEsc : false,
				buttons : {
					confirm : {
						text : "확인",
						value : true,
						visible : true,
						className : "",
						closeModal : true
					},
					cancel : {
						text : "취소",
						value : null,
						visible : true,
						className : "",
						closeModal : true
					}
				}
			}).then(function(result) {
				if(result){
					mod_cancel();
				}
			});
		}else{
			mod_cancel();
		}
	});
	
	/**
	 * 엑셀 템플릿 다운로드
	 */
	 $("#excelTemplate_btn").on("click",function(){
		var form = document.createElement("form");
		var input = document.createElement("input");
		input.name = "file_name";
		input.value = "fixture_master_upload_sample.xlsx";
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
	
	function validation(aData){
		for(var i=0; i<aData.length; i++){
			var oData = aData[i];
			
			if(isEmpty(oData.MANUFACTURER)){
				swalWarning("("+(i+1)+"행) 제조사를 입력해주세요");
				return false;
			}
			if(isEmpty(oData.FIXTURE_NAME)){
				swalWarning("("+(i+1)+"행) 비품명을 입력해주세요");
				return false;
			}
			if(isEmpty(oData.REGULATION_MEASUREMENT)){
				swalWarning("("+(i+1)+"행) 규격을 입력해주세요");
				return false;
			}
			if(isEmpty(oData.FIXTURE_TYPE)){
				swalWarning("("+(i+1)+"행) 비품유형을 입력해주세요");
				return false;
			}
			if(isEmpty(oData.UNIT_PRICE)){
				swalWarning("("+(i+1)+"행) 단가를 입력해주세요");
				return false;
			}
		}
		return true;
	}
	
	function is_changed(){
		var rows = scope.gridOptions.data,
			is_changed = false;
	
		rows.forEach(function(oRow, Index){
			if(!isEmpty(oRow.ROW_STATUS)){
				is_changed = true;
			}
		}.bind(this));
		
		return is_changed;
	}
	
	function view_mode(){
		$("#add_btn").css("display","none");
		$("#mod_btn").css("display","");
		$("#mod_cancel_btn").css("display","none");
		$("#remove_btn").css("display","none");
		$("#save_btn").css("display","none");
		$("#search_btn").attr("disabled", false);
		$("#upload_btn").attr("disabled", false);
		grid_mode_change('R');
	}
	
	function edit_mode(){
		$("#add_btn").css("display","");
		$("#mod_btn").css("display","none");
		$("#mod_cancel_btn").css("display","");
		$("#remove_btn").css("display","");
		$("#save_btn").css("display","");
		$("#search_btn").attr("disabled", true);
		$("#upload_btn").attr("disabled", true);
		grid_mode_change('U');
	}
	
	function grid_mode_change(sMode){
		scope.mode = sMode;
		scope.gridApi.grid.refresh();
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

/* 파일업로드 */
function fnExcelUpload(){
	var form = $("#frm")[0],
		formData = new FormData(form);
	
	if($("#upload").val().length < 1){
		swalWarning("파일을 먼저 선택해주세요.");
		return
	}
	
	/**
	 * 결재 상태 중 엑셀 업로드 가능 해야할까?
	 */
	var token = $("meta[name='_csrf']").attr("content"),
		header = $("meta[name='_csrf_header']").attr("content"),
	    data = $("#frm").serializeArray();
	
	$.ajax({
		url: "/file/excelUploadFixture",
		processData: false,
		contentType: false,
		dataType: 'json',
		data: formData,
		type: 'POST',
		success: function(data){
			let test = data.result.U;
			if(data.result.state === 'S'){
				swalSuccess(`업로드 되었습니다.\r\n 생성:\${data.result.C} \r\n 수정:\${data.result.U}`);
				$("#search_btn").trigger("click");
				//파일 input 초기화
				$("#upload").val("");
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
			console.error("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
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
			swalDangerCB("엑셀업로드에 실패하였습니다.\n관리자에게 문의해주세요.");
		}
	});
}


</script>

</body>