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
<title>광종 목록</title>
<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/resources/icm/sweetalert/js/sweetalert.min.js"></script>
<script type="text/javascript" src="/resources/icm/js/custom.js"></script>
<link rel="stylesheet" href="/resources/yp/css/style.css">
<script type="text/javascript">
	$(document).ready(function(){
		
	});
	
	function fnSearchData(){
		if($("input[name=search_text]").val().length >= 2){
			$("#frm").submit();	
		}else{
			swalWarning("검색어는 2자 이상 입력하세요.");
		}
	}
	
	function fnSendData(i){
		var target = Number("${req_data.target}");
		if(isNaN(target)){
			$("input[name=item_cd]", opener.document).val($("input[name=MIN_CD]:eq("+i+")").val());
//	 		$("input[name=item_nm]", opener.document).val($("input[name=TSHORT]:eq("+i+")").val());
			$("input[name=item_nm]", opener.document).val($("input[name=TLONG]:eq("+i+")").val());
		}else{
			opener.scope.gridOptions.data[target].ITEM_CD  = $("input[name=MIN_CD]:eq("+i+")").val();
			opener.scope.gridOptions.data[target].ITEM_NM  = $("input[name=TLONG]:eq("+i+")").val();
		}
		opener.scope.gridApi.grid.refresh();
		self.close();
	}
</script>
</head>
<body>
	
	<div id="popup">
		<div class="pop_header">광종 목록</div>
		<div class="pop_content">
			<form id="frm" name="frm" method="post" accept-charset="UTF-8">
				<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" name="pageSize" value="15" />
				<input type="hidden" name="rangeSize" value="10" />
				<input type="hidden" name="page" value="${pagination.getCurPage()}" />
				
				
				<section>
	               <div class="tbl_box">
	                    <select name="search_type">
							<option value="I_MIN_CD" selected>코드</option>
						</select>
	                    <input type="text" name="search_text" value="${req_data.search_text}"/>
	                    <a href="#" id="search_btn" onclick="fnSearchData();"><img src="/resources/yp/images/ic_search.png"></a>
	                </div>
	            </section>
				<div class="lst">
					<table cellspacing="0" cellpadding="0">
						<caption style="padding-top:0px;"></caption>
						<thead>
							<tr>
								<th>번호</th>
								<th>정광 코드</th>
								<th>short name</th>
								<th>long name</th>
								<th>원산지</th>
								<th>사용 유무</th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${fn:length(list) > 0}">
						<c:forEach var="list" items="${list}" varStatus="i">
							<tr onclick="fnSendData(${i.index});" style="cursor:pointer;">
								<td>${i.index + 1}</td>
								<td>${list.MIN_CD}<input type="hidden" name="MIN_CD" value="${list.MIN_CD}"></td>
								<td>${list.TSHORT}<input type="hidden" name="TSHORT" value="${list.TSHORT}"></td>
								<td>${list.TLONG}<input type="hidden" name="TLONG" value="${list.TLONG}"></td>
								<td>${list.ORIGIN}</td>
								<td>${list.YFLAG}</td>
							</tr>
						</c:forEach>
						</c:if>
						<c:if test="${fn:length(list) == 0}">
							<tr><td align="center" colspan="6">조회된 내역이 없습니다</td></tr>
						</c:if>
						</tbody>
					</table>
				</div>

			</form>
			<div class="btn_wrap">
				<button class="btn" onclick="self.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>