package com.yp.zwc.ipt.srvc.intf;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YP_ZWC_IPT_Service {
	public List<HashMap<String, String>> select_zwc_ipt_performance(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// 그리드 RFC 조회 스타터
	public HashMap<String, Object> exec(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public String zwc_ipt_sum_list_check_a(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public String zwc_ipt_sum_list_check_b(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public String zwc_ipt_mon_create_check(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public String zwc_rpt_post_intervention_check(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public String zwc_rst_summary_list_check(HttpServletRequest request, HttpServletResponse response) throws Exception;
	@SuppressWarnings("rawtypes")
	public int zwc_ipt_sum_create_exec(HashMap req_data) throws Exception;
	public List<HashMap<String, String>> select_zwc_ipt_list_report(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<HashMap<String, String>> select_zwc_ipt_detail_list(HttpServletRequest request, HttpServletResponse response) throws Exception;

	@SuppressWarnings("rawtypes")
	public List<HashMap<String, Object>> select_cb_working_master_v(HashMap request) throws Exception;
	@SuppressWarnings("rawtypes")
	public List<HashMap<String, Object>> select_cb_tbl_working_subc(HashMap request) throws Exception;
	public int merge_tbl_working_daily_report(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int update_tbl_working_daily_report_tlc(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int update_tbl_working_daily_report_tlc_y(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int update_tbl_working_daily_report_tlc_n(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int merge_tbl_working_daily_report_dt(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int pre_select_tbl_working_monthly_report(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int insert_tbl_working_monthly_report(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int update_tbl_working_monthly_report(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public List<HashMap<String, Object>> zwc_ipt_contract_bill(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public String zwc_ipt_contract_bill_representative(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public List<HashMap<String, Object>> zwc_ipt_doc_create_dt_list(HttpServletRequest request, HttpServletResponse response) throws Exception;
	@SuppressWarnings("rawtypes")
	public String[] createDocument(HashMap req_data) throws Exception;
	@SuppressWarnings("rawtypes")
	public int updateDocumentNumber(HashMap req_data) throws Exception;
	@SuppressWarnings("rawtypes")
	public List<HashMap<String, String>> zweb_check_document(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int zwc_ipt_mon_create_status_reset(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int zwc_ipt_sum_list_status_reset(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
