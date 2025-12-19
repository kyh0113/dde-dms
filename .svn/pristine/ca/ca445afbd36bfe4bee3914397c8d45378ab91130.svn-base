package com.vicurus.it.core.viewResolver;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

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

public class ExcelUploadXlsx {

	public String[][] simpleExcelRead(File targetFile) throws Exception {

		Workbook workbook = null;
		Sheet sheet = null;

		String[][] data = null;

		try {
			workbook = Workbook.getWorkbook(targetFile);     			// 존재하는 엑셀파일 경로를 지정
			sheet = workbook.getSheet(0);                               // 첫번째 시트를 지정합니다.

			int rowCount = sheet.getRows();								// 총 로우수를 가져옵니다.
			int colCount = sheet.getColumns();							// 총 열의 수를 가져옵니다.

			if(rowCount <= 0) {
				throw new Exception("읽을 데이터가 엑셀에 존재하지 않습니다.");
			}

			data = new String[rowCount][colCount];

			//엑셀데이터를 배열에 저장
			for(int i = 0 ; i < rowCount ; i++) {
				for(int k = 0 ; k < colCount ; k++) {
					Cell cell =sheet.getCell(k, i);						// 해당위치의 셀을 가져오는 부분입니다.
					if(cell == null) continue;
					data[i][k] = cell.getContents();					// 가져온 셀의 실제 콘텐츠 즉, 데이터(문자열)를 가져오는 부분입니다.
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			try {
				if(workbook != null) workbook.close();
			} catch (Exception e) {
			}
		}
		return data;
	}
}