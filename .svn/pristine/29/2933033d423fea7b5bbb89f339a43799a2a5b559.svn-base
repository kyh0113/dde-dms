<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/resources/icm/js/jquery.js"></script>
<script src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
<script src="/resources/icm/js/custom.js" ></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<sec:csrfMetaTags />
<title>비품요청 상세</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">

<style type="text/css">
#frm thead {
	background: #333333;
    color: white;
}
</style>

<script type="text/javascript">

	/**
	 * 전역 변수 
	 */
	var table_data = JSON.parse('${grid_data}');
		
	$(document).ready(function() {
		
		$(".fn_paging").on("click", function() {
			/**
			 * HTML의 page 속성의 값을 가져옴. 
			 */
			$("input[name=page]").val($(this).attr("page"));
			fnSearchData();
		});
		
		/**
		 * enter key
		 */
		$('input[name="search_text"]').keydown(function() {
			if (event.keyCode === 13) {
		  		event.preventDefault();
		  		fnSearchData();
		  		
		  	};
		});
		
		// 엑셀 다운로드
		$("#excel_btn").on("click", function() {
			event.preventDefault();
			
			//20191023_khj for csrf
			var csrf_element = document.createElement("input");
			csrf_element.name = "_csrf";
			csrf_element.value = "${_csrf.token}";
			csrf_element.type = "hidden";
			//20191023_khj for csrf
			var xlsForm = document.createElement("form");

			xlsForm.name = "sndFrm";
			xlsForm.method = "post";
			xlsForm.action = "/yp/popup/fixture/xls/fixture_req_dtl_list";

			document.body.appendChild(xlsForm);

			xlsForm.appendChild(csrf_element);

			var pr = {
				search_type : $("select[name=search_type]").val(),
				search_text : $("input[name=search_text]").val(),
				gridData : '${grid_data}'
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
			}, 5000); //5초
		});
		
		$(".purchase_req_btn").on("click", function() {
			
			if(table_data.length < 1){
				swalWarningCB("발주 요청할 데이터가 없습니다.");
				return false;
			}
			
			swal({
				icon : "info",
				text : "발주요청 하시겠습니까?",
				closeOnClickOutside : false,
				closeOnEsc : false,
				buttons : {
					confirm : {
						text : "확인",
						value : true,
						visible : true,
						className : "",
						closeModal : true
					},
					cancel : {
						text : "취소",
						value : null,
						visible : true,
						className : "",
						closeModal : true
					}
				}
			}).then(function(result) {
				if(result){
					/**
					 * 발주 요청
					 */
					 
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					
					var codes = [];
					table_data.forEach(function(oData){
						codes.push(oData.FIXTURE_REQ_CODE);
					});

					$.ajax({
						url : "/yp/popup/fixture/fixture_req_purchase",
						type : "POST",
						cache : false,
						async : true,
						dataType : "json",
						data : {
							codes : JSON.stringify(codes)
						},
						success : function(data) {
							window.opener.document.getElementById("search_btn").click();
							window.close();
							window.opener.swalSuccessCB("저장이 완료 됐습니다.", function(){
								
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
							window.close();
							window.opener.swalDangerCB("저장 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
					
				}
			});
		});
		
		$(".purchase_finish_btn").on("click", function() {
			if(table_data.length < 1){
				swalWarningCB("구매완료 처리할 데이터가 없습니다.");
				return false;
			}
			
			swal({
				icon : "info",
				text : "구매를 완료 하시겠습니까?",
				closeOnClickOutside : false,
				closeOnEsc : false,
				buttons : {
					confirm : {
						text : "확인",
						value : true,
						visible : true,
						className : "",
						closeModal : true
					},
					cancel : {
						text : "취소",
						value : null,
						visible : true,
						className : "",
						closeModal : true
					}
				}
			}).then(function(result) {
				if(result){
					/**
					 * 구매완료
					 */
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					
					var codes = [];
					table_data.forEach(function(oData){
						codes.push(oData.FIXTURE_REQ_CODE);
					});
					
					$.ajax({
						url : "/yp/popup/fixture/fixture_req_purchase_finish",
						type : "POST",
						cache : false,
						async : true,
						dataType : "json",
						data : {
							codes : JSON.stringify(codes)
						},
						success : function(data) {
							window.opener.document.getElementById("search_btn").click();
							window.close();
							window.opener.swalSuccessCB("저장이 완료 됐습니다.", function(){
								
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
							window.close();
							window.opener.swalDangerCB("저장 실패하였습니다.\n관리자에게 문의해주세요.");
						}
					});
					
				}
			});
		});
		
		
	});
	
	/**
	 * Paging 조회
	 */ 
	function fnSearchData() {
		var form = $("#frm")[0],
			grid_data = '${grid_data}';
		
		var grid_data_element = document.createElement("input");
		grid_data_element.name = "gridData";
		grid_data_element.value = grid_data;
		grid_data_element.type = "hidden";
		
		form.appendChild(grid_data_element);
		
		form.submit();
	}
	
	/**
	 * Validation
	 */ 
	function fnValidation(data) {
		// REQ_AMOUNT Validation
		for(var i=0; i<data.length; i++){
			if(isEmpty(data[i].REQ_AMOUNT)){
				return false;				
			}
		}
		return true;
	}
	
</script>
</head>
<body>
	<div id="popup">
		<div class="pop_header">비품요청 상세</div>
		<div class="pop_content">
			<form id="frm" name="frm" method="post" accept-charset="UTF-8" action="/yp/popup/fixture/fixtureReqDtlPop">
				<!-- 20191023_khj for csrf -->
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="type" value="${req_data.type}" />
				<input type="hidden" name="target" value="${req_data.target}" />
				<input type="hidden" name="pageSize" value="15" />
				<input type="hidden" name="rangeSize" value="10" />
				<input type="hidden" name="page" value="${pagination.getCurPage()}" />
				<section>
					<div class="tbl_box">
 						<select name="search_type">
							<option value="fixture_type" <c:if test="${req_data.search_type eq 'fixture_type'}">selected</c:if>>비품유형</option>
						</select>
						<input type="text" name="search_text" size="20" value="${req_data.search_text}" />
						<a href="#" onclick="fnSearchData();"><img src="/resources/yp/images/ic_search.png"></a>
						<button class="btn btn_make" id="excel_btn" style="float:right;'">엑셀 다운로드</button>
						
					</div>
				</section>
				<div class="lst">
					<table id="fixture_req_table" cellspacing="0" cellpadding="0">
						<colgroup>
							<col />
							<col />
							<col />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th>제조사</th>
								<th>요청부서</th>
								<th>요청자</th>
								<th>비품명</th>
								<th>비품항목</th>
								<th>요청수량</th>
								<c:if test="${'MA' eq sessionScope.s_authogrp_code || 'SA' eq sessionScope.s_authogrp_code || 'FXA' eq sessionScope.s_authogrp_code}">
									<th>불출수량</th>
									<th>구매수량</th>
								</c:if>
							</tr>
						</thead>
						<tbody>
							<c:if test="${fn:length(list) > 0}">
							<c:forEach var="item" items="${list}">
								<tr>
									<td align="center">${item.manufacturer}</td>
									<td align="center">${item.req_dept_name}</td>
									<td align="center">${item.req_user_name}</td>
									<td align="center">${item.fixture_name}</td>
									<td align="center">${item.fixture_type}</td>
									<td align="center">${item.req_amount}</td>
									<c:if test="${'MA' eq sessionScope.s_authogrp_code || 'SA' eq sessionScope.s_authogrp_code || 'FXA' eq sessionScope.s_authogrp_code}">
										<td align="center">${item.dispense_req_amount}</td>
										<td align="center">${item.purchase_req_amount}</td>
									</c:if>
								</tr>
					        </c:forEach>
							</c:if>
							<c:if test="${fn:length(list) == 0}">
								<tr>
									<td align="center" colspan="8">조회된 내역이 없습니다</td>
								</tr>
							</c:if>						
						</tbody>
					</table>
				</div>
				</section>
			</form>
			
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
			<div class="btn_wrap">
				<!-- MA 메뉴관리자, SA 시스템관리자, FXA 비품관리자 만 불출완료 발주요청 가능 -->
				<c:if test="${'MA' eq sessionScope.s_authogrp_code || 'SA' eq sessionScope.s_authogrp_code || 'FXA' eq sessionScope.s_authogrp_code}">
					<c:if test="${is_availalbe_finish_purchase}">
						<!-- 구매완료 => 불출완료 -->
						<button class="btn btn_g purchase_finish_btn">불출완료</button>
					</c:if>
					<c:if test="${is_available_purchase_req}">
						<button class="btn btn_g purchase_req_btn">발주요청</button>
					</c:if>
				</c:if>
				<button class="btn" onclick="self.close();">닫기</button>
			</div>
		</div>
</body>
</html>