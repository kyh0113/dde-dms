<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!doctype html>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<title>LME/환율 정보</title>
		<link rel="stylesheet" type="text/css" media="screen" href="/resources/yp/css/lme.css">
		<link rel="stylesheet" type="text/css" media="print" href="/resources/yp/css/lme_print.css">
		<script type="text/javascript" src="/resources/yp/js/jquery-3.4.1.min.js"></script>
		<script type="text/javascript" src="/resources/yp/js/printThis.js"></script>
		<script type="text/javascript">
		$(function() {
			//selbox selected
			var date = "${html_date}";
			$("#cbx_YY").val(date.substring(0,4)).prop("selected", true);
			$("#cbx_Mon").val(date.substring(4,6)).prop("selected", true);
			$("#cbx_DD").val(date.substring(6,8)).prop("selected", true);
			
			$(".basicTable:first td").not(".ac").each(function(i){
				var temp1 = $(this).text();
				if( isNaN( parseFloat( temp1 ) ) ) return;
				var temp = temp1.split(".");
				if(temp[1].length >5){
					temp1 = parseFloat(temp1).toFixed(2);
					$(this).text(temp1);	
				}
			});
			
			$(".basicTable:first td").filter(".ac").each(function(i){
				var temp1 = $(this).text();
				if( isNaN( parseFloat( temp1 ) ) ) return;
				var temp = temp1.split(".");
				if(temp[0].length < 2){
					temp1 = parseFloat(temp1).toFixed(5);
					$(this).text(temp1);
				}else if(temp1.length > 7){
					temp1 = parseFloat(temp1).toFixed(2);
					$(this).text(temp1);
				}
			});
			
// 			$(".basicTable:first td").each(function(i){
// 				var temp4 = $(this).text();
// 				if( isNaN( parseFloat( temp4 ) ) ) return;
// 				if(temp4.length > 6){
// 					temp4 = parseFloat(temp4).toFixed(2);
// 					$(this).text(temp4);
// 				}
// 			});
			
			$(".basicTable:eq(1) td,.basicTable:last td").not(".table_hdtd_in").each(function(i){
				var temp = $(this).text();
				if( isNaN( parseFloat( temp ) ) ) return;
				temp = parseFloat(temp).toFixed(2);
				$(this).text(temp);
			});
			
			
			$(".avg .element-value").each(function(i){
				var temp2 = $(this).text();
				if( isNaN( parseFloat( temp2 ) ) ) return;
				temp2 = parseFloat(temp2).toFixed(2);
				$(this).text(temp2);
			});
			
		});
		
		
		function search_click()
		    {
		    	var year = $("#cbx_YY option:selected").val();
		    	var mon =  $("#cbx_Mon option:selected").val();
		    	var day =  $("#cbx_DD option:selected").val();
		    	
		    	$("input[name=LME_DATE]").val(year+"-"+mon+"-"+day);
		    	var frm1 = document.frm1;
		    	
		      	frm1.target = "_self"
		      	frm1.action = "table?LME_DATE="+$("input[name=LME_DATE]").val();
		      	frm1.submit();
		    }
		    function printWindow()
		    {
		    	$("#lme_date,.content").printThis();
// 		    	var date = "${html_date}";
// 		    	var lme_date = date.substring(0,4)+"-"+date.substring(4,6)+"-"+date.substring(6,8);
// 		    	kzlme = window.open("https://www.sls.sorincorporation.com/Common/LMEPRICE.do?LME_DATE="+lme_date,"kzlme");
// 		    	kzlme.onPrint();
// 		    	kzlme.close();
		    }    
		    
	</script>
	
</head>
<body id="lme_body">
<div style="width:794px; margin:0 auto; padding:0 0;">
	<c:choose>
	<c:when test="${Data_Size eq 0}">
	    <script>
			alert('요청하신 날짜에 검색된 내용이 없습니다.');
			location.href="table"
		</script>
	</c:when>
</c:choose>
<img src="/resources/yp/images/lme/Top_Image.png" width="792px" height="83px">
<form name="frm1" id="frm1" Method="post" Target="_self"  action="table_temp" >
<table style="width:792px;">
	<tr align="right"> 
		<td width="150">
			<input type="hidden" name="LME_DATE" value=""/>
		</td>
		<td width="250" style="text-align:center;">
			<select id="cbx_YY" name="cbx_YY" size=1 style="WIDTH: 60px">
		<% 
				java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy");
				int current_year = Integer.parseInt(formatter.format(new java.util.Date()));
				 
				for(int i=current_year; i>2012; i--)
				{
					out.println("<option value="+i+"  >"+i+" </option>");
				}
		%>
			</select>
			년&nbsp;
		    <select id="cbx_Mon" name="cbx_Mon" size=1 style="WIDTH:40px">
				<option value=01  >01
				<option value=02  >02
				<option value=03  >03
				<option value=04  >04
				<option value=05  >05
				<option value=06  >06
				<option value=07  >07
				<option value=08  >08
				<option value=09  >09
				<option value=10  >10
				<option value=11  >11
				<option value=12  >12
		    </select>
		    월&nbsp;
		   <select id="cbx_DD" name="cbx_DD" size=1 style="WIDTH:40px">
			   <option value=01  >1
			   <option value=02  >2
			   <option value=03  >3
			   <option value=04  >4
			   <option value=05  >5
			   <option value=06  >6
			   <option value=07  >7
			   <option value=08  >8
			   <option value=09  >9
			   <option value=10  >10
			   <option value=11  >11
			   <option value=12  >12
			   <option value=13  >13
			   <option value=14  >14
			   <option value=15  >15
			   <option value=16  >16
			   <option value=17  >17
			   <option value=18  >18
			   <option value=19  >19
			   <option value=20  >20
			   <option value=21  >21
			   <option value=22  >22
			   <option value=23  >23
			   <option value=24  >24
			   <option value=25  >25
			   <option value=26  >26
			   <option value=27  >27
			   <option value=28  >28
			   <option value=29  >29
			   <option value=30  >30
			   <option value=31  >31
		    </select>
		      일
	    </td>
		<td width="150"> 
		  	<a href="#" onClick="javascript:search_click();return false;" ><img src="/resources/yp/images/lme/search0.png" width="61" height="28" border="0"></a> 
			<a href="#" onClick="javascript:printWindow()" ><img src="/resources/yp/images/lme/print.png" width="61" height="28" border="0"></a> 
		</td>	



	</tr>
</table>
</form>
<hr width="100%" align="left">
<BR>
<table style="width:794px;" id="lme_date">
	<tr> 
		<td align="center">
           <h1>LME DAILY PRICE</h1><br>
           <b>2023년 03월 31일</b>
         </td>
    </tr>
</table>
<div class="content hide" style="display: block;">
${content}
	
</div>
</div>
</body>
</html>
