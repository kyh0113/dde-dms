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
SimpleDateFormat date = new SimpleDateFormat("yyyy");
int to_yyyy = Integer.parseInt(date.format(today));
// JSTL에서 사용할 수 있도록 세팅
request.setAttribute("to_yyyy", to_yyyy);

Calendar cal = Calendar.getInstance();
cal.set(Calendar.YEAR, 2010);
int from_yyyy = Integer.parseInt(date.format(cal.getTime()));
//JSTL에서 사용할 수 있도록 세팅
request.setAttribute("from_yyyy", from_yyyy);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
.default_hide {
	display: none;
}
</style>
<title>기준정보 등록</title>
</head>
<body>
	<form id="frm" name="frm" method="post">
		<!-- 20191023_khj for csrf -->
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
	<h2>
		기준정보 등록
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
					<th>기준정보</th>
					<td>
						<select id="CODE_TYPE" onchange="javascript: fnDocTypeDisplay(this);">
							<%-- 2021-11 추가개발 - 거래처는 【조업도급 > 출입관리 > 출입업체】메뉴에서 추가하는 것으로 변경 --%>
							<%--<option value="V">거래처</option>--%>
							<option value="W">근무형태</option>
							<option value="N">유해인자</option>
							<option value="P">보호구</option>
<!-- 							<option value="C">업체별 경비항목</option> -->
							<option value="U">단위</option>
						</select>
					</td>
					<th><span class="default_hide">연도</span></th>
					<td>
<!-- 						<select id="BASE_YYYY" class="default_hide" onchange="javascript: $('#search_btn').trigger('click');"> -->
<%-- 							<c:forEach var="i" begin="0" end="${to_yyyy - from_yyyy}">JSTL 역순 출력 - 연도 --%>
<%-- 								<c:set var="yearOption" value="${to_yyyy - i}" /> --%>
<%-- 								<option value="${yearOption}">${yearOption}</option> --%>
<%-- 							</c:forEach> --%>
<!-- 						</select> -->
						<input type="text" id="BASE_YYYY" class="default_hide calendar search_dtp_y" value="${to_yyyy}" readonly="readonly"/>
					</td>
					<th>&nbsp;</th>
					<td>&nbsp;</td>
				</tr>
			</table>
			<div class="btn_wrap">
				<input type=button class="btn btn_search" id="search_btn"		value="조회">
			</div>
		</div>
	</section>
	<div class="float_wrap" style="margin-bottom: 2px;">
		<div class="fl" style="margin-bottom: 10px;">&nbsp;</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type=button class="btn_g" id="fnAdd"		value="추가">
				<input type=button class="btn_g" id="fnDel"		value="삭제">
				<input type=button class="btn_g" id="fnSave"	value="저장">
			</div>
		</div>
	</div>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="shdsCtrl">
			<div data-ui-i18n="ko" style="height: 620px;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter ui-grid-pinning>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
	</section>
	<script>
		//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
		app.controller('shdsCtrl', [ '$scope', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
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

			$scope.pagination = vm.pagination;

			// 세션아이드코드 스코프에저장
			$scope.s_emp_code = "${s_emp_code}";

			$scope.uiGridConstants = uiGridConstants;

			// 금액 콤마
			$scope.fnAddComma = function(row) {
				var d = row.entity.UNIT_PRICE.replace(/[^0-9]/g, '');
				var num = unComma(d);
				num = num * 1;
				row.entity.UNIT_PRICE = addComma(num);
			};
			
			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바

				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 100,

				enableCellEditOnFocus : true, //셀 클릭시 edit모드 
				enableSelectAll : true, //전체선택 체크박스
				enableRowSelection : false, //로우 선택
				enableRowHeaderSelection : true, //맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 27, //체크박스 컬럼 길이
				enableHorizontalScrollbar : "1",
				enableVerticalScrollbar : "1",
				rowHeight : 27, //체크박스 컬럼 높이
				// useExternalPagination : true, //pagination을 직접 세팅
				enableAutoFitColumns : true, //컬럼 width를 자동조정
				multiSelect : true, //여러로우선택
				enablePagination : true,
				enablePaginationControls : true,

				columnDefs : [ //컬럼 세팅
				{
					displayName : 'STATUS',
					field : 'STATUS',
					width : '95',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '코드',
					field : 'CODE',
					width : '75',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '순번',
					field : 'SEQ',
					width : '75',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '연도', /* 보호구 */
					field : 'BASE_YYYY',
					width : '75',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.BASE_YYYY" style="height: inherit;">'
				}, {
					displayName : '항목', /* 거래처 */
					field : 'CODE_NAME',
					width : '200',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.CODE_NAME" style="height: inherit;">'
				}, {
					displayName : '거래처', /* 거래처 */
					field : 'CODE_NAME',
					width : '200',
					visible : false,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.CODE_NAME" style="height: 100%; width: calc(100% - 24px);" readonly="readonly"><img src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(row)">'
				}, {
					displayName : 'SAP코드', /* 거래처 */
					field : 'SAP_CODE',
					width : '95',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '대표자', /* 거래처 */
					field : 'REPRESENTATIVE',
					width : '85',
					visible : false,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.REPRESENTATIVE" style="width: 100%; height: inherit;">'
				}, {
					displayName : '단가', /* 보호구 */
					field : 'UNIT_PRICE',
					width : '75',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.UNIT_PRICE" ng-change="grid.appScope.fnAddComma(row)" style="width: 100%; height: inherit;" >'
				}, {
					displayName : '단위', /* 업체별 경비항목 */
					field : 'UNIT',
					width : '75',
					visible : false,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.UNIT" style="width: 100%; height: inherit;">'
				}, {
					displayName : '업체코드', /* 거래처 */
					field : 'ENTERPRISE_CODE',
					width : '95',
					visible : false,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" ng-model="row.entity.ENTERPRISE_CODE" style="width: 100%; height: inherit;">'
				}, {
					displayName : '구분', /* 거래처 */
					field : 'ENTERPRISE_GUBUN',
					width : '95',
					visible : false,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : 
						'<select ng-model="row.entity.ENTERPRISE_GUBUN" style="width: 100%; height: 100% !important; min-width: initial;" >' + 
						'	<option ng-repeat="SB_ENTERPRISE_GUBUN in grid.appScope.SB_ENTERPRISE_GUBUN" ng-selected="row.entity.ENTERPRISE_GUBUN == SB_ENTERPRISE_GUBUN.CODE" value="{{SB_ENTERPRISE_GUBUN.CODE}}" >{{SB_ENTERPRISE_GUBUN.CODE_NAME}}</option>' + 
						'</select>'
				}, {
					displayName : '사용유무',
					field : 'USE_YN',
					width : '100',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				} ]
			});
			
			<%
			List<HashMap<String, Object>> cb_enterprice_gubun = (List<HashMap<String, Object>>) request.getAttribute("cb_enterprice_gubun");
			JSONArray json_cb_enterprice_gubun = new JSONArray();
			for (int i = 0; i < cb_enterprice_gubun.size(); i++) {
				JSONObject data= new JSONObject();
				data.put("CODE", cb_enterprice_gubun.get(i).get("CODE"));
				data.put("CODE_NAME", cb_enterprice_gubun.get(i).get("CODE_NAME"));
				json_cb_enterprice_gubun.add(i, data);
			}
			%>
			// 거래처 콤보
			$scope.SB_ENTERPRISE_GUBUN = <%=json_cb_enterprice_gubun%>;
			$scope.SB_ENTERPRISE_GUBUN.unshift({CODE:"", CODE_NAME:"선택"});
			
			// 상세조회
			$scope.fnSearchPopup = function(row) {
				var target = scope.gridOptions.data.indexOf(row.entity);
				fnSearchPopup(target);
			};
			
			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  
		} ]);
		var scope;
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
				listQuery : "yp_zwc_mst.select_zwc_mst", //list가져오는 마이바티스 쿼리 아이디
				cntQuery : "yp_zwc_mst.select_zwc_mst_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
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
				$("#search_btn").trigger("click");
				$('.datepicker').hide();
			});
			
			// 조회
			$("#search_btn").on("click", function() {
				scope.reloadGrid({
					CODE_TYPE : $("#CODE_TYPE").val(),
					BASE_YYYY : function(){
						if($("#CODE_TYPE").val() === "P" || $("#CODE_TYPE").val() === "C"){
							return $("#BASE_YYYY").val();
						}else{
							return "";
						}
					}
				});
			});

			// 신청
			$("#fnAdd").on("click", function() {
				scope.addRow({
					STATUS : null,
					CODE : $("#CODE_TYPE").val(),
					SEQ : null,
					BASE_YYYY : $("#BASE_YYYY").val().trim(),
					CODE_NAME : null,
					SAP_CODE : null,
					REPRESENTATIVE : null,
					UNIT_PRICE : null,
					UNIT : null,
					USE_YN : null
				}, true, "desc");
			});

			// 선택 저장
			$("#fnSave").on("click", function() {
				var rows = scope.gridApi.selection.getSelectedRows();
				if(rows.length === 0){
					swalWarningCB("저장할 항목을 선택하세요.");
					return false;
				}
				if (!fnValidation()){
					return false;
				}
				if (confirm("등록하겠습니까?")) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zwc/mst/zwc_mst_save",
						type : "POST",
						cache : false,
						async : true,
						dataType : "json",
						data : {
							CODE_TYPE: $("#CODE_TYPE").val(),
							ROW_NO: JSON.stringify(rows)
						},
						success : function(result) {
							if (result.code > 0){
								$("#search_btn").trigger("click");
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
							swalDangerCB("등록에 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
				}
			});

			// 삭제
			$("#fnDel").on("click", function() {
				var rows = scope.gridApi.selection.getSelectedRows();
				if(rows.length === 0){
					swalWarningCB("삭제할 항목을 선택하세요.");
					return false;
				}
				if (!fnValidation()){
					return false;
				}
				if (confirm("삭제하겠습니까?")) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zwc/mst/zwc_mst_delete",
						type : "POST",
						cache : false,
						async : true,
						dataType : "json",
						data : {
							ROW_NO: JSON.stringify(rows)
						},
						success : function(result) {
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

			// 필터 토글
			$("#filter_btn").on("click", function() {
				scope.gridOptions.enableFiltering = !scope.gridOptions.enableFiltering;
				scope.gridApi.core.notifyDataChange( scope.uiGridConstants.dataChange.COLUMN );
			});
			
			$("#CODE_TYPE").trigger("change");
		});

// 		<option value="V">거래처</option>
// 		<option value="W">근무형태</option>
// 		<option value="N">유해인자</option>
// 		<option value="P">보호구</option>
// 		<option value="C">업체별 경비항목</option>
// 		<option value="U">단위</option>
		
		var default_hide = [ 3, 4, 5, 6, 7, 8, 9, 10, 11 ];
		// 2020-11-03 jamerl - 조용래: 제거 > 10 ENTERPRISE_CODE(업체코드) 사용안함
		var type_v = [ 5, 6, 7, 11 ]; // 거래처
		var type_w = [ 4 ]; // 근무형태
		var type_n = [ 4 ]; // 유해인자
		var type_p = [ 3, 4, 8 ]; // 보호구
		var type_c = [ 3, 4, 9 ]; // 업체별 경비항목
		var type_u = [ 4 ]; // 단위
		
		function fnDocTypeDisplay(obj) {
			// 데이터 초기화
			scope.gridOptions.data = [];
			
			var type = $(obj).find(":selected").val();
			// 코드별 그리드 컬럼 초기화
			if (type == "V") {
				$(".default_hide").hide();
				type_v_Show();
			} else if (type == "W") {
				$(".default_hide").hide();
				type_w_Show();
			} else if (type == "N") {
				$(".default_hide").hide();
				type_n_Show();
			} else if (type == "P") {
				$(".default_hide").show();
				type_p_Show();
			} else if (type == "C") {
				$(".default_hide").show();
				type_c_Show();
			} else if (type == "U") {
				$(".default_hide").hide();
				type_u_Show();
			}
			// 조회
			$("#search_btn").trigger("click");
		}
		function type_v_Show() {
			// 초기화
			$.each(default_hide, function(i, v) {
				scope.gridOptions.columnDefs[v].visible = false;
			});
			// 기준정보 - 거래처
			$.each(type_v, function(i, v) {
				scope.gridOptions.columnDefs[v].visible = true;
			});
			scope.gridApi.grid.refresh();
		}
		function type_w_Show() {
			// 초기화
			$.each(default_hide, function(i, v) {
				scope.gridOptions.columnDefs[v].visible = false;
			});
			// 기준정보 - 근무형태
			$.each(type_w, function(i, v) {
				scope.gridOptions.columnDefs[v].visible = true;
			});
			scope.gridApi.grid.refresh();
		}
		function type_n_Show() {
			// 초기화
			$.each(default_hide, function(i, v) {
				scope.gridOptions.columnDefs[v].visible = false;
			});
			// 기준정보 - 유해인자
			$.each(type_n, function(i, v) {
				scope.gridOptions.columnDefs[v].visible = true;
			});
			scope.gridApi.grid.refresh();
		}
		function type_p_Show() {
			// 초기화
			$.each(default_hide, function(i, v) {
				scope.gridOptions.columnDefs[v].visible = false;
			});
			// 기준정보 - 보호구
			$.each(type_p, function(i, v) {
				scope.gridOptions.columnDefs[v].visible = true;
			});
			scope.gridApi.grid.refresh();
		}
		function type_c_Show() {
			// 초기화
			$.each(default_hide, function(i, v) {
				scope.gridOptions.columnDefs[v].visible = false;
			});
			// 기준정보 - 업체별 경비항목
			$.each(type_c, function(i, v) {
				scope.gridOptions.columnDefs[v].visible = true;
			});
			scope.gridApi.grid.refresh();
		}
		function type_u_Show() {
			// 초기화
			$.each(default_hide, function(i, v) {
				scope.gridOptions.columnDefs[v].visible = false;
			});
			// 기준정보 - 단위
			$.each(type_u, function(i, v) {
				scope.gridOptions.columnDefs[v].visible = true;
			});
			scope.gridApi.grid.refresh();
		}
		
		function fnSearchPopup(target) {
			window.open("", "업체 검색", "width=630, height=920");
			fnHrefPopup("/yp/popup/zwc/mst/retrieveLIFNR", "업체 검색", {
				target : target
			});
		}
		
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
		function fnValidation(){
			var check = true;
			return check;
		}
		/*콤마 추가*/
		function addComma(num) {
			return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		}

		/*콤마 제거*/
		function unComma(num) {
			return num.replace(/,/gi, '');
		}
		
		function formatDate_y(date) {
			var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
			if (month.length < 2)
				month = '0' + month;
			if (day.length < 2)
				day = '0' + day;
			return [ year ].join('/');
		}
	</script>
</body>