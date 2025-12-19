<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<title>중복로그인</title>
	<link id="bs-css" href="/resources/icm/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="/resources/icm/css/jquery-ui.css" />

	<script>
	$(document).ready(function(){
		swal({
			  icon : "warning",
			  text: "다른 위치에서 사용중인 계정 입니다.\n 시스템에서 로그아웃 처리 됩니다.",
			  closeOnClickOutside : false,
			  closeOnEsc : false,
			  buttons: {
					confirm: {
					  text: "확인",
					  value: true,
					  visible: true,
					  className: "",
					  closeModal: true
					}
			  }
			})
			.then(function(result){
				location.href="/";
			});
	});
	</script>

	
</body>