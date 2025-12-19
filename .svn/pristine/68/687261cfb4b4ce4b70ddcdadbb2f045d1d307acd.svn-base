package com.yp.zmm.aw.cntr;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONValue;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sap.conn.jco.JCoFunction;
import com.vicurus.it.core.common.Pagination;
import com.vicurus.it.core.common.Util;
import com.vicurus.it.core.common.WebUtil;
import com.yp.login.srvc.intf.YPLoginService;
import com.yp.zfi.doc.srvc.intf.YP_ZFI_DOC_Service;
import com.yp.zmm.aw.srvc.intf.YP_ZMM_AW_Service;

@Controller
public class YP_ZMM_AW_Controller {
	
	@Autowired
	private YP_ZMM_AW_Service zmm_aw_Service;
	private YP_ZFI_DOC_Service zfi_doc_Service;
	
	@Autowired
	private YPLoginService lService;
	
	private static final Logger logger = LoggerFactory.getLogger(YP_ZMM_AW_Controller.class);
	
	/**
	 * 구매관리 > 물류관리 > 차량 계량 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/aw/zmm_weight_list", method = RequestMethod.POST)
	public ModelAndView zmm_weight_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】구매관리 > 물류관리 > 차량 계량 조회");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/zmm/aw/zmm_weight_list");
		return mav;
	}
	
	
	/**
	 * 구매관리 > 물류관리 > 차량 계량 엑셀
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/xls/zmm/aw/zmm_weight_list", method = RequestMethod.POST)
	public ModelAndView xls_zmm_weight_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		ArrayList<HashMap<String, String>> list = zmm_aw_Service.zmm_weight_list(paramMap);	//업체목록 데이터 가져오기
		mav.addObject("list", list);
		mav.setViewName("/yp/zmm/aw/xls/zmm_weight_list");
		return mav;
	}
	
	
	/**
	 * 구매관리 > 물류관리 > 차량 계량데이터 삭제
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/aw/zmm_weight_delete", method = RequestMethod.POST)
	public ModelAndView zmm_weight_delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【로직처리】구매관리 > 물류관리 > 차량 계량데이터 삭제");
		ModelAndView mav = new ModelAndView();
	
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		logger.debug("paramMap="+paramMap);
		int result_cnt = zmm_aw_Service.zmm_weight_delete(paramMap);
		HashMap<String, String> json = new HashMap<String, String>();
		json.put("result", Integer.toString(result_cnt));
		
		return new ModelAndView("DataToJson", json);
	}
	
	
	/**
	 * 구매관리 > 물류관리 > 차량 계량데이터 수정저장
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/aw/zmm_weight_save", method = RequestMethod.POST)
	public ModelAndView zmm_weight_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【로직처리】구매관리 > 물류관리 > 차량 계량데이터 수정저장");
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		logger.debug("paramMap="+paramMap);
		int result_cnt = zmm_aw_Service.zmm_weight_save(paramMap);
		HashMap<String, String> json = new HashMap<String, String>();
		json.put("result", Integer.toString(result_cnt));
		
		return new ModelAndView("DataToJson", json);
	}
	
	
	/**
	 * 구매관리 > 물류관리 > 차량 계량데이터 일마감
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "yp/zmm/aw/zmm_weight_dailyclosing", method = RequestMethod.POST)
	public ModelAndView zmm_weight_dailyclosing(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【로직처리】구매관리 > 물류관리 > 차량 계량데이터 일마감");
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		logger.debug("paramMap="+paramMap);
		int result_cnt = zmm_aw_Service.zmm_weight_dailyclosing(paramMap);
		HashMap<String, String> json = new HashMap<String, String>();
		json.put("result", Integer.toString(result_cnt));
		
		return new ModelAndView("DataToJson", json);
	}
	
	
	/**
	 * 구매관리 > 물류관리 > 차량 계량데이터 월마감
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/aw/zmm_weight_monthlyclosing", method = RequestMethod.POST)
	public ModelAndView zmm_weight_monthlyclosing(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【로직처리】구매관리 > 물류관리 > 차량 계량데이터 월마감");
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		logger.debug("paramMap="+paramMap);
		int result_cnt = zmm_aw_Service.zmm_weight_monthlyclosing(paramMap);
		HashMap<String, String> json = new HashMap<String, String>();
		json.put("result", Integer.toString(result_cnt));
		
		return new ModelAndView("DataToJson", json);
	}
	
	
	/**
	 * 구매관리 > 물류관리 > 차량 계약 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/aw/zmm_weight_cont_list", method = RequestMethod.POST)
	public ModelAndView zmm_weight_cont_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】구매관리 > 물류관리 > 차량 계약 조회");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/zmm/aw/zmm_weight_cont_list");
		return mav;
	}
	
	
	/**
	 * 구매관리 > 물류관리 > 차량 계약 등록 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/aw/zmm_weight_cont_create", method = RequestMethod.POST)
	public ModelAndView zmm_weight_cont_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】구매관리 > 물류관리 > 차량 계약 등록");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/zmm/aw/zmm_weight_cont_create");
		return mav;
	}
	
	
	/**
	 * 구매관리 > 물류관리 > 차량 계약 등록
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/aw/zmm_weight_cont_create_prc", method = RequestMethod.POST)
	public ModelAndView zmm_weight_cont_create_prc(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		logger.debug("paramMap="+paramMap);
		
		int result_cnt = zmm_aw_Service.zmm_weight_cont_create_prc(paramMap);
		HashMap<String, String> json = new HashMap<String, String>();
		json.put("result", Integer.toString(result_cnt));

		return new ModelAndView("DataToJson", json);
	}
	
	
	/**
	 * 구매관리 > 물류관리 > 차량 계약 등록 > 팝업(업체 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zmm/aw/retrieveKUNNR")
	public ModelAndView retrieveKUNNR(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));

		if (paramMap.get("search_type") != null) {
			ArrayList<HashMap<String, String>> list = zmm_aw_Service.retrieveKUNNR(paramMap);
			int totCnt = list.size();

			Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
			mav.addObject("pagination", pagination);

			paramMap.put("firstRecordIndex", pagination.getStartIndex());
			paramMap.put("lastRecordIndex", pagination.getEndIndex());

			ArrayList<HashMap<String, String>> pagingList = util.pagingListOfERPList(list, pagination.getStartIndex(), pagination.getEndIndex());
			logger.debug("{}", pagingList);
			mav.addObject("list", pagingList);
		}
		paramMap.put("type", paramMap.get("type"));
		paramMap.put("target", paramMap.get("target"));
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zmm/aw/search_kunnr_pop");
		return mav;
	}
	
	
	/**
	 * 구매관리 > 물류관리 > 차량 계약 등록 > 팝업(자재 검색 from SAP)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zmm/aw/retrieveMATNRbySAP")
	public ModelAndView retrieveMATNRbySAP(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		//SAP ERP연동 
		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));

		if (paramMap.get("search_type") != null) {
			ArrayList<HashMap<String, String>> list = zmm_aw_Service.retrieveMATNR(paramMap);
			int totCnt = list.size();

			Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
			mav.addObject("pagination", pagination);
			
			paramMap.put("firstRecordIndex", pagination.getStartIndex());
			paramMap.put("lastRecordIndex", pagination.getEndIndex());
			
			ArrayList<HashMap<String, String>> pagingList = util.pagingListOfERPList(list, pagination.getStartIndex(), pagination.getEndIndex());
			logger.debug("{}", pagingList);
			mav.addObject("list", pagingList);
		}
		paramMap.put("type", paramMap.get("type"));
		paramMap.put("target", paramMap.get("target"));
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zmm/aw/search_matnr_pop");
		return mav;
	}
	
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zmm/aw/bill_create")
	public ModelAndView bill_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		//SAP ERP연동
		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));
		
		if (paramMap.get("search_type") != null) {
			ArrayList<HashMap<String, String>> list = zmm_aw_Service.retrieveBill(paramMap);
			int totCnt = list.size();
			
			Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
			mav.addObject("pagination", pagination);
			
			paramMap.put("firstRecordIndex", pagination.getStartIndex());
			paramMap.put("lastRecordIndex", pagination.getEndIndex());
			
			ArrayList<HashMap<String, String>> pagingList = util.pagingListOfERPList(list, pagination.getStartIndex(), pagination.getEndIndex());
			logger.debug("{}", pagingList);
			mav.addObject("list", pagingList);
		}
		paramMap.put("type", paramMap.get("type"));
		paramMap.put("target", paramMap.get("target"));
		
		mav.addObject("data", paramMap);
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zmm/aw/search_bill_pop");
		return mav;
	}
	
	
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zmm/aw/createDocument_Bill")
	public ModelAndView createDocument(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		req_data.put("emp_code", session.getAttribute("empCode"));		
		req_data.put("ENT_CODE", (String) request.getParameter("ENT_CODE"));
		req_data.put("ENT", (String) request.getParameter("ENT"));
		req_data.put("REG_NO", (String) request.getParameter("REG_NO"));
		req_data.put("ZMKDT", (String) request.getParameter("ZDATE"));
		req_data.put("HWBAS", (String) request.getParameter("HWBAS"));
		req_data.put("HWSTE", (String) request.getParameter("HWSTE"));
		req_data.put("ZTTAT", (String) request.getParameter("ZTTAT"));
		req_data.put("ZSPCN", (String) request.getParameter("ZSPCN"));
		req_data.put("CALC_CODE", (String) request.getParameter("CALC_CODE"));
		req_data.put("I_LIFNR", (String) request.getParameter("ENT_CODE"));
		req_data.put("I_BUKRS", "1000");
		req_data.put("I_BUPLA", "1200");
		req_data.put("I_KOSTL", "214101");
		req_data.put("I_ZKOSTL", "230201");
		req_data.put("I_HKONT", "43324201");
		req_data.put("I_BUDAT", StringUtils.replace((String) request.getParameter("ZDATE"), "/", ""));
		
		String[] return_str2 = zmm_aw_Service.retrieveLIFNR(req_data);
		HashMap resultMap2 = new HashMap();
		req_data.put("STCD2", request.getParameter("REG_NO"));
		req_data.put("NAME1", return_str2[1]);
		req_data.put("HKONT", return_str2[2]);
		req_data.put("BVTYP", return_str2[3]);
		req_data.put("BANKN", return_str2[4]);
		req_data.put("ZTERM", return_str2[5]);
		req_data.put("TEXT1", return_str2[6]);

		String[] return_str3 = zmm_aw_Service.retrieveBUDGET(req_data);
		HashMap resultMap3 = new HashMap();
		req_data.put("AVAIL_AMT", return_str3[0]);
		//req_data.put("row_no", "0");
		String[] return_str = zmm_aw_Service.createDocument(req_data);
		
		logger.debug("data" + req_data);
		
		if (return_str[0].equals("S"))
			logger.debug("###%%%" + session.getAttribute("userDept") + "," + session.getAttribute("userName") + "," + session.getAttribute("empCode") + "," + return_str[1]);
		HashMap resultMap = new HashMap();
		resultMap.put("flag", return_str[0]);
		resultMap.put("msg", return_str[1]);

		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zmm/aw/retrieveBillbySAP")
	public ModelAndView retrieveBillbySAP(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		//SAP ERP연동
		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));
		
		ArrayList<HashMap<String, String>> list = zmm_aw_Service.retrieveBill(paramMap);
		int totCnt = list.size();
		
		Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
		mav.addObject("pagination", pagination);
		
		paramMap.put("firstRecordIndex", pagination.getStartIndex());
		paramMap.put("lastRecordIndex", pagination.getEndIndex());
		
		ArrayList<HashMap<String, String>> pagingList = util.pagingListOfERPList(list, pagination.getStartIndex(), pagination.getEndIndex());
		logger.debug("{}", totCnt);
		mav.addObject("list", pagingList);
		
		paramMap.put("type", paramMap.get("type"));
		paramMap.put("target", paramMap.get("target"));
		
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zmm/aw/search_bill_pop");
		return mav;
	}
	
	
	/**
	 * 구매관리 > 물류관리 > 차량 계약 등록 > 팝업(자재 검색 from CAS)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zmm/aw/retrieveMATNR")
	public ModelAndView retrieveMATNR(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		/* CAS 연동  */
		if (paramMap.get("search_type") != null) {
			List<HashMap<String, Object>> list = zmm_aw_Service.zmm_p_detail_code_cas(paramMap);
			mav.addObject("list", list);
		}
		paramMap.put("type", paramMap.get("type"));
		paramMap.put("target", paramMap.get("target"));
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zmm/aw/search_matnr_pop");
		return mav;
	}
	
	
	/**
	 * 구매관리 > 물류관리 > 차량 계약 등록 > 팝업(품목 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zmm/aw/retrievePname")
	public ModelAndView retrievePname(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		/* CAS 연동  */
		List<HashMap<String, Object>> list = zmm_aw_Service.zmm_weight_p_name_list(paramMap);
		mav.addObject("list", list);
		
		paramMap.put("type", paramMap.get("type"));
		paramMap.put("target", paramMap.get("target"));
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zmm/aw/search_pname_pop");
		return mav;
	}
	
	
	/**
	 * 구매관리 > 물류관리 > 차량 계약 등록 > 팝업(영업소 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zmm/aw/retrieveVKBUR")
	public ModelAndView retrieveVKBUR(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		//SAP ERP연동 
		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));

		
		ArrayList<HashMap<String, String>> list = zmm_aw_Service.retrieveVKBUR(paramMap);
		int totCnt = list.size();
		
		Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
		mav.addObject("pagination", pagination);
		
		paramMap.put("firstRecordIndex", pagination.getStartIndex());
		paramMap.put("lastRecordIndex", pagination.getEndIndex());
		
		ArrayList<HashMap<String, String>> pagingList = util.pagingListOfERPList(list, pagination.getStartIndex(), pagination.getEndIndex());
		logger.debug("{}", pagingList);
		mav.addObject("list", pagingList);
		
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zmm/aw/search_vkbur_pop");
		return mav;
	}
	
	
	/**
	 * 구매관리 > 물류관리 > 차량 계량 상세품목 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/aw/zmm_weight_p_code_list", method = RequestMethod.POST)
	public ModelAndView zmm_weight_p_code_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		logger.debug("paramMap="+paramMap);
		HashMap<String, String> result = zmm_aw_Service.zmm_weight_p_code_list(paramMap);
		
		return new ModelAndView("DataToJson", result);
	}
	
	
	/**
	 * 구매관리 > 물류관리 > 차량 계량 품목명 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/aw/zmm_weight_p_name_cas", method = RequestMethod.POST)
	public ModelAndView zmm_weight_p_name_cas(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		logger.debug("paramMap="+paramMap);
		HashMap<String, String> result = zmm_aw_Service.zmm_weight_p_name_cas(paramMap);
		logger.debug("11"+result);
		return new ModelAndView("DataToJson", result);
	}
	
	
	/**
	 * 구매관리 > 물류관리 > 차량 계약 상세조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/aw/zmm_weight_cont_detail", method = RequestMethod.POST)
	public ModelAndView zmm_weight_cont_detail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】구매관리 > 물류관리 > 차량 계약 조회");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HashMap<String, String> cont = zmm_aw_Service.zmm_weight_cont_detail(paramMap);
		mav.addObject("cont", cont);
		
		mav.setViewName("/yp/zmm/aw/zmm_weight_cont_detail");
		return mav;
	}
	
	
	/**
	 * 구매관리 > 물류관리 > 차량 계약 수정
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/aw/zmm_weight_cont_detail_save", method = RequestMethod.POST)
	public ModelAndView zmm_weight_cont_detail_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		logger.debug("paramMap="+paramMap);
		
		int result_cnt = zmm_aw_Service.zmm_weight_cont_detail_save(paramMap);
		HashMap<String, String> json = new HashMap<String, String>();
		json.put("result", Integer.toString(result_cnt));

		return new ModelAndView("DataToJson", json);
	}
	
	
	/**
	 * 구매관리 > 물류관리 > 차량 계약 삭제
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/aw/zmm_weight_cont_delete", method = RequestMethod.POST)
	public ModelAndView zmm_weight_cont_delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		logger.debug("paramMap="+paramMap);
		
		int result_cnt = zmm_aw_Service.zmm_weight_cont_delete(paramMap);
		HashMap<String, String> json = new HashMap<String, String>();
		
		if(result_cnt > 0) json.put("result", "S");
		else json.put("result", "E");

		return new ModelAndView("DataToJson", json);
	}
	
	
	/**
	 * 구매관리 > 물류관리 > 차량 계량 정산
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/aw/zmm_weight_calc_list", method = RequestMethod.POST)
	public ModelAndView zmm_weight_calc_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】구매관리 > 물류관리 >차량 계량 정산");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/zmm/aw/zmm_weight_calc_list");
		return mav;
	}
	
	
	/**
	 * 구매관리 > 물류관리 > 차량 계량 정산 > 팝업(상세조회)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zmm/aw/calc_detail_list")
	public ModelAndView calc_detail_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<Object> list = zmm_aw_Service.calc_detail_list(paramMap);
		
		mav.addObject("list", list);
		mav.setViewName("/yp/zmm/aw/calc_detail_pop");
		return mav;
	}
	
	
	/**
	 * 구매관리 > 물류관리 > 차량 계량 정산 > 팝업(오더생성)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zmm/aw/so_create")
	public ModelAndView so_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		mav.addObject("data", paramMap);
		mav.setViewName("/yp/zmm/aw/so_create_pop");
		return mav;
	}
	
	
	/**
	 * 구매관리 > 물류관리 > 차량 계량 정산 > 팝업(오더생성) > 오더생성
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping(value = "/yp/zmm/aw/so_create_save", method = RequestMethod.POST)
	// @RequestMapping("/yp/zmm/aw/so_create_save")
	public ModelAndView so_create_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		logger.debug("req_data : " + req_data.toString());
		
		// logger.debug("###%%%" + WebUtil.leftPad(WebUtil.checkNull(req_data.get("I_PART_PARTN_NUMB")), 10));
		HttpSession session = request.getSession();
		req_data.put("emp_code", session.getAttribute("empCode"));
		
		String[] return_str = zmm_aw_Service.so_create_save(req_data);
		
		logger.debug("###%%%" + return_str[0] + "," + return_str[1] + "," + return_str[2]);
		HashMap resultMap = new HashMap();
		resultMap.put("so_no", return_str[0]);
		resultMap.put("msg", return_str[1]);
		resultMap.put("error", return_str[2]);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	/**
	 * 구매관리 > 물류관리 > 차량 계량 정산 저장
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/aw/zmm_weight_calc_save", method = RequestMethod.POST)
	public ModelAndView zmm_weight_calc_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		logger.debug("paramMap="+paramMap);
		int result_cnt = zmm_aw_Service.zmm_weight_calc_save(paramMap);
		
		HashMap<String, String> json = new HashMap<String, String>();
		json.put("result", Integer.toString(result_cnt));
		
		return new ModelAndView("DataToJson", json);
	}
	
	
	/**
	 * 전자결재I/F - 차량 계량 정산 결재 상신페이지 데이터 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/aw/zmm_weight_calc_edoc_write")
	public void zmm_weight_calc_edoc_list(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String from = "【전자결재I/F】차량 계량 정산";
		logger.debug(from);
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		logger.debug("@@"+paramMap);
		List list = zmm_aw_Service.zmm_weight_calc_edoc_list(paramMap);
		
		this.JsonFlush(request, response, list, from);
	}
	
	
	/**
	 * 전자결재I/F - 차량 계량 정산 결재 상신페이지 데이터 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/aw/zmm_weight_data_edoc_write")
	public void zmm_weight_data_edoc_list(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String from = "【전자결재I/F】차량 계량 수정";
		logger.debug(from);
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		logger.debug("@@"+paramMap);
		List list = zmm_aw_Service.zmm_weight_data_edoc_list(paramMap);
		
		this.JsonFlush(request, response, list, from);
	}
	
	
	/**
	 * 전자결재I/F - 차량 계량 정산 결재 상신페이지 데이터 상세조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/popup/zmm/aw/zmm_weight_edoc_calc_detail_list")
	public ModelAndView zmm_weight_edoc_calc_detail_list(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String from = "【전자결재I/F】차량 계량 정산 상세 팝업";
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		logger.debug("@@"+paramMap);
		List<Object> list = zmm_aw_Service.zmm_weight_edoc_calc_detail_list(paramMap);
		
		mav.addObject("list", list);
		mav.setViewName("/yp/zmm/aw/edoc_calc_detail_list");
		return mav;
	}
	
	
	/**
	 * 전자결재I/F - 전자결재 상태변경
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/aw/zmm_edoc_status_update")
	public void zmm_edoc_status_update(HttpServletRequest request, HttpServletResponse response){
		String from = "【상태변경I/F】차량 계량 상태연동";
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		String RESULT = "";
		String MESSAGE = "";
		
		try {
			int result = 0;
			result = zmm_aw_Service.zmm_edoc_status_update(request, response);
			logger.debug("UPDATE {} 건 완료", result);
			if(result > 0) {
				RESULT = "S";
				MESSAGE = "성공";
				map.put("RESULT", RESULT);
				map.put("MESSAGE", MESSAGE);
				list.add(map);
			}else{
				RESULT = "E";
				MESSAGE = "상태가 변경 된 대상이 존재하지 않습니다.";
				map.put("RESULT", RESULT);
				map.put("MESSAGE", MESSAGE);
				list.add(map);
			}
		} catch (Exception e) {
			logger.error("{} - {}", e.getCause(), e.toString());
			RESULT = "E";
			MESSAGE = this.subStrByte(e.toString(), 4000);
			map.put("RESULT", RESULT);
			map.put("MESSAGE", MESSAGE); // 4000바이트 초과 문자열 잘라내기
			list.add(map);
			//e.printStackTrace();
		} finally {
			logger.debug("{}", list);
			this.JsonFlush(request, response, list, from);
		}
	}
	
	
	/**
	 * 전자결재I/F - 전자결재(수정 계량 확인서) 상태변경
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/aw/zmm_edoc_data_update")
	public void zmm_edoc_data_update(HttpServletRequest request, HttpServletResponse response){
		String from = "【상태변경I/F】차량 계량 상태연동(수정 계량 확인서)";
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		String RESULT = "";
		String MESSAGE = "";
		
		try {
			int result = 0;
			result = zmm_aw_Service.zmm_edoc_data_update(request, response);
			logger.debug("UPDATE {} 건 완료", result);
			if(result > 0) {
				RESULT = "S";
				MESSAGE = "성공";
				map.put("RESULT", RESULT);
				map.put("MESSAGE", MESSAGE);
				list.add(map);
			}else{
				RESULT = "E";
				MESSAGE = "상태가 변경 된 대상이 존재하지 않습니다.";
				map.put("RESULT", RESULT);
				map.put("MESSAGE", MESSAGE);
				list.add(map);
			}
		} catch (Exception e) {
			logger.error("{} - {}", e.getCause(), e.toString());
			RESULT = "E";
			MESSAGE = this.subStrByte(e.toString(), 4000);
			map.put("RESULT", RESULT);
			map.put("MESSAGE", MESSAGE); // 4000바이트 초과 문자열 잘라내기
			list.add(map);
			//e.printStackTrace();
		} finally {
			logger.debug("{}", list);
			this.JsonFlush(request, response, list, from);
		}
	}
	
	
	/**
	 * YPWEBPOTAL-16 차량계량 정산 > 전자결재 상태값 변경 오류 및 전표번호 리턴 오류
	 * 
	 * 신규 추가
	 * 
	 * 구매관리 > 물류관리 > 전표 생성 서버사이드 validation
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/aw/fi_doc_regpage_check", method = RequestMethod.POST)
	public ModelAndView fi_doc_regpage_check(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("/yp/zmm/aw/fi_doc_regpage_check");
		
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		logger.debug("req_data="+req_data);
		// int result_cnt = zmm_aw_Service.zmm_weight_calc_save(paramMap);
		
		HashMap<String, Object> result = zmm_aw_Service.fi_doc_regpage(req_data);
		logger.debug("result="+result.toString());
		HashMap<String, String> json = new HashMap<String, String>();
		if(result == null){
			json.put("result", "S");
		}else{
			json.put("result", "E");
		}
		
		return new ModelAndView("DataToJson", json);
	}
	
	
	/**
	 * 구매관리 > 물류관리 > 차량 계량 정산 전표생성 화면
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zmm/aw/fi_doc_regpage", method = RequestMethod.POST)
	public ModelAndView fi_doc_regpage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		
		req_data.put("auth", (String) session.getAttribute("FI_AUTH"));
		if (req_data.get("auth") == null || "".equals(req_data.get("auth"))) {
			req_data.put("auth", "US");
		}
		//logger.debug("auth - {}", req_data.get("auth"));
		//logger.debug("req_data - {}", req_data);
		HashMap<String, Object> result = zmm_aw_Service.fi_doc_regpage(req_data);
		
		req_data.put("FRM", result.get("ZFIS0010_W"));
		req_data.put("TRF", result.get("ZFIS0020_W"));
		req_data.put("user_dept_code", (String) session.getAttribute("userDeptCd"));
		
		mav.addObject("req_data", req_data);
		
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/zfi/doc/zfi_doc_create");
		return mav;
	}
	
	
	@RequestMapping(value = "/yp/zmm/aw/retrieveMATNR_SW")
	public void retrieveMATNR_SW(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		String status = "";
		String msg = "";
		
		zmm_aw_Service.retrieveMATNR_SW();
		
		status = "S";
		msg = "성공";
		map.put("status", status);
		map.put("msg", msg);
		list.add(map);
		
	}
	
	
	@RequestMapping(value = "/yp/zmm/aw/retrieveKUNNR_SW")
	public void retrieveKUNNR_SW(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		String status = "";
		String msg = "";
		
		zmm_aw_Service.retrieveKUNNR_SW();
		
		status = "S";
		msg = "성공";
		map.put("status", status);
		map.put("msg", msg);
		list.add(map);
		
	}
	
	
	/**
	 * 삼우계량I/F - API 연동 DB처리
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/aw/zmm_weight_data_json")
	public void zmm_weight_data_json(HttpServletRequest request, HttpServletResponse response){
		String from = "【삼우 차량계량 시스템 연동]";
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		String status = "";
		String msg = "";
				
		try {
			int result = 0;
			result = zmm_aw_Service.zmm_weight_data_json(request, response);
			logger.debug("UPDATE {} 건 완료", result);
			if(result > 0) {
				status = "S";
				msg = "성공";
				map.put("status", status);
				map.put("msg", msg);
				list.add(map);
			}else{
				status = "E";
				msg = "실패";
				map.put("status", status);
				map.put("msg", msg);
				list.add(map);
			}
		} catch (Exception e) {
			logger.error("{} - {}", e.getCause(), e.toString());
			status = "E";
			msg = this.subStrByte(e.toString(), 4000);
			map.put("status", status);
			map.put("msg", msg); // 4000바이트 초과 문자열 잘라내기
			list.add(map);
			//e.printStackTrace();
		} finally {
			logger.debug("{}", list);
			this.JsonFlush(request, response, list, from);
		}
	}
	
	
	/**
	 * JSON Flush 기능
	 * @param request
	 * @param response
	 * @param list
	 * @param from
	 */
	@SuppressWarnings({"rawtypes", "static-access"})
	private void JsonFlush(HttpServletRequest request, HttpServletResponse response, List list, String from) {
		PrintWriter out = null;
		try {
			Util util = new Util();
			String jsonString = JSONValue.toJSONString(list);
			response.setContentType("text/plain;charset=utf-8"); // json
			jsonString = jsonString.replace("\"org.springframework.validation.BindingResult.string\":org.springframework.validation.BeanPropertyBindingResult: 0 errors,", "");
			
			// 20191026_khj XSS 필터적용
			jsonString = util.XSSFilter(jsonString);
			logger.debug("{} ReturnJson: {}", from, JsonEnterConvert(jsonString));
			out = response.getWriter();
			out.println(jsonString);
		} catch (IOException e) {
			logger.error("{} - {}", e.getMessage(), e);
			e.printStackTrace();
			System.err.println("IOException : " + e.getMessage());
		} catch (Throwable e) {
			logger.error("{} - {}", e.getMessage(), e);
			e.printStackTrace();
			System.err.println("Throwable : " + e.getMessage());
		} finally {
			out.flush();
			out.close();
		}
	}
	
	
	/**
	 * 디버깅용 JSON 보기좋게 표시
	 * @param json
	 * @return
	 */
	private String JsonEnterConvert(String json) {
		if (json == null || json.length() < 2) {
			return json;
		}
		
		final int len = json.length();
		final StringBuilder sb = new StringBuilder();
		char c;
		String tab = "";
		boolean beginEnd = true;
		for (int i = 0; i < len; i++) {
			c = json.charAt(i);
			switch (c) {
				case '{':
				case '[': {
					sb.append(c);
					if (beginEnd) {
						tab += "\t";
						sb.append("\n");
						sb.append(tab);
					}
					break;
				}
				case '}':
				case ']': {
					if (beginEnd) {
						tab = tab.substring(0, tab.length() - 1);
						sb.append("\n");
						sb.append(tab);
					}
					sb.append(c);
					break;
				}
				case '"': {
					if (json.charAt(i - 1) != '\\')
						beginEnd = !beginEnd;
					sb.append(c);
					break;
				}
				case ',': {
					sb.append(c);
					if (beginEnd) {
						sb.append("\n");
						sb.append(tab);
					}
					break;
				}
				default: {
					sb.append(c);
				}
			} // switch end
		}
		if (sb.length() > 0)
			sb.insert(0, '\n');
		return sb.toString();
	}
	
	
	/**
	 * byte단위로 문자열을 자르는 함수
	 *  - 2바이트, 3바이트 문자열이 잘리는 부분은 제거 (한글 등)
	 *  - 자르고 뒤에 ...을 붙인다.
	 * @param str : 자를 문자열
	 * @param cutlen : 자를 바이트 수
	 * @return 자르고 뒤에 ...을 붙인 문자열
	 */
	private String subStrByte(String str, int cutlen) {
		if(!str.isEmpty()) {
			str = str.trim();
			if(str.getBytes().length <= cutlen) {
				return str;
			} else {
				StringBuffer sbStr = new StringBuffer(cutlen);
				int nCnt = 0;
				for(char ch: str.toCharArray())
				{
					nCnt += String.valueOf(ch).getBytes().length;
					if(nCnt > cutlen) break;
					sbStr.append(ch);
				}
				return sbStr.toString();
			}
		}
		else {
			return "";
		}
	}
}
