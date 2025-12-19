package com.vicurus.it.core.viewResolver;

import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Font;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.view.document.AbstractExcelView;

public class ExcelDownloadXls extends AbstractExcelView {
	/** logger */
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(ExcelDownloadXls.class);
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected void buildExcelDocument(Map<String, Object> model,HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		//System.out.println("---- ExcelDownloadXls Start ----");	
		
		String userAgent = request.getHeader("User-Agent");
		String fileName = "";
		
		Map excelMap = (Map)model.get("excelList");
		List<Map> excelList = (List<Map>)excelMap.get("excelList");
		

		//엑셀 파일명에 붙일 현재시간 생성 시작
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy_MM_dd_HH_mm_ss");
		String today = dateFormat.format(calendar.getTime());
		//엑셀 파일명에 붙일 현재시간 생성 끝

		//엑셀 파일명 생성 시작
		if(excelMap.get("excel_name").equals("") || excelMap.get("excel_name").equals(null)){
			fileName = "엑셀다운로드" + "_" + today + ".xls";
		}else{
			fileName = excelMap.get("excel_name").toString() + "_" + today + ".xls";
		}
		
		if(userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1){
			fileName = URLEncoder.encode(fileName, "utf-8");
		}else{
			fileName = new String(fileName.getBytes("utf-8"), "iso-8859-1");
		}
		
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		//엑셀 파일명 생성 끝
	
		
		
		//WORKBOOK 생성
		HSSFSheet sheet = createFirstSheet(workbook);
		createColumnLabel(workbook, sheet, (String)excelMap.get("excel_header_kr"));
		
		Object tempStr = null;
		List temp_list = new ArrayList();
		HSSFCellStyle xcs = workbook.createCellStyle();
		
		for(int j=0; j < excelList.size(); j++){
			
			Map tempMap = (Map)excelList.get(j);
			
			for(int k=0; k < excelHeaderCnt(excelMap); k++){
				
				 //Null값 체킹 시작//
				 boolean isContains = tempMap.containsKey(excelHeaderName(excelMap, k));

                 if ( isContains ) {
//                	 tempStr = String.valueOf(tempMap.get(excelHeaderName(excelMap, k)));
                	 tempStr = tempMap.get(excelHeaderName(excelMap, k));
                 } else {
                	 tempStr = "";
                 }
                 //Null값 체킹 끝//
//                 temp_list.add(tempStr.toString());		
                 temp_list.add(tempStr);		
			}
			createPageRow(sheet, temp_list, j, workbook, xcs); //ROW값 생성
			temp_list.clear();					//리스트 초기화
			
		}
		
	}
	
	@SuppressWarnings("rawtypes")
	private int excelHeaderCnt(Map excelMap){		//엑셀헤더개수
		String temp = (String)excelMap.get("excel_header_eng");
		String temp_array[] =  temp.split("@");
		int head_cnt = (Integer)temp_array.length;
		
		return head_cnt;
	}
	
	@SuppressWarnings("rawtypes")
	private String excelHeaderName(Map excelMap, int rowNum){	//엑셀헤더영문명(Map에서 데이터 가져올때 쓰임)
		String temp = (String)excelMap.get("excel_header_eng");
		String temp_array[] =  temp.split("@");
		temp = temp_array[rowNum];
		
		return temp;
	}
	
	private HSSFSheet createFirstSheet(HSSFWorkbook workbook){	//엑셀 시트 생성
		HSSFSheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "Sheet1");
		//sheet.setColumnWidth(1, 256*30);
		return sheet;
	}
	
	private void createColumnLabel(HSSFWorkbook workbook, HSSFSheet sheet, String header){	//엑셀 헤더 생성
		HSSFFont fontcolor = workbook.createFont();
		fontcolor.setColor(Font.COLOR_NORMAL);
		fontcolor.setBoldweight(Font.BOLDWEIGHT_BOLD);
		
		HSSFCellStyle cellStyle = workbook.createCellStyle();
		cellStyle.setFont(fontcolor);
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		
		HSSFRow firstRow = sheet.createRow(0);

		String[] tempStr =  header.split("@");
		
		HSSFCell cell = firstRow.createCell(0);
		cell.setCellValue(tempStr[0]);
		cell.setCellStyle(cellStyle);
		
		for(int i=1; i < tempStr.length; i++){
			cell = firstRow.createCell(i);
			cell.setCellValue(tempStr[i]);
			cell.setCellStyle(cellStyle);
		}
	
	}
	
	@SuppressWarnings("rawtypes")
	private void createPageRow(HSSFSheet sheet, List excelList, int rowNum, HSSFWorkbook workbook, HSSFCellStyle xcs){
		HSSFRow row = sheet.createRow(rowNum + 1);	//엑셀 ROW생성
		HSSFCell cell = row.createCell(0);			//엑셀 CELL생성
		cell.setCellType(Cell.CELL_TYPE_FORMULA);
		BigDecimal big1 = null;
		BigDecimal big2 = null;
//		if(excelList.get(0) instanceof BigDecimal){
//			cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//			logger.debug("숫자1: {}", excelList.get(0));
//			logger.debug("숫자1: {}", ((BigDecimal)excelList.get(0)).longValue());
//			cell.setCellValue(((BigDecimal)excelList.get(0)).longValue());
//		}else if(excelList.get(0) instanceof Long){
//			cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//			logger.debug("숫자2: {}", excelList.get(0));
//			cell.setCellValue((Long)excelList.get(0));
//		}else if(excelList.get(0) instanceof Integer){
//			cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//			logger.debug("숫자3: {}", excelList.get(0));
//			cell.setCellValue((Integer)excelList.get(0));
//		}else if(excelList.get(0) instanceof Float){
//			cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//			logger.debug("숫자4: {}", excelList.get(0));
//			cell.setCellValue((Float)excelList.get(0));
//		}else if(excelList.get(0) instanceof Double){
//			cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//			logger.debug("숫자5: {}", excelList.get(0));
//			cell.setCellValue((Double)excelList.get(0));
//		}else{
		if(excelList.get(0) instanceof Integer){
			cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//			logger.debug("숫자1-1: {}", excelList.get(0));
			
			big1 = new BigDecimal(excelList.get(0).toString());
			big2 = big1.subtract(new BigDecimal(big1.longValue()));
			if(big2.doubleValue() == 0.0){
//				logger.debug("Integer: {}", excelList.get(0));
				cell.setCellValue(new BigDecimal(excelList.get(0).toString()).longValue());
			}else{
//				logger.debug("Double: {}", excelList.get(0));
				cell.setCellValue((Double)excelList.get(0));
			}
		}else if(excelList.get(0) instanceof Long){
			cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//			logger.debug("숫자1-2: {}", excelList.get(0));
			
			big1 = new BigDecimal(excelList.get(0).toString());
			big2 = big1.subtract(new BigDecimal(big1.longValue()));
			if(big2.doubleValue() == 0.0){
//				logger.debug("Long: {}", excelList.get(0));
				cell.setCellValue(new BigDecimal(excelList.get(0).toString()).longValue());
			}else{
//				logger.debug("Double: {}", excelList.get(0));
				cell.setCellValue((Double)excelList.get(0));
			}
		}else if(excelList.get(0) instanceof Float){
			xcs.setDataFormat(workbook.createDataFormat().getFormat("0.##"));
			cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//			logger.debug("숫자2: {}", excelList.get(0));
			
			big1 = new BigDecimal(excelList.get(0).toString());
			big2 = big1.subtract(new BigDecimal(big1.longValue()));
			if(big2.doubleValue() == 0.0){
//				logger.debug("Long: {}", excelList.get(0));
				cell.setCellValue(new BigDecimal(excelList.get(0).toString()).longValue());
			}else{
//				logger.debug("Double: {}", excelList.get(0));
				cell.setCellValue((Double)excelList.get(0));
			}
		}else if(excelList.get(0) instanceof Double){
			xcs.setDataFormat(workbook.createDataFormat().getFormat("0.##"));
			cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//			logger.debug("숫자3: {}", excelList.get(0));
			
			big1 = new BigDecimal(excelList.get(0).toString());
			big2 = big1.subtract(new BigDecimal(big1.longValue()));
			if(big2.doubleValue() == 0.0){
//				logger.debug("Long: {}", excelList.get(0));
				cell.setCellValue(new BigDecimal(excelList.get(0).toString()).longValue());
			}else{
//				logger.debug("Double: {}", excelList.get(0));
				cell.setCellValue((Double)excelList.get(0));
			}
		}else if(excelList.get(0) instanceof BigDecimal){
			cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//			logger.debug("숫자4: {}", excelList.get(0));
			
			big1 = new BigDecimal(excelList.get(0).toString());
			big2 = big1.subtract(big1.setScale(0, BigDecimal.ROUND_DOWN));
//			logger.debug("big2.doubleValue() -> {}", big2.doubleValue());
			if(big2.doubleValue() == 0.0){
//				logger.debug("Long: {}", excelList.get(0));
				cell.setCellValue(new BigDecimal(excelList.get(0).toString()).longValue());
			}else{
//				logger.debug("Double: {}", excelList.get(0));
				cell.setCellValue(((BigDecimal)excelList.get(0)).doubleValue());
			}
		}else{
			if(excelList.get(0) == null){
				cell.setCellType(Cell.CELL_TYPE_BLANK);
//				logger.debug("공백: {}", excelList.get(0));
				cell.setCellValue("");
			}else{
				cell.setCellType(Cell.CELL_TYPE_STRING);
//				logger.debug("일반: {}", excelList.get(0));
				cell.setCellValue(excelList.get(0).toString());
			}
		}
		for(int i=1; i < excelList.size(); i++){
			cell = row.createCell(i);
			cell.setCellType(Cell.CELL_TYPE_FORMULA);
//			if(excelList.get(i) instanceof BigDecimal){
//				cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//				HSSFCellStyle xcs = workbook.createCellStyle();
//				xcs.setDataFormat(workbook.createDataFormat().getFormat("#.##"));
//				logger.debug("숫자1: {}", excelList.get(i));
//				logger.debug("숫자1: {}", ((BigDecimal)excelList.get(i)).longValue());
//				cell.setCellValue(((BigDecimal)excelList.get(i)).longValue());
//				cell.setCellStyle(xcs);
//			}
			if(excelList.get(i) instanceof Integer){
				cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//				logger.debug("숫자1-1: {}", excelList.get(i));
				
				big1 = new BigDecimal(excelList.get(i).toString());
				big2 = big1.subtract(new BigDecimal(big1.longValue()));
				if(big2.doubleValue() == 0.0){
//					logger.debug("Integer: {}", excelList.get(i));
					cell.setCellValue(new BigDecimal(excelList.get(i).toString()).longValue());
				}else{
//					logger.debug("Double: {}", excelList.get(i));
					cell.setCellValue((Double)excelList.get(i));
				}
			}else if(excelList.get(i) instanceof Long){
				cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//				logger.debug("숫자1-2: {}", excelList.get(i));
				
				big1 = new BigDecimal(excelList.get(i).toString());
				big2 = big1.subtract(new BigDecimal(big1.longValue()));
				if(big2.doubleValue() == 0.0){
//					logger.debug("Long: {}", excelList.get(i));
					cell.setCellValue(new BigDecimal(excelList.get(i).toString()).longValue());
				}else{
//					logger.debug("Double: {}", excelList.get(i));
					cell.setCellValue((Double)excelList.get(i));
				}
			}else if(excelList.get(i) instanceof Float){
				xcs.setDataFormat(workbook.createDataFormat().getFormat("0.##"));
				cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//				logger.debug("숫자2: {}", excelList.get(i));
				
				big1 = new BigDecimal(excelList.get(i).toString());
				big2 = big1.subtract(new BigDecimal(big1.longValue()));
				if(big2.doubleValue() == 0.0){
//					logger.debug("Long: {}", excelList.get(i));
					cell.setCellValue(new BigDecimal(excelList.get(i).toString()).longValue());
				}else{
//					logger.debug("Double: {}", excelList.get(i));
					cell.setCellValue((Double)excelList.get(i));
				}
			}else if(excelList.get(i) instanceof Double){
				xcs.setDataFormat(workbook.createDataFormat().getFormat("0.##"));
				cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//				logger.debug("숫자3: {}", excelList.get(i));
				
				big1 = new BigDecimal(excelList.get(i).toString());
				big2 = big1.subtract(new BigDecimal(big1.longValue()));
//				logger.debug("big2.doubleValue() -> {}", big2.doubleValue());
				if(big2.doubleValue() == 0.0){
//					logger.debug("Long: {}", excelList.get(i));
					cell.setCellValue(new BigDecimal(excelList.get(i).toString()).longValue());
				}else{
//					logger.debug("Double: {}", excelList.get(i));
					cell.setCellValue((Double)excelList.get(i));
				}
			}else if(excelList.get(i) instanceof BigDecimal){
				cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//				logger.debug("숫자4: {}", excelList.get(i));
				
				big1 = new BigDecimal(excelList.get(i).toString());
				big2 = big1.subtract(big1.setScale(0, BigDecimal.ROUND_DOWN));
//				logger.debug("big2.doubleValue() -> {}", big2.doubleValue());
				if(big2.doubleValue() == 0.0){
//					logger.debug("Long: {}", excelList.get(i));
					cell.setCellValue(new BigDecimal(excelList.get(i).toString()).longValue());
				}else{
//					logger.debug("Double: {}", excelList.get(i));
					cell.setCellValue(((BigDecimal)excelList.get(i)).doubleValue());
				}
			}else{
				if(excelList.get(i) == null){
					cell.setCellType(Cell.CELL_TYPE_BLANK);
//					logger.debug("공백: {}", excelList.get(i));
					cell.setCellValue("");
				}else{
					cell.setCellType(Cell.CELL_TYPE_STRING);
//					logger.debug("일반: {}", excelList.get(i));
					cell.setCellValue(excelList.get(i).toString());
				}
			}		
		}
	}


	
	
}
