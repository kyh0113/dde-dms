<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
	
	Date today = new Date();
	SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/dd");
	String toDay = date.format(today);
	String sDate = toDay.substring(0, 8) + "01";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<sec:csrfMetaTags />
<title>세금계산서 조회</title>
<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
<script type="text/javascript" src="/resources/icm/js/custom.js"></script>
<script type="text/javascript" src="/resources/icm/js/jquery.form.js"></script>
<script src="/resources/icm/js/bootstrap.min.js"></script>
<script src="/resources/icm/datepicker/js/bootstrap-datepicker.js"></script>
<link href="/resources/icm/datepicker/css/datepicker.css" rel="stylesheet" type="text/css" />
<link id="bs-css" href="/resources/icm/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/yp/css/style.css">
<script type="text/javascript">
	
	
	var scope;
	$(document).ready(function() {
		// 부트스트랩 날짜객체
		$(".dtp").datepicker({
			format : "yyyy/mm/dd",
			language : "ko",
			todayHighlight : true,
			autoclose : true,
			clearBtn : true,
			updateViewDate : false
		}).on('changeDate', function() {
		 	$('.datepicker').hide();
		});
	
	
	// 세금계산서 조회
	$("#search_btn").on("click", function() {
		
		var search_type = $("#search_type").val();
		
		search_type = "Y"
		
		var form = $("#frm")[0];
		form.submit();
		
		//var token = $("meta[name='_csrf']").attr("content");
		//var header = $("meta[name='_csrf_header']").attr("content");
		//alert($("#REG_NO").val());
		
		//$.ajax({
			//url : "/yp/popup/zmm/aw/retrieveBillbySAP",
			//type : "POST",
			//cache : false,
			//async : true,
			//dataType : "json",
			//data : {
				//REG_NO : "5068187519",
				//sdate : "20160601",
				//edate : "20160630"
			//},
			//success : function(data) {
				//var form = $("#frm")[0];
				//form.submit();
			//},
			//beforeSend : function(xhr) {
				// 2019-10-23 khj - for csrf
				//xhr.setRequestHeader(header, token);
				//$('.wrap-loading').removeClass('display-none');
			//},
			//complete : function() {
				//$('.wrap-loading').addClass('display-none');
			//},
			//error : function(request, status, error) {
				//console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
				//swalDangerCB("저장 실패하였습니다.\n관리자에게 문의해주세요.");
			//}
		//});
	});
	
	
	$("#reg_btn").click(function() {
		
		var TOT_AMT = $("#TOT_AMT").val();
		var TOT_AMT = TOT_AMT.slice(0,-3);
		//var chk_i = Math.floor($("#chk_i").val());
		var ENT_CODE = $("#ENT_CODE").val();
		var ENT = $("#ENT").val();
		var REG_NO = $("#REG_NO").val();
		var ZDATE = $("#ZDATE").val();
		var HWBAS = $("#HWBAS").val().replace(/\,|\./gi, "");
		var HWSTE = $("#HWSTE").val().replace(/\,|\./gi, "");
		var ZTTAT = $("#ZTTAT").val().replace(/\,|\./gi, "");
		var ZSPCN = $("#ZSPCN").val();
		var CALC_CODE = $("#CALC_CODE").val();
		
		alert(TOT_AMT);
		//alert(HWBAS);
		//alert(HWSTE);
		//alert(ZTTAT);
		
		if(TOT_AMT != HWBAS) {
			alert("계량 정산금액과 세금계산서 공급가액이 일치하지 않습니다.");
			return false;
		}
		
		if (confirm("임시전표 발행하시겠습니까?")) {
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				url : "/yp/zmm/aw/createDocument_Bill",
				type : "POST",
				cache : false,
				async : false,
				dataType : "json",
				data : {
					 ENT_CODE: ENT_CODE
					,ENT: ENT
					,REG_NO: REG_NO
					,ZDATE: ZDATE
					,HWBAS: HWBAS
					,HWSTE: HWSTE
					,ZTTAT: ZTTAT
					,ZSPCN: ZSPCN
					,CALC_CODE: CALC_CODE
				},
				success : function(result) {
					if (result.flag == "S") {
						alert("전표가 등록되었습니다.\n(전표번호 : " + result.msg + ")");
						// $("#reg_btn").hide();
						// fnAddDocTable(result.msg);
					} else {
						alert(result.msg);
					}
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
					// swalDangerCB("등록에 실패하였습니다.\n관리자에게 문의해주세요.");
				}
			});
		}
  	});
	
	});

</script>

<script type="text/javascript">

	function fnSendData(i) {
		
		var type = "${req_data.type}";
		var target = Number("${req_data.target}");
		
		document.getElementById("ZDATE").value = $("input[name=ZDATE]:eq("+i+")").val();
		document.getElementById("HWBAS").value = $("input[name=HWBAS]:eq("+i+")").val();
		document.getElementById("HWSTE").value = $("input[name=HWSTE]:eq("+i+")").val();
		document.getElementById("ZTTAT").value = $("input[name=ZTTAT]:eq("+i+")").val();
		document.getElementById("ZSPCN").value = $("input[name=ZSPCN]:eq("+i+")").val();
		
	}

</script>

<style>
	.lst tr:hover td {
	    background: #eefbff;
	    cursor: pointer;
	}
</style>

</head>
<body>
	<div id="popup">
		<div class="pop_header">세금계산서 조회</div>
		<div class="pop_content">
			<form id="frm" name="frm" method="post" accept-charset="UTF-8">
				<!-- 20191023_khj for csrf -->
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="type" value="${req_data.type}" />
				<input type="hidden" name="target" value="${req_data.target}" />
				<input type="hidden" name="pageSize" value="15" />
				<input type="hidden" name="rangeSize" value="10" />
				<input type="hidden" name="page" value="${pagination.getCurPage()}" />			
				<input type="hidden" name="ENT_CODE" id="ENT_CODE" value="${data.ENT_CODE}" />
				<input type="hidden" name="ENT" id="ENT" value="${data.ENT}" />
				<input type="hidden" name="REG_NO" id="REG_NO" value="${data.REG_NO}" />
				<input type="hidden" name="search_type" id="search_type" value="N" />
				<!-- <input type="text" name="TOT_AMT" id="TOT_AMT" value="${data.TOT_AMT}" /> -->
				<input type="hidden" name="TOT_AMT" id="TOT_AMT" value="${data.TOT_AMT}" />
				<input type="hidden" name="CALC_CODE" id="CALC_CODE" value="${data.CALC_CODE}" />
				<input type="text" name="ZSPCN" id="ZSPCN" value="">
				<input type="text" name="ZDATE" id="ZDATE" value="">
				<input type="text" name="HWBAS" id="HWBAS" value="">
				<input type="text" name="HWSTE" id="HWSTE" value="">
				<input type="text" name="ZTTAT" id="ZTTAT" value="">
				<input type="text" name="P_GUBUN" id="P_GUBUN" value="${data.P_GUBUN}" />
				
				<section>
				<div class="tbl_box">
					<table cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="20%" />
							<col />
						</colgroup>
						<tr>
							<th style="text-align: left;">* 상호</th>
							<td style="text-align: left;">${data.ENT}</td>
						</tr>
						<tr>
							<th style="text-align: left;">* 거래처번호</th>
							<td style="text-align: left;">${data.ENT_CODE}</td>
						</tr>
						<tr>
							<th style="text-align: left;">* 사업자등록번호</th>
							<td style="text-align: left;">${data.REG_NO}</td>
						</tr>
						<tr>
							<th style="text-align: left;">* 발행일자</th>
							<td>
								<input class="calendar dtp" type="text" name="sdate" id="sdate" readonly autocomplete="off" value="<c:choose><c:when test="${empty req_data.sdate}"><%=sDate%></c:when><c:otherwise>${req_data.sdate}</c:otherwise></c:choose>" readonly>
								~
								<input class="calendar dtp" type="text" name="edate" id="edate" readonly autocomplete="off" value="<c:choose><c:when test="${empty req_data.edate}"><%=toDay%></c:when><c:otherwise>${req_data.edate}</c:otherwise></c:choose>" readonly>
							</td>
						</tr>
					</table>
				</div>
				</section>
				<div class="btn_wrap">
					<button class="btn btn_search" id="search_btn" type="">조회</button>
					<button class="btn" onclick="self.close();">닫기</button>
				</div>
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
						</colgroup>
						<tr>
							<th align="center">선택</th>
							<th align="center">상호</th>
							<th>발행일자</th>
							<th>공급가액</th>
							<th>세액</th>
							<th>총금액</th>
						</tr>
						<c:if test="${fn:length(list) > 0}">
							<c:forEach var="list" items="${list}" varStatus="i">
								<tr onclick="fnSendData(${i.index+1});" style="cursor: pointer;">
									<td>${(pagination.curPage-1) * pagination.pageSize + (i.index+1)}</td>
									<!--  <td><input type="radio" id="chk_i" name="chk_i" value="${list.HWBAS}'&'${list.ZDATE}'&'${list.HWSTE}'&'${list.ZTTAT}"></td>-->
									<td style="text-align: left;">${list.ZSPCN}<input type="hidden" name="ZSPCN" id="ZSPCN" value="${list.ZSPCN}"></td>
									<td style="text-align: center;">${list.ZDATE}<input type="hidden" name="ZDATE" id="ZDATE" value="${list.ZDATE}"></td>
									<td style="text-align: right;"><fmt:formatNumber value="${list.HWBAS*100}" />
										<input type="hidden" name="HWBAS" id="HWBAS" value="<fmt:formatNumber value="${list.HWBAS*100}" />">
									</td>
									<td style="text-align: right;"><fmt:formatNumber value="${list.HWSTE*100}" />
										<input type="hidden" name="HWSTE" id="HWSTE" value="<fmt:formatNumber value="${list.HWSTE*100}" />">
									</td>
									<td style="text-align: right;"><fmt:formatNumber value="${list.ZTTAT*100}" />
										<input type="hidden" name="ZTTAT" id="ZTTAT" value="<fmt:formatNumber value="${list.ZTTAT*100}" />">
									</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${fn:length(list) == 0}">
							<tr>
								<td align="center" colspan="6">조회된 내역이 없습니다</td>
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
								<c:when test="${pageNum eq pagination.getCurPage()}">
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
				<button class="btn" id="reg_btn" type="">발행</button>
				<button class="btn" onclick="self.close();">닫기</button>
			</div>
			
		</div>
	</div>
	
</body>
</html>
