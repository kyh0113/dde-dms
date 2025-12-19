package com.yp.zwc.rst.srvc.intf;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YP_ZWC_RST_Service {
	
	// 그리드 RFC 조회 스타터
	public HashMap<String, Object> exec(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public List<HashMap<String, String>> select_zwc_rst_list_report(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int merge_tbl_working_monthly_report_retro(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public List<HashMap<String, Object>> zwc_rst_bill(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public String zwc_rst_bill_representative(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public List<HashMap<String, Object>> zwc_rst_doc_create_dt_list(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public String[] createDocument(HashMap req_data) throws Exception;
	public int updateDocumentNumber(HashMap req_data) throws Exception;
	@SuppressWarnings("rawtypes")
	public List<HashMap<String, String>> zweb_check_document(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
