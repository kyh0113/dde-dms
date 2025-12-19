<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>전사통제 Flowchart</title>
<style>
.popup_bottom{text-align : right; padding-right:20px;}
</style>
</head>
<body>

<form id="elcDesignDoc_form">
<!-- 20191023_khj for csrf -->
<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
<input type="hidden" id="attach_no" name="attach_no">
<input type="hidden" id="compo_code" name="compo_code">
<input type="hidden" id="compo_name" name="compo_name">

	<section class="section">
		<h2 class="subTitle">전사통제 Flowchart</h2>
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
			<div class="selList">
				<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
				<div id="compoCtrl-uiGrid"  data-ng-controller="compoCtrl" style="height: 100%;">
					<div data-ui-i18n="ko" style="height: 100%;">
						<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav data-ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
							<div data-ng-if="loader" class="loader"></div>
							<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
						</div>
					</div>
				</div>
				<!-- 복붙영역(html) 끝 -->
			</div>
		</div>
		<div class="box" style="width:60%;">
			<div>
				<table class="tableTypeInput">
					<colgroup>
						<col style="width: 132px;">
						<col>
					</colgroup>
					<tbody>
						<tr>
		                 <th scope="col">문서담당자</th>
		                 <td>
		                 	<input type="text" style="border-right:1px solid #d3d3d3;" class="inputTxt widthAuto" id="dept_name" name="dept_name" placeholder="" readonly>
		                    <input type="text" class="inputTxt widthAuto" id="user_name" name="user_name" placeholder="" readonly>
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
					<button id="elcDesignDoc_save_btn" type="button" class="btnTypeM">저장</button>
				</span>
			</div>	
		</div>
	</section>

</form>
<%@include file="./docManagerAlloc_modal.jsp"%>
<script>
	//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
	app.controller('compoCtrl', ['$scope','$controller','$log','StudentService', 'uiGridConstants',
	function ($scope,$controller,$log,StudentService,uiGridConstants) {		//$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
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
		
		$scope.uiGridConstants = uiGridConstants;
		
		$scope.addRow = vm.addRow;
		
		$scope.pagination = vm.pagination;
		$scope.gridOptions = vm.gridOptions(  				// 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableFiltering : false, 					//칵 컬럼에 검색바
				paginationPageSizes : [500, 1500, 5000, 10000], 		//한번에 보여질 로우수 셀렉트리스트
				enableCellEditOnFocus : false, 				//셀 클릭시 edit모드 
				enableSelectAll : false, 					//전체선택 체크박스
				enableRowSelection : true, 					//로우 선택
				enableRowHeaderSelection : false, 			//맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 35, 				//체크박스 컬럼 길이
				rowHeight : 27, 							//체크박스 컬럼 높이
				useExternalPagination : false, 				//pagination을 직접 세팅
				enableAutoFitColumns: true,					//컬럼 width를 자동조정
				multiSelect : false, 						//여러로우선택
				enablePagination : false,					//pagenation 숨기기
				enablePaginationControls: false,			//pagenation 숨기기
				columnDefs : [  							//컬럼 세팅
					{ visible:false, displayName: '구성요소아이디', field: 'code_id',enableCellEdit : false, allowCellFocus : false, cellClass : $scope.cellClassSet},
					{ displayName: '구성요소명', field: 'code_name',enableCellEdit : false, allowCellFocus : false, cellClass : $scope.cellClassSet}
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
	
	//fileDropDown("fileTableTbody");
	var fileDropZone = $("#fileTableTbody").fileDropDown({
		areaOpenText : "구성요소를 먼저 선택해주십시오.",
		areaOpen : true,
		fileSizeLimits : '<spring:eval expression="@config['file.fileSizeLimits']"/>',
		totalfileSizeLimits : '<spring:eval expression="@config['file.totalfileSizeLimits']"/>'
	});
	fileDropZone.setDropZone();
	
	$("#multifileselect").change(function(){
		fileDropZone.selectFile($("#multifileselect").get(0).files);
	})
	
	
	var scope = angular.element(document.getElementById("compoCtrl-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
	
	<c:forEach var="compo" items="${compoList}">
		scope.gridOptions.data.push({code_id: "${compo.code_id}", code_name: "${compo.code_name}"});
	</c:forEach>
	
	
	$("#termcode").on("change",function(){
		
		document.getElementById("dept_code").value = "";
		document.getElementById("dept_name").value = "";
		document.getElementById("user_id").value = "";
		document.getElementById("user_name").value = "";
		fileDropZone.fileListLoad({
			url : "/biz/ICMFileList",
			param : {}
		});
	});
	
	scope.gridApi.selection.on.rowSelectionChanged(scope,function(row){			//로우 선택할때마다 이벤트
		var term_code =  $("#termcode option:selected").data("term-code");
		var code_id = row.entity.code_id;
		var code_name = row.entity.code_name;
		fileDropZone.area(true);
		document.getElementById("compo_code").value = code_id;
		document.getElementById("compo_name").value = code_name;
		$.ajax({
			type: 'POST',
			url: '/icm/elcDesignDocDetail',
			data: {code_id : code_id, term_code : term_code},
			dataType: 'json',
			success: function(data){

				var detail = data.elcDesignDocDetail;
				var fileList = data.fileList;
				var attach_no = "";
				document.getElementById("user_id").value = "";
				document.getElementById("user_name").value = "";
				document.getElementById("dept_code").value = "";
				document.getElementById("dept_name").value = "";
				document.getElementById("attach_no").value = "";
				if(!isEmpty(detail)){
					document.getElementById("user_id").value = detail.user_id;
					document.getElementById("user_name").value = detail.emp_name;
					document.getElementById("dept_code").value = detail.dept_code;
					document.getElementById("dept_name").value = detail.dept_name;
				}
				if(!isEmpty(fileList)){
					attach_no = fileList[0].attach_no;
					document.getElementById("attach_no").value = fileList[0].attach_no;
				}
				fileDropZone.fileListLoad({
					url : "/biz/ICMFileList",
					param : {attach_no : attach_no}
				});
			}
		});
    });
	
	
	$("#doc_manager_alloc_btn").on("click",function(){
		var selectedRow = scope.gridApi.selection.getSelectedRows()[0];
		if(isEmpty(selectedRow)){
			swalWarning("구성요소를 선택해주십시오.");
			return false;
		}
		var $docManagerAllocModal = $("#docManagerAllocModal");
		$docManagerAllocModal.modal({
			backdrop : false,
			keyboard: false
		});
	});
	
	$("#elcDesignDoc_save_btn").on("click",function(){
		
		var formData = fileDropZone.uploadFile("elcDesignDoc_form");
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
			url: '/icm/elcDesignDocSave',
			data: formData,
			processData: false,
            contentType: false,
            dataType: 'json',
			success: function(data){

				swalSuccess("저장 되었습니다.");
				
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