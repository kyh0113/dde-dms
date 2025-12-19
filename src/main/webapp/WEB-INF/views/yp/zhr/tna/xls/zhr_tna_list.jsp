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
			return '개인 출퇴근 현황.xlsx';
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
<title>개인 출퇴근 현황</title>
</head>
<body>
	<h3>개인 출퇴근 현황</h3>
	<table id="tableData" border="1">
		<caption></caption>
		<thead>
			<tr>
				<th rowspan="2">일자</th>
				<th rowspan="2">부서</th>
				<th rowspan="2">반</th>
				<th rowspan="2">근무조</th>
				<th rowspan="2">원근무</th>
				<th rowspan="2">사번</th>
				<th rowspan="2">성명</th>
				<th rowspan="2">출근시간</th>
				<th rowspan="2">퇴근시간</th>
				<th rowspan="2">정상외 유형</th>
				<th colspan="2">시간외 근무</th>
				<th rowspan="2">비고</th>
			</tr>
			<tr>
				<th>근무유형</th>
				<th>근무시간</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(alllist) > 0}">
		<c:forEach var="list" items="${alllist}" varStatus="i">
			<tr>
				<td>
					<fmt:parseDate value="${list.DATE}" var="dateFmt" pattern="yyyyMMdd"/>
					<fmt:formatDate value="${dateFmt}" pattern="yyy/MM/dd"/>
				</td>
				<td>${list.ORGEH_T}</td>
				<td>${list.CLASS_T}</td>
				<td>${list.SCHKZ_T}</td>
				<td>${list.ZCDTX}</td>
				<td>${list.PERNR}</td>
				<td>${list.ENAME}</td>
				<td>
					<c:if test="${list.IN_TIME1 ne 0000}">
						${fn:substring(list.IN_TIME1,0,2)}
						<c:if test="${fn:substring(list.IN_TIME1,0,2) != ''}">:</c:if>
						${fn:substring(list.IN_TIME1,2,4)}
					</c:if>
				</td>
				<td>
					<c:if test="${list.OUT_TIME1 ne 0000}">
						${fn:substring(list.OUT_TIME1,0,2)}
						<c:if test="${fn:substring(list.OUT_TIME1,0,2) != ''}">:</c:if>
						${fn:substring(list.OUT_TIME1,2,4)}
					</c:if>
				</td>
				<td>${list.ATEXT}</td>
				<td>${list.ZOPER1}</td>
				<td>${list.OT_TIMES1}</td>
				<td>${list.BIGO}</td>
			</tr>
		</c:forEach>
		</c:if>
		<c:if test="${fn:length(alllist) == 0}">
			<tr><td align="center" colspan="13">조회된 내역이 없습니다</td></tr>
		</c:if>
		</tbody>
	</table>
 </body>
</html>