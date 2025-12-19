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
<title>작업표준서 상세조회</title>
<script>
	$(document).ready(function() {
		$.ajax({
			url : "/yp/zpp/wsd/wsd_view_link",
			type : "POST",
// 			processData: false,
//          contentType: false,
			data : $("#frm").serialize(),
			dataType : "json",
			success : function(result) {
				$("iframe").attr("src",result.PDF_URL + result.PDF_NAME);
			},
			error : function(request, status, error) {
				console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
			}
		});

		$("#reg_btn").click(function() {
			fnUpdPop();
		});
		
		$("#excel_btn").click(function() {
			fnExelDown();
		});
		
		/*
		kjy 2022.12.29 조회버튼 추가 -> 버전별 조회 가능
		*/
		$("#search_btn").click(function(){
			$.ajax({
				url : "/yp/zpp/wsd/wsd_view_link",
				type : "POST",
//	 			processData: false,
//	          contentType: false,
				data : $("#frm").serialize(),
				dataType : "json",
				success : function(result) {
					$("iframe").attr("src",result.PDF_URL + result.PDF_NAME);
				},
				error : function(request, status, error) {
					console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
				}
			});
		});

		
	});
	

	
	//등록 팝업
	function fnUpdPop(){
		$("#frm").attr("target","wsd_update");
		$("#frm").attr("action","/yp/popup/zpp/wsd/zpp_wsd_update");
		window.open("","wsd_update","scrollbars=no,width=400,height=500");

		$("#frm").submit();
	}
	
	function fnExelDown(){
		$("#frm").attr("action", "/yp/zpp/wsd/zpp_wsd_download");
		$("#frm").submit();
		$('.wrap-excelloading').removeClass('display-none');
		setTimeout(function() {
		  $('.wrap-excelloading').addClass('display-none');
		},5000); //5초
	}
</script>
</head>
<body>
	<h2>
		작업표준서 상세조회
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
			<form name="frm" id="frm" method="post">
			<table cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="10%" />
					<col width="30%" />
					<col width="10%" />
					<col width="30%" />
					<col width="" />
				</colgroup>
				<tr>
					<th>문서버전</th>
					<td>
						<select name="version">
							<c:forEach var="data" items="${vlist}">
<%-- 					        	<option value="${data.VERSION}" >Rev.${data.VERSION}<c:if test="${data.GW_EDOC_STATUS ne 'F'}">(결재미완료)</c:if></option> --%>
								<option value="${data.VERSION}" >Rev.${data.VERSION}</option>
					        </c:forEach>
						</select>
					</td>
					<th></th>
					<td>
						<input type="hidden" name="code" value="${req_data.code}"/>
						<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
					</td>	
			</table>
			</form>
			<div class="btn_wrap">
				<button class="btn btn_make" id="excel_btn">엑셀 다운로드</button>
				<c:if test="${'MA' eq sessionScope.s_authogrp_code || 'SA' eq sessionScope.s_authogrp_code || 'WM' eq sessionScope.s_authogrp_code}">
				<button class="btn btn_save" id="reg_btn">문서 갱신</button>
				<button class="btn btn_search" id="search_btn">조회</button>
				</c:if>			
			</div>
		</div>
	</section>
	<section class="section">
<!-- 		<div style="width:auto;height:auto;"> -->
			<iframe frameborder="0" width="100%" height="820px" src=""></iframe>
<!-- 		</div> -->
	</section>
	
</body>