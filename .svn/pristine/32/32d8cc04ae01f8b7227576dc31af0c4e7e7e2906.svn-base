<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/resources/icm/js/jquery.js"></script>
<script src="/resources/yp/js/xlsx/xlsx.full.min.js"></script>
<script src="/resources/yp/js/xlsx/FileSaver.min.js"></script>
<script>
	//공통
	//참고 출처 : https://redstapler.co/sheetjs-tutorial-create-xlsx/
	var excelHandler = {
		getExcelFileName : function() {
			return '입항스케줄.xlsx';
		},
		getSheetName : function() {
			return 'Sheet1';
		},
		getExcelData : function() {
			return document.getElementById('tableData');
		},
		getWorksheet : function() {
			return XLSX.utils.table_to_sheet(this.getExcelData());
		}
	}
	
	function s2ab(s) {
		var buf = new ArrayBuffer(s.length); //convert s to arrayBuffer
		var view = new Uint8Array(buf); //create uint8array as viewer
		for (var i = 0; i < s.length; i++)
			view[i] = s.charCodeAt(i) & 0xFF; //convert to octet
		return buf;
	}
	
	function exportExcel() {
		// step 1. workbook 생성
		var wb = XLSX.utils.book_new();
	
		// step 2. 시트 만들기 
		var newWorksheet = excelHandler.getWorksheet();
	
		// step 3. workbook에 새로만든 워크시트에 이름을 주고 붙인다.  
		XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName());
	
		// step 4. 엑셀 파일 만들기 
		var wbout = XLSX.write(wb, {
			bookType : 'xlsx',
			type : 'binary'
		});
	
		// step 5. 엑셀 파일 내보내기 
		saveAs(new Blob([ s2ab(wbout) ], {
			type : "application/octet-stream"
		}), excelHandler.getExcelFileName());
	}
	
	$(document).ready(function() {
		exportExcel();
	});
</script>
<title></title>
</head>
<body>
	<h3>입항스케줄</h3>
	<table id="tableData" border="1">
		<caption></caption>
		<thead>
			<tr>
				<th rowspan="2">No</th>
				<th rowspan="2">주문번호</th>
				<th rowspan="2">업체*</th>
				<th rowspan="2">광종*</th>
				<th rowspan="2">차수</th>
				<th rowspan="2">입고차수*</th>
				<th rowspan="2">선박명</th>
				<th rowspan="2">DMT*</th>
				<th rowspan="2">B/L입항일*</th>
				<th rowspan="2">실제입항일</th>
				<th rowspan="2">B/L입항일 Fix</th>
				<th rowspan="2">Laycan</th>
				<th colspan="2">B/L</th>
				<th rowspan="2">itinerary</th>
				<th rowspan="2">실제하역일</th>
				<th rowspan="2">하역완료</th>
				<th rowspan="2">선사</th>
				<th rowspan="2">Surveyor</th>
				<th colspan="3">지불방법</th>
			</tr>
			<tr>
				<th>수령</th>
				<th>전달</th>
				<th>T/T</th>
				<th>L/C</th>
				<th>조건</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(list) > 0}">
		<c:forEach var="list" items="${list}" varStatus="i">
			<tr>
				<td>${i.index + 1}</td>
				<td>${list.PO_NO}</td>
				<td>${list.VENDOR_NM}</td>
				<td>${list.ITEM_NM}</td>
				<td>${list.ORDER1}</td>
				<td>${list.ORDER2}</td>
				<td>${list.SHIP_NM}</td>
				<td style="text-align:right;">${list.DMT}</td>
				<td>${list.ARRIVAL_DATE}</td>
				<td>${list.SHIP_DATE}</td>
				<td>${list.ARRIVAL_DATE_FIX}</td>
				<td>${list.LAYCAN}</td>
				<td>${list.RECEIPT}</td>
				<td>${list.DELAY}</td>
				<td>${list.ITINERARY}</td>
				<td>${list.UNLOAD_DATE}</td>
				<td>${list.UNLOAD_YN}</td>
				<td>${list.SHIP_VENDOR}</td>
				<td>${list.SURVEYOR}</td>
				<td>${list.TT}</td>
				<td>${list.LC}</td>
				<td>${list.CONDITION}</td>
			</tr>
		</c:forEach>
		</c:if>
		<c:if test="${fn:length(list) == 0}">
			<tr><td align="center" colspan="21">조회된 내역이 없습니다</td></tr>
		</c:if>
		</tbody>
	</table>
</body>
</html>