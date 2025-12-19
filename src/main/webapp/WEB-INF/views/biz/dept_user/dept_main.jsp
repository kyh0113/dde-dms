<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String s_dept_code = (String)request.getSession().getAttribute("s_dept_code") == null ? "" : (String)request.getSession().getAttribute("s_dept_code");
String s_emp_code = (String)request.getSession().getAttribute("s_emp_code") == null ? "" : (String)request.getSession().getAttribute("s_emp_code");
%>
<head>
<title>부서관리</title>
<style>
.reg_userDetailModal_emp_code{
	width:70%; position:relative; float:left;
}
.reg_id_check{
	position:relative; float:left; width:30%; height:36px;
}
</style>
</head>
<body>
	<section class="section">
		<h2 class="subTitle">부서관리</h2>
		<div class="searchTable">
			<form class="actschedForm" id="actsched">
				<!-- 20191023_khj for csrf -->
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<table>
					<colgroup>
						<col style="width:86px">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row" class="textRight"></th>
							<td class="controlPeriod">
								
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</section>
	<section class="section boxItem2">
		<div class="box" style="width:40%;">
			<h3 class="subTitle2">조직도</h3>
			<div class="treeWrap">
				<div id="deptTree" class="tree"><!-- 부서트리가 들어감 --></div>
			</div>
			<div class="btnWrap">
				<span class="right">
					<button type="button" id="firstDept_add" class="btnTypeM">최상위부서등록</button>
					<button type="button" id="excelDept_template_down_btn" class="btnTypeM">템플릿다운로드</button>
					<button type="button" id="excelDept_upload_btn" class="btnTypeM">업로드</button>
					<button type="button" id="excel_down_btn" class="btnTypeE"><i class="fas fa-download"></i>&nbsp;EXCEL</button>
				</span>
				<form id="excelDownForm" method="post" action="/core/excel/excelDown">
					<input type="hidden" id="listQuery" name="listQuery" value="biz_excel.deptExcel">
					<input type="hidden" id="filename" name="filename" value="dept_template">
					<input type="hidden" id="version" name="version" value="xlsx">
				</form>
			</div>
		</div>
		
		<div class="box" style="width:60%;">
			<h3 class="subTitle2">부서정보</h3>
			<div>
	    		<form class="deptForm" id="deptForm">
	    			<!-- 20191023_khj for csrf -->
					<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	    			<table class="tableTypeInput" border="0" cellpadding="0" cellspacing="0">
	    				<colgroup>
	                    	<col width="100" />
	                        <col width="" />                            
	                    </colgroup>
	                    <tr> 
	                      <th scope="col">상위부서코드</th>
	                      <td>
	                      	<input class="form-control" type="text" name="updept_code" id="updept_code" readonly>
	                      </td>                           
	                    </tr>
	                    <tr> 
	                      <th scope="col">상위부서명</th>
	                      <td>
	                      	<input class="form-control" type="text" name="updept_name" id="updept_name" readonly>
	                      </td>                           
	                    </tr>
	                    <tr>
	                      <th scope="col">부서코드</th>
	                      <td>
	                      	<input class="form-control" type="text" name="dept_code" id="dept_code" readonly>
	                      </td>                         
	                    </tr>
	                    <tr>
	                      <th scope="col">부서명</th>
	                      <td>
	                      	<input class="form-control" type="text" name="dept_name" id="dept_name" maxlength="50">
	                      </td>                           
	                    </tr>
	    			</table>
	    		</form>	
	   		</div>
	   		<div class="btnWrap">
	   			<span class="right">                               	
			        <button id="detp_modify_btn" class="btnTypeM">수정</button>
			        <button id="deptAdd_btn" class="btnTypeM">하위부서등록</button>                       	
			        <button id="deptDelete_btn" class="btnTypeM1">삭제</button>
		        </span>
	   		</div>
		</div>
	
	</section>

<%@include file="../excelUploadModal/excelUploadModal.jsp" %>
<%@include file="./deptAdd.jsp" %>
<script>
$(document).ready(function(){
	
	
	treeListCall({termcode : $("#termcode option:selected").data("term-code"), _csrf : "${_csrf.token}"}, '/icm/deptList', '#deptTree', "#");
	$('#deptTree').on('changed.jstree', function (e, data) { //jstree 클릭 이벤트

	    if(data.action == "select_node"){
	    	var selectedNode = data.node.original;

	    	document.getElementById("deptAddModal_term_code").value = selectedNode.term_code;
	    	document.getElementById("deptAddModal_updept_code").value = selectedNode.id;
	    	document.getElementById("deptAddModal_updeptlvl_code").value = selectedNode.deptlvl_code;
	    	document.getElementById("deptAddModal_updept_name").value = selectedNode.text;
	    	document.getElementById("deptAddModal_updept_line").value = selectedNode.dept_line;
	    	
	    	document.getElementById("updept_code").value = selectedNode.parent;
	    	document.getElementById("updept_name").value = selectedNode.updept_name;
	    	document.getElementById("dept_code").value = selectedNode.id;
	    	document.getElementById("dept_name").value = selectedNode.text;
	    	
	    };
	  }).jstree();
	  // create the instance
	
});
</script>
<script>
$(document).ready(function(){
	
	var scope = angular.element(document.getElementById("div-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
	
	$("#termcode").on("change",function(){
		treeRecall({termcode : $("#termcode option:selected").data("term-code"), _csrf : "${_csrf.token}"}, '/icm/deptList', "#deptTree","#");
	});
	
	$("#firstDept_add").on("click",function(){
		$("#deptTree").jstree("deselect_all");
		document.getElementById("deptForm").reset();
		document.getElementById("deptAddModal_term_code").value = $("#termcode option:selected").data("term-code");
    	document.getElementById("deptAddModal_updept_code").value = 0;
    	document.getElementById("deptAddModal_updeptlvl_code").value = 0;
    	document.getElementById("deptAddModal_updept_name").value = "최상위부서입니다.";
		
		$("#deptAddModal").modal({
			backdrop : false,
			keyboard: false
		});
		$("#deptAddModal").draggable({
		      handle: ".modal-header",
		      cursor : "move"
		});
	});
	
	$("#deptAdd_btn").on("click",function(){
		var selectedNode = $("#deptTree").jstree("get_selected");
		if(selectedNode.length == 0){
			swalWarning("상위부서를 선택해주십시오.");
			return false;
		}
		$("#deptAddModal").modal({
			backdrop : false,
			keyboard: false
		});
		$("#deptAddModal").draggable({
		      handle: ".modal-header",
		      cursor : "move"
		});
	});
	
	$("#deptDelete_btn").on("click",function(){
		var dept_code = document.getElementById("deptAddModal_updept_code").value;
		if(isEmpty(dept_code)){
			swalWarning("삭제 할 부서를 선택해주십시오.");
			return false;
		}
		swal({
			  icon : "info",
			  text: "선택한 부서의 하위부서와 사용자가 모두 삭제됩니다. 삭제하시겠습니까?",
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
					    var oForm = $("#deptAddForm").serializeArray();
						var oFormArray = gPostArray(oForm);
						oFormArray.term_code = oFormArray.deptAddModal_term_code;
						$.ajax({
							type: 'POST',
							url: '/icm/deptRemove',
							data: oFormArray,
							dataType: 'json',
							//async : false,
							success: function(data){
								if(data.result > 0){
									swalSuccess("부서가 삭제되었습니다.");
									treeRecall({termcode : $("#termcode option:selected").data("term-code"), _csrf : "${_csrf.token}"}, '/icm/deptList', "#deptTree","#");
								}
							}
						});
				  }
			});
	});
	
	$("#excelDept_template_down_btn").on("click",function(){
		var form = document.createElement("form");
    	var input = document.createElement("input");
    	input.name = "file_name";
    	input.value = "dept_template.xlsx";
    	input.type = "hidden";
    	
    	form.method = "post";
    	form.action = "/biz/ICMTemplateDownload";
    	
    	form.appendChild(input);
    	document.body.appendChild(form);
    	
    	form.submit();
    	form.remove();
	});
	
	$("#excelDept_upload_btn").on("click",function(){
		//필요한 파라미터를 공통엑셀업로드 jsp에 append
		var excelUploadForm = $("#elxcelUploadForm");
		excelUploadForm.append("<input type='hidden' name='termcode' value='"+$("#termcode option:selected").data("term-code")+"'>");
		excelUploadForm.append("<input type='hidden' name='insertQuery' value='biz_dept.dept_insert'>");
		excelUploadForm.append("<input type='hidden' name='deleteQuery' value='biz_dept.dept_delete'>");
		excelUploadForm.append("<input type='hidden' name='updateQueryFinal' value='biz_dept.dept_line_update'>");
		$("#excelUploadModal").modal({
			backdrop : false,
			keyboard: false
		});
	});
	
	$("#detp_modify_btn").on("click",function(){
		var oForm = $("#deptForm").serializeArray();
		var oFormArray = gPostArray(oForm);
		if(oFormArray.dept_name.trim() == ""){
			swalWarning("부서명을 입력해주십시오.");
			return false;
		}
		swal({
			  icon : "info",
			  text: "부서정보를 수정하시겠습니까?",
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
						oFormArray.term_code = $("#termcode option:selected").data("term-code");
						$.ajax({
							type: 'POST',
							url: '/icm/deptUpdate',
							data: oFormArray,
							dataType: 'json',
							//async : false,
							success: function(data){
								if(data.result > 0){
									swalSuccess("수정되었습니다.");
									treeRecall({termcode : $("#termcode option:selected").data("term-code"), _csrf : "${_csrf.token}"}, '/icm/deptList', "#deptTree","#");
								}
							}
						});
				  }
			});
	});
	
});

</script>

</body>