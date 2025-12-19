<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<style>
#typical-uiGrid .ui-grid-viewport
{
   overflow-y: hidden !important;
}
#invoice-uiGrid .ui-grid-viewport
{
   overflow-y: hidden !important;
}
</style>
<title>입항스케줄 조회</title>
<script type="text/javascript">
	$(document).ready(function() {
		
		//LME 데이터 조회
		fnSearchData();
		
		//Assay Header 세팅
		fnAssayHeader();
		
		// 부트스트랩 날짜객체
		$(".dtp").datepicker({
			format : "yyyy/mm/dd",
			language : "ko",
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
		입항스케줄 조회
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
	<form id="frm" name="frm">
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="page" id="page" value="${paginationInfo.currentPageNo}" />
		<input type="hidden" name="page_rows" value="" />
		<input type="hidden" name="add_rows" value="0" />
		<input type="hidden" id="search_flag" value="${search_flag}"/>
		
		<section>
            <div class="stitle">LME</div>
<%--        <fmt:parseDate var="LME_DATE" value="${toDay}" pattern="yyyyMMdd"/> --%>
<%-- 	    <input type="text" name="lme_date" id="lme_date" class="dtp calendar" value="<fmt:formatDate value="${LME_DATE}" pattern="yyyy/MM/dd"/>"> --%>
			<input type="text" name="lme_date" id="lme_date" class="dtp calendar" value="<%=toDay%>">
            <input type="button" id="lme_search_btn" class="btn btn_search" value="조회">
            <input type="button" id="lme_save_btn" class="btn btn_save" value="저장">
            <div class="space10"></div>
            <div class="lst">
                <table id="lme_table" cellspacing="0" cellpadding="0" style="width:500px;">
                    <colgroup>
                        <col />
                        <col />
                        <col />
                        <col />
                    </colgroup>
                    <thead>
	                    <tr>
	                        <th colspan="2" class="center">종류</th>
	                        <th class="center">이번달(avg)</th>
	                        <th class="center">지난달(avg)</th>
	                    </tr>
                    </thead>
                    <tbody>
	                    <tr>
	                        <td>ZN</td>
	                        <td class="left">
	                        	<label>$</label>&nbsp;&nbsp;
	                        	<input type="text" style="width:100px;" name="lme_zn">
	                        </td>
	                        <td class="right" id="ZN_THIS"></td>
	                        <td class="right" id="ZN_LAST"></td>
	                    </tr>
	                     <tr>
	                        <td>Ag</td>
	                        <td class="left">
	                        	<label>$</label>&nbsp;&nbsp;
	                        	<input type="text" style="width:100px;" name="lme_ag">
	                        </td>
	                        <td class="right" id="AG_THIS"></td>
	                        <td class="right" id="AG_LAST"></td>
	                    </tr>
	                    <tr>
	                        <td>Cu</td>
	                        <td class="left">
	                        	<label>$</label>&nbsp;&nbsp;
	                        	<input type="text" style="width:100px;" name="lme_cu">
	                        </td>
	                        <td class="right" id="CU_THIS"></td>
	                        <td class="right" id="CU_LAST"></td>
	                    </tr>
	                   <tr>
	                        <td>Pb</td>
	                        <td class="left">
	                        	<label>$</label>&nbsp;&nbsp;
	                        	<input type="text" style="width:100px;" name="lme_pb">
	                        </td>
	                        <td class="right" id="PB_THIS"></td>
	                        <td class="right" id="PB_LAST"></td>
	                    </tr>
	                    <tr>
	                        <td>Au</td>
	                        <td class="left">
	                        	<label>$</label>&nbsp;&nbsp;
	                        	<input type="text" style="width:100px;" name="lme_au">
	                        </td>
	                        <td class="right" id="AU_THIS"></td>
	                        <td class="right" id="AU_LAST"></td>
	                    </tr>
	                    <tr>
	                        <td>SHG</td>
	                        <td class="left">
	                        	<label>￦</label>
	                        	<input type="text" style="width:100px;" name="lme_shg">
	                        </td>
	                        <td class="right" id="SHG_THIS"></td>
	                        <td class="right" id="SHG_LAST"></td>
	                    </tr>
	                   <tr>
	                        <td>HG</td>
	                        <td class="left">
	                        	<label>￦</label>
	                        	<input type="text" style="width:100px;" name="lme_hg">
	                        </td>
	                        <td class="right" id="HG_THIS"></td>
	                        <td class="right" id="HG_LAST"></td>
	                    </tr>
                    </tbody>
                </table>
            </div>
        </section>
		
		<section>
			<div class="fl">
				<div class="stitle">입항스케줄</div>
			</div>
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
						<th>BL입항일</th>
						<td>
							<input type="text"  class="calendar dtp" name="arrival_date" id="arrival_date" value="${req_data.current_month}"/> ~ 
							<input type="text"  class="calendar dtp" name="arrival_edate" id="arrival_edate" value="${req_data.next_month}"/>
						</td>
						<th>실제입항일</th>
						<td>
							<input type="text"  class="calendar dtp" name="ship_date" id="ship_date" value="${req_data.ship_date}"/> ~ 
							<input type="text"  class="calendar dtp" name="ship_edate" id="ship_edate" value="${req_data.ship_edate}"/>
						</td>
						<th>업체</th>
						<td>
							<input type="text" name="vendor_nm" id="vendor_nm" value="${req_data.vendor_nm}">
							<input type="hidden" name="vendor_cd" id="vendor_cd" value="${req_data.vendor_cd}">
							<a href="#" onclick="fnSearchPopup('2');"><img src="/resources/yp/images/ic_search.png"></a>
						</td>
					</tr>
					<tr>
						<th>광종</th>
						<td>
							<input type="text" name="item_nm" value="${req_data.item_nm}">
							<input type="hidden" name="item_cd" value="${req_data.item_cd}">
							<a href="#" onclick="fnSearchPopup('1');"><img src="/resources/yp/images/ic_search.png"></a>
						</td>
						<th>선사</th>
						<td>
							<input type="text" name="ship_vendor" value="${req_data.ship_vendor}">
						</td>
						<th>surveyor</th>
						<td>
							<input type="text" name="surveyor" value="${req_data.surveyor}">
						</td>
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
<!-- 	<div class="fl"> -->
<!-- 		<div class="stitle">입항스케줄</div> -->
<!-- 	</div> -->
		<div class="fr">
			<div class="btn_wrap">
				<span class="require">*표시는 등록/수정시 필수입력값 입니다.</span>&nbsp;&nbsp;
<!-- 				<input type="button" value="&nbsp;" class="btn_g" id="filter_btn" style="background-image: url(/resources/yp/images/btn_ic_search.png); background-position: 10% 50%; background-repeat: no-repeat; padding-left: 7px;"/> -->
				<input type="button" class="btn_g" id="add_btn"  value="등록 줄 추가"/>
				<input type="button" class="btn_g" id="reg_btn" value="등록 저장"/>
				<input type="button" class="btn_g" id="mod_btn"  value="선택 수정"/>
				<input type="button" class="btn_g" id="del_btn"  value="선택 삭제"/>
			</div>
		</div>
	</div>

	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="shdsCtrl" style="height: auto;">
			<div data-ui-i18n="ko" style="height: 400px;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav data-ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
	</section>
	<br>
	<div class="float_wrap">
		<div class="fl">
			<div class="stitle">Typical Assay</div>
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type="button" class="btn_g" id="typical_save_btn" value="저장"/>
			</div>
		</div>
	</div>

	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="typical-uiGrid" data-ng-controller="typicalCtrl">
			<div data-ui-i18n="ko" style="height: 74px;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav data-ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" style="font-size:20px;" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
	</section>
	<br>
	<div class="float_wrap">
		<div class="fl">
			<div class="stitle">Invoice Assay</div>
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type="button" class="btn_g" id="invoice_save_btn" value="저장"/>
			</div>
		</div>
	</div>

	<section class="section" style="margin-bottom:200px;">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="invoice-uiGrid" data-ng-controller="invoiceCtrl">
			<div data-ui-i18n="ko" style="height: 74px;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav data-ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" style="font-size:20px;" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
	</section>
	<br>
	<br>
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

			// formater - 천단위 콤마
			$scope.formatter_decimal = function(str_date) {
				if (!isNaN(Number(str_date))) {
					return Number(str_date).toLocaleString()
				} else {
					return str_date;
				}
			};
			
			// formater - String yyyyMM -> String yyyy.MM
			$scope.formatter_yyyymm = function(str_date) {
				return str_date.substring(0,4)+"/"+str_date.substring(4,6)
			};

			// 코드팝업
			$scope.fnSearchPopup = function(type, row) {
				var target = scope.gridOptions.data.indexOf(row.entity);
				fnSearchPopup(type, target);
			};
			
			//BL입항일 Fix 체크시 BL입항일 수정못하도록 처리
			$scope.checkboxClick = function(row,ev){
				if(row.entity.ARRIVAL_DATE_FIX == "Y"){
					$("#ARRIVAL_DATE_"+row.entity.RNUM).attr("readonly", false);
					$("#ARRIVAL_DATE_"+row.entity.RNUM).toggleClass("dtp2");
				}else{
					if(row.entity.ARRIVAL_DATE_FIX){
						$("#ARRIVAL_DATE_"+row.entity.RNUM).attr("readonly", true);
						$("#ARRIVAL_DATE_"+row.entity.RNUM).toggleClass("dtp2");
					}else{
						$("#ARRIVAL_DATE_"+row.entity.RNUM).attr("readonly", false);
						$("#ARRIVAL_DATE_"+row.entity.RNUM).toggleClass("dtp2");
					}
				}
				
								
			};
	
			//Cell Template1
			var cellTmp1_Reg_PO_NO            = '<input ng-if="row.entity.STATE==0" type="text" ng-model="row.entity.PO_NO">';
			var cellTmp1_New_PO_NO            = '<input ng-if="row.entity.STATE!=0" type="text" ng-model="row.entity.PO_NO">';	  
			var cellTmp1_Reg_RECEIPT_NO       = '<input ng-if="row.entity.STATE==0" type="text" ng-model="row.entity.RECEIPT_NO">';
			var cellTmp1_New_RECEIPT_NO       = '<input ng-if="row.entity.STATE!=0" type="text" ng-model="row.entity.RECEIPT_NO">';	  
			var cellTmp1_Reg_VENDOR_NM        = '<input ng-if="row.entity.STATE==0" type="text" ng-model="row.entity.VENDOR_NM" readonly>';
			var cellTmp1_New_VENDOR_NM        = '<input ng-if="row.entity.STATE!=0" type="text" ng-model="row.entity.VENDOR_NM" style="width:90%;" readonly><img src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(2, row)">';
			var cellTmp1_Reg_ITEM_NM          = '<input ng-if="row.entity.STATE==0" type="text" ng-model="row.entity.ITEM_NM" readonly>';
			var cellTmp1_New_ITEM_NM          = '<input ng-if="row.entity.STATE!=0" type="text" ng-model="row.entity.ITEM_NM" style="width:80%;" readonly><img src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(1, row)">';
			var cellTmp1_Reg_ORDER1           = '<input ng-if="row.entity.STATE==0" type="text" ng-model="row.entity.ORDER1">';
			var cellTmp1_New_ORDER1           = '<input ng-if="row.entity.STATE!=0" type="text" ng-model="row.entity.ORDER1">';
			var cellTmp1_Reg_ORDER2           = '<input ng-if="row.entity.STATE==0" type="text" ng-model="row.entity.ORDER2" readonly>';
			var cellTmp1_New_ORDER2           = '<input ng-if="row.entity.STATE!=0" type="text" ng-model="row.entity.ORDER2">';
			var cellTmp1_Reg_SHIP_NM          = '<input ng-if="row.entity.STATE==0" type="text" ng-model="row.entity.SHIP_NM">';
			var cellTmp1_New_SHIP_NM          = '<input ng-if="row.entity.STATE!=0" type="text" ng-model="row.entity.SHIP_NM">';
			var cellTmp1_Reg_DMT              = '<input ng-if="row.entity.STATE==0" type="text" ng-model="row.entity.DMT">';
			var cellTmp1_New_DMT              = '<input ng-if="row.entity.STATE!=0" type="text" ng-model="row.entity.DMT">';
			var cellTmp1_Reg_LAYCAN           = '<input ng-if="row.entity.STATE==0" type="text" ng-model="row.entity.LAYCAN">';
			var cellTmp1_New_LAYCAN           = '<input ng-if="row.entity.STATE!=0" type="text" ng-model="row.entity.LAYCAN">';
			var cellTmp1_Reg_RECEIPT          = '<input ng-if="row.entity.STATE==0" type="checkbox" ng-model="row.entity.RECEIPT" ng-checked="row.entity.RECEIPT ==\'Y\'">';
			var cellTmp1_New_RECEIPT          = '<input ng-if="row.entity.STATE!=0" type="checkbox" ng-model="row.entity.RECEIPT">';
			var cellTmp1_Reg_DELAY            = '<input ng-if="row.entity.STATE==0" type="checkbox" ng-model="row.entity.DELAY" ng-checked="row.entity.DELAY ==\'Y\'">';
			var cellTmp1_New_DELAY            = '<input ng-if="row.entity.STATE!=0" type="checkbox" ng-model="row.entity.DELAY">';
			var cellTmp1_Reg_ITINERARY        = '<input ng-if="row.entity.STATE==0" type="text" ng-model="row.entity.ITINERARY">';
			var cellTmp1_New_ITINERARY        = '<input ng-if="row.entity.STATE!=0" type="text" ng-model="row.entity.ITINERARY">';
			var cellTmp1_Reg_ARRIVAL_DATE     = '<input ng-if="row.entity.STATE==0 && row.entity.ARRIVAL_DATE_FIX ==\'Y\'" type="text" class="calendar" ng-model="row.entity.ARRIVAL_DATE" id="ARRIVAL_DATE_{{row.entity.RNUM}}" readonly><input ng-if="row.entity.STATE==0 && row.entity.ARRIVAL_DATE_FIX !=\'Y\'" type="text" class="calendar dtp2" ng-model="row.entity.ARRIVAL_DATE" id="ARRIVAL_DATE_{{row.entity.RNUM}}">';
			var cellTmp1_New_ARRIVAL_DATE     = '<input ng-if="row.entity.STATE!=0" type="text" class="calendar dtp" ng-model="row.entity.ARRIVAL_DATE" id="ARRIVAL_DATE_{{row.entity.RNUM}}">';
			var cellTmp1_Reg_ARRIVAL_DATE_FIX = '<input ng-if="row.entity.STATE==0" type="checkbox" ng-model="row.entity.ARRIVAL_DATE_FIX" ng-checked="row.entity.ARRIVAL_DATE_FIX ==\'Y\'" ng-click="grid.appScope.checkboxClick(row, $event)"';
			var cellTmp1_New_ARRIVAL_DATE_FIX = '<input ng-if="row.entity.STATE!=0" type="checkbox" ng-model="row.entity.ARRIVAL_DATE_FIX">';
			var cellTmp1_Reg_SHIP_DATE        = '<input ng-if="row.entity.STATE==0" type="text" class="calendar dtp" ng-model="row.entity.SHIP_DATE" id="SHIP_DATE_{{row.entity.RNUM}}">';
			var cellTmp1_New_SHIP_DATE        = '<input ng-if="row.entity.STATE!=0" type="text" class="calendar dtp" ng-model="row.entity.SHIP_DATE" id="SHIP_DATE_{{row.entity.RNUM}}">';
			var cellTmp1_Reg_UNLOAD_DATE      = '<input ng-if="row.entity.STATE==0" type="text" class="calendar dtp" ng-model="row.entity.UNLOAD_DATE" id="UNLOAD_DATE_{{row.entity.RNUM}}">';
			var cellTmp1_New_UNLOAD_DATE      = '<input ng-if="row.entity.STATE!=0" type="text" class="calendar dtp" ng-model="row.entity.UNLOAD_DATE" id="UNLOAD_DATE_{{row.entity.RNUM}}">';
			var cellTmp1_Reg_UNLOAD_YN        = '<input ng-if="row.entity.STATE==0" type="checkbox" ng-model="row.entity.UNLOAD_YN" ng-checked="row.entity.UNLOAD_YN ==\'Y\'">';
			var cellTmp1_New_UNLOAD_YN        = '<input ng-if="row.entity.STATE!=0" type="checkbox" ng-model="row.entity.UNLOAD_YN">';
			var cellTmp1_Reg_SHIP_VENDOR      = '<input ng-if="row.entity.STATE==0" type="text" ng-model="row.entity.SHIP_VENDOR">';
			var cellTmp1_New_SHIP_VENDOR      = '<input ng-if="row.entity.STATE!=0" type="text" ng-model="row.entity.SHIP_VENDOR">';
			var cellTmp1_Reg_SURVEYOR         = '<input ng-if="row.entity.STATE==0" type="text" ng-model="row.entity.SURVEYOR" readonly>';
			var cellTmp1_New_SURVEYOR         = '<input ng-if="row.entity.STATE!=0" type="text" ng-model="row.entity.SURVEYOR">';
			var cellTmp1_Reg_TT               = '<input ng-if="row.entity.STATE==0" type="checkbox" ng-model="row.entity.TT" ng-checked="row.entity.TT ==\'Y\'">';
			var cellTmp1_New_TT               = '<input ng-if="row.entity.STATE!=0" type="checkbox" ng-model="row.entity.TT">';
			var cellTmp1_Reg_LC               = '<input ng-if="row.entity.STATE==0" type="checkbox" ng-model="row.entity.LC" ng-checked="row.entity.LC ==\'Y\'">';
			var cellTmp1_New_LC               = '<input ng-if="row.entity.STATE!=0" type="checkbox" ng-model="row.entity.LC">';
			var cellTmp1_Reg_CONDITION        = '<input ng-if="row.entity.STATE==0" type="text" ng-model="row.entity.CONDITION">';
			var cellTmp1_New_CONDITION        = '<input ng-if="row.entity.STATE!=0" type="text" ng-model="row.entity.CONDITION">';
			//Cell Template1 
			
			
			var columnDefs1 = [
				{
					displayName : 'STATE',
					field : 'STATE',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, 
				{
					displayName : 'SEQ',
					field : 'SEQ',
					width : '80',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				},
				{
					displayName : 'No',
					field : 'RNUM',
					width : '80',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, 
				{
					displayName : '주문번호',
					field : 'PO_NO',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: cellTmp1_Reg_PO_NO + cellTmp1_New_PO_NO
				},
				{
					displayName : '입고번호',
					field : 'RECEIPT_NO',
					width : '120',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: cellTmp1_Reg_RECEIPT_NO + cellTmp1_New_RECEIPT_NO
				},
				{displayName : '업체코드', field : 'VENDOR_CD', visible : false, cellClass : "center", enableCellEdit : false, allowCellFocus : false,},
				{
					displayName : '업체*',
					field : 'VENDOR_NM',
					width : '280',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: cellTmp1_Reg_VENDOR_NM + cellTmp1_New_VENDOR_NM
				},
				{displayName : '광종코드', field : 'ITEM_CD', visible : false, cellClass : "center", enableCellEdit : false, allowCellFocus : false},
				{
					displayName : '광종*',
					field : 'ITEM_NM',
					width : '200',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: cellTmp1_Reg_ITEM_NM + cellTmp1_New_ITEM_NM
				},
				{
					displayName : '차수',
					field : 'ORDER1',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: cellTmp1_Reg_ORDER1 + cellTmp1_New_ORDER1
				},
				{
					displayName : '입고차수*',
					field : 'ORDER2',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: cellTmp1_Reg_ORDER2 + cellTmp1_New_ORDER2
				},
				{
					displayName : '선박명',
					field : 'SHIP_NM',
					width : '130',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: cellTmp1_Reg_SHIP_NM + cellTmp1_New_SHIP_NM
				},
				{
					displayName : 'DMT*',
					field : 'DMT',
					width : '130',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: cellTmp1_Reg_DMT + cellTmp1_New_DMT
				},
				{
					displayName : 'B/L입항일*',
					field : 'ARRIVAL_DATE',
					width : '130',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: cellTmp1_Reg_ARRIVAL_DATE + cellTmp1_New_ARRIVAL_DATE
				},
				{
					displayName : '실제입항일',
					field : 'SHIP_DATE',
					width : '130',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: cellTmp1_Reg_SHIP_DATE + cellTmp1_New_SHIP_DATE
				},
				{
					displayName : 'B/L입항일 Fix',
					field : 'ARRIVAL_DATE_FIX',
					width : '130',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: cellTmp1_Reg_ARRIVAL_DATE_FIX + cellTmp1_New_ARRIVAL_DATE_FIX
				},
				{
					displayName : 'Laycan',
					field : 'LAYCAN',
					width : '130',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: cellTmp1_Reg_LAYCAN + cellTmp1_New_LAYCAN
				},
				{
					displayName : 'B/L(수령)',
					field : 'RECEIPT',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: cellTmp1_Reg_RECEIPT + cellTmp1_New_RECEIPT
				},
				{
					displayName : 'B/L(전달)',
					field : 'DELAY',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: cellTmp1_Reg_DELAY + cellTmp1_New_DELAY
				},
				{
					displayName : 'Itinerary',
					field : 'ITINERARY',
					width : '200',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: cellTmp1_Reg_ITINERARY + cellTmp1_New_ITINERARY
				},
				{displayName : 'BL입항일', field : 'ORIGINAL_ARRIVAL_DATE', visible : false, cellClass : "center", enableCellEdit : false, allowCellFocus : false,},
				{
					displayName : '실제하역일',
					field : 'UNLOAD_DATE',
					width : '130',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: cellTmp1_Reg_UNLOAD_DATE + cellTmp1_New_UNLOAD_DATE
				},
				{
					displayName : '하역완료',
					field : 'UNLOAD_YN',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: cellTmp1_Reg_UNLOAD_YN + cellTmp1_New_UNLOAD_YN
				},
				{
					displayName : '선사',
					field : 'SHIP_VENDOR',
					width : '130',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: cellTmp1_Reg_SHIP_VENDOR + cellTmp1_New_SHIP_VENDOR
				},
				{
					displayName : 'Surveyor',
					field : 'SURVEYOR',
					width : '130',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: cellTmp1_Reg_SURVEYOR + cellTmp1_New_SURVEYOR
				},
				{
					displayName : '지불방법(T/T)',
					field : 'TT',
					width : '150',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: cellTmp1_Reg_TT + cellTmp1_New_TT
				},
				{
					displayName : '지불방법(L/C)',
					field : 'LC',
					width : '150',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: cellTmp1_Reg_LC + cellTmp1_New_LC
				},
				{
					displayName : '지불방법(조건)',
					field : 'CONDITION',
					width : '200',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: cellTmp1_Reg_CONDITION + cellTmp1_New_CONDITION
				},
			  ];

			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바
				showColumnFooter : false,
				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 1000,

				enableCellEditOnFocus : true, //셀 클릭시 edit모드 
				enableSelectAll : false, //전체선택 체크박스
				enableRowSelection : true, //로우 선택
				enableRowHeaderSelection : true, //맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 35, //체크박스 컬럼 길이
				enableHorizontalScrollbar : "1",
				enableVerticalScrollbar : "1",
				rowHeight : 24, //체크박스 컬럼 높이
				// useExternalPagination : true, //pagination을 직접 세팅
				enableAutoFitColumns : false, //컬럼 width를 자동조정
				multiSelect : false, //여러로우선택
				enablePagination : false,
				enablePaginationControls : false,

				columnDefs : columnDefs1,
				
				onRegisterApi: function( gridApi ) {
				      $scope.gridApi = gridApi;
				 }
			});

			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  
		} ]);
		
		//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
		app.controller('typicalCtrl', [ '$scope', '$window', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $window, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
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
	
			var columnDefs1 = [];

			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableFiltering : false, 	//각 컬럼에 검색바
				showColumnFooter : false,	//컬럼 푸터
				showGridFooter : false,		//그리드 푸터
				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 1000,

				enableCellEditOnFocus : true, //셀 클릭시 edit모드 
				enableSelectAll : false, //전체선택 체크박스
				enableRowSelection : false, //로우 선택
				enableRowHeaderSelection : false, //맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 35, //체크박스 컬럼 길이
				rowHeight : 27, //체크박스 컬럼 높이
				// useExternalPagination : true, //pagination을 직접 세팅
				enableAutoFitColumns : false, //컬럼 width를 자동조정
				multiSelect : false, //여러로우선택
				enablePagination : false,
				enablePaginationControls : false,

				columnDefs : columnDefs1,
				
				onRegisterApi: function( gridApi ) {
				      $scope.gridApi = gridApi;
				 }
			});

			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  
		} ]);
		
		//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
		app.controller('invoiceCtrl', [ '$scope', '$window', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $window, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
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
	
			var columnDefs1 = [];

			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableFiltering : false, 	//각 컬럼에 검색바
				showColumnFooter : false,	//컬럼 푸터
				showGridFooter : false,		//그리드 푸터
				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 1000,

				enableCellEditOnFocus : true, //셀 클릭시 edit모드 
				enableSelectAll : false, //전체선택 체크박스
				enableRowSelection : false, //로우 선택
				enableRowHeaderSelection : false, //맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 35, //체크박스 컬럼 길이
				rowHeight : 27, //체크박스 컬럼 높이
				// useExternalPagination : true, //pagination을 직접 세팅
				enableAutoFitColumns : false, //컬럼 width를 자동조정
				multiSelect : false, //여러로우선택
				enablePagination : false,
				enablePaginationControls : false,

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
			scope         = angular.element(document.getElementById("shds-uiGrid")).scope(); 	//html id를 통해서 controller scope(this) 가져옴
			typical_scope = angular.element(document.getElementById("typical-uiGrid")).scope(); //Typical Assay
			invoice_scope = angular.element(document.getElementById("invoice-uiGrid")).scope(); //Invoice Assay
			
			scope.gridApi.core.on.rowsRendered(scope, function() {	//그리드 렌더링 후 이벤트
			 	//console.log(scope);
				//alert(scope.searchCnt);
			});
			scope.gridApi.selection.on.rowSelectionChanged(scope, function(row) { //로우 선택할때마다 이벤트
				var selectedRows = scope.gridApi.selection.getSelectedRows();	//그리드 선택된 rows data
				if(selectedRows.length > 0){	//체크박스 선택시
					if(row.entity.STATE == 0){	//조회 된 데이터만 해당
						$.ajax({
						    url: "/yp/zmm/raw/AssayList",
						    type: "POST",
						    cache:false,
						    async:true, 
						    dataType:"json",
						    data:{_csrf : "${_csrf.token}", RECEIPT_DATE : row.entity.ARRIVAL_DATE, ITEM_CD : row.entity.ITEM_CD, RECEIPT_TYPE : row.entity.ORDER2},
						    success: function(result) {
						    	var col_list = new Array();
						    	var row_list1 = new Array();
						    	var row_list2 = new Array();
						    	var row1 = new Object();
						    	var row2 = new Object();
						    	
						    	$.each(result.list, function(i, d){
									//그리드 컬럼 정의
						    		var col = new Object();
									col.displayName    = result.list[i].COMPONENT;
									col.field          = result.list[i].TEST_CD;
									col.width          = "120";
									col.enableCellEdit = true;
									col.allowCellFocus = true;
									col_list.push(col);
			
									//그리드 로우 정의
									row1[result.list[i].TEST_CD] = result.list[i].TYPICAL_VALUE;	//운영테스트시 변경필요
									row2[result.list[i].TEST_CD] = result.list[i].INVOICE_VALUE;	//운영테스트시 변경필요
								});
						    	
						    	row_list1.push(row1);	
						    	row_list2.push(row2);	

						    	typical_scope.gridOptions.columnDefs = col_list;
						    	typical_scope.gridOptions.data       = row_list1;	//그리드 데이터 담기
						    	invoice_scope.gridOptions.data       = row_list2;	//그리드 데이터 담기
						    	typical_scope.gridApi.core.notifyDataChange(typical_scope.uiGridConstants.dataChange.ALL);	//그리드 새로고침
						    	invoice_scope.gridApi.core.notifyDataChange(invoice_scope.uiGridConstants.dataChange.ALL);	//그리드 새로고침
					    	},
							beforeSend:function(){
								$('.wrap-loading').removeClass('display-none');
							},
							complete:function(){
						        setTimeout(function() {
									$('.wrap-loading').addClass('display-none');
								}, 1000); //1초
						    },
						    error:function(request,status,error){
						    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
						    	swalDanger("Assay 조회에 실패하였습니다.\n관리자에게 문의해주세요.");
						    }
						});
					}
				}else{	//체크박스 해제시 Assay 그리드 데이터 초기화
					typical_scope.gridOptions.data.length = 0;
					invoice_scope.gridOptions.data.length = 0;
				}
				
				
			});
			scope.gridApi.selection.on.rowSelectionChangedBatch(scope, function(rows) { //전체선택시 가져옴
				//console.log("row3", rows[0].entity); //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
			});
			// pagenation option setting  그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param = {
				EXEC_RFC  : "N", // RFC 여부
				cntQuery  : "yp_zmm.retrieveArrivalScheduleListCnt", 	
				listQuery : "yp_zmm.retrieveArrivalScheduleList"
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
			
			// 부트스트랩 날짜객체
			$(document).on("focus", ".dtp", function() {
				$(this).datepicker({
					format : "yyyy/mm/dd",
					language : "ko",
					todayHighlight : true,
					autoclose : true,
					clearBtn : true,
					updateViewDate : false
				}).on('changeDate', function (ev) {
					if(ev.viewMode != "months" && ev.viewMode != "years"){
						$(this).trigger("change");
						$('.datepicker').hide();
					}
				});
			});
			
			// 부트스트랩 날짜객체
			$(document).on("focus", ".dtp2", function() {
				$(this).datepicker({
					format : "yyyy/mm/dd",
					language : "ko",
					todayHighlight : true,
					autoclose : true,
					clearBtn : true,
					updateViewDate : false
				}).on('show', function(ev) {
					if($("#"+this.id).prop("readonly")){
						$('.datepicker').hide();
					}
				}).on('changeDate', function (ev) {
					if(ev.viewMode != "months" && ev.viewMode != "years"){
						$(this).trigger("change");
						$('.datepicker').hide();
					}
				});
			});
			
			
			// LME 조회
			$("#lme_search_btn").on("click", function() {
				fnSearchData();
				fnSearchData2();
			});
			
			// LME 저장
			$("#lme_save_btn").on("click", function() {
				$.ajax({
				    url: "/yp/zmm/raw/createLME",
				    type: "POST",
				    cache:false,
				    async:true, 
					dataType:"json",
				    data:$("#frm").serialize(),
				    success: function(result) {
				    	if(result.result_code > 0){
				    		swalSuccess(result.msg);
				    	}else{
				    		swalDanger(result.msg);
				    	}
			    		fnSearchData();	//데이터 리로드
			    	},
					beforeSend:function(){
						$('.wrap-loading').removeClass('display-none');
					},
					complete:function(){
				        $('.wrap-loading').addClass('display-none');
				    },
				    error:function(request,status,error){
				    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
				    	swalDanger("저장에 실패하였습니다.\n관리자에게 문의해주세요.");
				    }
				});
			});
			
			// 입항스케줄 조회
			$("#search_btn").on("click", function() {
				//ASSAY 그리드 데이터 초기화
				typical_scope.gridOptions.data.length = 0;
				invoice_scope.gridOptions.data.length = 0;
				
				scope.reloadGrid(
					gPostArray($("#frm").serializeArray())	//폼을 그리드 파라메터로 전송
				);	
			});
			
			// 추가
			$("#add_btn").on("click", function() {
				var addChk = true;
				if(scope.gridOptions.data.length > 0){
					if(scope.gridOptions.data[0].STATE == 1){
						addChk = false;
					}
				}
				if(addChk){
					scope.addRow({
						STATE      : 1,
						SEQ        : "",
						RNUM       : "등록",
						RECEIPT_NO : "",
						VENDOR_CD  : "",
						VENDOR_NM  : "",
						ITEM_CD    : "",
						ITEM_NM    : "",
						ORDER1     : "",
						ORDER2     : "",
						SHIP_NM    : "",
						DMT        : "",
						ARRIVAL_DATE     : "",
						SHIP_DATE   : "",
						ARRIVAL_DATE_FIX : "",
						LAYCAN     : "",
						RECEIPT    : "",
						DELAY      : "",
						ITINERARY  : "",
						ORIGINAL_ARRIVAL_DATE : "",
						UNLOAD_DATE : "",
						UNLOAD_YN   : "",
						SHIP_VENDOR : "",
						SURVEYOR    : "",
						TT          : "",
						LC          : "",
						CONDITION   : "",
						UPLOAD_DATE : "",
					}, true, "desc");
				}	
				
				//ASSAY 그리드 데이터 초기화
				typical_scope.gridOptions.data.length = 0;
				invoice_scope.gridOptions.data.length = 0;
			});
			
			//등록
			$("#reg_btn").click(function(){
				var selectedRows = scope.gridApi.selection.getSelectedRows();	//그리드 선택된 rows data
				if(selectedRows.length == 0){
					swalWarning("저장할 항목을 선택해 주세요.");
					return false;
				}

				if(selectedRows[0].VENDOR_CD == ""){
					swalWarning("업체를 입력해주세요.");
					return false;
				}else if(selectedRows[0].ITEM_CD == ""){
					swalWarning("광종을 입력해주세요.");
					return false;
				}else if(selectedRows[0].ORDER2 == ""){
					swalWarning("입고차수를 입력해주세요.");
					return false;
				}else if(selectedRows[0].ARRIVAL_DATE == ""){
					swalWarning("B/L입항일을 입력해주세요.");
					return false;
				}

				//datepicker 바인딩 안되는 경우 방지 위해 강제로 데이터 세팅
				selectedRows[0].ARRIVAL_DATE = $("#ARRIVAL_DATE_"+selectedRows[0].RNUM).val();
				selectedRows[0].SHIP_DATE    = $("#SHIP_DATE_"+selectedRows[0].RNUM).val();
				selectedRows[0].UNLOAD_DATE  = $("#UNLOAD_DATE_"+selectedRows[0].RNUM).val();
				
				
				//form데이터에 그리드데이터 json으로 변환 및 추가해서 서버로 전송
				var data = $("#frm").serializeArray();
				data.push({name: "gridData", value: JSON.stringify(selectedRows)});
				
				$.ajax({
				    url: "/yp/zmm/raw/createArrivalSchedule",
				    type: "POST",
				    cache:false,
				    async:true, 
					dataType:"json",
				    data:data,
				    success: function(result) {
				    	if(result.result_code > 0){
				    		swalSuccess(result.msg);
				    	}else{
				    		swalDanger(result.msg);
				    	}
			    		fnSearchData();		//LME 데이터 리로드
			    		fnSearchData2();	//입항스케줄 데이터 리로드
			    	},
					beforeSend:function(){
						$('.wrap-loading').removeClass('display-none');
					},
					complete:function(){
				        $('.wrap-loading').addClass('display-none');
				    },
				    error:function(request,status,error){
				    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
				    	swalDanger("등록에 실패하였습니다.\n관리자에게 문의해주세요.");
				    }
				});
			});
			
			//수정
			$("#mod_btn").on("click",function(){
				var selectedRows = scope.gridApi.selection.getSelectedRows();	//그리드 선택된 rows data
				if(selectedRows.length == 0){
					swalWarning("수정할 항목을 선택해 주세요.");
					return false;
				}

				//datepicker 바인딩 안되는 경우 방지 위해 강제로 데이터 세팅
				selectedRows[0].ARRIVAL_DATE = $("#ARRIVAL_DATE_"+selectedRows[0].RNUM).val();
				selectedRows[0].SHIP_DATE    = $("#SHIP_DATE_"+selectedRows[0].RNUM).val();
				selectedRows[0].UNLOAD_DATE  = $("#UNLOAD_DATE_"+selectedRows[0].RNUM).val();
				
				//form데이터에 그리드데이터 json으로 변환 및 추가해서 서버로 전송
				var data = $("#frm").serializeArray();
				data.push({name: "gridData", value: JSON.stringify(selectedRows)});
				
				$.ajax({
				    url: "/yp/zmm/raw/updateArrivalSchedule",
				    type: "POST",
				    cache:false,
				    async:true, 
				    dataType:"json",
				    data:data,
				    success: function(result) {
				    	if(result.result_code > 0){
				    		swalSuccessCB(result.msg, function(){
				    			fnSearchData();		//LME 데이터 리로드
				    			fnSearchData2();	//입항스케줄 데이터 리로드	
				    		});
				    	}else{
				    		swalDangerCB(result.msg);
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
				    	swalDanger("수정에 실패하였습니다.\n관리자에게 문의해주세요.");
				    }
				});
				
			});
			
			//삭제
			$("#del_btn").on("click",function(){
				var selectedRows = scope.gridApi.selection.getSelectedRows();	//그리드 선택된 rows data
				if(selectedRows.length == 0){
					swalWarning("삭제할 항목을 선택해 주세요.");
					return false;
				}
				
				//form데이터에 그리드데이터 json으로 변환 및 추가해서 서버로 전송
				var data = $("#frm").serializeArray();
				data.push({name: "gridData", value: JSON.stringify(selectedRows)})

				$.ajax({
				    url: "/yp/zmm/raw/deleteArrivalSchedule",
				    type: "POST",
				    cache:false,
				    async:true, 
				    dataType:"json",
				    data:data,
				    success: function(result) {
				    	if(result.result_code > 0){
				    		swalSuccess(result.msg);
				    	}else{
				    		swalDanger(result.msg);
				    	}
			    		fnSearchData();		//LME 데이터 리로드
			    		fnSearchData2();	//입항스케줄 데이터 리로드
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
			});
			
			//Typical Assay 저장
			$("#typical_save_btn").on("click", function(){
				var selectedRows = scope.gridApi.selection.getSelectedRows();	//그리드 선택된 rows data
				if(typical_scope.gridOptions.data.length == 0){
					swalWarning("저장할 데이터가 없습니다.\n입항스케줄 데이터를 선택해 주세요.");
					return false;
				}
				var data = 
				{
					_csrf : "${_csrf.token}", 								//보안토큰
					RECEIPT_DATE : selectedRows[0].ORIGINAL_ARRIVAL_DATE,	//BL입항일 
					ITEM_CD      : selectedRows[0].ITEM_CD, 				//광종코드
					RECEIPT_TYPE : selectedRows[0].ORDER2,					//입고차수
					gridData     : JSON.stringify(typical_scope.gridOptions.data)	//Assay 데이터
				};

				$.ajax({
				    url: "/yp/zmm/raw/createTypicalAssay",
				    type: "POST",
				    cache:false,
				    async:true, 
				    dataType:"json",
				    data:data,
				    success: function(result) {
				    	if(result.result_code > 0){
				    		swalSuccess(result.msg);
				    	}else{
				    		swalDanger(result.msg);
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
				    	swalDanger("저장에 실패하였습니다.\n관리자에게 문의해주세요.");
				    }
				});
			});
			
			//Invoice Assay 저장
			$("#invoice_save_btn").on("click", function(){
				var selectedRows = scope.gridApi.selection.getSelectedRows();	//그리드 선택된 rows data
				if(invoice_scope.gridOptions.data.length == 0){
					swalWarning("저장할 데이터가 없습니다.\n입항스케줄 데이터를 선택해 주세요.");
					return false;
				}

				var data = 
				{
					_csrf : "${_csrf.token}", 								//보안토큰
					RECEIPT_DATE : selectedRows[0].ORIGINAL_ARRIVAL_DATE,	//BL입항일 
					ITEM_CD      : selectedRows[0].ITEM_CD, 				//광종코드
					RECEIPT_TYPE : selectedRows[0].ORDER2,					//입고차수
					gridData     : JSON.stringify(invoice_scope.gridOptions.data)	//Assay 데이터
				};

				$.ajax({
				    url: "/yp/zmm/raw/createInvoiceAssay",
				    type: "POST",
				    cache:false,
				    async:true, 
				    dataType:"json",
				    data:data,
				    success: function(result) {
				    	if(result.result_code > 0){
				    		swalSuccess(result.msg);
				    	}else{
				    		swalDanger(result.msg);
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
				    	swalDanger("저장에 실패하였습니다.\n관리자에게 문의해주세요.");
				    }
				});
			});
			
			// 엑셀 다운로드
			$("#excel_btn").on("click", function() {
				$("input[name=excel_flag]").val("1");
				//20191023_khj for csrf
				var csrf_element = document.createElement("input");
				csrf_element.name = "_csrf";
				csrf_element.value = "${_csrf.token}";
				csrf_element.type = "hidden";
				//20191023_khj for csrf
				var xlsForm = document.createElement("form");
				
				xlsForm.target = "xlsx_download";
				xlsForm.name   = "sndFrm";
				xlsForm.method = "post";
				xlsForm.action = "/yp/xls/zmm/raw/zmm_raw_schedule_read";

				document.body.appendChild(xlsForm);

				xlsForm.appendChild(csrf_element);

				var pr = gPostArray($("#frm").serializeArray());	//form parameters to array

				$.each(pr, function(k, v) {
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
			
			// 필터 토글
// 			$("#filter_btn").on("click", function() {
// 				scope.gridOptions.enableFiltering = !scope.gridOptions.enableFiltering;
// 				scope.gridApi.core.notifyDataChange( scope.uiGridConstants.dataChange.COLUMN );
// 			});
		});
		
		function fnSearchPopup(type,target){//none target : 검색  , target : 개별항목 줄번호
			if(type=="1"){
				window.open("/yp/popup/zmm/raw/retrieveItemPop?target="+target,"광종 검색","width=610,height=800,scrollbars=yes");
			}else if(type=="2"){
				window.open("/yp/popup/zmm/raw/retrieveVendorPop?target="+target,"업체 검색","width=700,height=800,scrollbars=yes");
			}
		}

		function numberCommas(str) {
			var x = parseInt(str);
		    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
		
		function fnSearchData(){
			//LME 조회
			$.ajax({
			    url: "/yp/zmm/raw/zmm_raw_schedule_read_search",
			    type: "POST",
			    cache:false,
			    async:true, 
			    data:$("#frm,#search_form").serialize(),
			    dataType:"json",
			    success: function(result) {
			    	var html;
			    	var lme     = result.lme;
			    	var lme_avg = result.lme_avg;
			    	
			    	if(lme.length > 0){
			    		var ZN_DIFF = 0;
				    	var AG_DIFF = 0;
				    	var CU_DIFF = 0;
				    	var PB_DIFF = 0;
				    	var AU_DIFF = 0;
				    	var SHG_DIFF= 0;
				    	var HG_DIFF = 0;
				    	
			    		if(lme.length > 1){	//직전 LME데이터가 있는 경우에만 차이값을 계산
			    			ZN_DIFF = lme[0].ZN - lme[1].ZN;
					    	AG_DIFF = lme[0].AG - lme[1].AG;
					    	CU_DIFF = lme[0].CU - lme[1].CU;
					    	PB_DIFF = lme[0].PB - lme[1].PB;
					    	AU_DIFF = lme[0].AU - lme[1].AU;
					    	SHG_DIFF= lme[0].SHG - lme[1].SHG;
					    	HG_DIFF = lme[0].HG - lme[1].HG;
			    		}
						
				    	//실수인 경우 소수점 2자리까지 반올림
				    	if(ZN_DIFF % 1 !== 0)  ZN_DIFF = ZN_DIFF.toFixed(2);
				    	if(AG_DIFF % 1 !== 0)  AG_DIFF = AG_DIFF.toFixed(2);
				    	if(CU_DIFF % 1 !== 0)  CU_DIFF = CU_DIFF.toFixed(2);
				    	if(PB_DIFF % 1 !== 0)  PB_DIFF = PB_DIFF.toFixed(2);
				    	if(AU_DIFF % 1 !== 0)  AU_DIFF = AU_DIFF.toFixed(2);
				    	if(SHG_DIFF % 1 !== 0) SHG_DIFF = SHG_DIFF.toFixed(2);
				    	if(HG_DIFF % 1 !== 0)  HG_DIFF = HG_DIFF.toFixed(2);
				    	
						if(lme[0].LME_DATE1 == ""){
							$("#lme_date").val($("#lme_date").val());	//LME DATE 변경
						}else{
							$("#lme_date").val(lme[0].LME_DATE1);	//LME DATE 변경
						}
				    	
				    	$("#lme_table tbody").empty();			//html table 초기화
				    	
			   			html += '<tr>';
			   			html += '<td>ZN</td>';
	                    html += '<td class="left">';    
	                    html += '<label>$</label>&nbsp;&nbsp;';    
	                    html += '<input type="text" style="width:100px;" name="lme_zn" id="lme_zn" value="'+NVL(lme[0].ZN)+'">&nbsp;&nbsp;';    	
	                    if(ZN_DIFF * 1 > 0)      html += '<img src="/resources/yp/images/iic_amount_up.png">'+'<span>'+"$"+ZN_DIFF+'</span>';
						else if(ZN_DIFF * 1 < 0) html += '<img src="/resources/yp/images/iic_amount_down.png">'+'<span>'+"$"+ZN_DIFF * -1+'</span>';
	                    html += '</td>';	                   
	                    html += '<td class="right" id="ZN_THIS">$'+lme_avg[0].ZN+'</td>';
	                    html += '<td class="right" id="ZN_LAST">$'+lme_avg[1].ZN+'</td>';    
	                    html += '</tr>';
	                    
	                    html += '<tr>';
	                    html += '<td>Ag</td>';
	                    html += '<td class="left">';
	                    html += '<label>$</label>&nbsp;&nbsp;';
	                    html += '<input type="text" style="width:100px;" name="lme_ag" id="lme_ag" value="'+NVL(lme[0].AG)+'">&nbsp;&nbsp;';
	                    if(AG_DIFF * 1 > 0)      html += '<img src="/resources/yp/images/iic_amount_up.png">'+'<span>'+"$"+AG_DIFF+'</span>';
						else if(AG_DIFF * 1 < 0) html += '<img src="/resources/yp/images/iic_amount_down.png">'+'<span>'+"$"+AG_DIFF * -1+'</span>';
	                    html += '</td>';    
	                    html += '<td class="right" id="AG_THIS">$'+lme_avg[0].AG+'</td>';
	                    html += '<td class="right" id="AG_LAST">$'+lme_avg[1].AG+'</td>';    
	                    html += '</tr>';    	
	                    
	                    html += '<tr>';
	                    html += '<td>Cu</td>';
	                    html += '<td class="left">';
	                    html += '<label>$</label>&nbsp;&nbsp;';    
	                    html += '<input type="text" style="width:100px;" name="lme_cu" id="lme_cu" value="'+NVL(lme[0].CU)+'">&nbsp;&nbsp;';    	
	                    if(CU_DIFF * 1 > 0)      html += '<img src="/resources/yp/images/iic_amount_up.png">'+'<span>'+"$"+CU_DIFF+'</span>';
						else if(CU_DIFF * 1 < 0) html += '<img src="/resources/yp/images/iic_amount_down.png">'+'<span>'+"$"+CU_DIFF * -1+'</span>';
	                    html += '</td>';	                   
	                    html += '<td class="right" id="CU_THIS">$'+lme_avg[0].CU+'</td>';
	                    html += '<td class="right" id="CU_LAST">$'+lme_avg[1].CU+'</td>';    
	                    html += '</tr>';
	                      
	                    html += '<tr>';
	                    html += '<td>Pb</td>';
	                    html += '<td class="left">';
	                    html += '<label>$</label>&nbsp;&nbsp;';    
	                    html += '<input type="text" style="width:100px;" name="lme_pb" id="lme_pb" value="'+NVL(lme[0].PB)+'">&nbsp;&nbsp;';    	
	                    if(PB_DIFF * 1 > 0)      html += '<img src="/resources/yp/images/iic_amount_up.png">'+'<span>'+"$"+PB_DIFF+'</span>';
						else if(PB_DIFF * 1 < 0) html += '<img src="/resources/yp/images/iic_amount_down.png">'+'<span>'+"$"+PB_DIFF * -1+'</span>';
	                    html += '</td>';	                   
	                    html += '<td class="right" id="PB_THIS">$'+lme_avg[0].PB+'</td>';
	                    html += '<td class="right" id="PB_LAST">$'+lme_avg[1].PB+'</td>';    
	                    html += '</tr>';
	                    
	                    html += '<tr>';
	                    html += '<td>Au</td>';
	                    html += '<td class="left">';
	                    html += '<label>$</label>&nbsp;&nbsp;';    
	                    html += '<input type="text" style="width:100px;" name="lme_au" id="lme_au" value="'+NVL(lme[0].AU)+'">&nbsp;&nbsp;';    	
	                    if(AU_DIFF * 1 > 0)      html += '<img src="/resources/yp/images/iic_amount_up.png">'+'<span>'+"$"+AU_DIFF+'</span>';
						else if(AU_DIFF * 1 < 0) html += '<img src="/resources/yp/images/iic_amount_down.png">'+'<span>'+"$"+AU_DIFF * -1+'</span>';
	                    html += '</td>';	                   
	                    html += '<td class="right" id="AU_THIS">￦'+lme_avg[0].AU+'</td>';
	                    html += '<td class="right" id="AU_LAST">￦'+lme_avg[1].AU+'</td>';    
	                    html += '</tr>';
	                       
	                    html += '<tr>';
	                    html += '<td>SHG</td>';
	                    html += '<td class="left">';
	                    html += '<label>￦ </label>';    
	                    html += '<input type="text" style="width:100px;" name="lme_shg" id="lme_shg" value="'+NVL(lme[0].SHG)+'">&nbsp;&nbsp;';    	
	                    if(SHG_DIFF * 1 > 0)      html += '<img src="/resources/yp/images/iic_amount_up.png">'+'<span>'+"₩"+SHG_DIFF+'</span>';
						else if(SHG_DIFF * 1 < 0) html += '<img src="/resources/yp/images/iic_amount_down.png">'+'<span>'+"₩"+SHG_DIFF * -1+'</span>';
	                    html += '</td>';	                   
	                    html += '<td class="right" id="SHG_THIS">￦'+lme_avg[0].SHG+'</td>';
	                    html += '<td class="right" id="SHG_LAST">￦'+lme_avg[1].SHG+'</td>';    
	                    html += '</tr>';
	                    
	                    html += '<tr>';
	                    html += '<td>HG</td>';
	                    html += '<td class="left">';
	                    html += '<label>￦ </label>';    
	                    html += '<input type="text" style="width:100px;" name="lme_hg" id="lme_hg" value="'+NVL(lme[0].HG)+'">&nbsp;&nbsp;';    	
	                    if(HG_DIFF * 1 > 0)      html += '<img src="/resources/yp/images/iic_amount_up.png">'+'<span>'+"₩"+HG_DIFF+'</span>';
						else if(HG_DIFF * 1 < 0) html += '<img src="/resources/yp/images/iic_amount_down.png">'+'<span>'+"₩"+HG_DIFF * -1+'</span>';
	                    html += '</td>';	                   
	                    html += '<td class="right" id="HG_THIS">￦'+lme_avg[0].HG+'</td>';
	                    html += '<td class="right" id="HG_LAST">￦'+lme_avg[1].HG+'</td>';    
	                    html += '</tr>';

				    	$("#lme_table tbody").html(html);
			    	
			    	}else{	//LME 테이블 초기화

			            $("#lme_table tbody").find('input').each(function(){
			                this.value = '';
			            });
			    		
			            $("#lme_table tbody td").find('img').each(function(){
			                $(this).next().remove();
			                $(this).remove();
			            });
			            
			            //이번달,저번달 평균데이터 세팅
			            $("#ZN_THIS").html("$"+lme_avg[0].ZN);
			            $("#ZN_LAST").html("$"+lme_avg[1].ZN);
			            $("#AG_THIS").html("$"+lme_avg[0].AG);
			            $("#AG_LAST").html("$"+lme_avg[1].AG);
			            $("#CU_THIS").html("$"+lme_avg[0].CU);
			            $("#CU_LAST").html("$"+lme_avg[1].CU);
			            $("#PB_THIS").html("$"+lme_avg[0].PB);
			            $("#PB_LAST").html("$"+lme_avg[1].PB);
			            $("#AU_THIS").html("￦ "+lme_avg[0].AU);
			            $("#AU_LAST").html("￦ "+lme_avg[1].AU);
			            $("#SHG_THIS").html("￦ "+lme_avg[0].SHG);
			            $("#SHG_LAST").html("￦ "+lme_avg[1].SHG);
			            $("#HG_THIS").html("￦ "+lme_avg[0].HG);
			            $("#HG_LAST").html("￦ "+lme_avg[1].HG);
			    	}
			    	
			    },
			    beforeSend:function(){
					$('.wrap-loading').removeClass('display-none');
				},
				complete:function(){
			        //$('.wrap-loading').addClass('display-none');
			    },
			    error:function(request,status,error){
			    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
			    	swalDanger("조회에 실패하였습니다.\n관리자에게 문의해주세요.");
			    }
			});
		}
		
		function fnSearchData2(){
			//ASSAY 그리드 데이터 초기화
			typical_scope.gridOptions.data.length = 0;
			invoice_scope.gridOptions.data.length = 0;
			
			//입항스케줄 그리드 리로드
			scope.reloadGrid(gPostArray($("#frm").serializeArray()));
		}
		
		function fnAssayHeader(){
			//form데이터에 그리드데이터 json으로 변환 및 추가해서 서버로 전송
			var data = $("#frm").serializeArray();
			//data.push({name: "gridData", value: JSON.stringify(selectedRows)})

			$.ajax({
			    url: "/yp/zmm/raw/AssayList",
			    type: "POST",
			    cache:false,
			    async:true, 
			    dataType:"json",
			    data:data,
			    success: function(result) {
			    	var col_list = new Array();
			    	$.each(result.list, function(i, d){
						//그리드 컬럼 정의
			    		var col = new Object();
						col.displayName    = result.list[i].COMPONENT;
						col.field          = result.list[i].TEST_CD;
						col.width          = "120";
						col.enableCellEdit = true;
						col.allowCellFocus = true;
						col_list.push(col);
					});
			    	typical_scope.gridOptions.columnDefs = col_list;
			    	invoice_scope.gridOptions.columnDefs = col_list;
			    	typical_scope.gridApi.core.notifyDataChange(typical_scope.uiGridConstants.dataChange.ALL);
			    	invoice_scope.gridApi.core.notifyDataChange(invoice_scope.uiGridConstants.dataChange.ALL);
		    	},
				beforeSend:function(){
					$('.wrap-loading').removeClass('display-none');
				},
				complete:function(){
			        $('.wrap-loading').addClass('display-none');
			    },
			    error:function(request,status,error){
			    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
			    	swalDanger("저장에 실패하였습니다.\n관리자에게 문의해주세요.");
			    }
			});
		}
		
	</script>
	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
</body>