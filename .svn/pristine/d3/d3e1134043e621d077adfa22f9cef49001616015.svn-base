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
	<c:if test="${req_data.TYPE eq 'REG'}">리조트 예약 신청</c:if>
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
	
	function fnEntMod(){
		if(fnRegValidation()){
			
			var oForm = $("#frm").serializeArray();
			var oFormArray = gPostArray(oForm);
			
			swal({
				  icon : "info",
				  text: "예약 수정 하시겠습니까?",
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
				  if(result){
						$.ajax({
							type: 'POST',
							url: '/yp/zhr/rez/updateResortReservAdReg',
							data: oFormArray,
							dataType: 'json',
							//async : false,
							success: function(data){
								if(data.result_code == "1" ){
									swalSuccess("저장되었습니다.");
									opener.$("#search_btn").trigger("click");

									self.close();
									
								}else{
									swalWarning("저장 실패했습니다.");
								}
							}
							
						});
				  	  
				  }
				});

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
		}else if("" == $("select[name=resort_name] :checked").val()){
			swalWarningCB("리조트명을 선택해주세요.", function(){
				$("select[name=resort_name]").focus();
			}); 
			return false;
		}else if("" == $("select[name=desire_area] :checked").val()){
			swalWarningCB("희망지역을 선택해주세요.", function(){
				$("select[name=desire_area]").focus();
			}); 
			return false;
		}else if("" == $("select[name=people_num] :checked").val()){
			swalWarningCB("인원수를 선택해주세요.", function(){
				$("select[name=people_num]").focus();
			}); 
			return false;
			
			/*
			var resort_name = $("select[name=resort_name] :checked").val();
			if(typeof resort_name === "undefined" || resort_name === ""){
				swalWarningCB("리조트명을 선택해주세요.", function(){
					$("input[name=resort_name]").focus();
				}); 
				return false;
			}
			*/

/*
		}else if("" == $("input[name=etc]").val()){
			swalWarningCB("선호객실타입을 입력해주세요.", function(){
				$("input[name=etc]").focus();
			}); 
			return false;
*/

		}else if("" == $("input[name=use_period_s]").val()){
			swalWarningCB("사용기간 시작일을 입력해주세요.", function(){
				$("input[name=use_period_s]").focus();
			}); 
			return false;
		}else if("" == $("input[name=use_period_e]").val()){
			swalWarningCB("사용기간 종료일을 입력해주세요.", function(){
				$("input[name=use_period_e]").focus();
			}); 
			return false;
		}
		return true;
	}
	
	function fnImgRegPop(type){
		//window.open("/yp/popup/imgReg?type="+type,"imgRegPop","width=600,height=300");
		
		var csrf_element = document.createElement("input");
		csrf_element.name = "_csrf";
		csrf_element.value = "${_csrf.token}";
		csrf_element.type = "hidden";
		
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

	function fnFileDown11(url){
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

	function fnFileDownNew(){
		
		<%--
			server.xml 에 <Context docBase="D:/uploadFiles" path="/uploadFiles" reloadable="false" />
			가상 context Path 추가
		--%>
		var url = '/uploadFiles/rez_cont_file_url/';
		//var fileName = $("input[name=file_name]").val();
		var fileName = "20231129001634736_2023년소노리조트객실요금표.xlsx";
		var fileDownloadUrl = url + fileName;
		// alert(url);
		if(url == ""){
			swalWarningCB("파일다운로드 경로가 없습니다. 관리자에게 문의해주세요.");
			return false;
		}

		/*
			서버사이드 파일 존재유무 체크
		*/
		$.ajax({
		    url: fileDownloadUrl,
		    type: 'HEAD',
		    error: function() {
		        //file not exists
		        swalWarningCB("다운로드 가능한 파일이 없습니다.\n" + fileDownloadUrl + "\n 관리자에게 문의해주세요.");
		    },
		    success: function() {
		        //file exists
		    	
		    	var a = document.createElement('a');
		        a.href = fileDownloadUrl; // window.URL.createObjectURL(url+fileName); // xhr.response is a blob
		        a.download = fileName; // Set the file name.
		        a.style.display = 'none';
		        document.body.appendChild(a);
		        a.click();
		        delete a;
		        
		    }
		});
		
	}

	function fnFileDown(){
		var url = $("input[name=file_url]").val() + $("input[name=file_name]").val();
		console.log(url);
		
		if(url == ""){
			swalWarningCB("파일다운로드 경로가 없습니다. 관리자에게 문의해주세요.");
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

</script>
</head>
<body>
	<div id="popup">
		<div class="pop_header">
			리조트 예약 신청
		</div>
		<div class="pop_content">
			<form id="frm" name="frm" method="post">
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="file_url" id="file_url" value="/rez_cont_file_url/">
				<input type="hidden" name="file_name" id="file_name" value="20231129001634736_2023년소노리조트객실요금표.xlsx" readonly="readonly">
				
		        <!-- /uploadFiles/rez_cont_file_url/ -->
				
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
							<!-- <td><input type="text" name="emp_name" size="1" style="width:165px;" value="${data[0].EMP_NAME}"/></td> -->
							<td><input type="text" name="emp_name" size="1" style="width:165px;" value="${resortRezlist.EMP_NAME}" readonly="readonly" />
							<input type="hidden" name="emp_cd" size="1" style="width:165px;" value="${resortRezlist.EMP_CD}" readonly="readonly" />
							<input type="hidden" name="seq" size="1" style="width:165px;" value="${resortRezlist.SEQ}" readonly="readonly" />
							<th>사 번</th>
							<td><input type="text" name="emp_cd" size="1" style="width:165px;" value="${resortRezlist.EMP_CD}" readonly="readonly" /></td>
						</tr>
						<tr>
							<th>부 서</th>
							<td>
								<input type="text" name="dept_name" size="1" style="width:165px;" value="${resortRezlist.DEPT_NAME}" readonly="readonly" />
								<input type="hidden" name="dept_cd" value="${resortRezlist.DEPT_CD}" />
							</td>
							<th>직 급</th>
							<td>
								<input type="text" name="pos_nm" size="1" style="width:165px;" value="${resortRezlist.POS_NM}" readonly="readonly" />
							</td>
						</tr>
						<tr>
							<th>연락처<span class="require">*</span></th>
							<td><input type="text" name="mobile_no" maxlength="11" style="width:165px;" value="${resortRezlist.MOBILE_NO}" onkeydown="return onlyNumberKey(event);" onkeyup="removeChar(event);" placeholder="- 없이 입력" /></td>
							<th>이메일<span class="require">*</span></th>
							<td>
								<input type="text" name="email" maxlength="100" style="width:150px;" value="${resortRezlist.EMAIL}" />
							</td>
						</tr>
						<tr>
							<th>리 조 트 명<span class="require">*</span></th>
							<td>
								<select name="resort_name" style="width:165px;" onchange="fn_change_resort_name()" >
									<c:if test="${fn:length(resortlist) != 0}">
										<option value="">--선 택--</option>
									</c:if>
									<c:forEach var="e" items="${resortlist}" varStatus="i" >
										<option value="${e.RESORT_CD}" <c:if test="${e.RESORT_CD eq resortRezlist.RESORT_CD}">selected</c:if>>${e.RESORT_NAME}</option>
									</c:forEach>
								</select>
							</td>
							<th>희 망 지 역<span class="require">*</span></th>
							<td>
							    <select name="desire_area" style="width:165px;">
									<c:if test="${fn:length(regionlist) != 1}">
										<option value="">--선 택--</option>
									</c:if>
									<c:forEach var="e" items="${regionlist}" varStatus="i" >
										<option value="${e.REGION_CD}" <c:if test="${e.REGION_CD eq resortRezlist.REGION_CD}">selected</c:if>>${e.REGION_NAME}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>신 청 사 유</th>
							<td>
								<input type="text" name="appl_reason" style="width:300px;"  value="${resortRezlist.APPL_REASON}"/>
							</td>
							<th>인 원 수<span class="require">*</span></th>
							<td>
								<select name="people_num" style="width:30px;" >
									<option value="">--선 택--</option>
									<c:forEach var="i" begin="1" end="8" step="1" >
										<option value="${i}" <c:if test="${i eq resortRezlist.PEOPLE_NUM}">selected</c:if>>${i}</option>
									</c:forEach>
								</select> &nbsp; 명
							</td>
						</tr>
						<tr>
							<th>사 용 기 간<span class="require">*</span></th>
							<td colspan="3"><input name="use_period_s" id="use_period_s" class="dtp calendar" style="width:165px;" value="${resortRezlist.USE_PERIOD_S}"/>  ~  <input name="use_period_e" id="use_period_e" class="dtp calendar" style="width:165px;" value="${resortRezlist.USE_PERIOD_E}"/></td>
						</tr>
						<tr>
							<th>선 호 객 실 타 입</th>
							<td colspan="3" class="left">
								<input type="text" name="etc" style="width:570px;"  value="${resortRezlist.ETC}"/>
							</td>
						</tr>
						<tr>
							<th>상   태</th>
							<td colspan="3" class="left">
								<select name="status"> <!-- onchange="fn_change_status()" -->
									<option value="S" <c:if test="${'S' eq resortRezlist.STATUS}">selected</c:if>>승인</option>
									<option value="F" <c:if test="${'F' eq resortRezlist.STATUS}">selected</c:if>>반려</option>
								</select>
							</td>
						</tr>
						<tr id="refuse_area"> <!-- style="display:none;" -->
							<th>내  용</th>
							<td colspan="3" class="left">
								<input type="text" name="refuse_reason" style="width:570px;" value="${resortRezlist.REFUSE_REASON}"/>
							</td>
						</tr>
						<!--
						<tr>
							<th>요 금 참 고 표<span class="require">*</span></th>
							<td colspan="3" class="left">
							<a href="javascript:void(0);" onclick="fnFileDown();">2023년 소노리조트 객실 요금표</a>
							</td>
						</tr>
						-->
					</table>
				</section>
			</form>
			<div class="btn_wrap">
				<button class="btn" id="reg_btn" onclick="javascript:fnEntMod();">예약수정</button>
				<button class="btn" onclick="self.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>