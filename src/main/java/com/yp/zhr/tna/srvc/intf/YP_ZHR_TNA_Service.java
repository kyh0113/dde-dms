package com.yp.zhr.tna.srvc.intf;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YP_ZHR_TNA_Service {

	/* 1.인사관리 */
	// 그리드 RFC 조회 스타터
	public HashMap<String, Object> exec(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	/* 1-1.근태관리 */
	// 개인 출퇴근 조회
	public ArrayList<HashMap<String, String>> zhr_per_daily_report(HttpServletRequest request, HttpServletResponse response) throws Exception;

	// 시간외근무 등록
	@SuppressWarnings("rawtypes")
	public List select_zhr_per_daily_report(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// 부서정보 조회
	@SuppressWarnings("rawtypes")
	public List retrieveEmpWorkInfo(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// 원근무 정보 조회
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> retrieveTimecardList(HashMap req_data) throws Exception;
	
	@SuppressWarnings("rawtypes")
	public HashMap<String,ArrayList<HashMap<String, String>>> retrieveVacationEmpList(HashMap req_data) throws Exception;
	
	public HashMap<String, String> retrieveUpperDepartment(String dept_cd) throws Exception;
	
	@SuppressWarnings("rawtypes")
	public HashMap<String,String> createOvertime(HashMap req_data) throws Exception;
	
	public int updateOverPlanStauts(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	@SuppressWarnings("rawtypes")
	public List retrieveOvertimePlanListBySeq(HashMap seq) throws Exception;
	
	public HashMap<String, Object> createOverPlanToSAP(HttpServletRequest request, ArrayList<HashMap<String, String>> list) throws Exception;
	
	@SuppressWarnings("rawtypes")
	public int updateOverPlanConfirm(HttpServletRequest request, ArrayList list) throws Exception;
	
	public ArrayList<HashMap<String, String>>  zhr_per_overtime_report(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	@SuppressWarnings("rawtypes")
	public List select_emp_work_dept(HttpServletRequest request, HttpServletResponse response) throws Exception;
	@SuppressWarnings("rawtypes")
	public List select_team_list(HashMap<String, Object> param) throws Exception;
	@SuppressWarnings("rawtypes")
	public List select_group_list(HashMap<String, Object> param) throws Exception;
	@SuppressWarnings("rawtypes")
	public List select_shift_list(HashMap<String, Object> param) throws Exception;	
}
