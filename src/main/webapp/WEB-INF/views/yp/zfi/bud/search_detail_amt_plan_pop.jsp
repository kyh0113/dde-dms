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
<title>예산금액 상세보기</title>
<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
<script type="text/javascript" src="/resources/icm/js/custom.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
<script type="text/javascript">
	$(document).ready(function(){
		
	});
	
	function fnExelDown(){
		//부모창 앵귤러 스코프 접근
		var opener_scope = window.opener.angular.element("#shds-uiGrid").scope();
		//선택된 로우 데이터 접근
		var selectedRows = opener_scope.gridApi.selection.getSelectedRows();
		
		$("input[name=I_GSBER]").val(selectedRows[0].GSBER);
		$("input[name=I_RORG]").val(selectedRows[0].RORG);
		$("input[name=I_BORG]").val(selectedRows[0].BORG);
		$("input[name=I_BACT]").val(selectedRows[0].BACT);
		$("input[name=I_SPMON]").val(selectedRows[0].SPMON);
		$("input[name=I_ACTIME]").val(selectedRows[0].ACTIME);
		
		$("#frm").attr("action", "/yp/popup/zfi/bud/retrieveDetailAmtPlan");
		$("#frm").submit();
		$('.wrap-excelloading').removeClass('display-none');
		setTimeout(function() {
			$('.wrap-excelloading').addClass('display-none');
		},5000); //5초
	}
</script>
</head>
<body>
	
	<div id="popup">
		<div class="pop_header">예산금액 상세보기</div>
		<div class="pop_content">
			<form id="frm" name="frm" method="post" accept-charset="UTF-8">
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="excel_flag" value="1"/>
				<input type="hidden" name="I_GSBER" value="">
				<input type="hidden" name="I_RORG" value="">
				<input type="hidden" name="I_BORG" value="">
				<input type="hidden" name="I_BACT" value="">
				<input type="hidden" name="I_SPMON" value="">
				<input type="hidden" name="I_ACTIME" value="">
				
				<div class="btn_wrap">
					<input type="button" class="btn btn_make" id="excel_btn" onclick="fnExelDown();" value="엑셀 다운로드"></input>
				</div>
				
				<section>
				<div class="lst">
					<table cellspacing="0" cellpadding="0" class="datatable" style="width:2000px;">
						<caption style="padding-top:0px;"></caption>
						<thead>
							<tr>
								<th style="width:70px;">집행부서</th>
								<th>집행부서명</th>
								<th style="width:70px;">년월</th>
								<th style="width:70px;">예산조직</th>
								<th>예산조직명</th>
								<th style="width:70px;">예산계정</th>
								<th>예산계정명</th>
								<th>값 유형</th>
								<th>금액</th>
								<th style="width:160px;">내역</th>
								<th>전용기간</th>
								<th>전용 사업영역</th>
								<th>전용 예산조직</th>
								<th>전용 예산조직명</th>
								<th>전용 예산계정</th>
								<th>전용 예산계정명</th>
								<th style="width:70px;">승인상태</th>
								<th style="width:70px;">생성자명</th>
								<th style="width:70px;">생성일</th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${fn:length(list) > 0}">
						<c:forEach var="list" items="${list}" varStatus="i">
							<tr>
								<td>${list.RORG}</td>
								<td>${list.RORGTXT}</td>
								<td>${fn:substring(list.SPMON,0,4)}.${fn:substring(list.SPMON,4,6)}</td>
								<td>${list.BORG}</td>
								<td>${list.BORGTXT}</td>
								<td>${list.BACT}</td>
								<td>${list.BACTTXT}</td>
								<td>${list.VALTPTXT}</td>
								<td style="text-align:right;"><fmt:formatNumber value="${list.VALUE}" pattern="#,###" /></td>
								<td>${list.DOCUM}</td>
								<td>
									<c:if test="${list.C_SPMON ne '000000'}">${list.C_SPMON}</c:if>
								</td>
								<td>${list.C_GSBER}</td>
								<td>${list.C_BORG}</td>
								<td>${list.C_BORGTXT}</td>
								<td>${list.C_BACT}</td>
								<td>${list.C_BACTTXT}</td>
								<td>${list.STATUTXT}</td>
								<td>${list.ERNAM}</td>
								<td>${fn:substring(list.ERDAT,0,4)}.${fn:substring(list.ERDAT,4,6)}.${fn:substring(list.ERDAT,6,8)}</td>
							</tr>
						</c:forEach>
						</c:if>
						<c:if test="${fn:length(list) == 0}">
							<tr><td align="center" colspan="19">조회된 내역이 없습니다</td></tr>
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