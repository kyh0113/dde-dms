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
			return '소급비 집계 조회.xlsx';
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
<title>소급비 집계 조회</title>
</head>
<body>
	<h3>소급비 집계 조회</h3>
	<table id="tableData" border="1">
		<caption></caption>
		<thead>
			<tr>
				<!-- 저장품 체크 없을 때 -->
				 <c:if test="${GUBUN_CODE eq '1'}">
					<th>업체명</th>
					<th>대표자</th>
					<th>소계</th>
					<th>부가세</th>
					<th>합계</th>
					<th>현재월도급비</th>
					<th>전년월도급비</th>
					<th>소급액</th>
					<th>전표번호</th>
					<th>전자결제</th>
				</c:if>
				<!-- 저장품 체크 있을 때 -->
				<c:if test="${GUBUN_CODE eq '0'}">
					<th>업체명</th>
					<th>대표자</th>
					<th>소계</th>
					<th>부가세</th>
					<th>합계</th>
					<th>현재월도급비</th>
					<th>전년월도급비</th>
					<th>소급액</th>
					<th>전표번호</th>
					<th>전자결제</th>
				</c:if>
			</tr>
		</thead>
		<tbody>
		<!-- 데이터가 존재할때 -->
		<c:if test="${fn:length(alllist) > 0}">
			<!-- 저장품 체크 없을 때 -->
			<c:if test="${GUBUN_CODE eq '1'}">
				<c:forEach var="data" items="${alllist}" varStatus="i">
					<tr>
						<td>${data.VENDOR_NAME}</td>
						<td>${data.REPRESENTATIVE}</td>
						<td>${data.SUB_TOTAL}</td>
						<td>${data.VAT}</td>
						<td>${data.TOTAL}</td>
						<td>${data.CURRENTLY_SUBCONTRACTING_COST}</td>
						<td>${data.LAST_YEAR_SUBCONTRACTING_COST}</td>
						<td>${data.RETROACT_AMOUNT}</td>
						<td>${data.SLIP_NUMBER}</td>
						<!-- 1.대기  2.승인  3.반려  4.결재요청  5.진행중  6.회수 -->
						<c:choose>
							<c:when test="${data.STATUS eq '2'}">
						        <td>O</td>
						    </c:when>
						    <c:otherwise>
						    	<td></td>
    						</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</c:if>
			<!-- 저장품 체크 있을 때 -->
			<c:if test="${GUBUN_CODE eq '0'}">
				<c:forEach var="data" items="${alllist}" varStatus="i">
					<tr>
						<td>${data.VENDOR_NAME}</td>
						<td>${data.REPRESENTATIVE}</td>
						<td>${data.SUB_TOTAL}</td>
						<td>${data.VAT}</td>
						<td>${data.TOTAL}</td>
						<td>${data.CURRENTLY_SUBCONTRACTING_COST}</td>
						<td>${data.LAST_YEAR_SUBCONTRACTING_COST}</td>
						<td>${data.RETROACT_AMOUNT}</td>
						<td>${data.SLIP_NUMBER}</td>
						<!-- 1.대기  2.승인  3.반려  4.결재요청  5.진행중  6.회수 -->
						<c:choose>
							<c:when test="${data.STATUS eq '2'}">
						        <td>O</td>
						    </c:when>
						    <c:otherwise>
						    	<td></td>
    						</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</c:if>
			
		</c:if>
		<!-- 데이터가 존재하지 않을때 -->
		<c:if test="${fn:length(alllist) == 0}">
			<tr><td align="center" colspan="10">조회된 내역이 없습니다</td></tr>
		</c:if>
		</tbody>
	</table>
 </body>
</html>