<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Modal -->
<div class="modal fade" id="masterCodeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" style="width:800px;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">마스터 코드관리</h4>
      </div>
      <form id="masterCodeForm">
      	  <!-- 20191023_khj for csrf -->
		  <input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	      <div class="modal-body">
	      		<div class="popup_tblType01" style="margin:0">
		      	  <table  class="tableTypeInput" border="0" cellpadding="0" cellspacing="0">
		                <colgroup>
		                   <col width="20%" />
		                   <col width="30%" />
		                   <col width="20%" />
		                   <col width="30%" />                                   
		                </colgroup>
		                <tr>
		                	<th scope="col">마스터코드(*)</th>
		                	<td><input type="text" class="form-control" maxlength="50" id="m_master_code" name="m_master_code"></td>
		                	<th scope="col">마스터코드명(*)</th>
		                	<td><input type="text" class="form-control" maxlength="50" id="m_master_name" name="m_master_name"></td>
		                </tr>
		                <tr>
		                	<th scope="col">순번(*)</th>
		                	<td><input type="text" class="form-control" maxlength="50" id="m_master_sort" name="m_master_sort" placeholder="숫자만 입력"></td>
		                	<th scope="col" rowspan="2">메모</th>
		                	<td rowspan="2"><textarea class="form-control" rows="3" maxlength="50" id="m_master_note" name="m_master_note"></textarea></td>
		                </tr>
		                <tr>
		                	<th scope="col">사용유무(*)</th>
		                	<td>
		                		<label class="checkbox-inline" style="margin-bottom:-4px;margin-left:10px;">
		                			<input type="radio" name="m_master_use" id="m_master_use" value="Y" checked>사용
		                		</label>
		                		<label class="checkbox-inline" style="margin-bottom:-4px;margin-left:10px;">
		                			<input type="radio" name="m_master_use" id="m_master_use" value="N">미사용
		                		</label>
		                	</td>
		                </tr>
		          </table>
		        </div>
	      </div>
	  </form>
	  <div class="modal-footer">
		  <button id="btn_master_save" type="button" class="btn">저장</button>
		  <button id="btn_master_cancle" type="button" class="btn" data-dismiss="modal">취소</button>
	  </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>
$(document).ready(function(){
	
	$("#btn_master_save").on("click",function(){
		if(isEmpty(document.getElementById("m_master_code").value.trim())){
			swalWarning("마스터코드를 입력해주십시오.");
			return false;
		}
		if(isEmpty(document.getElementById("m_master_name").value.trim())){
			swalWarning("마스터코드명을 입력해주십시오.");
			return false;
		}
		if(isEmpty(document.getElementById("m_master_sort").value.trim())){
			swalWarning("순번을 입력해주십시오.");
			return false;
		}
		if(isEmpty(document.getElementById("m_master_use").value.trim())){
			swalWarning("사용유무를 선택해주십시오.");
			return false;
		}
		
		
		var oForm = $("#masterCodeForm").serializeArray();
		var oFormArray = gPostArray(oForm);

		$.ajax({
			type: 'POST',
			url: '/core/staff/code/mergeMasterCode',
			data: oFormArray,
			dataType: 'json',
			//async : false,
			success: function(data){
				if(data.result > 0 ){
					swalSuccess("저장되었습니다.");
					$("#masterCodeModal").modal("hide");
					$("#btn_search").trigger("click");
				}else{
					swalWarning("저장 실패했습니다.");
				}
			}
		});
	});
	
	$("#masterCodeModal").on("hide.bs.modal",function(){
		
	})
	
});
</script>