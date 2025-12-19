package com.yp.zwc.ctr.cntr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.vicurus.it.core.common.Pagination;
import com.vicurus.it.core.common.Util;
import com.yp.login.srvc.intf.YPLoginService;
import com.yp.util.DateUtil;
import com.yp.zwc.ctr.srvc.intf.YP_ZWC_CTR_Service;
import com.yp.zwc.ipt2.srvc.intf.YP_ZWC_IPT2_Service;

@Controller
public class YP_ZWC_CTR_Controller {
	
	@Autowired
	private YP_ZWC_IPT2_Service YP_ZWC_IPT2_Service;

	@Autowired
	private YP_ZWC_CTR_Service zwc_ctr_Service;
	
	@Autowired
	private YPLoginService lService;

	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_CTR_Controller.class);

	/**
	 * 조업도급 > 계약관리 > 도급계약 관리
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/ctr/zwc_ctr_create", method = RequestMethod.POST)
	public ModelAndView zwc_ctr_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】조업도급 > 계약관리 > 도급계약 관리");
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
		logger.debug("도급관리 데이터권한 - {}", req_data.get("auth"));
		
		// 2020-08-25 jamerl -	화면 최초 로드시 소속 부서, 반, 근무조 조회
		List<HashMap> result = zwc_ctr_Service.select_emp_work_dept(request, response);
		logger.debug("result = {}", result);
		
		HashMap<String, Object> dept_param = new HashMap<String, Object>();
		// 2020-08-20 jamerl - 권한, 소속 부서, 반, 조의 정보가 반드시 필요
		dept_param.put("s_authogrp_code", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH"));
		dept_param.put("orgeh", result.get(0).get("ORGEH"));
		dept_param.put("zclss", result.get(0).get("ZCLSS"));
		dept_param.put("schkz", result.get(0).get("SCHKZ"));
		dept_param.put("emp_code",(String) session.getAttribute("empCode"));
		
		mav.addObject("orgeh", result.get(0).get("ORGEH"));
		mav.addObject("zclss", result.get(0).get("ZCLSS"));
		mav.addObject("schkz", result.get(0).get("SCHKZ"));
		
		List teamList = zwc_ctr_Service.select_team_list(dept_param);
		mav.addObject("teamList", teamList);
		
		mav.addObject("cb_gubun", zwc_ctr_Service.select_cb_gubun_yp_subc_gubun(request, response));
		mav.addObject("cb_gubun2", zwc_ctr_Service.select_cb_gubun_yp_factory_gubun(request, response));
		mav.addObject("cb_working_master_u", zwc_ctr_Service.select_cb_working_master_u(request, response));
		mav.addObject("cb_working_master_v", zwc_ctr_Service.select_cb_working_master_v(request, response));
		
		mav.setViewName("/yp/zwc/ctr/zwc_ctr_create");
		return mav;
	}

	/**
	 * 조업도급 > 계약관리 > 도급계약 관리 > 팝업(담당부서 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zwc/ctr/retrieveDEPT")
	public ModelAndView retrieveDEPT(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));

		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("orgeh", (String) session.getAttribute("userDeptCd"));
		paramMap.put("s_authogrp_code", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH"));

		if (paramMap.get("search_type") != null) {
			ArrayList<HashMap<String, String>> list = (ArrayList<HashMap<String, String>>) zwc_ctr_Service.retrieveDEPT(paramMap);
			int totCnt = list.size();

			Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
			mav.addObject("pagination", pagination);

			paramMap.put("firstRecordIndex", pagination.getStartIndex());
			paramMap.put("lastRecordIndex", pagination.getEndIndex());

			ArrayList<HashMap<String, String>> pagingList = util.pagingListOfERPList(list, pagination.getStartIndex(), pagination.getEndIndex());

			mav.addObject("list", pagingList);
		}
		paramMap.put("type", paramMap.get("type"));
		paramMap.put("target", paramMap.get("target"));
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zwc/ctr/search_dept_pop");
		return mav;
	}
	
	/**
	 * 조업도급 > 계약관리 > 도급계약 관리 > 팝업(담당부서 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/ctr/retrieveAjaxDEPT")
	public ModelAndView retrieveAJAXDEPT(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("orgeh", (String) session.getAttribute("userDeptCd"));
		paramMap.put("s_authogrp_code", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH"));
		paramMap.put("search_type", "I_KOSTL");
		paramMap.put("search_text", paramMap.get("DEPT_CODE"));
		
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String,String>>();
		list = (ArrayList<HashMap<String, String>>) zwc_ctr_Service.retrieveDEPT(paramMap);
		
		HashMap resultMap = new HashMap();
		
		if(list.size() > 0) {
			resultMap.put("result", list.get(0));
		}else {
			resultMap.put("result", new HashMap());
		}
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 계약관리 > 도급계약 관리 > 팝업(코스트센터 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zwc/ctr/retrieveKOSTL")
	public ModelAndView retrieveKOSTL(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		
		if (paramMap.get("search_type") != null) {
			ArrayList<HashMap<String, String>> list = zwc_ctr_Service.retrieveKOSTL(paramMap);
			int totCnt = list.size();
			
			Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
			mav.addObject("pagination", pagination);
			
			paramMap.put("firstRecordIndex", pagination.getStartIndex());
			paramMap.put("lastRecordIndex", pagination.getEndIndex());
			
			ArrayList<HashMap<String, String>> pagingList = util.pagingListOfERPList(list, pagination.getStartIndex(), pagination.getEndIndex());
			
			mav.addObject("list", pagingList);
		}
		paramMap.put("type", paramMap.get("type"));
		paramMap.put("target", paramMap.get("target"));
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zwc/ctr/search_kostl_pop");
		return mav;
	}
	
	/**
	 * 조업도급 > 계약관리 > 도급계약 관리 > 엑셀다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/xls/zwc/ctr/zwc_ctr_select")
	public ModelAndView zwc_ctr_select(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【엑셀다운로드】조업도급 > 계약관리 > 도급계약 관리");
		ModelAndView mav = new ModelAndView();
		
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		list = zwc_ctr_Service.zwc_ctr_select(request, response);

		mav.addObject("alllist", list);

		mav.setViewName("/yp/zwc/ctr/xls/zwc_ctr_create");
		return mav;
	}
	
	/**
	 * 조업도급 > 계약관리 > 도급계약 관리 > 삭제 전 도급일보 체크
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ctr/zwc_ctr_delete_chk")
	public ModelAndView zwc_ctr_delete_chk(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【삭제 전 도급일보 체크】조업도급 > 계약관리 > 도급계약 관리");
		HashMap resultMap = new HashMap();
		int result = zwc_ctr_Service.zwc_ctr_delete_chk(request, response);
		
		resultMap.put("cnt", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 계약관리 > 도급계약 관리 > 삭제
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ctr/zwc_ctr_delete")
	public ModelAndView zwc_ctr_delete(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【삭제】조업도급 > 계약관리 > 도급계약 관리");
		HashMap resultMap = new HashMap();
		int result = zwc_ctr_Service.zwc_ctr_delete(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 계약관리 > 도급계약 관리 > 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ctr/zwc_ctr_save")
	public ModelAndView zwc_ctr_save(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【저장】조업도급 > 계약관리 > 도급계약 관리");
		HashMap resultMap = new HashMap();
		int result = zwc_ctr_Service.zwc_ctr_save(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 계약관리 > 도급계약 관리 > 참조생성
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ctr/zwc_ctr_ref_save")
	public ModelAndView zwc_ctr_ref_save(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【참조생성】조업도급 > 계약관리 > 도급계약 관리");
		HashMap resultMap = new HashMap();
		int result = zwc_ctr_Service.zwc_ctr_ref_save(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 조업도급 > 계약관리 > 도급계약 내용 등록
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/ctr/zwc_ctr_detail_create", method = RequestMethod.POST)
	public ModelAndView zwc_ctr_detail_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】조업도급 > 계약관리 > 도급계약 내용 등록");
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
		List<HashMap> result = zwc_ctr_Service.select_emp_work_dept(request, response);
		logger.debug("result = {}", result);
		
		HashMap<String, Object> dept_param = new HashMap<String, Object>();
		// 2020-08-20 jamerl - 권한, 소속 부서, 반, 조의 정보가 반드시 필요
		dept_param.put("s_authogrp_code", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH"));
		dept_param.put("orgeh", result.get(0).get("ORGEH"));
		dept_param.put("zclss", result.get(0).get("ZCLSS"));
		dept_param.put("schkz", result.get(0).get("SCHKZ"));
		dept_param.put("emp_code",(String) session.getAttribute("empCode"));
		
		mav.addObject("orgeh", result.get(0).get("ORGEH"));
		mav.addObject("zclss", result.get(0).get("ZCLSS"));
		mav.addObject("schkz", result.get(0).get("SCHKZ"));
		
		List teamList = zwc_ctr_Service.select_team_list(dept_param);
		mav.addObject("teamList", teamList);
		
		mav.addObject("cb_gubun", zwc_ctr_Service.select_cb_gubun_yp_subc_gubun(request, response));
		mav.addObject("cb_working_master_u", zwc_ctr_Service.select_cb_working_master_u(request, response));
		mav.addObject("cb_working_master_v", zwc_ctr_Service.select_cb_working_master_v(request, response));
		mav.addObject("cb_working_master_w", zwc_ctr_Service.select_cb_working_master_w(request, response));
		
		mav.setViewName("/yp/zwc/ctr/zwc_ctr_detail_create");
		return mav;
	}
	
	/**
	 * 조업도급 > 계약관리 > 도급계약 내용 등록 > 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zwc/ctr/select_zwc_ctr_detail_create")
	public ModelAndView select_zwc_ctr_detail_create(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【조회】조업도급 > 계약관리 > 도급계약 내용 등록");
		HashMap resultMap = new HashMap();
		
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		list = zwc_ctr_Service.select_zwc_ctr_detail_create(request, response);
		
		resultMap.put("result", list);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 계약관리 > 도급계약 내용 등록 > 단가조회 - 인력
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zwc/ctr/select_zwc_ctr_detail_create_unit_price")
	public ModelAndView select_zwc_ctr_detail_create_unit_price(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【단가조회】조업도급 > 계약관리 > 도급계약 내용 등록");
		HashMap resultMap = new HashMap();
		List result_l = new ArrayList();
		Float result_f = 0f;
		
		result_l = zwc_ctr_Service.select_zwc_ctr_detail_create_final_unit_price(request, response);
		resultMap.put("final_unit_price", result_l);
		result_f = zwc_ctr_Service.select_zwc_ctr_detail_create_month_amount_ptc(request, response);
		resultMap.put("month_amount_ptc", result_f);
		result_f = zwc_ctr_Service.select_zwc_ctr_detail_create_month_amount_nft(request, response);
		resultMap.put("month_amount_nft", result_f);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 계약관리 > 도급계약 내용 등록 > 시간외수당 조회 - 인력
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zwc/ctr/select_overtime_pay")
	public ModelAndView select_overtime_pay(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【시간외수당 조회】조업도급 > 계약관리 > 도급계약 내용 등록");
		HashMap resultMap = new HashMap();
		HashMap result = new HashMap();
		
		result = zwc_ctr_Service.select_overtime_pay(request, response);
		resultMap.put("result", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 계약관리 > 도급계약 내용 등록 > 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zwc/ctr/zwc_ctr_detail_create_save")
	public ModelAndView zwc_ctr_detail_create_save(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【저장】조업도급 > 계약관리 > 도급계약 내용 등록");
		HashMap resultMap = new HashMap();
		int result = 0;
		
		result = zwc_ctr_Service.zwc_ctr_detail_create_save(request, response);
		
		resultMap.put("result", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	/**
	 * 조업도급 > 계약관리 > 도급계약 작업자 맵핑
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zwc/ctr/zwc_ctr_worker_mapping", method = RequestMethod.POST)
	public ModelAndView zwc_ctr_worker_mapping(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】조업도급 > 계약관리 > 도급계약 작업자 맵핑");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap req_data = (HashMap)util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		
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
		
//		mav.addObject("cb_working_master_v", zwc_ctr_Service.select_cb_working_master_v(request, response));
		
		mav.setViewName("/yp/zwc/ctr/zwc_ctr_worker_mapping");
		return mav;
	}
	
	/**
	 * 조업도급 > 계약관리 > 도급계약 작업자 맵핑 > 작업자 추가 팝업
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zwc/ctr/workerListPop")
	public ModelAndView workerListPop(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("target", paramMap.get("target"));

		//mav.addObject("WORKTYPE_LIST", zwc_ctr_Service.select_zwc_ctr_worktype_list(paramMap));		//근무형태 셀렉트리스트
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zwc/ctr/zwc_ctr_worker_mapping_pop");
		return mav;
	}
	
	/**
	 * 조업도급 > 계약관리 > 도급계약 작업자 맵핑 > 작업자 맵핑 삭제
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zwc/ctr/zwc_ctr_worker_delete")
	public ModelAndView zwc_ctr_worker_delete(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【삭제】조업도급 > 계약관리 > 도급계약 작업자 맵핑  > 작업자 맵핑 삭제");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = zwc_ctr_Service.zwc_ctr_worker_delete(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 계약관리 > 도급계약 작업자 맵핑 > 작업자 맵핑 벨리데이션
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zwc/ctr/zwc_ctr_worker_mapping_validation")
	public ModelAndView zwc_ctr_worker_mapping_validation(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【등록】조업도급 > 계약관리 > 도급계약 작업자 맵핑  > 작업자 맵핑 벨리데이션");
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap resultMap = new HashMap();
		resultMap.put("VALIDATION_LIST", zwc_ctr_Service.zwc_ctr_worker_mapping_validation(paramMap));
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 계약관리 > 도급계약 작업자 맵핑 > 작업자 맵핑 추가
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zwc/ctr/zwc_ctr_worker_create")
	public ModelAndView zwc_ctr_worker_create(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【등록】조업도급 > 계약관리 > 도급계약 작업자 맵핑  > 작업자 맵핑 추가");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = zwc_ctr_Service.zwc_ctr_worker_create(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zwc/ctr/select_zwc_ctr_worker_list")
	public ModelAndView select_zwc_ctr_worker_list(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【조회】작업자등록 > 미등록인원 표시");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HashMap resultMap = new HashMap();
		ArrayList<HashMap<String, String>> result = new ArrayList<HashMap<String,String>>();
		result = zwc_ctr_Service.select_zwc_ctr_worker_list(req_data);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
}
