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
<title>사용금액 상세보기</title>
<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
<script type="text/javascript" src="/resources/icm/js/custom.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
<script type="text/javascript">

	$(document).ready(function(){
		
	});
	
	function fnDocumentPop(BELNR,BUDAT){
		BELNR = fnPreAddZero(BELNR);
		var w = window.open("about:blank","회계전표","width=1200,height=900,location=yes,scrollbars=yes");
		
		$.ajax({
		    url: "/yp/popup/zfi/bud/retrieveDocumentPop?BELNR="+BELNR+"&BUDAT="+BUDAT+"&_csrf="+"${_csrf.token}",	//get방식 파라메터에 csrf 토큰 삽입(없을시 403에러 유발)
		    type: "post",
		    cache:false,
		    async:true, 
		    data:$("#qfrm").serialize(),
		    dataType:"json",
		    success: function(result) {
		    	if(result.docno == ""){
		    		w.location.href = "http://ypgw.ypzinc.co.kr/ekp/view/info/infoAccSpec?bukrs="+result.bukrs+"&belnr="+BELNR+"&gjahr="+result.gjahr+"&docNo=2018년 본사/전산팀 지출품의 제 xxxxx호";
		    	}else{
		    		w.location.href = "http://ypgw.ypzinc.co.kr/ekp/view/info/infoAccSpec?bukrs="+result.bukrs+"&belnr="+BELNR+"&gjahr="+result.gjahr+"&docNo="+result.docno;
		    	}
		    },
			error:function(request,status,error){
		    	console.log("code:"+request.status+"\n"+"message:"+request.json+"\n"+"error:"+error);
		    	swalWarning("검색에 실패하였습니다.\n관리자에게 문의해주세요.");
		    }
	 	});
	}
	
	function fnPreAddZero(num){
		num = num+"";
		var length = num.length;
		for(var i=10;i>length;i--){
			num = "0" + num;
		}
		return num;
	}
	
	function fnExelDown(){
		//부모창 앵귤러 스코프 접근
		var opener_scope = window.opener.angular.element("#shds-uiGrid").scope();
		//선택된 로우 데이터 접근
		var selectedRows = opener_scope.gridApi.selection.getSelectedRows();
		console.log(selectedRows);
		$("input[name=I_GSBER]").val(selectedRows[0].GSBER);
		$("input[name=I_RORG]").val(selectedRows[0].RORG);
		$("input[name=I_BORG]").val(selectedRows[0].BORG);
		$("input[name=I_BACT]").val(selectedRows[0].BACT);
		$("input[name=I_SPMON]").val(selectedRows[0].SPMON);
		$("input[name=I_ACTIME]").val(selectedRows[0].ACTIME);
		
		$("#frm").attr("action", "/yp/popup/zfi/bud/retrieveDetailAmtAct");
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
		<div class="pop_header">사용금액 상세보기</div>
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
					<input type="button" class="btn btn_make" id="excel_btn" value="엑셀 다운로드" onclick="fnExelDown();"/>
				</div>
				
				<section>
				<div class="lst">
					<table cellspacing="0" cellpadding="0" style="width:1800px;">
						<caption style="padding-top:0px;"></caption>
						<thead>
							<tr>
								<th>지정</th>
								<th style="width:100px;">전표번호</th>
								<th style="width:80px;">참조키3</th>
								<th style="width:80px;">전기일</th>
								<th style="width:80px;">유형</th>
								<th style="width:80px;">통화</th>
								<th>전표통화액</th>
								<th>현지통화금액</th>
								<th>텍스트</th>
								<th style="width:100px;">코스트센터명</th>
								<th style="width:80px;">사업영역</th>
								<th style="width:170px;">계정명</th>
								<th style="width:80px;">손익센터</th>
								<th>반제전표</th>
								<th>WBS요소</th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${fn:length(list) > 0}">
						<c:forEach var="list" items="${list}" varStatus="i">
							<tr>
								<td>${list.ZUONR}</td>
								<td><a href="javascript:fnDocumentPop('${list.BELNR}','${list.BUDAT}');" style="text-decoration: underline;">${list.BELNR}</a></td>
								<td>${list.XREF3}</td>
								<td>${fn:substring(list.BUDAT,0,4)}.${fn:substring(list.BUDAT,4,6)}.${fn:substring(list.BUDAT,6,8)}</td>
								<td>${list.BLART}</td>
								<td>${list.WAERS}</td>
								<td style="text-align:right;"><fmt:formatNumber value="${list.DMSHB}" pattern="#,###" /></td>
								<td style="text-align:right;"><fmt:formatNumber value="${list.BWWRT}" pattern="#,###" /></td>
								<td>${list.SGTXT}</td>
				 				<td>${list.KTEXT}</td>
								<td>${list.GSBER}</td>
								<td>${list.TXT50}</td>
								<td>${list.PRCTR}</td>
								<td>${list.AUGBL}</td>
								<td>${list.PROJK}</td>
							</tr>
						</c:forEach>
						</c:if>
						<c:if test="${fn:length(list) == 0}">
							<tr><td align="center" colspan="15">조회된 내역이 없습니다</td></tr>
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