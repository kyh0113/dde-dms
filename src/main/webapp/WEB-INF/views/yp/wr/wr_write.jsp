<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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

<script>
	
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
		
		//조회조건 default
		//오늘날짜 세팅
		if($("input[name=date]").val() == ""){
			$("input[name=date]").val("<%=toDay%>");	
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
		
		else if("" == $("input[name=WR_CALL_DEPT]").val()){
			swalWarningCB("의뢰부서를 입력해주세요.", function(){
				$("input[name=WR_CALL_DEPT]").focus();
			}); 
			return false;
		}
		
		else if("" == $("input[name=WR_CALL_EMP]").val()){
			swalWarningCB("의뢰자를 입력해주세요.", function(){
				$("input[name=WR_CALL_EMP]").focus();
			}); 
			return false;
		}
		
		
		else if("" == $("textarea[name=WR_WORKD]").val()){
			swalWarningCB("요청사항을 입력해주세요.", function(){
				$("textarea[name=WR_WORKD]").focus();
			}); 
			return false;
		}
		
		else if("" == $("input[name=WR_CK_TSDATE]").val()){
			swalWarningCB("완료희망일을 입력해주세요.", function(){
				$("input[name=WR_CK_TSDATE]").focus();
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
			전산작업 의뢰서
		</div>
	</div>
	</div>

	<form id="frm" name="frm" method="post">
	
	<input type="hidden" name="WR_TYPE" id="WR_TYPE" value="C" />
	<input type="hidden" name="WR_DAY" id="WR_DAY" value="<%=toDay%>" />
	<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" name="" id="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" id="userDeptCd" name="userDeptCd"  value="${sessionScope.userDeptCd}">
	<input type="hidden" id="empCode" name="empCode" value="${sessionScope.empCode}">	
	
	<table class="tableTypeGray">
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
<!-- 					<input type="text" id="WR_NAME" name="WR_NAME" value="" placeholder="전산작업의뢰서 - 제목"/> -->
					<input type="text" id="WR_NAME" name="WR_NAME" value="" />
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
			<tr>
				<th>의뢰부서</th>
				<td>
					<input type="text" class="wid200" id="WR_CALL_DEPT" name="WR_CALL_DEPT" value=""/>
				</td>
				<th>의뢰자</th>
				<td>
					<input type="text" class="wid200" id="WR_CALL_EMP" name="WR_CALL_EMP" value=""/>
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
					<textarea id="WR_WORKD" name="WR_WORKD" class="h200"></textarea>
				</td>
			</tr>
			<tr>
				<th>비고</th>
				<td colspan="3">
					<input type="text" id="WR_TESTD" name="WR_TESTD" value=""/>
				</td>
			</tr>
		</tbody>
		<tr>
			<th>완료희망일</th>
			<td colspan="3">
				<input type="text" class="wid120 calendar dtp" name="WR_CK_TSDATE" id="WR_CK_TSDATE" value="${date}" readonly/>
			</td>
		</tr>
	</table>
	
	<div class="btnBox">
		<button type="button" class="btnBlue" onclick="javascript:WREntReg();">저장</button>
	</div>
		
</form>		
</body>
