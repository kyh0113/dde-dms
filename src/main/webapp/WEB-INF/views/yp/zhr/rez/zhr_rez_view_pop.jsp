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
	리조트 예약결과
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
	
	function fnEntAdmission(){
		if(fnRegValidation()){
			
			var oForm = $("#frm").serializeArray();
			var oFormArray = gPostArray(oForm);

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
			//}
			
			/*
				$('#frm').ajaxForm({
					//url: "/yp/zwc/ent/createAccessControl",
					url: "/yp/zhr/rez/createResortReservControl",
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
				    }*/
				});
				//$("#frm").submit();
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
		}else if("F" == $("select[name=status] :checked").val()){
			if("" == $("input[name=refuse_reason]").val()){
				swalWarningCB("반려사유를 입력해주세요.", function(){
					$("select[name=refuse_reason]").focus();
				});
			return false;
			}
			return true;
			
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
	

	// 리조트  선택
	function fn_change_resort_name(){
		// 반 초기화
		fn_clear_desire_area();
		
		var resort_name = $("select[name=resort_name] :checked").val();
		console.log("resort_name ::::::: " + resort_name)
		if(typeof resort_name === "undefined" || resort_name === ""){
			return false;
		}
		// 하위 반 조회 및 출력
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			url : "/yp/zhr/rez/resortRegionList",
			type : "POST",
			cache : false,
			async : true,
			dataType : "json",
			data : {
				"resort_cd" : resort_name,
				"zclss" : "${zclss}",
				"schkz" : "${schkz}"
			},
			success : function(result) {
				console.log("result --> " + result);
				if(typeof result.list !== "undefined" && result.list.length > 0){
					$.each(result.list, function(i, d){
						console.log("result.list --> " + i, d);
						$("select[name=desire_area]").append(new Option(d.REGION_NAME, d.REGION_CD));
					});
//						if("${req_data.auth}" === "SA" || "${req_data.auth}" === "MA"){
//							$("select[name=ser_group]").prepend(new Option("전체", ""));
//						}else if("${req_data.auth}" === "IM" || "${req_data.auth}" === "TM" || "${req_data.auth}" === "WM"){
//							$("select[name=ser_group]").prepend(new Option("전체", ""));
//						}
					$("select[name=desire_area] option:eq(0)").prop("selected", true);
					$("select[name=desire_area]").trigger("change");
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
				swalDangerCB("조회에 실패하였습니다.\n관리자에게 문의해주세요.");
			}
		});
		// 근무조 초기화
		// 하위 근무조 조회 및 출력
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
			리조트 예약 결과
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
							<th>성 명</th>
							<td>
								${resortRezlist.EMP_NAME}
								<input type="hidden" name="emp_cd" size="1" style="width:165px;" value="${req_data.empCode}" readonly="readonly" />
								<input type="hidden" name="seq" size="1" style="width:165px;" value="${req_data.seq}" readonly="readonly" />
							</td>
							<th>부 서</th>
							<td>
								${resortRezlist.DEPT_NAME}
								<input type="hidden" name="dept_cd" value="${req_data.userDeptCd}"/>
							</td>
						</tr>
						<tr>
							<th>연락처</th>
							<td>${resortRezlist.MOBILE_NO}</td>
							<th>이메일</th>
							<td>
								${resortRezlist.EMAIL}
							</td>
						</tr>
						<tr>
							<th>리 조 트 명</th>
							<td>${resortRezlist.RESORT_NAME}</td>
							<th>희 망 지 역</th>
							<td>${resortRezlist.REGION_NAME}</td>
						</tr>
						<tr>
							<th>신 청 사 유</th>
							<td>
								${resortRezlist.APPL_REASON}
							</td>
							<th>인 원 수</th>
							<td>
								${resortRezlist.PEOPLE_NUM} 명
							</td>
						</tr>
		
						<tr>
							<th>사 용 기 간</th>
							<td colspan="3" class="left">
								${resortRezlist.USE_PERIOD}
							</td>
						</tr>
						<tr>
							<th>선 호 객 실 타 입</th>
							<td colspan="3" class="left">
								${resortRezlist.ETC}
							</td>
						</tr>
						
						<tr>
							<th>상   태</th>
							<td colspan="3" class="left">
								<c:if test="${resortRezlist.STATUS eq 'S'}">
									승인
								</c:if>
								<c:if test="${resortRezlist.STATUS eq 'F'}">
									반려
								</c:if>
							</td>
						</tr>
						
						<tr>
							<th>내  용</th>
							<td colspan="3" class="left">
								${resortRezlist.REFUSE_REASON}
							</td>
						</tr>
						
						
						
					</table>
				</section>
			</form>
			<div class="btn_wrap">

				<button class="btn" onclick="self.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>