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
	<c:if test="${req_data.TYPE eq 'REG'}">출입인원 등록</c:if>
	<c:if test="${req_data.TYPE eq 'MOD'}">출입인원 수정</c:if>
	<c:if test="${req_data.TYPE eq 'VIEW'}">출입인원 상세</c:if>
</title>
<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
<script type="text/javascript" src="/resources/icm/js/custom.js"></script>
<script type="text/javascript" src="/resources/icm/js/jquery.form.js"></script>
<script src="/resources/icm/js/bootstrap.min.js"></script>
<script src="/resources/icm/datepicker/js/bootstrap-datepicker.js"></script>
<link href="/resources/icm/datepicker/css/datepicker.css" rel="stylesheet" type="text/css" />
<link id="bs-css" href="/resources/icm/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/yp/css/style.css">
<script type="text/javascript">
	$(document).ready(function(){
		if('${req_data.TYPE}' == "REG"){	//등록
			$("input[name=subc_code]").removeAttr("readonly");
			$(".reg-hide").remove();
			$("#save_btn").remove();
			$('#status').children('option:not(:first)').remove();
		}else if('${req_data.TYPE}' == "MOD"){	//수정
			$("#reg_btn").remove();
			$("#oath_view_btn").show();	//서약서 보기버튼
			$("#oath_down_btn").show();	//서약서 다운로드
			$("#health_view_btn").show();	//검진 보기버튼
			$("#health_down_btn").show();	//검진 다운로드
			//협력사 관리자는 "출입신청"만 오픈
			if('${req_data.gubun}' == "ent"){
				$('#status').children('option:not(:first)').remove();
			}
		}else{	//뷰
			$("#reg_btn").remove();		//등록버튼
			<c:if test="${sessionScope.s_authogrp_code ne 'SA' and sessionScope.s_authogrp_code ne 'CA' and sessionScope.s_authogrp_code ne 'MA'}">
			$("#save_btn").remove();	//저장버튼
			</c:if>
			$(".input-file").hide();	//서약서 등록버튼
			$("#oath_view_btn").show();	//서약서 보기버튼
			$("#oath_down_btn").show();	//서약서 다운로드
			$("#health_view_btn").show();	//검진 보기버튼
			$("#health_down_btn").show();	//검진 다운로드
			$("#chk_modify_area").remove();	//출입번호 수정체크박스
			$("#chk_modify_area2").remove();//출입번호 수정코멘트란
			//협력사 관리자는 "출입신청"만 오픈
			if('${req_data.gubun}' == "ent"){
				$('#status').children('option:not(:first)').remove();
			}
		}

		// 부트스트랩 날짜객체
		$(".dtp").datepicker({
			format : "yyyy/mm/dd",
			language : "ko",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		 });
		
		// 부트스트랩 날짜객체
		$(document).on("focus", ".dtp", function() {
			$(this).datepicker({
				format : "yyyy/mm/dd",
				language : "ko",
				todayHighlight : true,
				autoclose : true,
				clearBtn : true,
				updateViewDate : false
			}).on('changeDate', function (ev) {
				if(ev.viewMode != "months" && ev.viewMode != "years"){
					$(this).trigger("change");
					$('.datepicker').hide();
				}
			});
		});
		
		//20201210_khj 조용래 대리 요청으로 출입인원 수정창에서 출입번호를 수정할 수 있도록 변경
		$("#chk_modify").change(function(){
	        if($("#chk_modify").is(":checked")){
	            $("input[name=subc_code]").attr("readonly",false);	            
	        }else{
	            $("input[name=subc_code]").attr("readonly",true);
	        }
	    });
	});
	
	function fnEntReg(){
		if(fnRegValidation()){
				$('#frm').ajaxForm({
					url: "/yp/zwc/ent/createAccessControl",
					dataType:"json",
					enctype: "multipart/form-data", 
					success: function(data){
						if(data.result_code < 1){
							swalWarning(data.msg);
						}else{
							swalSuccessCB(data.msg, function(){
								opener.parent.fnSearchData();
								window.open('', '_self').close();
							});	
						}
					},
					error:function(request,status,error){
				    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
				    	swalDanger("등록중 오류가 발생하였습니다.\n관리자에게 문의해주세요.");
//		 		    },
//		 		    complete:function(data){
//		 		    	alert(data);
				    }
				});
				$("#frm").submit();
		}
	}
	
	function fnEntUpd(){
		if(fnRegValidation()){
			$('#frm').ajaxForm({
				url: "/yp/zwc/ent/updateAccessControl",
				dataType:"json",
				enctype: "multipart/form-data", 
				success: function(data){
					if(data.result_code < 1){
						swalWarning(data.msg);
					}else{
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
	
	function fnRegValidation(){
// 		$("input[name=jumin]").val($("input[name=jumin1]").val() + "-" + $("input[name=jumin2]").val());
		$("input[name=jumin]").val($("input[name=jumin1]").val());	//20200921_KHJ 생년월일6자리만 쓴다고함
		
		if("" == $("select[name=ent_code]").val()){
			swalWarningCB("업체를 선택해주세요.", function(){
				$("input[name=ent_code]").focus();
			}); 
			return false;
		}else if("" == $("input[name=subc_code]").val()){
			swalWarningCB("출입번호를 입력해주세요.", function(){
				$("input[name=subc_code]").focus();
			}); 
			return false;
		}else if(8 > $("input[name=subc_code]").val().length){
			swalWarningCB("출입번호는 8자리로 입력해주세요.", function(){
				$("input[name=subc_code]").focus();
			}); 
			return false;
		}else if($("input:checkbox[name=chk_modify]").is(":checked") == true){
			if($("input[name=subc_code]").val() == $("input[name=ori_subc_code]").val()){
				swalWarningCB("출입번호가 수정 이전과 동일합니다.\n새로운 출입번호를 입력해주세요.", function(){
					$("input[name=subc_code]").focus();
				}); 
				return false;	
			}
		}else if("${req_data.TYPE}" == "MOD" && $("input:checkbox[name=chk_modify]").is(":checked") == false){
			if($("input[name=subc_code]").val() != $("input[name=ori_subc_code]").val()){
				swalWarningCB("출입번호가 수정되었습니다.\n출입번호 수정 체크박스를 체크해주세요.", function(){
					$("input[name=subc_code]").focus();
				}); 
				return false;	
			}	
		}else if("" == $("input[name=subc_name]").val()){
			swalWarningCB("성명을 입력해주세요.", function(){
				$("input[name=subc_name]").focus();
			}); 
			return false;
		}else if("" == $("input[name=jumin1]").val()){
			swalWarningCB("생년월일 6자리를 입력해주세요.", function(){
				$("input[name=jumin1]").focus();
			}); 
			return false;
		}else if("" == $("input[name=addr]").val()){
			swalWarningCB("주소를 입력해주세요.", function(){
				$("input[name=addr]").focus();
			}); 
			return false;
		}else if("/resources/images/icon/pn_photo.gif" == $("#img_url").attr("src")){
			swalWarningCB("사진을 등록해주세요.", function(){}); 
			return false;
		}else if("" == $("input[name=cell_phone]").val()){
			swalWarningCB("휴대전화를 입력해주세요.", function(){
				$("input[name=cell_phone]").focus();
			}); 
			return false;
		}else if("" == $("input[name=hired_date]").val()){
			swalWarningCB("출입시작을 입력해주세요.", function(){
				$("input[name=hire_date]").focus();
			}); 
			return false;
		}else if("" == $("input[name=oath_url]").val()){
			swalWarningCB("서약서를 등록해주세요.", function(){
				$("input[name=oath_url]").focus();
			}); 
			return false;
// 		}else if("" == $("input[name=health_url]").val()){
// 			swalWarningCB("건강검진을 등록해주세요.", function(){
// 				$("input[name=health_url]").focus();
// 			}); 
// 			return false;
		}
		return true;
	}
	
	function fnImgRegPop(type){
		//window.open("/yp/popup/imgReg?type="+type,"imgRegPop","width=600,height=300");
		
		//20191023_khj for csrf
		var csrf_element = document.createElement("input");
		csrf_element.name = "_csrf";
		csrf_element.value = "${_csrf.token}";
		csrf_element.type = "hidden";
		//20191023_khj for csrf
		
		var input1   = document.createElement("input");
		input1.name  = "type";
		input1.value = type;
		input1.type  = "hidden";
		
		var popForm = document.createElement("form");

		popForm.name = "popForm";
		popForm.method = "post";
		popForm.target = "IMG_REG_POP";
		popForm.action = "/yp/popup/imgReg";

		document.body.appendChild(popForm);

		popForm.appendChild(csrf_element);
		
		popForm.appendChild(input1);
		
		window.open("","IMG_REG_POP","scrollbars=yes,width=600,height=300");

		popForm.submit();
		popForm.remove();
		
	}
	
	function fnImgPop(url){
		if(url == ""){
			swalWarningCB("url오류입니다. 관리자에게 문의해주세요.");
			return false;
		}
		window.open("/yp/popup/imgPopup?url="+encodeURIComponent(url),"imgPop","width=580,height=780");
	}
	
	function fnFileDown(url){
		if(url == ""){
			swalWarningCB("url오류입니다. 관리자에게 문의해주세요.");
			return false;
		}
		var form    = document.createElement("form");
    	var input   = document.createElement("input");
    	input.name  = "url";
    	input.value = url;
    	input.type  = "hidden";
    	form.appendChild(input);
    	
    	input = document.createElement("input");
    	input.name  = "${_csrf.parameterName}";
    	input.value = "${_csrf.token}";
    	input.type  = "hidden";
    	form.appendChild(input);
    	
    	form.method = "post";
    	form.action = "/yp/fileDown";
    	
    	document.body.appendChild(form);
    	
    	form.submit();
    	form.remove();
	}
	
	function jusoSearch(){
		window.open('/yp/popup/jusoPopup','새주소검색','width=570,height=420, scrollbars=yes, resizable=yes');
	}
	
	function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
		$("input[name=addr]").val(roadFullAddr);
		$("input[name=zip_code]").val(zipNo);
	}
</script>
</head>
<body>
	<div id="popup">
		<div class="pop_header">
			<c:if test="${req_data.TYPE eq 'REG'}">출입인원 등록</c:if>
			<c:if test="${req_data.TYPE eq 'MOD'}">출입인원 수정</c:if>
			<c:if test="${req_data.TYPE eq 'VIEW'}">출입인원 상세</c:if>
		</div>
		<div class="pop_content">
			<form id="frm" name="frm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<section>
					<table width="100%" class="tbl-basic">
						<colgroup>
                       		<col />
                       	 	<col />
                        	<col />
                        	<col />
                    	</colgroup>
						<tr>
							<td rowspan="5" class="pic">
								<img id="img_url" width="110" height=130 src="${data[0].IMG_URL}" onerror="this.src='/resources/yp/images/pic.png'" /><p />
								<div class="input-file">
									<label onclick="fnImgRegPop('img');">
										사진등록
										<input type="hidden" name="img_url" value="${data[0].IMG_URL}">
									</label>
								</div>
							</td>
							<th>업체명</th>
							<td>
								<select name="ent_code" style="width:165px;">
									<c:if test="${fn:length(entlist) != 1}">
										<option value="">--선 택--</option>
									</c:if>
									<c:forEach var="e" items="${entlist}" varStatus="i" >
										<option value="${e.ENT_CODE}" <c:if test="${e.ENT_CODE eq data[0].ENT_CODE}">selected</c:if>>${e.ENT_NAME}</option>
									</c:forEach>
								</select>
							</td>
							<th>출입번호<span class="require">*</span></th>
							<td>
							    <c:if test="${data[0].SUBC_CODE == null}" ><input type="text" name="subc_code" maxlength="8" style="width:165px;" readonly value="${data[0].SUBC_CODE}"/></c:if>
								<c:if test="${data[0].SUBC_CODE != null}" >
									<input type="text" name="subc_code" maxlength="8" style="width:165px;" readonly value="${data[0].SUBC_CODE}"/>
									<input type="hidden" name="ori_subc_code" maxlength="8" style="width:165px;" readonly value="${data[0].SUBC_CODE}"/>
									<label class="switch" id="chk_modify_area"><input type="checkbox" name="chk_modify" id="chk_modify"><span class="slider round">수정</span></label> 
									<div id="chk_modify_area2"><span class="require">*</span> 출입번호 수정시 해당사원 작업맵핑은 자동으로 변경 됩니다.</div>
								</c:if>
							</td>
						</tr>
						<tr>
							<th>성 명<span class="require">*</span></th>
							<td><input type="text" name="subc_name" size="1" style="width:165px;" value="${data[0].SUBC_NAME}"/></td>
							<th>생년월일<span class="require">*</span></th>
							<td>
<%-- 							<c:set var="c_jumin" value="${fn:split(data[0].JUMIN,'-')}"/> --%>
								<input type="hidden" name="jumin" value=""/>
								<input type="text" size="5" name="jumin1" maxlength="6" style="width:80px;" value="${data[0].JUMIN}" placeholder="6자리 입력" onkeydown="return onlyNumberKey(event);" onkeyup="removeChar(event);" />
<%-- 							<input type="text" size="5" name="jumin1" maxlength="6" style="width:80px;" value="${c_jumin[0]}" onkeydown="return onlyNumberKey(event);" onkeyup="removeChar(event);" />- --%>
<%-- 							<input type="text" size="5" name="jumin2" maxlength="7" style="width:80px;" value="${c_jumin[1]}" onkeydown="return onlyNumberKey(event);" onkeyup="removeChar(event);" /> --%>
							</td>
						</tr>
						<tr>
							<th>주소<span class="require">*</span></th>
							<td colspan="3" class="left">
								<input type="text" name="zip_code" style="width:70px;" readonly="readonly" value="${data[0].ZIP_CODE}"/>
								<a href="#" onclick="javascript:jusoSearch();"><img src="/resources/yp/images/ic_search.png"></a>
								<input type="text" name="addr" style="width:430px;" readonly="readonly" value="${data[0].ADDR}"/>
							</td>
						</tr>
						<tr>
							<th>휴대전화<span class="require">*</span></th>
							<td><input type="text" name="cell_phone" maxlength="11" style="width:165px;" value="${data[0].CELL_PHONE}" onkeydown="return onlyNumberKey(event);" onkeyup="removeChar(event);" placeholder="- 없이 입력" /></td>
							<th>비상연락</th>
							<td><input type="text" name="phone" maxlength="11" style="width:165px;" value="${data[0].PHONE}" onkeydown="return onlyNumberKey(event);" onkeyup="removeChar(event);" placeholder="- 없이 입력" /></td>
						</tr>
						<tr>
							<th>차종</th>
							<td><input type="text" name="vehicle_name" style="width:165px;" value="${data[0].VEHICLE_NAME}"/></td>
							<th>차량번호</th>
							<td><input type="text" name="vehicle_no" style="width:165px;" value="${data[0].VEHICLE_NO}"/></td>
						</tr>
						<tr>
							<th>상태</th>
							<th>출입시작<span class="require">*</span></th>
							<td><input name="hired_date" id="hired_date" class="dtp calendar" style="width:165px;" value="${data[0].HIRED_DATE}"/></td>
							<th>출입종료</th>
							<td><input name="resign_date" id="resign_date" class="dtp calendar" style="width:165px;" value="${data[0].RESIGN_DATE}"/></td>
						</tr>
						<tr>
							<th style="background-color:#fff;">
								<select name="status" id="status">
									<option value="W" <c:if test="${data[0].STATUS == 'W'}">selected</c:if>>출입신청</option>
									<option value="A" <c:if test="${data[0].STATUS == 'A'}">selected</c:if>>출입승인</option>
<%-- 								<option value="B" <c:if test="${data[0].STATUS == 'B'}">selected</c:if>>반려</option> --%>
									<option value="R" <c:if test="${data[0].STATUS == 'R'}">selected</c:if>>출입종료</option>
									<option value="N" <c:if test="${data[0].STATUS == 'N'}">selected</c:if>>출입금지</option>
								</select>
							</th>
							<th>서약서<span class="require">*</span></th>
							<td colspan="3" class="left">
								<div class="input-file">
									<label onclick="fnImgRegPop('oath');" style="margin-bottom:0px;">
										서약서등록
										<input type="hidden" name="oath_url" id="oath_url" value="${data[0].OATH_URL}">
									</label>
								</div>
								<input type="button" id="oath_view_btn" class="btn_g" onclick="fnImgPop('${data[0].OATH_URL}');" value="보      기" style="display:none;"/>
								<input type="button" id="oath_down_btn" class="btn_g" onclick="fnFileDown('${data[0].OATH_URL}');" value="다운로드" style="display:none;"/>
							</td>
						</tr>
						<tr>
							<th style="background-color:#fff;"></th>
							<th>건강검진</th>
							<td colspan="3" class="left">
								<div class="input-file">
									<label onclick="fnImgRegPop('health');" style="margin-bottom:0px;">
										검진등록
										<input type="hidden" name="health_url" id="health_url" value="${data[0].HEALTH_URL}">
									</label>
								</div>
								<input type="button" id="health_view_btn" class="btn_g" onclick="fnImgPop('${data[0].HEALTH_URL}');" value="보      기" style="display:none;"/>
								<input type="button" id="health_down_btn" class="btn_g" onclick="fnFileDown('${data[0].HEALTH_URL}');" value="다운로드" style="display:none;"/>
							</td>
						</tr>
					</table>
				</section>
			</form>
			<div class="btn_wrap">
				<button class="btn" id="reg_btn" onclick="javascript:fnEntReg();">등록</button>
				<button class="btn" id="save_btn" onclick="javascript:fnEntUpd();">저장</button>
				<button class="btn" onclick="self.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>