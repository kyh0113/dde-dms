<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
if (request.getProtocol().equals("HTTP/1.1"))
	response.setHeader("Cache-Control", "no-cache");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>일일 아연 생산 현황</title>
<style>
table {
  width: 100%;
  border: 1px solid #444444;
  border-collapse: collapse;
}
th, td {
  border: 1px solid #444444;
}
.center{
	text-align: center;
}
.right{
	text-align: right;
}
thead{
	background-color: #c8c8c8;
}


</style>
</head>

<body>
	<div style="text-align: right;">기준일 : ${list[0].BENCHMARK_DATE}</div>
	<table>
		<colgroup>
			<col width="10%" />
			<col width="14%"/>
			<col width="14%" />
			<col width="14%"/>
			<col width="14%" />
			<col width="14%"/>
		</colgroup>
		<thead>
	        <tr>
	            <th>구  분</th>
	            <th>계  획</th>
	            <th>실  적</th>
	            <th>달 성 률</th>
	            <th colspan="2">월 누 계</th>
	        </tr>
	    </thead>
	    <tbody>
	    	<c:forEach var="item" items="${list}" varStatus="vs" begin="0" end="4" step="1">
	    		<tr>
	    			<td class="<c:choose>
	    			 				<c:when test='${vs.index eq 3 || vs.index eq 4}'>right</c:when>
	    			 				<c:otherwise>center</c:otherwise>
	    			 		   </c:choose>" >
	    				<c:out value="${item.GUBUN} "/>
	    			</td>
					<td class="right"><c:out value="${item.DAILY_PLAN} "/></td>
					<td class="right"><c:out value="${item.DAILY_PERFORMANCE} "/></td>
					<td class="right"><c:out value="${item.DAILY_ACHIEVEMENT_RATE}% "/></td>
					<td class="right"><c:out value="${item.MONTHLY_PERFORMANCE} "/></td>
					<td class="right">
					<c:if test="${vs.index eq 0 || vs.index eq 1}">
						<c:out value="${item.MONTHLY_ACHIEVEMENT_RATE}% "/>
					</c:if>
					</td>
	    		</tr>
			</c:forEach>
	    </tbody>
	</table>
<script>
$(document).ready(function(){
	$("#search_btn").on("click",function(){		
		scope.reloadGrid({});
	});
	
	//비품요청 팝업
	function fnTestPopup() {
		var rows = scope.gridApi.selection.getSelectedRows();
		
		console.log(rows);
		
		/**
		 * window.open(URL, name, specs, replace)
		 */
		window.open("", "테스트팝업", "width=800, height=500");
		 
		/**
		 * fnHrefPopup(url, target, pr)
		 */
// 		fnHrefPopup("/yp/popup/test/testPop", "테스트팝업", {
// 			"gridData" : JSON.stringify(rows)
// 		});
	}
	
	/* 팝업 submit */
	function fnHrefPopup(url, target, pr) {
		//20191023_khj for csrf
		var csrf_element = document.createElement("input");
		csrf_element.name = "_csrf";
		csrf_element.value = "${_csrf.token}";
		csrf_element.type = "hidden";
		//20191023_khj for csrf
		var popForm = document.createElement("form");

		/**
		 * [form 속성]
		 * action : form 데이터를 보낼 URL
		 * target : 네이밍 된 iframe
		 */
		popForm.name = "popForm";
		popForm.method = "post";
		popForm.target = target;
		popForm.action = url;

		document.body.appendChild(popForm);

		popForm.appendChild(csrf_element);

		/**
		 * parameter를 input으로 form에 추가
		 */
		$.each(pr, function(k, v) {
			// 				console.log(k, v);
			var el = document.createElement("input");
			el.name = k;
			el.value = v;
			el.type = "hidden";
			popForm.appendChild(el);
		});

		popForm.submit();
		popForm.remove();
	}
	
	
});

</script>

</body>