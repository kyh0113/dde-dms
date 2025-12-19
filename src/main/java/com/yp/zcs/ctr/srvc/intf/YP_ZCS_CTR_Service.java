package com.yp.zcs.ctr.srvc.intf;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YP_ZCS_CTR_Service  {

	public List<HashMap<String, Object>> select_pay_code_list(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// 공사용역 > 계약관리 > 계약등록 > 팝업(업체 검색)
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> select_working_master_v(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//WBS 코드 팝업
	public ArrayList<HashMap<String, String>> retrievePOSID(HashMap req_data) throws Exception;
	
	public HashMap zcs_ctr_manh_save(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int zcs_ctr_manh_delete(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// 공사용역 > 계약관리 > 계약조회 > 팝업(계약명 검색)
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> retrieveContarctName(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// (계약조회 => 계약등록 화면)으로 넘어올 시 계약코드를 기준으로 조회하기
	public List<HashMap<String, Object>> select_contstruction_subc(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<HashMap<String, Object>> select_contstruction_subc_cost(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public List<HashMap<String, Object>> select_contstruction_subc_emp_cost(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int select_exist_monthly_rpt(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int zcs_ctr_manh_read_delete(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
}
