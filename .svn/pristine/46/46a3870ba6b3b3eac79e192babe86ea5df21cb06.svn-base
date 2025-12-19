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
<title>회계전표 결재</title>
<script type="text/javascript">
$(document).ready(function(){
	$("#t_preacc2").prop("checked",true);
	$("#t_acc2").css("margin-top","20px");
	$("#t_acc2").css("height","40px");
	$("#t_acc2").html("<span style='font-size:20px !important;'>전결</span>");
	
	$("#t_preacc1").on("click",function(){
		if($("#t_preacc1").prop("checked")){
			$("#t_acc").css("margin-top","20px");
			$("#t_acc").css("height","40px");
			$("#t_acc").html("<span style='font-size:20px !important;'>전결</span>");
		}else{
			$("#t_acc").css("margin-top","0px");
			$("#t_acc").css("height","60px");
			$("#t_acc").text("");
		}
	});
	$("#i_preacc1").on("change",function(){
		if($("#i_preacc1").prop("checked")){
			$("#i_acc").css("margin-top","20px");
			$("#i_acc").css("height","40px");
			$("#i_acc").html("<span style='font-size:20px !important;'>전결</span>");
		}else{
			$("#i_acc").css("margin-top","0px");
			$("#i_acc").css("height","60px");
			$("#i_acc").text("");
		}
	});
	$("#t_preacc2").on("click",function(){
		if($("#t_preacc2").prop("checked")){
			$("#t_acc2").css("margin-top","20px");
			$("#t_acc2").css("height","40px");
			$("#t_acc2").html("<span style='font-size:20px !important;'>전결</span>");
		}else{
			$("#t_acc2").css("margin-top","0px");
			$("#t_acc2").css("height","60px");
			$("#t_acc2").text("");
		}
	});
	$("#i_preacc2").on("change",function(){
		if($("#i_preacc2").prop("checked")){
			$("#i_acc2").css("margin-top","20px");
			$("#i_acc2").css("height","40px");
			$("#i_acc2").html("<span style='font-size:20px !important;'>전결</span>");
		}else{
			$("#i_acc2").css("margin-top","0px");
			$("#i_acc2").css("height","60px");
			$("#i_acc2").text("");
		}
	});
});

function fnPrint(){
	$("#print_area").printThis();
}
</script>
<style type="text/css">
@page a4sheet { size: 29.7cm 21.0cm} 
.a4 { page: a4sheet; page-break-after: always } 
div, td {font-size:11px "Malgun Gothic", candara, dotum; color:#000000;}
table {
border-collapse: collapse;
border-spacing: 0;
}
.datatable {width:100%;font-size:11px;}
.datatable th {text-align: center; padding:1px 5px 0px; color:#000000; border-top:1px solid #000000; border-bottom:1px solid #000000; border-left:1px solid #000000; border-right:1px solid #000000; background:#F9F9F9;}
.datatable td {text-align: center; padding:1px 5px 0px; border-top:1px solid #000000; border-bottom:1px solid #000000; border-left:1px solid #000000; border-right:1px solid #000000;}
</style>
</head>
<body>
	<c:set var="totalpage" value="${headermap[0].totalpage}"/>
	<c:set var="cha_sum" value="0"/>
	<c:set var="dae_sum" value="0"/>
	<div style="margin-bottom: 15px;">
		<button onclick="javascript:fnPrint();">인쇄</button>
		<a href="http://ypgw.ypzinc.co.kr/ekp/view/board/article/brdAtclViewPopup?atclId=BA26792524877628076874&access="><span>*인쇄초기설정 방법 보기</span></a>
		<div style="float:right;">
			품의&nbsp;:
			<input type="checkbox" id="t_preacc1">팀장 전결 &nbsp;
			<input type="checkbox" id="i_preacc1">임원 전결 &nbsp; &nbsp;
			결재&nbsp;:
			<input type="checkbox" id="t_preacc2">팀장 전결 &nbsp;
			<input type="checkbox" id="i_preacc2">임원 전결
		</div>
	</div>
	<div id="print_area">
		<c:forEach var="page" begin="1" end="${totalpage}" step="1" varStatus="i">
			<div class="a4">
				<table class="datatable" style="border-top:0px;"><!-- 제목 테이블 -->
					<colgroup>
						<col width="9%">
						<col width="8%">
						<col width="9%">
						<col width="8%">
						<col width="28%">
						<col width="38%">
					</colgroup>
					<tbody>
						<tr>
							<th style="text-align: center; border:black solid 1px;" colspan="4">
								작   성   내   역
							</th>
							<td rowspan="4" style="border:0px;">
								<strong style="font-size: 33px; text-decoration: underline;">회 계 전 표</strong><br>
								<span style="font-size: 10pt;">
									<fmt:parseDate var="BUDAT" value="${headermap[0].BUDAT}" pattern="yyyy.MM.dd"/>
									<fmt:formatDate value="${BUDAT}" pattern="yyyy년 MM월dd일"/>
								</span>
							</td>
							<td rowspan="4" style="border:0px; padding:0px;">
								<div style="float: right;">
									<c:if test="${i.current == 1}">
										<div id="recvLineDl" style="padding: 0px; float: left;">
											<div style="padding: 0px; float: left;">
												<div style="padding: 0px; width: auto; border-left-color: black; border-left-width: 1px; border-left-style: solid; float: left;">
													<dl style="margin: 0px; width: 20px; overflow: hidden; border-top-color: black; border-right-color: black; border-bottom-color: black; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-top-style: solid; border-right-style: solid; border-bottom-style: solid; float: left;">
														<dd style="margin: 0px; padding: 3px 0px; height: 78px; text-align: center;">
															<br>결<br><br><br>재
														</dd>
													</dl>
												</div>
											</div>
											
											<div style="padding: 0px; float: left;">
												<div style="padding: 0px; width: auto; float: left;">
													<dl style="margin: 0px; width: 64px; overflow: hidden; border-top-color: black; border-right-color: black; border-bottom-color: black; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-top-style: solid; border-right-style: solid; border-bottom-style: solid; float: left;">
														<dt style="background: rgb(245, 245, 245); padding: 2px 0px; height: 15px; text-align: center; line-height: 1; overflow: hidden; border-bottom-color: black; border-bottom-width: 1px; border-bottom-style: solid;">담당</dt>
														<dt style="margin: 0px; padding: 2px 0px; height: 60px; text-align: center; line-height: 1;"></dt>
			<!-- 											<dd style="margin: 0px; padding: 3px 0px; height: 10px; text-align: center; line-height: 1; border-top:black solid 1px;"></dd> -->
													</dl>
												</div>
											</div>
											<div style="padding: 0px; float: left;">
												<div style="padding: 0px; float: left;">
													<div style="padding: 0px; width: auto; float: left;">
														<dl style="margin: 0px; width: 64px; overflow: hidden; border-top-color: black; border-right-color: black; border-bottom-color: black; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-top-style: solid; border-right-style: solid; border-bottom-style: solid; float: left;">
															<dt style="background: rgb(245, 245, 245); padding: 2px 0px; height: 15px; text-align: center; line-height: 1; overflow: hidden; border-bottom-color: black; border-bottom-width: 1px; border-bottom-style: solid;">팀장</dt>
															<dt id="t_acc2" style="margin: 0px; padding: 2px 0px; height: 60px; text-align: center; line-height: 1;"></dt>
			<!-- 												<dd style="margin: 0px; padding: 3px 0px; height: 10px; text-align: center; line-height: 1; border-top:black solid 1px;"></dd> -->
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
																	<c:when test="${headermap[0].BTEXT eq '안성휴게소'}">소장</c:when>
																	<c:otherwise>임원</c:otherwise>
																</c:choose>
															</dt>
															<dt id="i_acc2" style="margin: 0px; padding: 2px 0px; height: 60px; text-align: center; line-height: 1;"></dt>
			<!-- 												<dd style="margin: 0px; padding: 3px 0px; height: 10px; text-align: center; line-height: 1; border-top:black solid 1px;"></dd> -->
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
																	<c:when test="${headermap[0].BTEXT eq '석포공장'}">소장</c:when>
																	<c:when test="${headermap[0].BTEXT eq '안성휴게소'}">본부장</c:when>
																	<c:otherwise>부사장</c:otherwise>
																</c:choose>
															</dt>
															<dt style="margin: 0px; padding: 2px 0px; height: 60px; text-align: center; line-height: 1;"></dt>
			<!-- 												<dd style="margin: 0px; padding: 3px 0px; height: 10px; text-align: center; line-height: 1; border-top:black solid 1px;"></dd> -->
														</dl>
													</div>
												</div>
											</div>
											<c:if test="${headermap[0].BTEXT eq '본사'}">
												<div style="padding: 0px; float: left;">
													<div style="padding: 0px; float: left;">
														<div style="padding: 0px; width: auto; float: left;">
															<dl style="margin: 0px; width: 64px; overflow: hidden; border-top-color: black; border-right-color: black; border-bottom-color: black; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-top-style: solid; border-right-style: solid; border-bottom-style: solid; float: left;">
																<dt style="background: rgb(245, 245, 245); padding: 2px 0px; height: 15px; text-align: center; line-height: 1; overflow: hidden; border-bottom-color: black; border-bottom-width: 1px; border-bottom-style: solid;">사장</dt>
																<dt style="margin: 0px; padding: 2px 0px; height: 60px; text-align: center; line-height: 1;"></dt>
				<!-- 												<dd style="margin: 0px; padding: 3px 0px; height: 10px; text-align: center; line-height: 1; border-top:black solid 1px;"></dd> -->
															</dl>
														</div>
													</div>
												</div>
											</c:if>
										</div>
									</c:if>
								</div>
							</td>
						</tr>
						<tr>
							<th>전 표 유 형</th>
							<td>${headermap[0].LTEXT}</td>
							<th>전 표 번 호</th>
							<td>${headermap[0].BELNR}</td>
						</tr>
						<tr>
							<th style="padding:0;">발행사업장명</th>
							<td>${headermap[0].BTEXT}</td>
							<th>역  분  개</th>
							<td>${headermap[0].STBLG}</td>
						</tr>
						<tr>
							<th>발  행  인</th>
							<td>${headermap[0].ENAME}</td>
							<th style="padding:0;">반제전표번호</th>
							<td>${headermap[0].AUGBL}</td>
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
						<tr style="height: 20px;">
							<th rowspan="4" scope="row" style="width:25px;">행<br>
							<br>
							<br>
							<br>번
							</th>
							<th scope="col">거   래   처</th>
							<th scope="col">상   대   처</th>
							<th scope="col">원    금</th>
							<th scope="col">이        율</th>
							<th scope="col">기     산     일</th>
							<th rowspan="4" scope="col">계 정 과 목</th>
							<th colspan="2" scope="col">금 액</th>
						</tr>
						<tr style="height: 20px;">
							<th scope="col">증 서 번 호</th>
							<th scope="col">외 화 구 분</th>
							<th scope="col">외 화 액</th>
							<th scope="col">환        율</th>
							<th scope="col">만     기     일</th>
							<th rowspan="3" scope="col">차 변</th>
							<th rowspan="3" scope="col">대 변</th>
						</tr>
						<tr style="height: 20px;">
							<th colspan="2" scope="col">품        명</th>
							<th scope="col">수    량</th>
							<th scope="col">단        위</th>
							<th scope="col">단            가</th>
						</tr>
						<tr style="height: 20px;">
							<th colspan="3" scope="col">적        요</th>
							<th scope="col">집 행 부 서</th>
							<th scope="col">코 스 트 센 터</th>
						</tr>
						<c:forEach var="list" items="${list}" begin="${(i.current - 1) * 5}" end="${(i.current - 1) * 5 + 4}" step="1" varStatus="j">
							<tr style="height: 20px;">
								<td style="text-align: center;" rowspan="4">${list.FIELD28}</td><!-- 행번 -->
								<td>${list.FIELD09}</td><!-- 거래처 -->
								<td>${list.FIELD10}</td><!-- 상대처 -->
								<td style="text-align: right;">${list.FIELD11}</td><!-- 원금 -->
								<td style="text-align: right;">${list.FIELD12}</td><!-- 이율 -->
								<td style="text-align: center;">${list.FIELD13}</td><!-- 기산일 -->
								<td rowspan="4">
									${list.FIELD29}
									<c:if test="${fn:length(list.FIELD31) > 0}"><br>${list.FIELD31}</c:if>
									<c:if test="${fn:length(list.FIELD30) > 0}"><br>${list.FIELD30}</c:if>
								</td><!-- 계정과목 -->
								<td style="text-align: right;" rowspan="4">
									${list.FIELD26}
									<c:set var="cha_gum" value="${fn:replace(list.FIELD26,',','')}"/>
								</td><!-- 차변금액 -->
								<td style="text-align: right;" rowspan="4">
									${list.FIELD27}
									<c:set var="dae_gum" value="${fn:replace(list.FIELD27,',','')}"/>
								</td><!-- 대변금액 -->
							</tr>
							<tr style="height: 20px;">
								<td>${list.FIELD14}</td><!-- 증서번호 -->
								<td style="text-align: center;">${list.FIELD15}</td><!-- 외화구분 -->
								<td style="text-align: right;">${list.FIELD16}</td><!-- 외화액 -->
								<td style="text-align: right;">${list.FIELD17}</td><!-- 환율 -->
								<td style="text-align: center;">${list.FIELD18}</td><!-- 만기일 -->
							</tr>
							<tr style="height: 20px;">
								<td colspan="2">${list.FIELD19}</td><!-- 품명 -->
								<td style="text-align: right;">${list.FIELD20}</td><!-- 수량 -->
								<td style="text-align: center;">${list.FIELD21}</td><!-- 단위 -->
								<td style="text-align: right;">${list.FIELD22}</td><!-- 단가 -->
							</tr>
							<tr style="height: 20px;">
								<td colspan="3">${list.FIELD23}</td><!-- 적요 -->
								<td style="text-align: center;">${list.FIELD24}</td><!-- 집행부서 -->
								<td style="text-align: center;">${list.FIELD25}</td><!-- 코스트센터 -->
							</tr>
							<c:set var="cha_sum" value="${cha_sum + fn:trim(cha_gum)}"/>
							<c:set var="dae_sum" value="${dae_sum + fn:trim(dae_gum)}"/>
							<c:if test="${j.last && j.index != (i.current - 1) * 5 + 4}">
								<c:set var="empty_tr" value="${(i.current - 1) * 5 + 4 - j.index}"/>
							</c:if>
						</c:forEach>
						<c:forEach begin="1" end="${empty_tr}" step="1" varStatus="t">
							<tr style="height: 20px;">
								<td style="text-align: center;" rowspan="4"></td><!-- 행번 -->
								<td></td><!-- 거래처 -->
								<td></td><!-- 상대처 -->
								<td style="text-align: right;"></td><!-- 원금 -->
								<td style="text-align: right;"></td><!-- 이율 -->
								<td style="text-align: center;"></td><!-- 기산일 -->
								<td rowspan="4"></td><!-- 계정과목 -->
								<td style="text-align: right;" rowspan="4"></td><!-- 차변금액 -->
								<td style="text-align: right;" rowspan="4"></td><!-- 대변금액 -->
							</tr>
							<tr style="height: 20px;">
								<td></td><!-- 증서번호 -->
								<td style="text-align: center;"></td><!-- 외화구분 -->
								<td style="text-align: right;"></td><!-- 외화액 -->
								<td style="text-align: right;"></td><!-- 환율 -->
								<td style="text-align: center;"></td><!-- 만기일 -->
							</tr>
							<tr style="height: 20px;">
								<td colspan="2"></td><!-- 품명 -->
								<td style="text-align: right;"></td><!-- 수량 -->
								<td style="text-align: center;"></td><!-- 단위 -->
								<td style="text-align: right;"></td><!-- 단가 -->
							</tr>
							<tr style="height: 20px;">
								<td colspan="3"></td><!-- 적요 -->
								<td style="text-align: center;"></td><!-- 집행부서 -->
								<td style="text-align: center;"></td><!-- 코스트센터 -->
							</tr>
						</c:forEach>
						<tr>
							<td style="height:78px;"></td>
							<td style="text-align: center;" colspan="5">
								<div style="float: left;">
									<c:if test="${i.current == 1}">
										<div id="infoAppLine" style="padding: 0px; float: left;">
											<div style="padding: 0px; float: left;">
												<div style="padding: 0px; width: auto; border-left-color: black; border-left-width: 1px; border-left-style: solid; float: left;">
													<dl style="margin: 0px; width: 20px; overflow: hidden; border-top-color: black; border-right-color: black; border-bottom-color: black; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-top-style: solid; border-right-style: solid; border-bottom-style: solid; float: left;">
														<dd style="margin: 0px; padding: 3px 0px; height: 78px; text-align: center;">
															<br>품<br><br><br>의
														</dd>
													</dl>
												</div>
											</div>
											
											<div style="padding: 0px; float: left;">
												<div style="padding: 0px; width: auto; float: left;">
													<dl style="margin: 0px; width: 64px; overflow: hidden; border-top-color: black; border-right-color: black; border-bottom-color: black; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-top-style: solid; border-right-style: solid; border-bottom-style: solid; float: left;">
														<dt style="background: rgb(245, 245, 245); padding: 2px 0px; height: 15px; text-align: center; line-height: 1; overflow: hidden; border-bottom-color: black; border-bottom-width: 1px; border-bottom-style: solid;">담당</dt>
														<dt style="margin: 0px; padding: 2px 0px; height: 60px; text-align: center; line-height: 1;"></dt>
			<!-- 											<dd style="margin: 0px; padding: 3px 0px; height: 10px; text-align: center; line-height: 1; border-top:black solid 1px;"></dd> -->
													</dl>
												</div>
											</div>
											<div style="padding: 0px; float: left;">
												<div style="padding: 0px; float: left;">
													<div style="padding: 0px; width: auto; float: left;">
														<dl style="margin: 0px; width: 64px; overflow: hidden; border-top-color: black; border-right-color: black; border-bottom-color: black; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-top-style: solid; border-right-style: solid; border-bottom-style: solid; float: left;">
															<dt style="background: rgb(245, 245, 245); padding: 2px 0px; height: 15px; text-align: center; line-height: 1; overflow: hidden; border-bottom-color: black; border-bottom-width: 1px; border-bottom-style: solid;">팀장</dt>
															<dt id="t_acc" style="margin: 0px; padding: 2px 0px; height: 60px; text-align: center; line-height: 1;"></dt>
			<!-- 												<dd style="margin: 0px; padding: 3px 0px; height: 10px; text-align: center; line-height: 1; border-top:black solid 1px;"></dd> -->
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
			<!-- 												<dd style="margin: 0px; padding: 3px 0px; height: 10px; text-align: center; line-height: 1; border-top:black solid 1px;"></dd> -->
														</dl>
													</div>
												</div>
											</div>
											<div style="padding: 0px; float: left;">
												<div style="padding: 0px; float: left;">
													<div style="padding: 0px; width: auto;  float: left;">
														<dl style="margin: 0px; width: 64px; overflow: hidden; border-top-color: black; border-right-color: black; border-bottom-color: black; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-top-style: solid; border-right-style: solid; border-bottom-style: solid; float: left;">
															<dt style="background: rgb(245, 245, 245); padding: 2px 0px; height: 15px; text-align: center; line-height: 1; overflow: hidden; border-bottom-color: black; border-bottom-width: 1px; border-bottom-style: solid;">
																<c:choose>
																	<c:when test="${headermap[0].BTEXT eq '석포공장'}">소장</c:when>
																	<c:otherwise>부사장</c:otherwise>
																</c:choose>
															</dt>
															<dt style="margin: 0px; padding: 2px 0px; height: 60px; text-align: center; line-height: 1;"></dt>
			<!-- 												<dd style="margin: 0px; padding: 3px 0px; height: 10px; text-align: center; line-height: 1; border-top:black solid 1px;"></dd> -->
														</dl>
													</div>
												</div>
											</div>
										</div>
									</c:if>	
								</div>
							</td>
							<td style="text-align: center;">
								<strong style="font-size: 18px;">합 계</strong>
							</td>
							<td class="cha_Hab" style="text-align: right;">
								<c:if test="${i.last}"><fmt:formatNumber value="${cha_sum}" pattern="#,###"/></c:if>
							</td><!-- 차변금액 합계 -->
							<td class="dae_Hab" style="text-align: right;">
								<c:if test="${i.last}"><fmt:formatNumber value="${dae_sum}" pattern="#,###"/></c:if>
							</td><!-- 대변금액 합계 -->
						</tr>
					</tbody>
				</table>
				<div style="text-align:center;">
					<img src="/resources/yp/wp/yplogo_blk.jpg" width="" height="20px"><span>주 식 회 사   영   풍</span>
				</div>
			</div>
		</c:forEach>
	</div>
</body>
</html>