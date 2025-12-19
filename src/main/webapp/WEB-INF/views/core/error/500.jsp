<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page" %>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

	<title>500 Error</title>

	<!-- Google font -->
<!-- 	<link href="https://fonts.googleapis.com/css?family=Nunito:400,700" rel="stylesheet"> -->
	<link href="/resources/icm/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Custom stlylesheet -->
	<link type="text/css" rel="stylesheet" href="/resources/colorlib-error-404-18/css/style.css" />

	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->

	<!-- The fav icon -->
    <link rel="shortcut icon" href="/favicon_vit.ico">
</head>

<body>

	<div id="notfound">
		<div class="notfound">
			<div class="notfound-404"></div>
			<h1>500</h1>
			<h2>서버에서 요청을 처리할 수 없습니다.</h2>
			<p>요청 처리 과정에서 예외가 발생했습니다. 뒤로가기나 다시 로그인을 통해 재 요청 해주십시오.<br>해당 증상이 지속 될 시 관리자에게 문의 바랍니다.</p>
			<a href="javascript:history.back();">뒤로가기</a>&emsp;&emsp;
			<a href="javascript:location.replace('/yp/login/login')">로그인 페이지</a>
		</div>
	</div>

</body><!-- This templates was made by Colorlib (https://colorlib.com) -->

</html>
