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
<title>${current_menu.menu_name}</title>
<style>
.ui-grid-cell-contents{
	white-space : pre !important;
}

</style>
</head>

<spring:eval expression="@config['gw.url']" var="gw_url" />
<spring:eval expression="@systemProperties.getProperty('spring.profiles.active')" var="activeProfile" />

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
	<form>
		<!-- 20191023_khj for csrf -->
		<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
	<table border="1">
		<tr bgcolor="#696969" style="color:white" align ="center">
			<th>제목</th>
			<th>formId</th>
			<th>code</th>
			<th>전자결재</th>
	    </tr>
		<tr>
			<td>정광성분분석 성분분석 최종값</td>
		    <td><input style="width:100%;" name="formId" value="EF166441989478594"/></td>
		    <td><input style="width:100%;" name="code" value="YPCP-0001_YPMC-0021_2022-11-16"/></td>
		    <td style="display:flex; justify-content: center; align-items: center;"><div name="edoc_btn" class="ui-grid-cell-contents btn_g" style="cursor: pointer;" >전자결재</div></td>
		</tr>
		<tr>
			<td>정광성분분석 B/L통보</td>
		    <td><input style="width:100%;" name="formId" value="EF167088836245056"/></td>
		    <td><input style="width:100%;" name="code" value="YPCP-0001_YPMC-0001_2022-11-16"/></td>
		    <td style="display:flex; justify-content: center; align-items: center;"><div name="edoc_btn" class="ui-grid-cell-contents btn_g" style="cursor: pointer;" >전자결재</div></td>
		</tr>
		<tr>
			<td>정광성분분석 Seller 분석결과 송부용 조회</td>
		    <td><input style="width:100%;" name="formId" value="EF167115238248813"/></td>
		    <td><input style="width:100%;" name="code" value="YPCP-0001_YPMC-0001_2022-11-16"/></td>
		    <td style="display:flex; justify-content: center; align-items: center;"><div name="edoc_btn" class="ui-grid-cell-contents btn_g" style="cursor: pointer;" >전자결재</div></td>
		</tr>
    </table>
<script>

var gw_url = '<c:out value="${gw_url }"/>';
var active_profile = '<c:out value="${activeProfile }"/>';

$(document).ready(function(){
	$("div[name=edoc_btn]").on("click", function(){
		var $tr = $(this).parent().parent(),
			$tdes = $tr.children(),
			index = $tr.index()-1,
			form_id = $("input[name=formId]").eq(index).val(),
			code = $("input[name=code]").eq(index).val(),
			url = '';
		
		if(active_profile === 'dev' || active_profile === 'local'){
			url = `\${gw_url}/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=\${form_id}&MASTER_ID=\${code}`;
		}else if(active_profile === 'prd'){
			url = `\${gw_url}/ekp/eapp/app.do?cmd=appWrite&eappDoc.formId=\${form_id}&MASTER_ID=\${code}`;
		}
			
		console.log('[TEST]url:',url);
		window.open(url, "전자결재", "scrollbars=auto,width=1000,height=900");
	});
});

</script>

</body>