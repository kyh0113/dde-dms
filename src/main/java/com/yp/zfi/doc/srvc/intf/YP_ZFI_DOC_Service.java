package com.yp.zfi.doc.srvc.intf;

import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YP_ZFI_DOC_Service {

	/* 1.재무관리 > 전표관리 > 회계전표 목록 */
	// 그리드 RFC 조회 스타터
	public ArrayList<HashMap<String, String>> exec(HttpServletRequest request, HttpServletResponse response) throws Exception;

	// 회계전표 목록 조회
	public ArrayList<HashMap<String, String>> ui_select_cs_notice_list(HttpServletRequest request, HttpServletResponse response) throws Exception;

	// 팝업 - 회계전표 조회
	@SuppressWarnings("rawtypes")
	public HashMap<String, ArrayList<HashMap<String, String>>> retrievePrintDocument1(HashMap req_data) throws Exception;

	// 팝업 - 지출품의 조회
	@SuppressWarnings("rawtypes")
	public HashMap<String, ArrayList<HashMap<String, String>>> retrievePrintDocument2(HashMap req_data) throws Exception;

	// 회계전표 선택삭제
	@SuppressWarnings("rawtypes")
	public String removeDocument(HashMap req_data) throws Exception;

	// 회계전표 상세조회
	@SuppressWarnings("rawtypes")
	public String retrieveDocumentPop(HashMap req_data) throws Exception;

	// 결재상신
	@SuppressWarnings("rawtypes")
	public String[] createDocWrite(HashMap req_data) throws Exception;

	// 빠른 전표생성
	@SuppressWarnings("rawtypes")
	public HashMap<String,Object> retrieveDocumentDetail(HashMap req_data) throws Exception;
	
	/* 1.재무관리 > 전표관리 > 회계전표 등록 */
	// 재무관리 > 전표관리 > 회계전표 등록 > 전표 등록
	@SuppressWarnings("rawtypes")
	public String[] createDocument(HashMap req_data) throws Exception;
	
	// 재무관리 > 전표관리 > 회계전표 등록 > 팝업(업체 검색)
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> retrieveLIFNR(HashMap req_data) throws Exception;

	// 재무관리 > 전표관리 > 회계전표 등록 > 팝업(계정과목 검색)
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> retrieveSAKNR(HashMap req_data) throws Exception;

	// 재무관리 > 전표관리 > 회계전표 등록 > AJAX(계정과목 검색)
	@SuppressWarnings("rawtypes")
	public HashMap<String, String> retrieveSAKNRonBlur(HashMap req_data) throws Exception;

	// 재무관리 > 전표관리 > 회계전표 등록 > 팝업(세금코드 선택)
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> retrieveTAXPC(HashMap req_data) throws Exception;

	// 재무관리 > 전표관리 > 회계전표 등록 > 팝업(은행 선택)
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> retrieveBANKN(HashMap req_data) throws Exception;

	// 재무관리 > 전표관리 > 회계전표 등록 > 팝업(통화 선택)
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> retrieveWAERS(HashMap req_data) throws Exception;

	// 재무관리 > 전표관리 > 회계전표 등록 > 팝업(은행번호 검색)
	@SuppressWarnings("rawtypes")
	public HashMap<String, Object> retrieveBANKA(HashMap req_data) throws Exception;

	// 재무관리 > 전표관리 > 회계전표 등록 > 팝업(계정과목 검색)
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> retrieveHKONT(HashMap req_data) throws Exception;

	// 재무관리 > 전표관리 > 회계전표 등록 > 팝업(집행부서 검색, 코스트센터 검색)
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> retrieveKOSTL(HashMap req_data) throws Exception;

	// 재무관리 > 전표관리 > 회계전표 등록 > 팝업(WBS코드 검색)
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> retrievePOSID(HashMap req_data) throws Exception;

	// 재무관리 > 전표관리 > 회계전표 등록 > 팝업(WBS코드 검색)
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> retrieveMVGR(HashMap req_data) throws Exception;

	// 재무관리 > 전표관리 > 회계전표 등록 > 팝업(판매오더 검색)
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> retrieveVBELN(HashMap req_data) throws Exception;

	// 재무관리 > 전표관리 > 회계전표 등록 > 팝업(단위 검색)
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> retrieveMEINS(HashMap req_data) throws Exception;

	// 재무관리 > 전표관리 > 회계전표 등록 > 팝업(차량 검색)
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> retrieveZCCODE(HashMap req_data) throws Exception;

	// 재무관리 > 전표관리 > 회계전표 등록 > 팝업(지급조건 검색)
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> retrieveZTERM(HashMap req_data) throws Exception;

	// 재무관리 > 전표관리 > 회계전표 등록 > 팝업(설비오더 검색)
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> retrieveAUFNR(HashMap req_data) throws Exception;

	// 재무관리 > 전표관리 > 회계전표 등록 > 가용예산 조회
	@SuppressWarnings("rawtypes")
	public String retrieveBUDGET(HashMap req_data) throws Exception;
}
