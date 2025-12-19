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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<sec:csrfMetaTags />
<title>자재 검색</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="http://malsup.github.com/jquery.form.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
<script type="text/javascript">
	$(document).ready(function() {
		$(".fn_paging").on("click", function() {
			$("input[name=page]").val($(this).attr("page"));
			fnSearchData();
		});
		
		$('input').on('keydown', function(e) {
			if (e.which == 13) {
				e.preventDefault();
				fnSearchData();
			}
		});
	});
	
	// 조회
	function fnSearchData() {
		var type = "${req_data.type}";
		
		if ($("input[name=search_text]").val().length >= 2) {
			var form = $("#frm")[0];
			console.log(type);
			if(type == "SO")
				form.action = "/yp/popup/zmm/aw/retrieveMATNRbySAP";
				form.submit();
		} else {
			alert("검색어는 2자 이상 입력하세요.");
		}
	}
	
	function fnSendData(i){
		var type = "${req_data.type}";
		var target = "${req_data.target}";
		if(target == "" || target == "undefined"){
			target = -1;
		}else{
			target = Number(target);
		}
		console.log(type+"/"+target);
		if(type == "srch"){
			if(target >= 0){
				/*
				*	YPDIGITAL-5
				*	4. 계약마스터 등록화면에서 "상세품목코드" 값을 불러오질 못하고 있음. (운영도 같음)
				*	P_DETAIL_CODE_SAP 맵핑값을 P_DETAIL_CODE 로 수정
				*/  
				//opener.scope.gridOptions.data[target].P_DETAIL_CODE_SAP = $("input[name=MATNR]:eq("+i+")").val();
				opener.scope.gridOptions.data[target].P_DETAIL_CODE = $("input[name=MATNR]:eq("+i+")").val();
				opener.scope.gridOptions.data[target].P_DETAIL_NAME = $("input[name=MAKTX]:eq("+i+")").val();
				opener.scope.gridOptions.data[target].SAP_CODE = $("input[name=SAP_CODE]:eq("+i+")").val();
				opener.scope.gridOptions.data[target].SAP_NAME = $("input[name=SAP_NAME]:eq("+i+")").val();
				
				//CAS 품목 조회
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({
					url : "/yp/zmm/aw/zmm_weight_p_name_cas",
					type : "POST",
					cache : false,
					async : false,
					dataType : "json",
					data : {
						P_DETAIL_CODE : $("input[name=MATNR]:eq("+i+")").val()
						/*,P_DETAIL_NAME : $("input[name=MAKTX]:eq("+i+")").val()*/
					},
					success : function(data) {
						opener.scope.gridOptions.data[target].P_NAME = data.PRODUCT_NAME;
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
						console.log("CAS 품목조회 실패!");
					}
				});
			}else{
				$("input[name=srch_p_detail_code]", opener.document).val($("input[name=MATNR]:eq("+i+")").val());
				$("input[name=srch_p_detail_name]", opener.document).val($("input[name=MAKTX]:eq("+i+")").val());
				$("input[name=sap_code]", opener.document).val($("input[name=sap_code]:eq("+i+")").val());
				$("input[name=sap_name]", opener.document).val($("input[name=sap_name]:eq("+i+")").val());
			}
		}else if(type == "SO"){
			console.log("1");
			$("input[name=I_ITM_MATERIAL]", opener.document).val($("input[name=MATNR]:eq("+i+")").val());
			$(".I_ITM_MATERIAL", opener.document).text($("input[name=MAKTX]:eq("+i+")").val());
			self.close();
		}else{
			//alert("1234");
			$("input[name=p_detail_code]", opener.document).val($("input[name=MATNR]:eq("+i+")").val());
			$("input[name=p_detail_name]", opener.document).val($("input[name=MAKTX]:eq("+i+")").val());
			$("input[name=sap_code]", opener.document).val($("input[name=sap_code]:eq("+i+")").val());
			$("input[name=sap_name]", opener.document).val($("input[name=sap_name]:eq("+i+")").val());
		}
		
		opener.scope.gridApi.grid.refresh();
		self.close();
	}
	
</script>
</head>
<body>
	<div id="popup">
		<div class="pop_header">자재 검색</div>
		<div class="pop_content">
			<form id="frm" name="frm" method="post" accept-charset="UTF-8">
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
						<option value="I_MAKTX" <c:if test="${req_data.search_type eq 'I_MAKTX'}">selected</c:if>>설명</option>
						<option value="I_MATNR" <c:if test="${req_data.search_type eq 'I_MATNR'}">selected</c:if>>코드</option>
					</select>
					<input type="text" name="search_text" size="20" value="${req_data.search_text}" />
					<a href="#" onclick="fnSearchData();"><img src="/resources/yp/images/ic_search.png"></a>
				</div>
				</section>
				<section>
				<div class="lst">
					<table cellspacing="0" cellpadding="0">
						<colgroup>
							<col />
							<col />
							<col />
							<col />
							<col />
						</colgroup>
						<tr>
							<th>번호</th>
							<th>코드</th>
							<th>자재명</th>
							<th>SAP코드</th>
							<th>SAP명</th>
						</tr>
						<c:if test="${fn:length(list) > 0}">
							<c:forEach var="list" items="${list}" varStatus="i">
								<tr onclick="fnSendData(${i.index});" style="cursor: pointer;">
									<!-- <tr style="cursor:pointer;"> -->
									<td>${(pagination.curPage-1) * pagination.pageSize + (i.index+1)}</td>
									<td>
										${list.MATNR}
										<input type="hidden" name="MATNR" value="${list.MATNR}">
									</td>
									<td style="text-align: left;">${list.MAKTX}<input type="hidden" name="MAKTX" value="${list.MAKTX}">
									</td>
									<td>
										${list.SAP_CODE}
										<input type="hidden" name="SAP_CODE" value="${list.SAP_CODE}">
									</td>
									<td style="text-align: left;">${list.SAP_NAME}<input type="hidden" name="SAP_NAME" value="${list.SAP_NAME}">
									</td>
								</tr>
							</c:forEach>
						</c:if>

						<c:if test="${fn:length(list) == 0}">
							<tr>
								<td align="center" colspan="5">조회된 내역이 없습니다</td>
							</tr>
						</c:if>
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
				<button class="btn" onclick="self.close();">닫기</button>
			</div>
		</div>
</body>
</html>