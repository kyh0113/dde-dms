<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<sec:csrfMetaTags />
	<title>정광 심판 판정 결과 조회</title>
	<script src="/resources/icm/js/jquery.js"></script>
	<script src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
	<script src="/resources/icm/js/custom.js"></script>
	<!-- 기존 프레임워크 리소스 -->
	<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/resources/icm/css/jquery-ui.css" />
	<!-- 2019-12-13 smh jquery-ui.css 변경.끝 -->
	<link href='/resources/icm/css/animate.min.css' rel='stylesheet'>
	<link rel="stylesheet" type="text/css" href="/resources/css/custom.css" />
	<link rel="stylesheet" type="text/css" href="/resources/css/all.min.css" />
	<link rel="stylesheet" href="/resources/icm/jsTree/dist/themes/default/style.min.css" />
	<link href="/resources/icm/datepicker/css/datepicker.css" rel="stylesheet" type="text/css" />
	<link id="bs-css" href="/resources/icm/css/bootstrap.min.css" rel="stylesheet">
	<!-- jQuery -->
	<script src="/resources/icm/js/jquery.js"></script>
	<script src="/resources/icm/js/jquery.validate.min.js"></script>
	<script src="/resources/icm/js/jquery-ui.js"></script>
	<script src="/resources/icm/jsTree/dist/jstree.min.js"></script>
	<script src="/resources/icm/jsTree/dist/customJstree.js"></script>
	<link rel="stylesheet" href="/resources/icm/uigrid/css/ui-grid.min.css" type="text/css">
	<script src="/resources/icm/js/custom.js"></script>
	<script src="/resources/icm/js/multiFile.js"></script>
	<script src="/resources/icm/js/fileList.js"></script>
	<script src="/resources/icm/angular/js/angular.min.js"></script>
	<script src="/resources/icm/angular/js/angular-route.min.js"></script>
	<script src="/resources/icm/uigrid/js/ui-grid.min.js"></script>
	<script src="/resources/icm/uigrid/js/ui-grid.language.ko.js"></script>
	<!-- 2019-08-15 smh 추가 시작.-->
	<!-- 	<script src="/resources/js/jquery.vicurusit.js"></script> -->
	<!-- 2019-08-15 smh 추가 끝-->
	<script src="/resources/icm/uigrid/js/uiGrid1.js"></script>
	<script src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
	<script src="/resources/icm/datepicker/js/bootstrap-datepicker.js"></script>
	<script src="/resources/icm/jsTree/dist/customJstree.js"></script>
	<link rel="stylesheet" type="text/css" href="/resources/font/ng.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/style.css">
	<script type="text/javascript" src="/resources/js/ui.js"></script>
	<!-- 20191227_khj Tooltip Add -->
	<script src="/resources/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="/resources/icm/js/bootstrap.min.js"></script>
	<!-- application script for Charisma demo -->
	<script src="/resources/icm/js/charisma.js"></script>
	<link rel="stylesheet" href="/resources/yp/css/style.css">
	<!-- 기존 프레임워크 리소스 -->
	<!-- 영풍 리소스 -->
	<script src="/resources/yp/js/common.js"></script>
	<style type="text/css">
		/* ui-grid header-align CENTER */
		.ui-grid-header-cell{text-align:center !important;}
		.ui-grid-header-cell-label.ng-binding{margin-left:1.2em;}
		.ui-grid-viewport
		{
			overflow-x:hidden !important;
		}
	</style>
</head>
<body data-ng-app="app">
	<style>
 		.tableWrapper {
            height: 760px;
            overflow: auto;
        }

        #table_2 {
            border: 1px;
            border-collapse: collapse;
        }

        #table_2 th {
            position: sticky;
            top: 0px;
            background-color: lightgray !important;
			border:1px solid #000000;
        }

		table {
		  	border-collapse:collapse;
			border:1px solid #111111;
			text-align:center;
			vertical-align:middle;
		}

		thead {
		  position: fixed;
		  top: 0;
		  background: #cdefff;
		}

		th
		{
		  border:1px solid silver;
		  height: 30px;
		}

		td {
			border:1px solid #000000;
			text-align:center;
			vertical-align:middle;
		}
		.label_cell {
			height:16px; width:100%; border:0; text-align:center;  readonly;
		}
	</style>
	<form id="frm" name="frm" method="post">
		<!-- 20191023_khj for csrf -->
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
	<h2>
		정광 심판 판정 결과 조회
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
						<select name="ore_id" style="width:150px;">
							<option value="ALL">전체</option>
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
			<div class="btn_wrap">
				<button class="btn btn_excel" id="excel_btn">엑셀 다운로드</button>
				<button class="btn btn_search" id="search_btn" type="">조회</button>
			</div>
		</div>
	</section>
	<div style="height:1px; background-color:white"></div>

	<div style="height:10px; background-color:white"></div>

	<div style="overflow:scroll; height:730px;">
		<section class="section">
			<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
			<div id="data-uiGrid-1" data-ng-controller="dataCtrl-1" style="height: auto;width:100%;">
				<div data-ui-i18n="ko" style="height: 680px;">
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
		var l_Rx_List = [];
		var l_MaterialName = new Array();
		var l_MaterialID = new Array();
		var l_SellerName = new Array();
		var l_SellerID = new Array();

		var l_MASTER_ID = '';
		var l_MATERIAL_ID = '';
		var l_SELLER_ID = '';
		var l_IMPORT_DATE ='';

		function AddColumn(row, contents)
		{
			var table_data = document.createElement('td');

			table_data.innerHTML = contents;
			row.appendChild(table_data);
		}

		function cell_click(idx) {
			//	console.log(l_Rx_List[idx].MASTER_ID);
			
			l_MASTER_ID = l_Rx_List[idx].MASTER_ID;
			l_MATERIAL_ID = l_Rx_List[idx].MATERIAL_ID;
			l_SELLER_ID = l_Rx_List[idx].SELLER_ID;
			l_IMPORT_DATE = l_Rx_List[idx].IMPORT_DATE;

			popup_Umpire_Detail(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE);
		}

		//	"UMPIRE 상세조회"
		function popup_Umpire_Detail(MASTER_ID, MATERIAL_ID, SELLER_ID, IMPORT_DATE) {
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

			var popupX = (document.body.offsetWidth - 1200) / 2;
			var popupY = (document.body.offsetHeight - 900) / 2;

			window.open("","umpire_detail","width=" + screen.width + ",height=" + screen.height + ",left=0,top=0" + ",scrollbars=yes");

			form.method = "post";
			form.target = "umpire_detail"
			form.action = "/yp/popup/zpp/ore/zpp_ore_popup_umpire_detail";

			form.appendChild(input0);
			form.appendChild(input1);
			form.appendChild(input2);
			form.appendChild(input3);
			form.appendChild(input4);

			document.body.appendChild(form);

			form.submit();
			form.remove();
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
			paginationOptions.pageSize = 20; //초기 한번에 보여질 로우수
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

			$scope.formatter_avg = function(avg) {
				if(avg == null) return "0";
				else return Number(avg).toFixed(2);
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
				paginationPageSize : 20,

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
					displayName : '광종',
					field : 'LOT_NO',
					width : '140',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_material_name(row.entity.MATERIAL_ID, row.entity.SHEET)}}</div>'
				}, {
					displayName : 'SELLER',
					field : 'DMT',
					width : '150',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_seller_name(row.entity.SELLER_ID)}}</div>'
				}, {
					displayName : '입항일',
					field : 'IMPORT_DATE',
					width : '100',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'LOT',
					field : 'LOT_COUNT',
					width : '45',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'Zn(%)',
					field : 'IG_1_AVG',
					width : '77',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_avg(row.entity.IG_1_AVG)}}</div>'
				}, {
					displayName : '조정',
					field : 'ADJUST_IG_1',
					width : '67',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_avg(row.entity.ADJUST_IG_1)}}</div>'
				}, {
					displayName : 'SPLIT',
					field : 'IG_1_SPLIT',
					width : '67',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'UMPIRE',
					field : 'IG_1_UMPIRE',
					width : '67',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '승',
					field : 'IG_1_WIN',
					width : '67',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '패',
					field : 'IG_1_FAIL',
					width : '67',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'LOT',
					field : 'LOT_COUNT',
					width : '67',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'Ag(g/T)',
					field : 'IG_2_AVG',
					width : '77',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_avg(row.entity.IG_2_AVG)}}</div>'
				}, {
					displayName : '조정',
					field : 'ADJUST_IG_2',
					width : '67',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_avg(row.entity.ADJUST_IG_2)}}</div>'
				}, {
					displayName : 'SPLIT',
					field : 'IG_2_SPLIT',
					width : '67',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'UMPIRE',
					field : 'IG_2_UMPIRE',
					width : '67',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '승',
					field : 'IG_2_WIN',
					width : '67',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '패',
					field : 'IG_2_FAIL',
					width : '67',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'LOT',
					field : 'LOT_COUNT',
					width : '67',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'Au(%)',
					field : 'IG_3_AVG',
					width : '77',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_avg(row.entity.IG_3_AVG)}}</div>'
				}, {
					displayName : '조정',
					field : 'ADJUST_IG_3',
					width : '67',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_avg(row.entity.ADJUST_IG_3)}}</div>'
				}, {
					displayName : 'SPLIT',
					field : 'IG_3_SPLIT',
					width : '67',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'UMPIRE',
					field : 'IG_3_UMPIRE',
					width : '67',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '승',
					field : 'IG_3_WIN',
					width : '67',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '패',
					field : 'IG_3_FAIL',
					width : '67',
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

		$(document).ready(function() {
			//	console.log('document ready');

			getMaterialList();
			getSellerList();

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

				load_master_grid();
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
				xlsForm.action = "/yp/xls/zpp/ore/zpp_ore_umpire_xls_list";
				
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

			// 선택 저장
			$("#fnReg").on("click", function() {
			});
		});

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

		function set_NS(id, value) {
			//	console.log(id + ":" + value);
			if(value == null) document.getElementById(id).value = '';
			else document.getElementById(id).value = value;
		}

		function load_master_grid() {
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

					//	console.log(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE, l_SHEET_ID);

					popup_Umpire_Detail(l_MASTER_ID, l_MATERIAL_ID, l_SELLER_ID, l_IMPORT_DATE);
				}
			);
			data_scope_1.gridApi.selection.on.rowSelectionChangedBatch(
					data_scope_1,
					function(rows) { //전체선택시 가져옴
			});
			// pagenation option setting  그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param1 = {
				listQuery : "yp_zpp.zpp_ore_get_master_list_avg", //list가져오는 마이바티스 쿼리 아이디
				cntQuery :  "yp_zpp.zpp_ore_get_master_list_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
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

	</script>
	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
</body>