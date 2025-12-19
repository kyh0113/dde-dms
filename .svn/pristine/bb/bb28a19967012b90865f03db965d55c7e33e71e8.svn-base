<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
if (request.getProtocol().equals("HTTP/1.1")) {
	response.setHeader("Cache-Control", "no-cache");
}%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="/resources/yp/wp/printThis.js"></script>
<title>지출품의서</title>
<script type="text/javascript">
$(document).ready(function(){
	$("#t_preacc").on("click",function(){
		if($("#t_preacc").prop("checked")){
			$("#t_acc").css("margin-top","20px");
			$("#t_acc").css("height","40px");
			$("#t_acc").html("<span style='font-size:20px !important;'>전결");
		}else{
			$("#t_acc").css("margin-top","0px");
			$("#t_acc").css("height","60px");
			$("#t_acc").text("");
		}
	});
	$("#i_preacc").on("change",function(){
		if($("#i_preacc").prop("checked")){
			$("#i_acc").css("margin-top","20px");
			$("#i_acc").css("height","40px");
			$("#i_acc").html("<span style='font-size:20px !important;'>전결");
		}else{
			$("#i_acc").css("margin-top","0px");
			$("#i_acc").css("height","60px");
			$("#i_acc").text("");
		}
	});
});

function fnPrint(){
	$("#print_area").printThis();
}

</script>
<style type="text/css">
@page a4sheet { size: 21.0cm 29.7cm } 
.a4 { page: a4sheet; page-break-after: always } 
div, td {font-size:10px "Malgun Gothic", candara, dotum; color:#000000;}
table {
border-collapse: collapse;
border-spacing: 0;
}
.datatable {width:100%;font-size:10px;}
.datatable th {text-align: center; padding:6px 10px 5px; color:#000000; border-top:1px solid #000000; border-bottom:1px solid #000000; border-left:1px solid #000000; border-right:1px solid #000000; background:#F9F9F9;}
.datatable td {text-align: center; padding:6px 10px 5px; border-top:1px solid #000000; border-bottom:1px solid #000000; border-left:1px solid #000000; border-right:1px solid #000000;}
</style>
</head>
<body>
	<div style="margin-bottom: 15px;">
		<button onclick="javascript:fnPrint();">인쇄</button>
		<a href="http://ypgw.ypzinc.co.kr/ekp/view/board/article/brdAtclViewPopup?atclId=BA26792524877628076874&access="><span>*인쇄초기설정 방법 보기</span></a>
		<div style="float:right;">
			<input type="checkbox" id="t_preacc">팀장 전결 &nbsp;&nbsp;
			<input type="checkbox" id="i_preacc">임원 전결
		</div>
	</div>
	
	<div id="print_area" class="a4">
		<table class="datatable" style="border-top:0px;"><!-- 제목 테이블 -->
			<colgroup>
				<col width="12%">
				<col width="10%">
				<col width="12%">
				<col width="10%">
				<col width="10%">
				<col width="46%">
			</colgroup>
			<tbody>
				<tr>
					<td colspan="6" style="border:0px;height:50px;">
						<strong style="font-size: 28px; text-decoration: underline;">
							<c:if test="${subject eq '2'}">지 출 품 의 서</c:if>
							<c:if test="${subject eq '3'}">수 입 품 의 서</c:if></strong><br>
						<span style="font-size: 9pt;">${headermap[0].BUDAT}</span>
					</td>
				</tr>
				<tr>
					<th style="text-align: center; border:1px solid #000000; font-szie: 10px;" colspan="4">
						작   성   내   역
					</th>
					<td rowspan="3" style="border: 0px;"></td>
					<td rowspan="3" style="border: 0px; padding:0px;">
						<div style="float: right;">
							<div id="recvLineDl" style="padding: 0px; float: left;">
								<div style="padding: 0px; float: left;">
									<div style="padding: 0px; width: auto; border-left-color: black; border-left-width: 1px; border-left-style: solid; float: left;">
										<dl style="margin: 0px; width: 20px; overflow: hidden; border-top-color: black; border-right-color: black; border-bottom-color: black; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-top-style: solid; border-right-style: solid; border-bottom-style: solid; float: left;">
											<dd style="margin: 0px; padding: 3px 0px; height: 100px; text-align: center;">
												<br>결<br><br><br><br><br>재
											</dd>
										</dl>
									</div>
								</div>
								
								<div style="padding: 0px; float: left;">
									<div style="padding: 0px; width: auto; float: left;">
										<dl style="margin: 0px; width: 64px; overflow: hidden; border-top-color: black; border-right-color: black; border-bottom-color: black; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-top-style: solid; border-right-style: solid; border-bottom-style: solid; float: left;">
											<dt style="background: rgb(245, 245, 245); padding: 2px 0px; height: 15px; text-align: center; line-height: 1; overflow: hidden; border-bottom-color: black; border-bottom-width: 1px; border-bottom-style: solid;">담당</dt>
											<dt style="margin: 0px; padding: 2px 0px; height: 60px; text-align: center; line-height: 1;"></dt>
											<dd style="margin: 0px; padding: 3px 0px; height: 15px; text-align: center; line-height: 1; border-top:black solid 1px;"></dd>
										</dl>
									</div>
								</div>
								<div style="padding: 0px; float: left;">
									<div style="padding: 0px; float: left;">
										<div style="padding: 0px; width: auto; float: left;">
											<dl style="margin: 0px; width: 64px; overflow: hidden; border-top-color: black; border-right-color: black; border-bottom-color: black; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-top-style: solid; border-right-style: solid; border-bottom-style: solid; float: left;">
												<dt style="background: rgb(245, 245, 245); padding: 2px 0px; height: 15px; text-align: center; line-height: 1; overflow: hidden; border-bottom-color: black; border-bottom-width: 1px; border-bottom-style: solid;">팀장</dt>
												<dt id="t_acc" style="margin: 0px; padding: 2px 0px; height: 60px; text-align: center; line-height: 1;"></dt>
												<dd style="margin: 0px; padding: 3px 0px; height: 15px; text-align: center; line-height: 1; border-top:black solid 1px;"></dd>
											</dl>
										</div>
									</div>
								</div>
								<div style="padding: 0px; float: left;">
									<div style="padding: 0px; float: left;">
										<div style="padding: 0px; width: auto; float: left;">
											<dl style="margin: 0px; width: 64px; overflow: hidden; border-top-color: black; border-right-color: black; border-bottom-color: black; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-top-style: solid; border-right-style: solid; border-bottom-style: solid; float: left;">
												<dt style="background: rgb(245, 245, 245); padding: 2px 0px; height: 15px; text-align: center; line-height: 1; overflow: hidden; border-bottom-color: black; border-bottom-width: 1px; border-bottom-style: solid;">임원</dt>
												<dt id="i_acc" style="margin: 0px; padding: 2px 0px; height: 60px; text-align: center; line-height: 1;"></dt>
												<dd style="margin: 0px; padding: 3px 0px; height: 15px; text-align: center; line-height: 1; border-top:black solid 1px;"></dd>
											</dl>
										</div>
									</div>
								</div>
								<div style="padding: 0px; float: left;">
									<div style="padding: 0px; float: left;">
										<div style="padding: 0px; width: auto; float: left;">
											<dl style="margin: 0px; width: 64px; overflow: hidden; border-top-color: black; border-right-color: black; border-bottom-color: black; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-top-style: solid; border-right-style: solid; border-bottom-style: solid; float: left;">
												<dt style="background: rgb(245, 245, 245); padding: 2px 0px; height: 15px; text-align: center; line-height: 1; overflow: hidden; border-bottom-color: black; border-bottom-width: 1px; border-bottom-style: solid;">
													<c:choose>
														<c:when test="${headermap[0].BTEXT eq '석포제련소'}">소장</c:when>
														<c:otherwise>사장</c:otherwise>
													</c:choose>
												</dt>
												<dt style="margin: 0px; padding: 2px 0px; height: 60px; text-align: center; line-height: 1;"></dt>
												<dd style="margin: 0px; padding: 3px 0px; height: 15px; text-align: center; line-height: 1; border-top:black solid 1px;"></dd>
											</dl>
										</div>
									</div>
								</div>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<th>품의사업장</th>
					<td>${headermap[0].BTEXT}</td>
					<th>품의부서</th>
					<td>${headermap[0].ORGTX}</td>
				</tr>
				<tr>
					<th>전표번호</th>
					<td>${headermap[0].BELNR}</td>
					<th>발행인</th>
					<td>${headermap[0].ENAME}</td>
				</tr>
			</tbody>
		</table>
		<div style="height: 15px;">
		</div>
		<table class="datatable"><!-- 내용 테이블 -->
			<colgroup>
				<col class="">
				<col class="">
				<col class="">
				<col class="">
				<col class="">
				<col class="">
				<col class="">
				<col class="">
			</colgroup>
			<tbody>
				<tr style="height: 25px;">
					<th scope="row" style="width:25px;">행번</th>
					<th scope="col">계 정 과 목</th>
					<th scope="col">거   래   처</th>
					<th scope="col">적   요</th>
					<th scope="col">원가부문</th>
					<th scope="col">원화금액</th>
					<th scope="col">외화금액</th>
					<th scope="col">통화</th>
				</tr>
				<c:set var="won_sum" value="0"/>
				<c:set var="oy_sum" value="0"/><!-- 외화 합계 -->
				<c:forEach var="list" items="${list}" varStatus="i">
					<tr style="height: 25px;">
						<td style="text-align: center;">${list.BUZEI}</td><!-- 행번 -->
						<td>${list.TXT50}</td><!-- 계정과목 -->
						<td>${list.ZUONR}</td><!-- 거래처 -->
						<td>${list.SGTXT}</td><!-- 적요 -->
						<td>${list.KTEXT}</td><!-- 원가부분 -->
						<td style="text-align: right;">
							${list.DMBTR}
							<c:set var="won_gum" value="${fn:replace(list.DMBTR,',','')}"/>
							<c:set var="won_sum" value="${won_sum + fn:trim(won_gum)}"/>
						</td><!-- 원화금액 -->
						<td style="text-align: right;">
							${list.WRBTR}
							<c:set var="oy_gum" value="${fn:replace(list.WRBTR,',','')}"/>
							<c:set var="oy_sum" value="${oy_sum + fn:trim(oy_gum)}"/>
						</td><!-- 외화금액 -->
						<td style="text-align: center;">${list.WAERS}</td><!-- 통화 -->
					</tr>
				</c:forEach>
				<tr style="height: 25px;">
					<td style="text-align: center;" colspan="5">합 계</td>
					<td style="text-align: right;"><fmt:formatNumber value="${won_sum}" pattern="#,###"/></td><!-- 원화 합계 -->
					<td style="text-align: right;"><fmt:formatNumber value="${oy_sum}" pattern="#,###"/></td><!-- 외화 합계 -->
					<td></td>
				</tr>
			</tbody>
		</table>
		<c:if test="${etc != null && (fn:contains(headermap[0].userDept,'영업') || headermap[0].userDept eq '서린')}"><!-- 서린 or 영업팀 -->
			<div style="margin-top:15px;">
				<c:if test="${etc[0].ZSUMALL != null && etc[0].ZSUMALL != ''}">
					<div id="gumaek" style="float:right;margin-left:15px;">
						<table class="datatable">
							<tr>
								<td colspan="2">${etc[0].ZTEXT}</td>
							</tr>
							<tr>
								<td>금액</td>
								<td style="text-align: right;">${etc[0].ZSUMALL}</td>
							</tr>
							<tr>
								<td height="15px">월일</td>
								<td>${headermap[0].BUDAT}</td>
							</tr>
						</table>
					</div>
				</c:if>
				<c:if test="${(etc[0].ZMULPUM != null && etc[0].ZMULPUM != '') || (etc[0].ZSEGUM != null && etc[0].ZSEGUM != '')}">
					<div id="mulpum" style="float:right;">
						<table class="datatable">
							<colgroup>
								<col class="">
								<col class="">
								<col class="">
								<col class="">
							</colgroup>
							<tr>
								<td rowspan="3" width="10px">${fn:substring(headermap[0].BUDAT,7,9)}<br>월<br>${fn:substring(headermap[0].BUDAT,12,14)}<br>일</td>
								<td colspan="3">세금계산서 확인필</td>
							</tr>
							<tr>
								<td width="40px">담당</td>
								<td width="40px">팀장</td>
								<td width="40px" rowspan="2"></td>
							</tr>
							<tr height="40px">
								<td height="40px"></td>
								<td height="40px"></td>
							</tr>
							<tr>
								<td colspan="2">물품대</td>
								<td colspan="2" style="text-align: right;">${etc[0].ZMULPUM}</td>
							</tr>
							<tr>
								<td colspan="2">세액</td>
								<td colspan="2" style="text-align: right;">${etc[0].ZSEGUM}</td>
							</tr>
						</table>
					</div>
				</c:if>
			</div>
		</c:if>
		<div style="position:absolute;bottom:0px;text-align:center;width:100%;">
			<img src="/resources/yp/wp/yplogo_blk.jpg" width="" height="20px"><span>주 식 회 사   영   풍</span>
		</div>
	</div>
	
</body>
</html>