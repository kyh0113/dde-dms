package com.yp.zwc.ptc.srvc;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Repository;

public interface YP_ZWC_PTC_Service {
	
	public List<HashMap<String, Object>> select_cb_working_master_v(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<HashMap<String, Object>> select_cb_working_master_p(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int select_zwc_ptc_dt_cnt(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<HashMap<String, Object>> select_zwc_ptc_working_subc_list(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<HashMap<String, Object>> select_zwc_ptc_dt_list(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<HashMap<String, Object>> select_cb_working_recent_master_p(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int zwc_ptc_create_save(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<HashMap<String, Object>> select_column_make_list(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	
	public int select_zwc_ptc_list_cnt(HttpServletRequest request, HttpServletResponse response) throws Exception;
	

}
