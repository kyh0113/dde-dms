package com.yp.zwc.nft.srvc.intf;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YP_ZWC_NFT_Service {
	
	public List<HashMap<String, Object>> select_cb_working_master_v(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<HashMap<String, Object>> select_cb_working_master_n(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<HashMap<String, Object>> select_zwc_nft_working_subc_list(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<HashMap<String, Object>> select_zwc_nft_dt_list(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int zwc_nft_create_save(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<HashMap<String, Object>> select_column_make_list(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
