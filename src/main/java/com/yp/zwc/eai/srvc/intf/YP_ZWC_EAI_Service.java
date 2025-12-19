package com.yp.zwc.eai.srvc.intf;

import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YP_ZWC_EAI_Service {
	public List<HashMap<String, Object>> working_monthly_report(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<HashMap<String, Object>> working_subc_pst_adj(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<HashMap<String, Object>> working_subc_cost_count(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<HashMap<String, Object>> working_reto_cost_count(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<HashMap<String, Object>> construction_chk_rpt(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int working_eai_status(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public List wsd_edoc_write(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int working_eai_log(HashMap<String, Object> finalMap) throws Exception;
	
}
