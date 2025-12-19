<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String s_emp_code = (request.getSession().getAttribute("s_emp_code") == null)?"":(String)(request.getSession().getAttribute("s_emp_code"));
    String s_emp_name = (request.getSession().getAttribute("s_emp_name") == null)?"":(String)(request.getSession().getAttribute("s_emp_name"));
    String s_company_name = (request.getSession().getAttribute("s_company_name") == null)?"":(String)(request.getSession().getAttribute("s_company_name"));
%>
<head>
<title>Main</title>
<style>
.container-fluid{min-width:1352px !important;}
.container-fluid h1 {
    font-size: 16px;
    margin: 20px 0px 10px 0px !important;
    font-weight: bold;
}
.tblType01 {
    margin: 0 15px !important;
    border-top: 1px solid #e4e4e4;
}
.swal-text {
  text-align: left;
}
</style>
</head>
<body>

	<section class="section">
		<h2 class="subTitle">Main</h2>
		<div class="searchTable">
			<form class="actschedForm" id="actsched">
			<!-- 20191023_khj for csrf -->
			<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" id="doc_type" name="doc_type" value="INS">
				<table>
					<colgroup>
						<col style="width:86px">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">SelectBox</th>
							<td class="controlPeriod">
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
			</form>
		</div>
	</section>

<div class="mainSch" style="min-width:1352px;">
<section class="box1">
	<div class="inner">
		<h3 class="tit">Info 1</h3>
		<p class="date"></p>
		<ul class="list">
			<li>전체 <span class="total">0</span></li>
			<li>진행 <span class="proceeding">0</span></li>
			<li>완료 <span class="ended">0</span></li>
		</ul>
	</div>
</section>
<section class="box2">
	<div class="inner">
		<h3 class="tit">Info 2</h3>
		<p class="date"></p>
		<ul class="list">
			<li>전체 <span class="total">0</span></li>
			<li>진행 <span class="proceeding">0</span></li>
			<li>완료 <span class="ended">0</span></li>
		</ul>
	</div>
</section>
<section class="box3">
	<div class="inner">
		<h3 class="tit">Info 3</h3>
		<p class="date"></p>
		<ul class="list">
			<li>전체 <span class="total">0</span></li>
			<li>진행 <span class="proceeding">0</span></li>
			<li>완료 <span class="ended">0</span></li>
		</ul>
		<div class="etc">
			<span class="subTit">Issue</span>
			<ul class="list">
				<li>전체 <span>0</span></li>
				<li>완료 <span>0</span></li>
			</ul>
		</div>
	</div>
</section>
<section class="box4">
	<div class="inner">
		<h3 class="tit">Info 4</h3>
		<p class="date"></p>
		<ul class="list">
			<li style="width:100%;">상태 <span class="ceofinalrptStateText">개발중</span></li>
			</ul>
		</div>
	</section>
</div>
<h2 id="icm_page_title" style="display:none;"></h2>



<h2 class="subTitle" id="tester_subTitle">Grid 1</h2>
<section class="section" id="tester_section">
    <!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
	<div id="div-uiGrid"  data-ng-controller="ctrCtrl" style="height: 500px;">
		<div data-ui-i18n="ko" style="height: 100%;">
			<strong>Scrolling Vertically</strong> {{ gridApi.grid.isScrollingVertically }}
      		<br>
     	 	<strong>Scrolling Horizontally</strong> {{ gridApi.grid.isScrollingHorizontally }}
      		<br>
			<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav data-ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter data-ui-grid-moveColumns>
				<div data-ng-if="loader" class="loader"></div>
				<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
			</div>
		</div>
	</div>
   <!-- 복붙영역(html) 끝 -->
</section>




<%@include file="./board/popup.jsp"%>
<%@include file="./fileForm/fileUpload_modal.jsp"%>

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
			
		$scope.fileDropZone = angular.element("#attachFileTable").fileDropDown({
			areaOpen : true,
			fileSizeLimits : '<spring:eval expression="@config['file.fileSizeLimits']"/>',
			totalfileSizeLimits : '<spring:eval expression="@config['file.totalfileSizeLimits']"/>'
		});
		$scope.fileDropZone.setDropZone();
		
		$("#multifileselect").change(function(){
			$scope.fileDropZone.selectFile($("#multifileselect").get(0).files);
		})
		
		$scope.cellClassSet = function(grid, row, col, rowRenderIndex, colRenderIndex){
			var className = "center main_number blue";
			
			switch(col.field){
				case "TITLE" : className = "left boldboldbold";
					break;
			}
			
			return className;
		}
		
		$scope.openDetail = function(doc_type, num, menu_id){

			switch(num){
				//평가자 미작성 (결재상태:미상신, 작성여부: N)
				case 1 :  switch(doc_type){
							case "CDST": page_move("/icm/elcDTPerform","S","N","T"); //인자설명 : (경로,결재상태,사용여부,수행역할) 수행역할은(T:평가자, M:현업담당자)
					  			break; 
					  		case "DST": page_move("/icm/plcDTPerform","S","N","T"); 
					  			break; 
						  	case "ACT": page_move("/icm/elcOEPerform","S","N","T");  
						  		break; 
						  	case "INS": page_move("/icm/plcOEPerform","S","N","T");   
						  		break;
						  	case "RPT": page_move("/icm/operationalEvaluationResultReport","S","","");  
						  		break;
						  	case "AUD": form.setAttribute("action", "/icm/testaudtPerform"); form.appendChild(csrf_element); form.submit(); 
					  			break;
						  	case "ADR": form.setAttribute("action", "/icm/testaudtPerform"); form.appendChild(csrf_element); form.submit(); 
					  			break;
						  }
					break;
				//평가자 작성중(결재상태:미상신, 작성여부: Y)
				case 2 :  switch(doc_type){
							case "CDST": page_move("/icm/elcDTPerform","S","Y","T"); 
					  			break; 
					  		case "DST": page_move("/icm/plcDTPerform","S","Y","T"); 
					  			break; 
							case "ACT": page_move("/icm/elcOEPerform","S","Y","T");   
						  		break;
						  	case "INS": page_move("/icm/plcOEPerform","S","Y","T");    
						  		break;
						  	case "RPT": page_move("/icm/operationalEvaluationResultReport","S","",""); 
						  		break;
						  	case "AUD": form.setAttribute("action", "/icm/testaudtPerform"); form.appendChild(csrf_element);  form.submit(); 
				  				break;
					  		case "ADR": form.setAttribute("action", "/icm/testaudtConsolidation"); form.appendChild(csrf_element);  form.submit(); 
				  				break;
						  }
					break;
				//평가자 결재진행
				case 3 :  switch(doc_type){
							case "CDST": page_move("/icm/elcDTPerform","P","","T");  
					  			break; 
					  		case "DST": page_move("/icm/plcDTPerform","P","","T");  
					  			break; 
						  	case "ACT": page_move("/icm/elcOEPerform","P","","T");    
						  		break;
						  	case "INS": page_move("/icm/plcOEPerform","P","","T");     
						  		break;
						  	case "RPT": page_move("/icm/operationalEvaluationResultReport","P","","");  
						  		break;
						  	case "AUD": form.setAttribute("action", "/icm/testaudtPerform"); form.appendChild(csrf_element); form.submit(); 
				  				break;
					  		case "ADR": form.setAttribute("action", "/icm/testaudtConsolidation"); form.appendChild(csrf_element); form.submit(); 
				  				break;	
						  }
					break;
				//평가자 결재반려
				case 4 :  switch(doc_type){
							case "CDST": page_move("/icm/elcDTPerform","R","","T");   
					  			break; 
					  		case "DST": page_move("/icm/plcDTPerform","R","","T");   
					  			break; 
						  	case "ACT": page_move("/icm/elcOEPerform","R","","T");    
						  		break;
						  	case "INS": page_move("/icm/plcOEPerform","R","","T");      
						  		break;
						  	case "RPT": page_move("/icm/operationalEvaluationResultReport","R","",""); 
						  		break;
						  	case "AUD": form.setAttribute("action", "/icm/testaudtPerform"); form.appendChild(csrf_element); form.submit(); 
			  					break;
				  			case "ADR": form.setAttribute("action", "/icm/testaudtConsolidation"); form.appendChild(csrf_element);  form.submit(); 
			  					break;	
						  }
					break;
				//평가자 결재완료
				case 5 :  switch(doc_type){
							case "CDST": page_move("/icm/elcDTPerform","E","","T");    
					  			break; 
					  		case "DST": page_move("/icm/plcDTPerform","E","","T");    
					  			break; 
						  	case "ACT": page_move("/icm/elcOEPerform","E","","T");     
						  		break;
						  	case "INS": page_move("/icm/plcOEPerform","E","","T");       
						  		break;
						  	case "RPT": page_move("/icm/operationalEvaluationResultReport","E","","");
						  		break;
						  	case "AUD": form.setAttribute("action", "/icm/testaudtPerform"); form.appendChild(csrf_element);  form.submit(); 
			  					break;
			  				case "ADR": form.setAttribute("action", "/icm/testaudtConsolidationReview"); form.appendChild(csrf_element);  form.submit(); 
			  					break;	
						  }
					break;
			}
		}
		
		$scope.pagination = vm.pagination;
		$scope.gridOptions = vm.gridOptions(  				// 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableFiltering : false, 					//칵 컬럼에 검색바
				paginationPageSizes : [500, 1500, 5000, 10000], 		//한번에 보여질 로우수 셀렉트리스트
				enableCellEditOnFocus : true, 				//셀 클릭시 edit모드 
				enableSelectAll : false, 					//전체선택 체크박스
				enableRowSelection : false, 					//로우 선택
				enableRowHeaderSelection : false, 			//맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 35, 				//체크박스 컬럼 길이
				rowHeight : 27, 							//체크박스 컬럼 높이
				useExternalPagination : true, 				//pagination을 직접 세팅
				enableAutoFitColumns: false,					//컬럼 width를 자동조정
				multiSelect : true, 						//여러로우선택
				enablePagination : false,
				enablePaginationControls: false,
				columnDefs : [  							//컬럼 세팅
					{ displayName: '아이디', field: 'emp_code',enableCellEdit : false, allowCellFocus : false, cellClass : $scope.cellClassSet},
		            { displayName: '유저명', field: 'emp_name',enableCellEdit : false, allowCellFocus : false, cellClass : $scope.cellClassSet
					, cellTemplate : '<div class="ui-grid-cell-contents ui-grid-dbclick-column" ng-click="grid.appScope.openDetail(row.entity.emp_name, 1)">{{row.entity.emp_name}}</div>'},
					{ displayName: '이메일', field: 'email',enableCellEdit : false, allowCellFocus : false, cellClass : $scope.cellClassSet},
					{ displayName: '패스워드변경일', field: 'pwchg_date',enableCellEdit : false, allowCellFocus : false, footerCellTemplate : '<div class="ui-grid-cell-contents" style="text-align:right; color: #31486a">Total : {{grid.options.totalItems}}</div>', cellClass : $scope.cellClassSet
					, cellTemplate : '<div class="ui-grid-cell-contents ui-grid-dbclick-column" ng-click="grid.appScope.openDetail(row.entity.DOC_TYPE, 5)">{{row.entity.pwchg_date}}</div>'},
		            { displayName: '로그인일시', field: 'login_datetime',enableCellEdit : false, allowCellFocus : false, cellClass:"center"}
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
	function managerNavi(doc_type){
		var form = document.createElement("form");
		form.setAttribute("method","post");
		
		var element = document.createElement("input");
		
		//20191023_khj for csrf
		var csrf_element = document.createElement("input");
		csrf_element.name  = "_csrf";
		csrf_element.value = "${_csrf.token}";
		csrf_element.type  = "hidden";
		//20191023_khj for csrf
		
		document.body.appendChild(form);
		switch(doc_type){
			case "CDST": form.setAttribute("action", "/icm/elcDTPerform"); form.appendChild(csrf_element); form.submit(); 
				break; 
			case "DST": form.setAttribute("action", "/icm/plcDTPerform"); form.appendChild(csrf_element); form.submit(); 
				break; 
		  	case "ACT": form.setAttribute("action", "/icm/elcOEPerform"); form.appendChild(csrf_element); form.submit(); 
		  		break;
		  	case "INS": form.setAttribute("action", "/icm/plcOEPerform"); form.appendChild(csrf_element); form.submit(); 
		  		break;
		}
	}
	
$(document).ready(function(){

	
	//복붙영역(앵귤러 이벤트들 가져오기) 시작, 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
	var scope = angular.element(document.getElementById("div-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴


	/* scope.gridApi.selection.on.rowSelectionChangedBatch(scope,function(rows){	//전체선택시 가져옴
		console.log(rows);           //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
    });	 */
	
	//pagenation option setting  그리드를 부르기 전에 반드시 선언
	var param = {
		listQuery : "biz_main.grid_todoList", 		//list가져오는 마이바티스 쿼리 아이디
		cntQuery : "biz_main.grid_cnt_todoList",	//list cnt 가져오는 마이바티스 쿼리 아이디
	}; 
    
	scope.paginationOptions = customExtend(scope.paginationOptions,param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합

	//복붙영역(앵귤러 이벤트들 가져오기) 끝

	scope.reloadGrid({
		term_code : $("#termcode option:selected").val()
	});
	
	
	

	
	//평가자 역할 그리드 Completed event
	scope.gridApi.core.on.rowsRendered(scope, function() {
		
	});
	

	
	
	if("${beforURI}".indexOf("/core/login/login")!=-1){
		//2019-10-28 smh 최근 마지막 로그인정보 alert.시작
		$.ajax({
				type: 'POST',
				url: '/core/loginLogChk',
				data: {},
				dataType: 'json',
				contentType: "application/json; charset=utf-8",
				async : false,
				success: function(data){
					var text="";
					if(data.loginLogNum>1){
						var login_datetime = data.loginLogLastInfo[0].login_datetime;
						var login_name = data.loginLogLastInfo[0].login_name;
						var login_ip = data.loginLogLastInfo[0].login_ip;
						text="최종접속일 : "+login_datetime+"\r\n"+"최종접속 IP : "+login_ip;
					}else{
						text="최초 접속입니다.";
					}
					
					swal({
						  icon : "info",
						  text: text,
						  closeOnClickOutside : false,
						  closeOnEsc : false,
						  buttons: {
								confirm: {
								  text: "확인",
								  value: true,
								  visible: true,
								  className: ""
								}
						  }
						})
						.then(function(result){
							  if(result){
								//2019-08-18 smh 공지사항 시작
									if(getCookie("is_popup")!="Y"){
										
										//board의 popup_yn컬럼 값이 "Y"가 존재하는지 판단
										$.ajax({
												type: 'POST',
												url: '/biz/board/popupChk',
												data: {},
												dataType: 'json',
												contentType: "application/json; charset=utf-8",
												async : false,
												success: function(data){
													//popup_yn = 'Y' 가 존재할때
													if(data.popupNum>0){
														//첨부파일 드랍존 세팅
														scope.fileDropZone.fileListLoad({
															url : "/biz/ICMFileList",
															param : {attach_no : ("${popupData.attach_no}"==null)?null : "${popupData.attach_no}"}
														});
														
														//파일첨부 운영자만 모달 삭제버튼 보여주기
														if("${s_authogrp_code}"=="00"){
															$(".attachDeleteBtn").css("display", "");
														}else{
															$(".attachDeleteBtn").css("display", "none");
														}	
														
														//2019-08-18 smh 팝업모달 띄우기
														var $popupModal = $("#popupModal");
														$popupModal.modal({
															backdrop : 'static',
															keyboard: false
														});
													}
												},
										        complete: function(){}
											});
									}
							  }
						});
				},
		        complete: function(){}
			});
			//2019-10-28 smh 최근 마지막 로그인정보 alert.끝
		}

});

//2019-08-18 smh 공지사항 끝
//page 이동 함수
function page_move(url, flag, write_yn, position){
	if(write_yn == undefined){
		write_yn = "";
	}
	
	//form 생성
	var form = document.createElement("form"); 
	form.setAttribute("method","post");
	
	//결재상태 element
	var flag_element = document.createElement("input");
	flag_element.name = "flag";
	flag_element.type = "hidden";
	
	//작성여부 element
	var write_yn_element = document.createElement("input");
	write_yn_element.name = "write_yn";
	write_yn_element.type = "hidden";
	
	//수행역할 element
	var position_element = document.createElement("input");
	position_element.name = "position";
	position_element.type = "hidden";
	
	//20191023_khj for csrf
	var csrf_element = document.createElement("input");
	csrf_element.name  = "_csrf";
	csrf_element.value = "${_csrf.token}";
	csrf_element.type  = "hidden";
	//20191023_khj for csrf
	
	//term_code element
	var term_code_element = document.createElement("input");
	term_code_element.name = "term_code";
	term_code_element.value = $("#termcode option:selected").data("term-code");
	term_code_element.type  = "hidden";
	
	//form을 body에 추가
	document.body.appendChild(form); //form.setAttribute("action", "/icm/elcOEPerform");  form.submit(); 
	
	//form에 경로 element 추가
	form.setAttribute("action", url); 
	form.appendChild(csrf_element); 
	
	//form에 결재상태 element 추가
	flag_element.value = flag; 
	form.appendChild(flag_element); 
	
	//form에 작성여부 element 추가
	write_yn_element.value = write_yn; 
	form.appendChild(write_yn_element); 
	
	//form에 수행역할 element 추가
	position_element.value = position; 
	form.appendChild(position_element);
	
	//form에 term_code element 추가
	form.appendChild(term_code_element);
	
	//form 제출
	form.submit();
	
}
</script>

</body>