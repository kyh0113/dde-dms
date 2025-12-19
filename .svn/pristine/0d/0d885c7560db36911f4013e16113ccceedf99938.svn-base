<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Modal -->
<div class="modal fade" id="menuAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" style="width:600px;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">SUB메뉴 등록</h4>
      </div>
      <form id="menuAddForm">
      	  <!-- 20191023_khj for csrf -->
		  <input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
      	  <input type="hidden" id="menuAddModal_updeptlvl_code" name="menuAddModal_updeptlvl_code" value="">
      	  <input type="hidden" id="menuAddModal_updept_line" name="menuAddModal_updept_line" value="">
	      <div class="modal-body">
	      		<div class="popup_tblType01" style="margin:0">
		      	  <table  class="tableTypeInput" border="0" cellpadding="0" cellspacing="0">
		                <colgroup>
		                   <col width="120" />
		                   <col width="" />                                  
		                </colgroup>
		                <tr>
		                	<th scope="col">상위메뉴코드</th>
		                	<td><input type="text" class="form-control" id="menuAddModal_up_menu_code" name="menuAddModal_up_menu_code" readonly></td>
		                </tr>
		                <tr>
		                	<th scope="col">상위메뉴명</th>
		                	<td><input type="text" class="form-control" id="menuAddModal_up_menu_name" name="menuAddModal_up_menu_name" readonly></td>
		                </tr>
		                <tr>
		                	<th scope="col">메뉴명</th>
		                	<td><input type="text" class="form-control" maxlength="50" id="menuAddModal_menu_name" name="menuAddModal_menu_name"></td>
		                </tr>
		                <tr>
		                	<th scope="col">URL</th>
		                	<td><input type="text" class="form-control" maxlength="50" id="menuAddModal_menu_url" name="menuAddModal_menu_url"></td>
		                </tr>
		                <tr>
		                	<th scope="col">순서</th>
		                	<td><input type="text" class="form-control" maxlength="50" id="menuAddModal_menu_sort" name="menuAddModal_menu_sort"></td>
		                </tr>
		          </table>
		        </div>
	      </div>
	  </form>
      <div class="modal-footer">
      	<button id="btn_menuAdd_save" type="button" class="btn">저장</button>
        <button id="deptAdd_modal_close_btn" type="button" class="btn" data-dismiss="modal">취소</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>
$(document).ready(function(){
	
	$("#btn_menuAdd_save").on("click",function(){

		if(isEmpty(document.getElementById("menuAddModal_menu_name").value.trim())){
			swalWarning("메뉴명을 입력해주십시오.");
			return false;
		}
		
		if(isEmpty(document.getElementById("menuAddModal_menu_url").value.trim())){
			swalWarning("URL을 입력해주십시오.");
			return false;
		}
		
		if(isEmpty(document.getElementById("menuAddModal_menu_sort").value.trim())){
			swalWarning("순서를 입력해주십시오.");
			return false;
		}
		
		var oForm = $("#menuAddForm").serializeArray();
		var oFormArray = gPostArray(oForm);
		$.ajax({
			type: 'POST',
			url: '/core/staff/menu/addSubMenu',
			data: oFormArray,
			dataType: 'json',
			//async : false,
			success: function(data){
				if(data.result > 0){
					swalSuccess("SUB메뉴 등록되었습니다.");
					$("#menuAddModal").modal("hide");
					treeRecall({_csrf : "${_csrf.token}"}, "/core/staff/menu/menuTree", "#menuTree", "#");
				}else{
					swalWarning("SUB메뉴 등록 실패했습니다.");
				}
			}
		});
	});
	
	$("#menuAddModal").on("hide.bs.modal",function(){
		document.getElementById("menuAddModal_up_menu_code").value="";
		document.getElementById("menuAddModal_up_menu_name").value="";
		document.getElementById("menuAddModal_menu_name").value="";
		document.getElementById("menuAddModal_menu_url").value="";
		document.getElementById("menuAddModal_menu_sort").value="";
	})
	
});
</script>