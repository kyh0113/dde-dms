<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String s_dept_code = (String)request.getSession().getAttribute("s_dept_code") == null ? "" : (String)request.getSession().getAttribute("s_dept_code");
String s_emp_code = (String)request.getSession().getAttribute("s_emp_code") == null ? "" : (String)request.getSession().getAttribute("s_emp_code");
%>
<head>
<title>사용자관리</title>
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
	
	<input type="hidden" name="s_dept_code" id="s_dept_code" value="${s_dept_code}">
	<section class="section">
		<h2 class="subTitle">사용자관리</h2>
		<div class="searchTable">
			<form class="actschedForm" id="actsched">
				<!-- 20191023_khj for csrf -->
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<table>
					<colgroup>
						<col style="width:10%">
						<col style="width:40%">
						<col style="width:10%">
						<col style="width:40%">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row" class="textRight">성명</th>
							<td>
								<input class="inputTxt"  type="text" name="empname" id="empname"> 
							</td>
							<th scope="row" class="textRight">사용여부</th>
							<td class="sel-350">
								<select class="form-control" id="status" name="status">
							        <option value="">전체</option>
							        <option value="C" selected>YES</option>
							        <option value="D">NO</option>
							    </select> 
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
		<div class="btnWrap">
			<button id="user_search_btn" type="button" class="btnTypeM">검색</button>
		</div>
	</section>
	<section class="section boxItem2">
		<div class="box" style="width:40%;">
			<h3 class="subTitle2">조직도</h3>
			<div class="treeWrap">
				<div id="deptTree" class="tree"><!-- 부서트리가 들어감 --></div>
			</div>
		</div>
		
		<div class="box" style="width:60%;">
			<h3 class="subTitle2">사용자정보</h3>
			<div>
	    		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
				<div id="div-uiGrid"  data-ng-controller="ctrCtrl" style="height: 100%;">
					<div data-ui-i18n="ko" style="height: 100%;">
						<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav data-ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
							<div data-ng-if="loader" class="loader"></div>
							<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
						</div>
					</div>
				</div>
				<!-- 복붙영역(html) 끝 -->
	   		</div>
	   		<div class="btnWrap">
			   	<span class="left">
			   		<button id="excelUser_template_down_btn" class="btnTypeM">사원템플릿다운로드</button>                       	
		        	<button id="excelUser_upload_btn" class="btnTypeM">사원업로드</button>
		        	<button type="button" id="excel_down_btn" class="btnTypeE"><i class="fas fa-download"></i>&nbsp;EXCEL</button>
				</span>
				<form id="excelDownForm" method="post" action="/core/excel/excelDown">
					<input type="hidden" id="listQuery" name="listQuery" value="biz_excel.userExcel">
					<input type="hidden" id="filename" name="filename" value="user_template">
					<input type="hidden" id="version" name="version" value="xlsx">
				</form>
		        <span class="right">                        	
		            <button id="user_dept_modify_btn" class="btnTypeM">부서이동</button>
		            <button id="user_register_btn" class="btnTypeM">등록</button>
		            <button id="user_delete_btn" class="btnTypeM1">삭제</button>
		        </span>
		    </div>
		    <div class="btnWrap">
		    	<span class="left">
		    		<button id="all_user_pw_init" class="btnTypeM3">(일괄)암호 초기화</button>
		    		<button id="all_user_status_c" class="btnTypeM3">(일괄)사용여부 YES</button>
		    		<button id="all_user_status_d" class="btnTypeM3">(일괄)사용여부 NO</button>
		    	</span>
		    </div>
		</div>
	
	</section>

<%@include file="../excelUploadModal/excelUploadModal.jsp" %>
<script>
	//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
	app.controller('ctrCtrl', ['$scope','$controller','$log','StudentService', 
	function ($scope,$controller,$log,StudentService) {		//$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
		var vm = this; 										//this를 vm에 대입, 아래에서 부모의 $scope를 vm에 추가하기 위해 			
		angular.extend(vm, $controller('CodeCtrl',{ 		//CodeCtrl(ui-grid 커스텀 api)를 상속받는다
			$scope : $scope									// 자식컨트롤러의 vm에 부모 컨트롤러의 $scope를 합, 이로써 자식 컨트롤러에서 부모의 모든 $scope(this)를 사용 할 수 있음			
		}));	
		var paginationOptions = vm.paginationOptions;		//부모의 paginationOptions를 자식의 paginationOptions에 대입,즉시실행 함수
		
		paginationOptions.pageNumber = 1;					//초기 page number
		paginationOptions.pageSize = 500;					//초기 한번에 보여질 로우수
		$scope.paginationOptions = paginationOptions;
		
		$scope.gridApi = vm.gridApi;						//외부에서 grid의 클릭이벤트와 같은것들을 쓰기 위해서
		$scope.loader = vm.loader;
		
		$scope.addRow = vm.addRow;
		
		$scope.modeChange = function(mode){			
			if(mode == "R"){
				document.getElementById("userDetailModal_label").innerText = "사용자정보 등록";
				document.getElementById("user_register_final_btn").style.display = "inline-block";
				document.getElementById("user_modify_final_btn").style.display = "none";
				document.getElementById("emp_code_td").innerHTML = '<input type="text" class="inputTxt reg_userDetailModal_emp_code" id="userDetailModal_emp_code" name="userDetailModal_emp_code">'+
																	/* 2019-06-14-smh 시작  - 중복체크 버튼 삭제, 아이디 중복체크 표시div추가 */
// 																	'<button id="id_check" class="btnTypeS1">중복체크</button>'+
																  	'<br><br><div id="userIdChk"></div>';
																	/* 2019-06-14-smh 끝 */
			}else if(mode == "M"){
				document.getElementById("userDetailModal_label").innerText = "사용자정보 수정";
				document.getElementById("user_register_final_btn").style.display = "none";
				document.getElementById("user_modify_final_btn").style.display = "inline-block";
				document.getElementById("emp_code_td").innerHTML = ' <input type="text" class="inputTxt" id="userDetailModal_emp_code" name="userDetailModal_emp_code" readonly>';
			}
		}
		
		$scope.openUserDetail = function(row){
			$.ajax({
				type: 'POST',
				url: '/icm/userDetail',
				data: row,
				dataType: 'json',
				//async : false,
				success: function(data){
					document.getElementById("userDetailForm").reset();
					document.getElementById("userDetailModal_emp_name").readOnly = true;
					$scope.modeChange("M");
					var userDetail = data.userDetail;
					var positionList = data.positionList;
					
					for(var key in userDetail){
						if(key == "position_code"){	
							var position_code = document.getElementById("userDetailModal_position_code");
							var optionList = "<option value='' id='position_'>- 선택 -</option>";
							for(var i in positionList){
								optionList += "<option value='"+positionList[i].position_code+"' id='position_"+positionList[i].position_code+"'>"+positionList[i].position_name+"</option>";
							}
							position_code.innerHTML = optionList;
							/* 2019-09-29 smh positionList null처리 추가*/
							if(document.getElementById("position_"+userDetail.position_code)!=null){
								document.getElementById("position_"+userDetail.position_code).selected = true;
							}
							/* 2019-09-29 smh 끝 */
							continue;
						}
						//2019-08-27 smh 시작. null처리 해줌 
						if(key == "signimg_dir" || key == "stampimg_dir"){
							if(userDetail[key]!=null && userDetail[key]!=""){
								document.getElementById(key+"_src").src = ("/imgFile/" + userDetail[key].split("/imgFile/")[1] === null ? "" : "/imgFile/" + userDetail[key].split("/imgFile/")[1]);
								continue;
							}
						}
						//2019-08-27 smh 끝.

						if($("#userDetailModal_"+key).length > 0){
							document.getElementById("userDetailModal_"+key).value = userDetail[key];
						}
						
					}
					
					
					$("#userDetailModal").modal({
						backdrop : false
					});
				},
		        complete: function(){}
			});	
			
		}
		
		$scope.cellClassSet = function(grid, row, col, rowRenderIndex, colRenderIndex){
			var className = "";
			switch(col.field){
				case "stampimg_dir" :	className = "center "; 
					break;
				case "photoimg_dir" :  className = "center ";
					break;
				case "signimg_dir" : className = "center ";
					break;
				case "acnt_code" : className = "center ";
					break;
			}
			if((row.entity.photoimg_dir == 'Yes')&&(col.feild == "photoimg_dir")){
				className = className + " green";
			}
			if(row.entity.photoimg_dir == 'No'&&col.field == "photoimg_dir"){
				className = className + " red";
			}
			if((row.entity.signimg_dir == 'Yes')&&(col.field == "signimg_dir")){
				className = className + " green";
			}
			if((row.entity.signimg_dir == 'No')&&(col.field == "signimg_dir")){
				className = className + " red";
			}
			if((row.entity.stampimg_dir == 'Yes')&&(col.field == "stampimg_dir")){
				className = className + " green";
			}
			if((row.entity.stampimg_dir == 'No')&&(col.field == "stampimg_dir")){
				className = className + " red";
			}
			return className;
		}
		
		$scope.pagination = vm.pagination;
		$scope.gridOptions = vm.gridOptions(  				// 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableFiltering : false, 					//칵 컬럼에 검색바
				paginationPageSizes : [500, 1500, 5000, 10000], 		//한번에 보여질 로우수 셀렉트리스트
				enableCellEditOnFocus : true, 				//셀 클릭시 edit모드 
				enableSelectAll : true, 					//전체선택 체크박스
				enableRowSelection : true, 					//로우 선택
				enableRowHeaderSelection : true, 			//맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 35, 				//체크박스 컬럼 길이
				rowHeight : 27, 							//체크박스 컬럼 높이
				useExternalPagination : true, 				//pagination을 직접 세팅
				enableAutoFitColumns: false,					//컬럼 width를 자동조정
				multiSelect : true, 						//여러로우선택
				enablePagination : false,
				enablePaginationControls: false,
				columnDefs : [  							//컬럼 세팅
					{ displayName: '사용자ID', field: 'emp_code',enableCellEdit : false, allowCellFocus : false, cellClass : "center"},
		            { displayName: '성명', field: 'emp_name',enableCellEdit : false, allowCellFocus : false, cellClass : "center"
						,cellTemplate : '<div class="ui-grid-cell-contents ng-binding ng-scope ui-grid-dbclick-column" ng-dblclick="grid.appScope.openUserDetail(row.entity)">{{row.entity.emp_name}}</div>'
		            },
		            { displayName: '직책', field: 'position_name',enableCellEdit : false, allowCellFocus : false, cellClass : "center"},
		            {  width:"150", displayName: '소속부서', field: 'dept_name',enableCellEdit : false, allowCellFocus : false, cellClass : "center"},
		            { visible : false, displayName: '부서코드', field: 'dept_code',enableCellEdit : false, allowCellFocus : false, cellClass : "center"},
		            { width:"80", displayName: '사진', field: 'photoimg_dir',enableCellEdit : false, allowCellFocus : false, cellClass : $scope.cellClassSet
		            	, cellTemplate : '<div class="ui-grid-cell-contents" style="font-size:15px;"><i ng-if="row.entity.photoimg_dir ==\'Yes\'" class="fas fa-check green"></i><i ng-if="row.entity.photoimg_dir ==\'No\'" class="fas fa-times red"></i></div>'},
		            { width:"80", displayName: '싸인', field: 'signimg_dir',enableCellEdit : false, allowCellFocus : false, cellClass : $scope.cellClassSet
		            	, cellTemplate : '<div class="ui-grid-cell-contents" style="font-size:15px;"><i ng-if="row.entity.signimg_dir ==\'Yes\'" class="fas fa-check green"></i><i ng-if="row.entity.signimg_dir ==\'No\'" class="fas fa-times red"></i></div>'	},
		            { width:"80", displayName: '도장', field: 'stampimg_dir',enableCellEdit : false, allowCellFocus : false, cellClass : $scope.cellClassSet
		            	, cellTemplate : '<div class="ui-grid-cell-contents" style="font-size:15px;"><i ng-if="row.entity.stampimg_dir ==\'Yes\'" class="fas fa-check green"></i><i ng-if="row.entity.stampimg_dir ==\'No\'" class="fas fa-times red"></i></div>'	},
		            { visible : false, displayName: '사용여부', field: 'status',enableCellEdit : false, allowCellFocus : false, cellClass : "center"},
				]
			}
		);  
		
		$scope.gridLoad = vm.gridLoad; 						//부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
		$scope.reloadGrid = vm.reloadGrid;
															//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  
	
	}]);
	//복붙영역(앵귤러단) 끝
</script>
<script>
$(document).ready(function(){
	
	//복붙영역(앵귤러 이벤트들 가져오기) 시작, 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
	
	var scope = angular.element(document.getElementById("div-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
	scope.gridApi.selection.on.rowSelectionChanged(scope,function(row){			//로우 선택할때마다 이벤트
		
    });
	
	/* scope.gridApi.selection.on.rowSelectionChangedBatch(scope,function(rows){	//전체선택시 가져옴
		console.log(rows);           //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
    });	 */
	
	//pagenation option setting  그리드를 부르기 전에 반드시 선언
	var param = {
		listQuery : "biz_dept.grid_userList", 				//list가져오는 마이바티스 쿼리 아이디
		cntQuery : "biz_dept.grid_cnt_userList"					//list cnt 가져오는 마이바티스 쿼리 아이디
    }; 
	scope.paginationOptions = customExtend(scope.paginationOptions,param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
	//복붙영역(앵귤러 이벤트들 가져오기) 끝
	
	
	
});
</script>
<script>
$(document).ready(function(){
	
	var scope = angular.element(document.getElementById("div-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
	
	treeListCall({termcode : $("#termcode option:selected").data("term-code"), _csrf : "${_csrf.token}"}, '/icm/deptList', '#deptTree', document.getElementById("s_dept_code").value);
	treeListCall({termcode : $("#termcode option:selected").data("term-code"), _csrf : "${_csrf.token}"}, '/icm/deptList', '#deptTree2', document.getElementById("s_dept_code").value);
	
	
	$('#deptTree').on('changed.jstree', function (e, data) { //jstree 클릭 이벤트
	    if(data.action == "select_node"){
	    	var selectedNode = data.node.original;

	    	scope.reloadGrid({
	    		termcode : selectedNode.term_code,
	    		dept_code : selectedNode.id,
	    		status : $("#status option:selected").val(),
	    		emp_name : ''
	    	});
	    };
	  }).jstree();
	  // create the instance
	
	$("#termcode").on("change",function(){
		var emp_name = $("#empname").val();
		var dept_code = '';
		if(isEmpty(emp_name)){
			dept_code = document.getElementById("s_dept_code").value;
		}
		treeRecall({termcode : $("#termcode option:selected").data("term-code"), _csrf : "${_csrf.token}"}, '/icm/deptList', "#deptTree", dept_code);
		treeRecall({termcode : $("#termcode option:selected").data("term-code"), _csrf : "${_csrf.token}"}, '/icm/deptList', "#deptTree2", dept_code);
		scope.reloadGrid({
			termcode : $("#termcode option:selected").data("term-code"),
			dept_code : dept_code,
			status : $("#status option:selected").val(),
			emp_name : emp_name
		});
		btnBlock();
	});
	
	$("#user_search_btn").on("click",function(){
		var emp_name = $("#empname").val();
		var dept_code = '';
		if(isEmpty(emp_name)){
			dept_code = document.getElementById("s_dept_code").value;
		}
		scope.reloadGrid({
			termcode : $("#termcode option:selected").data("term-code"),
			dept_code : dept_code,
			status : $("#status option:selected").val(),
			emp_name : emp_name
		});
		$("#deptTree").jstree("deselect_all");
		btnBlock();
	});

	$("#user_dept_modify_btn").on("click",function(){
		var selectedRows = scope.gridApi.selection.getSelectedRows();
		if(isEmpty(selectedRows)){
			swalWarning("부서이동 대상자를 선택해 주세요.");
			return false;	
		}
		
		$("#deptListModal").modal({
			backdrop : false
		});
	});
	
	
	$("#user_register_btn").on("click",function(){
		document.getElementById("userDetailForm").reset();
// 		document.getElementById("user_register_final_btn").disabled = true;
		document.getElementById("userDetailModal_emp_name").readOnly = false;
		
		var $deptTree = $('#deptTree');
		var selectedNode = $deptTree.jstree(true).get_node($deptTree.jstree('get_selected')[0], true)[0];
		if(isEmpty(selectedNode)){
			swalWarning("사원을 등록 할 부서를 선택해주십시오.");
			return false;
		}
		scope.modeChange("R");

		document.getElementById("userDetailModal_dept_code").value = selectedNode.id.trim();
		document.getElementById("userDetailModal_dept_name").value = selectedNode.innerText;
		
		$.ajax({
			type: 'POST',
			url: '/icm/userDetail',
			data: {},
			dataType: 'json',
			//async : false,
			success: function(data){
				var positionList = data.positionList;
				
				var position_code = document.getElementById("userDetailModal_position_code");
				var optionList = "<option value='' id='position_'>- 선택 -</option>";
				for(var i in positionList){
					optionList += "<option value='"+positionList[i].position_code+"' id='position_"+positionList[i].position_code+"'>"+positionList[i].position_name+"</option>";
				}
				position_code.innerHTML = optionList;

			}
		});	
		
		
		$("#userDetailModal").modal({
			backdrop : false
		});
	});
	
	$("#user_delete_btn").on("click",function(){
		var $this = $(this);
		
		var selectedRows = scope.gridApi.selection.getSelectedRows();
		if(isEmpty(selectedRows)){
			swalWarning("삭제할 사용자를 선택해 주세요.");
			$this.attr("disabled", false);
			return false;	
		}
		swal({
			  icon : "info",
			  text: "선택한 사용자정보를 삭제하시겠습니까?",
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
							url: '/icm/userPerDelete',
							data: { term_code : $("#termcode option:selected").data("term-code"), listString : JSON.stringify(selectedRows) },
							dataType: 'json',
							success: function(data){
									swalSuccess("선택한 사용자정보가 삭제되었습니다.");
									$("#user_search_btn").trigger("click");
							},
				            complete: function(){}
						});	
				  }
			});
		
	});
	
	$("#excelUser_template_down_btn").on("click",function(){
		var form = document.createElement("form");
    	var input = document.createElement("input");
    	input.name = "file_name";
    	input.value = "user_template.xlsx";
    	input.type = "hidden";
    	
    	form.method = "post";
    	form.action = "/biz/ICMTemplateDownload";
    	
    	form.appendChild(input);
    	document.body.appendChild(form);
    	
    	form.submit();
    	form.remove();
	});
	
	$("#excelUser_upload_btn").on("click",function(){
		swal({
			  icon : "info",
			  text: "사용자정보를 업로드 하시겠습니까?",
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
						//필요한 파라미터를 공통엑셀업로드 jsp에 append
						var excelUploadForm = $("#elxcelUploadForm");
						excelUploadForm.append("<input type='hidden' name='termcode' value='"+$("#termcode option:selected").data("term-code")+"'>");
						excelUploadForm.append("<input type='hidden' name='insertQuery' value='biz_dept.user_insert'>");
						excelUploadForm.append("<input type='hidden' name='deleteQuery' value='biz_dept.user_delete'>");
						$("#excelUploadModal").modal({
							backdrop : false,
							keyboard: false
						});
				  }
			});
	});
	
	$("#all_user_pw_init").on("click",function(){
		swal({
			  icon : "info",
			  text: "모든 사용자 암호를 초기화하시겠습니까?\r\n(단, 운영자는 대상에서 제외됩니다.)",
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
						url: '/icm/allUserPwInit',
						data: { term_code : $("#termcode option:selected").data("term-code")},
						dataType: 'json',
						success: function(data){
							swalSuccess("모든 사용자암호가 초기화됐습니다.");
							$("#user_search_btn").trigger("click");
						},
			            complete: function(){}
					});	
			    }
			});
	});
	
	$("#all_user_status_c").on("click",function(){
		swal({
			  icon : "info",
			  text: "모든 사용자의 시스템 사용여부(상태)를 \"YES\" 하시겠습니까?\r\n(단, 운영자는 대상에서 제외됩니다.)",
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
						url: '/icm/allUserStatusUpdate',
						data: { term_code : $("#termcode option:selected").data("term-code"), status : "C"},
						dataType: 'json',
						success: function(data){
							swalSuccess("정상적으로 시스템 사용여부(상태)를 수정하였습니다.");
							$("#user_search_btn").trigger("click");
						},
			            complete: function(){}
					});	
			    }
			});
	});
	
	$("#all_user_status_d").on("click",function(){
		swal({
			  icon : "info",
			  text: "모든 사용자의 시스템 사용여부(상태)를 \"NO\"하시겠습니까?\r\n(단, 운영자는 대상에서 제외됩니다.)",
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
						url: '/icm/allUserStatusUpdate',
						data: { term_code : $("#termcode option:selected").data("term-code"), status : "D"},
						dataType: 'json',
						success: function(data){
							swalSuccess("정상적으로 시스템 사용여부(상태)를 수정하였습니다.");
							$("#user_search_btn").trigger("click");
						},
			            complete: function(){}
					});	
			    }
			});
	});
});

</script>

<%@include file="./deptList_modal.jsp"%>
<%@include file="./userDetail_modal.jsp"%>

</body>