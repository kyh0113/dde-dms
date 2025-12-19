package com.yp.zwc.cct.srvc.intf;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YP_ZWC_CCT_Service {
	
	public ArrayList<HashMap<String, String>> zwc_cct_select(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int zwc_cct_save(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
}
