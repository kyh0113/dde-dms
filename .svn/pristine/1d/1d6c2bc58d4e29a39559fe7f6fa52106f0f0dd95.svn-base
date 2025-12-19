package com.yp.wr.srvc.intf;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface wr_Service {
	
	List<Object> wr_report(HashMap paramHashMap) throws Exception;
	  
	int wr_write_insert(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws Exception;
	
	HashMap wr_final_insert(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws Exception;
	
	HashMap wr_report_insert(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws Exception;
	
	HashMap wr_writepop_insert(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws Exception;
	
	HashMap wr_reportinpop_insert(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws Exception;
	
	//String wr_cd_select(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws Exception;
  
	Map<String, Object> create_wr_write(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws Exception;
	

	//public int wr_edoc_status_update (HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	List<Object> wr_req_list (HashMap paramMap) throws Exception;
	
	List<Object> wr_req_list_D (HashMap paramMap) throws Exception;
	
	List<Object> wr_req_list_A (HashMap paramMap) throws Exception;
	
	List<Object> wr_req_list_E (HashMap paramMap) throws Exception;
	
	List<Object> wr_req_list_B (HashMap paramMap) throws Exception;
	
	List<Object> wr_report_pop (Map parseMap) throws Exception;
	
	public int wr_edoc_status_update (HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int wr_edoc_status_update_report (HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int wr_edoc_status_update_final (HttpServletRequest request, HttpServletResponse response) throws Exception;
}
