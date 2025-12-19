<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<head>
<title>Dashboard</title>
<style>
body, p, h1, h2, h3, h5, h6, ul, ol, li, dl, dt, dd, table, th, td, form, fieldset, legend, input, textarea, button, iframe, pre{line-height:normal !important;}
	canvas {
		-moz-user-select: none;
		-webkit-user-select: none;
		-ms-user-select: none;
	}
	.chart-sub-container {
		width: 25%;
		
	}
	.chart_container {
		display: flex;
		flex-direction: row;
		flex-wrap: wrap;
		justify-content: center;
	}
	.container-fluid{min-width:1352px !important;}
	.dashboardTopBox .box1 .inner:hover, .dashboardTopBox .box2 .inner:hover{cursor:pointer;border: 3px solid #599fd6;} 
	.dashboardTopBox .box3 .inner:hover, .dashboardTopBox .box4 .inner:hover{cursor:pointer;border: 3px solid #5b56a2;}
	.dashboardTopBox .box5 .inner:hover{cursor:pointer;border: 3px solid #555274;}
	.pieCharthWrap .section{padding-bottom:0;}
/* 	.dashboardTopBox .tit{margin-top:0px; margin-bottom:0px;} */
	.box_left, .box_right{position:relative; float:left;}
	#header .logo {height: 100%;}
	.table_gray1 td, .table_gray1 th{line-height:30px !important;}
</style>
<link rel="stylesheet" href="/resources/icm/main/css/dashboard.css" />
<link rel="stylesheet" type="text/css" href="/resources/icm/icm6.0/css/style.css">
	<script src="/resources/icm/js/dashboard.js"></script>	
</head>



<div id="icm_page_title" style="display:none;"></div>

<div class="tab">
	<button id="tab_dashboard" class="tab-item tab-button tablink tab-red" onclick="opentab(event,'dashboard')">Tab1</button>
	<button id="tab_monitoring" class="tab-item tab-button tablink" onclick="javascript:alert('Tab2!');">Tab2</button>
</div>

<div id="wrap-loading" class="wrap-loading">
	<div><img src="/resources/images/ajax-loader.gif" /></div>
</div>

	
    <!--대쉬보드 탭-->
	<div id="dashboard" class="tabbody">
		
	<section class="section">
		<div class="dashboardTopBox">
			<section class="box1">
				<div class="inner" id="btn_modal_account" onclick="view_modal('modal_account', ''); chartMake_modalAccount();">
					<h2 class="tit">Info1</h2>
					<ul class="list">
						<li>Count1<span id="qntfact_cnt">0</span></li>
						<li>Count2<span id="qltfact_cnt">0</span></li>
					</ul>
				</div>
			</section>
			<section class="box2">
				<div class="inner" id="btn_modal_process" onclick="view_modal('modal_account', ''); chartMake_modalAccount();">
					<h2 class="tit">Info2</h2>
					<ul class="list">
						<li>Count3<span id="process_cnt">0</span></li>
					</ul>
				</div>
			</section>
			<section class="box3">
				<div class="inner" id="btn_modal_control" onclick="view_modal('modal_account', ''); chartMake_modalAccount();">
					<h2 class="tit">Info3</h2>
					<ul class="list">
						<li>Count4<span id="elc_cnt">0</span></li>
						<li>Count5<span id="plc_cnt">0</span></li>
					</ul>
				</div>
			</section>
			<section class="box4">
				<div class="inner" id="btn_modal_remark" onclick="view_modal('modal_account', ''); chartMake_modalAccount();">
					<h2 class="tit">Info4</h2>
					<ul class="list">
						<li>Count6<span id="remark_y_cnt">0</span></li>
						<li>Count7<span id="remark_n_cnt">0</span></li>
					</ul>
				</div>
			</section>
			<section class="box5">
				<div class="inner" id="btn_modal_mrc" onclick="view_modal('modal_account', ''); chartMake_modalAccount();">
					<h2 class="tit">Info5</h2>
					<ul class="list">
						<li>Count8<span id="mrc_cnt">0</span></li>
						<li>Count9<span id="ipe_cnt">0</span></li>
					</ul>
				</div>
			</section>
		</div>
	</section>
	
	<section class="section">
		<h2 class="subTitle3">Step bar</h2>
		<ul class="progress2" id="stepbar">
			<li class="com"><span>start</span></li>
			<li class="com"><span>step1</span></li>
			<li class="com"><span>step2</span></li>
			<li class="com"><span>step3</span></li>
			<li class="pass"><span>step4</span></li>
			<li class="ing"><span>step5</span></li>
			<li><span>end</span></li>
		</ul>
	</section>
	

	<div id="graph_area1">
        <div class="center_dashboard" style="margin: 10px 0;">
        	<div class="box_left">
            	<div class="border_box" style="margin-left:0;">
                	<div class="title">Chart1</div>
                    <div class="graph" style="height:150px;">
                    	<canvas id="chart_tp" height="100%"></canvas>
                    </div>
                </div>
            </div>
            <div class="box_center">
            	<div id="graph_2_grid_call" class="border_box">
                	<div class="title">
                    	<div class="title_left">Chart2</div>
                        <div class="title_right">Chart3</div>
                    </div>
                    <div class="graph" style="height:150px; display:flex;">
	                    <div  class="chart-sub-container" >
	                    	<canvas id="chart_elcdt" height="180"></canvas>
                     	</div>	
                     	<div  class="chart-sub-container" >
                     		<canvas id="chart_elcot" height="180"></canvas>
                     	</div>
                     		
                     	<div class="chart-sub-container">
                     		<canvas id="chart_plcdt" height="180"></canvas>
                     	</div>		
                     	<div  class="chart-sub-container" >
                     		<canvas id="chart_plcot" height="180"></canvas>
                     	</div>		
                     </div>
                </div>
            </div>
            <div class="box_right">
            	<div class="border_box" style="margin-right:0;">
                	<div class="title">Chart4</div>
                    <div class="graph" style="height:150px;">
                    	<canvas id="chart_ep" height="100%"></canvas>
                    </div>
                </div>
            </div>
        </div>
     </div>
	
	<section class="section">
		<h2 class="subTitle3">Chart5</h2>
		<div>
			<canvas id="chart_monitor" height="40"></canvas>
		</div>
	</section>
	
	</div>

<%@include file="./modal_account.jsp"%>

<script>

$(document).ready(function(){
	
	getDashBoardChart($("#d_termcode option:selected").val());
	
	$('#wrap-loading').addClass('display-none');
});

</script>

<script type="text/javascript">
var color = Chart.helpers.color;

function view_modal(id, type){
	var $dashBoard_modal = $("#"+id);

	$dashBoard_modal.modal({
		backdrop : false,
		keyboard: false
	});
	/* 
	$dashBoard_modal.draggable({
	      handle: ".modal-header",
	      cursor : "move"
	});
	 */
}


</script>


