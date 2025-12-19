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
			return 'BL_LIST.xlsx';
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
<title>정광 심판 이력 종합</title>
</head>
<body>
	<h3>정광 심판 이력 종합</h3>
	<table id="tableData" border="1">
		<caption></caption>
		<thead>
			<tr>
				<th>광종</th>
				<th>SELLER</th>
				<th>입항일</th>
				<th>선박명</th>
				<th>수량</th>
				<th>로트별수량</th>
				<th>성분결과등록</th>
				<th>성분결과조정</th>
				<th>성분결과조회</th>
				<th>SELLER분석</th>
				<th>SELLER결과(g/T)</th>
				<th>SELLER비교</th>
				<th>의뢰대상조회</th>
				<th>심판판정결과</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${fn:length(alllist) > 0}">
					<c:forEach var="list" items="${alllist}" varStatus="i">
						<tr>
							<%-- s:문자, n:숫자, d:날짜 --%>
							<td t="s">${list.MATERIAL_NAME}</td>
							<td t="s">${list.SELLER_NAME}</td>
							<td t="s">${list.IMPORT_DATE}</td>
							<td t="s">${list.VESSEL_NAME}</td>
							<td t="s">${list.DMT}</td>
							<td t="s">${list.S1}</td>
							<td t="s">${list.S2}</td>
							<td t="s">${list.S3}</td>
							<td t="s">${list.S4}</td>
							<td t="s">${list.S5}</td>
							<td t="s">${list.S6}</td>
							<td t="s">${list.S7}</td>
							<td t="s">${list.S8}</td>
							<td t="s">${list.S9}</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:when test="${fn:length(alllist) == 0}">
					<tr><td align="center" colspan="7">조회된 내역이 없습니다</td></tr>
				</c:when>
			</c:choose>
		</tbody>
	</table>
</body>
</html>