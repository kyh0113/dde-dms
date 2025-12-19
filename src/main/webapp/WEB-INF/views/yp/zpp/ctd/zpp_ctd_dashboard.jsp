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
<title>캐소드 블렌딩 등록 조회</title>
</head>
<body>
	<form id="frm" name="frm" method="post">
		<!-- 20191023_khj for csrf -->
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
	<h2>
		캐소드 블렌딩 등록 조회
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
					<th>검색기간</th>
					<td>
						<input type="text" class="calendar dtp" name="sdate" id="sdate" size="10" value="${req_data.sdate}">
						~
						<input type="text" class="calendar dtp" name="edate" id="edate" size="10" value="${req_data.edate}">
					</td>
					<th>용탕번호</th>
					<td>
						<select name="machine_id">
							<option value="A">전체</option>
							<option value="1">1공장 #1 - 1,000 kW</option>
							<option value="2">1공장 #2 - 1,600 kW</option>
							<option value="3">2공장 #1 - 2,200 kW</option>
							<option value="4">2공장 #2 - 2,200 kW</option>
							<option value="5">2공장 #3 - 2,200 kW</option>
 						</select>
					</td>
					<th>조업자</th>
					<td colspan="3">
						<input type="text" name="worker_name" >
					</td>
				</tr>
				<tr>
					<th>투입시각</th>
					<td>
						<select name="hour_index">
							<option value="A">전체</option>
							<option value="1">01:00</option>
							<option value="2">02:00</option>
							<option value="3">03:00</option>
							<option value="4">04:00</option>
							<option value="5">05:00</option>
							<option value="6">06:00</option>
							<option value="7">07:00</option>
							<option value="8">08:00</option>
							<option value="9">09:00</option>
							<option value="10">10:00</option>
							<option value="11">11:00</option>
							<option value="12">12:00</option>
							<option value="13">13:00</option>
							<option value="14">14:00</option>
							<option value="15">15:00</option>
							<option value="16">16:00</option>
							<option value="17">17:00</option>
							<option value="18">18:00</option>
							<option value="19">19:00</option>
							<option value="20">20:00</option>
							<option value="21">21:00</option>
							<option value="22">22:00</option>
							<option value="23">23:00</option>
							<option value="24">24:00</option>
						</select>
					</td>
				</tr>
				<tr>
				</tr>
			</table>
			<div class="btn_wrap">
				<button class="btn btn_make" id="excel_btn" type="">엑셀 다운로드</button>
				<button class="btn btn_search" id="search_btn" type="">조회</button>
			</div>
		</div>
	</section>
	<div style="height:1px; background-color:white"></div>
	<div class="float_wrap" style="margin-bottom: 2px;">
		<div class="fl">
			<input type=button class="btn_g" id="fnAddRow" value="예측 등록">
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type=button class="btn_g" id="fnReg" value="예측 설정">
			</div>
		</div>
	</div>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
	<canvas id="line-chart" width="800px" height="100px"></canvas>

	<div style="height:30px; background-color:white"></div>

	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="shdsCtrl" style="height: auto;">
			<div data-ui-i18n="ko" style="height: 380px;">
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

		var objLineChart = new Chart(document.getElementById("line-chart"), {
			  type: 'line',
			  data: {
			    labels: [],
			    datasets: [{ 
			        data: [],
			        label: "예상 용탕 품위",
			        borderColor: "#3cba9f",
			        fill: false
			      }
			    ]
			  },
			  options: {
			    title: {
			      display: false,
			      text: '시간별 예상 용탕 품위'
			    }
			  }
			});

		//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
		app.controller('shdsCtrl', [ '$scope', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
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
					displayName : '날짜',
					field : 'JOB_DATE',
					width : '120',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_datetime(row.entity.JOB_DATE)}}</div>'
				}, {
					displayName : '투입',
					field : 'JOB_TIME',
					width : '60',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_job_time(row.entity.JOB_TIME)}}</div>'
				}, {
					displayName : '용탕NO',
					field : 'MACHINE_NO',
					width : '80',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_machine_id(row.entity.MACHINE_NO)}}</div>'
				}, {
					displayName : '조업자',
					field : 'WORKER',
					width : '90',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '잔량',
					field : 'REMAIN_AMOUNT',
					width : '70',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '품위',
					field : 'REMAIN_LEVEL',
					width : '70',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '예상',
					field : 'PREDICT_LEVEL',
					width : '70',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '합계',
					field : 'M1_LOT_CNT',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '고품위 대형',
					field : 'M1_LOT_CNT',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_product_str(row.entity.M1_LOT_CNT, row.entity.M1_WEIGHT, row.entity.M1_RESULT)}}</div>'
				}, {
					displayName : '고품위 소형',
					field : 'M2_LOT_CNT',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_product_str(row.entity.M2_LOT_CNT, row.entity.M2_WEIGHT, row.entity.M2_RESULT)}}</div>'
				}, {
					displayName : '1차분 대형',
					field : 'M3_LOT_CNT',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_product_str(row.entity.M3_LOT_CNT, row.entity.M3_WEIGHT, row.entity.M3_RESULT)}}</div>'
				}, {
					displayName : '2차분 대형',
					field : 'M4_LOT_CNT',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_product_str(row.entity.M4_LOT_CNT, row.entity.M4_WEIGHT, row.entity.M4_RESULT)}}</div>'
				}, {
					displayName : '저품위 소형',
					field : 'M5_LOT_CNT',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_product_str(row.entity.M5_LOT_CNT, row.entity.M5_WEIGHT, row.entity.M5_RESULT)}}</div>'
				}, {
					displayName : '불량잉곳',
					field : 'M6_LOT_CNT',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_product_str(row.entity.M6_LOT_CNT, row.entity.M6_WEIGHT, row.entity.M6_RESULT)}}</div>'
				}, {
					displayName : '화성화조 대형',
					field : 'M7_LOT_CNT',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_product_str(row.entity.M7_LOT_CNT, row.entity.M7_WEIGHT, row.entity.M7_RESULT)}}</div>'
				}, {
					displayName : '화성화조 소형',
					field : 'M8_LOT_CNT',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_product_str(row.entity.M8_LOT_CNT, row.entity.M8_WEIGHT, row.entity.M8_RESULT)}}</div>'
				}]
			});

			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  
		} ]);
		$(document).ready(function() {
			
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
				// 				console.log("row3", rows[0].entity); //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
			});
			//scope.gridApi.selection.on.rowSelectionChanged: function (scope, row, evt) {
			//	console.log('select : ' + row);
            //});
			// pagenation option setting  그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param = {
				listQuery : "yp_zpp.zpp_ctd_cathode_list", //list가져오는 마이바티스 쿼리 아이디
				cntQuery : "yp_zpp.zpp_ctd_cathode_list_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			scope.gridApi.selection.on.rowSelectionChangedBatch(
				scope,
				function(rows)
				{	//전체선택시 가져옴
					//	console.log(rows);           //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
		    	}
			);
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
				var sdate_var = $("input[name=sdate]").val();
				var sdate_str = sdate_var.substring(0, 4) + sdate_var.substring(5, 7) + sdate_var.substring(8, 10) + "000000";
				var edate_var = $("input[name=edate]").val();
				var edate_str = edate_var.substring(0, 4) + edate_var.substring(5, 7) + edate_var.substring(8, 10) + "235959";

				scope.reloadGrid({
					sdate : sdate_str,
					edate : edate_str,
					machine_id : $("select[name=machine_id]").val(),
					worker_name : $("input[name=worker_name]").val(),
					hour_index : $("select[name=hour_index]").val()
				});

				//	graph update
				$.ajax({
					url : "/yp/zpp/ctd/zpp_ctd_graph_list",
					type : "POST",
				    cache:false,
				    async:true, 
					data : {
						sdate : sdate_str,
						edate : edate_str,
						machine_id : $("select[name=machine_id]").val(),
						worker_name : $("input[name=worker_name]").val(),
						hour_index : $("select[name=hour_index]").val(),
						_csrf : '${_csrf.token}'
						},
					dataType : "json",
					success : function(result) {
						var gl = result.graphList;

						objLineChart.data.labels.splice(0, objLineChart.data.labels.length);//라벨 삭제

						//데이터 삭제
						objLineChart.data.datasets.forEach(function(dataset) {
							dataset.data.pop();
						});

						objLineChart.data.datasets.splice(-1);

						objLineChart.update();

				        var newDataset = {
							label: '예상 용탕 품위',
							borderColor : '#3cba9f',
							data: [],
							fill: false
						};

						for(var i in gl) {
							var time_str = gl[i].JOB_DATE;
							var disp_str;

							disp_str = time_str.substring(4, 6) + '/' +
								time_str.substring(6, 8) + ' ' +
								((gl[i].JOB_TIME.length === 1) ? ("0" + gl[i].JOB_TIME) : gl[i].JOB_TIME) + ':' + "00";
							objLineChart.data.labels.push(disp_str);

							newDataset.data.push(gl[i].PREDICT_LEVEL);
						}

						objLineChart.data.datasets.push(newDataset);
						objLineChart.update();
					},
					error : function(request, status, error) {
						//	console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
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
					// console.log(k, v);
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
				var form    = document.createElement("form");
				var input0   = document.createElement("input");
				input0.name  = "_csrf";
				input0.value = "${_csrf.token}";
				input0.type  = "hidden";

				var input1   = document.createElement("input");
				input1.name  = "l_Weight_1";
				input1.value = l_MultipleVal[0];
				input1.type  = "hidden";
				
				var input2   = document.createElement("input");
				input2.name  = "l_Weight_2";
				input2.value = l_MultipleVal[1];
				input2.type  = "hidden";
				
				var input3   = document.createElement("input");
				input3.name  = "l_Weight_3";
				input3.value = l_MultipleVal[2];
				input3.type  = "hidden";
				
				var input4   = document.createElement("input");
				input4.name  = "l_Weight_4";
				input4.value = l_MultipleVal[3];
				input4.type  = "hidden";

				var input5   = document.createElement("input");
				input5.name  = "l_Weight_5";
				input5.value = l_MultipleVal[4];
				input5.type  = "hidden";
				
				var input6   = document.createElement("input");
				input6.name  = "l_Weight_6";
				input6.value = l_MultipleVal[5];
				input6.type  = "hidden";

				var input7   = document.createElement("input");
				input7.name  = "l_Weight_7";
				input7.value = l_MultipleVal[6];
				input7.type  = "hidden";

				var input8   = document.createElement("input");
				input8.name  = "l_Weight_8";
				input8.value = l_MultipleVal[7];
				input8.type  = "hidden";

				var input11   = document.createElement("input");
				input11.name  = "l_Ppm_1";
				input11.value = l_InPpm[0];
				input11.type  = "hidden";
				
				var input12   = document.createElement("input");
				input12.name  = "l_Ppm_2";
				input12.value = l_InPpm[1];
				input12.type  = "hidden";
				
				var input13   = document.createElement("input");
				input13.name  = "l_Ppm_3";
				input13.value = l_InPpm[2];
				input13.type  = "hidden";
				
				var input14   = document.createElement("input");
				input14.name  = "l_Ppm_4";
				input14.value = l_InPpm[3];
				input14.type  = "hidden";
				
				var input15   = document.createElement("input");
				input15.name  = "l_Ppm_5";
				input15.value = l_InPpm[4];
				input15.type  = "hidden";
				
				var input16   = document.createElement("input");
				input16.name  = "l_Ppm_6";
				input16.value = l_InPpm[5];
				input16.type  = "hidden";
				
				var input17   = document.createElement("input");
				input17.name  = "l_Ppm_7";
				input17.value = l_InPpm[6];
				input17.type  = "hidden";
				
				var input18   = document.createElement("input");
				input18.name  = "l_Ppm_8";
				input18.value = l_InPpm[7];
				input18.type  = "hidden";
				
				var popupX = (document.body.offsetWidth - 1400) / 2;
				var popupY = (document.body.offsetHeight - 300) / 2;

				window.open("","setup_popup","width=1400,height=300,left=" + popupX + ",top=" + popupY + ",scrollbars=yes");
				
				form.method = "post";
				form.target = "setup_popup"
				form.action = "/yp/popup/zpp/ctd/zpp_ctd_setup_popup";
				
				form.appendChild(input0);

				form.appendChild(input1);
				form.appendChild(input2);
				form.appendChild(input3);
				form.appendChild(input4);
				form.appendChild(input5);
				form.appendChild(input6);
				form.appendChild(input7);
				form.appendChild(input8);
				
				form.appendChild(input11);
				form.appendChild(input12);
				form.appendChild(input13);
				form.appendChild(input14);
				form.appendChild(input15);
				form.appendChild(input16);
				form.appendChild(input17);
				form.appendChild(input18);

				document.body.appendChild(form);
				
				form.submit();
				form.remove();
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