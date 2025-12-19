<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<sec:csrfMetaTags />
	<title>작업자 추가</title>
	<script src="/resources/icm/js/jquery.js"></script>
	<script src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
	<script src="/resources/icm/js/custom.js"></script>
	<!-- 기존 프레임워크 리소스 -->
	<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/resources/icm/css/jquery-ui.css" />
	<!-- 2019-12-13 smh jquery-ui.css 변경.끝 -->
	<link href='/resources/icm/css/animate.min.css' rel='stylesheet'>
	<link rel="stylesheet" type="text/css" href="/resources/css/custom.css" />
	<link rel="stylesheet" type="text/css" href="/resources/css/all.min.css" />
	<link rel="stylesheet" href="/resources/icm/jsTree/dist/themes/default/style.min.css" />
	<link href="/resources/icm/datepicker/css/datepicker.css" rel="stylesheet" type="text/css" />
	<link id="bs-css" href="/resources/icm/css/bootstrap.min.css" rel="stylesheet">
	<!-- jQuery -->
	<script src="/resources/icm/js/jquery.js"></script>
	<script src="/resources/icm/js/jquery.validate.min.js"></script>
	<script src="/resources/icm/js/jquery-ui.js"></script>
	<script src="/resources/icm/jsTree/dist/jstree.min.js"></script>
	<script src="/resources/icm/jsTree/dist/customJstree.js"></script>
	<link rel="stylesheet" href="/resources/icm/uigrid/css/ui-grid.min.css" type="text/css">
	<script src="/resources/icm/js/custom.js"></script>
	<script src="/resources/icm/js/multiFile.js"></script>
	<script src="/resources/icm/js/fileList.js"></script>
	<script src="/resources/icm/angular/js/angular.min.js"></script>
	<script src="/resources/icm/angular/js/angular-route.min.js"></script>
	<script src="/resources/icm/uigrid/js/ui-grid.min.js"></script>
	<script src="/resources/icm/uigrid/js/ui-grid.language.ko.js"></script>
	<!-- 2019-08-15 smh 추가 시작.-->
	<!-- 	<script src="/resources/js/jquery.vicurusit.js"></script> -->
	<!-- 2019-08-15 smh 추가 끝-->
	<script src="/resources/icm/uigrid/js/uiGrid1.js"></script>
	<script src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
	<script src="/resources/icm/datepicker/js/bootstrap-datepicker.js"></script>
	<script src="/resources/icm/jsTree/dist/customJstree.js"></script>
	<link rel="stylesheet" type="text/css" href="/resources/font/ng.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/style.css">
	<script type="text/javascript" src="/resources/js/ui.js"></script>
	<!-- 20191227_khj Tooltip Add -->
	<script src="/resources/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="/resources/icm/js/bootstrap.min.js"></script>
	<!-- application script for Charisma demo -->
	<script src="/resources/icm/js/charisma.js"></script>
	<link rel="stylesheet" href="/resources/yp/css/style.css">
	<!-- 기존 프레임워크 리소스 -->
	<!-- 영풍 리소스 -->
	<script src="/resources/yp/js/common.js"></script>
	<style type="text/css">
	
	/* ui-grid header-align CENTER */
	.ui-grid-header-cell{text-align:center !important;}
	.ui-grid-header-cell-label.ng-binding{margin-left:1.2em;}
	.ui-grid-viewport
	{
		overflow-x:hidden !important;
	}
	</style>
	<script type="text/javascript">
	$(document).ready(function() {
		//Grid 필터
		$(".ui-grid-icon-container").on('click', function(evnet){
			var target_id = $(this).parents("div").parents("div").parents("div").parents("div").parents("div")[0].id; 
			var target_scope = angular.element(document.getElementById(target_id)).scope();
			target_scope.gridOptions.enableFiltering = !target_scope.gridOptions.enableFiltering;
			target_scope.gridApi.core.notifyDataChange( target_scope.uiGridConstants.dataChange.COLUMN );
		})
		
	});
	</script>
</head>
<body data-ng-app="app">
	<div id="popup">
		<div class="pop_header">
			작업자 추가
		</div>
		<div class="pop_content">
			<form id="frm" name="frm" method="post" accept-charset="UTF-8">
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" id="target" value="${req_data.target}"/>
				<section>
	               <div class="tbl_box">
	               		거래처&nbsp;&nbsp;:&nbsp;&nbsp;${req_data.VENDOR_NAME}<br/>
	                   	계약명&nbsp;&nbsp;:&nbsp;&nbsp;${req_data.CONTRACT_NAME}
	                </div>
	            </section>
			</form>	
			<section class="section">
				<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
				<div id="shds-uiGrid" data-ng-controller="shdsCtrl">
					<div data-ui-i18n="ko" style="width:360px; height:400px;">
						<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter ui-grid-pinning>
							<div data-ng-if="loader" class="loader"></div>
							<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
						</div>
					</div>
				</div>
				<!-- 복붙영역(html) 끝 -->
			</section>
			<div>
				<c:if test="${req_data.WORKTYPE_CODE ne 'W98'}">
				맵핑 완료<span class="require" id="map_cnt">0</span> / 근무형태(계)<span class="require" id="tot_cnt">0</span>
				</c:if>
				<c:if test="${req_data.WORKTYPE_CODE eq 'W98'}">
					맵핑 완료<span class="require" id="map_cnt">0</span>
				</c:if>
			</div>
			<div class="btn_wrap">
				<button class="btn" onclick="fnSave();">추가</button>
				<button class="btn" onclick="self.close();">닫기</button>
			</div>
		</div>
	</div>
	<script>
		//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
		app.controller('shdsCtrl', [ '$scope', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
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

			$scope.pagination = vm.pagination;

			// 세션아이드코드 스코프에저장
			$scope.s_emp_code = "${s_emp_code}";

			$scope.uiGridConstants = uiGridConstants;
			
			var columnDefs = [ //컬럼 세팅
				{
					displayName : '성명',
					field : 'SUBC_NAME',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				},
				{
					displayName : '근무형태',
					field : 'WORKTYPE_CODE',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}
			];	
	
		
			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바

				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 100,

				enableCellEditOnFocus : true, //셀 클릭시 edit모드 
				enableSelectAll : true, //전체선택 체크박스
				enableRowSelection : true, //로우 선택
				enableRowHeaderSelection : true, //맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 27, //체크박스 컬럼 길이
				enableHorizontalScrollbar : "1",
				enableVerticalScrollbar : "1",
				rowHeight : 27, //체크박스 컬럼 높이
				// useExternalPagination : true, //pagination을 직접 세팅
				enableAutoFitColumns : true, //컬럼 width를 자동조정
				multiSelect : true, //여러로우선택
				enablePagination : false,
				enablePaginationControls : false,

				columnDefs : columnDefs,
				
				onRegisterApi: function( gridApi ) {
					$scope.gridApi = gridApi;
				}
			});
			
			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  
		} ]);
		var scope;
		$(document).ready(function() {
			// 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
			scope = angular.element(document.getElementById("shds-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
			scope.gridApi.selection.on.rowSelectionChanged(scope, function(row) { //로우 선택할때마다 이벤트
				// console.log("row2", row.entity);
			});
			scope.gridApi.selection.on.rowSelectionChangedBatch(scope, function(rows) { //전체선택시 가져옴
				// console.log("row3", rows[0].entity); //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
			});
			// pagenation option setting  그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param = {
				listQuery : "yp_zwc_ctr.select_zwc_ctr_worker_list", //list가져오는 마이바티스 쿼리 아이디
				cntQuery : "yp_zwc_ctr.select_zwc_ctr_worker_list_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
			
		});
	</script>
	<script>
	$(document).ready(function() {
		//페이지 진입시 조회
		scope.reloadGrid({
			ENT_CODE    : '${req_data.ENT_CODE}',
			BASE_YYYY   : '${req_data.BASE_YYYY}',
			VENDOR_CODE : '${req_data.VENDOR_CODE}',
			CONTRACT_CODE : '${req_data.CONTRACT_CODE}',
			WORKTYPE_CODE : '${req_data.WORKTYPE_CODE}',
		});
		
		$("#map_cnt").text('${req_data.MAP_CNT}');	//맵핑 된 작업자 수
		$("#tot_cnt").text('${req_data.TOT_CNT}');  //계약 근무형태 계
	});
	
	function fnSave(){
		var selectedRows = scope.gridApi.selection.getSelectedRows();	//그리드 선택된 rows data
		if(selectedRows.length == 0){
			swalWarning("추가할 작업자를 선택해주세요.");
			return false;
		}
		
		/* 20201103_khj 체크로직 삭제 요청받음
		$.ajax({
		    url: "/yp/zwc/ctr/zwc_ctr_worker_mapping_validation",
		    type: "POST",
		    cache:false,
		    async:false, 
		    data:{BASE_YYYY   : '${req_data.BASE_YYYY}', VENDOR_CODE : '${req_data.VENDOR_CODE}', CONTRACT_CODE : '${req_data.CONTRACT_CODE}', _csrf:'${_csrf.token}'},
		    dataType : 'json',
		    success: function(result) {
		    	var arr = result.VALIDATION_LIST;	//근무형태별 등록가능인원 카운트정보
		    	
		    	
		    	//선택된 그리드 데이터 루프돌면서 등록가능한지 카운트 체크
				$.each(selectedRows, function(i, d){
					var val = d.WORKTYPE_CODE;					//근무형태코드
					var newArr = arr.filter(function(item){		//배열에 해당하는 값 있으면 새로운배열에 할당
			    		  return item.WORKTYPE_CODE === val;
			    	});  
					
			    	var index = arr.indexOf(newArr[0]);		//해당 루프순번의 근무형태코드에 해당하는 배열의 인덱스번호 획득
			    	arr[index].REG_POSSIBLE_CNT = arr[index].REG_POSSIBLE_CNT - 1;	//등록가능인원 카운트 -1씩해서 0 이하면 등록 못하게끔 벨리데이션 처리
						if(arr[index].REG_POSSIBLE_CNT < 0){
						swalWarning("추가 가능한 작업자 수를 초과하였습니다.");
						validation = false;
						return false;
					}else{
						validation = true;
					}
				});
		    	
		    	
		    	validation = true;
	    	},
			beforeSend:function(){
				$('.wrap-loading').removeClass('display-none');
			},
			complete:function(){
			       $('.wrap-loading').addClass('display-none');
			},
			error:function(request,status,error){
			   	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
			   	swalDanger("추가에 실패하였습니다.\n관리자에게 문의해주세요.");
			}
		});
		*/
		
		//if(validation){
			//form데이터에 그리드데이터 json으로 변환 및 추가해서 서버로 전송
			var data = $("#frm").serializeArray();
			data.push({name: "gridData", value: JSON.stringify(selectedRows)});
			$.ajax({
			    url: "/yp/zwc/ctr/zwc_ctr_worker_create",
			    type: "POST",
			    cache:false,
			    async:false, 
			    dataType:"json",
			    data:data,
			    success: function(result) {
			    	if(result.result > 0){
			    		swalSuccessCB("추가 되었습니다.", function(){
			    			window.opener.fnSearchData();
					    	self.close();
			    		});
			    	}else{
			    		swalDanger("추가에 실패하였습니다.\n관리자에게 문의해주세요.");
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
			    	swalDanger("추가에 실패하였습니다.\n관리자에게 문의해주세요.");
			    }
			});
		//}
	}
	</script>
</body>
</html>