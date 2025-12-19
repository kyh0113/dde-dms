<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
if (request.getProtocol().equals("HTTP/1.1")) {
	response.setHeader("Cache-Control", "no-cache");
}

Date today = new Date();
SimpleDateFormat date = new SimpleDateFormat("yyyy");
int to_yyyy = Integer.parseInt(date.format(today));
// JSTL에서 사용할 수 있도록 세팅
request.setAttribute("to_yyyy", to_yyyy);

Calendar cal = Calendar.getInstance();
cal.set(Calendar.YEAR, 2010);
int from_yyyy = Integer.parseInt(date.format(cal.getTime()));
//JSTL에서 사용할 수 있도록 세팅
request.setAttribute("from_yyyy", from_yyyy);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>업체별 경비 등록</title>
</head>
<body>
	<h2>
		업체별 경비 등록
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
	<!-- 	<div class="stitle">기본정보</div> -->
	<section>
		<div class="tbl_box">
			<table cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="5%" />
					<col width="25%" />
					<col width="5%" />
					<col width="25%" />
					<col width="5%" />
					<col width="25%" />
				</colgroup>
				<tr>
					<th>연도</th>
					<td>
<!-- 						<select id="BASE_YYYY"> -->
<%-- 							<c:forEach var="i" begin="0" end="${to_yyyy - from_yyyy}"> --%>
<%-- 								JSTL 역순 출력 - 연도 --%>
<%-- 								<c:set var="yearOption" value="${to_yyyy - i}" /> --%>
<%-- 								<option value="${yearOption}">${yearOption}</option> --%>
<%-- 							</c:forEach> --%>
<!-- 						</select> -->
						<input type="text" id="BASE_YYYY" class="calendar search_dtp_y" value="${to_yyyy}" readonly="readonly"/>
					</td>
					<th>거래처</th>
					<td>
						<select id="VENDOR_CODE">
							<c:forEach items="${cb_working_master_v}" var="data">
								<option value="${data.CODE}">${data.CODE_NAME}</option>
							</c:forEach>
						</select>
					</td>
					<th>&nbsp;</th>
					<td>&nbsp;</td>
				</tr>
			</table>
			<div class="btn_wrap">
				<button class="btn btn_search" id="search_btn" type="">조회</button>
<!-- 				<button class="btn btn_search" id="search_btn2" type="">수정테스트</button> -->
			</div>
		</div>
	</section>
	<div class="float_wrap" style="margin-bottom: 2px;">
		<div class="fl" style="margin-bottom: 10px;">&nbsp;</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type=button class="btn_g" id="fnModify" value="수정">
				<input type=button class="btn_g" id="fnSave" value="저장">
			</div>
		</div>
	</div>
	<section class="section">
		<form id="frm" name="frm" method="post">
			<!-- 20191023_khj for csrf -->
			<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="BASE_YYYY" />
			<input type="hidden" name="VENDOR_CODE" />
			<div class="tbl_box">
				<table border="1">
					<colgroup>
						<col width="3%" />
						<col />
					</colgroup>
					<tr>
						<th style="text-align: center; vertical-align: middle;">인원</th>
						<td>
							<input type="text" class="readonly-at-search validation not-null" name="C1" value="0" style="text-align: right;" readonly="readonly" />
							<input type="text" class="" value="명" size="1" disabled="disabled" />
						</td>
					</tr>
					<tr>
						<th style="text-align: center; vertical-align: middle;">사업소세</th>
						<td>
							<input type="text" class="readonly-at-search validation" name="C2" value="0" style="text-align: right;" readonly="readonly" />
							<input type="text" class="" value="%" size="1" disabled="disabled" />
						</td>
					</tr>
					<tr>
						<th style="text-align: center; vertical-align: middle;">안전대행료</th>
						<td>
							<input type="text" class="readonly-at-search validation" name="C3" value="0" style="text-align: right;" readonly="readonly" />
							<input type="text" class="" value="원" size="1" disabled="disabled" />
						</td>
					</tr>
					<tr>
						<th style="text-align: center; vertical-align: middle;">보험대행료</th>
						<td>
							<input type="text" class="readonly-at-search validation" name="C4" value="0" style="text-align: right;" readonly="readonly" />
							<input type="text" class="" value="원" size="1" disabled="disabled" />
						</td>
					</tr>
					<tr>
						<th style="text-align: center; vertical-align: middle;">교통비</th>
						<td>
							<input type="text" class="readonly-at-search validation" name="C5" value="0" style="text-align: right;" readonly="readonly" />
							<input type="text" class="" value="원" size="1" disabled="disabled" />
						</td>
					</tr>
					<tr>
						<th style="text-align: center; vertical-align: middle;">KOSAH18001</th>
						<td>
							<input type="text" class="readonly-at-search validation" name="C6" value="0" style="text-align: right;" readonly="readonly" />
							<input type="text" class="" value="원" size="1" disabled="disabled" />
						</td>
					</tr>
					<tr>
						<th style="text-align: center; vertical-align: middle;">관리감독자 교육비</th>
						<td>
							<input type="text" class="readonly-at-search validation" name="C7" value="0" style="text-align: right;" readonly="readonly" />
							<input type="text" class="" value="원" size="1" disabled="disabled" />
						</td>
					</tr>
					<tr>
						<th style="text-align: center; vertical-align: middle;">관리감독자 교육인원</th>
						<td>
							<input type="text" class="readonly-at-search validation" name="C8" value="0" style="text-align: right;" readonly="readonly" />
							<input type="text" class="" value="명" size="1" disabled="disabled" />
						</td>
					</tr>
					<tr>
						<th style="text-align: center; vertical-align: middle;">유해화학물질 취급자 교육비</th>
						<td>
							<input type="text" class="readonly-at-search validation" name="C12" value="0" style="text-align: right;" readonly="readonly" />
							<input type="text" class="" value="원" size="1" disabled="disabled" />
						</td>
					</tr>
					<tr>
						<th style="text-align: center; vertical-align: middle;">유해화학물질 취금자 교육인원</th>
						<td>
							<input type="text" class="readonly-at-search validation" name="C13" value="0" style="text-align: right;" readonly="readonly" />
							<input type="text" class="" value="명" size="1" disabled="disabled" />
						</td>
					</tr>
					<tr>
						<th style="text-align: center; vertical-align: middle;">세무기장료</th>
						<td>
							<input type="text" class="readonly-at-search validation" name="C9" value="0" style="text-align: right;" readonly="readonly" />
							<input type="text" class="" value="원" size="1" disabled="disabled" />
						</td>
					</tr>
					<tr>
						<th style="text-align: center; vertical-align: middle;">사무실운영비</th>
						<td>
							<input type="text" class="readonly-at-search validation" name="C10" value="0" style="text-align: right;" readonly="readonly" />
							<input type="text" class="" value="원" size="1" disabled="disabled" />
						</td>
					</tr>
					<tr>
						<th style="text-align: center; vertical-align: middle;">사업주이윤</th>
						<td>
							<input type="text" class="readonly-at-search validation" name="C11" value="0" style="text-align: right;" readonly="readonly" />
							<input type="text" class="" value="원" size="1" disabled="disabled" />
						</td>
					</tr>
				</table>
			</div>
		</form>
	</section>
	<script>
		var enable_calc = false; // 계산 여부 - true: 가능, false: 불가
		var enable_save = false; // 저장 가능 여부 - true: 가능, false: 불가
		$(document).ready(function() {
			// 부트스트랩 날짜객체
			$(".search_dtp_y").datepicker({
				format: " yyyy",
				viewMode: "years",
				minViewMode: "years",
				language : "ko",
				todayHighlight : true,
				autoclose : true,
				clearBtn : true,
				updateViewDate : false
			}).on('changeDate', function(e) {
				$(this).val(formatDate_y(e.date.valueOf())).trigger("change");
				$("#search_btn").trigger("click");
				$('.datepicker').hide();
			});
			
			// 거래처 변경시 조회
			$("#VENDOR_CODE").on("change", function(){
				$("#search_btn").trigger("click");
			});
			
			// 조회
			$("#search_btn2").on("click", function() {
				f_href("/yp/zwc/upc/zwc_upc_create", {
					BASE_YYYY : "2019", // 선택한 데이터의 연도
					WORKTYPE_CODE : "W2", // 선택한 데이터의 근무형태코드
					hierarchy :  "000005" // 하드코딩
				});
			});
			// 조회
			$("#search_btn").on("click", function() {
				enable_save = false;
				$(".readonly").val("0");
				$(".readonly-at-search").prop("readonly", true).val("0");
				
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					url : "/yp/zwc/upc/select_zwc_upc_create",
					type : "post",
					cache : false,
					async : true,
					data : {
						BASE_YYYY : $("#BASE_YYYY").val(),
						VENDOR_CODE : $("#VENDOR_CODE").val()
					},
					dataType : "json",
					success : function(result) {
						/* 2020-09-24 jamerl - 조용래대리 : 유해화학물질, ○○○○인원 항상 보여주고, 입력시에 알맞게 입력하기로 함 */
						// 연도가 홀수면 유해화학물질, ○○○○인원 숨김
// 						if($("#BASE_YYYY").val() % 2 !== 0){
// 							$("[name=C12]").parent().parent().hide();
// 							$("[name=C13]").parent().parent().hide();
// 						}else{
// 							$("[name=C12]").parent().parent().show();
// 							$("[name=C13]").parent().parent().show();
// 						}
						$("[name=VENDOR_CODE]").val($("#VENDOR_CODE").val());
						$("[name=BASE_YYYY]").val($("#BASE_YYYY").val());
						
						if(result.list1.length > 0){
							enable_calc = false;
							$(".readonly-at-search").prop("readonly", true);
							
							var row = result.list1[0];
							$.each(row, function(k, v){
								if(k === "BASE_YYYY"){
									$("[name=BASE_YYYY]").val(v);
								}else if(k === "VENDOR_CODE"){
									$("[name=VENDOR_CODE]").val(v);
								}else{
									$("#frm").find("[name=" + k + "]").val(addComma(v));
								}
							});
						}else{
							$("#fnModify").trigger("click");
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
						swalDangerCB("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
					}
				});
			});

			// 수정
			$("#fnModify").on("click", function() {
				enable_save = true;
				$(".readonly-at-search").prop("readonly", false);
			});

			// 선택 저장
			$("#fnSave").on("click", function() {
				if(enable_save){
					if (!fnValidation()) {
						return false;
					}
					// 2020-09-09 jamerl - TBL_WORKING_UNIT_PRICE 조회 연도에 데이터 건수가 > 0 일 경우에만 저장할 수 있도록 처리 필요 
					if (confirm("등록하겠습니까?")) {
						$(".readonly-at-search").each(function(i, d){
							$(d).val(unComma($(d).val()));
						});
						var token = $("meta[name='_csrf']").attr("content");
						var header = $("meta[name='_csrf_header']").attr("content");
						var data = $("#frm").serializeArray();
						$.ajax({
							url : "/yp/zwc/upc/save_zwc_upc_create",
							type : "POST",
							cache : false,
							async : true,
							dataType : "json",
							data : data,
							success : function(result) {
								if (result.code.insert1 > 0) {
									$("#search_btn").trigger("click");
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
								swalDangerCB("등록에 실패하였습니다.\n관리자에게 문의해주세요.");
							}
						});
					}
				}else{
					swalWarningCB("저장할 수 있는 상태가 아닙니다.\n수정 버튼을 클릭하세요.");
					return false;
				}
			});
			
			$(".readonly-at-search").on("keyup", function(){
				$(this).val(unComma($(this).val()));
			}).on("blur", function(){
				$(this).val(addComma($(this).val()));
			});
			
			$("#search_btn").trigger("click");
		});
		
		/*콤마 추가*/
		function addComma(num) {
			var rnum = "0";
			if(num !== null){
				rnum = num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			}
			return rnum;
		}

		/*콤마 제거*/
		function unComma(num) {
			return num.replace(/[^0-9.]/gi, '');
		}
		
		function fnValidation(){
			var check = true;
			$(".validation").each(function(i, d){
				// 빈 값은 0으로 설정
				if($(d).val().trim() === ""){
					$(d).val(0);
				}
				if($(d).is(".not-null") && $(d).val() === "0"){
					console.log($(d));
					swalWarningCB("인원값을 확인해주세요.", function(){
						$(d).focus();
					});
					check = false;
					return false;
				}
				if(isNaN(Number(unComma($(d).val())))){
					swalWarningCB("항목값을 확인해주세요.", function(){
						$(d).focus();
					});
					check = false;
					return false;
				}
			});
// 			console.log("결과", check);
			return check;
		}
		function formatDate_y(date) {
			var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
			if (month.length < 2)
				month = '0' + month;
			if (day.length < 2)
				day = '0' + day;
			return [ year ].join('/');
		}
	</script>
</body>