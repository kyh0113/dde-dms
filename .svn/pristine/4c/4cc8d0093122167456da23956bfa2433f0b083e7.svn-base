<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!-- Modal -->
<div class="modal fade" id="data_authUserMappingModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">&lt;<span id="data_authMenuModal_title"></span> - <span id="data_authMenuModal_menu_title"></span>&gt; 데이터 권한 사용자 매핑</h4>
      </div>
      <div class="modal-body" style="height:600px;">
     		<form class="form-horizontal" id="authUserForm">
      			<!-- 20191023_khj for csrf -->
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="data_selection_auth_id" id="data_selection_auth_id" value="" />
				<input type="hidden" name="data_selection_menu_code" id="data_selection_menu_code" value="" />
				<!-- popup contents -->
				<section>
					<div class="tbl_box" style="width:100%;">
						<table>
							<colgroup>
								<col width="12%" />
								<col />
								<col width="12%" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th scope="col">사용자명</th>
									<td>
										<input type="text" class="inputTxt" name="user_name" id="user_name" style="width:50%;">
									</td>
									<th></th><td></td>
								</tr>
							</tbody>
						</table>
						<div class="btn_wrap">
							<input type="button" class="btn btn_search" id="btn_user_search" value="조회"/>
						</div>
					</div>
				</section>
			</form>	
				
			<div class="float_wrap">
				<div class="fl"><div class="stitle">사용자 목록</div></div>
			</div>
			
			<section class="section">
				<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
				<div id="data_authUserCntl-uiGrid"  data-ng-controller="data_modal_authUserCntl" style="height: 400px;">
					<div data-ui-i18n="ko" style="height: 100%;">
						<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav data-ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
							<div data-ng-if="loader" class="loader"></div>
							<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
						</div>
					</div>
				</div>
				<!-- 복붙영역(html) 끝 -->
			</section>
	  	
      </div>
      <div class="modal-footer">
      	<button id="btn_data_authUserMappingModal_save" type="button" class="btn">저장</button>
        <button id="btn_data_authUserMappingModal_close" type="button" class="btn" data-dismiss="modal">닫기</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script>
	//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
	app.controller('data_modal_authUserCntl', ['$scope','$controller','$log','StudentService', 
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
			enableFiltering : false, 					//칵 컬럼에 검색바
			paginationPageSizes : [500, 1500, 5000, 10000], 		//한번에 보여질 로우수 셀렉트리스트
			enableCellEditOnFocus : false, 				//셀 클릭시 edit모드 
			enableSelectAll : true, 					//전체선택 체크박스
			enableRowSelection : false, 					//로우 선택
			enableRowHeaderSelection : true, 			//맨앞 컬럼 체크박스 컬럼으로
			selectionRowHeaderWidth : 35, 				//체크박스 컬럼 길이
			rowHeight : 27, 							//체크박스 컬럼 높이
			useExternalPagination : false, 				//pagination을 직접 세팅
			enableAutoFitColumns: true,					//컬럼 width를 자동조정
			multiSelect : true, 						//여러로우선택
			enablePagination : false,					//pagenation 숨기기
			enablePaginationControls: false,			//pagenation 숨기기
			
			columnDefs : [ //컬럼 세팅
			{
				visible : false,
				displayName : '변경권한코드',
				field : 'auth_id',
				enableCellEdit : false,
				allowCellFocus : false,
				cellClass : "center"
			}, {
				visible : false,
				displayName : '변경메뉴코드',
				field : 'auth_id',
				enableCellEdit : false,
				allowCellFocus : false,
				cellClass : "center"
			}, {
				visible : false,
				displayName : '접속자ID',
				field : 's_emp_code',
				enableCellEdit : false,
				allowCellFocus : false,
				cellClass : "center"
			}, {
				width : "95",
				displayName : '사용자ID',
				field : 'user_id',
				enableCellEdit : false,
				allowCellFocus : false,
				cellClass : "center"
			}, {
				displayName : '사용자명',
				field : 'user_name',
				enableCellEdit : false,
				allowCellFocus : false,
				cellClass : "center"
			}, {
				width : "125",
				displayName : '현재권한코드',
				field : 'now_auth_id',
				enableCellEdit : false,
				allowCellFocus : false,
				cellClass : "center"
			}, {
				displayName : '현재권한',
				field : 'now_auth_name',
				enableCellEdit : false,
				allowCellFocus : false,
				cellClass : "center"
			}, {
				width : "125",
				displayName : '현재메뉴코드',
				field : 'now_menu_code',
				enableCellEdit : false,
				allowCellFocus : false,
				cellClass : "center"
			}, {
				displayName : '현재메뉴명',
				field : 'now_menu_name',
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
	var userScope = angular.element(document.getElementById("data_authUserCntl-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
	//복붙영역(앵귤러 이벤트들 가져오기) 시작, 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
	//ui-grid 초기 조회조건 세팅
	userScope.gridApi.selection.on.rowSelectionChanged(userScope,function(row){			//로우 선택할때마다 이벤트
		
    });
	
	/* scope.gridApi.selection.on.rowSelectionChangedBatch(scope,function(rows){	//전체선택시 가져옴
		console.log(rows);           //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
    });	 */
	
	//pagenation option setting  그리드를 부르기 전에 반드시 선언
	var param = {
		listQuery : "Auth.data_selectUserList", 				//list가져오는 마이바티스 쿼리 아이디
		cntQuery : "Auth.data_selectUserListCnt"					//list cnt 가져오는 마이바티스 쿼리 아이디
		                                // 그밖에 필요한 파라미터 네임과 벨류를 넣어준다
    }; 
    userScope.paginationOptions = customExtend(userScope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
	//scope.gridLoad(scope.paginationOptions);               //처음페이지 로드될때 테이블 로드
	//복붙영역(앵귤러 이벤트들 가져오기) 끝
	

	
	$("#btn_user_search").on("click",function(){
		userScope.reloadGrid({
			user_name : document.getElementById("user_name").value,
			auth_id : document.getElementById("data_selection_auth_id").value,
			menu_code : document.getElementById("data_selection_menu_code").value
		});
	})
	
	
	$("#btn_data_authUserMappingModal_save").on("click",function(){
		var selectedRows = userScope.gridApi.selection.getSelectedRows();
		if(isEmpty(selectedRows)){
			swalWarning("데이터 권한을 매핑할 사용자를 선택해주십시오.");
			return false;
		}

		swal({
			  icon : "info",
			  text: "<"+$("#data_authMenuModal_title").text()+"> 데이터 권한으로 매핑하시겠습니까?",
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
			.then(function(result) {
				if (result) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						type : 'POST',
						url : '/core/staff/auth/mappingUserDataAuth',
						data : JSON.stringify(selectedRows),
						dataType : 'json',
						//async : false,
						contentType : "application/json; charset=utf-8",
						success : function(data) {
							console.log(data);
							if (data.result > 0) {
								swalSuccess("저장 되었습니다.");
								$("#data_authUserMappingModal").modal("toggle");
							} else {
								swalWarning("저장 실패했습니다.");
							}
						},
						beforeSend : function(xhr) {
							//20191023_khj for csrf
							xhr.setRequestHeader(header, token);
						}
					});
				}
			});
		});

		$("#btn_data_authUserMappingModal_close").on("hide.bs.modal", function() {

		});

	});
</script>