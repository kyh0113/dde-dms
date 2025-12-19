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
<title>예산조회
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
		}).on('changeDate', function(){
		 	$('.datepicker').hide();
		});
		
		//조회조건 default
		if("${req_data.gsber_s}" == ""){
			$("input:radio[name='GSBER_S']:radio[value='1100']").prop('checked', true); 
		}
		
		
		// 조회
		$("#search_btn").on("click", function() {
			if (fnValidation()) {
				scope.reloadGrid({
					gsber_s : $('input[name="GSBER_S"]:checked').val(),
					bact_s : $("#BACT_S").val(),
					bact_e : $("#BACT_E").val(),
					bact_sign : $("#BACT_SIGN").val(),
					bact_option : $("#BACT_OPTION").val(),
					rorg_s : $("#RORG_S").val(),
					rorg_e : $("#RORG_E").val(),
					rorg_sign : $("#RORG_SIGN").val(),
					rorg_option : $("#RORG_OPTION").val(),
					spmon_s : $("#SPMON_S").val(),
					spmon_e : $("#SPMON_E").val(),
					borg_s : $("#BORG_S").val(),
					borg_e : $("#BORG_E").val(),
					borg_sign : $("#BORG_SIGN").val(),
					borg_option : $("#BORG_OPTION").val(),
 					empCode    : "${req_data.emp_code}", 
 					userDeptCd : "${req_data.user_dept_code}",
					userDept   : "${req_data.user_dept}"
				});
			}
		});

		
		
		// SAP input parameter 세팅
		$(".SAP_INPUT_OPTION").on("change", function() {
			var $option = $("#"+this.id);
			var start_p = $(this).prevAll(":input[id$='_S']")[0].id;	//START PARAM
			var end_p   = $(this).prevAll(":input[id$='_E']")[0].id;	//END PARAM
			
			//input value 초기화
			$("#"+start_p).val("");	
			$("#"+end_p).val("");
			
			if($option.val() == "BT" || $option.val() == "NB"){
				$("#"+start_p).css("width","85px");
				$("#"+end_p).show();
			}else{
				$("#"+start_p).css("width","170px");
				$("#"+end_p).hide();
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
			xlsForm.action = "/yp/xls/zfi/bud/zfi_bud_read";

			document.body.appendChild(xlsForm);

			xlsForm.appendChild(csrf_element);

			//20201126_khj 일부 파라메터 주석처리(백승지대리가 요청했던 입력조건작업시 사용되는 파라메터임)
			var pr = {
					gsber_s : $('input[name="GSBER_S"]:checked').val(),
					bact_s : $("#BACT_S").val(),
					//bact_e : $("#BACT_E").val(),
					bact_sign : $("#BACT_SIGN").val(),
					bact_option : $("#BACT_OPTION").val(),
					rorg_s : $("#RORG_S").val(),
					//rorg_e : $("#RORG_E").val(),
					rorg_sign : $("#RORG_SIGN").val(),
					rorg_option : $("#RORG_OPTION").val(),
					spmon_s : $("#SPMON_S").val(),
					spmon_e : $("#SPMON_E").val(),
					borg_s : $("#BORG_S").val(),
					//borg_e : $("#BORG_E").val(),
					borg_sign : $("#BORG_SIGN").val(),
					borg_option : $("#BORG_OPTION").val(),
	 				empCode    : "${req_data.emp_code}", 
	 				userDeptCd : "${req_data.user_dept_code}",
					userDept   : "${req_data.user_dept}"
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

	function fnDocWriteGW(url) {
		var newwin = window.open(url, "전자결재 상신하기", "width=850, height=600, scrollbars=yes, resize=yes");
		if (newwin == null) {
			swalWarning("팝업 차단기능 혹은 팝업차단 프로그램이 동작중입니다. 팝업 차단 기능을 해제한 후 다시 시도하세요.");
			return false
		}
	}
	
	function fnSearchPopup(type){
		if(type=="1"){
			//window.open("/fi/","사업영역","width=630,height=800");
		}else if(type=="2"){
			window.open("/yp/popup/zfi/bud/retrieveBACT","예산계정","width=600,height=800,scrollbars=yes");	
		}else if(type=="3"){
			window.open("/yp/popup/zfi/bud/retrieveKOSTL2?type=Z","집행부서","width=600,height=800,scrollbars=yes");
		}else if(type=="4"){
			window.open("/yp/popup/zfi/bud/retrieveKOSTL2?type=B","예산조직","width=600,height=800,scrollbars=yes");
		}
	}
	
	function fnValidation() {
		var s = $("input[name=SPMON_S]").val().replace(/[^0-9]/g,"");
		var e = $("input[name=SPMON_E]").val().replace(/[^0-9]/g,"");
		if(s > e){
			swalWarning("입력년월 종료일이 시작일보다 과거입니다.");
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
	
	function fnDetailAmt(type,row){
		$("input[name=I_GSBER]").val(row.GSBER);
		$("input[name=I_RORG]").val(row.RORG);
		$("input[name=I_BORG]").val(row.BORG);
		$("input[name=I_BACT]").val(row.BACT);
		$("input[name=I_SPMON]").val(row.SPMON);
		$("input[name=I_ACTIME]").val(row.ACTIME);
		
		if(type=="ACT"){
			window.open("","ACT","scrollbars=yes,width=1300,height=600");
			document.amt_frm.target = "ACT";
			document.amt_frm.action = "/yp/popup/zfi/bud/retrieveDetailAmtAct";
		}else if(type=="BUD"){
			window.open("","BUD","scrollbars=yes,width=1300,height=600");	
			document.amt_frm.target = "BUD";
			document.amt_frm.action = "/yp/popup/zfi/bud/retrieveDetailAmtPlan";
		}
		$("#amt_frm").submit();
	}
</script>
</head>
<body>
	<h2>
		예산 조회
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
	<form id="amt_frm" name="amt_frm" method="post">
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="I_GSBER">
		<input type="hidden" name="I_RORG">
		<input type="hidden" name="I_BORG">
		<input type="hidden" name="I_BACT">
		<input type="hidden" name="I_SPMON">
		<input type="hidden" name="I_ACTIME">
	</form>
	<form id="frm" name="frm" method="post">
		<input type="hidden" name="excel_flag" />
		<input type="hidden" id="url" value=""/>
		<input type="hidden" name="page" id="page" value="${paginationInfo.currentPageNo}" />
		<input type="hidden" name="page_rows" value="" />
		
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
						<th>사업영역</th>
						<td>
							<!-- 생산기획팀(60007185) 외에는 본인 부서만 조회되도록 로직 수정 [myeongjin/20250826]-->					
							<input type="radio" name="GSBER_S" id="1100" value="1100" <c:if test="${req_data.GSBER_S eq '1100'}">checked</c:if> ><label for="1100">본사</label>
							<input type="radio" name="GSBER_S" id="1200" value="1200" <c:if test="${req_data.GSBER_S eq '1200'}">checked</c:if> ><label for="1200">석포</label>
							<input type="radio" name="GSBER_S" id="1400" value="1400" <c:if test="${req_data.GSBER_S eq '1400'}">checked</c:if> ><label for="1400">안성휴게소</label>
							<input type="radio" name="GSBER_S" id="1600" value="1600" <c:if test="${req_data.GSBER_S eq '1600'}">checked</c:if> ><label for="1600">Green메탈캠퍼스</label>
						</td>
						<th>집행부서</th>
						<td>
							<input type="text" name="RORG_S" id="RORG_S" style="width:170px;">
							
							<!-- 입력조건관련 임시주석처리 -->
							<!--  
							<input type="text" name="RORG_E" id="RORG_E" style="width:85px;display:none;">
							<input type="hidden" name="RORG_SIGN" id="RORG_SIGN" value="I">
							<select class="SAP_INPUT_OPTION" name="RORG_OPTION" id="RORG_OPTION">
								<option value="EQ" selected>=</option>
								<option value="BT">사이값</option>
								<option value="NB">사이값 제외</option>
								<option value="GE">≥</option>
								<option value="LE">≤</option>
								<option value="GT">＞</option>
								<option value="LT">＜</option>
								<option value="NE">≠</option>
							</select>
							-->
							
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
						<th>예산계정</th>
						<td>
							<input type="text" name="BACT_S" id="BACT_S" style="width:170px;">
							
							<!-- 입력조건관련 임시주석처리 -->
							<!--  
							<input type="text" name="BACT_E" id="BACT_E" style="width:85px;display:none;">
							<input type="hidden" name="BACT_SIGN" id="BACT_SIGN" value="I">
							<select class="SAP_INPUT_OPTION" name="BACT_OPTION" id="BACT_OPTION">
								<option value="EQ" selected>=</option>
								<option value="BT">사이값</option>
								<option value="NB">사이값 제외</option>
								<option value="GE">≥</option>
								<option value="LE">≤</option>
								<option value="GT">＞</option>
								<option value="LT">＜</option>
								<option value="NE">≠</option>
							</select>
							-->

							<a href="#" onclick="fnSearchPopup('2');"><img src="/resources/yp/images/ic_search.png"></a>
						</td>
						<th>예산조직</th>
						<td>
							<input type="text" name="BORG_S" id="BORG_S" style="width:170px;">
							
							<!-- 입력조건관련 임시주석처리 -->
							<!--  
							<input type="text" name="BORG_E" id="BORG_E" style="width:85px;display:none;">
							<input type="hidden" name="BORG_SIGN" id="BORG_SIGN" value="I">
							<select class="SAP_INPUT_OPTION" name="BORG_OPTION" id="BORG_OPTION">
								<option value="EQ" selected>=</option>
								<option value="BT">사이값</option>
								<option value="NB">사이값 제외</option>
								<option value="GE">≥</option>
								<option value="LE">≤</option>
								<option value="GT">＞</option>
								<option value="LT">＜</option>
								<option value="NE">≠</option>
							</select>
							-->

							<a href="#" onclick="fnSearchPopup('4');"><img src="/resources/yp/images/ic_search.png"></a>
						</td>
						<th>&nbsp;</th>
						<td>&nbsp;</td>
					</tr>
				</table>
				<div class="btn_wrap">
					<input type="button" class="btn btn_make" id="excel_btn" value="엑셀 다운로드"/>
					<input type="button" class="btn btn_search" id="search_btn" value="조회"/>
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
			</div>
		</div>
	</div>
	
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="shds-uiGrid" data-ng-controller="shdsCtrl" style="height: auto;">
			<div data-ui-i18n="ko" style="height: 580px;">
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
				return str_date.substring(0,4)+"."+str_date.substring(4,6)
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
			$scope.openPop_BUDAMT = function(row){
				fnDetailAmt("BUD", row);
			};
			
			//사용금액 상세보기
			$scope.openPop_ACTAMT = function(row){
				fnDetailAmt("ACT", row);
			};
			
			//cellClass
			$scope.cellClassSet = function(grid, row, col, rowRenderIndex, colRenderIndex){
				var className = "";
				switch(col.field){
					case "BUDAMT" :	className = "right"; 
					break;
					case "ACTAMT" :	className = "right"; 
					break;	
				}
				if(col.field == "BUDAMT" && (row.entity.BUDAMT > 0)){
					className = className + " blue cursor-underline";
				}
				if(col.field == "ACTAMT" && (row.entity.ACTAMT > 0)){
					className = className + " blue cursor-underline";
				}
				
				return className;
			}

			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu:true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바
				showColumnFooter : true,
				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
				paginationPageSize : 1000,

				enableCellEditOnFocus : true, //셀 클릭시 edit모드 
				enableSelectAll : false, //전체선택 체크박스
				enableRowSelection : true, //로우 선택
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

				columnDefs : 
				[ //컬럼 세팅
					{
						displayName : '입력년월',
						field : 'SPMON',
						width : '100',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_yyyymm(row.entity.SPMON)}}</div>'
					}, 
					{
						displayName : '입력년월(H)',
						field : 'SPMON',
						width : '110',
						visible : false,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					}, 
					{
						displayName : '사업영역(H)',
						field : 'GSBER',
						width : '100',
						visible : false,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					}, 
					{
						displayName : '집행부서',
						field : 'RORG',
						width : '100',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					}, 
					{
						displayName : '집행부서명',
						field : 'RORGTXT',
						width : '110',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					}, 
					{
						displayName : '예산조직',
						field : 'BORG',
						width : '100',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					}, 
					{
						displayName : '예산조직명',
						field : 'BORGTXT',
						width : '110',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					}, 
					{
						displayName : '계정분류',
						field : 'CLASS',
						//width : '10%',
						minWidth: 100,
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					}, 
					{
						displayName : '예산계정',
						field : 'BACT',
						width : '100',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					}, 
					{
						displayName : '예산계정명',
						field : 'BACTTXT',
						//width : '15%',
						minWidth: 100,
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					}, {
						displayName : '연도',
						field : 'GJAHR',
						width : '120',
						visible : false,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false,
						footerCellTemplate: '<div class="ui-grid-cell-contents">합 계</div>'
					}, 
					{
						displayName : '계획금액',
						field : 'BASEAMT',
						width : '100',
						visible : true,
						cellClass : "right",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.BASEAMT)}}</div>',
						aggregationType: uiGridConstants.aggregationTypes.sum,
						footerCellTemplate: '<div class="ui-grid-cell-contents right" >{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
					}, 
					{
						displayName : '예산금액',
						field : 'BUDAMT',
						width : '100',
						visible : true,
						cellClass : $scope.cellClassSet,
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents ng-binding ng-scope ui-grid-click-column cursor" ng-click="grid.appScope.openPop_BUDAMT(row.entity)">{{grid.appScope.formatter_decimal(row.entity.BUDAMT)}}</div>',
						aggregationType: uiGridConstants.aggregationTypes.sum,
						footerCellTemplate: '<div class="ui-grid-cell-contents right" >{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
					}, 
					{
						displayName : '사용금액',
						field : 'ACTAMT',
						width : '100',
						visible : true,
						cellClass : $scope.cellClassSet,
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents ng-binding ng-scope ui-grid-click-column cursor" ng-click="grid.appScope.openPop_ACTAMT(row.entity)">{{grid.appScope.formatter_decimal(row.entity.ACTAMT)}}</div>',
						aggregationType: uiGridConstants.aggregationTypes.sum,
						footerCellTemplate: '<div class="ui-grid-cell-contents right" >{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
					}, 
					{
						displayName : '가용금액',
						field : 'REMAMT',
						width : '100',
						visible : true,
						cellClass : "right",
						enableCellEdit : false,
						allowCellFocus : false,
						cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.REMAMT)}}</div>',
						aggregationType: uiGridConstants.aggregationTypes.sum,
						footerCellTemplate: '<div class="ui-grid-cell-contents right" >{{grid.appScope.formatter_decimal(col.getAggregationValue())}}</div>'
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
					},
					{
						displayName : '통제시기(H)',
						field : 'ACTIME',
						width : '120',
						visible : false,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					},
					{
						displayName : '통제부서',
						field : 'ACSLFTXT',
						width : '100',
						visible : true,
						cellClass : "center",
						enableCellEdit : false,
						allowCellFocus : false
					} 
				]
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
				RFC_FUNC : "ZWEB_BUDGET_LIST" // RFC 함수명
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합

		
			//복붙영역(앵귤러 이벤트들 가져오기) 끝
		});
	</script>
	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
</body>