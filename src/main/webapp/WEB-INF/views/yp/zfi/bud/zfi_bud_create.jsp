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

String s_dept_code = (String)request.getSession().getAttribute("s_dept_code") == null ? "" : (String)request.getSession().getAttribute("s_dept_code");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>예산신청
</title>
<script type="text/javascript">
	var scope;
	$(document).ready(function() {
		// 부트스트랩 날짜객체
		$(".dtp").datepicker({
			format : "yyyy/mm",
			language : "ko",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		});
		
		//조회조건 default
		if("${req_data.GSBER_S}" == "" || "${req_data.GSBER_S}" == null){
			$("input:radio[name='GSBER_S']:radio[value='1100']").prop('checked', true); 
		}
		if("${req_data.GUBUN}" == "" || "${req_data.GUBUN}" == null){
			$("input:radio[name='GUBUN']:radio[value='I']").prop('checked', true); 
		}
	
		//오늘날짜 세팅
		if($("input[name=SPMON_S]").val() == ""){
			$("input[name=SPMON_S],input[name=SPMON_E]").val("<%=toDay%>");	
		}
		
		//검색조건 변경시 조회유도
		$("input[name=SPMON_S],input[name=RORG_S]").on("change",function(){
			$("#search_flag").val("2");
		});
		
		
		$('input').on('keydown', function(event) {
			if(event.keyCode==13) 
				return false;
		});

		if("${ep_flag}" == "E") swalDanger("${ep_msg}");
	});

	
	
</script>
</head>
<body>
	<h2>
		예산 신청
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
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="page" id="page" value="${paginationInfo.currentPageNo}" />
		<input type="hidden" name="page_rows" value="" />
		<input type="hidden" name="add_rows" value="0" />
		<input type="hidden" id="search_flag" value="${search_flag}"/>
		
		<div class="float_wrap" style="margin-bottom:20px;">
			<div class="fr">
				예산조직은 필수 입력값입니다. 본인 소속 부서만 조회 가능합니다. (타 부서 조회가 필요하신 경우 전산팀에 문의)
			</div>
		</div>
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
						<th>신청유형</th>
						<td>
							<input type="radio" name="GUBUN" id="GUBUN_I" value="I" onclick="scope.gridColChange(this.value)" <c:if test="${req_data.GUBUN eq 'I'}">checked</c:if>><label for="GUBUN_I">증액</label>
							<input type="radio" name="GUBUN" id="GUBUN_R" value="R" onclick="scope.gridColChange(this.value)" <c:if test="${req_data.GUBUN eq 'R'}">checked</c:if>><label for="GUBUN_R">감액</label>
							<input type="radio" name="GUBUN" id="GUBUN_S" value="S" onclick="scope.gridColChange(this.value)" <c:if test="${req_data.GUBUN eq 'S'}">checked</c:if>><label for="GUBUN_S">조기</label>
							<input type="radio" name="GUBUN" id="GUBUN_T" value="T" onclick="scope.gridColChange(this.value)" <c:if test="${req_data.GUBUN eq 'T'}">checked</c:if>><label for="GUBUN_T">이월</label>
							<input type="radio" name="GUBUN" id="GUBUN_C" value="C" onclick="scope.gridColChange(this.value)"><label for="GUBUN_C">전용</label> 
						</td>
						<th>집행부서</th>
						<td>
							<input type="text" name="RORG_S" id="RORG_S" style="width:170px;">
							<a href="#" onclick="fnSearchPopup('3');"><img src="/resources/yp/images/ic_search.png"></a>
							
						</td>
						
						<th>입력년월</th>
						<td>
							<input type="text"  class="calendar dtp" name="SPMON_S" id="SPMON_S" value="${req_data.SPMON_S}"/> ~ 
							<input type="text"  class="calendar dtp" name="SPMON_E" id="SPMON_E" value="${req_data.SPMON_E}"/>
						</td>
					</tr>
					<tr>
						<th>사업영역</th>
						<td>			
							<input type="radio" name="GSBER_S" id="1100" value="1100" <c:if test="${req_data.GSBER_S eq '1100'}">checked</c:if> ><label for="1100">본사</label>
							<input type="radio" name="GSBER_S" id="1200" value="1200" <c:if test="${req_data.GSBER_S eq '1200'}">checked</c:if> ><label for="1200">석포</label>
							<input type="radio" name="GSBER_S" id="1400" value="1400" <c:if test="${req_data.GSBER_S eq '1400'}">checked</c:if> ><label for="1400">안성휴게소</label>
							<input type="radio" name="GSBER_S" id="1600" value="1600" <c:if test="${req_data.GSBER_S eq '1600'}">checked</c:if> ><label for="1600">Green메탈캠퍼스</label>
						</td>
						<th>예산조직</th>
						<td>
							<input type="text" name="BORG_S" id="BORG_S" value="${req_data.BORG_S}">
							<a href="#" onclick="fnSearchPopup('4');"><img src="/resources/yp/images/ic_search.png"></a>
						</td>
						<th>FROM ~ TO</th>
						<td>
							<input type="text" class="calendar dtp" name="SPMON_F" id="SPMON_F" value="${req_data.SPMON_F}"/> ~ 
							<input type="text" class="calendar dtp" name="SPMON_T" id="SPMON_T" value="${req_data.SPMON_T}"/>
						</td>
					</tr>
					<tr>
						<th>승인상태</th>
						<td >
							<select name="STATU">
								<option value="">전체</option>
								<option value="1" <c:if test="${req_data.STATU eq '1'}">selected</c:if>>대기</option>
								<option value="2" <c:if test="${req_data.STATU eq '2'}">selected</c:if>>승인</option>
								<option value="3" <c:if test="${req_data.STATU eq '3'}">selected</c:if>>반려</option>
								<option value="4" <c:if test="${req_data.STATU eq '4'}">selected</c:if>>결재요청</option>
								<option value="5" <c:if test="${req_data.STATU eq '5'}">selected</c:if>>진행중</option>
								<option value="6" <c:if test="${req_data.STATU eq '6'}">selected</c:if>>회수</option>
							</select>
						</td>
						<th>예산계정</th>
						<td>
							<input type="text" name="BACT_S" id="BACT_S" value="${req_data.BACT_S}">
							<a href="#" onclick="fnSearchPopup('2');"><img src="/resources/yp/images/ic_search.png"></a>
						</td>
						<th>&nbsp;</th>
						<td>&nbsp;</td>
					</tr>
				</table>
				<div class="btn_wrap">
					<button class="btn btn_search" id="search_btn">조회</button>
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
				<input type="button" class="btn_g" id="add_btn"     value="추가"/>
				<input type="button" class="btn_g" id="modify_btn"  value="수정"/>
				<input type="button" class="btn_g" id="save_btn"    value="저장"/>
				<input type="button" class="btn_g" id="delete_btn"  value="삭제"/>
			</div>
		</div>
	</div>
	<form id="data_form">
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="SPMON_S_R" value=""><input type="hidden" name="SPMON_E_R" value="">
		<input type="hidden" name="SPMON_F_R" value=""><input type="hidden" name="SPMON_T_R" value="">
		<input type="hidden" name="GUBUN_R" value="">
		<input type="hidden" name="VALTP_R" value="">
		<input type="hidden" name="GSBER_R" value="">
	</form>	
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
				return str_date.substring(0,4)+"/"+str_date.substring(4,6)
			};

			// 코드팝업
			$scope.fnSearchPopup = function(type, row) {
				var target = scope.gridOptions.data.indexOf(row.entity);
				fnSearchPopup(type, target);
			};
			
			// 코드팝업("전용")
			$scope.fnSearchPopup2 = function(type, row) {
				var target = scope.gridOptions.data.indexOf(row.entity);
				fnSearchPopup2(type, target);
			};
			
			// onchange 이벤트 시작
			$scope.fnAjaxKOSTL = function(type, row) {
				var target = scope.gridOptions.data.indexOf(row.entity);
				fnAjaxKOSTL(type, target);
			};
			$scope.fnAjaxBACT = function(row) {
				var target = scope.gridOptions.data.indexOf(row.entity);
				fnAjaxBACT(target);
			};
			// onchange 이벤트 끝
			
			//cellClass
			$scope.cellClassSet = function(grid, row, col, rowRenderIndex, colRenderIndex){
				var className = "";
				switch(col.field){
					
				}
				
				
				return className;
			}
			
			
			//Cell Template1(증액,감액,조기,이월)
			var cellTmp1_Reg_SPMON = '<div   ng-if="row.entity.state!=0" class="ui-grid-cell-contents">{{grid.appScope.formatter_yyyymm(row.entity.SPMON)}}</div>';
			var cellTmp1_New_SPMON = '<input ng-if="row.entity.state==0" type="text" class="calendar dtp" ng-model="row.entity.SPMON"/>';	  
			//집행부서
			var cellTmp1_Reg_RORG = '<div   ng-if="row.entity.state!=0" class="ui-grid-cell-contents">{{row.entity.RORG}}</div>';	
			var cellTmp1_New_RORG = '<input ng-if="row.entity.state==0" type="text" on-model-change="grid.appScope.fnAjaxKOSTL(\'R\', row)" ng-model="row.entity.RORG" style="width:70%;"><img src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(5, row)">';
			//집행부서명
			var cellTmp1_Reg_RORGTXT = '<div   ng-if="row.entity.state!=0" class="ui-grid-cell-contents">{{row.entity.RORGTXT}}</div>';
			var cellTmp1_New_RORGTXT = '<input ng-if="row.entity.state==0" type="text" ng-model="row.entity.RORGTXT" style="width:100%;" readonly>';
			//예산조직
			var cellTmp1_Reg_BORG = '<div   ng-if="row.entity.state!=0" class="ui-grid-cell-contents">{{row.entity.BORG}}</div>';
			var cellTmp1_New_BORG = '<input ng-if="row.entity.state==0" type="text" on-model-change="grid.appScope.fnAjaxKOSTL(\'B\', row)" ng-model="row.entity.BORG" style="width:70%;"><img src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(6, row)">';
			//예산조직명
			var cellTmp1_Reg_BORGTXT = '<div   ng-if="row.entity.state!=0" class="ui-grid-cell-contents">{{row.entity.BORGTXT}}</div>';
			var cellTmp1_New_BORGTXT = '<input ng-if="row.entity.state==0" type="text" ng-model="row.entity.BORGTXT" style="width:100%;" readonly>';
			//예산계정
			var cellTmp1_Reg_BACT = '<div   ng-if="row.entity.state!=0" class="ui-grid-cell-contents">{{row.entity.BACT}}</div>';
			var cellTmp1_New_BACT = '<input ng-if="row.entity.state==0" type="text" on-model-change="grid.appScope.fnAjaxBACT(row)" ng-model="row.entity.BACT" style="width:70%;"><img src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup(7, row)">';
			//예산계정명
			var cellTmp1_Reg_BACTTXT = '<div   ng-if="row.entity.state!=0" class="ui-grid-cell-contents">{{row.entity.BACTTXT}}</div>';
			var cellTmp1_New_BACTTXT = '<input ng-if="row.entity.state==0" type="text" ng-model="row.entity.BACTTXT" style="width:100%;" readonly>';
			//잔액
			var cellTmp1_Reg_REMAMT = '<div   ng-if="row.entity.state!=0" class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.REMAMT)}}</div>';
			var cellTmp1_New_REMAMT = '<input ng-if="row.entity.state==0" type="text" ng-model="row.entity.REMAMT" class="right" style="width:100%;" readonly>';
			//금액
			var cellTmp1_Reg_VALUE = '<div   ng-if="row.entity.state!=0 && row.entity.state!=1" class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.VALUE)}}</div>';
			var cellTmp1_New_VALUE = '<input ng-if="row.entity.state==0" type="text" ng-model="row.entity.VALUE" style="width:100%;">';
			var cellTmp1_Mod_VALUE = '<div   ng-if="row.entity.state==1" class="ui-grid-cell-contents"><input type="text" ng-model="row.entity.VALUE" value="{{grid.appScope.formatter_decimal(row.entity.VALUE)}}" /></div>';
			//내역
			var cellTmp1_Reg_DOCUM = '<div   ng-if="row.entity.state!=0 && row.entity.state!=1" class="ui-grid-cell-contents">{{row.entity.DOCUM}}</div>';
			var cellTmp1_New_DOCUM = '<input ng-if="row.entity.state==0" type="text" ng-model="row.entity.DOCUM" style="width:100%;">';
			var cellTmp1_Mod_DOCUM = '<div   ng-if="row.entity.state==1" class="ui-grid-cell-contents"><input type="text" ng-model="row.entity.DOCUM" value="{{row.entity.DOCUM}}" /></div>';
			//Cell Template1 
			
			
			//Cell Template2(전용)
			//사업영역 코드리스트 하드코딩
			$scope.C_GSBER_CDList = [{"code_name":"본사","code_id":"1100"},{"code_name":"석포","code_id":"1200"},{"code_name":"안성휴게소","code_id":"1400"},{"code_name":"Green메탈캠퍼스","code_id":"1600"}];
			//상태
			var cellTmp2_Reg_STATUTXT = '<div   ng-if="row.entity.state!=0" class="ui-grid-cell-contents">{{row.entity.STATUTXT}}</div>';
			var cellTmp2_New_STATUTXT = '<div class="ui-grid-cell-contents">등록</div>';	  
			//사업영역
			var cellTmp2_Reg_C_GSBER = '<div   ng-if="row.entity.state!=0" class="ui-grid-cell-contents">{{row.entity.GSBER}}</div>';
			var cellTmp2_New_C_GSBER = '<select class="ui-grid-template ui-grid-custom-select" style="width:100%; min-width: fit-content;" ng-model="row.entity.GSBER">' + '	<option ng-repeat="C_GSBER_CDList in grid.appScope.C_GSBER_CDList" ng-selected="row.entity.GSBER == C_GSBER_CDList.code_id" value="{{C_GSBER_CDList.code_id}}" >{{C_GSBER_CDList.code_name}}</option>' + '</select>';
			//전용년월
			var cellTmp2_Reg_SPMON = '<div   ng-if="row.entity.state!=0" class="ui-grid-cell-contents">{{grid.appScope.formatter_yyyymm(row.entity.SPMON)}}</div>';
			var cellTmp2_New_SPMON = '<input ng-if="row.entity.state==0" type="text" ng-model="row.entity.SPMON" style="width:100%;" value="{{grid.appScope.formatter_yyyymm(row.entity.SPMON)}}" readonly>';
			//집행부서
			var cellTmp2_Reg_RORG = '<div   ng-if="row.entity.state!=0" class="ui-grid-cell-contents">{{row.entity.RORG}}</div>';	
			var cellTmp2_New_RORG = '<input ng-if="row.entity.state==0" type="text" on-model-change="grid.appScope.fnAjaxKOSTL(\'R\', row)" ng-model="row.entity.RORG" style="width:70%;"><img src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup2(3, row)">';
			//집행부서명
			var cellTmp2_Reg_RORGTXT = '<div   ng-if="row.entity.state!=0" class="ui-grid-cell-contents">{{row.entity.RORGTXT}}</div>';
			var cellTmp2_New_RORGTXT = '<input ng-if="row.entity.state==0" type="text" ng-model="row.entity.RORGTXT" style="width:100%;" readonly>';
			//예산조직
			var cellTmp2_Reg_BORG = '<div   ng-if="row.entity.state!=0" class="ui-grid-cell-contents">{{row.entity.BORG}}</div>';
			var cellTmp2_New_BORG = '<input ng-if="row.entity.state==0" type="text" on-model-change="grid.appScope.fnAjaxKOSTL(\'B\', row)" ng-model="row.entity.BORG" style="width:70%;"><img src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup2(4, row)">';
			//예산조직명
			var cellTmp2_Reg_BORGTXT = '<div   ng-if="row.entity.state!=0" class="ui-grid-cell-contents">{{row.entity.BORGTXT}}</div>';
			var cellTmp2_New_BORGTXT = '<input ng-if="row.entity.state==0" type="text" ng-model="row.entity.BORGTXT" style="width:100%;" readonly>';
			//전용 예산조직
			var cellTmp2_Reg_C_BORG = '<div   ng-if="row.entity.state!=0" class="ui-grid-cell-contents">{{row.entity.C_BORG}}</div>';
			var cellTmp2_New_C_BORG = '<input ng-if="row.entity.state==0" type="text" on-model-change="grid.appScope.fnAjaxKOSTL(\'C_B\', row)" ng-model="row.entity.C_BORG" style="width:70%;"><img src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup2(5, row)">';
			//전용 예산조직명
			var cellTmp2_Reg_C_BORGTXT = '<div   ng-if="row.entity.state!=0" class="ui-grid-cell-contents">{{row.entity.C_BORGTXT}}</div>';
			var cellTmp2_New_C_BORGTXT = '<input ng-if="row.entity.state==0" type="text" ng-model="row.entity.C_BORGTXT" style="width:100%;" readonly>';
			//예산계정
			var cellTmp2_Reg_BACT = '<div   ng-if="row.entity.state!=0" class="ui-grid-cell-contents">{{row.entity.BACT}}</div>';
			var cellTmp2_New_BACT = '<input ng-if="row.entity.state==0" type="text" on-model-change="grid.appScope.fnAjaxBACT(row)" ng-model="row.entity.BACT" style="width:70%;"><img src="/resources/yp/images/ic_search.png" ng-click="grid.appScope.fnSearchPopup2(6, row)">';
			//예산계정명
			var cellTmp2_Reg_BACTTXT = '<div   ng-if="row.entity.state!=0" class="ui-grid-cell-contents">{{row.entity.BACTTXT}}</div>';
			var cellTmp2_New_BACTTXT = '<input ng-if="row.entity.state==0" type="text" ng-model="row.entity.BACTTXT" style="width:100%;" readonly>';
			//잔액
			var cellTmp2_Reg_REMAMT = '<div   ng-if="row.entity.state!=0" class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.REMAMT)}}</div>';
			var cellTmp2_New_REMAMT = '<input ng-if="row.entity.state==0" type="text" ng-model="row.entity.REMAMT" class="right" style="width:100%;" readonly>';
			//금액
			var cellTmp2_Reg_VALUE = '<div   ng-if="row.entity.state!=0 && row.entity.state!=1" class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.VALUE)}}</div>';
			var cellTmp2_New_VALUE = '<input ng-if="row.entity.state==0" type="text" ng-model="row.entity.VALUE" style="width:100%;">';
			//내역
			var cellTmp2_Reg_DOCUM = '<div   ng-if="row.entity.state!=0 && row.entity.state!=1" class="ui-grid-cell-contents">{{row.entity.DOCUM}}</div>';
			var cellTmp2_New_DOCUM = '<input ng-if="row.entity.state==0" type="text" ng-model="row.entity.DOCUM" style="width:100%;">';
			//Cell Template2
			
			
			var columnDefs1 = [
				{
					displayName : 'state',
					field : 'state',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, 
				{
					displayName : '입력년월',
					field : 'SPMON',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: cellTmp1_Reg_SPMON + cellTmp1_New_SPMON
				}, 
				{visible : false, displayName : '입력년월2', field : 'SPMON2', cellClass : "center", enableCellEdit : false, allowCellFocus : false}, 
				{
					displayName : '승인상태',
					field : 'STATUTXT',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, 
				{visible : false, displayName : '상태1', field : 'STATU', cellClass : "center", enableCellEdit : false, allowCellFocus : false}, 
				{visible : false, displayName : '상태2', field : 'SEQ', cellClass : "center", enableCellEdit : false, allowCellFocus : false},
				{
					displayName : '집행부서',
					field : 'RORG',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : cellTmp1_Reg_RORG + cellTmp1_New_RORG
				}, 
				{
					displayName : '집행부서명',
					field : 'RORGTXT',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : cellTmp1_Reg_RORGTXT + cellTmp1_New_RORGTXT
				}, 
				{
					displayName : '예산조직',
					field : 'BORG',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : cellTmp1_Reg_BORG + cellTmp1_New_BORG 
				}, 
				{
					displayName : '예산조직명',
					field : 'BORGTXT',
					width : '119',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : cellTmp1_Reg_BORGTXT + cellTmp1_New_BORGTXT
				}, 
				{
					displayName : '예산계정',
					field : 'BACT',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : cellTmp1_Reg_BACT + cellTmp1_New_BACT
				}, 
				{
					displayName : '예산계정명',
					field : 'BACTTXT',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : cellTmp1_Reg_BACTTXT + cellTmp1_New_BACTTXT,
					footerCellTemplate: '<div class="ui-grid-cell-contents">합 계</div>'
				}, 
				{
					displayName : '잔액',
					field : 'REMAMT',
					width : '10%',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : cellTmp1_Reg_REMAMT + cellTmp1_New_REMAMT,
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents right" >{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
				}, 
				{
					displayName : '금액',
					field : 'VALUE',
					width : '10%',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : cellTmp1_Reg_VALUE + cellTmp1_New_VALUE + cellTmp1_Mod_VALUE,
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents right" >{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
				},
				{
					displayName : '내역',
					field : 'DOCUM',
					//width : '7.6%',
					minWidth: 110,
					visible : true,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate :  cellTmp1_Reg_DOCUM + cellTmp1_New_DOCUM + cellTmp1_Mod_DOCUM
				}, 
				{
					displayName : '통제구분',
					field : 'ACDETTXT',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				},
				{
					displayName : '통제시기',
					field : 'ACTIMETXT',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}
			  ];

			
			var columnDefs2 = [
				{visible : false, displayName : 'SEQ', field : 'SEQ', cellClass : "center", enableCellEdit : false, allowCellFocus : false},
				{visible : false, displayName : '상태코드', field : 'STATU', cellClass : "center", enableCellEdit : false, allowCellFocus : false}, 
				{
					displayName : '상태',
					field : 'STATUTXT',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : cellTmp2_Reg_STATUTXT + cellTmp2_New_STATUTXT
				}, 
				{ 	displayName : '사업영역', 
					field : 'GSBER',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false, 
					allowCellFocus : false,
					cellTemplate : cellTmp2_Reg_C_GSBER + cellTmp2_New_C_GSBER
				},
				{
					displayName : '집행부서',
					field : 'RORG',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : cellTmp2_Reg_RORG + cellTmp2_New_RORG
				}, 
				{
					displayName : '집행부서명',
					field : 'RORGTXT',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : cellTmp2_Reg_RORGTXT + cellTmp2_New_RORGTXT
				},
				{
					displayName : '전용년월',
					field : 'SPMON',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate: cellTmp2_Reg_SPMON + cellTmp2_New_SPMON
				}, 
				{
					displayName : '예산조직',
					field : 'BORG',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : cellTmp2_Reg_BORG + cellTmp2_New_BORG 
				}, 
				{
					displayName : '예산조직명',
					field : 'BORGTXT',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : cellTmp2_Reg_BORGTXT + cellTmp2_New_BORGTXT
				}, 
				{
					displayName : '전용 예산조직',
					field : 'C_BORG',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : cellTmp2_Reg_C_BORG + cellTmp2_New_C_BORG 
				}, 
				{
					displayName : '전용 예산조직명',
					field : 'C_BORGTXT',
					width : '135',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : cellTmp2_Reg_C_BORGTXT + cellTmp2_New_C_BORGTXT
				}, 
				{
					displayName : '예산계정',
					field : 'BACT',
					width : '100',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : cellTmp1_Reg_BACT + cellTmp1_New_BACT
				}, 
				{
					displayName : '예산계정명',
					field : 'BACTTXT',
					width : '110',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : cellTmp1_Reg_BACTTXT + cellTmp1_New_BACTTXT,
					footerCellTemplate: '<div class="ui-grid-cell-contents">합 계</div>'
				}, 
				{
					displayName : '잔액',
					field : 'REMAMT',
					width : '100',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : cellTmp2_Reg_REMAMT + cellTmp2_New_REMAMT,
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents right" >{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
				}, 
				{
					displayName : '적용금액',
					field : 'VALUE',
					width : '100',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : cellTmp2_Reg_VALUE + cellTmp2_New_VALUE,
					aggregationType: uiGridConstants.aggregationTypes.sum,
					footerCellTemplate: '<div class="ui-grid-cell-contents right" >{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
				},
				{
					displayName : '내역',
					field : 'DOCUM',
					//width : '7.7%',
					minWidth: 110,
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate :  cellTmp2_Reg_DOCUM + cellTmp2_New_DOCUM
				}, 
			  ];
			
			//구분마다 그리드 컬럼정보 변경
			$scope.gridColChange = function(value){
				if(value == "C"){	//전용
					 $scope.gridOptions.columnDefs = columnDefs2;							//"전용" 그리드컬럼 적용
// 					 $scope.gridOptions.multiSelect = false;								//"전용" 멀티셀렉트 금지
					 $scope.gridOptions.multiSelect = true;									//"전용" 멀티셀렉트 허용
				}else{
					 $scope.gridOptions.columnDefs = columnDefs1;							//"전용" 외 그리드컬럼 적용	
					 $scope.gridOptions.multiSelect = true;									//"전용" 외 멀티셀렉트 허용
				}
				//그리드 초기화 모음
				$scope.gridOptions.data.length = 0;											//그리드 data 초기화
				$scope.gridApi.selection.clearSelectedRows();								//그리드 selection 초기화
			    $scope.gridApi.core.notifyDataChange(uiGridConstants.dataChange.COLUMN);	//그리드 컬럼 변경내용 즉시적용	
			};		 
			
			
			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바
				showColumnFooter : true,
				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 1000,

				enableCellEditOnFocus : true, //셀 클릭시 edit모드 
				enableSelectAll : false, //전체선택 체크박스
				enableRowSelection : true, //로우 선택
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

				columnDefs : columnDefs1,
				
				onRegisterApi: function( gridApi ) {
				      $scope.gridApi = gridApi;
				 }
			});

			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  

		} ]);

		$(document).ready(function() {
			// 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
			scope = angular.element(document.getElementById("shds-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
			
			scope.gridApi.core.on.rowsRendered(scope, function() {	//그리드 렌더링 후 이벤트
			 	//console.log(scope);
				//alert(scope.searchCnt);
			});
			scope.gridApi.selection.on.rowSelectionChanged(scope, function(row) { //로우 선택할때마다 이벤트
				//console.log("row2", row.entity);
				//체크해제시 "수정모드"였으면 "조회모드"로 변경해줌
				if(row.entity.state == "1"){
					scope.gridOptions.data[scope.gridOptions.data.indexOf(row.entity)].state = null;
					scope.gridApi.grid.refresh();
				}
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
				RFC_FUNC : "ZWEB_BUDGET_CHANGE" // RFC 함수명
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
			
			// 부트스트랩 날짜객체
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
			
			fnGubunSet();
			
			$("input[name=GUBUN]").on("click",function(){
				fnGubunSet();
			});
			
			$("input[name=SPMON_S]").on("change",function(){
				$("input[name=SPMON_E]").val($("input[name=SPMON_S]").val());
			});
			
			//조회횟수 초기화
			$("input[name=GUBUN]").on("change", function(){
				if( $('input[name="GUBUN"]:checked').val() == "I" || 
					$('input[name="GUBUN"]:checked').val() == "R" ||
					$('input[name="GUBUN"]:checked').val() == "C"){
					scope.searchCnt = 0;
				}
			});
			
			// 조회
			$("#search_btn").on("click", function() {
				var RFC_FUNC;
				//if($('input[name="GUBUN"]:checked').val() == "C"){
				//	RFC_FUNC = 'ZWEB_BUDGET_CHANGE2';
				//}else{
				//	RFC_FUNC = 'ZWEB_BUDGET_CHANGE';
				//}
				RFC_FUNC = 'ZWEB_BUDGET_CHANGE';
				
				var param = {
						EXEC_RFC : "Y", // RFC 여부
						RFC_TYPE : "ZFI_BUD", // RFC 구분
						RFC_FUNC : RFC_FUNC // RFC 함수명
				};
				scope.paginationOptions = customExtend(scope.paginationOptions, param);
				
				if (fnValidation()) {
					scope.reloadGrid({
						gubun : $('input[name="GUBUN"]:checked').val(),		//신청유형
						spmon_s : $("#SPMON_S").val(),						//입력년월_시작
						spmon_e : $("#SPMON_E").val(),						//입력년월_끝
						gsber_s : $('input[name="GSBER_S"]:checked').val(),	//사업영역
						spmon_f : $("#SPMON_F").val(),						//프롬년월_시작
						spmon_t : $("#SPMON_T").val(),						//프롬년월_끝
						rorg_s : $("#RORG_S").val(),						//집행부서
						bact_s : $("#BACT_S").val(),						//예산계정
						borg_s : $("#BORG_S").val(),						//예산조직
						statu : $("select[name=STATU]").val(),				//상태
	 					empCode    : "${req_data.emp_code}", 
	 					userDeptCd : "${req_data.user_dept_code}",
						userDept   : "${req_data.user_dept}"
						//20200722_khj 데이터조회를 위한 하드코딩
						//empCode    : "12016210"
					});
					
					//검색플래그 = 가능
					$("#search_flag").val("1");
				}
			});
			
			// 추가
			$("#add_btn").on("click", function() {			
				if(scope.searchCnt > 0){
					if($("input[name=GUBUN]:checked").val() == "S" || $("input[name=GUBUN]:checked").val() == "T"){	//조기&이월
						swalWarning("추가 할 수 없는 신청유형입니다.");
						return false;
					}
					
					//"전용" 조건일때 검색조건 변경되면 다시 조회하게끔 유도
					if($("input[name=GUBUN]:checked").val() == "C" && $("#search_flag").val() == "2"){
						swalWarning("검색 조건이 변경되었습니다. 조회이후 추가해 주세요.");
						return false;
					}
					
					scope.addRow({
						state     : 0,
						SPMON     : $("input[name=SPMON_S]").val(),
						STATUTXT  : "",
						RORG      : $("input[name=RORG_S]").val(),
						RORGTXT   : "",
						BORG      : $("input[name=BORG_S]").val(),
						BORGTXT   : "",
						BACT      : "",
						BACTTXT   : "",
						REMAMT    : 0,
						VALUE     : "",
						DOCUM     : "",
						ACDETTXT  : "",
						ACTIMETXT : "",
						GSBER   : "1100"
					      }, true, "desc"
					);
					
					//row 추가시 조회조건에 있는 입력되어있는 코드를 참조 
					fnAjaxKOSTL("R", 0);
					fnAjaxKOSTL("B", 0);
			
				}else{
					swalWarning("조회이후에 추가해 주세요.");
					return false;
				}
				
				
			});
			
			//수정
			$("#modify_btn").on("click",function(){
				var msg = "";
				var selectedRows = scope.gridApi.selection.getSelectedRows();	//그리드 선택된 rows data
				if(selectedRows.length == 0){
					swalWarning("수정할 데이터를 선택해 주세요.");
					return false;
				}
				
				$(selectedRows).each(function(index, item){
 					if(selectedRows[index].STATU == "" || selectedRows[index].STATU == null){
						//선택한 항목중에 상태가 빈값인 항목의 cellTemplate을 변경해서 수정모드로 변경
 						scope.gridOptions.data[scope.gridOptions.data.indexOf(selectedRows[index])].state = 1;
 						scope.gridApi.grid.refresh();
					}else{
						msg = "승인상태가 초기값(빈값)인 항목만 수정이 가능합니다.";
					}
				});

				if(msg != "") swalWarning(msg);
			});
			
			//저장버튼 클릭
			$("#save_btn").on("click",function(){
				var selectedRows = scope.gridApi.selection.getSelectedRows();	//그리드 선택된 rows data
				var datas = scope.gridOptions.data;	//그리드 전체 데이터 접근
				var new_chk = 0;
				var mod_chk = 0;
				for(var i=0; i < selectedRows.length; i++){
					if(selectedRows[i].state == "0") new_chk++;
					else mod_chk++;
				}
				//scope.gridApi.selection.getSelectedRows()[0].VALUE : 선택된 데이터의 금액 값
				
				/*
				2022.11.10 kjy 금액 필드 에러 메세지 추가
				*/
				if(!Number(scope.gridApi.selection.getSelectedRows()[0].VALUE)){
					swalWarning("금액 값엔 숫자만 입력 가능합니다.");
					return false;
				}

				if(new_chk > 0 && mod_chk > 0){
					swalWarning("추가/수정 처리는 같이 처리 될 수 없습니다.");
					return false;
				}else if(new_chk > 0){
					fnBudgetSave("add", selectedRows);
				}else if(mod_chk > 0){
					fnBudgetSave("modify", selectedRows);
				}else{
					swalWarning("저장할 항목을 선택해 주세요.");
					return false;
				}
			});
			
			//삭제버튼 클릭
			$("#delete_btn").on("click",function(){
				
				var selectedRows = scope.gridApi.selection.getSelectedRows();	//그리드 선택된 rows data
				var datas = scope.gridOptions.data;	//그리드 전체 데이터 접근
				
				if(selectedRows.length == 0){
					swalWarning("삭제할 항목을 선택해 주세요.");
					return false;
				}else{
					for(var i=0; i < selectedRows.length; i++){
						if(selectedRows[i].STATU != "1"){
							swalWarning("대기상태에서만 삭제할 수 있습니다.");
							return false;
						}
					}
				}

				fnBudgetSave("delete", selectedRows);
			});
			
			
		});
	
		function fnGubunSet(){
			//증액,감액
			if($("input[name=GUBUN]:checked").val() == "I" || $("input[name=GUBUN]:checked").val() == "R"){
				$("input[name=SPMON_F]").attr("disabled",true);
				$("input[name=SPMON_T]").attr("disabled",true);
				$("input[name=SPMON_S]").removeAttr("disabled");
				$("input[name=SPMON_E]").removeAttr("disabled");
				$("#add_btn").show();
				$("#modify_btn").hide();
				$("input:radio[name='GSBER_S']:radio[value='1100']").prop('checked', true); //default 본사 선택
			//전용 (그리드 컬럼 변경)
			}else if($("input[name=GUBUN]:checked").val() == "C"){
				$("input[name=GSBER_S]").attr("checked",false);
				$("input[name=SPMON_F]").attr("disabled",true);
				$("input[name=SPMON_T]").attr("disabled",true);
				$("input[name=SPMON_S]").removeAttr("disabled");
				$("input[name=SPMON_E]").removeAttr("disabled");
				$("#add_btn").show();
				$("#modify_btn").hide();
			//조기,이월
			}else{
				$("input[name=SPMON_F]").removeAttr("disabled");
				$("input[name=SPMON_T]").removeAttr("disabled");
				$("input[name=SPMON_S]").attr("disabled",true);
				$("input[name=SPMON_E]").attr("disabled",true);
				$("#add_btn").hide();
				$("#modify_btn").show();
				$("input:radio[name='GSBER_S']:radio[value='1100']").prop('checked', true);	//default 본사 선택
			}
		}


		function fnBudgetSave(type, selectedRows){
			var action_url = "";
			if(type == "add"){	//추가
				
				if($("input[name=GUBUN]:checked").val() == "C") action_url = "/yp/zfi/bud/createBudgetOnlyToSAP";
				else action_url = "/yp/zfi/bud/createBudgetToSAP";

				$("input[name=GSBER_R]").val($("input[name=GSBER_S]:checked").val());
				$("input[name=VALTP_R]").val($("input[name=GUBUN]:checked").val());
			}else if(type == "modify"){	//수정
				action_url = "/yp/zfi/bud/updateBudgetToSAP";
				$("input[name=GSBER_R]").val($("input[name=GSBER_S]:checked").val());
				$("input[name=VALTP_R]").val($("input[name=GUBUN]:checked").val());
			}else if(type == "delete"){	//삭제

				if($("input[name=GUBUN]:checked").val() == "C") action_url = "/yp/zfi/bud/deleteBudgetOnlyToSAP";
				else action_url = "/yp/zfi/bud/deleteBudgetToSAP";

				$("input[name=GSBER_R]").val($("input[name=GSBER_S]:checked").val());
				$("input[name=VALTP_R]").val($("input[name=GUBUN]:checked").val());
			}
			
			//form데이터에 그리드데이터 json으로 변환 및 추가해서 서버로 전송
			var data = $("#frm, #data_form").serializeArray();
			data.push({name: "gridData", value: JSON.stringify(selectedRows)})
			
			$.ajax({
			    url: action_url,
			    type: "POST",
			    cache:false,
			    async:true,
			    dataType:"json",
			    data:data,
			    success: function(result) {
			    	swalSuccess(result.msg);
			    	$("#search_btn").trigger("click");
			    },
			    beforeSend:function(){
					$('.wrap-loading').removeClass('display-none');
				},
				complete:function(){
			        $('.wrap-loading').addClass('display-none');
			    },
			    error:function(request,status,error){
			    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
			    	swalDanger("처리중 오류가 발생하였습니다.\n관리자에게 문의해주세요.");
			    }
			});
		}

		function fnGoSearch(pageIndex) {
		    if (pageIndex) {
		        $("#page").val(pageIndex);
		    } else {
		        $("#page").val("1");
		    }
		    fnSearchData();
		}


		function fnValidation() {
			if(undefined == $("input[name=GUBUN]:checked").val()){
				swalWarning("신청유형을 선택해 주세요.");
				return false;
			}else if("I" == $("input[name=GUBUN]:checked").val() || "R" == $("input[name=GUBUN]:checked").val()){
				if("" == $("input[name=SPMON_S]").val() || "" == $("input[name=SPMON_E]").val()){
					swalWarning("입력년월 기간을 입력해 주세요.");
					return false;
				}
				var s = $("input[name=SPMON_S]").val().replace(/[^0-9]/g,"");
				var e = $("input[name=SPMON_E]").val().replace(/[^0-9]/g,"");
				if(s > e){
					swalWarning("입력년월 종료일이 시작일보다 과거입니다.");
					return false;
				}
			}else if("S" == $("input[name=GUBUN]:checked").val() || "T" == $("input[name=GUBUN]:checked").val()){
				if("" == $("input[name=SPMON_F]").val() || "" == $("input[name=SPMON_T]").val()){
					swalWarning("FROM / TO 항목을 입력해 주세요.");
					return false;
				}
				var f = $("input[name=SPMON_F]").val().replace(/[^0-9]/g,"");
				var t = $("input[name=SPMON_T]").val().replace(/[^0-9]/g,"");
				if("S" == $("input[name=GUBUN]:checked").val() && f<t){
					swalWarning("TO는  FROM보다 과거로 설정해야 합니다.");
					return false;
				}else if("T" == $("input[name=GUBUN]:checked").val() && f>t){
					swalWarning("FROM은  TO보다 과거로 설정해야 합니다.");
					return false;
				}
			}
			return true;
		}

		function fnSearchPopup(type,target){//none target : 조회항목 , target : 추가항목 줄번호
			if(type=="1"){
				//window.open("/fi/","사업영역","width=630,height=800");
			}else if(type=="2"){
				window.open("/yp/popup/zfi/bud/retrieveBACT","예산계정","width=600,height=800,scrollbars=yes");
			}else if(type=="3"){
				window.open("/yp/popup/zfi/bud/retrieveKOSTL2?type=Z","집행부서","width=600,height=800,scrollbars=yes");
			}else if(type=="4"){
				/*
				2022.11.10 kjy 예산 조직 오류 수정 -> 타입 B로 변경
				*/
				//window.open("/yp/popup/zfi/bud/retrieveKOSTL2?type=CB","예산조직","width=600,height=800,scrollbars=yes");
				window.open("/yp/popup/zfi/bud/retrieveKOSTL2?type=B","예산조직","width=600,height=800,scrollbars=yes");
			}else if(type=="5"){
				window.open("/yp/popup/zfi/bud/retrieveKOSTL?type=R&target="+target,"집행부서 검색","width=600,height=800,scrollbars=yes");
			}else if(type=="6"){
				window.open("/yp/popup/zfi/bud/retrieveKOSTL?type=B&target="+target,"조직 검색","width=600,height=800,scrollbars=yes");
			}else if(type=="7"){
				window.open("/yp/popup/zfi/bud/retrieveBACT?type=B&target="+target,"예산계정 검색","width=600,height=800,scrollbars=yes");
			}
		}

		function fnSearchPopup2(type,target){	//"전용" 팝업이벤트
			if(type=="1"){
				window.open("/yp/popup/zfi/bud/retrieveKOSTL2?type=C&target="+target,"집행부서","width=600,height=800,scrollbars=yes");
			}else if(type=="3"){
				window.open("/yp/popup/zfi/bud/retrieveKOSTL2?type=CR&target="+target,"집행부서 검색","width=600,height=800,scrollbars=yes");
			}else if(type=="4"){
				window.open("/yp/popup/zfi/bud/retrieveKOSTL2?type=CB&target="+target,"예산조직 검색","width=600,height=800,scrollbars=yes");
			}else if(type=="5"){
				window.open("/yp/popup/zfi/bud/retrieveKOSTL2?type=CC&target="+target,"전용 예산조직 검색","width=600,height=800,scrollbars=yes");
			}else if(type=="6"){
				window.open("/yp/popup/zfi/bud/retrieveBACT?type=C&target="+target,"예산계정 검색","width=600,height=800,scrollbars=yes");
			}
		}
		
		function fnAjaxKOSTL(type,target){
			if( scope.gridOptions.data[target][type+"ORG"].length >= 6){
				
				//검색조건 임시추가 시작
				var form    = document.getElementById("data_form");
		    	var input   = document.createElement("input");
		    	input.name  = type+"ORG"+"_"+target;
		    	input.id    = type+"ORG"+"_"+target;
		    	input.value = scope.gridOptions.data[target][type+"ORG"]
		    	input.type  = "hidden";
		    	form.appendChild(input);
				//검색조건 임시추가 끝
		    	
				$.ajax({
				    url: "/yp/zfi/bud/retrieveAjaxKOSTL2?type="+type+"&target="+target,
				    type: "post",
				    cache:false,
				    async:true, 
				    data:$("#data_form, #frm").serialize(),
				    dataType:"json",
				    success: function(result) {
						if(result.KOST1 == "" || result.KOST1 == null){
							swalInfo("일치하는 데이터가 없습니다.");
						}else{
							if(type=="R"){//집행부서
								//$("input[name=RORGTXT_"+target+"]").val(result.VERAK);	//집행부서 코드설명
								scope.gridOptions.data[target].RORGTXT  = result.VERAK;		//집행부서 코드설명
							}else if(type=="C" || type=="C_B"){
								scope.gridOptions.data[target].C_BORGTXT = result.VERAK;	//전용 예산조직명
							}else{//type=="B" 코스트센터
								//$("input[name=BORGTXT_"+target+"]").val(result.VERAK);	//코스트센터 코드설명
								scope.gridOptions.data[target].BORGTXT  = result.VERAK;		//코스트센터 코드설명
							}
						}
						scope.gridApi.grid.refresh();	//그리드 새로고침(html elem와 바인딩 위함)
						
						//검색조건 임시추가한거 삭제
						$("#"+type+"ORG"+"_"+target).remove();
					},
					beforeSend:function(){
						$('.wrap-loading').removeClass('display-none');
					},
					complete:function(){
				        $('.wrap-loading').addClass('display-none');
				    },
				    error:function(request,status,error){
				    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
				    	swalDanger("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
				    }
			 	});
			}
		}

		function numberCommas(str) {
			var x = parseInt(str);
		    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}

		function fnAjaxBACT(target){
			if(scope.gridOptions.data[target].BACT.length >= 8){
				$("input[name=GSBER_R]").val($("input[name=GSBER_S]:checked").val());
				if($("input[name=GSBER_R]").val() == "") $("input[name=GSBER_R]").val(scope.gridOptions.data[target].GSBER);
				
				//검색조건 임시추가 시작
				var form    = document.getElementById("data_form");
		    	var input   = document.createElement("input");
		    	input.name  = "BACT_"+target;
		    	input.id    = "BACT_"+target;
		    	input.value = scope.gridOptions.data[target].BACT
		    	input.type  = "hidden";
		    	form.appendChild(input);
		    	
		    	var input2   = document.createElement("input");
		    	input2.name  = "RORG_"+target;
		    	input2.id    = "RORG_"+target;
		    	input2.value = scope.gridOptions.data[target].RORG
		    	input2.type  = "hidden";
		    	form.appendChild(input2);
		    	
		    	var input3   = document.createElement("input");
		    	input3.name  = "BORG_"+target;
		    	input3.id    = "BORG_"+target;
		    	input3.value = scope.gridOptions.data[target].BORG
		    	input3.type  = "hidden";
		    	form.appendChild(input3);
		    	
		    	var input4   = document.createElement("input");
		    	input4.name  = "SPMON_S_"+target;
		    	input4.id    = "SPMON_S_"+target;
		    	input4.value = scope.gridOptions.data[target].SPMON
		    	input4.type  = "hidden";
		    	form.appendChild(input4);
				//검색조건 임시추가 끝
				
				
				$.ajax({
				    url: "/yp/zfi/bud/retrieveAjaxBACT?target="+target,
				    type: "post",
				    cache:false,
				    async:true, 
				    data:$("#data_form, #frm").serialize(),
				    dataType:"json",
				    success: function(result) {
						if(result.TXT_50 == "" || result.TXT_50 == null){
							swalInfo("일치하는 데이터가 없습니다.");
						}else{
							scope.gridOptions.data[target].BACTTXT = result.TXT_50;				//계정과목 설명
							scope.gridOptions.data[target].REMAMT  = numberCommas(result.AMT);	//잔액
							scope.gridApi.core.notifyDataChange(scope.uiGridConstants.dataChange.ALL);	//새로고침
						}
						scope.gridApi.grid.refresh();	//그리드 새로고침(html elem와 바인딩 위함)
					},
					beforeSend:function(){
						$('.wrap-loading').removeClass('display-none');
					},
					complete:function(){
				        $('.wrap-loading').addClass('display-none');
				     	 //검색조건 임시추가한거 삭제
						$("#BACT_"+target).remove();
						$("#RORG_"+target).remove();
						$("#BORG_"+target).remove();
						$("#SPMON_S_"+target).remove();
				    },
				    error:function(request,status,error){
				    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
				    	swalDanger("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
				    }
			 	});
			}
		}
	</script>
</body>