<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
SimpleDateFormat date = new SimpleDateFormat("yyyy");
int to_yyyy = Integer.parseInt(date.format(today));
// JSTL에서 사용할 수 있도록 세팅
request.setAttribute("to_yyyy", to_yyyy);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>소급비 집계표
</title>
<script type="text/javascript">
	var scope;
	$(document).ready(function() {
		
		// 부트스트랩 날짜객체
		$(".dtp").datepicker({
			format : "yyyy/mm",
			language : "ko",
			viewMode: "months", 
			minViewMode: "months",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		});
		
		$('input').on('keydown', function(event) {
			if(event.keyCode==13) 
				return false;
		});
		

	});
	
</script>
</head>
<body>
	<h2>
		소급비 집계표
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
	<form id="frm" name="frm">
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="excel_flag" />
		<input type="hidden" name="page" id="page" value="${req_data.paginationInfo.currentPageNo}" />
		<input type="hidden" name="page_rows" value="" />
		<input type="hidden" name="user_dept" id="user_dept" value="${req_data.user_dept}"/>
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
						<th>검수연도</th>
						<td>
							<input type="text" id="CHECK_YYYY" name="CHECK_YYYY" class="calendar search_dtp_y" value="${to_yyyy}" readonly="readonly"/>
						</td>
						<th></th>
						<td><input id="storage_chk_box" name="storage_chk_box" type="checkbox" style="cursor:pointer;"/><label for="storage_chk_box" style="cursor:pointer;">&nbsp;&nbsp;저장품</label></td>
						<th></th>
						<td></td>
					</tr>
				</table>
				<div class="btn_wrap">
					<input type="button" class="btn btn_make" id="excel_btn" value="엑셀 다운로드"/>
					<button class="btn btn_search" id="search_btn">조회</button>
				</div>
			</div>
		</section>
	</form>
	<div class="float_wrap">
		<div class="fl">
		</div>
		<div class="fr" style="margin-bottom:5px;">
			<div class="btn_wrap">
				<input type="button" class="btn_g" id="electronic_payment_btn"  value="전자결재"/>
				<input type="button" class="btn_g" id="subcontracting_cost_btn"  value="소급비청구서"/>
				<input type="button" class="btn_g" id="chit_btn"  value="전표생성"/>
				<input type="button" class="btn_g" id="remove_btn" value="전표삭제" >
			</div>
		</div>
	</div>
	<section class="section">
		
			<div data-ui-i18n="ko" style="height: 620px;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		
		<!-- 복붙영역(html) 끝 -->
	</section>
	</div>
	<script>
		var columnDefs1;
		var columnDefs2;
		var isGubun = 1; //0:저장품, 1:그외
		
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

			
			// formater - String yyyyMM -> String yyyy.MM
			$scope.formatter_yyyymm = function(str_date) {
				return str_date.substring(0,4)+"/"+str_date.substring(4,6)
			};
			
			// formater - 천단위 콤마
			$scope.formatter_decimal = function(str_date) {
				if (!isNaN(Number(str_date))) {
					return Number(str_date).toLocaleString()
				} else {
					return str_date;
				}
			};
			
			// 상세조회
			$scope.rowClick = function(data) {
				var row = data.entity;

				var BELNR = fnPreAddZero(row.SLIP_NUMBER);
				var BUDAT = row.BUDAT;

				var w = window.open("about:blank", "회계전표", "width=1200,height=900,location=yes,scrollbars=yes");

				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					url : "/yp/zfi/doc/select_rtrv_doc",
					type : "post",
					cache : false,
					async : true,
					data : {
						BELNR : BELNR,
						BUDAT : BUDAT
					},
					dataType : "json",
					success : function(result) {
						var gw_url = '<spring:eval expression="@config['gw.url']"/>';	//그룹웨어 URL
						if (result.docno == "") {
							w.location.href = gw_url + "/ekp/view/info/infoAccSpec?bukrs=" + result.bukrs + "&belnr=" + BELNR + "&gjahr=" + result.gjahr + "&docNo=2018년 본사/전산팀 지출품의 제 xxxxx호";
						} else {
							w.location.href = gw_url + "/ekp/view/info/infoAccSpec?bukrs=" + result.bukrs + "&belnr=" + BELNR + "&gjahr=" + result.gjahr + "&docNo=" + result.docno;
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
					error : function(xhr, statusText) {
						console.error("code:" + xhr.status + " - " + "message:" + xhr.statusText, xhr);
						swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
					}
				});
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
			
			$scope.formatter_bg_color = function(data) {
				var rgb;
				switch(data){
					case "0" :
						rgb = "#ff5e00";
						break;
					case "4" :
						rgb = "#ff5e00";
						break;
					case "5" :
						rgb = "#ff0000";
						break;
					case "7" :
						rgb = "#ff0000";
						break;
					case "F" :
						rgb = "#abf200";
						break;
					case "S" :
						rgb = "#abf200";
						break;
					default :
						rgb = "";
				}
				return rgb;
			};
			
			//cellClass
			$scope.cellClassSet = function(grid, row, col, rowRenderIndex, colRenderIndex){
				var className = "";
				switch(col.field){
					
				}

				return className;
			}

			
			columnDefs1 = [
				{
					displayName : '검수년도',
					field : 'CHECK_YYYY',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				},
				{
					displayName : '코드(업체)',
					field : 'VENDOR_CODE',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, 
				{
					displayName : '구분코드',
					field : 'GUBUN_CODE',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, 
				{
					displayName : '업체명',
					field : 'VENDOR_NAME',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;">{{row.entity.VENDOR_NAME}}</div>'
				}, 
				{
					displayName : '대표자',
					field : 'REPRESENTATIVE',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;">{{row.entity.REPRESENTATIVE}}</div>'
				},
				{
					displayName : '협력업체',
					field : 'AMOUNT1',
					width : "120",
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.AMOUNT1)}}</div>'
				},
				{
					displayName : '물량관리',
					field : 'AMOUNT2',
					width : "120",
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.AMOUNT2)}}</div>'
				},
				{
					displayName : '소계',
					field : 'SUB_TOTAL',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.SUB_TOTAL)}}</div>'
				},
				{
					displayName : '부가세',
					field : 'VAT',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.VAT)}}</div>'
				},
				{
					displayName : '합계',
					field : 'TOTAL',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.TOTAL)}}</div>'
				},
				{
					displayName : '현재월도급비',
					field : 'CURRENTLY_SUBCONTRACTING_COST',
					visible : false,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.CURRENTLY_SUBCONTRACTING_COST)}}</div>'
				},
				{
					displayName : '전년월도급비',
					field : 'LAST_YEAR_SUBCONTRACTING_COST',
					visible : false,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.LAST_YEAR_SUBCONTRACTING_COST)}}</div>'
				},{
					displayName : '적립금',
					field : 'SAVE_MONEY_AMOUNT',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.SAVE_MONEY_AMOUNT)}}</div>'
				},{
					displayName : '정산액',
					field : 'RETROACT_AMOUNT',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.RETROACT_AMOUNT)}}</div>'
				},{
					displayName : '차액',
					field : 'DIFF_AMOUNT',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.DIFF_AMOUNT)}}</div>'
				},{
					displayName : '기지급액',
					field : 'PRE_RETROACT_AMOUNT',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.PRE_RETROACT_AMOUNT)}}</div>'
				},{
					displayName : '전표번호',
					field : 'SLIP_NUMBER',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-click="grid.appScope.rowClick(row)" style="cursor: pointer; text-decoration: underline;">{{row.entity.SLIP_NUMBER}}</div>'
				},
				{
					displayName : '전자결재',
					field : 'STATUS',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				},
				{
					displayName : '전자결재',
					field : 'STATUS_TXT',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="background-color: {{grid.appScope.formatter_bg_color(row.entity.STATUS)}}">{{row.entity.STATUS_TXT}}&nbsp;</div>'
				},
				{
					displayName : '전기일',
					field : 'BUDAT',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
				}
			];
			
			columnDefs2 = [
				{
					displayName : '검수년도',
					field : 'CHECK_YYYY',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				},
				{
					displayName : '코드(업체)',
					field : 'VENDOR_CODE',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, 
				{
					displayName : '구분코드',
					field : 'GUBUN_CODE',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, 
				{
					displayName : '업체명',
					field : 'VENDOR_NAME',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;">{{row.entity.VENDOR_NAME}}</div>'
				}, 
				{
					displayName : '대표자',
					field : 'REPRESENTATIVE',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;">{{row.entity.REPRESENTATIVE}}</div>'
				},
				{
					displayName : '소계',
					field : 'SUB_TOTAL',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.SUB_TOTAL)}}</div>'
				},
				{
					displayName : '부가세',
					field : 'VAT',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.VAT)}}</div>'
				},
				{
					displayName : '합계',
					field : 'TOTAL',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.TOTAL)}}</div>'
				},
				{
					displayName : '현재월도급비',
					field : 'CURRENTLY_SUBCONTRACTING_COST',
					visible : false,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.CURRENTLY_SUBCONTRACTING_COST)}}</div>'
				},
				{
					displayName : '전년월도급비',
					field : 'LAST_YEAR_SUBCONTRACTING_COST',
					visible : false,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.LAST_YEAR_SUBCONTRACTING_COST)}}</div>'
				},{
					displayName : '적립금',
					field : 'SAVE_MONEY_AMOUNT',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.SAVE_MONEY_AMOUNT)}}</div>'
				},{
					displayName : '정산액',
					field : 'RETROACT_AMOUNT',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.RETROACT_AMOUNT)}}</div>'
				},{
					displayName : '차액',
					field : 'DIFF_AMOUNT',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.DIFF_AMOUNT)}}</div>'
				},{
					displayName : '기지급액',
					field : 'PRE_RETROACT_AMOUNT',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.PRE_RETROACT_AMOUNT)}}</div>'
				},{
					displayName : '전표번호',
					field : 'SLIP_NUMBER',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-click="grid.appScope.rowClick(row)" style="cursor: pointer; text-decoration: underline;">{{row.entity.SLIP_NUMBER}}</div>'
				},
				{
					displayName : '전자결재',
					field : 'STATUS',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor:pointer;"><span class="green" ng-if="row.entity.STATUS ==\'2\'">O</span></div>'
				},
				{
					displayName : '전기일',
					field : 'BUDAT',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
				}
			];
			
			
			$scope.openPopup = function(target){
				window.open("", "소급비집계 상세조회", "width=900, height=720");
				fnHrefPopup("/yp/popup/zwc/rst/zwc_rst_detail_list", "소급비집계 상세조회", {
					"CHECK_YYYY"  : target.CHECK_YYYY,
					"VENDOR_CODE" : target.VENDOR_CODE,
					"GUBUN_CODE"  : target.GUBUN_CODE,
					"VENDOR_NAME" : target.VENDOR_NAME
				}); 
			};
			
			
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
				columnDefs : columnDefs1,	//헤더 세팅
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
					EXEC_RFC  : "Y", 		// RFC 여부
					RFC_TYPE  : "ZWC_RST",	// RFC 타입
					RFC_FUNC  : "ZWEB_CHECK_DOCUMENT",	// RFC 펑션
					cntQuery  : "yp_zwc_rst.select_reto_cost_count_cnt", 	
					listQuery : "yp_zwc_rst.select_reto_cost_count"
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
			
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
				$('.datepicker').hide();
			});
			
			/****************************************엑셀 다운로드 공통 시작****************************************/		
			$("#excel_btn").click(function(e){
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
				xlsForm.action = "/yp/xls/zwc/rst/zwc_rst_summary_list";

				document.body.appendChild(xlsForm);

				xlsForm.appendChild(csrf_element);

				var pr = gPostArray($("#frm").serializeArray());

				$.each(pr, function(k, v) {
					//check_yyyymm 공백 제거하기
					var data = $("#frm").serializeArray();
					var el = document.createElement("input");
					el.name = k;
					el.value = v;
					el.type = "hidden";
					xlsForm.appendChild(el);
				});
				
				//저장품 파라미터 넘기기
				//저장품 체크시
				if(isGubun == 0){
					var el = document.createElement("input");
					el.name = "GUBUN_CODE";
					el.value = "0";
					el.type = "hidden";
					xlsForm.appendChild(el);
				//저장품 해제시
				}else{
					var el = document.createElement("input");
					el.name = "GUBUN_CODE";
					el.value = "1";
					el.type = "hidden";
					xlsForm.appendChild(el);
				}

				xlsForm.submit();
				xlsForm.remove();
				$('.wrap-loading').removeClass('display-none');
				setTimeout(function() {
					$('.wrap-loading').addClass('display-none');
				}, 5000); //5초
			});
			/****************************************엑셀 다운로드 공통  끝  ****************************************/

			// 조회
			$("#search_btn").on("click", function() {
				//check_yyyymm 공백 제거하기
				var data = $("#frm").serializeArray();
				//컬럼 바꾸기
				//저장품 체크시
				if(isGubun == 0){
					scope.gridOptions.columnDefs = columnDefs2;
					data.push({"name" : "GUBUN_CODE" , "value" : "0"});
				//저장품 해제시
				}else{
					scope.gridOptions.columnDefs = columnDefs1;
					data.push({"name" : "GUBUN_CODE" , "value" : "1"});
				}
				scope.reloadGrid(
					gPostArray(data)	//폼을 그리드 파라메터로 전송
				);	
			});
			
			//저장품 체크박스 클릭
			$("#storage_chk_box").change(function(){
				//체크했을때
				if($("#storage_chk_box").is(":checked")){
					//저장품
					isGubun = 0;
				//체크해제 했을때
				}else{
					//저장품 그외
					isGubun = 1;
				}
			});
			
			// 전자결재
			$("#electronic_payment_btn").on("click", function() {
				if($("#CHECK_YYYY").val() === ""){
					swalInfoCB("검수년도 정보가 없습니다.");
					return false;
				}else{
					// 2020-11-09 jamerl - 조용래 : 대상 조회조건의 데이터(도급월보)가 모두 결재여부 확인.
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zwc/ipt/zwc_rst_summary_list_check",
						type : "POST",
						cache : false,
						async : false,
						dataType : "json",
						data : {
							CHECK_YYYY : $("#CHECK_YYYY").val().trim(),
							GUBUN_CODE : isGubun === 0 ? "0" : "1"
						},
						success : function(data) {
							console.log("전자결재 가능여부", data.result);
							// 2020-11-13 jamerl - 조용래 : 체크로직 구현 후 전자결재 테스트 할 수 있도록 무조건 전자결재 할 수 있게 처리
// 							data.result = "Y";
							if(data.result === 'N2'){
								swalWarningCB("대상 소급비집계가 없습니다.");
							}else if(data.result === 'Y'){
								var w = window.open("about:blank", "소급비 집계표", "width=1200,height=900,location=yes,scrollbars=yes");
								w.location.href = "http://ypgw.ypzinc.co.kr/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=EF160393533676302" + 
										"&CHECK_YYYY=" + $("#CHECK_YYYY").val().trim() + 
										"&GUBUN_CODE=" + ($("#storage_chk_box").is(":checked") ? "0" : "1") + 
										"&PKSTR=" + $("#CHECK_YYYY").val().trim() + ";" + ($("#storage_chk_box").is(":checked") ? "0" : "1");
							}else{
								swalWarningCB("소급비집계 전자결재가 완료되지 않았습니다.");
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
				}
			});
			
			// 소급비청구서
			$("#subcontracting_cost_btn").on("click", function() {
				var rows = scope.gridApi.selection.getSelectedRows();
				if(rows.length === 0){
					swalWarningCB("소급비청구서 항목을 선택하세요.");
					return false;
				}
				if(rows.length > 1){
					swalWarningCB("소급비청구서 항목은 한 건씩 선택하세요.");
					return false;
				}
				window.open("", "소급비청구서", "width=1300, height=720");
				fnHrefPopup("/yp/popup/zwc/rst/zwc_rst_bill", "소급비청구서", {
					"BASE_YYYY"  : $("#CHECK_YYYY").val().trim(),
					"VENDOR_CODE" : rows[0].VENDOR_CODE,
					"VENDOR_NAME" : rows[0].VENDOR_NAME
				}); 
			});
			
			// 전표생성
			$("#chit_btn").on("click", function() {
				var rows = scope.gridApi.selection.getSelectedRows();
				if(rows.length === 0){
					swalWarningCB("전표생성할 항목을 선택하세요.");
					return false;
				}
				if(rows.length > 1){
					swalWarningCB("전표생성할 항목은 한 건씩 선택하세요.");
					return false;
				}
				if(rows[0].SLIP_NUMBER != null){
					swalWarningCB("이미 전표생성 완료된 항목입니다.");
					return false;
				}
				
				window.open("", "전표생성", "width=750, height=400");
				var HKONT;
				if(isGubun == 0) HKONT = "43307115"; else HKONT = "43204101";	//0:저장품, 저장품 외
				fnHrefPopup("/yp/popup/zwc/rst/zwc_rst_doc_create", "전표생성", {
					"CHECK_YYYY"  : $("#CHECK_YYYY").val(),
					"VENDOR_CODE" : rows[0].VENDOR_CODE,
					"VENDOR_NAME" : rows[0].VENDOR_NAME,
					"SAP_CODE" : rows[0].SAP_CODE,
					"HKONT" : HKONT,
					"GUBUN_CODE_AGGREGATION" : rows[0].GUBUN_CODE,
					"TOTAL" : rows[0].TOTAL,
					"VAT"   : rows[0].VAT,
					"SUB_TOTAL" : rows[0].SUB_TOTAL
				}); 
			});
			
			// 선택삭제
			$("#remove_btn").on("click", function() {
				var selectedRows = scope.gridApi.selection.getSelectedRows();
				if (!isEmpty(selectedRows)) {
					if(selectedRows.length > 1){
						swalWarning("전표삭제는 1건씩만 가능합니다.\n1건만 선택 후 삭제해 주세요.");
						return false;
					}else if(selectedRows[0].SLIP_NUMBER == "" || selectedRows[0].SLIP_NUMBER == null){
						swalWarning("삭제할 전표가 없습니다.");
						return false;	
					}else{
						var row = selectedRows[0];
						swal({
							icon : "info",
							text : "전표를 삭제하시겠습니까?",
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
							if (result) {
								var token = $("meta[name='_csrf']").attr("content");
								var header = $("meta[name='_csrf_header']").attr("content");
								$.ajax({
									url : "/yp/zfi/doc/remove_rtrv_doc",
									type : "POST",
									cache : false,
									async : true,
									data : {
										IBELNR : row.SLIP_NUMBER,			//전표번호
										IGJAHR : row.BUDAT.substring(0,4),	//전기일_yyyy
									},
									dataType : "json",
									success : function(result) {
										swalSuccessCB(result.msg, function() {
											$("#search_btn").trigger("click");
										});

									},
									beforeSend : function(xhr) {
										// 2019-10-23 khj - for csrf
										xhr.setRequestHeader(header, token);
										$('.wrap-loading').removeClass('display-none');
									},
									complete : function() {
										$('.wrap-loading').addClass('display-none');
									},
									error : function(xhr, statusText) {
										console.error("code:" + xhr.status + " - " + "message:" + xhr.statusText, xhr);
										swalDangerCB("삭제중 오류가 발생였습니다.\n관리자에게 문의해주세요.");
									}
								});
							}
						});
						
					}	
					
				} else {
					swalWarningCB("전표를 선택해 주세요.");
				}
			});
		});
		
		function fnHrefPopup(url, target, pr) {
			//20191023_khj for csrf
			var csrf_element = document.createElement("input");
			csrf_element.name = "_csrf";
			csrf_element.value = "${_csrf.token}";
			csrf_element.type = "hidden";
			//20191023_khj for csrf
			var popForm = document.createElement("form");

			popForm.name = "popForm";
			popForm.method = "post";
			popForm.target = target;
			popForm.action = url;

			document.body.appendChild(popForm);

			popForm.appendChild(csrf_element);

			$.each(pr, function(k, v) {
				console.log(k, v);
				var el = document.createElement("input");
				el.name = k;
				el.value = v;
				el.type = "hidden";
				popForm.appendChild(el);
			});

			popForm.submit();
			popForm.remove();
		}
		
		function formatDate_y(date) {
			var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
			if (month.length < 2)
				month = '0' + month;
			if (day.length < 2)
				day = '0' + day;
			return [ year ].join('/');
		}
		
		function fnPreAddZero(num) {
			num = num + "";
			var length = num.length;
			for (var i = 10; i > length; i--) {
				num = "0" + num;
			}
			return num;
		}
	</script>
	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
</body>