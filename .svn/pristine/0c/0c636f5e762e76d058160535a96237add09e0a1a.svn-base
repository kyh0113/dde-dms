package com.vicurus.it.core.viewResolver;

import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.view.AbstractView;

public class ExcelDownloadXlsx extends AbstractView {
	/** logger */
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(ExcelDownloadXlsx.class);

//	/** The content type for an Excel response */
//    private static final String CONTENT_TYPE = "application/vnd.ms-excel";
//
//    public ExcelDownloadXlsx() {
//        setContentType(CONTENT_TYPE);
//    }
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("---- ExcelDownloadXlsx Start ----");
		
		try{
		
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
				fileName = "엑셀다운로드" + "_" + today + ".xlsx";
			}else{
				fileName = excelMap.get("excel_name").toString() + "_" + today + ".xlsx";
			}
			
			if(userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1){
				fileName = URLEncoder.encode(fileName, "utf-8");
			}else{
				fileName = new String(fileName.getBytes("utf-8"), "iso-8859-1");
			}
			
	//		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
			response.setHeader("Content-Transfer-Encoding", "binary");
			//엑셀 파일명 생성 끝
			
			
			//WORKBOOK 생성
			Workbook workbook = new XSSFWorkbook();
	
			//SHEET 생성
			XSSFSheet sheet = createFirstSheet((XSSFWorkbook) workbook);
			createColumnLabel((XSSFWorkbook) workbook, sheet, (String)excelMap.get("excel_header_kr"));
			
			Object tempStr = null;
			List temp_list = new ArrayList<String>();
			for(int j=0; j < excelList.size(); j++){
				
				Map tempMap = (Map)excelList.get(j);
				
				for(int k=0; k < excelHeaderCnt(excelMap); k++){
					
					 //Null값 체킹 시작//
					 boolean isContains = tempMap.containsKey(excelHeaderName(excelMap, k));
	
	                 if ( isContains ) {
//	                	 tempStr = String.valueOf(tempMap.get(excelHeaderName(excelMap, k)));
	                	 tempStr = tempMap.get(excelHeaderName(excelMap, k));
	                 } else {
	                	 tempStr = "";
	                 }
	                 //Null값 체킹 끝//
	
//	                 temp_list.add(tempStr.toString());		
	                 temp_list.add(tempStr);		
				}
				createPageRow(sheet, temp_list, j); //ROW값 생성
				temp_list.clear();					//리스트 초기화
				
			}
			
			//엑셀 출력 시작
			ServletOutputStream out = response.getOutputStream();
	        workbook.write(out);
	        //엑셀 출력 끝
	        
	        if (out != null) {
	        	out.close();
	        }
    } catch (Exception e) {
        System.out.println("ExcelToXLSL FAILED!");
    	throw e;
    }

	}
	
	
	@SuppressWarnings({ "rawtypes" })
	private int excelHeaderCnt(Map excelMap){		//엑셀헤더개수
		String temp = (String)excelMap.get("excel_header_eng");
		String temp_array[] =  temp.split("@");
		int head_cnt = (Integer)temp_array.length;
		
		return head_cnt;
	}
	
	@SuppressWarnings({ "rawtypes" })
	private String excelHeaderName(Map excelMap, int rowNum){	//엑셀헤더영문명(Map에서 데이터 가져올때 쓰임)
		String temp = (String)excelMap.get("excel_header_eng");
		String temp_array[] =  temp.split("@");
		temp = temp_array[rowNum];
		
		return temp;
	}
	
	private XSSFSheet createFirstSheet(XSSFWorkbook workbook){	//엑셀 시트 생성
		XSSFSheet sheet = (XSSFSheet) workbook.createSheet();
		workbook.setSheetName(0, "Sheet1");
		sheet.setColumnWidth(1, 256*30);
		return sheet;
	}
	
	private void createColumnLabel(XSSFWorkbook workbook, XSSFSheet sheet, String header){	//엑셀 헤더 생성
		XSSFFont fontcolor =  (XSSFFont) workbook.createFont();
		fontcolor.setColor(Font.COLOR_NORMAL);
		fontcolor.setBoldweight(Font.BOLDWEIGHT_BOLD);
		
		XSSFCellStyle cellStyle = (XSSFCellStyle) workbook.createCellStyle();
		cellStyle.setFont(fontcolor);
		cellStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		cellStyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		
		XSSFRow firstRow = (XSSFRow) sheet.createRow(0);

		String[] tempStr =  header.split("@");
		
		XSSFCell cell = (XSSFCell) firstRow.createCell(0);
		cell.setCellValue(tempStr[0]);
		cell.setCellStyle(cellStyle);
		
		for(int i=1; i < tempStr.length; i++){
			cell = (XSSFCell) firstRow.createCell(i);
			cell.setCellValue(tempStr[i]);
			cell.setCellStyle(cellStyle);
		}
	
	}
	
	@SuppressWarnings("rawtypes")
	private void createPageRow(XSSFSheet sheet, List excelList, int rowNum){
		XSSFRow row = (XSSFRow) sheet.createRow(rowNum + 1);	//엑셀 ROW생성
		XSSFCell cell = (XSSFCell) row.createCell(0);			//엑셀 CELL생성
		cell.setCellType(Cell.CELL_TYPE_FORMULA);
		if(excelList.get(0) instanceof BigDecimal){
			cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//			logger.debug("숫자: {}", excelList.get(0));
			cell.setCellValue(((BigDecimal)excelList.get(0)).longValue());
		}else if(excelList.get(0) instanceof Long){
			cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//			logger.debug("숫자: {}", excelList.get(0));
			cell.setCellValue((Long)excelList.get(0));
		}else if(excelList.get(0) instanceof Integer){
			cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//			logger.debug("숫자: {}", excelList.get(0));
			cell.setCellValue((Integer)excelList.get(0));
		}else if(excelList.get(0) instanceof Float){
			cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//			logger.debug("숫자: {}", excelList.get(0));
			cell.setCellValue((Float)excelList.get(0));
		}else if(excelList.get(0) instanceof Double){
			cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//			logger.debug("숫자: {}", excelList.get(0));
			cell.setCellValue((Double)excelList.get(0));
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
			cell = (XSSFCell) row.createCell(i);
			cell.setCellType(Cell.CELL_TYPE_FORMULA);
			if(excelList.get(i) instanceof BigDecimal){
				cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//				logger.debug("숫자: {}", excelList.get(i));
				cell.setCellValue(((BigDecimal)excelList.get(i)).longValue());
			}else if(excelList.get(i) instanceof Long){
				cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//				logger.debug("숫자: {}", excelList.get(i));
				cell.setCellValue((Long)excelList.get(i));
			}else if(excelList.get(i) instanceof Integer){
				cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//				logger.debug("숫자: {}", excelList.get(i));
				cell.setCellValue((Integer)excelList.get(i));
			}else if(excelList.get(i) instanceof Float){
				cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//				logger.debug("숫자: {}", excelList.get(i));
				cell.setCellValue((Float)excelList.get(i));
			}else if(excelList.get(i) instanceof Double){
				cell.setCellType(Cell.CELL_TYPE_NUMERIC);
//				logger.debug("숫자: {}", excelList.get(i));
				cell.setCellValue((Double)excelList.get(i));
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
