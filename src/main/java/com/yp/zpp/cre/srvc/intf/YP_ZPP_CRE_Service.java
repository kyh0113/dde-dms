package com.yp.zpp.cre.srvc.intf;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YP_ZPP_CRE_Service {

	public int zpp_cre_reg(HttpServletRequest request, HttpServletResponse response) throws Exception;

	public int deleteAccessControl(HttpServletRequest request, HttpServletResponse response) throws Exception;

	public HashMap<String, Object> retrieveBFDT(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public HashMap<String, Object> select_tbl_cre_list(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public HashMap<String, Object> select_tbl_cre_list_pop(HttpServletRequest request, HttpServletResponse response) throws Exception;

}