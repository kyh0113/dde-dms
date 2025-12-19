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
<title>개인 출퇴근 조회</title>
</head>
<body>
	<!-- 20191023_khj for csrf -->
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<h2>
		개인 출퇴근 조회
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
					<th>성명</th>
					<td>
						<input type="text" name="ser_name">
					</td>
					<th>&nbsp;</th>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<c:if test="${'SA' eq req_data.auth || 'MA' eq req_data.auth}">
					<th>사업장</th>
					<td>
						<select name="ser_cpname" onchange="fn_change_ser_cpname(this.value);">
							<option value="ALL" selected="selected">-전체-</option>
							<option value="1100">본사</option>
							<option value="1200">석포</option>
							<option value="1600">Green메탈캠퍼스</option>
						</select>
					</td>
					</c:if>
					<th>부서</th>
					<td>
						<select name="ser_teamname" onchange="fn_change_ser_teamname();">
							<c:choose>
								<c:when test="${'SA' eq req_data.auth || 'MA' eq req_data.auth}">
									<option value="" selected="selected">-전체-</option>
									<c:forEach var="t" items="${teamList}" varStatus="status">
										<option value="${t.OBJID}">${t.STEXT}</option>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach var="t" items="${teamList}" varStatus="status">
										<option value="${t.OBJID}" <c:if test="${status.first}">selected</c:if>>${t.STEXT}</option>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</select>
					</td>
					<th>반</th>
					<td>
						<select name="ser_group" onchange="fn_change_ser_class();">
							<c:choose>
								<c:when test="${'SA' eq req_data.auth || 'MA' eq req_data.auth}">
									<option value="" selected="selected">-전체-</option>
									<c:forEach var="t" items="${groupList}">
										<option value="${t.OBJID}">${t.STEXT}</option>
									</c:forEach>
								</c:when>
								<c:when test="${'IM' eq req_data.auth || 'TM' eq req_data.auth || 'WM' eq req_data.auth}">
									<option value="" selected="selected">-전체-</option>
									<c:forEach var="t" items="${groupList}">
										<option value="${t.OBJID}">${t.STEXT}</option>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach var="t" items="${groupList}">
										<option value="${t.OBJID}" <c:if test="${status.first}">selected</c:if>>${t.STEXT}</option>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</select>
					</td>
					<th>근무조</th>
					<td>
						<select name="ser_shift"  >
							<c:choose>
								<c:when test="${'SA' eq req_data.auth || 'MA' eq req_data.auth}">
									<option value="" selected="selected">-전체-</option>
									<c:forEach var="t" items="${shiftList}">
										<option value="${t.OBJID}">${t.STEXT}</option>
									</c:forEach>
								</c:when>
								<c:when test="${'IM' eq req_data.auth || 'TM' eq req_data.auth || 'WM' eq req_data.auth}">
									<option value="" selected="selected">-전체-</option>
									<c:forEach var="t" items="${shiftList}">
										<option value="${t.OBJID}">${t.STEXT}</option>
									</c:forEach>
								</c:when>
								<c:when test="${'CM' eq req_data.auth}">
									<option value="" selected="selected">-전체-</option>
									<c:forEach var="t" items="${shiftList}">
										<option value="${t.OBJID}">${t.STEXT}</option>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach var="t" items="${shiftList}">
										<option value="${t.OBJID}" <c:if test="${status.first}">selected</c:if>>${t.STEXT}</option>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</select>
					</td>
				</tr>
			</table>
			<div class="btn_wrap">
				<button class="btn btn_make" id="excel_btn" type="">엑셀 다운로드</button>
				<button class="btn btn_search" id="search_btn" type="">조회</button>
			</div>
		</div>
	</section>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="shdsCtrl" style="height: auto;">
			<div data-ui-i18n="ko" style="height: 620px;">
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
			$scope.uiGridConstants = uiGridConstants;
			$scope.pagination = vm.pagination;

			// 세션아이드코드 스코프에저장
			$scope.s_emp_code = "${s_emp_code}";

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

				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
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
					displayName : '일자',
					field : 'DATE',
					width : '80',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_date(row.entity.DATE)}}</div>'
				}, {
					displayName : '부서',
					field : 'ORGEH_T',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '반',
					field : 'CLASS_T',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '근무조',
					field : 'SCHKZ_T',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '원근무',
					field : 'ZCDTX',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '사번',
					field : 'PERNR',
					width : '90',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '성명',
					field : 'ENAME',
					width : '90',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '출근시간1',
					field : 'IN_TIME1',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_time(row.entity.IN_TIME1)}}</div>'
				}, {
					displayName : '퇴근시간1',
					field : 'OUT_TIME1',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_time(row.entity.OUT_TIME1)}}</div>'
				}, {
					displayName : '출근시간2',
					field : 'IN_TIME2',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_time(row.entity.IN_TIME2)}}</div>'
				}, {
					displayName : '퇴근시간2',
					field : 'OUT_TIME2',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_time(row.entity.OUT_TIME2)}}</div>'
				}, {
					displayName : '출근시간3',
					field : 'IN_TIME3',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_time(row.entity.IN_TIME3)}}</div>'
				}, {
					displayName : '퇴근시간3',
					field : 'OUT_TIME3',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_time(row.entity.OUT_TIME3)}}</div>'
				}, {
					displayName : '정상외 유형',
					field : 'ATEXT',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '비고',
					field : 'BIGO',
// 					width : '200',
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
			var scope;
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
				RFC_TYPE : "ZHR_TNA", // RFC 구분
				RFC_FUNC : "ZHR_PER_DAILY_REPORT" // RFC 함수명
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
				if (fnValidation()) {
					scope.reloadGrid({
						sdate : $("input[name=sdate]").val(),
						edate : $("input[name=edate]").val(),
						ser_cpname : $("select[name=ser_cpname]").val(),
						ser_teamname : $("select[name=ser_teamname]").val(),
						ser_group : $("select[name=ser_group]").val(),
						ser_shift : $("select[name=ser_shift]").val(),
						ser_name : $("input[name=ser_name]").val()
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

				xlsForm.target = "xlsx_download";
				xlsForm.name = "sndFrm";
				xlsForm.method = "post";
				xlsForm.action = "/yp/xls/zhr/tna/zhr_tna_list";

				document.body.appendChild(xlsForm);

				xlsForm.appendChild(csrf_element);

				var pr = {
					sdate : $("input[name=sdate]").val(),
					edate : $("input[name=edate]").val(),
					ser_teamname : $("select[name=ser_teamname]").val(),
					ser_group : $("select[name=ser_group]").val(),
					ser_shift : $("select[name=ser_shift]").val(),
					ser_name : $("input[name=ser_name]").val()
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
		});
		
		function fnValidation() {
			if ("" === $("input[name=sdate]").val()) {
				swalWarningCB("검색기간(시작)을 입력해주세요", function() {
					$("input[name=sdate]").focus();
				});
				return false;
			} else if ("" === $("input[name=edate]").val()) {
				swalWarningCB("검색기간(종료)을 입력해주세요", function() {
					$("input[name=edate]").focus();
				});
				return false;
			}
			//시작일 종료일 차이구하기
			var sdate = new Date($("input[name=sdate]").val());
			var edate = new Date($("input[name=edate]").val());
			var limit_mon = new Date($("input[name=sdate]").val());

			limit_mon.setMonth(sdate.getMonth() + 1);

			if (sdate > edate) {
				swalWarningCB("검색 종료일이 시작일보다 이전입니다.");
				return false;
			} else if ($("select[name=ser_teamname]").val() == "" && $("input[name=ser_name]").val() == "") {
				if (limit_mon.getTime() < edate.getTime()) {
					swalWarningCB("검색기간이 1개월로 제한됩니다.");
					return false;
				}
			}
			return true;
		}



		// 회사 변경 이벤트
		function fn_change_ser_cpname(tp){

			//부서 초기화
			fn_clear_team_class(tp);
			// 회사 초기화
			fn_clear_ser_class();
			
			var ser_cpname = $("select[name=ser_cpname] :checked").val();
			if(typeof ser_cpname === "undefined" || ser_cpname === ""){
				return false;
			}
			// 하위 반 조회 및 출력
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				url : "/yp/zhr/tna/select_ser_team",
				type : "POST",
				cache : false,
				async : true,
				dataType : "json",
				data : {
					"ser_cp" : ser_cpname,
					"zclss" : "${zclss}",
					"schkz" : "${schkz}"
				},
				success : function(result) {
					console.log(result);
					if(typeof result.list !== "undefined" && result.list.length > 0){
						$.each(result.list, function(i, d){
							console.log(i, d);
							$("select[name=ser_teamname]").append(new Option(d.STEXT, d.OBJID));
						});
// 						if("${req_data.auth}" === "SA" || "${req_data.auth}" === "MA"){
// 							$("select[name=ser_group]").prepend(new Option("전체", ""));
// 						}else if("${req_data.auth}" === "IM" || "${req_data.auth}" === "TM" || "${req_data.auth}" === "WM"){
// 							$("select[name=ser_group]").prepend(new Option("전체", ""));
// 						}
						$("select[name=ser_teamname] option:eq(0)").prop("selected", true);
						$("select[name=ser_teamname]").trigger("change");
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
					swalDangerCB("조회에 실패하였습니다.\n관리자에게 문의해주세요.");
				}
			});
			// 근무조 초기화
			// 하위 근무조 조회 및 출력
		}



		// 부서 변경 이벤트
		function fn_change_ser_teamname(){
			// 반 초기화
			fn_clear_ser_class();
			
			var ser_teamname = $("select[name=ser_teamname] :checked").val();
			if(typeof ser_teamname === "undefined" || ser_teamname === ""){
				return false;
			}
			// 하위 반 조회 및 출력
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				url : "/yp/zhr/tna/select_ser_class",
				type : "POST",
				cache : false,
				async : true,
				dataType : "json",
				data : {
					"orgeh" : ser_teamname,
					"zclss" : "${zclss}",
					"schkz" : "${schkz}"
				},
				success : function(result) {
					console.log(result);
					if(typeof result.list !== "undefined" && result.list.length > 0){
						$.each(result.list, function(i, d){
							console.log(i, d);
							$("select[name=ser_group]").append(new Option(d.STEXT, d.OBJID));
						});
// 						if("${req_data.auth}" === "SA" || "${req_data.auth}" === "MA"){
// 							$("select[name=ser_group]").prepend(new Option("전체", ""));
// 						}else if("${req_data.auth}" === "IM" || "${req_data.auth}" === "TM" || "${req_data.auth}" === "WM"){
// 							$("select[name=ser_group]").prepend(new Option("전체", ""));
// 						}
						$("select[name=ser_group] option:eq(0)").prop("selected", true);
						$("select[name=ser_group]").trigger("change");
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
					swalDangerCB("조회에 실패하였습니다.\n관리자에게 문의해주세요.");
				}
			});
			// 근무조 초기화
			// 하위 근무조 조회 및 출력
		}
		
		// 반 변경 이벤트
		function fn_change_ser_class(){
			// 근무조 초기화
			fn_clear_ser_shift();
			
			var ser_teamname = $("select[name=ser_teamname] :checked").val();
			var ser_class = $("select[name=ser_group] :checked").val();
			if(typeof ser_class === "undefined" || ser_class === ""){
				return false;
			}
			// 하위 근무조 조회 및 출력
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				url : "/yp/zhr/tna/select_ser_shift",
				type : "POST",
				cache : false,
				async : true,
				dataType : "json",
				data : {
					"orgeh" : ser_teamname,
					"zclss" : ser_class,
					"schkz" : "${schkz}"
				},
				success : function(result) {
					console.log(result);
					if(typeof result.list !== "undefined" && result.list.length > 0){
						$.each(result.list, function(i, d){
							console.log(i, d);
							$("select[name=ser_shift]").append(new Option(d.STEXT, d.OBJID));
						});
// 						if("${req_data.auth}" === "SA" || "${req_data.auth}" === "MA"){
// 							$("select[name=ser_shift]").prepend(new Option("전체", ""));
// 						}else if("${req_data.auth}" === "IM" || "${req_data.auth}" === "TM" || "${req_data.auth}" === "WM"){
// 							$("select[name=ser_shift]").prepend(new Option("전체", ""));
// 						}else if("${req_data.auth}" === "CM"){
// 							$("select[name=ser_shift]").prepend(new Option("전체", ""));
// 						}
						$("select[name=ser_shift] option:eq(0)").prop("selected", true);
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
					swalDangerCB("조회에 실패하였습니다.\n관리자에게 문의해주세요.");
				}
			});
		}

		// 부서 초기화
		function fn_clear_team_class(tp){
			$("select[name=ser_teamname]").empty();
			if(tp == "ALL"){
				$("select[name=ser_teamname]").prepend(new Option("전체", ""));
			}
			//if("${req_data.auth}" === "SA" || "${req_data.auth}" === "MA"){
				//$("select[name=ser_teamname]").prepend(new Option("전체", ""));
			//}else if("${req_data.auth}" === "IM" || "${req_data.auth}" === "TM" || "${req_data.auth}" === "WM"){
				//$("select[name=ser_teamname]").prepend(new Option("전체", ""));
			//}
		}

		// 반 초기화
		function fn_clear_ser_class(){
			$("select[name=ser_group]").empty();
			if("${req_data.auth}" === "SA" || "${req_data.auth}" === "MA"){
				$("select[name=ser_group]").prepend(new Option("전체", ""));
			}else if("${req_data.auth}" === "IM" || "${req_data.auth}" === "TM" || "${req_data.auth}" === "WM"){
				$("select[name=ser_group]").prepend(new Option("전체", ""));
			}
		}
		
		// 근무조 초기화
		function fn_clear_ser_shift(){
			$("select[name=ser_shift]").empty();
			if("${req_data.auth}" === "SA" || "${req_data.auth}" === "MA"){
				$("select[name=ser_shift]").prepend(new Option("전체", ""));
			}else if("${req_data.auth}" === "IM" || "${req_data.auth}" === "TM" || "${req_data.auth}" === "WM"){
				$("select[name=ser_shift]").prepend(new Option("전체", ""));
			}else if("${req_data.auth}" === "CM"){
				$("select[name=ser_shift]").prepend(new Option("전체", ""));
			}
		}
	</script>
	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
</body>
