package com.vicurus.it.core.viewResolver;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

import com.vicurus.it.core.icmAbstract.AbstractExcelPOIViewForICM;


public class XlsDownForICM extends AbstractExcelPOIViewForICM {

	@Override
	@SuppressWarnings({"rawtypes","unchecked"})
	protected void buildExcelDocument(Map<String, Object> model,
			Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		Map datas = (Map) model.get("datas");
		

		List<Map> dataList = (List<Map>) datas.get("dataList");
		String[] header = (String[]) datas.get("header");

		Sheet sheet = workbook.createSheet("2003");
		Row row = null;
		Cell cell = null;
		int r = 0;
		int c = 0;

		// Style for header cell
		CellStyle style = workbook.createCellStyle();
		style.setFillForegroundColor(IndexedColors.GREY_40_PERCENT.index);
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		style.setAlignment(CellStyle.ALIGN_CENTER);

		// Create header cells
		row = sheet.createRow(r++);
		
		for(int i=0; i<header.length; i++){
			cell = row.createCell(c++);
			cell.setCellStyle(style);
			cell.setCellValue(header[i]);
		}
		
		// Create data cell
		for (Map data : dataList) {
			row = sheet.createRow(r++);
			c = 0;
			Iterator<String> mapIter = data.keySet().iterator();
	        while(mapIter.hasNext()){
	            String key = mapIter.next();
	            String value = String.valueOf(data.get(key));
	            row.createCell(c++).setCellValue(value);
	        }
		}
		for (int i = 0; i < header.length; i++){
			sheet.setColumnWidth(i, header[i].length()*768);
		}
		//엑셀 출력 시작
		ServletOutputStream out = response.getOutputStream();
        workbook.write(out);
        //엑셀 출력 끝
        
        if (out != null) {
        	out.close();
        }
	}

	@Override
	protected Workbook createWorkbook() {
		// TODO Auto-generated method stub
		// 2003
		return new HSSFWorkbook();
	}
}