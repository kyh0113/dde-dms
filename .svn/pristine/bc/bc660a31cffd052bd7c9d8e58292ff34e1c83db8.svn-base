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
<title>SAP 오더 검색</title>
<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/resources/icm/js/custom.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
<script type="text/javascript">
	$(document).ready(function(){
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
	function fnSendData(i){
		var target = Number("${req_data.target}");
		var target_gubun = Number("${req_data.target_gubun}");
		var target_gubun2 = "${req_data.target_gubun2}";
		if(target_gubun === 4){
			// 표시
			$(".daily_work_content .data-base .order_number.rows-no-" + target, opener.document).val( $("input[name=AUFNR]:eq("+i+")").val() );
			$(".daily_work_content .data-base .cost_code.rows-no-" + target, opener.document).val( $("input[name=KOSTL]:eq("+i+")").val() );
			$(".daily_work_content .data-base .cost_name.rows-no-" + target, opener.document).val( $("input[name=KTEXT]:eq("+i+")").val() );
			// 데이터
			$(".daily_work_content .data-base .rows-checkbox.rows-no-" + target, opener.document).attr("ORDER_NUMBER", $("input[name=AUFNR]:eq("+i+")").val().trim());
			$(".daily_work_content .data-base .rows-checkbox.rows-no-" + target, opener.document).attr("COST_CODE", $("input[name=KOSTL]:eq("+i+")").val().trim());
			$(".daily_work_content .data-base .rows-checkbox.rows-no-" + target, opener.document).attr("COST_NAME", $("input[name=KTEXT]:eq("+i+")").val().trim());
		}else if(target_gubun === 5){
			// 표시
			$(".daily_rpt2_content .data-base .order_number.rows-no-" + target, opener.document).val( $("input[name=AUFNR]:eq("+i+")").val() );
			$(".daily_rpt2_content .data-base .cost_code.rows-no-" + target, opener.document).val( $("input[name=KOSTL]:eq("+i+")").val() );
			$(".daily_rpt2_content .data-base .cost_name.rows-no-" + target, opener.document).val( $("input[name=KTEXT]:eq("+i+")").val() );
			// 데이터
			$(".daily_rpt2_content .data-base .rows-checkbox.rows-no-" + target, opener.document).attr("ORDER_NUMBER", $("input[name=AUFNR]:eq("+i+")").val().trim());
			$(".daily_rpt2_content .data-base .rows-checkbox.rows-no-" + target, opener.document).attr("COST_CODE", $("input[name=KOSTL]:eq("+i+")").val().trim());
			$(".daily_rpt2_content .data-base .rows-checkbox.rows-no-" + target, opener.document).attr("COST_NAME", $("input[name=KTEXT]:eq("+i+")").val().trim());
			<%-- 2022-01-04 jamerl - 돌발작업 로직 추가 --%>
			if(target_gubun2 === "unexpected") {
				$(".daily_rpt2_content .data-base .work_contents.rows-no-" + target, opener.document).val( "[돌발작업]" + $("input[name=AUFTEXT]:eq("+i+")").val() );
				$(".daily_rpt2_content .data-base .rows-checkbox.rows-no-" + target, opener.document).attr("WORK_CONTENTS", "[돌발작업]" + $("input[name=AUFTEXT]:eq("+i+")").val().trim());
			} else {
				$(".daily_rpt2_content .data-base .work_contents.rows-no-" + target, opener.document).val( $("input[name=AUFTEXT]:eq("+i+")").val() );
				$(".daily_rpt2_content .data-base .rows-checkbox.rows-no-" + target, opener.document).attr("WORK_CONTENTS", $("input[name=AUFTEXT]:eq("+i+")").val().trim());
			}
		} else {
			// 표시
			$(".data-base .order_number.rows-no-" + target, opener.document).val( $("input[name=AUFNR]:eq("+i+")").val() );
			$(".data-base .cost_code.rows-no-" + target, opener.document).val( $("input[name=KOSTL]:eq("+i+")").val() );
			$(".data-base .cost_name.rows-no-" + target, opener.document).val( $("input[name=KTEXT]:eq("+i+")").val() );
			// 데이터
			$(".data-base .rows-checkbox.rows-no-" + target, opener.document).attr("ORDER_NUMBER", $("input[name=AUFNR]:eq("+i+")").val().trim());
			$(".data-base .rows-checkbox.rows-no-" + target, opener.document).attr("COST_CODE", $("input[name=KOSTL]:eq("+i+")").val().trim());
			$(".data-base .rows-checkbox.rows-no-" + target, opener.document).attr("COST_NAME", $("input[name=KTEXT]:eq("+i+")").val().trim());
			<%-- 2022-01-04 jamerl - 돌발작업 로직 추가 --%>
			if(target_gubun2 === "unexpected") {
				$(".data-base .work_contents.rows-no-" + target, opener.document).val( "[돌발작업]" + $("input[name=AUFTEXT]:eq("+i+")").val() );
				$(".data-base .rows-checkbox.rows-no-" + target, opener.document).attr("WORK_CONTENTS", "[돌발작업]" + $("input[name=AUFTEXT]:eq("+i+")").val().trim());
			} else {
				$(".data-base .work_contents.rows-no-" + target, opener.document).val( $("input[name=AUFTEXT]:eq("+i+")").val() );
				$(".data-base .rows-checkbox.rows-no-" + target, opener.document).attr("WORK_CONTENTS", $("input[name=AUFTEXT]:eq("+i+")").val().trim());
			}
		}
		
		self.close();
	}
</script>
</head>
<body>
	
	<div id="popup">
		<div class="pop_header">SAP 오더 목록</div>
		<div class="pop_content">
			<form id="frm" name="frm" method="post" accept-charset="UTF-8">
				<!-- 20191023_khj for csrf -->
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="target" value="${req_data.target}" />
				<input type="hidden" name="target_gubun" value="${req_data.target_gubun}" />
				<input type="hidden" name="target_gubun2" value="${req_data.target_gubun2}" />
				<input type="hidden" name="pageSize" value="15" />
				<input type="hidden" name="rangeSize" value="10" />
				<input type="hidden" name="page" value="${pagination.getCurPage()}" />
				<section>
				<div class="tbl_box">
					<select name="search_type">
						<option value="2" <c:if test="${req_data.search_type eq 2}">selected="selected"</c:if>>작업장명</option>
						<option value="1" <c:if test="${req_data.search_type eq 1}">selected="selected"</c:if>>오더번호</option>
					</select>
					<input type="text" name="search_text" size="20" value="${req_data.search_text}" style="width: calc(100% - 129px);"/>
					<a href="#" onclick="fnSearchData();"><img src="/resources/yp/images/ic_search.png"></a>
				</div>
				</section>
			</form>
			<section>
			<div class="lst">
				<table cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="55px;"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="12%"/>
						<col width="10%"/>
						<col width="12%"/>
						<col />
					</colgroup>
					<thead>
						<tr>
							<th>순번</th>
							<th>오더번호</th>
							<th>작업장코드</th>
							<th>작업장명</th>
							<th>코스트센터</th>
							<th>코스트센터명</th>
							<th>오더내역</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${fn:length(list) > 0}">
							<c:forEach var="list" items="${list}" varStatus="i">
								<tr onclick="fnSendData(${i.index});" style="cursor:pointer;">
									<td>
										${(pagination.curPage-1) * pagination.pageSize + (i.index+1)}
									</td>
									<td>
										${list.AUFNR}<input type="hidden" name="AUFNR" value="${list.AUFNR}">
									</td>
									<td>
										${list.VAPLZ}<input type="hidden" name="VAPLZ" value="${list.VAPLZ}">
									</td>
									<td>
										${list.VATXT}<input type="hidden" name="VATXT" value="${list.VATXT}">
									</td>
									<td>
										${list.KOSTL}<input type="hidden" name="KOSTL" value="${list.KOSTL}">
									</td>
									<td>
										${list.KTEXT}<input type="hidden" name="KTEXT" value="${list.KTEXT}">
									</td>
									<td style="text-align: left;">
										${list.AUFTEXT}<input type="hidden" name="AUFTEXT" value="${list.AUFTEXT}">
									</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${fn:length(list) == 0}">
							<tr>
								<td align="center" colspan="7">조회된 내역이 없습니다</td>
							</tr>
						</c:if>
					</tbody>
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
	</div>
</body>
</html>