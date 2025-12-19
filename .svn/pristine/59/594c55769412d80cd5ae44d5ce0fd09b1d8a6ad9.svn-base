<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
if (request.getProtocol().equals("HTTP/1.1"))
	response.setHeader("Cache-Control", "no-cache");
%>
<head>
<title>메뉴관리</title>
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
	<h2>
		메뉴관리
		<!-- 공통 - 네비게이션 시작 -->
		<ul class="loc">
			<li>
				<img src="/resources/yp/images/ic_loc_home.png">
			</li>
			<c:if test="${menu.breadcrumb[0].top_menu_id ne null}">
				<li>${menu.breadcrumb[0].top_menu_name}</li>
				<c:if test="${menu.breadcrumb[0].top_menu_id ne menu.breadcrumb[0].up_menu_id}">
					<c:if test="${menu.breadcrumb[0].up_menu_id ne null}">
						<li>${menu.breadcrumb[0].up_menu_name}</li>
					</c:if>
				</c:if>
			</c:if>
			<c:if test="${menu.breadcrumb[0].menu_id ne null}">
				<li>${menu.breadcrumb[0].menu_name}</li>
			</c:if>
		</ul>
		<!-- 공통 - 네비게이션 종료 -->
	</h2>
	<section class="section">
		<form class="actschedForm" id="actsched">
			<!-- 20191023_khj for csrf -->
			<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		</form>
	</section>
	
	<div class="float_wrap">
		<div class="fl"><div class="stitle">메뉴 리스트</div></div>
		<div class="fr">
			<div class="btn_wrap">
				<input type="button" class="btn_g btn_plus" id="btn_all_open"  value="모두열기"/>
				<input type="button" class="btn_g" id="btn_all_close"  value="모두닫기"/>
				<input type="button" class="btn_g" id="btn_menu_view"  value="[순번+메뉴명]보기"/>
				<input type="button" class="btn_g" id="btn_top_add"  value="TOP메뉴등록"/>
				<form id="excelDownForm" method="post" action="/core/excel/excelDown">
					<input type="hidden" id="listQuery" name="listQuery" value="biz_excel.deptExcel">
					<input type="hidden" id="filename" name="filename" value="dept_template">
					<input type="hidden" id="version" name="version" value="xlsx">
				</form>
			</div>
		</div>
	</div>
	
	
	<section class="section">
		<div class="box" style="width:100%; overflow:scroll; height:300px; border:1px solid silver;">
			<div>
				<div id="menuTree" class="tree"><!-- 메뉴트리가 들어감 --></div>
			</div>
			<!-- <div class="btnWrap">
				<span class="right">
					<button type="button" id="btn_all_open" class="btnTypeM2"><i class="fas fa-plus-square"></i>&nbsp;모두열기</button>
					<button type="button" id="btn_all_close" class="btnTypeM2"><i class="fas fa-minus-square"></i>&nbsp;모두닫기</button>
					<button type="button" id="btn_menu_view" class="btnTypeM">[순번+메뉴명]보기</button>
					<button type="button" id="btn_top_add" class="btnTypeM">TOP메뉴등록</button>
				</span>
				<form id="excelDownForm" method="post" action="/core/excel/excelDown">
					<input type="hidden" id="listQuery" name="listQuery" value="biz_excel.deptExcel">
					<input type="hidden" id="filename" name="filename" value="dept_template">
					<input type="hidden" id="version" name="version" value="xlsx">
				</form>
			</div> -->
		</div>
	</section>
		
		
		<div class="float_wrap">
			<div class="fl"><div class="stitle">메뉴 정보</div></div>
			<div class="fr">
				<div class="btn_wrap">
					<input type="button" class="btn_g" id="btn_menu_update"  value="수정 등록"/>
					<input type="button" class="btn_g" id="btn_menu_add"  value="SUB메뉴등록"/>
					<input type="button" class="btn_g" id="btn_menu_delete"  value="삭제"/>
				</div>
			</div>
		</div>
		<section class="section">
    		<form class="menuForm" id="menuForm">
    			<!-- 20191023_khj for csrf -->
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
    			<table class="tableTypeInput" border="0" cellpadding="0" cellspacing="0">
    				<colgroup>
                    	<col width="110" />
                        <col width="" />                            
                    </colgroup>
                    <tr> 
                      <th scope="col">상위메뉴코드</th>
                      <td>
                      	<input class="form-control" type="text" name="up_menu_code" id="up_menu_code" readonly>
                      </td>                           
                    </tr>
                    <tr> 
                      <th scope="col">상위메뉴명</th>
                      <td>
                      	<input class="form-control" type="text" name="up_menu_name" id="up_menu_name" readonly>
                      </td>                           
                    </tr>
                    <tr>
                      <th scope="col">메뉴코드</th>
                      <td>
                      	<input class="form-control" type="text" name="menu_code" id="menu_code" readonly>
                      </td>                         
                    </tr>
                    <tr>
                      <th scope="col">메뉴명</th>
                      <td>
                      	<input class="form-control" type="text" name="menu_name" id="menu_name" maxlength="50">
                      </td>                           
                    </tr>
                    <tr>
                      <th scope="col">실행 URL</th>
                      <td>
                      	<input class="form-control" type="text" name="menu_url" id="menu_url" maxlength="50">
                      </td>                           
                    </tr>
                    <tr>
                      <th scope="col">순서</th>
                      <td>
                      	<input class="form-control" type="text" name="menu_sort" id="menu_sort" maxlength="50">
                      </td>                           
                    </tr>
                    <tr>
                      <th scope="col">사용여부</th>
                      <td>
	                      <select class="form-control" id="use_yn" name="use_yn">
						  		<option value="Y" selected>Y</option>
 									<option value="N">N</option>
						  </select>
                      </td>                           
                    </tr>
    			</table>
    		</form>	
		</section>

<%@include file="./topMenuLayerAdd.jsp" %>
<%@include file="./subMenuLayerAdd.jsp" %>

<script>
$(document).ready(function(){
	
	treeListCall({ _csrf : "${_csrf.token}"}, '/core/staff/menu/menuTree', '#menuTree', '#');
	$('#menuTree').on('changed.jstree', function (e, data) { //jstree 클릭 이벤트

	    if(data.action == "select_node"){
	    	var selectedNode = data.node.original;

	    	/*
	    	document.getElementById("deptAddModal_updept_code").value = selectedNode.id;
	    	document.getElementById("deptAddModal_updeptlvl_code").value = selectedNode.deptlvl_code;
	    	document.getElementById("deptAddModal_updept_name").value = selectedNode.text;
	    	document.getElementById("deptAddModal_updept_line").value = selectedNode.dept_line;
	    	*/
	    	
	    	document.getElementById("menuAddModal_up_menu_code").value = selectedNode.id;
	    	document.getElementById("menuAddModal_up_menu_name").value = selectedNode.text;
	    	
	    	document.getElementById("up_menu_code").value = selectedNode.parent;
	    	document.getElementById("up_menu_name").value = selectedNode.up_menu_name;
	    	document.getElementById("menu_code").value = selectedNode.id;
	    	if($("#btn_menu_view").val() == "[순번+메뉴명]보기"){
	    		document.getElementById("menu_name").value = selectedNode.text;
	    	}else{
	    		document.getElementById("menu_name").value = selectedNode.text2;
	    	}
	    	document.getElementById("menu_url").value = selectedNode.url;
	    	document.getElementById("menu_sort").value = selectedNode.sort;
	    	document.getElementById("use_yn").value = selectedNode.use_yn;
	    };
	}).jstree();

	// create the instance

});

</script>


<script>
$(document).ready(function(){
	
	$("#btn_all_open").on("click",function(){
		$("#menuTree").jstree("open_all");
	})
	
	$("#btn_all_close").on("click",function(){
		$("#menuTree").jstree("close_all");
	})
	
	$("#btn_menu_view").on("click",function(){
		if($("#btn_menu_view").val() == "[순번+메뉴명]보기"){
			treeRecall({ _csrf : "${_csrf.token}"}, '/core/staff/menu/menuTree_sort', '#menuTree', '#');
			$("#btn_menu_view").val("[메뉴명]보기");
		}else{
			treeRecall({ _csrf : "${_csrf.token}"}, '/core/staff/menu/menuTree', '#menuTree', '#');
			$("#btn_menu_view").val("[순번+메뉴명]보기");
		}
	})
	
	
	$("#btn_top_add").on("click",function(){
		$("#menuTree").jstree("deselect_all");
		document.getElementById("menuForm").reset();
		
		$("#topMenuAddModal").modal({
			backdrop : false,
			keyboard: false
		});
		$("#topMenuAddModal").draggable({
		      handle: ".modal-header",
		      cursor : "move"
		});
	});
	
	$("#btn_menu_add").on("click",function(){
		var selectedNode = $("#menuTree").jstree("get_selected");
		if(selectedNode.length == 0){
			swalWarning("메뉴리스트에서 메뉴를 선택해주십시오.");
			return false;
		}
		
		document.getElementById("menuAddModal_up_menu_code").value = document.getElementById("menu_code").value;
    	document.getElementById("menuAddModal_up_menu_name").value = document.getElementById("menu_name").value;
		
		$("#menuAddModal").modal({
			backdrop : false,
			keyboard: false
		});
		$("#menuAddModal").draggable({
		      handle: ".modal-header",
		      cursor : "move"
		});
	});
	
	$("#btn_menu_delete").on("click",function(){
		var selectedNode = $("#menuTree").jstree("get_selected");
		if(selectedNode.length == 0){
			swalWarning("메뉴리스트에서 메뉴를 선택해주십시오.");
			return false;
		}
		
		swal({
			  icon : "info",
			  text: "선택한 메뉴의 하위메뉴 존재시 모두 삭제됩니다.\n삭제 하시겠습니까?",
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
					    var oForm = $("#menuForm").serializeArray();
						var oFormArray = gPostArray(oForm);
						$.ajax({
							type: 'POST',
							url: '/core/staff/menu/deleteMenu',
							data: oFormArray,
							dataType: 'json',
							//async : false,
							success: function(data){
								if(data.result > 0){
									swalSuccess("메뉴가 삭제되었습니다.");
									treeRecall({_csrf : "${_csrf.token}"}, "/core/staff/menu/menuTree", "#menuTree", "#");
								}else{
									swalWarning("메뉴 삭제 실패했습니다.");
								}
							}
						});
				  }
			});
	});

	
	
	$("#btn_menu_update").on("click",function(){
		
		var selectedNode = $("#menuTree").jstree("get_selected");
		  if(selectedNode.length == 0){
			  swalWarning("수정할 메뉴를 선택해주십시오.");
			  return false;
		}

		var oForm = $("#menuForm").serializeArray();
		var oFormArray = gPostArray(oForm);
		if(oFormArray.menu_name.trim() == ""){
			swalWarning("메뉴명을 입력해주십시오.");
			return false;
		}
		if(oFormArray.menu_url.trim() == ""){
			swalWarning("URL을 입력해주십시오.(default : /)");
			return false;
		}
		if(oFormArray.menu_sort.trim() == ""){
			swalWarning("순서를 입력해주십시오.");
			return false;
		}
		swal({
			  icon : "info",
			  text: "메뉴정보를 수정하시겠습니까?",
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
						$.ajax({
							type: 'POST',
							url: '/core/staff/menu/updateMenu',
							data: oFormArray,
							dataType: 'json',
							//async : false,
							success: function(data){
								if(data.result > 0){
									swalSuccess("메뉴정보 수정되었습니다.");
									treeRecall({_csrf : "${_csrf.token}"}, "/core/staff/menu/menuTree", "#menuTree", "#");
								}else{
									swalWarning("메뉴정보 수정 실패했습니다.");
								}
							}
						});
				  }
			});
	});
	
});

</script>

</body>