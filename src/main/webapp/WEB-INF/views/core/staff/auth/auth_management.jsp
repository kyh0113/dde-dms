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
<title>권한관리</title>
<style>
.ui-grid-cell-contents{
	white-space : pre !important;
}

</style>
</head>
<body>
	<h2>
		권한관리
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
	<form id="authForm">
		<!-- 20191023_khj for csrf -->
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<section>
			<div class="tbl_box">
				<table>
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
								<input class="inputTxt"  type="text" name="auth_name" id="auth_name"> 
							</td>
							<th scope="col"></th>
							<td></td>
				        </tr>
					</tbody>
				</table>
				<div class="btn_wrap">
					<input type="button" class="btn btn_search" id="btn_search" value="조회"/>
				</div>
			</div>
		</section>
	</form>
	
	<div class="float_wrap" style="margin-bottom:5px;">
		<div class="fr">
			<div class="btn_wrap">
				<input type="button" class="btn_g" id="btn_add"  value="등록"/>
				<input type="button" class="btn_g" id="btn_del"  value="삭제"/>
			</div>
		</div>
	</div>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="authCtrl-uiGrid"  data-ng-controller="authCtrl" style="height: auto;">
			<div data-ui-i18n="ko" style="height: auto;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav data-ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
	</section>
	

<%@include file="./auth_modal.jsp"%>
<%@include file="./authUser_modal.jsp"%>
<%@include file="./authUser_mapping_modal.jsp"%>
<%@include file="./authMenu_mapping_modal.jsp"%>

<script>
	//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
	app.controller('authCtrl', ['$scope','$controller','$log','StudentService', 
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
		
		
		$scope.openAuthModal=function(row){
			document.getElementById("authModal_auth_code").value = row.auth_id;
			document.getElementById("authModal_auth_name").value = row.auth_title;
			document.getElementById("authModal_auth_url").value = row.init_page;
			$("#authModal_auth_code").prop("readonly", true);
			$("#authModal").modal({
				backdrop : false,
				keyboard: false
			});
			$("#authModal").draggable({
			      handle: ".modal-header",
			      cursor : "move"
			});
		}
		
		$scope.openUserList=function(row){
			document.getElementById("authEmpModal_title").innerText = row.auth_title;
			var scope = angular.element(document.getElementById("authEmpCtrl-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
			scope.reloadGrid({
				auth_id : row.auth_id
			});
			var $authEmpModal = $("#authEmpModal");
			$authEmpModal.modal({
				backdrop : false,
				keyboard: false
			});
		}
		
		$scope.openUserMapping=function(row){
			$("#authUserMappingModal #authMenuModal_title").html(row.auth_title);
			document.getElementById("selection_auth_id").value = row.auth_id;
			var scope = angular.element(document.getElementById("authUserCntl-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
			scope.reloadGrid({
				auth_id : row.auth_id
			});
			var $authUserMappingModal = $("#authUserMappingModal");
			$authUserMappingModal.modal({
				backdrop : false,
				keyboard: false
			});
		}
		
		$scope.openMenuMapping=function(row){
			$("#authMenuModal #authMenuModal_title").html(row.auth_title);
			var scope = angular.element(document.getElementById("authMenuCtrl-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
			scope.gridOptions.data = [];
			scope.gridApi.grid.refresh();
			scope.reloadGrid({
				auth_id : row.auth_id
			});
			var $authMenuModal = $("#authMenuModal");
			$authMenuModal.modal({
				backdrop : false,
				keyboard: false
			});
		}
		
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
				multiSelect : true, 						//여러로우선택
				enablePagination : false,
				enablePaginationControls: false,
				columnDefs : [  							//컬럼 세팅
		            { width:"100", displayName: '권한코드', field: 'auth_id',enableCellEdit : false, allowCellFocus : false, cellClass:"center"
		            	,cellTemplate : '<div class="ui-grid-cell-contents ng-binding ng-scope ui-grid-dbclick-column" ng-click="grid.appScope.openAuthModal(row.entity)">{{row.entity.auth_id}}</div>'},
		            { width:"300", displayName: '권한명', field: 'auth_title',enableCellEdit : false, allowCellFocus : false},
		            { displayName: '초기화면 URL', field: 'init_page',enableCellEdit : false, allowCellFocus : false},
		            { width:"150", displayName: '권한-사용자목록', field: 'auth_user_list',enableCellEdit : false, allowCellFocus : false, cellClass : "center"
		            	, cellTemplate : '<div class="ui-grid-cell-contents" style="font-size:15px; "><i class="fas fa-users ui-grid-dbclick-column" style="cursor: pointer;" ng-click="grid.appScope.openUserList(row.entity)"></i></div>'},
		            { width:"150", displayName: '권한-사용자매핑', field: 'auth_user_mapping',enableCellEdit : false, allowCellFocus : false, cellClass : "center"
				        , cellTemplate : '<div class="ui-grid-cell-contents" style="font-size:15px;"><i class="fas fa-user ui-grid-dbclick-column" style="cursor: pointer;" ng-click="grid.appScope.openUserMapping(row.entity)"></i></div>'},
		            { width:"150", displayName: '권한-메뉴매핑', field: 'auth_menu_mapping',enableCellEdit : false, allowCellFocus : false, cellClass : "center"
		            	, cellTemplate : '<div class="ui-grid-cell-contents" style="font-size:15px;"><i class="fas fa-edit ui-grid-dbclick-column" style="cursor: pointer;" ng-click="grid.appScope.openMenuMapping(row.entity)"></i></div>'}
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
	var scope = angular.element(document.getElementById("authCtrl-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
	scope.gridApi.selection.on.rowSelectionChanged(scope,function(row){			//로우 선택할때마다 이벤트
		
    });
	
	/* scope.gridApi.selection.on.rowSelectionChangedBatch(scope,function(rows){	//전체선택시 가져옴
		console.log(rows);           //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
    });	 */
	
	//pagenation option setting  그리드를 부르기 전에 반드시 선언
	var param = {
		listQuery : "Auth.authList", 				//list가져오는 마이바티스 쿼리 아이디
		cntQuery : "Auth.authListCnt"				//list cnt 가져오는 마이바티스 쿼리 아이디
	}; 
	scope.paginationOptions = customExtend(scope.paginationOptions,param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합	
	//복붙영역(앵귤러 이벤트들 가져오기) 끝
	
	scope.reloadGrid({
		auth_name : $("#auth_name").val()
	});
	
	$("#btn_search").on("click",function(){
		scope.reloadGrid({
			auth_name : $("#auth_name").val()
		});
	});
	
	$("#btn_add").on("click",function(){
		document.getElementById("authModalForm").reset();
		$("#authModal").modal({
			backdrop : false,
			keyboard: false
		});
		$("#authModal").draggable({
		      handle: ".modal-header",
		      cursor : "move"
		});
	});
	
	$("#btn_del").on("click",function(){
		var selectedRows = scope.gridApi.selection.getSelectedRows();
		if(isEmpty(selectedRows)){
			swalWarning("삭제할 권한을 선택해주십시오.");
			return false;
		}
		
		swal({
			  icon : "info",
			  text: "선택한 권한에 연결된 메뉴 및 사용자정보 모두 삭제됩니다.\n권한을 삭제하시겠습니까?",
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
			.then(function(result){
				  if(result){
					  	var token = $("meta[name='_csrf']").attr("content");
						var header = $("meta[name='_csrf_header']").attr("content");
						$.ajax({
							type: 'POST',
							url: '/core/staff/auth/deleteAuth',
							data: JSON.stringify(selectedRows),
							dataType: 'json',
							//async : false,
							contentType : "application/json; charset=utf-8",
							success: function(data){
								if(data.result > 0){
									swalSuccess("권한 삭제되었습니다.");
									$("#btn_search").trigger("click");
								}else{
									swalWarning("권한 삭제 실패했습니다.");
								}
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
							}
						});
				  }
			});
		
	});

});
</script>
</body>