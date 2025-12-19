package com.vicurus.it.core.viewResolver;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.ss.usermodel.FormulaEvaluator;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

public class ExcelUploadXls {

	/**
	 * POI 방식으로 .XLS 파일 읽기
	 * @param targetFile
	 * @return excelList
	 * @throws Exception
	 */
	public Map xlsExcelRead(File targetFile) throws Exception {

		FileInputStream fis = new FileInputStream(targetFile);
		HSSFWorkbook workbook = new HSSFWorkbook(fis);							//워크북 객체 생성
		FormulaEvaluator evaluator = workbook.getCreationHelper().createFormulaEvaluator(); // 수식 계산 시 필요!!!!!!
		
		List excelList = new ArrayList();										//엑셀데이터 담을 리스트
		Map excelMap = new HashMap();											//엑셀데이터 담을 맵
		int rowindex=0;															//행 인덱스
		int columnindex=0;														//열 인덱스
		
		try{
			HSSFSheet sheet = workbook.getSheetAt(0);							//첫번째 시트 지정
			
			int rows = sheet.getPhysicalNumberOfRows();							//행의 수
			
			//**************************************** 엑셀 정합성 체크 시작 ****************************************
			if(rows <= 1) {														//데이터 없는 경우 리턴!!
				excelMap.put("excel_result_code", "20");						//리절트코드는 20번!!
				return excelMap;														
			}
			
			HSSFRow chkRow = sheet.getRow(0);									//헤더의 로우
			int chkCells = chkRow.getPhysicalNumberOfCells();					//헤더의 셀

			if(chkCells != 10){													//10개의 컬럼의 엑셀양식 아니면 리턴!!
				excelMap.put("excel_result_code", "30");						//리절트코드는 30번!!					
				return excelMap;			
			}
			//**************************************** 엑셀 정합성 체크   끝 ****************************************
			
			
			
			for(rowindex = 1; rowindex < rows; rowindex++){						//첫번째 행은 헤더, 2행부터 읽기
			    
				HSSFRow row = sheet.getRow(rowindex);							//행을 읽는다
				
				if(row != null){
					
					//int cells = row.getPhysicalNumberOfCells();				//셀의 수		
					
					Map cellMap = new HashMap();								//셀의 내용을 담을 맵
					
					for(columnindex = 0; columnindex <= chkCells; columnindex++){
						
						String value="";    									//셀의 내용을 담을 변수
						DecimalFormat df = new DecimalFormat();	
						
			            HSSFCell cell = row.getCell(columnindex);				//셀값을 읽는다	           
			            
			            if(cell == null){										//데이터 NULL인 경우 공백으로 수정
			                //continue;	
			                value = "";												
			            }else{													//타입별로 내용 읽기												
			                switch (cell.getCellType()){
			                case HSSFCell.CELL_TYPE_FORMULA:
			                	if(!(cell.toString()=="") ){
									if(evaluator.evaluateFormulaCell(cell)==HSSFCell.CELL_TYPE_NUMERIC){
										double fddata = cell.getNumericCellValue();         
										value = df.format(fddata);
									}else if(evaluator.evaluateFormulaCell(cell)==HSSFCell.CELL_TYPE_STRING){
										value = cell.getStringCellValue()+"";
									}else if(evaluator.evaluateFormulaCell(cell)==HSSFCell.CELL_TYPE_BOOLEAN){
										boolean fbdata = cell.getBooleanCellValue();         
										value = String.valueOf(fbdata);         
									}
									break; 
								} 
			                	
			                    value = cell.getCellFormula();
			                    break;
			                case HSSFCell.CELL_TYPE_NUMERIC:
			                	// cell의 값이 numeric일 경우 날짜와 숫자 두가지일 경우이다. 아래와 같이 확인     
								if (HSSFDateUtil.isCellDateFormatted(cell)){
									//SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
									SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
									String datetime=formatter.format(cell.getDateCellValue());
									//String date=datetime.substring(0,8);
									//String time=datetime.substring(8,14);
									value=datetime;
								} else{
									//double ddata = cell.getNumericCellValue();   
									//value = df.format(ddata);		//회계표시 쓸때 사용
									
									value = (int)cell.getNumericCellValue()+"";
								}
			                	
			                    //value = cell.getNumericCellValue()+"";
			                    break;
			                case HSSFCell.CELL_TYPE_STRING:			                	
			                    value = cell.getStringCellValue()+"";
			                    break;
			                case HSSFCell.CELL_TYPE_BLANK:
			                    value = "";
			                    break;
			                case HSSFCell.CELL_TYPE_ERROR:
			                    value = cell.getErrorCellValue()+"";
			                    break;
			                case HSSFCell.CELL_TYPE_BOOLEAN:
			                	boolean bdata = cell.getBooleanCellValue();         
								value = String.valueOf(bdata);
			                    break;    
			                    
			                }
			            }
			            //******************** 엑셀 필수 컬럼 체크 시작 ********************
			            if(columnindex == 0 && value == ""){						//사원번호 컬럼이 null인 경우
			            	excelMap.put("excel_result_code", "40");				//리절트코드는 40번!!
			            	return excelMap;	
			            } 
			            
			            if(columnindex == 2 && value == ""){						//핸드폰번호 컬럼이 null인 경우
			            	excelMap.put("excel_result_code", "50");				//리절트코드는 50번!!
			            	return excelMap;
			            }     
			           //******************** 엑셀 필수 컬럼 체크   끝  ********************
			            
			            cellMap.put(Integer.toString(columnindex), value);        
			            
					}
					excelList.add(cellMap);
				}
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			try {
				fis.close();
			} catch (Exception e) {
				
			}
		}
		
		excelMap.put("excel_result_code", "1");				//리절트 코드 1은 업로드 완료!!
		excelMap.put("excelList", excelList);
		return excelMap;
	}
	
}