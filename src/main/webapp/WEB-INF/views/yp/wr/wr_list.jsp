<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	String sdate = toDay.substring(0, 8) + "01";
%>

<head>
<title>${current_menu.menu_name}</title>
</head>

<body>
<script type="text/javascript">
	var scope;
	$(document).ready(function() {
		
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
	
		//조회조건 default
		//오늘날짜 세팅
		if($("input[name=WR_DAY]").val() == ""){
			$("input[name=WR_DAY]").val("<%=sdate%>");	
		}
		
		if($("input[name=WR_RE_DATE]").val() == ""){
			$("input[name=WR_RE_DATE]").val("<%=toDay%>");	
		}	
	});	
</script>

<script>
	$(document).ready(function(){
		//복붙영역(앵귤러 이벤트들 가져오기) 시작, 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
		var scope = angular.element(document.getElementById("wr-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
		scope.gridApi.selection.on.rowSelectionChanged(scope,function(row){			//로우 선택할때마다 이벤트		
	    });
	
		/* scope.gridApi.selection.on.rowSelectionChangedBatch(scope,function(rows){	//전체선택시 가져옴
			console.log(rows);           //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
	    });	 */
		
		//pagenation option setting  그리드를 부르기 전에 반드시 선언
		var param = {
			listQuery : "yp_wr.grid_wr_hist_list", 				//list가져오는 마이바티스 쿼리 아이디
			cntQuery : "yp_wr.grid_wr_hist_list_cnt"		//list cnt 가져오는 마이바티스 쿼리 아이디
		}; 
		    
		scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합	
	
		scope.reloadGrid({
		
		});
		//복붙영역(앵귤러 이벤트들 가져오기) 끝
	
		//rows렌더링된 후에 동작 이벤트 추가
		scope.gridApi.core.on.rowsRendered(scope, function() {
		});
	
		//조회 
		$("#search_btn").on("click",function(){		
			scope.reloadGrid({
				WR_EMP : $("input[name=WR_EMP]").val(),
				WR_SYS : $("input[name=WR_SYS]").val(),
				WR_NAME : $("input[name=WR_NAME]").val(),
				WR_DAY : $("input[name=WR_DAY]").val(),
				WR_RE_DATE : $("input[name=WR_RE_DATE]").val()
			});
		});
		
		$("#detail_btn").on("click", function(){
			var rows = scope.gridApi.selection.getSelectedRows();
			console.log('[TEST]rows:', rows);	
			if(rows.length < 1){
				swalWarningCB("요청 데이터를 선택해주세요.");
				return;
			}
		});
		
		$("#write_detail_btn").on("click", function(){
			write_Pop();
		});
		
		$("#report_in_detail_btn").on("click", function(){
			report_in_Pop();
		});
		
		$("#report_detail_btn").on("click", function(){	
			report_Pop();
		});
	});

	/* 팝업 submit */
	function fnHrefPopup(url, target, pr) {
		//20191023_khj for csrf
		var csrf_element = document.createElement("input");
		csrf_element.name = "_csrf";
		csrf_element.value = "${_csrf.token}";
		csrf_element.type = "hidden";
		//20191023_khj for csrf
		var popForm = document.createElement("form");
	
		/**
		 * [form 속성]
		 * action : form 데이터를 보낼 URL
		 * target : 네이밍 된 iframe
		 */
		popForm.name = "popForm";
		popForm.method = "post";
		popForm.target = target;
		popForm.action = url;
	
		document.body.appendChild(popForm);
	
		popForm.appendChild(csrf_element);
	
		/**
		 * parameter를 input으로 form에 추가
		 */
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
	
	/* 의뢰서 팝업 submit */
	function writeHrefPopup(url, target, pr) {
		//20191023_khj for csrf
		var csrf_element = document.createElement("input");
		csrf_element.name = "_csrf";
		csrf_element.value = "${_csrf.token}";
		csrf_element.type = "hidden";
		//20191023_khj for csrf
		var popForm2 = document.createElement("form");
	
		/**
		 * [form 속성]
		 * action : form 데이터를 보낼 URL
		 * target : 네이밍 된 iframe
		 */
		 popForm2.name = "popForm2";
		 popForm2.method = "post";
		 popForm2.target = target;
		 popForm2.action = url;
	
		document.body.appendChild(popForm2);
	
		popForm2.appendChild(csrf_element);
	
		/**
		 * parameter를 input으로 form에 추가
		 */
		$.each(pr, function(k, v) {
			// 				console.log(k, v);
			var el = document.createElement("input");
			el.name = k;
			el.value = v;
			el.type = "hidden";
			popForm2.appendChild(el);
		});
	
		popForm2.submit();
		popForm2.remove();
	}
	
	/* 자체처리 보고서 팝업 submit */
	function reportinHrefPopup(url, target, pr) {
		//20191023_khj for csrf
		var csrf_element = document.createElement("input");
		csrf_element.name = "_csrf";
		csrf_element.value = "${_csrf.token}";
		csrf_element.type = "hidden";
		//20191023_khj for csrf
		var popFormr = document.createElement("form");
	
		/**
		 * [form 속성]
		 * action : form 데이터를 보낼 URL
		 * target : 네이밍 된 iframe
		 */
		 popFormr.name = "popFormr";
		 popFormr.method = "post";
		 popFormr.target = target;
		 popFormr.action = url;
	
		document.body.appendChild(popFormr);
	
		popFormr.appendChild(csrf_element);
	
		/**
		 * parameter를 input으로 form에 추가
		 */
		$.each(pr, function(k, v) {
			// 				console.log(k, v);
			var el = document.createElement("input");
			el.name = k;
			el.value = v;
			el.type = "hidden";
			popFormr.appendChild(el);
		});
	
		popFormr.submit();
		popFormr.remove();
	}


	function write_Pop(){
		window.open("", "의뢰서작성", "width=1300", "height=550");
		writeHrefPopup("/yp/wr/wr_write_pop", "의뢰서작성" ,{
		});
	}

	function report_in_Pop(){
	
		window.open("", "자체처리보고서작성", "width=1300", "height=550");
	
		reportinHrefPopup("/yp/wr/wr_report_in_pop", "자체처리보고서작성" ,{
		});
	}
	
	function report_Pop(){
		
		window.open("", "추가보고서작성", "width=1300", "height=550");
	
		reportinHrefPopup("/yp/wr/wr_report_pop_plus", "추가보고서작성" ,{
		});
	}
	
	function openPop(row) {
		//form 초기화
		$("form[name='ent_frm']").each(function() {
			this.reset();
		    $("input[type=hidden]").val(''); //reset만으로 hidden type은 리셋이 안되기 때문에 써줌
		});		
		
		$("#ent_frm input[name=WR_CODES]").val(row.entity.WR_CODES);
		$("#ent_frm input[name=WR_NAME]").val(row.entity.WR_NAME); //제목
		$("#ent_frm input[name=WR_CALL_DEPT]").val(row.entity.WR_CALL_DEPT); //요청부서
		$("#ent_frm input[name=WR_CALL_EMP]").val(row.entity.WR_CALL_EMP); //요청자
		$("#ent_frm input[name=WR_DAY]").val(row.entity.WR_DAY); //요청일(작성일)
		$("#ent_frm input[name=WR_WORKD]").val(row.entity.WR_WORKD); //요청사항
		$("#ent_frm input[name=_csrf]").val('${_csrf.token}');
		
		window.open("","ENT_POP","scrollbars=yes,width=1130,height=800");
		document.ent_frm.target = "ENT_POP";
		document.ent_frm.action = "/yp/wr/wr_report_pop";
		
		$("#ent_frm").submit();
	}
	
	//처리서작성팝업
	function openPopf(row) {
		//form 초기화
		$("form[name='ent_frm']").each(function() {
			this.reset();
		    $("input[type=hidden]").val(''); //reset만으로 hidden type은 리셋이 안되기 때문에 써줌
		});

		$("#ent_frm input[name=WR_CODES]").val(row.entity.WR_CODES);
		$("#ent_frm input[name=WR_NAME]").val(row.entity.WR_NAME); //제목
		$("#ent_frm input[name=WR_WORK]").val(row.entity.WR_WORK); //작업자
		$("#ent_frm input[name=WR_WSDATE]").val(row.entity.WR_WSDATE); //작업기간 시작일
		$("#ent_frm input[name=WR_WEDATE]").val(row.entity.WR_WEDATE); //작업기간 종료일
		$("#ent_frm input[name=WR_TSDATE]").val(row.entity.WR_TSDATE); //테스트시작일자
		$("#ent_frm input[name=WR_TEDATE]").val(row.entity.WR_TEDATE); //테스트종료일자
		$("#ent_frm input[name=WR_RE_DATE]").val(row.entity.WR_RE_DATE); //완료예정일
		$("#ent_frm input[name=WR_TEDATE]").val(row.entity.WR_TEDATE); //테스트종료일자
		$("#ent_frm input[name=WR_WORKD]").val(row.entity.WR_WORKD); //작업내역
		$("#ent_frm input[name=WR_TESTD]").val(row.entity.WR_TESTD); //테스트내역
		$("#ent_frm input[name=WR_CALL_DEPT]").val(row.entity.WR_CALL_DEPT); //요청부서
		$("#ent_frm input[name=WR_CALL_EMP]").val(row.entity.WR_CALL_EMP); //요청자
	
		$("#ent_frm input[name=_csrf]").val('${_csrf.token}');
		
		window.open("","ENT_POP","scrollbars=yes,width=1130,height=800");
		document.ent_frm.target = "ENT_POP";
		document.ent_frm.action = "/yp/wr/wr_final_pop";
		
		$("#ent_frm").submit();
	}
	//처리서작성팝업
	
	//자체처리서작성팝업
	function openPope(row) {
		//form 초기화
		$("form[name='ent_frm']").each(function() {
			this.reset();
		    $("input[type=hidden]").val(''); //reset만으로 hidden type은 리셋이 안되기 때문에 써줌
		});
		
		$("#ent_frm input[name=WR_CODES]").val(row.entity.WR_CODES);
		$("#ent_frm input[name=WR_NAME]").val(row.entity.WR_NAME); //제목
		$("#ent_frm input[name=WR_WORK]").val(row.entity.WR_WORK); //작업자
		$("#ent_frm input[name=WR_WSDATE]").val(row.entity.WR_WSDATE); //작업기간 시작일
		$("#ent_frm input[name=WR_WEDATE]").val(row.entity.WR_WEDATE); //작업기간 종료일
		$("#ent_frm input[name=WR_TSDATE]").val(row.entity.WR_TSDATE); //테스트시작일자
		$("#ent_frm input[name=WR_TEDATE]").val(row.entity.WR_TEDATE); //테스트종료일자
		$("#ent_frm input[name=WR_RE_DATE]").val(row.entity.WR_RE_DATE); //완료예정일
		$("#ent_frm input[name=WR_TEDATE]").val(row.entity.WR_TEDATE); //테스트종료일자
		$("#ent_frm input[name=WR_WORKD]").val(row.entity.WR_WORKD); //작업내역
		$("#ent_frm input[name=WR_TESTD]").val(row.entity.WR_TESTD); //테스트내역
	
		$("#ent_frm input[name=_csrf]").val('${_csrf.token}');
		
		window.open("","ENT_POP","scrollbars=yes,width=1130,height=800");
		document.ent_frm.target = "ENT_POP";
		document.ent_frm.action = "/yp/wr/wr_final_in_pop";
		
		$("#ent_frm").submit();
	}
	//자체처리서작성팝업

</script>

<form id="ent_frm" name="ent_frm" method="post">
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" name="WR_CODES">
	<input type="hidden" name="WR_CALL_DEPT">
	<input type="hidden" name="WR_CALL_EMP">
	<input type="hidden" name="WR_DAY">
	<input type="hidden" name="WR_WORKD">
	<input type="hidden" name="WR_WORK">
	<input type="hidden" name="WR_WSDATE">
	<input type="hidden" name="WR_WEDATE">
	<input type="hidden" name="WR_TSDATE">
	<input type="hidden" name="WR_TEDATE">
	<input type="hidden" name="WR_RE_DATE">
	<input type="hidden" name="WR_TESTD">
</form>

<form  id="searchFrm">
<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />

	<h2>
	${current_menu.menu_name}
		<!-- 공통 - 네비게이션 시작 -->
		<ul class="loc">
			<li>
				<img src="/resources/yp/images/ic_loc_home.png">
			</li>
			
			<c:forEach var="menu" items="${breadcrumbList}">
				<li>${menu.menu_name}</li>
			</c:forEach>
		</ul>
		<!-- 공통 - 네비게이션 종료 -->
	</h2>
	<section>
		<div class="float_wrap">
			<div class="fl">
				<div class="stitle"></div>
			</div>
		</div>
		
		<div class="tbl_box">
			<table>
				<colgroup>
					<col width="5%" />
					<col width="25%" />
					<col width="5%" />
					<col width="25%" />
					<col width="5%" />
					<col width="25%" />
				</colgroup>
				<tr>
					<th>제목</th>
					<td>
						<input type="text" name="WR_NAME" value="" style="width:500px">
					</td>
					<th>작성기간</th>
					<td>
						<input type="text" class="calendar dtp" name="WR_DAY" id="WR_DAY" size="10" value="${sdate}" readonly>
						~
						<input type="text" class="calendar dtp" name="WR_RE_DATE" id="WR_RE_DATE" size="10" value="${date}" readonly>
					</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>
						<input type="text" name="WR_EMP" value="">
					</td>
					<th>시스템명</th>
					<td>
						<input type="text" name="WR_SYS" value="">
					</td>
				</tr>
					
			     
			</table>
			<div class="btn_wrap">
				<button class="btn btn_search" id="search_btn" >조회</button>
			</div>
		</div>
	</section>
	
	<div class="float_wrap">
		<div class="fl">
			<div class="stitle">
				작업내역
			</div>
		</div>
		<div class = "fr">
			<button type="button" class="btn_g" id="write_detail_btn">의뢰서작성</button>
			<button type="button" class="btn_g" id="report_in_detail_btn">자체처리작성</button>
<!-- 			<button type="button" class="btn_g" id="report_detail_btn">추가보고서작성</button> -->
		</div>
		
	</div>

	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="wr-uiGrid"  data-ng-controller="wrMasterHistListCtrl" style="height: 600px;">
			<div data-ui-i18n="ko" style="height: auto;">
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
	
	app.controller('wrMasterHistListCtrl', ['$scope','$controller','$log','StudentService', 'uiGridConstants', 
	function ($scope, $controller, $log, StudentService, uiGridConstants) {		//$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
		var vm = this; 										//this를 vm에 대입, 아래에서 부모의 $scope를 vm에 추가하기 위해 			
		angular.extend(vm, $controller('CodeCtrl',{ 		//CodeCtrl(ui-grid 커스텀 api)를 상속받는다
			$scope : $scope									// 자식컨트롤러의 vm에 부모 컨트롤러의 $scope를 합, 이로써 자식 컨트롤러에서 부모의 모든 $scope(this)를 사용 할 수 있음			
		}));	
		var paginationOptions = vm.paginationOptions;		//부모의 paginationOptions를 자식의 paginationOptions에 대입,즉시실행 함수
		
		paginationOptions.pageNumber = 1;					//초기 page number
		paginationOptions.pageSize = 10;					//초기 한번에 보여질 로우수
		$scope.paginationOptions = paginationOptions;
		
		$scope.gridApi = vm.gridApi;						//외부에서 grid의 클릭이벤트와 같은것들을 쓰기 위해서
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
		
		$scope.fnSearchPopup = function(type, row) {
			var target = scope.gridOptions.data.indexOf(row.entity);
			fnSearchPopup(type, target);
		};
		
		
		/**
		 * 결재상태
		 */
		$scope.isApproval = function(edoc_status){
			if(isEmpty(edoc_status)){
				return false;
			}else if(edoc_status === '5'){
				return false;
			}
			return true;
		};
		
		/**
		 * 결재상태
		 */
		$scope.isApproval2 = function(EDOC_STATUS_R){
			if(isEmpty(EDOC_STATUS_R)){
				return false;
			}else if(EDOC_STATUS_R === '5'){
				return false;
			}
			return true;
		};
		
		/**
		 * 결재상태
		 */
		$scope.isApproval3 = function(EDOC_STATUS_F){
			if(isEmpty(EDOC_STATUS_F)){
				return false;
			}else if(EDOC_STATUS_F === '5'){
				return false;
			}
			return true;
		};
		
		
		/* 결재상신 */

		/* 의뢰서 */
		$scope.fnApprovalC = function(row) {
	
						var codes = row.entity.WR_CODES,
							url = "http://gwdev.ypzinc.co.kr/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=EF171393927212297&WR_CODES="+codes;
							
						window.open(url, "전자결재", "scrollbars=auto,width=1000,height=900");
		};
		
		/* 보고서 */
		$scope.fnApprovalD = function(row) {
	
						var codes = row.entity.WR_CODES,
							url = "http://gwdev.ypzinc.co.kr/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=EF171394067177190&WR_CODES="+codes;
							
						window.open(url, "전자결재", "scrollbars=auto,width=1000,height=900");
				
		};
		
		/* 자체보고서 */
		$scope.fnApprovalE = function(row) {
	
						var codes = row.entity.WR_CODES,
							url = "http://gwdev.ypzinc.co.kr/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=EF171394157822518&WR_CODES="+codes;
							
						window.open(url, "전자결재", "scrollbars=auto,width=1000,height=900");
				
		};
		
		/* 처리서 */
		$scope.fnApprovalA = function(row) {
	
						var codes = row.entity.WR_CODES,
							url = "http://gwdev.ypzinc.co.kr/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=EF171394257360539&WR_CODES="+codes;
							
						window.open(url, "전자결재", "scrollbars=auto,width=1000,height=900");
				
		};
		
		/* 자체처리서 */
		$scope.fnApprovalB = function(row) {
	
						var codes = row.entity.WR_CODES,
							url = "http://gwdev.ypzinc.co.kr/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=EF171394307648684&WR_CODES="+codes;
							
						window.open(url, "전자결재", "scrollbars=auto,width=1000,height=900");
				
		};
		
		/* 보고서작성 */
		$scope.openPop_b = function(row) {
			openPop(row);
		};
		
		/* 처리서작성 */
		$scope.openPop_f = function(row) {
			openPopf(row);
		};
		
		/* 자체처리서작성 */
		$scope.openPop_e = function(row) {
			openPope(row);
		};
		
		
		
		$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
		{
			enableGridMenu: true,	 //필터버튼
			enableFiltering : false, //각 컬럼에 검색바

			paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트	
			paginationPageSize : 10,

			enableCellEditOnFocus : false, //셀 클릭시 edit모드 
			enableSelectAll : true, //전체선택 체크박스
			enableRowSelection : false, //로우 선택
			enableRowHeaderSelection : true, //맨앞 컬럼 체크박스 컬럼으로
			selectionRowHeaderWidth : 35, //체크박스 컬럼 길이
			enableHorizontalScrollbar : "1",
			enableVerticalScrollbar : "1",
			rowHeight : 27, //체크박스 컬럼 높이
			//useExternalPagination : true, //pagination을 직접 세팅
			enableAutoFitColumns : false, //컬럼 width를 자동조정
			multiSelect : true, //여러로우선택
			enablePagination : true,
			enablePaginationControls : true,
			
			columnDefs : [ //컬럼 세팅
			{
				displayName : '코드',
				field : 'WR_CODES',
				width : '100',
				visible : false,
				cellClass : "center",
				pinnedLeft : true,
				enableCellEdit : false,
				allowCellFocus : false
			},
			{
				displayName : '번호',
				field : 'WR_CD',
				width : '100',
				visible : false,
				cellClass : "center",
				pinnedLeft : true,
				enableCellEdit : false,
				allowCellFocus : false
			},
			{
				displayName : '번호',
				field : 'EDOC_NO',
				width : '100',
				visible : false,
				cellClass : "center",
				pinnedLeft : true,
				enableCellEdit : false,
				allowCellFocus : false
			},
			{
				displayName : '분류',
				field : 'WR_TYPE',
				width : '100',
				visible : false,
				cellClass : "center",
				pinnedLeft : true,
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : 
					'<div ng-if="row.entity.WR_TYPE == \'A\'" class="ui-grid-cell-contents">처리서</div>'
					+'<div ng-if="row.entity.WR_TYPE == \'B\'" class="ui-grid-cell-contents">자체처리서</div>'
					+'<div ng-if="row.entity.WR_TYPE == \'C\'" class="ui-grid-cell-contents">의뢰서</div>'
					+'<div ng-if="row.entity.WR_TYPE == \'D\'" class="ui-grid-cell-contents">보고서</div>'
					+'<div ng-if="row.entity.WR_TYPE == \'E\'" class="ui-grid-cell-contents">자체보고서</div>'
			},
			
			{
				displayName : '의뢰서',
				field : 'EDOC_STATUS',
				width : '120',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				/**
				 * [전자결재 상태표]
				 * A : SAP에서 작성완료  => X
				 * 0 : 결재진행중 => 결재중
				 * 4 : 결재진행중 => X
				 * 5 : 반려상태 => 반려
				 * 7 : 결재상신을 취소한 상태 => 회수
				 * F : 수신결재완료 => 완료
				 * D : 사용자에의한 삭제 => 삭제
				 * U : 수신결재완료 => X
				 * J : 수신결재반려후 반송 => X
				 * E : 내부결재종료 => 완료
				 * R : 수신접수 => X
				 * S : 내부결재완료 => 완료
				 * C : 완전삭제 => X
				 */
				cellTemplate : 
					'<div ng-if="!grid.appScope.isApproval(row.entity.EDOC_STATUS) && row.entity.WR_TYPE ==\'C\'" class="ui-grid-cell-contents btn_g"  style="cursor: pointer;" ng-click="grid.appScope.fnApprovalC(row)">결재상신</div>'
					+'<div ng-if="row.entity.EDOC_STATUS == \'0\'" class="ui-grid-cell-contents">결재중</div>'
					+'<div ng-if="row.entity.EDOC_STATUS == \'4\'" class="ui-grid-cell-contents">수신결재중</div>'
					+'<div ng-if="row.entity.EDOC_STATUS == \'S\'" class="ui-grid-cell-contents">완료</div>'
					+'<div ng-if="row.entity.EDOC_STATUS == \'F\'" class="ui-grid-cell-contents">완료</div>'
					+'<div ng-if="row.entity.EDOC_STATUS == \'E\'" class="ui-grid-cell-contents">완료</div>'
					+'<div ng-if="row.entity.EDOC_STATUS == \'5\'" class="ui-grid-cell-contents">반려</div>'
					+'<div ng-if="row.entity.EDOC_STATUS == \'7\'" class="ui-grid-cell-contents">회수</div>'
					+'<div ng-if="row.entity.EDOC_STATUS == \'D\'" class="ui-grid-cell-contents">삭제</div>'
			},	
			{
				displayName : '보고서',
				field : 'EDOC_STATUS_R',
				width : '120',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
				cellTemplate : 
					'<div ng-if="row.entity.EDOC_STATUS ==\'F\' && row.entity.WR_REPORT ==\'N\'"  class="ui-grid-cell-contents btn_g"  style="cursor: pointer;" ng-click="grid.appScope.openPop_b(row)">보고서작성</div>'
					+'<div ng-if="!grid.appScope.isApproval2(row.entity.EDOC_STATUS_R) && row.entity.WR_REPORT ==\'Y\' && row.entity.WR_TYPE ==\'D\'" class="ui-grid-cell-contents btn_g"  style="cursor: pointer;" ng-click="grid.appScope.fnApprovalD(row)">결재상신</div>'
					+'<div ng-if="!grid.appScope.isApproval2(row.entity.EDOC_STATUS_R) && row.entity.WR_REPORT ==\'Y\' && row.entity.WR_TYPE ==\'E\'" class="ui-grid-cell-contents btn_g"  style="cursor: pointer;" ng-click="grid.appScope.fnApprovalE(row)">결재상신</div>'
					+'<div ng-if="row.entity.EDOC_STATUS_R == \'0\'" class="ui-grid-cell-contents">결재중</div>'
					+'<div ng-if="row.entity.EDOC_STATUS_R == \'4\'" class="ui-grid-cell-contents">수신결재중</div>'
					+'<div ng-if="row.entity.EDOC_STATUS_R == \'S\'" class="ui-grid-cell-contents">완료</div>'
					+'<div ng-if="row.entity.EDOC_STATUS_R == \'F\'" class="ui-grid-cell-contents">완료</div>'
					+'<div ng-if="row.entity.EDOC_STATUS_R == \'E\'" class="ui-grid-cell-contents">완료</div>'
					+'<div ng-if="row.entity.EDOC_STATUS_R == \'5\'" class="ui-grid-cell-contents">반려</div>'
					+'<div ng-if="row.entity.EDOC_STATUS_R == \'7\'" class="ui-grid-cell-contents">회수</div>'
					+'<div ng-if="row.entity.EDOC_STATUS_R == \'D\'" class="ui-grid-cell-contents">삭제</div>'
			},
			{
				displayName : 'EDOC_STATUS_R',
				field : 'EDOC_STATUS_R',
				width : '100',
				visible : false,
				cellClass : "left",
				pinnedLeft : true,
				enableCellEdit : false,
				allowCellFocus : false,
			},
			{
				displayName : 'EDOC_STATUS_F',
				field : 'EDOC_STATUS_F',
				width : '100',
				visible : false,
				cellClass : "left",
				pinnedLeft : true,
				enableCellEdit : false,
				allowCellFocus : false,
			},
			{
				displayName : '처리서',
				field : 'WR_FINAL',
				width : '120',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false,
 				cellTemplate : 
 					'<div ng-if="row.entity.EDOC_STATUS_R ==\'F\' && row.entity.WR_FINAL ==\'N\' && row.entity.WR_TYPE ==\'D\' "  class="ui-grid-cell-contents btn_g"  style="cursor: pointer;" ng-click="grid.appScope.openPop_f(row)">처리서작성</div>'
 					+'<div ng-if="row.entity.EDOC_STATUS_R ==\'F\' && row.entity.WR_FINAL ==\'N\' && row.entity.WR_TYPE ==\'E\' "  class="ui-grid-cell-contents btn_g"  style="cursor: pointer;" ng-click="grid.appScope.openPop_e(row)">자체처리서작성</div>'
					+'<div ng-if="!grid.appScope.isApproval3(row.entity.EDOC_STATUS_F) && row.entity.WR_FINAL ==\'Y\' && row.entity.WR_TYPE ==\'A\'" class="ui-grid-cell-contents btn_g"  style="cursor: pointer;" ng-click="grid.appScope.fnApprovalA(row)">결재상신</div>'
					+'<div ng-if="!grid.appScope.isApproval3(row.entity.EDOC_STATUS_F) && row.entity.WR_FINAL ==\'Y\' && row.entity.WR_TYPE ==\'B\'" class="ui-grid-cell-contents btn_g"  style="cursor: pointer;" ng-click="grid.appScope.fnApprovalB(row)">결재상신</div>'
					+'<div ng-if="row.entity.EDOC_STATUS_F == \'0\'" class="ui-grid-cell-contents">결재중</div>'
					+'<div ng-if="row.entity.EDOC_STATUS_F == \'4\'" class="ui-grid-cell-contents">수신결재중</div>'
					+'<div ng-if="row.entity.EDOC_STATUS_F == \'S\'" class="ui-grid-cell-contents">완료</div>'
					+'<div ng-if="row.entity.EDOC_STATUS_F == \'F\'" class="ui-grid-cell-contents">완료</div>'
					+'<div ng-if="row.entity.EDOC_STATUS_F == \'E\'" class="ui-grid-cell-contents">완료</div>'
					+'<div ng-if="row.entity.EDOC_STATUS_F == \'5\'" class="ui-grid-cell-contents">반려</div>'
					+'<div ng-if="row.entity.EDOC_STATUS_F == \'7\'" class="ui-grid-cell-contents">회수</div>'
					+'<div ng-if="row.entity.EDOC_STATUS_F == \'D\'" class="ui-grid-cell-contents">삭제</div>'
			},
			{
				displayName : 'WR_REPORT',
				field : 'WR_REPORT',
				width : '100',
				visible : false,
				cellClass : "left",
				pinnedLeft : true,
				enableCellEdit : false,
				allowCellFocus : false,
			},
			{
				displayName : 'WR_FINAL',
				field : 'WR_FINAL',
				width : '100',
				visible : false,
				cellClass : "left",
				pinnedLeft : true,
				enableCellEdit : false,
				allowCellFocus : false,
			},
			{
				displayName : '제목',
				field : 'WR_NAME',
				width : '470',
				visible : true,
				cellClass : "left",
				pinnedLeft : true,
				enableCellEdit : false,
				allowCellFocus : false,
			},
			{
				displayName : '작성자',
				field : 'WR_EMP',
				width : '100',
				visible : true,
				cellClass : "center",
				pinnedLeft : true,
				enableCellEdit : false,
				allowCellFocus : false
			}, 
			{
				displayName : '작업자',
				field : 'WR_WORK',
				width : '100', 
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, {
				displayName : '요청부서',
				field : 'WR_CALL_DEPT',
				width : '120',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			},{
				displayName : '요청자',
				field : 'WR_CALL_EMP',
				width : '120',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			},{
				displayName : '시스템명',
				field : 'WR_SYS',
				width : '120',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			}, {
				displayName : '작업종류',
				field : 'WR_TAB',
				width : '120',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			},		
			{
				displayName : '작성일',
				field : 'WR_DAY',
				width : '120',
				visible : true,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			},
			{
				displayName : '완료일',
				field : 'WR_RE_DATE',
				width : '120',
				visible : false,
				cellClass : "center",
				enableCellEdit : false,
				allowCellFocus : false
			},
			
			{
				displayName : '비고',
				field : 'WR_TESTD',
				width : '200',
				visible : false,
				cellClass : "left",
				enableCellEdit : false,
				allowCellFocus : false
			},
			{
				displayName : '보고서테스트',
				field : 'R_WR_TYPE',
				width : '200',
				visible : false,
				cellClass : "left",
				enableCellEdit : false,
				allowCellFocus : false
			},
			{
				displayName : '요청사항',
				field : 'WR_WORKD',
				width : '200',
				visible : false,
				cellClass : "left",
				enableCellEdit : false,
				allowCellFocus : false
			},
			{
				displayName : '작업시작일',
				field : 'WR_WSDATE',
				width : '200',
				visible : false,
				cellClass : "left",
				enableCellEdit : false,
				allowCellFocus : false
			},
			{
				displayName : '작업종료일',
				field : 'WR_WEDATE',
				width : '200',
				visible : false,
				cellClass : "left",
				enableCellEdit : false,
				allowCellFocus : false
			},
			{
				displayName : '테스트시작일',
				field : 'WR_TSDATE',
				width : '200',
				visible : false,
				cellClass : "left",
				enableCellEdit : false,
				allowCellFocus : false
			},
			{
				displayName : '테스트종료일',
				field : 'WR_TEDATE',
				width : '200',
				visible : false,
				cellClass : "left",
				enableCellEdit : false,
				allowCellFocus : false
			},

			],
			onRegisterApi: function(gridApi){
			      $scope.gridApi = gridApi;
			      $scope.gridApi.pagination.on.paginationChanged( $scope, function( currentPage, pageSize){
			      	$scope.getPage(currentPage, pageSize);
				});
			}
		});

		$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
		$scope.reloadGrid = vm.reloadGrid;
		//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  
															
	}]);
	//복붙영역(앵귤러단) 끝
	</script>

</form>
</body>


