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
<title>작업표준서 등록</title>
<script type="text/javascript">
$(document).ready(function() {
	
	$("#reg_btn").click(function() {
		var form = $("#regfrm")[0];
  	  	var formData = new FormData(form);
  	  	
  	  	if(fnValidation()){
	  	  	$.ajax({
				url : "/yp/popup/zpp/wsd/zpp_wsd_create_save",
				type : "POST",
				processData: false,
	            contentType: false,
				data : formData,
				success : function(result) {
					opener.parent.swalSuccess("저장 되었습니다.");
					self.close();
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
	
	$("select[name=type1]").change(function() {
		var sUpperVal = $(this).val();
		$.ajax({
			url : "/yp/zpp/wsd/zpp_wsd_auth_dept_map_code_list",
			type : "POST",
			data : {
					"upper_val" : sUpperVal
					,"type_level" : "2"
					, _csrf : '${_csrf.token}'},
			dataType : "json",
			success : function(result) {
				var data = result.result;
				var opt = "<option value=''>전체</option>";
				if(!isEmpty(sUpperVal)){
					for(var i=0;i<data.length;i++){
						
						opt += "<option value='"+data[i].VALUE+"'>"+data[i].VALUE+"</option>";
						sel="";
					}
				}
				
				$("select[name=type2] option").remove();
				$("select[name=type2]").append(opt);
			},
			error : function(request, status, error) {
				console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
			}
		});
	});
});

function fnValidation(){
	if($("input[name=type1]").val() == ""){
		swalInfo("공정 항목을 입력해 주세요.");
		return false;
	}else if($("input[name=type2]").val() == ""){
		swalInfo("공정상세 항목을 입력해 주세요.");
		return false;
	}else if($("input[name=doc_no]").val() == ""){
		swalInfo("문서코드 항목을 입력해 주세요.");
		return false;
	}else if($("input[name=doc_title]").val() == ""){
		swalInfo("문서제목 항목을 입력해 주세요.");
		return false;
	}else if($("input[name=wsd_file]").val() == ""){
		swalInfo("업로드할 파일을 등록해 주세요.");
		return false;
	}
	return true;
}

</script>
</head>
<body>
	<div class="wrap-loading display-none">
		<div><img src="/resources/images/ajax-loader.gif" /></div>
	</div>
	<div id="popup">
		<div class="pop_header">작업표준서 등록</div>
		<div class="pop_content">
			<form id="regfrm" name="regfrm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<section>
					<div class="tbl_box">
						<table cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="25%" />
								<col width="75%" />
							</colgroup>
							<tr>
								<th>문서형식</th>
								<td>
									<select name="doc_type">
										<option value="1">작업표준서</option>
										<option value="2">검수표준서</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>공정</th>
								<td>
									<select name="type1">
										<option value="" <c:if test="${req_data.srch_type1 eq ''}">selected</c:if>>전체</option>
										<c:forEach var="data" items="${clist}">
								        	<option value="${data.VALUE}" >${data.VALUE}<c:if test="${data.VALUE eq req_data.srch_type1}">selected</c:if></option>
								        </c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th>상세공정</th>
								<td>
									<select name="type2">
										<option value="">전체</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>문서코드</th>
								<td><input type="text" name="doc_no" value=""></td>
							</tr>
							<tr>
								<th>문서제목</th>
								<td><input type="text" name="doc_title" value=""></td>
							</tr>
							<tr>
								<th>엑셀 저장</th>
								<td><input type="file" name="wsd_file" id="upload" value=""/></td>
							</tr>
							<tr>
								<th>PDF 저장</th>
								<td><input type="file" name="wsd_pdf" id="upload_p" value=""/></td>
							</tr>
						</table>
					</div>
					*엑셀파일을 PDF로 저장하여 두개 파일을 모두 업로드해야합니다.
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