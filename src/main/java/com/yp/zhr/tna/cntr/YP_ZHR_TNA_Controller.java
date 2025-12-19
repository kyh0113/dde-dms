package com.yp.zhr.tna.cntr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.vicurus.it.core.common.Util;
import com.yp.login.srvc.intf.YPLoginService;
import com.yp.util.DateUtil;
import com.yp.zhr.tna.srvc.intf.YP_ZHR_TNA_Service;

@Controller
public class YP_ZHR_TNA_Controller {

	@Autowired
	private YP_ZHR_TNA_Service zhr_tna_Service;
	
	@Autowired
	private YPLoginService lService;

	private static final Logger logger = LoggerFactory.getLogger(YP_ZHR_TNA_Controller.class);

	/**
	 * 인사관리 > 근태관리 > 개인 출퇴근 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zhr/tna/zhr_tna_list", method = RequestMethod.POST)
	public ModelAndView zhr_tna_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】인사관리 > 근태관리 > 개인 출퇴근 조회");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap req_data = (HashMap)util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		req_data.put("sdate", DateUtil.getToday());
		req_data.put("edate", DateUtil.getToday());
		
		HttpSession session = request.getSession();
		req_data.put("emp_code",(String) session.getAttribute("empCode"));
		req_data.put("emp_name",((String) session.getAttribute("userName")));
		req_data.put("user_dept",((String) session.getAttribute("userDept")));
		req_data.put("ofc_name",((String) session.getAttribute("userOfc")));
		req_data.put("auth", (String) session.getAttribute("HR_AUTH"));
		if(req_data.get("auth") == null) req_data.put("auth","US");
		// 2020-08-19 jamerl - 직급명으로 auth 세팅하지 않도록 조치
//		if(req_data.get("auth") == null){
//			if("팀장".equals(req_data.get("ofc_name")))	req_data.put("auth","TM");
			// 원래 주석이었음
//			else if("조장".equals(req_data.get("ofc_name")))	req_data.put("auth","SM");
//			else 	req_data.put("auth","US");
//		}
		
		// 2020-08-25 jamerl -	화면 최초 로드시 소속 부서, 반, 근무조 조회
		List<HashMap> result = zhr_tna_Service.select_emp_work_dept(request, response);
		logger.debug("result = {}", result);
		
		HashMap<String, Object> dept_param = new HashMap<String, Object>();
		// 2020-08-20 jamerl - 권한, 소속 부서, 반, 조의 정보가 반드시 필요
		dept_param.put("s_authogrp_code", session.getAttribute("s_authogrp_code"));
		dept_param.put("orgeh", result.get(0).get("ORGEH"));
		dept_param.put("zclss", result.get(0).get("ZCLSS"));
		dept_param.put("schkz", result.get(0).get("SCHKZ"));
		dept_param.put("emp_code",(String) session.getAttribute("empCode"));
		
		mav.addObject("orgeh", result.get(0).get("ORGEH"));
		mav.addObject("zclss", result.get(0).get("ZCLSS"));
		mav.addObject("schkz", result.get(0).get("SCHKZ"));
		
		List teamList = zhr_tna_Service.select_team_list(dept_param);
		mav.addObject("teamList", teamList);
		List groupList = zhr_tna_Service.select_group_list(dept_param);
		mav.addObject("groupList", groupList);
		List shiftList = zhr_tna_Service.select_shift_list(dept_param);
		mav.addObject("shiftList", shiftList);
		
//		if(session.getAttribute("shiftList")==null){
//			ArrayList<HashMap<String, String>> shiftList = util.retrieveWorkShift(req_data);
//			mav.addObject("shiftList",shiftList);
//			session.setAttribute("shiftList", shiftList);
//		}else{
//			mav.addObject("shiftList",session.getAttribute("shiftList"));
//		}
//		if(session.getAttribute("groupList")==null){
//			ArrayList<HashMap<String, String>> groupList = util.retrieveWorkGroup(req_data);
//			mav.addObject("groupList",groupList);
//			session.setAttribute("groupList",groupList);
//		}else{
//			mav.addObject("groupList",session.getAttribute("groupList"));
//		}
//		if(session.getAttribute("teamList")==null){
//			req_data.put("otype", "O");
//			ArrayList<HashMap<String, String>> teamList = util.retrieveTeamname(req_data);
//			mav.addObject("teamList",teamList);
//			session.setAttribute("teamList", teamList);
//		}else{
//			mav.addObject("teamList",session.getAttribute("teamList"));
//		}
		
		logger.debug("req_data >> {}", req_data);
		mav.addObject("req_data", req_data);
		
		mav.setViewName("/yp/zhr/tna/zhr_tna_list");
		return mav;
	}
	
	
	/**
	 * 인사관리 > 근태관리 > 개인 출퇴근 현황 > 엑셀 다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/yp/xls/zhr/tna/zhr_tna_list", method = RequestMethod.POST)
	public ModelAndView xls_zhr_tna_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		list = zhr_tna_Service.zhr_per_daily_report(request, response);

		mav.addObject("alllist", list);

		mav.setViewName("/yp/zhr/tna/xls/zhr_tna_list");
		return mav;
	}
	
	
	/**
	 * 인사관리 > 근태관리 > 시간외근무 등록
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zhr/tna/zhr_tna_ot_create", method = RequestMethod.POST)
	public ModelAndView zhr_tna_ot_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】인사관리 > 근태관리 > 시간외근무 등록");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		Util util = new Util();
		HashMap req_data = (HashMap)util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		req_data.put("sdate", DateUtil.getToday());
		req_data.put("edate", DateUtil.getToday());
		
		HttpSession session = request.getSession();
		req_data.put("emp_code",(String) session.getAttribute("empCode"));
		req_data.put("emp_name",((String) session.getAttribute("userName")));
		req_data.put("user_deptcd",((String) session.getAttribute("userDeptCd")));
		req_data.put("user_dept",((String) session.getAttribute("userDept")));
		req_data.put("ofc_name",((String) session.getAttribute("userOfc")));
		req_data.put("auth", (String) session.getAttribute("HR_AUTH"));
		if(req_data.get("auth") == null) req_data.put("auth","US");
//		if(req_data.get("auth") == null){
//			if("팀장".equals(req_data.get("ofc_name")))	req_data.put("auth","TM");
//			else if("조장".equals(req_data.get("ofc_name")))	req_data.put("auth","SM");
//			else 	req_data.put("auth","US");
//		}
		
		// 2020-08-25 jamerl -	화면 최초 로드시 소속 부서, 반, 근무조 조회
		List<HashMap> result = zhr_tna_Service.select_emp_work_dept(request, response);
		logger.debug("result = {}", result);
		
		HashMap<String, Object> dept_param = new HashMap<String, Object>();
		// 2020-08-20 jamerl - 권한, 소속 부서, 반, 조의 정보가 반드시 필요
		dept_param.put("s_authogrp_code", session.getAttribute("s_authogrp_code"));
		dept_param.put("orgeh", result.get(0).get("ORGEH"));
		dept_param.put("zclss", result.get(0).get("ZCLSS"));
		dept_param.put("schkz", result.get(0).get("SCHKZ"));
		dept_param.put("emp_code",(String) session.getAttribute("empCode"));
		
		mav.addObject("orgeh", result.get(0).get("ORGEH"));
		mav.addObject("zclss", result.get(0).get("ZCLSS"));
		mav.addObject("schkz", result.get(0).get("SCHKZ"));
		
		List teamList = zhr_tna_Service.select_team_list(dept_param);
		mav.addObject("teamList", teamList);
		List groupList = zhr_tna_Service.select_group_list(dept_param);
		mav.addObject("groupList", groupList);
		List shiftList = zhr_tna_Service.select_shift_list(dept_param);
		mav.addObject("shiftList", shiftList);
		
//		if(session.getAttribute("shiftList")==null){
//			ArrayList<HashMap<String, String>> shiftList = util.retrieveWorkShift(req_data);
//			mav.addObject("shiftList",shiftList);
//			session.setAttribute("shiftList", shiftList);
//		}else{
//			mav.addObject("shiftList",session.getAttribute("shiftList"));
//		}
//		if(session.getAttribute("groupList")==null){
//			ArrayList<HashMap<String, String>> groupList = util.retrieveWorkGroup(req_data);
//			mav.addObject("groupList",groupList);
//			session.setAttribute("groupList",groupList);
//		}else{
//			mav.addObject("groupList",session.getAttribute("groupList"));
//		}
//		if(session.getAttribute("teamList")==null){
//			req_data.put("otype", "O");
//			ArrayList<HashMap<String, String>> teamList = util.retrieveTeamname(req_data);
//			mav.addObject("teamList",teamList);
//			session.setAttribute("teamList", teamList);
//		}else{
//			mav.addObject("teamList",session.getAttribute("teamList"));
//		}
		logger.debug("req_data >> {}", req_data);
		mav.addObject("req_data", req_data);
		
		mav.setViewName("/yp/zhr/tna/zhr_tna_ot_create");
		return mav;
	}
	
	
	/**
	 * 인사관리 > 근태관리 > 시간외근무 등록 > 엑셀 다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/yp/xls/zhr/tna/zhr_tna_ot_create", method = RequestMethod.POST)
	public ModelAndView xls_zhr_tna_ot_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		list = (ArrayList<HashMap<String, String>>) zhr_tna_Service.select_zhr_per_daily_report(request, response);

		mav.addObject("alllist", list);

		mav.setViewName("/yp/zhr/tna/xls/zhr_tna_ot_create");
		return mav;
	}
	
	
	/**
	 * 인사관리 > 근태관리 > 시간외근무 등록 > 시간외근무 등록 안내 팝업
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zhr/tna/ot_notice_pop", method = RequestMethod.GET)
	public ModelAndView ot_notice_pop(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/yp/zhr/tna/ot_notice_pop");
		return mav;
	}
	
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zhr/tna/select_ser_team", method = RequestMethod.POST)
	public ModelAndView select_ser_team(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap<String, Object> req_data = (HashMap<String, Object>) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		ArrayList<HashMap<String, String>> result = (ArrayList<HashMap<String, String>>) zhr_tna_Service.select_team_list(req_data);
		
		HashMap resultMap = new HashMap();
		resultMap.put("list", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}


	/**
	 * 콤보 반 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zhr/tna/select_ser_class", method = RequestMethod.POST)
	public ModelAndView select_ser_class(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap<String, Object> req_data = (HashMap<String, Object>) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		ArrayList<HashMap<String, String>> result = (ArrayList<HashMap<String, String>>) zhr_tna_Service.select_group_list(req_data);
		
		HashMap resultMap = new HashMap();
		resultMap.put("list", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	/**
	 * 콤보 근무조 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zhr/tna/select_ser_shift", method = RequestMethod.POST)
	public ModelAndView select_ser_shift(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap<String, Object> req_data = (HashMap<String, Object>) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		ArrayList<HashMap<String, String>> result = (ArrayList<HashMap<String, String>>) zhr_tna_Service.select_shift_list(req_data);

		HashMap resultMap = new HashMap();
		resultMap.put("list", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	/**
	 * 인사관리 > 근태관리 > 시간외근무 등록 > 부서정보 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zhr/tna/retrieveEmpWorkInfo", method = RequestMethod.POST)
	public ModelAndView retrieveEmpWorkInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ArrayList<HashMap<String, String>> result = (ArrayList<HashMap<String, String>>) zhr_tna_Service.retrieveEmpWorkInfo(request, response);

		HashMap resultMap = new HashMap();
		
		resultMap.put("msg","조회되었습니다.");
		resultMap.put("list", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	/**
	 * 인사관리 > 근태관리 > 시간외근무 등록 > 동명사원 팝업
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zhr/tna/retrieveSameNamePop", method = RequestMethod.GET)
	public ModelAndView retrieveSameNamePop(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = new ModelAndView();
		
		ArrayList<HashMap<String, String>> result = (ArrayList<HashMap<String, String>>) zhr_tna_Service.retrieveEmpWorkInfo(request, response);
		
		mav.addObject("list", result);
		mav.addObject("target", request.getParameter("target"));
		mav.setViewName("/yp/zhr/tna/search_same_name_pop");
		
		return mav;
	}
	
	
	/**
	 * 인사관리 > 근태관리 > 시간외근무 등록 > 원근무 정보 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zhr/tna/retrieveTimecard")
	public ModelAndView retrieveTimecard(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Util util = new Util();
		HashMap req_data = (HashMap)util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		req_data.put("sdate",req_data.get("work_startdate"));
		req_data.put("edate",req_data.get("work_startdate"));
		
		HttpSession session = request.getSession();
		req_data.put("emp_code",req_data.get("emp_code"));
		req_data.put("ser_name",req_data.get("emp_name"));
		req_data.put("user_dept",((String) session.getAttribute("userDept")));
		req_data.put("auth","US");
		req_data.put("otype", "O");
		logger.debug("!!!"+req_data+"!!!");
		
		ArrayList<HashMap<String, String>> timecardList = zhr_tna_Service.retrieveTimecardList(req_data);
		
		HashMap resultMap = new HashMap();
		resultMap.put("msg", "조회중 오류가 발생하였습니다.\n관리자에게 문의해 주세요.");
		if(timecardList.size() > 0){
			HashMap<String, String> result = timecardList.get(0);
			resultMap.put("msg", "00");
			String text = result.get("ZCDTX");
			String timecard = "";
			
			try{
				timecard = result.get("IN_TIME1").substring(0, 2)+":"+result.get("IN_TIME1").substring(2, 4)
						+" - "+result.get("OUT_TIME1").substring(0, 2)+":"+result.get("OUT_TIME1").substring(2, 4);
				resultMap.put("time_card1", result.get("IN_TIME1"));
				resultMap.put("time_card2", result.get("OUT_TIME1"));
				resultMap.put("time_card3", result.get("IN_TIME2"));
				resultMap.put("time_card4", result.get("OUT_TIME2"));
				resultMap.put("time_card5", result.get("IN_TIME3"));
				resultMap.put("time_card6", result.get("OUT_TIME3"));
			}catch(Exception e){
				e.printStackTrace();
				timecard = result.get("BIGO");
			}
			
			resultMap.put("text", text);
			resultMap.put("timecard", timecard);
			resultMap.put("origin_work", result.get("ZCDTX"));
			resultMap.put("origin_work_code", result.get("TPROG"));
			resultMap.put("regular_work1", result.get("NOMBEG"));
			resultMap.put("regular_work2", result.get("NOMEND"));
		}
		logger.debug("result="+resultMap);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	/**
	 * 인사관리 > 근태관리 > 시간외근무 등록 > 작업구분 대체근무 선택시 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zhr/tna/retrieveVacationEmpList")
	public ModelAndView retrieveVacationEmpList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Util util = new Util();
		HashMap<String, Object> req_data = (HashMap<String, Object>) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		logger.debug("retrieveVacationEmpList.req_data="+req_data);
		HashMap<String,ArrayList<HashMap<String, String>>> result = zhr_tna_Service.retrieveVacationEmpList(req_data);
		
		HashMap resultMap = new HashMap();
		resultMap.put("list",result.get("list"));
		resultMap.put("msg",result.get("data").get(0).get("msg"));
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	/**
	 * 인사관리 > 근태관리 > 시간외근무 등록 > 선택 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zhr/tna/createOvertime")
	public ModelAndView createOvertime(HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/xml; charset=utf-8");
		
		HashMap resultMap = new HashMap();
		resultMap.put("msg", "등록중 오류가 발생하였습니다.\n관리자에게 문의해 주세요.");
		resultMap.put("code","01");
		
		Util util = new Util();
		HashMap req_data = (HashMap)util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		req_data.put("no", request.getParameterValues("no"));
		
		logger.debug(""+req_data);
		HttpSession session = request.getSession();
		req_data.put("reg_worker",(String) session.getAttribute("empCode"));
		req_data.put("reg_worker_name",(String) session.getAttribute("userName"));
		req_data.put("auth",(String) session.getAttribute("HR_AUTH"));
//		req_data.put("team_code",(String) session.getAttribute("userDeptCd"));
//		req_data.put("team_name",(String) session.getAttribute("userDept"));
//		HashMap<String,String> upperDeptName = zhr_tna_Service.retrieveUpperDepartment((String)req_data.get("team_code"));
		// 2020-09-09 jamerl - 조용래, 전정대 : 세션의 부서코드, 명 대신 파라미터의 부서코드, 명을 사용하도록 변경
		
//		String result = hrService.retrieveOvertimeCheck(req_data);
		HashMap<String,String> result = zhr_tna_Service.createOvertime(req_data);
		String msg = "";
		if(Integer.parseInt(result.get("cnt")) > 0){
			msg = result.get("cnt")+"건이 등록 되었습니다.\n";
		}
		if(result.get("code") == "00") {
			resultMap.put("code","00");
		}else if(result.get("code") == "02") { 
			msg += result.get("proc_row")+"번 항목 - 시간외근무 신청시간이 중복됩니다.";
		}else if(result.get("code") == "03") { 
			msg += result.get("proc_row")+"번 항목 - 주간 추가 근무시간이 12시간을 초과할 수 없습니다.\n(신청중인 초과근무시간 까지 계산됩니다.)";
		}else if(result.get("code") == "04") { 
			msg += result.get("proc_row")+"번 항목 - 선택된 원근무자의 대체근무가 등록되어 있습니다.";
		}
		resultMap.put("msg",msg);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	/**
	 * 인사관리 > 근태관리 > 시간외근무 등록 > 선택 삭제, 선택 반려
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zhr/tna/updateOverPlanStauts")
	public ModelAndView updateOverPlanStauts(HttpServletRequest request, HttpServletResponse response) throws Exception {
		boolean check = true;//"SA".equals(auth) || "MA".equals(auth) || "팀장".equals(ofc)
//		logger.debug("인사메뉴 권한 : " + auth);
		HashMap resultMap = new HashMap();
		
		if(check) {
			resultMap.put("msg", "서버처리중 오류가 발생하였습니다.\n관리자에게 문의해 주세요.");
			int result = zhr_tna_Service.updateOverPlanStauts(request, response);
			logger.debug("result = {}", result);
			if(result > 0) {
				resultMap.put("msg","처리 되었습니다.");
			}
		} else {
			resultMap.put("msg", "권한이 없습니다.");
		}
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	/**
	 * 인사관리 > 근태관리 > 시간외근무 등록 > 선택 삭제, 선택 반려
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/popup/zhr/tna/createOverPlanToSAP")
	public ModelAndView createOverPlanToSAP(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		Util util = new Util();
		HashMap req_data = (HashMap)util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		logger.debug("**"+req_data);
		req_data.put("teamcode",(String) session.getAttribute("userDeptCd"));
		HashMap<String,String> upperDeptName = zhr_tna_Service.retrieveUpperDepartment((String)req_data.get("teamcode"));
		if("50000001".equals(upperDeptName.get("DEPT_CD"))) req_data.put("work_place","1100");		//본사
		else if("50000002".equals(upperDeptName.get("DEPT_CD"))) req_data.put("work_place","1200");	//석포제련소
		else if("50000003".equals(upperDeptName.get("DEPT_CD"))) req_data.put("work_place","1300");	//안성휴게소
		else if("60007226".equals(upperDeptName.get("DEPT_CD"))) req_data.put("work_place","1600");	//그린메탈캠퍼스
		
		JSONObject json = new JSONObject();
		json.put("msg", "등록중 오류가 발생하였습니다.\n관리자에게 문의해 주세요.");
		json.put("code","01");
		
//		String[] seq = request.getParameterValues("seq");
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("seq").toString());
		logger.debug("jsonArr = {}", jsonArr);
		HashMap seqs = new HashMap();
//		seqs.put("seq", seq);
		seqs.put("seq", jsonArr);
		seqs.put("emp_code", (String) session.getAttribute("empCode"));
		seqs.put("emp_name", (String) session.getAttribute("userName"));
		ArrayList<HashMap<String, String>> list = (ArrayList<HashMap<String, String>>) zhr_tna_Service.retrieveOvertimePlanListBySeq(seqs);
		
		HashMap<String, Object> result = zhr_tna_Service.createOverPlanToSAP(request, list);
//		logger.debug("result ------ {}", result);
//		logger.debug("result.get(\"list\") ------ {}", result.get("list"));
		HashMap<String, String> ex_param = (HashMap<String, String>) result.get("ex_param");
		ArrayList<HashMap<String, String>> result_list = (ArrayList<HashMap<String, String>>) result.get("list");
		
		ArrayList seqlist = new ArrayList();
		
		for(int i=0;i<result_list.size();i++) {
//		for(int i=0;i<list.size();i++){
			if(result_list.get(i).get("ERROR").equals("Y"))
				seqlist.add(result_list.get(i).get("SEQ"));
//				seqlist.add(list.get(i).get("SEQ"));
		}
		logger.debug("seqlist="+seqlist);
		seqs.put("seq", seqlist);
		if(seqlist.size()>0) {
			int rows = zhr_tna_Service.updateOverPlanConfirm(request, seqlist);
		}
		ModelAndView mav = new ModelAndView();
		mav.addObject("ex_param",result.get("ex_param"));
		mav.addObject("list",result.get("list"));
		mav.addObject("req_data",req_data);
		mav.setViewName("/yp/zhr/tna/createOvertimeToSap_result_pop");
		return mav;
	}
	
	
	/**
	 * 인사관리 > 근태관리 > 시간외근무 확정 조회
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zhr/tna/zhr_tna_ot_confirm_list", method = RequestMethod.POST)
	public ModelAndView zhr_tna_ot_confirm_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】인사관리 > 근태관리 > 시간외근무 확정 조회");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		Util util = new Util();
		HashMap req_data = (HashMap)util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		req_data.put("sdate", DateUtil.getToday());
		req_data.put("edate", DateUtil.getToday());
		
		HttpSession session = request.getSession();
		req_data.put("emp_code",(String) session.getAttribute("empCode"));
		req_data.put("emp_name",((String) session.getAttribute("userName")));
		req_data.put("ser_teamcode",((String) session.getAttribute("userDeptCd")));
		req_data.put("ser_teamname",((String) session.getAttribute("userDept")));
		req_data.put("ofc_name",((String) session.getAttribute("userOfc")));
		
		req_data.put("auth", (String) session.getAttribute("HR_AUTH"));
		if(req_data.get("auth") == null) req_data.put("auth","US");
//		if(req_data.get("auth") == null){
//			if("팀장".equals(req_data.get("ofc_name")))	req_data.put("auth","TM");
////			else if("조장".equals(req_data.get("ofc_name")))	req_data.put("auth","SM");
//			else 	req_data.put("auth","US");
//		}
		
		mav.addObject("req_data", req_data);
		
		mav.setViewName("/yp/zhr/tna/zhr_tna_ot_confirm_list");
		return mav;
	}
	
	
	/**
	 * 인사관리 > 근태관리 > 시간외근무 확정 조회 > 엑셀 다운로드
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/yp/xls/zhr/tna/zhr_per_overtime_report")
	public ModelAndView zhr_per_overtime_report(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		list = zhr_tna_Service.zhr_per_overtime_report(request, response);

		mav.addObject("alllist", list);

		mav.setViewName("/yp/zhr/tna/xls/zhr_tna_ot_confirm_list");
		return mav;
	}
}
