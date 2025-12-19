<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
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

//한달 
Calendar mon = Calendar.getInstance();
mon.add(Calendar.MONTH , -1);
String beforeMonthDay = date.format(mon.getTime());
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>계약 조회</title>
<script type="text/javascript">
	var scope;
	$(document).ready(function() {
		// 부트스트랩 날짜객체
		$(".dtp").datepicker({
			format : "yyyy/mm/dd",
			language : "ko",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		});
		
		//조회조건 default
		//오늘날짜 세팅
		if($("input[name=edate]").val() == ""){
			$("input[name=edate]").val("<%=toDay%>");	
		}
		//1달전 날짜 세팅
		if($("input[name=sdate]").val() == ""){
			$("input[name=sdate]").val("<%=beforeMonthDay%>");
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
		계약 조회
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
	
		<div class="float_wrap">
			<div class="fl">
				<div class="stitle">
				</div>
			</div>
		</div>
		
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<section>
			<div class="tbl_box">
				<table class="contract_standard_table" cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="5%" />
						<col width="25%" />
						<col width="5%" />
						<col width="25%" />
						<col width="5%" />
						<col width="25%" />
					</colgroup>
					<tr>
						<th>지급기준</th>
						<td>
							<select name="PAY_STANDARD" >
								<option value="" >= 전체 =</option>
								<c:forEach var="data" items="${pay_code_list}">
						        	<option value="${data.detail_code}" >${data.detail_name}</option>
						        </c:forEach>
							</select>
						</td>
						<th>WBS코드</th>
						<td>
							<input type="text" name="POSID" id="POSID" value="${req_data.POSID}">
							<a href="#" onclick="fnSearchPopup('1');"><img src="/resources/yp/images/ic_search.png"></a>
						</td>
						<th>계약기간</th>
						<td>
							<input type="text" class="calendar dtp" name="sdate" id="sdate" size="10" value="${req_data.sdate}"/>
							 ~ 
							<input type="text" class="calendar dtp" name="edate" id="edate" size="10" value="${req_data.edate}"/>
						</td>
					</tr>
					<tr>
						<th>계약코드</th>
						<td>
							<input type="text" name="CONTRACT_CODE"/>
							<a href="#" onclick="fnSearchPopup('2');"><img src="/resources/yp/images/ic_search.png"></a>
							<input type="text" name="CONTRACT_NAME" readonly/>
						</td>
						<th>거래처</th>
						<td>
							<input type="text" name="SAP_CODE" size="10" readonly="readonly" style="background-color: #e5e5e5;"/>
							<input type="hidden" name="VENDOR_CODE" size="10"/>
							<a href="#" onclick="fnSearchPopup('3');"><img src="/resources/yp/images/ic_search.png"></a>
							<input type="text" name="VENDOR_NAME" disabled="disabled"  />
						</td>
						<th></th><td></td>
					</tr>
				</table>
				<div class="btn_wrap">
				<button class="btn btn_search" id="search_btn" type="">조회</button>
			</div>
			</div>
		</section>
		
		<div class="float_wrap">
			<div class="fr">
				<div class="btn_wrap" style="margin-bottom:5px;">
					<input type="button" class="btn_g" id="btn_remove" value="삭제"/>
				</div>
			</div>
		</div>
		<section class="section">
			<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
			<div id="shds-uiGrid" data-ng-controller="shdsCtrl">
				<div data-ui-i18n="ko" style="height: 620px;">
					<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
						<div data-ng-if="loader" class="loader"></div>
						<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
					</div>
				</div>
			</div>
			<!-- 복붙영역(html) 끝 -->
		</section>
	</form>
<!----------------------------------------------------------- 공통 & 공수(경비/기타)Grid ----------------------------------------------------->
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
		
		// formater - String yyyyMM -> String yyyy.MM
		$scope.formatter_yyyymm = function(str_date) {
			return str_date.substring(0,4)+"/"+str_date.substring(4,6)
		};

		
		//cellClass
		$scope.cellClassSet = function(grid, row, col, rowRenderIndex, colRenderIndex){
			var className = "";
			switch(col.field){
				
			}

			return className;
		}
		
		//수정 페이지로 이동
		$scope.moveUpdatePage = function(row) {
			
			f_href("/yp/zcs/ctr/zcs_ctr_manh_create", {
				CONTRACT_CODE : row.CONTRACT_CODE,
				hierarchy : "000006"
			});
		};

		
		var columnDefs1 = [
			{
				displayName : '지급기준코드',
				field : 'PAY_STANDARD',
				width : '100',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, 
			{
				displayName : '지급기준',
				field : 'PAY_STANDARD_NAME',
				width : '100',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, 
			{
				displayName : '계약코드',
				field : 'CONTRACT_CODE',
				width : '120',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : '<div class="ui-grid-cell-contents relatvie_box height_full pointer" style="color:blue" ng-dblclick="grid.appScope.moveUpdatePage(row.entity)" ng-model="row.entity.CONTRACT_CODE">{{row.entity.CONTRACT_CODE}}</div>'
			}, 
			{
				displayName : '계약명',
				field : 'CONTRACT_NAME',
				width : '200',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, 
			{
				displayName : 'WBS',
				field : 'WBS_CODE',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, 
			{
				displayName : '계약시작일',
				field : 'CONTRACT_START_DATE',
				width : '120',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, 
			{
				displayName : '계약종료일',
				field : 'CONTRACT_END_DATE',
				width : '120',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			},
			{
				displayName : '거래처',
				field : 'VENDOR_NAME',
				width : '150',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			},
			{
				displayName : '업체코드',
				field : 'VENDOR_CODE',
				width : '100',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			},
			{
				displayName : '계약인원',
				field : 'CONTRACT_PEOPLE_CNT',
				width : '100',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			},
			{
				displayName : '일일필수출근인원',
				field : 'DAILY_REQ_PEOPLE_CNT',
				width : '150',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}
		  ];
		
		
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

			columnDefs : columnDefs1,
			
			onRegisterApi: function( gridApi ) {
			      $scope.gridApi = gridApi;
			 }
		});

		$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
		$scope.reloadGrid = vm.reloadGrid;
		//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  

	} ]);

	$(document).ready(function(){
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
				EXEC_RFC  : "N", // RFC 여부
				cntQuery  : "yp_zcs_ctr.select_grid_construction_subc_cnt", 	
				listQuery : "yp_zcs_ctr.select_grid_construction_subc"
		};
		scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
		//복붙영역(앵귤러 이벤트들 가져오기) 끝
		
		// 부트스트랩 날짜객체 hide
		$(document).on("focus", ".dtp", function() {
			$(this).datepicker({
				format : "yyyy/mm/dd",
				language : "ko",
				todayHighlight : true,
				autoclose : true,
				clearBtn : true,
				updateViewDate : false
			}).on('changeDate', function (ev) {
				$(this).trigger("change");
				$('.datepicker').hide();
			});
		});
		
		// 조회
		$("#search_btn").on("click", function() {
			
			var data = $("#frm").serializeArray();
			var POSID = $("#POSID").val();
			
			//시작&끝 날짜 '/'문자 없애기
			var CONTRACT_START_DATE = $("#sdate").val().replace("/","").replace("/","");
			var CONTRACT_END_DATE = $("#edate").val().replace("/","").replace("/","");
			data.push({name: "CONTRACT_START_DATE", value: CONTRACT_START_DATE});
			data.push({name: "CONTRACT_END_DATE", value: CONTRACT_END_DATE});
			data.push({name: "WBS_CODE", value: POSID});
			scope.reloadGrid(
				gPostArray(data)	
			);
		});
		
		/* 삭제 */
		$("#btn_remove").on("click", function() {
			var selectedRows = scope.gridApi.selection.getSelectedRows();
			if(selectedRows.length === 0){
				swalWarningCB("삭제할 항목을 선택하세요.");
				return false;
			}
			
			//월보테이블에 데이터가 존재하는지 확인
			//존재할경우, 삭제할 수 없음
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			
			//월보테이블에 해당 계약코드 존재유무
			var isExistMonthlyRpt;
			$.ajax({
					url : "/yp/zcs/ctr/select_exist_monthly_rpt",
					type : "POST",
					cache : false,
					async : false, //동기화
					dataType : "json",
					data : {"gridData" : JSON.stringify(selectedRows)},
					success : function(result) {
						isExistMonthlyRpt = result.result;
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
						swalDangerCB("삭제에 실패하였습니다.\n관리자에게 문의해주세요.");
					}
				});
			
			if(isExistMonthlyRpt){
				swalWarningCB("월보에 해당 계약건이 존재합니다.");
				return;
			}
			
			if (confirm("삭제하겠습니까?")) {
				var data = $("#frm").serializeArray();
				data.push({name: "gridData", value: JSON.stringify(selectedRows)});
				
				$.ajax({
					url : "/yp/zcs/ctr/zcs_ctr_manh_read_delete",
					type : "POST",
					cache : false,
					async : true,
					dataType : "json",
					data : data,
					success : function(result) {
						swalSuccessCB(result.result+"건이 삭제 완료됐습니다.");
						$("#search_btn").trigger("click");
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
						swalDangerCB("삭제에 실패하였습니다.\n관리자에게 문의해주세요.");
					}
				});
			}
			
		});
		
	});
	
	/* 팝업 */
	function fnSearchPopup(type) {
		if (type == "1") {
			window.open("/yp/popup/zfi/bud/retrievePOSID","WBS 검색","width=600,height=800,scrollbars=yes");
		}else if(type == "2"){
			window.open("/yp/popup/zcs/ctr/retrieveContarctName","계약명 검색","width=600,height=800,scrollbars=yes");
		}else if(type == "3"){
			window.open("/yp/popup/zcs/ctr/select_working_master_v", "업체 검색", "width=600, height=800");
		}
	}
	
	/* 팝업 submit */
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
			// 				console.log(k, v);
			var el = document.createElement("input");
			el.name = k;
			el.value = v;
			el.type = "hidden";
			popForm.appendChild(el);
		});

		popForm.submit();
		popForm.remove();
	}
	
	/*콤마 추가*/
	function addComma(num) {
		return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}

	/*콤마 제거*/
	function unComma(num) {
		return num.replace(/,/gi, '');
	}
</script>

</body>