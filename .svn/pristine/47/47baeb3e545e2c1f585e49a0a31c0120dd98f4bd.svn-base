<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%
String sabun = request.getSession().getAttribute("s_emp_code") == null ? "" : request.getSession().getAttribute("s_emp_code").toString();
String s_emp_name = request.getSession().getAttribute("s_emp_name") == null ? "" : request.getSession().getAttribute("s_emp_name").toString();
if("".equals(sabun)){
	response.sendRedirect("/");
}
String current_date = request.getAttribute("current_date")==null?"": (String)request.getAttribute("current_date");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=0.8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<sec:csrfMetaTags />
<title><decorator:title default="VIT FRAMEWORK" /></title>
	
	<!-- 2019-08-13 smh 시작. smartEditor -->
	<script type="text/javascript" src="/resources/js/se/js/HuskyEZCreator.js" charset="utf-8"></script>
<!-- 	<script type="text/javascript" src="/resources/js/se/SmartEditor2.html"></script> -->
	<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
	<!-- 2019-08-13 smh 끝. -->
	
    <!-- The styles -->
    <!-- 2019-12-13 smh jquery-ui.css 변경.시작 -->
    <!-- 2020-01-06 khj 로컬 리소스 바라보도록 원복 -->
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
    <!-- The fav icon -->
    <link rel="shortcut icon" href="/favicon_vit.ico">
    
    <link rel="stylesheet" href="/resources/icm/uigrid/css/ui-grid.min.css" type="text/css">
    
    
    <script src="/resources/icm/js/custom.js" ></script>
    <script src="/resources/icm/js/multiFile.js" ></script>
    <script src="/resources/icm/js/fileList.js" ></script>
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
	<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/style.css">
    <script type="text/javascript" src="/resources/js/ui.js"></script>
    
    <!-- 20191227_khj Tooltip Add -->
    <script src="/resources/popper.js/1.14.3/umd/popper.min.js"></script>
    
<style>
span{
	word-break:break-all;
}

.progress{
	display:none;
	position:absolute !important;
	width :100%;
	z-index : 9999;
}
.sr-only{
	position : relative !important;
}
.progress-bar-back{
	display:none;
	width : 100%;
	height : 100%;
	background-color : rgba(0,0,0,0.4);
	position : absolute;
	z-index : 9998; 
	cursor : wait;
}
#wrapper{overflow:auto; min-height:841px;}
#content-wrapper{width:100%;}
.ui-grid-header-cell{text-align:center !important;}
.nav .open > a, .nav .open > a:hover, .nav .open > a:focus {
    background-color: inherit;
    border-color: transparent;
}
.nav > li > a:hover, .nav > li > a:focus {
    color: #439ee3;
    background-color: inherit;
}
.treeWrap .tree{height:400px; overflow:auto;}

/* 20190805_khj IE는 적용 안되서 주석처리 */
/* .modal-body select{background:rgba(0,0,255,0);-webkit-appearance: menulist-button;} */

.modal{
 opacity:1 !important;
 }

/* loading_bar */
.wrap-loading{ /* background darkness*/
    position: fixed;
    left:0;
    right:0;
    top:0;
    bottom:0;
    background: rgba(0,0,0,0.2); /*not in ie */
    filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000',endColorstr='#20000000');    /* ie */
    z-index:9000;
}

.wrap-loading div{ /*loading img*/
        position: fixed;
        top:50%;
        left:50%;
        margin-left: -21px;
        margin-top: -21px;
        z-index:9000;
}

.display-none{ /*loading_bar hidden*/
    display:none;
}
/* loading_bar */

.tooltip-inner{
text-align:left;
}
</style>
<decorator:head />
</head>
<div class="progress-bar-back"></div>
<body>
<div class="loader main-loader"></div>
<div class="main-loader-bg"></div>

<div id="wrap">
	<!-- header -->
	<header id="header">
		<div class="progress">
		  <div id="progressBar" class="progress-bar bg-info active" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%; height: 100%;">
		    <span class="sr-only" id="progress-bar-view"></span>
		  </div>
		</div>
		<h1 class="logo" style="font-size:33px;font-weight:bold; margin-top:5px;">
			<a href="#" id="btn_main">
				VIT <span style="color:#2380C7;">Framework</span>
			</a>
		</h1>
		<p class="status">
			<span class="txt"><a href="#"><%=s_emp_name %></a>님이 로그인 하셨습니다.</span>
			<a href="#" id="btn_logout" class="btnTypeS btnLogout">LOGOUT</a>
		</p>
	</header>
	<!-- //header -->
	<!-- container -->
	<div id="container">
		<!-- lnb -->
		<nav id="lnb">
			<ul id="icm_menu_container"></ul>
		</nav>
		<script>
			lnb();
		</script>
		<div id="contents">

				<div class="contHead">
					<button type="button" class="btnMenu" onclick="$('#container').toggleClass('menuOff'); grid_resize();">메뉴</button>
					<p class="loc">
						<c:if test="${menu.breadcrumb[0].top_menu_id ne null}">
				  			<span>${menu.breadcrumb[0].top_menu_name} </span>
				  			<c:if test="${menu.breadcrumb[0].top_menu_id ne menu.breadcrumb[0].up_menu_id}">
					  			<c:if test="${menu.breadcrumb[0].up_menu_id ne null}">
						  			<span>${menu.breadcrumb[0].up_menu_name} </span>
						  		</c:if>
						  	</c:if>
				  		</c:if>
				  		<c:if test="${menu.breadcrumb[0].menu_id ne null}">
				  			<span>${menu.breadcrumb[0].menu_name}</span>
				  		</c:if> 
					</p>
				</div>
				
				<div class="contBody" data-ng-app="app">
					<decorator:body></decorator:body>
				</div>
		</div>
	</div>
	
<!-- 	<div id="wrap-loading" class="wrap-loading display-none"> -->
<!--     	<div><img src="/resources/images/ajax-loader.gif" /></div> -->
<!-- 	</div> -->
	
</div>


<!-- external javascript -->

<script src="/resources/icm/js/bootstrap.min.js"></script>
<!-- application script for Charisma demo -->
<script src="/resources/icm/js/charisma.js"></script>
 
<script>
(function($) {
	
	//20191023_khj for csrf
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
	
    $.ajaxSetup({
        beforeSend: function(xhr){
        	//console.log("공통 비포센트 실행");
        	$(".main-loader").show();
        	$(".main-loader-bg").show();
        	//$('.wrap-loading').removeClass('display-none');
        	//document.getElementsByClassName("main-loader").style.display = "block";
        	//document.getElementsByClassName("main-loader-bg").style.display = "block";
        	
        	//20191023_khj for csrf
	        xhr.setRequestHeader(header, token);
	        xhr.setRequestHeader("AJAX", true);
        },
        complete : function(){
            $(".main-loader").hide();
        	$(".main-loader-bg").hide();
        	//$('.wrap-loading').addClass('display-none');
        	$("#progressBar").attr('aria-valuenow',100).css("width", 100+"%");
			$("#progress-bar-view").text(100+"%");
			$(".progress").hide();
			$(".progress-bar-back").hide(); 
        },
        error : function(error, text, errorThrown ){
        	$(".main-loader").hide();
        	$(".main-loader-bg").hide();
        	//$('.wrap-loading').addClass('display-none');

			//20191029_khj 스프링 시큐리티때문에 ajax에러인데 200코드로 리스폰스 되는 경우엔 세션타임아웃인 경우임, 따라서 로그인페이지로 강제이동
			if(error.status == "200"){
        		location.href = "/core/login/sessionOut.do";
        	}
			
        	if(error.status == "403"){
        		location.href = "/core/login/sessionOut.do";
        	}
        	
			if(error.responseJSON == null){
				if(error.responseText == "500" ){
					swalWarning("에러가 발생했습니다. 관리자에 문의해주십시오.");	
				}else if(error.responseText == "403"){
					swalWarning("권한이 없습니다.");
				}else if(error.responseText == "404"){
					swalWarning("해당기능을 실행할 수 없습니다. 관리자에 문의해주십시오.");
				}
			}else{
				var validationText = error.responseJSON.biz_validation_message;
				if(validationText == "SESSIONNO" ){
					//alert("장시간 미사용으로 로그아웃 됩니다.");
					//location.href = "/";
					location.href = "/core/login/sessionOut.do";
				}else{
					swalWarning(validationText);		
				}	
			}
			
        	$("#progressBar").attr('aria-valuenow',100).css("width", 100+"%");
			$("#progress-bar-view").text(100+"%");
			$(".progress").hide();
			$(".progress-bar-back").hide();
        	
        }
    });

})(jQuery);
function box_content_height_reset(){
	$(".box-content").height();
}
function grid_resize(){
	var $grid = $(".ui-grid");
	if($grid.length > 0){
		var grid_scope = angular.element($grid).scope(); 
		setTimeout(function() {grid_scope.gridApi.grid.refresh();},100);
	}
}
</script>
<script>
$(document).ready(function(){

	/* 20191227_khj Tooltip Add */
	//Tooltip Setting
	$('[data-toggle="tooltip"]').tooltip();
	
	
	var current_date = '${current_date}';
	$(".current_date").html(current_date);

	<c:forEach var="topmenu" items='${menu.topmenu}' varStatus = 'status'>
		<c:set var="menu_id" value ="${topmenu.menu_id}" />
		<c:if test="${topmenu.menu_level eq '1'}" >
			<c:choose>
				<c:when test="${topmenu.type eq 'Y'}">
						$("#icm_menu_container").append('<li class="accordion" data-menu-id="${topmenu.menu_id}">'+
						'<a class="ajax-link leftmenu_'+${status.count}+'" href="#"><span>${topmenu.menu_name}</span></a>'+
						'<div class="subMenu"><ul id="${topmenu.menu_id}" class="nav nav-pills nav-stacked"></ul></div></li>');
				</c:when>
				<c:when test="${topmenu.type ne 'Y'}">
				$("#icm_menu_container").append('<li><a class="ajax-link leftmenu_'+${status.count}+'" href="#" data-url="${topmenu.menu_path}" data-menu-id="${topmenu.menu_id}">${topmenu.menu_name}</a></li>');
				</c:when>	
			</c:choose>
		</c:if>
	</c:forEach>
	
	<c:forEach var="leftmenu" items='${menu.leftmenu}'>
		<c:set var="menu_path" value ="${leftmenu.menu_path}" />
		<c:if test="${leftmenu.menu_level eq '2'}" >
			<c:choose>
				<c:when test="${menu_path eq null || menu_path == '' || menu_path == '/'}">
						$("#${leftmenu.upmenu_id}").append('<li class="accordion" style="font-size:12px;" data-menu-id="${leftmenu.menu_id}" data-upmenu-id="${leftmenu.upmenu_id}">'+
						'<a class="ajax-link" href="#"><span>${leftmenu.menu_name}</span></a>'+
						'<div class="subMenu"><ul id="${leftmenu.menu_id}" data-upmenu-id="${leftmenu.upmenu_id}" class="nav nav-pills nav-stacked"></ul></div></li>');	
				</c:when>
				<c:otherwise>
						$("#${leftmenu.upmenu_id}").append('<li style="font-size:12px;"><a class="ajax-link" href="#" data-upmenu-id="${leftmenu.upmenu_id}" data-menu-id="${leftmenu.menu_id}" data-url="${leftmenu.menu_path}">${leftmenu.menu_name}</a></li>');
				</c:otherwise>
			</c:choose>
		</c:if>
	</c:forEach>
	/* 		$("#${submenu.upmenu_id}").append('<li><a class="ajax-link" href="#" data-menu-id="${submenu.menu_id}" data-url="${submenu.menu_path}">${submenu.menu_name}</a></li>');
	 */
	<c:forEach var="submenu" items='${menu.submenu}'>
		<c:set var="menu_path" value ="${submenu.menu_path}" />
		<c:if test="${submenu.menu_level eq '3'}" >
			<c:choose>
				<c:when test="${menu_path eq null || menu_path == '' || menu_path == '/'}">
						$("#${submenu.upmenu_id}").append('<li class="accordion" style="font-size:12px;" data-upmenu-id="${submenu.upmenu_id}" data-menu-id="${submenu.menu_id}">'+
						'<a class="ajax-link" href="#"><span>${submenu.menu_name}</span></a>'+
						'<div class="subMenu"><ul id="${submenu.menu_id}" data-upmenu-id="${submenu.upmenu_id}" class="nav nav-pills nav-stacked"></ul></div></li>');	
				</c:when>
				<c:otherwise>
						$("#${submenu.upmenu_id}").append('<li style="font-size:12px;"><a class="ajax-link" href="#" data-upmenu-id="${submenu.upmenu_id}" data-menu-id="${submenu.menu_id}" data-url="${submenu.menu_path}">${submenu.menu_name}</a></li>');
				</c:otherwise>
			</c:choose>
		</c:if>
	</c:forEach>
 	
	<c:forEach var="submenu2" items='${menu.submenu2}'>
		<c:if test="${submenu2.menu_level eq '4'}" >
		$("#${submenu2.upmenu_id}").append('<li><a class="ajax-link" href="#" data-upmenu-id="${submenu2.upmenu_id}"  data-menu-id="${submenu2.menu_id}" data-url="${submenu2.menu_path}">${submenu2.menu_name}</a></li>');
		</c:if>
	</c:forEach>
	 
	
	//highlight current / active link
    var selectedMenu = $('a[data-url="'+window.location.pathname+'"]');
    selectedMenu.parent().addClass('on');
	var upmenuId = selectedMenu.data("upmenuId");
	while(!isEmpty(upmenuId)){
		var nextUpmenuUL = $("#"+upmenuId);
		nextUpmenuUL.parent().css("display","block");
		nextUpmenuUL.parent().parent().addClass("open");
		upmenuId = nextUpmenuUL.data("upmenuId");
	}
    
    var currentPage = $("#icm_menu_container .active")[0];
    if(!isEmpty(currentPage)){
    	document.getElementById("icm_page_title").innerText = currentPage.innerText; //body에 content title	
    }
    
    
    var modal_stack = 0;
    var modal_top = 20;
    var modal_left = 20;
    
    $(".modal").on("shown.bs.modal",function(){
 		var $this = $($(this).children(".modal-dialog"));
    	var $html = $("html");
    	
    	$this.css({
   	      top: 0 + (modal_stack*modal_top),
   	      left : (modal_stack*modal_left)
   	    });

     	$this.draggable({
    		handle : ".modal-header"
    	});
    	
    	modal_stack += 1;
    	$(this).css("z-index",(modal_stack*10)+1050);
    	$('html').scrollTop(0);
    	$('html').css("overflow","hidden");
    	

		//$(this).scrollTop(0);
		//20190908_khj 첨부파일등록,오토샘플링 팝업오픈시 부모팝업 스크롤탑 안되도록 조치
		var this_id = this.id == null?"": this.id;
		
		if(this_id != "attachFileUpload" 
			&& this_id != "plcOEAutoSamplingModal" 
			&& this_id != "AutoSmaplingExcelUploadModal"
			&& this_id != "plcOEPerformApprovalSelectionForm"
			&& this_id != "elcOEPerformApprovalSelectionForm"
			&& this_id != "operationalEvaluationResultReportDetailModal"
		){
			$(".modal-body").scrollTop(0);
			$(this).find(".ui-grid-viewport").scrollTop(0);
		}
		//파일첨부 modal만 적용
		//modal show될때 height size 초기화
		if(this_id == "attachFileUpload"){
			$("#modal-content-id").css("height","560px");
			$("#modal-content-id").css("width","600px");
		}
		
    }); 
    
    $(".modal").on("hide.bs.modal",function(){
        modal_stack -= 1;
        //console.log("hide modal stack : ",modal_stack);
        if(modal_stack == 0){
        	$('html').css("overflow","auto");
        }
    });
    
    $('.modal').on('hidden.bs.modal', function (e) {
		if($(this).find('form')[0] != undefined){
			
			//모달 닫기시 clear 제외할 Form 명시(Angular 데이터 클리어 되는 현상있음)
			switch($(this).find('form')[0].id){
				case "plcOEPerfromAutoSamplingForm" :
					return false;
					break;
				case "elcOEPerfromAutoSamplingForm" :
					return false;
					break;
				case "sfac_bs_form" :
					return false;
					break;		
				
				default :
					$(this).find('form')[0].reset();
					break;
			}	
		}    	
	});
    
    $("#excel_down_btn").on("click",function(){
    	var form = document.getElementById("excelDownForm");
    	var input = document.createElement("input");
    	input.name = "term_code";
    	input.id = "term_code";
    	input.value = $("#termcode option:selected").data("term-code");
    	input.type = "hidden";
    	form.appendChild(input);
    	form.submit();
    	form.removeChild(document.getElementById("excelDownForm").querySelector("#"+"term_code"));
    });
    
    $("#btn_main").on("click",function(){
    	var form    = document.createElement("form");
    	var input   = document.createElement("input");
    	input.name  = "_csrf";
    	input.value = "${_csrf.token}";
    	input.type  = "hidden";
    	
    	form.method = "post";
     	form.action = "/core/menu/main";
    	
    	form.appendChild(input);
    	document.body.appendChild(form);
    	
    	form.submit();
    	form.remove();
    });
    
    $("#btn_logout").on("click",function(){
    	var form    = document.createElement("form");
    	var input   = document.createElement("input");
    	input.name  = "_csrf";
    	input.value = "${_csrf.token}";
    	input.type  = "hidden";
    	
    	form.method = "post";
     	form.action = "/core/login/logout.do";
    	
    	form.appendChild(input);
    	document.body.appendChild(form);
    	
    	form.submit();
    	form.remove();
    });
    
 	// BackSpace 키 방지 이벤트
    $(document).keydown(function(e){   
        if(e.target.nodeName != "INPUT" && e.target.nodeName != "TEXTAREA"){
            if(e.keyCode === 8){//BackSpace(8)
            	return false;
            }
        }
    });
 
	
});
</script>
</body>
</html>