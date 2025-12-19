package com.yp.zwc.smc.cntr;

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
import com.yp.zwc.smc.srvc.intf.YP_ZWC_SMC_Service;

@Controller
public class YP_ZWC_SMC_Controller {

	@Autowired
	private YP_ZWC_SMC_Service zwc_smc_Service;
	
	@Autowired
	private YPLoginService lService;

	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_SMC_Controller.class);

	/**
	 * 조업도급 > 적립금 비용 > 업체별 적립금 등록/수정
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zwc/smc/zwc_smc_create", method = RequestMethod.POST)
	public ModelAndView zwc_smc_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】조업도급 > 적립금 비용 > 업체별 적립금 등록/수정");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.addObject("cb_working_master_v", zwc_smc_Service.select_cb_working_master_v(request, response));
		
		mav.setViewName("/yp/zwc/smc/zwc_smc_create");
		return mav;
	}
	
	/**
	 * 조업도급 > 적립금 비용 > 업체별 적립금 등록/수정 > 엑셀다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/xls/zwc/smc/zwc_smc_select")
	public ModelAndView zwc_smc_select(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【엑셀다운로드】조업도급 > 적립금 비용 > 업체별 적립금 등록/수정");
		ModelAndView mav = new ModelAndView();
		
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		list = zwc_smc_Service.zwc_smc_select(request, response);

		mav.addObject("alllist", list);

		mav.setViewName("/yp/zwc/smc/xls/zwc_smc_create");
		return mav;
	}
	
	/**
	 * 조업도급 > 적립금 비용 > 업체별 적립금 등록/수정 > 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/smc/zwc_smc_save")
	public ModelAndView zwc_smc_save(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【저장】조업도급 > 적립금 비용 > 업체별 적립금 등록/수정");
		HashMap resultMap = new HashMap();
		int result = zwc_smc_Service.zwc_smc_save(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
}
