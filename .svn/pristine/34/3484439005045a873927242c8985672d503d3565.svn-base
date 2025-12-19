<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!-- Modal -->
<div class="modal fade" id="excelUploadModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="excelUploadModalLabel">엑셀업로드</h4>
      </div>
      <div class="modal-body">
      <form class="form-horizontal" id="elxcelUploadForm" enctype="multipart/form-data">
        <!-- 20191023_khj for csrf -->
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
      	<input name="excelfile" id="excelfile" type="file">
      	<input type="hidden" name="perpose_name" id="perpose_name">	
      </form>	 	
      </div>
      <div class="modal-footer">
      	<button id="excelUpload_upload_btn" type="button" class="btn btn-primary">업로드</button>
        <button id="excelUpload_upload_close" type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>
$(document).ready(function(){
	
	function elementMng(){
		var elxcelUploadForm = $("#elxcelUploadForm");
		elxcelUploadForm.children().remove();
		elxcelUploadForm.append('<input name="excelfile" id="excelfile" type="file">');	
	}
	
	$("#excelUpload_upload_btn").on("click",function(){
		$("#account_excel_upload").attr("disabled",true);
		if(isEmpty($("#excelfile").val())){
			swalWarning("파일이 없습니다.");
			return false;
		}
		var alertText = "";
		alertText = "업로드 하시겠습니까?";
			
		swal({
		  icon : "info",
		  text: alertText,
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
				  var form = $("#elxcelUploadForm")[0];
			      var formData = new FormData(form);
				  $.ajax({
			    		xhr: function(){
			    			var xhr = new window.XMLHttpRequest();
			    			xhr.upload.addEventListener("progress",function(e){
			    				if(e.lengthComputable){
			    					//console.log(e);
			    					$(".progress").show();
			    					$(".progress-bar-back").show();
			    					//console.log("Bytes Loaded : " + e.loaded);
			    					//console.log("Total Size:" + e.total);
			    					//console.log("Percentage Uploaded : " + (e.loaded/e.total));
			    					
			    					var percent = Math.round((e.loaded / e.total) * 100);
			    					if(percent == 100){
			    						percent = 99;
			    					}
			    					$("#progressBar").attr('aria-valuenow',percent).css("width", percent+"%");
			    					$("#progress-bar-view").text(percent+"%");
			    					
			    				}
			    			});
			    			
			    			return xhr;
			    		},
			            url: "/core/excel/excelUpload",
			            processData: false,
			            contentType: false,
			            data: formData,
			            type: 'POST',
			            success: function(data){
			            	if(JSON.parse(data).result == -1){
			            		swalWarning("업로드가 진행되지 않았습니다. 엑셀 데이터 확인 후 다시 업로드 해주십시오.");
			            	}else{
			            		swalSuccess("업로드 되었습니다.");
			            		$("#termcode").trigger("change");
			            	}
			            	elementMng();
			            	$("#excelUploadModal").modal("toggle");

			            	$("#progressBar").attr('aria-valuenow',100).css("width", 100+"%");
							$("#progress-bar-view").text(100+"%");
							$(".progress").hide();
							$(".progress-bar-back").hide(); 
							
			            }
			        });
			    	$("#account_excel_upload").attr("disabled",false);
			    	$("#excelUpload_upload_btn").attr("disabled",false);
			  }
		});	
	});
	
	$("#excelUpload_upload_close").on("click",function(){
		$("#account_excel_upload").attr("disabled",false);
		elementMng();
	});
});


</script>