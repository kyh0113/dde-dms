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
<title>시간외근무 확정처리 결과</title>
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
		if ($("input[name=search_text]").val().length >= 2) {
			var form = $("#frm")[0];
			form.submit();
		} else {
			alert("검색어는 2자 이상 입력하세요.");
		}
	}
	function fnSendData(i) {
		var type = "${req_data.type}";
		var target = Number("${req_data.target}");
		opener.scope.gridOptions.data[target].AUFNR = $("input[name=AUFNR]:eq(" + i + ")").val(); //설비오더
		opener.scope.gridOptions.data[target].KOSTL = $("input[name=KOSTL]:eq(" + i + ")").val(); //코스트센터
		opener.scope.gridOptions.data[target].LTEXT = $("input[name=LTEXT]:eq(" + i + ")").val(); //코스트센터명
		opener.scope.gridApi.grid.refresh();

		self.close();
	}
</script>
</head>
<body>
	<div id="popup">
		<div class="pop_header">시간외근무 확정처리 결과</div>
		<div class="pop_content">
			<section>
			<div class="lst">
				<table cellspacing="0" cellpadding="0">
					<colgroup>
						<col />
						<col />
						<col />
						<col />
						<col />
						<col />
						<col />
					</colgroup>
					<tr>
						<th>사번</th>
						<th>성명</th>
						<th>부서명</th>
						<th>근무일자</th>
						<th>작업사유</th>
						<th>처리결과</th>
						<th>메시지</th>
					</tr>
					<c:if test="${fn:length(list) > 0}">
						<c:forEach var="list" items="${list}" varStatus="i">
							<tr>
								<td>${list.PERNR}</td>
								<td>${list.ENAME}</td>
								<td>${list.ORGEH_T}</td>
								<td>
									<fmt:parseDate var="ZREDT" pattern="yyyyMMdd" value="${list.ZREDT1}" />
									<fmt:formatDate value="${ZREDT}" pattern="yyyy/MM/dd" />
								</td>
								<td>${list.ZOPERRN}</td>
								<td>
									<c:if test="${list.ERROR eq 'N'}">실패</c:if>
									<c:if test="${list.ERROR eq 'Y'}">성공</c:if>
								</td>
								<td>${list.MESSAGE}</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${fn:length(list) == 0}">
						<tr>
							<td align="center" colspan="7">조회된 내역이 없습니다</td>
						</tr>
					</c:if>
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
			<div class="btn_wrap">
				<button class="btn" onclick="self.close();">닫기</button>
			</div>
		</div>
</body>
</html>