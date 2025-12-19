package com.yp.zwc.upc.cntr;

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
import com.yp.zwc.upc.srvc.intf.YP_ZWC_UPC_Service;

@Controller
public class YP_ZWC_UPC_Controller {

	@Autowired
	private YP_ZWC_UPC_Service zwc_upc_Service;
	
	@Autowired
	private YPLoginService lService;

	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_UPC_Controller.class);

	/**
	 * 조업도급관리 > 근무별 단가 > 업체별 경비 등록/수정
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zwc/upc/zwc_upc_create", method = RequestMethod.POST)
	public ModelAndView zwc_upc_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】조업도급관리 > 근무별 단가 > 업체별 경비 등록/수정");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.addObject("cb_working_master_v", zwc_upc_Service.select_cb_working_master_v(request, response));
		
		mav.setViewName("/yp/zwc/upc/zwc_upc_create");
		return mav;
	}
	
	/**
	 * 조업도급관리 > 근무별 단가 > 업체별 경비 등록/수정 > 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/upc/select_zwc_upc_create", method = RequestMethod.POST)
	public ModelAndView select_zwc_upc_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】조업도급관리 > 근무별 단가 > 업체별 경비 등록/수정");
		Util util = new Util();
		HashMap<String, Object> req_data = (HashMap<String, Object>) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HashMap resultMap = new HashMap();
		
		List result = zwc_upc_Service.select_tbl_working_ent_cost(req_data);
		resultMap.put("list1", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급관리 > 근무별 단가 > 업체별 경비 등록/수정 > 저장
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/upc/save_zwc_upc_create", method = RequestMethod.POST)
	public ModelAndView save_zwc_upc_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【저장】조업도급관리 > 근무별 단가 > 업체별 경비 등록/수정");
		HashMap resultMap = new HashMap();
		resultMap.put("code", zwc_upc_Service.save_zwc_upc_create(request, response));
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급관리 > 단가정보 > 업체별 단가조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zwc/upc/zwc_upc_list", method = RequestMethod.POST)
	public ModelAndView zwc_upw_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("【화면호출】조업도급관리 > 단가정보 > 업체별 단가조회");
		
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.addObject("cb_working_master_v", zwc_upc_Service.select_cb_working_master_v(request, response));
		mav.addObject("cb_working_master_w", zwc_upc_Service.select_cb_working_master_w(request, response));
		
		mav.setViewName("/yp/zwc/upc/zwc_upc_list");
		return mav;
	}
	
	/**
	 * 조업도급관리 > 단가정보 > 업체별 단가조회 > 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/upc/select_zwc_upc_list", method = RequestMethod.POST)
	public ModelAndView select_zwc_upc_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("【화면호출】조업도급관리 > 단가정보 > 업체별 단가조회 > 조회");
		HashMap resultMap = new HashMap();
		
		
		resultMap.put("list", zwc_upc_Service.select_zwc_upc_list(request, response));
		resultMap.put("vendor_list", zwc_upc_Service.select_zwc_upc_vendor_list(request, response));
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급관리 > 단가정보 > 업체별 단가조회 > 엑셀 다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/yp/xls/zwc/upc/zwc_upc_list", method = RequestMethod.POST)
	public ModelAndView xls_zwc_upc_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		List<HashMap<String, String>> list = zwc_upc_Service.select_zwc_upc_list_report(request, response);

		mav.addObject("alllist", list);
		mav.addObject("cb_working_master_w", zwc_upc_Service.select_cb_working_master_w(request, response));
		mav.addObject("vendor_list", zwc_upc_Service.select_zwc_upc_vendor_list(request, response));

		mav.setViewName("/yp/zwc/upc/xls/zwc_upc_list");
		return mav;
	}
	
	/**
	 * 조업도급관리 > 단가정보 > 업체별 단가조회 > 팝업(상세 조회)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/popup/zwc/upc/zwc_upc_detail_list")
	public ModelAndView zwc_upc_detail_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		mav.addObject("BASE_YYYY", paramMap.get("BASE_YYYY"));
		mav.addObject("VENDOR_NAME", paramMap.get("VENDOR_NAME"));
		mav.addObject("WORKTYPE_NAME", paramMap.get("WORKTYPE_NAME"));
		mav.addObject("detail_list", zwc_upc_Service.select_zwc_upc_detail_list(request, response));
		
		
		mav.setViewName("/yp/zwc/upc/zwc_upc_detail_list_pop");
		return mav;
	}
	
}
