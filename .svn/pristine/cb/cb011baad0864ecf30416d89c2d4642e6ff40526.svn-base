<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Modal -->
<div class="modal fade" id="masterCodeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" style="width:800px;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">리조트 코드관리</h4>
      </div>
      <form id="masterCodeForm">
		  <input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		  <input type="hidden" name="m_saveType" id="m_saveType" value="" />
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
		                	<th scope="col">리조트코드(*)</th>
		                	<td><input type="text" class="form-control" maxlength="50" id="m_resort_code" name="m_resort_code" readonly></td>
		                	<th scope="col">리조트코드명(*)</th>
		                	<td><input type="text" class="form-control" maxlength="50" id="m_resort_name" name="m_resort_name"></td>
		                </tr>
		                <tr>
		                	<th>&nbsp;</th>
		                	<td>&nbsp;</td>
		                	<th>&nbsp;</th>
		                	<td>&nbsp;</td>
		                </tr>
		                <tr>
		                	<th scope="col">사용유무(*)</th>
		                	<td colspan="3">
		                		<label class="checkbox-inline" style="margin-bottom:-4px;margin-left:10px;">
		                			<input type="radio" name="m_resort_status" id="m_resort_status" value="Y" checked>사용
		                		</label>
		                		<label class="checkbox-inline" style="margin-bottom:-4px;margin-left:10px;">
		                			<input type="radio" name="m_resort_status" id="m_resort_status" value="N">미사용
		                		</label>
		                	</td>
		                </tr>
		          </table>
		        </div>
	      </div>
	  </form>
	  <div class="modal-footer">
		  <button id="btn_resort_save" type="button" class="btn">저장</button>
		  <button id="btn_resort_cancle" type="button" class="btn" data-dismiss="modal">취소</button>
	  </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>
$(document).ready(function(){
	
	$("#btn_resort_save").on("click",function(){
		
		
		let mSaveType = document.getElementById("m_saveType").value;
		if(mSaveType == "MOD"){
			
			
			
			if(isEmpty(document.getElementById("m_resort_code").value.trim())){
				swalWarning("리조트코드를 입력해주십시오.");
				return false;
			}
			if(isEmpty(document.getElementById("m_resort_name").value.trim())){
				swalWarning("리조트코드명을 입력해주십시오.");
				return false;
			}
			if(isEmpty(document.getElementById("m_resort_status").value.trim())){
				swalWarning("사용유무를 선택해주십시오.");
				return false;
			}
			
			
			var oForm = $("#masterCodeForm").serializeArray();
			var oFormArray = gPostArray(oForm);

			$.ajax({
				type: 'POST',
				url: "/yp/zhr/rez/mergeResortCode",
				data: oFormArray,
				dataType: 'json',
				//async : false,
				success: function(data){
					if(data.result > 0 ){
						swalSuccess("저장되었습니다.");
						$("#masterCodeModal").modal("hide");
						angular.element(document.getElementById("masterCodeCtrl-uiGrid")).scope().reloadGrid(gPostArray($("#master_frm").serializeArray()));
						angular.element(document.getElementById("detailCodeCtrl-uiGrid")).scope().reloadGrid(gPostArray($("#master_frm").serializeArray()));
					}else{
						swalWarning("저장 실패했습니다.");
					}
				}
			});
			
			
		}else if(mSaveType == "REG"){

			if(isEmpty(document.getElementById("m_resort_name").value.trim())){
				swalWarning("리조트코드명을 입력해주십시오.");
				return false;
			}
			if(isEmpty(document.getElementById("m_resort_status").value.trim())){
				swalWarning("사용유무를 선택해주십시오.");
				return false;
			}
			
			
			var oForm = $("#masterCodeForm").serializeArray();
			var oFormArray = gPostArray(oForm);

			$.ajax({
				type: 'POST',
				url: "/yp/zhr/rez/createResortCode",
				data: oFormArray,
				dataType: 'json',
				//async : false,
				success: function(data){
					if(data.result > 0 ){
						swalSuccess("저장되었습니다.");
						$("#masterCodeModal").modal("hide");
						angular.element(document.getElementById("masterCodeCtrl-uiGrid")).scope().reloadGrid(gPostArray($("#master_frm").serializeArray()));
					}else{
						swalWarning("저장 실패했습니다.");
					}
				}
			});
			
		}

	});
	
	$("#masterCodeModal").on("hide.bs.modal",function(){
		
	})
	
});
</script>