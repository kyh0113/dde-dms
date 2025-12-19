<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="WR" %>
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
<link rel="stylesheet" href="/resources/yp/css/stylecss.css">
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
		});
		
		
		//오늘날짜 세팅
		if($("input[name=WR_WSDATE]").val() == ""){
			$("input[name=WR_WSDATE]").val("<%=toDay%>");	
		}
		
		if($("input[name=WR_TSDATE]").val() == ""){
			$("input[name=WR_TSDATE]").val("<%=toDay%>");	
		}
		
		
		
		$('input').on('keydown', function(event) {
			if(event.keyCode==13) 
				return false;
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
	    
    function updateSecondaryOptions2() {
	    var WR_STS = document.getElementById("WR_STS");
	    var WR_STS_TAB = document.getElementById("WR_STS_TAB");
	    var selectedValue = WR_STS.value;

	    // 이전에 추가된 옵션 제거
	    WR_STS_TAB.innerHTML = "";

	    // 선택된 값에 따라 다른 옵션 추가
	    switch (selectedValue) {
	        case "STS 번호":
	        	WR_STS_TAB.add(new Option("STS 내역", "STS 내역"));
	            break;
	        case "형상관리 번호":
	        	WR_STS_TAB.add(new Option("형상관리 내역", "형상관리 내역"));
	            break;
	        case "접수번호":
	        	WR_STS_TAB.add(new Option("접수 내역", "접수 내역"));
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
			    url: "/yp/wr/wr_final_insert",
			    type: "POST",
			    cache: false,
			    async: true,
			    dataType: "json",
			    data: oFormArray,

			    success: function(result)
				{
					swalSuccessCB("저장되었습니다.", function() {
		       
			         // SweetAlert 확인 버튼을 클릭했을 때 실행할 코드
		             //   var formData = JSON.stringify(oFormArray); // oFormArray를 JSON 문자열로 변환
		             //   var WR_CODES = result.WR_CODES; // 여기서 WR_CODES를 가져온다고 가정
		             //   var redirectUrl = "http://gwdev.ypzinc.co.kr/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=EF165663577865476";
		             //   window.location.href = redirectUrl + "&WR_CODES=" + WR_CODES;
			        });

				},
				

			    complete: function() {
			        $('.wrap-loading').addClass('display-none');
			    },
			    beforeSend: function(xhr) {
			        xhr.setRequestHeader(header, token);
			        $('.wrap-loading').removeClass('display-none');
			    },
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
	<h2>
	${current_menu.menu_name}
		<!-- 공통 - 네비게이션 시작 -->
		<ul class="loc">
			<li>
				<img src="/resources/yp/images/ic_loc_home.png">
			</li>
			
			<c:forEach var="menu" items="${breadcrumbList}">
				<li>${menu.menu_name}</li>
			</c:forEach>
		</ul>
		<!-- 공통 - 네비게이션 종료 -->
	</h2>

	<div class="float_wrap">
	<div class="fl">
		<div class="stitle">
			전산작업 처리서
		</div>
	</div>
	</div>
	
	<form id="frm" name="frm" method="post">

	<input type="hidden" name="WR_TYPE" id="WR_TYPE" value="A" />
	<input type="hidden" name="WR_DAY" id="WR_DAY" value="<%=toDay%>" />
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" name="" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" id="userDeptCd" name="userDeptCd"  value="${sessionScope.userDeptCd}">
	<input type="hidden" id="empCode" name="empCode" value="${sessionScope.empCode}">

	<div class="float_wrap">
	
	<table class="tableTypeGray mb20">
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
					<input type="text" id="WR_NAME" name="WR_NAME" value=""/>
				</td>
			</tr>
			<tr>
				<th>작성부서</th>
				<td>
					<input type="text" class="wid200" id="WR_DEPT" name="WR_DEPT" value="${userDept}" readonly/>
				</td>
				<th>작성자</th>
				<td>
					<input type="text" class="wid200" id="WR_EMP" name="WR_EMP" value="${userName}" readonly/>
				</td>
			</tr>
	</table>
	</div>

	<div class="float_wrap">
		<div class="fl">
			<div class="stitle">
				작업 처리 내역
			</div>
		</div>
	<table class="tableTypeGray mb20">
		<colgroup>
			<col style="width:10%"/>
			<col style="width:20%"/>
			<col style="width:10%"/>
			<col style="width:20%"/>
			<col style="width:10%"/>
			<col style="width:20%"/>
		</colgroup>
		<tbody>
			<tr>
				<th>작업자</th>
				<td>
					<input type="text" class="wid200" id="WR_WORK" name="WR_WORK" value=""/>
				</td>
				<th>작업기간(시작/종료)</th>
				<td>
					<input type="text" class="wid120 calendar dtp" name="WR_WSDATE" id="WR_WSDATE" value="${date}" readonly/> 
					~ 
					<input type="text" class="wid120 calendar dtp" name="WR_WEDATE" id="WR_WEDATE" value="${date}" readonly/>
				</td>
				<th>테스트(시작/종료)</th>
				<td>
					<input type="text" class="wid120 calendar dtp" name="WR_TSDATE" id="WR_TSDATE" value="${date}" readonly/> 
					~ 
					<input type="text" class="wid120 calendar dtp" name="WR_TEDATE" id="WR_TEDATE" value="${date}" readonly/>
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
				<th>완료일</th>
				<td>
					<input type="text" class="wid120 calendar dtp" name="WR_RE_DATE" id="WR_RE_DATE" value="${date}" readonly/>
				</td>
			</tr>
			
			<tr>
				<th colspan="6">작업내역</th>
			</tr> 
			<tr>
				<td colspan="6">
					<textarea id="WR_WORKD" name="WR_WORKD" class="h150"></textarea>
				</td>
			</tr>
			
			<tr>
				<th colspan="6">테스트내역</th>
			</tr>
			<tr>
				<td colspan="6">
					<textarea id="WR_TESTD" name="WR_TESTD" class="h100"></textarea>
				</td>
			</tr>
			<tr>
				<th>
					<select id="WR_STS" name="WR_STS" onchange="updateSecondaryOptions2()">
						<option value="">선택</option>
					    <option value="STS 번호">STS 번호</option>
					    <option value="형상관리 번호">형상관리 번호</option>
					    <option value="접수번호">접수번호</option>
					</select>
				</th>
				<td>
					<input type="text" class="wid200" id="WR_STS_D" name="WR_STS_D" value=""/>
				</td>
				<th>
					<select id="WR_STS_TAB" name="WR_STS_TAB">
					    <!-- 이 영역은 JavaScript로 업데이트. -->
					</select>
				</th>
				<td colspan ="3">
					<input type="text" id="WR_STS_TAB_D" name="WR_STS_TAB_D" value=""/>
				</td>			
			</tr>
			
	</table>
	
	</div>
	
	<div class="float_wrap">
		<div class="fl">
			<div class="stitle">
				현업 테스트내역
			</div>
		</div>
	<table class="tableTypeGray mb20">
		<colgroup>
			<col style="width:10%"/>
			<col style="width:20%"/>
			<col style="width:10%"/>
			<col style="width:20%"/>
			<col style="width:10%"/>
			<col style="width:20%"/>
		</colgroup>
		<tbody>
			<tr>
				<th>요청부서</th>
				<td>
					<input type="text" class="wid200" id="WR_CALL_DEPT" name="WR_CALL_DEPT" value=""/>
				</td>
				<th>요청자</th>
				<td colspan ="3">
					<input type="text" class="wid200" id="WR_CALL_EMP" name="WR_CALL_EMP" value=""/>
				</td>
				
			</tr>
			
			<tr>
				<th>최종검수부서</th>
				<td>
					<input type="text" class="wid200" id="WR_CK_DEPT" name="WR_CK_DEPT" value=""/>
				</td>
				<th>최종검수자</th>
				<td>
					<input type="text" class="wid200" id="WR_CK_EMP" name="WR_CK_EMP" value=""/>
				</td>	
				<th>테스트일자</th>
				<td>
					<input type="text" class="wid120 calendar dtp" name="WR_CK_TSDATE" id="WR_CK_TSDATE" value="${date}" readonly/>
				</td>
			</tr>
			
			<tr>
				<th colspan="6">테스트내역</th>
			</tr>
			<tr>
				<td colspan="6">
					<textarea id="WR_CK_TESTD" name="WR_CK_TESTD" class="h100"></textarea>
				</td>
			</tr>
			
			
			
			
	</table>
	
	</div>
	
	
	<div class="btnBox">
		<button type="button" class="btnBlue" onclick="javascript:WREntReg();">저장</button>
	</div>
		
	</form>		
</body>
