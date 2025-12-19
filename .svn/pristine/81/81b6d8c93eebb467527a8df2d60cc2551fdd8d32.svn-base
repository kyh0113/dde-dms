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
<style type="text/css">
.default_hide {
	display: none;
}
</style>
<title>통합경비 등록</title>
</head>
<body>
	<!-- 20191023_khj for csrf -->
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<h2>
		통합경비 등록
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
	<form id="frm" name="frm" method="post">
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
<!-- 							<select id="BASE_YYYY" name="BASE_YYYY" onchange="javascript: $('#search_btn').trigger('click');"> -->
<%-- 								<c:forEach var="i" begin="0" end="${to_yyyy - from_yyyy}">JSTL 역순 출력 - 연도 --%>
<%-- 									<c:set var="yearOption" value="${to_yyyy - i}" /> --%>
<%-- 									<option value="${yearOption}">${yearOption}</option> --%>
<%-- 								</c:forEach> --%>
<!-- 							</select> -->
							<input type="text" id="BASE_YYYY" name="BASE_YYYY" class="calendar search_dtp_y" value="${to_yyyy}" readonly="readonly"/>
						</td>
						<th>&nbsp;</th>
						<td>&nbsp;</td>
						<th>&nbsp;</th>
						<td>&nbsp;</td>
					</tr>
				</table>
				<div class="btn_wrap">
					<button class="btn btn_search" id="search_btn" type="">조회</button>
				</div>
			</div>
		</section>
	</form>
	<div class="float_wrap" style="margin-bottom: 2px;">
		<div class="fl" style="margin-bottom: 10px;">&nbsp;</div>
		<div class="fr">
			<div class="btn_wrap">
				<input type=button class="btn_g" id="fnUpdate" value="수정">
				<input type=button class="btn_g" id="fnSave" value="저장">
			</div>
		</div>
	</div>
	<section class="section">
		<table class ="cct_table" cellspacing="10" cellpadding="100">
			<colgroup>
				<col width="15%" />
				<col width="85%" />
			</colgroup>
			<tr>
				<th>퇴직금</th>
				<td>
					<input id="retirement_grants" class ="cct_table_input" />
					<b>&nbsp;개월</b>
				</td>
			</tr>
			<tr>
				<th>산재보험료</th>
				<td>
					<input id="safety_insurance" class ="cct_table_input"/>
					<b>&nbsp;%</b>
				</td>
			</tr>
			<tr>
				<th>국민연금</th>
				<td>
					<input id="national_pension" class ="cct_table_input"/>
					<b>&nbsp;%</b>
				</td>
			</tr>
			<tr>
				<th>건강보험료</th>
				<td>
					<input id="health_insurance" class ="cct_table_input"/>
					<b>&nbsp;%</b>
				</td>
			</tr>
			<tr>
				<th>장기요양보험</th>
				<td>
					<input id="longterm_insurance" class ="cct_table_input"/>
					<b>&nbsp;%</b>
				</td>
			</tr>
			<tr>
				<th>고용보험</th>
				<td>
					<input id="employment_insurance" class ="cct_table_input"/>
					<b>&nbsp;%</b>
				</td>
			</tr>
			<tr>
				<th>종합소득세</th>
				<td>
					<input id="general_income_tax" class ="cct_table_input"/>
					<b>&nbsp;%</b>
				</td>
			</tr>
			<tr>
				<th>세무성실신고</th>
				<td>
					<input id="tax_affairs_report" class ="cct_table_input"/>
					<b>&nbsp;%</b>
				</td>
			<tr>
			<tr>
				<th>사업주이윤</th>
				<td>
					<input id="profit" class ="cct_table_input"/>
					<b>&nbsp;원</b>
				</td>
			<tr>
		</table>
	</section>
	<script>
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
			
			// 조회
			$("#search_btn").on("click", function() {
				console.log('클릭');
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				
				//테이블 input태그들
				var $table_inputs = $(".cct_table .cct_table_input");
				
				var data = $("#frm").serializeArray();
				
				//input값들 초기화
				$table_inputs.val('');
				
				$.ajax({
					url : "/yp/zwc/mst/zwc_cct_select",
					type : "POST",
					cache : false,
					async : true,
					dataType : "json",
					data : data,
					success : function(data) {
						var result = data.result[0];
						console.log('data:',data);
						if(data.result.length == 0){
							//input 수정가능
							$table_inputs.prop('readonly',false);
							return;
						}
						
						//input 리드온리
						$table_inputs.prop('readonly',true);
						
						//순서
						//json데이터와 html 순서 똑같아서 순서에 맞게 넣어줌.
						//0:퇴직금, 1:산재보험료, 2:국민연금, 3:건강보험료, 4:장기요양보험, 5:고용보험, 6:종합소득세, 7:세무성실신고
						var i = 0;
						for(let key in result){
							var data = result[key];
							$table_inputs[i].value = data;
							i++;
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
			});
			
			// 수정
			$("#fnUpdate").on("click", function() {
				//테이블 input태그들
				var $table_inputs = $(".cct_table .cct_table_input");
				//input 수정가능
				$table_inputs.prop('readonly',false);
			});

			// 선택 저장
			$("#fnSave").on("click", function() {
				
				//테이블 input태그들
				var $table_inputs = $(".cct_table .cct_table_input");
				
				//빈값 체크
				var is_exist_empty = false;
				$table_inputs.each(function (index, item){
					if(isEmpty(item.value)){
						is_exist_empty = true;
						return;
					}
				});
				if(is_exist_empty){
					swalWarning("빈값이 있습니다. 모두 입력해주세요.");
					return;
				}
				
				//form데이터에 input데이터들 추가시키기
				var data = $("#frm").serializeArray();
				$table_inputs.each(function (index, item){
					data.push({name: item.id, value: item.value});
				});
				
				
				if (confirm("저장 하겠습니까?")) {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					
					//var data = $("#frm").serializeArray();
					
					$.ajax({
						url : "/yp/zwc/cct/zwc_cct_save",
						type : "POST",
						cache : false,
						async : true,
						dataType : "json",
						data : data,
						success : function(data) {
							$("#search_btn").trigger("click");
							swalSuccess("저장 되었습니다.");
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
			});

			
			// 처음에 바로 조회
			$("#search_btn").trigger("click");
		});
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