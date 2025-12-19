package com.yp.zwc.mst.cntr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.yp.zfi.doc.srvc.intf.YP_ZFI_DOC_Service;
import com.yp.zwc.mst.srvc.intf.YP_ZWC_MST_Service;

@Controller
public class YP_ZWC_MST_Controller {

	@Autowired
	private YP_ZWC_MST_Service zwc_mst_Service;

	@Autowired
	private YP_ZFI_DOC_Service zfi_doc_Service;
	
	@Autowired
	private YPLoginService lService;

	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_MST_Controller.class);

	/**
	 * 조업도급관리 > 기준정보 > 기준정보 등록
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zwc/mst/zwc_mst_create", method = RequestMethod.POST)
	public ModelAndView zwc_mst_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】조업도급관리 > 기준정보 > 기준정보 등록");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.addObject("cb_enterprice_gubun", zwc_mst_Service.select_cb_enterprice_gubun(request, response));
		
		mav.setViewName("/yp/zwc/mst/zwc_mst_create");
		return mav;
	}
	
	/**
	 * 정비용역 > 기준정보 > 기준정보 등록
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/mst/zcs_mst_create", method = RequestMethod.POST)
	public ModelAndView zcs_mst_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】정비용역 > 기준정보 > 기준정보 등록");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.addObject("cb_enterprice_gubun", zwc_mst_Service.select_cb_enterprice_gubun(request, response));
		
		mav.setViewName("/yp/zwc/mst/zwc_mst_create");
		return mav;
	}

	/**
	 * 조업도급관리 > 기준정보 > 기준정보 등록 > 팝업(업체 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zwc/mst/retrieveLIFNR")
	public ModelAndView retrieveLIFNR(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));

		if (paramMap.get("search_type") != null) {
			ArrayList<HashMap<String, String>> list = zfi_doc_Service.retrieveLIFNR(paramMap);
			int totCnt = list.size();

			Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
			mav.addObject("pagination", pagination);

			paramMap.put("firstRecordIndex", pagination.getStartIndex());
			paramMap.put("lastRecordIndex", pagination.getEndIndex());

			ArrayList<HashMap<String, String>> pagingList = util.pagingListOfERPList(list, pagination.getStartIndex(), pagination.getEndIndex());
			logger.debug("{}", pagingList);
			mav.addObject("list", pagingList);
		}
		paramMap.put("target", paramMap.get("target"));
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zwc/mst/search_lifnr_pop");
		return mav;
	}
	
	/**
	 * 조업도급관리 > 기준정보 > 기준정보 등록 > 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/mst/zwc_mst_save")
	public ModelAndView zwc_mst_save(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HashMap resultMap = new HashMap();
		resultMap.put("code", zwc_mst_Service.zwc_mst_save(request, response));
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급관리 > 기준정보 > 기준정보 등록 > 삭제
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/mst/zwc_mst_delete")
	public ModelAndView zwc_mst_delete(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HashMap resultMap = new HashMap();
		resultMap.put("code", zwc_mst_Service.zwc_mst_delete(request, response));
		return new ModelAndView("DataToJson", resultMap);
	}
}
