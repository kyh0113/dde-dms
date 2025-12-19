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
<title>예산계정과목 검색</title>
<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
<script type="text/javascript" src="/resources/icm/js/custom.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
<script type="text/javascript">
	$(document).ready(function(){
		$("input[name=I_GSBER]").val($("input[name=GSBER_S]:checked", opener.document ).val());
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
		if(type == "M"){
			$("input[name=BACT_S]", opener.document).val($("input[name=BACT]:eq("+i+")").val());
		}else if(type == "B"){
			opener.scope.gridOptions.data[target].BACT    = $("input[name=BACT]:eq("+i+")").val();			//예산계정
			opener.scope.gridOptions.data[target].BACTTXT    = $("input[name=BACTTXT]:eq("+i+")").val();	//예산계정 명
			opener.parent.fnAjaxBACT("${req_data.target}");
		}else if(type == "C"){		//예산전용 등록
			$("input[name=BACT_R_"+"${req_data.target}"+"]", opener.document).val($("input[name=BACT]:eq("+i+")").val());			//예산계정
			$("input[name=BACTTXT_R_"+"${req_data.target}"+"]", opener.document).val($("input[name=BACTTXT]:eq("+i+")").val());	//예산계정 명
			opener.parent.fnAjaxBACT("${req_data.target}");
			self.close();
		}else{
			var input_val = $("input[name=BACT_S]", opener.document).val();
			if(input_val == ""){
				$("input[name=BACT_S]", opener.document).val($("input[name=BACT]:eq("+i+")").val());
			}else{
				
				if(($("input[name=BACT_S]", opener.document).val().match(/,/g) || []).length > 1){
					swalWarning("다중 검색은 3개까지 가능합니다.");
				}else{
					$("input[name=BACT_S]", opener.document).val(input_val+","+$("input[name=BACT]:eq("+i+")").val());
				}
			}	
		}
		opener.scope.gridApi.grid.refresh();
		self.close();
	}
</script>
</head>
<body>
	
	<div id="popup">
		<div class="pop_header">예산계정과목 검색</div>
		<div class="pop_content">
			<form id="frm" name="frm" method="post" accept-charset="UTF-8">
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="mode" value="written" />
				<input type="hidden" name="IGJAHR" value="" />
				<input type="hidden" name="IBELNR" value="" />
				
				<section>
	               <div class="tbl_box">
	                   <select name="search_type">
							<option value="I_BACTTXT" <c:if test="${req_data.search_type eq 'I_BACTTXT'}">selected</c:if>>계정 이름</option>
							<option value="I_BACT" <c:if test="${req_data.search_type eq 'I_BACT'}">selected</c:if>>계정 코드</option>
						</select> 
	                    <input type="text" name="search_text" value="${req_data.search_text}"/>
	                    <a href="#" id="search_btn" onclick="fnSearchData();"><img src="/resources/yp/images/ic_search.png"></a>
	                </div>
	            </section>
				
				<section>
				<div class="lst">
					<table cellspacing="0" cellpadding="0">
						<caption style="padding-top:0px;"></caption>
						<thead>
							<tr>
								<th>번호</th>
								<th>코드</th>
								<th>계정이름</th>
								<th>원가요소</th>
								<th>이름</th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${fn:length(list) > 0}">
							<c:forEach var="list" items="${list}" varStatus="i">
								<tr onclick="fnSendData(${i.index});" style="cursor:pointer;">
									<td>${i.index+1}<input type="hidden" name="AMT" value="${list.AMT}"></td>
									<td><fmt:parseNumber value="${list.BACT}"/><input type="hidden" name="BACT" value="<fmt:parseNumber value="${list.BACT}"/>"></td>
									<td>${list.BACTTXT}<input type="hidden" name="BACTTXT" value="${list.BACTTXT}"></td>
									<td>${list.KSTAR}</td>
									<td>${list.KTEXT}</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${fn:length(list) == 0}">
							<tr><td align="center" colspan="5">조회된 내역이 없습니다</td></tr>
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