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
	<title>작업자 조회</title>
	<style type="text/css">
	.lst th, .lst td { font-size: 1.0em; }
	.lst td { border : 1px solid #000; cursor: auto !important; vertical-align: inherit !important;}
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
		작업자 조회
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
					<th>입소일</th>
					<td>
						<input type="text" id="A_START_DATE" class="default_hide calendar search_dtp_d" value="${today}" readonly="readonly"/>
					</td>
				</tr>
			</table>
			<div class="btn_wrap">
				<input type=button class="btn btn_make" id="excel_btn"		value="엑셀 다운로드">
				<input type=button class="btn btn_search" id="search_btn"		value="조회">
			</div>
		</div>
	</section>
	<section>
		<div class="lst" style="overflow-y: scroll; height: 650px;">
			<table cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="10%"/>
					<col width="6%"/>
					<col width="8%"/>
					<col width="8%"/>
					<col width="8%"/>
					<col width="10%"/>
					<col width="*"/>
					<col width="8%"/>
					<col width="8%"/>
				</colgroup>
				<tr class="col_rows">
					<th>거래처</th>
					<th>작업자</th>
					<th>입소일시</th>
					<th>퇴소일시</th>
					<th>오더번호</th>
					<th>코스트센터</th>
					<th>오더내역</th>
					<th>작업입장</th>
					<th>작업퇴장</th>
				</tr>
				<tr class="ndata_rows"><td align="center" colspan="9" class="watermark">데이터가 없습니다.</td></tr>
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
				viewMode: "1",
				minViewMode: "1",
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
					url : "/yp/zcs/ipt/select_zcs_ipt_worker_list",
					type : "post",
					cache : false,
					async : true,
					data : {
						COMPANY_ID : $("#COMPANY_ID").val().trim(),
						USER_NAME : $("#USER_NAME").val().trim(),
						A_START_DATE : $("#A_START_DATE").val().replace(/\//gi, "").trim()
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
								'<td class="'+ (flag ? 'add_rowspan row_' + i: 'remove') +'">' + (d.COMPANY_ID === null ? "" : d.COMPANY_ID) + '</td>' + 
								'<td class="'+ (flag ? 'add_rowspan row_' + i: 'remove') +'" title="' + d.CARD_NO + '">' + d.USER_NAME + '</td>' + 
								'<td class="'+ (flag ? 'add_rowspan row_' + i: 'remove') +'">' + d.A_START_DATE + '</td>' + 
								'<td class="'+ (flag ? 'add_rowspan row_' + i: 'remove') +'">' + (d.A_END_DATE === null ? "" : d.A_END_DATE) + '</td>' + 
								'<td>' + (d.AUFNR === null ? "" : d.AUFNR) + '</td>' + 
								'<td title="' + (d.KOSTL === null ? "" : d.KOSTL) + '">' + (d.KTEXT === null ? "" : d.KTEXT) + '</td>' + 
								'<td style="text-align: left;">' + (d.AUFTEXT === null ? "" : d.AUFTEXT) + '</td>' + 
								'<td>' + (d.W_START_DATE === null ? "" : d.W_START_DATE) + '</td>' + 
								'<td>' + (d.W_END_DATE === null ? "" : d.W_END_DATE) + '</td>' + 
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
				xlsForm.action = "/yp/xls/zcs/ipt/select_zcs_ipt_worker_list";
				
				document.body.appendChild(xlsForm);
				
				xlsForm.appendChild(csrf_element);
				
				var pr = {
					COMPANY_ID : $("#COMPANY_ID").val().trim(),
					USER_NAME : $("#USER_NAME").val().trim(),
					A_START_DATE : $("#A_START_DATE").val().replace(/\//gi, "").trim()
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
			
			// 필터 토글
			$("#filter_btn").on("click", function() {
				scope.gridOptions.enableFiltering = !scope.gridOptions.enableFiltering;
				scope.gridApi.core.notifyDataChange( scope.uiGridConstants.dataChange.COLUMN );
			});
		});
		
		function fnValidation(){
			var check = true;
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
		
		function fnSearchPopup(type) {
			if(type == "1"){
				window.open("", "거래처 검색", "width=600, height=800, scrollbars=yes");
				// 지급기준별 조회 조건 추가 - {1:공수, 2: 작업, 3: 월정액}
				fnHrefPopup("/yp/popup/zcs/ipt/popup_company_id", "거래처 검색", {});
			}else if (type == "2") {
				window.open("", "작업자 검색", "width=600, height=800, scrollbars=yes");
				fnHrefPopup("/yp/popup/zcs/ipt/popup_name", "작업자 검색", {
					COMPANY_ID : $("#COMPANY_ID").val().trim()
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
	<iframe name="xlsx_download" style="display:none;" src=""></iframe>
</body>