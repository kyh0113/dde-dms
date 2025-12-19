<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
<title>리조트등록관리</title>
</head>
<body>
	<h2>
		리조트 등록 관리
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
	<section class="section">
		<form id="ipeManagementForm">
			<!-- 20191023_khj for csrf -->
			<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="sel_resort_code" id="sel_resort_code" value="" />
			<input type="hidden" name="sel_resort_name" id="sel_resort_name" value="" />
	
		</form>
	</section>

	<!-- <section class="section"> -->

	<div style="float:left;">
		<div class="stitle" style="width:700px;">리조트명</div>
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="masterCodeCtrl-uiGrid"  data-ng-controller="masterCodeCtrl" style="width: 700px; height: 400px;">
		
			<form id="master_frm" name="master_frm" method="post">
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="TYPE">
				<input type="hidden" name="SEQ">
				<input type="hidden" name="RESORT_CD">
			</form>
			
			<div data-ui-i18n="ko" style="height: 100%;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav data-ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
		<!-- 버튼 -->
		<div>&nbsp;</div>
		<div class="float_wrap">
			<div class="fl"></div>
			<div class="fr">
				<div class="btn_wrap">
					<input type="button" class="btn_g" id="btn_add_resort"  value="등록"/>
					<input type="button" class="btn_g" id="btn_del_resort"  value="삭제"/>
				</div>
			</div>
		</div>
	</div>
	<!-- </section>-->
	<div style="float:left;"><div style="width: 100px;">&nbsp;</div></div>

	<!-- <section class="section">  -->
	<div style="float:left;">
	<div class="stitle" style="width:700px;">선호지역</div>
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  jj-->
		<div id="detailCodeCtrl-uiGrid"  data-ng-controller="detailCodeCtrl" style="width: 700px; height: 400px;">
			<div data-ui-i18n="ko" style="height: 100%;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav data-ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 버튼 -->
		<div>&nbsp;</div>
		<div class="float_wrap">
			<div class="fl"></div>
			<div class="fr">
				<div class="btn_wrap">
					<input type="button" class="btn_g" id="btn_add_region"  value="등록"/>
					<input type="button" class="btn_g" id="btn_del_region"  value="삭제"/>
				</div>
			</div>
		</div>
	</div>
	<!-- </section>-->
	
	<div class="float_wrap">
		<div class="fl"><div class="stitle">첨부파일 등록</div></div>
		<div class="fr">
			<div class="btn_wrap">
			
			</div>
		</div>
	</div>
	
	<section>
		<div class="tbl_box">
			<table cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="5%" />
					<col width="35%" />
					<col width="5%" />
					<col width="35%" />
					<col width="%" />
				</colgroup>

				<tr>
					<th>첨부 파일</th>
					<td>
						<button class="btn btn_make" id="file_reg">첨부 파일</button>
						<input type="hidden" name="file_url" id="file_url" value="">
						<input type="text" name="file_name" id="file_name" value="" readonly="readonly">
					</td>
					<th></th><td></td>
				</tr>
			</table>
		</div>
	</section>

	<!-- 주석처리 CJJ -->
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<!--
		<div id="detailCodeCtrl-uiGrid1"  data-ng-controller="detailCodeCtrl1" style="height: 400px;">
			<div data-ui-i18n="ko" style="height: 100%;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav data-ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div> -->
		<!-- 복붙영역(html) 끝 -->
	</section>
	
	<!-- 주석처리  -->
<!-- 수정필요 jj -->
<%@include file="resortCode_modal.jsp"%>
<%@include file="regionCode_modal.jsp"%>

<script>
	//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
	app.directive('convertToNumber', function() {
	  return {
	    require: 'ngModel',
	    link: function(scope, element, attrs, ngModel) {
	      ngModel.$parsers.push(function(val) {
	        return (typeof val == "number")?parseInt(val, 10) : val;
	      });
	      ngModel.$formatters.push(function(val) {
	        return '' + val;
	      });
	    }
	  };
	});
	
	app.controller('masterCodeCtrl', ['$scope','$controller','$log','StudentService', '$http', 
	function ($scope,$controller,$log,StudentService,$http) {		//$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
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
		$scope.deleteRowOne = vm.deleteRowOne;
		$scope.addedTF = false;
		
		$scope.pagination = vm.pagination;
		
		$scope.ipe_typeList = null;
		$scope.ipe_sourceList = null;
		$scope.ipe_periodList = null;
		$scope.ipe_hold_periodList = null;
		$scope.ipe_lvlList = null;
		
	 	angular.element(document).ready(function () {
// 			 $http({
// 		          method: 'POST',
// 		            url: '/ipeSelectList',
// 		            data: $.param({dummy:"", _csrf : "${_csrf.token}"}), 
// 		            headers: {
// 		                'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
// 		            	//'Content-Type': 'application/json; charset=UTF-8'
// 		            }
// 		        }).success(function(data){
// 		        	$scope.ipe_typeList = data.ipe_type;
// 		    		$scope.ipe_sourceList = data.ipe_source;
// 		    		$scope.ipe_periodList = data.ipe_period;
// 		    		$scope.ipe_hold_periodList = data.ipe_hold_period;
// 		    		$scope.ipe_lvlList = data.ipe_lvl;
// 		    		for(var i=0; i<$(".ui-grid-custom-select").length; i++){
// 		    			$(".ui-grid-custom-select")[i][0].remove();
// 		    		}
		    		
		    		
// 		     });	 
	 	});
		// 리조트명 수정
	 	$scope.openMasterCode=function(row){
	 		//document.master_frm.RESORT_CD.value = row.RESORT_CD;;
			document.getElementById("m_saveType").value = "MOD";
	 		document.getElementById("m_resort_code").value = row.RESORT_CD;
			document.getElementById("m_resort_name").value = row.RESORT_NAME;
			
			//document.getElementById("sel_resort_code").value = row.RESORT_CD;
			//console.log("row.resort_cd --> " + row.RESORT_CD);
			//console.log("sel_resort_cd --> " + document.getElementById("sel_resort_code").value);
			//document.getElementById("m_master_sort").value = row.master_sort;
			//document.getElementById("m_master_note").value = row.master_note;
			$("input:radio[name='m_resort_status']:radio[value='"+row.STATUS+"']").prop('checked', true); // 선택하기
			
			$("#m_master_code").prop("readonly", true);
			$("#masterCodeModal").modal({
				backdrop : false,
				keyboard: false
			});
		}

		
		$scope.gridOptions = vm.gridOptions(  				// 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableFiltering : false, 					//칵 컬럼에 검색바
				paginationPageSizes : [500, 1500, 5000, 10000], 		//한번에 보여질 로우수 셀렉트리스트
				enableCellEditOnFocus : true, 				//셀 클릭시 edit모드 
				enableSelectAll : false, 					//전체선택 체크박스
				enableRowSelection : false, 					//로우 선택
				enableRowHeaderSelection : true, 			//맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 35, 				//체크박스 컬럼 길이
				rowHeight : 27, 							//체크박스 컬럼 높이
				useExternalPagination : false, 				//pagination을 직접 세팅
				enableAutoFitColumns: true,					//컬럼 width를 자동조정
				multiSelect : false, 						//여러로우선택
				enablePagination : false,					//pagenation 숨기기
				enablePaginationControls: false,			//pagenation 숨기기
				columnDefs : [  							//컬럼 세팅
					{ displayName: '리조트코드', field: 'RESORT_CD',enableCellEdit : false, allowCellFocus : false, cellClass:"center"},
					{ displayName: '리조트코드명', field: 'RESORT_NAME',enableCellEdit : false, allowCellFocus : false, cellClass:"center"},
					{ width:"100", displayName: '사용', field: 'STATUS',enableCellEdit : false, allowCellFocus : false, cellClass:"center"
						, cellTemplate : '<div class="ui-grid-cell-contents" style="font-size:15px;"><i ng-if="row.entity.STATUS ==\'Y\'" class="fas fa-check green"></i><i ng-if="row.entity.STATUS !=\'Y\'" class="fas fa-times red"></i></div>'
					},
					{ width:"100", displayName: '수정', field: 'master_modify',enableCellEdit : false, allowCellFocus : false, cellClass:"center"
						, cellTemplate : '<div class="ui-grid-cell-contents" style="font-size:15px;"><i class="fas fa-edit ui-grid-dbclick-column" ng-click="grid.appScope.openMasterCode(row.entity)"></i></div>'},
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
app.controller('detailCodeCtrl', ['$scope','$controller','$log','StudentService', '$http', 
	function ($scope,$controller,$log,StudentService,$http) {		//$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
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
		$scope.deleteRowOne = vm.deleteRowOne;
		$scope.addedTF = false;
		
		$scope.pagination = vm.pagination;
		
		$scope.ipe_typeList = null;
		$scope.ipe_sourceList = null;
		$scope.ipe_periodList = null;
		$scope.ipe_hold_periodList = null;
		$scope.ipe_lvlList = null;
		$scope.systemList = null;
		
	 	angular.element(document).ready(function () {
// 			 $http({
// 		          method: 'POST',
// 		            url: '/ipeSelectList',
// 		            data: $.param({term_code:$("#termcode option:selected").data("term-code"), _csrf : "${_csrf.token}"}), 
// 		            headers: {
// 		                'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
// 		            	//'Content-Type': 'application/json; charset=UTF-8'
// 		            }
// 		        }).success(function(data){
// 		        	$scope.ipe_typeList = data.ipe_type;
// 		    		$scope.ipe_sourceList = data.ipe_source;
// 		    		$scope.ipe_periodList = data.ipe_period;
// 		    		$scope.ipe_hold_periodList = data.ipe_hold_period;
// 		    		$scope.ipe_lvlList = data.ipe_lvl;
// 		    		$scope.systemList = data.systemList;
// 		    		for(var i=0; i<$(".ui-grid-custom-select").length; i++){
// 		    			$(".ui-grid-custom-select")[i][0].remove();
// 		    		}
		    		
		    		
// 		     });	 
	 	});
		
	 	$scope.openDetailCode=function(row){
	 		document.getElementById("m_d_saveType").value = "MOD";
			document.getElementById("m_d_resort_code").value = row.RESORT_CD;
			document.getElementById("m_d_resort_name").value = row.RESORT_NAME;
			document.getElementById("m_region_code").value  = row.REGION_CD;
			document.getElementById("m_region_name").value  = row.REGION_NAME;
			

			//document.getElementById("RESORT_CD").value  = row.RESORT_CD;
			document.master_frm.RESORT_CD.value = row.RESORT_CD;
			


			$("input:radio[name='m_region_status']:radio[value='"+row.STATUS+"']").prop('checked', true); // 선택하기
			
			$("#m_d_resort_code").prop("readonly", true);
			
			$("#detailCodeModal").modal({
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
				enableRowSelection : false, 					//로우 선택
				enableRowHeaderSelection : true, 			//맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 35, 				//체크박스 컬럼 길이
				rowHeight : 27, 							//체크박스 컬럼 높이
				useExternalPagination : false, 				//pagination을 직접 세팅
				enableAutoFitColumns: true,					//컬럼 width를 자동조정
				multiSelect : true, 						//여러로우선택
				enablePagination : false,					//pagenation 숨기기
				enablePaginationControls: false,			//pagenation 숨기기
				columnDefs : [  							//컬럼 세팅
					{ displayName: '선호지역코드', field: 'REGION_CD',enableCellEdit : false, allowCellFocus : false, cellClass:"center"},
					{ displayName: '선호지역명', field: 'REGION_NAME',enableCellEdit : false, allowCellFocus : false, cellClass:"center"},
					{displayName : 'resort_cd', field : 'RESORT_CD', visible : false}, 
					{displayName : 'resort_name', field : 'RESORT_NAME', visible : false},
					{ width:"100", displayName: '사용', field: 'STATUS',enableCellEdit : false, allowCellFocus : false, cellClass:"center"
					, cellTemplate : '<div class="ui-grid-cell-contents" style="font-size:15px;"><i ng-if="row.entity.STATUS ==\'Y\'" class="fas fa-check green"></i><i ng-if="row.entity.STATUS !=\'Y\'" class="fas fa-times red"></i></div>'},
					{ width:"100", displayName: '수정', field: 'detail_modify',enableCellEdit : false, allowCellFocus : false, cellClass:"center"
					, cellTemplate : '<div class="ui-grid-cell-contents" style="font-size:15px;"><i class="fas fa-edit ui-grid-dbclick-column" ng-click="grid.appScope.openDetailCode(row.entity)"></i></div>'},
					
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
	
	var scope_master = angular.element(document.getElementById("masterCodeCtrl-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
	var scrop_detail = angular.element(document.getElementById("detailCodeCtrl-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
	
	//console.log("scope_master" + scope_master);
	/*
	scope_master.keys(scope_master).forEach(function(key){
        console.log(scope_master[key]);
    });
	*/
	//console.log("scope_detail" + scrop_detail);
	
	
	//pagenation option setting  그리드를 부르기 전에 반드시 선언
	var param = {
		listQuery : "yp_ZHR.resortMng", 			
		cntQuery : "yp_ZHR.resortMngCnt"			
    }; 
	var param1 = {
    	listQuery : "yp_ZHR.resortMngRgn", 		//list가져오는 마이바티스 쿼리 아이디
    	cntQuery : "yp_ZHR.resortMngRgnCnt"		//list cnt 가져오는 마이바티스 쿼리 아이디
    }; 
  
	scope_master.paginationOptions = customExtend(scope_master.paginationOptions,param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
	scrop_detail.paginationOptions = customExtend(scrop_detail.paginationOptions,param1); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
	
//	scope.gridLoad(scope.paginationOptions);               //처음페이지 로드될때 테이블 로드
	//복붙영역(앵귤러 이벤트들 가져오기) 끝
	
});
</script>
<script>
$(document).ready(function(){
	var scope_master = angular.element(document.getElementById("masterCodeCtrl-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
	var scope_detail = angular.element(document.getElementById("detailCodeCtrl-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
	
	scope_master.gridApi.selection.on.rowSelectionChanged(scope_master,function(row){
		
		document.getElementById("sel_resort_code").value = row.entity.RESORT_CD;
		document.getElementById("sel_resort_name").value = row.entity.RESORT_NAME;
		
		scope_detail.reloadGrid({
			//select_detail_code : row.entity.master_code
			RESORT_CD : row.entity.RESORT_CD
		});
	});
	
	
	scope_master.reloadGrid({
		selectCodeMaster : $("#selectCodeMaster").val(),
		selectCodeMasterYN : $("#selectCodeMasterYN").val(),
	});
	
	
	$("#btn_search").on("click",function(){
		scope_master.reloadGrid({
			selectCodeMaster   : $("#selectCodeMaster").val(),
			selectCodeMasterYN : $("#selectCodeMasterYN").val(),
		});
		
		scope_detail.gridOptions.data.length = 0;
	});
	
	$("#btn_add_master").on("click",function(){
		document.getElementById("masterCodeForm").reset();
		$("#masterCodeModal").modal({
			backdrop : false,
			keyboard: false
		});
	})
	
	// 리조트 신규입력
	$("#btn_add_resort").on("click",function(){
		document.getElementById("masterCodeForm").reset();
		document.getElementById("m_saveType").value = "REG";
		$("#masterCodeModal").modal({
			backdrop : false,
			keyboard: false
		});
	})
	
	
	// 선호지역 신규입력
	$("#btn_add_region").on("click",function(){
		document.getElementById("detailCodeForm").reset();
		document.getElementById("m_d_saveType").value = "REG";

		if(isEmpty(document.getElementById("sel_resort_code").value.trim())){
			swalWarning("리조트코드를 입력해주십시오.");
			return false;
		}

		document.getElementById("m_d_resort_code").value = document.getElementById("sel_resort_code").value; //리조트 코드
		document.getElementById("m_d_resort_name").value = document.getElementById("sel_resort_name").value; //리조트 코드

		$("input[name=RESORT_CD]").val(document.getElementById("sel_resort_code").value);
		
		$("#detailCodeModal").modal({
			backdrop : false,
			keyboard: false
		});
	})
	
	$("#btn_add_detail").on("click",function(){
		var selectedRows = scope_master.gridApi.selection.getSelectedRows();
		if(isEmpty(selectedRows)){
			swalWarning("마스터코드를 선택해주십시오.");
			return false;
		}
		$("#m_detail_code").prop("readonly", false);
		document.getElementById("detailCodeForm").reset();
		document.getElementById("m_d_master_code").value = selectedRows[0].master_code;
		document.getElementById("m_d_master_name").value = selectedRows[0].master_name;
		$("#detailCodeModal").modal({
			backdrop : false,
			keyboard: false
		});
	})
	
	$("#btn_del_master").on("click",function(){
		var selectedRows = scope_master.gridApi.selection.getSelectedRows();
		if(isEmpty(selectedRows)){
			swalWarning("마스터코드를 선택해주십시오.");
			return false;
		}
		
		swal({
			  icon : "warning",
			  text: "마스터코드 삭제시 연결된 상세코드도 모두 삭제됩니다.\n선택한 마스터코드를 삭제 하시겠습니까?",
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
					  	$.ajax({
							type: 'POST',
							url: "/yp/zhr/rez/deleteResortCode",
							data: JSON.stringify(selectedRows),
							dataType: 'json',
							contentType : "application/json; charset=utf-8",
							success: function(data){
								if(data.result > 0){
									swalSuccess("삭제 되었습니다.");
									$("#btn_search").trigger("click");
								}else{
									swalWarning("삭제 실패했습니다.");
								}
							}
						});
				  }
			});
	})
	/*
	$("#btn_del_detail").on("click",function(){
		var selectedRows = scope_detail.gridApi.selection.getSelectedRows();

			.then(function(result){
				  if(result){
					  	$.ajax({
							type: 'POST',
							url: '/core/staff/code/deleteDetailCode',
							data: JSON.stringify(selectedRows),
							dataType: 'json',
							contentType : "application/json; charset=utf-8",
							success: function(data){
								if(data.result > 0){
									swalSuccess("삭제 되었습니다.");
									$("#btn_search").trigger("click");
								}else{
									swalWarning("삭제 실패했습니다.");
								}
							}
						});
				  }
			});
	})
	*/
	
	$("#btn_del_region").on("click",function(){
		var selectedRows = scope_detail.gridApi.selection.getSelectedRows();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		if(isEmpty(selectedRows)){
			swalWarning("삭제할 선호지역을 선택해주십시오.");
			return false;
		}
		console.log('  --> ' + selectedRows[0].RESORT_CD);
		console.log('  --> ' + selectedRows[0].REGION_CD);
		let preResortCd = selectedRows[0].RESORT_CD;
		//$("#RESORT_CD").val(preResortCd);
		$("input[name=RESORT_CD]").val(preResortCd);
		
		swal({
			  icon : "warning",
			  text: "선택한 선호지역을 삭제 하시겠습니까?",
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
					  	$.ajax({
							type: 'POST',
							url: "/yp/zhr/rez/deleteRegionCode",
							data: JSON.stringify(selectedRows),
							dataType: 'json',
							contentType : "application/json; charset=utf-8",
							success: function(data){
								if(data.result > 0){
									swalSuccess("삭제 되었습니다.");
									//scope_master.reloadGrid(gPostArray($("#master_frm").serializeArray()));
									scope_detail.reloadGrid(gPostArray($("#master_frm").serializeArray()));
								}else{
									swalWarning("삭제 실패했습니다.");
								}
							},
							beforeSend : function(xhr) {
								xhr.setRequestHeader(header, token);
								$('.wrap-loading').removeClass('display-none');
							},
							complete : function() {
								$('.wrap-loading').addClass('display-none');
							}
						});
				  }
			});
	})

	$("#btn_del_resort").on("click",function(){
		var selectedRows = scope_master.gridApi.selection.getSelectedRows();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		if(isEmpty(selectedRows)){
			swalWarning("삭제할 리조트명을 선택해주십시오.");
			return false;
		}
		console.log('  --> ' + selectedRows[0].RESORT_CD);
		console.log('  --> ' + selectedRows[0].REGION_CD);
		//let preResortCd = selectedRows[0].RESORT_CD;
		//$("input[name=RESORT_CD]").val(preResortCd);
		
		swal({
			  icon : "warning",
			  text: "선택한 리조트명을 삭제 하시겠습니까?",
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
					  	$.ajax({
							type: 'POST',
							url: "/yp/zhr/rez/deleteResortCode",
							data: JSON.stringify(selectedRows),
							dataType: 'json',
							contentType : "application/json; charset=utf-8",
							success: function(data){
								if(data.result > 0){
									swalSuccess("삭제 되었습니다.");
									scope_master.reloadGrid(gPostArray($("#master_frm").serializeArray()));
									scope_detail.reloadGrid(gPostArray($("#master_frm").serializeArray()));
								}else{
									swalWarning("삭제 실패했습니다.");
								}
							},
							beforeSend : function(xhr) {
								xhr.setRequestHeader(header, token);
								$('.wrap-loading').removeClass('display-none');
							},
							complete : function() {
								$('.wrap-loading').addClass('display-none');
							}
						});
				  }
			});
	})

	//계약서 첨부 버튼
	$("#file_reg").on("click", function() {
		fnContRegPop();
	});
	
	$('input[type=text]').keydown(function() {
		  if (event.keyCode === 13) {
		    event.preventDefault();
		  };
	});


	
});

function fnContRegPop(){
	
	//20191023_khj for csrf
	var csrf_element = document.createElement("input");
	//csrf_element.name = "_csrf";
	//<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	csrf_element.name = "${_csrf.parameterName}";
	csrf_element.id = "${_csrf.parameterName}";
	csrf_element.value = "${_csrf.token}";
	csrf_element.type = "hidden";
	//20191023_khj for csrf
	
	var input1   = document.createElement("input");
	input1.name  = "title";
	input1.value = "파일 등록";
	input1.type  = "hidden";
	
	var input2   = document.createElement("input");
	input2.name  = "type";
	input2.value = "rez_cont_file";
	input2.type  = "hidden";
	
	var popForm = document.createElement("form");

	popForm.name = "popForm";
	popForm.method = "post";
	popForm.target = "FILE_REG_POP";
	popForm.action = "/yp/popup/zhr/rez/fileReg";
	

	document.body.appendChild(popForm);

	popForm.appendChild(csrf_element);
	
	popForm.appendChild(input1);
	popForm.appendChild(input2);
	
	window.open("","FILE_REG_POP","scrollbars=yes,width=600,height=300");

	popForm.submit();
	popForm.remove();
}
</script>
</body>