var app = angular.module('app', ['ngRoute','ui.grid.edit','ui.grid.cellNav', 'ui.grid','ui.grid.resizeColumns','ui.grid.pagination', 'ui.grid.exporter',
	'ui.grid.autoResize','ui.grid.selection', 'ui.grid.treeView', 'ui.grid.grouping', 'ui.grid.pinning']);
	 

	app.config(['$httpProvider', function($httpProvider) {
	    $httpProvider.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';
	}]);
	
	//20200714_khj 그리드 edit모드 사용시 한글입력란에는 다음과 같이 kr-input 설정이 필요하다.
	app.directive('krInput', ['$parse', function($parse) {
	    return {
	        priority : 0,
	        restrict : 'A',
	        compile : function(element) {
	            element.on('compositionstart', function(e) {
	                e.stopImmediatePropagation();
	            });
	        },
	    };
	}]);
	
	//20200726_khj 그리드안에 onchange 이벤트 감지 추가
	app.directive('onModelChange', function($parse){
	    return {
	        restrict: "A",
	        require: "?ngModel",
	        link: function(scope, elem, attrs, ctrl) {
	            scope.$watch(attrs['ngModel'], function (newValue, oldValue) {
	                if (typeof(newValue) === "undefined" || newValue == oldValue) {
	                    return;
	                }
	                var changeExpr = $parse(attrs['onModelChange']);
	                if (changeExpr) {
	                    changeExpr(scope);
	                }
	            });
	        } 
	    };
	});
	
	//20200902_khj IE input tag KOREAN 2way binding issue 
	app.config(function ($provide) {
	    $provide.decorator('inputDirective', function($delegate, $log) {
	        //$log.debug('Hijacking input directive');
	        var directive = $delegate[0];
	        angular.extend(directive.link, {
	            post: function(scope, element, attr, ctrls) {
	                element.on('compositionupdate', function (event) {
	                    element.triggerHandler('compositionend');
	                })
	            }
	        });
	        return $delegate;
	    });
	});
	
	//20200902_khj IE textarea tag KOREAN 2way binding issue 
	app.config(function ($provide) {
	    $provide.decorator('textareaDirective', function($delegate, $log) {
	        //$log.debug('Hijacking input directive');
	        var directive = $delegate[0];
	        angular.extend(directive.link, {
	            post: function(scope, element, attr, ctrls) {
	                element.on('compositionupdate', function (event) {
	                    element.triggerHandler('compositionend');
	                })
	            }
	        });
	        return $delegate;
	    });
	});
	
	
	//20200810_khj excel copied data to ui-grid
	// keys: 17 - ctrl key, 86 - v key
	app.directive('onClipboardPasted', function ($parse) {
	    return function (scope, element, attrs) {
	        element.bind("paste", function (event) {	//붙여넣기 이벤트 바인딩
	        	event.preventDefault();	//이벤트 전파방지(v키 입력되는거 방지위함)
	        	
	            //클립보드 데이터 가져오기(IE와 크롬은 다른 방식)
	            if (window.clipboardData === undefined){
	            	pastedData = event.originalEvent.clipboardData.getData('Text') // use this method in Chrome to get clipboard data.
	            }else{
	            	pastedData = window.clipboardData.getData('Text') // use this method in IE/Edge to get clipboard data.
	            }    
	            
	            //scope안에 rowRenderIndex, colRenderIndex 활용
//	            var grid_rIdx = scope.rowRenderIndex;			//현재 커서위치의 로우 인덱스
	            var grid_rIdx = scope.grid.renderContainers.body.visibleRowCache.indexOf(scope.row);	//현재 커서위치의 로우 인덱스
	            var grid_cIdx = scope.colRenderIndex;			//현재 커서위치의 셀 인덱스, 히든필드때문에 실제 인덱스가 안맞을 수 있으니 그리드 히든필드는 모두 뒤쪽으로 옮겨놓자, 1번부터 시작입니다요.
	            grid_cIdx     = grid_cIdx + 1;					//체크박스 있는 경우 인덱스 0번이 사용되기 때문에, 그리드 셀 인덱스는 1번부터 시작.
	            
	            var rows      = pastedData.split('\n');			//클립보드 데이터가 1줄 이상인 경우 개행문자 단위로 자르기, 엑셀에서 복사하면 1부터 시작
	            var grid_rows = scope.grid.options.data.length;	//현재 그리드의 총 로우 수
	            var rows_lang = rows.length;
	            
	            if(rows_lang == 1){	//단 건 클립보드 데이터인경우 루프 태우기 위해 1 더해줌
	            	rows_lang = rows_lang + 1;
	            }
	            
	            //루프 시작
	            loop: 
	            for(var i = 0; i < rows_lang - 1; i++){	//클립보드 데이터 행만큼 루프
	            	var cells = rows[i].split('\t');
	            	
	            	if(grid_rows <= i){		//렌더링 된 그리드 총 로우 개수만큼 루프되면 종료
	            		break loop;
	        		}
	            	
	            	var d = 0;
	            	var cells_lang = cells.length;
	            	
	            	for(var j = 0; j < cells_lang; j++){	//클립보드 한 행의 열만큼 루프
	            		var field = scope.col.name;	//시작 필드명
//						console.log("FIELD?",field);
//						console.log("COL_INDEX?",scope.grid.columns.indexOf(scope.col));
//	            		console.log(scope.row.grid.columns[scope.grid.columns.indexOf(scope.col) + j].field);
	
	            		//예시)scope.grid.options.data[1].SPMON = 202008;  두번째 행의 SPMON 필드의 데이터를 202008로 변경
	            		
	            		if(scope.grid.options.columnDefs[scope.grid.columns.indexOf(scope.col) + j - 1].visible == true){
	            			scope.grid.options.data[grid_rIdx][scope.row.grid.columns[scope.grid.columns.indexOf(scope.col) + j].field] = cells[d];	 
	            			d = d + 1;
	            		}else{
	            			cells_lang = cells_lang + 1;
	            		}
	            		
	            	}
 	
	            	grid_rIdx++;
	            }
	
	            scope.grid.api.core.notifyDataChange(scope.grid.appScope.uiGridConstants.dataChange.ALL);	//그리드 새로고침 
	        });
	    };
	})
	

	app.controller('CodeCtrl', ['$scope','$log','StudentService','i18nService', 'uiGridConstants', '$timeout','uiGridExporterService', 'uiGridExporterConstants', '$interval',
		function ($scope,$log,StudentService,i18nService,uiGridConstants,$timeout, uiGridExporterService, uiGridExporterConstants,$interval) {
			i18nService.setCurrentLang("ko");
			$scope.formatters = {};
			$scope.searchCnt = 0;	//20200724_khj 그리드 조회 성공시 조회성공건수 추가
			var vm = this; 
			
			vm.paginationOptions = paginationOptions();
			
			vm.gridOptions = gridOptions;
			
			
			vm.gridLoad = function(paginationParam){
				$scope.loader = true;
		    	 StudentService.getStudents(
						paginationParam).success(function(data){
							$scope.loader = false;
							
							// 2020-07-28 jamerl - 영풍 RFC <-> 그리드 조회시 RFC 코드에 의한 RFC 메세지를 출력하는 경우를 위한 처리 추가
							if(typeof data.YP_RFC_CODE !== "undefined" && data.YP_RFC_CODE === "E"){
								swalWarning(data.YP_RFC_MSG);
							}
							
				    	  $scope.gridOptions.data = data.content;
				    	  $scope.gridOptions.totalItems = data.totalElements;
				    	  $scope.searchCnt = $scope.searchCnt + 1;	//20200724_khj 그리드 조회 성공시 조회성공건수 추가
				    	  
				    	  //grid의 체크박스 아래 부분이 반쯤 가려지는 버그 수정
				    	  var viewport =  $($scope.gridApi.grid.element).find(".ui-grid-viewport");
				    	  if(viewport.length > 1){
				    		  var viewport0 = $(viewport[0]);
				    		  $interval( function() {
				    			  viewport0.height(viewport[1].clientHeight);
				    		      }, 500, 10);
				    	  }
				    	  
				      }).error(function(error){
				    	  if(error.biz_validation_message == "SESSIONNO"){
				    		  //alert("장시간 미사용으로 로그아웃 됩니다.");
				    		  location.href = "/";
				    	  }else{
				    		  swalDanger("오류가 발생하였습니다.\n관리자에게 문의해주세요.");
				    		  return false;
				    	  }
				      });
			};
			
			vm.reloadGrid = function(customParam, callback){
				var paginationParam = customExtend(vm.paginationOptions,customParam);
				$scope.loader = true;
//				console.log("이전");
				$('.wrap-loading').removeClass('display-none');
		    	 StudentService.getStudents(
						paginationParam).success(function(data){
//							console.log("성공");
							$('.wrap-loading').addClass('display-none');
							$scope.loader = false;
							
							// 2020-07-28 jamerl - 영풍 RFC <-> 그리드 조회시 RFC 코드에 의한 RFC 메세지를 출력하는 경우를 위한 처리 추가
							if(typeof data.YP_RFC_CODE !== "undefined" && data.YP_RFC_CODE === "E"){
								swalWarning(data.YP_RFC_MSG);
							}
							
				    	  $scope.gridOptions.data = data.content;
				    	  $scope.gridOptions.totalItems = data.totalElements;
				    	  $scope.searchCnt = $scope.searchCnt + 1;	//20200724_khj 그리드 조회 성공시 조회성공건수 추가
 
				    	  //grid의 체크박스 아래 부분이 반쯤 가려지는 버그 수정
				    	  var viewport =  $($scope.gridApi.grid.element).find(".ui-grid-viewport");
				    	  if(viewport.length > 1){
				    		  var viewport0 = $(viewport[0]);
				    		  $interval( function() {
				    			  viewport0.height(viewport[1].clientHeight);
				    		      }, 500, 10);
				    	  } 
						// 2020-11-23 jamerl - reloadGrid 함수를 통해 그리드 조회후 조회된 JSON을 이용하여 콜백함수 처리를 위해 추가
				    	if(typeof callback === "undefined"){
				    		;
				    	}else{
				    		console.log("콜백함수 오퍼레이션 시작");
				    		callback(data.content);
				    	}
				      }).error(function(error){
//				    	  console.log("실패");
				    	  $('.wrap-loading').addClass('display-none');
				    	  if(error && error.biz_validation_message == "SESSIONNO"){
				    		  //alert("장시간 미사용으로 로그아웃 됩니다.");
				    		  location.href = "/";
				    	  }else{
				    		  swalDanger("오류가 발생하였습니다.\n관리자에게 문의해주세요.");
				    		  return false;
				    	  } 
				      });
			};
			
			
			//20200807_khj 테스트 및 커스터마이징 위해 별도로 만듬
			vm.reloadGrid_custom = function(customParam){
				var paginationParam = customExtend(vm.paginationOptions,customParam);
				$scope.loader = true;
//				console.log("이전");
				$('.wrap-loading').removeClass('display-none');
		    	 StudentService.getStudents(
						paginationParam).success(function(data){
//							console.log("성공");
							
							$scope.loader = false;
							
							// 2020-07-28 jamerl - 영풍 RFC <-> 그리드 조회시 RFC 코드에 의한 RFC 메세지를 출력하는 경우를 위한 처리 추가
							if(typeof data.YP_RFC_CODE !== "undefined" && data.YP_RFC_CODE === "E"){
								swalWarning(data.YP_RFC_MSG);
							}
							
				    	  $scope.gridOptions.data = data.content;
				    	  $scope.gridOptions.totalItems = data.totalElements;
				    	  $scope.searchCnt = $scope.searchCnt + 1;	//20200724_khj 그리드 조회 성공시 조회성공건수 추가
				    	  
				    	  setTimeout(function(){
		 					$scope.gridApi.treeBase.expandAllRows();	//20200806_khj 그리드 트리노드 모두펼치기
				    	  }, 0)
				    	  
				    	  
				    	  //grid의 체크박스 아래 부분이 반쯤 가려지는 버그 수정
				    	  var viewport =  $($scope.gridApi.grid.element).find(".ui-grid-viewport");
				    	  if(viewport.length > 1){
				    		  var viewport0 = $(viewport[0]);
				    		  $interval( function() {
				    			  viewport0.height(viewport[1].clientHeight);
				    		      }, 500, 10);
				    	  }
				    	  
				    	  
				    	  //20200807_khj 투보수 화면에 일반푸터랑 트리푸터 혼용할때 IE에서 푸터가 짤려서 보이는 이슈존재, 강제로 리사이징해서 정상적으로 보이게 작업
				    	  /*
				    	  var agent = navigator.userAgent.toLowerCase();
				    	  if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
					    	  setTimeout(function(){
					    		  var width = "100%";
								  if(scope.searchCnt%2 == 0){
										width = "99.9%";
								  }else{
										width = "100%";
								  }
								  angular.element(document.getElementsByClassName('grid')[0]).css('width', width);
					    	  }, 500)
				    	  }
				    	  */

				      }).error(function(error){
//				    	  console.log("실패");
				    	  $('.wrap-loading').addClass('display-none');
				    	  if(error.biz_validation_message == "SESSIONNO"){
				    		  //alert("장시간 미사용으로 로그아웃 됩니다.");
				    		  location.href = "/";
				    	  }else{
				    		  swalDanger("오류가 발생하였습니다.\n관리자에게 문의해주세요.");
				    		  return false;
				    	  } 
				    	  
				      }).finally(function() {
				    	  $('.wrap-loading').addClass('display-none');
				      });
			};
			
			/*
			//2020-09-09 smh 컬럼까지 변해서 추가시킴
			vm.reloadGrid_include_column = function(customParam, defaultColumn){
				var paginationParam = customExtend(vm.paginationOptions,customParam);
				$scope.loader = true;
//				console.log("이전");
				$('.wrap-loading').removeClass('display-none');
		    	 StudentService.getStudents(
						paginationParam).success(function(data){
							$('.wrap-loading').addClass('display-none');
							$scope.loader = false;
							
							// 2020-07-28 jamerl - 영풍 RFC <-> 그리드 조회시 RFC 코드에 의한 RFC 메세지를 출력하는 경우를 위한 처리 추가
							if(typeof data.YP_RFC_CODE !== "undefined" && data.YP_RFC_CODE === "E"){
								swalWarning(data.YP_RFC_MSG);
							}
							
						      var columnDefs = [];
						
							  var totalItem = data.totalItem;
							  var content = data.content;
						      //데이터 있을 경우, 첫번째 데이터로 컬럼 세팅
							  if(content.length>0){
								var info = content[0];
								for(var key in info){
									if(info[key] != null && key == 'BASE_YYYY'){
										var column = 
										  {
											 displayName : '연도',
											 field : key,
											 width : '100',
											 visible : true,
											 cellClass : "center",
											 enableCellEdit : false,
											 allowCellFocus : false,
											 cellTemplate : '<div class="ui-grid-cell-contents pointer" ng-dblclick="grid.appScope.moveUpdatePage(row.entity)">{{grid.appScope.formatter_decimal(row.entity.BASE_YYYY)}}</div>'
										  }
										  columnDefs.push(column);
									}else if(info[key] != null && key == 'VENDOR_CODE'){
										var column = 
										  {
											 displayName : '거래처',
											 field : key,
											 width : '100',
											 visible : false,
											 cellClass : "center",
											 enableCellEdit : false,
											 allowCellFocus : false,
											 cellTemplate : '<div class="ui-grid-cell-contents pointer" ng-dblclick="grid.appScope.moveUpdatePage(row.entity)">{{grid.appScope.formatter_decimal(row.entity.VENDOR_CODE)}}</div>'
										  }
										  columnDefs.push(column);
									}else if(info[key] != null && key == 'VENDER_NAME'){
										var column = 
										  {
											 displayName : '거래처',
											 field : key,
											 width : '100',
											 visible : true,
											 cellClass : "center",
											 enableCellEdit : false,
											 allowCellFocus : false,
											 cellTemplate : '<div class="ui-grid-cell-contents pointer" ng-dblclick="grid.appScope.moveUpdatePage(row.entity)">{{row.entity.VENDER_NAME}}</div>'
										  }
										  columnDefs.push(column);
									}else if(info[key] != null && key == 'W1'){
										var column = 
										  {
											 displayName : '상갑반',
											 field : key,
											 //width : '100',
											 visible : true,
											 cellClass : "center",
											 enableCellEdit : false,
											 allowCellFocus : false,
											 cellTemplate : '<div class="ui-grid-cell-contents pointer" ng-dblclick="grid.appScope.moveUpdatePage(row.entity)">{{grid.appScope.formatter_decimal(row.entity.W1)}}</div>'
										  }
										  columnDefs.push(column);
									}else if(info[key] != null && key == 'W2'){
										var column = 
										  {
											 displayName : '갑반',
											 field : key,
											 //width : '100',
											 visible : true,
											 cellClass : "center",
											 enableCellEdit : false,
											 allowCellFocus : false,
											 cellTemplate : '<div class="ui-grid-cell-contents pointer" ng-dblclick="grid.appScope.moveUpdatePage(row.entity)">{{grid.appScope.formatter_decimal(row.entity.W2)}}</div>'
										  }
										  columnDefs.push(column);
									}else if(info[key] != null && key == 'W3'){
										var column = 
										  {
											 displayName : '을반',
											 field : key,
											 //width : '100',
											 visible : true,
											 cellClass : "center",
											 enableCellEdit : false,
											 allowCellFocus : false,
											 cellTemplate : '<div class="ui-grid-cell-contents pointer" ng-dblclick="grid.appScope.moveUpdatePage(row.entity)">{{grid.appScope.formatter_decimal(row.entity.W3)}}</div>'
										  }
										  columnDefs.push(column);
									}else if(info[key] != null && key == 'W4'){
										var column = 
										  {
											 displayName : '병반',
											 field : key,
											 //width : '100',
											 visible : true,
											 cellClass : "center",
											 enableCellEdit : false,
											 allowCellFocus : false,
											 cellTemplate : '<div class="ui-grid-cell-contents pointer" ng-dblclick="grid.appScope.moveUpdatePage(row.entity)">{{grid.appScope.formatter_decimal(row.entity.W4)}}</div>'
										  }
										  columnDefs.push(column);
									}else if(info[key] != null && key == 'W5'){
										var column = 
										  {
											 displayName : '지게차',
											 field : key,
											 //width : '100',
											 visible : true,
											 cellClass : "center",
											 enableCellEdit : false,
											 allowCellFocus : false,
											 cellTemplate : '<div class="ui-grid-cell-contents pointer" ng-dblclick="grid.appScope.moveUpdatePage(row.entity)">{{grid.appScope.formatter_decimal(row.entity.W5)}}</div>'
										  }
										  columnDefs.push(column);
									}else if(info[key] != null && key == 'W6'){
										var column = 
										  {
											 displayName : '휠로다',
											 field : key,
											 //width : '100',
											 visible : true,
											 cellClass : "center",
											 enableCellEdit : false,
											 allowCellFocus : false,
											 cellTemplate : '<div class="ui-grid-cell-contents pointer" ng-dblclick="grid.appScope.moveUpdatePage(row.entity)">{{grid.appScope.formatter_decimal(row.entity.W6)}}</div>'
										  }
										  columnDefs.push(column);
									}else if(info[key] != null && key == 'W7'){
										var column = 
										  {
											 displayName : '포크레인',
											 field : key,
											 //width : '100',
											 visible : true,
											 cellClass : "center",
											 enableCellEdit : false,
											 allowCellFocus : false,
											 cellTemplate : '<div class="ui-grid-cell-contents pointer" ng-dblclick="grid.appScope.moveUpdatePage(row.entity)">{{grid.appScope.formatter_decimal(row.entity.W7)}}</div>'
										  }
										  columnDefs.push(column);
									}
								}
								$scope.gridOptions.columnDefs = columnDefs;	
							  //데이터 없을 경우, 기본 컬럼 세팅
							  }else{
								$scope.gridOptions.columnDefs = defaultColumn;	
							  }
						
				
				    	  $scope.gridOptions.data = data.content;
				    	  $scope.gridOptions.totalItems = data.totalElements;
				    	  $scope.searchCnt = $scope.searchCnt + 1;	//20200724_khj 그리드 조회 성공시 조회성공건수 추가
 
				    	  //grid의 체크박스 아래 부분이 반쯤 가려지는 버그 수정
				    	  var viewport =  $($scope.gridApi.grid.element).find(".ui-grid-viewport");
				    	  if(viewport.length > 1){
				    		  var viewport0 = $(viewport[0]);
				    		  $interval( function() {
				    			  viewport0.height(viewport[1].clientHeight);
				    		      }, 500, 10);
				    	  } 
				      }).error(function(error){
//				    	  console.log("실패");
				    	  $('.wrap-loading').addClass('display-none');
				    	  if(error.biz_validation_message == "SESSIONNO"){
				    		  //alert("장시간 미사용으로 로그아웃 됩니다.");
				    		  location.href = "/";
				    	  }else{
				    		  swalDanger("오류가 발생하였습니다.\n관리자에게 문의해주세요.");
				    		  return false;
				    	  } 
				      });
			};
			*/
			
			vm.addRow = function(obj, check, order){ //check는 로우를 추가하면서 체크박스 선택을 할것인지 true=선택 / false=선택안함
				if(order == "desc"||isEmpty(order)){
					$scope.gridOptions.data.unshift(obj);    		//unshift : 가장첫라인에 로우 추가
					$scope.gridApi.core.notifyDataChange(uiGridConstants.dataChange.EDIT); // data의 값이 바뀌었을때 테이블에 보여지는 값도 바로 바뀌도록 ..
					if(check){	
						$timeout(function () {
						      $scope.gridApi.selection.selectRow($scope.gridOptions.data[0]);
						});
					}
				}else{
					$scope.gridOptions.data.push(obj);    		//push : 가장끝라인에 로우 추가
					$scope.gridApi.core.notifyDataChange(uiGridConstants.dataChange.EDIT); // data의 값이 바뀌었을때 테이블에 보여지는 값도 바로 바뀌도록 ..
					if(check){	
						$timeout(function () {
						      $scope.gridApi.selection.selectRow($scope.gridOptions.data[$scope.gridOptions.data.length-1]);
						});
					}
				}
				
			};
			
			vm.getHeaderArr = function(){
				var header = $scope.gridOptions.columnDefs;
				var headerArr = [];
				for(var i=0; i<header.length; i++){
					headerArr.push(header[i].displayName);
				}
				return headerArr;
			}
			
			vm.deleteRowOne = function(obj){
				var index  = $scope.gridOptions.data.indexOf(obj);
				$scope.gridApi.selection.unSelectRow(obj);
				$scope.gridOptions.data.splice(index, 1);
				$scope.gridApi.core.notifyDataChange(uiGridConstants.dataChange.ALL);
			}
			
			vm.deleteRow = function(obj){
				for(var i=0; i<obj.length; i++){
					var index  = $scope.gridOptions.data.indexOf(obj[i]);
					$scope.gridApi.selection.unSelectRow(obj[i]);
					$scope.gridOptions.data.splice(index, 1);
				}
				$scope.gridApi.core.notifyDataChange(uiGridConstants.dataChange.EDIT); // data의 값이 바뀌었을때 테이블에 보여지는 값도 바로 바뀌도록 ..
			};
			
			vm.deleteAll = function(obj){
				for(var i=0; i<obj.length; i++){
					var index  = $scope.gridOptions.data.indexOf(obj[i]);
					
					$scope.gridOptions.data.splice(index, 1);
				}
				$scope.gridApi.core.notifyDataChange(uiGridConstants.dataChange.EDIT); // data의 값이 바뀌었을때 테이블에 보여지는 값도 바로 바뀌도록 ..
			};
			
			
			vm.gridApi = $scope.gridApi;
			
			var loader = false;
			vm.loader = loader;
			
			//20200724_khj 그리드 조회 성공시 조회성공건수 추가
			var searchCnt = 0;
			vm.searchCnt = searchCnt;
			
			function dataChange(){
				
			}
			
			function paginationOptions(){
				var paginationOptions = {
			            pageNumber: 1,
			            pageSize: 5,
			        	sort: null,
			        	listQuery : null,
			        	cntQuery : null
			        };
				return paginationOptions;
			}
			
			vm.cellClassSet = function(func){
				func();
			}
			
			function gridOptions(obj){
				$scope.gridOptions = {
					showHeader : obj.showHeader,
					showGridFooter: obj.showGridFooter == null?true:obj.showGridFooter,
					showColumnFooter: obj.showColumnFooter,
					footerCellTemplate :obj.footerCellTemplate,
					enableColumnMenus : false,
					enableFiltering: obj.enableFiltering,
					enableGridMenu: obj.enableGridMenu,     //필터버튼(다운로드메뉴)
					exporterMenuCsv: false,	  //export csv
					exporterMenuPdf: false,   //export pdf
					exporterMenuExcel: false, //export excel
					paginationPageSizes: obj.paginationPageSizes,
					paginationPageSize: vm.paginationOptions.pageSize,
					enableRowHeaderSelection: obj.enableRowHeaderSelection,
					enableCellEditOnFocus : obj.enableCellEditOnFocus,
					enableSelectAll: obj.enableSelectAll,
					enableAutoFitColumns: true,
					enableRowSelection: obj.enableRowSelection,
					selectionRowHeaderWidth: obj.selectionRowHeaderWidth,
				    rowHeight: obj.rowHeight,
					useExternalPagination: obj.useExternalPagination,
					multiSelect: obj.multiSelect,
					columnDefs: obj.columnDefs,
					enablePagination : obj.enablePagination,
					enablePaginationControls: obj.enablePaginationControls,
			        onRegisterApi: function(gridApi) {
			            $scope.gridApi = gridApi;				//function 파라미터 gridApi를 $scope에 대입해줘야 밖에서 쓸 수 있음
			            //$scope.gridApi.core.handleWindowResize();
			            gridApi.pagination.on.paginationChanged(
			              $scope, 
			              function (newPage, pageSize) {
			            	vm.paginationOptions.pageNumber = newPage;
			            	vm.paginationOptions.pageSize = pageSize;
			                StudentService.getStudents(vm.paginationOptions)
			                  .success(function(data){
			                    $scope.gridOptions.data = data.content;
			                    $scope.gridOptions.totalItems = data.totalElements;
			                  });
			            });
			            gridApi.edit.on.beginCellEdit($scope, function(rowEntity, colDef, row) {
			        		var editDIV = $(row.currentTarget).parent().children()[1];
			        		$(editDIV).addClass("editDIV");		
			        		//console.log($(row.currentTarget).parent().children());    //css({"height":"500px", "color":"red"});
			        	});  
			         }
				};
				return $scope.gridOptions;
			}
	}]);
	
	app.service('HttpService',['$http', function ($http) {
		//var name = $("#frsc").attr("name");
	    function post(url,param) {
	    	
	    	//20191023_khj for csrf
	    	var csrfValue = document.getElementById("_csrf").value;
	    	param._csrf = csrfValue;
	    	
	    	return $http({
	          method: 'POST',
	            url: url,
	            data: $.param(param), 
	            headers: {
	                'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
	                'X-Requested-With' : 'XMLHttpRequest',
	                'ajaxHeader' : 'AJAX'
	            }
	        });
	    	
	    }
	    return {
	    	post: post
	    };
	}]);
	
	app.service('StudentService',['$http', function ($http) {
		//var name = $("#frsc").attr("name");
		function getStudents(paginationParam,gridOptions) {
			paginationParam.pageNumber = paginationParam.pageNumber > 0?paginationParam.pageNumber - 1:0;
			
			//20191023_khj for csrf
			var csrfValue = document.getElementById("_csrf").value;
			paginationParam._csrf = csrfValue;
			
			return $http({
				method: 'POST',
				url: '/uiGridLoad',
				data: $.param(paginationParam), 
				headers: {
					'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
					'X-Requested-With' : 'XMLHttpRequest',
					'ajaxHeader' : 'AJAX'
					//'Content-Type': 'application/json; charset=UTF-8'
				}
			});
		}
		return {
			getStudents: getStudents
		};
	}]);
	
