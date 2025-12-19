package com.vicurus.it.core.excel.srvc;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import com.vicurus.it.core.viewResolver.ExcelUploadXls;
import com.vicurus.it.core.waf.mvc.IFileRenamePolicy;
import com.vicurus.it.core.common.FileUtil;
import com.vicurus.it.core.common.Util;
import com.vicurus.it.core.common.WebUtil;
import com.vicurus.it.core.excel.srvc.intf.ExcelService;
import com.vicurus.it.core.file.cntr.FileRenamePolicy;



@Service("ExcelService") 
public class ExcelServiceImpl implements ExcelService {
    
	@Autowired
    @Qualifier("sqlSession")
	private SqlSession query;

	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(ExcelServiceImpl.class);
   
	//config.properties 에서 설정 정보 가져오기 시작
	private static String NAMESPACE;
	
	@Value("#{config['db.vendor']}")
	public void setNAMESPACE(String value) {
		this.NAMESPACE = value + ".";
	}
	
	@Value("#{config['file.excelDir']}")
	private String excel_dir;
	//config.properties 에서 설정 정보 가져오기 끝
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map excelDownloadWithQuery(Map map) throws Exception {
		Map paramMap = map;
		paramMap.put("dataList", query.selectList(NAMESPACE+(String)paramMap.get("list"), paramMap));
		return paramMap;	
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map excelDown(Map map) throws Exception {
		// TODO Auto-generated method stub

		Map paramMap = map;
		int cnt = 0;
		
		if(paramMap.get("excel_sidx").equals("CHK")){	//엑셀다운로드(CHECK)
			String t_str = "";
			List dataList = new ArrayList();

			String[] t_array = ((String)paramMap.get("excel_list")).split("@");
			String[] h_array = ((String)paramMap.get("excel_header_eng")).split("@");

			for(int i=0; i < t_array.length; i++){
				String[] t_array2 = t_array[i].split("¶");		
				Map t_map = new HashMap();
				
				for(int j=0; j < t_array2.length; j++){
			
					t_map.put(h_array[j], t_array2[j]);					
				}

				dataList.add(i, t_map);
			}

			paramMap.put("dataList", dataList);
		
		}else if(paramMap.get("excel_sidx").equals("ALLOCATE_HISTORY")){	//분배이력 다운로드
			
			String temp = (String) paramMap.get("excel_list");
			
			String[] excel_temp =  temp.split("@");
			paramMap.put("list_cnt", excel_temp[0]);
			paramMap.put("list_name", excel_temp[1]);
			
			//쿼리 결과 카운트 리절트타입은 Integer나 Double만 허용 
			Object obj = query.selectOne(NAMESPACE+(String)paramMap.get("list_cnt"), paramMap);		//쿼리 조회(카운트)
			if(obj.getClass().getSimpleName().equals("Double")){
				cnt = Integer.parseInt(String.valueOf(Math.round((Double) obj)));
			}else{
				cnt = (Integer) obj;
			}
			
			paramMap.put("start", "1");														//무조건 고정값 "1"
			paramMap.put("end", cnt);														//리스트 카운트

			List dataList = query.selectList(NAMESPACE+(String)paramMap.get("list_name"), paramMap);	//쿼리 조회(리스트)
			paramMap.put("dataList", dataList);
			
		}else{		//엑셀다운로드(ALL)
		
			String temp = (String) paramMap.get("excel_list");
			String country = "";
			if(paramMap.containsKey("excel_country")) {
				country = (String)paramMap.get("excel_country"); 
				paramMap.put("country", country);
			};
			
			String[] excel_temp =  temp.split("@");
			paramMap.put("list_cnt", excel_temp[0]);
			paramMap.put("list_name", excel_temp[1]);
			//쿼리 결과 카운트 리절트타입은 Integer나 Double만 허용
			Object obj = query.selectOne(NAMESPACE+(String)paramMap.get("list_cnt"), paramMap);		//쿼리 조회(카운트)
			if(obj.getClass().getSimpleName().equals("Double")){
				cnt = Integer.parseInt(String.valueOf(Math.round((Double) obj)));
			}else{
				cnt = (Integer) obj;
			}
			
			paramMap.put("start", "1");														//무조건 고정값 "1"
			paramMap.put("end", cnt);														//리스트 카운트
			paramMap.put("sidx", paramMap.get("excel_sidx"));   							//정렬조건필드명
			paramMap.put("sord", paramMap.get("excel_sord"));								//정렬방법
			List dataList = query.selectList(NAMESPACE+(String)paramMap.get("list_name"), paramMap);	//쿼리 조회(리스트)
			paramMap.put("dataList", dataList);
		
		}
		return paramMap;	
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Transactional
	@Override
	public int ExcelUpload(final MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		Util util = new Util();
		FileUtil fileutil = new FileUtil();
		Map paramMap = util.getParamToMap(multipartRequest,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		
		IFileRenamePolicy renamePolicy = null;										//첨부파일리네임 객체 선언
		String curYear = Integer.toString(WebUtil.getYear());						//현재 년도 가져오기
		String curMonth = Integer.toString(WebUtil.getMonth());						//현재 월 가져오기
		if (curMonth.length() == 1) curMonth = "0" + curMonth;						//현재 월 1자리를 2자리로 변경
		String curDay = Integer.toString(WebUtil.getDay());							//현재 일 가져오기
		if (curDay.length() == 1) curDay = "0" + curDay;							//현재 일 1자리를 2자리로 변경
		
		String saveDir = curYear + "/" + curMonth + "/" + curDay + "/";				//첨부파일 담을 현재날짜 디렉토리
		String savePath = excel_dir;												//엑셀 저장되는 물리적 경로
		renamePolicy = new FileRenamePolicy(excel_dir, curYear, curMonth, curDay);	//첨부파일 디렉토리 유무 체크 및 생성
				
		String fileName = "";
		int excelSize = 0;
		int result = 0;

		
		//MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

		List<MultipartFile> files = multipartRequest.getFiles("excel_upload_name");	//폼에서 넘어오는 파일의 아이디

		for(MultipartFile file : files){
			
			//fileName = new String( file.getOriginalFilename().getBytes( "UTF-8"));
			fileName = new String( file.getOriginalFilename());					//파일명 가져오기

			File uExcelFile = new File(savePath + saveDir, fileName);			//file 객체 생성
			uExcelFile = fileutil.rename(uExcelFile);							//중복된 파일명이면 파일명뒤에 숫자붙여줌

			
			//********************************	파일 확장자 추출 시작	**********************************
			int dot = uExcelFile.getName().lastIndexOf(".");

	        String ext = uExcelFile.getName().substring(dot);					//파일 확장자 추출

			if (!util.isNull(ext)){												//파일 확장자 대문자로 변경
				ext = ext.toUpperCase();
			}
			//********************************	파일 확장자 추출 끝	    **********************************
			
			if (!".XLS".equals(ext)) {
				//System.out.println("'" + ext + "' 확장자는 엑셀 형식의 파일이 아닙니다.");
				result = 10;													//확장자 다른경우 리절트코드
				return result;
				
			} else {
				//System.out.println("엑셀 형식의 파일이 업로드 된 것을 확인하였습니다.");
				
				file.transferTo(uExcelFile);									//지정된 경로에 물리적 파일 저장
				
	        	ExcelUploadXls excelData = new ExcelUploadXls();
	        	List arr_excelData = new ArrayList();
				Map map_excelData = excelData.xlsExcelRead(uExcelFile);			//*******엑셀 데이터 추출*******
				
				
				//******************************* 엑셀 업로드 결과 코드 분기 ******************************* 
				if(map_excelData.get("excel_result_code") == "20"){				//엑셀 데이터가 없는 경우
					result = 20;
					return result;
				}else if(map_excelData.get("excel_result_code") == "30"){		//지정된 엑셀양식이 아닌 경우
					result = 30;
					return result;
				}else if(map_excelData.get("excel_result_code") == "40"){		//고객명이 없는 경우
					result = 40;
					return result;
				}else if(map_excelData.get("excel_result_code") == "50"){		//휴대폰번호가 없는 경우
					result = 50;
					return result;
				}else{
					arr_excelData = (List) map_excelData.get("excelList");		//엑셀 데이터 리스트 담기
				}
				//******************************* 엑셀 업로드 결과 코드 분기 *********************************** 
				
				
				
				//System.out.println("엑셀 파일의 사이즈는 : " + arr_excelData.size() + " 입니다.");
					
				//******************************* 엑셀 업로드 테이블 삭제(초기화) *******************************
				result = query.delete(NAMESPACE+"Sample.ExcelDelete", paramMap);		//덤프 테이블 삭제(초기화)
				if(result >= 1){
					result = query.update(NAMESPACE+"Sample.ExcelIdxInit");			//덤프 테이블 자동증가값 초기화	
				}
				//******************************* 엑셀 업로드 테이블 삭제(초기화) *******************************
				
				for(int i = 0; i < arr_excelData.size(); i++){						//ROW 수만큼 돌면서 저장
					Map cellMap = (Map) arr_excelData.get(i);
					
					cellMap.get(i);
					cellMap.put("s_user_id", paramMap.get("s_user_id"));			//세션정보 넣기(아이디)
					cellMap.put("s_user_name", paramMap.get("s_user_name"));		//세션정보 넣기(이름)
				

				//********************** 날짜 형식 데이터 체크 시작(필요에 의해 사용 권유) **********************	
//					if(util.isDate(cellMap.get("1").toString())){				//날짜 형식인지 체크
//						//System.out.println("생년월일은 날짜다");
//						String birth = (String) cellMap.get("1");					
//						cellMap.put("1", birth.substring(0, 10));
//					}else{														
//						//System.out.println("생년월일은 날짜아님");
//						if(cellMap.get("1").toString().length() > 10){
//							String birth = (String) cellMap.get("1");
//							cellMap.put("1", birth.substring(0, 10));
//						}
//					}
//								
//					
//					if(util.isDate(cellMap.get("11").toString())){				//날짜 형식인지 체크
//						//System.out.println("동의일자는 날짜다");
//					}else{														//날짜아니면 하나씩 잘라서 날짜로만듬
//						//System.out.println("동의일자는 날짜아님"+cellMap.get("11"));
//						
//						String ddate = (String) cellMap.get("11");
//						
//						if(ddate.length() == 19){
//							cellMap.put("11", ddate);
//						}else if(ddate.length() == 14){
//							String ddate2 =  ddate.substring(0, 4) + "-" + ddate.substring(4, 6) + "-" + ddate.substring(6, 8) + " " + ddate.substring(8, 10) + ":" + ddate.substring(10, 12) + ":" + ddate.substring(12, 14);
//							cellMap.put("11", ddate2);
//						}else if(ddate.length() > 14 && ddate.length() != 19){
//							//2015-10-06 오후 8:08:20(21)
//							//2015-10-06 오후 12:08:20(22)
//							//2004-01-09 10:56:57.580(23)
//							if(ddate.length() == 21){		
//								String ddate2 = ddate.substring(0, 10) + " " + ddate.substring(14, 21) + " " + ddate.substring(11, 13);
//								String ddate3 = ddate2.trim().replace("오전", "AM");
//								String ddate4 = ddate3.trim().replace("오후", "PM");
//
//								cellMap.put("11", ddate4);
//								cellMap.put("date_format", "Y");
//							}else if(ddate.length() == 22){
//								String ddate2 = ddate.substring(0, 10) + " " + ddate.substring(14, 22) + " " + ddate.substring(11, 13);
//								String ddate3 = ddate2.trim().replace("오전", "AM");
//								String ddate4 = ddate3.trim().replace("오후", "PM");
//
//								cellMap.put("11", ddate4);
//								cellMap.put("date_format", "Y");
//							}else{
//								cellMap.put("11", ddate);
//							}					
//						}else if(ddate.length() == 8){
//				
//							String ddate2 = ddate.substring(0, 4) + "-" +ddate.substring(4, 6) + "-" + ddate.substring(6, 8);
//							cellMap.put("11", ddate2);
//						}else if(ddate.length() == 10){
//							//2016.07.07
//							String ddate2 = ddate.substring(0, 4) + "-" +ddate.substring(5, 7) + "-" + ddate.substring(8, 10);
//							cellMap.put("11", ddate2);
//						}else{
//							cellMap.put("11", null);
//						}
//					}
					//********************** 날짜 형식 데이터 체크   끝(필요에 의해 사용 권유) **********************
					
					result = query.insert(NAMESPACE+"Sample.ExcelUpload", cellMap);			//덤프 테이블에 엑셀업로드

				}
				
			
			}
			//업로드완료 후 파일 삭제
			//uExcelFile.delete();
		}
		
		return result;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Transactional
	@Override
	public Map ExcelSave(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		Util util = new Util();
		Map dataMap = new HashMap();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int result = query.insert(NAMESPACE+"Sample.ExcelInsert", paramMap);	//임시 엑셀테이블 TO 샘플 사원테이블
		
		dataMap.put("result_code", result);	
		
		return dataMap;
	}

	
	
}
