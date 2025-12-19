<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Modal -->
<div class="modal fade" id="modal_account" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" style="width:1000px;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="row modal-title">Sub Modal</h4>
      </div>
      <form id="frm" style="height:50%;">
      	<!-- 20191023_khj for csrf -->
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	   	<div class="popup_w">
        	<div class="popup_left">
            	<div class="popup_box">
                	<div class="title">Sub Chart1</div>
                    <div class="graph" style="height:30%">
						<canvas id="tot_account" height="200"></canvas>
                    </div>
                </div>
            </div>
            <div class="popup_center">
            	<div class="popup_box">
                	<div class="title">Sub Chart2</div>
                    <div class="graph" style="height:30%">
                    	<canvas id="qt_account" height="200"></canvas>
                    </div>
                </div>
            </div>
            <div class="popup_right">
            	<div class="popup_box">
                	<div class="title">Sub Chart3</div>
                    <div class="graph" style="height:30%">
                    	<canvas id="ql_account" height="200"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <div class="table_gray1">
                <div class="table_w">
                        <div class="graph" style="height:300px;">
                    	<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller  -->
						<div id="modalAccountCtrl-uiGrid"  data-ng-controller="modalAccountCtrl" style="height: 100%;">
							<div data-ui-i18n="ko" style="height: 100%;">
								<div data-ui-grid="gridOptions" style="height:100%;" class="grid" data-ui-grid-edit data-ui-grid-cellNav data-ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
									<div data-ng-if="loader" class="loader"></div>
									<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
								</div>
							</div>
						</div>
						<!-- 복붙영역(html) 끝 -->
						<script>
							//복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  
							app.controller('modalAccountCtrl', ['$scope','$controller','$log','StudentService', 
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
								
								$scope.defs = [  							
									{ displayName: 'Column1', field: 'column1',enableCellEdit : false, allowCellFocus : false, cellClass : "left",},
									{ displayName: 'column2', field: 'column2',enableCellEdit : false, allowCellFocus : false, cellClass : "center"},
									{ displayName: 'column3', field: 'column3',enableCellEdit : false, allowCellFocus : false, cellClass : "right"},
									{ displayName: 'Column4', field: 'column4',enableCellEdit : false, allowCellFocus : false, cellClass : "left"},
								];
								
								//click event : 복붙안해도됨 / 시작
								
								
								
								//dbclick event : 복붙안해도됨 / 끝
								
								$scope.pagination = vm.pagination;
								$scope.gridOptions = vm.gridOptions(  				// 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
									{
										enableFiltering : false, 					//칵 컬럼에 검색바
										paginationPageSizes : [500, 1500, 5000, 10000], 		//한번에 보여질 로우수 셀렉트리스트
										enableCellEditOnFocus : false, 				//셀 클릭시 edit모드 
										enableSelectAll : false, 					//전체선택 체크박스
										enableRowSelection : false, 					//로우 선택
										enableRowHeaderSelection : false, 			//맨앞 컬럼 체크박스 컬럼으로
										selectionRowHeaderWidth : 35, 				//체크박스 컬럼 길이
										rowHeight : 27, 							//체크박스 컬럼 높이
										useExternalPagination : false, 				//pagination을 직접 세팅
										enableAutoFitColumns: true,					//컬럼 width를 자동조정
										multiSelect : false, 						//여러로우선택
										enablePagination : false,					//pagenation 숨기기
										enablePaginationControls: false,			//pagenation 숨기기
										columnDefs : []								//컬럼 세팅
										
									}
								);  
								
								$scope.gridLoad = vm.gridLoad; 						//부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님 
								$scope.reloadGrid = vm.reloadGrid;
																					//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능  
							
							}]);
							//복붙영역(앵귤러단) 끝

							
							$(document).ready(function(){
							
								//복붙영역(앵귤러 이벤트들 가져오기) 시작, 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
								//ui-grid 초기 조회조건 세팅
								
								var scope = angular.element(document.getElementById("modalAccountCtrl-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
								scope.gridApi.selection.on.rowSelectionChanged(scope,function(row){			//로우 선택할때마다 이벤트
									
							    });
								
								/* scope.gridApi.selection.on.rowSelectionChangedBatch(scope,function(rows){	//전체선택시 가져옴
									console.log(rows);           //전체선택된 로우 array (rows[i].entity가 로우의 오브젝트)
							    });	 */
								
								//pagenation option setting  그리드를 부르기 전에 반드시 선언
								var param = {
									listQuery : "biz_dashBoard.grid_modalAccountList", 		 //list가져오는 마이바티스 쿼리 아이디
									cntQuery : "biz_dashBoard.grid_modalAccountCnt"			 //list cnt 가져오는 마이바티스 쿼리 아이디

							    }; 
								scope.paginationOptions = customExtend(scope.paginationOptions,param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
							//	scope.gridLoad(scope.paginationOptions);               //처음페이지 로드될때 테이블 로드
								//복붙영역(앵귤러 이벤트들 가져오기) 끝
								//대쉬보드탭의 감사일지 그리드 끝
								
								$("#btn_modal_account").on("click",function(){
									scope.gridOptions.columnDefs = scope.defs;
									scope.reloadGrid({
										//d_termcode : $("#d_termcode").val()
									});
								});
							
							});
							
						</script>        	
                    </div>
                  </div>
        </div>
        <div class="table_gray1" style="margin-top:20px;">
            <div class="table_w">

             </div>
        </div>    
	  </form>
      <div class="modal-footer">
        <button type="button" class="just-close btn btn-primary" data-dismiss="modal">닫기</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script>

//Chart binding variable start//
var tot_account; 
var qt_account;	
var ql_account;
//Chart binding variable end//


$(document).ready(function(){
	
	
});

function chartMake_modalAccount(){
	$.ajax({
		type: 'POST',
		url: '/biz/dashBoard/modal_account_cnt',
		data: {},
		async:false,
		dataType: 'json',
		success: function(data){
			var modal_account_cnt = data.modal_account_cnt;
			var color = Chart.helpers.color;
			//Sub Chart1
			var tot_account_data = {
				labels: ['Sub Chart1'],
				datasets: [
					{
						label: modal_account_cnt[2].term_code,
						backgroundColor: 'rgba(255, 222, 119, 1)',
						borderColor: 'rgba(255, 222, 119, 1)',
						borderWidth: 1,
						data: [modal_account_cnt[2].total_cnt],
						datalabels: {anchor: 'end'}
					},
					{
						label: modal_account_cnt[1].term_code,
						backgroundColor: 'rgba(177, 214, 83, 1)',
						borderColor: 'rgba(177, 214, 83, 1)',
						borderWidth: 1,
						data: [modal_account_cnt[1].total_cnt],
						datalabels: {anchor: 'end'}
					},
					{
						label: modal_account_cnt[0].term_code,
						backgroundColor: 'rgba(128, 209, 254, 1)',
						borderColor: 'rgba(128, 209, 254, 1)',
						borderWidth: 1,
						data: [modal_account_cnt[0].total_cnt],
						datalabels: {anchor: 'end'}
					},
				
				]

			};
			
			//Sub Chart2
			var qt_account_data = {
				labels: ['Sub Chart2'],
				datasets: [
					{
						label: modal_account_cnt[2].term_code,
						backgroundColor: 'rgba(255, 222, 119, 1)',
						borderColor: 'rgba(255, 222, 119, 1)',
						borderWidth: 1,
						data: [modal_account_cnt[2].qntfact_cnt],
						datalabels: {anchor: 'end'}
					},
					{
						label: modal_account_cnt[1].term_code,
						backgroundColor: 'rgba(177, 214, 83, 1)',
						borderColor: 'rgba(177, 214, 83, 1)',
						borderWidth: 1,
						data: [modal_account_cnt[1].qntfact_cnt],
						datalabels: {anchor: 'end'}
					},
					{
						label: modal_account_cnt[0].term_code,
						backgroundColor: 'rgba(128, 209, 254, 1)',
						borderColor: 'rgba(128, 209, 254, 1)',
						borderWidth: 1,
						data: [modal_account_cnt[0].qntfact_cnt],
						datalabels: {anchor: 'end'}
					},
				
				]

			};
			
			//Sub Chart3
			var ql_account_data = {
				labels: ['Sub Chart3'],
				datasets: [
					{
						label: modal_account_cnt[2].term_code,
						backgroundColor: 'rgba(255, 222, 119, 1)',
						borderColor: 'rgba(255, 222, 119, 1)',
						borderWidth: 1,
						data: [modal_account_cnt[2].qltfact_cnt],
						datalabels: {anchor: 'end'}
					},
					{
						label: modal_account_cnt[1].term_code,
						backgroundColor: 'rgba(177, 214, 83, 1)',
						borderColor: 'rgba(177, 214, 83, 1)',
						borderWidth: 1,
						data: [modal_account_cnt[1].qltfact_cnt],
						datalabels: {anchor: 'end'}
					},
					{
						label: modal_account_cnt[0].term_code,
						backgroundColor: 'rgba(128, 209, 254, 1)',
						borderColor: 'rgba(128, 209, 254, 1)',
						borderWidth: 1,
						data: [modal_account_cnt[0].qltfact_cnt],
						datalabels: {anchor: 'end'}
					},
				
				]

			};
			
			
				//chart.js 버그 방지(차트에 마우스오버시 old data show현상)
				if (window.tot_account != undefined) {
					window.tot_account.destroy();
				}
				if (window.qt_account != undefined) {
					window.qt_account.destroy();
				}
				if (window.ql_account != undefined) {
					window.ql_account.destroy();
				}
			
				var ctx_tot_account = document.getElementById('tot_account').getContext('2d');
				window.tot_account = new Chart(ctx_tot_account, {
					type: 'bar',
					data: tot_account_data,
					options: {
						responsive: true,
						title: {
							display: false,
							text: ''
						},
						legend : {
					  		display : true,
					  		position : 'top',
					  		labels: { 
					  		     padding: 10,
					  		  	 usePointStyle: true
					  		} 
					  	},
						animation: {
							duration: 0
						},
						scales: {
		                    yAxes: [
		                        {
		                            ticks: {
		                                min: 0,
		                                //max : 500,
		                                beginAtZero: true,
		                                stepSize: 100
		                            }
		                        }
		                    ]
		                },
						plugins: {
							datalabels: {
								backgroundColor: function(context) {
									return context.dataset.backgroundColor;
								},
								borderColor: 'white',
								borderRadius: 25,
								borderWidth: 2,
								color: 'white',
								display: function(context) {
									var dataset = context.dataset;
									var count = dataset.data.length;
									var value = dataset.data[context.dataIndex];
									return value > count * 1.5;
								},
								font: {
									weight: 'bold'
								},
								formatter: Math.round
							}
						}
					}
				});

				var ctx_qt_account = document.getElementById('qt_account').getContext('2d');
				window.qt_account = new Chart(ctx_qt_account, {
					type: 'bar',
					data: qt_account_data,
					options: {
						responsive: true,
						title: {
							display: false,
							text: ''
						},
						legend : {
					  		display : true,
					  		position : 'top',
					  		labels: { 
					  		     padding: 10,
					  		  	 usePointStyle: true
					  		} 
					  	},
						animation: {
							duration: 0
						},
						scales: {
		                    yAxes: [
		                        {
		                            ticks: {
		                                min: 0,
		                                //max : 500,
		                                beginAtZero: true,
		                                stepSize: 100
		                            }
		                        }
		                    ]
		                },
						plugins: {
							datalabels: {
								backgroundColor: function(context) {
									return context.dataset.backgroundColor;
								},
								borderColor: 'white',
								borderRadius: 25,
								borderWidth: 2,
								color: 'white',
								display: function(context) {
									var dataset = context.dataset;
									var count = dataset.data.length;
									var value = dataset.data[context.dataIndex];
									return value > count * 1.5;
								},
								font: {
									weight: 'bold'
								},
								formatter: Math.round
							}
						}
					}
				});
				
				var ctx_ql_account = document.getElementById('ql_account').getContext('2d');
				window.ql_account = new Chart(ctx_ql_account, {
					type: 'bar',
					data: ql_account_data,
					options: {
						responsive: true,
						title: {
							display: false,
							text: ''
						},
						legend : {
					  		display : true,
					  		position : 'top',
					  		labels: { 
					  		     padding: 10,
					  		  	 usePointStyle: true
					  		} 
					  	},
						animation: {
							duration: 0
						},
						scales: {
		                    yAxes: [
		                        {
		                            ticks: {
		                                min: 0,
		                                //max : 500,
		                                beginAtZero: true,
		                                stepSize: 100
		                            }
		                        }
		                    ]
		                },
						plugins: {
							datalabels: {
								backgroundColor: function(context) {
									return context.dataset.backgroundColor;
								},
								borderColor: 'white',
								borderRadius: 25,
								borderWidth: 2,
								color: 'white',
								display: function(context) {
									var dataset = context.dataset;
									var count = dataset.data.length;
									var value = dataset.data[context.dataIndex];
									return value > count * 1.5;
								},
								font: {
									weight: 'bold'
								},
								formatter: Math.round
							}
						}
					}
				});	
		}
	});	
}

</script>
