<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<sec:csrfMetaTags />
<title>비밀번호 변경</title>
<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
<script type="text/javascript" src="/resources/icm/js/custom.js"></script>
<script type="text/javascript" src="/resources/icm/js/jquery.form.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
</head>
<body>
	<div id="popup">
		<div class="pop_header">비밀번호 변경</div>
		<div class="pop_content">
			<form id="pwd_reset_form" name="pwd_reset_form" method="post">
				<input type="hidden" name="ADMIN_ID" id="ADMIN_ID" value="${req_data.ADMIN_ID}" />
				<section>
				<table width="100%" class="tbl-basic">
					<colgroup>
						<col />
						<col />
					</colgroup>
					<tr>
						<th>
							비밀번호<span class="require">*</span>
						</th>
						<td>
							<input type="password" name="ADMIN_PW" id="ADMIN_PW" style="width: 100%;" />
						</td>
					</tr>
					<tr>
						<th>
							재입력<span class="require">*</span>
						</th>
						<td>
							<input type="password" id="ADMIN_PW_CF" style="width: 100%;" />
						</td>
					</tr>
				</table>
				</section>
			</form>
			<div class="btn_wrap">
				<button class="btn" id="reg_btn" onclick="javascript: fn_pwd_reset();">등록</button>
				<button class="btn" onclick="self.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {

	});

	function fn_pwd_reset() {
		if (fnValidation()) {
			$('#pwd_reset_form').ajaxForm({
				url : "/yp/popup/login/update_pwd_reset",
				dataType : "json",
				success : function(data) {
					if (data.result > 0) {
						swalWarningCB("처리되었습니다.", function(){
							self.close();
						});
					}
				},
				error : function(request, status, error) {
					console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
					swalDanger("등록중 오류가 발생하였습니다.\n관리자에게 문의해주세요.");
				},
				complete : function(data) { }
			});
			$("#pwd_reset_form").submit();
		}
	}

	function fnValidation() {
		var obj;
		obj = $("#pwd_reset_form #ADMIN_PW");
		if ("" === obj.val()) {
			swalWarningCB("비밀번호를 입력하세요.", function() {
				obj.focus();
			});
			return false;
		}
		obj = $("#pwd_reset_form #ADMIN_PW");
		if ("" === obj.val()) {
			swalWarningCB("초기비밀번호입니다.", function() {
				obj.focus();
			});
			return false;
		}
		obj = $("#pwd_reset_form #ADMIN_PW_CF");
		if ("" === obj.val()) {
			swalWarningCB("재입력을 입력하세요.", function() {
				obj.focus();
			});
			return false;
		}
		obj = $("#pwd_reset_form #ADMIN_PW_CF");
		if ($("#pwd_reset_form #ADMIN_PW").val() !== obj.val()) {
			swalWarningCB("비밀번호가 일치하지 않습니다.", function() {
				obj.focus();
			});
			return false;
		}
		return true;
	}
</script>
</html>