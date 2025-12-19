package com.yp.zwc.ctr.srvc.intf;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YP_ZWC_CTR_Service {
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> retrieveKOSTL(HashMap req_data) throws Exception;
	@SuppressWarnings("rawtypes")
	public List retrieveDEPT(HashMap req_data) throws Exception;
	public ArrayList<HashMap<String, String>> zwc_ctr_select(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<HashMap<String, Object>> select_cb_gubun_yp_subc_gubun(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<HashMap<String, Object>> select_cb_gubun_yp_factory_gubun(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<HashMap<String, Object>> select_cb_working_master_u(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<HashMap<String, Object>> select_cb_working_master_v(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<HashMap<String, Object>> select_cb_working_master_w(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int zwc_ctr_delete_chk(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int zwc_ctr_delete(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int zwc_ctr_save(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int zwc_ctr_ref_save(HttpServletRequest request, HttpServletResponse response) throws Exception;

	public ArrayList<HashMap<String, String>> select_zwc_ctr_detail_create(HttpServletRequest request, HttpServletResponse response) throws Exception;
	@SuppressWarnings("rawtypes")
	public List select_zwc_ctr_detail_create_final_unit_price(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public Float select_zwc_ctr_detail_create_month_amount_ptc(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public Float select_zwc_ctr_detail_create_month_amount_nft(HttpServletRequest request, HttpServletResponse response) throws Exception;
	@SuppressWarnings("rawtypes")
	public HashMap select_overtime_pay(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int zwc_ctr_detail_create_save(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> select_zwc_ctr_worker_list(HashMap req_data) throws Exception;
	@SuppressWarnings("rawtypes")
	public List<HashMap<String, Object>> select_zwc_ctr_worktype_list(HashMap req_data) throws Exception;
	@SuppressWarnings("rawtypes")
	public List<HashMap<String, Object>> zwc_ctr_worker_mapping_validation(HashMap req_data) throws Exception;
	public int zwc_ctr_worker_delete(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int zwc_ctr_worker_create(HttpServletRequest request, HttpServletResponse response) throws Exception;

	@SuppressWarnings("rawtypes")
	public List select_emp_work_dept(HttpServletRequest request, HttpServletResponse response) throws Exception;
	@SuppressWarnings("rawtypes")
	public List select_team_list(HashMap<String, Object> param) throws Exception;
	@SuppressWarnings("rawtypes")
	public List select_group_list(HashMap<String, Object> param) throws Exception;
	@SuppressWarnings("rawtypes")
	public List select_shift_list(HashMap<String, Object> param) throws Exception;
}
