<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>업무프로세스 Flowchart</title>
</head>
<body>
<form id="plcDesignDoc_form">
<!-- 20191023_khj for csrf -->
<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
<input type="hidden" id="attach_no" name="attach_no">

	<section class="section">
		<h2 class="subTitle">업무프로세스 Flowchart</h2>
		<div class="searchTable">
				<table>
					<colgroup>
						<col style="width:86px">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row" class="textRight">통제기간</th>
							<td colspan="3" class="controlPeriod">
								<select class="form-control" id="termcode" name="termcode" style="display:none;">
							        <c:forEach var="terms" items="${termList}">
							        	<option value="${terms.term_code}" data-term-code="${terms.term_code}" data-close-yn="${terms.close_yn}" data-announce-date="${terms.ANNOUNCE_DATE}" data-year-end-test-yn="${terms.year_end_test_yn}" data-before-term-code="${terms.before_term_code}">${terms.term_name}</option>
							        </c:forEach>
							    </select>
								<div class="sel" style="max-width:440px;">
									<button id="termListView_btn" type="button" class="btn" onclick="dropDown(this);">
										${termList[0].term_name }
							          	<c:if test="${termList[0].close_yn eq 'Y'}">
							          		( <span class="end">종료</span> )
							          	</c:if>
							          	<c:if test="${termList[0].close_yn eq 'N'}">
							          		( <span class="ing">진행중</span> )
							          	</c:if>
									</button>
									<ul class="list" id="termListView">
										<c:forEach var="terms" items="${termList}">
								            <li>
								            	<a id="${terms.term_code}" href="#">${terms.term_name}
								            		<c:if test="${terms.close_yn eq 'Y' }">
								            			( <span class="end">종료</span> )
								            		</c:if>
								            		<c:if test="${terms.close_yn eq 'N' }">
								            			( <span class="ing">진행중</span> )
								            		</c:if>
								            	</a>
								            </li>
								        </c:forEach>
									</ul>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
		</div>
	</section>
	<section class="section boxItem2">
		<div class="box" style="width:40%;">
			<div class="selList treeWrap">
				<h5 class="tit" style="border-top-width:0px;border-left-width:0px;border-right-width:0px; margin-top: 0px !important;margin-bottom: 0px !important;">프로세스</h5>
				<div id="processTree" class="tree">
				</div>
			</div>
		</div>
		<div class="box" style="width:60%;">
			<div>
				<table class="tableTypeInput">
					   <colgroup>
		               	<col width="100" />
		                   <col width="" />                            
		               </colgroup>
		               <tr>
		               	 <th scope="col">업무프로세스</th>
		               	 <td>
		               	 	<input type="text" class="inputTxt" id="upprocess_name" name="upprocess_name" style="width:100%;" readonly>
		               	 	<input type="hidden" id="upprocess_id" name="upprocess_id">
		               	 </td>
		               </tr>
		               <tr>
		               	 <th scope="col">하위프로세스</th>
		               	 <td>
		               	 	<input type="text" class="inputTxt" id="process_name" name="process_name" style="width:100%;" readonly>
		               	 	<input type="hidden" id="process_id" name="process_id">
		               	 </td>
		               </tr>
		               <tr>
		                 <th scope="col">문서담당자</th>
		                 <td>
		                 	<input type="text" style="border-right:1px solid #d3d3d3;" class="inputTxt widthAuto" id="dept_name" name="dept_name" placeholder="" readonly>
		                    <input type="text" class="inputTxt" widthAuto" id="user_name" name="user_name" placeholder="" readonly>
		                    <input type="hidden" id="dept_code" name="dept_code">
		                    <input type="hidden" id="user_id" name="user_id">
		                   
		                    <button class="btnTypeS1" id="doc_manager_alloc_btn">지정</button>
		                 </td>                           
		               </tr>
		               <tr>
		               	 <th scope="col">Flowchart</th>
		                  <td>
		                    <div class="popup_tblType00">
				      	  		<table class="tableTypeInput file-table-short">
				                    <!--  
				                    <thead>
				                    	<tr>
				                            <td style="border:0px;">
				                               	 첨부할 파일을 끌어서 아래영역에 놓아 주십시오.
				                            </td>
				                        </tr>
				                    </thead>
				                    -->
				                    <input multiple="multiple"  type="file"  id="multifileselect" style="width:100%;"/>  
				                    <tbody id="fileTableTbody">
				                    </tbody>
				                </table>
				      	  	</div>
		                  </td>
		               </tr>              
					</tbody>
				</table>
			</div>
			<div class="btnWrap">
				<span class="right">
					<button id="plcDesignDoc_save_btn" type="button" class="btnTypeM">저장</button>
				</span>
			</div>	
		</div>
	</section>
</form>
<%@include file="./docManagerAlloc_modal.jsp"%>
<script>
$(document).ready(function(){
	treeListCall({termcode : $("#termcode option:selected").data("term-code"), _csrf : "${_csrf.token}"}, '/icm/processList', '#processTree');
	btnBlock();
	
	var fileDropZone = $("#fileTableTbody").fileDropDown({
		areaOpenText : "프로세스를 먼저 선택해주십시오.",
		areaOpen : true,
		fileSizeLimits : '<spring:eval expression="@config['file.fileSizeLimits']"/>',
		totalfileSizeLimits : '<spring:eval expression="@config['file.totalfileSizeLimits']"/>'
	});
	fileDropZone.setDropZone();
	
	$("#multifileselect").change(function(){
		fileDropZone.selectFile($("#multifileselect").get(0).files);
	})
	
	
	$('#processTree').on('changed.jstree', function (e, data) { //jstree 클릭 이벤트
	    if(data.action == "select_node"){
	    	var selectedNode = data.node.original;
	    	if(selectedNode.parent == "#"){
	    		document.getElementById("process_id").value = selectedNode.id.trim();
				document.getElementById("process_name").value = selectedNode.text;
	    	}else{
	    		var parentNode = $("#processTree").jstree("get_node", selectedNode.parent);
	    		document.getElementById("process_id").value = selectedNode.id.trim();
				document.getElementById("process_name").value = selectedNode.text;
				document.getElementById("upprocess_id").value = parentNode.id.trim();
				document.getElementById("upprocess_name").value = parentNode.text;
	    	}
	    	$.ajax({
				type: 'POST',
				url: '/icm/plcDesignDocDetail',
				data: {process_id : selectedNode.id.trim(), term_code : selectedNode.termcode},
				dataType: 'json',
				success: function(data){

					fileDropZone.area(true);
					var detail = data.plcDesignDocDetail;
					var fileList = data.fileList;
					var attach_no = "";
					document.getElementById("user_id").value = "";
					document.getElementById("user_name").value = "";
					document.getElementById("dept_code").value = "";
					document.getElementById("dept_name").value = "";
					
					if(!isEmpty(detail)){
						document.getElementById("user_id").value = detail.tester_id;
						document.getElementById("user_name").value = detail.emp_name;
						document.getElementById("dept_code").value = detail.dept_code;
						document.getElementById("dept_name").value = detail.dept_name;
						document.getElementById("attach_no").value = detail.attach_no;
					}
					fileDropZone.fileListLoad({
						url : "/biz/ICMFileList",
						param : {attach_no : detail.attach_no}
					});
				}
			});
	    	
	    	
	    };
	  }).jstree();
	  // create the instance
	  
	$("#termcode").on("change",function(){
		
		document.getElementById("dept_code").value = "";
		document.getElementById("dept_name").value = "";
		document.getElementById("user_id").value = "";
		document.getElementById("user_name").value = "";
		fileDropZone.fileListLoad({
			url : "/biz/ICMFileList",
			param : {}
		});
		treeRecall({termcode : $("#termcode option:selected").data("term-code"), _csrf : "${_csrf.token}"}, '/icm/processList', "#processTree","#");
		btnBlock();
	});
	
	$("#doc_manager_alloc_btn").on("click",function(){
		var selectedNode =  $("#processTree").jstree("get_selected");
		if(isEmpty(selectedNode)){
			swalWarning("프로세스를 선택해주십시오.");
			return false;
		}
		var $docManagerAllocModal = $("#docManagerAllocModal");
		$docManagerAllocModal.modal({
			backdrop : false,
			keyboard: false
		});
	});  
	
	$("#plcDesignDoc_save_btn").on("click",function(){
		var formData = fileDropZone.uploadFile("plcDesignDoc_form");
    	if(formData == false){
    		swalWarning("파일용량은 500MB를 초과할 수 없습니다.");
    		return false;
    	}
    	var user_id = document.getElementById("user_id").value;
//     	if(isEmpty(user_id)){
//     		swalWarning("담당자를 지정해주십시오.");
//     		return false;
//     	}
    	$.ajax({
		  	xhr: function(){
    			var xhr = new window.XMLHttpRequest();
    			xhr.upload.addEventListener("progress",function(e){
    				if(e.lengthComputable){
    					$(".progress").show();
    					$(".progress-bar-back").show();
    					/* console.log("Bytes Loaded : " + e.loaded);
    					console.log("Total Size:" + e.total);
    					console.log("Percentage Uploaded : " + (e.loaded/e.total)); */
    					
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
			type: 'POST',
			url: '/icm/plcDesignDocSave',
			data: formData,
			processData: false,
            contentType: false,
            dataType: 'json',
			success: function(data){
				if(data.result_code == -1){
					swalWarning("등록 불가 확장자 파일 입니다.");
				}else{
					swalSuccess("저장 되었습니다.");	
				}
				fileDropZone.fileListLoad({
					url : "/biz/ICMFileList",
					param : {attach_no : data.attach_no}
				});
				$("#progressBar").attr('aria-valuenow',100).css("width", 100+"%");
				$("#progress-bar-view").text(100+"%");
				$(".progress").hide();
				$(".progress-bar-back").hide();
			}
		});	 	  
	});
});

</script>
</body>