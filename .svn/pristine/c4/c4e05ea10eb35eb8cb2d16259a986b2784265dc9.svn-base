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
<title>Seller 송부용 분석 결과 조회 [현재는 사용하지 않음]</title>
</head>
<body>
	<form id="frm" name="frm" method="post">
		<!-- 20191023_khj for csrf -->
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
	<h2>
		Seller 송부용 분석 결과 조회
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
					<th>광종명</th>
					<td>
						<select name="ore_id">
 						</select>
					</td>
					<th>업체명</th>
					<td>
						<select name="seller_id">
							<option value="ALL">전체</option>
 						</select>
					</td>
					<th>입항일자</th>
					<td>
						<input type="text" class="calendar dtp" name="sdate" id="sdate" size="10" value="${req_data.sdate}">
						~
						<input type="text" class="calendar dtp" name="edate" id="edate" size="10" value="${req_data.edate}">
					</td>
				</tr>
				<tr>
					<th>선박명</th>
					<td colspan="3">
						<input type="text" name="worker_name" >
					</td>
				</tr>
			</table>
			<div class="btn_wrap">
				<button class="btn btn_make" id="excel_btn" type="">엑셀 다운로드</button>
				<button class="btn btn_search" id="register_btn" type="">등록</button>
				<button class="btn btn_search" id="search_btn" type="">조회</button>
			</div>
		</div>
	</section>
	<div style="height:1px; background-color:white"></div>

	<div style="height:30px; background-color:white"></div>

	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="list-uiGrid" data-ng-controller="listCtrl" style="height: auto;">
			<div data-ui-i18n="ko" style="height: 220px;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter ui-grid-pinning>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
	</section>

	<div class="float_wrap" style="margin-bottom: 2px;">
		<div class="fl">
			<input type=button class="btn_g" id="fnAddRow" value="수정">
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type=button class="btn_g" id="fnReg" value="등록 완료">
			</div>
		</div>
	</div>

	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="data-uiGrid" data-ng-controller="dataCtrl" style="height: auto;">
			<div data-ui-i18n="ko" style="height: 220px;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter ui-grid-pinning>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
	</section>
	<script>
		var l_MaterialName = new Array();
		var l_MaterialID = new Array();
		var l_SellerName = new Array();
		var l_SellerID = new Array();

		isAdmin = ("SA" == "${req_data.auth}" || "MA" == "${req_data.auth}");
		isEastOffice = "50000021" == "${req_data.user_deptcd}";

		//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
		app.controller('listCtrl', [ '$scope', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
			var vm = this; //this를 vm에 대입, 아래에서 부모의 $scope를 vm에 추가하기 위해 			
			angular.extend(vm, $controller('CodeCtrl', { //CodeCtrl(ui-grid 커스텀 api)를 상속받는다
				// 자식컨트롤러의 vm에 부모 컨트롤러의 $scope를 합, 이로써 자식 컨트롤러에서 부모의 모든 $scope(this)를 사용 할 수 있음
				$scope : $scope
			}));
			var paginationOptions = vm.paginationOptions; //부모의 paginationOptions를 자식의 paginationOptions에 대입,즉시실행 함수

			paginationOptions.pageNumber = 1; //초기 page number
			paginationOptions.pageSize = 10; //초기 한번에 보여질 로우수
			$scope.paginationOptions = paginationOptions;

			$scope.gridApi = vm.gridApi; //외부에서 grid의 클릭이벤트와 같은것들을 쓰기 위해서
			$scope.loader = vm.loader;
			$scope.addRow = vm.addRow;
			$scope.uiGridConstants = uiGridConstants;
			$scope.pagination = vm.pagination;

			// 세션아이드코드 스코프에저장
			$scope.s_emp_code = "${s_emp_code}";

			$scope.formatter_material_name = function(material_id, sheet_id) {
				var sheet_str;
			
				if(sheet_id == "0") sheet_str = "";
				else sheet_str = "(" + sheet_id + ")";

				for(var i = 0;i < l_MaterialID.length;i ++) {
					if(l_MaterialID[i] == material_id) return l_MaterialName[i] + sheet_str;
				}
				return material_id + sheet_str;
			};

			$scope.formatter_seller_name = function(seller_id) {
				for(var i = 0;i < l_SellerID.length;i ++) {
					if(l_SellerID[i] == seller_id) return l_SellerName[i];
				}
				return seller_id;
			};

			$scope.formatter_datetime = function(str_datetime) {
				if (str_datetime.length === 14) {
					var ret_str = 	str_datetime.substring(0,  4) + '/' + str_datetime.substring( 4,  6) + '/' + str_datetime.substring(6, 8) + ' ' + 
									str_datetime.substring(8, 10) + ':' + str_datetime.substring(10, 12);
					return ret_str;
				} else {
					return str_datetime;
				}
			};

			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바

				paginationPageSizes : [ 10, 20, 30, 40, 50, 60, 70 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 10,

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

				columnDefs : [ //컬럼 세팅
				{
					displayName : '광종명',
					field : 'MATERIAL_ID',
					width : '250',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_material_name(row.entity.MATERIAL_ID, row.entity.SHEET)}}</div>'
				}, {
					displayName : '업체명',
					field : 'SELLER_ID',
					width : '250',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_seller_name(row.entity.SELLER_ID)}}</div>'
				}, {
					displayName : '입항일자',
					field : 'IMPORT_DATE',
					width : '250',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '선박명',
					field : 'VESSEL_NAME',
					width : '250',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}]
			});

			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  
		} ]);

		//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
		app.controller('dataCtrl', [ '$scope', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
			var vm = this; //this를 vm에 대입, 아래에서 부모의 $scope를 vm에 추가하기 위해 			
			angular.extend(vm, $controller('CodeCtrl', { //CodeCtrl(ui-grid 커스텀 api)를 상속받는다
				// 자식컨트롤러의 vm에 부모 컨트롤러의 $scope를 합, 이로써 자식 컨트롤러에서 부모의 모든 $scope(this)를 사용 할 수 있음
				$scope : $scope
			}));
			var paginationOptions = vm.paginationOptions; //부모의 paginationOptions를 자식의 paginationOptions에 대입,즉시실행 함수

			paginationOptions.pageNumber = 1; //초기 page number
			paginationOptions.pageSize = 10; //초기 한번에 보여질 로우수
			$scope.paginationOptions = paginationOptions;

			$scope.gridApi = vm.gridApi; //외부에서 grid의 클릭이벤트와 같은것들을 쓰기 위해서
			$scope.loader = vm.loader;
			$scope.addRow = vm.addRow;
			$scope.uiGridConstants = uiGridConstants;
			$scope.pagination = vm.pagination;

			// 세션아이드코드 스코프에저장
			$scope.s_emp_code = "${s_emp_code}";

			$scope.formatter_split_value = function(yp, seller) {
				var c1, c2;

				if(yp == undefined) c1 = 0.0; else c1 = parseFloat(yp);
				if(seller == undefined) c2 = 0.0; else c2 = parseFloat(seller);

				var r = c2 - c1;
				
				return r.toFixed(2);
			};

			$scope.formatter_average_value = function(yp, seller) {
				var c1, c2;

				if(yp == undefined) c1 = 0.0; else c1 = parseFloat(yp);
				if(seller == undefined) c2 = 0.0; else c2 = parseFloat(seller);

				var r = (c2 + c1) / 2.0;
				
				return r.toFixed(2);
			};

			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바

				paginationPageSizes : [ 10, 20, 30, 40, 50, 60, 70 ], //한번에 보여질 로우수 셀렉트리스트	
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
					displayName : 'LOT',
					field : 'LOT_NO',
					width : '120',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'Zn(%)',
					field : 'YP_IG_1',
					width : '160',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
				}, {
					displayName : 'Ag',
					field : 'YP_IG_2',
					width : '160',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'Au',
					field : 'YP_IG_3',
					width : '160',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_split_value(row.entity.YP, row.entity.SELLER)}}</div>'
				}]
			});

			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  
		} ]);

		function getMaterialList()
		{
			$.ajax({
				url : "/yp/zpp/ore/zpp_ore_get_material_list",
				type : "POST",
				cache : false,
				async : false,
				data : {
					_csrf : '${_csrf.token}'
				},
				dataType : "json",
				success : function(result) {
					for (var i in result.listValue) {
						var material_id = result.listValue[i].MATERIAL_ID;
						var material_name = result.listValue[i].MATERIAL_NAME;

						l_MaterialName[i] = material_name;
						l_MaterialID[i] = material_id;

						$('select[name="ore_id"]').append("<option value='" + material_id + "'>" + material_name + "</option>");
					}
				},
				error : function(request, status, error) {
					//	console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
				}
			});
		}

		function getSellerList()
		{
			$.ajax({
				url : "/yp/zpp/ore/zpp_ore_get_seller_list",
				type : "POST",
				cache : false,
				async : false,
				data : {
					_csrf : '${_csrf.token}'
				},
				dataType : "json",
				success : function(result) {
					for (var i in result.listValue) {
						var seller_id = result.listValue[i].SELLER_ID;
						var seller_name = result.listValue[i].SELLER_NAME;

						l_SellerName[i] = seller_name;
						l_SellerID[i] = seller_id;

						$('select[name="seller_id"]').append("<option value='" + seller_id + "'>" + seller_name + "</option>");
					}
				},
				error : function(request, status, error) {
					//	console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
				}
			});
		}

		$(document).ready(function() {
			getMaterialList();
			getSellerList();

			var list_scope;
			var data_scope;

			// 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
			list_scope = angular.element(document.getElementById("list-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
			list_scope.gridApi.selection.on.rowSelectionChanged(list_scope, function(row) {
				//	console.log("master id : " + row.entity.MASTER_ID);
				//	console.log("ingredient id : ", $("select[name=ingredient_id]").val());

				data_scope.reloadGrid({
					master_id : row.entity.MASTER_ID
				});
			});
			list_scope.gridApi.selection.on.rowSelectionChangedBatch(list_scope, function(rows) { //전체선택시 가져옴
				//	console.log("row3", rows[0].entity); //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
			});
			// pagenation option setting  그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param = {
				listQuery : "yp_zpp.zpp_ore_seller_query_list", //list가져오는 마이바티스 쿼리 아이디
				cntQuery : "yp_zpp.zpp_ore_seller_query_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
			};
			list_scope.paginationOptions = customExtend(list_scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝

			data_scope = angular.element(document.getElementById("data-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
			data_scope.gridApi.selection.on.rowSelectionChanged(data_scope, function(row) {
			});
			data_scope.gridApi.selection.on.rowSelectionChangedBatch(data_scope, function(rows) { //전체선택시 가져옴
			});
			// pagenation option setting  그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param2 = {
				listQuery : "yp_zpp.zpp_ore_seller_query_dt_list", //list가져오는 마이바티스 쿼리 아이디
				cntQuery : "yp_zpp.zpp_ore_seller_query_dt_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
			};
			data_scope.paginationOptions = customExtend(data_scope.paginationOptions, param2); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
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
				//	console.log("search_btn clicked");

				var sdate_var = $("input[name=sdate]").val();
				var sdate_str = sdate_var.substring(0, 4) + "-" + sdate_var.substring(5, 7) + "-" + sdate_var.substring(8, 10);
				var edate_var = $("input[name=edate]").val();
				var edate_str = edate_var.substring(0, 4) + "-" + edate_var.substring(5, 7) + "-" + edate_var.substring(8, 10);

				//	console.log("start_date : ", sdate_str);
				//	console.log("end_date : ", edate_str);
				//	console.log("ore_id : ", $("select[name=ore_id]").val());
				//	console.log("seller_id : ", $("select[name=seller_id]").val());

				list_scope.reloadGrid({
					sdate : sdate_str,
					edate : edate_str,
					ore_id : $("select[name=ore_id]").val(),
					seller_id : $("select[name=seller_id]").val()
				});
			});

			// 엑셀 다운로드
			$("#excel_btn").on("click", function() {
			});

			// 선택 저장
			$("#fnReg").on("click", function() {
			});
		});

		function fnTimeForm(time){
			var h = time.substring(0,2);
			var m = time.substring(2,4);
			return h+":"+m;
		}

		function setCookie(name, value, expiredays) {
	        var date = new Date();
	        date.setDate(date.getDate() + expiredays);
	        document.cookie = escape(name) + "=" + escape(value) + "; expires=" + date.toUTCString();
	    }
		
		function getCookie(name) { 
			var cookie = document.cookie;
			//	console.log(cookie);
			if (document.cookie != "") { 
				var cookie_array = cookie.split("; "); 
				for ( var index in cookie_array) { 
					var cookie_name = cookie_array[index].split("="); 
					if (cookie_name[0] == "ot_notice") { 
						return cookie_name[1]; 
					} 
				} 
			} 
			return ; 
		} 

	</script>
	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
</body>