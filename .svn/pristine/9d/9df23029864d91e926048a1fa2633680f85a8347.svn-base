<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Modal -->
<div class="modal fade" id="topMenuAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" style="width:600px;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">TOP 메뉴등록</h4>
      </div>
      <form id="topMenuAddForm">
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
		                	<th scope="col">메뉴명</th>
		                	<td><input type="text" class="form-control" maxlength="50" id="topMenuAddModal_menu_name" name="topMenuAddModal_menu_name"></td>
		                </tr>
		                <tr>
		                	<th scope="col">URL</th>
		                	<td><input type="text" class="form-control" maxlength="50" id="topMenuAddModal_menu_url" name="topMenuAddModal_menu_url" value="/"></td>
		                </tr>
		                <tr>
		                	<th scope="col">순서</th>
		                	<td><input type="text" class="form-control" maxlength="50" id="topMenuAddModal_menu_sort" name="topMenuAddModal_menu_sort"></td>
		                </tr>
		          </table>
		        </div>
	      </div>
	  </form>
      <div class="modal-footer">
      	<button id="btn_top_save" type="button" class="btn">저장</button>
        <button id="btn_top_cancle" type="button" class="btn" data-dismiss="modal">취소</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>
$(document).ready(function(){
	
	$("#btn_top_save").on("click",function(){
		if(isEmpty(document.getElementById("topMenuAddModal_menu_name").value.trim())){
			swalWarning("메뉴명을 입력해주십시오.");
			return false;
		}
		if(isEmpty(document.getElementById("topMenuAddModal_menu_url").value.trim())){
			swalWarning("URL을 입력해주십시오.(default : /)");
			return false;
		}
		if(isEmpty(document.getElementById("topMenuAddModal_menu_sort").value.trim())){
			swalWarning("순서를 입력해주십시오.");
			return false;
		}
		
		var oForm = $("#topMenuAddForm").serializeArray();
		var oFormArray = gPostArray(oForm);
		$.ajax({
			type: 'POST',
			url: '/core/staff/menu/addTopMenu',
			data: oFormArray,
			dataType: 'json',
			//async : false,
			success: function(data){
				if(data.result > 0 ){
					swalSuccess("TOP메뉴 등록되었습니다.");
					$("#topMenuAddModal").modal("hide");
					treeRecall({_csrf : "${_csrf.token}"}, "/core/staff/menu/menuTree", "#menuTree", "#");
				}else{
					swalWarning("TOP메뉴 등록 실패했습니다.");
				}
			}
		});
	});
	
	$("#topMenuAddModal").on("hide.bs.modal",function(){
		document.getElementById("topMenuAddModal_menu_name").value="";
		document.getElementById("topMenuAddModal_menu_url").value="";
		document.getElementById("topMenuAddModal_menu_sort").value="";
	})
	
});
</script>