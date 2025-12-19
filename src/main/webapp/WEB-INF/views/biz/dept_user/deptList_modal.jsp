<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<!-- Modal -->
<div class="modal fade" id="deptListModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" style="width:400px;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">이동할 부서 선택</h4>
      </div>
      <div class="modal-body">
        <div class="tree_box">
        	<div id="deptTree2"><!-- 부서트리가 들어감 --></div>
        </div>
      </div>
      <div class="modal-footer">
      	<button id="user_dept_modify_final_btn" type="button" class="btn btn-primary">저장</button>
        <button id="deptList_modal_close" type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>
$(document).ready(function(){
	var scope = angular.element(document.getElementById("div-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
	var u_deptcode = "";
	
	$('#deptTree2').on('changed.jstree', function (e, data) { //jstree 클릭 이벤트
	    if(data.action == "select_node"){
	    	var selectedNode = data.node.original;
	    	u_deptcode = selectedNode.id;
	    };
	  }).jstree();
	  // create the instance
	
	$("#user_dept_modify_final_btn").on("click",function(){

		var selectedRows = scope.gridApi.selection.getSelectedRows();
		var rowslength = selectedRows.length;
		for(var i=0; i<rowslength; i++){
			selectedRows[i].u_deptcode = u_deptcode;
		}
		var obj = {
			term_code : $("#termcode option:selected").data("term-code"), listString : JSON.stringify(selectedRows)	
		};
		$.ajax({
			type: 'POST',
			url: '/icm/user_dept_modify',
			data: obj,
			dataType: 'json',
			success: function(data){
				swalSuccess("수정 되었습니다.");
				$("#deptListModal").modal("toggle");
				$("#user_search_btn").trigger("click");
			}
		});	 
	});
	
	$("#deptList_modal_close").on("click",function(){
		$("#user_dept_modify_btn").attr("disabled",false);
	});
});


</script>