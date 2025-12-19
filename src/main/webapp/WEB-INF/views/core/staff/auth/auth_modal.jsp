<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Modal -->
<div class="modal fade" id="authModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" style="width:600px;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">권한 설정</h4>
      </div>
      <form id="authModalForm">
      	  <!-- 20191023_khj for csrf -->
		  <input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	      <div class="modal-body">
	      		<div class="popup_tblType01" style="margin:0">
		      	  <table  class="tableTypeInput" border="0" cellpadding="0" cellspacing="0">
		                <colgroup>
		                   <col width="120" />
		                   <col width="" />                                  
		                </colgroup>
		                <tr>
		                	<th scope="col">권한코드</th>
		                	<td><input type="text" class="form-control" maxlength="50" id="authModal_auth_code" name="authModal_auth_code"></td>
		                </tr>
		                <tr>
		                	<th scope="col">권한명</th>
		                	<td><input type="text" class="form-control" maxlength="50" id="authModal_auth_name" name="authModal_auth_name"></td>
		                </tr>
		                <tr>
		                	<th scope="col">초기화면 URL</th>
		                	<td><input type="text" class="form-control" maxlength="50" id="authModal_auth_url" name="authModal_auth_url" value="/"></td>
		                </tr>
		          </table>
		        </div>
	      </div>
	  </form>
      <div class="modal-footer">
      	<button id="btn_auth_save" type="button" class="btn">저장</button>
        <button id="btn_auth_cancle" type="button" class="btn" data-dismiss="modal">취소</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>
$(document).ready(function(){
	
	$("#btn_auth_save").on("click",function(){
		if(isEmpty(document.getElementById("authModal_auth_code").value.trim())){
			swalWarning("권한코드를 입력해주십시오.");
			return false;
		}
		if(isEmpty(document.getElementById("authModal_auth_name").value.trim())){
			swalWarning("권한명을 입력해주십시오.");
			return false;
		}
		if(isEmpty(document.getElementById("authModal_auth_url").value.trim())){
			swalWarning("초기화면 URL을 입력해주십시오.(default : /)");
			return false;
		}
		
		var oForm = $("#authModalForm").serializeArray();
		var oFormArray = gPostArray(oForm);

		$.ajax({
			type: 'POST',
			url: '/core/staff/auth/mergeAuth',
			data: oFormArray,
			dataType: 'json',
			//async : false,
			success: function(data){
				if(data.result > 0 ){
					swalSuccess("권한 저장되었습니다.");
					$("#authModal").modal("hide");
					$("#btn_search").trigger("click");
				}else{
					swalWarning("권한 저장 실패했습니다.");
				}
			}
		});
	});
	
	$("#authModal").on("hide.bs.modal",function(){
		document.getElementById("authModal_auth_code").value="";
		document.getElementById("authModal_auth_name").value="";
		document.getElementById("authModal_auth_url").value="";
		$("#authModal_auth_code").prop("readonly", false);
	})
	
});
</script>