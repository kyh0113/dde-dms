<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<!-- Modal -->
<div class="modal fade" id="authMenuModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">&lt;<span id="authMenuModal_title"></span>&gt; 권한 사용메뉴 목록</h4>
      </div>
      <div class="modal-body">
        <!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="authMenuCtrl-uiGrid"  data-ng-controller="authMenuCtrl" style="height: 550px;">
			<div data-ui-i18n="ko" style="height: 100%;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav data-ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
      </div>
      <div class="modal-footer">
      	<button id="authUserMenu_save" type="button" class="btn">저장</button>
        <button id="authMenumodal_close" type="button" class="btn" data-dismiss="modal">닫기</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script>
	//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
	app.controller('authMenuCtrl', ['$scope','$controller','$log','StudentService', 'uiGridConstants', 'uiGridTreeViewConstants',
	function ($scope,$controller,$log,StudentService,uiGridConstants,uiGridTreeViewConstants) {		//$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
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
		$scope.checkboxClick = function(fieldName, row){
			var index = row.grid.renderContainers.body.visibleRowCache.indexOf(row);
			var gridData = $scope.gridOptions.data;
			
			var child_ids = row.entity.CHECK_CHILD_ID;
			var child_id_array = child_ids.split('|');
			child_id_array.pop(child_id_array.length-1);
			
			for(var i = index + 1; i < gridData.length; i++){
				var b = gridData[i].HIERARCHY2 == null?"":gridData[i].HIERARCHY2;
				if(b.indexOf(fillZero( row.entity.MENU_ID, 6)) == -1){
					break;
				}
				if(row.entity[fieldName] == "N"){
					gridData[i][fieldName] = "Y";
// 					if(row.isSelected){
// 						$scope.gridApi.selection.unSelectRow(gridData[i]);	
// 					}else{
// 						$scope.gridApi.selection.selectRow(gridData[i]);
// 					}
				}else if(row.entity[fieldName] == "Y"){
					gridData[i][fieldName] = "N";
// 					if(row.isSelected){
// 						$scope.gridApi.selection.unSelectRow(gridData[i]);	
// 					}else{
// 						$scope.gridApi.selection.selectRow(gridData[i]);
// 					}
				}
				
			}
			
			//2020-08-24 smh
			//서브메뉴를 가진 메뉴일 경우,
			//서브메뉴도 같이 체크/체크해제 동작되게 하기
			
			//클릭한 체크박스의 값
			var YN = row.entity[fieldName];
			
			//가지고 있는 서브메뉴 만큼 반복
			for(var i=0; i<child_id_array.length; i++){
				//grid데이터만큼 반복
				for(var j=0; j<gridData.length; j++){
					//서브메뉴일 경우
					if(gridData[j].MENU_ID == child_id_array[i]){
						if(YN == "Y"){
							$scope.gridOptions.data[j][fieldName] = "N";
						}else if(YN == "N"){
							$scope.gridOptions.data[j][fieldName] = "Y";
						}
					}
					
				}
			}
			
			//if(row.entity[fieldName] == "N"){
			//	$scope.gridOptions.data[index][fieldName] = "Y";
// 				if(row.isSelected){
// 					$scope.gridApi.selection.unSelectRow($scope.gridOptions.data[index]);	
// 				}else{
// 					$scope.gridApi.selection.selectRow($scope.gridOptions.data[index]);
// 				}
			//}else if(row.entity[fieldName] == "Y"){
			//	$scope.gridOptions.data[index][fieldName] = "N";
// 				if(row.isSelected){
// 					$scope.gridApi.selection.unSelectRow($scope.gridOptions.data[index]);	
// 				}else{
// 					$scope.gridApi.selection.selectRow($scope.gridOptions.data[index]);
// 			//	}
			//}

			
			$scope.gridApi.core.notifyDataChange( uiGridConstants.dataChange.ALL);
		}
		
		$scope.cellClassSet = function(grid, row, col, rowRenderIndex, colRenderIndex){
			var className = "";
			switch(col.field){
				case "ENBL_YN" : className = "center relatvie_box";
					break;
				case "MENU_ID" : className = "right";
					break;
				case "TITLE_VIEW" : className = "left";
					break;
				case "BUTTON_AUTH_SEARCH" : className = "relatvie_box";
					break;
				case "BUTTON_AUTH_EXEC" : className = "relatvie_box";
					break;
				case "BUTTON_AUTH_DELETE" : className = "relatvie_box";
					break;
				case "BUTTON_AUTH_EXCEL" : className = "relatvie_box";
					break;
			}
			
			if(row.entity.ENBL_YN == 'Y' && col.field == 'ENBL_YN'){
				className = className + " green";
			}
			if(row.entity.ENBL_YN == 'N' && col.field == 'ENBL_YN'){
				className = className + " red";
			}
			
			//MENU_ID관련 Class
			if(row.entity.LEVL == '1'){
				className = className + " b-sky-blue2";
			}else if(row.entity.LEVL == '2'){
				className = className + " b-sky-blue";
			}else if(row.entity.LEVL == '3'){
				className = className + " b-sky-blue3";
			}
			
			return className;
		}
		
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
				columnDefs : [  							//컬럼 세팅
					{ visible:false, displayName: '권한코드', field: 'AUTH_ID',enableCellEdit : false, allowCellFocus : false, cellClass: "center"},
					{ displayName: '메뉴ID', field: 'MENU_ID',enableCellEdit : false, allowCellFocus : false, cellClass: $scope.cellClassSet
						, cellTemplate : '<div class="ui-grid-cell-contents" style="font-size:15px;" ng-if="row.entity.MENU_ID ==\'-1\'">-</div>'+
										 '<div class="ui-grid-cell-contents" style="font-size:15px;" ng-if="row.entity.MENU_ID !=\'-1\'">{{row.entity.MENU_ID}}</div>'},
		            { width: "300", displayName: '메뉴명', field: 'TITLE_VIEW',enableCellEdit : false, allowCellFocus : false, cellClass: $scope.cellClassSet
		            	, cellTemplate : '<div class="ui-grid-cell-contents" style="font-size:15px;"><i ng-if="row.entity.$$treeLevel ==\'0\'" class="fas fa-arrow-circle-down"></i><i ng-if="row.entity.$$treeLevel ==\'1\'" class="fas fa-arrow-circle-right"></i>{{row.entity.TITLE_VIEW}}</div>'},
		            { visible:false, displayName: 'URL', field: 'URL',enableCellEdit : false, allowCellFocus : false},
		            { visible:false, displayName: 'LEVL', field: 'LEVL',enableCellEdit : false, allowCellFocus : false},
		            { visible:false, displayName: '상위메뉴ID', field: 'PARENT_ID',enableCellEdit : false, allowCellFocus : false},
		            { visible:false, displayName: 'HIERARCHY2', field: 'HIERARCHY2',enableCellEdit : false, allowCellFocus : false},
		            { visible:false, displayName: '메뉴잠금', field: 'USE_YN',enableCellEdit : false, allowCellFocus : false},
		            { displayName: '사용여부', field: 'ENBL_YN',enableCellEdit : false, allowCellFocus : false, cellClass : $scope.cellClassSet
		            	, cellTemplate : '<div class="ui-grid-cell-contents" style="font-size:15px;"><i ng-if="row.entity.ENBL_YN ==\'Y\'" class="fas fa-check"></i><i ng-if="row.entity.ENBL_YN ==\'N\'" class="fas fa-times"></i></div>'},
		            { displayName: '사용여부', field: 'ENBL_YN',enableCellEdit : false, allowCellFocus : false, cellClass: $scope.cellClassSet
						,cellTemplate : '<input class="absolute_center" type="checkbox" style="margin:0 0 0 0; width:15%; height:auto;" ng-checked="row.entity.ENBL_YN ==\'Y\'" ng-click="grid.appScope.checkboxClick(\'ENBL_YN\', row)">'},
					{ displayName: '조회권한', field: 'BUTTON_AUTH_SEARCH',enableCellEdit : false, allowCellFocus : false, cellClass: $scope.cellClassSet
						,cellTemplate : '<input class="absolute_center" type="checkbox" style="margin:0 0 0 0; width:15%; height:auto;" ng-checked="row.entity.BUTTON_AUTH_SEARCH ==\'Y\'" ng-click="grid.appScope.checkboxClick(\'BUTTON_AUTH_SEARCH\', row)">'},
					{ displayName: '실행권한', field: 'BUTTON_AUTH_EXEC',enableCellEdit : false, allowCellFocus : false, cellClass : $scope.cellClassSet
						,cellTemplate : '<input class="absolute_center" type="checkbox" style="margin:0 0 0 0; width:15%; height:auto;" ng-checked="row.entity.BUTTON_AUTH_EXEC ==\'Y\'" ng-click="grid.appScope.checkboxClick(\'BUTTON_AUTH_EXEC\', row)">'},
					{ displayName: '삭제권한', field: 'BUTTON_AUTH_DELETE',enableCellEdit : false, allowCellFocus : false, cellClass: $scope.cellClassSet
						,cellTemplate : '<input class="absolute_center" type="checkbox" style="margin:0 0 0 0; width:15%; height:auto;" ng-checked="row.entity.BUTTON_AUTH_DELETE ==\'Y\'" ng-click="grid.appScope.checkboxClick(\'BUTTON_AUTH_DELETE\', row)">'},
					{ displayName: '엑셀권한', field: 'BUTTON_AUTH_EXCEL',enableCellEdit : false, allowCellFocus : false, cellClass: $scope.cellClassSet
						,cellTemplate : '<input class="absolute_center" type="checkbox" style="margin:0 0 0 0; width:15%; height:auto;" ng-checked="row.entity.BUTTON_AUTH_EXCEL ==\'Y\'" ng-click="grid.appScope.checkboxClick(\'BUTTON_AUTH_EXCEL\', row)">'},
		            
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
	var scope = angular.element(document.getElementById("authMenuCtrl-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
	scope.gridApi.selection.on.rowSelectionChanged(scope,function(row){			//로우 선택할때마다 이벤트
		
    });
	
	/* scope.gridApi.selection.on.rowSelectionChangedBatch(scope,function(rows){	//전체선택시 가져옴
		console.log(rows);           //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
    });	 */
	
	//pagenation option setting  그리드를 부르기 전에 반드시 선언
	var param = {
		listQuery : "Auth.authMenuList", 				//list가져오는 마이바티스 쿼리 아이디
		cntQuery : "Auth.authMenuListCnt"						//list cnt 가져오는 마이바티스 쿼리 아이디
	}; 
	scope.paginationOptions = customExtend(scope.paginationOptions,param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합	
	//복붙영역(앵귤러 이벤트들 가져오기) 끝
	
	$("#authUserMenu_save").on("click",function(){
		var array = new Array;
		var rows = scope.gridApi.grid.rows;
		var count = 0;
		
		for(var i=0; i < rows.length; i++){
			var obj = {};
			obj.auth_id    = rows[i].entity.AUTH_ID;
			obj.menu_id    = rows[i].entity.MENU_ID;
			obj.use_yn     = rows[i].entity.ENBL_YN;
			obj.btn_search = rows[i].entity.BUTTON_AUTH_SEARCH;
			obj.btn_exec   = rows[i].entity.BUTTON_AUTH_EXEC;
			obj.btn_delete = rows[i].entity.BUTTON_AUTH_DELETE;
			obj.btn_excel  = rows[i].entity.BUTTON_AUTH_EXCEL;
			array.push(obj);
		}
		
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			type: 'POST',
			url: '/core/staff/auth/authUserMenu_save',
			data: JSON.stringify(array),
//			dataType: 'json',
			contentType : "application/json; charset=utf-8",
			success: function(data){
				var data = JSON.parse(data);
				if(data.result > 0){
					swalSuccess("저장 되었습니다.");
					$("#authMenuModal").modal("toggle");
				}else{
					swalWarning("저장 실패했습니다.");
				}
			},
			beforeSend : function(xhr) {
				//20191023_khj for csrf
				xhr.setRequestHeader(header, token);
			}
		});

	});
	
	
});


</script>