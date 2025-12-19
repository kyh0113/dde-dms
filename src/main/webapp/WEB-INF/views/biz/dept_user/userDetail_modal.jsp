<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Modal -->
<div class="modal fade" id="userDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" style="width:1000px;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="userDetailModal_label"></h4>
      </div>
      <div class="modal-body" style="height : 550px; overflow: auto;">
         <div id="popup_w_big" style="min-width:820.33px;">
				<div class="popup_tblType01">
		            <form id="userDetailForm">
		            <!-- 20191023_khj for csrf -->
					<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		            <input type="hidden" id="userDetailModal_photoimg_dir" name="userDetailModal_photoimg_dir">
		            <input type="hidden" class="inputTxt" id="emp_code_check" name="emp_code_check">
		            <table class="tableTypeInput" border="0" cellpadding="0" cellspacing="0">
		                <colgroup>
		                   <col width="120" />
		                   <col width="37%" /> 
		                   <col width="120" />
		                   <col width="" />                            
		                </colgroup>
		                <tr>
		                   <th scope="col" style="color:green;">사용자ID</th>
		                   <td id="emp_code_td">
		                       <input type="text" maxlength="10" class="inputTxt" id="userDetailModal_emp_code" name="userDetailModal_emp_code" readonly>
		                       <button id="id_check" class="btnTypeS1">중복체크</button> 	                       
		                   </td>  
		                   <th scope="col"  style="color:green;">성명</th>
		                   <td>                            	
		                       <input type="text"  maxlength="20" class="inputTxt" id="userDetailModal_emp_name" name="userDetailModal_emp_name" readonly>
		                   </td>                            
		                 </tr> 
		                  <tr>
		                   <th scope="col">소속부서</th>
		                   <td>
		                   		<input type="text" class="inputTxt" id="userDetailModal_dept_name" name="userDetailModal_dept_name" readonly>
		                   		<input type="hidden" class="inputTxt" id="userDetailModal_dept_code" name="userDetailModal_dept_code" readonly>
		                   </td>  
		                   <th scope="col">권한</th>
		                   <td>           
		                   	   <input type="hidden" class="inputTxt" id="userDetailModal_auth_code" name="userDetailModal_auth_code" readonly>	                 	
		                       <input type="text" class="inputTxt" id="userDetailModal_auth_name" name="userDetailModal_auth_name" readonly>
		                   </td>                            
		                </tr> 
		                 <tr>
		                   <th scope="col" style="color:green;">직책</th>
		                   <td>
		                       <select id="userDetailModal_position_code" name="userDetailModal_position_code">
		                                    <option selected value="">- 선택 -</option> 
		                                    <option value="select1">선임</option>  
		                                    <option value="select2">팀장</option>   
		                                    <option value="select2">팀원</option>                                   
		                        </select> 
		                   </td>  
		                   <th scope="col">E-mail 주소</th>
		                   <td>                            	
		                       <input type="text" maxlength="50" class="inputTxt" id="userDetailModal_email" name="userDetailModal_email">
		                   </td>                            
		                 </tr> 
		                 <tr>
		                   <th scope="col">전화번호</th>
		                   <td>
		                   		<input type="text"  maxlength="20" class="inputTxt" id="userDetailModal_tel_no" name="userDetailModal_tel_no">
		                   </td>  
		                   <th scope="col">팩스번호</th>
		                   <td>                            	
		                       <input type="text"  maxlength="20" class="inputTxt" id="userDetailModal_fax_no" name="userDetailModal_fax_no">
		                   </td>                            
		                 </tr>
		                 <tr>
		                   <th scope="col">핸드폰번호</th>
		                   <td>
		                   		<input type="text"  maxlength="20" class="inputTxt" id="userDetailModal_mobile_no" name="userDetailModal_mobile_no">
		                   </td>
		                   <th scope="col" style="color:green;"></th>
		                   <td>                            	
		                      
		                   </td>                                                
		                 </tr> 
		                 <tr>                    
		                   <th scope="col">암호초기화</th>
		                   <td>
		                   	  
		                   	  	<button id="resetPwd" class="btnTypeS1" style="height: auto;">암호초기화</button>
		                   	  
		                   </td>   
		                   <th scope="col">상태(사용여부)</th>
		                   <td>
		                   		<select id="userDetailModal_status" name="userDetailModal_status" class="inputTxt">
		                                    <option value="">- 선택 -</option> 
		                                    <option value="C" selected>Yes</option>  
		                                    <option value="D">No</option>                                                                      
		                        </select> 
		                   </td>                           
		                 </tr> 
		                 <tr>                   
		                   <th scope="col">결재싸인</th>
		                   <td class="span">
		                   		<input type="file" style="height: auto;" value="파일 업로드" class="upload form-control" id="userDetailModal_signimg_dir" name="userDetailModal_signimg_dir"> 
		                   </td> 
		                   <th scope="col">결재도장</th>
		                   <td  class="span">
		                   		<input type="file" style="height: auto;" value="파일 업로드" class="upload form-control" id="userDetailModal_stampimg_dir" name="userDetailModal_stampimg_dir"> 
		                   </td>                         
		                 </tr> 
		                 <tr>                   
		                   <th scope="col">싸인이미지</th>
		                   <td id="signimg_holder" style="text-align:center;">
		                   		<input type="hidden">
		                   		<img id="signimg_dir_src" src="" width="150" height="150" alt="">
		                   </td> 
		                   <th scope="col">도장이미지</th>
		                   <td id="stampimg_holder" style="text-align:center;">
		                   		<input type="hidden">
		                   		<img id="stampimg_dir_src" src="" height="150" width="150" alt="">
		                   </td>                         
		                 </tr>        
		               </table>
		               <input type="hidden" name="ie_bug" id="ie_bug" value=""/> 
		               </form>
		             </div>
				</div>	 
      </div>
      <div class="modal-footer">
      	<button id="user_register_final_btn" type="button" class="btn btn-primary">등록</button>
      	<button id="user_modify_final_btn" type="button" class="btn btn-primary">수정</button>
        <button id="userDetailModal_close" type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>
$(document).ready(function(){
	
	
	function getAlertText(name){
		switch(name){
		case "userDetailModal_dept_code" : return {text : "부서를 선택해주십시오.", code : 1}
			break;
		case "userDetailModal_dept_name" : return {text : "부서를 선택해주십시오.", code : 1}
			break;
		case "userDetailModal_emp_code" : return {text : "사용자 ID를 입력해주십시오.", code : 1}
			break;
		case "userDetailModal_emp_name" : return {text : "사용자 성명을 입력해주십시오.", code : 1}
			break;
		case "userDetailModal_position_code" : return {text : "직책을 선택해주십시오.", code : 1}
			break;
		case "userDetailModal_term_code" : return {text : "통제기간을 선택해주십시오.", code : 1}
			break;
		default : return {text : "", code : 0}
		break;
		}
	}
	
	function registerBtnDisabled(mode){
		if(mode == "Y"){
			document.getElementById("emp_code_check").value = "N";
// 			document.getElementById("user_register_final_btn").disabled = true;
		}else if(mode == "N"){
			document.getElementById("emp_code_check").value = "Y";
// 			document.getElementById("user_register_final_btn").disabled = false;
		}else if(mode == ""){/*2019-06-17 smh 시작 - 아이디를 입력해주세요 알림창 띄워주기 위해서 추가*/
			document.getElementById("emp_code_check").value = "";
		}
		/*2019-06-17 smh 끝*/
	}
	
	$("#resetPwd").on("click",function(){
		$.ajax({
			type: 'POST',
			url: '/icm/userPasswordReset',
			data: {emp_code : document.getElementById("userDetailModal_emp_code").value},//oFormArr,
			dataType: 'json',
			success: function(data){
					swalSuccess("비밀번호가 초기화 되었습니다.");
			}
	    });
	})
	
	$("#user_register_final_btn").on("click",function(){
				
		var oForm = $("#userDetailForm").serializeArray();
		var oFormArr = gPostArray(oForm);
// 		console.log(oFormArr);
		
		/* 2019-06-17-smh 시작 - 사원아이디를 입력해주세요 알림창 */
		if(document.getElementById("emp_code_check").value==""){
			swalWarning("사원아이디를 입력해주세요.");
			return false;
		}
		/* 2019-06-17-smh 끝 */
		/* 2019-06-14-smh 시작 - 이미 존재하는아이디 알림창 */
		if(document.getElementById("emp_code_check").value=="N"){
			swalWarning("이미 존재하는 아이디입니다.");
			return false;
		}
		/* 2019-06-14-smh 끝 */

		for(var key in oFormArr){
// 			console.log("key",key);
			if(isEmpty(oFormArr[key]) || oFormArr[key].trim() == ""){
				var getAlertTextResult = getAlertText(key);
				if(getAlertTextResult.code*1 == 1){
					swalWarning(getAlertText(key).text);
					return false;
				}
			}	
		}		
		
		swal({
			  icon : "info",
			  text: "사용자정보를 등록 하시겠습니까?",
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
				  	  var form = $("#userDetailForm")[0];
				  	  var data = new FormData(form);
				  	  data.append("IE",  "IE");
					  $.ajax({
							type: 'POST',
							url: '/icm/userPerInsert',
							data: data,//oFormArr,
							enctype: 'multipart/form-data',
							processData: false,
				            contentType: false,
				            cache: false,
							//async : false,
							success: function(data){
									$("#userDetailModal").modal("hide");
									swalSuccess("사용자정보가 등록되었습니다.");
									var selectedNode = $("#deptTree").jstree("get_selected");
// 									console.log(selectedNode[0]);
									expandNode("#deptTree",selectedNode[0]);
								
							}
					  });	
				  }
			});
		
	});
	
	$("#user_modify_final_btn").on("click",function(){
		var oForm = $("#userDetailForm").serializeArray();
		var oFormArr = gPostArray(oForm);
// 		console.log(oFormArr);
		
		swal({
			  icon : "info",
			  text: "사용자정보를 변경 하시겠습니까?",
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
					  var form = $("#userDetailForm")[0];
				  	  var data = new FormData(form);
					  $.ajax({
							type: 'POST',
							url: '/icm/userModify',
							data: data,
							enctype: 'multipart/form-data',
							processData: false,
				            contentType: false,
				            cache: false,
							dataType: 'json',
							//async : false,
							success: function(data){
								if(data.result*1 > 0){
									$("#userDetailModal").modal("hide");
									swalSuccess("사용자정보가 변경되었습니다.");
									$("#user_search_btn").trigger("click");
								}else{
									swalWarning("다시 시도해주십시오.");
								}
							}
						});	
				  }
			});
		
	});
	
	$(document).on("change","#userDetailModal_emp_code",function(){
		registerBtnDisabled("Y");
	});
	
	$(document).on("click","#id_check",function(){
		var emp_code = document.getElementById("userDetailModal_emp_code").value;
		if(isEmpty(emp_code) || emp_code.trim() == ""){
			swalWarning("사용자ID를 입력해주세요.");
			return false;
		}
		$.ajax({
			type: 'POST',
			url: '/icm/checkId',
			data: {uid : emp_code},
			dataType: 'json',
			//async : false,
			success: function(data){
				if(data.result*1 == 1){
					registerBtnDisabled("Y");
					swalWarning("이미 존재하는 ID 입니다.");
				}else{
					registerBtnDisabled("N");
					swalSuccess("등록 가능한 ID 입니다.");
				}
			}
		});	
		
	});
	
	/* 2019-06-14-smh 시작 - 사용자ID 포커스 없어질 때 동작이벤트(중복체크이벤트) */
	$(document).on('blur','#userDetailModal_emp_code',function(){
		var emp_code = document.getElementById("userDetailModal_emp_code").value;
		var userIdChk = document.getElementById("userIdChk");
		if(isEmpty(emp_code) || emp_code.trim() == ""){
// 			swalWarning("사원아이디를 입력해주세요.");
			/* 2019-06-17-smh 시작 - 사원아이디를 입력해달라는  알람창 띄워주기 위해서 추가 */
			registerBtnDisabled("");
			/* 2019-06-17-smh 끝 */
			userIdChk.innerHTML="사용자ID를 입력해주세요.";
			userIdChk.style.color="red";
			return false;
		}
		$.ajax({
			type: 'POST',
			url: '/icm/checkId',
			data: {uid : emp_code},
			dataType: 'json',
			async : false,
			success: function(data){
				if(data.result*1 == 1){
					registerBtnDisabled("Y");
					userIdChk.innerHTML="이미 존재하는 ID 입니다.";
					userIdChk.style.color="red";
				}else{
					registerBtnDisabled("N");
					userIdChk.innerHTML="등록 가능한 ID 입니다.";
					userIdChk.style.color="green";
				}
			}
		});	
	});
	/* 2019-06-14-smh 끝 */
	
	/* 2019-08-06-smh 시작 - 파일업로드하기위해 파일선택시 바로 사진띄워주기.(수정버튼 눌러야 저장됨) */
	$("#userDetailModal_signimg_dir").on('change', function() {
        //Get count of selected files
        var imgPath = $(this)[0].value;
        var extn = imgPath.substring(imgPath.lastIndexOf('.') + 1).toLowerCase();
        var signimg_holder = $("#signimg_holder");
        signimg_holder.empty();
        if (extn == "gif" || extn == "png" || extn == "jpg" || extn == "jpeg") {
          if (typeof(FileReader) != "undefined") {
            //loop for each file selected for uploaded.
              var reader = new FileReader();
              reader.onload = function(e) {
                $("<img />", {
                  "src": e.target.result,
                  "class": "thumb-image",
                  "id" : "signimg_dir_src",
                  "width" : "150",
                  "height" : "150",
                  "alt" : ""
                }).appendTo(signimg_holder);
              }
              signimg_holder.show();
              reader.readAsDataURL($(this)[0].files[0]);
          } else {
         	swalWarning("이 브라우저는 FileReader를 지원하지 않습니다.");
          }
        } else {
        	swalWarning("image파일을 선택해주세요.");
        }
      });
	
	$("#userDetailModal_stampimg_dir").on('change', function() {
        //Get count of selected files
        var imgPath = $(this)[0].value;
        var extn = imgPath.substring(imgPath.lastIndexOf('.') + 1).toLowerCase();
        var stampimg_holder = $("#stampimg_holder");
        stampimg_holder.empty();
        if (extn == "gif" || extn == "png" || extn == "jpg" || extn == "jpeg") {
          if (typeof(FileReader) != "undefined") {
              var reader = new FileReader();
              reader.onload = function(e) {
                $("<img />", {
                  "src": e.target.result,
                  "class": "thumb-image",
                  "id" : "stampimg_dir_src",
                  "width" : "150",
                  "height" : "150",
                  "alt" : ""
                }).appendTo(stampimg_holder);
              }
              stampimg_holder.show();
              reader.readAsDataURL($(this)[0].files[0]);
          } else {
        	  swalWarning("이 브라우저는 FileReader를 지원하지 않습니다.");
          }
        } else {
        	swalWarning("image파일을 선택해주세요.");
        }
      });
	/* 2019-08-06-smh 끝 */
	
});
</script>