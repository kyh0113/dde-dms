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
	String sDate = toDay.substring(0, 8) + "01";
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>계약 마스터 등록</title>
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
		}).on('changeDate', function(){
		 	$('.datepicker').hide();
		});
		
		//계약서 첨부 버튼
		$("#file_reg").on("click", function() {
			fnContRegPop('A');
		});
		
		//계약서 첨부 버튼
		$("#file_reg2").on("click", function() {
			fnContRegPop('B');
		});
		
		$('input[type=text]').keydown(function() {
		  if (event.keyCode === 13) {
		    event.preventDefault();
		  };
		});
	});

	function fnContRegPop(tp){
		
		//20191023_khj for csrf
		var csrf_element   = document.createElement("input");
		csrf_element.name  = "_csrf";
		csrf_element.value = "${_csrf.token}";
		csrf_element.type  = "hidden";
		//20191023_khj for csrf
		
		if (tp == "A") {
			var input1   = document.createElement("input");
			input1.name  = "title";
			input1.value = "계약서 등록";
			input1.type  = "hidden";
			
			var input2   = document.createElement("input");
			input2.name  = "type";
			input2.value = "zmm_cont_file";
			input2.type  = "hidden";
		}
		
		else if (tp == "B") {
			var input1   = document.createElement("input");
			input1.name  = "title";
			input1.value = "계약서 등록2";
			input1.type  = "hidden";
			
			var input2   = document.createElement("input");
			input2.name  = "type";
			input2.value = "zmm_cont_file2";
			input2.type  = "hidden";
		}
		
		else if (tp == "C") {
			var input1   = document.createElement("input");
			input1.name  = "title";
			input1.value = "증빙문서 등록";
			input1.type  = "hidden";
			
			var input2   = document.createElement("input");
			input2.name  = "type";
			input2.value = "zmm_cont_file3";
			input2.type  = "hidden";
		}
		
		var popForm  = document.createElement("form");

		popForm.name   = "popForm";
		popForm.method = "post";
		popForm.target = "FILE_REG_POP";
		popForm.action = "/yp/popup/fileReg";

		document.body.appendChild(popForm);

		popForm.appendChild(csrf_element);
		popForm.appendChild(input1);
		popForm.appendChild(input2);
		
		window.open("","FILE_REG_POP","scrollbars=yes,width=600,height=300");

		popForm.submit();
		popForm.remove();
	}
	
	function fnSearchPopup(type, target) {
		console.log(target);
		if (type == "M") {
			window.open("", "자재 검색", "width=600, height=800");
			fnHrefPopup("/yp/popup/zmm/aw/retrieveMATNR", "자재 검색", {
				type : "srch"
				,target : target
			});
		}else if(type == "K"){
			window.open("", "업체 검색", "width=600, height=800");
			fnHrefPopup("/yp/popup/zmm/aw/retrieveKUNNR", "업체 검색", {
				type : ""
				,target : -1
			});
		}
	}
	
	function fnHrefPopup(url, target, pr) {
		//20191023_khj for csrf
		var csrf_element   = document.createElement("input");
		csrf_element.name  = "_csrf";
		csrf_element.value = "${_csrf.token}";
		csrf_element.type  = "hidden";
		//20191023_khj for csrf
		var popForm = document.createElement("form");

		popForm.name   = "popForm";
		popForm.method = "post";
		popForm.target = target;
		popForm.action = url;

		document.body.appendChild(popForm);
		popForm.appendChild(csrf_element);

		$.each(pr, function(k, v) {
			//console.log(k, v);
			var el   = document.createElement("input");
			el.name  = k;
			el.value = v;
			el.type  = "hidden";
			popForm.appendChild(el);
		});

		popForm.submit();
		popForm.remove();
	}
		
</script>
</head>
<body>
	<!-- 20191023_khj for csrf -->
	<input type="hidden" name="${_csrf.parameterName}"
		id="${_csrf.parameterName}" value="${_csrf.token}" />
	<h2>
		계약 마스터 등록
		<!-- 공통 - 네비게이션 시작 -->
		<ul class="loc">
			<li><img src="/resources/yp/images/ic_loc_home.png"></li>
			<c:if test="${menu.breadcrumb[0].top_menu_id ne null}">
				<li>${menu.breadcrumb[0].top_menu_name}</li>
				<c:if
					test="${menu.breadcrumb[0].top_menu_id ne menu.breadcrumb[0].up_menu_id}">
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
	<div class="stitle">계약 정보</div>
	<form id="regfrm" name="regfrm"  method="post" onsubmit="return false;">
	<section>
		<div class="tbl_box">
			<table cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="5%" />
					<col width="35%" />
					<col width="5%" />
					<col width="35%" />
					<col width="%" />
				</colgroup>
				<tr>
					<th>계약코드</th>
					<td><input type="text" name="cont_code" value="자동생성" readonly="readonly"/></td>
					<th>계약번호</th>
					<td>1</td>
				</tr>
				<tr>
					<th>업체</th>
					<td>
						<input type="text" name="ent_code" value="" readonly><img src="/resources/yp/images/ic_search.png" style="cursor: pointer;" onclick="javascript:fnSearchPopup('K', null);">
						<input type="text" name="ent" readonly="readonly">
					</td>
					<th>계약기간</th>
					<td><input class="calendar dtp" type="text" name="cont_sdate" autocomplete="off" value="" readonly>
						~ 
						<input class="calendar dtp" type="text" name="cont_edate" autocomplete="off" value="" readonly>
					</td>
				</tr>
				<tr>
					<th>사업자 등록번호</th>
					<td><input type="text" name="STCD2" readonly="readonly"></td>
					<th>계약적용일</th>
					<td><input class="calendar dtp" type="text" name="effective_date" autocomplete="off" value="" readonly></td>
				</tr>
				<tr>
					<th>계약서 첨부</th>
					<td>
						<button class="btn btn_make" id="file_reg">계약서 첨부1</button>
						<input type="hidden" name="file_url" id="file_url" value="">
						<input type="text" name="file_name" id="file_name" value="" readonly="readonly">

						<button class="btn btn_make" id="file_reg2">계약서 첨부2</button>
						<input type="text" name="file_name2" id="file_name2" value="" readonly="readonly">
						<input type="hidden" name="file_url3" id="file_url3" value="">
					</td>
					<th></th><td></td>
				</tr>
			</table>
		</div>
	</section>
	<div class="float_wrap">
		<div class="fl">
			<div class="stitle">품목</div>
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type="button" class="btn_g" id="add_btn" value="추가">
				<!--<input type="button" class="btn_g" id="mod_btn" value="수정">
				<input type="button" class="btn_g" id="remove_btn" value="삭제">-->
			</div>
		</div>
	</div>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="weightCtrl" style="height: auto;">
			<div data-ui-i18n="ko" style="height: 540px;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit
					data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns
					data-ui-grid-auto-resize ui-grid-auto-resize data-ui-grid-selection
					data-ui-grid-exporter>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
	</section>
	</form>
	<input type="button" class="btn_g" id="save_btn" value="저장">
	<script>
		/*복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  */
		app.controller('weightCtrl', [ '$scope', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
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
			
			// 수정
			$("#mod_btn").on("click", function() {
				var rows = scope.gridApi.selection.getSelectedRows();
				if (isEmpty(rows)) {
					swalWarning("항목을 선택하세요.");
					return false;
				}
				$.each(rows, function(i, d) {
					if(d.IS_NEW === "Y") {
						return true;
					}
					d.IS_MOD = "Y";
				});
				scope.gridApi.grid.refresh();
			});
			
			// 항목삭제 이벤트
			$("#remove_btn").on("click", function() {
				var selectedRows = scope.gridApi.selection.getSelectedRows();
				if (isEmpty(selectedRows)) {
					swalWarning("삭제할 항목을 선택하세요.");
					return false;
				}
				$.each(selectedRows, function(i, d) {
					// 선택된 데이터 삭제
					scope.gridOptions.data.splice(scope.gridOptions.data.indexOf(d), 1);
				});
				// 그리드 새로고침
				scope.gridApi.grid.refresh();
			});
			
			// 저장
			$("#save_btn").on("click", function() {
				
				var rows = scope.gridOptions.data;
				console.log(rows);
				if (!fnValidation() && fnValidationRow(rows)) {
					//alert("vali checked");
					return false;
				}
				var data = $("#regfrm").serializeArray();
				data.push({name: "ROW_NO", value: JSON.stringify(rows)});
				
				if (confirm("저장하시겠습니까?")) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zmm/aw/zmm_weight_cont_create_prc",
						type : "POST",
						cache : false,
						async : true,
						dataType : "json",
						data : data,
						success : function(data) {
							swalSuccessCB(data.result + "건 저장했습니다.", function(){
								$("#search_btn").trigger("click");
							});
							//scope.gridApi.grid.refresh();
							
							//f_href("/yp/zmm/aw/zmm_weight_cont_list", {
								//SEQ : rows[0].SEQ,
								//CONT_CODE : rows[0].CONT_CODE,
								//CONT_NO : rows[0].CONT_NO,
								//ENT_CODE : rows[0].ENT_CODE,
								//REG_NO : rows[0].REG_NO,
								//hierarchy : "000002"
							//});
							
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
							swalDangerCB("저장 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
				}
			});
			
			$scope.fnSearchPopup = function(type, row) {
				var target = scope.gridOptions.data.indexOf(row.entity);
				fnSearchPopup(type, target);
			};

			$scope.openPop_ENT = function(type, row) {
				fnContRegPop('C');
			};
			
			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바

				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 10,

				enableCellEditOnFocus : true, //셀 클릭시 edit모드 
				enableSelectAll : true, //전체선택 체크박스
				enableRowSelection : true, //로우 선택
				enableRowHeaderSelection : true, //맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 35, //체크박스 컬럼 길이
				enableHorizontalScrollbar : "1",
				enableVerticalScrollbar : "1",
				rowHeight : 27, //체크박스 컬럼 높이
				// useExternalPagination : true, //pagination을 직접 세팅
				enableAutoFitColumns : false, //컬럼 width를 자동조정
				multiSelect : true, //여러로우선택
				enablePagination : false,
				enablePaginationControls : false,

				columnDefs : [ //컬럼 세팅
				{
					displayName : 'IS_NEW',
					field : 'IS_NEW',
					width : '1',
					visible : false,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'IS_MOD',
					field : 'IS_MOD',
					width : '1',
					visible : false,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '품목코드',
					field : 'P_DETAIL_CODE',
					width : '150',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.P_DETAIL_CODE">{{row.entity.P_DETAIL_CODE}}</div>'
								+ '<input ng-if="row.entity.IS_NEW != null" type="text" class="" ng-model="row.entity.P_DETAIL_CODE" style="width: 75%; height: 100% !important;" on-model-change="grid.appScope.fnAjaxMATNR(\'M\',row)" readonly/>'
								+ '<input ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" type="text" class="" ng-model="row.entity.P_DETAIL_CODE" style="width: 75%; height: 100% !important;" on-model-change="grid.appScope.fnAjaxMATNR(\'M\',row)" readonly/>'
								+ '<img src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(\'M\', row)">'
				}, {
					displayName : '품목명',
					field : 'P_DETAIL_NAME',
					width : '150',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {	
					displayName : 'SAP코드',
					field : 'SAP_CODE',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'SAP명',
					field : 'SAP_NAME',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '구분',
					field : 'P_GUBUN',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.P_GUBUN" >{{row.entity.P_GUBUN}}</div>'
						+'<select ng-if="row.entity.IS_NEW != null \|\| row.entity.IS_MOD != null" ng-model="row.entity.P_GUBUN" style="height: 100%; width: 100%;">'
						+'<option ng-selected="row.entity.P_GUBUN == \'P\'" value="P">처리</option><option ng-selected="row.entity.P_GUBUN == \'U\'" value="U">운반</option><option ng-selected="row.entity.P_GUBUN == \'B\'" value="B">부피</option></select>'

				}, {
					displayName : '단위',
					field : 'WEIGHT_UNIT',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.WEIGHT_UNIT" >{{row.entity.WEIGHT_UNIT}}</div>'
								+'<select ng-if="row.entity.IS_NEW != null \|\| row.entity.IS_MOD != null" ng-model="row.entity.WEIGHT_UNIT" style="height: 100%; width: 100%;">'
								+'<option ng-selected="row.entity.WEIGHT_UNIT == \'Kg\'" value="Kg">Kg</option><option ng-selected="row.entity.WEIGHT_UNIT == \'ton\'" value="ton">ton</option><option ng-selected="row.entity.WEIGHT_UNIT == \'LUBE\'" value="LUBE">LUBE(*30)</option></select>'
				}, {
					displayName : '단가',
					field : 'CONT_AMOUNT',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.CONT_AMOUNT">{{grid.appScope.formatter_decimal(row.entity.CONT_AMOUNT)}}</div>'
								+ '<input ng-if="row.entity.IS_NEW != null" type="number" class="" ng-model="row.entity.CONT_AMOUNT" style="width: 100%; height: 100% !important;"/>'
								+ '<input ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" type="number" class="" ng-model="row.entity.CONT_AMOUNT" style="width: 100%; height: 100% !important;"/>'
				//}, {
					//displayName : '금액',
					//field : 'CONT_AMOUNT',
					//width : '100',
					//visible : true,
					//cellClass : "center",
					//enableCellEdit : false,
					//allowCellFocus : false,
					//cellTemplate : '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.CONT_AMOUNT">{{grid.appScope.formatter_decimal(row.entity.CONT_AMOUNT)}}</div>'
					//			+ '<input ng-if="row.entity.IS_NEW != null" type="text" class="" ng-model="row.entity.CONT_AMOUNT" style="width: 100%; height: 100% !important;"/>'
					//			+ '<input ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" type="text" class="" ng-model="row.entity.CONT_AMOUNT" style="width: 100%; height: 100% !important;"/>'
 				}, {
 					displayName : '단가적용월',
 					field : 'SDATE',
 					width : '100',
 					visible : true,
 					cellClass : "center",
 					enableCellEdit : false,
 					allowCellFocus : false,
 					cellTemplate : '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.SDATE">{{row.entity.SDATE}}</div>'
 								+ '<input ng-if="row.entity.IS_NEW != null" type="text" class="calendar dtp" ng-model="row.entity.SDATE" style="width: 100%; height: 100% !important;" readonly/>'
 								+ '<input ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" type="text" class="calendar dtp" ng-model="row.entity.SDATE" style="width: 100%; height: 100% !important;" readonly/>'
 				//}, {
 					//displayName : '종료일',
 					//field : 'EDATE',
 					//width : '150',
 					//visible : true,
 					//cellClass : "center",
 					//enableCellEdit : false,
 					//allowCellFocus : false,
 					//cellTemplate : '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.EDATE">{{row.entity.EDATE}}</div>'
 					//			+ '<input ng-if="row.entity.IS_NEW != null" type="text" class="calendar dtp" ng-model="row.entity.EDATE" style="width: 100%; height: 100% !important;"/>'
 					//			+ '<input ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" type="text" class="calendar dtp" ng-model="row.entity.EDATE" style="width: 100%; height: 100% !important;"/>'
				//}, {
					//displayName : '단가적용월',
					//field : 'MONETARY_UNIT',
					//width : '150',
					//visible : true,
					//cellClass : "center",
					//enableCellEdit : false,
					//allowCellFocus : false,
					//cellTemplate : '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.WEIGHT_UNIT">{{row.entity.MONETARY_UNIT}}</div>'
					//			+ '<input ng-if="row.entity.IS_NEW != null" type="text" class="" ng-model="row.entity.MONETARY_UNIT" style="width: 100%; height: 100% !important;"/>'
					//			+ '<input ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" type="text" class="" ng-model="row.entity.MONETARY_UNIT" style="width: 100%; height: 100% !important;"/>'
				}, {
					displayName : '증빙문서',
					field : 'FILE_NAME',
					width : '150',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents btn_g" style="cursor: pointer;margin-left:5px;" ng-click="grid.appScope.openPop_ENT(\'ADD\',row)">추가</div>'
				}, {
					displayName : '비고',
					field : 'BIGO',
					width : '300',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD == null" class="ui-grid-cell-contents" ng-model="row.entity.ng-model="row.entity.BIGO"">{{row.entity.BIGO}}</div>'
								+ '<input ng-if="row.entity.IS_NEW != null" type="text" class="" ng-model="row.entity.BIGO" style="width: 100%; height: 100% !important;"/>'
								+ '<input ng-if="row.entity.IS_NEW == null && row.entity.IS_MOD != null" type="text" class="" ng-model="row.entity.BIGO" style="width: 100%; height: 100% !important;"/>'
				} ]
			});

			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능
		
		} ]);

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
			//EXEC_RFC : "FI"
			// var param = {
			// listQuery : "yp_zmm_aw.select_zmm_weight_cont_list", //list가져오는 마이바티스 쿼리 아이디
			// cntQuery  : "yp_zmm_aw.select_zmm_weight_cont_list_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
			// };
			//scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
			
			// $("#search_btn").trigger("click");
				
			// 추가
			$("#add_btn").on("click", function() {
				
				var rows = scope.gridOptions.data;
				
				if(rows != "") {
					swalWarningCB("기존 품목 정보 입력 바랍니다.");
					return false;
				}

				scope.addRow({
					IS_NEW : "Y",
					IS_MOD : "",
					P_DETAIL_CODE : "",
					P_DETAIL_NAME : "",
					SAP_CODE : "",
					SAP_NAME : "",
					P_GUBUN : "",
					P_DETAIL_NAME : "",
					WEIGHT_UNIT : "",
					CONT_AMOUNT : "",
					SDATE : "",
					EDATE : "",
					MONETARY_UNIT : "",
					BIGO : ""
				}, true, "desc");
			
			});
			
			// grid date
			$(document).on("focus", ".dtp", function() {
				$(this).datepicker({
					format : "yyyy/mm",
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
		});
		
		
		function fnValidation() {
			if("" == $("input[name=ent_code]").val()){
				swalWarning("업체를 입력해 주세요.");
				return false;
			}else if("" == $("input[name=cont_sdate]").val()){
				swalWarning("계약기간 시작일을 입력해 주세요.");
				return false;
			}else if("" == $("input[name=cont_edate]").val()){
				swalWarning("계약기간 종료일을 입력해 주세요.");
				return false;
			}else if("" == $("input[name=effective_date]").val()){
				swalWarning("계약적용일을 입력해 주세요.");
				return false;
			}
			//else if("" == $("input[name=final_paydate]").val()){
				//swalWarning("최종단가일을 입력해 주세요.");
				//return false;
			//}
			//else if("" == $("input[name=file_url]").val()){
				//swalWarning("계약서를 첨부해 주세요.");
				//return false;
			//}
			//else if("" == $("input[name=ent_code]").val()){
				//swalWarning("업체를 입력해 주세요.");
				//return false;
			//}
			return true;
		}
		
		function fnValidationRow(rows){
			$.each(rows, function(i, d){
				//console.log("each.idx="+i);
				if(d.P_DETAIL_CODE === null || d.P_DETAIL_CODE === ""){
					swalWarningCB("품목을 선택해주세요.");
					return false;
				}else if(d.P_GUBUN === null || d.P_GUBUN === ""){
					swalWarningCB("구분을 선택해주세요.");
					return false;
				}else if(d.WEIGHT_UNIT === null || d.WEIGHT_UNIT === ""){
					swalWarningCB("단위를 입력해주세요.");
					return false;
				}else if(d.CONT_AMOUNT === null || d.CONT_AMOUNT === ""){
					swalWarningCB("단가를 입력해주세요.");
					return false;
				}else if(d.SDATE === null || d.SDATE === ""){
					swalWarningCB("단가적용월을 입력해주세요.");
					return false;
				}
			});
			return true;
		}
		
	</script>
	
</body>
