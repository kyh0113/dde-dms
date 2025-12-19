package com.yp.zcs.cpt.srvc.intf;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YP_ZCS_CPT_Service {
	public HashMap<String, Object> select_zcs_cpt_manh_create3(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public List<HashMap<String, Object>> select_inspection_manh_list1(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public List<HashMap<String, Object>> select_inspection_manh_list2(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ArrayList<HashMap<String, String>> select_work_status_list_manh(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ArrayList<HashMap<String, String>> select_work_status_list_opt(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ArrayList<HashMap<String, String>> select_work_status_list_using_report_code(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public HashMap zcs_cpt_manh_save(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public List<HashMap<String, Object>> select_pay_code_list(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// 정비용역 > 검수보고서 > 검수보고서 조회 > 보고서코드 조회
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> retrieveReportName(HttpServletRequest request, HttpServletResponse response) throws Exception;

	public int zcs_cpt_rpt_delete(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public List<HashMap<String, Object>> select_construction_chk_rpt(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public List<HashMap<String, Object>> select_inspection_manh_list2_using_report_code(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	/* 검수보고서(작업) 시작 */
	public List<HashMap<String, Object>> select_inspection_opt_list1(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public List<HashMap<String, Object>> select_inspection_opt_list2(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public List<HashMap<String, Object>> select_inspection_opt_list2_using_report_code(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public HashMap zcs_cpt_opt_save(HttpServletRequest request, HttpServletResponse response) throws Exception;
	/* 검수보고서(작업) 끝 */

	
	/* 검수보고서(월정액) 시작*/
	public List<HashMap<String, Object>> select_inspection_mon_list1(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<HashMap<String, Object>> select_inspection_mon_list2(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public HashMap zcs_cpt_mon_save(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<HashMap<String, Object>> select_inspection_mon_list2_using_report_code(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public HashMap<String, Object> select_monthly_rpt1_section_dt(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public HashMap<String, Object> select_monthly_rpt2_section_dt(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public HashMap<String, Object> select_monthly_rpt3_section_dt(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
