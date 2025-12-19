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
<title>성분분석 최종 결과 등록 [현재 사용하지 않음]</title>
</head>
<body>
	<form id="frm" name="frm" method="post">
		<!-- 20191023_khj for csrf -->
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
	<h2>
		성분분석 최종 결과 등록
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
							<option value="ALL">전체</option>
 						</select>
					</td>
					<th>업체명</th>
					<td>
						<select name="mining_id">
							<option value="ALL">전체</option>
 						</select>
					</td>
					<th>입항일자</th>
					<td>
						<input type="text" class="calendar dtp" name="sdate" id="sdate" size="10" value="${req_data.sdate}">
					</td>
				</tr>
				<tr>
					<th>선박명</th>
					<td colspan="3">
						<input type="text" name="worker_name" >
					</td>
					<th>LOT수</th>
					<td>
						<select name="lot_count">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
							<option value="31">31</option>
							<option value="32">32</option>
							<option value="33">33</option>
							<option value="34">34</option>
							<option value="35">35</option>
							<option value="36">36</option>
							<option value="37">37</option>
							<option value="38">38</option>
							<option value="39">39</option>
							<option value="40">40</option>
							<option value="41">41</option>
							<option value="42">42</option>
							<option value="43">43</option>
							<option value="44">44</option>
							<option value="45">45</option>
							<option value="46">46</option>
							<option value="47">47</option>
							<option value="48">48</option>
							<option value="49">49</option>
							<option value="50">50</option>
							<option value="51">51</option>
							<option value="52">52</option>
							<option value="53">53</option>
							<option value="54">54</option>
							<option value="55">55</option>
							<option value="56">56</option>
							<option value="57">57</option>
							<option value="58">58</option>
							<option value="59">59</option>
							<option value="60">60</option>
 						</select>
					</td>
				</tr>
				<tr>
				</tr>
			</table>
			<div class="btn_wrap">
				<button class="btn btn_make" id="excel_btn" type="">엑셀 다운로드</button>
				<button class="btn btn_search" id="search_btn" type="">등록</button>
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
		var l_Result_1 = 0;
		var l_Result_2 = 0;
		var l_Result_3 = 0;
		var l_Result_4 = 0;
		var l_Result_5 = 0;
		var l_Result_6 = 0;
		var l_Result_7 = 0;
		var l_Result_8 = 0;

		var l_Result_11 = 0;
		var l_Result_12 = 0;
		var l_Result_13 = 0;
		var l_Result_14 = 0;
		var l_Result_15 = 0;
		var l_Result_16 = 0;
		var l_Result_17 = 0;
		var l_Result_18 = 0;

		//	용탕잔량
		var l_InValue_1 = 0;
		//	용탕품위
		var l_InValue_2 = 0;
		//	투입 Lot 수
		var l_InLotVal = new Array();
		//	Lot당 무게
		var l_MultipleVal = new Array();
		//	제품별 ppm
		var l_InPpm = new Array();

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
			
			$scope.formatter_machine_id = function(str_machine_id) {
				var ret_str;
				
				switch(str_machine_id) {
				case '1':
					ret_str = '1공장 #1';
					break;
				case '2':
					ret_str = '1공장 #2';
					break;
				case '3':
					ret_str = '2공장 #1';
					break;
				case '4':
					ret_str = '2공장 #2';
					break;
				case '5':
					ret_str = '2공장 #3';
					break;
				default:
					ret_str = str_machine_id;
					break;
				}

				return ret_str;
			};

			$scope.formatter_product_str = function(str_lot_cnt, str_weight, str_result) {
				var ret_str, result_str;

				if((str_result === null) || (str_result == '0')) result_str = 'N/A';
				else result_str = str_result;

				ret_str = str_lot_cnt + ' / ' + str_weight + 't / ('+ result_str + ')';

				return ret_str;
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

			$scope.formatter_job_time = function(str_hour_index) {
				var ret_str = '';

				if (str_hour_index.length === 1) {
					ret_str = '0' + str_hour_index + ':00';
				} else {
					ret_str = str_hour_index + ':00';
				}
				
				return ret_str;
			};

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
					displayName : '광종명',
					field : 'JOB_DATE',
					width : '250',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_datetime(row.entity.JOB_DATE)}}</div>'
				}, {
					displayName : '업체명',
					field : 'JOB_TIME',
					width : '250',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_job_time(row.entity.JOB_TIME)}}</div>'
				}, {
					displayName : '입항일자',
					field : 'MACHINE_NO',
					width : '250',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_machine_id(row.entity.MACHINE_NO)}}</div>'
				}, {
					displayName : '선박명',
					field : 'WORKER',
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
			
			$scope.formatter_machine_id = function(str_machine_id) {
				var ret_str;
				
				switch(str_machine_id) {
				case '1':
					ret_str = '1공장 #1';
					break;
				case '2':
					ret_str = '1공장 #2';
					break;
				case '3':
					ret_str = '2공장 #1';
					break;
				case '4':
					ret_str = '2공장 #2';
					break;
				case '5':
					ret_str = '2공장 #3';
					break;
				default:
					ret_str = str_machine_id;
					break;
				}

				return ret_str;
			};

			$scope.formatter_product_str = function(str_lot_cnt, str_weight, str_result) {
				var ret_str, result_str;

				if((str_result === null) || (str_result == '0')) result_str = 'N/A';
				else result_str = str_result;

				ret_str = str_lot_cnt + ' / ' + str_weight + 't / ('+ result_str + ')';

				return ret_str;
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

			$scope.formatter_job_time = function(str_hour_index) {
				var ret_str = '';

				if (str_hour_index.length === 1) {
					ret_str = '0' + str_hour_index + ':00';
				} else {
					ret_str = str_hour_index + ':00';
				}
				
				return ret_str;
			};

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
					field : 'JOB_DATE',
					width : '120',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_datetime(row.entity.JOB_DATE)}}</div>'
				}, {
					displayName : '초기 Zn(%)',
					field : 'JOB_TIME',
					width : '160',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_job_time(row.entity.JOB_TIME)}}</div>'
				}, {
					displayName : '초기 Ag(%)',
					field : 'MACHINE_NO',
					width : '160',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_machine_id(row.entity.MACHINE_NO)}}</div>'
				}, {
					displayName : '초기 Au(%)',
					field : 'WORKER',
					width : '160',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '최종 Zn(%)',
					field : 'JOB_TIME',
					width : '160',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_job_time(row.entity.JOB_TIME)}}</div>'
				}, {
					displayName : '최종 Ag(%)',
					field : 'MACHINE_NO',
					width : '160',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_machine_id(row.entity.MACHINE_NO)}}</div>'
				}, {
					displayName : '최종 Au(%)',
					field : 'WORKER',
					width : '160',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '차이 Zn(%)',
					field : 'JOB_TIME',
					width : '160',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_job_time(row.entity.JOB_TIME)}}</div>'
				}, {
					displayName : '차이 Ag(%)',
					field : 'MACHINE_NO',
					width : '160',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_machine_id(row.entity.MACHINE_NO)}}</div>'
				}, {
					displayName : '차이 Au(%)',
					field : 'WORKER',
					width : '160',
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

						$('select[name="mining_id"]').append("<option value='" + seller_id + "'>" + seller_name + "</option>");
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

			l_InPpm[0] = 20.0;
			l_InPpm[1] = 20.0;
			l_InPpm[2] = 40.0;
			l_InPpm[3] = 40.0;
			l_InPpm[4] = 40.0;
			l_InPpm[5] = 40.0;
			l_InPpm[6] = 40.0;
			l_InPpm[7] = 40.0;
			
			l_MultipleVal[0] = 3.0;
			l_MultipleVal[1] = 1.5;
			l_MultipleVal[2] = 3.0;
			l_MultipleVal[3] = 3.0;
			l_MultipleVal[4] = 1.5;
			l_MultipleVal[5] = 1.0;
			l_MultipleVal[6] = 3.0;
			l_MultipleVal[7] = 3.0;

			get_Values();

			var scope;

			// 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
			scope = angular.element(document.getElementById("shds-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
			scope.gridApi.selection.on.rowSelectionChanged(scope, function(row) { //로우 선택할때마다 이벤트
				//	console.log("row2", row.entity);
			});
			scope.gridApi.selection.on.rowSelectionChangedBatch(scope, function(rows) { //전체선택시 가져옴
				// 	console.log("row3", rows[0].entity); //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
			});
			// pagenation option setting  그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param = {
				listQuery : "yp_zpp.zpp_ctd_cathode_list", //list가져오는 마이바티스 쿼리 아이디
				cntQuery : "yp_zpp.zpp_ctd_cathode_list_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
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
				xlsForm.action = "/yp/xls/zhr/tna/zhr_tna_ot_create";

				document.body.appendChild(xlsForm);

				xlsForm.appendChild(csrf_element);

				var pr = {
					emp_code : "${req_data.emp_code}",
					emp_name : "${req_data.emp_name}",
					user_deptcd : "${req_data.user_deptcd}",
					user_dept : "${req_data.user_dept}",
					ofc_name : "${req_data.ofc_name}",
					auth : "${req_data.auth}",
					sdate : $("input[name=sdate]").val(),
					edate : $("input[name=edate]").val(),
					ser_teamname : $("select[name=ser_teamname]").val(),
					ser_group : $("select[name=ser_group]").val(),
					ser_shift : $("select[name=ser_shift]").val(),
					ser_name : $("input[name=ser_name]").val()
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
				}, 5000); //5초
			});

			// 캐소드 블렌딩 예측 등록
			$("#fnAddRow").on("click", function() {
				var form    = document.createElement("form");
				var input0   = document.createElement("input");
				input0.name  = "_csrf";
				input0.value = "${_csrf.token}";
				input0.type  = "hidden";

				var popupX = (document.body.offsetWidth - 1400) / 2;
				var popupY = (document.body.offsetHeight - 500) / 2;

				window.open("","register_popup","width=1400,height=500,left=" + popupX + ",top=" + popupY + ",scrollbars=yes");
				
				form.method = "post";
				form.target = "register_popup"
				form.action = "/yp/popup/zpp/ctd/zpp_ctd_register_popup";
				
				form.appendChild(input0);

				document.body.appendChild(form);
				
				form.submit();
				form.remove();
			});

			// 선택 저장
			$("#fnReg").on("click", function() {
			});
		});

		function get_Values() {
			$.ajax({
				url : "/yp/zpp/ctd/zpp_ctd_envdata",
				type : "POST",
			    cache:false,
			    async:true, 
				data : {
					_csrf : '${_csrf.token}'
					},
				dataType : "json",
				success : function(result) {
					//	console.log("/yp/zpp/ctd/zpp_ctd_envdata success : " + result.REG_DATE + "," + result.M1_LOT_WEIGHT);

					l_InPpm[0] = result.M1_PPM_LEVEL;
					l_InPpm[1] = result.M2_PPM_LEVEL;
					l_InPpm[2] = result.M3_PPM_LEVEL;
					l_InPpm[3] = result.M4_PPM_LEVEL;
					l_InPpm[4] = result.M5_PPM_LEVEL;
					l_InPpm[5] = result.M6_PPM_LEVEL;
					l_InPpm[6] = result.M7_PPM_LEVEL;
					l_InPpm[7] = result.M8_PPM_LEVEL;
					
					l_MultipleVal[0] = result.M1_LOT_WEIGHT;
					l_MultipleVal[1] = result.M2_LOT_WEIGHT;
					l_MultipleVal[2] = result.M3_LOT_WEIGHT;
					l_MultipleVal[3] = result.M4_LOT_WEIGHT;
					l_MultipleVal[4] = result.M5_LOT_WEIGHT;
					l_MultipleVal[5] = result.M6_LOT_WEIGHT;
					l_MultipleVal[6] = result.M7_LOT_WEIGHT;
					l_MultipleVal[7] = result.M8_LOT_WEIGHT;

					//	console.log("data : " + l_InPpm[0] + "," + l_MultipleVal[0] + ","  + l_InPpm[1] + "," + l_MultipleVal[1] + ","  + l_InPpm[2] + "," + l_MultipleVal[2]);
				},
				error : function(request, status, error) {
					//	console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
				}
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