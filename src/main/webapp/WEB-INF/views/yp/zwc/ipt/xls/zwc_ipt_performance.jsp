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
			return '계획대비실적.xlsx';
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

		/*
		// 엑셀 포멧 샘플 - 날짜는 포멧적용 예외(자동적용됨)
		// 회계식: '#,##0'
		// 회계식(소수점: 자릿수만큼 0 붙임): '0.00'
		var colNum = XLSX.utils.decode_col("C"); // 포멧 적용 대상 
		var fmt = '#,##0'; // 회계식 포멧지정
		var range = XLSX.utils.decode_range(newWorksheet['!ref']);
		for(var i = range.s.r + 1; i <= range.e.r; ++i) {
			var ref = XLSX.utils.encode_cell({r:i, c:colNum});
			if(!newWorksheet[ref]) continue;
			if(newWorksheet[ref].t != 'n') continue;
			newWorksheet[ref].z = fmt;
		}
		 */

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
<title>계획대비실적</title>
</head>
<body>
	<h3>계획대비실적</h3>
	<table id="tableData" border="1">
		<caption></caption>
		<thead>
			<tr>
				<td rowspan="3">부서명</td>
				<td rowspan="3">거래처</td>
				<td rowspan="3">계약명</td>
				<td colspan="4">계약</td>
				<td colspan="4">실적</td>
				<td rowspan="3">차액</td>
				<td colspan="6">비교연월</td>
				<td rowspan="3">차액</td>
			</tr>
			<tr>
				<td rowspan="2">기준</td>
				<td rowspan="2">단위</td>
				<td rowspan="2">단가</td>
				<td rowspan="2">금액</td>
				<td rowspan="2">기준</td>
				<td rowspan="2">단위</td>
				<td rowspan="2">단가</td>
				<td rowspan="2">금액</td>
				<td>계약</td>
				<td colspan="4">실적</td>
				<td rowspan="2">차액</td>
			</tr>
			<tr>
				<td>금액</td>
				<td>기준</td>
				<td>단위</td>
				<td>단가</td>
				<td>금액</td>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${fn:length(alllist) > 0}">
					<c:forEach var="list" items="${alllist}" varStatus="i">
						<tr>
							<%-- s:문자, n:숫자, d:날짜 --%>
							<td t="s">${list.DEPT_NAME}</td>
							<td t="s">${list.VENDOR_NAME}</td>
							<td t="s">${list.CONTRACT_NAME}</td>
							<td t="n">${list.A_QTY}</td>
							<td t="s">${list.A_UNIT_NAME}</td>
							<td t="n">${list.A_UNIT_PRICE}</td>
							<td t="n">${list.A_AMOUNT}</td>
							<td t="n">${list.M_QTY}</td>
							<td t="s">${list.M_UNIT_NAME}</td>
							<td t="n">${list.M_UNIT_PRICE}</td>
							<td t="n">${list.M_AMOUNT}</td>
							<td t="n">${list.M_DIFF}</td>
							<td t="n">${list.CA_AMOUNT}</td>
							<td t="n">${list.CM_QTY}</td>
							<td t="s">${list.CM_UNIT_NAME}</td>
							<td t="n">${list.CM_UNIT_PRICE}</td>
							<td t="n">${list.CM_AMOUNT}</td>
							<td t="n">${list.CM_DIFF}</td>
							<td t="n">${list.CT_DIFF}</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:when test="${fn:length(alllist) == 0}">
					<tr><td align="center" colspan="19">데이터가 없습니다.</td></tr>
				</c:when>
			</c:choose>
		</tbody>
	</table>
</body>
</html>