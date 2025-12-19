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
<title>시간외근무 등록</title>
</head>
<body>
	<form id="frm" name="frm" method="post">
		<!-- 20191023_khj for csrf -->
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
	<h2>
		시간외근무 등록
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
					<th>상태</th>
					<td>
						<select name="ser_status" >
							<option value="">전체</option>
							<option value="W" <c:if test="${'W' eq req_data.ser_status}">selected</c:if>>대기</option>
							<option value="R" <c:if test="${'R' eq req_data.ser_status}">selected</c:if>>반려</option>
							<option value="C" <c:if test="${'C' eq req_data.ser_status}">selected</c:if>>승인</option>
						</select>
					</td>
					<th>성명</th>
					<td colspan="3">
						<input type="text" name="ser_name" >
					</td>
				</tr>
				<tr>
					<th>부서</th>
					<td>
						<input type="hidden" name="ser_teamcode" value="${req_data.user_deptcd}">
						<select name="ser_teamname" onchange="fn_change_ser_teamname();"  >
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
						<select name="ser_class" onchange="fn_change_ser_class();"  >
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
				<tr>
				</tr>
			</table>
			<div class="btn_wrap">
				<button class="btn btn_make" id="excel_btn" type="">엑셀 다운로드</button>
				<button class="btn btn_search" id="search_btn" type="">조회</button>
			</div>
		</div>
	</section>
	<div style="margin-bottom: 2px; margin-top: -25px;">
		<span style="font-size: 15px;"> * 작업구분(대체/연장/특별)<br> &nbsp;&nbsp;- 대체근무일 경우 대체-원근무자 입력, 근무직은 원근무자의 근무반 입력 <br> * 근무일 D+3일 이후에는 신청불가 (전자결재 "시간외근무미입력사유서" 제출) <br> * 실 근무시간 내에서 연장근무 신청 가능 <br> * 원근무 시간을 포함한 연장근무 신청 불가능 ex) 원근무 - 갑반 , 연장근무 - 13:00~17:00 신청 불가 <br>
		<span style="color: red;">* 대신 신청하는 경우, 【성명】검색 팝업을 통해 변경해주세요.</span>
		</span>
	</div>
	<div class="float_wrap" style="margin-bottom: 2px;">
		<div class="fl">
			<input type=button class="btn_g" id="fnAddRow" value="추가">
		</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type=button class="btn_g" id="fnReg" value="신청">
				<input type=button class="btn_g fnStausUpd" data-flag="X" value="신청취소">
				<c:if test="${'TM' eq req_data.auth || 'IM' eq req_data.auth}">
					&nbsp;&nbsp;
					<input type=button class="btn_g" id="fnSapConfirm" value="승인">
					<input type=button class="btn_g fnStausUpd" data-flag="R" value="반려">
				</c:if>
				<c:if test="${'SA' eq req_data.auth || 'MA' eq req_data.auth}">
					&nbsp;&nbsp;
					<input type=button class="btn_g" id="fnSapConfirm" value="승인">
					<input type=button class="btn_g fnStausUpd" data-flag="R" value="반려">
				</c:if>
			</div>
		</div>
	</div>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="shdsCtrl" style="height: auto;">
			<div data-ui-i18n="ko" style="height: 540px;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter ui-grid-pinning>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
	</section>
	<script>
		isAdmin = ("SA" == "${req_data.auth}" || "MA" == "${req_data.auth}");
		isEastOffice = "50000021" == "${req_data.user_deptcd}";
		
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

			// formater - String hhmi -> String hh:mi
			$scope.formatter_time_s = function(row) {
				var return_str = "";
				var str_date = row.entity.TIME_CARD1
				if (typeof str_date !== "undefined" && str_date !== null && str_date.length >= 4) {
					return_str = str_date.replace(/(\d{2})(\d{2})(\d{2})/g, '$1:$2');
				} else {
					return_str = "";
				}
				if(row.entity.TIME_CARD3 > "000000" && row.entity.TIME_CARD4 > "000000"){
					return_str += ", " + row.entity.TIME_CARD3.replace(/(\d{2})(\d{2})(\d{2})/g, '$1:$2');
				}
				if(row.entity.TIME_CARD5 > "000000" && row.entity.TIME_CARD6 > "000000"){
					return_str += ", " + row.entity.TIME_CARD5.replace(/(\d{2})(\d{2})(\d{2})/g, '$1:$2');
				}
				return return_str;
			};
			
			// formater - String hhmi -> String hh:mi
			$scope.formatter_time_e = function(row) {
				var return_str = "";
				var str_date = row.entity.TIME_CARD2
				if (typeof str_date !== "undefined" && str_date !== null && str_date.length >= 4) {
					return_str = str_date.replace(/(\d{2})(\d{2})(\d{2})/g, '$1:$2');
				} else {
					return_str = "";
				}
				if(row.entity.TIME_CARD3 > "000000" && row.entity.TIME_CARD4 > "000000"){
					return_str += ", " + row.entity.TIME_CARD4.replace(/(\d{2})(\d{2})(\d{2})/g, '$1:$2');
				}
				if(row.entity.TIME_CARD5 > "000000" && row.entity.TIME_CARD6 > "000000"){
					return_str += ", " + row.entity.TIME_CARD6.replace(/(\d{2})(\d{2})(\d{2})/g, '$1:$2');
				}
				return return_str;
			};

			// formater - String hhmi -> String hh:mi
			$scope.formatter_status = function(str_date) {
				if (str_date === "W") {
					return "대기";
				} else if (str_date === "R") {
					return "반려";
				} else if (str_date === "C") {
					return "승인";
				} else {
					return "";
				}
			};

			// 근무일자
			var WORK_STARTDATE = '<div ng-if="row.entity.STATUS != null" class="ui-grid-cell-contents" ng-model="row.entity.WORK_STARTDATE" >{{row.entity.WORK_STARTDATE}}</div>';
			var WORK_STARTDATE_NEW = '<input ng-if="row.entity.STATUS == null" type="text" class="calendar dtp" ng-model="row.entity.WORK_STARTDATE" ng-change="grid.appScope.fnRetrieveEmpInfo(row)"/>';

			// 근무일자, 성명 이벤트
			$scope.fnRetrieveEmpInfo_e = function(row) {
				viewModal_row = row;
				var $vieweModal = $("#viewModal");
				$vieweModal.modal({
					backdrop : 'static',
					keyboard: false
				});
			}
// 			$scope.fnRetrieveEmpInfo_e = function(row, keyEvent) {
// 				console.log(keyEvent.which);
// 				if(keyEvent.which === 13 || keyEvent.which === 9){
// 					viewModal_row = row;
// 					var $vieweModal = $("#viewModal");
// 					$vieweModal.modal({
// 						backdrop : 'static',
// 						keyboard: false
// 					});
// 				}
// 			}
			// 근무일자, 성명 이벤트
			$scope.fnRetrieveEmpInfo = function(row) {
				row.entity.WORK_ENDDATE = "";
				if (fnDateCompare(row.entity.WORK_STARTDATE) && !isAdmin) {
					swalWarningCB("신청가능 날짜가 아닙니다.");
					row.entity.WORK_STARTDATE = "";
				} else {
					var name = $.trim(row.entity.EMP_NAME);
					row.entity.EMP_NAME = name;
					var user_teamcode = $("input[name=ser_teamcode]").val();
					if (name.length >= 2) {
						if (row.entity.WORK_STARTDATE != "") {
							var token = $("meta[name='_csrf']").attr("content");
							var header = $("meta[name='_csrf_header']").attr("content");
							$.ajax({
								url : "/yp/zhr/tna/retrieveEmpWorkInfo",
								type : "post",
								cache : false,
								async : true,
								data : {
									"search_name" : name
								},
								dataType : "json",
								success : function(result) {
									if (result.list == null || result.list.length === 0) {
										swalWarningCB("데이터가 없습니다.");
										row.entity.EMP_CODE = "";
										row.entity.EMP_NAME = "";
										scope.gridApi.grid.refresh();
									} else if (result.list.length > 1) {
										//동명자 팝업
										row.entity.EMP_CODE = "";
										row.entity.EMP_NAME = "";
										scope.gridApi.grid.refresh();
										window.open("/yp/popup/zhr/tna/retrieveSameNamePop?target="+scope.gridOptions.data.indexOf(row.entity)+"&search_name="+name+"&_csrf=${_csrf.token}","same_name_pop","width=800px,height=600px,scrollbars=yes");
										//fnRetrieveOriginWork(row); //원근무 정보 조회
									} else if (user_teamcode != result.list[0].ORGEH && !isAdmin) {
										swalWarningCB("같은 부서의 인원이 아닙니다.");
										// console.log(user_teamcode + "/" + result.list[0].ORGEH);
									} else {
										row.entity.EMP_CODE = result.list[0].EMP_CD;
										row.entity.TEAM_CODE = result.list[0].ORGEH;
										row.entity.TEAM_NAME = result.list[0].ORGTX;
										row.entity.WORK_GROUP_CODE = result.list[0].ZCLSS;
										row.entity.WORK_GROUP = result.list[0].ZCLST;
										row.entity.WORK_SHIFT_CODE = result.list[0].SCHKZ;
										row.entity.WORK_SHIFT = result.list[0].JO_NAME;

										fnRetrieveOriginWork(row); //원근무 정보 조회
									}
									scope.gridApi.grid.refresh();
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
									swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
								}
							});
						} else {
							swalWarningCB("근무일자를 입력해주세요.");
						}
					}
				}
			};
			
			// 성명
			var EMP_NAME = 		'<div ng-if="row.entity.STATUS != null" class="ui-grid-cell-contents" ng-model="row.entity.EMP_NAME" >{{row.entity.EMP_NAME}}</div>';
			var EMP_NAME_NEW = 	'<div ng-if="row.entity.STATUS == null" class="ui-grid-cell-contents" ng-model="row.entity.EMP_NAME" >{{row.entity.EMP_NAME}}<img src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnRetrieveEmpInfo_e(row)"></div>';
// 			var EMP_NAME_NEW = '<input ng-if="row.entity.STATUS == null" type="text" class="" ng-model="row.entity.EMP_NAME" ng-keypress="grid.appScope.fnRetrieveEmpInfo_e(row, $event)"/>';

			// 작업구분
			var WORK_TYPE1 = '<div ng-if="row.entity.STATUS != null" class="ui-grid-cell-contents" ng-model="row.entity.WORK_TYPE1" >{{row.entity.WORK_TYPE1}}</div>';
			var WORK_TYPE1_NEW = 
				'<select ng-if="row.entity.STATUS == null" ng-model="row.entity.WORK_TYPE1_CODE" ng-change="grid.appScope.worktype2Options(row)" style="width: 100%; padding: 0;" >' + 
				'	<option ng-repeat="SB_WORK_TYPE1 in grid.appScope.SB_WORK_TYPE1" ng-selected="row.entity.WORK_TYPE1_CODE == SB_WORK_TYPE1.code_id" value="{{SB_WORK_TYPE1.code_id}}" >{{SB_WORK_TYPE1.code_name}}</option>' + 
				'</select>';

			// 작업구분 콤보
			$scope.SB_WORK_TYPE1 = [ {
				"code_id" : "",
				"code_name" : "선택"
			}, {
				"code_id" : "A",
				"code_name" : "대체근무"
			}, {
				"code_id" : "B",
				"code_name" : "연장근무"
			}, {
				"code_id" : "C",
				"code_name" : "특별근무"
			} ];

			// 작업구분 이벤트
			$scope.worktype2Options = function(row) {
				// 작업구분명
				$.each(scope.SB_WORK_TYPE1, function(i, d) {
					if (d.code_id == row.entity.WORK_TYPE1_CODE) {
						row.entity.WORK_TYPE1 = d.code_id === "" ? "" : d.code_name;
						return false;
					}
				});
				row.entity.ORIGIN_WORKER = ""; // 원근무자 초기화
				row.entity.ORIGIN_WORKER_NAME = ""; // 원근무자 초기화
				row.entity.WORK_TYPE2_CODE = ""; // 작업세부구분 초기화
				row.entity.WORK_TYPE2 = ""; // 작업세부구분 초기화
				
				var type1 = row.entity.WORK_TYPE1_CODE;
				if(type1 == "" || type1 == "- 선 택 -"){
					swalWarningCB("올바른 항목을 선택하세요.");
					return false;
				} 
				if(type1=="A"){
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zhr/tna/retrieveVacationEmpList",
						type : "post",
						cache : false,
						async : true,
						data : {
							"work_startdate" : row.entity.WORK_STARTDATE,
							"userDeptCd" : row.entity.TEAM_CODE
						},
						dataType : "json",
						success : function(result) {
							// console.log(result);
							if (result.msg == "S") {
								SB_ORIGIN_WORKER_NAME_1 = ori_SB_ORIGIN_WORKER_NAME_1;
								for(var i=0;i<result.list.length;i++){
									scope.SB_ORIGIN_WORKER_NAME_1.splice(1, 0, {code_id: result.list[i].AWART+","+result.list[i].PERNR, code_name: result.list[i].SNAME + "-" + result.list[i].ATEXT});
								}
							} else {
								SB_ORIGIN_WORKER_NAME_1 = ori_SB_ORIGIN_WORKER_NAME_1;
								swalWarningCB(result.msg);
							}
							row.entity.WORK_TYPE2_CODE = "";
							row.entity.WORK_TYPE2 = "";
							row.entity.WORK_DSC = "대체근무";
							scope.gridApi.grid.refresh();
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
							swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
				} else if(type1=="B") {
					row.entity.WORK_TYPE2_CODE = "B001";
					// 작업구분명
					$.each(scope.SB_WORK_TYPE2_1, function(i, d) {
						if (d.code_id == row.entity.WORK_TYPE2_CODE) {
							row.entity.WORK_TYPE2 = d.code_id === "" ? "" : d.code_name;
							return false;
						}
					});
					row.entity.WORK_DSC = "";
					scope.gridApi.grid.refresh();
				} else if(type1=="C") {
					row.entity.WORK_TYPE2_CODE = "C001";
					// 작업구분명
					$.each(scope.SB_WORK_TYPE2_2, function(i, d) {
						if (d.code_id == row.entity.WORK_TYPE2_CODE) {
							row.entity.WORK_TYPE2 = d.code_id === "" ? "" : d.code_name;
							return false;
						}
					});
					row.entity.WORK_DSC = "";
					scope.gridApi.grid.refresh();
				}
			};

			// 원근무자
			var ORIGIN_WORKER = '<div ng-if="row.entity.STATUS != null" class="ui-grid-cell-contents" ng-model="row.entity.ORIGIN_WORKER_NAME" >{{row.entity.ORIGIN_WORKER_NAME}}</div>';
			var ORIGIN_WORKER_NEW1 = 
				'<select ng-if="row.entity.STATUS == null && row.entity.WORK_TYPE1_CODE == \'A\'" ng-model="row.entity.ORIGIN_WORKER" ng-change="grid.appScope.fnSelectInput(row)" style="width: 100%; padding: 0;">' + 
				'	<option ng-repeat="SB_ORIGIN_WORKER_NAME_1 in grid.appScope.SB_ORIGIN_WORKER_NAME_1" ng-selected="row.entity.ORIGIN_WORKER == SB_ORIGIN_WORKER_NAME_1.code_id" value="{{SB_ORIGIN_WORKER_NAME_1.code_id}}" >{{SB_ORIGIN_WORKER_NAME_1.code_name}}</option>' + 
				'</select>';
			var ORIGIN_WORKER_NEW2 = '<div ng-if="row.entity.STATUS == null || row.entity.WORK_TYPE1_CODE != \'A\'" class="ui-grid-cell-contents" ng-model="row.entity.ORIGIN_WORKER_NAME" >{{row.entity.ORIGIN_WORKER_NAME}}</div>';

			// 원근무자 콤보(작업구분:대체근무)
			var ori_SB_ORIGIN_WORKER_NAME_1 = [{
				"code_id" : "",
				"code_name" : "선택"
			}, {
				"code_id" : "A001",
				"code_name" : "휴 직"
			}, {
				"code_id" : "A002",
				"code_name" : "결 원"
			}];
			$scope.SB_ORIGIN_WORKER_NAME_1 = ori_SB_ORIGIN_WORKER_NAME_1;

			// 원근무자 이벤트
			$scope.fnSelectInput = function(row) {
				// 작업구분명
				row.entity.ORIGIN_WORKER_NAME = "";
				$.each(scope.SB_ORIGIN_WORKER_NAME_1, function(i, d) {
					if (d.code_id == row.entity.ORIGIN_WORKER) {
						row.entity.ORIGIN_WORKER_NAME = d.code_id === "" ? "" : d.code_name;
						return false;
					}
				});
				var text_ori = row.entity.ORIGIN_WORKER_NAME;
				var value_ori = row.entity.ORIGIN_WORKER;
				var text = text_ori.split("-");
				var value = value_ori.split(",");
				row.entity.ORIGIN_WORKER_CODE = value[1];
				row.entity.ORIGIN_WORKER_NAME = text[0];
				if(text[1] != undefined){
					scope.SB_WORK_TYPE2_3 = [];
					scope.SB_WORK_TYPE2_3.push({
						code_id : value[0],
						code_name : text[1]
					});
				}else{
					scope.SB_WORK_TYPE2_3 = [];
					$.each(scope.SB_ORIGIN_WORKER_NAME_1, function(i, d) {
						if (d.code_id == row.entity.ORIGIN_WORKER) {
							scope.SB_WORK_TYPE2_3.push({
								code_id : row.entity.ORIGIN_WORKER,
								code_name : d.code_name
							});
							return false;
						}
					});
				}
				row.entity.WORK_TYPE2_CODE = value_ori;
				row.entity.WORK_TYPE2 = text_ori;
				
				scope.gridApi.grid.refresh();
			}

			// 작업세부구분
			var WORK_TYPE2 = '<div ng-if="row.entity.STATUS != null" class="ui-grid-cell-contents" ng-model="row.entity.WORK_TYPE2" >{{row.entity.WORK_TYPE2}}</div>';
			var WORK_TYPE2_NEW1 = 
				'<select ng-if="row.entity.STATUS == null && row.entity.WORK_TYPE1_CODE == \'B\'" ng-model="row.entity.WORK_TYPE2_CODE" ng-change="grid.appScope.fnWorkType2Text1(row)" style="width: 100%; padding: 0;">' + 
				'	<option ng-repeat="SB_WORK_TYPE2_1 in grid.appScope.SB_WORK_TYPE2_1" ng-selected="row.entity.WORK_TYPE2_CODE == SB_WORK_TYPE2_1.code_id" value="{{SB_WORK_TYPE2_1.code_id}}" >{{SB_WORK_TYPE2_1.code_name}}</option>' + 
				'</select>';
			var WORK_TYPE2_NEW2 = 
				'<select ng-if="row.entity.STATUS == null && row.entity.WORK_TYPE1_CODE == \'C\'" ng-model="row.entity.WORK_TYPE2_CODE" ng-change="grid.appScope.fnWorkType2Text2(row)" style="width: 100%; padding: 0;">' + 
				'	<option ng-repeat="SB_WORK_TYPE2_2 in grid.appScope.SB_WORK_TYPE2_2" ng-selected="row.entity.WORK_TYPE2_CODE == SB_WORK_TYPE2_2.code_id" value="{{SB_WORK_TYPE2_2.code_id}}" >{{SB_WORK_TYPE2_2.code_name}}</option>' + 
				'</select>';
			var WORK_TYPE2_NEW3 = 
				'<select ng-if="row.entity.STATUS == null && row.entity.WORK_TYPE1_CODE == \'A\'" ng-model="row.entity.WORK_TYPE2_CODE" style="width: 100%; padding: 0;">' + 
				'	<option ng-repeat="SB_WORK_TYPE2_3 in grid.appScope.SB_WORK_TYPE2_3" ng-selected="row.entity.WORK_TYPE2_CODE == SB_WORK_TYPE2_3.code_id" value="{{SB_WORK_TYPE2_3.code_id}}" >{{SB_WORK_TYPE2_3.code_name}}</option>' + 
				'</select>';

			// 작업세부구분 콤보(작업구분:연장근무)
			$scope.SB_WORK_TYPE2_1 = [ {
				"code_id" : "B001",
				"code_name" : "수시"
			}, {
				"code_id" : "B002",
				"code_name" : "보수"
			}, {
				"code_id" : "B003",
				"code_name" : "긴급"
			}, {
				"code_id" : "B004",
				"code_name" : "교육"
			} ];

			// 작업세부구분 콤보(작업구분:특별근무)
			$scope.SB_WORK_TYPE2_2 = [ {
				"code_id" : "C001",
				"code_name" : "공휴"
			}, {
				"code_id" : "C002",
				"code_name" : "기타"
			} ];

			// 작업세부구분 콤보(작업구분:대체근무) - 원근무자 선택에 따라서 변화함.
			$scope.SB_WORK_TYPE2_3 = [];

			// 작업세부구분 이벤트1
			$scope.fnWorkType2Text1 = function(row) {
				// 작업구분명
				row.entity.WORK_TYPE2 = "";
				$.each(scope.SB_WORK_TYPE2_1, function(i, d) {
					if (d.code_id == row.entity.WORK_TYPE2_CODE) {
						row.entity.WORK_TYPE2 = d.code_id === "" ? "" : d.code_name;
						return false;
					}
				});
				
				scope.gridApi.grid.refresh();
			}

			// 작업세부구분 이벤트2
			$scope.fnWorkType2Text2 = function(row) {
				// 작업구분명
				row.entity.WORK_TYPE2 = "";
				$.each(scope.SB_WORK_TYPE2_2, function(i, d) {
					if (d.code_id == row.entity.WORK_TYPE2_CODE) {
						row.entity.WORK_TYPE2 = d.code_id === "" ? "" : d.code_name;
						return false;
					}
				});
				
				scope.gridApi.grid.refresh();
			}

			// 작업사유
			var WORK_DSC = '<div ng-if="row.entity.STATUS != null" class="ui-grid-cell-contents" ng-model="row.entity.WORK_DSC" >{{row.entity.WORK_DSC}}</div>';
			var WORK_DSC_NEW = '<input ng-if="row.entity.STATUS == null" type="text" ng-model="row.entity.WORK_DSC" />';
			
			// 근무직
			var OVER_WORK = '<div ng-if="row.entity.STATUS != null" class="ui-grid-cell-contents" ng-model="row.entity.OVER_WORK" >{{row.entity.OVER_WORK}}</div>';
			var OVER_WORK_NEW = 
				'<select ng-if="row.entity.STATUS == null" ng-model="row.entity.OVER_WORK_CODE" ng-change="grid.appScope.fnWorkTimeSet(row)" style="width: 100%; padding: 0;">' + 
				'	<option ng-repeat="SB_OVER_WORK in grid.appScope.SB_OVER_WORK" ng-selected="row.entity.OVER_WORK_CODE == SB_OVER_WORK.code_id" value="{{SB_OVER_WORK.code_id}}" >{{SB_OVER_WORK.code_name}}</option>' + 
				'</select>';

			// 근무직 콤보
			$scope.SB_OVER_WORK = [ {
				"code_id" : "0009",
				"code_name" : "기타"
			}, {
				"code_id" : "0000",
				"code_name" : "상갑반"
			}, {
				"code_id" : "0001",
				"code_name" : "갑반"
			}, {
				"code_id" : "0002",
				"code_name" : "을반"
			}, {
				"code_id" : "0003",
				"code_name" : "병반"
			}, {
				"code_id" : "0010",
				"code_name" : "수전갑반"
			}, {
				"code_id" : "0011",
				"code_name" : "수전을반"
			}, {
				"code_id" : "0012",
				"code_name" : "수전병반"
			} ];

			// 근무직 이벤트
			$scope.fnWorkTimeSet = function(row) {
				// 근무직명
				row.entity.OVER_WORK = "";
				$.each(scope.SB_OVER_WORK, function(i, d) {
					if (d.code_id == row.entity.OVER_WORK_CODE) {
						row.entity.OVER_WORK = d.code_id === "" ? "" : d.code_name;
						return false;
					}
				});
				var code = row.entity.OVER_WORK_CODE;
				var time1 = "";
				var time2 = "";
				if(code == "0000"){//상갑반
					time1 = "08:00";
					time2 = "17:00";
					row.entity.REST_STIME = "12:00";
					row.entity.REST_ETIME = "13:00";
				}else if(code == "0001"){//갑반
					time1 = "07:00";
					time2 = "15:00";
					row.entity.REST_STIME = "";
					row.entity.REST_ETIME = "";
				}else if(code == "0002"){//을반
					time1 = "15:00";
					time2 = "23:00";
					row.entity.REST_STIME = "";
					row.entity.REST_ETIME = "";
				}else if(code == "0003"){//병반
					time1 = "23:00";
					time2 = "07:00";
					row.entity.REST_STIME = "";
					row.entity.REST_ETIME = "";
				}else if(code == "0010"){//수전갑반
					time1 = "07:30";
					time2 = "15:30";
					row.entity.REST_STIME = "";
					row.entity.REST_ETIME = "";
				}else if(code == "0011"){//수전을반
					time1 = "15:30";
					time2 = "23:30";
					row.entity.REST_STIME = "";
					row.entity.REST_ETIME = "";
				}else if(code == "0012"){//수전병반
					time1 = "23:30";
					time2 = "07:30";
					row.entity.REST_STIME = "";
					row.entity.REST_ETIME = "";
				}else{
					console.log("원근무 코드값 없음");
				}
				row.entity.TRUE_WORK_STARTTIME = time1;
				row.entity.TRUE_WORK_ENDTIME = time2;
				
				scope.gridApi.grid.refresh();
				
				scope.fnTimecheck(row);
			}

			// 연장시간 시작
			var TRUE_WORK_STARTTIME = '<div ng-if="row.entity.STATUS != null" class="ui-grid-cell-contents" ng-model="row.entity.TRUE_WORK_STARTTIME" >{{row.entity.TRUE_WORK_STARTTIME}}</div>';
			var TRUE_WORK_STARTTIME_NEW = '<input ng-if="row.entity.STATUS == null" type="text" ng-model="row.entity.TRUE_WORK_STARTTIME" ng-change="grid.appScope.fnTimecheck(row)" />';

			// 연장시간 종료
			var TRUE_WORK_ENDTIME = '<div ng-if="row.entity.STATUS != null" class="ui-grid-cell-contents" ng-model="row.entity.TRUE_WORK_ENDTIME" >{{row.entity.TRUE_WORK_ENDTIME}}</div>';
			var TRUE_WORK_ENDTIME_NEW = '<input ng-if="row.entity.STATUS == null" type="text" ng-model="row.entity.TRUE_WORK_ENDTIME" ng-change="grid.appScope.fnTimecheck(row)" />';

			// 연장시간 이벤트
			$scope.fnTimecheck = function(row) {
				var starttime = row.entity.TRUE_WORK_STARTTIME;
				var endtime = row.entity.TRUE_WORK_ENDTIME;
				var timeRegExp = /^([1-9]|[01][0-9]|2[0-3]):([0-5][0-9])$/;//시간포맷
				
				if(starttime.length == 2){
					row.entity.TRUE_WORK_STARTTIME = starttime + ":";
					return false; // 리턴 시키고 다시 본 이벤트를 타도록 유도
				}
				if(endtime.length == 2){
					row.entity.TRUE_WORK_ENDTIME = endtime + ":";
					return false; // 리턴 시키고 다시 본 이벤트를 타도록 유도
				}
				
				if(starttime.length > 4 && endtime.length > 4){
					if(timeRegExp.test(starttime) && timeRegExp.test(endtime)){
						var start = starttime.split(":");
						var end = endtime.split(":");
						var s_hour = Number(start[0]);
						var s_min = Number(start[1]);
						var e_hour = Number(end[0]);
						var e_min = Number(end[1]);
						
						if(s_min > e_min){//분단위 확인
							e_hour = e_hour - 1;
							e_min = e_min + 60;
						}
						var work_min = e_min - s_min;
						var work_min_60 = work_min;
						work_min = work_min * 10 / 600;
						
						if(s_hour > e_hour){
							e_hour = e_hour + 24;
							row.entity.WORK_ENDDATE = fn_tomorrow(row.entity.WORK_STARTDATE);
						}else{
							row.entity.WORK_ENDDATE = row.entity.WORK_STARTDATE;
						}
						var work_hour = e_hour - s_hour;
						if(row.entity.OVER_WORK_CODE == "0000"){
							var st = starttime.replace(":","");
							var et = endtime.replace(":","");
							if((st  > "1200" &&  st < "1300") || (et > "1200" && et < "1300")){
								swalWarningCB("시작시간 또는 종료시간은 휴게시간에 포함될 수 없습니다.");
								row.entity.OVERTIME = "";
								scope.gridApi.grid.refresh();
								return false;
							}else if((st <= "1200") && (et >= "1300")){
								work_hour += -1;
							}	
						}
// 						if(row.entity.OVER_WORK_CODE == "0000"){
// 							work_hour += -1;
// 						}
						row.entity.OVERTIME = (work_hour + work_min).toFixed(2);//소수점표시 - 구웹포탈 표시
						console.log(work_hour + work_min, (work_hour + work_min).toFixed(2));
						row.entity.TRUE_OVERTIME = (work_hour + work_min).toFixed(2);//소수점표시
						
						work_hour = "" + work_hour;
						if(work_hour.length < 2){
							work_hour = "0" + work_hour;
						}
						
						work_min_60 = "" + work_min_60;
						if(work_min_60.length < 2){
							work_min_60 = "0" + work_min_60;
						}
						row.entity.TRUE_OVERTIME = (work_hour + work_min_60);//시간표시 - 구웹포탈 히든값
					}else{
						swalWarningCB("시간형식에 맞지 않습니다. 23:59 포맷으로 입력해주세요.");
					}
				}else{
					row.entity.TRUE_OVERTIME = "";
				}
				
				scope.gridApi.grid.refresh();
			}

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
				multiSelect : true, //여러로우선택
				enablePagination : true,
				enablePaginationControls : true,


				columnDefs : [ //컬럼 세팅
				{
					displayName : '상태',
					field : 'STATUS',
					width : '80',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_status(row.entity.STATUS)}}</div>'
				}, {
					displayName : '근무일자',
					field : 'WORK_STARTDATE',
					width : '130',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : WORK_STARTDATE + WORK_STARTDATE_NEW
				}, {
					displayName : '사번',
					field : 'EMP_CODE',
					width : '80',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '성명',
					field : 'EMP_NAME',
					width : '90',
					visible : true,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : EMP_NAME + EMP_NAME_NEW
				}, {
					displayName : '부서',
					field : 'TEAM_NAME',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '반',
					field : 'WORK_GROUP',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '근무조',
					field : 'WORK_SHIFT',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '원근무',
					field : 'ORIGIN_WORK',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '작업구분',
					field : 'WORK_TYPE1_CODE',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : WORK_TYPE1 + WORK_TYPE1_NEW
				}, {
					displayName : '원근무자',
					field : 'ORIGIN_WORKER',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : ORIGIN_WORKER + ORIGIN_WORKER_NEW1 + ORIGIN_WORKER_NEW2
				}, {
					displayName : '작업세부구분',
					field : 'WORK_TYPE2',
					width : '130',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : WORK_TYPE2 + WORK_TYPE2_NEW1 + WORK_TYPE2_NEW2 + WORK_TYPE2_NEW3
				}, {
					displayName : '작업사유',
					field : 'WORK_DSC',
					width : '150',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : WORK_DSC + WORK_DSC_NEW
				}, {
					displayName : '실근무시간(시작)',
					field : 'TIME_CARD_S',
					width : '150',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_time_s(row)}}</div>'
				}, {
					displayName : '실근무시간(종료)',
					field : 'TIME_CARD_E',
					width : '150',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_time_e(row)}}</div>'
				}, {
					displayName : '근무직',
					field : 'OVER_WORK',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : OVER_WORK + OVER_WORK_NEW
				}, {
					displayName : '연장시간(시작)',
					field : 'TRUE_WORK_STARTTIME',
					width : '140',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : TRUE_WORK_STARTTIME + TRUE_WORK_STARTTIME_NEW
				}, {
					displayName : '연장시간(종료)',
					field : 'TRUE_WORK_ENDTIME',
					width : '140',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : TRUE_WORK_ENDTIME + TRUE_WORK_ENDTIME_NEW
				}, {
					displayName : '휴식시간(시작)',
					field : 'REST_STIME',
					width : '140',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '휴식시간(종료)',
					field : 'REST_ETIME',
					width : '140',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '연장근무',
					field : 'TRUE_OVERTIME',
					width : '100',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '연장근무',
					field : 'OVERTIME',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '등록일자',
					field : 'REG_DATE_DAY',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '등록시간',
					field : 'REG_DATE_TIME',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '등록자',
					field : 'REG_WORKER_NAME',
					width : '90',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '승인일자',
					field : 'CONFIRM_DATE_DAY',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '승인시간',
					field : 'CONFIRM_DATE_TIME',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '승인자',
					field : 'CONFIRM_WORKER_NAME',
					width : '90',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'TEAM_CODE',
					field : 'TEAM_CODE',
					width : '150',
					visible : false
				}, {
					displayName : 'REGULAR_WORK1',
					field : 'REGULAR_WORK1',
					width : '150',
					visible : false
				}, {
					displayName : 'REGULAR_WORK2',
					field : 'REGULAR_WORK2',
					width : '150',
					visible : false
				}, {
					displayName : 'WORK_ENDDATE',
					field : 'WORK_ENDDATE',
					width : '150',
					visible : false
				}, {
					displayName : 'WORK_GROUP_CODE',
					field : 'WORK_GROUP_CODE',
					width : '150',
					visible : false
				}, {
					displayName : 'WORK_SHIFT_CODE',
					field : 'WORK_SHIFT_CODE',
					width : '150',
					visible : false
				}, {
					displayName : 'ORIGIN_WORK_CODE',
					field : 'ORIGIN_WORK_CODE',
					width : '150',
					visible : false
				}, {
					displayName : 'ORIGIN_WORKER_NAME',
					field : 'ORIGIN_WORKER_NAME',
					width : '150',
					visible : false
				}, {
					displayName : 'TIME_CARD1',
					field : 'TIME_CARD1',
					width : '150',
					visible : false
				}, {
					displayName : 'TIME_CARD2',
					field : 'TIME_CARD2',
					width : '150',
					visible : false
				}, {
					displayName : 'TIME_CARD3',
					field : 'TIME_CARD3',
					width : '150',
					visible : false
				}, {
					displayName : 'TIME_CARD4',
					field : 'TIME_CARD4',
					width : '150',
					visible : false
				}, {
					displayName : 'TIME_CARD5',
					field : 'TIME_CARD5',
					width : '150',
					visible : false
				}, {
					displayName : 'TIME_CARD6',
					field : 'TIME_CARD6',
					width : '150',
					visible : false
				} ]
			});

			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  
		} ]);
		var scope;
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
				listQuery : "yp_zhr_tna.select_zhr_per_daily_report", //list가져오는 마이바티스 쿼리 아이디
				cntQuery : "yp_zhr_tna.select_zhr_per_daily_report_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝

			// 부트스트랩 날짜객체
			$(document).on("focus", ".dtp", function() {
				$(this).datepicker({
					format : "yyyy/mm/dd",
					language : "ko",
					todayHighlight : true,
					autoclose : true,
					clearBtn : true,
					updateViewDate : false
				}).on('changeDate', function(ev) {
					$(this).trigger("change");
					$('.datepicker').hide();
				});
			});

			// 조회
			$("#search_btn").on("click", function() {
				scope.reloadGrid({
					emp_code : "${req_data.emp_code}",
					emp_name : "${req_data.emp_name}",
					user_deptcd : "${req_data.user_deptcd}",
					user_dept : "${req_data.user_dept}",
					ofc_name : "${req_data.ofc_name}",
					auth : "${req_data.auth}",
					sdate : $("input[name=sdate]").val(),
					edate : $("input[name=edate]").val(),
					ser_teamname : $("[name=ser_teamname]").val(),
					ser_class : $("[name=ser_class]").val(),
					ser_shift : $("[name=ser_shift]").val(),
					ser_status : $("[name=ser_status]").val(),
					ser_name : $("[name=ser_name]").val()
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

			// 신청
			$("#fnAddRow").on("click", function() {
				scope.addRow({
					TEAM_CODE : "",
					REGULAR_WORK1 : "",
					REGULAR_WORK2 : "",
					WORK_ENDDATE : "",
					WORK_GROUP_CODE : "",
					WORK_SHIFT_CODE : "",
					ORIGIN_WORK_CODE : "",
					STATUS : null, /* 상태 */
					WORK_STARTDATE : "", /* 근무일 */
					EMP_CODE : "${req_data.emp_code}", /* 사번 */
					EMP_NAME : "${req_data.emp_name}", /* 성명 */
					TEAM_NAME : "${req_data.user_dept}", /* 부서 */
					WORK_GROUP : "", /* 근무반 */
					WORK_SHIFT : "", /* 근무조 */
					ORIGIN_WORK : "", /* 원근무 */
					WORK_TYPE1_CODE : "", /* 작업구분 */
					WORK_TYPE1 : "", /* 작업구분명 */
					ORIGIN_WORKER : "", /* 원근무자 */
					ORIGIN_WORKER_NAME : "", /* 원근무자명 */
					ORIGIN_WORKER_CODE : "", /* 원근무자명 - 저장용 */
					WORK_TYPE2_CODE : "", /* 작업세부구분 */
					WORK_TYPE2 : "", /* 작업세부구분명 - 저장용 */
					WORK_DSC : "", /* 작업사유 */
					TIME_CARD1 : "", /* 실근무시간 시작 */
					TIME_CARD2 : "", /* 실근무시간 종료 */
					TIME_CARD3 : "", /* 실근무시간 종료 */
					TIME_CARD4 : "", /* 실근무시간 종료 */
					TIME_CARD5 : "", /* 실근무시간 종료 */
					TIME_CARD6 : "", /* 실근무시간 종료 */
					OVER_WORK_CODE : "0009", /* 근무직 - (기본값 : 기타)*/
					OVER_WORK : "기타", /* 근무직명 - 저장용*/
					TRUE_WORK_STARTTIME : "", /* 연장시간 시작 */
					TRUE_WORK_ENDTIME : "", /* 연장시간 종료 */
					REST_STIME : "", /* 휴식시간 시작 */
					REST_ETIME : "", /* 휴식시간 종료 */
					TRUE_OVERTIME : "", /* 연장근무 */
					OVERTIME : "", /* 연장근무 */
					REG_DATE_DAY : "", /* 신청일 */
					REG_DATE_TIME : "", /* 신청시간 */
					REG_WORKER_NAME : "${req_data.emp_name}", /* 신청자 */
					CONFIRM_DATE_DAY : "", /* 승인일 */
					CONFIRM_DATE_TIME : "", /* 승인시간 */
					CONFIRM_WORKER_NAME : ""
				/* 승인자 */
				}, false, "desc");
			});

			// 선택 저장
			$("#fnReg").on("click", function() {
				var rows = scope.gridApi.selection.getSelectedRows();
				var data_rows = new Array();
				var cnt = 0;
				$.each(rows, function(i, d){
					if(d.STATUS == null){
						cnt++;
						data_rows.push(d);
					}
				});
				if(cnt === 0){
					swalWarningCB("저장할 신청항목을 선택하세요.");
					return false;
				}
				if (!fnValidation()){
					return false;
				}
				if (confirm("등록하겠습니까?")) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zhr/tna/createOvertime",
						type : "POST",
						cache : false,
						async : true,
						dataType : "json",
						data : {
							row_no: JSON.stringify(data_rows)
						},
						success : function(result) {
							swalWarningCB(result.msg);
							if (result.code == "00"){
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

			// 선택 삭제, 선택 반려
			$(".fnStausUpd").on("click", function() {
				var rows = scope.gridApi.selection.getSelectedRows();
				if (isEmpty(rows)) {
					swalWarning("항목을 선택하세요.");
					return false;
				}
				var data_rows = new Array();
				var cnt = 0;
				var check = true;
				
				var flag = $(this).data("flag");
				if(flag == 'X'){//삭제
					status = "W";
					msg = "대기상태가 아니면 삭제할 수 없습니다.";
				}else if(flag == 'A'){//팀장 승인 - 삭제 (팀장승인 == 확정)
					status = "W";
					msg = "대기상태인지 항목을 확인해 주세요.";
				}else if(flag == 'R'){//팀장 반려
					status = "W";
					msg = "확정상태인지 항목을 확인해 주세요.";
				}
				
				$.each(rows, function(i, d){
					if(d.STATUS === "W"){
						cnt++;
						data_rows.push({SEQ: d.SEQ});
					}else{
						check = false;
					}
				});
				if(!check){
					swalWarningCB(msg);
					return false;
				}
				if(cnt > 0){
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zhr/tna/updateOverPlanStauts",
						type : "POST",
						cache : false,
						async : true,
						dataType : "json",
						data : {
							upd_flag: flag,
							seq: JSON.stringify(data_rows)
						},
						success : function(result) {
							swalWarningCB(result.msg, function(){
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
						error : function(request, status, error) {
							console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
							swalDangerCB("등록에 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
				}
			});

			// 선택 승인
			$("#fnSapConfirm").on("click", function() {
				var rows = scope.gridApi.selection.getSelectedRows();
				if (isEmpty(rows)) {
					swalWarning("항목을 선택하세요.");
					return false;
				}
				var data_rows = new Array();
				var cnt = 0;
				var check = true;
				$.each(rows, function(i, d){
					if(d.STATUS === "W"){
						cnt++;
						data_rows.push({SEQ: d.SEQ});
					}else{
						check = false;
					}
				});
				if(!check){
					swalWarningCB("대기 상태인지 확인해 주세요.");
					return false;
				}
				var w = window.open("","confirm_pop","width=800px,height=600px,scrollbars=yes");

				//20191023_khj for csrf
				var csrf_element = document.createElement("input");
				csrf_element.name = "_csrf";
				csrf_element.value = "${_csrf.token}";
				csrf_element.type = "hidden";
				//20191023_khj for csrf
				var popForm = document.createElement("form");

				popForm.name = "sndFrm";
				popForm.method = "post";
				popForm.target = "confirm_pop";
				popForm.action = "/yp/popup/zhr/tna/createOverPlanToSAP";

				document.body.appendChild(popForm);

				popForm.appendChild(csrf_element);

				var pr = {
					seq : JSON.stringify(data_rows),
// 					BELNR : BELNR,
// 					BUDAT : BUDAT
				};

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
			});
		});

		function fnDateCompare(workday) {
			//동해사무소 입력날짜체크 예외처리
			if(isEastOffice) return false; 
			
			var today = new Date();
			var fourAgo = new Date();
			fourAgo.setDate(today.getDate() - 4);
			var selday = workday.split("/");
			var wday = new Date(selday[0], selday[1] - 1, selday[2]);
// 			console.log(fourAgo);
// 			console.log(wday);
// 			console.log(today);
// 			console.log(wday<=today);
			
			if(fourAgo<wday && wday<=today)	return false;
			else	return true;
		}
	
		function fnPopCallOriginWork(no){
			var row = scope.gridApi.grid.rows[no];
			fnRetrieveOriginWork(row);
		}
		
		// 원근무 정보 조회
		function fnRetrieveOriginWork(row) {
			if (row.entity.WORK_STARTDATE.length == 10 && row.entity.EMP_NAME.length >= 2) {
				var sdate = row.entity.WORK_STARTDATE;
				var username = row.entity.EMP_NAME;
				var empcode = row.entity.EMP_CODE;
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					url : "/yp/zhr/tna/retrieveTimecard",
					type : "POST",
					cache : false,
					async : true,
					dataType : "json",
					data : {
						"work_startdate" : sdate,
						"emp_name" : username,
						"emp_code" : empcode
					},
					success : function(result) {
//						console.log(result.msg);
						if (result.msg == "00") {
							if (result.timecard == "출퇴근 기록없음") {
								swalWarningCB(result.timecard);
								row.entity.TIME_CARD1 = "";
								row.entity.TIME_CARD2 = "";
							} else if (result.time_card1 == "000000" || result.time_card1 == undefined) {
								swalWarningCB("출근기록 없음");
								row.entity.TIME_CARD1 = "";
								row.entity.TIME_CARD2 = "";
							} else if (result.time_card2 == "000000" || result.time_card2 == undefined) {
								swalWarningCB("퇴근기록 없음");
								row.entity.TIME_CARD1 = result.time_card1;
								row.entity.TIME_CARD2 = "";
							} else {
								$("#won_jo").text(result.text);
								row.entity.ORIGIN_WORK = result.origin_work;
								row.entity.ORIGIN_WORK_CODE = result.origin_work_code;
								row.entity.TIME_CARD1 = result.time_card1;
								row.entity.TIME_CARD2 = result.time_card2;
								row.entity.REGULAR_WORK1 = result.regular_work1;
								row.entity.REGULAR_WORK2 = result.regular_work2;
								console.log(result.time_card3+"/"+result.time_card4+"/"+result.time_card5+"/"+result.time_card6);
								//출퇴근2번 있을 때
								if(result.time_card3 > "000000" && result.time_card4 > "000000"){
									row.entity.TIME_CARD3 = result.time_card3;
									row.entity.TIME_CARD4 = result.time_card4;
// 									$("#TIMECARD1_"+no).append("<br>"+fnTimeForm(result.time_card3));
// 									$("#TIMECARD2_"+no).append("<br>"+fnTimeForm(result.time_card4));
								}
								//출퇴근3번 있을 때
								if(result.time_card5 > "000000" && result.time_card6 > "000000"){
									row.entity.TIME_CARD5 = result.time_card3;
									row.entity.TIME_CARD6 = result.time_card4;
// 									$("#TIMECARD1_"+no).append("<br>"+fnTimeForm(result.time_card5));
// 									$("#TIMECARD2_"+no).append("<br>"+fnTimeForm(result.time_card6));
								}
							}
							scope.gridApi.grid.refresh();
						} else {
							swalWarningCB(result.msg);
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
			} else {
				swalWarningCB("근무일자 또는 성명을 입력해주세요.");
			}
		}

		//enddate = startdate+1일;
		function fn_tomorrow(str_date) {
			var parse_date = str_date.split("/");
			parse_date[1] = Number(parse_date[1]) - 1;//월 0~11
			var date = new Date(parse_date[0], parse_date[1], parse_date[2]);
			var tomorrow = new Date(Date.parse(date) + 1 * 1000 * 60 * 60 * 24);
			var str_tomorrow = tomorrow.getFullYear() + "/";
			var mon = "" + (tomorrow.getMonth() + 1);
			var day = "" + tomorrow.getDate();

			str_tomorrow += mon.length == 1 ? "0" + mon + "/" : mon + "/";
			str_tomorrow += day.length == 1 ? "0" + day : day;

			return str_tomorrow;
		}
		
		function fnValidation(){
			var check = true;
			var truework_validation = true;
			var rows = scope.gridApi.selection.getSelectedRows();
			$.each(rows, function(i, d){
				if(d.WORK_STARTDATE == ""){
					swalWarningCB("근무일자를 입력하세요.");
					check = false;
				} else if(d.WORK_ENDDATE == "") {	
					swalWarningCB("근무일자 변경후엔 근무직을 변경해야 합니다.");
					check = false;
				} else if(d.EMP_NAME == "") {
					swalWarningCB("이름을 입력하세요.");
					check = false;
				} else if(d.WORK_TYPE1_CODE == "") {
					swalWarningCB("작업구분을 선택하세요.");
					check = false;
				} else if(d.WORK_DSC == "") {
					swalWarningCB("작업사유 항목을 입력하세요.");
					check = false;
				} else if(d.TRUE_WORK_STARTTIME == "" || d.TRUE_WORK_ENDTIME == "") {
					swalWarningCB("연장시간을 입력하세요.");
					check = false;
				} else if(((d.TIME_CARD1 == "" || d.TIME_CARD2 == "") && ("50000021" != "${req_data.user_deptcd}")) && !isAdmin) {
					swalWarningCB("출근 또는 퇴근 시간 정보가 없습니다.");
					check = false;
// 					d.TIME_CARD1 = "083000";
// 					d.TIME_CARD2 = "173000";
// 					check = true;
				} else if("<%=toDay%>" == d.WORK_STARTDATE && d.TIME_CARD2 == "000000") {
					swalWarningCB("퇴근이전에 등록 할 수 없습니다.");
					check = false;
				} else {
					if(d.WORK_TYPE1_CODE == "A"){
						if(d.ORIGIN_WORKER == ""){
							swalWarningCB("원근무자를 선택하세요.");
							return false;
						}
					}
					
					var code = d.OVER_WORK_CODE;
					var time1 = d.REGULAR_WORK1.substring(0,4);
					var time2 = d.REGULAR_WORK2.substring(0,4);
					
					var st = d.TRUE_WORK_STARTTIME.replace(":","");
					var et = d.TRUE_WORK_ENDTIME.replace(":","");
					
					if(st > et) et = (et*1) + (2400*1);
					
					//신청시간이 정규근무시간에 포함이 되는지 확인
					if( d.WORK_TYPE2_CODE != "C001"){//공휴일때 정규근무시간 체크제외
						if(time1 > time2) time2 = (time2*1) + (2400*1);
						if((time1<st && st<time2) || (time1<et && et<time2)){
							check = false;
							swalWarningCB("신청근무 시간이 정규근무시간에 포함됩니다.");
						}
						if(time1==st || time2==et){
							check = false;
							swalWarningCB("신청근무 시간이 정규근무시간에 포함됩니다.");
						}
					}
					//출퇴근시간 실근무시간 비교 체크
					var timd_card1 = d.TIME_CARD1 * 1;
					var timd_card2 = d.TIME_CARD2 * 1;
					var timd_card3 = d.TIME_CARD3 * 1;
					var timd_card4 = d.TIME_CARD4 * 1;
					var timd_card5 = d.TIME_CARD5 * 1;
					var timd_card6 = d.TIME_CARD6 * 1;
					//console.log(timd_card1+"/"+timd_card2);
					
					if(timd_card1 > timd_card2){
						timd_card2 = timd_card2 + 240000;
					}
					if(timd_card3 > timd_card4){
						timd_card4 = timd_card4 + 240000;
					}
					if(timd_card5 > timd_card6){
						timd_card6 = timd_card6 + 240000;
					}
					var true_work_time1 = (d.TRUE_WORK_STARTTIME.replace(":","") + "00") * 1;
					var true_work_time2 = (d.TRUE_WORK_ENDTIME.replace(":","") + "00") * 1;
					if(true_work_time1 > true_work_time2){
						 true_work_time2 = true_work_time2 + 240000;
					}
					console.log(timd_card1 + "/" + timd_card2 + "/" + true_work_time1 + "/" + true_work_time2);
					
					if(isEastOffice || isAdmin){//동해사무소,관리자권한 출퇴근시간 미체크
						truework_validation = true;
					}else if (timd_card1 > true_work_time1 || timd_card2 < true_work_time2) {
						truework_validation = false;
						
						if(timd_card3 > 0 && timd_card4 > 0){
							truework_validation = true;
							
							if(timd_card3 > true_work_time1 || timd_card4 < true_work_time2){
								truework_validation = false;
								
								if(timd_card5 > 0 && timd_card6 > 0){
									truework_validation = true;
									
									if(timd_card5 > true_work_time1 || timd_card6 < true_work_time2){
										truework_validation = false;
										
									}
								}
							}
						}
						if(truework_validation == false){
							swalWarningCB("실근무시간이 출퇴근시간에 포함되지 않습니다.");
						}
					}
				}
			});
			console.log(check && truework_validation);
			return check && truework_validation;
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
							$("select[name=ser_class]").append(new Option(d.STEXT, d.OBJID));
						});
// 						if("${req_data.auth}" === "SA" || "${req_data.auth}" === "MA"){
// 							$("select[name=ser_class]").prepend(new Option("전체", ""));
// 						}else if("${req_data.auth}" === "IM" || "${req_data.auth}" === "TM" || "${req_data.auth}" === "WM"){
// 							$("select[name=ser_class]").prepend(new Option("전체", ""));
// 						}
						$("select[name=ser_class] option:eq(0)").prop("selected", true);
						$("select[name=ser_class]").trigger("change");
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
			var ser_class = $("select[name=ser_class] :checked").val();
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
		
		// 반 초기화
		function fn_clear_ser_class(){
			$("select[name=ser_class]").empty();
			if("${req_data.auth}" === "SA" || "${req_data.auth}" === "MA"){
				$("select[name=ser_class]").prepend(new Option("전체", ""));
			}else if("${req_data.auth}" === "IM" || "${req_data.auth}" === "TM" || "${req_data.auth}" === "WM"){
				$("select[name=ser_class]").prepend(new Option("전체", ""));
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
			console.log(cookie);
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
		
		function fnNoticePop(url) { 
			var cookieCheck = getCookie("ot_notice");
			if (cookieCheck != "N"){
				var win = window.open(url + "?_csrf=${_csrf.token}", "ot_notice_pop", "width=650,height=800,left=0,top=0");
				if(win == null || typeof(win) == "undefined" || (win == null && win.outerWidth == 0) || (win != null && win.outerHeight == 0) || win.test == "undefined"){
					alert("팝업이 차단되어 있습니다.\n차단을 해제해 주세요.");
				}
			}
		}

	</script>
	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
	<script>
	var viewModal_row = null;
	$(document).ready(function(){
		$("#mod_name").on("keyup",function(e){
			if(e.which === 13){
				$("#editBtn").trigger("click");
			}
		});
		
		$("#editBtn").on("click",function(){
			viewModal_row.entity.EMP_NAME = $("#mod_name").val();
			scope.fnRetrieveEmpInfo(viewModal_row);
			$("#viewModal").modal("hide");
		});
		
		fnNoticePop("/yp/popup/zhr/tna/ot_notice_pop");
	});
	
</script>
	<div class="modal fade" id="viewModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog"  style="width:250px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h2 class="row modal-title">성명입력</h2>
				</div>
				<!-- 버그때문에 의미없는 form추가ㅣ-->
				<form></form>
				<div class="modal-body" style="height : 80px; overflow: auto;">
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
								<th>이름</th>
								<td>
									<%--
									YPWEBPOTAL-13 
									시간 외 근무 : work_place 오류
									일단 이름 변경시 text box 의 width 값이 너무 좁아보여서 130px 로 수정한것 commit 하였습니다.
									 --%>
									<input type="text" id="mod_name" style="width: 130px;" />
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="just-close btn" id="editBtn" >변경</button>
					<button type="button" class="just-close btn" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</body>