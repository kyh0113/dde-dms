<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
if (request.getProtocol().equals("HTTP/1.1"))
	response.setHeader("Cache-Control", "no-cache");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>DB암복호화</title>
<style>
.ui-grid-cell-contents{
	white-space : pre !important;
}

</style>
</head>
<body>

	<section class="section">
		<h2 class="subTitle">암복호화</h2>
	</section>
	
	<section class="section">
		<div id="AA"   style="height: 600px;">
			<!-- 암호화form -->
			<form  id="encryptForm">
				<!-- 20191023_khj for csrf -->
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				
				<label for="encrypt" style="font-size:18px;">암호화할 text입력 : </label>
				<input class="inputTxt" type="text" name="encrypt" id="encrypt" style="width:300px;"/>
				<button id="encrypt_btn" type="button" class="btn btn-info" style="display:inline-block; width:100px;">암호화</button>
			</form>
			
			<label for="encrypt_result" style="font-size:18px;">암호화 결과 : </label>
			<input class="inputTxt" type="text" name="encrypt_result" id="encrypt_result" style="width:300px; background-color:orange;"/><br><br><hr><br>
			
			<!-- 복호화form -->
			<form  id="decryptForm">
				<!-- 20191023_khj for csrf -->
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				
				<label for="decryptForm" style="font-size:18px;">복호화할 text입력 : </label>
				<input class="inputTxt" type="text" name="decrypt" id="decrypt" style="width:300px;"/>
				<button id="decrypt_btn" type="button" class="btn btn-primary" style="display:inline-block; width:100px;">복호화</button>
			</form>
			
			<label for="decrypt_result" style="font-size:18px;">복호화 결과 : </label>
			<input class="inputTxt" type="text" name="decrypt_result" id="decrypt_result" style="width:300px;background-color:orange;"/>
			
		</div>
	</section>

<script>
$(document).ready(function(){
	
	$("#encrypt_btn").on("click",function(){
		
		var oForm = $("#encryptForm").serializeArray();
		var oFormArr = gPostArray(oForm);
		$.ajax({
			type: 'POST',
			url: '/core/staff/encrypt',
			data: oFormArr,
			dataType: 'json',
			async : false,
			success: function(data){
				$("#encrypt_result").val(data.encrypt_result);
			},
	        complete: function(){}
		});
	});
	
	$("#decrypt_btn").on("click",function(){
		var oForm = $("#decryptForm").serializeArray();
		var oFormArr = gPostArray(oForm);
		$.ajax({
			type: 'POST',
			url: '/core/staff/decrypt',
			data: oFormArr,
			dataType: 'json',
			async : false,
			success: function(data){
				$("#decrypt_result").val(data.decrypt_result);
			},
	        complete: function(){}
		});
	});
	
});
</script>
</body>