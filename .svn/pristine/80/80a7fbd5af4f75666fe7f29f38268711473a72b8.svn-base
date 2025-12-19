package com.yp.zhr.lbm.srvc.intf;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YP_ZHR_LBM_Service {

	/* 3.인사관리 */
	/* 3.2.도시락관리 */
	/* 3.2.1. 도시락 신청 등록 */
	//도시락 신청등록
	public HashMap<String, Object> createDosilakReg(HttpServletRequest request, HttpServletResponse response) throws Exception;
	//도시락 신청취소
	public HashMap<String, Object> deleteDosilakAppli(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public List<Object> retrieveEmpWorkList(HashMap req_data) throws Exception;
	
	//도시락 집계등록
	public HashMap<String, Object> updateDosilakOk(HttpServletRequest request, HttpServletResponse response) throws Exception;
	//도시락 집계취소
	public HashMap<String, Object> updateDosilakOkCancel(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//식당 수기 등록
	public HashMap<String, Object> createRestaurantReg(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	
}
