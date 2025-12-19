<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
if (request.getProtocol().equals("HTTP/1.1"))
	response.setHeader("Cache-Control", "no-cache");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
<script type="text/javascript">
	var type = "yp";
	$(document).ready(function() {
		// 엔터키 이벤트
		$(".enter_event").on("keyup", function(e) {
			if(e.which === 13){
				$("#login_btn").trigger("click");
			}
		});
		
		// 로그인
		$("#login_btn").on("click", function() {
			if("" === $("#id").val().trim()){
				swalWarningCB("로그인 정보가 일치하지 않습니다.", function(){
					$("#id").focus();
				});
				return false;
			}
			if("" === $("#password").val().trim()){
				swalWarningCB("로그인 정보가 일치하지 않습니다.", function(){
					$("#password").focus();
				});
				return false;
			}
			if($('#remember_id').is(':checked')){
				$.cookie('saved_id', $('#id').val(), { expires: 365, path: "/yp/login/" });
			}else{
				$.cookie('saved_id', null, { expires: -1, path: "/yp/login/" });
			}
			
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				url : "/yp/login/loginCheck",
				type : "post",
				cache : false,
				async : true,
				data : {
					id : $("#id").val(),
					password : $("#password").val(),
					type : type
				//yp, aff, ent, (vicurus)
				},
				dataType : "json",
				success : function(result) {
					if(result.code > 0){
						location.href="/";
					}else if(result.code === -99){
						swalWarningCB(result.msg, function(){
							var form    = document.createElement("form");
							var input1   = document.createElement("input");
							input1.name  = "ADMIN_ID";
							input1.value = $('#id').val();
							input1.type  = "hidden";
							
							var popupW = 500;
							var popupH = 300;
							var popupX = (window.screen.width / 2) - (popupW / 2);
							var popupY = (window.screen.height /2) - (popupH / 2);
							window.open("","pwd_reset","width=500,height=300,left="+popupX+",screenX="+popupX+",top="+popupY+",screenY="+popupY+",scrollbars=yes");
							
							form.method = "post";
							form.target = "pwd_reset"
							form.action = "/yp/popup/login/pwd_reset";
							
							form.appendChild(input1);
							document.body.appendChild(form);
							
							form.submit();
							form.remove();
						});
					}else{
						swalWarning(result.msg);
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
			
// 			f_href("/yp/login/loginCheck", {
// 				id : $("#id").val(),
// 				password : $("#password").val(),
// 				type : type
// 			//yp, aff, ent, (vicurus)
// 			});
		});

		// 계열사 선택
		$(".group").children().on("click", function() {
			$(".group").children().removeClass("on");
			$(this).addClass("on");
			type = $(this).data("type");
		});
		
		$('#remember_id').click(function(){
			if($('#remember_id').is(':checked')){
				$.cookie('saved_id', $('#id').val(), { expires: 365, path: "/yp/login/" });
			}else{
				$.cookie('saved_id', null, { expires: -1, path: "/yp/login/" });
			}
		});
		
		if(typeof $.cookie('saved_id') === "undefined"){
			$('#id').val("");
			$('#remember_id').removeAttr("checked");
			$('#id').focus();
		}else{
			$('#id').val($.cookie('saved_id'));
			$('#remember_id').attr("checked", "checked");
			$('#password').focus();
		}
	});
</script>
</head>
<body>
	<!-- 20191023_khj for csrf -->
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<div id="wrapper">
		<div class="login_img"></div>
		<div class="login_wrap">
			<div class="login_box">
				<img src="/resources/yp/images/login_img.png">
				<p>
					<img src="/resources/yp/images/logo_sub.png">영풍 디지털 시스템
				</p>
				<ul class="group">
					<li class="on" data-type="yp">영풍</li>
					<li data-type="aff">계열사</li>
					<li data-type="ent">협력사</li>
				</ul>
				<ul>
					<li>
						<input type="text" name="id" id="id" placeholder="User ID" class="login enter_event">
					</li>
					<li>
						<input type="password" name="password" id="password" placeholder="Password" class="login enter_event">
					</li>
					<li>
						<button class="btn_login" id="login_btn">LOGIN</button>
					</li>
					<li class="rt">
						<input type="checkbox" id="remember_id">
						Save ID
					</li>
				</ul>
			</div>
			<div class="copyright">Copyright (c) Young Poong All rights reserved.</div>
		</div>
	</div>
</body>