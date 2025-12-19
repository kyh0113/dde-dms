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
	<c:if test="${req_data.TYPE eq 'REG'}">협력업체 등록</c:if>
	<c:if test="${req_data.TYPE eq 'MOD'}">협력업체 상세보기</c:if>
</title>
<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
<script type="text/javascript" src="/resources/icm/js/custom.js"></script>
<script type="text/javascript" src="/resources/icm/js/jquery.form.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
<script type="text/javascript">
	$(document).ready(function(){
		if('${req_data.TYPE}' == "REG"){
			$(".reg-hide").remove();
			$("#mod_btn").remove();
		}else{
			$(".mod-hide").remove();
			$("#reg_btn").remove();
		}
	});
	
	function fnEntReg(){
		if(fnValidation()){
			$('#frm').ajaxForm({
				url: "/yp/zwc/ent/createEnt",
				dataType:"json",
				enctype: "multipart/form-data", 
				success: function(data){
					if(data.result_code < 0){
						swalWarning(data.msg);
					}
					if(data.msg == "등록 되었습니다."){
						swalSuccessCB(data.msg, function(){
							opener.parent.fnSearchData();
							window.open('', '_self').close();
						});	
					}
				},
				error:function(request,status,error){
			    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
			    	swalDanger("등록중 오류가 발생하였습니다.\n관리자에게 문의해주세요.");
//	 		    },
//	 		    complete:function(data){
//	 		    	alert(data);
			    }
			});
			$("#frm").submit();
		}
	}
	
	function fnEntUpd(){
		if(fnValidation()){
			$('#frm').ajaxForm({
				url: "/yp/zwc/ent/updateEnt",
				dataType:"json",
				enctype: "multipart/form-data", 
				success: function(data){
					if(data.result_code < 0){
						swalWarning(data.msg);
					}
					if(data.msg == "수정 되었습니다."){
						swalSuccessCB(data.msg, function(){
							opener.parent.fnSearchData();
							window.open('', '_self').close();
						});	
					}
				},
				beforeSend:function(){
					$('.wrap-loading').removeClass('display-none');
				},
				complete:function(){
			        $('.wrap-loading').addClass('display-none');
			    },
				error:function(request,status,error){
			    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
			    	swalDanger("등록중 오류가 발생하였습니다.\n관리자에게 문의해주세요.");
//	 		    },
//	 		    complete:function(data){
//	 		    	alert(data);
			    }
			});
			$("#frm").submit();
		}
	}

	function fnValidation(){
		if("" == $("input[name=ent_name]").val()){
			swalWarningCB("업체명을 입력해주세요", function(){
				$("input[name=ent_name]").focus();
			}); 
			return false;
		}else if("" == $("input[name=admin_id]").val()){
			swalWarningCB("관리자ID를 입력해주세요", function(){
				$("input[name=admin_id]").focus();
			}); 
			return false;
		}else if("" == $("input[name=admin_pw]").val()){
			swalWarningCB("관리자 암호를 입력해주세요", function(){
				$("input[name=admin_pw]").focus();
			}); 
			return false;
		}else if("" == $("input[name=ent_code]").val()){
			swalWarningCB("업체코드 2자리 숫자를 입력해주세요", function(){
				$("input[name=ent_code]").focus();
			}); 
			return false;
		}
		if($("input[name=phone1]").val() != '' && $("input[name=phone2]").val() != '' && $("input[name=phone3]").val() != ''){
			$("input[name=phone]").val($("input[name=phone1]").val()+"-"+$("input[name=phone2]").val()+"-"+$("input[name=phone3]").val());
		}else if($("input[name=phone1]").val() != '' || $("input[name=phone2]").val() != '' || $("input[name=phone3]").val() != ''){
			swalWarning("대표전화 빈칸을 채워주세요.");
			return false;
		}
		if("" != $("input[name=email]").val()){
			if(!EmailFormatCheck($("input[name=email]").val())){
				swalWarningCB("E-Mail 주소를 정확히 입력해주세요.", function(){
					$("input[name=email]").focus();
				}); 
				return false;
			}
		}
		
		return true;
	}
	
	function fnSearchPopup(){
		window.open("", "업체 검색", "width=630, height=920");
		fnHrefPopup("/yp/popup/zwc/ent/retrieveLIFNR", "업체 검색", {});
	}
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
			// 				console.log(k, v);
			var el = document.createElement("input");
			el.name = k;
			el.value = v;
			el.type = "hidden";
			popForm.appendChild(el);
		});

		popForm.submit();
		popForm.remove();
	}
	
</script>
</head>
<body>
	<div id="popup">
		<div class="pop_header">
			<c:if test="${req_data.TYPE eq 'REG'}">협력업체 등록</c:if>
			<c:if test="${req_data.TYPE eq 'MOD'}">협력업체 상세보기</c:if>
		</div>
		<div class="pop_content">
			<form id="frm" name="frm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="VENDOR_CODE" id="VENDOR_CODE" value="${req_data.VENDOR_CODE}"/>
				<input type="hidden" name="phone" id="phone"/>
				<section>
					<table width="100%" class="tbl-basic">
						<colgroup>
                       		<col />
                       	 	<col />
                        	<col />
                        	<col />
                    	</colgroup>
						<tr>
						<th>업체명<span class="require">*</span></th>
						<td>
							<input type="text" name="ent_name" id="ent_name" value="${req_data.ENT_NAME}" style="width:190px; background-color: #eee" readonly="readonly"/>
							<img class="mod-hide" src="/resources/yp/images/ic_search.png" style="cursor: pointer;" onclick="javascript: fnSearchPopup();">
						</td>
						<th>업체구분<span class="require">*</span></th>
						<td>
							<select name="ent_type" id="ent_type">
								<option value="D" <c:if test="${req_data.ENT_TYPE eq 'D'}">selected</c:if>>협력업체</option>
								<option value="J" <c:if test="${req_data.ENT_TYPE eq 'J'}">selected</c:if>>공사업체</option>
							</select>
						</td>
						</tr>
						<tr>
							<th>관리자 ID생성<span class="require">*</span></th>
							<td><input type="text" name="admin_id" id="admin_id" value="${req_data.ADMIN_ID}" maxlength="20" style="width:190px;"/></td>
<!-- 							<th>관리자 ID암호<span class="require">*</span></th> -->
<%-- 							<td><input type="text" name="admin_pw" id="admin_pw" value="${req_data.ADMIN_PW}" maxlength="20" style="width:160px;"/></td> --%>
							<th>구분<span class="require">*</span></th>
							<td>
								<select name="ENTERPRISE_GUBUN" id="ENTERPRISE_GUBUN">
									<option value="1" <c:if test="${req_data.ENTERPRISE_GUBUN eq '1'}">selected</c:if>>조업</option>
									<option value="2" <c:if test="${req_data.ENTERPRISE_GUBUN eq '2'}">selected</c:if>>조업 및 정비</option>
									<option value="3" <c:if test="${req_data.ENTERPRISE_GUBUN eq '3'}">selected</c:if>>정비</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>대표자</th>
							<td colspan="3">
								<input type="text" name="REPRESENTATIVE" id="REPRESENTATIVE" value="${req_data.REPRESENTATIVE}" style="width:100%;"/>
							</td>
						</tr>
						<tr>
							<th>대표전화</th>
							<td>
								<c:set var="phone" value="${fn:split(req_data.PHONE,'-')}"/>
								<input type="text" name="phone1" id="phone1" maxlength="3" value="${phone[0]}" style="width:60px;" onkeydown="return onlyNumberKey(event);" onkeyup="removeChar(event);"/>-
								<input type="text" name="phone2" id="phone2" maxlength="4" value="${phone[1]}" style="width:60px;" onkeydown="return onlyNumberKey(event);" onkeyup="removeChar(event);"/>-
								<input type="text" name="phone3" id="phone3" maxlength="4" value="${phone[2]}" style="width:60px;" onkeydown="return onlyNumberKey(event);" onkeyup="removeChar(event);"/>
							</td>
							<th>사업자등록증 첨부</th>
							<td><input type="file" name="license_url" id="license_url" style="width:250px;" accept=".pdf,.png,.jpg,.jpeg,.bmp,.gif"/></td>
						</tr>
						<tr>
							<th>업체코드<span class="require">*</span></th>
							<td>
								<c:if test="${req_data.TYPE eq 'REG'}">
									<input type="text" name="ent_code" id="ent_code" maxlength="20" style="width:190px; background-color: #eee;" readonly="readonly"/>
								</c:if>
								<c:if test="${req_data.TYPE eq 'MOD'}">
									<input type="hidden" name="ent_code" id="ent_code" value="<c:if test="${fn:length(req_data.ENT_CODE) < 2}">0</c:if>${req_data.ENT_CODE}"/>
									<c:if test="${fn:length(req_data.ENT_CODE) < 2}">0</c:if>${req_data.ENT_CODE}
								</c:if>
							</td>
							<th>E-Mail</th>
							<td>
								<input type="text" name="email" id="email" value="${req_data.EMAIL}" placeholder="예)tester@ypzinc.co.kr" style="width:250px;"/>
							</td>
						</tr>
						<tr class="reg-hide">
							<th>등록일</th>
							<td>
								<input type="text" value="${req_data.REG_DATE}" style="width:160px;" readonly disabled/>
							</td>
							<th>최종수정일</th>
							<td>
								<input type="text" value="${req_data.UPD_DATE}" style="width:160px;" readonly disabled/>
							</td>
						</tr>
						<tr class="reg-hide">
							<th>작업자</th>
							<td colspan="3">
								<input type="text" value="${req_data.userName}" style="width:160px;" readonly disabled/>
							</td>
						</tr>
					</table>
				</section>
			</form>
			<div class="btn_wrap">
				<button class="btn" id="reg_btn" onclick="javascript:fnEntReg();">등록</button>
				<button class="btn" id="mod_btn" onclick="javascript:fnEntUpd();">수정</button>
				<button class="btn" onclick="self.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>