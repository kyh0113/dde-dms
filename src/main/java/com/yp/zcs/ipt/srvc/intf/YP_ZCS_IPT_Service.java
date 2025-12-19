package com.yp.zcs.ipt.srvc.intf;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YP_ZCS_IPT_Service {
	public List<HashMap<String, String>> select_zcs_ipt_mon_manh_read(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public HashMap<String, Object> select_zcs_ipt_mon_manh_create(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int merge_zcs_ipt_mon_manh_create(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int delete_zcs_ipt_mon_manh_create(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int select_chk_enable_proc(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> retrieveKOSTL(HashMap req_data) throws Exception;
	
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> retrieveVAPLZ(HashMap req_data) throws Exception;
	
	public int zcs_ipt_mon_manh_create_save(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int month_manh_excelUpload_check(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int month_manh_delete(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int month_opt_excelUpload_check(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int zcs_ipt_mon_opt_create_save(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int month_opt_delete(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int month_excelUpload_check(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int zcs_ipt_mon_create_save(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int month_delete(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> unexpectedBySAP(HashMap paramMap) throws Exception;
	
	@SuppressWarnings("rawtypes")
	public List select_zcs_ipt_process_list(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	@SuppressWarnings("rawtypes")
	public List select_zcs_ipt_worker_list(HttpServletRequest request, HttpServletResponse response) throws Exception;
	@SuppressWarnings("rawtypes")
	public List select_construction_monthly_rpt2_excel(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	@SuppressWarnings("rawtypes")
	public List select_zcs_ipt_unexpected_list(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int proc_zcs_ipt_unexpected_list(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	@SuppressWarnings("rawtypes")
	public List popup_company_id(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	@SuppressWarnings("rawtypes")
	public List popup_name(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
