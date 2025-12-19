package com.yp.zwc.upw.cntr;

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
import com.vicurus.it.core.common.Util;
import com.yp.login.srvc.intf.YPLoginService;
import com.yp.zwc.upw.srvc.intf.YP_ZWC_UPW_Service;

@Controller
public class YP_ZWC_UPW_Controller {

	@Autowired
	private YP_ZWC_UPW_Service zwc_upw_Service;
	
	@Autowired
	private YPLoginService lService;

	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_UPW_Controller.class);

	/**
	 * 조업도급관리 > 단가정보 > 근무별 단가기준 등록/수정
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/upw/zwc_upw_create", method = RequestMethod.POST)
	public ModelAndView zwc_upw_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】조업도급관리 > 단가정보 > 근무별 단가기준 등록/수정");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		// 수정모드 파라미터 확인
		Util util = new Util();
		HashMap<String, Object> req_data = (HashMap<String, Object>) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		if(req_data.get("BASE_YYYY") != null) {
			mav.addObject("BASE_YYYY", req_data.get("BASE_YYYY"));
		}
		if(req_data.get("WORKTYPE_CODE") != null) {
			mav.addObject("WORKTYPE_CODE", req_data.get("WORKTYPE_CODE"));
		}
		
		mav.addObject("cb_working_master_w", zwc_upw_Service.select_cb_working_master_w(request, response));
		
		mav.setViewName("/yp/zwc/upw/zwc_upw_create");
		return mav;
	}
	
	/**
	 * 조업도급관리 > 단가정보 > 근무별 단가기준 등록/수정 > 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/upw/select_zwc_upw_create", method = RequestMethod.POST)
	public ModelAndView select_zwc_upw_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap<String, Object> req_data = (HashMap<String, Object>) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HashMap resultMap = new HashMap();
		
		List result = zwc_upw_Service.select_tbl_working_unit_price(req_data);
		resultMap.put("list1", result);
		
		result = zwc_upw_Service.select_tbl_working_combined_cost(req_data);
		resultMap.put("list2", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급관리 > 단가정보 > 근무별 단가기준 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zwc/upw/zwc_upw_list", method = RequestMethod.POST)
	public ModelAndView zwc_upw_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.addObject("cb_working_master_w", zwc_upw_Service.select_cb_working_master_w(request, response));
		
		mav.setViewName("/yp/zwc/upw/zwc_upw_list");
		return mav;
	}
	
	/**
	 * 조업도급관리 > 단가정보 > 근무별 단가기준 조회 > 엑셀 다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/yp/xls/zwc/upw/zwc_upw_list", method = RequestMethod.POST)
	public ModelAndView xls_zhr_tna_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		 List<HashMap<String, String>> list = zwc_upw_Service.select_zwc_upw_list_report(request, response);

		mav.addObject("alllist", list);

		mav.setViewName("/yp/zwc/upw/xls/zwc_upw_list");
		return mav;
	}
	
	
	
	
	/**
	 * 조업도급관리 > 단가정보 > 근무별 단가기준 등록/수정 > 저장
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked", "unused"})
	@RequestMapping(value = "/yp/zwc/upw/save_zwc_upw_create", method = RequestMethod.POST)
	public ModelAndView save_zwc_upw_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		resultMap.put("code", zwc_upw_Service.save_zwc_upw_create(request, response));
		return new ModelAndView("DataToJson", resultMap);
	}
	
}
