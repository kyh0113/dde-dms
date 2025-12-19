<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
if (request.getProtocol().equals("HTTP/1.1")) {
	response.setHeader("Cache-Control", "no-cache");
}

Date today = new Date();
SimpleDateFormat date = new SimpleDateFormat("yyyy");
int to_yyyy = Integer.parseInt(date.format(today));
// JSTL에서 사용할 수 있도록 세팅
request.setAttribute("to_yyyy", to_yyyy);

Calendar cal = Calendar.getInstance();
cal.set(Calendar.YEAR, 2010);
int from_yyyy = Integer.parseInt(date.format(cal.getTime()));
//JSTL에서 사용할 수 있도록 세팅
request.setAttribute("from_yyyy", from_yyyy);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>작업자 등록</title>
	<style type="text/css">
	.lst th, .lst td { font-size: 1.0em; }
	.lst td { border : 1px solid #000; cursor: auto !important; vertical-align: inherit !important;}
	.lst th { text-align: center; font-weight: bold; background-color: #fff20080; }
	.watermark { position : inherit !important; }
	.data_rows { display: none; }
	</style>
</head>
<body>
	<!-- 20191023_khj for csrf -->
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<h2>
		작업자 등록
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
	<!-- 	<div class="stitle">기본정보</div> -->
	<form id="frm" name="frm" method="post">
		<section>
			<div class="tbl_box">
				<table cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="5%" />
						<col width="25%" />
						<col width="5%" />
						<col width="25%" />
						<col width="5%" />
						<col width="25%" />
					</colgroup>
					<tr>
						<th>연도</th>
						<td>
							<input type="text" id="BASE_YYYY" class="calendar search_dtp_y" value="${to_yyyy}" readonly="readonly"/>
						</td>
						<th>거래처</th>
						<td>
							<select id="VENDOR_CODE">
								<c:forEach var="row" items="${cb_working_master_v}" varStatus="status">
									<option value="${row.CODE}">${row.CODE_NAME}</option>
								</c:forEach>
							</select>
						</td>
						<th>계약명</th>
						<td>
<!-- 							<input type="text" id="CONTRACT_NAME"> -->
							<select id="CONTRACT_CODE">
								<option value="${row.CODE}" data-base-yyyy="">= 선택 =</option>
								<c:forEach var="row" items="${cb_tbl_working_subc}" varStatus="status">
									<option value="${row.CODE}" data-base-yyyy="${row.BASE_YYYY}">${row.CODE_NAME}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</table>
				<div class="btn_wrap">
					<input type=button class="btn btn_search" id="search_btn"	value="조회">
				</div>
			</div>
		</section>
	</form>
	<div class="float_wrap" style="margin-bottom: 2px;">
		<div class="fl">
			<div class="btn_wrap">
			</div>
		</div>
		<div class="fr">
			<div class="btn_wrap">
			</div>
		</div>
	</div>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="shdsCtrl">
			<div data-ui-i18n="ko" style="height: 550px;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter ui-grid-pinning>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
	</section>
	<div class="float_wrap">
		<div class="fl">
			<div class="stitle">미등록인원 표시</div>
		</div>
		<div class="fr">
			&nbsp;
		</div>
	</div>
	<section>
		<div class="lst" style="overflow-x: scroll;">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<th style="vertical-align: middle; min-width: 0; max-width: 0; display: none;" class="col_rows">미등록 인원</th>
					<td align="center" class="watermark ndata_rows" style="opacity: 0.75">미등록인원이 없습니다.</td>
				</tr>
			</table>
		</div>
	</section>
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

			//작업자 삭제
			$scope.DeleteWorker = function(row, index, worker_name, worktype_code) {
				var base_yyyy = row.entity.BASE_YYYY;				//연도
				var vendor_code = row.entity.VENDOR_CODE;			//거래처코드
				var contract_code = row.entity.CONTRACT_CODE;		//계약코드
				
				if(worktype_code == "W1"){				//상갑반
					var subc_codes = row.entity.SUBC_CODE1.split(",");	
				}else if(worktype_code == "W99"){		//교대
					var subc_codes = row.entity.SUBC_CODE2.split(",");	
				}else{									//수시&저장품
					var subc_codes = row.entity.SUBC_CODE3.split(",");	
				}
				
				var subc_code = subc_codes[index];					//작업자코드
				swal({
					  icon : "info",
					  text: "["+worker_name+"]님을 맵핑 삭제하시겠습니까?",
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
							    url: "/yp/zwc/ctr/zwc_ctr_worker_delete",
							    type: "POST",
							    cache:false,
							    async:true, 
							    dataType:"json",
							    data:{BASE_YYYY:base_yyyy, VENDOR_CODE:vendor_code, CONTRACT_CODE:contract_code, SUBC_CODE:subc_code, _csrf:'${_csrf.token}'},
							    success: function(result) {
							    	if(result.result > 0){
							    		swalSuccess("삭제 되었습니다.");
							    	}else{
							    		swalDanger("삭제에 실패하였습니다.\n관리자에게 문의해주세요.");
							    	}
							    	fnSearchData();	//그리드 리로드
						    	},
								beforeSend:function(){
									$('.wrap-loading').removeClass('display-none');
								},
								complete:function(){
							        $('.wrap-loading').addClass('display-none');
							    },
							    error:function(request,status,error){
							    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
							    	swalDanger("삭제에 실패하였습니다.\n관리자에게 문의해주세요.");
							    }
							});
					 	 }			  
					});		
			};
			
			//작업자 리스트 팝업
			$scope.PopWorker = function(row, worktype_code) {

				if(row.entity.GUBUN_NAME == "수시/저장품"){
					if(worktype_code != "W98"){
						swalWarning("구분이 [수시/저장품]은 \n수시/저장품 작업자 맵핑만 가능합니다.");
						return false;
					}
				}else{
					if(worktype_code == "W98"){
						swalWarning("구분이 [일반]은  상갑반 및 교대 작업자 맵핑만 가능합니다.");
						return false;
					}
				}

				
				//파라메터 세팅
				var base_yyyy     = row.entity.BASE_YYYY;		//연도
				var vendor_code   = row.entity.VENDOR_CODE;		//거래처코드
				var contract_code = row.entity.CONTRACT_CODE;	//계약코드
				var contract_name = row.entity.CONTRACT_NAME;	//계약명
				var ent_code      = row.entity.ENT_CODE;		//협력사코드
				
				var form    = document.createElement("form");
	     		var input   = document.createElement("input");
	     		input.name  = "_csrf";
	     		input.value = "${_csrf.token}";
	     		input.type  = "hidden";
	    	
	     		var input1   = document.createElement("input");
	     		input1.name  = "BASE_YYYY";
	     		input1.value = base_yyyy;
	     		input1.type  = "hidden";
	     		
	     		var input2   = document.createElement("input");
	     		input2.name  = "VENDOR_CODE";
	     		input2.value = vendor_code;
	     		input2.type  = "hidden";
	     		
	     		var input3   = document.createElement("input");
	     		input3.name  = "CONTRACT_CODE";
	     		if(row.entity.GUBUN_NAME != "수시/저장품") input3.value = contract_code;
	     		if(row.entity.GUBUN_NAME == "수시/저장품") input3.value = base_yyyy+vendor_code;//수시/저장품 LINE은 계약코드가 존재하지 않기에 임의로 연도+거래처코드를 조합하여 사용
	     		input3.type  = "hidden";
	     		
	     		var input4   = document.createElement("input");
	     		input4.name  = "CONTRACT_NAME";
	     		input4.value = contract_name;
	     		input4.type  = "hidden";
	     		
	     		var input5   = document.createElement("input");
	     		input5.name  = "ENT_CODE";
	     		input5.value = ent_code;
	     		input5.type  = "hidden";
	     		
	     		var input6   = document.createElement("input");
	     		input6.name  = "WORKTYPE_CODE";
	     		input6.value = worktype_code;
	     		input6.type  = "hidden";
	     		
	     		var input7   = document.createElement("input");
	     		input7.name  = "TOT_CNT";
	     		input7.value = row.entity.MAN_QTY;	//계약 총 작업자수
	     		input7.type  = "hidden";
	     		
	     		var input8   = document.createElement("input");
	     		input8.name  = "MAP_CNT";
	     		if(row.entity.GUBUN_NAME != "수시/저장품") input8.value = row.entity.SUBC_CODE1_CNT + row.entity.SUBC_CODE2_CNT;	//맵핑된 작업자수(상갑반+교대)
	     		if(row.entity.GUBUN_NAME == "수시/저장품") input8.value = row.entity.SUBC_CODE3_CNT;								//맵핑된 작업자수(수시/저장품)
	     		input8.type  = "hidden";
	     		
	     		var input9   = document.createElement("input");
	     		input9.name  = "VENDOR_NAME";
	     		input9.value = row.entity.VENDOR_NAME;	//벤더명
	     		input9.type  = "hidden";
	     		
	     		window.open("","worker_popup","width=400,height=650,scrollbars=yes");
	     		
	     		form.method = "post";
	     		form.target = "worker_popup"
	     		form.action = "/yp/popup/zwc/ctr/workerListPop";
	    	
	     		form.appendChild(input);
	     		form.appendChild(input1);
	     		form.appendChild(input2);
	     		form.appendChild(input3);
	     		form.appendChild(input4);
	     		form.appendChild(input5);
	     		form.appendChild(input6);
	     		form.appendChild(input7);
	     		form.appendChild(input8);
	     		form.appendChild(input9);
	     		document.body.appendChild(form);
	    	
	     		form.submit();
	     		form.remove();
			};
			
			var columnDefs = [ //컬럼 세팅
				{
					displayName : '연도',
					field : 'BASE_YYYY',
					width : '75',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '거래처',
					field : 'VENDOR_CODE',
					width : '75',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '거래처명',
					field : 'VENDOR_NAME',
					width : '110',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '구분',
					field : 'GUBUN_NAME',
					width : '90',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '코드',
					field : 'CONTRACT_CODE',
					width : '75',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '협력사코드',
					field : 'ENT_CODE',
					visible : false,
					cellClass : "center",
					pinnedLeft : false,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '계약명',
					field : 'CONTRACT_NAME',
					width : '220',
					visible : true,
					cellClass : "left",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '상갑반 작업자',
					field : 'SUBC_NAME1',
					width : '500',
					visible : true,
					cellClass : "left",
					pinnedLeft : false,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate :
						'<div class="ui-grid-cell-contents">'+
						'	<button type="button" class="btn" ng-click="grid.appScope.PopWorker(row, \'W1\')" style="margin-left:5px; vertical-align: top; padding: 0 5px;">{{worker}}'+
						'		&nbsp;<i class="fas fa-plus green" style="cursor: pointer;"></i>&nbsp;'+
						'	</button>'+
						'	<button ng-repeat="worker in row.entity.SUBC_NAME1.split(\',\')" type="button" class="btn" ng-click="grid.appScope.DeleteWorker(row, $index, worker, \'W1\')" style="margin-left:5px; vertical-align: top; padding: 0 5px;">{{worker}}'+
						'		<i class="fas fa-times red" style="cursor: pointer;margin-left:5px;"></i>'+
						'	</button>'+
						'</div>'
				}, {
					displayName : '교대 작업자',
					field : 'SUBC_NAME2',
					width : '500',
					visible : true,
					cellClass : "left",
					pinnedLeft : false,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate :
						'<div class="ui-grid-cell-contents">'+
						'	<button type="button" class="btn" ng-click="grid.appScope.PopWorker(row, \'W99\')" style="margin-left:5px; vertical-align: top; padding: 0 5px;">{{worker2}}'+
						'		&nbsp;<i class="fas fa-plus green" style="cursor: pointer;"></i>&nbsp;'+
						'	</button>'+
						'	<button ng-repeat="worker2 in row.entity.SUBC_NAME2.split(\',\')" type="button" class="btn" ng-click="grid.appScope.DeleteWorker(row, $index, worker2, \'W99\')" style="margin-left:5px; vertical-align: top; padding: 0 5px;">{{worker2}}'+
						'		<i class="fas fa-times red" style="cursor: pointer;margin-left:5px;"></i>'+
						'	</button>'+
						'</div>'
				}, {
					displayName : '수시/저장품 작업자',
					field : 'SUBC_NAME3',
					width : '500',
					visible : true,
					cellClass : "left",
					pinnedLeft : false,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : 
						'<div class="ui-grid-cell-contents">'+
						'	<button type="button" class="btn" ng-click="grid.appScope.PopWorker(row, \'W98\')" style="margin-left:5px; vertical-align: top; padding: 0 5px;">{{worker3}}'+
						'	&nbsp;<i class="fas fa-plus green" style="cursor: pointer;"></i>&nbsp;'+
						'	</button>'+
						'	<button ng-repeat="worker3 in row.entity.SUBC_NAME3.split(\',\')" type="button" class="btn" ng-click="grid.appScope.DeleteWorker(row, $index, worker3, \'W98\')" style="margin-left:5px; vertical-align: top; padding: 0 5px;">{{worker3}}'+
						'		<i class="fas fa-times red" style="cursor: pointer;margin-left:5px;"></i>'+
						'	</button>'+
						'</div>'
				}
			];			
		
			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바

				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 100,

				enableCellEditOnFocus : true, //셀 클릭시 edit모드 
				enableSelectAll : false, //전체선택 체크박스
				enableRowSelection : false, //로우 선택
				enableRowHeaderSelection : true, //맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 27, //체크박스 컬럼 길이
				enableHorizontalScrollbar : "1",
				enableVerticalScrollbar : "1",
				rowHeight : 27, //체크박스 컬럼 높이
				// useExternalPagination : true, //pagination을 직접 세팅
				enableAutoFitColumns : true, //컬럼 width를 자동조정
				multiSelect : false, //여러로우선택
				enablePagination : true,
				enablePaginationControls : true,

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
				listQuery : "yp_zwc_ctr.select_zwc_ctr_worker_mapping", //list가져오는 마이바티스 쿼리 아이디
				cntQuery : "yp_zwc_ctr.select_zwc_ctr_worker_mapping_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
			
			//페이지 진입시 화면 조회
			fnSearchData();
			
			// 부트스트랩 날짜객체
			$(".search_dtp_y").datepicker({
				format: " yyyy",
				viewMode: "years",
				minViewMode: "years",
				language : "ko",
				todayHighlight : true,
				autoclose : true,
				clearBtn : true,
				updateViewDate : false
			}).on('changeDate', function(e) {
				$(this).val(formatDate_y(e.date.valueOf())).trigger("change");
				$("#search_btn").trigger("click");
				$('.datepicker').hide();
			});
			
			// 부트스트랩 날짜객체
			$(document).on("focus", ".dtp_d", function() {
				$(this).datepicker({
					format: "yyyy/mm/dd",
					language : "ko",
					todayHighlight : true,
					autoclose : true,
					clearBtn : true,
					updateViewDate : false
				}).on('changeDate', function(e) {
					$(this).val(formatDate_d(e.date.valueOf())).trigger("change");
					$('.datepicker').hide();
				});
			});
			
			// 조회
			$("#search_btn").on("click", function() {
				fnSearchData();
			});
		});
		
		function fnSearchData(){
			scope.reloadGrid({
				BASE_YYYY : $("#BASE_YYYY").val(),
				VENDOR_CODE : $("#VENDOR_CODE").val(),
				CONTRACT_CODE : $("#CONTRACT_CODE").val()
			});
			
			// 미등록인원 표시 조회
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				url : "/yp/zwc/ctr/select_zwc_ctr_worker_list",
				type : "post",
				cache : false,
				async : false,
				data : {
					ENT_CODE : "${sessionScope.ent_ent_code}",
					BASE_YYYY : $("#BASE_YYYY").val(),
					VENDOR_CODE : $("#VENDOR_CODE").val(),
					CONTRACT_CODE : $("#CONTRACT_CODE").val()
				},
				dataType : "json",
				success : function(data) {
					var result = data.result;
					if(result.length === 0){
						$(".lst table").css("width","100%");
						$(".ndata_rows").show();
						return false;
					}else{
						$(".lst table").css("width","auto");
						$(".ndata_rows").hide();
					}
					var data2 = ''; 
					$.each(result, function(i, d){
						console.log(i, d);
						data2 += '<td class="data_rows" style="min-width: 100px; max-width: 100px;">' + d.SUBC_NAME + '</td>';
					});
					$(".col_rows").after(data2); // JSON 받아서 출력
					$(".data_rows").show();
				},
				beforeSend : function(xhr) {
					// 2019-10-23 khj - for csrf
					xhr.setRequestHeader(header, token);
					$('.wrap-loading').removeClass('display-none');
					
					$(".data_rows").remove();
					$(".ndata_rows").hide();
				},
				complete : function() {
					$('.wrap-loading').addClass('display-none');
				},
				error : function(request, status, error) {
					console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
					swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
				}
			});
		}
		
		function formatDate_y(date) {
			var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
			if (month.length < 2)
				month = '0' + month;
			if (day.length < 2)
				day = '0' + day;
			return [ year ].join('/');
		}
		function formatDate_m(date) {
			var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
			if (month.length < 2)
				month = '0' + month;
			if (day.length < 2)
				day = '0' + day;
			return [ year, month ].join('/');
		}
		function formatDate_d(date) {
			var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
			if (month.length < 2)
				month = '0' + month;
			if (day.length < 2)
				day = '0' + day;
			return [ year, month, day ].join('/');
		}
	</script>
	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
</body>