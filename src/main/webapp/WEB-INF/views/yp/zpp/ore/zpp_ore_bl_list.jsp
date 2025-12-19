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
<title>정광 심판 이력 종합</title>
</head>
<body>
	<style>
 		.tableWrapper {
            height: 600px;
            overflow: auto;
        }

        #table_2 {
            border: 1px;
            border-collapse: collapse;
        }

        #table_2 th {
            position: sticky;
            top: -1px;
            background-color: lightgray !important;
			border:1px solid #000000;
        }
        
        table {
			border:1px solid #111111;
			text-align:center;
			vertical-align:middle;
		}
		td {
			border:1px solid #000000;
			text-align:center;
			vertical-align:middle;
		}
		.label_cell {
			height:16px; width:100%; border:0; text-align:center;  readonly;
		}

		/* ui-grid header-align CENTER */
		.ui-grid-header-cell{text-align:center !important;}
		.ui-grid-header-cell-label.ng-binding{margin-left:1.2em;}
		.ui-grid-viewport
		{
			overflow-x:hidden !important;
		}
	</style>

	<form id="frm" name="frm" method="post">
		<!-- 20191023_khj for csrf -->
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>

	<h2>
		정광 심판 이력 종합
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
					<col width="20%" />
					<col width="5%" />
					<col width="20%" />
					<col width="5%" />
					<col width="35%" />
				</colgroup>
				<tr>
					<th>광종명</th>
					<td>
						<select name="ore_id" style="width:140px;">
 						</select>
						<select name="sheet_id" style="width:10px;">
							<option value="ALL">전체</option>
							<option value="A">A</option>
							<option value="B">B</option>
							<option value="C">C</option>
							<option value="D">D</option>
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
			</table>
			<div style='height:15px;'></div>
			<div class="btn_wrap">
				<button class="btn btn_excel" id="excel_btn">엑셀 다운로드</button>
				<button class="btn btn_make" id="register_test" type="">시험연구팀 등록</button>
				<button class="btn btn_search" id="search_btn" type="">조회</button>
			</div>
		</div>
	</section>
	<div style="height:1px; background-color:white"></div>

	<div class="float_wrap" style="margin-bottom: 2px;">
		<div class="fl">
			<input type=button class="btn_g" id="fnFunc_1" value="시험연구팀 데이터 조회">
			<input type=button class="btn_g" id="fnFunc_2" value="로트별 수량">
			<input type=button class="btn_g" id="fnFunc_3" value="성분결과등록">
			<input type=button class="btn_g" id="fnFunc_4" value="성분결과조정">
			<input type=button class="btn_g" id="fnFunc_5" value="성분결과조회">
			<input type=button class="btn_g" id="fnFunc_6" value="SELLER분석결과">
			<input type=button class="btn_g" id="fnFunc_7" value="SELLER결과등록">
			<input type=button class="btn_g" id="fnFunc_8" value="SELLER비교조회">
			<input type=button class="btn_g" id="fnFunc_9" value="의뢰대상조회">
			<input type=button class="btn_g" id="fnFunc_10" value="심판판정결과입력">
		</div>
		<div class="fr">
			<input type=button class="btn_g" style="background-color:#D68F4A;" id="fnFunc_12" value="삭제">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type=button class="btn_g" id="fnFunc_11" value="정광심판판정결과조회">
		</div>
	</div>

	<div style="height:10px; background-color:white"></div>

	<div style="overflow:scroll; height:640px;">
		<section class="section">
			<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
			<div id="data-uiGrid-1" data-ng-controller="dataCtrl-1" style="height: auto;width:100%;">
				<div data-ui-i18n="ko" style="height: 600px;">
					<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter ui-grid-pinning>
						<div data-ng-if="loader" class="loader"></div>
						<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
					</div>
				</div>
			</div>
			<!-- 복붙영역(html) 끝 -->
		</section>
	</div>

	<script>
		var l_Sel_Grid_Idx = -1;
		
		var l_MaterialName = new Array();
		var l_MaterialID = new Array();
		var l_SellerName = new Array();
		var l_SellerID = new Array();

		var l_MASTER_ID = '';
		var l_MATERIAL_ID = '';
		var l_SHEET_ID = '';
		var l_SELLER_ID = '';
		var l_IMPORT_DATE = '';
		var l_VESSEL_NAME = '';
		var l_STATUS;

		var l_RxDataList = [];

		isAdmin = ("SA" == "${req_data.auth}" || "MA" == "${req_data.auth}");
		isEastOffice = "50000021" == "${req_data.user_deptcd}";

		function input_1_click(idx) {
			l_MASTER_ID = l_RxDataList[idx].MASTER_ID;
			l_MATERIAL_ID = l_RxDataList[idx].MATERIAL_ID;
			l_SELLER_ID = l_RxDataList[idx].SELLER_ID;
			l_IMPORT_DATE = l_RxDataList[idx].IMPORT_DATE;
			l_SHEET_ID = l_RxDataList[idx].SHEET;

			//	popup_BL_Register(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE, l_SHEET_ID);
			popup_Test_Register(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE, l_SHEET_ID);
		}

		function input_2_click(idx) {
			l_MASTER_ID = l_RxDataList[idx].MASTER_ID;
			l_MATERIAL_ID = l_RxDataList[idx].MATERIAL_ID;
			l_SELLER_ID = l_RxDataList[idx].SELLER_ID;
			l_IMPORT_DATE = l_RxDataList[idx].IMPORT_DATE;
			l_SHEET_ID = l_RxDataList[idx].SHEET;

			popup_Result_Register(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE, l_SHEET_ID);
		}

		function input_3_click(idx) {
			l_MASTER_ID = l_RxDataList[idx].MASTER_ID;
			l_MATERIAL_ID = l_RxDataList[idx].MATERIAL_ID;
			l_SELLER_ID = l_RxDataList[idx].SELLER_ID;
			l_IMPORT_DATE = l_RxDataList[idx].IMPORT_DATE;
			l_SHEET_ID = l_RxDataList[idx].SHEET;

			popup_Register_InitValue(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE, l_SHEET_ID);
		}

		function input_4_click(idx) {
			l_MASTER_ID = l_RxDataList[idx].MASTER_ID;
			l_MATERIAL_ID = l_RxDataList[idx].MATERIAL_ID;
			l_SELLER_ID = l_RxDataList[idx].SELLER_ID;
			l_IMPORT_DATE = l_RxDataList[idx].IMPORT_DATE;
			l_SHEET_ID = l_RxDataList[idx].SHEET;

			popup_Adjust_InitValue(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE, l_SHEET_ID);
		}

		function input_5_click(idx) {
			l_MASTER_ID = l_RxDataList[idx].MASTER_ID;
			l_MATERIAL_ID = l_RxDataList[idx].MATERIAL_ID;
			l_SELLER_ID = l_RxDataList[idx].SELLER_ID;
			l_IMPORT_DATE = l_RxDataList[idx].IMPORT_DATE;
			l_SHEET_ID = l_RxDataList[idx].SHEET;

			popup_Query_FixedValue(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE, l_SHEET_ID);
		}

		function input_6_click(idx) {
			l_MASTER_ID = l_RxDataList[idx].MASTER_ID;
			l_MATERIAL_ID = l_RxDataList[idx].MATERIAL_ID;
			l_SELLER_ID = l_RxDataList[idx].SELLER_ID;
			l_IMPORT_DATE = l_RxDataList[idx].IMPORT_DATE;
			l_VESSEL_NAME = l_RxDataList[idx].VESSEL_NAME;
			l_SHEET_ID = l_RxDataList[idx].SHEET;

			popup_Query_Seller_Send(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE, l_VESSEL_NAME, l_SHEET_ID);
		}

		function input_7_click(idx) {
			l_MASTER_ID = l_RxDataList[idx].MASTER_ID;
			l_MATERIAL_ID = l_RxDataList[idx].MATERIAL_ID;
			l_SELLER_ID = l_RxDataList[idx].SELLER_ID;
			l_IMPORT_DATE = l_RxDataList[idx].IMPORT_DATE;
			l_SHEET_ID = l_RxDataList[idx].SHEET;

			popup_Register_Seller_Result(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE, l_SHEET_ID);
		}

		function input_8_click(idx) {
			l_MASTER_ID = l_RxDataList[idx].MASTER_ID;
			l_MATERIAL_ID = l_RxDataList[idx].MATERIAL_ID;
			l_SELLER_ID = l_RxDataList[idx].SELLER_ID;
			l_IMPORT_DATE = l_RxDataList[idx].IMPORT_DATE;
			l_SHEET_ID = l_RxDataList[idx].SHEET;

			popup_Compare(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE, l_SHEET_ID);
		}

		function input_9_click(idx) {
			l_MASTER_ID = l_RxDataList[idx].MASTER_ID;
			l_MATERIAL_ID = l_RxDataList[idx].MATERIAL_ID;
			l_SELLER_ID = l_RxDataList[idx].SELLER_ID;
			l_IMPORT_DATE = l_RxDataList[idx].IMPORT_DATE;
			l_SHEET_ID = l_RxDataList[idx].SHEET;

			popup_Query_Umpire(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE, l_SHEET_ID);
		}

		function input_10_click(idx) {
			l_MASTER_ID = l_RxDataList[idx].MASTER_ID;
			l_MATERIAL_ID = l_RxDataList[idx].MATERIAL_ID;
			l_SELLER_ID = l_RxDataList[idx].SELLER_ID;
			l_IMPORT_DATE = l_RxDataList[idx].IMPORT_DATE;
			l_SHEET_ID = l_RxDataList[idx].SHEET;

			popup_Umpire_Result(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE, l_SHEET_ID);
		}

		function input_11_click(idx) {
			l_MASTER_ID = l_RxDataList[idx].MASTER_ID;
			l_MATERIAL_ID = l_RxDataList[idx].MATERIAL_ID;
			l_SELLER_ID = l_RxDataList[idx].SELLER_ID;
			l_IMPORT_DATE = l_RxDataList[idx].IMPORT_DATE;
			l_SHEET_ID = l_RxDataList[idx].SHEET;
		}

		function input_12_click(idx) {
			l_MASTER_ID = l_RxDataList[idx].MASTER_ID;
			l_MATERIAL_ID = l_RxDataList[idx].MATERIAL_ID;
			l_SELLER_ID = l_RxDataList[idx].SELLER_ID;
			l_IMPORT_DATE = l_RxDataList[idx].IMPORT_DATE;
			l_SHEET_ID = l_RxDataList[idx].SHEET;
		}

		//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
		app.controller('dataCtrl-1', [ '$scope', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
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

			//	로트별 수량 등록
			$scope.formatter_status_1 = function(status) {
				if(status == 0) return "미등록";
				else return "등록완료";
			};

			//	성분결과초기값등록
			$scope.formatter_status_2 = function(status) {
				if(status < 2) return "미등록";
				else return "등록완료";
			};

			//	성분결과초기값조정
			$scope.formatter_status_3 = function(status) {
				if(status < 3) return "미등록";
				else return "등록완료";
			};

			//	성분결과최종값조회
			$scope.formatter_status_4 = function(status) {
				if(status < 3) return "조회불가";
				else return "조회";
			};

			//	Seller 송부용 분석결과 조회
			$scope.formatter_status_5 = function(status) {
				if(status < 3) return "조회불가";
				else return "조회";
			};

			//	Seller 성분분석 결과등록
			$scope.formatter_status_6 = function(status) {
				if(status < 4) return "미등록";
				else return "등록완료";
			};

			//	Seller 성분분석결과 비교조회
			$scope.formatter_status_7 = function(status) {
				if(status < 4) return "조회불가";
				else return "조회";
			};

			//	정광심판판정의뢰대상조회
			$scope.formatter_status_8 = function(status) {
				if(status < 5) return "조회불가";
				else return "조회";
			};

			//	정광심판판정결과등록
			$scope.formatter_status_9 = function(status) {
				if(status < 7) return "미등록";
				else return "등록완료";
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
				enableRowHeaderSelection : true, //맨앞 컬럼 체크박스 컬럼으로
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
					displayName : '광종',
					field : 'LOT_NO',
					width : '95',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_material_name(row.entity.MATERIAL_ID, row.entity.SHEET)}}</div>'
				}, {
					displayName : 'SELLER',
					field : 'DMT',
					width : '95',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_seller_name(row.entity.SELLER_ID)}}</div>'
				}, {
					displayName : '입항일',
					field : 'IMPORT_DATE',
					width : '76',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '선박명',
					field : 'VESSEL_NAME',
					width : '133',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '수량(DMT)',
					field : 'DMT',
					width : '95',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '로트별수량',
					field : 'YP',
					width : '109',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_status_1(row.entity.STATUS)}}</div>'
				}, {
					displayName : '성분결과등록',
					field : 'UMPIRE',
					width : '109',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_status_2(row.entity.STATUS)}}</div>'
				}, {
					displayName : '성분결과조정',
					field : 'UMPIRE',
					width : '109',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_status_3(row.entity.STATUS)}}</div>'
				}, {
					displayName : '성분결과조회',
					field : 'UMPIRE',
					width : '109',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_status_4(row.entity.STATUS)}}</div>'
				}, {
					displayName : 'SELLER분석결과',
					field : 'WIN',
					width : '109',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_status_5(row.entity.STATUS)}}</div>'
				}, {
					displayName : 'SELLER결과등록',
					field : 'SETTLE',
					width : '109',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_status_6(row.entity.STATUS)}}</div>'
				}, {
					displayName : 'SELLER비교조회',
					field : 'SETTLE',
					width : '109',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_status_7(row.entity.STATUS)}}</div>'
				}, {
					displayName : '의뢰대상조회',
					field : 'SETTLE',
					width : '109',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_status_8(row.entity.STATUS)}}</div>'
				}, {
					displayName : '심판판정결과',
					field : 'SETTLE',
					width : '109',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_status_9(row.entity.STATUS)}}</div>'
				}]
			});

			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  
		} ]);

		function
		formatter_material_name(material_id, sheet_id) {
			var sheet_str;
			
			if(sheet_id == "0") sheet_str = "";
			else sheet_str = "(" + sheet_id + ")";

			for(var i = 0;i < l_MaterialID.length;i ++) {
				if(l_MaterialID[i] == material_id) return l_MaterialName[i] + sheet_str;
			}
			return material_id + sheet_str;
		};

		function
		formatter_seller_name(seller_id) {
			for(var i = 0;i < l_SellerID.length;i ++) {
				if(l_SellerID[i] == seller_id) return l_SellerName[i];
			}
			return seller_id;
		};

		$(document).ready(function() {
			getMaterialList();
			getSellerList();

			l_MASTER_ID = '';
			l_MATERIAL_ID = '';
			l_SELLER_ID = '';
			l_IMPORT_DATE = '';
			l_SHEET_ID = '';

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
				load_bl_grid();

				//load_bl_list();

				//var sdate_var = $("input[name=sdate]").val();
				//var sdate_str = sdate_var.substring(0, 4) + "-" + sdate_var.substring(5, 7) + "-" + sdate_var.substring(8, 10);
				//var edate_var = $("input[name=edate]").val();
				//var edate_str = edate_var.substring(0, 4) + "-" + edate_var.substring(5, 7) + "-" + edate_var.substring(8, 10);

				//console.log("start_date : ", sdate_str);
				//console.log("end_date : ", edate_str);
				//console.log("ore_id : ", $("select[name=ore_id]").val());
				//console.log("seller_id : ", $("select[name=seller_id]").val());

				//list_scope.reloadGrid({
				//	sdate : sdate_str,
				//	edate : edate_str,
				//	ore_id : $("select[name=ore_id]").val(),
				//	seller_id : $("select[name=seller_id]").val()
				//});
			});

			// 선택 저장
			$("#fnReg").on("click", function() {
			});

			// BL 등록
			$("#register_btn").on("click", function() {
				popup_BL_Register("", "", "", "");
			});

			//	시험연구팀 등록
			$("#register_test").on("click", function() {
				popup_Test_Register("", "", "", "");
			});

			/****************************************엑셀 다운로드 공통 시작****************************************/		
			$("#excel_btn").click(function(e){
				var csrf_element = document.createElement("input");
				csrf_element.name = "_csrf";
				csrf_element.value = "${_csrf.token}";
				csrf_element.type = "hidden";
				//20191023_khj for csrf
				var xlsForm = document.createElement("form");

				xlsForm.target = "xlsx_download";
				xlsForm.name = "sndFrm";
				xlsForm.method = "post";
				xlsForm.action = "/yp/xls/zpp/ore/zpp_ore_bl_xls_list";

				document.body.appendChild(xlsForm);

				xlsForm.appendChild(csrf_element);

				var sdate_var = $("input[name=sdate]").val();
				var sdate_str = sdate_var.substring(0, 4) + "-" + sdate_var.substring(5, 7) + "-" + sdate_var.substring(8, 10);
				var edate_var = $("input[name=edate]").val();
				var edate_str = edate_var.substring(0, 4) + "-" + edate_var.substring(5, 7) + "-" + edate_var.substring(8, 10);

				var pr = {
						sdate : sdate_str,
						edate : edate_str,
						ore_id : $("select[name=ore_id]").val(),
						sheet_id : $("select[name=sheet_id]").val(),
						seller_id : $("select[name=seller_id]").val()
				};

				$.each(pr, function(k, v) {
					//	console.log(k, v);
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
				}, 1000); // 1초
			});
			/****************************************엑셀 다운로드 공통  끝  ****************************************/

			//	fnFunc_1 : 시험연구팀 정보조회
			//	fnFunc_2 : 로트별수량등록
			//	fnFunc_3 : 초기값등록
			//	fnFunc_4 : 초기값조정
			//	fnFunc_5 : 최종값조회
			//	fnFunc_6 : Seller결과조회
			//	fnFunc_7 : Seller결과등록
			//	fnFunc_8 : Seller결과비교
			//	fnFunc_9 : 의뢰대상조회
			//	fnFunc_10 : 판정결과등록
			//	fnFunc_11 : 심판판정결과조회

			//	시험연구팀 등록정보조회
			$("#fnFunc_1").on("click", function() {
				var data_scope_1 = angular.element(document.getElementById("data-uiGrid-1")).scope(); //html id를 통해서 controller scope(this) 가져옴
				var rows = data_scope_1.gridApi.selection.getSelectedRows();

				if(rows.length != 1)
				{
					swalWarning("선택된 항목이 없습니다.");
				}
				else
				{
					popup_Test_Register(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE, l_SHEET_ID);
				}
			});

			//	로트별수량등록
			$("#fnFunc_2").on("click", function() {
				var data_scope_1 = angular.element(document.getElementById("data-uiGrid-1")).scope(); //html id를 통해서 controller scope(this) 가져옴
				var rows = data_scope_1.gridApi.selection.getSelectedRows();

				if(rows.length != 1)
				{
					swalWarning("선택된 항목이 없습니다.");
				}
				else
				{
					popup_Result_Register(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE, l_SHEET_ID);
				}
			});

			//	초기값등록
			$("#fnFunc_3").on("click", function() {
				var data_scope_1 = angular.element(document.getElementById("data-uiGrid-1")).scope(); //html id를 통해서 controller scope(this) 가져옴
				var rows = data_scope_1.gridApi.selection.getSelectedRows();

				if(rows.length != 1)
				{
					swalWarning("선택된 항목이 없습니다.");
				}
				else
				{
					popup_Register_InitValue(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE, l_SHEET_ID);
				}
			});

			//	초기값조정
			$("#fnFunc_4").on("click", function() {
				var data_scope_1 = angular.element(document.getElementById("data-uiGrid-1")).scope(); //html id를 통해서 controller scope(this) 가져옴
				var rows = data_scope_1.gridApi.selection.getSelectedRows();

				if(rows.length != 1)
				{
					swalWarning("선택된 항목이 없습니다.");
				}
				else
				{
					popup_Adjust_InitValue(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE, l_SHEET_ID);
				}
			});

			//	최종값조회
			$("#fnFunc_5").on("click", function() {
				var data_scope_1 = angular.element(document.getElementById("data-uiGrid-1")).scope(); //html id를 통해서 controller scope(this) 가져옴
				var rows = data_scope_1.gridApi.selection.getSelectedRows();

				if(rows.length != 1)
				{
					swalWarning("선택된 항목이 없습니다.");
				}
				else
				{
					popup_Query_FixedValue(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE, l_SHEET_ID);
				}
			});

			//	SELLER송부용결과조회
			$("#fnFunc_6").on("click", function() {
				var data_scope_1 = angular.element(document.getElementById("data-uiGrid-1")).scope(); //html id를 통해서 controller scope(this) 가져옴
				var rows = data_scope_1.gridApi.selection.getSelectedRows();

				if(rows.length != 1)
				{
					swalWarning("선택된 항목이 없습니다.");
				}
				else
				{
					popup_Query_Seller_Send(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE, l_VESSEL_NAME, l_SHEET_ID);
				}
			});

			//	SELLER결과등록
			$("#fnFunc_7").on("click", function() {
				var data_scope_1 = angular.element(document.getElementById("data-uiGrid-1")).scope(); //html id를 통해서 controller scope(this) 가져옴
				var rows = data_scope_1.gridApi.selection.getSelectedRows();

				if(rows.length != 1)
				{
					swalWarning("선택된 항목이 없습니다.");
				}
				else
				{
					popup_Register_Seller_Result(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE, l_SHEET_ID);
				}
			});

			//	SELLER결과비교
			$("#fnFunc_8").on("click", function() {
				var data_scope_1 = angular.element(document.getElementById("data-uiGrid-1")).scope(); //html id를 통해서 controller scope(this) 가져옴
				var rows = data_scope_1.gridApi.selection.getSelectedRows();

				if(rows.length != 1)
				{
					swalWarning("선택된 항목이 없습니다.");
				}
				else
				{
					popup_Compare(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE, l_SHEET_ID);
				}
			});

			//	의뢰대상조회
			$("#fnFunc_9").on("click", function() {
				var data_scope_1 = angular.element(document.getElementById("data-uiGrid-1")).scope(); //html id를 통해서 controller scope(this) 가져옴
				var rows = data_scope_1.gridApi.selection.getSelectedRows();

				if(rows.length != 1)
				{
					swalWarning("선택된 항목이 없습니다.");
				}
				else
				{
					popup_Query_Umpire(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE, l_SHEET_ID);
				}
			});

			//	정광심판판정결과등록
			$("#fnFunc_10").on("click", function() {
				var data_scope_1 = angular.element(document.getElementById("data-uiGrid-1")).scope(); //html id를 통해서 controller scope(this) 가져옴
				var rows = data_scope_1.gridApi.selection.getSelectedRows();

				if(rows.length != 1)
				{
					swalWarning("선택된 항목이 없습니다.");
				}
				else
				{
					popup_Umpire_Result(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE, l_SHEET_ID);
				}
			});

			//	정광심판판정결과조회
			$("#fnFunc_11").on("click",
				function() {
					popup_Query_UmpireList(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE, l_SHEET_ID);
				}
			);

			//	삭제
			$("#fnFunc_12").on("click",
				function()
				{
					var data_scope_1 = angular.element(document.getElementById("data-uiGrid-1")).scope(); //html id를 통해서 controller scope(this) 가져옴
					var rows = data_scope_1.gridApi.selection.getSelectedRows();
	
					if(rows.length != 1)
					{
						swalWarning("선택된 항목이 없습니다.");
					}
					else
					{
						var q_msg =
							"광종:" + formatter_material_name(l_MATERIAL_ID, l_SHEET_ID) + ", " +
							"SELLER:" + formatter_seller_name(l_SELLER_ID) + ", " +
							"입항일:" + l_IMPORT_DATE + "인  " +
							" 자료를 삭제하시겠습니까?";
		
						swal({
							  icon : "info",
							  text: q_msg,
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
											url : "/yp/zpp/ore/zpp_ore_delete_bl",
											type : "POST",
											cache : false,
											async : false,
											data : {
												MASTER_ID : l_MASTER_ID,
												_csrf : '${_csrf.token}'
											},
											dataType : "json",
											success : function(result) {
												swalSuccess("삭제 되었습니다.");
												load_bl_grid();
											},
											error : function(request, status, error) {
												//	console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
											}
										});
								  }
							});
					}
				}
			);
		});

		function set_NS(id, value) {
			//	console.log(id + ":" + value);
			document.getElementById(id).value = value;
		}

		function AddHeader(row, contents)
		{
			var table_data = document.createElement('th');

			table_data.innerHTML = contents;
			row.appendChild(table_data);
		}

		function AddColumn(row, contents)
		{
			var table_data = document.createElement('td');

			table_data.innerHTML = contents;
			row.appendChild(table_data);
		}

		function sel_prv_idx() {
			var data_scope_1 = angular.element(document.getElementById("data-uiGrid-1")).scope(); //html id를 통해서 controller scope(this) 가져옴

			data_scope_1.gridApi.selection.selectRow(data_scope_1.gridOptions.data[l_Sel_Grid_Idx]);
		}

		function load_bl_grid() {
			var data_scope_1;

			data_scope_1 = angular.element(document.getElementById("data-uiGrid-1")).scope(); //html id를 통해서 controller scope(this) 가져옴
			data_scope_1.gridApi.selection.on.rowSelectionChanged(
				data_scope_1,
				function(row)
				{
					l_MASTER_ID = row.entity.MASTER_ID;
					l_MATERIAL_ID = row.entity.MATERIAL_ID;
					l_SELLER_ID = row.entity.SELLER_ID;
					l_IMPORT_DATE = row.entity.IMPORT_DATE;
					l_SHEET_ID = row.entity.SHEET;
					l_VESSEL_NAME = row.entity.VESSEL_NAME;

					l_Sel_Grid_Idx = data_scope_1.gridOptions.data.indexOf(row.entity);

					//	console.log(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE, l_SHEET_ID);
				}
			);
			data_scope_1.gridApi.selection.on.rowSelectionChangedBatch(
				data_scope_1,
				function(rows) { //전체선택시 가져옴
				}
			);
			data_scope_1.gridApi.core.on.rowsRendered(data_scope_1,
				function() {
					if(l_Sel_Grid_Idx != -1) sel_prv_idx();
				}
			);
	       	// pagenation option setting  그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param1 = {
				listQuery : "yp_zpp.zpp_ore_req_bl_list", //list가져오는 마이바티스 쿼리 아이디
				cntQuery :  "yp_zpp.zpp_ore_req_bl_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
			};
			data_scope_1.paginationOptions = customExtend(data_scope_1.paginationOptions, param1); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝

			var sdate_var = $("input[name=sdate]").val();
			var sdate_str = sdate_var.substring(0, 4) + "-" + sdate_var.substring(5, 7) + "-" + sdate_var.substring(8, 10);
			var edate_var = $("input[name=edate]").val();
			var edate_str = edate_var.substring(0, 4) + "-" + edate_var.substring(5, 7) + "-" + edate_var.substring(8, 10);

			data_scope_1.reloadGrid({
				sdate : sdate_str,
				edate : edate_str,
				ore_id : $("select[name=ore_id]").val(),
				sheet_id : $("select[name=sheet_id]").val(),
				seller_id : $("select[name=seller_id]").val()
			});
		}

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

		//	"시험연구팀 등록"
		function popup_Test_Register(MASTER_ID, MATERIAL_ID, SELLER_ID, IMPORT_DATE, SHEET_ID) {
			var form    = document.createElement("form");
			var input0   = document.createElement("input");
			input0.name  = "_csrf";
			input0.value = "${_csrf.token}";
			input0.type  = "hidden";

			var input1   = document.createElement("input");
			input1.name  = "MASTER_ID";
			input1.value = MASTER_ID;
			input1.type  = "hidden";

			var input2   = document.createElement("input");
			input2.name  = "MATERIAL_ID";
			input2.value = MATERIAL_ID;
			input2.type  = "hidden";

			var input3   = document.createElement("input");
			input3.name  = "SELLER_ID";
			input3.value = SELLER_ID;
			input3.type  = "hidden";

			var input4   = document.createElement("input");
			input4.name  = "IMPORT_DATE";
			input4.value = IMPORT_DATE;
			input4.type  = "hidden";

			var input5   = document.createElement("input");
			input5.name  = "SHEET_ID";
			input5.value = SHEET_ID;
			input5.type  = "hidden";

			var popupX = (document.body.offsetWidth - 1200) / 2;
			var popupY = (document.body.offsetHeight - 900) / 2;

			window.open("","test_register_popup","width=" + screen.width + ",height=" + screen.height + ",left=0,top=0" + ",scrollbars=yes");

			form.method = "post";
			form.target = "test_register_popup"
			form.action = "/yp/popup/zpp/ore/zpp_ore_test_register_popup";

			form.appendChild(input0);
			form.appendChild(input1);
			form.appendChild(input2);
			form.appendChild(input3);
			form.appendChild(input4);
			form.appendChild(input5);

			document.body.appendChild(form);

			form.submit();
			form.remove();
		}

		//	"BL등록/조회"
		function popup_BL_Register(MASTER_ID, MATERIAL_ID, SELLER_ID, IMPORT_DATE, SHEET_ID) {
			var form    = document.createElement("form");
			var input0   = document.createElement("input");
			input0.name  = "_csrf";
			input0.value = "${_csrf.token}";
			input0.type  = "hidden";

			var input1   = document.createElement("input");
			input1.name  = "MASTER_ID";
			input1.value = MASTER_ID;
			input1.type  = "hidden";

			var input2   = document.createElement("input");
			input2.name  = "MATERIAL_ID";
			input2.value = MATERIAL_ID;
			input2.type  = "hidden";

			var input3   = document.createElement("input");
			input3.name  = "SELLER_ID";
			input3.value = SELLER_ID;
			input3.type  = "hidden";

			var input4   = document.createElement("input");
			input4.name  = "IMPORT_DATE";
			input4.value = IMPORT_DATE;
			input4.type  = "hidden";

			var input5   = document.createElement("input");
			input5.name  = "SHEET_ID";
			input5.value = SHEET_ID;
			input5.type  = "hidden";

			var popupX = (document.body.offsetWidth - 1200) / 2;
			var popupY = (document.body.offsetHeight - 900) / 2;

			window.open("","request_popup","width=" + screen.width + ",height=" + screen.height + ",left=0,top=0" + ",scrollbars=yes");

			form.method = "post";
			form.target = "request_popup"
			form.action = "/yp/popup/zpp/ore/zpp_ore_request_popup";

			form.appendChild(input0);
			form.appendChild(input1);
			form.appendChild(input2);
			form.appendChild(input3);
			form.appendChild(input4);
			form.appendChild(input5);

			document.body.appendChild(form);

			form.submit();
			form.remove();
		}

		//	"수량등록"
		function popup_Result_Register(MASTER_ID, MATERIAL_ID, SELLER_ID, IMPORT_DATE, SHEET_ID) {
			var form    = document.createElement("form");
			var input0   = document.createElement("input");
			input0.name  = "_csrf";
			input0.value = "${_csrf.token}";
			input0.type  = "hidden";

			var input1   = document.createElement("input");
			input1.name  = "MASTER_ID";
			input1.value = MASTER_ID;
			input1.type  = "hidden";

			var input2   = document.createElement("input");
			input2.name  = "MATERIAL_ID";
			input2.value = MATERIAL_ID;
			input2.type  = "hidden";

			var input3   = document.createElement("input");
			input3.name  = "SELLER_ID";
			input3.value = SELLER_ID;
			input3.type  = "hidden";

			var input4   = document.createElement("input");
			input4.name  = "IMPORT_DATE";
			input4.value = IMPORT_DATE;
			input4.type  = "hidden";

			var input5   = document.createElement("input");
			input5.name  = "SHEET_ID";
			input5.value = SHEET_ID;
			input5.type  = "hidden";

			var popupX = (document.body.offsetWidth - 1200) / 2;
			var popupY = (document.body.offsetHeight - 900) / 2;

			window.open("","register_popup","width=" + screen.width + ",height=" + screen.height + ",left=0,top=0" + ",scrollbars=yes");

			form.method = "post";
			form.target = "register_popup"
			form.action = "/yp/popup/zpp/ore/zpp_ore_register_popup";

			form.appendChild(input0);
			form.appendChild(input1);
			form.appendChild(input2);
			form.appendChild(input3);
			form.appendChild(input4);
			form.appendChild(input5);

			document.body.appendChild(form);

			form.submit();
			form.remove();
		}

		//	"초기값 등록"
		function popup_Register_InitValue(MASTER_ID, MATERIAL_ID, SELLER_ID, IMPORT_DATE, SHEET_ID) {
			var form    = document.createElement("form");
			var input0   = document.createElement("input");
			input0.name  = "_csrf";
			input0.value = "${_csrf.token}";
			input0.type  = "hidden";

			var input1   = document.createElement("input");
			input1.name  = "MASTER_ID";
			input1.value = MASTER_ID;
			input1.type  = "hidden";
			
			var input2   = document.createElement("input");
			input2.name  = "MATERIAL_ID";
			input2.value = MATERIAL_ID;
			input2.type  = "hidden";
			
			var input3   = document.createElement("input");
			input3.name  = "SELLER_ID";
			input3.value = SELLER_ID;
			input3.type  = "hidden";
			
			var input4   = document.createElement("input");
			input4.name  = "IMPORT_DATE";
			input4.value = IMPORT_DATE;
			input4.type  = "hidden";

			var input5   = document.createElement("input");
			input5.name  = "SHEET_ID";
			input5.value = SHEET_ID;
			input5.type  = "hidden";

			var popupX = (document.body.offsetWidth - 1200) / 2;
			var popupY = (document.body.offsetHeight - 900) / 2;

			window.open("","register_initvalue","width=" + screen.width + ",height=" + screen.height + ",left=0,top=0" + ",scrollbars=yes");

			form.method = "post";
			form.target = "register_initvalue"
			form.action = "/yp/popup/zpp/ore/zpp_ore_init_value";

			form.appendChild(input0);
			form.appendChild(input1);
			form.appendChild(input2);
			form.appendChild(input3);
			form.appendChild(input4);
			form.appendChild(input5);

			document.body.appendChild(form);

			form.submit();
			form.remove();
		}

		//	"초기값 조정"
		function popup_Adjust_InitValue(MASTER_ID, MATERIAL_ID, SELLER_ID, IMPORT_DATE, SHEET_ID) {
			var form    = document.createElement("form");
			var input0   = document.createElement("input");
			input0.name  = "_csrf";
			input0.value = "${_csrf.token}";
			input0.type  = "hidden";

			var input1   = document.createElement("input");
			input1.name  = "MASTER_ID";
			input1.value = MASTER_ID;
			input1.type  = "hidden";
			
			var input2   = document.createElement("input");
			input2.name  = "MATERIAL_ID";
			input2.value = MATERIAL_ID;
			input2.type  = "hidden";
			
			var input3   = document.createElement("input");
			input3.name  = "SELLER_ID";
			input3.value = SELLER_ID;
			input3.type  = "hidden";
			
			var input4   = document.createElement("input");
			input4.name  = "IMPORT_DATE";
			input4.value = IMPORT_DATE;
			input4.type  = "hidden";

			var input5   = document.createElement("input");
			input5.name  = "SHEET_ID";
			input5.value = SHEET_ID;
			input5.type  = "hidden";

			var popupX = (document.body.offsetWidth - 1200) / 2;
			var popupY = (document.body.offsetHeight - 900) / 2;

			window.open("","adjust_initvalue","width=" + screen.width + ",height=" + screen.height + ",left=0,top=0" + ",scrollbars=yes");

			form.method = "post";
			form.target = "adjust_initvalue"
			form.action = "/yp/popup/zpp/ore/zpp_ore_adjust_value";

			form.appendChild(input0);
			form.appendChild(input1);
			form.appendChild(input2);
			form.appendChild(input3);
			form.appendChild(input4);
			form.appendChild(input5);

			document.body.appendChild(form);

			form.submit();
			form.remove();
		}

		//	"최종값 조회"
		function popup_Query_FixedValue(MASTER_ID, MATERIAL_ID, SELLER_ID, IMPORT_DATE, SHEET_ID) {
			var form    = document.createElement("form");
			var input0   = document.createElement("input");
			input0.name  = "_csrf";
			input0.value = "${_csrf.token}";
			input0.type  = "hidden";

			var input1   = document.createElement("input");
			input1.name  = "MASTER_ID";
			input1.value = MASTER_ID;
			input1.type  = "hidden";
			
			var input2   = document.createElement("input");
			input2.name  = "MATERIAL_ID";
			input2.value = MATERIAL_ID;
			input2.type  = "hidden";
			
			var input3   = document.createElement("input");
			input3.name  = "SELLER_ID";
			input3.value = SELLER_ID;
			input3.type  = "hidden";
			
			var input4   = document.createElement("input");
			input4.name  = "IMPORT_DATE";
			input4.value = IMPORT_DATE;
			input4.type  = "hidden";

			var input5   = document.createElement("input");
			input5.name  = "SHEET_ID";
			input5.value = SHEET_ID;
			input5.type  = "hidden";

			var popupX = (document.body.offsetWidth - 1200) / 2;
			var popupY = (document.body.offsetHeight - 900) / 2;

			window.open("","query_fixedvalue","width=" + screen.width + ",height=" + screen.height + ",left=0,top=0" + ",scrollbars=yes");

			form.method = "post";
			form.target = "query_fixedvalue"
			form.action = "/yp/popup/zpp/ore/zpp_ore_fixed_value";

			form.appendChild(input0);
			form.appendChild(input1);
			form.appendChild(input2);
			form.appendChild(input3);
			form.appendChild(input4);
			form.appendChild(input5);

			document.body.appendChild(form);

			form.submit();
			form.remove();
		}

		//	"SELLER 송부용 분석 결과 조회"
		function popup_Query_Seller_Send(MASTER_ID, MATERIAL_ID, SELLER_ID, IMPORT_DATE, VESSEL_NAME, SHEET_ID) {
			//	console.log("popupQuerySellerSend : " + MASTER_ID + " " + MATERIAL_ID + " " + SELLER_ID + " " + IMPORT_DATE + " " + VESSEL_NAME);

			var form    = document.createElement("form");
			var input0   = document.createElement("input");
			input0.name  = "_csrf";
			input0.value = "${_csrf.token}";
			input0.type  = "hidden";

			var input1   = document.createElement("input");
			input1.name  = "MASTER_ID";
			input1.value = MASTER_ID;
			input1.type  = "hidden";
			
			var input2   = document.createElement("input");
			input2.name  = "MATERIAL_ID";
			input2.value = MATERIAL_ID;
			input2.type  = "hidden";
			
			var input3   = document.createElement("input");
			input3.name  = "SELLER_ID";
			input3.value = SELLER_ID;
			input3.type  = "hidden";
			
			var input4   = document.createElement("input");
			input4.name  = "IMPORT_DATE";
			input4.value = IMPORT_DATE;
			input4.type  = "hidden";

			var input5   = document.createElement("input");
			input5.name  = "VESSEL_NAME";
			input5.value = VESSEL_NAME;
			input5.type  = "hidden";

			var input6   = document.createElement("input");
			input6.name  = "SHEET_ID";
			input6.value = SHEET_ID;
			input6.type  = "hidden";

			var popupX = (document.body.offsetWidth - 1200) / 2;
			var popupY = (document.body.offsetHeight - 900) / 2;

			window.open("","query_sellersend","width=" + screen.width + ",height=" + screen.height + ",left=0,top=0" + ",scrollbars=yes");

			form.method = "post";
			form.target = "query_sellersend"
			form.action = "/yp/popup/zpp/ore/zpp_ore_popup_seller_query";

			form.appendChild(input0);
			form.appendChild(input1);
			form.appendChild(input2);
			form.appendChild(input3);
			form.appendChild(input4);
			form.appendChild(input5);
			form.appendChild(input6);

			document.body.appendChild(form);

			form.submit();
			form.remove();
		}

		//	"SELLER 성분 분석 결과 등록"
		function popup_Register_Seller_Result(MASTER_ID, MATERIAL_ID, SELLER_ID, IMPORT_DATE, SHEET_ID) {
			//	console.log("popup_Register_Seller_Result : " + MASTER_ID + " " + MATERIAL_ID + " " + SELLER_ID + " " + IMPORT_DATE);

			var form    = document.createElement("form");
			var input0   = document.createElement("input");
			input0.name  = "_csrf";
			input0.value = "${_csrf.token}";
			input0.type  = "hidden";

			var input1   = document.createElement("input");
			input1.name  = "MASTER_ID";
			input1.value = MASTER_ID;
			input1.type  = "hidden";
			
			var input2   = document.createElement("input");
			input2.name  = "MATERIAL_ID";
			input2.value = MATERIAL_ID;
			input2.type  = "hidden";
			
			var input3   = document.createElement("input");
			input3.name  = "SELLER_ID";
			input3.value = SELLER_ID;
			input3.type  = "hidden";
			
			var input4   = document.createElement("input");
			input4.name  = "IMPORT_DATE";
			input4.value = IMPORT_DATE;
			input4.type  = "hidden";

			var input5   = document.createElement("input");
			input5.name  = "SHEET_ID";
			input5.value = SHEET_ID;
			input5.type  = "hidden";

			var popupX = (document.body.offsetWidth - 1200) / 2;
			var popupY = (document.body.offsetHeight - 900) / 2;

			window.open("","register_seller_result","width=" + screen.width + ",height=" + screen.height + ",left=0,top=0" + ",scrollbars=yes");

			form.method = "post";
			form.target = "register_seller_result"
			form.action = "/yp/popup/zpp/ore/zpp_ore_popup_seller_register";

			form.appendChild(input0);
			form.appendChild(input1);
			form.appendChild(input2);
			form.appendChild(input3);
			form.appendChild(input4);
			form.appendChild(input5);

			document.body.appendChild(form);

			form.submit();
			form.remove();
		}

		//	"SELLER 성분 분석 결과 비교조회"
		function popup_Compare(MASTER_ID, MATERIAL_ID, SELLER_ID, IMPORT_DATE, SHEET_ID) {
			//	console.log("popup_Compare : " + MASTER_ID + " " + MATERIAL_ID + " " + SELLER_ID + " " + IMPORT_DATE);

			var form    = document.createElement("form");
			var input0   = document.createElement("input");
			input0.name  = "_csrf";
			input0.value = "${_csrf.token}";
			input0.type  = "hidden";

			var input1   = document.createElement("input");
			input1.name  = "MASTER_ID";
			input1.value = MASTER_ID;
			input1.type  = "hidden";
			
			var input2   = document.createElement("input");
			input2.name  = "MATERIAL_ID";
			input2.value = MATERIAL_ID;
			input2.type  = "hidden";
			
			var input3   = document.createElement("input");
			input3.name  = "SELLER_ID";
			input3.value = SELLER_ID;
			input3.type  = "hidden";
			
			var input4   = document.createElement("input");
			input4.name  = "IMPORT_DATE";
			input4.value = IMPORT_DATE;
			input4.type  = "hidden";

			var input5   = document.createElement("input");
			input5.name  = "SHEET_ID";
			input5.value = SHEET_ID;
			input5.type  = "hidden";

			var popupX = (document.body.offsetWidth - 1200) / 2;
			var popupY = (document.body.offsetHeight - 900) / 2;

			window.open("","popup_compare","width=" + screen.width + ",height=" + screen.height + ",left=0,top=0" + ",scrollbars=yes");

			form.method = "post";
			form.target = "popup_compare"
			form.action = "/yp/popup/zpp/ore/zpp_ore_popup_compare";

			form.appendChild(input0);
			form.appendChild(input1);
			form.appendChild(input2);
			form.appendChild(input3);
			form.appendChild(input4);
			form.appendChild(input5);

			document.body.appendChild(form);

			form.submit();
			form.remove();
		}

		//	"정광 심판판정 의뢰대상 조회"
		function popup_Query_Umpire(MASTER_ID, MATERIAL_ID, SELLER_ID, IMPORT_DATE, SHEET_ID) {
			//	console.log("popup_Compare : " + MASTER_ID + " " + MATERIAL_ID + " " + SELLER_ID + " " + IMPORT_DATE);

			var form    = document.createElement("form");
			var input0   = document.createElement("input");
			input0.name  = "_csrf";
			input0.value = "${_csrf.token}";
			input0.type  = "hidden";

			var input1   = document.createElement("input");
			input1.name  = "MASTER_ID";
			input1.value = MASTER_ID;
			input1.type  = "hidden";
			
			var input2   = document.createElement("input");
			input2.name  = "MATERIAL_ID";
			input2.value = MATERIAL_ID;
			input2.type  = "hidden";
			
			var input3   = document.createElement("input");
			input3.name  = "SELLER_ID";
			input3.value = SELLER_ID;
			input3.type  = "hidden";
			
			var input4   = document.createElement("input");
			input4.name  = "IMPORT_DATE";
			input4.value = IMPORT_DATE;
			input4.type  = "hidden";

			var input5   = document.createElement("input");
			input5.name  = "SHEET_ID";
			input5.value = SHEET_ID;
			input5.type  = "hidden";

			var popupX = (document.body.offsetWidth - 1200) / 2;
			var popupY = (document.body.offsetHeight - 900) / 2;

			window.open("","popup_query_umpire","width=" + screen.width + ",height=" + screen.height + ",left=0,top=0" + ",scrollbars=yes");

			form.method = "post";
			form.target = "popup_query_umpire"
			form.action = "/yp/popup/zpp/ore/zpp_ore_popup_query_umpire";

			form.appendChild(input0);
			form.appendChild(input1);
			form.appendChild(input2);
			form.appendChild(input3);
			form.appendChild(input4);
			form.appendChild(input5);

			document.body.appendChild(form);

			form.submit();
			form.remove();
		}

		//	"정광 심판판정 의뢰대상 조회"
		function popup_Umpire_Result(MASTER_ID, MATERIAL_ID, SELLER_ID, IMPORT_DATE, SHEET_ID) {
			//	console.log("popup_Compare : " + MASTER_ID + " " + MATERIAL_ID + " " + SELLER_ID + " " + IMPORT_DATE);

			var form    = document.createElement("form");
			var input0   = document.createElement("input");
			input0.name  = "_csrf";
			input0.value = "${_csrf.token}";
			input0.type  = "hidden";

			var input1   = document.createElement("input");
			input1.name  = "MASTER_ID";
			input1.value = MASTER_ID;
			input1.type  = "hidden";
			
			var input2   = document.createElement("input");
			input2.name  = "MATERIAL_ID";
			input2.value = MATERIAL_ID;
			input2.type  = "hidden";
			
			var input3   = document.createElement("input");
			input3.name  = "SELLER_ID";
			input3.value = SELLER_ID;
			input3.type  = "hidden";
			
			var input4   = document.createElement("input");
			input4.name  = "IMPORT_DATE";
			input4.value = IMPORT_DATE;
			input4.type  = "hidden";

			var input5   = document.createElement("input");
			input5.name  = "SHEET_ID";
			input5.value = SHEET_ID;
			input5.type  = "hidden";

			var popupX = (document.body.offsetWidth - 1200) / 2;
			var popupY = (document.body.offsetHeight - 900) / 2;

			window.open("","popup_umpire_result","width=" + screen.width + ",height=" + screen.height + ",left=0,top=0" + ",scrollbars=yes");

			form.method = "post";
			form.target = "popup_umpire_result"
			form.action = "/yp/popup/zpp/ore/zpp_ore_popup_umpire_result";

			form.appendChild(input0);
			form.appendChild(input1);
			form.appendChild(input2);
			form.appendChild(input3);
			form.appendChild(input4);
			form.appendChild(input5);

			document.body.appendChild(form);

			form.submit();
			form.remove();
		}

		//	"정광 심판판정 결과조회"
		function popup_Query_UmpireList(MASTER_ID, MATERIAL_ID, SELLER_ID, IMPORT_DATE, SHEET_ID) {
			//	console.log("popup_Compare : " + MASTER_ID + " " + MATERIAL_ID + " " + SELLER_ID + " " + IMPORT_DATE);

			var form    = document.createElement("form");
			var input0   = document.createElement("input");
			input0.name  = "_csrf";
			input0.value = "${_csrf.token}";
			input0.type  = "hidden";

			var input1   = document.createElement("input");
			input1.name  = "MASTER_ID";
			input1.value = MASTER_ID;
			input1.type  = "hidden";
			
			var input2   = document.createElement("input");
			input2.name  = "MATERIAL_ID";
			input2.value = MATERIAL_ID;
			input2.type  = "hidden";
			
			var input3   = document.createElement("input");
			input3.name  = "SELLER_ID";
			input3.value = SELLER_ID;
			input3.type  = "hidden";
			
			var input4   = document.createElement("input");
			input4.name  = "IMPORT_DATE";
			input4.value = IMPORT_DATE;
			input4.type  = "hidden";

			var input5   = document.createElement("input");
			input5.name  = "SHEET_ID";
			input5.value = SHEET_ID;
			input5.type  = "hidden";

			var popupX = (document.body.offsetWidth - 1200) / 2;
			var popupY = (document.body.offsetHeight - 900) / 2;

			window.open("","popup_umpire_list","width=" + screen.width + ",height=" + screen.height + ",left=0,top=0" + ",scrollbars=yes");

			form.method = "post";
			form.target = "popup_umpire_list"
			form.action = "/yp/popup/zpp/ore/zpp_ore_umpire_list";

			form.appendChild(input0);
			form.appendChild(input1);
			form.appendChild(input2);
			form.appendChild(input3);
			form.appendChild(input4);
			form.appendChild(input5);

			document.body.appendChild(form);

			form.submit();
			form.remove();
		}
		
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

		function parent_function()
		{
	        alert(parent_value);
	    }
		
	</script>
	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
</body>