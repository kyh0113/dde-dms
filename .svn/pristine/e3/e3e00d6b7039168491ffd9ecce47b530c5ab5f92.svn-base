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
			return '거래처별 단가조회.xlsx';
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
		var BASE_YYYY = '${BASE_YYYY}';
		var VENDOR_CODE = '${VENDOR_CODE}';
		var data = {'BASE_YYYY':BASE_YYYY, 'VENDOR_CODE':VENDOR_CODE, '${_csrf.parameterName}' : '${_csrf.token}'};
		$.ajax({
			url: "/yp/zwc/rpt/select_zwc_rpt_intervention_list",
		    type: "POST",
		    cache:false,
		    async:true, 
		    dataType:"json",
		    data:data, //폼을 그리드 파라메터로 전송
		    success: function(data) {
		    	//도금비 조정안 리스트
		    	var rpt_intervention_list = data.rpt_intervention_list;
		    	//도금비 조정안 데이터 없을경우, return
		    	if(rpt_intervention_list.length == 0){
		    		var innerHtml = '<tr><td align="center" colspan="14">조회된 내역이 없습니다</td></tr>';
		    		$('.table').append(innerHtml);
		    		exportExcel();
		    		return;
		    	}
		    	
		    	//-------구분 별로 세로로 묶기위한 변수 ------------------------
		    	//구분별로 몇개 row있는지에 대한 정보 list
		    	var rpt_gubun_list = data.rpt_gubun_list;
		    	
		    	//현재 구분에서 몇번째 위치인지 판별
		    	var count = 0;
		    	//현재 진행중인 구분이 몇번째인지 판별
		    	var gubun_pos = 0;
		    	//현재 구분이 몇번 반복되는지 판별
		    	var gubun_cnt = rpt_gubun_list[gubun_pos].CNT;
		    	//-----------------------------------------------
		    	
		    	//---------소계 합계 변수 -----------------------------
		    	var sub_total_current_man_qty = 0;	//소계 현행 인원
		    	var sub_total_current_cost = 0;		//소계 현행 월도급비
				var sub_total_adjust_man_qty = 0;	//소계 조정안 인원
				var sub_total_adjust_cost = 0;	//소계 조정안 월도급비
				var sub_total_variation_rate = 0;	//소계 증감률
				
				var sum_total_current_man_qty = 0;	//합계 현행 인원
		    	var sum_total_current_cost = 0;		//합계 현행 월도급비
				var sum_total_adjust_man_qty = 0;	//합계 조정안 인원
				var sum_total_adjust_cost = 0;	//합계 조정안 월도급비
				var sum_total_variation_rate = 0;	//합계 증감률
		    	//--------------------------------------------------
		    	
		    	//----------비고 저장을 위한 TBL_WORKING_SUBC_COST_ADJUST테이블의 PK 변수들 ----------------
		    	var BASE_YYYY;
				var VENDOR_CODE;
				var CONTRACT_CODE;

		    	//도급비 조정안 row
		    	for(var i=0; i<rpt_intervention_list.length; i++){
		    		var obj = rpt_intervention_list[i];
		    		var innerHtml = "";
		    		
		    		//증감률 = (조절안 월도급비 - 현행월도급비)/(조정안 월도급비) * 100
		    		var variation_rate = 0;
		    		//조정안 월도급비가 0이 아닐경우에만 증감률 계산 
		    		if(obj.ADJUST_SUBCONTRACTING_COST != 0){
		    			variation_rate = (obj.ADJUST_SUBCONTRACTING_COST - obj.CURRENT_SUBCONTRACTING_COST)/obj.ADJUST_SUBCONTRACTING_COST * 100;
		    		}
		    		
		    		//다음 구분으로 넘어갈때
		    		//count초기화
		    		//다음 구분은 몇번 반복되는지 계산
		    		//소계 만들어주기
		    		if(i != 0 && count == rpt_gubun_list[gubun_pos].CNT){
		    			count = 0;
		    			gubun_pos++;
		    			gubun_cnt = rpt_gubun_list[gubun_pos].CNT;
		    			//소계 증감률
		    			sub_total_variation_rate = (sub_total_adjust_cost - sub_total_current_cost)/sub_total_adjust_cost * 100;
		    			//합계 증감률
						sum_total_variation_rate = (sum_total_adjust_cost - sum_total_current_cost)/sum_total_adjust_cost * 100;
		    			//소계 만들어주기
		    			innerHtml = "";
		    			innerHtml += '<tr class="sub_total">';
		    			innerHtml += '	<td class="center vertical-center">소계</td>';
		    			innerHtml += '	<td></td>';
		    			innerHtml += '	<td></td>';
		    			innerHtml += '	<td class="center vertical-center">'+sub_total_current_man_qty+'</td>';	//소계 현행 인원
		    			innerHtml += '	<td></td>';
		    			innerHtml += '	<td></td>';
		    			innerHtml += '	<td class="right vertical-center">'+sub_total_current_cost+'</td>';		//소계 현행 월도급비
		    			innerHtml += '	<td class="center vertical-center">'+sub_total_adjust_man_qty+'</td>';	//소계 조정안 인원
		    			innerHtml += '	<td></td>';
		    			innerHtml += '	<td></td>';
		    			innerHtml += '	<td class="right vertical-center">'+sub_total_adjust_cost+'</td>';		//소계 조정안 월도급비
		    			innerHtml += '	<td class="center vertical-center">'+sub_total_variation_rate+' %</td>';//소계 증감률
		    			innerHtml += '	<td></td>';
		    			innerHtml += '</tr>';
		    			$('.table').append(innerHtml);
		    			
		    			//---------소계 합계 변수 초기화 ---------
		    			sub_total_current_man_qty = 0;	
				    	sub_total_current_cost = 0;		
						sub_total_adjust_man_qty = 0;
						sub_total_adjust_cost = 0;	
						sub_total_variation_rate = 0;	
		    			//---------------------------------
						innerHtml = "";
		    		}
		    		//도급비 조정안 col
		    		innerHtml += '<tr>';
		    		for(var key in obj){
		    			//구분 데이터일경우
		    			if(key == "GUBUN_NAME"){
		    				//구분의 제일 처음만 행병합을 해준다. 
		    				//1더해주는이유 : 소계때문에
		    				if( count == 0){
			    				innerHtml += '	<td class="center vertical-center" rowspan='+(gubun_cnt+1)+'>'+obj[key]+'</td>';
		    				}
		    			}else if(key == "BASE_YYYY"){
		    				BASE_YYYY = obj[key];
		    			}else if(key == "VENDOR_CODE"){
		    				VENDOR_CODE = obj[key];
		    			}else if(key == "CONTRACT_CODE"){
		    				CONTRACT_CODE = obj[key];
		    			}else if(key == "CONTRACT_NAME"){
		    				innerHtml += '<td class="center vertical-center">'+obj[key]+'</td>';
		    			}else if(key == "DEPT_NAME"){
		    				innerHtml += '<td class="center vertical-center">'+obj[key]+'</td>';
		    			}else if(key == "UNIT_NAME"){
		    				innerHtml += '<td class="center vertical-center">'+obj[key]+'</td>';
		    			}else if(key == "CURRENT_MAN_QTY"){
		    				innerHtml += '<td class="center vertical-center">'+obj[key]+'</td>';
		    				//현행 인원 소계 계산
		    				sub_total_current_man_qty += obj[key];
		    				//현행 인원 합계 계산
		    				sum_total_current_man_qty += obj[key];
		    			}else if(key == "CURRENT_UNIT_PRICE"){
		    				innerHtml += '<td class="right vertical-center">'+obj[key]+'</td>';
		    			}else if(key == "CURRENT_QUANTITY"){
		    				innerHtml += '<td class="right vertical-center">'+obj[key]+'</td>';
		    			}else if(key == "CURRENT_SUBCONTRACTING_COST"){
		    				innerHtml += '<td class="right vertical-center">'+obj[key]+'</td>';
		    				//현행 월도급비 소계 계산
		    				sub_total_current_cost += obj[key];
		    				//현행 월도급비 합계 계산
		    				sum_total_current_cost += obj[key];
		    			}else if(key == "ADJUST_MAN_QTY"){
		    				innerHtml += '<td class="center vertical-center">'+obj[key]+'</td>';
		    				//조정안 인원 소계 계산
		    				sub_total_adjust_man_qty += obj[key];
		    				//조정안 인원 합계 계산
		    				sum_total_adjust_man_qty += obj[key];
		    			}else if(key == "ADJUST_UNIT_PRICE"){
		    				innerHtml += '<td class="right vertical-center">'+obj[key]+'</td>';
		    			}else if(key == "ADJUST_QUANTITY"){
		    				innerHtml += '<td class="right vertical-center">'+obj[key]+'</td>';
		    			}else if(key == "ADJUST_SUBCONTRACTING_COST"){
		    				innerHtml += '<td class="right vertical-center">'+obj[key]+'</td>';
		    				//조정안 월도급비 소계 계산
		    				sub_total_adjust_cost += obj[key];
		    				//조정안 월도급비 합계 계산
		    				sum_total_adjust_cost += obj[key];
		    			}else if(key == "VARIATION_RATE"){
		    				innerHtml += '<td class="center vertical-center" >'+variation_rate+' %</td>';
		    			}else if(key == "NOTE"){
		    				innerHtml += '<td>'+obj[key]+'</td>';
		    			}
		    		}
		    		innerHtml += '</tr>';
		    		$('.table').append(innerHtml);
		    		
		    		//현재 구분에서 몇번째 위치나타내기 위해서
		    		count++;
		    		
		    		//제일 마지막에는 소계와 합계 넣어주기
		    		if(i == rpt_intervention_list.length-1){
		    			
		    			//소계 증감률 계산
		    			if(sub_total_adjust_cost == 0){
		    				sub_total_variation_rate = 0; 
		    			}else{
		    				sub_total_variation_rate = (sub_total_adjust_cost - sub_total_current_cost)/sub_total_adjust_cost * 100; 
		    			}
		    			//합계 증감률 계산
		    			if(sum_total_adjust_cost == 0){
		    				sum_total_variation_rate = 0; 
		    			}else{
		    				sum_total_variation_rate = (sum_total_adjust_cost - sum_total_current_cost)/sum_total_adjust_cost * 100;		
		    			}
						
		    			//소계 만들어주기
		    			innerHtml = "";
		    			innerHtml += '<tr class="sub_total">';
		    			innerHtml += '	<td class="center vertical-center">소계</td>';
		    			innerHtml += '	<td></td>';
		    			innerHtml += '	<td></td>';
		    			innerHtml += '	<td class="center vertical-center">'+sub_total_current_man_qty+'</td>';	//소계 현행 인원
		    			innerHtml += '	<td></td>';
		    			innerHtml += '	<td></td>';
		    			innerHtml += '	<td class="right vertical-center">'+sub_total_current_cost+'</td>';		//소계 현행 월도급비
		    			innerHtml += '	<td class="center vertical-center">'+sub_total_adjust_man_qty+'</td>';	//소계 조정안 인원
		    			innerHtml += '	<td></td>';
		    			innerHtml += '	<td></td>';
		    			innerHtml += '	<td class="right vertical-center">'+sub_total_adjust_cost+'</td>';		//소계 조정안 월도급비
		    			innerHtml += '	<td class="center vertical-center">'+sub_total_variation_rate+' %</td>';//소계 증감률
		    			innerHtml += '	<td></td>';
		    			innerHtml += '</tr>';
		    			$('.table').append(innerHtml);
		    			
		    			//합계 만들어주기
		    			innerHtml = "";
		    			innerHtml += '<tr class="sum_total">';
		    			innerHtml += '	<td></td>';
		    			innerHtml += '	<td class="center vertical-center">합계</td>';
		    			innerHtml += '	<td></td>';
		    			innerHtml += '	<td></td>';
		    			innerHtml += '	<td class="center vertical-center">'+sum_total_current_man_qty+'</td>';	//합계 현행 인원
		    			innerHtml += '	<td></td>';
		    			innerHtml += '	<td></td>';
		    			innerHtml += '	<td class="right vertical-center">'+sum_total_current_cost+'</td>';		//합계 현행 월도급비
		    			innerHtml += '	<td class="center vertical-center">'+sum_total_adjust_man_qty+'</td>';	//합계 조정안 인원
		    			innerHtml += '	<td></td>';
		    			innerHtml += '	<td></td>';
		    			innerHtml += '	<td class="right vertical-center">'+sum_total_adjust_cost+'</td>';	//합계 조정안 월도급비
		    			innerHtml += '	<td class="center vertical-center">'+sum_total_variation_rate+' %</td>';//합계 증감률
		    			innerHtml += '	<td></td>';
		    			innerHtml += '</tr>';
		    			$('.table').append(innerHtml);
		    		}
		    	}
		    	
		    	exportExcel();
		    }
		}); 
		
	});
</script>
<title>업체별 도급비 조정(안)</title>
</head>
<body>
	<h3>업체별 도급비 조정(안)</h3>
	<table border="1" class="table" id="tableData" border="1">
		<colgroup>
			<col />
			<col />
			<col />
			<col />
			<col />
			<col />
			<col />
			<col />
			<col />
			<col />
			<col />
			<col />
			<col />
			<col />
		</colgroup>
		<tr class="tb-head" >
			<td rowspan="2">구분</td>
			<td rowspan="2">작업명</td>
			<td rowspan="2">팀별</td>
			<td rowspan="2">단위</td>
			<td colspan="4">현행</td>
			<td colspan="4">조정안</td>
			<td rowspan="2">증감률</td>
			<td rowspan="2">비고</td>
	    </tr>
	    <tr class="tb-head">
			<td>인원</td>
			<td>단가</td>
			<td>물량</td>
			<td>월도급비</td>
			<td>인원</td>
			<td>단가</td>
			<td>물량</td>
			<td>월도급비</td>
	    </tr>
	</table>
 </body>
</html>