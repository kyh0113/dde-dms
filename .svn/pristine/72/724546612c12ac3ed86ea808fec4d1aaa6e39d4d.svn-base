package com.yp.zwc.ipt2.cntr;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.vicurus.it.core.common.CommonUtil;
import com.vicurus.it.core.common.Util;
import com.yp.login.srvc.intf.YPLoginService;
import com.yp.util.DateUtil;
import com.yp.zwc.ctr.srvc.intf.YP_ZWC_CTR_Service;
import com.yp.zwc.ipt2.srvc.intf.YP_ZWC_IPT2_Service;

@Controller
public class YP_ZWC_IPT2_Controller {

	@Value("#{config['db.url']}")
	private String p_url;
	@Value("#{config['db.username']}")
	private String p_username;
	@Value("#{config['db.password']}")
	private String p_password;
	
	@Autowired
	private YP_ZWC_IPT2_Service YP_ZWC_IPT2_Service;
	
	@Autowired
	private CommonUtil commonUtil;

	@Autowired
	private YP_ZWC_CTR_Service YP_ZWC_CTR_Service;
	
	@Autowired
	private YPLoginService lService;
	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_IPT2_Controller.class);
	
	/* 도급일보(협력사) - 시작 #################################################################################################################################################################################### */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/ipt2/zwc_ipt2_daily_create", method = RequestMethod.POST)
	public ModelAndView zwc_ipt2_daily_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】조업도급 > 도급검수 > 도급일보(협력사)");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		// 부서 세팅
		Util util = new Util();
		HashMap req_data = (HashMap)util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		
		req_data.put("emp_code",(String) session.getAttribute("empCode"));
		req_data.put("emp_name",((String) session.getAttribute("userName")));
		req_data.put("user_deptcd",((String) session.getAttribute("userDeptCd")));
		req_data.put("user_dept",((String) session.getAttribute("userDept")));
		req_data.put("ofc_name",((String) session.getAttribute("userOfc")));
		req_data.put("auth", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH"));
		
		// 2020-08-25 jamerl -	화면 최초 로드시 소속 부서, 반, 근무조 조회
		List<HashMap> result = YP_ZWC_CTR_Service.select_emp_work_dept(request, response);
		logger.debug("result = {}", result);
		
		HashMap<String, Object> dept_param = new HashMap<String, Object>();
		if(result.size() > 0) {
			// 2020-08-20 jamerl - 권한, 소속 부서, 반, 조의 정보가 반드시 필요
			dept_param.put("s_authogrp_code", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH"));
			dept_param.put("orgeh", result.get(0).get("ORGEH"));
			dept_param.put("zclss", result.get(0).get("ZCLSS"));
			dept_param.put("schkz", result.get(0).get("SCHKZ"));
			dept_param.put("emp_code",(String) session.getAttribute("empCode"));
			
			mav.addObject("orgeh", result.get(0).get("ORGEH"));
			mav.addObject("zclss", result.get(0).get("ZCLSS"));
			mav.addObject("schkz", result.get(0).get("SCHKZ"));
			
			List teamList = YP_ZWC_CTR_Service.select_team_list(dept_param);
			mav.addObject("teamList", teamList);
		}else {
			// 2020-11-23 jamerl - 협력사는 부서정보가 없음. 혹시 협력사가 부서정보가 있는 화면을 쓰게되면 아래 로직을 구현해야 함.
			// 현재는 그런 화면 없음
			// 화면 출력에서 에러는 발생되지 않지만 실제 데이터는 조회되지 않도록 조회조건값을 부서코드가 아닌 값으로 임시조치
			mav.addObject("orgeh", "부서정보없음");
			mav.addObject("teamList", new ArrayList());
		}
		
//		List<HashMap<String, Object>> cb_working_master_v = YP_ZWC_IPT2_Service.select_cb_working_master_v(req_data);
		List<HashMap<String, Object>> cb_working_master_v = new ArrayList<HashMap<String, Object>>();
		HashMap map_v = new HashMap<String, Object>();
		if("SA".equals(session.getAttribute("s_authogrp_code"))) {
			map_v.put("CODE", "V1");
			map_v.put("CODE_NAME", "세진 ENT");
			cb_working_master_v.add(map_v);
		}else {
			map_v.put("CODE", session.getAttribute("ent_vendor_code"));
			map_v.put("CODE_NAME", session.getAttribute("ent_vendor_name"));
			cb_working_master_v.add(map_v);
		}
		
		List<HashMap<String, Object>> cb_tbl_working_subc = new ArrayList<HashMap<String,Object>>();
		if(cb_working_master_v.size() > 0) {
			req_data.put("VENDOR_CODE", cb_working_master_v.get(0).get("CODE"));
			req_data.put("BASE_YYYY", DateUtil.getToday().substring(0, 4));
			cb_tbl_working_subc = YP_ZWC_IPT2_Service.select_cb_tbl_working_subc(req_data);
		}
		
		mav.addObject("cb_tbl_working_subc", cb_tbl_working_subc);
		mav.addObject("cb_working_master_v", cb_working_master_v);
		
		mav.setViewName("/yp/zwc/ipt2/zwc_ipt2_daily_create");
		return mav;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zwc/ipt2/zwc_ipt2_daily_create_worker_popup")
	public ModelAndView zwc_ipt2_daily_create_worker_popup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("target", paramMap.get("target"));

		//mav.addObject("WORKTYPE_LIST", zwc_ctr_Service.select_zwc_ctr_worktype_list(paramMap));		//근무형태 셀렉트리스트
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zwc/ipt2/zwc_ipt2_daily_create_worker_popup");
		return mav;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt2/save_tbl_working_daily_report")
	public ModelAndView save_tbl_working_daily_report(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【컨트롤러】조업도급 > 도급검수 > 도급일보(협력사) > 저장");
		HashMap resultMap = new HashMap();
		
		int result = YP_ZWC_IPT2_Service.save_tbl_working_daily_report(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt2/delete_tbl_working_daily_report")
	public ModelAndView delete_tbl_working_daily_report(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【컨트롤러】조업도급 > 도급검수 > 도급일보(협력사) > 삭제");
		HashMap resultMap = new HashMap();
		
		int result = YP_ZWC_IPT2_Service.delete_tbl_working_daily_report(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt2/possible")
	public ModelAndView possible(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HashMap resultMap = new HashMap();

		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		String possible_str = "";
		int possible_base_dt = 0;

		if( "C".equals(req_data.get("POSSIBLE")) ) {
			possible_str = "확정";
			// 일보일자 포함 이틀
			possible_base_dt = 1;
		} else if(  "A".equals(req_data.get("POSSIBLE"))  ){
			possible_str = "승인/승인취소";
			// 일보일자 포함 사흘
			possible_base_dt = 2;
		} else {
			resultMap.put("possible", false);
			resultMap.put("possible_msg", "확인/승인 파라미터가 지정되지 않았습니다. 시스템 관리자에게 문의하세요.");
			return new ModelAndView("DataToJson", resultMap);
		}
		logger.debug("【컨트롤러】조업도급 > 도급검수 > 도급일보(협력사) > {} 가능 여부 확인", possible_str);

		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		Date today_dt = new Date();
		Date limit_dt = new Date();
		Calendar today_cal = Calendar.getInstance();
		Calendar limit_cal = Calendar.getInstance();
		String today_str = formatter.format(today_dt);
		today_dt = formatter.parse( today_str );
		today_cal.setTime( today_dt );
		boolean rt = true;

		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			limit_dt = formatter.parse( jsonObj.get("BASE_YYYYMMDD").toString().replace("/", "") );
			limit_cal.setTime( limit_dt );
			int possible_dt = 0;

			logger.debug( "선택 데이터 - [{}], 요일(1:일, 2:월, ... , 6:금, 7:토) - [{}]", jsonObj.get("BASE_YYYYMMDD"), limit_cal.get(Calendar.DAY_OF_WEEK) );
			if( "C".equals(req_data.get("POSSIBLE")) ) {
				// 확정
				if( limit_cal.get(Calendar.DAY_OF_WEEK) == 6 ) {
					// 금요일
					possible_dt = possible_base_dt + 2;
				} else if( limit_cal.get(Calendar.DAY_OF_WEEK) == 7 ) {
					// 토요일
					possible_dt = possible_base_dt + 1;
				} else {
					possible_dt = possible_base_dt;
				}
			} else {
				// 승인
				if( limit_cal.get(Calendar.DAY_OF_WEEK) == 5 ) {
					// 목요일
					possible_dt = possible_base_dt + 3;
				} else if( limit_cal.get(Calendar.DAY_OF_WEEK) == 6 ) {
					// 금요일
					possible_dt = possible_base_dt + 2;
				} else if( limit_cal.get(Calendar.DAY_OF_WEEK) == 7 ) {
					// 토요일
					possible_dt = possible_base_dt + 1;
				} else {
					possible_dt = possible_base_dt;
				}
			}
			logger.debug( "추가일수 - [{}]", possible_dt );
			// 가능일자 설정
			limit_cal.add(Calendar.DATE, possible_dt);
			logger.debug( "오늘 - [{}], 가능일자 - [{}]", sdf.format( today_cal.getTime() ), sdf.format( limit_cal.getTime() ) );
			logger.debug( "결과 - [{}]", !today_cal.after(limit_cal) );
			// 관리자가 허용한 경우 처리할 수 있도록 허용 로직 추가
			// 이곳에 추가
			if( today_cal.after(limit_cal) ) {
				// 가능일자 초과 처리
				rt = false;
				break;
			}
		}

		resultMap.put("possible", rt);
		if( !rt ) {
			resultMap.put("possible_msg", "처리 일자를 초과하여 【" + possible_str + "】할 수 없습니다.");
		}
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt2/confirm_tbl_working_daily_report")
	public ModelAndView confirm_tbl_working_daily_report(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【컨트롤러】조업도급 > 도급검수 > 도급일보(협력사) > 확정");
		HashMap resultMap = new HashMap();
		
		int result = YP_ZWC_IPT2_Service.confirm_tbl_working_daily_report(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	/* 도급일보(협력사) - 끝 #################################################################################################################################################################################### */

	/* 도급승인 - 시작 #################################################################################################################################################################################### */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/ipt2/zwc_ipt2_daily_approval", method = RequestMethod.POST)
	public ModelAndView zwc_ipt2_daily_approval(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】조업도급 > 도급검수 > 일보 승인");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		// 부서 세팅
		Util util = new Util();
		HashMap req_data = (HashMap)util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		
		req_data.put("emp_code",(String) session.getAttribute("empCode"));
		req_data.put("emp_name",((String) session.getAttribute("userName")));
		req_data.put("user_deptcd",((String) session.getAttribute("userDeptCd")));
		req_data.put("user_dept",((String) session.getAttribute("userDept")));
		req_data.put("ofc_name",((String) session.getAttribute("userOfc")));
		req_data.put("auth", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH"));
		
		// 2020-08-25 jamerl -	화면 최초 로드시 소속 부서, 반, 근무조 조회
		List<HashMap> result = YP_ZWC_CTR_Service.select_emp_work_dept(request, response);
		logger.debug("result = {}", result);
		
		HashMap<String, Object> dept_param = new HashMap<String, Object>();
		if(result.size() > 0) {
			// 2020-08-20 jamerl - 권한, 소속 부서, 반, 조의 정보가 반드시 필요
			dept_param.put("s_authogrp_code", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH"));
			dept_param.put("orgeh", result.get(0).get("ORGEH"));
			dept_param.put("zclss", result.get(0).get("ZCLSS"));
			dept_param.put("schkz", result.get(0).get("SCHKZ"));
			dept_param.put("emp_code",(String) session.getAttribute("empCode"));
			
			mav.addObject("orgeh", result.get(0).get("ORGEH"));
			mav.addObject("zclss", result.get(0).get("ZCLSS"));
			mav.addObject("schkz", result.get(0).get("SCHKZ"));
			
			List teamList = YP_ZWC_CTR_Service.select_team_list(dept_param);
			mav.addObject("teamList", teamList);
		}else {
			// 2020-11-23 jamerl - 협력사는 부서정보가 없음. 혹시 협력사가 부서정보가 있는 화면을 쓰게되면 아래 로직을 구현해야 함.
			// 현재는 그런 화면 없음
			// 화면 출력에서 에러는 발생되지 않지만 실제 데이터는 조회되지 않도록 조회조건값을 부서코드가 아닌 값으로 임시조치
			mav.addObject("orgeh", "부서정보없음");
			mav.addObject("teamList", new ArrayList());
		}
		
		List<HashMap<String, Object>> cb_working_master_v = YP_ZWC_IPT2_Service.select_cb_working_master_v(req_data);
		List<HashMap<String, Object>> cb_tbl_working_subc = new ArrayList<HashMap<String,Object>>();
		if(cb_working_master_v.size() > 0) {
			req_data.put("VENDOR_CODE", cb_working_master_v.get(0).get("CODE"));
			req_data.put("BASE_YYYY", DateUtil.getToday().substring(0, 4));
			cb_tbl_working_subc = YP_ZWC_IPT2_Service.select_cb_tbl_working_subc_approval(req_data);
		}
		
		mav.addObject("cb_tbl_working_subc", cb_tbl_working_subc);
		mav.addObject("cb_working_master_v", cb_working_master_v);
		
		mav.setViewName("/yp/zwc/ipt2/zwc_ipt2_daily_approval");
		return mav;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt2/select_cb_tbl_working_subc")
	public ModelAndView select_cb_tbl_working_subc(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【계약콤보 조회】조업도급 > 도급검수 > 일보 승인 ");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap resultMap = new HashMap();
		
		List result = YP_ZWC_IPT2_Service.select_cb_tbl_working_subc(req_data);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt2/merge_tbl_working_daily_approval")
	public ModelAndView merge_tbl_working_daily_approval(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【저장】조업도급 > 도급검수 > 일보 승인 > 마스터 등록 ");
		HashMap resultMap = new HashMap();
		
		int result = YP_ZWC_IPT2_Service.merge_tbl_working_daily_approval(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt2/merge_tbl_working_daily_approval_dt")
	public ModelAndView merge_tbl_working_daily_approval_dt(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【저장】조업도급 > 도급검수 > 일보 승인 > 상세 등록 ");
		HashMap resultMap = new HashMap();
		
		int result = YP_ZWC_IPT2_Service.merge_tbl_working_daily_approval_dt(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt2/update_tbl_working_daily_approval_tlc")
	public ModelAndView update_tbl_working_daily_approval_tlc(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【저장】조업도급 > 도급검수 > 일보 승인 > 팀장확인, 취소(단건) ");
		HashMap resultMap = new HashMap();
		
		int result = YP_ZWC_IPT2_Service.update_tbl_working_daily_approval_tlc(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt2/update_tbl_working_daily_approval_tlc_y")
	public ModelAndView update_tbl_working_daily_approval_tlc_y(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【저장】조업도급 > 도급검수 > 일보 승인 > 팀장확인(일괄) ");
		HashMap resultMap = new HashMap();
		
		int result = YP_ZWC_IPT2_Service.update_tbl_working_daily_approval_tlc_y(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt2/update_tbl_working_daily_approval_tlc_n")
	public ModelAndView update_tbl_working_daily_approval_tlc_n(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【저장】조업도급 > 도급검수 > 일보 승인 > 팀장취소(일괄) ");
		HashMap resultMap = new HashMap();
		
		int result = YP_ZWC_IPT2_Service.update_tbl_working_daily_approval_tlc_n(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	/* 도급승인 - 끝 #################################################################################################################################################################################### */

	/* 도급월보 - 시작 #################################################################################################################################################################################### */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/ipt2/zwc_ipt2_mon_create", method = RequestMethod.POST)
	public ModelAndView zwc_ipt2_mon_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】조업도급 > 도급검수 > 도급월보 등록");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		// 부서 세팅
		Util util = new Util();
		HashMap req_data = (HashMap)util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		
		req_data.put("emp_code",(String) session.getAttribute("empCode"));
		req_data.put("emp_name",((String) session.getAttribute("userName")));
		req_data.put("user_deptcd",((String) session.getAttribute("userDeptCd")));
		req_data.put("user_dept",((String) session.getAttribute("userDept")));
		req_data.put("ofc_name",((String) session.getAttribute("userOfc")));
		req_data.put("auth", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH"));
		
		// 2020-08-25 jamerl -	화면 최초 로드시 소속 부서, 반, 근무조 조회
		List<HashMap> result = YP_ZWC_CTR_Service.select_emp_work_dept(request, response);
		logger.debug("result = {}", result);
		
		HashMap<String, Object> dept_param = new HashMap<String, Object>();
		if(result.size() > 0) {
			// 2020-08-20 jamerl - 권한, 소속 부서, 반, 조의 정보가 반드시 필요
			dept_param.put("s_authogrp_code", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH"));
			dept_param.put("orgeh", result.get(0).get("ORGEH"));
			dept_param.put("zclss", result.get(0).get("ZCLSS"));
			dept_param.put("schkz", result.get(0).get("SCHKZ"));
			dept_param.put("emp_code",(String) session.getAttribute("empCode"));
			
			mav.addObject("orgeh", result.get(0).get("ORGEH"));
			mav.addObject("zclss", result.get(0).get("ZCLSS"));
			mav.addObject("schkz", result.get(0).get("SCHKZ"));
			
			List teamList = YP_ZWC_CTR_Service.select_team_list(dept_param);
			mav.addObject("teamList", teamList);
		}else {
			// 2020-11-23 jamerl - 협력사는 부서정보가 없음. 혹시 협력사가 부서정보가 있는 화면을 쓰게되면 아래 로직을 구현해야 함.
			// 현재는 그런 화면 없음
			// 화면 출력에서 에러는 발생되지 않지만 실제 데이터는 조회되지 않도록 조회조건값을 부서코드가 아닌 값으로 임시조치
			mav.addObject("orgeh", "부서정보없음");
			mav.addObject("teamList", new ArrayList());
		}
		List<HashMap<String, Object>> cb_working_master_v = YP_ZWC_IPT2_Service.select_cb_working_master_v(req_data);
		List<HashMap<String, Object>> cb_tbl_working_subc = new ArrayList<HashMap<String,Object>>();
		if(cb_working_master_v.size() > 0) {
			req_data.put("VENDOR_CODE", cb_working_master_v.get(0).get("CODE"));
			cb_tbl_working_subc = YP_ZWC_IPT2_Service.select_cb_tbl_working_subc(req_data);
		}
		mav.addObject("cb_tbl_working_subc", cb_tbl_working_subc);
		mav.addObject("cb_working_master_v", cb_working_master_v);
		
		mav.setViewName("/yp/zwc/ipt2/zwc_ipt2_mon_create");
		return mav;
	}
	/* 도급월보 - 끝 #################################################################################################################################################################################### */
	
	/* 도급비청구서(신규) - 시작 #################################################################################################################################################################################### */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/ipt2/zwc_ipt2_contract_bill", method = RequestMethod.POST)
	public ModelAndView zwc_ipt2_contract_bill(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】조업도급 > 비용처리 > 도급비청구서(신규)");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		HttpSession session = request.getSession();
		
		List<HashMap<String, Object>> cb_working_master_v = new ArrayList<HashMap<String, Object>>();
		HashMap map_v = new HashMap<String, Object>();
		if("SA".equals(session.getAttribute("s_authogrp_code"))) {
			map_v.put("CODE", "V1");
			map_v.put("CODE_NAME", "세진 ENT");
			cb_working_master_v.add(map_v);
		}else {
			map_v.put("CODE", session.getAttribute("ent_vendor_code"));
			map_v.put("CODE_NAME", session.getAttribute("ent_vendor_name"));
			cb_working_master_v.add(map_v);
		}
		
		mav.addObject("cb_working_master_v", cb_working_master_v);
		
		mav.setViewName("/yp/zwc/ipt2/zwc_ipt2_contract_bill");
		return mav;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt2/pre_select_ipt2_contract_bill")
	public ModelAndView pre_select_ipt2_contract_bill(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【조회】조업도급 > 비용처리 > 도급비청구서(신규) > 첨부가능여부 확인");
		HashMap resultMap = new HashMap();
		
		int result = YP_ZWC_IPT2_Service.pre_select_ipt2_contract_bill(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt2/select_zwc_ipt2_contract_bill_upload")
	public ModelAndView select_zwc_ipt2_contract_bill_upload(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【조회】조업도급 > 비용처리 > 도급비청구서(신규) > 첨부파일 정보 조회");
		HashMap resultMap = new HashMap();
		
		HashMap<String, Object> result = YP_ZWC_IPT2_Service.select_zwc_ipt2_contract_bill_upload(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value="/yp/popup/ipt2/print_contract_bill")
	public void print_contract_bill(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Connection conn = null;
		Map parameters = new HashMap();
		try {
			Util util = new Util();
			Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
			List fileNames = new ArrayList();		//레포트 파일명을 담을 리스트
			fileNames.add(0, paramMap.get("p_report"));
			// Get a database connection
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String url = p_url;
//			conn = DriverManager.getConnection(url, "webpt", "Webpt3370");
//			conn = DriverManager.getConnection(url, "webpt_cp", "webpt_cp3370");
			conn = DriverManager.getConnection(url, p_username, p_password);
			
			// Get Parameter
			//String REPORT_FILE_NAME = request.getParameter("reportFileName");
			//String MODEL_CD= request.getParameter("model_cd");
			
			// Put Parameter
			// 파라미터  VENDOR_CODE,   BASE_YYYY, p1 (업체명), p2 (대표자명) 
			parameters.put("VENDOR_CODE", paramMap.get("VENDOR_CODE"));
			parameters.put("BASE_YYYY", paramMap.get("BASE_YYYY"));
			parameters.put("p1", paramMap.get("p1"));
			parameters.put("p2", paramMap.get("p2") == null ? "" : paramMap.get("p2"));
			
			//go PDF Output
			commonUtil.generatePDFOutput(response, parameters, fileNames, conn);	
			
		} catch (Exception e) {
			e.getStackTrace();
			request.setAttribute("exception", e);
			//getServletContext().getRequestDispatcher("/jsp/exception.jsp").forward(request,response);
			logger.error("{}",e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException sqle) {
					// Ignore
				}
			}
		}
	}
	/* 도급비청구서(신규) - 종료 #################################################################################################################################################################################### */
}
