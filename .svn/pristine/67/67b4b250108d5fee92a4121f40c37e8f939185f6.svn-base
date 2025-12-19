<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");

	String userName = (String) request.getSession().getAttribute("userName");
%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>메인</title>
</head>

<body>
	<!-- 2020-08-26 smh -->
	<!-- ng-app="app"은 main.jsp를 body로 가지는 yp_sesseion_exist_main.jsp에 존재 -->
	<!-- ng-app="app으로 Angular module을 생성 -->
	<div id="angular_body"  data-ng-controller="angular_controller">
		<!-- 20191023_khj for csrf -->
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<div id="wrapper">
			<!-- top S -->
			<div class="main_img">
				<div class="header">
					<div class="logo">
						<a href="javascript:void(0);"><img src="/resources/yp/images/logo.png"></a>
					</div>
					<div class="top_ic">
						<ul>
							<li>
								<%=userName%>
								<a href="javascript:void(0);"><img src="/resources/yp/images/topic_logout.png"></a>
								<div class="topnav_my">
									<ul>
										<li>
											<a href="javascript:void(0);" id="logout_btn">로그아웃</a>
										</li>
									</ul>
								</div>
							</li>
						</ul>
					</div>
				</div>
				<div id="container">
					<div class="motor">
						FRONTIER, GLOBAL, GREEN<br /> <span>YOUNG POONG</span>
					</div>
				</div>
			</div>
			<!-- top E -->
			<div class="space40"></div>
			<div id="container">
				<div class="leftCon">
					<!-- main stats S -->
<!-- 					2020-09-04 jamerl - 안기철팀장 : 영역제거 요청 -->
				<%--<div class="m_stats">
						<div class="m_stats_item bg_blue">
							<h3>계약현황</h3>
							<div class="m_stats_date">2020.04.08 ~ 2020.05.08</div>
							<h1>
								15 <span>건</span>
							</h1>
						</div>
						<div class="space40"></div>
						<div class="m_stats_item bg_orange">
							<h3>적립금현황</h3>
							<div class="m_stats_date">
								<a href="javascript:void(0);"><img src="/resources/yp/images/arrow.png"></a> 2020.05 <a href="javascript:void(0);"><img src="/resources/yp/images/arrow.png" class="arrow_rt"></a>
							</div>
							<h1>
								12 <span>업체</span> 100 <span>%</span>
							</h1>
						</div>
					</div>--%>
					<!-- main stats E -->
				</div>
				<div class="rightCon">
					<!-- main menu S -->
					<ul class="m_menu_item">
						<li>
							<a href="javascript:void(0);" id="zfi_btn"><img src="/resources/yp/images/menu_ic_money.png">
								<p>재무관리</p></a>
						</li>
						<li>
							<a href="javascript:void(0);" id="zmm_btn"><img src="/resources/yp/images/menu_ic_buy.png">
								<p>구매관리</p></a>
						</li>
						<li class="nomargin">
							<a href="javascript:void(0);" id="zhr_btn"><img src="/resources/yp/images/menu_ic_person.png">
								<p>인사관리</p></a>
						</li>
						<li>
							<a href="javascript:void(0);" id="zpp_btn"><img src="/resources/yp/images/menu_ic_report.png">
								<p>생산관리</p></a>
						</li>
						<li>
							<a href="javascript:void(0);" id="zwc_btn"><img src="/resources/yp/images/menu_ic_work.png">
								<p>조업도급관리</p></a>
						</li>
						<li class="nomargin">
							<a href="javascript:void(0);" id="zcs_btn"><img src="/resources/yp/images/menu_ic_factory.png">
								<p>정비용역관리</p></a>
						</li>
					</ul>
					<!-- main menu E -->
					<!-- notice S -->
					<div class="notice">
						<ul class="list_bl">
							<c:forEach var="boardItem" items="${boardList}">
								<li>
									<a href="javascript:void(0);" onclick="go_board(this)" data-board_no="${boardItem.BOARD_NO}" data-created_by="${boardItem.CREATED_BY}" data-attach_no="${boardItem.ATTACH_NO}">${boardItem.TITLE}</a><span class="date">${boardItem.CREATION_DATE}</span>
								</li>
							</c:forEach>
						</ul>
					</div>
					<!-- notice E -->
					<div class="branch">
						<%-- 2020-09-06 jamerl - 안기철팀장 : 왼쪽 50% 수준, 오른쪽은 빈 공간으로 해달라고 요청 --%>
						<!-- notice S -->
<!-- 						<ul class="list_bl"> -->
<!-- 							<li> -->
<!-- 								본사<span class="tel">02-519-3314</span> -->
<!-- 							</li> -->
<!-- 							<li> -->
<!-- 								석포제련소<span class="tel">054-679-7200</span> -->
<!-- 							</li> -->
<!-- 							<li> -->
<!-- 								지역별 사무소<span class="tel">031-611-5793(안성)<br />033-521-9087(동해) -->
<!-- 								</span> -->
<!-- 							</li> -->
<!-- 						</ul> -->
						<!-- notice E -->
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<%@include file="../biz/board/popup.jsp"%>
	<%@include file="../biz/board/view_modal.jsp"%>
	<%@include file="../biz/fileForm/fileUpload_modal.jsp"%>
	
	
	<script>
	//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
	app.controller('angular_controller', ['$scope','$controller','$log','StudentService', 
	function ($scope,$controller,$log,StudentService) {		//$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
		var vm = this; 										//this를 vm에 대입, 아래에서 부모의 $scope를 vm에 추가하기 위해 			
		angular.extend(vm, $controller('CodeCtrl',{ 		//CodeCtrl(ui-grid 커스텀 api)를 상속받는다
			$scope : $scope									// 자식컨트롤러의 vm에 부모 컨트롤러의 $scope를 합, 이로써 자식 컨트롤러에서 부모의 모든 $scope(this)를 사용 할 수 있음			
		}));	
		
		$scope.fileDropZone = angular.element("#attachFileTable").fileDropDown({
			areaOpen : true,
			fileSizeLimits : '<spring:eval expression="@config['file.fileSizeLimits']"/>',
			totalfileSizeLimits : '<spring:eval expression="@config['file.totalfileSizeLimits']"/>'
		});
		$scope.fileDropZone.setDropZone();
		
		$("#multifileselect").change(function(){
			$scope.fileDropZone.selectFile($("#multifileselect").get(0).files);
		})
		
		
		$scope.gridOptions = vm.gridOptions({});  
		
															
	}]);
	//복붙영역(앵귤러단) 끝
	
</script>

<script>
$(document).ready(function(){
	//공지게시판 팝업
	// board의 popup_yn컬럼 값이 "Y"가 존재하는지 판단
	var scope = angular.element(document.getElementById("angular_body")).scope(); //html id를 통해서 controller scope(this) 가져옴
	
	var data = [{name : '${_csrf.parameterName}', value : '${_csrf.token}'}];
	
	/* 팝업게시글 존재하면 띄워주기 */
	//2019-08-18 smh 공지사항 시작
	if(getCookie("not_see_popup")!="Y"){
		//팝업 게시글이 존재할때
		if(${popupNum}>0){
			//파일리스트 보여주기
			$.ajax({
					type: 'POST',
					url: '/biz/ICMFileList',
					data: {attach_no : '${popupData.attach_no}',
						'${_csrf.parameterName}' : '${_csrf.token}'},
					dataType: 'json',
					async : false,
					success: function(data){
						var file_list = data.files;
						
						$("#board_view_popup_modal_files").fileListSelectDown(file_list);
					},
			        complete: function(){}
			});
			
			//파일첨부 운영자만 모달 삭제버튼 보여주기
			/* if("${s_authogrp_code}"=="00"){
				$(".attachDeleteBtn").css("display", "");
			}else{
				$(".attachDeleteBtn").css("display", "none");
			}	 */
			
			//2019-08-18 smh 팝업모달 띄우기
			var $popupModal = $("#popupModal");
			$popupModal.modal({
				backdrop : 'static',
				keyboard: false
			});
		}
	}
	
	//재무관리 이동
	$("#zfi_btn").on("click", function() {
		f_href_with_auth("/yp/zfi/doc/zfi_doc_list", "000001");
	});
	//구매관리 이동
	$("#zmm_btn").on("click", function() {
		f_href_with_auth("/yp/zmm/raw/zmm_raw_schedule_read", "000002");
	});
	// 인사관리 이동
	$("#zhr_btn").on("click", function() {
		f_href_with_auth("/yp/zhr/tna/zhr_tna_ot_create", "000003");
	});
	// 생산관리 이동
	$("#zpp_btn").on("click", function() {
		return false;
	});
	// 조업도급관리 이동
	$("#zwc_btn").on("click", function() {
		f_href_with_auth("/yp/zwc/ipt/zwc_ipt_daily_create", "000005");
	});
	// 정비용역관리 이동
	$("#zcs_btn").on("click", function() {
		f_href_with_auth("/yp/zcs/ctr/zcs_ctr_manh_create", "000006");
	});
	
	// 로그아웃
	$("#logout_btn").on("click", function() {
		f_href("/yp/login/logout", {});
	});
	
	// 메뉴에 대한 권한 체크후 화면이동
	
	
	
});
function f_href_with_auth(url, hierarchy){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajax({
		url : "/yp/login/f_href_with_auth",
		type : "post",
		cache : false,
		async : true,
		data : {
			URL : url
		},
		dataType : "json",
		success : function(result) {
			if (result.code > 0) {
				f_href(url, {hierarchy : hierarchy});
			} else {
				swalWarningCB("권한이 없습니다.\n관리자에게 문의해주세요.");
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
			swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
		}
	});
}

function go_board(e){
	var $this = $(e);
	var board_no = $this.data("board_no");
	var created_by = $this.data("created_by");
	var attach_no = $this.data("attach_no");
	var emp_code = "${emp_code}";
	//게시글 작성자는 해당 페이지로 이동
	if(created_by == emp_code){
		f_href("/biz/board", {board_no: board_no, hierarchy : "000007"});
	//작성자가 아니라면 view 팝업창 띄워주기
	}else{
		//파일리스트 보여주기
		$.ajax({
				type: 'POST',
				url: '/biz/ICMFileList',
				data: {attach_no : attach_no,
					'${_csrf.parameterName}' : '${_csrf.token}'},
				dataType: 'json',
				async : false,
				success: function(data){
					var file_list = data.files;
					
					$("#board_view_modal_files").fileListSelectDown(file_list);
					
					open_board_detail(board_no);
				},
		        complete: function(){}
		});
	}
	
	
}

function open_board_detail(board_no){
	//공지게시판 팝업
	// board의 popup_yn컬럼 값이 "Y"가 존재하는지 판단
	var scope = angular.element(document.getElementById("angular_body")).scope(); //html id를 통해서 controller scope(this) 가져옴
	
	$.ajax({
		type: 'POST',
		url: '/biz/board/boardDetailMain',
		data: {board_no : board_no,
			'${_csrf.parameterName}' : '${_csrf.token}'},
		dataType: 'json',
		async : false,
		success: function(data){
			$("#view_title").html(data.title);
			$("#view_content").html(data.content);
			$("#view_creation_date").html(data.creation_date);
			$("#view_created_by_name").html(data.created_by_name);
			
			//파일드롭다운하는 모달 세팅
			/* scope.fileDropZone.fileListLoad({
				url : "/biz/ICMFileList",
				param : {attach_no : (data==null)?null : data.attach_no, 
						'${_csrf.parameterName}' : '${_csrf.token}'}
			}); */
		},
        complete: function(){}
	});
	
	//파일첨부 운영자만 모달 삭제버튼 보여주기
	if("${s_authogrp_code}"=="100"){
		$(".attachDeleteBtn").css("display", "");
	}else{
		$(".attachDeleteBtn").css("display", "none");
	}			
	
	var $vieweModal = $("#viewModal");
	$vieweModal.modal({
		backdrop : 'static',
		keyboard: false
	});
}
	
	
</script>
</body>


