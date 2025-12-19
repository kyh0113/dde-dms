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
SimpleDateFormat date = new SimpleDateFormat("yyyy/MM");
String toDay = date.format(today);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>도급비 집계처리
</title>
<script type="text/javascript">
	var scope;
	$(document).ready(function() {
		
		// 부트스트랩 날짜객체
		$(".dtp").datepicker({
			format : "yyyy/mm",
			language : "ko",
			viewMode: "months", 
		    minViewMode: "months",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		});
		
		//조회조건 default
		//오늘날짜 세팅
		if($("input[name=BASE_YYYYMM]").val() == ""){
			$("input[name=BASE_YYYYMM]").val("<%=toDay%>");	
		}
		
		$('input').on('keydown', function(event) {
			if(event.keyCode==13) 
				return false;
		});
		

	});
	
</script>
</head>
<body>
	<h2>
		도급비 집계처리
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
	<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
	<div id="shds-uiGrid" data-ng-controller="shdsCtrl">
	<form id="frm" name="frm">
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="excel_flag" />
		<input type="hidden" name="page" id="page" value="${req_data.paginationInfo.currentPageNo}" />
		<input type="hidden" name="page_rows" value="" />
		<input type="hidden" name="user_dept" id="user_dept" value="${req_data.user_dept}"/>
		<section>
			<div class="tbl_box">
				<table cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="3%" />
						<col width="250px"/>
						<col width="3%" />
						<col />
						<col width="3%" />
						<col />
					</colgroup>
					<tr>
						<th>검수년월</th>
						<td>
							<input type="text" class="calendar dtp" name="BASE_YYYYMM" id="BASE_YYYYMM" size="10" value="${req_data.date}"/>
						</td>
						<th><input type="button" class="btn_g" id="create_btn" value="집계처리"/></th>
						<td>&nbsp;</td>
						<th>&nbsp;</th>
						<td>&nbsp;</td>
					</tr>
				</table>
				<div class="btn_wrap">
					
				</div>
			</div>
		</section>
	</form>
	<div class="float_wrap">
		<div class="fl">
		</div>
		<div class="fr" style="margin-bottom:5px;">
		</div>
	</div>
	</div>
	<script>
		$(document).ready(function() {
			
			// 부트스트랩 날짜객체
			$(document).on("focus", ".dtp", function() {
				$(this).datepicker({
					format : "yyyy/mm",
					language : "ko",
					todayHighlight : true,
					autoclose : true,
					clearBtn : true,
					updateViewDate : false
				}).on('changeDate', function (ev) {
					$(this).trigger("change");
					$('.datepicker').hide();
				});
			});

			// 집계처리
			$("#create_btn").on("click", function() {
				swal({
					  icon : "info",
					  text: "집계처리를 하시겠습니까?",
					  closeOnClickOutside : false,
					  closeOnEsc : false,
					  buttons: {
							confirm: {
							  text: "확인",
							  value: true,
							  visible: true,
							  className: "",
							  closeModal: true
							},
							cancel: {
							  text: "취소",
							  value: null,
							  visible: true,
							  className: "",
							  closeModal: true
							}
					  }
					})
					.then(function(result){
					  if(result){
						  $.ajax({
							    url: "/yp/zwc/ipt/zwc_ipt_sum_create_exec",
							    type: "POST",
							    cache:false,
							    async:true, 
							    dataType:"json",
							    data:{BASE_YYYYMM:$("#BASE_YYYYMM").val().replace("/",""), _csrf:'${_csrf.token}'},
							    success: function(result) {
							    	if(result.result > 0){
							    		swalSuccess("집계처리 완료되었습니다.");
							    	}else{
							    		swalDanger("집계처리 실패하였습니다.\n관리자에게 문의해주세요.");
							    	}
							    	$('.wrap-loading').addClass('display-none');
						    	},
								beforeSend:function(){
									$('.wrap-loading').removeClass('display-none');
								},
								complete:function(){
							        $('.wrap-loading').addClass('display-none');
							    },
							    error:function(request,status,error){
							    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
							    	swalDanger("집걔처리 실패하였습니다.\n관리자에게 문의해주세요.");
							    }
							});
					 	 }			  
					});	
				
			});

		});
		
		function fnHrefPopup(url, target, pr) {
			//20191023_khj for csrf
			var csrf_element = document.createElement("input");
			csrf_element.name = "_csrf";
			csrf_element.value = "${_csrf.token}";
			csrf_element.type = "hidden";
			//20191023_khj for csrf
			var popForm = document.createElement("form");

			popForm.name = "popForm";
			popForm.method = "post";
			popForm.target = target;
			popForm.action = url;

			document.body.appendChild(popForm);

			popForm.appendChild(csrf_element);

			$.each(pr, function(k, v) {
				console.log(k, v);
				var el = document.createElement("input");
				el.name = k;
				el.value = v;
				el.type = "hidden";
				popForm.appendChild(el);
			});

			popForm.submit();
			popForm.remove();
		}


		function fnValidation(){
			if($("input[name=date]").val() == ''){
				swalWarning("신청일자를 입력해 주세요.");
				return false;
			} 
			return true;
		}
	</script>
	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
</body>