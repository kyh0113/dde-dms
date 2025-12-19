package com.yp.zwc.cmt.cntr;

import java.util.ArrayList;
import java.util.HashMap;
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
import com.yp.zwc.cmt.srvc.intf.YP_ZWC_CMT_Service;
import com.yp.zwc.ctr.srvc.intf.YP_ZWC_CTR_Service;

@Controller
public class YP_ZWC_CMT_Controller {

	@Autowired
	private YP_ZWC_CMT_Service zwc_cmt_Service;
	
	@Autowired
	private YP_ZWC_CTR_Service zwc_ctr_Service;
	
	@Autowired
	private YPLoginService lService;

	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_CMT_Controller.class);

	/**
	 * 조업도급 > 출퇴근 조회 > 작업자 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zwc/cmt/zwc_cmt_list", method = RequestMethod.POST)
	public ModelAndView zwc_cmt_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】조업도급 > 출퇴근 조회 > 작업자 조회");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.addObject("cb_working_master_v", zwc_ctr_Service.select_cb_working_master_v(request, response));
		mav.addObject("cb_gubun2", zwc_ctr_Service.select_cb_gubun_yp_factory_gubun(request, response));
		
		mav.setViewName("/yp/zwc/cmt/zwc_cmt_list");
		return mav;
	}
	
	/**
	 * 조업도급 > 출퇴근 조회 > 작업자 조회 > 팝업(코스트센터 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zwc/cmt/retrieveKOSTL")
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
		mav.setViewName("/yp/zwc/cmt/search_kostl_pop");
		return mav;
	}
	
	/**
	 * 조업도급 > 출퇴근 조회 > 작업자 상세조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zwc/cmt/zwc_cmt_list_dt", method = RequestMethod.POST)
	public ModelAndView zwc_cmt_list_dt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】조업도급 > 출퇴근 조회 > 작업자 상세조회");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.addObject("cb_working_master_v", zwc_ctr_Service.select_cb_working_master_v(request, response));
		mav.addObject("cb_gubun2", zwc_ctr_Service.select_cb_gubun_yp_factory_gubun(request, response));
		
		mav.setViewName("/yp/zwc/cmt/zwc_cmt_list_dt");
		return mav;
	}
}
