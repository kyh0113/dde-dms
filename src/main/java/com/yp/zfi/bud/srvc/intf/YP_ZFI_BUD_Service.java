package com.yp.zfi.bud.srvc.intf;

import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YP_ZFI_BUD_Service {

	/* 1.재무관리 */
	/* 2.1.예산조회 */
	// 그리드 RFC 조회 스타터
	public HashMap<String, Object> exec(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//그리드_예산조회(RFC)
	public ArrayList<HashMap<String, String>> ui_select_retrieveBudgetList(HttpServletRequest request, HttpServletResponse response) throws Exception; 
	
	//예산조회_팝업
	public HashMap<String, Object> retrieveBACT(HashMap req_data) throws Exception;
	
	//집행부서 팝업
	public ArrayList<HashMap<String, String>> retrieveKOSTL(HashMap req_data) throws Exception;
	
	//예산금액 상세팝업
	public ArrayList<HashMap<String, String>> retrieveDetailAmtPlan(HashMap req_data) throws Exception;
	
	//사용금액 상세팝업
	public ArrayList<HashMap<String, String>> retrieveDetailAmtACT(HashMap req_data) throws Exception;
	
	//사용금액 상세팝업 > 그릅웨어 팝업
	public String retrieveDocumentPop(HashMap req_data) throws Exception;
	
	/* 1.재무관리 */
	/* 2.2.예산신청 */
	// 그리드 RFC 조회 스타터
	public ArrayList<HashMap<String, String>> ui_select_retrieveBudgetModifyList(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ArrayList<HashMap<String, String>> ui_select_retrieveBudgetOnlyList(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//신청유형 "전용" 클릭시
	public HashMap<String, Object> retrieveBudgetOnlyList(HashMap req_data) throws Exception;
	
	//예산계정 팝업에서 예산계정 선택시
	public HashMap<String, String> retrieveAjaxBACT(HashMap req_data) throws Exception;
	
	//예산신청 저장(추가)
	public String[] createBudgetToSAP(HashMap req_data) throws Exception;
	
	//예산신청 저장(수정)
	public String[] updateBudgetToSAP(HashMap req_data) throws Exception;

	//예산신청 저장(삭제)
	public String[] deleteBudgetToSAP(HashMap req_data) throws Exception;
	
	//예산신청 전용 저장(추가)
	public String[] createBudgetOnlyToSAP(HashMap req_data) throws Exception;
	
	//예산신청 전용 저장(삭제)
	public String deleteBudgetOnlyToSAP(HashMap req_data) throws Exception;

	/* 2.3.예산 결재상신 */
	// 예산 결재상신 조회
	public HashMap<String, Object> retrieveBudgetDocWriteList(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// 결재상신
	@SuppressWarnings("rawtypes")
	public String[] retreveEdocPop(HashMap req_data) throws Exception;
	
	/* 2.4.투보수 예산 조회 */
	public HashMap<String, Object> ui_select_retrieveBudgetStatus(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//WBS 코드 팝업
	public ArrayList<HashMap<String, String>> retrievePOSID(HashMap req_data) throws Exception;
	
	/* 2.5.투보수 예산 상세조회 */
	public HashMap<String, Object> ui_select_retrieveBudgetWbsList(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	/* 2.5.투보수 예산 상세조회 상세팝업 */
	public HashMap<String, Object> retrieveBudgetWbsDetailList(HashMap req_data) throws Exception;
	
	
}
