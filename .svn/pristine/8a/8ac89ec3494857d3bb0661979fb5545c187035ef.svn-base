package com.yp.zmm.inv.cntr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.vicurus.it.core.common.Util;
import com.yp.login.srvc.intf.YPLoginService;
import com.yp.util.DateUtil;
import com.yp.zmm.inv.srvc.intf.YP_ZMM_INV_Service;

@Controller
public class YP_ZMM_INV_Controller {

	@Autowired
	private YP_ZMM_INV_Service zmmService;
	@Autowired
	private YP_ZMM_INV_Service zmm_ctr_Service;
	
	@Autowired
	private YPLoginService lService;
	private static final Logger logger = LoggerFactory.getLogger(YP_ZMM_INV_Controller.class);

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zmm/inv/inv_list", method = RequestMethod.POST)
	public ModelAndView zmm_inv_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】주요재고현황");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		HttpSession session = request.getSession();
		
		mav.addObject("auth", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH"));

		HashMap<String, Object> dept_param = new HashMap<String, Object>();

		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		mav.setViewName("/yp/zmm/inv/inv_list");
		
		return mav;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zmm/inv/inv_create", method = RequestMethod.POST)
	public ModelAndView zwc_ipt_performance(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】주요재고현황 등록");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		HttpSession session = request.getSession();
		
		mav.addObject("auth", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH"));

		HashMap<String, Object> dept_param = new HashMap<String, Object>();

		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		mav.setViewName("/yp/zmm/inv/inv_create");
		
		return mav;
	}

	/**
	 * 물류관리 > 주요재고 > 주요재고현황 > 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zmm/inv/select_tbl_inv_list", method = RequestMethod.POST)
	public ModelAndView select_tbl_inv_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】주요재고 > 주요재고현황 > 조회");
		HashMap resultMap = new HashMap();
		HashMap data = new HashMap();
		data = zmmService.select_tbl_inv_list(request, response);
		resultMap.put("list1", data.get("list1"));
		resultMap.put("list2", data.get("map2"));
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/yp/common/inv_list")

	public String zmm_inv_list(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		return "/yp/common/inv_list";
	}

	/**
	 * 물류관리 > 주요재고 > 주요재고 등록
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zmm/inv/zmm_inv_save")
	public ModelAndView zmm_inv_save(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HashMap resultMap = new HashMap();
		
		resultMap.put("list", zmmService.zmm_inv_save(request, response));

		return new ModelAndView("DataToJson", resultMap);
	}

}