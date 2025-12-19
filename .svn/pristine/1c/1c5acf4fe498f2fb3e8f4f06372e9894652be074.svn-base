<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=1">
<sec:csrfMetaTags />
<title>영풍 디지털 시스템 - <decorator:title default=""></decorator:title></title>
<!-- The fav icon -->
<link rel="icon" href="/resources/yp/favicon.ico">
<link rel="icon" href="/resources/yp/favicon-16x16.png" sizes="16x16">
<link rel="icon" href="/resources/yp/favicon-32x32.png" sizes="32x32">
<!-- <link rel="stylesheet" href="/resources/icm/main/css/login.css" /> -->
<!-- <link rel="stylesheet" href="/resources/css/common.css"> -->
<link rel="stylesheet" href="/resources/yp/css/style.css">
<script src="/resources/icm/js/jquery.js"></script>
<script src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
<script src="/resources/icm/js/custom.js"></script>
<!-- 20191024_khj RSA security -->
<script src="/resources/icm/secu/js/jsbn.js"></script>
<script src="/resources/icm/secu/js/prng4.js"></script>
<script src="/resources/icm/secu/js/rng.js"></script>
<script src="/resources/icm/secu/js/rsa.js"></script>
<script src="/resources/yp/js/jquery.cookie.js"></script>
<script type="text/javascript">
	/*
	 url: 이동시킬 주소
	 pr: json 형태의 넘길 파라미터
	 */
	function f_href(url, pr) {
		//20191023_khj for csrf
		var csrf_element = document.createElement("input");
		csrf_element.name = "_csrf";
		csrf_element.value = "${_csrf.token}";
		csrf_element.type = "hidden";
		//20191023_khj for csrf
		var form = document.createElement("form");

		form.setAttribute("method", "post");
		form.setAttribute("action", url);
		document.body.appendChild(form);

		form.appendChild(csrf_element);

		$.each(pr, function(k, v) {
			console.log(k, v);
			var el = document.createElement("input");
			el.name = k;
			el.value = v;
			el.type = "hidden";
			form.appendChild(el);
		});

		form.submit();
		form.remove();
	}
</script>
<decorator:head />
</head>
<body>
	<decorator:body />
</body>
</html>