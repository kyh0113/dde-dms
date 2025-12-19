<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<!-- Modal -->
<div class="modal fade" id="data_authEmpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">&lt;<span id="data_authEmpModal_title"></span> - <span id="data_authEmpModal_menu_title"></span>&gt; 데이터 권한 사용자 목록</h4>
      </div>
      <div class="modal-body">
        	<div class="tblType02">
				<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
				<div id="data_authEmpCtrl-uiGrid"  data-ng-controller="data_authEmpCtrl" style="height: 400px;">
					<div data-ui-i18n="ko" style="height: 100%;">
						<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav data-ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
							<div data-ng-if="loader" class="loader"></div>
							<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
						</div>
					</div>
				</div>
				<!-- 복붙영역(html) 끝 -->
			</div>
      </div>
      <div class="modal-footer">
        <button id="data_authEmpModal_close" type="button" class="btn" data-dismiss="modal">닫기</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script>
	//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
	app.controller('data_authEmpCtrl', ['$scope','$controller','$log','StudentService', 
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
			enableSelectAll : false, 					//전체선택 체크박스
			enableRowSelection : true, 					//로우 선택
			enableRowHeaderSelection : false, 			//맨앞 컬럼 체크박스 컬럼으로
			selectionRowHeaderWidth : 35, 				//체크박스 컬럼 길이
			rowHeight : 27, 							//체크박스 컬럼 높이
			useExternalPagination : true, 				//pagination을 직접 세팅
			enableAutoFitColumns: true,					//컬럼 width를 자동조정
			multiSelect : true, 						//여러로우선택
			enablePagination : false,
			enablePaginationControls: false,
			
			columnDefs : [ //컬럼 세팅
			{
				displayName : '권한코드',
				width : "95",
				field : 'data_auth_id',
				enableCellEdit : false,
				allowCellFocus : false,
				cellClass : "center"
			}, {
				displayName : '권한명',
				field : 'auth_name',
				enableCellEdit : false,
				allowCellFocus : false,
				cellClass : "center"
			}, {
				displayName : '메뉴코드',
				width : "95",
				field : 'menu_code',
				enableCellEdit : false,
				allowCellFocus : false,
				cellClass : "center"
			}, {
				displayName : '메뉴코드명',
				field : 'menu_name',
				enableCellEdit : false,
				allowCellFocus : false,
				cellClass : "center"
			}, {
				displayName : '사용자ID',
				width : "95",
				field : 'emp_code',
				enableCellEdit : false,
				allowCellFocus : false,
				cellClass : "center"
			}, {
				displayName : '사용자명',
				field : 'emp_name',
				enableCellEdit : false,
				allowCellFocus : false,
				cellClass : "center"
			}, ]
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
	var scope = angular.element(document.getElementById("data_authEmpCtrl-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
	scope.gridApi.selection.on.rowSelectionChanged(scope,function(row){			//로우 선택할때마다 이벤트
		
    });
	
	/* scope.gridApi.selection.on.rowSelectionChangedBatch(scope,function(rows){	//전체선택시 가져옴
		console.log(rows);           //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
    });	 */
	
	//pagenation option setting  그리드를 부르기 전에 반드시 선언
	var param = {
		listQuery : "Auth.data_authEmpList", 				//list가져오는 마이바티스 쿼리 아이디
		cntQuery : "Auth.data_authEmpListCnt"						//list cnt 가져오는 마이바티스 쿼리 아이디
	}; 
	scope.paginationOptions = customExtend(scope.paginationOptions,param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합	
	//복붙영역(앵귤러 이벤트들 가져오기) 끝
	
	$("#user_dept_modify_final_btn").on("click",function(){
		var $this = $(this);
		$.ajax({
			type: 'POST',
			url: '/icm/user_dept_modify',
			data: JSON.stringify(scope.gridApi.selection.getSelectedRows()),
//			dataType: 'json',
			contentType : "application/json; charset=utf-8",
			success: function(data){
				swalSuccess("수정 되었습니다.");
				$("#deptListModal").modal("toggle");
				$("#user_dept_modify_btn").attr("disabled",false);
			}
		});	 
	});
	
	$("#deptList_modal_close").on("click",function(){
		$("#user_dept_modify_btn").attr("disabled",false);
	});
});


</script>