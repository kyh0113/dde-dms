package com.yp.fixture.srvc.intf;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YPFixtureService {
	public List<Object> fixture_list (HashMap paramMap) throws Exception;
	public List<Object> fixture_req_list (HashMap paramMap) throws Exception;
	public List<Object> fixture_req_pop_list (Map parseMap) throws Exception;
	public int fixture_req_create (HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int fixture_edoc_status_update (HttpServletRequest request, HttpServletResponse response) throws Exception;
	public boolean is_available_edoc_approval (HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<Object> fixture_req_pop_xls_list (Map parseMap) throws Exception;
	public boolean fixture_is_availalbe_purchase_req (Map parseMap) throws Exception;
	public int fixture_req_purchase (HttpServletRequest request, HttpServletResponse response) throws Exception;
	public boolean fixture_is_availalbe_finish_purchase (Map paramMap) throws Exception;
	public int fixture_req_purchase_finish(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int fixture_master_save(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<Map<String, Object>> fixture_master_key_list () throws Exception;
}
