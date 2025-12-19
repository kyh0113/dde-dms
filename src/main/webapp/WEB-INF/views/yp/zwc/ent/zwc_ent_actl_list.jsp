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
SimpleDateFormat date = new SimpleDateFormat("yyyy/MM");
String toDay = date.format(today);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>출입인원</title>
</head>
<body>
	<h2>
		출입인원
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
	<form id="ent_frm" name="ent_frm" method="post">
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="TYPE">
		<input type="hidden" name="SEQ">
		<input type="hidden" name="ENT_CODE">
		<input type="hidden" name="SUBC_CODE">
	</form>
	<form id="frm" name="frm" method="post">
		<input type="hidden" name="excel_flag" />
		<input type="hidden" id="url" value=""/>
		<input type="hidden" name="page" id="page" value="${paginationInfo.currentPageNo}" />
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
						<th>업체</th>
						<td>
							<c:choose>
								<%-- 2020-11-23 jamerl - 조용래 : 시스템권한 CA 전체 추가 --%>
								<c:when test="${'SA' eq sessionScope.s_authogrp_code || 'MA' eq sessionScope.s_authogrp_code || 'CA' eq sessionScope.s_authogrp_code || 'SC' eq sessionScope.s_authogrp_code || 'SCM' eq sessionScope.s_authogrp_code}">
									<select id="ent_name">
										<option value="" selected="selected">-전체-</option>
										<c:forEach var="t" items="${teamList}" varStatus="status">
											<option value="${t.CB_CODE}">${t.CB_NAME}</option>
										</c:forEach>
									</select>
								</c:when>
								<c:otherwise>
									<input type="hidden" id="ent_name" value="${req_data.ent_name}" >
									<input type="text" value="${req_data.ent_name}" style="width:170px;" readonly="readonly">
								</c:otherwise>
							</c:choose>
						</td>
						<th>성명</th>
						<td>
							<input type="text" name="subc_name" id="subc_name" value="${req_data.subc_name}" style="width:170px;">
						</td>
						<th>상태</th>
						<td>
							<select name="ser_status" id="ser_status">
								<option value="">-전체-</option>
								<option value="W" <c:if test="${data.ser_status == 'W'}">selected</c:if>>출입신청</option>
								<option value="A" <c:if test="${data.ser_status == 'A'}">selected</c:if>>출입승인</option>
<%-- 							<option value="B" <c:if test="${data.ser_status == 'B'}">selected</c:if>>반려</option> --%>
								<option value="R" <c:if test="${data.ser_status == 'R'}">selected</c:if>>출입종료</option>
								<option value="N" <c:if test="${data.ser_status == 'N'}">selected</c:if>>출입금지</option>
							</select>
						</td>
					</tr>
				</table>
				<div class="btn_wrap">
					<input type="button" class="btn btn_make" id="excel_btn" value="엑셀 다운로드"/>
					<input type="button" class="btn btn_search" id="search_btn" value="조회"/>
				</div>
			</div>
		</section>
	</form>
	<div class="float_wrap">
		<div class="fl">
			<div class="stitle">인원목록</div>
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<c:if test="${'SA' eq sessionScope.s_authogrp_code || 'MA' eq sessionScope.s_authogrp_code || 'CA' eq sessionScope.s_authogrp_code ||'SCM' eq sessionScope.s_authogrp_code || 'CC' eq sessionScope.s_authogrp_code}">
					<input type="button" class="btn_g" id="reg_btn" value="등록" onclick="scope.openPop_ENT('REG','')"/>
				</c:if>
				<c:if test="${'SA' eq sessionScope.s_authogrp_code || 'MA' eq sessionScope.s_authogrp_code || 'CA' eq sessionScope.s_authogrp_code ||'SCM' eq sessionScope.s_authogrp_code}">
					<input type="button" class="btn_g" id="del_btn" value="삭제"/>
				</c:if>
<!-- 				<input type="button" class="btn_g" id="mod_btn" value="수정" onclick="scope.openPop_ENT('MOD','')"/> -->
			</div>
		</div>
	</div>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="shdsCtrl" style="height: auto;">
			<div data-ui-i18n="ko" style="height: 580px;">
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
			
			$scope.uiGridConstants = uiGridConstants;
			
			$scope.pagination = vm.pagination;

			// 세션아이디코드 스코프에저장
			$scope.s_emp_code = "${s_emp_code}";
			
			//협력업체 상세정보
			$scope.openPop_ENT = function(type, row){
				fnEntDetail(type, row);
			};

			//row선택시 체크박스 체크
			$scope.toggleFullRowSelection = function() {
				$scope.gridOptions.enableFullRowSelection = !$scope.gridOptions.enableFullRowSelection;
			    $scope.gridApi.core.notifyDataChange( uiGridConstants.dataChange.OPTIONS);
			};
			
			$scope.openPopup = function (row) {
				var auth_code = "${sessionScope.s_authogrp_code}";
				if("SA" == auth_code || "MA" == auth_code || "CA" == auth_code || "SCM" == auth_code)	fnEntDetail("MOD", row);
				else fnEntDetail("VIEW", row);
			};

			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu:true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바
				showColumnFooter : false,
				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 1000,
				enableCellEditOnFocus : false, //셀 클릭시 edit모드 
				enableSelectAll : false, //전체선택 체크박스
				enableRowSelection : true, //로우 선택
				enableRowHeaderSelection : true, //맨앞 컬럼 체크박스 컬럼으로
				enableFullRowSelection : true,
				selectionRowHeaderWidth : 35, //체크박스 컬럼 길이
				enableHorizontalScrollbar : "1",
				enableVerticalScrollbar : "1",
				rowHeight : 27, //체크박스 컬럼 높이
				// useExternalPagination : true, //pagination을 직접 세팅
				enableAutoFitColumns : true, //컬럼 width를 자동조정
				multiSelect : false, //여러로우선택
				enablePagination : true,
				enablePaginationControls : true,
				columnDefs : 
				[ //컬럼 세팅
					{
						displayName : '순번',
						field : 'RNUM',
						width : '75',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{row.entity.RNUM}}</div>'
					}, 
					{
						displayName : '구분',
						field : 'ENT_TYPE',
						visible : false,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{row.entity.ENT_TYPE}}</div>'
					}, 
					{
						displayName : '구분',
						field : 'ENT_TYPE_NAME',
						width : '75',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{row.entity.ENT_TYPE_NAME}}</div>'
					}, 
					{
						displayName : '업체코드',
						field : 'ENT_CODE',
						visible : false,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{row.entity.ENT_CODE}}</div>'
					}, 
					{
						displayName : '소속업체',
						field : 'ENT_NAME',
						width : '100',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{row.entity.ENT_NAME}}</div>'
					}, 
					{
						displayName : '출입번호',
						field : 'SUBC_CODE',
						width : '100',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{row.entity.SUBC_CODE}}</div>'
					},
					{
						displayName : '성명',
						field : 'SUBC_NAME',
						width : '75',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{row.entity.SUBC_NAME}}</div>'
					},
					{
						displayName : '생년월일',
						field : 'JUMIN',
						width : '100',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{row.entity.JUMIN}}</div>'
					},
					{
						displayName : '주소',
						field : 'ADDR',
						visible : true,
						cellClass : "left",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{row.entity.ADDR}}</div>'
					},
					{
						displayName : '연락처',
						field : 'CELL_PHONE',
						width : '100',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{row.entity.CELL_PHONE}}</div>'
					},
					{
						displayName : '비상연락',
						field : 'PHONE',
						width : '100',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{row.entity.PHONE}}</div>'
					},
					{
						displayName : '차종',
						field : 'VEHICLE_NAME',
						width : '100',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{row.entity.VEHICLE_NAME}}</div>'
					},
					{
						displayName : '차량번호',
						field : 'VEHICLE_NO',
						width : '100',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{row.entity.VEHICLE_NO}}</div>'
					},
					{
						displayName : '출입시작',
						field : 'HIRED_DATE',
						width : '100',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{row.entity.HIRED_DATE}}</div>'
					},
					{
						displayName : '출입종료',
						field : 'RESIGN_DATE',
						width : '100',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{row.entity.RESIGN_DATE}}</div>'
					},
					{
						displayName : '상태',
						field : 'STATUS',
						visible : false,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{row.entity.STATUS}}</div>'
					},
					{
						displayName : '상태',
						field : 'STATUS_NAME',
						width : '80',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{row.entity.STATUS_NAME}}</div>'
					},
				]
			});

			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  

		} ]);

		$(document).ready(function() {
			// 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
			scope = angular.element(document.getElementById("shds-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
			scope.gridApi.selection.on.rowSelectionChanged(scope, function(row) { //로우 선택할때마다 이벤트
				// 				console.log("row2", row.entity);
			});
			scope.gridApi.selection.on.rowSelectionChangedBatch(scope, function(rows) { //전체선택시 가져옴
				// 				console.log("row3", rows[0].entity); //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
			});
			// pagenation option setting  그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param = {
				EXEC_RFC  : "N", // RFC 여부
				cntQuery  : "yp_zwc_ent.accesscontrolListCnt", 	
				listQuery : "yp_zwc_ent.accesscontrolList"
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			scope.toggleFullRowSelection();	//row선택시 체크박스 체크
		
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
		});
	</script>
	<script type="text/javascript">
		var scope;
		$(document).ready(function() {
			//메뉴 진입시 조회
			scope.reloadGrid({
				ENT_NAME   : $("#ent_name").val(),
				SUBC_NAME  : $("#subc_name").val(),
				SER_STATUS : $("#ser_status").val(),
			});
			//협력사 관리자는 "등록,수정"만 오픈
			if('${req_data.gubun}' == "ent") $("#del_btn").remove();

			
			// 부트스트랩 날짜객체
			$(".dtp").datepicker({
				format : "yyyy/mm",
				language : "ko",
				todayHighlight : true,
				autoclose : true,
				clearBtn : true,
				updateViewDate : false
			}).on('changeDate', function(){
			 	$('.datepicker').hide();
			});
			
			// 조회
			$("#search_btn").on("click", function() {
				fnSearchData();
			});
			
			// 삭제
			$("#del_btn").click(function(){
				
				var selectedRows = scope.gridApi.selection.getSelectedRows();	//그리드 선택된 rows data
				if(selectedRows.length == 0){
					swalWarning("삭제할 항목을 선택해 주세요.");
					return false;
				}
				
				//form데이터에 그리드데이터 json으로 변환 및 추가해서 서버로 전송
				var data = $("#ent_frm").serializeArray();
				data.push({name: "gridData", value: JSON.stringify(selectedRows)});
				
				swal({
					icon : "info",
					text : "삭제하면 복구가 불가능하며 \n해당사원이 속한 모든 계약의 작업자맵핑도 초기화됩니다.\n삭제 하시겠습니까?",
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
						$.ajax({
						    url: "/yp/zwc/ent/deleteAccessControl",
						    type: "POST",
						    cache:false,
						    async:true,
						    dataType:"json",
						    data: data,
						    success: function(data) {
						    	if(data.result_code < 0){
									swalWarning(data.msg);
								}else{
									swalSuccessCB(data.msg, function(){
										fnSearchData();
									});	
								}
							},
						    error:function(request,status,error){
						    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
						    	swalDanger("삭제 진행중 오류가 발생하였습니다.\n관리자에게 문의해주세요.");
						    }
						});
					 }
				});
				
				
			});
	
			// 엑셀 다운로드
			$("#excel_btn").on("click", function() {
				//20191023_khj for csrf
				var csrf_element = document.createElement("input");
				csrf_element.name = "_csrf";
				csrf_element.value = "${_csrf.token}";
				csrf_element.type = "hidden";
				//20191023_khj for csrf
				var xlsForm = document.createElement("form");
	
				xlsForm.target = "xlsx_download";
				xlsForm.name = "sndFrm";
				xlsForm.method = "post";
				xlsForm.action = "/yp/xls/zwc/ent/zwc_ent_actl_list";
	
				document.body.appendChild(xlsForm);
	
				xlsForm.appendChild(csrf_element);

				//페이징별 엑셀출력 필요한 경우 세팅 필수 start
				var totalItems = scope.gridOptions.totalItems;
				var pageNumber = scope.gridOptions.paginationCurrentPage;	//현재페이지
				var pageSize   = scope.gridOptions.paginationPageSize;		//한번에 보여줄 row수
				var start = 0;
				var end = 0;
				if(totalItems <= pageSize) pageNumber = 1;
				if(pageNumber == 1){
					start = (pageNumber);
					end   = pageSize;
				}else{
					start = (pageNumber-1)*pageSize+1;
					end   = (pageNumber)*pageSize;
				}
				//페이징별 엑셀출력 필요한 경우 세팅 필수 end

				if('${req_data.gubun}' == "ent" && $("#ser_status").val() != "N"){	//협력업체 관리자인경우, 본인 업체만 조회가능
					$("#ent_name").val('${req_data.emp_name}');
				}
				
				var pr = {
						ENT_NAME   : $("#ent_name").val(),
						SUBC_NAME  : $("#subc_name").val(),
						SER_STATUS : $("#ser_status").val(),
						//엑셀출력시 페이징처리 위한 파라메터
						paging   : "Y",
						start    : start,
						end      : end
				};
	
				$.each(pr, function(k, v) {
					console.log(k, v);
					var el = document.createElement("input");
					el.name = k;
					el.value = v;
					el.type = "hidden";
					xlsForm.appendChild(el);
				});
	
				xlsForm.submit();
				xlsForm.remove();
				$('.wrap-loading').removeClass('display-none');
				setTimeout(function() {
					$('.wrap-loading').addClass('display-none');
				}, 5000); //5초
			});
	
		});
	
		function fnSearchData(){
			if('${req_data.gubun}' == "ent" && $("#ser_status").val() != "N"){	//협력업체 관리자인경우, 본인 업체만 조회가능
				$("#ent_name").val('${req_data.emp_name}');
			}
			scope.reloadGrid({
				ENT_NAME   : $("#ent_name").val(),
				SUBC_NAME  : $("#subc_name").val(),
				SER_STATUS : $("#ser_status").val(),
			});
		}
		
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

			$("#ent_frm input[name=TYPE]").val(type);
			$("#ent_frm input[name=_csrf]").val('${_csrf.token}');
			
			window.open("","ENT_POP","scrollbars=yes,width=900,height=550");
			document.ent_frm.target = "ENT_POP";
			document.ent_frm.action = "/yp/popup/zwc/ent/actlDetail"; 
			 
			$("#ent_frm").submit();
		}
	</script>
	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
</body>