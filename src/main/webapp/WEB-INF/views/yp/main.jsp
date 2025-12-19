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

	String userName = (String) request.getSession().getAttribute("userName");	//성명
	String userPos  = (String) request.getSession().getAttribute("userPos")  == null ? "" : (String) request.getSession().getAttribute("userPos") ;	//직급
	String userDept = (String) request.getSession().getAttribute("userDept") == null ? "" : (String) request.getSession().getAttribute("userDept");	//부서
	String fullName = "";
	if(!userDept.isEmpty() && !userPos.isEmpty()) fullName = userDept + " / " + userPos + " / " + userName;
	else fullName = userName;
%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>메인</title>
	<style type="text/css">
	ul { margin-bottom: 0; }
	</style>
</head>
<body>
	<!-- 20191023_khj for csrf -->
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<div id="wrapper" class="m_bg">
		<!-- top S -->
		<div class="m_header">
			<div class="top_ic">
				<ul>
					<li>
						<%=fullName%>
						<a href="javascript:void(0);"><img src="/resources/yp/images/topic_logout.png"></a>
						<div class="topnav_my">
							<ul>
								<li><a href="javascript:void(0);" id="logout_btn">로그아웃</a></li>
							</ul>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<!-- top E -->
		<div class="m_menu_wrapper">
			<div class="flex_container">
				<div class="motor">
                    <span class="m_logo"><img src="/resources/yp/images/logo_sub.png"> 영풍 디지털 시스템</span>
                    YP Digital System
                    <span class="m_text space20">정확한 Data 가 Digital way 로 가는 길입니다.</span>
                </div>
				<ul class="m_menu_item">
					<li class="m_menu_finance">
						<a href="javascript:void(0);" id="zfi_btn">
							<span>재무관리<p class="m_menu_sname">FINANCIAL AFFAIRS</p></span>
						</a>
					</li>
					<li class="m_menu_purchase">
						<a href="javascript:void(0);" id="zmm_btn">
							<span>물류관리<p class="m_menu_sname">DISTRIBUTION</p></span>
						</a>
					</li>
					<li class="m_menu_personnel">
						<a href="javascript:void(0);" id="zhr_btn">
							<span>인사관리<p class="m_menu_sname">PERSONNEL</p></span>
						</a>
					</li>
					<li class="m_menu_product">
						<a href="javascript:void(0);" id="zpp_btn">
							<span>생산관리<p class="m_menu_sname">PRODUCTION</p></span> 
						</a>
					</li>
					<li class="m_menu_subcontract">
						<a href="javascript:void(0);" id="zwc_btn">
							<span>조업도급<p class="m_menu_sname">SUBCONTRACT</p></span>
						</a>
					</li>
					<li class="m_menu_maintain">
						<a href="javascript:void(0);" id="zcs_btn">
							<span>정비용역<p class="m_menu_sname">MAINTAIN SERVICE</p></span>
						</a>
					</li>
					<li class="m_menu_community">
						<a href="javascript:void(0);" id="board_btn">
							<span>게시판<p class="m_menu_sname">COMMUNITY</p></span>
<!-- 							<span>전산작업<p class="m_menu_sname">ITSM</p></span> -->
						</a>
					</li>

				</ul>
			</div>
		</div> 
	</div>
	
	<%@include file="../biz/board/popup.jsp"%>
	<%@include file="../biz/board/view_modal.jsp"%>
	<%@include file="../biz/fileForm/fileUpload_modal.jsp"%>
	
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
			if("${popupNum}" > 0){
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
			f_href_with_auth("/yp/zmm/aw/zmm_weight_list", "000002");
		});
		// 인사관리 이동
		$("#zhr_btn").on("click", function() {
			f_href_with_auth("/yp/zhr/rez/zhr_rez_list", "000003");
		});
		
		// 도시락메뉴중단 myeongjin 20250829
//		$("#zhr_btn").on("click", function() {
//			f_href_with_auth("/yp/zhr/lbm/zhr_lbm_create", "000003");
//		});
		
		// 생산관리 이동
// 		$("#zmm_btn").on("click", function() {
// 			//alert("오픈 준비중");
// 			f_href_with_auth("/yp/zpp/wsd/zpp_wsd_list", "000004");
// 			return false;
// 		});
		// 생산관리 이동
		$("#zpp_btn").on("click", function() {
			//alert("오픈 준비중");
			/**
			 * [2022-08-26 smh] 작업/검수 표준서 바로 이동 
			 */
			f_href_with_auth("/yp/zpp/wsd/zpp_wsd_list", "000004");
			/**
			 * [KSH-2022.07.07] url이동 생성
			 * [2022-08-26 smh] 운영에 캐소드 블렌딩 관련 테이블이 없으므로 해당 url 주석처리
			 */
			//f_href("/yp/zpp/ctd/zpp_ctd_dashboard", {hierarchy : "000004"});
			//return false;
		});
		// 조업도급관리 이동
		$("#zwc_btn").on("click", function() {
			if("${sessionScope.s_authogrp_code}" === "CC"){ // 협력업체는 
				f_href_with_auth("/yp/zwc/ent/zwc_ent_actl_list", "000005");
			}else if("${sessionScope.s_authogrp_code}" === "SC"){// 보안관리자
				f_href_with_auth("/yp/zwc/ent/zwc_ent_actl_list", "000005");	
			}else if("${sessionScope.s_authogrp_code}" === "SCM"){// 보안관리자 마스터
				f_href_with_auth("/yp/zwc/ent/zwc_ent_list", "000005");	
			}else{
				f_href_with_auth("/yp/zwc/ipt/zwc_ipt_daily_create", "000005");
			}
		});
		// 정비용역관리 이동
		$("#zcs_btn").on("click", function() {
			f_href_with_auth("/yp/zcs/ipt/zcs_ipt_process_list", "000006");
		});
		
// 		// 게시판 이동
 		$("#board_btn").on("click", function() {
 			f_href_with_auth("/biz/board", "000007");
 		});

		//전산작업
//		$("#board_btn").on("click", function() {
//			f_href_with_auth("/yp/wr/wr_list", "000010");
//		});
		
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
				f_href(url, {hierarchy : hierarchy});
				
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
	</script>
</body>