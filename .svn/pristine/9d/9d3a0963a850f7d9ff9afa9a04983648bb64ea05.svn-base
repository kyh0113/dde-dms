/**
 * Used to show a small bar on the chart if the value is 0
 * Chart.js 밸류값이 0인 경우에 스몰라인으로 그려주는 플러그인 시작
 * @type Object
 */
var showZeroPlugin = {
    beforeRender: function (chartInstance) {
        var datasets = chartInstance.config.data.datasets;

        for (var i = 0; i < datasets.length; i++) {
            var meta = datasets[i]._meta;
            // It counts up every time you change something on the chart so
            // this is a way to get the info on whichever index it's at
            var metaData = meta[Object.keys(meta)[0]];
            var bars = metaData.data;

            for (var j = 0; j < bars.length; j++) {
                var model = bars[j]._model;

                if (metaData.type === "horizontalBar" && model.base === model.x) {
                    model.x = model.base + 2;
                } else if (model.base === model.y) {
                    model.y = model.base - 2;
                }
            }
        }

    }
};

/**
 * Chart.js 데이터 없을 시 No Data Display 문구 출력
 * @type Object
 */
var showNodataPlugin = {
		afterDraw: function(chart) {
		  	if (chart.data.datasets.length === 0) {
		      // No data is present
		      var ctx = chart.chart.ctx;
		      var width = chart.chart.width;
		      var height = chart.chart.height
		      chart.clear();
		      
		      ctx.save();
		      ctx.textAlign = 'center';
		      ctx.textBaseline = 'middle';
		      ctx.font = "bold 11px 'Helvetica Nueue'";
		      //ctx.fillStyle = "rgba(223, 106, 101, 1)";
		      ctx.fillStyle = "#D8D8D8";
		      ctx.fillText('데이터가 없습니다.', width / 2, height / 2);
		      ctx.restore();
		    }else if(chart.data.datasets[0].data == ""){
		    	// No data is present
			      var ctx = chart.chart.ctx;
			      var width = chart.chart.width;
			      var height = chart.chart.height
			      chart.clear();
			      
			      ctx.save();
			      ctx.textAlign = 'center';
			      ctx.textBaseline = 'middle';
			      ctx.font = "bold 11px 'Helvetica Nueue'";
			      //ctx.fillStyle = "rgba(223, 106, 101, 1)";
			      ctx.fillStyle = "#D8D8D8";
			      ctx.fillText('데이터가 없습니다.', width / 2, height / 2);
			      ctx.restore();
		    }
		  }	
};

/** Chart.js Plugin 등록 시작*/
Chart.pluginService.register(showZeroPlugin);
Chart.pluginService.register(showNodataPlugin);
/** Chart.js Plugin 등록 끝*/


//차트에 범례 텍스트 표시 옵션
////Define a plugin to provide data labels
//Chart.plugins.register({
//	afterDatasetsDraw: function(chart) {
//		var ctx = chart.ctx;

//		chart.data.datasets.forEach(function(dataset, i) {
//			var meta = chart.getDatasetMeta(i);
//			if (!meta.hidden) {
//				meta.data.forEach(function(element, index) {
//					// Draw the text in black, with the specified font
//					ctx.fillStyle = 'rgb(0, 0, 0)';

//					var fontSize = 12;
//					var fontStyle = 'normal';
//					var fontFamily = 'Verdana';
//					ctx.font = Chart.helpers.fontString(fontSize, fontStyle, fontFamily);

//					// Just naively convert to string for now
//					var dataString = dataset.data[index].toString();

//					// Make sure alignment settings are correct
//					ctx.textAlign = 'center';
//					ctx.textBaseline = 'middle';

//					var padding = 0;
//					var position = element.tooltipPosition();
//					ctx.fillText(dataString+"%", position.x, position.y - (fontSize / 2) - padding);
//				});
//			}
//		});
//	}
//});


function opentab(evt, tabName) {
  var i, x, tablinks;
  x = document.getElementsByClassName("tabbody");
  for (i = 0; i < x.length; i++) {
      x[i].style.display = "none";
  }

  tablinks = document.getElementsByClassName("tablink");
  for (i = 0; i < x.length; i++) {
      tablinks[i].className = tablinks[i].className.replace(" tab-red", "");
  }
  document.getElementById(tabName).style.display = "block";
  evt.currentTarget.className += " tab-red";
}


function openCity(cityName) {
    var i;
    var x = document.getElementsByClassName("graphbody");
    for (i = 0; i < x.length; i++) {
        x[i].style.display = "none"; 
    }
    document.getElementById(cityName).style.display = "block"; 
}

function view_layer(name){ 
		  document.getElementById(name).style.display='block'; 
} 
		
function close_layer(name){ 
		  document.getElementById(name).style.display='none'; 
} 



function getDashBoardChart(term_code){
	$.ajax({
		type: 'POST',
		url: '/biz/dashBoard/dashBoardChart',
		data: {term_code : term_code},
		dataType: 'json',
		success: function(data){
			//섹션1
			document.getElementById("qntfact_cnt").innerText = data.section1_account.qntfact_cnt;
			document.getElementById("qltfact_cnt").innerText = data.section1_account.qltfact_cnt;
			
			document.getElementById("process_cnt").innerText = data.section1_process.process_cnt;
			
			document.getElementById("elc_cnt").innerText = data.section1_elc.elc_cnt;
			document.getElementById("plc_cnt").innerText = data.section1_plc.plc_cnt;
			
			document.getElementById("remark_y_cnt").innerText = data.section1_remark.remark_y_cnt;
			document.getElementById("remark_n_cnt").innerText = data.section1_remark.remark_n_cnt;
			
			document.getElementById("mrc_cnt").innerText = data.section1_mrc_ipe.mrc_cnt;
			document.getElementById("ipe_cnt").innerText = data.section1_mrc_ipe.ipe_cnt;
			

			//총 평가진행율 차트
			var chartArray = [];
			if(parseInt(data.total_test_progress.test_target) > 0){
				chartArray.push(parseInt(data.total_test_progress.test_target - data.total_test_progress.test_approved));
				chartArray.push(parseInt(data.total_test_progress.test_approved));
			}
			makechart_totalTestProgress(chartArray);
				
			//평가진행율 차트
			var arr0 = [];
			var arr1 = [];
			var arr2 = [];
			var arr3 = [];
			var chartArray2 = new Array();
			$.each( data.test_progress, function( i , value ) {
				if(value.test_target > 0){
					eval("arr"+i).push(value.test_notwrite);  //미착수
					eval("arr"+i).push(value.test_notsubmit); //진행중
					eval("arr"+i).push(value.test_approving); //결재중
					eval("arr"+i).push(value.test_approved)   //결재완료
					chartArray2.push(eval("arr"+i));
				}else{
					chartArray2.push(eval("arr"+i));
				}
				
				
			});
			makechart_TestProgress(chartArray2);
			
			
			//미비점 진행 차트
			var chartArray3 = [];
			if(parseInt(data.gap_progress.ing_gap_cnt) + parseInt(data.gap_progress.end_gap_cnt) > 0){
				chartArray3.push(parseInt(data.gap_progress.ing_gap_cnt));
				chartArray3.push(parseInt(data.gap_progress.end_gap_cnt));
			}
			makechart_gapProgress(chartArray3);
			
			
			//평가진행율 차트
			var arr4_0 = [];	//부서명 담기
			var arr4_1 = [];	//미작성
			var arr4_2 = [];	//작성중
			var arr4_3 = [];  	//결재진행중
			var arr4_4 = [];	//결재완료
			var chartArray4 = new Array();
			$.each( data.dept_progress, function( i2 , value2 ) {
				arr4_0.push(value2.dept_name);
				arr4_1.push(value2.test_notwrite);  //미착수
				arr4_2.push(value2.test_notsubmit); //진행중
				arr4_3.push(value2.test_approving); //결재중
				arr4_4.push(value2.test_approved)   //결재완료
			});
			chartArray4.push(arr4_0);
			chartArray4.push(arr4_1);
			chartArray4.push(arr4_2);
			chartArray4.push(arr4_3);
			chartArray4.push(arr4_4);
			makechart_DeptProgress(chartArray4);
		}
	});		
}




//Chart binding variable start//
var chart_tp, chart_tp2; 		//평가진행율_파이차트
var chart_elcdt, chart_elcdt2;	//전사설계_도넛차트
var chart_plcdt, chart_plcdt2; 	//프로세스설계_도넛차트
var chart_elcot, chart_elcot2; 	//전사운영_도넛차트
var chart_plcot, chart_plcot2;	//프로세스운영_도넛차트
var chart_ep, chart_ep2; 		//미비점_파이차트
var chart_monitor; 				//조직별 프로세스진행율_바차트
var chart_top5; 				//상위부서_바차트
var chart_bottom5; 				//하위부서_바차트
var chart_gap;					//미비점추이_바차트
var chart_elcdt3, chart_plcdt3, chart_elcot3, chart_plcot3;	//미비 상세진행_도넛차트
//Chart binding variable end//


function makechart_totalTestProgress(chartArray){
	
	//평가진행율 차트 시작
	var chart_tp_set = {
		    type: 'doughnut',
		    data: {
		        labels: ["미진행율","진행율"],
		        datasets: [{
		            label: 'Dataset 1',
		            data: chartArray,
		            backgroundColor: [
		            	'lightgrey',	//grey
		            	'#4085d8'		//blue
		            	
		            ],
		            borderColor: [
		               // 'rgba(54, 162, 235, 1)',
		              //  'rgba(54, 162, 235, 1)'
		            ],
		            borderWidth: 1,
		            datalabels: {
		            	display:false,
		        		//anchor: 'end'		//start, end, center
						//backgroundColor: null,
						//borderWidth: 0
		        	}
		        }]
		    },
			options : {
				responsive : true,					//컨테이너에 따라 캔버스 크기 조절
				maintainAspectRatio : true,		//크기 조정할때 원본 캔버스 종횡비 유지
				responsiveAnimationDuration : 1,	//크기 조정 이벤트 후 새크기로 애니메이션을 적용하는데 걸리는시간(밀리초)
		    	legend : {
		    		display : true,
		    		position : 'top',
		    		labels: { 
		    		     padding: 5,
		    		     usePointStyle: true
		    		}, 
		    	},
		    	animation: {
					animateScale: true,
					animateRotate: true,
					animation: true
				},
				plugins: {
//					datalabels: {
//						backgroundColor: function(context) {
//							return context.dataset.backgroundColor;
//						},
//						borderColor: 'white',
//						borderRadius: 25,
//						borderWidth: 2,
//						color: 'white',
//						display: function(context) {
//							var dataset = context.dataset;
//							var count = dataset.data.length;
//							var value = dataset.data[context.dataIndex];
//							return value > count * 1.5;
//						},
//						font: {
//							weight: 'bold'
//						},
//						formatter: Math.round
//					}
				}
			}
		};

	var ctx_tp = document.getElementById("chart_tp").getContext('2d');
	
	//chart.js 버그 방지(차트에 마우스오버시 old data show현상)
	if (window.chart_tp != undefined) {
		window.chart_tp.destroy();
	}
	
	//chart.js 버그 방지(차트에 마우스오버시 old data show현상)
	if (window.chart_tp2 != undefined) {
		window.chart_tp2.destroy();
	}
	
	chart_tp = new Chart(ctx_tp, chart_tp_set);

	//평가진행율 차트 끝
}

function makechart_TestProgress(chartArray2){
	var ctx_elcdt = document.getElementById("chart_elcdt").getContext('2d');
	var ctx_plcdt = document.getElementById("chart_plcdt").getContext('2d');
	var ctx_elcot = document.getElementById("chart_elcot").getContext('2d');
	var ctx_plcot = document.getElementById("chart_plcot").getContext('2d');
	
	
	//전사설계평가 차트 시작
	var chart_elcdt_set = {
		    type: 'doughnut',
		    data: {
		        labels: ["미착수","진행중","결재중","결재완료"],
		        datasets: [{
		            label: 'Dataset 1',
		            data: chartArray2[0],
		            backgroundColor: [
		            	'lightgrey',	//grey
		            	'#52AED3', // lightblue
		            	'#4085d8',		//blue
		            	'rgba(180, 219, 80, 1)'
		            ],
		            borderColor: [
		               // 'rgba(54, 162, 235, 1)',
		              //  'rgba(54, 162, 235, 1)'
		            ],
		            borderWidth: 1,
		            datalabels: {
		            	display:false,
		        		anchor: 'end'		//start, end, center
						//backgroundColor: null,
						//borderWidth: 0
		        	}
		        }]
		    },
			options : {
				title: {
					display: true,
					text: '설계평가'
				},
				responsive : true,					//컨테이너에 따라 캔버스 크기 조절
				maintainAspectRatio : true,			//크기 조정할때 원본 캔버스 종횡비 유지
				responsiveAnimationDuration : 1,	//크기 조정 이벤트 후 새크기로 애니메이션을 적용하는데 걸리는시간(밀리초)
		    	legend : {
		    		display : false,
		    		position : '',
		    		labels: { 
		    		     padding: 0,
		    		     usePointStyle: true
		    		}, 
		    	},
		    	animation: {
					animateScale: true,
					animateRotate: true
				},
				 tooltips: { 
				      enabled: true 
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
		};

	//chart.js 버그 방지(차트에 마우스오버시 old data show현상)
	if (window.chart_elcdt != undefined) {
		window.chart_elcdt.destroy();
	}
	
	//chart.js 버그 방지(차트에 마우스오버시 old data show현상)
	if (window.chart_elcdt2 != undefined) {
		window.chart_elcdt2.destroy();
	}
	
	chart_elcdt = new Chart(ctx_elcdt, chart_elcdt_set);
	//전사설계평가 차트 끝

	//프로세스설계평가 차트 시작
	var chart_plcdt_set = {
			  type: 'doughnut',
			  data: {
			      labels: ["미착수","진행중","결재중","결재완료"],
			      datasets: [{
			          label: 'Dataset 1',
			          data: chartArray2[2],
			          backgroundColor: [
			        	  'lightgrey',	//grey
		            	  '#52AED3', // lightblue
		            	  '#4085d8',		//blue
		            	  'rgba(180, 219, 80, 1)'
			          ],
			          borderColor: [
			             // 'rgba(54, 162, 235, 1)',
			            //  'rgba(54, 162, 235, 1)'
			          ],
			          borderWidth: 1,
			          datalabels: {
			          	display:false,
			      		anchor: 'end'		//start, end, center
							//backgroundColor: null,
							//borderWidth: 0
			      	  }
			      }]
			  },
				options : {
					title: {
						display: true,
						text: '설계평가'
					},
					responsive : true,					//컨테이너에 따라 캔버스 크기 조절
					maintainAspectRatio : true,			//크기 조정할때 원본 캔버스 종횡비 유지
					responsiveAnimationDuration : 1,	//크기 조정 이벤트 후 새크기로 애니메이션을 적용하는데 걸리는시간(밀리초)
				  	legend : {
				  		display : false,
				  		position : 'top',
				  		labels: { 
				  		     padding: 0,
				  		     usePointStyle: true
				  		}, 
				  	},
			  		animation: {
						animateScale: true,
						animateRotate: true
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
			};

	//chart.js 버그 방지(차트에 마우스오버시 old data show현상)
	if (window.chart_plcdt != undefined) {
		window.chart_plcdt.destroy();
	}
	
	//chart.js 버그 방지(차트에 마우스오버시 old data show현상)
	if (window.chart_plcdt2 != undefined) {
		window.chart_plcdt2.destroy();
	}

	chart_plcdt = new Chart(ctx_plcdt, chart_plcdt_set);
	//프로세스설계평가 차트 끝


	//전사운영평가 차트 시작
	var chart_elcot_set = {
			  type: 'doughnut',
			  data: {
			      labels: ["미착수","진행중","결재중","결재완료"],
			      datasets: [{
			          label: 'Dataset 1',
			          data: chartArray2[1],
			          backgroundColor: [
		        	      'lightgrey',	//grey
		            	  '#52AED3', // lightblue
		            	  '#4085d8',		//blue
		            	  'rgba(180, 219, 80, 1)'
			          ],
			          borderColor: [
			             // 'rgba(54, 162, 235, 1)',
			            //  'rgba(54, 162, 235, 1)'
			          ],
			          borderWidth: 1,
			          datalabels: {
			            	display:false,
			        		anchor: 'end'		//start, end, center
			  				//backgroundColor: null,
			  				//borderWidth: 0
			         }
			      }]
			  },
				options : {
					title: {
						display: true,
						text: '운영평가'
					},
					responsive : true,					//컨테이너에 따라 캔버스 크기 조절
					maintainAspectRatio : true,			//크기 조정할때 원본 캔버스 종횡비 유지
					responsiveAnimationDuration : 1,	//크기 조정 이벤트 후 새크기로 애니메이션을 적용하는데 걸리는시간(밀리초)
				  	legend : {
				  		display : false,
				  		position : 'top',
				  		labels: { 
				  		     padding: 0,
				  		   	 usePointStyle: true
				  		}, 
				  	},
				  	animation: {
							animateScale: true,
							animateRotate: true
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
			};
	
	//chart.js 버그 방지(차트에 마우스오버시 old data show현상)
	if (window.chart_elcot != undefined) {
		window.chart_elcot.destroy();
	}
	
	//chart.js 버그 방지(차트에 마우스오버시 old data show현상)
	if (window.chart_elcot2 != undefined) {
		window.chart_elcot2.destroy();
	}
	
	chart_elcot = new Chart(ctx_elcot, chart_elcot_set);
	//전사운영평가 차트 끝

	//프로세스운영평가 차트 시작
	var chart_plcot_set = {
			  type: 'doughnut',
			  data: {
			      labels: ["미착수","진행중","결재중","결재완료"],
			      datasets: [{
			          label: 'Dataset 1',
			          data: chartArray2[3],
			          backgroundColor: [
			        	  'lightgrey',	//grey
			              '#52AED3', // lightblue
			              '#4085d8',		//blue
			              'rgba(180, 219, 80, 1)'
			          ],
			          borderColor: [
			             // 'rgba(54, 162, 235, 1)',
			            //  'rgba(54, 162, 235, 1)'
			          ],
			          borderWidth: 1,
			          datalabels: {
			            	display:false,
			        		anchor: 'end'		//start, end, center
			  				//backgroundColor: null,
			  				//borderWidth: 0
			          }
			      }]
			  },
				options : {
					title: {
						display: true,
						text: '운영평가'
					},
					responsive : true,					//컨테이너에 따라 캔버스 크기 조절
					maintainAspectRatio : true,			//크기 조정할때 원본 캔버스 종횡비 유지
					responsiveAnimationDuration : 1,	//크기 조정 이벤트 후 새크기로 애니메이션을 적용하는데 걸리는시간(밀리초)
				  	legend : {
				  		display : false,
				  		position : 'right',
				  		labels: { 
				  		   padding: 0,
				  		   usePointStyle: true
				  		}, 
				  	},
			  		animation: {
						animateScale: true,
						animateRotate: true
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
			};
	
	//chart.js 버그 방지(차트에 마우스오버시 old data show현상)
	if (window.chart_plcot != undefined) {
		window.chart_plcot.destroy();
	}
	
	//chart.js 버그 방지(차트에 마우스오버시 old data show현상)
	if (window.chart_plcot2 != undefined) {
		window.chart_plcot2.destroy();
	}
	
	chart_plcot  = new Chart(ctx_plcot, chart_plcot_set);
	//프로세스운영평가 차트 끝
	}	
	


function makechart_gapProgress(chartArray3){

		//평가진행율 차트 시작
		var chart_ep_set = {
			    type: 'pie',
			    data: {
			        labels: ["개선중","개선완료"],
			        datasets: [{
			            label: 'Dataset 1',
			            data: chartArray3,
			            backgroundColor: [
			            	'lightgrey',	//grey
			            	'#4085d8'		//blue
			            ],
			            borderColor: [
			               // 'rgba(54, 162, 235, 1)',
			              //  'rgba(54, 162, 235, 1)'
			            ],
			            borderWidth: 0,
			            datalabels: {
			        		anchor: 'end'		//start, end, center
							//backgroundColor: null,
							//borderWidth: 0
			        	}
			        }]
			    },
				options : {
					responsive : true,					//컨테이너에 따라 캔버스 크기 조절
					maintainAspectRatio : true,			//크기 조정할때 원본 캔버스 종횡비 유지
					responsiveAnimationDuration : 1,	//크기 조정 이벤트 후 새크기로 애니메이션을 적용하는데 걸리는시간(밀리초)
			    	legend : {
			    		display : true,
			    		position : 'top',
			    		labels: { 
			    		     padding: 5,
			    		     usePointStyle: true
			    		}, 
			    	},
			    	animation: {
						animateScale: true,
						animateRotate: true,
						animation: true
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
			};
		
		var ctx_ep  = document.getElementById("chart_ep").getContext('2d');

		//chart.js 버그 방지(차트에 마우스오버시 old data show현상)
		if (window.chart_ep != undefined) {
			window.chart_ep.destroy();
		}
		
		//chart.js 버그 방지(차트에 마우스오버시 old data show현상)
		if (window.chart_ep2 != undefined) {
			window.chart_ep2.destroy();
		}
		
		chart_ep  = new Chart(ctx_ep, chart_ep_set);
		//평가진행율 차트 끝
}


function makechart_DeptProgress(chartArray4){

	var chart_monitor_Data = {
			labels: chartArray4[0],
			datasets: [
				{
					label: '미착수',
					//backgroundColor: window.chartColors.grey,
					//backgroundColor: color('rgba(206, 208, 212, 1)').alpha(0.9).rgbString(),
					backgroundColor: 'rgba(206, 208, 212, 1)',
					borderColor: 'rgba(206, 208, 212, 1)',
					borderWidth: 1,
					data: chartArray4[1],
					datalabels: {anchor: 'end'}
				}, 
				{
					label: '진행중',
					//backgroundColor: window.chartColors.yellow,
					backgroundColor: '#52AED3',
					borderColor: '#52AED3',
					borderWidth: 1,
					data: chartArray4[2],
					datalabels: {anchor: 'end'}
				}, 
				{
					label: '결재중',
					//backgroundColor: window.chartColors.blue,
					backgroundColor: '#4085d8',
					borderColor: '#4085d8',
					borderWidth: 1,
					data: chartArray4[3],
					datalabels: {anchor: 'end'}
				}, 
				{
					label: '결재완료',
					//backgroundColor: window.chartColors.green,
					backgroundColor: 'rgba(180, 219, 80, 1)',
					borderColor: 'rgba(180, 219, 80, 1)',
					borderWidth: 1,
					data: chartArray4[4],
					datalabels: {anchor: 'end'}
				}
			]

		};

	var ctx_monitor = document.getElementById("chart_monitor").getContext('2d');

	//chart.js 버그 방지(차트에 마우스오버시 old data show현상)
	if (window.chart_monitor != undefined) {
		window.chart_monitor.destroy();
	}
	
	//부서별 모니터링 차트 시작
	window.chart_monitor = new Chart(ctx_monitor, {
		type: 'bar',
		data: chart_monitor_Data,
		options: {
			title: {
				display: false,
				text: ''
			},
			tooltips: {
				mode: 'index',
				intersect: false
			},
			responsive: true,
			legend : {
		  		display : true,
		  		position : 'top',
		  		labels: { 
		  		     padding: 5,
		  		  	 usePointStyle: true
		  		} 
		  	},
			scales: {
				xAxes: [{
					stacked: true,
				 	barPercentage: 1,
		            barThickness: 10,
		            maxBarThickness: 30,
		            minBarLength: 1,
		            ticks:{
		            	autoSkip: false,
		            	fontSize:10
		            },
		            gridLines: {
		                offsetGridLines: true
		            }
				}],
				yAxes: [{
					stacked: true
				}]
			},
			animation: {
				animateScale: true,
				animateRotate: true
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
	//부서별모니터링 차트 끝
}


function makechart_Top5Progress(datasets_top, datasets_bottom){

	var top5_data = {labels: ['평가진행율 상위부서(%)']};
	top5_data.datasets = datasets_top;
	
	var chart_top_set = {
			type: 'bar',
			data: top5_data,
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
					animateScale: true,
					animateRotate: true
				},
				scales: {
					xAxes: [{
						 	barPercentage: 1,
				            barThickness: 70,
				            maxBarThickness: 50,
				            minBarLength: 2,
				            gridLines: {
				                offsetGridLines: true
				            }
			        }],
                    yAxes: [
                        {
                            ticks: {
                                min: 0,
                                //max : 500,
                                beginAtZero: true,
                                stepSize: 10
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
		};
	

	
	var bottom5_data = {labels: ['평가진행율 하위부서(%)']};	
	bottom5_data.datasets = datasets_bottom;
		
		var chart_bottom_set = {
				type: 'bar',
				data: bottom5_data,
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
						animateScale: true,
						animateRotate: true
					},
					scales: {
						xAxes: [{
						 	barPercentage: 1,
				            barThickness: 70,
				            maxBarThickness: 50,
				            minBarLength: 2,
				            gridLines: {
				                offsetGridLines: true
				            }
						}],
	                    yAxes: [
	                        {
	                            ticks: {
	                                min: 0,
	                                //max : 500,
	                                beginAtZero: true,
	                                stepSize: 10
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
			};


	
	var ctx_top     = document.getElementById("chart_top5").getContext('2d');

	//chart.js 버그 방지(차트에 마우스오버시 old data show현상)
	if (window.chart_top5 != undefined) {
		window.chart_top5.destroy();
	}	
	window.chart_top5 = new Chart(ctx_top, chart_top_set);	
	
	
	var ctx_bottom  = document.getElementById("chart_bottom5").getContext('2d');
	
	//chart.js 버그 방지(차트에 마우스오버시 old data show현상)
	if (window.chart_bottom5 != undefined) {
		window.chart_bottom5.destroy();
	}
	window.chart_bottom5 = new Chart(ctx_bottom, chart_bottom_set);
	
}


function makechart_Total_Gap_Chart(chartData){

	//미비점 추이 챠트
	var exception_data = {
		labels: ['미비점 추이'],
		datasets: [
			{
				label: chartData[0].term_code,
				backgroundColor: 'rgba(255, 222, 119, 1)',
				borderColor: 'rgba(255, 222, 119, 1)',
				borderWidth: 1,
				data: [chartData[0].gap_cnt],
				datalabels: {anchor: 'end'}
			},
			{
				label: chartData[1].term_code,
				backgroundColor: 'rgba(177, 214, 83, 1)',
				borderColor: 'rgba(177, 214, 83, 1)',
				borderWidth: 1,
				data: [chartData[1].gap_cnt],
				datalabels: {anchor: 'end'}
			},
			{
				label: chartData[2].term_code,
				backgroundColor: 'rgba(128, 209, 254, 1)',
				borderColor: 'rgba(128, 209, 254, 1)',
				borderWidth: 1,
				data: [chartData[2].gap_cnt],
				datalabels: {anchor: 'end'}
			},
		
		]

	};
	
	
	var exception_set = {
		type: 'bar',
		data: exception_data,
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
				animateScale: true,
				animateRotate: true
			},
			scales: {
                yAxes: [
                    {
                        ticks: {
                            min: 0,
                            //max : 500,
                            beginAtZero: true,
                            stepSize: 10
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
	};
	
	var ctx_exception = document.getElementById("chart_exception").getContext('2d');
	
	//chart.js 버그 방지(차트에 마우스오버시 old data show현상)
	if (window.chart_gap != undefined) {
		window.chart_gap.destroy();
	}
	chart_gap = new Chart(ctx_exception, exception_set);
}


function makechart_Gap_Progress_Detail(chartArray6){
		
			//전사설계평가 차트 시작
			var chart_elcdt_set2 = {
				    type: 'doughnut',
				    data: {
				        labels: ["개선중","개선완료"],
				        datasets: [{
				            label: 'Dataset 1',
				            data: chartArray6[0],
				            backgroundColor: [
				            	'rgba(223, 106, 101, 1)',
				            	'rgba(68, 184, 226, 1)'
				            ],
				            borderColor: [
				               // 'rgba(54, 162, 235, 1)',
				              //  'rgba(54, 162, 235, 1)'
				            ],
				            borderWidth: 1,
				            datalabels: {
				            	display:false,
				        		anchor: 'end'		//start, end, center
								//backgroundColor: null,
								//borderWidth: 0
				        	}
				        }]
				    },
					options : {
						title: {
							display: true,
							text: '설계평가'
						},
						responsive : true,					//컨테이너에 따라 캔버스 크기 조절
						maintainAspectRatio : true,			//크기 조정할때 원본 캔버스 종횡비 유지
						responsiveAnimationDuration : 1,	//크기 조정 이벤트 후 새크기로 애니메이션을 적용하는데 걸리는시간(밀리초)
				    	legend : {
				    		display : false,
				    		position : '',
				    		labels: { 
				    		     padding: 0,
				    		     usePointStyle: true
				    		}, 
				    	},
				    	animation: {
							animateScale: true,
							animateRotate: true
						},
						 tooltips: { 
						      enabled: true 
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
				};
			//전사설계평가 차트 끝

			//프로세스설계평가 차트 시작
			var chart_plcdt_set2 = {
					  type: 'doughnut',
					  data: {
						  labels: ["개선중","개선완료"],
					        datasets: [{
					            label: 'Dataset 1',
					            data: chartArray6[1],
					            backgroundColor: [
					            	'rgba(223, 106, 101, 1)',
					            	'rgba(68, 184, 226, 1)'
					            ],
					          borderColor: [
					             // 'rgba(54, 162, 235, 1)',
					            //  'rgba(54, 162, 235, 1)'
					          ],
					          borderWidth: 1,
					          datalabels: {
					          	display:false,
					      		anchor: 'end'		//start, end, center
									//backgroundColor: null,
									//borderWidth: 0
					      	  }
					      }]
					  },
						options : {
							title: {
								display: true,
								text: '설계평가'
							},
							responsive : true,					//컨테이너에 따라 캔버스 크기 조절
							maintainAspectRatio : true,			//크기 조정할때 원본 캔버스 종횡비 유지
							responsiveAnimationDuration : 1,	//크기 조정 이벤트 후 새크기로 애니메이션을 적용하는데 걸리는시간(밀리초)
						  	legend : {
						  		display : false,
						  		position : 'top',
						  		labels: { 
						  		     padding: 0,
						  		     usePointStyle: true
						  		}, 
						  	},
					  		animation: {
								animateScale: true,
								animateRotate: true
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
					};
			//프로세스설계평가 차트 끝


			//전사운영평가 차트 시작
			var chart_elcot_set2 = {
					  type: 'doughnut',
					  data: {
						  labels: ["개선중","개선완료"],
					        datasets: [{
					            label: 'Dataset 1',
					            data: chartArray6[2],
					            backgroundColor: [
					            	'rgba(223, 106, 101, 1)',
					            	'rgba(68, 184, 226, 1)',
					            ],
					          borderColor: [
					             // 'rgba(54, 162, 235, 1)',
					            //  'rgba(54, 162, 235, 1)'
					          ],
					          borderWidth: 1,
					          datalabels: {
					            	display:false,
					        		anchor: 'end'		//start, end, center
					  				//backgroundColor: null,
					  				//borderWidth: 0
					         }
					      }]
					  },
						options : {
							title: {
								display: true,
								text: '운영평가'
							},
							responsive : true,					//컨테이너에 따라 캔버스 크기 조절
							maintainAspectRatio : true,			//크기 조정할때 원본 캔버스 종횡비 유지
							responsiveAnimationDuration : 1,	//크기 조정 이벤트 후 새크기로 애니메이션을 적용하는데 걸리는시간(밀리초)
						  	legend : {
						  		display : false,
						  		position : 'top',
						  		labels: { 
						  		     padding: 0,
						  		   	 usePointStyle: true
						  		}, 
						  	},
						  	animation: {
									animateScale: true,
									animateRotate: true
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
					};
			//전사운영평가 차트 끝

			//프로세스운영평가 차트 시작
			var chart_plcot_set2 = {
					  type: 'doughnut',
					  data: {
						  labels: ["개선중","개선완료"],
					        datasets: [{
					            label: 'Dataset 1',
					            data: chartArray6[3],
					            backgroundColor: [
					            	'rgba(223, 106, 101, 1)',
					            	'rgba(68, 184, 226, 1)',
					            ],
					          borderColor: [
					             // 'rgba(54, 162, 235, 1)',
					            //  'rgba(54, 162, 235, 1)'
					          ],
					          borderWidth: 1,
					          datalabels: {
					            	display:false,
					        		anchor: 'end'		//start, end, center
					  				//backgroundColor: null,
					  				//borderWidth: 0
					          }
					      }]
					  },
						options : {
							title: {
								display: true,
								text: '운영평가'
							},
							responsive : true,					//컨테이너에 따라 캔버스 크기 조절
							maintainAspectRatio : true,			//크기 조정할때 원본 캔버스 종횡비 유지
							responsiveAnimationDuration : 1,	//크기 조정 이벤트 후 새크기로 애니메이션을 적용하는데 걸리는시간(밀리초)
						  	legend : {
						  		display : false,
						  		position : 'right',
						  		labels: { 
						  		   padding: 0,
						  		   usePointStyle: true
						  		}, 
						  	},
					  		animation: {
								animateScale: true,
								animateRotate: true
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
					};
			//프로세스운영평가 차트 끝

			var ctx_elcdt3 = document.getElementById("chart_elcdt3").getContext('2d');
			var ctx_plcdt3 = document.getElementById("chart_plcdt3").getContext('2d');
			var ctx_elcot3 = document.getElementById("chart_elcot3").getContext('2d');
			var ctx_plcot3 = document.getElementById("chart_plcot3").getContext('2d');
			
			//chart.js 버그 방지(차트에 마우스오버시 old data show현상)
			if (window.chart_elcdt3 != undefined) {
				window.chart_elcdt3.destroy();
			}
			
			if (window.chart_plcdt3 != undefined) {
				window.chart_plcdt3.destroy();
			}
			
			if (window.chart_elcot3 != undefined) {
				window.chart_elcot3.destroy();
			}
			
			if (window.chart_plcot3 != undefined) {
				window.chart_plcot3.destroy();
			}
			
			chart_elcdt3 = new Chart(ctx_elcdt3, chart_elcdt_set2);
			chart_plcdt3 = new Chart(ctx_plcdt3, chart_plcdt_set2);
			chart_elcot3 = new Chart(ctx_elcot3, chart_elcot_set2);
			chart_plcot3 = new Chart(ctx_plcot3, chart_plcot_set2);


}