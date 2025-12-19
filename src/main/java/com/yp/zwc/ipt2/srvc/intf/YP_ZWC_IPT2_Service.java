package com.yp.zwc.ipt2.srvc.intf;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YP_ZWC_IPT2_Service {
	@SuppressWarnings("rawtypes")
	public List<HashMap<String, Object>> select_cb_tbl_working_subc(HashMap request) throws Exception;
	@SuppressWarnings("rawtypes")
	public List<HashMap<String, Object>> select_cb_working_master_v(HashMap request) throws Exception;
	@SuppressWarnings("rawtypes")
	public List<HashMap<String, Object>> select_cb_tbl_working_subc_approval(HashMap request) throws Exception;
	public int save_tbl_working_daily_report(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int delete_tbl_working_daily_report(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int confirm_tbl_working_daily_report(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int merge_tbl_working_daily_approval(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int merge_tbl_working_daily_approval_dt(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int update_tbl_working_daily_approval_tlc(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int update_tbl_working_daily_approval_tlc_y(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int update_tbl_working_daily_approval_tlc_n(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int pre_select_ipt2_contract_bill(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int update_zwc_ipt2_contract_bill_upload(HashMap<String, Object> req_data) throws Exception;
	public HashMap<String, Object> select_zwc_ipt2_contract_bill_upload(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
