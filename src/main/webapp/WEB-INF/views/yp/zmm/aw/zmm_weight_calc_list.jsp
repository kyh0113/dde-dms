<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
	
	Date today = new Date();
	SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/dd");
	String toDay = date.format(today);
	String sDate = toDay.substring(0, 8) + "01";
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>차량 계량 정산</title>
<script type="text/javascript">
	var scope;
	$(document).ready(function() {
		// 부트스트랩 날짜객체
		$(".dtp").datepicker({
			format : "yyyy/mm/dd",
			language : "ko",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		}).on('changeDate', function() {
		 	$('.datepicker').hide();
		});
		
		
		// 조회
		$("#search_btn").on("click", function() {
			scope.reloadGrid({
				sdate : $("#sdate").val() + " 00:00:00",
				edate : $("#edate").val() + " 23:59:59",
				srch_p_name : $("input[name=srch_p_name]").val(),
				srch_p_detail_code : $("input[name=srch_p_detail_code]").val(),
				srch_ent_code : $("input[name=srch_ent_code]").val()
			});
		});
		
		
		// 저장
		$("#save_btn").on("click", function() {
			var rows = scope.gridApi.selection.getSelectedRows();
			if(rows.length === 0){
				swalWarningCB("저장할 항목을 선택하세요.");
				return false;
			}
			
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				url : "/yp/zmm/aw/zmm_weight_calc_save",
				type : "POST",
				cache : false,
				async : true,
				dataType : "json",
				data : {
					sdate : $("#sdate").val() + " 00:00:00",
					edate : $("#edate").val() + " 23:59:59",
					srch_p_code : $("select[name=srch_p_code]").val(),
					srch_p_detail_code : $("select[name=srch_p_detail_code]").val(),
					srch_ent_code : $("select[name=srch_ent_code]").val(),
					DATE : $("#edate").val().replaceAll("/",""),
					ROW_NO : JSON.stringify(rows)
				},
				success : function(data) {
					swalSuccessCB(data.result + "건 저장했습니다.", function() {
						$("#search_btn").trigger("click");
					});
				},
				beforeSend : function(xhr) {
					// 2019-10-23 khj - for csrf
					xhr.setRequestHeader(header, token);
					$('.wrap-loading').removeClass('display-none');
				},
				complete : function() {
					$('.wrap-loading').addClass('display-none');
				},
				error : function(request, status, error) {
					console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
					swalDangerCB("저장 실패하였습니다.\n관리자에게 문의해주세요.");
				}
			});
			
		});
		
		
		//전자결재 연동
		$("#edoc_btn").on("click", function() {
			/*
			  2022-06-21
			  YPWEBPOTAL-12 차량계량 정산 - 전자결재 재상신 불가 로직 추가
			  - CALC_CODE 가 null 이거나 undefined 일경우에 "저장된 항목만 결재상신 가능합니다." 메세지 처리후 상신안됨
			  - EDOC_STATUS 가 0 일경우에 "진행중인 결재항목이 있습니다." 메세지 처리후 상신안됨
			  - EDOC_STATUS 가 S 일경우에 "완료된 결재항목이 있습니다." 메세지 처리후 상신안됨
			*/
			var isPossibleSubmit = true;
			var rows = scope.gridApi.selection.getSelectedRows();
			//console.log(rows);
			if(rows.length === 0){
				swalWarningCB("결재 상신 항목을 선택하세요.");
				isPossibleSubmit = false;
				return false;
			}else{
				
				$.each(rows, function(i, d) {
					if(d.CALC_CODE == null || d.CALC_CODE == "undefined") {
						swalWarningCB("저장된 항목만 결재상신 가능합니다.");
						isPossibleSubmit = false;
						return false;
					} else if(d.EDOC_STATUS == "0") {
						swalWarningCB("진행중인 결재항목이 있습니다.");
						isPossibleSubmit = false;
						return false;
					} else if(d.EDOC_STATUS == "S") {
						swalWarningCB("완료된 결재항목이 있습니다.");
						isPossibleSubmit = false;
						return false;
					}
				});
				
			}
			
			if(isPossibleSubmit) {
				
				var codes = "";
				$.each(rows, function(i, d) {
					if(i == 0) codes = d.CALC_CODE;
					else codes += ";" + d.CALC_CODE;
				});
				var url = "http://ypgw.ypzinc.co.kr/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=EF164627042833159&CALC_CODE="+codes;	//운영
				//var url = "http://gwdev.ypzinc.co.kr/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=EF164213678935652&CALC_CODE="+codes;	//개발		
				window.open(url,"전자결재","scrollbars=auto,width=1000,height=900");
				
			}
			
		});
		
		
		$("#fi_doc_btn").on("click", function() {
			var validation = true;
			var ent_code = "";
			var selectedRows = scope.gridApi.selection.getSelectedRows();
			if (!isEmpty(selectedRows)) {
				$.each(selectedRows, function(i, d){
					if(i == 0){
						ent_code = d.ENT_CODE;
					}else{
						if(ent_code != d.ENT_CODE){
							swalWarningCB("동일한 거래처를 선택해주세요.");
							validation = false;
						}
					}
					if(d.EDOC_STATUS != "F"){
						swalWarningCB("전자결재 미완료 건이 있습니다.");
						validation = false;
					}
					if(d.CONT_AMOUNT == null && d.CONT_AMOUNT == undefined){
						swalWarningCB("단가정보가 없습니다.");
						validation = false;
					}
				});
			}else{
				swalWarningCB("항목을 선택해 주세요.");
				validation = false;
			}
			
			if(validation) {
				<%--
					YPWEBPOTAL-16 차량계량 정산 > 전자결재 상태값 변경 오류 및 전표번호 리턴 오류
					fi_doc_regpage_check 신규 validation 처리 로직 추가됨.
					자재코드가 없는 경우에 "관리자에게 문의하세요" 출력함.
				--%>
				//var token = $("meta[name='_csrf']").attr("content");
				//var header = $("meta[name='_csrf_header']").attr("content");
				
				//$.ajax({
					//url : "/yp/zmm/aw/fi_doc_regpage_check",
					//type : "POST",
					//cache : false,
					//async : true,
					//dataType : "json",
					//data : {
						//data : JSON.stringify(selectedRows),
						//hierarchy : "000001"
					//},
					//success : function(data) {
						// 성공 처리시 페이지 이동
						//f_href("/yp/zmm/aw/fi_doc_regpage", {
							//data : JSON.stringify(selectedRows),
							//hierarchy : "000001"
						//});
					//},
					//beforeSend : function(xhr) {
						// 2019-10-23 khj - for csrf
						//xhr.setRequestHeader(header, token);
						//$('.wrap-loading').removeClass('display-none');
					//},
					//complete : function() {
						//$('.wrap-loading').addClass('display-none');
					//},
					//error : function(request, status, error) {
						//console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
						//swalDangerCB("관리자에게 문의해주세요.");
					//}
				//});
				
				fnBillPopup();
			}
			
		});
		
		$("#so_btn").on("click", function() {
			fnSOPopup();
		});
	});
	
	
	/* 팝업 */
	function fnDetailPopup(row) {
		window.open("", "계량 정산 상세", "width=1200, height=800");
		fnHrefPopup("/yp/popup/zmm/aw/calc_detail_list", "계량 정산 상세", {
			sdate : $("#sdate").val() + " 00:00:00",
			edate : $("#edate").val() + " 23:59:59",
			P_DETAIL_CODE_SAP : row.P_DETAIL_CODE_SAP,
			ENT_CODE : row.ENT_CODE,
			CALC_CODE : row.CALC_CODE
		});
		
	}
	
	
	function fnBillPopup() {
		
		var row = scope.gridApi.selection.getSelectedRows();
		var target = scope.gridOptions.data.indexOf(row.entity);
		
		$.each(row, function(i, d) {
			CALC_W = d.CALC_W;
			CONT_AMOUNT = d.CONT_AMOUNT;

			if(d.P_GUBUN == "B") {
				if(i == 0) TOT_AMT = (d.CNT * 30 * d.CONT_AMOUNT)*1000;
				else TOT_AMT += (d.CNT * 30 * d.CONT_AMOUNT)*1000;
			}
			else {
				if(i == 0) TOT_AMT = (d.CALC_W * d.CONT_AMOUNT);
				else TOT_AMT += (d.CALC_W * d.CONT_AMOUNT);
			}
			
			//TOT_AMT = TOT_AMT+TOT_AMT;
			//TOT_AMT = TOT_AMT.slice(0,-3);
			if(i == 0) CALC_CODE = d.CALC_CODE;
			else CALC_CODE += ";" + d.CALC_CODE;
			//alert(d.P_GUBUN);
			//alert(TOT_AMT);
		});
		
		window.open("", "계산서조회", "width=600, height=800");
		fnHrefPopup("/yp/popup/zmm/aw/bill_create", "계산서조회", {
			
			ENT_CODE : row[0].ENT_CODE,
			ENT :  row[0].ENT,
			REG_NO : row[0].REG_NO,
			TOT_AMT : TOT_AMT,
			CALC_CODE : CALC_CODE,
			type : "srch",
			target : target
		});
	}
	
	
	function fnSOPopup() {
		
		var row = scope.gridApi.selection.getSelectedRows();
		
		//console.log(row);
		//console.log('CALC_W : ' + row[0].CALC_W);
		//console.log('EDOC_STATUS : ' + row[0].EDOC_STATUS);
		
		if(row.length > 1) {
			swalWarningCB("하나의 데이터만 선택해 주세요.");
			return false;
		}
		
		if(row[0].P_DETAIL_CODE_SAP != null && row[0].P_DETAIL_CODE_SAP != undefined) {
			<%--
				2022-06-20
				YPWEBPOTAL-11
				SAP코드와 CAS코드 두가지가 있고 CAS코드는 앞에 CAS가 붙어있습니다.
				앞에 구분자 ‘CAS’ 로 코드 구분해주시면 될 것 같습니다.
				CAS 일때는 오더 생성 안되게 validation 처리
				
				-> 텍스트 수정 : \n["+row[0].P_DETAIL_CODE_SAP+"] 자재코드를 확인하여주세요. 제외
			--%>
			if(row[0].P_DETAIL_CODE_SAP.indexOf("CAS") > -1) {
				swalInfo("판매오더 생성이 불가능한 품목입니다.\n");
				return false;
			}
			
		}
		
		if(row[0].EDOC_STATUS == null) {
			
			swalInfo("전자결재 생성 후 판매오더 생성이 가능합니다.\n");
			return false;
		}
		
		//alert(row[0].CALC_W);
		
		window.open("", "오더생성", "width=600, height=500");
		fnHrefPopup("/yp/popup/zmm/aw/so_create", "오더생성", {
			CALC_CODE : row[0].CALC_CODE,
			P_DETAIL_CODE_SAP : row[0].P_DETAIL_CODE_SAP,
			/*
			* 2022/06/17
			* YPWEBPOTAL-6 차량계량 판매오더 생성의 건(개발)
			* 선택된 품목에 해당하는 자재코드가 팝업의 자재코드에 입력되어야 함
			* 계량 소계 수량이 중량에 보여야 함
			* > 맵핑코드가 없어서 parameter 추가후 코드, 텍스트 맵핑
			*/
			P_DETAIL_NAME : row[0].P_DETAIL_NAME,
			CALC_W : row[0].CALC_W,
			CONT_AMOUNT : row[0].CONT_AMOUNT,
			ENT_CODE : row[0].ENT_CODE,
			ENT : row[0].ENT
		});
	}
	
	
	/* 연동 팝업 */
	function fnSearchPopup(type, row) {
		//console.log(row)
		var target = scope.gridOptions.data.indexOf(row.entity);
		
		window.open("", "검색 팝업", "width=600, height=800");
		if(type == "K") {
			fnHrefPopup("/yp/popup/zmm/aw/retrieveKUNNR", "검색 팝업", {
				type : "srch",
				target : target
			});
		}else if(type == "M") {
			fnHrefPopup("/yp/popup/zmm/aw/retrieveMATNR", "검색 팝업", {
				type : "srch",
				target : target
			});
		}
	}
	
	
	/* 팝업 submit */
	function fnHrefPopup(url, target, pr) {
		//20191023_khj for csrf
		var csrf_element = document.createElement("input");
		csrf_element.name = "_csrf";
		csrf_element.value = "${_csrf.token}";
		csrf_element.type = "hidden";
		//20191023_khj for csrf
		var popForm = document.createElement("form");
		
		popForm.name = "popForm";
		popForm.method = "post";
		popForm.target = target;
		popForm.action = url;
		
		document.body.appendChild(popForm);
		
		popForm.appendChild(csrf_element);
		
		$.each(pr, function(k, v) {
			//console.log(k, v);
			var el = document.createElement("input");
			el.name = k;
			el.value = v;
			el.type = "hidden";
			popForm.appendChild(el);
		});
		
		popForm.submit();
		popForm.remove();
	}
	
	
	function fnValidation() {
		
		return true;
	}
	
	
	// 거래처(SAP) 등록
	$("#csap_btn").on("click", function() {
		alert("개발중입니다.");
		return false;
	});
	
	// 품목(SAP) 등록
	$("#psap_btn").on("click", function() {
		alert("개발중입니다.");
		return false;
	});
	
</script>
</head>
<body>
	<!-- 20191023_khj for csrf -->
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<h2>
		차량 계량 정산
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
	<section>
		<div class="tbl_box">
			<table cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="10%" />
					<col width="30%"/>
					<col width="10%" />
					<col width="30%"/>
					<col width="20%" />
				</colgroup>
				<tr>	
					<th>일자</th>
					<td>
						<input class="calendar dtp" type="text" name="sdate" id="sdate" autocomplete="off" value="<c:choose><c:when test="${empty req_data.sdate}"><%=sDate%></c:when><c:otherwise>${req_data.sdate}</c:otherwise></c:choose>">
						~
						<input class="calendar dtp" type="text" name="edate" id="edate" autocomplete="off" value="<c:choose><c:when test="${empty req_data.edate}"><%=toDay%></c:when><c:otherwise>${req_data.edate}</c:otherwise></c:choose>">
					</td>
					<th>거래처</th>
					<td>
						<input type="text" name="srch_ent" style="width:100px;" value="${req_data.srch_ent}" onkeyup="enterkey()">
						<input type="hidden" name="srch_ent_code" style="width:100px;" value="${req_data.srch_ent_code}">
						<a href="#" onclick="javascript:fnSearchPopup('K','');"><img src="/resources/yp/images/ic_search.png"></a>
						<input type="text" name="srch_ent" style="width:170px;" value="${req_data.srch_ent}" readonly="readonly">
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<!--
					<th>품목</th>
					<td>
						<input type="text" name="srch_p_name" value="">
					</td>
					-->
					<th>품목</th>
					<td>
						<input type="text" name="srch_p_name" value="${req_data.srch_p_name}" onkeyup="enterkey()"><img src="/resources/yp/images/ic_search.png" style="cursor: pointer;" onclick="javascript:fnSearchPopup('M', '');">
						<input type="hidden" name="srch_p_detail_code" value="${req_data.srch_p_detail_code}">
						<input type="text" name="srch_p_detail_name" readonly="readonly" value="${req_data.p_detail_name}">
					</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<div class="btn_wrap">
				<!-- <button class="btn btn_make" id="excel_btn" type="">엑셀 다운로드</button> -->
				<button class="btn btn_search" id="search_btn" type="">조회</button>
			</div>
		</div>
	</section>
	<div class="float_wrap">
	<!-- <div class="fl"> -->
		<!-- <div class="stitle">전표목록</div> -->
	<!-- </div> -->
		<div class="fr">
			<div class="btn_wrap">
				<input type="button" value="저장" class="btn_g h_w_appr" id="save_btn">
				<input type="button" value="전자결재" class="btn_g h_w_appr" id="edoc_btn">
				<input type="button" value="전표생성" class="btn_g h_w_appr" id="fi_doc_btn">
				<input type="button" value="오더생성" class="btn_g h_w_appr" id="so_btn">
				<input type="button" value="거래처(SAP)등록" class="btn_g h_w_appr" id="csap_btn">
				<input type="button" value="품목(SAP)등록" class="btn_g h_w_appr" id="psap_btn">
			</div>
			<div class="btn_wrap">단위 : Kg</div>
		</div>
	</div>
	<section class="section">
		<!-- 복붙영역(html) 시작, 복붙시 바꿔야할 값들 : id, data-ng-controller -->
		<div id="shds-uiGrid" data-ng-controller="weightCtrl" style="height: auto;">
			<div data-ui-i18n="ko" style="height: 540px;">
				<div data-ui-grid="gridOptions" class="grid" data-ui-grid-edit data-ui-grid-cellNav ui-grid-pagination data-ui-grid-resize-columns data-ui-grid-auto-resize ui-grid-auto-resize data-ui-grid-selection data-ui-grid-exporter>
					<div data-ng-if="loader" class="loader"></div>
					<div class="watermark" data-ng-show="!gridOptions.data.length">데이터가 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- 복붙영역(html) 끝 -->
	</section>
	<script>
		/*복붙영역(앵귤러단) 시작, 복붙하고 바꿔야할 것들 : ctrCtrl -> "새로운이름"(html의 data-ng-controller프로퍼티 값과 일치), $scope.gridOptions의 true/false(원하는대로) & columnDefs를~ 가져오는 데이터에 맞게 수정  */
		app.controller('weightCtrl', [ '$scope', '$controller', '$log', 'StudentService', 'uiGridConstants', function($scope, $controller, $log, StudentService, uiGridConstants) { //$scope(this)는 해당컨트롤러로 진입하기위한 접근지시자라고 보면됨
			var vm = this; //this를 vm에 대입, 아래에서 부모의 $scope를 vm에 추가하기 위해
			angular.extend(vm, $controller('CodeCtrl', { //CodeCtrl(ui-grid 커스텀 api)를 상속받는다
				// 자식컨트롤러의 vm에 부모 컨트롤러의 $scope를 합, 이로써 자식 컨트롤러에서 부모의 모든 $scope(this)를 사용 할 수 있음
				$scope : $scope
			}));
			var paginationOptions = vm.paginationOptions; //부모의 paginationOptions를 자식의 paginationOptions에 대입,즉시실행 함수
			
			paginationOptions.pageNumber = 1; //초기 page number
			paginationOptions.pageSize = 100; //초기 한번에 보여질 로우수
			$scope.paginationOptions = paginationOptions;
			
			$scope.gridApi = vm.gridApi; //외부에서 grid의 클릭이벤트와 같은것들을 쓰기 위해서
			$scope.loader = vm.loader;
			$scope.addRow = vm.addRow;
			
			$scope.pagination = vm.pagination;
			
			// 세션아이드코드 스코프에저장
			$scope.s_emp_code = "${s_emp_code}";
			
			$scope.uiGridConstants = uiGridConstants;
			
			// formater - String yyyyMMdd -> String yyyy/MM/dd
			$scope.formatter_date = function(str_date) {
				if (str_date.length === 8) {
					return str_date.replace(/(\d{4})(\d{2})(\d{2})/g, '$1/$2/$3');
				} else {
					return str_date;
				}
			};
			
			// formater - 천단위 콤마
			$scope.formatter_decimal = function(str_date) {
				if (!isNaN(Number(str_date))) {
					return Number(str_date).toLocaleString()
				} else {
					return str_date;
				}
			};
			
			// 수정
			$("#mod_btn").on("click", function() {
				var rows = scope.gridApi.selection.getSelectedRows();
				if (isEmpty(rows)) {
					swalWarning("항목을 선택하세요.");
					return false;
				}
				$.each(rows, function(i, d) {
					if(d.IS_NEW === "Y") {
						return true;
					}
					d.IS_MOD = "Y";
				});
				scope.gridApi.grid.refresh();
			});
			
			$scope.openPop= function(row) {
				fnDetailPopup(row);
			}

			$scope.openPop_EDOC = function(row) {
				
				if(row == null || row == "undefined") {
					swalWarning("전자결재 문서가 없습니다.");
					return false;
				}
				window.open('http://ypgw.ypzinc.co.kr/ekp/eapp/app.do?cmd=appView&docReq.mode=popupView&docReq.appId='+row);
			};
			
			$scope.gridOptions = vm.gridOptions( // 그리드 옵션, 부모의 그리드 옵션에 파라미터를 던지면서 변경해서 대입
			{
				enableGridMenu: true,	 //필터버튼
				enableFiltering : false, //각 컬럼에 검색바
				
				paginationPageSizes : [ 10, 100, 200, 300, 400, 500, 1000 ], //한번에 보여질 로우수 셀렉트리스트
				paginationPageSize : 10,
				
				enableCellEditOnFocus : true, //셀 클릭시 edit모드
				enableSelectAll : true, //전체선택 체크박스
				enableRowSelection : false, //로우 선택
				enableRowHeaderSelection : true, //맨앞 컬럼 체크박스 컬럼으로
				selectionRowHeaderWidth : 35, //체크박스 컬럼 길이
				enableHorizontalScrollbar : "1",
				enableVerticalScrollbar : "1",
				rowHeight : 27, //체크박스 컬럼 높이
				// useExternalPagination : true, //pagination을 직접 세팅
				enableAutoFitColumns : false, //컬럼 width를 자동조정
				multiSelect : true, //여러로우선택
				enablePagination : true,
				enablePaginationControls : true,
				
				columnDefs : [ //컬럼 세팅
				{
					displayName : 'CALC_CODE',
					field : 'CALC_CODE',
					width : '1',
					visible : false,
					cellClass : "center",
					pinnedLeft : true,
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : 'NO',
					field : 'ROWNO',
					width : '80',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.renderContainers.body.visibleRowCache.indexOf(row)+1}}</div>'
				}, {
					displayName : '거래처코드',
					field : 'ENT_CODE',
					width : '1',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '거래처',
					field : 'ENT',
					width : '200',
					visible : true,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '품목코드',
					field : 'P_CODE',
					width : '100',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '품목',
					field : 'P_NAME',
					width : '150',
					visible : false,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '품목코드',
					field : 'P_DETAIL_CODE_SAP',
					width : '100',
					visible : true,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false
				}, {
					displayName : '품목',
					field : 'P_DETAIL_NAME',
					width : '200',
					visible : true,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false
				//}, {
					//displayName : '구분코드',
					//field : 'TYPE_CODE',
					//width : '80',
					//visible : false,
					//cellClass : "center",
					//enableCellEdit : false,
					//allowCellFocus : false
					//}, {
					//displayName : '구분',
					//field : 'TYPE',
					//width : '80',
					//visible : true,
					//cellClass : "center",
					//enableCellEdit : false,
					//allowCellFocus : false
				//}, {
					//displayName : '폐기물종류코드',
					//field : 'WASTE_TYPE_CODE',
					//width : '100',
					//visible : false,
					//cellClass : "center",
					//enableCellEdit : false,
					//allowCellFocus : false
					//}, {
					//displayName : '폐기물종류',
					//field : 'WASTE_TYPE',
					//width : '100',
					//visible : true,
					//cellClass : "center",
					//enableCellEdit : false,
					//allowCellFocus : false,
				}, {
					displayName : '계량 소계(KG)',
					field : 'SUM_W',
					width : '120',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-click="grid.appScope.openPop(row.entity)" style="cursor:pointer;text-decoration:underline;">{{grid.appScope.formatter_decimal(row.entity.SUM_W)}}</div>'
 				}, {
 					displayName : '계량 소계(MT)',
 					field : 'SUM_MT',
 					width : '120',
 					visible : false,
 					cellClass : "right",
 					enableCellEdit : false,
 					allowCellFocus : false,
 					cellTemplate : '<input type="text" ng-model="row.entity.SUM_MT" value="{{grid.appScope.formatter_decimal(row.entity.SUM_MT)}}"/>'
				}, {
 					displayName : '업체 계량(MT)',
 					field : 'COM_W',
 					width : '120',
 					visible : true,
 					cellClass : "right",
 					enableCellEdit : false,
 					allowCellFocus : false,
 					cellTemplate : '<input type="text" ng-model="row.entity.COM_W" value="{{grid.appScope.formatter_decimal(row.entity.COM_W)}}"/>'
				}, {
					displayName : '정산 계량',
					field : 'CALC_W',
					width : '100',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div ng-if="row.entity.COM_W != 0 && row.entity.SUM_MT == null" class="ui-grid-cell-contents">{{(row.entity.COM_W)}}</div>'
								+'<div ng-if="row.entity.COM_W == 0 || row.entity.COM_W == null" class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.SUM_W)}}</div>'
								+''
				}, {
					displayName : '단가',
					field : 'CONT_AMOUNT',
					width : '100',
					visible : true,
					cellClass : "right",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{grid.appScope.formatter_decimal(row.entity.CONT_AMOUNT)}}</div>'
				}, {
					displayName : '정산 기준일',
					field : 'CALC_DATE',
					width : '120',
					visible : true,
					cellClass : "center",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<input type="text" class="calendar dtp" ng-model="row.entity.CALC_DATE" style="width: 100%; height: 100% !important;" value="{{row.entity.CALC_DATE}}"/>'
				//}, {
					//displayName : '전자결재',
					//field : 'EDOC_STATUS',
					//width : '100',
					//visible : true,
					//cellClass : "center",
					//enableCellEdit : false,
					//allowCellFocus : false
					//,cellTemplate : '<div ng-if="row.entity.EDOC_STATUS == \'0\'" class="ui-grid-cell-contents">결재중</div>'
									//+'<div ng-if="row.entity.EDOC_STATUS == \'S\'" class="ui-grid-cell-contents">완료</div>'
									//+'<div ng-if="row.entity.EDOC_STATUS == \'F\'" class="ui-grid-cell-contents">완료</div>'
									//+'<div ng-if="row.entity.EDOC_STATUS == \'E\'" class="ui-grid-cell-contents">완료</div>'
									//+'<div ng-if="row.entity.EDOC_STATUS == \'5\'" class="ui-grid-cell-contents">반려</div>'
									//+'<div ng-if="row.entity.EDOC_STATUS == \'7\'" class="ui-grid-cell-contents">회수</div>'
									//+'<div ng-if="row.entity.EDOC_STATUS == \'D\'" class="ui-grid-cell-contents">삭제</div>'
				}, {
					displayName : '전자결재',
					field : 'EDOC_NO',
					width : '250',
					visible : true,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents" ng-click="grid.appScope.openPop_EDOC(row.entity.EDOC_ID)" style="cursor:pointer;text-decoration:underline;">{{row.entity.EDOC_NO}}</div>'
				}, {
					displayName : '전표번호',
					field : 'FI_DOC_NO',
					width : '150',
					visible : true,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{row.entity.FI_DOC_NO}}</div>'
				}, {
					displayName : '오더번호',
					field : 'SALES_ODER',
					width : '150',
					visible : true,
					cellClass : "left",
					enableCellEdit : false,
					allowCellFocus : false,
					cellTemplate : '<div class="ui-grid-cell-contents">{{row.entity.SALES_ODER}}</div>'
				//}, {
					//displayName : '비고',
					//field : 'BIGO',
					//width : '200',
					//visible : true,
					//cellClass : "center",
					//enableCellEdit : false,
					//allowCellFocus : false,
					//cellTemplate : '<input type="text" ng-model="row.entity.BIGO" style="height: 100%; width: 100%;">'
 				}, {
 					displayName : '사업자등록번호',
 					field : 'REG_NO',
 					width : '1',
 					visible : false,
 					cellClass : "center",
 					enableCellEdit : false,
 					allowCellFocus : false,
 					cellTemplate : '<div class="ui-grid-cell-contents">{{row.entity.REG_NO}}</div>'
				} ]
			});
			
			$scope.gridLoad = vm.gridLoad; //부모 컨트롤러의 gridLoad function을 대입, 즉시실행 아님
			$scope.reloadGrid = vm.reloadGrid;
			//$scope.변수이름 = 값 또는 function; 를 하면 외부에서 부르는 것이 가능
			
		} ]);
		
		$(document).ready(function() {
			// 복붙하면서 바꿔야 할 값들 : getElementById, param의 listQuery, cntQuery, scope이름 (ex : scope2)
			scope = angular.element(document.getElementById("shds-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
			scope.gridApi.selection.on.rowSelectionChanged(scope, function(row) { //로우 선택할때마다 이벤트
			// console.log("row2", row.entity);
			});
			scope.gridApi.selection.on.rowSelectionChangedBatch(scope, function(rows) { //전체선택시 가져옴
			
			});
			
			// grid date
			$(document).on("focus", ".dtp", function() {
				$(this).datepicker({
					format : "yyyy/mm/dd",
					language : "ko",
					todayHighlight : true,
					autoclose : true,
					clearBtn : true,
					updateViewDate : false
				}).on('changeDate', function (ev) {
					$(this).trigger("change");
				 	$('.datepicker').hide();
				});
			});
			
			// pagenation option setting 그리드를 부르기 전에 반드시 선언
			// 테이블 조회는 
			// EXEC_RFC : "FI"
			var param = {
				listQuery : "yp_zmm_aw.zmm_weight_calc_list", //list가져오는 마이바티스 쿼리 아이디
				cntQuery  : "yp_zmm_aw.zmm_weight_calc_list_cnt" //list cnt 가져오는 마이바티스 쿼리 아이디
			};
			scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
			// 복붙영역(앵귤러 이벤트들 가져오기) 끝
			// $("#search_btn").trigger("click");
		});
	</script>
</body>