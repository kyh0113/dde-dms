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
<title>업체등록</title>
</head>
<body>
	<h2>
		업체등록
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
		<input type="hidden" name="ENT_CODE">
		<input type="hidden" name="ENT_NAME">
		<input type="hidden" name="ENT_TYPE">
		<input type="hidden" name="ADMIN_ID">
		<input type="hidden" name="ADMIN_PW">
		<input type="hidden" name="PHONE">
		<input type="hidden" name="EMAIL">
		<input type="hidden" name="WORKER">
		<input type="hidden" name="WORKER_NAME">
		<input type="hidden" name="REG_DATE">
		<input type="hidden" name="UPD_DATE">
		<input type="hidden" name="VENDOR_CODE">
		<input type="hidden" name="ENTERPRISE_GUBUN">
		<input type="hidden" name="REPRESENTATIVE">
	</form>
	<form id="frm" name="frm" method="post">
		<input type="hidden" name="excel_flag" />
		<input type="hidden" id="url" value="" />
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
						<th>업체명</th>
						<td>
							<input type="text" name="ENT_NAME" id="ENT_NAME" style="width:170px;">
						</td>
						<th>관리자 ID</th>
						<td>
							<input type="text" name="ADMIN_ID" id="ADMIN_ID" style="width:170px;">
						</td>
						<th>&nbsp;</th>
						<td>&nbsp;</td>
					</tr>
				</table>
				<div class="btn_wrap">
					<input type="button" class="btn btn_make" id="excel_btn" value="엑셀 다운로드" />
					<input type="button" class="btn btn_search" id="search_btn" value="조회" />
				</div>
			</div>
		</section>
	</form>
	<div class="float_wrap">
		<div class="fl">
			<div class="stitle">업체목록</div>
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type="button" class="btn_g" id="reg_btn" value="등록" onclick="scope.openPop_ENT('REG','')" />
			</div>
		</div>
	</div>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller -->
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
			angular.extend(vm, $controller('CodeCtrl', { //CodeCtrl(ui-grid 커스텀 api)를 상속받는다.
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
			
			// 비밀번호 초기화
			$scope.reset_pwd = function(row) {
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					url : "/yp/zwc/ent/updateEnt_reset_pwd",
					type : "POST",
					cache : false,
					async : false,
					dataType : "json",
					data : {
						ENT_CODE: row.entity.ENT_CODE
					},
					success : function(data) {
						if(data.result_code > 0) {
							swalSuccessCB("비밀번호를 초기화했습니다.");
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
						swalDangerCB("조회 실패하였습니다.\n관리자에게 문의해주세요.");
					}
				});
			};
			
			//사업자등록증 보기
			$scope.viewImg = function(row) {
				if(row.entity.LICENSE_URL == "") {
					swalWarning("등록된 사업자등록증이 없습니다.");
					return false;
				}else{
					fnImgPop(row.entity.LICENSE_URL);
				}
			};
			
			//협력업체 상세정보
			$scope.openPop_ENT = function(type, row) {
				fnEntDetail(type, row);
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
				
				columnDefs :
				[ //컬럼 세팅
					{
						displayName : ' ',
						field : 'RNUM',
						width : '55',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false,
					},
					{
						displayName : '기준정보_업체코드',
						field : 'VENDOR_CODE',
						visible : false,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					},
					{
						displayName : '구분',
						field : 'ENT_TYPE',
						visible : false,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					},
					{
						displayName : '구분',
						field : 'ENT_TYPE_NAME',
						width : '75',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					},
					{
						displayName : '업체코드',
						field : 'ENT_CODE',
						width : '105',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					},
					{
						displayName : '업체명',
						field : 'ENT_NAME',
						visible : true,
						cellClass : "left",
						enableCellEdit : false,
						allowCellFocus : false
					},
					{
						displayName : '대표전화',
						field : 'PHONE',
						width : '150',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					},
					{
						displayName : 'E-Mail',
						field : 'EMAIL',
						width : '200',
						visible : true,
						cellClass : "left",
						enableCellEdit : false,
						allowCellFocus : false
					},
					{
						displayName : '관리자',
						field : 'ADMIN_ID',
						width : '105',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					},
					{
						displayName : '사업자등록번호',
						field : 'LICENSE_URL',
						width : '150',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents btn_g" style="cursor: pointer;" ng-click="grid.appScope.viewImg(row)">보기</div><div class="ui-grid-cell-contents btn_g" style="cursor: pointer;margin-left:5px;" ng-click="grid.appScope.openPop_ENT(\'MOD\',row)">수정</div>'
					},
					{
						displayName : '패스워드',
						field : 'ADMIN_PW',
						width : '105',
						<c:choose>
						<%-- 2022-01-21 jamerl - CA권한 추가 --%>
						<%-- 2024-01-24 ichwang - MA권한 추가 --%>
						<c:when test="${sessionScope.s_authogrp_code eq 'SA' or sessionScope.s_authogrp_code eq 'CA' or sessionScope.s_authogrp_code eq 'SCM' or sessionScope.s_authogrp_code eq 'MA'}">visible : true,</c:when>
						<c:otherwise>visible : false,</c:otherwise>
						</c:choose>
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents btn_g" style="cursor: pointer;" ng-click="grid.appScope.reset_pwd(row)">초기화</div>'
					},
					{
						displayName : 'WORKER',
						field : 'WORKER',
						visible : false,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					},
					{
						displayName : 'WORKER',
						field : 'WORKER_NAME',
						visible : false,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					},
					{
						displayName : '등록일',
						field : 'REG_DATE',
						visible : false,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					},
					{
						displayName : '수정일',
						field : 'UPD_DATE',
						visible : false,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
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
				// console.log("row2", row.entity);
			});
			scope.gridApi.selection.on.rowSelectionChangedBatch(scope, function(rows) { //전체선택시 가져옴
				// console.log("row3", rows[0].entity); //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
			});
			// pagenation option setting  그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param = {
				EXEC_RFC  : "N", // RFC 여부
				cntQuery  : "yp_zwc_ent.enterpriseListCnt", 	
				listQuery : "yp_zwc_ent.enterpriseList"
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합

			//복붙영역(앵귤러 이벤트들 가져오기) 끝
		});
	</script>
	<script type="text/javascript">
		var scope;
		$(document).ready(function() {
			//메뉴 진입시 조회
			scope.reloadGrid({
				ENT_NAME : $("#ENT_NAME").val(),
				ADMIN_ID : $("#ADMIN_ID").val(),
			});
			
			// 부트스트랩 날짜객체
			$(".dtp").datepicker({
				format : "yyyy/mm",
				language : "ko",
				todayHighlight : true,
				autoclose : true,
				clearBtn : true,
				updateViewDate : false
			}).on('changeDate', function() {
			 	$('.datepicker').hide();
			});
			
			// 조회
			$("#search_btn").on("click", function() {
				fnSearchData();
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
				xlsForm.action = "/yp/xls/zwc/ent/zwc_ent_list";
				
				document.body.appendChild(xlsForm);
				
				xlsForm.appendChild(csrf_element);
				
				//페이징별 엑셀출력 필요한 경우 세팅 필수 start
				var totalItems = scope.gridOptions.totalItems;
				var pageNumber = scope.gridOptions.paginationCurrentPage;	//현재페이지
				var pageSize   = scope.gridOptions.paginationPageSize;		//한번에 보여줄 row수
				var start = 0;
				var end = 0;
				if(totalItems <= pageSize) pageNumber = 1;
				if(pageNumber == 1) {
					start = (pageNumber);
					end   = pageSize;
				}else{
					start = (pageNumber-1)*pageSize+1;
					end   = (pageNumber)*pageSize;
				}
				//페이징별 엑셀출력 필요한 경우 세팅 필수 end

				var pr = {
						ent_name : $("#ENT_NAME").val(),
						admin_id : $("#ADMIN_ID").val(),
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
		
		function fnSearchData() {
			scope.reloadGrid({
				ENT_NAME : $("#ENT_NAME").val(),
				ADMIN_ID : $("#ADMIN_ID").val(),
			});
		}
		
		function fnImgPop(url) {
			window.open("/yp/popup/imgPopup?url="+encodeURIComponent(url),"imgPop","width=580,height=780");
		}
		
		function fnEntDetail(type, row) {
			//form 초기화
			$("form[name='ent_frm']").each(function() {
				this.reset();
			    $("input[type=hidden]").val(''); //reset만으로 hidden type은 리셋이 안되기 때문에 써줌
			});
			
			if(type=="MOD") {
			 	$("#ent_frm input[name=TYPE]").val(type);
	 			$("#ent_frm input[name=ENT_CODE]").val(row.entity.ENT_CODE);
	 			$("#ent_frm input[name=ENT_NAME]").val(row.entity.ENT_NAME);
	 			$("#ent_frm input[name=ENT_TYPE]").val(row.entity.ENT_TYPE);
	 			$("#ent_frm input[name=ADMIN_ID]").val(row.entity.ADMIN_ID);
// 	 			$("#ent_frm input[name=ADMIN_PW]").val(row.entity.ADMIN_PW);
	 			$("#ent_frm input[name=PHONE]").val(row.entity.PHONE);
	 			$("#ent_frm input[name=EMAIL]").val(row.entity.EMAIL);
	 			$("#ent_frm input[name=WORKER]").val(row.entity.WORKER);
	 			$("#ent_frm input[name=WORKER_NAME]").val(row.entity.WORKER_NAME);
	 			$("#ent_frm input[name=REG_DATE]").val(row.entity.REG_DATE);
	 			$("#ent_frm input[name=UPD_DATE]").val(row.entity.UPD_DATE);
	 			$("#ent_frm input[name=VENDOR_CODE]").val(row.entity.VENDOR_CODE);
	 			$("#ent_frm input[name=ENTERPRISE_GUBUN]").val(row.entity.ENTERPRISE_GUBUN);
	 			$("#ent_frm input[name=REPRESENTATIVE]").val(row.entity.REPRESENTATIVE);
			}
			
			$("#ent_frm input[name=TYPE]").val(type);
			$("#ent_frm input[name=_csrf]").val('${_csrf.token}');
			
			window.open("","ENT_POP","scrollbars=yes,width=800,height=425");
			document.ent_frm.target = "ENT_POP";
			document.ent_frm.action = "/yp/popup/zwc/ent/entDetail";
			
			$("#ent_frm").submit();
		}
	</script>
	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
</body>