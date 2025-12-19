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
SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/dd");
String to_yyyy = date.format(today);

Calendar cal = Calendar.getInstance();
cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.getActualMinimum(Calendar.DATE));
String from_yyyy = date.format(cal.getTime());

date = new SimpleDateFormat("yyyy/MM");
String base_yyyymm = date.format(today);

// JSTL에서 사용할 수 있도록 세팅
request.setAttribute("to_yyyy", to_yyyy);
request.setAttribute("from_yyyy", from_yyyy);
request.setAttribute("base_yyyymm", base_yyyymm);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>월보 조회(공수)</title>
<style type="text/css">
.table td, .table th {
	padding: 0.4rem !important;
}
</style>
</head>
<body>
	<h2>
		월보 조회(공수)
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
		<!-- 엑셀업로드 insertQuery -->
		<input type='hidden' id='insertQuery' name='insertQuery' value='oracle.yp_zcs_ipt.create_construction_monthly_rpt1'>
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
							<input type="text" name="SAP_CODE" id="SAP_CODE" size="10" readonly="readonly" style="background-color: #e5e5e5;"/>
							<input type="hidden" name="VENDOR_CODE" id="VENDOR_CODE" size="10"/>
							<a href="#" onclick="fnSearchPopup('1');"><img src="/resources/yp/images/ic_search.png"></a>
							<input type="text" name="VENDOR_NAME" id="VENDOR_NAME" disabled="disabled"  style="width:200px;"/>
						</td>
						<th>계약코드</th>
						<td>
							<input type="text" name="CONTRACT_CODE" id="CONTRACT_CODE" size="10"/>
							<a href="#" onclick="fnSearchPopup('2');"><img src="/resources/yp/images/ic_search.png"></a>
							<input type="text" name="CONTRACT_NAME" disabled="disabled"  style="width:200px;"/>
						</td>
						<th>작업 시작일자</th>
						<td>
							<input type="text" id="STD" class="calendar dtp_ymd" value="${from_yyyy}" readonly="readonly"/>　~　
							<input type="text" id="EDD" class="calendar dtp_ymd" value="${to_yyyy}" readonly="readonly"/>
						</td>
					</tr>
				</table>
				<div class="btn_wrap">
				<button class="btn btn_search" id="search_btn" type="button">조회</button>
			</div>
			</div>
		</section>
		<section class="section">
			<form id="frm" name="frm" method="post">
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
			</form>
		</section>
	</form>
	<script type="text/javascript">
	var save_datas = new Array();
	
	$(document).ready(function(){
		var param = {
				EXEC_RFC  : "N", // RFC 여부
				cntQuery  : "yp_zcs_ipt.select_construction_monthly_rpt1_cnt", 	
				listQuery : "yp_zcs_ipt.select_construction_monthly_rpt1"
		};
		
		$('input').on('keydown', function(event) {
			if(event.keyCode==13) 
				return false;
		});
		
		// 부트스트랩 날짜객체
		$(".dtp_ym").datepicker({
			format : "yyyy/mm",
			language : "ko",
			viewMode: "months",
			minViewMode: "months",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		}).on('changeDate', function(e) {
			if(e.viewMode !== "months"){
				return false;
			}
			$(this).val(formatDate_m(e.date.valueOf())).trigger("change");
			$('.datepicker').hide();
		});

		$(document).on("focus", ".dtp_ymd", function() {
			$(this).datepicker({
				format: "yyyy/mm/dd",
				language : "ko",
				todayHighlight : true,
				autoclose : true,
				clearBtn : true,
				updateViewDate : false
			}).on('changeDate', function(e) {
				if(e.viewMode !== "days"){
					return false;
				}
				$(this).val(formatDate_d(e.date.valueOf())).trigger("change");
				$('.datepicker').hide();
			});
		});
		
		// 조회
		$("#search_btn").on("click", function() {
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
			// 시작일자
			var STD = $("#STD").val().trim();
			if(isEmpty(STD)){
				swalWarningCB("시작일자를 입력해주세요.");
				return false;
			}
			// 종료일자
			var EDD = $("#EDD").val().trim();
			if(isEmpty(EDD)){
				swalWarningCB("종료일자를 입력해주세요.");
				return false;
			}
			var data = {
				'VENDOR_CODE' : $("#VENDOR_CODE").val().trim(),
				'CONTRACT_CODE' : $("#CONTRACT_CODE").val().trim(),
				'STD' : $("#STD").val().trim(),
				'EDD' : $("#EDD").val().trim(),
// 				'TEAM' : "성우공업사"
				'TEAM' : $("#VENDOR_NAME").val().trim()
			};
			
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				url : "/yp/zcs/ipt/select_zcs_ipt_mon_manh_read",
				type : "POST",
				cache : false,
				async : true,
				dataType : "json",
				data : data, //폼을 그리드 파라메터로 전송
				success : function(data) {
					//테이블 초기화
					tableInit();
					
					var innerHtml = '';
					var manhour = 0;
					var manhour_correction = 0;
					var manhour_sum = 0;
					
					var result1 = data.list;
					
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
					innerHtml += '	<td class="right vertical-center"	style="width: 100px;"><div style="padding: 4px 3px;">' + manhour.toFixed(2) + '</div></td>';
					innerHtml += '	<td class="right vertical-center"	style="width: 100px;"><div style="padding: 4px 3px;">' + manhour_correction.toFixed(2) + '</div></td>';
					innerHtml += '	<td class="right vertical-center"	style="width: 100px;"><div style="padding: 4px 3px;">' + manhour_sum.toFixed(2) + '</div></td>';
					innerHtml += '	<td class="right vertical-center"><div style="padding: 4px 3px;">&nbsp;</div></td>';
					innerHtml += '</tr>';
					
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
	});
	
	/* 팝업 */
	function fnSearchPopup(type, target) {
		var w;
		if (type == "1") {
			w = window.open("/yp/popup/zcs/ctr/select_working_master_v", "업체 검색", "width=600, height=800");
		}else if(type == "2"){
			w = window.open("","계약명 검색","width=600,height=800,scrollbars=yes");
			// 지급기준별 조회 조건 추가 - {1:공수, 2: 작업, 3: 월정액} 
			fnHrefPopup("/yp/popup/zcs/ctr/retrieveContarctName", "계약명 검색", {
				PAY_STANDARD : "1"
			});
		}else if (type == "3") {
			w = window.open("", "SAP 오더 검색", "width=900, height=800, scrollbars=yes");
			fnHrefPopup("/yp/popup/zcs/ipt/sapPop", "SAP 오더 검색", {
				target : target,
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

	//테이블 초기화
	function tableInit() {
		//table tr 초기화
		$(".table tr:not(.tb-head)").remove();
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
	
	/* 검수보고서 결재여부 확인 */
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
	
// 	function fnSearchPopup(target){
// 		window.open("", "SAP 오더 검색", "width=900, height=800, scrollbars=yes");
// 		fnHrefPopup("/yp/popup/zcs/ipt/sapPop", "SAP 오더 검색", {
// 			target : idx,
// 		});
// 	}
	</script>
</body>