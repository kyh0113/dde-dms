<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String userName = (String) request.getSession().getAttribute("userName");	//성명
	String userPos  = (String) request.getSession().getAttribute("userPos")  == null ? "" : (String) request.getSession().getAttribute("userPos") ;	//직급
	String userDept = (String) request.getSession().getAttribute("userDept") == null ? "" : (String) request.getSession().getAttribute("userDept");	//부서
	String fullName = "";
	if(!userDept.isEmpty() && !userPos.isEmpty()) fullName = userDept + " / " + userPos + " / " + userName;
	else fullName = userName;
%>
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
<script src="/resources/icm/js/jquery.js"></script>
<script src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
<script src="/resources/icm/js/custom.js"></script>
<!-- 20191024_khj RSA security -->
<script src="/resources/icm/secu/js/jsbn.js"></script>
<script src="/resources/icm/secu/js/prng4.js"></script>
<script src="/resources/icm/secu/js/rng.js"></script>
<script src="/resources/icm/secu/js/rsa.js"></script>
<!-- 기존 프레임워크 리소스 -->
<!-- 2019-08-13 smh 시작. smartEditor -->
<script type="text/javascript" src="/resources/js/se/js/HuskyEZCreator.js" charset="utf-8"></script>
<!-- 	<script type="text/javascript" src="/resources/js/se/SmartEditor2.html"></script> -->
<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
<!-- 2019-08-13 smh 끝. -->
<link rel="stylesheet" type="text/css" href="/resources/icm/css/jquery-ui.css" />
<!-- 	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> -->
<!-- 2019-12-13 smh jquery-ui.css 변경.끝 -->
<link href='/resources/icm/css/animate.min.css' rel='stylesheet'>
<link rel="stylesheet" type="text/css" href="/resources/css/custom.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/all.min.css" />
<link rel="stylesheet" href="/resources/icm/jsTree/dist/themes/default/style.min.css" />
<link href="/resources/icm/datepicker/css/datepicker.css" rel="stylesheet" type="text/css" />
<link id="bs-css" href="/resources/icm/css/bootstrap.min.css" rel="stylesheet">
<!-- jQuery -->
<script src="/resources/icm/js/jquery.js"></script>
<script src="/resources/icm/js/jquery.validate.min.js"></script>
<script src="/resources/icm/js/jquery-ui.js"></script>
<script src="/resources/icm/jsTree/dist/jstree.min.js"></script>
<script src="/resources/icm/jsTree/dist/customJstree.js"></script>
<link rel="stylesheet" href="/resources/icm/uigrid/css/ui-grid.min.css" type="text/css">
<script src="/resources/icm/js/custom.js"></script>
<script src="/resources/icm/js/multiFile.js"></script>
<script src="/resources/icm/js/fileList.js"></script>
<script src="/resources/icm/angular/js/angular.min.js"></script>
<script src="/resources/icm/angular/js/angular-route.min.js"></script>
<script src="/resources/icm/uigrid/js/ui-grid.min.js"></script>
<script src="/resources/icm/uigrid/js/ui-grid.language.ko.js"></script>
<!-- 2019-08-15 smh 추가 시작.-->
<!-- 	<script src="/resources/js/jquery.vicurusit.js"></script> -->
<!-- 2019-08-15 smh 추가 끝-->
<script src="/resources/icm/uigrid/js/uiGrid1.js"></script>
<script src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
<script src="/resources/icm/datepicker/js/bootstrap-datepicker.js"></script>
<script src="/resources/icm/jsTree/dist/customJstree.js"></script>
<!-- chart.js -->
<script src="/resources/Chart.js-2.7.2/dist/Chart.bundle.js"></script>
<script src="/resources/Chart.js-2.7.2/dist/Chart.bundle.min.js"></script>
<script src="/resources/Chart.js-2.7.2/dist/Chart.js"></script>
<script src="/resources/Chart.js-2.7.2/dist/Chart.min.js"></script>
<script src="/resources/Chart.js-2.7.2/dist/chartjs-plugin-datalabels.js"></script>
<script src="/resources/Chart.js-2.7.2/dist/utils.js"></script>
<!-- 20191024_khj RSA security -->
<script src="/resources/icm/secu/js/jsbn.js"></script>
<script src="/resources/icm/secu/js/prng4.js"></script>
<script src="/resources/icm/secu/js/rng.js"></script>
<script src="/resources/icm/secu/js/rsa.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/font/ng.css">
<link rel="stylesheet" type="text/css" href="/resources/css/style.css">
<script type="text/javascript" src="/resources/js/ui.js"></script>
<!-- 20191227_khj Tooltip Add -->
<script src="/resources/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="/resources/icm/js/bootstrap.min.js"></script>
<!-- application script for Charisma demo -->
<script src="/resources/icm/js/charisma.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
<!-- 기존 프레임워크 리소스 -->
<!-- 영풍 리소스 -->
<script src="/resources/yp/js/common.js"></script>
<style type="text/css">
/* 로딩바 관련 */
.wrap-loading { /* background darkness*/
	position: fixed;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	background: rgba(0, 0, 0, 0.2); /*not in ie */
	filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000', endColorstr='#20000000'); /* ie */
	z-index: 9000;
}

.wrap-loading div { /*loading img*/
	position: fixed;
	top: 50%;
	left: 50%;
	margin-left: -21px;
	margin-top: -21px;
	z-index: 9000;
}

.display-none { /*loading_bar hidden*/
	display: none;
}

/* ui-grid header-align CENTER */
.ui-grid-header-cell{text-align:center !important;}
.ui-grid-header-cell-label.ng-binding{margin-left:1.2em;}
</style>
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

	// 메뉴 확대(선택메뉴)
	function show_menu(menu_id) {
		hideLayer();
		$("#" + menu_id).prop("checked", true);
	}

	// 메뉴 확대(전체메뉴)
	function viewLayer() {
		// 		$('#gnb_nav > ul').children().show();
		// 		document.getElementById("gnb_nav").style.visibility = "visible";
		document.getElementById("gnb").style.visibility = "visible";
		document.getElementById("gnb_nav").style.visibility = "hidden";
		document.getElementById("closeNav").style.marginLeft = "140px";
		grid_resize();
	}

	// 메뉴 축소
	function hideLayer() {
		// 		document.getElementById("gnb_nav").style.visibility = "hidden";
		document.getElementById("gnb").style.visibility = "hidden";
		document.getElementById("gnb_nav").style.visibility = "visible";
		document.getElementById("closeNav").style.marginLeft = "250px";
		grid_resize();
	}

	function grid_resize(){
		var $grid = $(".ui-grid");
		if($grid.length > 0){
			var grid_scope = angular.element($grid).scope(); 
			setTimeout(function() {grid_scope.gridApi.grid.refresh();},100);
		}
	}

	$(document).ready(function() {
		// 홈 이동
		$("#home_btn").on("click", function() {
			f_href("/yp/main", {});
		});

		// 로그아웃
		$("#logout_btn").on("click", function() {
			f_href("/yp/login/logout", {});
		});
		
		//Grid 필터
		$(".ui-grid-icon-container").on('click', function(evnet){
			var target_id = $(this).parents("div").parents("div").parents("div").parents("div").parents("div")[0].id; 
			var target_scope = angular.element(document.getElementById(target_id)).scope();
			target_scope.gridOptions.enableFiltering = !target_scope.gridOptions.enableFiltering;
			target_scope.gridApi.core.notifyDataChange( target_scope.uiGridConstants.dataChange.COLUMN );
		})

		// 아이콘 메뉴 출력
		<c:set var="menu_seq" value="0" />
		<c:forEach var="topmenu" items='${menu.topmenu}' varStatus='status'>
		<c:if test="${topmenu.menu_level eq '1' and topmenu.type eq 'Y'}">
		<c:set var="menu_seq" value="${menu_seq + 1}" />
		<c:choose>
		<c:when test="${menu_seq eq 1}">
		$(".gnb ul").append('<li onclick="javascript: show_menu(\'_${topmenu.hierarchy}\');"><a href="javascript:void(0);"><img src="/resources/yp/images/gnb_ic_money.png"><p>${topmenu.menu_name}</p></a></li>');
		</c:when>
		<c:when test="${menu_seq eq 2}">
		$(".gnb ul").append('<li onclick="javascript: show_menu(\'_${topmenu.hierarchy}\');"><a href="javascript:void(0);"><img src="/resources/yp/images/gnb_ic_buy.png"><p>${topmenu.menu_name}</p></a></li>');
		</c:when>
		<c:when test="${menu_seq eq 3}">
		$(".gnb ul").append('<li onclick="javascript: show_menu(\'_${topmenu.hierarchy}\');"><a href="javascript:void(0);"><img src="/resources/yp/images/gnb_ic_person.png"><p>${topmenu.menu_name}</p></a></li>');
		</c:when>
		<c:when test="${menu_seq eq 4}">
		$(".gnb ul").append('<li onclick="javascript: show_menu(\'_${topmenu.hierarchy}\');"><a href="javascript:void(0);"><img src="/resources/yp/images/gnb_ic_report.png"><p>${topmenu.menu_name}</p></a></li>');
		</c:when>
		<c:when test="${menu_seq eq 5}">
		$(".gnb ul").append('<li onclick="javascript: show_menu(\'_${topmenu.hierarchy}\');"><a href="javascript:void(0);"><img src="/resources/yp/images/gnb_ic_work.png"><p>${topmenu.menu_name}</p></a></li>');
		</c:when>
		<c:when test="${menu_seq eq 6}">
		$(".gnb ul").append('<li onclick="javascript: show_menu(\'_${topmenu.hierarchy}\');"><a href="javascript:void(0);"><img src="/resources/yp/images/gnb_ic_factory.png"><p>${topmenu.menu_name}</p></a></li>');
		</c:when>
		<c:otherwise>
		$(".gnb ul").append('<li onclick="javascript: show_menu(\'_${topmenu.hierarchy}\');"><a href="javascript:void(0);"><img src="/resources/yp/images/gnb_ic_factory.png"><p>${topmenu.menu_name}</p></a></li>');
		</c:otherwise>
		</c:choose>
		</c:if>
		</c:forEach>
		<c:remove var="menu_seq" />
		// 메뉴 출력

		// 1레벨
		<c:forEach var="topmenu" items='${menu.topmenu}' varStatus='status'>
		<c:if test="${topmenu.menu_level eq '1'}">
		<c:choose>
		<c:when test="${topmenu.type eq 'Y'}">
		$(".mn_container").append(
			'<div class="mn_item">' +
			'	<input id="_${topmenu.hierarchy}" name="gnb" type="radio" <c:if test="${hierarchy eq topmenu.hierarchy}">checked="checked"</c:if> /> <label for="_${topmenu.hierarchy}">${topmenu.menu_name}</label>' +
			'	<article class="mn_sub">' +
			'		<ul id="${topmenu.menu_id}"></ul>' +
			'	</article>' +
			'</div>'
		);
		</c:when>
		</c:choose>
		</c:if>
		</c:forEach>
		
		// 2레벨
		<c:forEach var="leftmenu" items='${menu.leftmenu}'>
		<c:set var="menu_path" value ="${leftmenu.menu_path}" />
		<c:if test="${leftmenu.menu_level eq '2'}" >
		<c:choose>
		<c:when test="${menu_path eq null || menu_path == '' || menu_path == '/'}">
		$("#${leftmenu.upmenu_id}").append('<li><a href="javascript:void(0);">${leftmenu.menu_name}</a></li><ul class="gnb_3lv" id="${leftmenu.menu_id}"></ul>');
		</c:when>
		<c:otherwise>
		$("#${leftmenu.upmenu_id}").append('<li><a href="javascript:void(0);" class="ajax-link" style="display: inline-block; width: 100%;" data-hierarchy="${leftmenu.hierarchy}" data-upmenu-id="${leftmenu.upmenu_id}" data-menu-id="${leftmenu.menu_id}" data-url="${leftmenu.menu_path}">${leftmenu.menu_name}</a></li>');
		</c:otherwise>
		</c:choose>
		</c:if>
		</c:forEach>

		// 3레벨
		<c:forEach var="submenu" items='${menu.submenu}'>
		<c:set var="menu_path" value ="${submenu.menu_path}" />
		<c:if test="${submenu.menu_level eq '3'}" >
		<c:choose>
		<c:when test="${menu_path eq null || menu_path == '' || menu_path == '/'}">
		$("#${submenu.upmenu_id}").append('<li><a href="javascript:void(0);">${submenu.menu_name}</a></li>');
		</c:when>
		<c:otherwise>
		$("#${submenu.upmenu_id}").append('<li><a href="javascript:void(0);" class="ajax-link" style="display: inline-block; width: 100%;" data-hierarchy="${submenu.hierarchy}" data-upmenu-id="${submenu.upmenu_id}" data-menu-id="${submenu.menu_id}" data-url="${submenu.menu_path}">${submenu.menu_name}</a></li>');
		</c:otherwise>
		</c:choose>
		</c:if>
		</c:forEach>
	});
</script>
<decorator:head />
</head>
<body class="bg_gray">
	<div id="wrap-loading" class="wrap-loading display-none">
		<div>
			<img src="/resources/images/ajax-loader.gif" />
		</div>
	</div>
	<!-- wrapper S -->
	<div id="wrapper">
		<div class="header">
			<div class="logo">
				<a href="javascript:void(0);" id="home_btn"><img style="vertical-align:top;" src="/resources/yp/images/logo_sub.png"> 영풍 디지털 시스템</a>
				<p style="font-size:14px; margin-left:80px; margin-top:-20px;">YP Digital System</p>
			</div>
			<div class="top_ic">
				<ul>
					<li>
						<%=fullName%><a href="javascript:void(0);"><img src="/resources/yp/images/topic_logout.png"></a>
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
		<div class="content_body">
			<!-- gnb S -->
			<div id="gnb" class="gnb">
				<ul>
					<li>
						<a href="javascript:void(0);" onclick="hideLayer('gnb')"> <img src="/resources/yp/images/gnb_ic_menu.png">
							<p>전체메뉴</p>
						</a>
					</li>
				</ul>
			</div>
			<!-- gnb E -->
			<!-- gnb_nav S -->
			<div id="gnb_nav">
				<div class="mn_container">
					<div class="mn_icon">
						<a href="javascript:void(0);" onclick="viewLayer('gnb')"><img src="/resources/yp/images/gnb_ic_menu.png"></a>
					</div>
				</div>
				<!-- gnb_nav E -->
			</div>
			<!-- contents box S -->
			<!-- 			<div class="sub_contents_box" data-ng-app="app" style="width: 1760px;"> -->
			<div class="sub_contents_box" data-ng-app="app" id="closeNav">
				<div class="sub_contents">
					<decorator:body />
				</div>
			</div>
			<!-- contents box E -->
			<!-- wrapper E -->
		</div>
</body>
</html>