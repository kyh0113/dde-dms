package com.yp.zwc.cct.cntr;

import java.util.ArrayList;
import java.util.HashMap;
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
import com.yp.zwc.cct.srvc.intf.YP_ZWC_CCT_Service;

@Controller
public class YP_ZWC_CCT_Controller {

	@Autowired
	private YP_ZWC_CCT_Service zwc_cct_Service;
	
	@Autowired
	private YPLoginService lService;

	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_CCT_Controller.class);

	/**
	 * 조업도급관리 > 통합경비 > 연도별 통합 경비 등록
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zwc/cct/zwc_cct_create", method = RequestMethod.POST)
	public ModelAndView zwc_cct_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】조업도급관리 > 통합경비 > 연도별 통합 경비 등록");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/zwc/cct/zwc_cct_create");
		return mav;
	}
	
	/**
	 * 조업도급관리 > 통합경비 > 연도별 통합 경비 등록 > 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/mst/zwc_cct_select")
	public ModelAndView zwc_cct_select(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HashMap resultMap = new HashMap();
		ArrayList<HashMap<String, String>> resultList = zwc_cct_Service.zwc_cct_select(request, response);
		
		resultMap.put("result", resultList);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급관리 > 통합경비 > 연도별 통합 경비 등록 > 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/cct/zwc_cct_save")
	public ModelAndView zwc_cct_save(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HashMap resultMap = new HashMap();
		int result = zwc_cct_Service.zwc_cct_save(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
}
