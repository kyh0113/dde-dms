<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Modal -->
<div class="modal fade" id="deptAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" style="width:600px;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">부서등록</h4>
      </div>
      <form id="deptAddForm">
      	  <!-- 20191023_khj for csrf -->
		  <input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
      	  <input type="hidden" id="deptAddModal_term_code" name="deptAddModal_term_code" value="">
      	  <input type="hidden" id="deptAddModal_updeptlvl_code" name="deptAddModal_updeptlvl_code" value="">
      	  <input type="hidden" id="deptAddModal_updept_line" name="deptAddModal_updept_line" value="">
	      <div class="modal-body">
	      		<div class="popup_tblType01" style="margin:0">
		      	  <table  class="tableTypeInput" border="0" cellpadding="0" cellspacing="0">
		                <colgroup>
		                   <col width="120" />
		                   <col width="" />                                  
		                </colgroup>
		                <tr>
		                	<th scope="col">상위부서코드</th>
		                	<td><input type="text" class="form-control" id="deptAddModal_updept_code" name="deptAddModal_updept_code" readonly></td>
		                </tr>
		                <tr>
		                	<th scope="col">상위부서명</th>
		                	<td><input type="text" class="form-control" id="deptAddModal_updept_name" name="deptAddModal_updept_name" readonly></td>
		                </tr>
		                <tr>
		                	<th scope="col">부서코드</th>
		                	<td><input type="text" class="form-control" maxlength="10" id="deptAddModal_dept_code" name="deptAddModal_dept_code"></td>
		                </tr>
		                <tr>
		                	<th scope="col">부서명</th>
		                	<td><input type="text" class="form-control" maxlength="50" id="deptAddModal_dept_name" name="deptAddModal_dept_name"></td>
		                </tr>
		          </table>
		        </div>
	      </div>
	  </form>
      <div class="modal-footer">
      	<button id="deptAdd_fianl_btn" type="button" class="btn btn-primary">저장</button>
        <button id="deptAdd_modal_close_btn" type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>
$(document).ready(function(){
	
	$("#deptAdd_fianl_btn").on("click",function(){
		if(isEmpty(document.getElementById("deptAddModal_dept_code").value.trim())){
			swalWarning("부서코드를 입력해주십시오.");
			return false;
		}
		if(isEmpty(document.getElementById("deptAddModal_dept_name").value.trim())){
			swalWarning("부서명을 입력해주십시오.");
			return false;
		}
		
		var oForm = $("#deptAddForm").serializeArray();
		var oFormArray = gPostArray(oForm);
		$.ajax({
			type: 'POST',
			url: '/icm/deptAdd',
			data: oFormArray,
			dataType: 'json',
			//async : false,
			success: function(data){
				if(data.result == -1 ){
					swalWarning("부서코드가 이미 존재합니다.");
				}else if(data.result == 1){
					swalSuccess("부서가 등록되었습니다.");
					$("#deptAddModal").modal("hide");
					treeRecall({termcode : $("#termcode option:selected").data("term-code"), _csrf : "${_csrf.token}"}, '/icm/deptList', "#deptTree", oFormArray.deptAddModal_dept_code);
				}else if(data.result == -2){
					swalWarning("최상위부서가 이미 존재합니다.");
				}
			}
		});
	});
	
	$("#deptAddModal").on("hide.bs.modal",function(){
		document.getElementById("deptAddModal_dept_code").value="";
		document.getElementById("deptAddModal_dept_name").value="";
	})
	
});
</script>