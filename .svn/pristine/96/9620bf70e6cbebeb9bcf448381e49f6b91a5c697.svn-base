<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}

	Date today = new Date();
	SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/dd");
	String toDay = date.format(today);

	//7일전
	Calendar day = Calendar.getInstance();
	day.add(Calendar.DATE , -7);
	String bfDay = date.format(day.getTime());
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>리조트 예약 관리
</title>
<script type="text/javascript">
	var scope;
	$(document).ready(function() {
		// 부트스트랩 날짜객체
		$(".dtp").datepicker({
			format : "yyyy/mm/dd",
			language : "ko",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		});
		
		//조회조건 default
		//오늘날짜 세팅
		if($("input[name=sdate]").val() == ""){
			$("input[name=sdate]").val("<%=bfDay%>");	
		}

		if($("input[name=edate]").val() == ""){
			$("input[name=edate]").val("<%=toDay%>");	
		}

		$('input').on('keydown', function(event) {
			if(event.keyCode==13) 
				return false;
		});

	});
	
</script>
</head>
<body>
	<h2>
		리조트 예약 관리
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
	<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
	<div id="shds-uiGrid" data-ng-controller="shdsCtrl">
	
	<form id="ent_frm" name="ent_frm" method="post">
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="TYPE">
		<input type="hidden" name="SEQ">
		<input type="hidden" name="emp_name">
		<input type="hidden" name="emp_cd">
		<input type="hidden" name="dept_name">
		<input type="hidden" name="dept_cd">
		<input type="hidden" name="mobile_no">
		<input type="hidden" name="email">
		<input type="hidden" name="resort_name">
		<input type="hidden" name="resort_cd">
		<input type="hidden" name="desire_area">
		<input type="hidden" name="appl_reason">
		<input type="hidden" name="use_period_s">
		<input type="hidden" name="use_period_e">
		<input type="hidden" name="etc">
		<input type="hidden" name="status">
		<input type="hidden" name="seq">
		<input type="hidden" name="use_period">
		<input type="hidden" name="people_num">
		<input type="hidden" name="refuse_reason">
		<input type="hidden" name="ENT_CODE">
		<input type="hidden" name="SUBC_CODE">
		<input type="hidden" name="pos_nm">
	</form>

	<form id="frm" name="frm">
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="excel_flag" />
		<input type="hidden" name="page" id="page" value="${req_data.paginationInfo.currentPageNo}" />
		<input type="hidden" name="page_rows" value="" />
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
						<th>신청일자</th>
						<td>
							<input type="text" class="calendar dtp" name="sdate" id="sdate" size="10" value="${bfDay}" readonly />
							~
							<input type="text" class="calendar dtp" name="edate" id="edate" size="10" value="${toDay}" readonly />
						</td>
						<th>리조트명</th>
						<td>
							<select name="resort_name" style="width:165px;" >
								<c:if test="${fn:length(resortlist) != 1}">
									<option value="">--선 택--</option>
								</c:if>
								<c:forEach var="e" items="${resortlist}" varStatus="i" >
									<option value="${e.RESORT_CD}" <c:if test="${e.RESORT_CD eq data[0].RESORT_CD}">selected</c:if>>${e.RESORT_NAME}</option>
								</c:forEach>
							</select>
						</td>
						<th>승인상태</th>
						<td>
							<select name="status" >
								<option value="">--선 택--</option>
								<option value="A" <c:if test="${req_data.status eq 'A'}">selected</c:if>>대기</option>
								<option value="S" <c:if test="${req_data.status eq 'S'}">selected</c:if>>승인</option>
								<option value="F" <c:if test="${req_data.status eq 'F'}">selected</c:if>>반려</option>
							</select>
						</td>
					</tr>
					<tr>
					</tr>
				</table>
				<div class="btn_wrap">
					<button class="btn btn_search" id="search_btn">조회</button>
				</div>
			</div>
		</section>
	</form>
	<div class="float_wrap">
		<div class="fl">
			<div class="stitle">
				신청현황<span class="require">(조회건수 : <b>{{gridOptions.data.length}}</b> 건, &nbsp; 대기건수 : <b>{{regCnt}}</b> 건, &nbsp; 승인건수 : <b>{{approvalCnt}}</b> 건, &nbsp; 반려건수 : <b>{{oppositeCnt}}</b> 건 )</span>
			</div>
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type="button" class="btn_g" id="rmv_btn"  value="선택삭제"/>
			</div>
		</div>
	</div>
	<section class="section">
		<div data-ui-i18n="ko" style="height: 590px;">
			<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
				<div data-ng-if="loader" class="loader"></div>
				<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
	</section>
	</div>
	<script>
		//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
		app.controller('shdsCtrl', [ '$scope', '$window', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $window, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
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
			$scope.deleteRow = vm.deleteRow;
			$scope.deleteRowOne = vm.deleteRowOne;
	    	$scope.searchCnt = vm.searchCnt;
			$scope.uiGridConstants = uiGridConstants;
			
			$scope.pagination = vm.pagination;
			
			// 세션아이디코드 스코프에저장
			$scope.s_emp_code = "${s_emp_code}";

			//협력업체 상세정보 팝업 jj
			$scope.openPop_ENT = function(type, row){
				fnEntDetail(type, row);
			};

			$scope.openPop_VUE = function(type, row){
				fnEntDetailVue(type, row);
			};

			//자식팝업에서 부모창의 콜백함수 실행
			$window.inviteCallback = function() {
	        
	        };

			// formater - String yyyyMMdd -> String yyyy/MM/dd
			$scope.formatter_date = function(str_date) {
				if (str_date.length === 8) {
					return str_date.replace(/(\d{4})(\d{2})(\d{2})/g, '$1/$2/$3');
				} else {
					return str_date;
				}
			};
			
			//신청 건수
			$scope.regCnt = 0;
			
			//승인 건수
			$scope.approvalCnt = 0;
			
			//반려 건수
			$scope.oppositeCnt = 0;

			// formater - String yyyyMM -> String yyyy.MM
			$scope.formatter_yyyymm = function(str_date) {
				return str_date.substring(0,4)+"/"+str_date.substring(4,6)
			};

			
			// onchange 이벤트 시작
			$scope.fnAjaxKOSTL = function(type, row) {
				var target = scope.gridOptions.data.indexOf(row.entity);
				fnAjaxKOSTL(type, target);
			};
			$scope.fnAjaxBACT = function(row) {
				var target = scope.gridOptions.data.indexOf(row.entity);
				fnAjaxBACT(target);
			};
			// onchange 이벤트 끝
			
			//cellClass
			$scope.cellClassSet = function(grid, row, col, rowRenderIndex, colRenderIndex){
				var className = "";
				switch(col.field){
					
				}

				return className;
			}

			var columnDefs1 = [

				{
					displayName : '성명',
					field : 'EMP_NAME',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				},
				{
					displayName : '부서명',
					field : 'DEPT_NAME',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, 
				{
					displayName : '리조트명',
					field : 'RESORT_NAME',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				},
				{
					displayName : '희망지역',
					field : 'REGION_NAME',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				},

				{displayName : 'seq', field : 'SEQ', visible : false}, 
				{displayName : 'mobile_no', field : 'MOBILE_NO', visible : false},
				{displayName : 'email', field : 'EMAIL', visible : false},
				{displayName : 'appl_reason', field : 'APPL_REASON', visible : false},
				{displayName : 'etc', field : 'ETC', visible : false},
				{displayName : 'people_num', field : 'PEOPLE_NUM', visible : false},
				{displayName : 'refuse_reason', field : 'REFUSE_REASON', visible : false},
				{displayName : 'resort_cd', field : 'RESORT_CD', visible : false},
				{
					displayName : '신청일',
					field : 'REG_DATE',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, 
				{
					displayName : '사용기간',
					field : 'USE_PERIOD',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				},
				{
					displayName : '상태',
					field : 'STATUS',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents"><span class="ui-grid-cell-contents btn_s" style="background-color:#CC3333;border-color:#CC3333;" ng-if="row.entity.STATUS ==\'F\'" ng-click="grid.appScope.openPop_VUE(\'MOD\',row)">반려</span><span class="ui-grid-cell-contents btn_g" ng-if="row.entity.STATUS ==\'S\'" ng-click="grid.appScope.openPop_VUE(\'MOD\',row)">승인</span><span class="ui-grid-cell-contents btn_s" ng-if="row.entity.STATUS ==\'A\'" ng-click="grid.appScope.openPop_ENT(\'MOD\',row)">대기</span></div>'
				}
			  ];

			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바
				showColumnFooter : false,
				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 1000,

				enableCellEditOnFocus : true, //셀 클릭시 edit모드 
				enableSelectAll : true, //전체선택 체크박스
				enableRowSelection : true, //로우 선택
				enableRowHeaderSelection : true, //맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 35, //체크박스 컬럼 길이
				enableHorizontalScrollbar : "1",
				enableVerticalScrollbar : "1",
				rowHeight : 27, //체크박스 컬럼 높이
				// useExternalPagination : true, //pagination을 직접 세팅
				enableAutoFitColumns : true, //컬럼 width를 자동조정
				multiSelect : true, //여러로우선택
				enablePagination : true,
				enablePaginationControls : true,

				columnDefs : columnDefs1,
				
				onRegisterApi: function( gridApi ) {
				      $scope.gridApi = gridApi;
				 }
			});

			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  

		} ]);

		$(document).ready(function() {
			// 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
			scope = angular.element(document.getElementById("shds-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
			
			scope.gridApi.core.on.rowsRendered(scope, function() {	//그리드 렌더링 후 이벤트
				scope.regCnt = 0;	//신청건수 초기화
				scope.approvalCnt = 0;	//승인건수 초기화
				scope.oppositeCnt = 0;	//반려건수 초기화
				
				$.each(scope.gridOptions.data, function(i,d){
					//신청한 상태일 경우
					if(d.STATUS == "A"){
						scope.regCnt += 1; 
					//승인한 상태일 경우
					}else if(d.STATUS == "S"){
						scope.approvalCnt += 1;
					//반려 상태일 경우
					}else if(d.STATUS == "F"){
						scope.oppositeCnt += 1; 
					}
					
				});
			});
			scope.gridApi.selection.on.rowSelectionChanged(scope, function(row) { //로우 선택할때마다 이벤트
				//console.log("row2", row.entity);
			});
			scope.gridApi.selection.on.rowSelectionChangedBatch(scope, function(rows) { //전체선택시 가져옴
				//console.log("row3", rows[0].entity); //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
			});
			// pagenation option setting  그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param = {
					EXEC_RFC  : "N", // RFC 여부
					//cntQuery  : "yp_ZHR.resortReservationWCnt", 	
					//listQuery : "yp_ZHR.resortReservationList"
					cntQuery  : "yp_ZHR.resortReservationAdmissionWCnt", 	
					listQuery : "yp_ZHR.resortReservationAdmissionList"
					
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
			
			// 부트스트랩 날짜객체
			$(document).on("focus", ".dtp", function() {
				$(this).datepicker({
					format : "yyyy/mm",
					language : "ko",
					todayHighlight : true,
					autoclose : true,
					clearBtn : true,
					updateViewDate : false
				}).on('changeDate', function (ev) {
					$(this).trigger("change");
					$('.datepicker').hide();
				});
			});

			//조회횟수 초기화
			$("input[name=date]").on("change", function(){
				scope.searchCnt = 0;
			});
			
			// 조회
			$("#search_btn").on("click", function() {
				if (fnValidation()) {
					scope.reloadGrid(
						gPostArray($("#frm").serializeArray())	//폼을 그리드 파라메터로 전송
					);	
				}
			});
			
			//추가버튼
			$("#add_btn").click(function(){
				var datas = scope.gridOptions.data;	//그리드 전체 데이터 접근
				if(datas.length != 0){
					window.open("/yp/popup/zhr/lbm/retrieveEmpWorkList","사원검색","width=450,height=700,scrollbars=yes");	
				}else{
					swalWarning("조회한 후에 추가해 주세요.");
					return false;
				}
			});	
			
			//예약 신청 jj
			$("#resv_btn").click(function(){
				scope.openPop_ENT('REG','')
				//fnDosilakReg();
			});
			
			//신청추가
			$("#reg_btn").click(function(){
				fnDosilakReg();
			});
			
			//신청취소
			/*
			$("#rmv_btn").click(function(){
				fnOkDosilakCancel();
			});
			*/

			//삭제
			$("#rmv_btn").on("click",function(){
				var selectedRows = scope.gridApi.selection.getSelectedRows();
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				if(isEmpty(selectedRows)){
					swalWarning("삭제할 예약현황을 선택해주십시오.");
					return false;
				}
				
				//선택된 것 중에서 집계완료건이 존재한다면, 신청취소 불가
				for(var i = 0; i<selectedRows.length; i++){
					//집계완료된 건이 존재할 경우  //A:대기 S:승인 F:반려
					if((selectedRows[i].STATUS == "S") || (selectedRows[i].STATUS == "F")){
						swalDanger("승인 및 반려된 건은 취소할 수 없습니다.");
						return;
					}
				}
				
				swal({
					  icon : "warning",
					  text: "선택한 예약현황을 삭제 하시겠습니까?",
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
									type: "POST",
									url: "/yp/zhr/rez/deleteResortRez",
									data: JSON.stringify(selectedRows),
									dataType: 'json',
									contentType : "application/json; charset=utf-8",
									success: function(data){
										if(data.result > 0){
											swalSuccess("삭제 되었습니다.");
											$("#search_btn").trigger("click");
										}else{
											swalWarning("삭제 실패했습니다.");
										}
									},
									
									beforeSend : function(xhr) {
										// 2019-10-23 khj - for csrf
										xhr.setRequestHeader(header, token);
										$('.wrap-loading').removeClass('display-none');
									},
									complete : function() {
										$('.wrap-loading').addClass('display-none');
									}
									
									
								});
						  }
					});
			});

		});

		function fnAddRow(emp_cd,emp_name,dept_name){			
			scope.addRow({
				EMP_CD    : emp_cd,
				EMP_NAME  : emp_name,
				DEPT_NAME : dept_name
			}, false, "ASC");				
		}

		function fnDosilakReg(){
			var selectedRows = scope.gridApi.selection.getSelectedRows();	//그리드 선택된 rows data
			if(selectedRows.length > 0){
				
				//form데이터 + 그리드데이터 json으로 변환 및 추가해서 서버로 전송
				var data = $("#frm").serializeArray();
				data.push({name: "gridData", value: JSON.stringify(selectedRows)});
				
				$.ajax({
				    url: "/yp/zhr/lbm/createDosilakAppli",
				    type: "POST",
				    cache:false,
				    async:true, 
				    data : data,
				    dataType:"json",
				    success: function(result) {
				    	swalSuccess(result.msg);
				    	$("#search_btn").trigger("click");
				    	scope.gridApi.selection.clearSelectedRows();			//그리드 selection 초기화
					},
					beforeSend:function(){
						$('.wrap-loading').removeClass('display-none');
					},
					complete:function(){
				        $('.wrap-loading').addClass('display-none');
				    },
				    error:function(request,status,error){
				    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
				    	swalDanger("처리중 오류가 발생하였습니다.\n관리자에게 문의해주세요.");
				    }
			 	});
			}else{
				swalWarning("등록할 항목을 선택해 주세요.");
				return false;
			}
		}

		function fnOkDosilakCancel(){
			var selectedRows = scope.gridApi.selection.getSelectedRows();	//그리드 선택된 rows data
			
			//선택된 것 중에서 집계완료건이 존재한다면, 신청취소 불가
			for(var i = 0; i<selectedRows.length; i++){
				//집계완료된 건이 존재할 경우
				if(selectedRows[i].STATUS == "Y"){
					swalDanger("집계된 건은 취소할 수 없습니다.");
					return;
				}
			};
			if(selectedRows.length > 0){
				//form데이터 + 그리드데이터 json으로 변환 및 추가해서 서버로 전송
				var data = $("#frm").serializeArray();
				data.push({name: "gridData", value: JSON.stringify(selectedRows)})
				
				$.ajax({
				    url: "/yp/zhr/lbm/deleteDosilakAppli",
				    type: "POST",
				    cache:false,
				    async:true, 
				    data : data,
				    dataType:"json",
				    success: function(result) {
				    	swalSuccess(result.msg);
				    	$("#search_btn").trigger("click");
				    	scope.gridApi.selection.clearSelectedRows();			//그리드 selection 초기화
					},
					beforeSend:function(){
						$('.wrap-loading').removeClass('display-none');
					},
					complete:function(){
				        $('.wrap-loading').addClass('display-none');
				    },
				    error:function(request,status,error){
				    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
				    	swalDanger("처리중 오류가 발생하였습니다.\n관리자에게 문의해주세요.");
				    }
			 	});
			}else{
				swalWarning("신청 취소할 항목을 선택해 주세요.");
				return false;
			}
		}

		function fnChkAll(checkFlag) {
			var f = $("input[name=no]");
		    for(var i=0; i<f.length; i++) { 
				f[i].checked = checkFlag;
			} 
		}

		function fnValidation(){
			if($("input[name=date]").val() == ''){
				swalWarning("신청일자를 입력해 주세요.");
				return false;
			} 
			return true;
		}

		//jj pop 보내기
		function fnEntDetail(type, row){
			//form 초기화
			 $("form[name='ent_frm']").each(function() {
			       this.reset();
			      $("input[type=hidden]").val(''); //reset만으로 hidden type은 리셋이 안되기 때문에 써줌
			 });

			if(type=="MOD"){
				/*
				var selectedRows = scope.gridApi.selection.getSelectedRows();	//그리드 선택된 rows data
				if(selectedRows.length == 0){
					swalWarning("수정할 데이터를 선택해 주세요.");
					return false;
				}*/

			 	$("#ent_frm input[name=TYPE]").val(type);
			 	$("#ent_frm input[name=SEQ]").val(row.SEQ);
	 			$("#ent_frm input[name=ENT_CODE]").val(row.ENT_CODE);
	 			$("#ent_frm input[name=SUBC_NAME]").val(row.SUBC_NAME);
			}
			
			if(type=="VIEW"){				
			 	$("#ent_frm input[name=TYPE]").val(type);
			 	$("#ent_frm input[name=SEQ]").val(row.SEQ);
	 			$("#ent_frm input[name=ENT_CODE]").val(row.ENT_CODE);
	 			$("#ent_frm input[name=SUBC_NAME]").val(row.SUBC_NAME);
			}
			
			/*
			<input type="hidden" name="emp_name">
			<input type="hidden" name="emp_cd">
			<input type="hidden" name="dept_name">
			<input type="hidden" name="dept_cd">
			<input type="hidden" name="mobile_no">
			<input type="hidden" name="email">
			<input type="hidden" name="resort_name">
			<input type="hidden" name="resort_cd">
			<input type="hidden" name="desire_area">
			<input type="hidden" name="appl_reason">
			<input type="hidden" name="use_period_s">
			<input type="hidden" name="use_period_e">
			<input type="hidden" name="etc">
			
			displayName : '성명',
			field : 'EMP_NAME',
			displayName : '부서명',
			field : 'DEPT_NAME',
			displayName : '리조트명',
			field : 'RESORT_NAME',
			displayName : '희망지역',
			field : 'REGION_NAME',
			displayName : '신청일',
			field : 'REG_DATE',
			displayName : '사용기간',
			field : 'USE_PERIOD',
			displayName : '상태',
			field : 'STATUS',
*/

		 	//$("#ent_frm input[name=TYPE]").val(type);
 			$("#ent_frm input[name=emp_name]").val(row.entity.EMP_NAME);   //성명 
 			$("#ent_frm input[name=dept_name]").val(row.entity.DEPT_NAME); //부서명
 			$("#ent_frm input[name=resort_name]").val(row.entity.RESORT_NAME);  //리조트명
 			$("#ent_frm input[name=desire_area]").val(row.entity.REGION_NAME);   //희망지역

 			//$("#ent_frm input[name=PHONE]").val(row.entity.REG_DATE);   //신청일
 			$("#ent_frm input[name=use_period]").val(row.entity.USE_PERIOD);  //사용기간
 			$("#ent_frm input[name=status]").val(row.entity.STATUS); //상태
 			$("#ent_frm input[name=seq]").val(row.entity.SEQ); //seq
 			$("#ent_frm input[name=mobile_no]").val(row.entity.MOBILE_NO); //전화번호
 			$("#ent_frm input[name=email]").val(row.entity.EMAIL); //이메일
 			$("#ent_frm input[name=appl_reason]").val(row.entity.APPL_REASON); //신청사유
 			$("#ent_frm input[name=etc]").val(row.entity.ETC); //신청사유
 			$("#ent_frm input[name=people_num]").val(row.entity.PEOPLE_NUM); //인원수
 			$("#ent_frm input[name=emp_cd]").val(row.entity.EMP_CD); //사번
 			$("#ent_frm input[name=pos_nm]").val(row.entity.POS_NM); //직급

			$("#ent_frm input[name=TYPE]").val(type);
			$("#ent_frm input[name=_csrf]").val('${_csrf.token}');
			
			window.open("","REZ_ADM_POP","scrollbars=yes,width=900,height=550");
			document.ent_frm.target = "REZ_ADM_POP";
			//document.ent_frm.action = "/yp/popup/zhr/rez/zhrRezCreate";
			document.ent_frm.action = "/yp/popup/zhr/rez/zhrRezAdmissionVue";
			
			$("#ent_frm").submit();
		}

		//jj pop 승인  반려 보내기
		function fnEntDetailVue(type, row){
			//form 초기화
			 $("form[name='ent_frm']").each(function() {
			       this.reset();
			      $("input[type=hidden]").val(''); //reset만으로 hidden type은 리셋이 안되기 때문에 써줌
			 });

			if(type=="MOD"){
				/*
				var selectedRows = scope.gridApi.selection.getSelectedRows();	//그리드 선택된 rows data
				if(selectedRows.length == 0){
					swalWarning("수정할 데이터를 선택해 주세요.");
					return false;
				}*/

			 	$("#ent_frm input[name=TYPE]").val(type);
			 	$("#ent_frm input[name=SEQ]").val(row.SEQ);
			}

		 	//$("#ent_frm input[name=TYPE]").val(type);
 			$("#ent_frm input[name=emp_name]").val(row.entity.EMP_NAME);   //성명 
 			$("#ent_frm input[name=dept_name]").val(row.entity.DEPT_NAME); //부서명
 			$("#ent_frm input[name=resort_name]").val(row.entity.RESORT_NAME);  //리조트명
 			$("#ent_frm input[name=desire_area]").val(row.entity.REGION_NAME);   //희망지역

 			//$("#ent_frm input[name=PHONE]").val(row.entity.REG_DATE);   //신청일
 			$("#ent_frm input[name=use_period]").val(row.entity.USE_PERIOD);  //사용기간
 			$("#ent_frm input[name=status]").val(row.entity.STATUS); //상태
 			$("#ent_frm input[name=seq]").val(row.entity.SEQ); //seq
 			$("#ent_frm input[name=mobile_no]").val(row.entity.MOBILE_NO); //전화번호
 			$("#ent_frm input[name=email]").val(row.entity.EMAIL); //이메일
 			$("#ent_frm input[name=appl_reason]").val(row.entity.APPL_REASON); //신청사유
 			$("#ent_frm input[name=etc]").val(row.entity.ETC); //신청사유
 			$("#ent_frm input[name=people_num]").val(row.entity.PEOPLE_NUM); //인원수
 			$("#ent_frm input[name=refuse_reason]").val(row.entity.REFUSE_REASON); //인원수
 			$("#ent_frm input[name=emp_cd]").val(row.entity.EMP_CD); //사번
 			$("#ent_frm input[name=pos_nm]").val(row.entity.POS_NM); //직급
 
			$("#ent_frm input[name=TYPE]").val(type);
			$("#ent_frm input[name=_csrf]").val('${_csrf.token}');
			
			window.open("","REZ_ADM_POP","scrollbars=yes,width=900,height=550");
			document.ent_frm.target = "REZ_ADM_POP";
			//document.ent_frm.action = "/yp/popup/zhr/rez/zhrRezAdmissionViewPop";
			document.ent_frm.action = "/yp/popup/zhr/rez/zhrRezAdmissionModPop";
			
			$("#ent_frm").submit();
		}
	</script>
</body>