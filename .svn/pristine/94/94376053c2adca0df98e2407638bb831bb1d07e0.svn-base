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
SimpleDateFormat date = new SimpleDateFormat("yyyy/MM");
String to_yyyy = date.format(today);
// JSTL에서 사용할 수 있도록 세팅
request.setAttribute("to_yyyy", to_yyyy);

Calendar cal = Calendar.getInstance();
String from_yyyy = date.format(cal.getTime());
//JSTL에서 사용할 수 있도록 세팅
request.setAttribute("from_yyyy", from_yyyy);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>계획대비실적</title>
<style type="text/css">
.table td, .table th {
	padding: 0.4rem !important;
}
</style>
</head>
<body>
	<!-- 20191023_khj for csrf -->
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<h2>
		계획대비실적
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
					<col width="5%" />
					<col width="25%" />
					<col width="5%" />
					<col width="25%" />
					<col width="5%" />
					<col width="25%" />
				</colgroup>
				<tr>
					<th>조회연월</th>
					<td>
						<input type="text" id="SEARCH_YYYYMM" class="calendar search_dtp_m" value="${from_yyyy}" readonly="readonly" />
					</td>
					<th>거래처</th>
					<td>
						<select id="VENDOR_CODE" name="VENDOR_CODE">
							<option value="" selected="selected">-전체-</option>
							<c:forEach items="${cb_working_master_v}" var="data">
								<option value="${data.CODE}">${data.CODE_NAME}</option>
							</c:forEach>
						</select>
					</td>
					<th>부서명</th>
					<td>
						<select id="DEPT_CODE">
							<option value="" selected="selected">-전체-</option>
							<c:forEach var="t" items="${teamList}" varStatus="status">
								<option value="${t.OBJID}">${t.STEXT}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>비교연월</th>
					<td>
						<input type="text" id="COMPARE_YYYYMM" class="calendar search_dtp_m" value="${to_yyyy}" readonly="readonly" />
					</td>
				</tr>
			</table>
			<div class="btn_wrap">
				<input type=button class="btn btn_make" id="excel_btn"		value="엑셀 다운로드">
				<input type="button" class="btn btn_search" id="search_btn" value="조회" />
			</div>
		</div>
	</section>
	<section class="section">
		<form id="frm" name="frm" method="post">
			<div class="tbl_box" style="background: none;">
				<table border="1" class="table">
					<tr class="tb-head">
						<td rowspan="3" style="color: white;">부서명</td>
						<td rowspan="3" style="color: white;">거래처</td>
						<td rowspan="3" style="color: white;">계약명</td>
						<td colspan="4" style="color: white;">계약</td>
						<td colspan="4" style="color: white;">실적</td>
						<td rowspan="3" style="color: white;">차액</td>
						<td colspan="6" style="color: white;">비교연월</td>
						<td rowspan="3" style="color: white;">차액</td>
					</tr>
					<tr class="tb-head">
						<td rowspan="2" style="color: white;">기준</td>
						<td rowspan="2" style="color: white;">단위</td>
						<td rowspan="2" style="color: white;">단가</td>
						<td rowspan="2" style="color: white;">금액</td>
						<td rowspan="2" style="color: white;">기준</td>
						<td rowspan="2" style="color: white;">단위</td>
						<td rowspan="2" style="color: white;">단가</td>
						<td rowspan="2" style="color: white;">금액</td>
						<td style="color: white;">계약</td>
						<td colspan="4" style="color: white;">실적</td>
						<td rowspan="2" style="color: white;">차액</td>
					</tr>
					<tr class="tb-head">
						<td style="color: white;">금액</td>
						<td style="color: white;">기준</td>
						<td style="color: white;">단위</td>
						<td style="color: white;">단가</td>
						<td style="color: white;">금액</td>
					</tr>
					<tr><td class="center vertical-center" colspan="19">데이터가 없습니다.</td></tr>
				</table>
			</div>
		</form>
	</section>
	<script>
		$(document).ready(function() {
			$(".search_dtp_m").datepicker({
				format : "yyyy/mm",
				viewMode : "months",
				minViewMode : "months",
				language : "ko",
				todayHighlight : true,
				autoclose : true,
				clearBtn : true,
				updateViewDate : false
			}).on('changeDate', function(e) {
				$(this).val(formatDate_m(e.date.valueOf())).trigger("change");
				$('.datepicker').hide();
			});

			// 조회
			$("#search_btn").on("click", function() {
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				var data = {
					'SEARCH_YYYYMM' : $("#SEARCH_YYYYMM").val().trim(),
					'COMPARE_YYYYMM' : $("#COMPARE_YYYYMM").val().trim(),
					'VENDOR_CODE' : $("#VENDOR_CODE").val(),
					'DEPT_CODE' : $("#DEPT_CODE").val(),
					header : token
				};
				$.ajax({
					url : "/yp/zwc/ipt/select_zwc_ipt_performance",
					type : "POST",
					cache : false,
					async : true,
					dataType : "json",
					data : data, //폼을 그리드 파라메터로 전송
					success : function(data) {
						//테이블 초기화
						tableInit();

						var innerHtml = '';

						//도금비 조정안 리스트
						var list = data.list;
						//도금비 조정안 데이터 없을경우, return
						if (list.length > 0) {
							//도급비 조정안 row
							for (var i = 0; i < list.length; i++) {
								var obj = list[i];
								console.log(i, obj);
								innerHtml += '<tr>';
								innerHtml += '	<td class="center vertical-center">' + obj.DEPT_NAME + '</td>';
								innerHtml += '	<td class="center vertical-center">' + obj.VENDOR_NAME + '</td>';
								innerHtml += '	<td class="center vertical-center">' + obj.CONTRACT_NAME + '</td>';
								innerHtml += '	<td class="right vertical-center">' + addComma( String( obj.A_QTY ) ) + '</td>';
								innerHtml += '	<td class="center vertical-center">' + obj.A_UNIT_NAME + '</td>';
								innerHtml += '	<td class="right vertical-center">' + addComma( String( obj.A_UNIT_PRICE ) ) + '</td>';
								innerHtml += '	<td class="right vertical-center" style="background-color: lightblue;">' + addComma( String( obj.A_AMOUNT ) ) + '</td>';
								innerHtml += '	<td class="right vertical-center">' + addComma( String( obj.M_QTY ) ) + '</td>';
								innerHtml += '	<td class="center vertical-center">' + obj.M_UNIT_NAME + '</td>';
								innerHtml += '	<td class="right vertical-center">' + addComma( String( obj.M_UNIT_PRICE ) ) + '</td>';
								innerHtml += '	<td class="right vertical-center" style="background-color: lightblue;">' + addComma( String( obj.M_AMOUNT ) ) + '</td>';
								innerHtml += '	<td class="right vertical-center" style="background-color: lightsalmon;">' + addComma( String( obj.M_DIFF ) ) + '</td>';
								innerHtml += '	<td class="right vertical-center" style="background-color: lightblue;">' + addComma( String( obj.CA_AMOUNT ) ) + '</td>';
								innerHtml += '	<td class="right vertical-center">' + addComma( String( obj.CM_QTY ) ) + '</td>';
								innerHtml += '	<td class="center vertical-center">' + obj.CM_UNIT_NAME + '</td>';
								innerHtml += '	<td class="right vertical-center">' + addComma( String( obj.CM_UNIT_PRICE ) ) + '</td>';
								innerHtml += '	<td class="right vertical-center" style="background-color: lightblue;">' + addComma( String( obj.CM_AMOUNT ) ) + '</td>';
								innerHtml += '	<td class="right vertical-center" style="background-color: lightsalmon;">' + addComma( String( obj.CM_DIFF ) ) + '</td>';
								innerHtml += '	<td class="right vertical-center" style="background-color: lightsalmon;">' + addComma( String( obj.CT_DIFF ) ) + '</td>';
								innerHtml += '</tr>';
							}
						}else{
							innerHtml = '<tr><td class="center vertical-center" colspan="19">데이터가 없습니다.</td></tr>';
						}
						$('.table').append(innerHtml);
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
						swalDangerCB("조회 실패하였습니다.\n관리자에게 문의해주세요.");
					}
				});
			});
			
			// 엑셀 다운로드
			$("#excel_btn").on("click", function() {
				//20191023_khj for csrf
				var csrf_element = document.createElement("input");
				csrf_element.name = "_csrf";
				csrf_element.value = "${_csrf.token}";
				csrf_element.type = "hidden";
				//20191023_khj for csrf
				var xlsForm = document.createElement("form");
				
				xlsForm.target = "xlsx_download";
				xlsForm.name = "sndFrm";
				xlsForm.method = "post";
				xlsForm.action = "/yp/xls/zwc/ipt/select_zwc_ipt_performance";
				
				document.body.appendChild(xlsForm);
				
				xlsForm.appendChild(csrf_element);
				
				var pr = {
					SEARCH_YYYYMM : $("#SEARCH_YYYYMM").val().trim(),
					COMPARE_YYYYMM : $("#COMPARE_YYYYMM").val().trim(),
					VENDOR_CODE : $("#VENDOR_CODE").val(),
					DEPT_CODE : $("#DEPT_CODE").val()
				};
				
				$.each(pr, function(k, v) {
					console.log(k, v);
					var el = document.createElement("input");
					el.name = k;
					el.value = v;
					el.type = "hidden";
					xlsForm.appendChild(el);
				});
				
				xlsForm.submit();
				xlsForm.remove();
				$('.wrap-loading').removeClass('display-none');
				setTimeout(function() {
					$('.wrap-loading').addClass('display-none');
				}, 1000); // 1초
			});
		});

		//테이블 초기화
		function tableInit() {
			//table tr 초기화
			$(".table tr").remove();
			var innerHtml = 
				'<tr class="tb-head">' +
				'	<td rowspan="3" style="color: white">부서명</td>' +
				'	<td rowspan="3" style="color: white">거래처</td>' +
				'	<td rowspan="3" style="color: white">계약명</td>' +
				'	<td colspan="4" style="color: white">계약기준</td>' +
				'	<td colspan="4" style="color: white">실적기준</td>' +
				'	<td rowspan="3" style="color: white">차액</td>' +
				'	<td colspan="6" style="color: white">비교연월</td>' +
				'	<td rowspan="3" style="color: white">차액</td>' +
				'</tr>' +
				'<tr class="tb-head">' +
				'	<td rowspan="2" style="color: white">기준</td>' +
				'	<td rowspan="2" style="color: white">단위</td>' +
				'	<td rowspan="2" style="color: white">단가</td>' +
				'	<td rowspan="2" style="color: white">금액</td>' +
				'	<td rowspan="2" style="color: white">기준</td>' +
				'	<td rowspan="2" style="color: white">단위</td>' +
				'	<td rowspan="2" style="color: white">단가</td>' +
				'	<td rowspan="2" style="color: white">금액</td>' +
				'	<td style="color: white">계약기준</td>' +
				'	<td colspan="4" style="color: white">실적기준</td>' +
				'	<td rowspan="2" style="color: white">차액</td>' +
				'</tr>' +
				'<tr class="tb-head">' +
				'	<td style="color: white">금액</td>' +
				'	<td style="color: white">기준</td>' +
				'	<td style="color: white">단위</td>' +
				'	<td style="color: white">단가</td>' +
				'	<td style="color: white">금액</td>' +
				'</tr>';
			$('.table').append(innerHtml);
		}

		/*콤마 추가*/
		function addComma(num) {
			return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		}

		/*콤마 제거*/
		function unComma(num) {
			return num.replace(/,/gi, '');
		}

		function formatDate_y(date) {
			var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
			if (month.length < 2)
				month = '0' + month;
			if (day.length < 2)
				day = '0' + day;
			return [ year ].join('/');
		}

		function formatDate_m(date) {
			var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
			if (month.length < 2)
				month = '0' + month;
			if (day.length < 2)
				day = '0' + day;
			return [ year, month ].join('/');
		}

		function formatDate_d(date) {
			var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
			if (month.length < 2)
				month = '0' + month;
			if (day.length < 2)
				day = '0' + day;
			return [ year, month, day ].join('/');
		}
	</script>
	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
</body>