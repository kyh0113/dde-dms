package com.yp.zmm.raw.srvc.intf;

import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YP_ZMM_RAW_Service {

	/* 2.구매관리 */
	/* 2.1.원료관리 */
	// 그리드 RFC 조회 스타터

	//LME 조회
	public ArrayList<HashMap<String, String>> retrieveLME(HashMap paramMap) throws Exception;
	
	//LME 평균 조회
	public ArrayList<HashMap<String, String>> retrieveLME_AVG(HashMap paramMap) throws Exception;
	
	//LME 존재유무 조회
	public ArrayList<HashMap<String, String>> retrieveLME_check(HashMap paramMap) throws Exception;
	
	//LME 등록
	public int createLME(HashMap paramMap) throws Exception;
	
	//LME 수정
	public int updateLME(HashMap paramMap) throws Exception;
		
	//입항스케줄 엑셀 다운로드
	public ArrayList<HashMap<String, String>> retrieveArrivalScheduleList(HashMap paramMap) throws Exception;
	
	//광종 코드팝업
	public ArrayList<HashMap<String, String>> retrieveItemBySAP(HashMap paramMap) throws Exception;
	
	//업체 코드팝업
	public ArrayList<HashMap<String, String>> retrieveVendorBySAP(HashMap paramMap) throws Exception;
	
	//입항스케줄 등록
	public int createArrivalSchedule(HashMap paramMap) throws Exception;
	
	//입항스케줄 수정
	public int updateArrivalSchedule(HashMap paramMap) throws Exception;
	
	//입항스케줄 삭제
	public int deleteArrivalSchedule(HashMap paramMap) throws Exception;
	
	//Typical Assay, Invoice Assay 조회
	public ArrayList<HashMap<String, String>> AssayList(HashMap paramMap) throws Exception;
	
	//Typical Assay 저장
	public int createTypicalAssay(HashMap paramMap) throws Exception;
	
	//Invoice Assay 저장
	public int createInvoiceAssay(HashMap paramMap) throws Exception;
	
}
