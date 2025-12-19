<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<sec:csrfMetaTags />
<title>WBS 검색</title>
<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
<script type="text/javascript" src="/resources/icm/js/custom.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
<script type="text/javascript">
	$(document).ready(function(){
		$(".fn_paging").on("click", function() {
			$("input[name=page]").val($(this).attr("page"));
			fnSearchData();
		});
	});
	
	function fnSearchData(){
		if($("input[name=search_text]").val().length >= 2){
			$("#frm").submit();	
		}else{
			swalWarning("검색어는 2자 이상 입력하세요.");
		}
	}
	
	function fnSendData(i){
		$("input[name=WBS_CODE"+"${req_data.num}"+"]", opener.document).val($("input[name=POSID]:eq("+i+")").val());		//WBS코드
		self.close();
	}
</script>
</head>
<body>
	
	<div id="popup">
		<div class="pop_header">WBS 검색 ${req_data.num}</div>
		<div class="pop_content">
			<form id="frm" name="frm" method="post" accept-charset="UTF-8">
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="pageSize" value="15" />
				<input type="hidden" name="rangeSize" value="10" />
				<input type="hidden" name="page" value="${pagination.getCurPage()}" />
				<input type="hidden" name="num" value="${req_data.num}" />
				<section>
	               <div class="tbl_box">
	                    <select name="search_type">
							<option value="I_PSPNR">WBS코드</option>
							<option value="I_POST1" selected>WBS코드명</option>
						</select>
	                    <input type="text" name="search_text" size="20" value="${req_data.search_text}"/>
	                    <a href="#" id="search_btn" onclick="fnSearchData();"><img src="/resources/yp/images/ic_search.png"></a>
	                </div>
	            </section>
				
				<section>
				<div class="lst">
					<table cellspacing="0" cellpadding="0">
						<caption style="padding-top:0px;"></caption>
						<thead>
							<tr>
								<th>번호</th>
								<th>코드</th>
								<th>설명</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${fn:length(list) > 0}">
							<c:forEach var="list" items="${list}" varStatus="i">
								<tr onclick="fnSendData(${i.index});" style="cursor:pointer;">
									<td>${(pagination.curPage-1) * pagination.pageSize + (i.index+1)}</td>
									<td>${list.POSID}<input type="hidden" name="POSID" value="${list.POSID}"></td>
									<td>${list.POST1}<input type="hidden" name="POST1" value="${list.POST1}"></td>
								</tr>
							</c:forEach>
							</c:if>
							<c:if test="${fn:length(list) == 0}">
								<tr><td align="center" colspan="6">조회된 내역이 없습니다</td></tr>
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
				<button class="btn" onclick="self.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>