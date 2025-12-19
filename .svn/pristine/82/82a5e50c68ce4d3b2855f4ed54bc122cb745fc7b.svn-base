package com.vicurus.it.core.viewResolver;

import java.io.File;
import java.io.FileInputStream;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Value;

import com.vicurus.it.core.icmAbstract.AbstractExcelPOIViewForICM;
 
 
public class XlsxDownForICM extends AbstractExcelPOIViewForICM {
	
	@Value("#{config['file.templateDir']}")
	private String templateDir;
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		Map datas = (Map) model.get("datas");
		List<Map> dataList = (List<Map>) datas.get("dataList");

		String fileName = (String)datas.get("filename");
		File excelDir = new File(templateDir);
		File excelFile = new File(excelDir, fileName+".xlsx");
		
		try{
			FileInputStream fis = new FileInputStream(excelFile);
			XSSFWorkbook workbook2 = new XSSFWorkbook(fis);
			if(workbook2 != null){
				XSSFSheet sheet = workbook2.getSheetAt(0);
				Row row = null;
				Cell cell = null;
				int r = 2;		//2행까지 헤더 영역
				int c = 0;
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
				//엑셀 출력 시작
				ServletOutputStream out = response.getOutputStream();
				workbook2.write(out);
		        //엑셀 출력 끝
		        if (out != null) {
		        	out.close();
		        }
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
 
	@Override
	protected Workbook createWorkbook() {
		// TODO Auto-generated method stub
		//2007
		return new XSSFWorkbook();
	}
 
}