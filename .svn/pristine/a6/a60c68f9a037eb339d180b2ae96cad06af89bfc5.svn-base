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
<title>□ 일일 아연 생산 현황</title>
<style>
table {
  width: 100%;
  border: 1px solid #444444;
  border-collapse: collapse;
}
th, td {
  border: 1px solid #444444;
}

</style>
</head>

<body>
	<table>
		<colgroup>
			<col width="15%" />
			<col width="15%"/>
			<col width="15%" />
			<col width="15%"/>
			<col width="15%" />
			<col width="15%"/>
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
	    	<c:forEach var="item" items="${list}" varStatus="vs" begin="0" end="2" step="1">
	    		<tr>
					<td><c:out value="${item.YYYYMM}"/></td>
					<td><c:out value="${item.TEXT}"/></td>
					<td><c:out value="${item.PLANT}"/></td>
					<td><c:out value="1"/></td>
					<td><c:out value="1"/></td>
					<td><c:out value="1"/></td>
	    		</tr>
			</c:forEach>
<!-- 	        <tr> -->
<!-- 	            <td>아연캐소드</td> -->
<!-- 	            <td>1,046</td> -->
<!-- 	            <td>1,062.152</td> -->
<!-- 	            <td>101.54%</td> -->
<!-- 	            <td>9,972.126</td> -->
<%-- 	            <td>${TEXT}</td> --%>
<!-- 	        </tr> -->
<!-- 	        <tr> -->
<!-- 	            <td>아연괴</td> -->
<!-- 	            <td>1,046</td> -->
<!-- 	            <td>1,062.152</td> -->
<!-- 	            <td>101.54%</td> -->
<!-- 	            <td>9,972.126</td> -->
<!-- 	            <td>95.34%</td> -->
<!-- 	        </tr> -->
<!-- 	        <tr> -->
<!-- 	            <td>정류기 전력원단위</td> -->
<!-- 	            <td>1,046</td> -->
<!-- 	            <td>1,062.152</td> -->
<!-- 	            <td>101.54%</td> -->
<!-- 	            <td>9,972.126</td> -->
<!-- 	            <td>95.34%</td> -->
<!-- 	        </tr> -->
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