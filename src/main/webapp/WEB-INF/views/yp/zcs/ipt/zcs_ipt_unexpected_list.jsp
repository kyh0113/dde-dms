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

Date dt = new Date();
SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/dd");
String today = date.format(dt);
// JSTL에서 사용할 수 있도록 세팅
request.setAttribute("today", today);
%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>돌발 작업/오더 매핑</title>
	<style type="text/css">
	.lst th, .lst td { font-size: 1.0em; }
	.lst td { border : 1px solid #000; cursor: auto !important; vertical-align: inherit !important;}
	.lst tr:hover td { background: none; }
	.lst th { text-align: center; font-weight: bold; background-color: #fff20080; }
	.watermark { position : inherit !important; font-size: 2.5em !important; padding : 50px 0 50px 0 !important; }
	.data_rows { display: none; }
	</style>
</head>
<body>
	<form id="frm" name="frm" method="post">
		<!-- 20191023_khj for csrf -->
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
	<h2>
		돌발 작업/오더 매핑
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
					<col width="3%" />
					<col width="30%" />
					<col width="3%" />
					<col width="30%" />
					<col width="3%" />
					<col width="30%" />
				</colgroup>
				<tr>
					<th>거래처</th>
					<td>
						<input type="text" id="COMPANY_ID"/>
						<a href="#" onclick="fnSearchPopup('1');"><img src="/resources/yp/images/ic_search.png"></a>
					</td>
					<th>작업자</th>
					<td>
						<input type="text" id="USER_NAME" />
						<a href="#" onclick="fnSearchPopup('2');"><img src="/resources/yp/images/ic_search.png"></a>
					</td>
					<th>입퇴장기간</th>
					<td>
						<input type="text" id="A_START_DATE" class="default_hide calendar search_dtp_d" value="${today}" readonly="readonly"/>&nbsp;~&nbsp;
						<input type="text" id="A_END_DATE" class="default_hide calendar search_dtp_d" value="${today}" readonly="readonly"/>
					</td>
				</tr>
			</table>
			<div class="btn_wrap">
				<input type=button class="btn btn_search" id="search_btn"		value="조회">
			</div>
		</div>
	</section>
	<div class="float_wrap">
		<div class="fr">
			<div class="btn_wrap" style="margin-bottom:5px;">
				<input type="button" class="btn_g" id="fnIns" value="저장"/>
			</div>
		</div>
	</div>
	<section>
		<div class="lst">
			<table cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="3%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="15%"/>
					<col width="15%"/>
					<col width="*"/>
					<col width="3%"/>
				</colgroup>
				<tr class="col_rows">
					<th>&nbsp;</th>
					<th>거래처</th>
					<th>작업자</th>
					<th>작업입장</th>
					<th>작업퇴장</th>
					<th>오더번호</th>
					<th>&nbsp;</th>
				</tr>
				<tr class="ndata_rows"><td align="center" colspan="7" class="watermark">데이터가 없습니다.</td></tr>
			</table>
		</div>
	</section>
	<c:if test="${!empty pagination}">
		<div class="paginavi">
			<div class="paging">
				<c:if test="${pagination.curRange ne 1 }">
					<a href="javascript:void(0);" class="btnCtrl start fn_paging" page="1">◀◀</a>
				</c:if>
				<c:if test="${pagination.curPage ne 1}">
					<a href="javascript:void(0);" class="btnCtrl prev fn_paging" page="${pagination.getPrevPage()}">◀</a>
				</c:if>
				<c:forEach var="pageNum" begin="${pagination.getStartPage()}" end="${pagination.getEndPage()}">
					<c:choose>
						<c:when test="${pageNum eq  pagination.getCurPage()}">
							<a href="javascript:void(0);" class="page on fn_paging" page="${pageNum}">${pageNum}</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:void(0);" class="page fn_paging" page="${pageNum}">${pageNum}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${pagination.getCurPage() ne pagination.getPageCnt() && pagination.getPageCnt() > 0}">
					<a href="javascript:void(0);" class="btnCtrl next fn_paging" page="${pagination.getNextPage()}">▶</a>
				</c:if>
				<c:if test="${pagination.getCurRange() ne pagination.getRangeCnt() && pagination.getRangeCnt() > 0}">
					<a href="javascript:void(0);" class="btnCtrl last fn_paging" page="${pagination.getPageCnt()}">▶▶</a>
				</c:if>
			</div>
		</div>
	</c:if>
	<script>
	$(document).ready(function() {
		// 부트스트랩 날짜객체
		$(".search_dtp_d").datepicker({
			format: "yyyy/mm/dd",
			viewMode: "days",
			minViewMode: "days",
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
			$("#search_btn").trigger("click");
			$('.datepicker').hide();
		});
		
		// 조회
		$("#search_btn").on("click", function() {
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				url : "/yp/zcs/ipt/select_zcs_ipt_unexpected_list",
				type : "post",
				cache : false,
				async : true,
				data : {
					COMPANY_ID : $("#COMPANY_ID").val().trim(),
					USER_NAME : $("#USER_NAME").val().trim(),
					A_START_DATE : $("#A_START_DATE").val().replace(/\//gi, "").trim(),
					A_END_DATE : $("#A_END_DATE").val().replace(/\//gi, "").trim()
				},
				dataType : "json",
				success : function(data) {
					var result = data.result;
					if(result.length === 0){
						$(".ndata_rows").show();
						return false;
					}
					var data2 = '';
					var before_rnum = 0;
					var same_cnt = 1;
					var flag = false;
					var target = 0;
					// 이전과 지금이 다를때 넣을 위치를 정한다. - ROWSPAN 부여할 위치
					// 이전과 지금이 다를때 넣을 값을 초기화한다. - ROWSPAN 값
					// 넣을 위치에 매번 값을 넣는다. 
					$.each(result, function(i, d){
						console.log(i, d);
						if(before_rnum !== d.RNUM){
							target = i;
							same_cnt = 1;
							flag = true;
						}else{
							same_cnt++;
							flag = false;
						}
						data2 +=
						'<tr class="data_rows">' + 
							'<td><input type="checkbox" class="datas" style="zoom : 1.5;"' + 
							' WORK_SEQ="' + d.WORK_SEQ + '"' + 
							' USER_NAME="' + d.USER_NAME + '"' + 
							' SABUN="' + d.SABUN + '"' + 
							' W_START_DATE="' + d.W_START_DATE + '"' + 
							' W_START_TIME="' + d.W_START_TIME + '"' + 
							' W_END_DATE="' + d.W_END_DATE + '"' + 
							' W_END_TIME="' + d.W_END_TIME + '"' + 
							' REG_DATE="' + d.REG_DATE + '"' + 
							' UPDATE_DATE="' + d.UPDATE_DATE + '"' + 
							'></td>' + 
// 							'<td>' + (d.W_END_DATE === null ? "" : d.W_END_DATE) + '</td>' + 
							'<td class="'+ (flag ? 'add_rowspan row_' + i: 'remove') +'">' + d.COMPANY_ID + '</td>' + 
							'<td class="'+ (flag ? 'add_rowspan row_' + i: 'remove') +'" title="' + d.CARD_NO + '">' + d.USER_NAME + '</td>' + 
							'<td>' + (d.W_START_DATE_VIEW === null ? "" : d.W_START_DATE_VIEW) + ' ' + (d.W_START_TIME_VIEW === null ? "" : d.W_START_TIME_VIEW) + '</td>' + 
							'<td>' + (d.W_END_DATE_VIEW === null ? "" : d.W_END_DATE_VIEW) + ' ' + (d.W_END_TIME_VIEW === null ? "" : d.W_END_TIME_VIEW) + '</td>' + 
							'<td style="text-align: left;"><span class="auftext_view"></span></td>' + 
							'<td>' + '<a href="#" onclick="fnSearchPopup(\'3\', ' + i + ');"><img src="/resources/yp/images/ic_search.png"></a>' + '</td>' +
						'</tr>';
						if(i === 0){
							result[i].ROWSPAN = 1;
						}else{
							if(result[target].RNUM !== result[i].RNUM){
								result[i].ROWSPAN = 1;
							}else{
								result[target].ROWSPAN = same_cnt;
							}
						}
						console.log("result["+target+"].ROWSPAN = " + result[target].ROWSPAN);
						before_rnum = d.RNUM;
					});
					$(".col_rows").after(data2); // JSON 받아서 출력
					$(".data_rows > td.remove").remove();
					$.each(result, function(i, d){
						if(d.ROWSPAN){
							console.log(i, d.ROWSPAN);
							$(".data_rows > td.add_rowspan.row_" + i).prop("rowspan", d.ROWSPAN);
						}
					});
					
					$(".data_rows").show();
				},
				beforeSend : function(xhr) {
					// 2019-10-23 khj - for csrf
					xhr.setRequestHeader(header, token);
					$('.wrap-loading').removeClass('display-none');
					
					$(".data_rows").remove();
					$(".ndata_rows").hide();
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
		
		// 저장
		$("#fnIns").on("click", function() {
			if(fnValidation()){
				if (confirm("저장하시겠습니까?")) {
					var datas = [];
					$("input.datas").each(function(i, obj){
						if($(obj).is(":checked")){
							datas.push({
								AUFNR : $(obj).attr("AUFNR"),
								WORK_SEQ : $(obj).attr("WORK_SEQ"),
								VAPLZ : $(obj).attr("VAPLZ"),
								VATXT : $(obj).attr("VATXT"),
								KOSTL : $(obj).attr("KOSTL"),
								KTEXT : $(obj).attr("KTEXT"),
								AUFTEXT : $(obj).attr("AUFTEXT"),
								REG_DATE : $(obj).attr("REG_DATE"),
								UPDATE_DATE : $(obj).attr("UPDATE_DATE"),
							});
						}
					});
					
					console.log(JSON.stringify(datas));
// 					return false;
					
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : "/yp/zwc/ipt/proc_zcs_ipt_unexpected_list",
						type : "POST",
						cache : false,
						async : true,
						dataType : "json",
						data : {
							ROW_NO: JSON.stringify(datas)
						},
						success : function(result) {
							console.log(result);
							$("#search_btn").trigger("click");
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
				}
			}
		});
		
		// 필터 토글
		$("#filter_btn").on("click", function() {
			scope.gridOptions.enableFiltering = !scope.gridOptions.enableFiltering;
			scope.gridApi.core.notifyDataChange( scope.uiGridConstants.dataChange.COLUMN );
		});
	});
	
	function fnValidation(){
		var check = true;
		var datas = [];
		
		$("input.datas").each(function(i, obj){
			if($(obj).is(":checked")){
				datas.push({
					AUFNR : $(obj).attr("AUFNR")
				});
			}
		});
		
		if(datas.length === 0){
			swalWarningCB("돌발 작업/오더 매핑할 항목을 선택하세요.");
			check = false;
		}
		
		$.each(datas, function(i, d){
			console.log(d.AUFNR);
			if(typeof d.AUFNR === "undefined"){
				swalWarningCB("돌발 작업/오더 매핑되지 않은 항목이 선택되었습니다.");
				check = false;
				return false;
			}
		});
		
		return check;
	}
	
	/*콤마 추가*/
	function addComma(num) {
		return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}
	
	/*콤마 제거*/
	function unComma(num) {
		return num.replace(/,/gi, '');
	}
	
	function formatDate_d(date) {
		var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
		if (month.length < 2)
			month = '0' + month;
		if (day.length < 2)
			day = '0' + day;
		return [ year, month, day ].join('/');
	}
	
	function fnSearchPopup(type, order_no, target){
		if(type == "1"){
			
			
		}else if(type == "2"){	//돌발 작업/오더 검색팝업
			window.open("/yp/popup/zcs/ipt/unexpectedPop?I_AUFNR="+order_no+"&target="+target,"돌발 작업/오더 검색","width=900,height=800,scrollbars=yes");
		}
	}
	
	function fnSearchPopup(type, idx) {
		if (type == "1"){
			window.open("", "거래처 검색", "width=600, height=800, scrollbars=yes");
			// 지급기준별 조회 조건 추가 - {1:공수, 2: 작업, 3: 월정액}
			fnHrefPopup("/yp/popup/zcs/ipt/popup_company_id", "거래처 검색", {});
		}else if (type == "2") {
			window.open("", "작업자 검색", "width=600, height=800, scrollbars=yes");
			fnHrefPopup("/yp/popup/zcs/ipt/popup_name", "작업자 검색", {
				COMPANY_ID : $("#COMPANY_ID").val().trim()
			});
		}else if (type == "3"){ //돌발 작업/오더 검색팝업
			window.open("", "돌발 작업/오더 검색", "width=900, height=800, scrollbars=yes");
			fnHrefPopup("/yp/popup/zcs/ipt/unexpectedPop", "돌발 작업/오더 검색", {
				target : idx,
			});
		}
	}
	
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
	</script>
</body>