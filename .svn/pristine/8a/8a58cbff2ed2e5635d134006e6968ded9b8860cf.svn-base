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
<title>코드 검색</title>
<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
<script type="text/javascript" src="/resources/icm/js/custom.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
<script type="text/javascript">
	$(document).ready(function(){
	
	});
	
	function fnGoSearch(pageIndex) {
	    if (pageIndex) {
	        $("#page").val(pageIndex);
	    } else {
	        $("#page").val("1");
	    }
	    fnSearchData();
	}
	
	function fnSearchData(){
		if($("input[name=search_text]").val().length >= 2){
			$("#frm").submit();	
		}else{
			swalWarning("검색어는 2자 이상 입력하세요.");
		}
	}
	
	function fnSendData(i){
		var type = "${req_data.type}";
		var target = Number("${req_data.target}");
		if(type=="Z"){//집행부서
			$("input[name=I_GUBUN]").val("Z");
			$("input[name=ZKOSTL_"+"${req_data.target}"+"]", opener.document).val($("input[name=KOST1]:eq("+i+")").val());		//집행부서
			$("input[name=ZKTEXT_"+"${req_data.target}"+"]", opener.document).val($("input[name=VERAK]:eq("+i+")").val());		//집행부서 설명
		}else if(type=="C"){//type=="C" 코스트센터
			$("input[name=I_GUBUN]").val("C");
			$("input[name=KOSTL_"+"${req_data.target}"+"]", opener.document).val($("input[name=KOST1]:eq("+i+")").val());		//계정과목
			$("input[name=LTEXT_"+"${req_data.target}"+"]", opener.document).val($("input[name=VERAK]:eq("+i+")").val());		//계정과목 설명
			window.opener.fnAvailAMT("${req_data.target}");
		}else if(type=="R"){//예산관리 집행부서
			opener.scope.gridOptions.data[target].RORG    = $("input[name=KOST1]:eq("+i+")").val();	//집행부서
			opener.scope.gridOptions.data[target].RORGTXT = $("input[name=VERAK]:eq("+i+")").val();	//집행부서 명
		}else if(type=="B"){//예산관리 예산조직
			opener.scope.gridOptions.data[target].BORG    = $("input[name=KOST1]:eq("+i+")").val();	//예산조직
			opener.scope.gridOptions.data[target].BORGTXT = $("input[name=VERAK]:eq("+i+")").val();	//예산조직 명
		}
		
		opener.scope.gridApi.grid.refresh();
		self.close();
	}
</script>
</head>
<body>
	
	<div id="popup">
		<div class="pop_header">
			<c:if test="${req_data.type eq 'Z'}">집행부서 검색</c:if>
			<c:if test="${req_data.type eq 'C'}">코스트센터 검색</c:if>
			<c:if test="${req_data.type eq 'R'}">집행부서 검색</c:if>
			<c:if test="${req_data.type eq 'B'}">예산조직 검색</c:if>
		</div>
		<div class="pop_content">
			<form id="frm" name="frm" method="post" accept-charset="UTF-8">
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="I_GUBUN" value=""/>
				<input type="hidden" id="target" value="${req_data.target}"/>
				<input type="hidden" id="page" name="page" value=""/>
				
				<section>
	               <div class="tbl_box">
	                    <select name="search_type">
							<option value="I_KOSTL">코스트센터</option>
							<option value="I_LTEXT" selected>설명</option>
						</select>
	                    <input type="text" name="search_text" value="${req_data.search_text}"/>
	                    <a href="#" id="search_btn" onclick="fnSearchData();"><img src="/resources/yp/images/ic_search.png"></a>
	                </div>
	            </section>
			</form>	
				<section>
				<div class="lst">
					<table cellspacing="0" cellpadding="0">
						<caption style="padding-top:0px;"></caption>
						<thead>
							<tr>
								<th>번호</th>
								<th>코스트센터</th>
								<th>설명</th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${fn:length(list) > 0}">
						<c:forEach var="list" items="${list}" varStatus="i">
							<tr onclick="fnSendData(${i.index});" style="cursor:pointer;">
				<!-- 			<tr style="cursor:pointer;"> -->
								<td>${(paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage + (i.index+1)}</td>
								<td><fmt:parseNumber value="${list.KOST1}"/><input type="hidden" name="KOST1" value="<fmt:parseNumber value="${list.KOST1}"/>"></td>
								<td>${list.VERAK}<input type="hidden" name="VERAK" value="${list.VERAK}"></td>
							</tr>
						</c:forEach>
						</c:if>
						<c:if test="${fn:length(list) == 0}">
							<tr><td align="center" colspan="6">조회된 내역이 없습니다</td></tr>
						</c:if>
							
						</tbody>
					</table>
				</div>
				<div class="paginavi">
			        <ui:pagination paginationInfo="${paginationInfo}"  jsFunction="fnGoSearch" type=""/>
			    </div>
				</section>
			<div class="btn_wrap">
				<button class="btn" onclick="self.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>