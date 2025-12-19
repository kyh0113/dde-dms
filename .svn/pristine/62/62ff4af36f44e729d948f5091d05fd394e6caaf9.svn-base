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
	<c:if test="${req_data.TYPE eq 'REG'}">리조트 예약승인관리</c:if>
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
		$(document).on("focus", ".dtp", function(){
			$(this).datepicker({
				format : "yyyy/mm/dd",
				language : "ko",
				todayHighlight : true,
				autoclose : true,
				clearBtn : true,
				updateViewDate : false
			}).on('changeDate', function (ev){
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
	
	function fnEntAdmission(){

		if(fnRegValidation()){
			
			var oForm = $("#frm").serializeArray();
			var oFormArray = gPostArray(oForm);

			swal({
				  icon : "info",
				  text: "저장 하시겠습니까?",
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
				
					$.ajax({
						type: 'POST',
						url: '/yp/zhr/rez/resortRefuseControl',
						data: oFormArray,
						dataType: 'json',
						//async : false,
						success: function(data){
							if(data.result_code == "1" ){
								swalSuccess("저장되었습니다.");
								//$("#btn_search").trigger("click");
								
								opener.$("#search_btn").trigger("click");
								
								//opener.parent.fnSearchData();
								//window.open('', '_self').close();
								
								self.close();
								
							}else{
								swalWarning("저장 실패했습니다.");
							}
						}
					
					});

				})
		}
	}
	
	function fnEntUpd(){

		if(fnRegValidation()){

			$('#frm').ajaxForm({
				//url: "/yp/zwc/ent/updateAccessControl",
				url: '/yp/zhr/rez/createResortReservControl',
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
		
		if("" == $("select[name=user_name]").val()){
			swalWarningCB("성명을 입력해주세요.", function(){
				$("input[name=user_name]").focus();
			});
			return false;
		}else if("" == $("input[name=dept_name]").val()){
			swalWarningCB("부서를 입력해주세요.", function(){
				$("input[name=dept_name]").focus();
			});
			return false;
		}else if("" == $("input[name=mobile_no]").val()){
			swalWarningCB("연락처를 입력해주세요.", function(){
				$("input[name=mobile_no]").focus();
			});
			return false;
		}else if("" == $("input[name=email]").val()){
			swalWarningCB("이메일을 입력해주세요.", function(){
				$("input[name=email]").focus();
			});
			return false;
		}else if("" == $("select[name=status] :checked").val()){
			swalWarningCB("상태를 선택해주세요.", function(){
				$("select[name=status]").focus();
			});
			return false;
			
			/*
			var resort_name = $("select[name=resort_name] :checked").val();
			console.log("resort_name ::::::: " + resort_name)
			if(typeof resort_name === "undefined" || resort_name === ""){
				return false;
			}
			*/
		/*
		}else if("F" == $("select[name=status] :checked").val()){
			if("" == $("input[name=refuse_reason]").val()){
				swalWarningCB("반려사유를 입력해주세요.", function(){
					$("select[name=refuse_reason]").focus();
				});
			return false;
			}
			return true;
		}
		*/
		
		}else if("" == $("input[name=refuse_reason]").val()){
			swalWarningCB("사유를 입력해주세요.", function(){
				$("select[name=refuse_reason]").focus();
			});
			return false;
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

	function fn_change_status(){
		// 반려 사유 hidden 처리
		var status_s = $("select[name=status] :checked").val();
		if(status_s === "F"){
			$("#refuse_area").css("display", "");
		}else{
			$("input[name=refuse_reason]").val("")
			$("#refuse_area").css("display", "none");
		}
	}

	// 희망지역 초기화
	function fn_clear_desire_area(){
		$("select[name=desire_area]").empty();
		$("select[name=desire_area]").prepend(new Option("--선 택--", ""));
	}

</script>
</head>
<body>
	<div id="popup">
		<div class="pop_header">
			리조트 예약 상태(승인대기)
		</div>
		<div class="pop_content">
			<form id="frm" name="frm" method="post">
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
							<th style="width:18%;">성 명</th>
							<td>
								${req_data.emp_name}
								<input type="hidden" name="emp_cd" size="1" style="width:165px;" value="${req_data.empCode}" readonly="readonly" />
								<input type="hidden" name="seq" size="1" style="width:165px;" value="${req_data.seq}" readonly="readonly" />
							</td>
							<th style="width:18%;">사 번</th>
							<td>
								${req_data.emp_cd}
							</td>
						</tr>

						<tr>
							<th style="width:18%;">부 서</th>
							<td>
								${req_data.dept_name}
								<input type="hidden" name="dept_cd" value="${req_data.userDeptCd}"/>
							</td>
							<th style="width:18%;">직 급</th>
							<td>
								${req_data.pos_nm}
							</td>
						</tr>

						<tr>
							<th>연락처</th>
							<td>${req_data.mobile_no}</td>
							<th>이메일</th>
							<td>
								${req_data.email}
							</td>
						</tr>

						<tr>
							<th>리 조 트 명</th>
							<td>${req_data.resort_name}</td>
							<th>희 망 지 역</th>
							<td>${req_data.desire_area}</td>
						</tr>

						<tr>
							<th>신 청 사 유</th>
							<td>
								${req_data.appl_reason}
							</td>
							<th>인 원 수</th>
							<td>
								${req_data.people_num} 명
							</td>
						</tr>

						<tr>
							<th>사 용 기 간</th>
							<td colspan="3" class="left">
								${req_data.use_period}
							</td>
						</tr>

						<tr>
							<th>선 호 객 실 타 입</th>
							<td colspan="3" class="left">
								${req_data.etc}
							</td>
						</tr>

						<tr>
							<th>상   태<span class="require">*</span></th>
							<td colspan="3" class="left">
								<select name="status"> <!-- onchange="fn_change_status()" -->
									<option value="">--선 택--</option>
									<option value="S">승인</option>
									<option value="F">반려</option>
								</select>
							</td>
						</tr>

						<tr id="refuse_area"> <!-- style="display:none;" -->
							<th>내  용<span class="require">*</span></th>
							<td colspan="3" class="left">
								<input type="text" name="refuse_reason" style="width:570px;" value=""/>
							</td>
						</tr>

					</table>
				</section>
			</form>
			<div class="btn_wrap">
				<button class="btn" id="reg_btn" onclick="javascript:fnEntAdmission();">저장</button>
				<button class="btn" onclick="self.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>