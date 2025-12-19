<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Modal -->
<div class="modal fade" id="docManagerAllocModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="row modal-title" id="myModalLabel">문서담당자지정</h4>
      </div>
	  <div class="modal-body" style="height : 600px; overflow: auto;">
	  	<div class="popup_tblType02">
	  		<div class="popup_tblType02">
		  		<table class="tableType" border="0" cellpadding="0" cellspacing="0">
		                    <colgroup>
		                        <col width="40%" />       
		                        <col width="60%" />                          
		                    </colgroup>
		                    <tr>
		                      <th scope="col" style="padding: 5px 3px 7px 3px;">부서목록</th>
		                      <th scope="col" style="padding: 5px 3px 7px 3px;">사원목록</th> 
		                    </tr>
		                    <tr>
		                    	<td rowspan="3" style="text-align:left; vertical-align:top;">
						        	<div id="deptTree" style="overflow:auto; height:100%;"><!-- 부서트리가 들어감 --></div>
		                    	</td>
		                    	<td>
		                    		<div style="height: 180px;">
								  		<!-- 해당부서 직원리스트 -->
								  		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
										<div id="deptEmpCtrl-uiGrid"  data-ng-controller="deptEmpCtrl" style="height: 100%;">
											<div data-ui-i18n="ko" style="height: 100%;">
												<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav data-ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
													<div data-ng-if="loader" class="loader"></div>
													<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
												</div>
											</div>
										</div>
										<!-- 복붙영역(html) 끝 -->
									</div>
		                    		<div class="popup_bottom">                      	
							            <div class="right"> 
							                <button id="docManagerAlloc_modal_add_btn" class="btnTypeS2">지정</button>
							            </div>
							        </div>
		                    	</td>
		                    </tr>
		                    <tr>
		                    	<th scope="col" style="padding: 5px 3px 7px 3px;">담당자</th>
		                    </tr>
		                    <tr>
		                    	<td>
						        	<div style="height: 180px;">
							        	<!-- 담당자 -->
							        	<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
										<div id="testerCtrl-uiGrid"  data-ng-controller="testerCtrl" style="height: 100%;">
											<div data-ui-i18n="ko" style="height: 100%;">
												<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav data-ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
													<div data-ng-if="loader" class="loader"></div>
													<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
												</div>
											</div>
										</div>
										<!-- 복붙영역(html) 끝 -->
									</div>
							        <div class="popup_bottom">
							             <div class="right"> 
							                 <button id="docManagerAlloc_modal_delete_btn"class="btnTypeS2">삭제</button>
							             </div>
							         </div>
		                    	</td>
		                    </tr>
		         </table>
		     </div>
	  	</div>
	  </div>
	  <div class="modal-footer">
	  	<button id="docManagerAlloc_modal_save_btn" class="btn btn-primary">확인</button>
      	<button id="docManagerAlloc_modal_close" type="button" class="btn btn-secondary just-close" data-dismiss="modal">닫기</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script>
	//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
	app.controller('deptEmpCtrl', ['$scope','$controller','$log','StudentService', 
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
				showHeader : true,
				enableFiltering : false, 					//칵 컬럼에 검색바
				paginationPageSizes : [500, 1500, 5000, 10000], 		//한번에 보여질 로우수 셀렉트리스트
				enableCellEditOnFocus : false, 				//셀 클릭시 edit모드 
				enableSelectAll : false, 					//전체선택 체크박스
				enableRowSelection : true, 					//로우 선택
				enableRowHeaderSelection : true, 			//맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 35, 				//체크박스 컬럼 길이
				rowHeight : 27, 							//체크박스 컬럼 높이
				useExternalPagination : false, 				//pagination을 직접 세팅
				enableAutoFitColumns: true,					//컬럼 width를 자동조정
				multiSelect : false, 						//여러로우선택
				enablePagination : false,					//pagenation 숨기기
				enablePaginationControls: false,			//pagenation 숨기기
				columnDefs : [  							//컬럼 세팅
					
					{ displayName: '사원이름', field: 'emp_name',enableCellEdit : false, allowCellFocus : false},
					{ displayName: '부서', field: 'dept_name',enableCellEdit : false, allowCellFocus : false},
					{ displayName: '직책', field: 'position_name',enableCellEdit : false, allowCellFocus : false},
					
					{ visible:false, displayName: '사원번호', field: 'emp_code',enableCellEdit : false, allowCellFocus : false},
					{ visible:false, displayName: '부서코드', field: 'dept_code',enableCellEdit : false, allowCellFocus : false},
					{ visible:false, displayName: '직책코드', field: 'position_code',enableCellEdit : false, allowCellFocus : false},
					{ visible:false, displayName: 'sort_year', field: 'sort_year',enableCellEdit : false, allowCellFocus : false},
					{ visible:false, displayName: '통제기간', field: 'term_code',enableCellEdit : false, allowCellFocus : false},
					{ visible:false, displayName: '통제항목번호', field: 'ca_no',enableCellEdit : false, allowCellFocus : false}
					
				]
			}
		);  
		
		$scope.gridLoad = vm.gridLoad; 						//부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
		$scope.reloadGrid = vm.reloadGrid;
															//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  
	
	}]);
	//복붙영역(앵귤러단) 끝
</script>
<script>
	//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
	app.controller('testerCtrl', ['$scope','$controller','$log','StudentService', 
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
		$scope.deleteRow = vm.deleteRow;
		$scope.pagination = vm.pagination;
		$scope.gridOptions = vm.gridOptions(  				// 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				showHeader : true,
				enableFiltering : false, 					//칵 컬럼에 검색바
				paginationPageSizes : [500, 1500, 5000, 10000], 		//한번에 보여질 로우수 셀렉트리스트
				enableCellEditOnFocus : false, 				//셀 클릭시 edit모드 
				enableSelectAll : false, 					//전체선택 체크박스
				enableRowSelection : true, 					//로우 선택
				enableRowHeaderSelection : true, 			//맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 35, 				//체크박스 컬럼 길이
				rowHeight : 27, 							//체크박스 컬럼 높이
				useExternalPagination : false, 				//pagination을 직접 세팅
				enableAutoFitColumns: true,					//컬럼 width를 자동조정
				multiSelect : false, 						//여러로우선택
				enablePagination : false,					//pagenation 숨기기
				enablePaginationControls: false,			//pagenation 숨기기
				columnDefs : [  							//컬럼 세팅
					
					{ displayName: '사원이름', field: 'emp_name',enableCellEdit : false, allowCellFocus : false},
					{ displayName: '부서', field: 'dept_name',enableCellEdit : false, allowCellFocus : false},
					{ displayName: '직책', field: 'position_name',enableCellEdit : false, allowCellFocus : false},
					
					{ visible:false, displayName: '사원번호', field: 'emp_code',enableCellEdit : false, allowCellFocus : false},
					{ visible:false, displayName: '부서코드', field: 'dept_code',enableCellEdit : false, allowCellFocus : false},
					{ visible:false, displayName: '직책코드', field: 'position_code',enableCellEdit : false, allowCellFocus : false},
					{ visible:false, displayName: 'sort_year', field: 'sort_year',enableCellEdit : false, allowCellFocus : false},
					{ visible:false, displayName: '통제기간', field: 'term_code',enableCellEdit : false, allowCellFocus : false},
					{ visible:false, displayName: '통제항목번호', field: 'ca_no',enableCellEdit : false, allowCellFocus : false}
					
				]
			}
		);  
		
		$scope.gridLoad = vm.gridLoad; 						//부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
		$scope.reloadGrid = vm.reloadGrid;
															//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  
	
	}]);
	//복붙영역(앵귤러단) 끝
</script>
<script>
$(document).ready(function(){
	
	//복붙영역(앵귤러 이벤트들 가져오기) 시작, 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
	//ui-grid 초기 조회조건 세팅
	
	var deptEmp_scope = angular.element(document.getElementById("deptEmpCtrl-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴	
	var tester_scope = angular.element(document.getElementById("testerCtrl-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
	/* scope.gridApi.selection.on.rowSelectionChangedBatch(scope,function(rows){	//전체선택시 가져옴
		console.log(rows);           //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
    });	 */
	
	//pagenation option setting  그리드를 부르기 전에 반드시 선언
	var param = {
		listQuery : "icm_elcOETesterAlloc.grid_elcOETesterCandidate", 				//list가져오는 마이바티스 쿼리 아이디
		cntQuery : "icm_elcOETesterAlloc.grid_cnt_elcOETesterCandidate"					//list cnt 가져오는 마이바티스 쿼리 아이디
		//termcode : termcode                                // 그밖에 필요한 파라미터 네임과 벨류를 넣어준다
    }; 
    var param1 = {
   		listQuery : "icm_elcDept.grid_allDept", 				//list가져오는 마이바티스 쿼리 아이디
   		cntQuery : "icm_elcDept.grid_cnt_allDept"					//list cnt 가져오는 마이바티스 쿼리 아이디
   		//termcode : termcode                                // 그밖에 필요한 파라미터 네임과 벨류를 넣어준다
    }; 
    deptEmp_scope.paginationOptions = customExtend(deptEmp_scope.paginationOptions,param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
    tester_scope.paginationOptions = customExtend(tester_scope.paginationOptions,param1); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
//	scope.gridLoad(scope.paginationOptions);               //처음페이지 로드될때 테이블 로드
	//복붙영역(앵귤러 이벤트들 가져오기) 끝
});
</script>
<script>
$(document).ready(function(){
	var deptEmp_scope = angular.element(document.getElementById("deptEmpCtrl-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴	
	var tester_scope = angular.element(document.getElementById("testerCtrl-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴

	treeListCall({termcode : $("#termcode option:selected").data("term-code"), _csrf : "${_csrf.token}"}, '/icm/deptList', '#deptTree');
	
	$('#deptTree').on('changed.jstree', function (e, data) { //jstree 클릭 이벤트
	    if(data.action == "select_node"){
	    	var selectedNode = data.node.original;
	    	deptEmp_scope.reloadGrid({
	    		modal_term_code : selectedNode.term_code,
	    		modal_dept_code : selectedNode.id
	    	});
	    };
	  }).jstree();
	  // create the instance
	  
	$("#deptTree").on('loaded.jstree', function() {//jstree가 로드될때 특정노드 오픈 and 선택
		 
	});
	
	$("#docManagerAlloc_modal_add_btn").on("click",function(){
		var selectedEmp = deptEmp_scope.gridApi.selection.getSelectedRows()[0];
		if(isEmpty(selectedEmp)){
			swalWarning("사원목록에서 문서담당자를 선택해주십시오.");
			return false;
		}
		if(tester_scope.gridOptions.data.length > 0){
			swalWarning("문서담당자는 한명만 지정 가능합니다.");
			return false;
		}
		tester_scope.addRow(selectedEmp);
	});
	
	$("#docManagerAlloc_modal_delete_btn").on("click",function(){
		var selectedEmp = tester_scope.gridApi.selection.getSelectedRows();
		if(isEmpty(selectedEmp)){
			swalWarning("삭제할 평가담당자를 선택해주십시오.");
			return false;
		}
		tester_scope.deleteRow(selectedEmp);
	});
	
	$("#docManagerAlloc_modal_save_btn").on("click",function(){
		var manager = tester_scope.gridOptions.data[0];
		if(isEmpty(manager)){
			swalWarning("문서담당자를 지정해주세요.");
			return false;	
		}
		document.getElementById("dept_code").value = manager.dept_code;
		document.getElementById("dept_name").value = manager.dept_name;
		document.getElementById("user_id").value = manager.emp_code;
		document.getElementById("user_name").value = manager.emp_name;
		$("#docManagerAllocModal").modal("hide");
	});
	
	$('#docManagerAllocModal').on('show.bs.modal', function (e) {
		deptEmp_scope.reloadGrid({});
		tester_scope.reloadGrid({});
	});
	
});


</script>