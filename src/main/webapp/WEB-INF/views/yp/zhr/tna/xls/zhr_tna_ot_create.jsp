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
			return '시간외근무 등록.xlsx';
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
<title>시간외근무 등록</title>
</head>
<body>
	<h3>시간외근무 등록</h3>
	<table id="tableData" border="1">
		<caption></caption>
		<thead>
			<tr>
				<th rowspan="2">상태</th>
				<th rowspan="2">근무일자</th>
				<th rowspan="2">사번</th>
				<th rowspan="2">성명</th>
				<th rowspan="2">부서</th>
				<th rowspan="2">반</th>
				<th rowspan="2">근무조</th>
				<th rowspan="2">원근무</th>
				<th rowspan="2">작업구분</th>
				<th rowspan="2">원근무자</th>
				<th rowspan="2">작업세부구분</th>
				<th rowspan="2">작업사유</th>
				<th colspan="2">실근무시간</th>
				<th rowspan="2">근무직</th>
				<th colspan="2">연장시간</th>
				<th colspan="2">휴식시간</th>
				<th rowspan="2">연장근무</th>
				<th colspan="3">등록</th>
				<th colspan="3">승인</th>
			</tr>
			<tr>
				<th>시작</th>
				<th>종료</th>
				<th>시작</th>
				<th>종료</th>
				<th>시작</th>
				<th>종료</th>
				<th>일자</th>
				<th>시간</th>
				<th>등록자</th>
				<th>일자</th>
				<th>시간</th>
				<th>승인자</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${fn:length(alllist) > 0}">
				<c:forEach var="list" items="${alllist}" varStatus="i">
					<tr>
						<td>
							<c:choose>
								<c:when test="${list.STATUS eq 'W'}">대기</c:when>
								<c:when test="${list.STATUS eq 'R'}">반려</c:when>
								<c:when test="${list.STATUS eq 'C'}">승인</c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
						</td>
						<td>${list.WORK_STARTDATE}</td>
						<td>${list.EMP_CODE}</td>
						<td>${list.EMP_NAME}</td>
						<td>${list.TEAM_NAME}</td>
						<td>${list.WORK_GROUP}</td>
						<td>${list.WORK_SHIFT}</td>
						<td>${list.ORIGIN_WORK}</td>
						<td>
							<c:choose>
								<c:when test="${list.WORK_TYPE1_CODE eq 'A'}">대체근무</c:when>
								<c:when test="${list.WORK_TYPE1_CODE eq 'B'}">연장근무</c:when>
								<c:when test="${list.WORK_TYPE1_CODE eq 'C'}">특별근무</c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
						</td>
						<td>${list.ORIGIN_WORKER_NAME}</td>
						<td>${list.WORK_TYPE2}</td>
						<td>${list.WORK_DSC}</td>
						<td>
							<c:set var="TIME_CARD1" value="${list.TIME_CARD1}" />
							<c:choose>
								<c:when test="${fn:length(TIME_CARD1) eq 6}">
									${fn:substring(TIME_CARD1, 0, 2)}:${fn:substring(TIME_CARD1, 2, 4)}
								</c:when>
								<c:otherwise>${list.TIME_CARD1}</c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:set var="TIME_CARD2" value="${list.TIME_CARD2}" />
							<c:choose>
								<c:when test="${fn:length(TIME_CARD2) eq 6}">
									${fn:substring(TIME_CARD2, 0, 2)}:${fn:substring(TIME_CARD2, 2, 4)}
								</c:when>
								<c:otherwise>${list.TIME_CARD2}</c:otherwise>
							</c:choose>
						</td>
						<td>${list.OVER_WORK}</td>
						<td>${list.TRUE_WORK_STARTTIME}</td>
						<td>${list.TRUE_WORK_ENDTIME}</td>
						<td>${list.REST_STIME}</td>
						<td>${list.REST_ETIME}</td>
						<td>${list.OVERTIME}</td>
						<td>${list.REG_DATE_DAY}</td>
						<td>${list.REG_DATE_TIME}</td>
						<td>${list.REG_WORKER_NAME}</td>
						<td>${list.CONFIRM_DATE_DAY}</td>
						<td>${list.CONFIRM_DATE_TIME}</td>
						<td>${list.CONFIRM_WORKER_NAME}</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${fn:length(alllist) == 0}">
				<tr>
					<td align="center" colspan="26">조회된 내역이 없습니다</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</body>
</html>