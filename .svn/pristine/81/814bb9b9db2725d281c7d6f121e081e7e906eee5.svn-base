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
<title>비품 요청</title>
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
		
		$(".save_btn").on("click", function() {
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			var object = {};
			
			/**
			 * 넘겨 받은 Grid Data와 입력한 Req Amount Data를 합친다
			 */
			var $req_amount_inputs = $("input[name=req_amount]"),
				req_amount_input_length = $req_amount_inputs.length;
			
			for(var i=0; i<req_amount_input_length; i++){
				table_data[i].REQ_AMOUNT = $req_amount_inputs[i].value;
			}

			/**
			 * Validation 처리
			 */
			if (!fnValidation(table_data)){
				swalWarning("요청 수량을 입력해주세요.");
				return false;
			}
			
			$.ajax({
				url : "/yp/fixture/fixture_req_create",
				type : "POST",
				cache : false,
				async : true,
				dataType : "json",
				data : {
					table_data : JSON.stringify(table_data)
				},
				success : function(data) {
					window.close();
					window.opener.document.getElementById('search_btn').click();
					window.opener.swalSuccessCB("저장이 완료 됐습니다.");
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
		});
		
		$("input[name=req_amount]").change(function(oEvent){
			var index = $("input[name=req_amount]").index(this);
			
			//REQ_AMOUNT 데이터 추가
			if(isEmpty(table_data[index].REQ_AMOUNT)){
				table_data[index].REQ_AMOUNT = $(this)								
			}
		});
	
	});
	
	/**
	 * Paging 조회
	 */ 
	function fnSearchData() {
		var form = $("#frm")[0];
		var grid_data = '${grid_data}';
		
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
		<div class="pop_header">비품요청</div>
		<div class="pop_content">
			<form id="frm" name="frm" method="post" accept-charset="UTF-8">
				<!-- 20191023_khj for csrf -->
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="type" value="${req_data.type}" />
				<input type="hidden" name="target" value="${req_data.target}" />
				<input type="hidden" name="pageSize" value="15" />
				<input type="hidden" name="rangeSize" value="10" />
				<input type="hidden" name="page" value="${pagination.getCurPage()}" />
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
								<th>비품명</th>
								<th>비품항목</th>
								<th>재고수량</th>
								<th>이용가능 재고수량</th>
								<th>요청수량</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${fn:length(list) > 0}">
							<c:forEach var="item" items="${list}">
								<tr>
									<td name="fixture_name" align="center">${item.FIXTURE_NAME}</td>
									<td align="center">${item.FIXTURE_TYPE}</td>
									<td align="center">${item.STOCK_AMOUNT}</td>
									<td align="center">${item.AVAILABLE_STOCK_AMOUNT}</td>
									<td><input name="req_amount" placeholder="수량입력" align="center"/></td>
								</tr>
					        </c:forEach>
							</c:if>
							<c:if test="${fn:length(list) == 0}">
								<tr>
									<td align="center" colspan="6">조회된 내역이 없습니다</td>
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
				<button class="btn close_btn" onclick="self.close();">닫기</button>
				<button type="button" class="btn_g save_btn">저장</button>
			</div>
		</div>
</body>
</html>