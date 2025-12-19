<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
if (request.getProtocol().equals("HTTP/1.1"))
	response.setHeader("Cache-Control", "no-cache");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>공지게시판</title>
<style>
.ui-grid-cell-contents{
	white-space : pre !important;
}

</style>
</head>

<body>
	<h2>
		공지게시판
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
	
	<form  id="searchFrm">
		<!-- 20191023_khj for csrf -->
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<section>
			<div class="tbl_box">
				<table>
					<colgroup>
						<col width="12%" />
						<col width="38%"/>
						<col width="12%" />
						<col width="38%"/>
					</colgroup>
					<tr>
						<th>검색 카테고리</th>
						<td>
							<select id="board_search" name="board_search" >
					        	<option value="title" >제목</option>
					        	<option value="creator" >작성자</option>
						    </select>
						</td>
						<th>검색입력</th>
						<td>
							<input class="inputTxt" type="text" name="board_searchValue" id="board_searchValue" style="width:300px;" onkeydown="enter_check();">
						</td>
			        </tr>	        
				</table>
				<div class="btn_wrap">
					<input type="button" class="btn btn_search" id="search_btn" value="조회"/>
				</div>
			</div>
		</section>
	</form>
	
	<%-- <c:if test="${s_authogrp_code eq '100'}"> --%>
		<div class="float_wrap" style="margin-bottom:5px;">
			<div class="fr">
				<div class="btn_wrap">
					<input type="button" class="btn_g" id="write_btn"  value="작성"/>
					<input type="button" class="btn_g" id="delete_btn"  value="삭제"/>
				</div>
			</div>
		</div>
	<%-- </c:if> --%>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
		<div id="board-uiGrid"  data-ng-controller="boardCtrl" style="height: 600px;">
			<div data-ui-i18n="ko" style="height: auto;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
	</section>
	
	<!-- 모달부분 -->
	<%-- <%@include file="./write_modal.jsp"%> --%>
	<%@include file="./write_modal.jsp"%>
	<%@include file="./view_modal.jsp"%>
	<%@include file="./update_modal.jsp"%>
	<%@include file="../fileForm/fileUpload_modal.jsp"%>
	
	<script>
	//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
	app.controller('boardCtrl', ['$scope','$controller','$log','StudentService', 
	function ($scope,$controller,$log,StudentService) {		//$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
		var vm = this; 										//this를 vm에 대입, 아래에서 부모의 $scope를 vm에 추가하기 위해 			
		angular.extend(vm, $controller('CodeCtrl',{ 		//CodeCtrl(ui-grid 커스텀 api)를 상속받는다
			$scope : $scope									// 자식컨트롤러의 vm에 부모 컨트롤러의 $scope를 합, 이로써 자식 컨트롤러에서 부모의 모든 $scope(this)를 사용 할 수 있음			
		}));	
		var paginationOptions = vm.paginationOptions;		//부모의 paginationOptions를 자식의 paginationOptions에 대입,즉시실행 함수
		
		paginationOptions.pageNumber = 1;					//초기 page number
		paginationOptions.pageSize = 10;					//초기 한번에 보여질 로우수
		$scope.paginationOptions = paginationOptions;
		
		$scope.gridApi = vm.gridApi;						//외부에서 grid의 클릭이벤트와 같은것들을 쓰기 위해서
		$scope.loader = vm.loader;
		
		$scope.addRow = vm.addRow;
		
		$scope.pagination = vm.pagination;
		
		$scope.fileDropZone = angular.element("#attachFileTable").fileDropDown({
			areaOpen : true,
			fileSizeLimits : '<spring:eval expression="@config['file.fileSizeLimits']"/>',
			totalfileSizeLimits : '<spring:eval expression="@config['file.totalfileSizeLimits']"/>'
		});
		$scope.fileDropZone.setDropZone();
		
		$("#multifileselect").change(function(){
			$scope.fileDropZone.selectFile($("#multifileselect").get(0).files);
		})
		
		//세션아이드코드 스코프에저장
		$scope.emp_cd = "${emp_cd}";

		//수정표시 보여줄지 말지 판단
		$scope.idChk = function(row){
			//관리자 권한만 보이도록
			//if("${s_authogrp_code}" == "100"){
			//	return true;
			//}
			
			//작성자만 보이도록
			if(row.entity.created_by == "${emp_cd}"){
				return true;
			}
			
			return false;

		}
		
		//게시판에서 바로 파일업로드모달 띄워주기
		$scope.openAttachModal=function(row){
			
			//파일드롭다운하는 모달 세팅
			$scope.fileDropZone.fileListLoad({
				url : "/biz/ICMFileList",
				param : {attach_no : (row==null)?null : row.attach_no, 
						             '${_csrf.parameterName}' : '${_csrf.token}'}
			});
			
			//파일첨부 운영자만 모달 삭제버튼 보여주기
			if("${s_authogrp_code}" == "100"){
				$(".attachDeleteBtn").css("display", "");
			}else{
				$(".attachDeleteBtn").css("display", "none");
			}
			
			
			var $attachFileUpload = $("#attachFileUpload");
			$attachFileUpload.modal({
				backdrop : false,
				keyboard: false
			});
		}
		
				
		$scope.openBoardDetail = function(row){
			
			var data = $("#searchFrm").serializeArray();
			data.push({name: "gridData", value: JSON.stringify(row)});
			
			$.ajax({
				type: 'POST',
				url: '/biz/board/boardDetail',
				data: data,
				dataType: 'json',
				async : false,
				success: function(data){
					
					var board_voew_data = data.boardView;
					$("#view_title").html(board_voew_data.title);
					$("#view_content").html(board_voew_data.content);
					$("#view_creation_date").html(board_voew_data.creation_date);
					$("#view_created_by_name").html(board_voew_data.created_by_name);
					
					//파일드롭다운하는 모달 세팅
					//$scope.fileDropZone.fileListLoad({
					//	url : "/biz/ICMFileList",
					//	param : {attach_no : (data==null)?null : data.attach_no, 
					//			'${_csrf.parameterName}' : '${_csrf.token}'}
					//});
					
					var file_list = data.fileList;
					$("#board_view_modal_files").fileListSelectDown(file_list);
				},
		        complete: function(){}
			});
			
			//파일첨부 운영자만 모달 삭제버튼 보여주기
			if("${s_authogrp_code}"=="100"){
				$(".attachDeleteBtn").css("display", "");
			}else{
				$(".attachDeleteBtn").css("display", "none");
			}			
			
			var $vieweModal = $("#viewModal");
			$vieweModal.modal({
				backdrop : 'static',
				keyboard: false
			});
			
			
		}
		
		$scope.openBoardUpdate=function(row){
			
			//form데이터 + 그리드데이터 json으로 변환 및 추가해서 서버로 전송
			var data = $("#searchFrm").serializeArray();
			data.push({name: "gridData", value: JSON.stringify(row)});
			
			$.ajax({
				type: 'POST',
				url: '/biz/board/boardDetail',
				data: data,
				dataType: 'json',
				async : false,
				success: function(data){
					var board_view = data.boardView;
					var file_list = data.fileList;
					$("#board_update_title").val(board_view.title);
	
// 					var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
//  					oEditors.getById["update_content"].exec("PASTE_HTML", [data.content]);						
// 					oEditors.getById['update_content'].exec('CHANGE_EDITING_MODE', ['WYSIWYG']); 
// 					oEditors.getById["update_content"].exec('FOCUS');
// 			    	oEditors.getById["update_content"].exec("EVENT_CHANGE_EDITING_MODE_CLICKED", ["HTMLSrc", true]); 
					
					
					//20200708_khj dialog -> 모달로 바꾸면서 iframe 세로길이 0px되는 이슈 해결위해 추가 
 					$('#update_content-iframe').height($('#update_content').height() + 50);
 					var iframeMain = $("#update_content-iframe").contents().find('#se2_iframe');
 					iframeMain.height("100%");
 					
 					//에디터 가려지는 부분 보이게하기
 					var ifram = $("#update_content").next("iframe");
 			    	ifram.css("width","100%").css("height","344px");
 					
					
					oEditors.getById["update_content"].exec("SET_IR", [""]);			//에디터 초기화
					$("#update_content").html(board_view.content);
					oEditors.getById["update_content"].exec("LOAD_CONTENTS_FIELD");		//Textarea 내용을 에디터로 세팅
					
					$("#update_creation_date").html(board_view.creation_date);
					$("#update_created_by_name").html(board_view.created_by_name);
					$("#update_board_no").val(board_view.board_no);
					$("#attach_no").val(board_view.attach_no);

					//input박스 체크 or 체크해제
					//*=는 주어진 문자열을 포함하고있는 노드
					if(board_view.header_yn=='Y'){
						$("input:checkbox[id*='board_update_header_yn']").prop("checked",true);
					}else{
						$("input:checkbox[id*='board_update_header_yn']").prop("checked",false);
					}
					if(board_view.popup_yn=='Y'){
						$("input:checkbox[id*='update_popup_yn']").prop("checked",true);
					}else{
						$("input:checkbox[id*='update_popup_yn']").prop("checked",false);
					}
					
					//파일드롭다운하는 모달 세팅
					$scope.fileDropZone.fileListLoad({
						url : "/biz/ICMFileList",
						param : {attach_no : (board_view==null)?null : board_view.attach_no,
								'${_csrf.parameterName}' : '${_csrf.token}'}
					});
				},
				error : function(jqXHR, textStatus, errorThrown){
					//alert(jqXHR);
					//alert(textStatus);
					if(jqXHR.status == "403"){
						alert("<spring:eval expression="@config['sessionoutMSG']"/>");
						location.replace("/core/login/login.do");
						return false;
					}
					
					var msg = "";
					if (jqXHR.status == 0) {
						msg = 'Not connect.\n Verify Network.';
					} else if (jqXHR.status == 404) {
						msg = 'Requested page not found. [404]';
					} else if (jqXHR.status == 500) {
						msg = 'Internal Server Error [500].';
					} else if (textStatus == 'parsererror') {
						msg = 'Requested JSON parse failed.';
					} else {
						msg = 'Uncaught Error.\n' + jqXHR.responseText;
					}

					swalDangerCB(msg);
					return false;
				},
		        complete: function(){}
			});

// 			$("#boardUpdate").dialog({
// 				title:"수정"
// 				,width: 1200
// 			    ,modal: true
// 			    ,resizable:false
// 			    ,closeOnEscape: false
// 			    ,position: {my: 'center', at:'center' ,of: 'body'}
// 			});
			
			$("#boardUpdate").modal({
				backdrop : false,
				keyboard: false
			});
		}

		$scope.cellClassSet = function(grid, row, col, rowRenderIndex, colRenderIndex){
			var className = "";
			
			switch(row.entity.header_yn){
				case "Y" :	className = "alarm"; 
					break;
			}
			switch(row.entity.popup_yn){
				case "Y" :	className = "popup"; 
					break;
			}
// 			console.log("col.fieldn:",col.field);
			switch(col.field){
				case "header_yn" :	 className = className+" center"; 
					break;
				case "board_no" :	className = className+" center";
					break;
				case "title" :	className = className+" left";
					break;
				case "file_num" :	className = className+" center";
					break;
				case "created_by" :	className = className+" center";
					break;
				case "created_by_name" :	className = className+" center";
					break;
				case "creation_date" :	className = className+" center";
					break;
				case "cnt" :	className = className+" center";
					break;
				case "popup_yn" :	className = className+" center";
					break;
			}
			return className;
		}
		
		$scope.gridOptions = vm.gridOptions(  				// 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableFiltering : true, 					//각 컬럼에 검색바
				
				paginationPageSizes : [10,100,200,300,400,500,1000], 		//한번에 보여질 로우수 셀렉트리스트	
			    paginationPageSize: 10,
				
				enableCellEditOnFocus : true, 				//셀 클릭시 edit모드 
				enableSelectAll : true, 					//전체선택 체크박스
				enableRowSelection : true, 					//로우 선택
				enableRowHeaderSelection : true, 			//맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 35, 				//체크박스 컬럼 길이
				rowHeight : 27, 							//체크박스 컬럼 높이
// 				useExternalPagination : true, 				//pagination을 직접 세팅
				enableAutoFitColumns: true,					//컬럼 width를 자동조정
				multiSelect : true, 						//여러로우선택
				enablePagination : true,
				enablePaginationControls: true,
				
				columnDefs : [  							//컬럼 세팅
					{ displayName: '공지', field: 'header_yn',enableCellEdit : false, allowCellFocus : false, cellClass :$scope.cellClassSet , width:"6%"
						, cellTemplate : '<div class="ui-grid-cell-contents" style="font-size:15px;"><i style="cursor:pointer;" ng-if="row.entity.header_yn ==\'Y\'" class="fas fa-bell ui-grid-click-column" ng-click="grid.appScope.openBoardDetail(row.entity)"></i></div>'},
					{ visible:true, displayName: '팝업', field: 'popup_yn',enableCellEdit : false, allowCellFocus : false, cellClass :$scope.cellClassSet , width:"6%"
						, cellTemplate : '<div class="ui-grid-cell-contents" style="font-size:15px;"><i style="cursor:pointer;" ng-if="row.entity.popup_yn ==\'Y\'" class="fas fa-bullhorn ui-grid-click-column" ng-click="grid.appScope.openBoardDetail(row.entity)"</i></div>'},
					{ displayName: '번호', field: 'board_no',enableCellEdit : false, allowCellFocus : false, cellClass: $scope.cellClassSet, width:"6%"},
		            { displayName: '제목', field: 'title',enableCellEdit : false, allowCellFocus : false, cellClass: $scope.cellClassSet
		            	,cellTemplate : '<div style="cursor:pointer" class="ui-grid-cell-contents ng-binding ng-scope ui-grid-click-column" ng-click="grid.appScope.openBoardDetail(row.entity)">{{row.entity.title}}</div>'},
		            { displayName: '파일', field: 'file_num',enableCellEdit : false, allowCellFocus : false, cellClass :$scope.cellClassSet , width:"6%"
		           		, cellTemplate : '<div class="ui-grid-cell-contents" style="font-size:15px;"><i style="cursor:pointer;" ng-if="row.entity.file_num>0" class="fas fa-save ui-grid-click-column" ng-click="grid.appScope.openAttachModal(row.entity)">({{row.entity.file_num}})</i></div>'},
		            { visible:false, displayName: '작성자코드', field: 'created_by',enableCellEdit : false, allowCellFocus : false, cellClass : $scope.cellClassSet},
		            { visible:false, displayName: 'attach_no', field: 'attach_no',enableCellEdit : false, allowCellFocus : false, cellClass :$scope.cellClassSet} , 
		            { displayName: '작성자', field: 'created_by_name',enableCellEdit : false, allowCellFocus : false, cellClass : $scope.cellClassSet, width:"8%"},
		            { displayName: '작성일', field: 'creation_date',enableCellEdit : false, allowCellFocus : false, cellClass: $scope.cellClassSet , width:"13%"},
		            { displayName: '조회수', field: 'cnt',enableCellEdit : false, allowCellFocus : false, cellClass : $scope.cellClassSet, width:"7%"},
		            { displayName: '수정', field: 'board_no',enableCellEdit : false, allowCellFocus : false, cellClass : $scope.cellClassSet, width:"7%"
		            	, cellTemplate : '<div style="font-size:15px;" class="ui-grid-cell-contents ui-grid-click-column"><i style="cursor:pointer;" ng-if="grid.appScope.idChk(row)" class="fas fa-edit ui-grid-click-column" ng-click="grid.appScope.openBoardUpdate(row.entity)"></i></div>'},
		            	
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
	var scope = angular.element(document.getElementById("board-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
	scope.gridApi.selection.on.rowSelectionChanged(scope,function(row){			//로우 선택할때마다 이벤트
		
    });
	
	/* scope.gridApi.selection.on.rowSelectionChangedBatch(scope,function(rows){	//전체선택시 가져옴
		console.log(rows);           //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
    });	 */
	
	//pagenation option setting  그리드를 부르기 전에 반드시 선언
	var param = {
		listQuery : "biz_board.grid_boardList", 				//list가져오는 마이바티스 쿼리 아이디
		cntQuery : "biz_board.grid_boardCnt"						//list cnt 가져오는 마이바티스 쿼리 아이디
	}; 
	scope.paginationOptions = customExtend(scope.paginationOptions,param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합	
	
	scope.reloadGrid({
		
	});
	//복붙영역(앵귤러 이벤트들 가져오기) 끝2
	
	//rows렌더링된 후에 동작 이벤트 추가
	var one_time = true;
	scope.gridApi.core.on.rowsRendered(scope, function() {
        //code to execute
		//메인화면에서 게시글을 클릭하여 들어온 경우, board_no값을 받아옵니다.
		//메뉴에서 공지게시판을 눌러서 들어온 경우, board_no=-1입니다.(board_no 디폴트값 : -1)
		if(${board_no} != -1 && one_time){
			var rows = scope.gridApi.grid.rows;
			for(var i=0; i<rows.length; i++){
				var board_no = ${board_no};
				if(rows[i].entity.board_no == ${board_no}){
					scope.openBoardDetail(rows[i].entity);
					one_time = false;
					break;
				}
			}
		}
        
	});
	
	$("#write_btn").on("click",function(){
		
		//iframe텍스트 영역의 높이가 0이여서 클릭안되는 버그
		//height를 100%로 주어서 해결
		$('#write_content-iframe').height($('#write_content').height() + 50);
		var iframeMain = $("#write_content-iframe").contents().find('#se2_iframe');
		iframeMain.height("100%");
		
		//에디터 초기화
		oEditors.getById["write_content"].exec("SET_IR", [""]);	
		
		//Textarea 내용을 초기화
		$("#write_content").html("");
		
		//에디터 가려지는 부분 보이게하기
		var ifram = $("#write_content").next("iframe");
    	ifram.css("width","100%").css("height","344px");
    	
		
		var $boardWriteModal = $("#boardWriteModal");
		$boardWriteModal.modal({
			backdrop : false,
			keyboard: false
		});
		
    	
		//form 리셋
		$("#boardWrFrm")[0].reset();
		
		//파일드롭다운하는 모달 세팅
		scope.fileDropZone.fileListLoad({
			url : "/biz/ICMFileList",
			param : {attach_no : null, 
				    '${_csrf.parameterName}' : '${_csrf.token}'}
		});
		
	});
	
	$("#search_btn").on("click",function(){		
		scope.reloadGrid({
			board_search : $("#board_search option:selected").val(),
			board_searchValue : $("#board_searchValue").val(),
		});
		$("#board_searchValue").val("");
	});
	
	$("#delete_btn").on("click",function(){		
		
		var selectedRows = scope.gridApi.selection.getSelectedRows();
		var datas = scope.gridOptions.data;

		if(isEmpty(selectedRows)){
			swalWarning("삭제할 게시글을 선택해주십시오.");
			return false;
		}
		
		//삭제권한 검사
		for(var i=0; i<selectedRows.length; i++){
			if(selectedRows[i].created_by != scope.emp_cd){
				swalWarning("해당 게시글의 작성자만이 삭제할 수 있습니다.");
				return false;
			}
		}
		
		var data = $("#searchFrm").serializeArray();
		data.push({name: "gridData", value: JSON.stringify(selectedRows)});
		console.log("data:",data);
		
		swal({
			  icon : "info",
			  text: "삭제하시겠습니까?",
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
						url: '/biz/board/boardDelete',
						data: data,
						dataType: 'json',
						async : false,
						success: function(data){
							swalSuccess("삭제 되었습니다.");
							$("#board_searchValue").val("");
							$("#search_btn").trigger("click");
						},
				        complete: function(){}
					}); 
			 	 }			  
			});		
// 		scope.gridApi.core.notifyDataChange(scope.uiGridConstants.dataChange.ALL);	
		//리로드
	});
	
});

function enter_check(){
	// 엔터키의 코드는 13입니다.
    if(event.keyCode == 13){
    	$("#search_btn").trigger("click");
    }
}

</script>

</body>