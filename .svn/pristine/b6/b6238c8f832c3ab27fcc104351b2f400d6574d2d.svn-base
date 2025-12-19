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
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>작업표준서 조회</title>
</head>
<body>
	<!-- 20191023_khj for csrf -->
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<h2>
		작업표준서 조회
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
					<th>공정</th>
					<td>
						<select name="srch_type1">
						<!-- kjy, 2022.12.29 부서 상관 없이 모든 사람이 모든 문서 조회 가능하도록 수정 -->
							<c:if test="${req_data.s_authogrp_code eq 'SA' || req_data.s_authogrp_code eq 'MA' || req_data.auth eq 'WM'}"></c:if>
								<option value="" <c:if test="${req_data.srch_type1 eq ''}">selected</c:if>>전체</option>
							<c:forEach var="data" items="${clist1}">
					        	<option value="${data.VALUE}" >${data.VALUE}<c:if test="${data.VALUE eq req_data.srch_type1}">selected</c:if></option>
					        </c:forEach>
						</select>
					</td>
					<th>코드</th>
					<td>
						<input type="text" name="srch_code" value="${req_data.srch_code}">
					</td>
					<th>&nbsp;</th>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<th>상세공정</th>
					<td>
						<select name="srch_type2">
						<!-- kjy, 2022.12.29 부서 상관 없이 모든 사람이 모든 문서 조회 가능하도록 수정 -->
							<c:if test="${req_data.s_authogrp_code eq 'SA' || req_data.s_authogrp_code eq 'MA' || req_data.auth eq 'WM'}"></c:if>
								<option value="" <c:if test="${req_data.srch_type1 eq ''}">selected</c:if>>전체</option>				
							<c:forEach var="data" items="${clist2}">
					        	<option value="${data.VALUE}" >${data.VALUE}<c:if test="${data.VALUE eq req_data.srch_type2}">selected</c:if></option>
					        </c:forEach>
						</select>
					</td>
					<th>문서제목</th>
					<td>
						<input type="text" name="srch_doc_title" value="${req_data.srch_doc_title}">
					</td>
					<th>&nbsp;</th>
					<td>&nbsp;</td>
				</tr>
			</table>
			<div class="btn_wrap">
<!-- 				권한 풀고 공정 데이터를 해당 부서 건만 볼 수 있도록 수정 -->
				<c:if test="${'SA' eq sessionScope.s_authogrp_code || 'MA' eq sessionScope.s_authogrp_code || 'WM' eq req_data.auth}">
					<button class="btn btn_save" id="reg_btn">신규 등록</button>
				</c:if>
				<button class="btn btn_search" id="search_btn">조회</button>
			</div>
		</div>
	</section>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="shdsCtrl" style="height: auto;">
			<div data-ui-i18n="ko" style="height: 620px;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
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
			$scope.uiGridConstants = uiGridConstants;
			$scope.pagination = vm.pagination;

			// 세션아이드코드 스코프에저장
			$scope.s_emp_code = "${s_emp_code}";
		
			$scope.fn_detail = function(row) {
				f_href("/yp/zpp/wsd/zpp_wsd_detail", {
					code : row.CODE,
					version : row.VERSION,
					hierarchy : "000004"
				});
				//f_href_with_auth("/yp/zpp/wsd/zpp_wsd_detail?code="+code, "000004");
			}
			
			//전자결재 연동	//220330 결재연동 취소
			$scope.fn_gwif = function(row){
 				var url = "http://ypgw.ypzinc.co.kr/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=EF163583830678631&code="+row.CODE+"&ver="+row.NEW_VER;	//운영
				//var url = "http://gwdev.ypzinc.co.kr/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=EF162201232127207&code="+row.CODE+"&ver="+row.NEW_VER;	//개발		
				window.open(url,"전자결재","scrollbars=auto,width=1000,height=900");
			}	
			
			
			// formater - String yyyyMMdd -> String yyyy/MM/dd
			$scope.formatter_date = function(str_date) {
				if (str_date.length === 8) {
					return str_date.replace(/(\d{4})(\d{2})(\d{2})/g, '$1/$2/$3');
				} else {
					return str_date;
				}
			};

			// formater - String hhmi -> String hh:mi
			$scope.formatter_time = function(str_date) {
				if (str_date !== "000000" && str_date.length === 6) {
					return str_date.replace(/(\d{2})(\d{2})(\d{2})/g, '$1:$2');
				} else {
					return "";
				}
			};

			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바

				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 10,

				enableCellEditOnFocus : false, //셀 클릭시 edit모드 
				enableSelectAll : false, //전체선택 체크박스
				enableRowSelection : false, //로우 선택
				enableRowHeaderSelection : false, //맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 35, //체크박스 컬럼 길이
				enableHorizontalScrollbar : "1",
				enableVerticalScrollbar : "1",
				rowHeight : 27, //체크박스 컬럼 높이
				// useExternalPagination : true, //pagination을 직접 세팅
				enableAutoFitColumns : true, //컬럼 width를 자동조정
				multiSelect : false, //여러로우선택
				enablePagination : true,
				enablePaginationControls : true,

				columnDefs : [ //컬럼 세팅
				{
					displayName : '공정',
					field : 'TYPE1',
					width : '150',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '상세공정',
					field : 'TYPE2',
					width : '150',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '코드',
					field : 'CODE',
					width : '150',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '문서 제목',
					field : 'DOC_TITLE',
// 					width : '500',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '개정일자',
					field : 'UPD_DATE',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div ng-if="row.entity.UPD_DATE != null" class="ui-grid-cell-contents">{{grid.appScope.formatter_date(row.entity.UPD_DATE)}}</div>'
				}, {
					displayName : '개정버전',
					field : 'VERSION',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
					,cellTemplate : '<div class="ui-grid-cell-contents" ng-if="row.entity.VERSION != null">Rev.{{row.entity.VERSION}}</div>'
				}, {
					displayName : '문서 등록일',
					field : 'REG_DATE',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_date(row.entity.REG_DATE)}}</div>'
					
// 				}, {
// 					displayName : '개정문서 결재',
// 					field : 'NEW_VER',
// 					width : '150',
// 					visible : true,
// 					cellClass : "center",
// 					enableCellEdit : false,
// 					allowCellFocus : false,
// 					cellTemplate : '<div class="ui-grid-cell-contents btn_g pointer" ng-if="row.entity.NEW_VER != null && row.entity.NEW_EDOC == null" ng-click="grid.appScope.fn_gwif(row.entity)">결재 상신</div>'
// 									+'<div class="ui-grid-cell-contents" ng-if="row.entity.NEW_EDOC == \'W\'">결재진행중</div>'
				}, {
					displayName : '상세보기',
					field : 'STATUS',
					width : '150',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents btn_g pointer" ng-click="grid.appScope.fn_detail(row.entity)">보기</div>'
				}]
			});

			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  
		} ]);

		$(document).ready(function() {
			var scope;
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
				listQuery : "yp_zpp.select_zpp_wsd_list", //list가져오는 마이바티스 쿼리 아이디
				cntQuery : "yp_zpp.select_zpp_wsd_list_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝

			// 부트스트랩 날짜객체
			$(".dtp").datepicker({
				format : "yyyy/mm/dd",
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
				var srch_type1 = $('select[name="srch_type1"]').val(),
					srch_type2 = $('select[name="srch_type2"]').val();
				
		// kjy, 2022.12.29 부서 상관 없이 모든 사람이 모든 문서 조회 가능하도록 수정
				
		//		if("${sessionScope.s_authogrp_code}" !== 'SA' && "${sessionScope.s_authogrp_code}" !== 'MA' && "${req_data.auth}" !== 'WM'){
		//			if(isEmpty(srch_type1) || isEmpty(srch_type2)){
		//				swalWarning("공정과 상세공정을 선택해주세요.");
		//				return;
		//			}
		//		}
				
				scope.reloadGrid({
					type1 : $("select[name=srch_type1]").val(),
					type2 : $("select[name=srch_type2]").val(),
					code : $("input[name=srch_code]").val(),
					title : $("input[name=srch_doc_title]").val()
				});
			});
			
			$("select[name=srch_type1]").change(function() {
				var type1 = $(this).val();
				$.ajax({
					url : "/yp/zpp/wsd/zpp_wsd_auth_dept_map_code_list",
					type : "POST",
					data : {"upper_val" : $("select[name=srch_type1]").val()
							,"type_level" : "2"
							, _csrf : '${_csrf.token}'},
					dataType : "json",
					success : function(result) {
						var data = result.result;
						var opt = "";
						
						if(isEmpty(type1)){
							opt += "<option value=''>전체</option>";
						}
						
						var type2 = $("select[name=srch_type2]:selected").val();
						var sel = "";
						for(var i=0;i<data.length;i++){
							if(type2 == data[i].VALUE) sel = "selected";
							opt += "<option value='"+data[i].VALUE+"'"+sel+">"+data[i].VALUE+"</option>";
							sel="";
						}
						$("select[name=srch_type2] option").remove();
						$("select[name=srch_type2]").append(opt);
					},
					error : function(request, status, error) {
						console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
					}
				});
			});
			
			$("#reg_btn").click(function() {
				fnRegPop();
			});
			
			$("#excel_btn").click(function() {
				fnExelDown();
			});
		});

		
		//등록 팝업
		function fnRegPop(){
			var csrf_element = document.createElement("input");
			csrf_element.name = "_csrf";
			csrf_element.value = "${_csrf.token}";
			csrf_element.type = "hidden";
			
			var popForm = document.createElement("form");

			popForm.name = "popForm";
			popForm.method = "post";
			popForm.target = "wsd_create";
			popForm.action = "/yp/popup/zpp/wsd/zpp_wsd_create";

			document.body.appendChild(popForm);
			popForm.appendChild(csrf_element);
			
			window.open("","wsd_create","scrollbars=no,width=400,height=500");

			popForm.submit();
			popForm.remove();
			
		}
	</script>
</body>