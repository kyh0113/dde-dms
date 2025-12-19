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
SimpleDateFormat date = new SimpleDateFormat("yyyy/MM");
String toDay = date.format(today);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>도급비 집계표
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
		}).on('changeDate', function(e) {
			if(e.viewMode !== "months"){
				return false;
			}
			$(this).val(formatDate_m(e.date.valueOf())).trigger("change");
//				$("#search_btn").trigger("click");
			$('.datepicker').hide();
		});
		
		//조회조건 default
		//오늘날짜 세팅
		if($("input[name=check_yyyymm]").val() == ""){
			$("input[name=check_yyyymm]").val("<%=toDay%>");	
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
		도급비 집계표
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
						<th>검수년월</th>
						<td>
							<input type="text" class="calendar dtp" name="check_yyyymm" id="sdate" size="10" value="${req_data.date}" readonly="readonly"/>
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
				<input type="button" class="btn_g" id="create_btn"  value="집계처리"/>
				<span id="STATUS_VIEW" style="display: none; border: 1px solid #626262; padding: 1px 10px 2PX; font-size: 12px; vertical-align: middle; color: #000;"></span>
				<input type="button" class="btn_g" id="electronic_payment_btn"  value="전자결재"/>
				<c:if test="${'MA' eq sessionScope.s_authogrp_code || 'CA' eq sessionScope.s_authogrp_code}">
				<input type="button" class="btn_g" id="fnReset"	value="전자결재 초기화">
				</c:if>
				<input type="button" class="btn_g" id="subcontracting_cost_btn"  value="도급비청구서"/>
				<input type="button" class="btn_g" id="chit_btn"  value="전표생성"/>
				<input type="button" class="btn_g" id="remove_btn" value="전표삭제" >
			</div>
		</div>
	</div>
	<section class="section">
		
			<div data-ui-i18n="ko" style="height: 615px;">
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
			
			//사업자등록증 보기
			$scope.viewImg = function(row) {
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					url : "/yp/zwc/ipt2/select_zwc_ipt2_contract_bill_upload",
					type : "POST",
					cache : false,
					async : false,
					dataType : "json",
					data : {
						BASE_YYYY: row.entity.CHECK_YYYYMM,
						VENDOR_CODE: row.entity.VENDOR_CODE,
						GUBUN_CODE_AGGREGATION: row.entity.GUBUN_CODE
					},
// 					data : {
// 						BASE_YYYY: rows[0].BASE_YYYY,
// 						VENDOR_CODE: rows[0].VENDOR_CODE,
// 						GUBUN_CODE_AGGREGATION: rows[0].GUBUN_CODE_AGGREGATION
// 					},
					success : function(data) {
						if(data.result.CNT === 0){
							swalWarningCB("도급비집계 데이터가 존재하지 않습니다.");
							return false;
						}else if(data.result.ATTACH_YN === "N"){
							swalWarningCB("업로드된 도급비청구서가 존재하지 않습니다.");
							return false;
						}else{
							window.open("/yp/popup/imgPopup?url="+encodeURIComponent(data.result.ATTACH_URL),"imgPop","width=580,height=780");
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

			
			columnDefs1 = [
				{
					displayName : '검수년월',
					field : 'CHECK_YYYYMM',
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
					cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{row.entity.VENDOR_NAME}}</div>'
				}, 
				{
					displayName : '대표자',
					field : 'REPRESENTATIVE',
					width : "85",
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{row.entity.REPRESENTATIVE}}</div>'
				},
				{
					displayName : '당월협력업체',
					field : 'AMOUNT1',
					width : "120",
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.AMOUNT1)}}</div>'
				},
				{
					displayName : '당월물량관리',
					field : 'AMOUNT2',
					width : "120",
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.AMOUNT2)}}</div>'
				},
				{
					displayName : '소계',
					field : 'SUB_TOTAL',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.SUB_TOTAL)}}</div>'
				},
				{
					displayName : '부가세',
					field : 'VAT',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.VAT)}}</div>'
				},
				{
					displayName : '합계',
					field : 'TOTAL',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.TOTAL)}}</div>'
				},
				{
					displayName : '적립금',
					field : 'SAVE_MONEY_AMOUNT',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.SAVE_MONEY_AMOUNT)}}</div>'
				},
				{
					displayName : '지급액',
					field : 'PAY_AMOUNT',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.PAY_AMOUNT)}}</div>'
				},
				{
					displayName : '전월도급비',
					field : 'LAST_MONTH_SUBCONTRACTING_COST',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.LAST_MONTH_SUBCONTRACTING_COST)}}</div>'
				},
				{
					displayName : '증감',
					field : 'VARIATION',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.VARIATION)}}</div>'
				},
				{
					displayName : '투입인원(명)',
					field : 'MAN_MONTH',
					width : "115",
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{row.entity.MAN_MONTH}}</div>'
				},
				{
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
					width : "95",
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				},
				{
					displayName : '전자결재',
					field : 'STATUS_TXT',
					width : "95",
					visible : false,
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
				}, {
					displayName : '보기',
					field : '_',
					width : '95',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents btn_g" style="cursor: pointer;" ng-click="grid.appScope.viewImg(row)">보기</div>'
				}
			  ];
			
			columnDefs2 = [
				{
					displayName : '검수년월',
					field : 'CHECK_YYYYMM',
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
					cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{row.entity.VENDOR_NAME}}</div>'
				}, 
				{
					displayName : '대표자',
					field : 'REPRESENTATIVE',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{row.entity.REPRESENTATIVE}}</div>'
				},
				{
					displayName : '저장품',
					field : 'AMOUNT3',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.AMOUNT3)}}</div>'
				},
				{
					displayName : '소계',
					field : 'SUB_TOTAL',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.SUB_TOTAL)}}</div>'
				},
				{
					displayName : '부가세',
					field : 'VAT',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.VAT)}}</div>'
				},
				{
					displayName : '합계',
					field : 'TOTAL',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.TOTAL)}}</div>'
				},
				{
					displayName : '적립금',
					field : 'SAVE_MONEY_AMOUNT',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.SAVE_MONEY_AMOUNT)}}</div>'
				},
				{
					displayName : '지급액',
					field : 'PAY_AMOUNT',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.PAY_AMOUNT)}}</div>'
				},
				{
					displayName : '전월도급비',
					field : 'LAST_MONTH_SUBCONTRACTING_COST',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.LAST_MONTH_SUBCONTRACTING_COST)}}</div>'
				},
				{
					displayName : '증감',
					field : 'VARIATION',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{grid.appScope.formatter_decimal(row.entity.VARIATION)}}</div>'
				},
				{
					displayName : '투입인원(명)',
					field : 'MAN_MONTH',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-dblclick="grid.appScope.openPopup(row.entity)" style="cursor:pointer;">{{row.entity.MAN_MONTH}}</div>'
				},
				{
					displayName : '전표번호',
					field : 'SLIP_NUMBER',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-click="grid.appScope.rowClick(row)" style="cursor: pointer; text-decoration: underline;">{{row.entity.SLIP_NUMBER}}</div>'
				}, {
					displayName : '전자결재',
					field : 'STATUS',
					width : '95',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '전자결재',
					field : 'STATUS_TXT',
					width : '95',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="background-color: {{grid.appScope.formatter_bg_color(row.entity.STATUS)}}">{{row.entity.STATUS_TXT}}&nbsp;</div>'
				}, {
					displayName : '전기일',
					field : 'BUDAT',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
				}, {
					displayName : '보기',
					field : '_',
					width : '95',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents btn_g" style="cursor: pointer;" ng-click="grid.appScope.viewImg(row)">보기</div>'
				}
			  ];
			
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
			
			$scope.openPopup = function(target){
				window.open("", "도급비집계 상세조회", "width=1300, height=720");
				fnHrefPopup("/yp/popup/zwc/ipt/zwc_ipt_detail_list", "도급비집계 상세조회", {
					"BASE_YYYYMM"  : target.CHECK_YYYYMM,
					"CHECK_YYYYMM" : target.CHECK_YYYYMM,
					"VENDOR_CODE"  : target.VENDOR_CODE,
					"GUBUN_CODE"   : target.GUBUN_CODE,
					"VENDOR_NAME"  : target.VENDOR_NAME
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
					RFC_TYPE  : "ZWC_IPT",	// RFC 타입
					RFC_FUNC  : "ZWEB_CHECK_DOCUMENT",	// RFC 펑션
					cntQuery  : "yp_zwc_ipt.select_subc_cost_count_cnt", 	
					listQuery : "yp_zwc_ipt.select_subc_cost_count"
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
			
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
				xlsForm.action = "/yp/xls/zwc/ipt/zwc_ipt_sum_list";

				document.body.appendChild(xlsForm);

				xlsForm.appendChild(csrf_element);

				var pr = gPostArray($("#frm").serializeArray());

				$.each(pr, function(k, v) {
					//check_yyyymm 공백 제거하기
					var data = $("#frm").serializeArray();
					if(k == "check_yyyymm"){
						v = v.replace(/ /gi, "");// 모든 공백을 제거
					}
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
			
			// 집계처리
			$("#create_btn").on("click", function() {
				swal({
					icon : "warning",
					text : "집계처리를 하시겠습니까?\n※ 재집계시 기존데이터는 초기화됩니다.",
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
						$.ajax({
							url : "/yp/zwc/ipt/zwc_ipt_sum_create_exec",
							type : "POST",
							cache : false,
							async : true,
							dataType : "json",
							data : {
								BASE_YYYYMM : $("#sdate").val().replace("/", ""),
								_csrf : '${_csrf.token}'
							},
							success : function(result) {
								if (result.result > 0) {
									swalSuccess("집계처리 완료되었습니다.");
								} else {
									swalDanger("집계처리 실패하였습니다.\n관리자에게 문의해주세요.");
								}
								$('.wrap-loading').addClass('display-none');
							},
							beforeSend : function() {
								$('.wrap-loading').removeClass('display-none');
							},
							complete : function() {
								$('.wrap-loading').addClass('display-none');
							},
							error : function(request, status, error) {
								console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
								swalDanger("집걔처리 실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
					}
				});
			});
			
			// 조회
			$("#search_btn").on("click", function() {
				//check_yyyymm 공백 제거하기
				var data = $("#frm").serializeArray();
				for(var i=0; i<data.length; i++){
					if(data[i]["name"] == "check_yyyymm"){
// 						data[i]["value"] = data[i]["value"].replace(/ /gi, "");// 모든 공백을 제거
						data[i]["value"] = data[i]["value"].replace("/", "");
						break;
					}
				}
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
					gPostArray(data),	//폼을 그리드 파라메터로 전송
					function(uigrid_data){ // uigrid_data <-- 조회된 데이터(JSON)
					console.log("그리드 수신 데이터 확인", uigrid_data);
					// 2020-11-23 jamerl - 조용래 : 부서가 선택된 상태로 조회된 그리드의 첫 행의 결과에 따라 결재상태를 표시
					if(uigrid_data.length > 0){
						var t = uigrid_data[0].STATUS;
						var v = uigrid_data[0].STATUS_TXT;
						var rgb;
						if(t === null || t === ""){
							$("#STATUS_VIEW").hide();
							return true;
						}
						switch(t){
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
						$("#STATUS_VIEW").text(v)
										 .css("background-color", rgb)
										 .show();
					}else{
						$("#STATUS_VIEW").hide();
					}
				});
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
			
			// 전재결재 초기화
			$("#fnReset").on("click", function() {
				if($("#sdate").val() === ""){
					swalInfoCB("전자결재 초기화 대상 검수년월 정보가 없습니다.");
					return false;
				}else{
					// 2020-11-09 jamerl - 조용래 : 대상 조회조건의 데이터(도급월보)가 모두 결재여부 확인.
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zwc/ipt/zwc_ipt_sum_list_status_reset",
						type : "POST",
						cache : false,
						async : false,
						dataType : "json",
						data : {
							CHECK_YYYYMM : $("#sdate").val().replace("/", ""),
							GUBUN_CODE : isGubun === 0 ? "0" : "1"
						},
						success : function(data) {
							swalInfoCB("전자결재 초기화 되었습니다.", function(){
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
						error : function(request, status, error) {
							console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
							swalDangerCB("전자결재 초기화 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
				}
			});
			
			// 전자결재
			$("#electronic_payment_btn").on("click", function() {
				if($("#sdate").val() === ""){
					swalInfoCB("검수년월 정보가 없습니다.");
					return false;
				}else{
					// 2020-11-09 jamerl - 조용래 : 대상 조회조건의 데이터(도급월보)가 모두 결재여부 확인.
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zwc/ipt/zwc_ipt_sum_list_check_a",
						type : "POST",
						cache : false,
						async : false,
						dataType : "json",
						data : {
							CHECK_YYYYMM : $("#sdate").val().replace("/", ""),
							GUBUN_CODE : isGubun === 0 ? "0" : "1"
						},
						success : function(data) {
							console.log("전자결재 가능여부", data.result);
							// 2020-11-13 jamerl - 조용래 : 체크로직 구현 후 전자결재 테스트 할 수 있도록 무조건 전자결재 할 수 있게 처리
// 							data.result = "Y";
							if(data.result === 'N2'){
								swalWarningCB("대상 도급월보가 없습니다.");
							}else if(data.result === 'Y'){
								$.ajax({
									url : "/yp/zwc/ipt/zwc_ipt_sum_list_check_b",
									type : "POST",
									cache : false,
									async : false,
									dataType : "json",
									data : {
										CHECK_YYYYMM : $("#sdate").val(),
										GUBUN_CODE : isGubun === 0 ? "0" : "1"
									},
									success : function(data) {
										console.log("전자결재 가능여부", data.result);
										// 2020-11-13 jamerl - 조용래 : 체크로직 구현 후 전자결재 테스트 할 수 있도록 무조건 전자결재 할 수 있게 처리
// 										data.result = "Y";
										if(data.result === 'N2'){
											swalWarningCB("대상 도급비집계가 없습니다.");
										}else if(data.result === 'Y'){
											var w = window.open("about:blank", "도급비 집계표", "width=1200,height=900,location=yes,scrollbars=yes");
											w.location.href = "http://ypgw.ypzinc.co.kr/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=EF160393526682558" + 
													"&CHECK_YYYYMM=" + $("#sdate").val().replace("/", "").trim() + 
													"&GUBUN_CODE=" + ($("#storage_chk_box").is(":checked") ? "0" : "1") + 
													"&PKSTR=" + $("#sdate").val().replace("/", "").trim() + ";" + ($("#storage_chk_box").is(":checked") ? "0" : "1");
										}else{
											swalWarningCB("도급비집계 전자결재가 진행중이거나 완료되었습니다.");
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
							}else{
								swalWarningCB("도급월보 전자결재가 완료되지 않았습니다.");
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
			
			// 도급비청구서
			$("#subcontracting_cost_btn").on("click", function() {
				var rows = scope.gridApi.selection.getSelectedRows();
				if(rows.length === 0){
					swalWarningCB("도급비청구서 항목을 선택하세요.");
					return false;
				}
				if(rows.length > 1){
					swalWarningCB("도급비청구서 항목은 한 건씩 선택하세요.");
					return false;
				}
				window.open("", "도급비청구서", "width=1300, height=720");
				fnHrefPopup("/yp/popup/zwc/ipt/zwc_ipt_contract_bill", "도급비청구서", {
					"BASE_YYYY"  : $("#sdate").val(),
					"VENDOR_CODE" : rows[0].VENDOR_CODE,
					"VENDOR_NAME" : rows[0].VENDOR_NAME,
					"GUBUN_CODE_AGGREGATION" : rows[0].GUBUN_CODE
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
				fnHrefPopup("/yp/popup/zwc/ipt/zwc_ipt_doc_create", "전표생성", {
					"BASE_YYYY"  : $("#sdate").val(),
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
				//console.log(k, v);
				var el = document.createElement("input");
				el.name = k;
				el.value = v;
				el.type = "hidden";
				popForm.appendChild(el);
			});

			popForm.submit();
			popForm.remove();
		}
		function formatDate_m(date) {
			var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
			if (month.length < 2)
				month = '0' + month;
			if (day.length < 2)
				day = '0' + day;
			return [ year, month ].join('/');
		}
		function fnValidation(){
			if($("input[name=date]").val() == ''){
				swalWarning("신청일자를 입력해 주세요.");
				return false;
			} 
			return true;
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