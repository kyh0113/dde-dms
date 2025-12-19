(function($){
	$.fn.fileListSelectDown = function(data){
		//empty select and download button generate
		var $this = $(this);
		var rand = Math.floor(Math.random() * 9000000000); // 0 ~ (max - 1) 까지의 정수 값을 생성
		
		//20191206_khj 업무프로세스 통제항목 상세보기시 flowchart명이 길면 화면이 늘어지는 현상 발견, 아래처럼 분기처리하여 조치
		var select = "";
		if($this[0].id == "plcDetailModal_designDoc"){
			select = '<select class="form-control" id="select'+rand+'" style="width: 120px;"></select>';
		}else{
			/* 2020-09-08 smh 수정 */
			/* class = "form-control"삭제 width, height, margin-right 추가 */
			select = '<select class="" id="select'+rand+'" style="width:250px; min-width:200px; height:37px !important; margin-right:3px;"></select>';
		}
		
		$this.empty();
		var button = "";
		
		button = '<span class="input-group-addon" style="margin="3px;" padding:0px 0px; float : left; width:auto;"><button id="file_down'+rand+'" class="btnTypeS1 btn btn_apply" style="line-height: 30px !important; width:100%; height:100%;">파일다운</button></span>';

		//20200508_khj 일괄다운로드 추가
		button += '<span class="input-group-addon" style="padding:0px 0px 0px 2px; float : left; width:auto;"><button id="file_down_all'+rand+'" class="btnTypeS1 btn btn_apply" style="line-height: 30px !important; width:100%; height:100%;">일괄다운</button></span>';

		$this.append(select + button);
		
		var $select = $("#select"+rand);
		if(!isEmpty(data) && data.length > 0){
			for(var i in data){
				$select.append("<option data-ser='"+data[i].ser_no+"' data-attach='"+data[i].attach_no+"'>"+data[i].src_file_name+"</option>");
			}
		}else{	//No file uploaded
			$select.parent("div").append("<span style='color:#3986AC; font-weight:bold;'>업로드 된 파일이 없습니다.</span>");
			$select.remove();
			$("#file_down"+rand).remove();
			$("#file_down_all"+rand).remove();
		}
		
		$(document).off("click","#file_down"+rand).on("click","#file_down"+rand,function(){
			var attach_no = $("#select"+rand+" option:selected").data("attach");
			var ser_no = $("#select"+rand+" option:selected").data("ser");
			//console.log(attach_no, ser_no);
			if(!(parseInt(attach_no)+parseInt(ser_no) > 0)){
				swalWarning("업로드 된 파일이 없습니다.");
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
		
		
		$(document).off("click","#file_down_all"+rand).on("click","#file_down_all"+rand,function(){
			var attach_no = $("#select"+rand+" option:selected").data("attach");
			var ser_no = $("#select"+rand+" option:selected").data("ser");
			//console.log(attach_no, ser_no);
			if(!(parseInt(attach_no)+parseInt(ser_no) > 0)){
				swalWarning("업로드 된 파일이 없습니다.");
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
	    	
	    	
	    	/*var term_code_element = document.createElement("input");
	    	term_code_element.name = "term_code";
	    	term_code_element.value = $("#termcode option:selected").data("term-code");
	    	if(term_code_element.value == "undefined"){	//대쉬보드화면은 #termcode 엘리먼트가 없어서, #m_termcode 엘리먼트로 대체
	    		term_code_element.value = $("#m_termcode option:selected").data("term-code");
	    	}
	    	term_code_element.type = "hidden";*/

			//20200908 smh for csrf
	    	var csrf_element = document.createElement("input");
	    	var csrfValue = document.getElementById("_csrf").value;
	    	csrf_element.name  = "_csrf";
	    	csrf_element.value = csrfValue;
	    	csrf_element.type  = "hidden";
	    	form.appendChild(csrf_element);
	    	//20200908 smh for csrf

	    	form.method = "post";
	    	form.action = "/icm/ICMFileDownloadAll";
	    	
	    	form.appendChild(attach_no_element);
	    	form.appendChild(ser_no_element);
	    	//form.appendChild(term_code_element);
	    	document.body.appendChild(form);
	    	
	    	form.submit();
	    	form.remove();
		});
		
		
	}
})(jQuery);