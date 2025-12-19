<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>

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
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
<script type="text/javascript" src="/resources/icm/js/custom.js"></script>
<script type="text/javascript" src="/resources/icm/js/jquery.form.js"></script>
<script src="/resources/icm/js/bootstrap.min.js"></script>
<script src="/resources/icm/datepicker/js/bootstrap-datepicker.js"></script>
<link href="/resources/icm/datepicker/css/datepicker.css" rel="stylesheet" type="text/css" />
<link id="bs-css" href="/resources/icm/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/yp/css/style.css">



<title>${current_menu.menu_name}</title>

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
			}).on('changeDate', function(){
		 	$('.datepicker').hide();
		});
		
		//오늘날짜 세팅
		if($("input[name=WR_WSDATE]").val() == ""){
			$("input[name=WR_WSDATE]").val("<%=toDay%>");	
		}
		
		if($("input[name=WR_TSDATE]").val() == ""){
			$("input[name=WR_TSDATE]").val("<%=toDay%>");	
		}
		
		if($("input[name=WR_RE_DATE]").val() == ""){
			$("input[name=WR_RE_DATE]").val("<%=toDay%>");	
		}
		
		
		
		$('input').on('keydown', function(event) {
			if(event.keyCode==13) 
				return false;
		});
		
		//전자결재 연동
		$("#edoc_btn").on("click", function() {
			//var url = "http://gwdev.ypzinc.co.kr/ekp/view/form/frmFormPopup?formId=382914097278341622251"
				var url = "http://gwdev.ypzinc.co.kr/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=EF147789712019390";	//개발	
				//var url = "http://ypgw.ypzinc.co.kr/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=EF164627042833159&CALC_CODE="+codes;	//운영
				//var url = "http://gwdev.ypzinc.co.kr/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=EF164213678935652&CALC_CODE="+codes;	//개발		
				window.open(url,"전자결재","scrollbars=auto,width=1000,height=900");
			
		});
		

	});
	
	
	function updateSecondaryOptions() {
	    var WR_SYS = document.getElementById("WR_SYS");
	    var WR_TAB = document.getElementById("WR_TAB");
	    var selectedValue = WR_SYS.value;

	    // 이전에 추가된 옵션 제거
	    WR_TAB.innerHTML = "";

	    // 선택된 값에 따라 다른 옵션 추가
	    switch (selectedValue) {
		    case "그룹웨어":
	        	WR_TAB.add(new Option("계정관리", "계정관리"));
	        	WR_TAB.add(new Option("메일", "메일"));
	            WR_TAB.add(new Option("전자결재", "전자결재"));
	            WR_TAB.add(new Option("오류개선", "오류개선"));
	            WR_TAB.add(new Option("기능추가", "기능추가"));
	            WR_TAB.add(new Option("삭제요청", "삭제요청"));
	            WR_TAB.add(new Option("기타", "기타"));
	            break;
	        case "디지털시스템":
	            WR_TAB.add(new Option("권한부여", "권한부여"));
	            WR_TAB.add(new Option("삭제요청", "삭제요청"));
	            WR_TAB.add(new Option("오류개선", "오류개선"));
	            WR_TAB.add(new Option("기능추가", "기능추가"));
	            WR_TAB.add(new Option("기타", "기타"));
	            break;
	        case "SAP":
	        	WR_TAB.add(new Option("권한부여", "권한부여"));
	            WR_TAB.add(new Option("삭제요청", "삭제요청"));
	            WR_TAB.add(new Option("오류개선", "오류개선"));
	            WR_TAB.add(new Option("기능추가", "기능추가"));
	            WR_TAB.add(new Option("기타", "기타"));
	            break;
	        case "네트워크":
	        	WR_TAB.add(new Option("작업", "작업"));
	            WR_TAB.add(new Option("일반", "일반"));
	            break;
	        case "전산일반":
	        	WR_TAB.add(new Option("업무용PC", "업무용PC"));
	            WR_TAB.add(new Option("SW", "SW"));
	            WR_TAB.add(new Option("HW", "HW"));
	            WR_TAB.add(new Option("정기점검", "정기점검"));
	            WR_TAB.add(new Option("비용처리", "비용처리"));
	            WR_TAB.add(new Option("기타", "기타"));
	            WR_TAB.add(new Option("보안", "보안"));
	            break;
	        default:
	            // 기본값 처리
	            break;
	    }
	    
	}


function WREntReg() {
		if(fnRegValidation()){
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
		
			var oForm = $("#frm").serializeArray();
			var oFormArray = gPostArray(oForm);

			$.ajax({
			    url: "/yp/wr/wr_writepop_insert",
			    type: "POST",
			    cache: false,
			    async: true,
			    dataType: "json",
			    data: oFormArray,

			    success: function(result) {
	                swalSuccessCB("저장되었습니다.", function() {
	                    // SweetAlert 확인 버튼을 클릭했을 때 실행할 코드
	                    	opener.location.reload(); // 배경 창 새로고침
	                        self.close();
	                });
	            },

			    complete: function() {
			        $('.wrap-loading').addClass('display-none');
			    },
			    //beforeSend: function(xhr) {
			    //    xhr.setRequestHeader(header, token);
			    //    $('.wrap-loading').removeClass('display-none');
			    //},
			    error: function(request, status, error) {
			        console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			        swalDangerCB("실패되었습니다. 관리자에게 문의하시길 바랍니다.");
			    }
			});
			
		}
		
	}
	
function fnRegValidation() {
	
	//전산작업처리서
	if("" == $("input[name=WR_NAME]").val()){
		swalWarningCB("제목을 입력해주세요.", function(){
			$("input[name=WR_NAME]").focus();
		}); 
		return false;
	}
	
	else if("" == $("select[name=WR_SYS] :checked").val()){
		swalWarningCB("시스템을 선택해주세요.", function(){
			$("select[name=WR_SYS]").focus();
		}); 
		return false;
	}
	
	else if("" == $("input[name=WR_WORK]").val()){
		swalWarningCB("작업자를 입력해주세요.", function(){
			$("input[name=WR_WORK]").focus();
		}); 
		return false;
	}
	
	else if("" == $("input[name=WR_WEDATE]").val()){
		swalWarningCB("작업종료일자를 입력해주세요.", function(){
			$("input[name=WR_WEDATE]").focus();
		}); 
		return false;
	}
	
	else if("" == $("input[name=WR_TEDATE]").val()){
		swalWarningCB("테스트종료일자를 입력해주세요.", function(){
			$("input[name=WR_TEDATE]").focus();
		}); 
		return false;
	}
	
	else if("" == $("input[name=WR_RE_DATE]").val()){
		swalWarningCB("완료일자를 입력해주세요.", function(){
			$("input[name=WR_RE_DATE]").focus();
		}); 
		return false;
	}
	
	else if("" == $("textarea[name=WR_WORKD]").val()){
		swalWarningCB("작업내역을 입력해주세요.", function(){
			$("textarea[name=WR_WORKD]").focus();
		}); 
		return false;
	}
	
	else if("" == $("textarea[name=WR_TESTD]").val()){
		swalWarningCB("테스트내역을 입력해주세요.", function(){
			$("textarea[name=WR_TESTD]").focus();
		}); 
		return false;
	}
	
	else if("" == $("input[name=WR_CALL_DEPT]").val()){
		swalWarningCB("요청부서를 입력해주세요.", function(){
			$("input[name=WR_CALL_DEPT]").focus();
		}); 
		return false;
	}
	
	else if("" == $("input[name=WR_CALL_EMP]").val()){
		swalWarningCB("요청자를 입력해주세요.", function(){
			$("input[name=WR_CALL_EMP]").focus();
		}); 
		return false;
	}
	
	else if("" == $("input[name=WR_CK_TSDATE]").val()){
		swalWarningCB("테스트일자를 입력해주세요.", function(){
			$("input[name=WR_CK_TSDATE]").focus();
		}); 
		return false;
	}
	
	else if("" == $("textarea[name=WR_CK_TESTD]").val()){
		swalWarningCB("테스트내역을 입력해주세요.", function(){
			$("textarea[name=WR_CK_TESTD]").focus();
		}); 
		return false;
	}
	
	
	return true;
}

	
	

	
</script>


</head>


				
<body>	
<div id="popup">
	<div class="pop_header">
			전산작업 의뢰서
		</div>

	<div class="pop_content">

		<div class="fl">
			<div class="stitle">
				전산작업 의뢰서
			</div>
		</div>

		<form id="frm" name="frm" method="post">
		
		<!--의뢰서 -->
		<input type="hidden" name="WR_TYPE" id="WR_TYPE" value="C" />  
		<input type="hidden" name="WR_REPORT" id="WR_REPORT" value="N" /> 
		<input type="hidden" name="WR_FINAL" id="WR_FINAL" value="N" /> 
		<input type="hidden" name="WR_DAY" id="WR_DAY" value="<%=toDay%>" />
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" id="userDeptCd" name="userDeptCd"  value="${sessionScope.userDeptCd}">
		<input type="hidden" id="empCode" name="empCode" value="${sessionScope.empCode}">
		
		
		<div>
		<section>
		<table width="100%" class="tbl-basic">
			<colgroup>
				<col style="width:10%"/>
				<col style="width:40%"/>
				<col style="width:10%"/>
				<col style="width:40%"/>
			</colgroup>
			<tbody>
			<tr>
				<th>제목</th>
				<td colspan="3">
					<input type="text" id="WR_NAME" name="WR_NAME" style="width:980px;" value="전산작업 의뢰서 " placeholder="전산작업 의뢰서 " maxlength="70"/>
				</td>
			</tr>
			<tr>
				<th>작성부서</th>
				<td>
					<input type="text" id="WR_DEPT" name="WR_DEPT" value="${userDept}" style="background-color: #eee" readonly="readonly"/>
				</td>
				<th>작성자</th>
				<td>
					<input type="text" id="WR_EMP" name="WR_EMP" value="${userName}" style="background-color: #eee" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<th>의뢰부서</th>
				<td>
					<input type="text" id="WR_CALL_DEPT" name="WR_CALL_DEPT" value="" maxlength="10"/>
				</td>
				<th>의뢰자</th>
				<td>
					<input type="text" id="WR_CALL_EMP" name="WR_CALL_EMP" value="" maxlength="10"/>
				</td>
			</tr>
			<tr>
				<th>SYSTEM</th>
				<td>
					<select id="WR_SYS" name="WR_SYS" onchange="updateSecondaryOptions()">
						<option value="">선택</option>
					    <option value="그룹웨어">그룹웨어</option>
					    <option value="디지털시스템">디지털시스템</option>
					    <option value="SAP">SAP</option>
					    <option value="네트워크">네트워크</option>
					    <option value="전산일반">전산일반</option>
					</select>
				</td>
				<th>작업종류</th>
				<td>
					<select id="WR_TAB" name="WR_TAB">
					    <!-- 이 영역은 JavaScript로 업데이트. -->
					</select>
				</td>
			</tr>
			<tr>
				<th colspan="4">요청사항</th>
			</tr>
			<tr>
				<td colspan="4">
					<textarea id="WR_WORKD" name="WR_WORKD" style="width:1070px; height:200px;" maxlength="1000"></textarea>
				</td>
			</tr>
			<tr>
				<th>비고</th>
				<td colspan="3">
					<input type="text" id="WR_TESTD" name="WR_TESTD" style="width:980px;" value="" maxlength="300"/>
				</td>
			</tr>
			<tr>
			<th>완료희망일</th>
			<td colspan="3">
				<input type="text" class="calendar dtp" name="WR_CK_TSDATE" id="WR_CK_TSDATE" value="${date}" readonly/>
			</td>
		</tr>
		</tbody>
		</table>
		
		</div>
		</section>
		
		<section>
		<div class="btn_wrap">
			<button type="button" class="btn" onclick="javascript:WREntReg();">저장</button>
			<button class="btn" onclick="self.close();">닫기</button>
		</div>
			
		</form>
		</section>
	</div>
</div>
</body>



</html>