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
<title>약정 개별항목 조회</title>
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
	
	function fnExelDown(){
		$("input[name=excel_flag]").val("1");
		//20191023_khj for csrf
		var csrf_element = document.createElement("input");
		csrf_element.name = "_csrf";
		csrf_element.value = "${_csrf.token}";
		csrf_element.type = "hidden";
		//20191023_khj for csrf
		var xlsForm = document.createElement("form");

		xlsForm.name = "sndFrm";
		xlsForm.method = "post";
		xlsForm.action = "/yp/zfi/bud/xls/zfi_bud_wbs_read_detail_y";

		document.body.appendChild(xlsForm);

		xlsForm.appendChild(csrf_element);

		var pr = {
			POSID   : $('input[name=POSID]').val(),
			GUBUN   : $('input[name=GUBUN]').val(),
			YYYYMM  : $('input[name=YYYYMM]').val(),
			empCode : "${req_data.emp_code}", 
		};

		$.each(pr, function(k, v) {
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
	}

</script>
</head>
<body>
	
	<div id="popup">
		<div class="pop_header">약정 개별항목 조회</div>
		<div class="pop_content">
			<form id="frm" name="frm" method="post" accept-charset="UTF-8">
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="pageSize" value="15" />
				<input type="hidden" name="rangeSize" value="10" />
				<input type="hidden" name="page" value="${pagination.getCurPage()}" />
				<input type="hidden" name="excel_flag" value="1"/>
				<input type="hidden" name="POSID" value="${req_data.POSID}">
				<input type="hidden" name="GUBUN" value="${req_data.GUBUN}">
				<input type="hidden" name="YYYYMM" value="${req_data.YYYYMM}">
				
				<div class="btn_wrap">
					<input type="button" class="btn btn_make" id="excel_btn" onclick="fnExelDown();" value="엑셀 다운로드"></input>
				</div>
				
				<section>
				<div class="lst">
					<table cellspacing="0" cellpadding="0" style="width:1000px;">
						<caption style="padding-top:0px;"></caption>
						<thead>
							<tr>
								<th>참조전표범주</th>
								<th>차변일자</th>
								<th>오브젝트<br>유형</th>
								<th style="width:130px;">WBS 코드</th>
								<th>원가 요소</th>
								<th>금액<br>(CO 톻화)</th>
								<th>총 수량</th>
								<th>단위</th>
								<th>자재 번호</th>
								<th>자재내역</th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${fn:length(listy) > 0}">
							<c:set var="sum_yw" value="0"/>
							<c:set var="sum_ym" value="0"/>
							<c:forEach var="list" items="${listy}" varStatus="i">
								<tr>
									<td>${list.REFBTXT}</td>
									<td>${list.BUDAT}</td>
									<td>${list.OBART}</td>
									<td>${list.OBJID}</td>
									<td>${list.SAKTO}</td>
									<td style="text-align:right;"><fmt:formatNumber value="${list.WKGBTR}" pattern="#,###" /><c:set var="sum_yw" value="${sum_yw + list.WKGBTR}"/></td>
									<td style="text-align:right;"><fmt:formatNumber value="${list.MEGBTR}" pattern="#,###" /><c:set var="sum_ym" value="${sum_ym + list.MEGBTR}"/></td>
									<td>${list.MEINH}</td>
									<td>${list.MATNR}</td>
									<td>${list.SGTXT}</td>
								</tr>
							</c:forEach>
							<tr id="sum">
								<td colspan="5" style="text-align:center;">합 계</td>
								<td style="text-align:right;"><fmt:formatNumber value="${sum_yw}" pattern="#,###" /></td>
								<td style="text-align:right;"><fmt:formatNumber value="${sum_ym}" pattern="#,###" /></td>
								<td colspan="3"></td>
							</tr>
						</c:if>
						<c:if test="${fn:length(listy) == 0}">
							<tr><td align="center" colspan="8">조회된 내역이 없습니다</td></tr>
						</c:if>
						</tbody>
					</table>
				</div>
				</section>
			</form>
			<div class="btn_wrap">
				<button class="btn" onclick="self.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>