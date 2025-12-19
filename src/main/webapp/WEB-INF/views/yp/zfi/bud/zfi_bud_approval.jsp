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
SimpleDateFormat date = new SimpleDateFormat("yyyy/MM");
String toDay = date.format(today);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>예산 결재상신</title>
</head>
<body>
	<h2>
		예산 결재상신
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
	<form id="data_form">
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="SPMON_S_R" value=""><input type="hidden" name="SPMON_E_R" value="">
		<input type="hidden" name="SPMON_F_R" value=""><input type="hidden" name="SPMON_T_R" value="">
		<input type="hidden" name="GUBUN_R" value="">
		<input type="hidden" name="VALTP_R" value="">
		<input type="hidden" name="GSBER_R" value="">
	</form>
	<form id="frm" name="frm" method="post">
		<input type="hidden" name="excel_flag" />
		<input type="hidden" id="url" value="" />
		<input type="hidden" name="page" id="page" value="${paginationInfo.currentPageNo}" />
		<input type="hidden" name="page_rows" value="" />
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
						<th>사업영역</th>
						<td>
							<input type="radio" name="GSBER_S" id="1100" value="1100" <c:if test="${req_data.GSBER_S eq '1100'}">checked</c:if>>
							<label for="1100">본사</label>
							<input type="radio" name="GSBER_S" id="1200" value="1200" <c:if test="${req_data.GSBER_S eq '1200'}">checked</c:if>>
							<label for="1200">석포</label>
							<input type="radio" name="GSBER_S" id="1400" value="1400" <c:if test="${req_data.GSBER_S eq '1400'}">checked</c:if>>
							<label for="1400">안성휴게소</label>
							<input type="radio" name="GSBER_S" id="1600" value="1600" <c:if test="${req_data.GSBER_S eq '1600'}">checked</c:if>>
							<label for="1600">Green메탈캠퍼스</label>
						</td>
						<th>집행부서</th>
						<td>
							<input type="text" name="RORG_S" id="RORG_S" value="${req_data.RORG_S}">
							<a href="#" onclick="fnSearchPopup('3');"><img src="/resources/yp/images/ic_search.png"></a>
						</td>
						<th>입력년월</th>
						<td>
							<input class="calendar dtp" type="text" name="SPMON_S" id="SPMON_S" value="<c:choose><c:when test="${empty req_data.SPMON_S}"><%=toDay%></c:when><c:otherwise>${req_data.SPMON_S}</c:otherwise></c:choose>">
							~
							<input class="calendar dtp" type="text" name="SPMON_E" id="SPMON_E" value="<c:choose><c:when test="${empty req_data.SPMON_E}"><%=toDay%></c:when><c:otherwise>${req_data.SPMON_E}</c:otherwise></c:choose>">
						</td>
					</tr>
					<tr>
						<th>신청유형</th>
						<td>
							<input type="radio" name="GUBUN" id="GUBUN1" value="I" <c:if test="${req_data.GUBUN eq 'I'}">checked</c:if>>
							<label for="GUBUN1">증액</label>
							<input type="radio" name="GUBUN" id="GUBUN2" value="R" <c:if test="${req_data.GUBUN eq 'R'}">checked</c:if>>
							<label for="GUBUN2">감액</label>
							<input type="radio" name="GUBUN" id="GUBUN3" value="S" <c:if test="${req_data.GUBUN eq 'S'}">checked</c:if>>
							<label for="GUBUN3">조기</label>
							<input type="radio" name="GUBUN" id="GUBUN4" value="T" <c:if test="${req_data.GUBUN eq 'T'}">checked</c:if>>
							<label for="GUBUN4">이월</label>
						</td>
						<th>예산조직</th>
						<td>
							<input type="text" name="BORG_S" id="BORG_S" value="${req_data.BORG_S}">
							<a href="#" onclick="fnSearchPopup('4');"><img src="/resources/yp/images/ic_search.png"></a>
						</td>
						<th>예산계정</th>
						<td>
							<input type="text" name="BACT_S" id="BACT_S" value="${req_data.BACT_S}">
							<a href="#" onclick="fnSearchPopup('2');"><img src="/resources/yp/images/ic_search.png"></a>
						</td>
					</tr>
					<tr>
						<th>승인상태</th>
						<td>
							<select name="STATU">
								<option value="1" <c:if test="${req_data.STATU eq '1'}">selected</c:if>>대기</option>
								<option value="2" <c:if test="${req_data.STATU eq '2'}">selected</c:if>>승인</option>
								<option value="3" <c:if test="${req_data.STATU eq '3'}">selected</c:if>>반려</option>
								<option value="4" <c:if test="${req_data.STATU eq '4'}">selected</c:if>>결재요청</option>
								<option value="5" <c:if test="${req_data.STATU eq '5'}">selected</c:if>>진행중</option>
								<option value="6" <c:if test="${req_data.STATU eq '6'}">selected</c:if>>회수</option>
								<option value="" <c:if test="${req_data.STATU eq ''}">selected</c:if>>전체</option>
							</select>
						</td>
						<th>&nbsp;</th>
						<td>&nbsp;</td>
						<th>&nbsp;</th>
						<td>&nbsp;</td>
					</tr>
				</table>
				<div class="btn_wrap">
					<input type="button" class="btn btn_search" id="search_btn" value="조회" />
				</div>
			</div>
		</section>
	</form>
	<div class="float_wrap">
		<div class="fl">
			<div class="stitle">예산목록</div>
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type="button" class="btn_g" id="edoc_write" value="전자결재 상신">
			</div>
		</div>
	</div>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="shdsCtrl" style="height: auto;">
			<div data-ui-i18n="ko" style="height: 550px;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
	</section>
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

			$scope.uiGridConstants = uiGridConstants;

			$scope.pagination = vm.pagination;

			// 세션아이디코드 스코프에저장
			$scope.s_emp_code = "${s_emp_code}";

			$window.inviteCallback = function() {
				alert('hi');
			};

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

			// formater - String yyyyMM -> String yyyy.MM
			$scope.formatter_yyyymm = function(str_date) {
				return str_date.substring(0, 4) + "." + str_date.substring(4, 6)
			};

			// 미상신체크
			$scope.isApproval = function(str) {
				if (str === "미상신") {
					return true;
				} else {
					return false;
				}
			};

			//예산금액 상세보기
			$scope.openPop_BUDAMT = function(row) {
				fnDetailAmt("BUD", row);
			};

			//사용금액 상세보기
			$scope.openPop_ACTAMT = function(row) {
				fnDetailAmt("ACT", row);
			};

			//cellClass
			$scope.cellClassSet = function(grid, row, col, rowRenderIndex, colRenderIndex) {
				var className = "";
				switch (col.field) {
				case "BUDAMT":
					className = "right";
					break;
				case "ACTAMT":
					className = "right";
					break;
				}
				if (col.field == "BUDAMT" && (row.entity.BUDAMT > 0)) {
					className = className + " blue cursor-underline";
				}
				if (col.field == "ACTAMT" && (row.entity.ACTAMT > 0)) {
					className = className + " blue cursor-underline";
				}

				return className;
			}

			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바
				
				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 1000,

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
				multiSelect : true, //여러로우선택
				enablePagination : true,
				enablePaginationControls : true,

				columnDefs : [ //컬럼 세팅
				{
					displayName : 'C_GSBER',
					field : 'C_GSBER',
					width : '150',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'C_BACT',
					field : 'C_BACT',
					width : '150',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'SPMON',
					field : 'SPMON',
					width : '150',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'C_SPMON',
					field : 'C_SPMON',
					width : '150',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'STATU',
					field : 'STATU',
					width : '150',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'SEQ',
					field : 'SEQ',
					width : '150',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'C_SEQ',
					field : 'C_SEQ',
					width : '150',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'C_TYPE',
					field : 'C_TYPE',
					width : '150',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '입력년월',
					field : 'SPMON',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_yyyymm(row.entity.SPMON)}}</div>'
				}, {
					displayName : 'FROM',
					field : 'SPMON',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_yyyymm(row.entity.SPMON)}}</div>'
				}, {
					displayName : 'TO',
					field : 'C_SPMON',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_yyyymm(row.entity.C_SPMON)}}</div>'
				}, {
					displayName : '승인상태',
					field : 'STATUTXT',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '집행부서',
					field : 'RORG',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '집행부서명',
					field : 'RORGTXT',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '예산조직',
					field : 'BORG',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '예산조직명',
					field : 'BORGTXT',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '예산계정',
					field : 'BACT',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '예산계정명',
					field : 'BACTTXT',
					width : '110',
					visible : true,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '잔액',
					field : 'REMAMT',
					width : '9%',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.REMAMT)}}</div>'
				}, {
					displayName : '금액',
					field : 'VALUE',
					width : '9%',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.VALUE)}}</div>'
				}, {
					displayName : '내역',
					field : 'DOCUM',
					//width : '100',
					visible : true,
					cellClass : "left",
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
				RFC_TYPE : "ZFI_BUD", // RFC 구분
				RFC_FUNC : "ZFI_BUD_APPROVAL" // RFC 함수명
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
			
			// 부트스트랩 날짜객체
			$(".dtp").datepicker({
				format : "yyyy/mm",
				language : "ko",
				todayHighlight : true,
				autoclose : true,
				clearBtn : true,
				updateViewDate : false
			}).on('changeDate', function(){
			 	$('.datepicker').hide();
			});

			//조회조건 default
			if ("${req_data.GSBER_S}" == "") {
				$("input:radio[name='GSBER_S']:radio[value='1100']").prop('checked', true);
			}

			// 조회
			$("#search_btn").on("click", function() {
				if (fnValidation()) {
					scope.reloadGrid({
						GSBER_S : $('input[name=GSBER_S]:checked').val(), // 사업영역
						GSBER_E : null,
						RORG_S : $("#RORG_S").val(), // 집행부서
						RORG_E : null,
						BORG_S : $("#BORG_S").val(), // 예산조직
						BORG_E : null,
						BACT_S : $("#BACT_S").val(), // 예산계정
						BACT_E : null, // 예산계정
						SPMON_S : $("#SPMON_S").val(), // 전기년월
						SPMON_E : $("#SPMON_E").val(), // 전기년월
						GUBUN : $("input[name=GUBUN]:checked").val(), // 신청유형
						STATU : $("select[name=STATU]").val(), // 승인상태
					});
					if("I" === $("input[name=GUBUN]:checked").val() || "R" === $("input[name=GUBUN]:checked").val()){
						scope.gridOptions.columnDefs[8].visible = true;
						scope.gridOptions.columnDefs[9].visible = false;
						scope.gridOptions.columnDefs[10].visible = false;
					}else if("S" === $("input[name=GUBUN]:checked").val() || "T" === $("input[name=GUBUN]:checked").val()){
						scope.gridOptions.columnDefs[8].visible = false;
						scope.gridOptions.columnDefs[9].visible = true;
						scope.gridOptions.columnDefs[10].visible = true;
					}else{
						scope.gridOptions.columnDefs[8].visible = true;
						scope.gridOptions.columnDefs[9].visible = false;
						scope.gridOptions.columnDefs[10].visible = false;
					}
					scope.gridApi.grid.refresh();
				}
			});

			// 결재상신
			$("#edoc_write").on("click", function() {
				if (fnDocValidation()) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					var data = $("#data_form").serializeArray();
					var selectedRows = scope.gridApi.selection.getSelectedRows();
					data.push({name: "chk_no", value: JSON.stringify(selectedRows)});
					$.ajax({
						url : "/yp/popup/zfi/bud/retreveEdocPop",
						type : "POST",
						cache : false,
						async : true,
						dataType : "json",
						data : data,
						success : function(result) {
							if (result.result == "E") {
								swalWarningCB(result.msg);
							} else {
								var newwin = window.open(result.url, "전자결재 상신하기", "width=850,height=800,scrollbars=yes,resize=yes");
								if (newwin == null) {
									swalDangerCB("팝업 차단기능 혹은 팝업차단 프로그램이 동작중입니다. 팝업 차단 기능을 해제한 후 다시 시도하세요.");
								}
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
							swalDangerCB("처리중 오류가 발생하였습니다.\n관리자에게 문의해주세요.");
						}
					});
				}
			});
		});
		
		function fnDocWriteGW(url) {
			var newwin = window.open(url, "전자결재 상신하기", "width=850, height=800, scrollbars=yes, resize=yes");
			if (newwin == null) {
				swalWarning("팝업 차단기능 혹은 팝업차단 프로그램이 동작중입니다. 팝업 차단 기능을 해제한 후 다시 시도하세요.");
				return false
			}
		}

		function fnSearchPopup(type) {
			if (type == "1") {
				//window.open("/fi/","사업영역","width=630,height=800");
			} else if (type == "2") {
				window.open("/yp/popup/zfi/bud/retrieveBACT", "예산계정", "width=600,height=800,scrollbars=yes");
			} else if (type == "3") {
				window.open("/yp/popup/zfi/bud/retrieveKOSTL2?type=Z", "집행부서", "width=600,height=800,scrollbars=yes");
			} else if (type == "4") {
				window.open("/yp/popup/zfi/bud/retrieveKOSTL2?type=B", "예산조직", "width=600,height=800,scrollbars=yes");
			}
		}

		function fnDocValidation() {
			var index = $("input[name=chk_no]:checked").val();
			$("input[name=GSBER_R]").val($("input[name=GSBER_S]:checked").val());
			$("input[name=VALTP_R]").val($("input[name=GUBUN]:checked").val());

			var selectedRows = scope.gridApi.selection.getSelectedRows();
			if (!isEmpty(selectedRows)) {
				var bool = true;
				$.each(selectedRows, function(i, d) {
					var index = this.value;
					if (d.STATU == "1") {
						if ("R" == $("input[name=GUBUN]:checked").val() || "T" == $("input[name=GUBUN]:checked").val()) {
							swalWarningCB("그룹웨어 결재는 증액, 조기만 요청하실 수 있습니다.");
							bool = false;
							return false;
						}
					} else {
						swalWarningCB("전자결재 상신은 대기상태만 가능합니다.");
						bool = false;
						return false;
					}
				});
				if(!bool){
					return false;
				}
			} else {
				swalWarningCB("항목을 선택해야 합니다.");
				return false;
			}
			return true;
		}

		function fnValidation() {
			var s = $("input[name=SPMON_S]").val().replace(/[^0-9]/g, "");
			var e = $("input[name=SPMON_E]").val().replace(/[^0-9]/g, "");
			if (s > e) {
				swalWarning("입력년월 종료일이 시작일보다 과거입니다.");
				return false;
			}
			return true;
		}

		function fnDetailAmt(type, row) {
			$("input[name=I_GSBER]").val(row.GSBER);
			$("input[name=I_RORG]").val(row.RORG);
			$("input[name=I_BORG]").val(row.BORG);
			$("input[name=I_BACT]").val(row.BACT);
			$("input[name=I_SPMON]").val(row.SPMON);
			$("input[name=I_ACTIME]").val(row.ACTIME);

			if (type == "ACT") {
				window.open("", "ACT", "scrollbars=yes,width=1300,height=600");
				document.amt_frm.target = "ACT";
				document.amt_frm.action = "/yp/popup/zfi/bud/retrieveDetailAmtAct";
			} else if (type == "BUD") {
				window.open("", "BUD", "scrollbars=yes,width=1300,height=600");
				document.amt_frm.target = "BUD";
				document.amt_frm.action = "/yp/popup/zfi/bud/retrieveDetailAmtPlan";
			}
			$("#amt_frm").submit();
		}
	</script>
</body>