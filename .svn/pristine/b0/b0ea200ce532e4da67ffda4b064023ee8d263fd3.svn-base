<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="input-group">
	<select class="form-control" id="fileList3" name="fileList3" style="width: auto; min-width:200px;">

	</select>
<span class="input-group-addon" style="padding:0px 0px;float : left; height:21px;"><button id="file_down3" class="white_btn_s" style="width:100%; height:100%;">파일다운</button></span>
</div>
<script>
$(document).ready(function(){
	$("#file_down3").on("click",function(){
		var attach_no = $("#fileList3 option:selected").data("attach");
		var ser_no = $("#fileList3 option:selected").data("ser");
		if(!(parseInt(attach_no)+parseInt(ser_no) > 0)){
			swalWarning("파일이 없습니다.");
			return false;
		}
		
    	var form = document.createElement("form");
    	var attach_no_element = document.createElement("input");
    	attach_no_element.name = "attach_no";
    	attach_no_element.value = attach_no;
    	attach_no_element.type = "hidden";
    	var ser_no_element = document.createElement("input");
    	ser_no_element.name = "ser_no";
    	ser_no_element.value = ser_no;
    	ser_no_element.type = "hidden";
    	
    	form.method = "post";
    	form.action = "/biz/ICMFileDownload";
    	
    	form.appendChild(attach_no_element);
    	form.appendChild(ser_no_element);
    	document.body.appendChild(form);
    	
    	form.submit();
    	form.remove();
		
	});
});
</script>
    