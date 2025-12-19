<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<sec:csrfMetaTags />
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="http://malsup.github.com/jquery.form.js"></script>
<script type="text/javascript" src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
<script type="text/javascript" src="/resources/icm/js/custom.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
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
</style>
<title>판매오더 등록</title>
<script type="text/javascript">
$(document).ready(function() {
	
	$("#reg_btn").click(function() {
		var form = $("#regfrm")[0];
  	  	var formData = new FormData(form);
		
  	  	if(fnValidation()){
	  	  	$.ajax({
				url : "/yp/zmm/aw/so_create_save",
				type : "POST",
				processData: false,
	            contentType: false,
				data : formData,
				dataType : "json",
				success : function(result) {
					if(result.so_no != ""){
						opener.parent.swalSuccess(result.msg);
						self.close();
					}else{
						swalWarningCB(result.error);
					}
				},
				beforeSend : function(xhr) {
					// 2019-10-23 khj - for csrf
					//xhr.setRequestHeader(header, token);
					$('.wrap-loading').removeClass('display-none');
				},
				complete : function() {
					$('.wrap-loading').addClass('display-none');
				},
				error : function(request, status, error) {
					console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
					swalDangerCB("저장에 실패하였습니다.\n관리자에게 문의해주세요.");
				}
			});
  	  	}
  	});
	
	$("select[name=I_SALES_ORG],select[name=I_DISTR_CHAN],select[name=I_DIVISION]").on("change",function() {
		$("input[name=I_SALES_OFF]").val("");
		$(".I_SALES_OFF").text("");
	});
});

/* 팝업 */
function fnSearchPopup(type, target) {
	console.log("target:"+target);
	window.open("", "검색 팝업", "width=600, height=800");
	if(type == "K"){
		fnHrefPopup("/yp/popup/zmm/aw/retrieveKUNNR", "검색 팝업", {
			type : "SO",
			target : target
		});
	}else if(type == "M"){
		fnHrefPopup("/yp/popup/zmm/aw/retrieveMATNR", "검색 팝업", {
			type : "SO",
			target : target
		});
	}else if(type == "S"){
		fnHrefPopup("/yp/popup/zmm/aw/retrieveVKBUR", "검색 팝업", {
			I_SALES_ORG : $("select[name=I_SALES_ORG]").val(),
			I_DISTR_CHAN : $("select[name=I_DISTR_CHAN]").val(),
			I_DIVISION : $("select[name=I_DIVISION]").val()
		});
	}
}

/* 팝업 submit */
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
		// console.log(k, v);
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
	if($("input[name=I_SALES_OFF]").val() == ""){
		swalInfo("영업소 항목을 입력해 주세요.");
		return false;
	}else if($("input[name=I_MATERIAL]").val() == ""){
		swalInfo("자재코드 항목을 입력해 주세요.");
		return false;
	}else if($("input[name=I_SC_REQ_QTY]").val() == ""){
		swalInfo("중량 항목을 입력해 주세요.");
		return false;
	}else if($("input[name=I_ZPRE_VALUE]").val() == ""){
		swalInfo("판매단가 항목을 입력해 주세요.");
		return false;
	}else if($("input[name=I_PART_PARTN_NUMB]").val() == ""){
		swalInfo("고객 항목을 입력해 주세요.");
		return false;
	}else if($("input[name=I_MATERIAL]").val().indexOf("CAS") > -1){
		swalInfo("SAP 자재코드가 아닙니다.\n["+$('input[name=I_MATERIAL]').val()+"] 자재코드를 확인하여주세요.");
		$('input[name=I_MATERIAL]').focus()
		return false;
	}
	return true;
}

/*콤마 추가*/
function addComma(value,target) {
	var result = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	
	if(target == "Q")
		$("input[name=I_SC_REQ_QTY]").val(result);
	else
		$("input[name=I_ZPRE_VALUE]").val(result);
}
</script>
</head>
<body>
	<div class="wrap-loading display-none">
		<div><img src="/resources/images/ajax-loader.gif" /></div>
	</div>
	<div id="popup">
		<div class="pop_header">판매오더 등록</div>
		<div class="pop_content">
			<form id="regfrm" name="regfrm" method="post">
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="CALC_CODE" value="${data.CALC_CODE}" />
				<input type="hidden" name="P_DETAIL_CODE_SAP" value="${data.P_DETAIL_CODE_SAP}" />
				<input type="hidden" name="CALC_W" value="${data.CALC_W}" />
				<input type="hidden" name="CONT_AMOUNT" value="${data.CONT_AMOUNT}" />
				<input type="hidden" name="ENT_CODE" value="${data.ENT_CODE}" />
				<input type="hidden" name="ENT" value="${data.ENT}" />
				
				<section>
					<div class="tbl_box">
						<table cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="20%" />
								<col width="45%" />
								<col width="" />
							</colgroup>
							<tr>
								<th>오더유형</th>
								<td>일반출고주문<input type="hidden" name="I_DOC_TYPE" value="ZOR1"></td>
								<td></td>
							</tr>
							<tr>
								<th>판매조직</th>
								<td>
									<select name="I_SALES_ORG">
										<option value="1000">국내</option>
										<option value="2000">해외</option>
									</select>
								</td>
								<td></td>
							</tr>
							<tr>
								<th>유통경로</th>
								<td>
									<select name="I_DISTR_CHAN">
										<option value="10">내수</option>
										<option value="20">로컬</option>
									</select>
								</td>
								<td></td>
							</tr>
							<tr>
								<th>제품군</th>
								<td><select name="I_DIVISION">
										<option value="10">아연</option>
										<option value="20">카드뮴</option>
										<option value="30">황산</option>
										<option value="40">황산동</option>
										<option value="50">은 부산물</option>
										<option value="60">인듐</option>
										<option value="70">전기동</option>
										<option value="71">귀금속 Cake</option>
										<option value="72">석고</option>
										<option value="91">기타부산물(Cake,석고,슬라그)</option>
									</select>
								</td>
								<td></td>
							</tr>
							<tr>
								<th>영업소</th>
								<td><input type="text" name="I_SALES_OFF" value=""><img src="/resources/yp/images/ic_search.png" style="cursor: pointer;" onclick="javascript:fnSearchPopup('S', null);"></td>
								<td class="I_H_SALES_OFF" style="text-align:left;"></td>
							</tr>
							<tr>
								<th>자재코드</th>
								<%--
									/*
									* 2022/06/17
									* YPWEBPOTAL-6 차량계량 판매오더 생성의 건(개발)
									* 선택된 품목에 해당하는 자재코드가 팝업의 자재코드에 입력되어야 함
									* 계량 소계 수량이 중량에 보여야 함
									* > 맵핑코드가 없어서 parameter 추가후 코드, 텍스트 맵핑 
									*/
								 --%>
								<td><input type="text" name="I_MATERIAL" value="${data.P_DETAIL_CODE_SAP}" readonly/>
								</td>
								<td class="I_MATERIAL" style="text-align:left;">${data.P_DETAIL_NAME}</td>
							</tr>
							<tr>
								<th>중량</th>
								<!--<td>${data.CALC_W}</td>-->
								<td><input type="text" name="I_SC_REQ_QTY" value="${data.CALC_W}" /></td>
								<td></td>
							</tr>
							<!--
							<tr>
								<th>DMT중량</th>
								<td><input type="text" name="I_SC_REQ_QTY" value="" onchange="addComma(this.value,'Q');"/></td>
								<td></td>
							</tr>
							-->
							<tr>
								<th>판매단가</th>
								<!--<td><fmt:formatNumber value="${data.CONT_AMOUNT}" pattern="#,###" /></td>-->
								<td><input type="text" name="I_ZPRE_VALUE" value="${data.CONT_AMOUNT}" /></td>
								<td></td>
							</tr>
							<tr>
								<th>고객</th>
								<td><input type="text" name="" value="${data.ENT}" readonly /></td>
								<input type="hidden" name="I_PART_PARTN_NUMB" value="${data.ENT_CODE}" readonly />
							</tr>
						</table>
					</div>
					<%--안내 메시지 위치 --%>
				</section>
			</form>
			<div class="btn_wrap">
				<button class="btn btn_save" id="reg_btn">등록</button>
				<button class="btn" onclick="self.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>