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
<title>회계전표 목록</title>
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
			if (fnValidation()) {
				scope.reloadGrid({
					budat_s : $("#budat_s").val(),
					budat_e : $("#budat_e").val(),
// 					bldat_s : $("#bldat_s").val(),
// 					bldat_e : $("#bldat_e").val(),
					cpudt_s : $("#cpudt_s").val(),
					cpudt_e : $("#cpudt_e").val(),
					bktxt : $("#bktxt").val(),
					belnr : $("#belnr").val(),
					ser_name : $("#ser_name").val()
				});
			}
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

			xlsForm.name = "sndFrm";
			xlsForm.method = "post";
			xlsForm.action = "/yp/zfi/doc/xls/zfi_doc_list";

			document.body.appendChild(xlsForm);

			xlsForm.appendChild(csrf_element);

			var pr = {
				budat_s : $("#budat_s").val(),
				budat_e : $("#budat_e").val(),
// 				bldat_s : $("#bldat_s").val(),
// 				bldat_e : $("#bldat_e").val(),
				cpudt_s : $("#cpudt_s").val(),
				cpudt_e : $("#cpudt_e").val(),
				bktxt : $("#bktxt").val(),
				belnr : $("#belnr").val(),
				ser_name : $("#ser_name").val()
			};

			$.each(pr, function(k, v) {
				console.log(k, v);
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

		// 선택삭제
		$("#remove_btn").on("click", function() {
			var selectedRows = scope.gridApi.selection.getSelectedRows();
			if (!isEmpty(selectedRows)) {
				var row = selectedRows[0];
				var BTEXT = row.BTEXT;
				var ZACCPT_TXT = row.ZACCPT_TXT;
				var STTXT = row.STTXT;
				var delcheck = BTEXT === "Parking" && ZACCPT_TXT === "미승인" && STTXT === "미상신";
				if (delcheck) {
					swal({
						icon : "info",
						text : "전표를 삭제하시겠습니까?",
						closeOnClickOutside : false,
						closeOnEsc : false,
						buttons : {
							confirm : {
								text : "확인",
								value : true,
								visible : true,
								className : "",
								closeModal : true
							},
							cancel : {
								text : "취소",
								value : null,
								visible : true,
								className : "",
								closeModal : true
							}
						}
					}).then(function(result) {
						if (result) {
							var token = $("meta[name='_csrf']").attr("content");
							var header = $("meta[name='_csrf_header']").attr("content");
							$.ajax({
								url : "/yp/zfi/doc/remove_rtrv_doc",
								type : "POST",
								cache : false,
								async : true,
								data : {
									IBELNR : row.BELNR,
									IGJAHR : row.GJAHR,
									qbudat_s : $("#budat_s").val(),
									qbudat_e : $("#budat_e").val(),
									IZSNAME : row.ZSNAME,
									//DEL_USER : scope.emp_code
								},
								dataType : "json",
								success : function(result) {
									swalSuccessCB(result.msg, function() {
										$("#search_btn").trigger("click");
									});

								},
								beforeSend : function(xhr) {
									// 2019-10-23 khj - for csrf
									xhr.setRequestHeader(header, token);
									$('.wrap-loading').removeClass('display-none');
								},
								complete : function() {
									$('.wrap-loading').addClass('display-none');
								},
								error : function(xhr, statusText) {
									console.error("code:" + xhr.status + " - " + "message:" + xhr.statusText, xhr);
									swalDangerCB("삭제중 오류가 발생였습니다.\n관리자에게 문의해주세요.");
								}
							});
						}
					});
				} else {
					swalWarningCB("선택된 전표는 삭제할 수 없습니다.");
				}
			} else {
				swalWarningCB("전표를 선택해 주세요.");
			}
		});

		// 선택 빠른전표
		$("#quick_statement_btn").on("click", function() {
			var selectedRows = scope.gridApi.selection.getSelectedRows();
			if (!isEmpty(selectedRows)) {
				if (selectedRows[0].BTEXT == "Posting") {
					f_href("/yp/zfi/doc/documentRegpage", {
						IBELNR : selectedRows[0].BELNR,
						IGJAHR : selectedRows[0].GJAHR,
						hierarchy : "${hierarchy}"
					});
				}else{
					swalWarningCB("임시전표는 빠른전표 기능이 제공되지 않습니다.");
				}
			} else {
				swalWarningCB("전표를 선택해 주세요.");
			}
		});

		// 회계전표, 지출품의 수기결재 팝업
		$(".h_w_appr").on("click", function() {
			var selectedRows = scope.gridApi.selection.getSelectedRows();
			if (!isEmpty(selectedRows)) {
				var row = selectedRows[0];

				window.open("", "수기결재 인쇄", "width=" + 1000 + ",height=" + screen.height + ",scrollbars=yes");

				//20191023_khj for csrf
				var csrf_element = document.createElement("input");
				csrf_element.name = "_csrf";
				csrf_element.value = "${_csrf.token}";
				csrf_element.type = "hidden";
				//20191023_khj for csrf
				var popForm = document.createElement("form");

				popForm.name = "sndFrm";
				popForm.method = "post";
				popForm.target = "수기결재 인쇄";
				popForm.action = "/yp/popup/zfi/doc/printDocPage";

				document.body.appendChild(popForm);

				popForm.appendChild(csrf_element);

				var pr = {
					type : $(this).data("type"),
					IBELNR : row.BELNR,
					IGJAHR : row.GJAHR,
					qbudat_s : $("#budat_s").val(),
					qbudat_e : $("#budat_e").val(),
					IZSNAME : row.ZSNAME
				};

				$.each(pr, function(k, v) {
					console.log(k, v);
					var el = document.createElement("input");
					el.name = k;
					el.value = v;
					el.type = "hidden";
					popForm.appendChild(el);
				});

				popForm.submit();
				popForm.remove();
			} else {
				swalWarningCB("전표를 선택해 주세요.");
			}
		});
	});

	function fnDocWriteGW(url) {
		var newwin = window.open(url, "전자결재 상신하기", "width=850, height=600, scrollbars=yes, resize=yes");
		if (newwin == null) {
			alert("팝업 차단기능 혹은 팝업차단 프로그램이 동작중입니다. 팝업 차단 기능을 해제한 후 다시 시도하세요.");
		}
	}

	function fnExelDown() {
		$("input[name=excel_flag]").val("1");
		$("#frm").attr("action", "/fi/retrieveDocumentList");
		$("#frm").submit();
		$('.wrap-excelloading').removeClass('display-none');
		setTimeout(function() {
			$('.wrap-excelloading').addClass('display-none');
		}, 5000); //5초
	}

	function fnValidation() {
		if ("" === $("#budat_s").val()) {
			swalWarningCB("전기일(시작)을 입력해주세요", function() {
				$("#budat_s").focus();
			});
			return false;
		} else if ("" === $("#budat_e").val()) {
			swalWarningCB("전기일(종료)을 입력해주세요", function() {
				$("#budat_e").focus();
			});
			return false;
		}
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
</script>
</head>
<body>
	<!-- 20191023_khj for csrf -->
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<h2>
		회계전표 목록
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
	<section>
		<div class="tbl_box">
			<table cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="5%" />
					<col width="25%"/>
					<col width="5%" />
					<col width="25%"/>
					<col width="5%" />
					<col width="25%"/>
				</colgroup>
				<tr>
					<th>전기일</th>
					<td>
						<input class="calendar dtp" type="text" name="budat_s" id="budat_s" value="<c:choose><c:when test="${empty req_data.budat_s}"><%=toDay%></c:when><c:otherwise>${req_data.budat_s}</c:otherwise></c:choose>">
						~
						<input class="calendar dtp" type="text" name="budat_e" id="budat_e" value="<c:choose><c:when test="${empty req_data.budat_e}"><%=toDay%></c:when><c:otherwise>${req_data.budat_e}</c:otherwise></c:choose>">
					</td>
<!-- 					2020-09-06 jamerl - 백승지 : 검색조건 제외 : 증빙일 삭제 -->
<!-- 					<th>증빙일</th> -->
<!-- 					<td> -->
<%-- 						<input class="calendar dtp" type="text" name="bldat_s" id="bldat_s" value="${req_data.bldat_s}"> --%>
<!-- 						~ -->
<%-- 						<input class="calendar dtp" type="text" name="bldat_e" id="bldat_e" value="${req_data.bldat_e}"> --%>
<!-- 					</td> -->
					<th>입력일</th>
					<td>
						<input class="calendar dtp" type="text" name="cpudt_s" id="cpudt_s" value="${req_data.cpudt_s}">
						~
						<input class="calendar dtp" type="text" name="cpudt_e" id="cpudt_e" value="${req_data.cpudt_e}">
					</td>
					<th>&nbsp;</th>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<th>전표헤더 텍스트</th>
					<td>
						<input type="text" name="bktxt" id="bktxt" >
					</td>
					<th>전표번호</th>
					<td>
						<input type="text" name="belnr" id="belnr" >
					</td>
					<th>작성자</th>
					<td>
						<input type="text" name="ser_name" id="ser_name" >
					</td>
				</tr>
			</table>
			<div class="btn_wrap">
				<button class="btn btn_make" id="excel_btn" type="">엑셀 다운로드</button>
				<button class="btn btn_search" id="search_btn" type="">조회</button>
			</div>
		</div>
	</section>
	<div class="float_wrap">
		<div class="fl">
			<div class="stitle">전표목록</div>
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type="button" value="선택삭제"  class="btn_g" id="remove_btn" >
				<input type="button" value="선택 빠른전표"  class="btn_g" id="quick_statement_btn" >
				<input type="button" value="회계전표"  class="btn_g h_w_appr" id="statement_btn" data-type="1" >
				<input type="button" value="지출품의"  class="btn_g h_w_appr" id="consult_btn" data-type="2" >
				<input type="button" value="수입품의"  class="btn_g h_w_appr" id="consult_btn" data-type="3" >
			</div>
		</div>
	</div>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="shdsCtrl" style="height: auto;">
			<div data-ui-i18n="ko" style="height: 540px;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
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

			// 미상신체크
			$scope.isApproval = function(str) {
				if (str === "미상신") {
					return true;
				} else {
					return false;
				}
			};

			// 상세조회
			$scope.rowClick = function(data) {
				var row = data.entity;

				var BELNR = fnPreAddZero(row.BELNR);
				var BUDAT = row.BUDAT;

				var w = window.open("about:blank", "회계전표", "width=1200,height=900,location=yes,scrollbars=yes");

				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					url : "/yp/zfi/doc/select_rtrv_doc",
					type : "post",
					cache : false,
					async : true,
					data : {
						BELNR : BELNR,
						BUDAT : BUDAT
					},
					dataType : "json",
					success : function(result) {
						if (result.docno == "") {
							w.location.href = "http://ypgw.ypzinc.co.kr/ekp/view/info/infoAccSpec?bukrs=" + result.bukrs + "&belnr=" + BELNR + "&gjahr=" + result.gjahr + "&docNo=2018년 본사/전산팀 지출품의 제 xxxxx호";
						} else {
							w.location.href = "http://ypgw.ypzinc.co.kr/ekp/view/info/infoAccSpec?bukrs=" + result.bukrs + "&belnr=" + BELNR + "&gjahr=" + result.gjahr + "&docNo=" + result.docno;
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
					error : function(xhr, statusText) {
						console.error("code:" + xhr.status + " - " + "message:" + xhr.statusText, xhr);
						swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
					}
				});
			};

			// 결재상신
			$scope.fn_approval = function(row) {
				var BELNR = row.entity.BELNR;
				var GJAHR = row.entity.GJAHR;

				var w = window.open("about:blank", "임시전표 전자결재 상신", "width=400, height=500");

				//20191023_khj for csrf
				var csrf_element = document.createElement("input");
				csrf_element.name = "_csrf";
				csrf_element.value = "${_csrf.token}";
				csrf_element.type = "hidden";
				//20191023_khj for csrf
				var popForm = document.createElement("form");

				popForm.name = "sndFrm";
				popForm.method = "post";
				popForm.target = "임시전표 전자결재 상신";
				popForm.action = "/yp/popup/zfi/doc/createDocWritePage";

				document.body.appendChild(popForm);

				popForm.appendChild(csrf_element);

				var pr = {
					FROM : "zfi_doc_list",
					BELNR : BELNR,
					GJAHR : GJAHR
				};

				$.each(pr, function(k, v) {
					console.log(k, v);
					var el = document.createElement("input");
					el.name = k;
					el.value = v;
					el.type = "hidden";
					popForm.appendChild(el);
				});

				popForm.submit();
				popForm.remove();
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
					displayName : '상태',
					field : 'BTEXT',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{row.entity.BTEXT == "Parking" ? "임시" : (row.entity.BTEXT == "Posting" ? "확정" : "-")}}</div>'
				}, {
					displayName : '승인여부',
					field : 'ZACCPT_TXT',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '전자결재',
					field : 'STTXT',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents btn_g" ng-if="grid.appScope.isApproval(row.entity.STTXT)" style="cursor: pointer;" ng-click="grid.appScope.fn_approval(row)">결재상신</div>' + '<div class="ui-grid-cell-contents" ng-if="!grid.appScope.isApproval(row.entity.STTXT)">{{row.entity.STTXT}}</div>'
				}, {
					displayName : '전표번호',
					field : 'BELNR',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" style="cursor: pointer; text-decoration: underline;" ng-click="grid.appScope.rowClick(row)">{{row.entity.BELNR}}</div>'
				}, {
					displayName : '연도',
					field : 'GJAHR',
					width : '80',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '원화금액',
					field : 'DMBTR',
					width : '9%',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.DMBTR)}}</div>'
				}, {
					displayName : '외화금액',
					field : 'PSWBT',
					width : '9%',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.PSWBT)}}</div>'
				}, {
					displayName : '통화',
					field : 'PSWSL',
					width : '80',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '전표헤더 텍스트',
					field : 'BKTXT',
					//width : '8%',
					minWidth : 110,
					visible : true,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '참조',
					field : 'XBLNR',
					width : '100',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '거래처',
					field : 'LIFNR',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '거래처명',
					field : 'NAME1',
					width : '140',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '전기일',
					field : 'BUDAT',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_date(row.entity.BUDAT)}}</div>'
				}, {
					displayName : '입력일',
					field : 'CPUDT',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_date(row.entity.CPUDT)}}</div>'
				}, {
					displayName : '사원이름',
					field : 'ZSNAME',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
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
				// 				console.log("row2", row.entity);
			});
			scope.gridApi.selection.on.rowSelectionChangedBatch(scope, function(rows) { //전체선택시 가져옴
				// 				console.log("row3", rows[0].entity); //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
			});
			// pagenation option setting  그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param = {
				EXEC_RFC : "Y", // RFC 여부
				RFC_TYPE : "ZFI_DOC", // RFC 구분
				RFC_FUNC : "ZWEB_LIST_DOCUMENT" // RFC 함수명
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝

			// 			$("#search_btn").trigger("click");
		});
	</script>
</body>