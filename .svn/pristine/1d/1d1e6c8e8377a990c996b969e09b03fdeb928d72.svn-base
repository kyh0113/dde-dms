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
<title>계량 소계 상세</title>
<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
<script type="text/javascript" src="/resources/icm/js/custom.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
<style>
.datatable td {text-align:left;}
</style>
<script type="text/javascript">

</script>
</head>
<body>
	<div id="popup">
		<div class="pop_header">계량 소계 상세</div>
		<div class="pop_content">
			<section>
				<div class="lst">
					<table class="datatable" style="width:100%;">
						<c:set var="sum_w" value="0"/>
						<c:set var="sum_w_code" value="0"/>
						<caption style="padding-top:0px;"></caption>
						<thead>
							<tr>
								<th>번호</th>
								<th>계량일자</th>
								<th>차량번호</th>
								<th>품목</th>
<!--  								<th>상세품목</th> -->
<!-- 								<th>구분</th> -->
<!-- 								<th>폐기물</th> -->
								<th>계량</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${fn:length(list) > 0}">
								<c:forEach var="clist" items="${list}" varStatus="i">
									<tr>
										<td>${i.index + 1}</td>
										<td>${clist.DATE1}</td>
										<td>${clist.TRUCK_NO}</td>
										<td>${clist.P_NAME}</td>
<%--										<td>${clist.P_DETAIL_NAME}</td> --%>
<%-- 										<td>${clist.TYPE}</td> --%>
<%-- 										<td>${clist.WASTE_TYPE}</td> --%>
										<td style="text-align:right;">
											<fmt:formatNumber value="${clist.FINAL_WEIGHT}" pattern="#,###" />
											<c:set var="sum_w" value="${sum_w + clist.FINAL_WEIGHT}"/>
											<c:set var="sum_w_code" value="${sum_w_code + clist.FINAL_WEIGHT}"/>
										</td>
									</tr>
									<c:set var="nextcode" value="${list[i.index+1].CALC_CODE}"/>
									<c:if test="${clist.CALC_CODE ne nextcode}">
										<tr style="background: #d9ed8a;">
											<td colspan="5" style="text-align:center;">소계</td>
											<td style="text-align:right;">
											<fmt:formatNumber value="${sum_w_code}" pattern="#,###" />
										</td>
										</tr>
										<c:set var="sum_w_code" value="0"/>
									</c:if>
								</c:forEach>
								<tr style="background: #62db66;">
									<td colspan="4" style="text-align:center;">합계</td>
									<td style="text-align:right;"><fmt:formatNumber value="${sum_w}" pattern="#,###" /></td>
								</tr>
							</c:if>
							<c:if test="${fn:length(list) == 0}">
								<tr><td align="center" colspan="7">조회된 내역이 없습니다</td></tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</section>
			<div class="btn_wrap">
				<button class="btn" onclick="self.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>