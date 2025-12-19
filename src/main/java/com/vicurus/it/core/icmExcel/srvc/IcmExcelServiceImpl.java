package com.vicurus.it.core.icmExcel.srvc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.vicurus.it.core.common.Util;
import com.vicurus.it.core.icmExcel.srvc.intf.IcmExcelService;

@Repository
public class IcmExcelServiceImpl implements IcmExcelService {
	
	private static final Logger logger = LoggerFactory.getLogger(IcmExcelServiceImpl.class);
	
	//config.properties 에서 설정 정보 가져오기 시작
	private static String NAMESPACE;
			
	@Value("#{config['db.vendor']}")
	public void setNAMESPACE(String value) {
		this.NAMESPACE = value + ".";
	}
	//config.properties 에서 설정 정보 가져오기 끝
	
	@Autowired
	@Resource(name="sqlSession")
    private SqlSession query;
	
	@Override
	public List excelList(Map param) throws Exception {
		
		List resultList = query.selectList(NAMESPACE+(String) param.get("listQuery"), param);
		
		return resultList;
	}

	@Override
	@Transactional(rollbackFor={Exception.class})
	public int xlsxUpload(MultipartFile file, final MultipartHttpServletRequest request, HttpServletResponse response) throws Exception{
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		//System.out.println("[xlsxUpload]paramMap:"+paramMap);
		int result = 0;
		try {
			Map insertCellMap = new HashMap();
			List key = new ArrayList();
			String insertQuery = (paramMap.get("insertQuery")==null)?"":(String) paramMap.get("insertQuery");
			String updateQuery = (paramMap.get("updateQuery")==null)?"":(String) paramMap.get("updateQuery");
			String deleteQuery = (paramMap.get("deleteQuery")==null)?"":(String) paramMap.get("deleteQuery");
			String deleteQuery2 = (paramMap.get("deleteQuery2")==null)?"":(String) paramMap.get("deleteQuery2");
			String deleteQuery3 = (paramMap.get("deleteQuery3")==null)?"":(String) paramMap.get("deleteQuery3");
			if(!updateQuery.equals("")){
				result = query.update(NAMESPACE+updateQuery,paramMap);
			}
			if(!deleteQuery.equals("")){
				result = query.delete(NAMESPACE+deleteQuery,paramMap);
			}
			if(!deleteQuery2.equals("")){
				result = query.delete(NAMESPACE+deleteQuery2,paramMap);
			}
			if(!deleteQuery3.equals("")){
				result = query.delete(NAMESPACE+deleteQuery3,paramMap);
			}
			
			int i = 0;
			// Creates a workbook object from the uploaded excelfile
			XSSFWorkbook workbook = new XSSFWorkbook(file.getInputStream());
			
			// Creates a worksheet object representing the first sheet
			XSSFSheet worksheet = workbook.getSheetAt(0);
		
			// Reads the data in excel file until last row is encountered
			while (i <= worksheet.getLastRowNum()) {			
				// Creates an object representing a single row in excel
				XSSFRow row = worksheet.getRow(i++);
				if(i==1){
					for(int j=0; j<row.getLastCellNum(); j++){
						key.add(row.getCell(j).getStringCellValue());
					}
					//System.out.println(key.toString());
					insertCellMap.putAll(paramMap);
					continue;
				}
				if(i==2){
					continue;
				}
				if(i==3){
					continue;
				}
				
				for(int j=0; j<row.getLastCellNum(); j++){
					String cellValue = "";
					if(row.getCell(j) != null){
						row.getCell(j).setCellType(XSSFCell.CELL_TYPE_STRING);
						cellValue = row.getCell(j).getStringCellValue();
					}
					insertCellMap.put(key.get(j), cellValue);
				}

				insertCellMap.put("index", i-3);
				result = query.insert(NAMESPACE+insertQuery, insertCellMap);
				
				
			}		
			if(workbook != null){
//				workbook.close();
			}
			String updateQueryFinal = (paramMap.get("updateQueryFinal")==null)?"":(String) paramMap.get("updateQueryFinal");
			if(!updateQueryFinal.equals("")){
				result += query.update(NAMESPACE+updateQueryFinal,paramMap);
			}
			String insertQueryFinal = (paramMap.get("insertQueryFinal")==null)?"":(String) paramMap.get("insertQueryFinal");
			if(!insertQueryFinal.equals("")){
				result += query.insert(NAMESPACE+insertQueryFinal,paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception();
		}
 
		return result;
	}

	@Override
	public int xlsUpload(MultipartFile file, final MultipartHttpServletRequest request, HttpServletResponse response) {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	@Transactional(rollbackFor={Exception.class})
	public int xlsxUploadBatch(MultipartFile file, final MultipartHttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		List paramList = new ArrayList();
		try {
			
			int i = 0;
			// Creates a workbook object from the uploaded excelfile
			XSSFWorkbook workbook = new XSSFWorkbook(file.getInputStream());
			
			// Creates a worksheet object representing the first sheet
			XSSFSheet worksheet = workbook.getSheetAt(0);
			
			//20190805_khj 계획샘플수보다 모집단수가 작은지 체크, 계획샘플수가 숫자인경우에만 체크한다!_start
			int row_num = worksheet.getLastRowNum() - 2;
			String sample_num = (String) paramMap.get("sample_num");

			//계획된샘플수가 숫자변환 가능한지 체크(숫자 아닌 문자열이 있을 수 있기에... ex:모집단의 20% 등)
			if(util.isNumber(sample_num)) {
				if(Integer.parseInt(sample_num) > row_num) {
					//계획샘플수보다 업로드한 모집단수가 작을 경우 -2 반환
					result = -2;
					return result;
				}
			}
			//20190805_khj 계획샘플수보다 모집단수가 작은지 체크, 계획샘플수가 숫자인경우에만 체크한다 _end
			
			
			List key = new ArrayList();
			String insertQuery = (paramMap.get("insertQuery")==null)?"":(String) paramMap.get("insertQuery");
			String updateQuery = (paramMap.get("updateQuery")==null)?"":(String) paramMap.get("updateQuery");
			String deleteQuery = (paramMap.get("deleteQuery")==null)?"":(String) paramMap.get("deleteQuery");
			String deleteQuery2 = (paramMap.get("deleteQuery2")==null)?"":(String) paramMap.get("deleteQuery2");
			if(!updateQuery.equals("")){
				result = query.update(NAMESPACE+updateQuery,paramMap);
			}
			if(!deleteQuery.equals("")){
				result = query.delete(NAMESPACE+deleteQuery,paramMap);
			}
			if(!deleteQuery2.equals("")){
				result = query.delete(NAMESPACE+deleteQuery2,paramMap);
			}
				
			
			long cum_amount = 0;
			// Reads the data in excel file until last row is encountered
			while (i <= worksheet.getLastRowNum()) {			
				// Creates an object representing a single row in excel
				Map insertCellMap = new HashMap();
				insertCellMap.putAll(paramMap);
				XSSFRow row = worksheet.getRow(i++);
				if(i==1){
					for(int j=0; j<row.getLastCellNum(); j++){
						key.add(row.getCell(j).getStringCellValue());
					}
					//System.out.println(key);
					continue;
				}
				if(i==2){
					continue;
				}
				if(i==3){
					continue;
				}
				for(int j=0; j<key.size(); j++){
					String cellValue = "";
					if(row.getCell(j) != null){
						row.getCell(j).setCellType(XSSFCell.CELL_TYPE_STRING);
						cellValue = row.getCell(j).getStringCellValue();
						insertCellMap.put(key.get(j), cellValue);
						if(((String)key.get(j)).equals("AMOUNT")){
							cum_amount +=  Long.parseLong(cellValue);
						}
					}else{
						insertCellMap.put(key.get(j), 0);
					}
					
				}
				//System.out.println(insertCellMap.toString());
				insertCellMap.put("index", i-3);
				insertCellMap.put("cum_amount", cum_amount);
				paramList.add(insertCellMap);
				
			}
//			workbook.close();
			
			int paramListSize = paramList.size();
			int headercnt = Integer.parseInt((String)paramMap.get("headercnt"));
			int term = 2100/headercnt-1;
			for(int l=0; l<paramListSize; l+=term){
				
				if(l+term > paramListSize){
					result = query.insert(NAMESPACE+insertQuery,paramList.subList(l, l+(paramListSize%term)) );
				}else{
					result = query.insert(NAMESPACE+insertQuery, paramList.subList(l, (l+term)));
				}
				
			}
			
			
			String updateQueryFinal = (paramMap.get("updateQueryFinal")==null)?"":(String) paramMap.get("updateQueryFinal");
			if(!updateQueryFinal.equals("")){
				result += query.update(NAMESPACE+updateQueryFinal,paramMap);
			}
			String insertQueryFinal = (paramMap.get("insertQueryFinal")==null)?"":(String) paramMap.get("insertQueryFinal");
			if(!insertQueryFinal.equals("")){
				result += query.insert(NAMESPACE+insertQueryFinal,paramMap);
			}
		} catch (NumberFormatException nfe) {
//			nfe.printStackTrace();
			logger.error("업로드 에러(넘버포멧): ", nfe);
			result = -1;
//			throw new Exception();
		} catch (Exception e) {
//			e.printStackTrace();
			logger.error("업로드 에러: ", e);
			result = -1;
//			throw new Exception();
		}
 
		return result;
	}
	
	

}
