<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	String sDate = toDay.substring(0, 4) + "/01/01";
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>계약마스터 조회</title>
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

		// 조회
		$("#search_btn").on("click", function() {
			scope.reloadGrid({
				sdate : $("#sdate").val(),
				edate : $("#edate").val(),
				srch_ent_code : $("input[name=srch_ent_code]").val()
			});
		});
		
		$("#mod_btn").on("click", function() {
			var rows = scope.gridApi.selection.getSelectedRows();
			if (isEmpty(rows)) {
				swalWarning("항목을 선택하세요.");
				return false;
			}
			<%--
				2022.08.03 JhOh
				YPWEBPOTAL-17 차량계량마스터 수정 시 오류
				 - SEQ : rows[0].SEQ 전송값 추가
			--%>
			f_href("/yp/zmm/aw/zmm_weight_cont_detail", {
				SEQ : rows[0].SEQ,
				CONT_CODE : rows[0].CONT_CODE,
				CONT_NO : rows[0].CONT_NO,
				ENT_CODE : rows[0].ENT_CODE,
				REG_NO : rows[0].REG_NO,
				hierarchy : "000002"
			});
			
		});
		
		$("#del_btn").on("click", function() {
			var rows = scope.gridApi.selection.getSelectedRows();
			if(isEmpty(rows)) {
				swalWarning("항목을 선택하세요.");
				return false;
			}else if(rows.length > 1){
				swalWarning("항목은 하나만 선택하세요.");
				return false;
			}
			
			if (confirm("삭제 하시겠습니까?")) {
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					url : "/yp/zmm/aw/zmm_weight_cont_delete",
					type : "POST",
					cache : false,
					async : true,
					dataType : "json",
					data : {
						<%--
							2022.08.03 JhOh
							YPWEBPOTAL-17 차량계량마스터 수정 시 오류
							 - SEQ : rows[0].SEQ 전송값 추가
						--%>
						seq : rows[0].SEQ,
						cont_code : rows[0].CONT_CODE,
						cont_no : rows[0].CONT_NO,
						ent_code : rows[0].ENT_CODE
					},
					success : function(data) {
						if(data.result == "S"){
							swalSuccessCB("삭제 되었습니다.", function(){
								$("#search_btn").trigger("click");
							});
						}else{
							swalDangerCB("삭제에 실패하였습니다.\n관리자에게 문의해주세요.");
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
						swalDangerCB("삭제에 실패하였습니다.\n관리자에게 문의해주세요.");
					}
				});
			}
		});
	});
	
	function fnValidation() {
		
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
	
	function fnSearchPopup(type, target) {
		if (type == "M") {
			window.open("", "자재 검색", "width=600, height=800");
			fnHrefPopup("/yp/popup/zmm/aw/retrieveMATNR", "자재 검색", {
				type : "srch",
				target : -1
			});
		}else if(type == "K"){
			window.open("", "업체 검색", "width=600, height=800");
			fnHrefPopup("/yp/popup/zmm/aw/retrieveKUNNR", "업체 검색", {
				type : "srch",
				target : -1
			});
		}
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
			// console.log(k, v);
			var el = document.createElement("input");
			el.name = k;
			el.value = v;
			el.type = "hidden";
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
		계약마스터 조회
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
					<th>계약기간</th>
					<td><input class="calendar dtp" type="text" name="sdate"
						id="sdate" autocomplete="off"
						value="<c:choose><c:when test="${empty req_data.sdate}"><%=sDate%></c:when><c:otherwise>${req_data.sdate}</c:otherwise></c:choose>" readonly>
						~ <input class="calendar dtp" type="text" name="edate" id="edate"
						autocomplete="off"
						value="<c:choose><c:when test="${empty req_data.edate}"><%=toDay%></c:when><c:otherwise>${req_data.edate}</c:otherwise></c:choose>" readonly>
					</td>
					<th>업체</th>
					<td>
						<input type="text" name="srch_ent_code" value="" readonly><img src="/resources/yp/images/ic_search.png" style="cursor: pointer;" onclick="javascript:fnSearchPopup('K', null);">
						<input type="text" name="srch_ent" readonly="readonly">
					</td>
					<th></th><td></td>
				</tr>
			</table>
			<div class="btn_wrap">
				<!-- <button class="btn btn_make" id="excel_btn" type="">엑셀 다운로드</button> -->
				<button class="btn btn_search" id="search_btn" type="">조회</button>
			</div>
		</div>
	</section>
	<div class="float_wrap">
		<!-- 		<div class="fl"> -->
		<!-- 			<div class="stitle"></div> -->
		<!-- 		</div> -->
		<div class="fr">
			<div class="btn_wrap" style="margin-bottom: 2px;">
			<!-- <input type="button" value="등록" class="btn_g" id="reg_btn"> -->
				<input type="button" value="상세보기" class="btn_g" id="mod_btn">
			<!-- <input type="button" value="삭제" class="btn_g" id="del_btn"> -->
			</div>
		</div>
	</div>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="weightCtrl"
			style="height: auto;">
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

			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바

				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 10,

				enableCellEditOnFocus : true, //셀 클릭시 edit모드 
				enableSelectAll : true, //전체선택 체크박스
				enableRowSelection : false, //로우 선택
				enableRowHeaderSelection : true, //맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 35, //체크박스 컬럼 길이
				enableHorizontalScrollbar : "1",
				enableVerticalScrollbar : "1",
				rowHeight : 27, //체크박스 컬럼 높이
				// useExternalPagination : true, //pagination을 직접 세팅
				enableAutoFitColumns : false, //컬럼 width를 자동조정
				multiSelect : false, //여러로우선택
				enablePagination : true,
				enablePaginationControls : true,

				columnDefs : [ //컬럼 세팅
				{
					displayName : '계약코드',
					field : 'CONT_CODE',
					width : '150',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '계약번호',
					field : 'CONT_NO',
					width : '80',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '업체코드',
					field : 'ENT_CODE',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '업체명',
					field : 'ENT',
					width : '200',
					visible : true,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '품목',
					field : 'P_DETAIL_NAME',
					width : '200',
					visible : true,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '구분',
					field : 'P_GUBUN',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '단위',
					field : 'WEIGHT_UNIT',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '단가',
					field : 'CONT_AMOUNT',
					width : '100',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.CONT_AMOUNT)}}</div>'
				}, {
					displayName : '계약시작일',
					field : 'CONT_SDATE',
					width : '150',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '계약종료일',
					field : 'CONT_EDATE',
					width : '150',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				//}, {
					//displayName : '최종단가일',
					//field : 'FINAL_PAYDATE',
					//width : '150',
					//visible : true,
					//cellClass : "center",
					//enableCellEdit : false,
					//allowCellFocus : false
				//}, {
					//displayName : '계약단가',
					//field : 'UPD_DATE',
					//width : '200',
					//visible : true,
					//cellClass : "center",
					//enableCellEdit : false,
					//allowCellFocus : false
				}, {
					displayName : '사업자번호',
					field : 'REG_NO',
					width : '150',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '계약서경로',
					field : 'CONT_FILE_URL',
					width : '100',
					visible : false,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '계약서',
					field : 'CONT_FILE_NAME',
					width : '200',
					visible : false,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{row.entity.CONT_FILE_NAME}}</div>'
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
			var param = {
					listQuery : "yp_zmm_aw.select_zmm_weight_cont_list", //list가져오는 마이바티스 쿼리 아이디
					cntQuery  : "yp_zmm_aw.select_zmm_weight_cont_list_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝

			// $("#search_btn").trigger("click");
		});
	</script>
</body>