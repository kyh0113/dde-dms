package com.yp.zpp.cre.cntr;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import com.vicurus.it.core.common.Util;
import com.yp.login.srvc.intf.YPLoginService;
import com.yp.util.DateUtil;
import com.yp.zpp.cre.srvc.intf.YP_ZPP_CRE_Service;

@Controller
public class YP_ZPP_CRE_Controller {

	@Autowired
	private YP_ZPP_CRE_Service zppService;
	@Autowired
	private YPLoginService lService;
	private static final Logger logger = LoggerFactory.getLogger(YP_ZPP_CRE_Controller.class);

	/**
	 * 생산관리 > 전해조청소관리 > 청소실적현황
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zpp/cre/zpp_cre_read", method = RequestMethod.POST)
	public ModelAndView zpp_cre_read(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 전해조청소관리 > 청소실적현황");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		// session attr to param
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", ((String) session.getAttribute("userName")));
		paramMap.put("user_dept", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("dept_name", (String) session.getAttribute("userDept"));
		paramMap.put("auth", (String) session.getAttribute("HR_AUTH"));
		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");

		mav.addObject("req_data", paramMap);

		mav.setViewName("/yp/zpp/cre/zpp_cre_read");

		return mav;

	}

	@Autowired
	private YP_ZPP_CRE_Service zpp_cre_Service;

	/**
	 * 생산관리 > 전해조청소관리 > 청소실적등록
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zpp/cre/zpp_cre_create", method = RequestMethod.POST)
	public ModelAndView zpp_cre_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 전해조청소관리 > 청소실적등록");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/zpp/cre/zpp_cre_create");
		
		return mav;
	}

	/**
	 * 생산관리 > 전해조청소관리 > 전해 청소 등록
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/yp/zpp/cre/zpp_cre_save")
	public ModelAndView zpp_cre_reg(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HashMap resultMap = new HashMap();
		int result = zppService.zpp_cre_reg(request, response);
		resultMap.put("result", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 생산관리 > 전해조청소관리 > 전해 청소 등록 삭제
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zpp/cre/deleteAccessControl")
	public ModelAndView deleteAccessControl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		int result = zppService.deleteAccessControl(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 생산관리 > 전해조청소관리 > 이전 청소일, 청소경과일 AJAX
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */

	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zpp/cre/retrieveAjaxBFDT")
	public ModelAndView retrieveAjaxBFDT(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HashMap resultMap = new HashMap();

		resultMap = zppService.retrieveBFDT(request, response);
		resultMap.put("BF_DT", resultMap.get("BF_DT"));
		resultMap.put("CALC_CLEAN", resultMap.get("CALC_CLEAN"));

		return new ModelAndView("DataToJson", resultMap);
	}

	// 생산관리 > 전해조청소관리 > 청소실적조회
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/cre/zpp_cre_popup1", method = RequestMethod.POST)
	public ModelAndView zpp_cre_popup1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 전해조청소관리 - 청소실적조회");

		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/cre/zpp_cre_popup1");

		return mav;
	}
	
	// 생산관리 > 전해조청소관리 > 전해조 청소실적월별현황 현황
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/cre/select_tbl_cre_list")
	public ModelAndView select_tbl_cre_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】생산관리 > 청소실적현황 > 청소실적월별현황");
		HashMap resultMap = new HashMap();
		HashMap data = new HashMap();
		data = zppService.select_tbl_cre_list(request, response);
		resultMap.put("list1", data.get("list1"));
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/cre/select_tbl_cre_list_pop")
	public ModelAndView select_tbl_cre_list_pop(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】생산관리 > 청소실적현황 > 청소실적월별현황");
		HashMap resultMap = new HashMap();
		HashMap data = new HashMap();
		data = zppService.select_tbl_cre_list_pop(request, response);
		resultMap.put("list1", data.get("list1"));
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zpp/cre/zpp_cre_stat", method = RequestMethod.POST)
	public ModelAndView zpp_cre_stat(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 전해조청소관리 > 월별청소진행현황");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		// session attr to param
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", ((String) session.getAttribute("userName")));
		paramMap.put("user_dept", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("dept_name", (String) session.getAttribute("userDept"));
		paramMap.put("auth", (String) session.getAttribute("HR_AUTH"));
		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");

		mav.addObject("req_data", paramMap);

		mav.setViewName("/yp/zpp/cre/zpp_cre_stat");

		return mav;

	}
}
