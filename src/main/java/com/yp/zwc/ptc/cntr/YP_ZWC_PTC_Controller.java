package com.yp.zwc.ptc.cntr;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.yp.login.srvc.intf.YPLoginService;
import com.yp.zwc.ptc.srvc.YP_ZWC_PTC_Service;

@Controller
public class YP_ZWC_PTC_Controller {

	@Autowired
	private YP_ZWC_PTC_Service zwc_ptc_Service;
	
	@Autowired
	private YPLoginService lService;

	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_PTC_Controller.class);

	/**
	 * 조업도급관리 > 보호구 > 계약별 보호구 수량 등록
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zwc/ptc/zwc_ptc_create", method = RequestMethod.POST)
	public ModelAndView zwc_ptc_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.addObject("cb_working_master_v", zwc_ptc_Service.select_cb_working_master_v(request, response));
		mav.addObject("cb_working_recent_master_p", zwc_ptc_Service.select_cb_working_recent_master_p(request, response));
		
		mav.setViewName("/yp/zwc/ptc/zwc_ptc_create");
		return mav;
	}
	
	/**
	 * 조업도급관리 > 보호구 > 계약별 보호구 수량 등록 > 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/ptc/select_zwc_ptc_list", method = RequestMethod.POST)
	public ModelAndView select_zwc_upc_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		
		//resultMap.put("cnt", zwc_ptc_Service.select_zwc_ptc_dt_cnt(request, response));
		resultMap.put("ptc_subc_list", zwc_ptc_Service.select_zwc_ptc_working_subc_list(request, response));
		resultMap.put("ptc_dt_list", zwc_ptc_Service.select_zwc_ptc_dt_list(request, response));
		resultMap.put("ptc_column_make_list", zwc_ptc_Service.select_column_make_list(request, response));
		resultMap.put("cb_working_master_p", zwc_ptc_Service.select_cb_working_master_p(request, response));
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급관리 > 보호구 > 계약별 보호구 수량 등록 > 저장
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/ptc/zwc_ptc_create_save", method = RequestMethod.POST)
	public ModelAndView zwc_ptc_create_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		resultMap.put("result", zwc_ptc_Service.zwc_ptc_create_save(request, response));
		return new ModelAndView("DataToJson", resultMap);
	}
	
}
