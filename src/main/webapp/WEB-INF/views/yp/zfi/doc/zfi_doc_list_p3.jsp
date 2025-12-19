<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<sec:csrfMetaTags />
<title>전자결재 상신</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="http://malsup.github.com/jquery.form.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
<script type="text/javascript">
	$(document).ready(function() {
		$("#wirte").click(function() {
			<c:choose>
			<c:when test='${FROM eq "zfi_doc_create"}'>
			console.log("from 회계전표 등록");
			$("input[name=IBELNR]").val("${BELNR}");
			$("input[name=IGJAHR]").val("${BUDAT.substring(0, 4)}");
			</c:when>
			<c:when test='${FROM eq "zfi_doc_list"}'>
			console.log("from 회계전표 목록");
			$("input[name=IBELNR]").val("${BELNR}");
			$("input[name=IGJAHR]").val("${GJAHR}");
			</c:when>
			</c:choose>
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				url : "/yp/zfi/doc/createDocWrite",
				type : "POST",
				cache : false,
				async : true,
				data : $("#frm").serialize(),
				dataType : "json",
				success : function(result) {
					console.log(result);
					if (result.flag == "S") {
						opener.parent.fnDocWriteGW(result.url);
						self.close();
					} else {
						alert(result.msg);
					}
				},
				beforeSend : function(xhr) {
					// 2019-10-23 khj - for csrf
					xhr.setRequestHeader(header, token);
					$('.wrap-loading').removeClass('display-none');
				},
				complete : function() {
					$('.wrap-loading').addClass('display-none');
				},
				error : function(request, status, error) {
					console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
					alert("전자결재 기안화면 조회에 실패하였습니다.\n관리자에게 문의해주세요.");
				}
			});
		});
	});
</script>
</head>
<body>
	<!-- 20191023_khj for csrf -->
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<div id="popup">
		<div class="pop_header">전자결재 상신</div>
		<div class="pop_content">
			<form id="frm" name="frm" method="post" accept-charset="UTF-8">
				<input type="hidden" name="mode" value="written" />
				<input type="hidden" name="IGJAHR" value="" />
				<input type="hidden" name="IBELNR" value="" />
				<section>
				<div class="lst">
					<table cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="20%" />
							<col />
						</colgroup>
						<tr>
							<th>선택</th>
							<th>전자결재 상신문서</th>
						</tr>
						<tr>
							<td>
								<input type="radio" name="GUBUN" id="GUBUN1" value="R1">
							</td>
							<td>
								<label for="GUBUN1">지출품의서(발수신)</label>
							</td>
						</tr>
						<tr>
							<td>
								<input type="radio" name="GUBUN" id="GUBUN2" value="R2">
							</td>
							<td>
								<label for="GUBUN2">지출품의서(내부)</label>
							</td>
						</tr>
						<tr>
							<td>
								<input type="radio" name="GUBUN" id="GUBUN3" value="R3">
							</td>
							<td>
								<label for="GUBUN3">수입품의서(발수신)</label>
							</td>
						</tr>
						<tr>
							<td>
								<input type="radio" name="GUBUN" id="GUBUN4" value="R4">
							</td>
							<td>
								<label for="GUBUN4">수입품의서(내부)</label>
							</td>
						</tr>
						<tr>
							<td>
								<input type="radio" name="GUBUN" id="GUBUN5" value="R5">
							</td>
							<td>
								<label for="GUBUN5">회계전표(발수신)</label>
							</td>
						</tr>
						<tr>
							<td>
								<input type="radio" name="GUBUN" id="GUBUN6" value="R6">
							</td>
							<td>
								<label for="GUBUN6">회계전표(내부)</label>
							</td>
						</tr>
						<tr>
							<td>
								<input type="radio" name="GUBUN" id="GUBUN7" value="R7">
							</td>
							<td>
								<label for="GUBUN7">출장여비정산(발수신)</label>
							</td>
						</tr>
						
						<tr>
							<td>
								<input type="radio" name="GUBUN" id="GUBUN14" value="R14">
							</td>
							<td>
								<label for="GUBUN14">출장여비정산(내부)</label>
							</td>
						</tr>
						
					</table>
				</div>
				</section>
			</form>
			<div class="btn_wrap">
				<button class="btn btn_apply" id="wirte">문서 상신하기</button>
			</div>
		</div>
</body>
</html>