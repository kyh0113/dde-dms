package com.yp.zmm.aw.srvc.intf;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YP_ZMM_AW_Service {

	public ArrayList<HashMap<String, String>> zmm_weight_list(HashMap paramMap) throws Exception;

	public int zmm_weight_delete(HashMap paramMap) throws Exception;
	
	public int zmm_weight_save(HashMap paramMap) throws Exception;
	
	public int zmm_weight_dailyclosing(HashMap paramMap) throws Exception;
	
	public int zmm_weight_monthlyclosing(HashMap paramMap) throws Exception;
	
	public int zmm_weight_cont_create_prc(HashMap paramMap) throws Exception;

	public ArrayList<HashMap<String, String>> retrieveKUNNR(HashMap paramMap) throws Exception;
	
	public ArrayList<HashMap<String, String>> retrieveMATNR(HashMap paramMap) throws Exception;
	
	public ArrayList<HashMap<String, String>> retrieveBill(HashMap paramMap) throws Exception;
	
	public List<HashMap<String, Object>> zmm_weight_p_name_list(HashMap paramMap) throws Exception;
	
	public ArrayList<HashMap<String, String>> retrieveVKBUR(HashMap paramMap) throws Exception;
	
	public List<HashMap<String, Object>> zmm_p_detail_code_cas(HashMap paramMap) throws Exception;
	
	public HashMap<String, String> zmm_weight_p_code_list(HashMap paramMap) throws Exception;
	
	public HashMap<String, String> zmm_weight_p_name_cas(HashMap paramMap) throws Exception;
	
	public HashMap<String, String> zmm_weight_cont_detail(HashMap paramMap) throws Exception;
	
	public int zmm_weight_cont_detail_save(HashMap paramMap) throws Exception;
	
	public int zmm_weight_cont_delete(HashMap paramMap) throws Exception;
	
	public List<Object> calc_detail_list (HashMap paramMap) throws Exception;
	
	public String[] so_create_save(HashMap req_data) throws Exception;

	public int zmm_weight_calc_save(HashMap paramMap) throws Exception;
	
	public List<HashMap<String, Object>> zmm_weight_calc_edoc_list (HashMap paramMap) throws Exception;
	
	public List<HashMap<String, Object>> zmm_weight_data_edoc_list (HashMap paramMap) throws Exception;
	
	public List<Object> zmm_weight_edoc_calc_detail_list (HashMap paramMap) throws Exception;
	
	public int zmm_edoc_status_update(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int zmm_edoc_data_update(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public HashMap<String, Object> fi_doc_regpage(HashMap paramMap) throws Exception;
	
	public void retrieveMATNR_SW() throws Exception;
	
	public void retrieveKUNNR_SW() throws Exception;
	
	public int zmm_weight_data_json(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	@SuppressWarnings("rawtypes")
	public String[] createDocument(HashMap req_data) throws Exception;
	public String[] retrieveLIFNR(HashMap req_data) throws Exception;
	public String[] retrieveBUDGET(HashMap req_data) throws Exception;
	
}
