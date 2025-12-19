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
<title></title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript" src="http://malsup.github.com/jquery.form.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
<script type="text/javascript">
	$(document).ready(function() {
		
	});
	
	function closePopup() {
        if (document.getElementById("check").value) {
        	opener.parent.setCookie("ot_notice", "N", 1);
            self.close();
        }
    }

</script>
</head>
<body>
	<div id="popup">
		<div class="pop_header">시간외근무 입력 안내</div>
		<div class="pop_content">
			
			<div style="margin-bottom: 2px; margin-top: 0px;">
				<span style="font-size: 15px;">
					1. 입력시 주의 사항
					<br> ※ 시간외근무(연장근로)는 주 12시간 이내 시행 가능
					<br> ※ 시간외근무는 1일 8시간, 1주 소정근로 40시간 초과한 시간을 의미함
					<br> ※ 1주의 기산점은 주휴일이 끝난 다음날부터 시작한다 
					<br> ※ 근무일지 계획란에 "재작성"으로 나올 경우 "계획 재수립" 해야 함 
					<br> ※ 근무일지 시행란에 "위반"으로 나오지 않게 법기준을 넘겨 근무하지 말 것
					<br> ※ 근무조 재편성으로 주휴일이 변경 되어 근무기간이 늘어날 시 에는 
					<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;부여한 임시휴무를 쉰 후 1주의 기산점을 재설정한다.
					<br> ※ 상갑반 주휴일 변경시 변경후 첫번째 주휴일를 쉰 후 1주의 기산점을 재설정한다.
					<br> ※ 과로근무방지를 위해 병반-갑반 연장을 제한함
				</span>
			</div>
			<div class="lst">
				<div style="margin-bottom: 2px; margin-top: 20px;">
					<span style="font-size: 15px;">2. 입력방법</span>
				</div>
				<table cellspacing="0" cellpadding="0">
					<tr>
						<th>구분</th>
						<th>원근무</th>
						<th>작업구분</th>
						<th>원근무자</th>
						<th>작업세부구분</th>
						<th>작업사유</th>
					</tr>
					<tr>
						<td rowspan="3">원근무시</td>
						<td>휴무</td>
						<td>특별근무</td>
						<td>-</td>
						<td>기타</td>
						<td>실제사유입력</td>
					</tr>
					<tr>
						<td>주휴</td>
						<td>특별근무</td>
						<td>-</td>
						<td>기타</td>
						<td>실제사유입력</td>
					</tr>
					<tr>
						<td>공휴</td>
						<td>특별근무</td>
						<td>-</td>
						<td>공휴</td>
						<td>실제사유입력</td>
					</tr>
					<tr>
						<td rowspan="7">대체근무시</td>
						<td>갑반</td>
						<td rowspan="7">대체근무</td>
						<td rowspan="7">대근자선택</td>
						<td rowspan="7">사유선택</td>
						<td rowspan="7">대체근무</td>
					</tr>
					<tr>
						<td>을반</td>
					</tr>
					<tr>
						<td>병반</td>
					</tr>
					<tr>
						<td>석포 COAL</td>
					</tr>
					<tr>
						<td>비연봉제상갑조</td>
					</tr>
					<tr>
						<td>휴무</td>
					</tr>
					<tr>
						<td>주휴</td>
					</tr>
					<tr>
						<td rowspan="8">연장근무시</td>
						<td>갑반</td>
						<td rowspan="7">연장근무</td>
						<td rowspan="7">-</td>
						<td rowspan="7">사유선택</td>
						<td rowspan="7">실제사유입력</td>
					</tr>
					<tr>
						<td>을반</td>
					</tr>
					<tr>
						<td>병반</td>
					</tr>
					<tr>
						<td>석포 COAL</td>
					</tr>
					<tr>
						<td>비연봉제상갑조</td>
					</tr>
					<tr>
						<td>휴무</td>
					</tr>
					<tr>
						<td>주휴</td>
					</tr>
					<tr>
						<td bgcolor="#bbdefb">공휴</td>
						<td bgcolor="#bbdefb">연장근무</td>
						<td bgcolor="#bbdefb">-</td>
						<td bgcolor="#bbdefb">사유선택</td>
						<td bgcolor="#bbdefb">실제사유입력</td>
					</tr>
				</table>
			</div>
			<div style="margin-bottom: 2px; margin-top: 20px;">
				<span style="font-size: 15px;">
					3. 확인사항
					<br> ※ 반드시 근무일지상 시간외근무 12시간, 주52시간 초과유무 확인후 입력 요망(초과불가)
					<br> ※ 근무일 D+3일 이후에는 신청 불가(정상외 신청 및 근무조 변경 등은 사전에 신청)
					<br> ※ 웝포털에서 대신 신청시 당사자 사번 및 성명 변경 확인 
					<br> ※ 디지털시스템에서 시간외 근무 입력 후 실근무시간과 입력된 근무시간 확인
				</span>
			</div>
			<div class="btn_wrap">
				<input type="checkbox" id="check" onclick="closePopup();">오늘 그만보기&nbsp;&nbsp;
				<button class="btn" onclick="self.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>