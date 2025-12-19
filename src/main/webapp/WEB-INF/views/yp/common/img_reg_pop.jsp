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
<c:choose>
    <c:when test="${type eq 'oath'}">서약서 등록</c:when>
    <c:when test="${type eq 'zwc_ipt2_contract_bill'}">청구서 첨부</c:when>
    <c:otherwise>사진 등록</c:otherwise>
</c:choose>
</title>
<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
<script type="text/javascript" src="/resources/icm/js/custom.js"></script>
<script type="text/javascript" src="/resources/icm/js/jquery.form.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
<script type="text/javascript">

$(document).ready(function(){
	
	$("#reg_btn").click(function(){
		$("#img_url").attr("name", '${type}'+'_url');	//서약서파일 업로드인지 이미지파일업로드인지 체크 후 저장경로 세팅
		$("#regfrm").ajaxForm({
			url: "/yp/zwc/ent/imgUpload",
<c:choose>
	<c:when test="${type eq 'zwc_ipt2_contract_bill'}">
			data : {
				type : '${type}', 
				_csrf : '${_csrf.token}', 
				BASE_YYYY : '${BASE_YYYY}', 
				VENDOR_CODE : '${VENDOR_CODE}', 
				GUBUN_CODE_AGGREGATION : '${GUBUN_CODE_AGGREGATION}'
			},
	</c:when>
	<c:otherwise>
			data : {type : '${type}', _csrf : '${_csrf.token}'},
	</c:otherwise>
</c:choose>
			dataType:"json",
			enctype: "multipart/form-data", 
			success: function(data){
				if(data.result_code < 0){
					swalWarning(data.msg);
				}else{
					swalSuccessCB(data.msg, function(){
						if('${type}' == 'oath'){
							$("#oath_url",opener.document).val(data.url);
							$("#oath_view_btn",opener.document).show();	//보기버튼
							$("#oath_down_btn",opener.document).show();	//다운로드버튼
						}else if('${type}' == 'health'){
							$("#health_url",opener.document).val(data.url);
							$("#health_view_btn",opener.document).show();	//보기버튼
							$("#health_down_btn",opener.document).show();	//다운로드버튼	
						}else if('${type}' == 'zwc_ipt2_contract_bill'){
// 							$("#ATTACH_URL", opener.document).val(data.url);
// 							$("#ATTACH_YN", opener.document).val(data.ATTACH_YN);
						}else{
							$("#img_url",opener.document).attr("src",data.url);	//img태그
							$("input[name=img_url]",opener.document).val(data.url);	//hidden url
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
			<c:choose>
			    <c:when test="${type eq 'oath'}">서약서 등록</c:when>
				<c:when test="${type eq 'zwc_ipt2_contract_bill'}">청구서 첨부</c:when>
			    <c:otherwise>사진 등록</c:otherwise>
			</c:choose>
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
									<input type="file" id="img_url" title="파일 업로드" maxlength="1000" accept=".pdf,.png,.jpg,.jpeg,.bmp,.gif"/>
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