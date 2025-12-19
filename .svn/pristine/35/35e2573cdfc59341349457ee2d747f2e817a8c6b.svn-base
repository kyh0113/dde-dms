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
<title>
${paramMap.title}
</title>
<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
<script type="text/javascript" src="/resources/icm/js/custom.js"></script>
<script type="text/javascript" src="/resources/icm/js/jquery.form.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
<script type="text/javascript">

$(document).ready(function(){
	
	$("#reg_btn").click(function(){
		$("#file_url").attr("name", '${req_data.type}'+'_url');	//서약서파일 업로드인지 이미지파일업로드인지 체크 후 저장경로 세팅
		$("#regfrm").ajaxForm({
			//url: "/yp/fileUpload",
			url: "/yp/zhr/rez/fileUploadResort",
			data : {
				type : "${req_data.type}"
				//,_csrf : "${_csrf.token}"
			},
			dataType:"json",
			enctype: "multipart/form-data", 
			success: function(data){
				if(data.result_code < 0){
					swalWarning(data.msg);
				}else{
					swalSuccessCB(data.msg, function(){
						if("rez_cont_file" == "${req_data.type}"){//차량계량 계약등록 계약서
							$("input[name=file_url]",opener.document).val(data.uploadPath0);	//hidden url
							$("input[name=file_name]",opener.document).val(data.fileName0);	
						}
						self.close();
					});	
				}	
			},
			error:function(request,status,error){
		    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
		    	swalDanger("등록중 오류가 발생하였습니다.\n관리자에게 문의해주세요.");
		    }
		});
		$("#regfrm").submit();
	});
	
});

</script>
</head>
<body>	
 	<div id="popup">
  		<div class="pop_header">
			<c:if test="${'' ne req_data.title && req_data.title != null}">${req_data.title}</c:if>
			<c:if test="${'' eq req_data.title || req_data.title == nullreq_data.title}">파일 등록</c:if>
  		</div>
		<div class="pop_content">
			<form id="regfrm" name="regfrm"  method="post" enctype="multipart/form-data">
			<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<section class="section">
					<div class="tbl_box">
						<table cellspacing="0" cellpadding="0">
							<caption style="padding-top:0px;"></caption>
							<tr>
								<th>첨부파일</th>
								<td>
									<input type="file" id="file_url" title="파일 업로드" maxlength="1000" accept=".pdf,.png,.jpg,.jpeg,.bmp,.gif,.doc,.docx,.xls,.xlsx,.ppt,.pptx"/>
								</td>
							</tr>
						</table>
					</div>		
				</section>
			</form>
			<div class="btn_wrap">
				<button class="btn" id="reg_btn">등록</button>
				<button class="btn" onclick="self.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>