<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
if (request.getProtocol().equals("HTTP/1.1")) {
	response.setHeader("Cache-Control", "no-cache");
}

Date today = new Date();
SimpleDateFormat date = new SimpleDateFormat("yyyy/MM");
String toDay = date.format(today);

//한달 
Calendar mon = Calendar.getInstance();
mon.add(Calendar.MONTH , -1);
String beforeMonthDay = date.format(mon.getTime());
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>검수보고서 생성(공수)</title>
<script type="text/javascript">
	var scope;
	$(document).ready(function() {
		// 부트스트랩 날짜객체
		$(".dtp").datepicker({
			format : "yyyy/mm",
			language : "ko",
			viewMode: "months", 
		    minViewMode: "months",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		});
		
		$(".dtp2").datepicker({
			format : "yyyy/mm/dd",
			language : "ko",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		});
		
		//조회조건 default
		//오늘날짜 세팅
		if($("input[name=BASE_YYYYMM]").val() == ""){
			$("input[name=BASE_YYYYMM]").val("<%=toDay%>");	
		}
		
		$('input').on('keydown', function(event) {
			if(event.keyCode==13) 
				return false;
		});
	});
</script>
</head>
<body>
	<h2>
		검수보고서 생성(공수)
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
	
	<form id="frm" name="frm">
		<div class="float_wrap">
			<div class="fl">
				<div class="stitle">
				</div>
			</div>
		</div>
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<section>
			<div class="tbl_box">
				<table class="contract_standard_table" cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="5%" />
						<col width="25%" />
						<col width="5%" />
						<col width="25%" />
						<col width="5%" />
						<col width="25%" />
					</colgroup>
					<tr>
						<th>거래처</th>
						<td>
							<input type="text" name="SAP_CODE" size="10" readonly="readonly" style="background-color: #e5e5e5;"/>
							<input type="hidden" name="VENDOR_CODE" id="VENDOR_CODE" size="10"/>
							<a href="#" onclick="fnSearchPopup('1');"><img src="/resources/yp/images/ic_search.png"></a>
							<input type="text" name="VENDOR_NAME" disabled="disabled"  style="width:200px;"/>
						</td>
						<th>계약코드</th>
						<td>
							<input type="text" name="CONTRACT_CODE" id="CONTRACT_CODE" size="10"/>
							<a href="#" onclick="fnSearchPopup('2');"><img src="/resources/yp/images/ic_search.png"></a>
							<input type="text" name="CONTRACT_NAME" disabled="disabled"  style="width:200px;"/>
						</td>
						<th>월보년월</th>
						<td>
							<input type="text" style="cursor: pointer;" class="calendar dtp" name="BASE_YYYYMM" id="sdate" size="10" value="${req_data.sdate}"/>
						</td>
					</tr>
				</table>
				<div class="btn_wrap">
					<input type="button" class="btn btn_search" id="search_btn" value="조회"/>
				</div>
			</div>
		</section>
		<div class="wrap" style="float:right;">
			<span>보고서코드</span>
			<input type="text" disabled="disabled"  name="REPORT_CODE"/>
		</div><div style="clear:both;"></div>
		
		
		<div class="float_wrap" style="margin-bottom: -25px;">
			<div class="fr">
				<div class="btn_wrap">
					<input type=button class="btn_g" id="save" value="저장">
				</div>
			</div>
		</div>
		<section class="section">
			<!-- 탭 부분 -->
			<!-- 
			<ul class="tabs">
				<li class="tab-link inspection_report current">검수보고서</li>
				<li class="tab-link work_status">작업현황</li>
				<li class="tab-link work_history">작업내역</li>
				<li class="save_class" style="border:none; float:right;"><input type=button class="btn_g" id="save" value="저장"></li>
			</ul>
			 -->
			 <ul class="nav nav-tabs" style="display: flex !important;">
				<li class="nav-item">
					<a class="nav-link inspection_report active" data-toggle="tab" href="#inspection_report_content">검수보고서</a>
				</li>
				<li class="nav-item">
					<a class="nav-link work_status" data-toggle="tab" href="#work_status_content">작업현황</a>
				</li>
				<li class="nav-item">
					<a class="nav-link work_history" data-toggle="tab" href="#work_history_content">작업내역</a>
				</li>
			</ul>
			<div class="tab-content tbl_box">
				<!-- 공통 테이블 ( 작업시작 ~ 작업종료 )  -->
				<table id="inspection_table_date" border="1" class="inspection_table" cellspacing="0" cellpadding="0" style="margin:auto; margin-top:10px; margin-bottom:10px; width:450px;">
					<colgroup>
						<col width="25%" />
						<col width="25%" />
						<col width="25%" />
						<col width="25%" />
					</colgroup>
					<!-- 
					<tr>
						<th class="tb-head">경동기계</th><td class="SUBCONTRACT_START_DATE_DISPLAY"></td>
						<th class="tb-head">~</th><td class="SUBCONTRACT_END_DATE_DISPLAY"></td>
					</tr>
					 -->
				</table>
					
				<!-- 검수보고서 -->
				<div class="tab-pane show active" id="inspection_report_content">
					<!--  
					<input type="hidden"  name="VENDOR_CODE_RESULT" />
					<input type="hidden"  name="VENDOR_NAME_RESULT" />
					<input type="hidden"  name="CONTRACT_CODE_RESULT" />
					<input type="hidden"  name="CONTRACT_NAME_RESULT" />
					<input type="hidden"  name="BASE_YYYYMM_RESULT" />
					-->
					<input type="hidden"  name="WBS_CODE1" />
					<input type="hidden"  name="WBS_CODE2" />
					<input type="hidden"  name="WBS_CODE3" />
					<input type="hidden"  name="WBS_CODE4" />
					<input type="hidden"  name="WBS_CODE5" />
					<input type="hidden"  name="WBS_CODE6" />
					<table border="1" class="inspection_table" id="inspection_table" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="25%" />
							<col width="10%" />
							<col width="10%" />
							<col width="10%" />
							<col width="15%" />
							<col width="15%" />
							<col width="15%" />
						</colgroup>
						<!-- 
						<tr>
							<th colspan="2" class="tb-head">WBS코드</th>
							<td colspan="3" class="WBS_CODE"></td>
							<th class="tb-head">검수기준일자</th>
							<td><input type="text" style="cursor: pointer;" class="calendar dtp2" name="CHECK_BASE_DATE"/></td>
						</tr>
						<tr>
							<th colspan="2" class="tb-head">계약명</th>
							<td colspan="3" class="CONTRACT_NAME"></td>
							<th class="tb-head">도급 시작 기간</th>
							<td><input type="text" style="cursor: pointer;" class="calendar dtp2" name="SUBCONTRACT_START_DATE" /></td>
						</tr>
						<tr>
							<th colspan="2" class="tb-head">도급(지급)금액</th>
							<td colspan="3" class="SUBCONTRACT_AMOUNT"></td>
							<th class="tb-head">도급 종료 기간</th>
							<td><input type="text" style="cursor: pointer;" class="calendar dtp2" name="SUBCONTRACT_END_DATE" /></td>
						</tr>
						<tr>
							<th rowspan="2" colspan="2" class="tb-head">거래처</th>
							<td rowspan="2" colspan="3" class="VENDOR_NAME"></td>
							<th class="tb-head">감독자</th>
							<td><input type="text" name="SUPERVISOR" /></td>
						</tr>
						<tr>
							<th class="tb-head">검수자</th>
							<td><input type="text" name="INSPECTOR" /></td>
						</tr>
						<tr>
							<th rowspan="2" colspan="2" class="tb-head">공정구분</th>
							<td colspan="2" class="tb-head">시공량</td>
							<td rowspan="2" class="tb-head">단가</td>
							<th rowspan="2" class="tb-head">금액</th>
							<td rowspan="2" class="tb-head">통화</td>
						</tr>
						<tr>
							<td class="tb-head">단위</td>
							<td class="tb-head">수량</td>
						</tr>
						 -->
					</table>
				</div>
				<!-- 작업현황 -->
				<div class="tab-pane" id="work_status_content" style="overflow:auto;">
					<table border="1" class="work_status_table" id="work_status_table" cellspacing="0" cellpadding="0">
					</table>
				</div>
				<!-- 작업내역 -->
				<div class="tab-pane" id="work_history_content">
					<section class="section">
<style type="text/css">
.table td, .table th {
	padding: 0.4rem !important;
}
</style>
						<div class="tbl_box" style="background: none;">
							<table border="1" class="table">
								<tr class="tb-head">
									<td style="color: white; width: 33px;">&nbsp;</td>
									<td style="color: white; width: 160px;">SAP<br>오더번호</td>
									<td style="color: white; width: 10%;">코스트<br>센터</td>
									<td style="color: white;">작업내역</td>
									<td style="color: white; width: 130px;">시작일자</td>
									<td style="color: white; width: 80px;">시작시간</td>
									<td style="color: white; width: 130px;">종료일자</td>
									<td style="color: white; width: 80px;">종료시간</td>
									<td style="color: white; width: 100px;">공수<br>(M/D)</td>
									<td style="color: white; width: 100px;">보정</td>
									<td style="color: white; width: 100px;">계</td>
									<td style="color: white; width: 200px;">비고</td>
								</tr>
								<tr><td class="center vertical-center" colspan="12">데이터가 없습니다.</td></tr>
							</table>
						</div>
					</section>
				</div>
			</div>
		</section>
		<input type="hidden" name="ie_bug" id="ie_bug" value=""/> 
	</form>
<script>
	$(document).ready(function(){
		// 부트스트랩 날짜객체 hide
		$(document).on("focus", ".dtp", function() {
			$(this).datepicker({
				format : "yyyy/mm",
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
		
		$(document).on("focus", ".dtp2", function() {
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
		
		// 조회
		$("#search_btn").on("click", function() {
			
			//거래처 빈값체크
			var SAP_CODE = $("input[name=SAP_CODE]").val();
			if(isEmpty(SAP_CODE)){
				swalWarningCB("거래처를 입력해주세요.");
				return false;
			}
			//계약코드 빈값체크
			var CONTRACT_CODE = $("input[name=CONTRACT_CODE]").val();
			if(isEmpty(CONTRACT_CODE)){
				swalWarningCB("계약코드를 입력해주세요.");
				return false;
			}
			
			//보고서코드 초기화
			$('input[name=REPORT_CODE]').val('');
			
			//검수보고서 데이터 가져오기
			//1:거래처,계약코드,월보년월로 데이터가져오기
			//2:보고서코드로 데이터가져오기
			inspection_report('1');
			
			//작업현황 데이턱 가져오기
			work_status('1');
			
			//작업내역 Grid 데이터 가져오기
			work_history();
			
		});
		
		/* 검수보고서 탭 클릭 */
		$(".section .inspection_report").on("click", function() {

			/* 탭 표시 */
			$('.section ul.tabs li').removeClass('current');
			$(this).addClass('current');
			
			/* 테이블 표시 */
			$('.section .tab-content-contract').removeClass('current');
			$('.section .inspection_report_content').addClass('current');
			
			//저장버튼 비활성화
			$("#save").hide();
			
		});
			
		/* 작업현황 탭 클릭 */
		$(".section .work_status").on("click", function() {
			$('.section ul.tabs li').removeClass('current');
			$(this).addClass('current');
			
			/* 테이블 표시 */
			$('.section .tab-content-contract').removeClass('current');
			$('.section .work_status_content').addClass('current');
			
			//저장버튼 비활성화
			$("#save").hide();
		});
		
		/* 작업내역 탭 클릭 */
		$(".section .work_history").on("click", function() {
			$('.section ul.tabs li').removeClass('current');
			$(this).addClass('current');
			
			/* 테이블 표시 */
			$('.section .tab-content-contract').removeClass('current');
			$('.section .work_history_content').addClass('current');
			
			//저장버튼 활성화
			$("#save").show();
			
			// 2021-03-29 jamerl - 그리드제거 : scope.gridApi.grid.refresh();	//그리드 새로고침
		});
		
		/* 저장 */
		$("#save").on("click", function() {
			// 2020-12-01 jamerl - 최승빈 : 결재 진행중 혹은 완료된 계약은 변경불가
			if(!select_chk_enable_proc(null, $("input[name=BASE_YYYYMM]").val().replace(/\//gi, ""), $("input[name=VENDOR_CODE]").val(), $("input[name=CONTRACT_CODE]").val(), $("input[name=REPORT_CODE]").val())){
				return false;
			}
			
			//검수기준일자
			var CHECK_BASE_DATE = $("input[name=CHECK_BASE_DATE]").val();
			//도급시작기간
			var SUBCONTRACT_START_DATE = $("input[name=SUBCONTRACT_START_DATE]").val();
			//도급종료기간
			var SUBCONTRACT_END_DATE = $("input[name=SUBCONTRACT_END_DATE]").val();
			//감독자
			var SUPERVISOR = $("input[name=SUPERVISOR]").val();
			//검수자
			var INSPECTOR = $("input[name=INSPECTOR]").val();
			
			//검수기준일자 빈값 체크
			if(isEmpty(CHECK_BASE_DATE)){
				swalWarningCB("검수보고서탭의 검수기준일자를 입력해주세요.");
				return;
			}
			
			//도급시작기간 빈값 체크
			if(isEmpty(SUBCONTRACT_START_DATE)){
				swalWarningCB("도급시작기간를 입력해주세요.");
				return;
			}
			
			//도급종료기간 빈값 체크
			if(isEmpty(SUBCONTRACT_END_DATE)){
				swalWarningCB("도급종료기간를 입력해주세요.");
				return;
			}
			
			//감독자 빈값 체크
			if(isEmpty(SUPERVISOR)){
				swalWarningCB("감독자를 입력해주세요.");
				return;
			}
			
			//검수자 빈값 체크
			if(isEmpty(INSPECTOR)){
				swalWarningCB("검수자를 입력해주세요.");
				return;
			}
			
			swal({
				  icon : "info",
				  text: "저장하시겠습니까?",
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
					    var token = $("meta[name='_csrf']").attr("content");
						var header = $("meta[name='_csrf_header']").attr("content");
						
						var data = {
							REPORT_CODE : $("input[name=REPORT_CODE]").val(),
							//VENDOR_CODE : $("input[name=VENDOR_CODE_RESULT]").val(),
							//VENDOR_NAME : $("input[name=VENDOR_NAME_RESULT]").val(),
							//CONTRACT_CODE : $("input[name=CONTRACT_CODE_RESULT]").val(),
							//CONTRACT_NAME : $("input[name=CONTRACT_NAME_RESULT]").val(),
							//BASE_YYYYMM : $("input[name=BASE_YYYYMM_RESULT]").val().replace("/",""),
							VENDOR_CODE : $("input[name=VENDOR_CODE]").val(),
							VENDOR_NAME : $("input[name=VENDOR_NAME]").val(),
							CONTRACT_CODE : $("input[name=CONTRACT_CODE]").val(),
							CONTRACT_NAME : $("input[name=CONTRACT_NAME]").val(),
							BASE_YYYYMM : $("input[name=BASE_YYYYMM]").val().replace("/",""),
							WBS_CODE1 : $("input[name=WBS_CODE1]").val(),
							WBS_CODE2 :	$("input[name=WBS_CODE2]").val(),
							WBS_CODE3 : $("input[name=WBS_CODE3]").val(),
							WBS_CODE4 :	$("input[name=WBS_CODE4]").val(),
							WBS_CODE5 :	$("input[name=WBS_CODE5]").val(),
							WBS_CODE6 :	$("input[name=WBS_CODE6]").val(),
							CHECK_BASE_DATE : CHECK_BASE_DATE.replace("/","").replace("/",""),
							SUBCONTRACT_AMOUNT : unComma($(".SUBCONTRACT_AMOUNT ").html()),
							SUBCONTRACT_START_DATE : SUBCONTRACT_START_DATE.replace("/","").replace("/",""),
							SUBCONTRACT_END_DATE : SUBCONTRACT_END_DATE.replace("/","").replace("/",""),
							SUPERVISOR : SUPERVISOR,
							INSPECTOR : INSPECTOR
						};

						$.ajax({
							url : "/yp/zcs/cpt/zcs_cpt_manh_create_save",
							type : "POST",
							cache : false,
							async : true,
							dataType : "json",
							data : data,
							success : function(result) {
								//swalSuccessCB(result.result+"건이 저장 완료됐습니다.");
								if(result.result > 0){
									swalSuccessCB("저장 완료됐습니다.");
									$("input[name=REPORT_CODE]").val(result.REPORT_CODE);
								}else{
									swalWarningCB("이미 생성된 보고서는 새로 생성할 수 없습니다.");
								}

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
								swalDangerCB("저장에 실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
						
				  }
				});
			
		});
		
		//검수보고서조회에서 검수보고서등록화면으로 넘어올 경우
		if(!isEmpty('${REPORT_CODE}')){
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			
			var report_code = '${REPORT_CODE}';
			var data = {'REPORT_CODE':report_code};
			
			//보고서코드에 값넣어주기
			$("input[name=REPORT_CODE]").val(report_code);
			
			$.ajax({
				url : "/yp/zcs/cpt/zcs_cpt_manh_create_select",
				type : "post",
				cache : false,
				async : false,//동기화
				data : data,
				dataType : "json",
				success : function(result) {
					var contstruction_report_list = result.contstruction_report_list;	
					var obj = contstruction_report_list[0];
					for(var key in obj){
						//계약코드 넣어주기
						if(key == "CONTRACT_CODE"){
							$("input[name=CONTRACT_CODE]").val(obj[key]);
						//계약명 넣어주기
						}else if(key == "CONTRACT_NAME"){
							$("input[name=CONTRACT_NAME]").val(obj[key]);
						//거래처 코드 넣어주기
						}else if(key == "VENDOR_CODE"){
							$("input[name=VENDOR_CODE]").val(obj[key]);
						//거래처 명 넣어주기
						}else if(key == "VENDOR_NAME"){
							$("input[name=VENDOR_NAME]").val(obj[key]);
						//월보년월 넣어주기
						}else if(key == "BASE_YYYYMM"){
							$("input[name=BASE_YYYYMM]").val(YYYYMM_format(obj[key]));
						//SAP_CODE 넣어주기
						}else if(key == "SAP_CODE"){
							$("input[name=SAP_CODE]").val(obj[key]);
						}
					}
					
					//검수보고서 데이터 가져오기
					//1:거래처,계약코드,월보년월로 데이터가져오기
					//2:보고서코드로 데이터가져오기
					inspection_report('2');
					
					//작업현황 데이터 가져오기
					//1:거래처,계약코드,월보년월로 데이터가져오기
					//2:보고서코드로 데이터가져오기
					work_status('2');
					
					//작업내역 Grid 데이터 가져오기
					work_history();
					
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
					swalDangerCB("조회에 실패하였습니다.\n관리자에게 문의해주세요.");
				}
			}); 
		}
		
		
		
		/* 공수 인건비 트리거 클릭 */
		$(".section .inspection_report").trigger("click");
	});

	// formater - 소수점 2째자리 표현
	function formatter_decimal(str_date) {
		return Math.round(str_date * 100) / 100;
	}
	
	/* 팝업 */
	function fnSearchPopup(type, target) {
		if (type == "1") {
			window.open("/yp/popup/zcs/ctr/select_working_master_v", "업체 검색", "width=600, height=800");
		}else if(type == "2"){
			window.open("","계약명 검색","width=600,height=800,scrollbars=yes");
			// 지급기준별 조회 조건 추가 - {1:공수, 2: 작업, 3: 월정액}
			fnHrefPopup("/yp/popup/zcs/ctr/retrieveContarctName", "계약명 검색", {
				PAY_STANDARD : "1"
			});
		}else if (type == "3") {
			window.open("", "코스트센터 검색", "width=600, height=800");
			fnHrefPopup("/yp/popup/zcs/ipt/retrieveKOSTL", "코스트센터 검색", {
				type : "C",
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
			// 				console.log(k, v);
			var el = document.createElement("input");
			el.name = k;
			el.value = v;
			el.type = "hidden";
			popForm.appendChild(el);
		});

		popForm.submit();
		popForm.remove();
	}
	
	/*콤마 추가*/
	function addComma(num) {
		return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}

	/*콤마 제거*/
	function unComma(num) {
		return num.replace(/,/gi, '');
	}
	
	//검수보고서 데이터 가져오기
	//1:거래처,계약코드,월보년월로 데이터가져오기
	//2:보고서코드로 데이터가져오기
	function inspection_report(flag){
		var data = $("#frm").serializeArray();
		for(var i=0; i<data.length; i++){
			if(data[i]["name"] == "BASE_YYYYMM"){
//					data[i]["value"] = data[i]["value"].replace(/ /gi, "");// 모든 공백을 제거
				data[i]["value"] = data[i]["value"].replace("/", "");
				break;
			}
		}
		
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		var url = "";
		//1:거래처,계약코드,월보년월로 데이터가져오기
		if(flag == '1'){
			url = "/yp/zcs/cpt/select_zcs_cpt_manh_create"
		//2:보고서코드로 데이터가져오기
		}else if(flag == "2"){
			url = "/yp/zcs/cpt/select_zcs_cpt_manh_create2"
			data.push({name: "REPORT_CODE", value: '${REPORT_CODE}'});
		}
		//검수보고서
		$.ajax({
			url : url,
			type : "POST",
			cache : false,
			async : false, //--동기화
			dataType : "json",
			data : data,
			success : function(result) {
				//상단
				var inspection_manh_list1 = result.inspection_manh_list1;
				//하단
				var inspection_manh_list2 = result.inspection_manh_list2;
				//construction_rpt_chk
				var construction_chk_rpt = result.construction_chk_rpt;
				
				//작업현황 테이블 초기화
		    	work_status_table_init();
				
		    	//1:거래처,계약코드,월보년월로 데이터가져오기
				if(flag == '1'){
					//거래처, 계약코드, 월보년월중 값이 1개라도 null이면 그리지 말기
					if(inspection_manh_list2.length == 0 || isEmpty(inspection_manh_list2[0].VENDOR_CODE) || isEmpty(inspection_manh_list2[0].CONTRACT_CODE) || isEmpty(inspection_manh_list2[0].BASE_YYYYMM)){
						//table tr 초기화
				    	$("#inspection_table tr").remove();
				    	$("#inspection_table_date tr").remove();
						return;
					}
				//2:보고서코드로 데이터가져오기
				}else if(flag == '2'){
					//거래처, 계약코드, 월보년월중 값이 1개라도 null이면 그리지 말기
					if(construction_chk_rpt.length == 0 || isEmpty(construction_chk_rpt[0].VENDOR_CODE) || isEmpty(construction_chk_rpt[0].CONTRACT_CODE) || isEmpty(construction_chk_rpt[0].BASE_YYYYMM)){
						//table tr 초기화
				    	$("#inspection_table tr").remove();
				    	$("#inspection_table_date tr").remove();
						return;
					}
				}
				
				
				//검수보고서 테이블 초기화
		    	tableInit();
		    	
				/*---------------- SUBCONTRACT_AMOUNT, SUBCONTRACT_START_DATE, SUBCONTRACT_END_DATE, SUPERVISOR, INSPECTOR 
														값 넣어주기 ---------------------*/
				if(!isEmpty(construction_chk_rpt)){
					$('input[name=CHECK_BASE_DATE]').val(YYYYMMDD_format(construction_chk_rpt[0].CHECK_BASE_DATE));
					$('input[name=SUBCONTRACT_START_DATE]').val(YYYYMMDD_format(construction_chk_rpt[0].SUBCONTRACT_START_DATE));
					$('input[name=SUBCONTRACT_END_DATE]').val(YYYYMMDD_format(construction_chk_rpt[0].SUBCONTRACT_END_DATE));
					$('input[name=SUPERVISOR]').val(construction_chk_rpt[0].SUPERVISOR);
					$('input[name=INSPECTOR]').val(construction_chk_rpt[0].INSPECTOR);
					$('.SUBCONTRACT_START_DATE_DISPLAY').html(YYYYMMDD_format(construction_chk_rpt[0].SUBCONTRACT_START_DATE));
					$('.SUBCONTRACT_END_DATE_DISPLAY').html(YYYYMMDD_format(construction_chk_rpt[0].SUBCONTRACT_END_DATE));
					
					//$("input[name=CONTRACT_CODE_RESULT]").val(construction_chk_rpt[0].CONTRACT_CODE);
					//$("input[name=CONTRACT_NAME_RESULT]").val(construction_chk_rpt[0].CONTRACT_NAME);
					//$("input[name=VENDOR_CODE_RESULT]").val(construction_chk_rpt[0].VENDOR_CODE);
					//$("input[name=VENDOR_NAME_RESULT]").val(construction_chk_rpt[0].VENDOR_NAME);
					$("input[name=WBS_CODE1]").val(construction_chk_rpt[0].WBS_CODE1);
					$("input[name=WBS_CODE2]").val(construction_chk_rpt[0].WBS_CODE2);
					$("input[name=WBS_CODE3]").val(construction_chk_rpt[0].WBS_CODE3);
					$("input[name=WBS_CODE4]").val(construction_chk_rpt[0].WBS_CODE4);
					$("input[name=WBS_CODE5]").val(construction_chk_rpt[0].WBS_CODE5);
					$("input[name=WBS_CODE6]").val(construction_chk_rpt[0].WBS_CODE6);
					//$("input[name=BASE_YYYYMM_RESULT]").val(YYYYMM_format(construction_chk_rpt[0].BASE_YYYYMM));
					//---------------- 상단 테이블 데이터 넣어주기 ---------------------------
					//상단 : 맨위부터 ~ 공정구분행 까지.
					var WBS_CODE = construction_chk_rpt[0].WBS_CODE;
					var CONTRACT_NAME = construction_chk_rpt[0].CONTRACT_NAME;
					var VENDOR_NAME = construction_chk_rpt[0].VENDOR_NAME;
					
					$(".WBS_CODE").html(WBS_CODE);
					$(".CONTRACT_NAME").html(CONTRACT_NAME);
					$(".VENDOR_NAME").html(VENDOR_NAME);
					//----------------------------------------------------------------
				}
				
				//---------------- ---------------- ---------------- ---------------- ---------------- ---------------- ---------------- ----------------
				
				/*---------------- VENDOR_CODE, VENDOR_NAME,CONTRACT_CODE, CONTRACT_NAME,
									WBS_CODE1~6, BASE_YYYYMM 값 넣어주기 ---------- */
				if(!isEmpty(inspection_manh_list1)){
					//$("input[name=CONTRACT_CODE_RESULT]").val(inspection_manh_list1[0].CONTRACT_CODE);
					//$("input[name=CONTRACT_NAME_RESULT]").val(inspection_manh_list1[0].CONTRACT_NAME);
					//$("input[name=VENDOR_CODE_RESULT]").val(inspection_manh_list1[0].VENDOR_CODE);
					//$("input[name=VENDOR_NAME_RESULT]").val(inspection_manh_list1[0].VENDOR_NAME);
					$("input[name=WBS_CODE1]").val(inspection_manh_list1[0].WBS_CODE1);
					$("input[name=WBS_CODE2]").val(inspection_manh_list1[0].WBS_CODE2);
					$("input[name=WBS_CODE3]").val(inspection_manh_list1[0].WBS_CODE3);
					$("input[name=WBS_CODE4]").val(inspection_manh_list1[0].WBS_CODE4);
					$("input[name=WBS_CODE5]").val(inspection_manh_list1[0].WBS_CODE5);
					$("input[name=WBS_CODE6]").val(inspection_manh_list1[0].WBS_CODE6);
					//$("input[name=BASE_YYYYMM_RESULT]").val(YYYYMM_format(inspection_manh_list2[0].BASE_YYYYMM));
					
					//---------------- 상단 테이블 데이터 넣어주기 ---------------------------
					//상단 : 맨위부터 ~ 공정구분행 까지.
					var WBS_CODE = inspection_manh_list1[0].WBS_CODE;
					var CONTRACT_NAME = inspection_manh_list1[0].CONTRACT_NAME;
					var VENDOR_NAME = inspection_manh_list1[0].VENDOR_NAME;
					
					$(".WBS_CODE").html(WBS_CODE);
					$(".CONTRACT_NAME").html(CONTRACT_NAME);
					$(".VENDOR_NAME").html(VENDOR_NAME);
					//----------------------------------------------------------------
				}
				//--------------------------------------------------------------
				
				//---------소계 합계 변수 -----------------------------
		    	var sub_total_amount = 0;			//소계 금액
				var sum_total_amount = 0;			//합계 금액
		    	//--------------------------------------------------
				
				//코스트 코드를 기준으로 묶기 위한 변수
				var BEFORE_COST_CODE = "";
				//코스트 코드 순서 번호를 표시하기 위한 변수
				var order = 0;
				//루프에서 가장 처음인지 확인하기 위한 변수
				var isFisrt = true;
				
				
				for(var i=0; i<inspection_manh_list2.length; i++){
					var obj = inspection_manh_list2[i];
					var innerHtml = "";
					
					//코스트 코드를 기준으로 묶기 위한 변수
					var CURRENT_COST_CODE = obj.COST_CODE;
					
					//대표 COST_NAME 넣어주기 && 소계 넣어주기
					if(BEFORE_COST_CODE != CURRENT_COST_CODE){
						//소계 넣어주기
						if(!isFisrt){
							innerHtml = '<tr class="sub_total ">';
			    			innerHtml += '	<td colspan="5" class="center vertical-center">소계</td>';
			    			innerHtml += '	<td class="right vertical-center">'+addComma(sub_total_amount)+'</td>';	//소계 금액
			    			innerHtml += '	<td class="center vertical-center">'+obj.CURRENCY+'</td>';
			    			innerHtml += '</tr>';
			    			$('#inspection_table').append(innerHtml);
							//---------소계 변수 초기화 ---------
			    			sub_total_amount = 0;	
			    			//---------------------------------
						}
						
						//대표 COST_NAME 넣어주기
						innerHtml = '<tr>';
						innerHtml += '	<td colspan="7" class="vertical-center left tb-head" >'+(++order)+'. '+obj.COST_NAME+'</td>';
		    			innerHtml += '</tr>';
		    			
						BEFORE_COST_CODE = obj.COST_CODE;
						$('#inspection_table').append(innerHtml);
					}
					
					innerHtml = '<tr>';
					innerHtml += '	<td class="left vertical-center tb-head" >'+obj.WORK_CONTENTS+'</td>';
					innerHtml += '	<td class="center vertical-center" >'+obj.RATE_AMOUNT+'</td>';
					innerHtml += '	<td class="center vertical-center" >'+obj.UNIT+'</td>';
					innerHtml += '	<td class="center vertical-center" >'+obj.MANHOUR+'</td>';
					innerHtml += '	<td class="right vertical-center" >'+addComma(obj.UNIT_PRICE)+'</td>';
					innerHtml += '	<td class="right vertical-center" >'+addComma(obj.AMOUNT)+'</td>';
					innerHtml += '	<td class="center vertical-center" >'+obj.CURRENCY+'</td>';
	    			innerHtml += '</tr>';
	    			$('#inspection_table').append(innerHtml);
	    			
	    			//소계 계산
	    			sub_total_amount += obj.AMOUNT;
	    			//합계 계산
	    			sum_total_amount += obj.AMOUNT;
	    			
	    			//제일 마지막에는 소계와 합계 넣어주기
		    		if(i == inspection_manh_list2.length-1){
		    			//소계 만들어주기
		    			innerHtml = '<tr class="sub_total ">';
		    			innerHtml += '	<td colspan="5" class="center vertical-center">소계</td>';
		    			innerHtml += '	<td class="right vertical-center">'+addComma(sub_total_amount)+'</td>';	//소계 금액
		    			innerHtml += '	<td class="center vertical-center">'+obj.CURRENCY+'</td>';
		    			innerHtml += '</tr>';
		    			$('#inspection_table').append(innerHtml);
		    			
		    			//합계 만들어주기
		    			innerHtml = "";
		    			innerHtml = '<tr class="sum_total">';
		    			innerHtml += '	<td colspan="5" class="center vertical-center">합계</td>';
// 		    			innerHtml += '	<td class="right vertical-center">'+addComma(sum_total_amount)+'</td>';	//합계 금액
						// 2021-03-29 jamerl - 최승빈 : 합계 금액 천단위 절사 => 10000으로 나누어 천단위를 소수점으로 변경후 버림 처리후 10000을 곱하여 천단위 절사 구현
		    			innerHtml += '	<td class="right vertical-center">' + addComma( Math.floor( sum_total_amount / 10000 ) * 10000 ) +'</td>';	//합계 금액
		    			innerHtml += '	<td class="center vertical-center">'+obj.CURRENCY+'</td>';
		    			innerHtml += '</tr>';
		    			$('#inspection_table').append(innerHtml);
		    			
		    			//도급(지급)금액에 값넣어주기
// 		    			$(".SUBCONTRACT_AMOUNT").html(addComma(sum_total_amount));
						// 2021-03-29 jamerl - 최승빈 : 합계 금액 천단위 절사 => 10000으로 나누어 천단위를 소수점으로 변경후 버림 처리후 10000을 곱하여 천단위 절사 구현
		    			$(".SUBCONTRACT_AMOUNT").html( addComma( Math.floor( sum_total_amount / 10000 ) * 10000 ) );
		    		}
	    			
	    			isFisrt = false;
				}
				// 월보 시작일, 종료일 설정 추가
				if(result.section_dt !== null && typeof result.section_dt !== "undefined"){
					console.log("section_dt", result.section_dt);
					$("input[name=SUBCONTRACT_START_DATE]").val(result.section_dt.SECTION_START_DT).trigger("changeDate");
					$("input[name=SUBCONTRACT_END_DATE]").val(result.section_dt.SECTION_END_DT).trigger("changeDate");
				}
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
				swalDangerCB("조회에 실패하였습니다.\n관리자에게 문의해주세요.");
			}
		});
	}
	
	//검수보고서 테이블 초기화
	function tableInit() {
		//table tr 초기화
    	$("#inspection_table tr").remove();
    	$("#inspection_table_date tr").remove();
    	
    	var innerHtml = 
	    	'<tr>'+
			'	<th class="tb-head">경동기계</th><td class="SUBCONTRACT_START_DATE_DISPLAY"></td>'+
			'	<th class="tb-head">~</th><td class="SUBCONTRACT_END_DATE_DISPLAY"></td>'+
			'</tr>';
    	$("#inspection_table_date").append(innerHtml);
	    
    	innerHtml = 
	    	'<tr>'+
				'<th colspan="2" class="tb-head">WBS코드</th>'+
				'<td colspan="3" class="WBS_CODE center vertical-center"></td>'+
				'<th class="tb-head">검수기준일자</th>'+
				'<td><input type="text" style="cursor: pointer;" class="calendar dtp2" name="CHECK_BASE_DATE" readonly/></td>'+
			'</tr>'+
			'<tr>'+
				'<th colspan="2" class="tb-head">계약명</th>'+
				'<td colspan="3" class="CONTRACT_NAME center vertical-center"></td>'+
				'<th class="tb-head">도급 시작 기간</th>'+
				'<td><input type="text" style="cursor: pointer;" class="calendar dtp2" name="SUBCONTRACT_START_DATE" readonly/></td>'+
			'</tr>'+
			'<tr>'+
				'<th colspan="2" class="tb-head">도급(지급)금액</th>'+
				'<td colspan="3" class="SUBCONTRACT_AMOUNT center vertical-center"></td>'+
				'<th class="tb-head">도급 종료 기간</th>'+
				'<td><input type="text" style="cursor: pointer;" class="calendar dtp2" name="SUBCONTRACT_END_DATE" readonly/></td>'+
			'</tr>'+
			'<tr>'+
				'<th rowspan="2" colspan="2" class="tb-head">거래처</th>'+
				'<td rowspan="2" colspan="3" class="VENDOR_NAME center vertical-center"></td>'+
				'<th class="tb-head">감독자</th>'+
				'<td><input type="text" name="SUPERVISOR" /></td>'+
			'</tr>'+
			'<tr>'+
				'<th class="tb-head">검수자</th>'+
				'<td><input type="text" name="INSPECTOR" /></td>'+
			'</tr>'+
			'<tr>'+
				'<th rowspan="2" colspan="2" class="tb-head">공정구분</th>'+
				'<td colspan="2" class="tb-head">시공량</td>'+
				'<td rowspan="2" class="tb-head">단가</td>'+
				'<th rowspan="2" class="tb-head">금액</th>'+
				'<td rowspan="2" class="tb-head">통화</td>'+
			'</tr>'+
			'<tr>'+
				'<td class="tb-head">단위</td>'+
				'<td class="tb-head">수량</td>'+
			'</tr>';
    	$("#inspection_table").append(innerHtml);
    	
    	//도급시작기간 변경 감지
		$('input[name=SUBCONTRACT_START_DATE]').datepicker({
			format : "yyyy/mm/dd",
			language : "ko",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		}).on('changeDate', function (ev) {
			$('.SUBCONTRACT_START_DATE_DISPLAY').html($(this).val());
		});
		
		//도급종료기간 변경 감지
		$('input[name=SUBCONTRACT_END_DATE]').datepicker({
			format : "yyyy/mm/dd",
			language : "ko",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		}).on('changeDate', function (ev) {
			$('.SUBCONTRACT_END_DATE_DISPLAY').html($(this).val());
		});
	}
	
	//작업현황 데이터 가져오기
	//1:거래처,계약코드,월보년월로 데이터가져오기
	//2:보고서코드로 데이터가져오기
	function work_status(flag){
		
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		var data = {
			BASE_YYYYMM : $("input[name=BASE_YYYYMM]").val().replace("/",""),
			//CONTRACT_CODE : $("input[name=CONTRACT_CODE_RESULT]").val(),
			//VENDOR_CODE : $("input[name=VENDOR_CODE_RESULT]").val()
			CONTRACT_CODE : $("input[name=CONTRACT_CODE]").val(),
			VENDOR_CODE : $("input[name=VENDOR_CODE]").val()
		};
		
		var url = "";
		//1:거래처,계약코드,월보년월로 데이터가져오기
		if(flag == '1'){
			url = "/yp/zcs/cpt/select_work_status_manh"
		//2:보고서코드로 데이터가져오기
		}else if(flag == "2"){
			url = "/yp/zcs/cpt/select_work_status2"
			data.REPORT_CODE = '${REPORT_CODE}';
		}
		
		$.ajax({
			url :url,
			type : "POST",
			cache : false,
			async : true,
			dataType : "json",
			data : data,
			success : function(result) {
				//작업현황 리스트
				var work_status_list = result.work_status_list;
				//날짜별 합계 map
				var sum_by_date_map = result.sum_by_date_map;
				
				//작업현황 테이블 초기화
		    	work_status_table_init();
				
				//값이 없을경우 그리지 말기
				if(work_status_list.length < 1){
					return;
				}
				
				//-------------------컬럼 그리기-----------------------
				var innerHtml = "";
				innerHtml = '<tr>';
				innerHtml += '	<td class="center vertical-center tb-head" style="width:100px;">코스트 센터</td>';
				innerHtml += '	<td class="center vertical-center tb-head" style="width:100px;">작업명</td>';
				for(var key in work_status_list[0]){
	    			//날짜 데이터 컬럼으로 만들어주기
					if(!isNaN(key)){
						innerHtml += '<td class="center vertical-center tb-head" >'+key.substr(6,2)+'</td>';
	    			}
				}
				innerHtml += '	<td class="center vertical-center tb-head">계</td>';
				innerHtml += '</tr>';
				$('#work_status_table').append(innerHtml);
				//--------------------------------------------------
				
				//총합계
				var total_sum = 0;
				//-------------------데이터 보여주기-----------------------
				for(var i=0; i<work_status_list.length; i++){
					//코스트센터별 합계
					var cost_sum = 0;
					
					innerHtml = '<tr>';
					//코스트센터, 작업명 먼저 세팅
					for(var key in work_status_list[i]){
						var obj = work_status_list[i];
						if(key=="COST_NAME"){
							innerHtml += '<td class="center vertical-center">'+obj[key]+'</td>'
						}else if(key=="WORK_CONTENTS"){
							innerHtml += '<td class="center vertical-center">'+obj[key]+'</td>'
						}
					}
					
					//그다음으로 날짜 데이터 세팅
					for(var key in work_status_list[i]){
						//날짜 데이터인지 체크
						if(!isNaN(key)){
							//null일경우 0으로 변환
							if(isEmpty(obj[key])){
								obj[key] = "";
							//비어있지 않을 경우에만 cost_sum, total_sum 합계 구하기
							}else{
								cost_sum  += formatter_decimal(obj[key]);
								total_sum += formatter_decimal(obj[key]);
							}
							innerHtml += '<td class="center vertical-center" >'+obj[key]+'</td>';
		    			}
					}
					innerHtml += '<td class="center vertical-center" >'+formatter_decimal(cost_sum)+'</td>';
					innerHtml += '</tr>';
					$('#work_status_table').append(innerHtml);
				}
				//----------------------------------------------------
				
				//-----------------날짜별 합계 & 총합계 보여주기--------------
				innerHtml = '<tr class="sum_total">';
				innerHtml += '	<td class="center vertical-center" colspan="2">계</td>';
				for(var key in sum_by_date_map){
	    			//날짜별 합계 만들어주기
					innerHtml += '	<td class="center vertical-center" >'+formatter_decimal(sum_by_date_map[key])+'</td>';
				}
				//총합계
				innerHtml += '	<td class="center vertical-center" >'+formatter_decimal(total_sum)+'</td>';
				innerHtml += '</tr>';
				$('#work_status_table').append(innerHtml);
				//----------------------------------------------------
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
				swalDangerCB("조회에 실패하였습니다.\n관리자에게 문의해주세요.");
			}
		});
	}
	
	
	//작업현황 테이블 초기화
	function work_status_table_init() {
		//작업현황 테이블 tr 초기화
    	$("#work_status_table tr").remove();
    	
	}
	
	//작업내역 Grid 데이턱 가져오기
	function work_history(){
		/*
		var param = {};
		//보고서 코드가 있을때
		if(isEmpty($('input[name=REPORT_CODE]').val())){
			param = {
					EXEC_RFC  : "N", // RFC 여부
					cntQuery  : "yp_zcs_cpt.select_construction_monthly_rpt1_cnt", 	
					listQuery : "yp_zcs_cpt.select_construction_monthly_rpt1"
			};
		//보고서 코드가 없을때
		}else{
			param = {
					EXEC_RFC  : "N", // RFC 여부
					cntQuery  : "yp_zcs_cpt.select_construction_chk_rpt_dt2_cnt", 	
					listQuery : "yp_zcs_cpt.select_construction_chk_rpt_dt2",
					REPORT_CODE : '${REPORT_CODE}'
			};
		}
		scope.paginationOptions = customExtend(scope.paginationOptions, param); //위에 선언한 파라미터 오브젝트를 기존 paginationOject에 합
		
		var data = {
				BASE_YYYYMM : $("input[name=BASE_YYYYMM]").val().replace("/",""),
				CONTRACT_CODE : $("input[name=CONTRACT_CODE]").val(),
				VENDOR_CODE : $("input[name=VENDOR_CODE]").val()
			};
		scope.reloadGrid(data);
		*/
		//거래처 빈값체크
		var VENDOR_CODE = $("#VENDOR_CODE").val().trim();
		if(isEmpty(VENDOR_CODE)){
			swalWarningCB("거래처를 입력해주세요.");
			return false;
		}
		//계약코드 빈값체크
		var CONTRACT_CODE = $("#CONTRACT_CODE").val().trim();
		if(isEmpty(CONTRACT_CODE)){
			swalWarningCB("계약코드를 입력해주세요.");
			return false;
		}
		// 월보년월
		var BASE_YYYYMM = $("#sdate").val().trim();
		if(isEmpty(CONTRACT_CODE)){
			swalWarningCB("월보년월를 입력해주세요.");
			return false;
		}
		var data = {
			BASE_YYYYMM : $("#sdate").val().trim(),
			VENDOR_CODE : $("#VENDOR_CODE").val().trim(),
			CONTRACT_CODE : $("#CONTRACT_CODE").val().trim(),
			REPORT_CODE : $('input[name=REPORT_CODE]').val().trim()
		};
		
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			url : "/yp/zcs/cpt/select_zcs_cpt_manh_create3",
			type : "POST",
			cache : false,
			async : true,
			dataType : "json",
			data : data, //폼을 그리드 파라메터로 전송
			success : function(data) {
				//작업내역 table tr 초기화
				$(".table tr:not(.tb-head)").remove();
				
				var innerHtml = '';
				var manhour = 0;
				var manhour_correction = 0;
				var manhour_sum = 0;
				
				var result1 = data.list1;
				var result2 = data.list2;
				
				if(result1.length === 0){
					innerHtml = '<tr><td class="center vertical-center" colspan="12">데이터가 없습니다.</td></tr>';
					$('.table').append(innerHtml);
					return false;
				}
				
				$.each(result1, function(i, d){
					innerHtml += '<tr class="data-base" data-rn="' + ( i + 1 ) + '">';
					innerHtml += '	<td class="center vertical-center"	style="width: 33px;"><div style="padding: 4px 3px;">' + d.RN + '</div></td>';
					innerHtml += '	<td class="center vertical-center"	style="width: 160px;"><div style="padding: 4px 3px;">' + d.ORDER_NUMBER + '</div></td>';
					innerHtml += '	<td class="center vertical-center"	style="width: 10%;"><div style="padding: 4px 3px;">' + d.COST_NAME + '</div></td>';
					innerHtml += '	<td class="left vertical-center"	><div style="padding: 4px 3px;">' + d.WORK_CONTENTS + '</div></td>';
					innerHtml += '	<td class="center vertical-center"	style="width: 130px;"><div style="padding: 4px 3px;">' + d.WORK_START_DT + '</div></td>';
					innerHtml += '	<td class="center vertical-center"	style="width: 80px;"><div style="padding: 4px 3px;">' + d.WORK_START_TIME + '</div></td>';
					innerHtml += '	<td class="center vertical-center"	style="width: 130px;"><div style="padding: 4px 3px;">' + d.WORK_END_DT + '</div></td>';
					innerHtml += '	<td class="center vertical-center"	style="width: 80px;"><div style="padding: 4px 3px;">' + d.WORK_END_TIME + '</div></td>';
					innerHtml += '	<td class="right vertical-center"	style="width: 100px;"><div style="padding: 4px 3px;">' + d.MANHOUR + '</div></td>';
					innerHtml += '	<td class="right vertical-center"	style="width: 100px;"><div style="padding: 4px 3px;">' + d.MANHOUR_CORRECTION + '</div></td>';
					innerHtml += '	<td class="right vertical-center"	style="width: 100px;"><div style="padding: 4px 3px;">' + d.MANHOUR_SUM + '</div></td>';
					innerHtml += '	<td class="right vertical-center"	style="width: 200px;"><div style="padding: 4px 3px;">' + ( isEmpty( d.MEMO ) ? '' : d.MEMO ) + '</div></td>';
					innerHtml += '</tr>';
					manhour += Number( d.MANHOUR );
					manhour_correction += Number( d.MANHOUR_CORRECTION );
					manhour_sum += Number( d.MANHOUR_SUM );
				});
				console.log("manhour", manhour);
				console.log("manhour_correction", manhour_correction);
				console.log("manhour_sum", manhour_sum);
				innerHtml += '<tr>';
				innerHtml += '	<td class="center vertical-center" colspan="8"><div style="padding: 4px 3px;">공수합계</div></td>';
				innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">' + manhour.toFixed(2) + '</div></td>';
				innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">' + manhour_correction.toFixed(2) + '</div></td>';
				innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">' + manhour_sum.toFixed(2) + '</div></td>';
				innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">&nbsp;</div></td>';
				innerHtml += '</tr>';
				
				// 출퇴근 조회결과에서 가져온 값을 출력한다.
				if(result2 === null){
					innerHtml += '<tr class="data-commute">';
					innerHtml += '	<td class="center vertical-center" colspan="8"><div style="padding: 4px 3px;">출퇴근합계</div></td>';
					innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">' + 0 + '</div></td>';
					innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">' + 0 + '</div></td>';
					innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">' + 0 + '</div></td>';
					innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">&nbsp;</div></td>';
					innerHtml += '</tr>';
					innerHtml += '<tr class="data-commute">';
					innerHtml += '	<td class="center vertical-center" colspan="10"><div style="padding: 4px 3px;">차이( 공수 - 출퇴근 )</div></td>';
//						innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">' + ( manhour_sum - manhour_cnt ) + '</div></td>';
					innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">' + manhour_sum.toFixed(2) + '</div></td>';
					innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">&nbsp;</div></td>';
					innerHtml += '</tr>';
				}else{
					innerHtml += '<tr class="data-commute">';
					innerHtml += '	<td class="center vertical-center" colspan="8"><div style="padding: 4px 3px;">출퇴근합계</div></td>';
					innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">' + result2.COMMUTE + '</div></td>';
					innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">' + result2.COMMUTE_CORRECTION + '</div></td>';
					innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">' + result2.COMMUTE_SUM + '</div></td>';
					innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">&nbsp;</div></td>';
					innerHtml += '</tr>';
					innerHtml += '<tr class="data-commute">';
					innerHtml += '	<td class="center vertical-center" colspan="10"><div style="padding: 4px 3px;">차이( 공수 - 출퇴근 )</div></td>';
					innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">' + result2.SUBTRACTION + '</div></td>';
					innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">&nbsp;</div></td>';
					innerHtml += '</tr>';
				}
				$('.table').append(innerHtml);
				reflectFooter();
			},
			beforeSend : function(xhr) {
				// 2019-10-23 khj - for csrf
				xhr.setRequestHeader(header, token);
				$('.wrap-loading').removeClass('display-none');
				$('.all-check').prop("checked", false);
			},
			complete : function() {
				$('.wrap-loading').addClass('display-none');
			},
			error : function(request, status, error) {
				console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
				swalDangerCB("조회 실패하였습니다.\n관리자에게 문의해주세요.");
			}
		});
	}
	
	function reflectFooter() {
		// 공수합계 계산
		var addition_col2 = 0;
		var addition_col3 = 0;
		$('.data.data-col-2').each(function(i, d){
			addition_col2 += Number( $(d).val() );
		});
		$('.sub1.data-col-2').val(addition_col2.toFixed(2));
		
		$('.data.data-col-3').each(function(i, d){
			addition_col3 += Number( $(d).val() );
		});
		$('.sub1.data-col-3').val(addition_col3.toFixed(2));
		
		// 차이 계산
		var subtraction_3 = 0;
		$('.sub3.data-col-3').val( ( Number( $('.sub1.data-col-3').val() ) - Number( $('.sub2.data-col-3').val() ) ).toFixed(2) );
	}
	
	//YYYY/MM/DD형식으로 만들어주기
	function YYYYMMDD_format(str) {
		if(!isEmpty(str)){
			var y = str.substr(0, 4);
		    var m = str.substr(4, 2);
		    var d = str.substr(6, 2);
		    return y+'/'+m+'/'+d
		}
	    return str;
	}

	//YYYY/MM형식으로 만들어주기
	function YYYYMM_format(str) {
		if(!isEmpty(str)){
		    var y = str.substr(0, 4);
		    var m = str.substr(4, 2);
		    return y+'/'+m
		}
		return str;
	}

	function select_chk_enable_proc(mode, p1, p2, p3, p4){
		var result = false;
		
		var data = {};
		if (mode === "UIG") {
			if(scope.gridOptions.data.length < 1){
				swalWarningCB("조회하여 데이터가 1개 이상 존재할 때만 추가할 수 있습니다.");
				return false;
			}
			data = scope.gridOptions.data[0];
		}else{
			data.BASE_YYYYMM = p1;
			data.VENDOR_CODE = p2;
			data.CONTRACT_CODE = p3;
			data.REPORT_CODE = p4;
		}
		
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		$.ajax({
			url : "/yp/zcs/ipt/select_chk_enable_proc",
			type : "POST",
			cache : false,
			async : false,
			dataType : "json",
			data : data,
			success : function(data) {
				if( data.result === 0 ) {
					result = true;
				}else{
					swalWarningCB("전자결재 상태에 의해 작업할 수 없습니다.");
				}
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
				swalDangerCB("작업을 실패하였습니다.\n관리자에게 문의해주세요.");
			}
		});
		return result;
	}
</script>

</body>