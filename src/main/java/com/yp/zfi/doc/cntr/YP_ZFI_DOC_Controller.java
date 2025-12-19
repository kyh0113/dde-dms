package com.yp.zfi.doc.cntr;

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
import com.yp.zfi.doc.srvc.intf.YP_ZFI_DOC_Service;

@Controller
public class YP_ZFI_DOC_Controller {

	@Autowired
	private YP_ZFI_DOC_Service zfi_doc_Service;
	@Autowired
	private YPLoginService lService;

	private static final Logger logger = LoggerFactory.getLogger(YP_ZFI_DOC_Controller.class);

	/**
	 * 재무관리 > 전표관리 > 회계전표 목록
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zfi/doc/zfi_doc_list", method = RequestMethod.POST)
	public ModelAndView zfi_doc_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		mav.addObject("hierarchy", paramMap.get("hierarchy"));

		mav.setViewName("/yp/zfi/doc/zfi_doc_list");
		return mav;
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 목록 > 엑셀 다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/yp/zfi/doc/xls/zfi_doc_list", method = RequestMethod.POST)
	public ModelAndView xls_zfi_doc_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		list = zfi_doc_Service.ui_select_cs_notice_list(request, response);

		mav.addObject("alllist", list);

		mav.setViewName("/yp/zfi/doc/xls/zfi_doc_list");
		return mav;
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 목록 > 결재상신
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zfi/doc/createDocWritePage", method = RequestMethod.POST)
	public ModelAndView createDocWritePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", ((String) session.getAttribute("userName")));
		paramMap.put("user_dept", ((String) session.getAttribute("userDept")));
		paramMap.put("auth", (String) session.getAttribute("FI_AUTH"));
		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");

		mav.addObject("FROM", paramMap.get("FROM")); // 호출프로그램 - {zfi_doc_list:회계전표 목록, zfi_doc_create:회계전표 등록}
		mav.addObject("BELNR", paramMap.get("BELNR")); // 회계전표 목록
		mav.addObject("GJAHR", paramMap.get("GJAHR")); // 회계전표 목록, 등록
		mav.addObject("BUDAT", paramMap.get("BUDAT")); // 회계전표 등록
		mav.addObject("req_data", paramMap);

		mav.setViewName("/yp/zfi/doc/zfi_doc_list_p3");
		return mav;
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 목록 > 회계전표 팝업
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zfi/doc/printDocPage", method = RequestMethod.POST)
	public ModelAndView printDocPage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();
		paramMap.put("userDept", session.getAttribute("userDept"));
		paramMap.put("userDeptCd", session.getAttribute("userDeptCd"));
		paramMap.put("empCode", session.getAttribute("empCode"));

		String return_page = "";
		HashMap<String, ArrayList<HashMap<String, String>>> result = new HashMap<String, ArrayList<HashMap<String, String>>>();

		if ("1".equals(paramMap.get("type"))) {
			return_page = "/yp/zfi/doc/zfi_doc_list_p1";
			result = zfi_doc_Service.retrievePrintDocument1(paramMap);
		} else if ("2".equals(paramMap.get("type"))) {
			return_page = "/yp/zfi/doc/zfi_doc_list_p2";
			result = zfi_doc_Service.retrievePrintDocument2(paramMap);
			mav.addObject("etc", result.get("etc"));
			mav.addObject("subject", paramMap.get("type"));
		} else if ("3".equals(paramMap.get("type"))) {
			return_page = "/yp/zfi/doc/zfi_doc_list_p2";
			result = zfi_doc_Service.retrievePrintDocument2(paramMap);
			mav.addObject("etc", result.get("etc"));
			mav.addObject("subject", paramMap.get("type"));
		}
		result.get("headermap").get(0).put("totalpage", String.valueOf((result.get("list").size() - 1) / 5 + 1));// (totalrow-1)/rowperpage+1
		result.get("headermap").get(0).put("userDept", (String) paramMap.get("userDept"));

		mav.addObject("headermap", result.get("headermap"));
		mav.addObject("list", result.get("list"));

		mav.setViewName(return_page);
		return mav;
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 목록 > 결재작성
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zfi/doc/createDocWrite", method = RequestMethod.POST)
	public ModelAndView createDocWrite(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));

		String[] return_str = zfi_doc_Service.createDocWrite(paramMap);

		resultMap.put("flag", return_str[0]);
		resultMap.put("msg", return_str[1]);
		resultMap.put("url", return_str[2]);

		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 목록 > 삭제
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zfi/doc/remove_rtrv_doc", method = RequestMethod.POST)
	public ModelAndView remove_rtrv_doc(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		String result = zfi_doc_Service.removeDocument(paramMap);

		resultMap.put("msg", result);

		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 목록 > 상세조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zfi/doc/select_rtrv_doc", method = RequestMethod.POST)
	public ModelAndView select_rtrv_doc(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		String docno = zfi_doc_Service.retrieveDocumentPop(paramMap);
		
		resultMap.put("docno", docno);
		resultMap.put("bukrs", "1000");// 회사코드 1000고정
		resultMap.put("belnr", (String) paramMap.get("BELNR"));
		resultMap.put("gjahr", ((String) paramMap.get("BUDAT")).substring(0, 4));

		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 목록 > 빠른전표
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zfi/doc/documentRegpage", method = RequestMethod.POST)
	public ModelAndView documentRegpage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();
		
		req_data.put("auth", (String) session.getAttribute("FI_AUTH"));
		if (req_data.get("auth") == null || "".equals(req_data.get("auth"))) {
			req_data.put("auth", "US");
		}
		logger.debug("auth - {}", req_data.get("auth"));
		HashMap<String, Object> result = zfi_doc_Service.retrieveDocumentDetail(req_data);
		req_data.clear();
		req_data.put("FRM", result.get("ZFIS0010_W"));
		//logger.debug("FRM - {}", result.get("ZFIS0010_W"));
		req_data.put("TRF", result.get("ZFIS0020_W"));
		//logger.debug("TRF - {}", result.get("ZFIS0020_W"));
		req_data.put("user_dept_code", (String) session.getAttribute("userDeptCd"));

		mav.addObject("req_data", req_data);

		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/zfi/doc/zfi_doc_create");
		return mav;
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zfi/doc/zfi_doc_create", method = RequestMethod.POST)
	public ModelAndView zfi_doc_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		mav.setViewName("/yp/zfi/doc/zfi_doc_create");
		return mav;
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > 전표 등록
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zfi/doc/createDocument")
	public ModelAndView createDocument(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();
		req_data.put("emp_code", session.getAttribute("empCode"));

		String[] return_str = zfi_doc_Service.createDocument(req_data);

		if (return_str[0].equals("S"))
			logger.debug("###%%%" + session.getAttribute("userDept") + "," + session.getAttribute("userName") + "," + session.getAttribute("empCode") + "," + return_str[1]);
		HashMap resultMap = new HashMap();
		resultMap.put("flag", return_str[0]);
		resultMap.put("msg", return_str[1]);

		return new ModelAndView("DataToJson", resultMap);
	}

	/* ## document_regpage popup 시작 ############################################################################################################### */
	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > AJAX(가용예산 조회)
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zfi/doc/retrieveBUDGET")
	public ModelAndView retrieveBUDGET(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		String result = zfi_doc_Service.retrieveBUDGET(req_data);

		HashMap resultMap = new HashMap();
		resultMap.put("amt", result);

		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > 팝업(업체 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zfi/doc/retrieveLIFNR")
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
		paramMap.put("type", paramMap.get("type"));
		paramMap.put("target", paramMap.get("target"));
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zfi/doc/search_lifnr_pop");
		return mav;
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > AJAX(업체 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zfi/doc/retrieveLIFNRonblur")
	public ModelAndView retrieveLIFNROnblur(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap req_data = new HashMap();
		req_data.put("search_type", "I_LIFNR");
		req_data.put("search_text", (String) request.getParameter("LIFNR"));
		req_data.put("AGKOA", (String) request.getParameter("AGKOA"));
		req_data.put("doc_type", (String) request.getParameter("doc_type"));
		
		ArrayList<HashMap<String, String>> result = zfi_doc_Service.retrieveLIFNR(req_data);

		HashMap resultMap = new HashMap();
		if (result.size() > 0) {
			resultMap.put("LIFNR", result.get(0).get("LIFNR"));
			resultMap.put("LIFNR", result.get(0).get("LIFNR"));
			resultMap.put("STCD2", result.get(0).get("STCD2"));
			resultMap.put("NAME1", result.get(0).get("NAME1"));
			resultMap.put("HKONT", result.get(0).get("HKONT"));
			resultMap.put("TXT_50", result.get(0).get("TXT_50"));
			resultMap.put("BANKN", result.get(0).get("BANKN"));
			resultMap.put("BVTYP", result.get(0).get("BVTYP"));
			resultMap.put("KTOKK", result.get(0).get("KTOKK"));
			resultMap.put("ZTERM", result.get(0).get("ZTERM"));
			resultMap.put("TEXT1", result.get(0).get("TEXT1"));
		}
		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > AJAX(업체 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zfi/doc/retrieveAjaxSTCD2")
	public ModelAndView retrieveAjaxSTCD2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap req_data = new HashMap();
		req_data.put("type", "T");
		req_data.put("search_type", "I_STCD2");
		req_data.put("search_text", (String) request.getParameter("STCD2"));

		logger.debug("$$" + req_data);
		ArrayList<HashMap<String, String>> result = zfi_doc_Service.retrieveLIFNR(req_data);

		HashMap resultMap = new HashMap();
		if (result.size() > 0) {
			resultMap.put("STCD2", result.get(0).get("STCD2"));
			resultMap.put("NAME1", result.get(0).get("NAME1"));
		}
		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > 팝업(계정과목 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zfi/doc/retrieveSAKNR")
	public ModelAndView retrieveSAKNR(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));

		if (paramMap.get("search_type") != null && paramMap.get("search_text") != null) {
			ArrayList<HashMap<String, String>> list = zfi_doc_Service.retrieveSAKNR(paramMap);
			int totCnt = list.size();

			Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
			mav.addObject("pagination", pagination);

			paramMap.put("firstRecordIndex", pagination.getStartIndex());
			paramMap.put("lastRecordIndex", pagination.getEndIndex());

			ArrayList<HashMap<String, String>> pagingList = util.pagingListOfERPList(list, pagination.getStartIndex(), pagination.getEndIndex());

			mav.addObject("list", pagingList);
			mav.addObject("req_data", paramMap);
		}
		mav.setViewName("/yp/zfi/doc/search_saknr_pop");
		return mav;
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > AJAX(계정과목 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zfi/doc/retrieveSAKNRonblur")
	public ModelAndView retrieveSAKNRonblur(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		req_data.put("search_type", "I_HKONT");
		req_data.put("search_text", (String) request.getParameter("HKONT"));
		logger.debug("@@@" + req_data);
		HashMap<String, String> result = zfi_doc_Service.retrieveSAKNRonBlur(req_data);

		HashMap resultMap = new HashMap();

		resultMap.put("ABWHK", result.get("E_HKONT"));
		resultMap.put("TXT20", result.get("E_TXT_50"));

		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > 팝업(세금코드 선택)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zfi/doc/retrieveTAXPC")
	public ModelAndView retrieveTAXPC(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));

		ArrayList<HashMap<String, String>> list = zfi_doc_Service.retrieveTAXPC(paramMap);
		int totCnt = list.size();

		Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
		mav.addObject("pagination", pagination);

		paramMap.put("firstRecordIndex", pagination.getStartIndex());
		paramMap.put("lastRecordIndex", pagination.getEndIndex());

		ArrayList<HashMap<String, String>> pagingList = util.pagingListOfERPList(list, pagination.getStartIndex(), pagination.getEndIndex());

		mav.addObject("list", pagingList);
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zfi/doc/search_taxpc_pop");
		return mav;
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > AJAX(세금코드 선택)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zfi/doc/retrieveTAXPConblur")
	public ModelAndView retrieveTAXPConblur(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap req_data = new HashMap();
		// req_data.put("search_type","I_MWSKZ");
		req_data.put("I_MWSKZ", (String) request.getParameter("MWSKZ"));
		req_data.put("doc_type", (String) request.getParameter("doc_type"));

		logger.debug("@@@" + req_data);
		ArrayList<HashMap<String, String>> result = zfi_doc_Service.retrieveTAXPC(req_data);

		HashMap resultMap = new HashMap();
		if (result.size() > 0) {
			resultMap.put("MWSKZ", result.get(0).get("MWSKZ"));
			resultMap.put("TEXT1", result.get(0).get("TEXT1"));
		}
		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > 팝업(은행 선택)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zfi/doc/retrieveBANKN")
	public ModelAndView retrieveBANKN(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));
		// 해외영업팀(서린상사)이 아니면 계좌검색 X -20.03.03
		HttpSession session = request.getSession();
		if (!"D188102476".equals((String) session.getAttribute("userDeptCd")) && "599999".equals((String) paramMap.get("LIFNR"))) {
			paramMap.put("LIFNR", "");
			ArrayList<HashMap<String, String>> list = zfi_doc_Service.retrieveBANKN(paramMap);
			int totCnt = list.size();

			Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
			mav.addObject("pagination", pagination);

			paramMap.put("firstRecordIndex", pagination.getStartIndex());
			paramMap.put("lastRecordIndex", pagination.getEndIndex());

			ArrayList<HashMap<String, String>> pagingList = util.pagingListOfERPList(list, pagination.getStartIndex(), pagination.getEndIndex());

			mav.addObject("list", pagingList);
			mav.addObject("req_data", paramMap);
		}
		if (!"".equals(paramMap.get("search_type"))) {
			ArrayList<HashMap<String, String>> list = zfi_doc_Service.retrieveBANKN(paramMap);
			int totCnt = list.size();

			Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
			mav.addObject("pagination", pagination);

			paramMap.put("firstRecordIndex", pagination.getStartIndex());
			paramMap.put("lastRecordIndex", pagination.getEndIndex());

			ArrayList<HashMap<String, String>> pagingList = util.pagingListOfERPList(list, pagination.getStartIndex(), pagination.getEndIndex());

			mav.addObject("list", pagingList);
			mav.addObject("req_data", paramMap);
		}
		mav.setViewName("/yp/zfi/doc/search_bankn_pop");
		return mav;
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > 팝업(통화 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zfi/doc/retrieveWAERS")
	public ModelAndView retrieveWAERS(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));

		if (paramMap.get("search_type") != null) {
			ArrayList<HashMap<String, String>> list = zfi_doc_Service.retrieveWAERS(paramMap);
			int totCnt = list.size();

			Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
			mav.addObject("pagination", pagination);

			paramMap.put("firstRecordIndex", pagination.getStartIndex());
			paramMap.put("lastRecordIndex", pagination.getEndIndex());

			ArrayList<HashMap<String, String>> pagingList = util.pagingListOfERPList(list, pagination.getStartIndex(), pagination.getEndIndex());

			mav.addObject("list", pagingList);
		}
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zfi/doc/search_waers_pop");
		return mav;
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > AJAX(통화 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zfi/doc/retrieveWAERSonblur")
	public ModelAndView retrieveWAERSonblur(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap req_data = new HashMap();
		req_data.put("search_type", "I_WAERS");
		req_data.put("search_text", (String) request.getParameter("WAERS"));
		req_data.put("BUDAT", (String) request.getParameter("BUDAT"));

		logger.debug("@@@" + req_data);
		ArrayList<HashMap<String, String>> result = zfi_doc_Service.retrieveWAERS(req_data);

		HashMap resultMap = new HashMap();
		if (result.size() > 0) {
			resultMap.put("WAERS", result.get(0).get("WAERS"));
			resultMap.put("KURSF", result.get(0).get("UKURS"));
		}
		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > 팝업(은행번호 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zfi/doc/retrieveBANKA")
	public ModelAndView retrieveBANKA(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		if (!paramMap.isEmpty()) {
			HashMap<String, Object> result = zfi_doc_Service.retrieveBANKA(paramMap);
			paramMap.put("E_FLAG", result.get("E_FLAG"));
			paramMap.put("E_MESSAGE", result.get("E_MESSAGE"));

			mav.addObject("list", result.get("list"));
			mav.addObject("req_data", paramMap);
		}
		mav.setViewName("/yp/zfi/doc/search_banka_pop");
		return mav;
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > AJAX(은행번호 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zfi/doc/retrieveBANKAonblur")
	public ModelAndView retrieveBANKAonblur(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap req_data = new HashMap();
		req_data.put("search_type", "I_BANKL");
		req_data.put("search_text", (String) request.getParameter("BVTYP"));

		HashMap<String, Object> result = zfi_doc_Service.retrieveBANKA(req_data);
		ArrayList<HashMap<String, String>> list = (ArrayList<HashMap<String, String>>) result.get("list");

		HashMap resultMap = new HashMap();
		resultMap.put("E_FLAG", result.get("E_FLAG"));
		resultMap.put("E_MESSAGE", result.get("E_MESSAGE"));
		if ("S".equals((String) result.get("E_FLAG"))) {
			resultMap.put("BANKA", list.get(0).get("BANKA"));
		}
		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > 팝업(계정과목 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zfi/doc/retrieveHKONT")
	public ModelAndView retrieveHKONT(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));

		if (paramMap.get("search_type") != null) {
			ArrayList<HashMap<String, String>> list = zfi_doc_Service.retrieveHKONT(paramMap);
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
		mav.setViewName("/yp/zfi/doc/search_hkont_pop");
		return mav;
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > AJAX(계정과목 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zfi/doc/retrieveAjaxHKONT")
	public ModelAndView retrieveAjaxHKONT(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap req_data = new HashMap();
		req_data.put("search_type", "I_HKONT");
		req_data.put("search_text", (String) request.getParameter("HKONT"));

		logger.debug("$$" + req_data);
		ArrayList<HashMap<String, String>> result = zfi_doc_Service.retrieveHKONT(req_data);

		HashMap resultMap = new HashMap();
		if (result.size() > 0) {
			resultMap.put("SAKNR", result.get(0).get("SAKAN"));
			resultMap.put("TXT_50", result.get(0).get("TXT50"));
		}
		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > 팝업(집행부서 검색, 코스트센터 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zfi/doc/retrieveKOSTL")
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
			ArrayList<HashMap<String, String>> list = zfi_doc_Service.retrieveKOSTL(paramMap);
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
		mav.setViewName("/yp/zfi/doc/search_kostl_pop");
		return mav;
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > AJAX(집행부서 검색, 코스트센터 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zfi/doc/retrieveAjaxKOSTL")
	public ModelAndView retrieveAjaxKOSTL(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap req_data = new HashMap();
		String type = ((String) request.getParameter("type")).equals("Z") ? "ZKOSTL" : "KOSTL";
		req_data.put("search_type", "I_KOSTL");
		req_data.put("search_text", (String) request.getParameter(type));

		HttpSession session = request.getSession();
		req_data.put("emp_code", (String) session.getAttribute("empCode"));

		logger.debug("$$" + req_data);

		ArrayList<HashMap<String, String>> result = zfi_doc_Service.retrieveKOSTL(req_data);

		HashMap resultMap = new HashMap();
		if (result.size() > 0) {
			resultMap.put("KOST1", result.get(0).get("KOST1"));
			resultMap.put("VERAK", result.get(0).get("VERAK"));
		}
		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > 팝업(WBS코드 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zfi/doc/retrievePOSID")
	public ModelAndView retrievePOSID(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));

		if (paramMap.get("search_type") != null) {
			ArrayList<HashMap<String, String>> list = zfi_doc_Service.retrievePOSID(paramMap);
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
		mav.setViewName("/yp/zfi/doc/search_posid_pop");
		return mav;
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > AJAX(WBS코드 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zfi/doc/retrieveAjaxPOSID")
	public ModelAndView retrieveAjaxPOSID(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap req_data = new HashMap();
		req_data.put("search_type", "I_PSPNR");
		req_data.put("search_text", (String) request.getParameter("POSID"));

		logger.debug("$$" + req_data);
		ArrayList<HashMap<String, String>> result = zfi_doc_Service.retrievePOSID(req_data);

		HashMap resultMap = new HashMap();
		if (result.size() > 0) {
			resultMap.put("POSID", result.get(0).get("POSID"));
			resultMap.put("POST1", result.get(0).get("POST1"));
		}
		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > 팝업(자재그룹 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zfi/doc/retrieveMVGR")
	public ModelAndView retrieveMVGR(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));

		if (paramMap.get("search_type") != null) {
			ArrayList<HashMap<String, String>> list = zfi_doc_Service.retrieveMVGR(paramMap);
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
		mav.setViewName("/yp/zfi/doc/search_mvgr_pop");
		return mav;
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > AJAX(자재그룹 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zfi/doc/retrieveAjaxMVGR1")
	public ModelAndView retrieveAjaxMVGR1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap req_data = new HashMap();
		req_data.put("search_type", "I_MVGR1");
		req_data.put("search_text", (String) request.getParameter("MVGR1"));

		logger.debug("$$" + req_data);
		ArrayList<HashMap<String, String>> result = zfi_doc_Service.retrieveMVGR(req_data);

		HashMap resultMap = new HashMap();
		if (result.size() > 0) {
			resultMap.put("MVGR1", result.get(0).get("MVGR1"));
			resultMap.put("BEZEI", result.get(0).get("BEZEI"));
		}
		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > 팝업(판매오더 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zfi/doc/retrieveVBELN")
	public ModelAndView retrieveVBELN(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));

		if (paramMap.get("search_type") != null) {
			ArrayList<HashMap<String, String>> list = zfi_doc_Service.retrieveVBELN(paramMap);
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
		mav.setViewName("/yp/zfi/doc/search_vbeln_pop");
		return mav;
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > AJAX(판매오더 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zfi/doc/retrieveAjaxVBELN")
	public ModelAndView retrieveAjaxVBELN(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap req_data = new HashMap();
		req_data.put("search_type", "I_VBELN");
		req_data.put("search_text", (String) request.getParameter("VBELN"));

		logger.debug("$$" + req_data);
		ArrayList<HashMap<String, String>> result = zfi_doc_Service.retrieveVBELN(req_data);

		HashMap resultMap = new HashMap();
		if (result.size() > 0) {
			resultMap.put("VBELN", result.get(0).get("VBELN"));
			resultMap.put("VTWEG", result.get(0).get("VTWEG"));
			resultMap.put("MVGR1", result.get(0).get("MVGR1"));
		}
		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > 팝업(단위 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zfi/doc/retrieveMEINS")
	public ModelAndView retrieveMEINS(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));

		if (paramMap.get("search_type") != null) {
			ArrayList<HashMap<String, String>> list = zfi_doc_Service.retrieveMEINS(paramMap);
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
		mav.setViewName("/yp/zfi/doc/search_meins_pop");
		return mav;
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > AJAX(단위 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zfi/doc/retrieveAjaxMEINS")
	public ModelAndView retrieveAjaxMEINS(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap req_data = new HashMap();
		req_data.put("search_type", "I_MSEHI");
		req_data.put("search_text", (String) request.getParameter("MEINS"));

		logger.debug("$$" + req_data);
		ArrayList<HashMap<String, String>> result = zfi_doc_Service.retrieveMEINS(req_data);

		HashMap resultMap = new HashMap();
		if (result.size() > 0) {
			resultMap.put("MSEHI", result.get(0).get("MSEHI"));
			resultMap.put("MSEHL", result.get(0).get("MSEHL"));
		}
		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > 팝업(차량 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zfi/doc/retrieveZCCODE")
	public ModelAndView retrieveZCCODE(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));

		if (paramMap.get("search_type") != null) {
			ArrayList<HashMap<String, String>> list = zfi_doc_Service.retrieveZCCODE(paramMap);
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
		mav.setViewName("/yp/zfi/doc/search_zccode_pop");
		return mav;
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > AJAX(차량 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zfi/doc/retrieveAjaxZCCODE")
	public ModelAndView retrieveAjaxZCCODE(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap req_data = new HashMap();
		req_data.put("search_type", "I_ZCCODE");
		req_data.put("search_text", (String) request.getParameter("ZCCODE"));

		logger.debug("$$" + req_data);
		ArrayList<HashMap<String, String>> result = zfi_doc_Service.retrieveZCCODE(req_data);

		HashMap resultMap = new HashMap();
		if (result.size() > 0) {
			resultMap.put("ZCCODE", result.get(0).get("ZCCODE"));
			resultMap.put("ZCTEXT", result.get(0).get("ZCTEXT"));
		}
		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > 팝업(지급조건 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zfi/doc/retrieveZTERM")
	public ModelAndView retrieveZTERM(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));

		if (paramMap.get("search_type") != null) {
			ArrayList<HashMap<String, String>> list = zfi_doc_Service.retrieveZTERM(paramMap);
			int totCnt = list.size();

			Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
			mav.addObject("pagination", pagination);

			paramMap.put("firstRecordIndex", pagination.getStartIndex());
			paramMap.put("lastRecordIndex", pagination.getEndIndex());

			ArrayList<HashMap<String, String>> pagingList = util.pagingListOfERPList(list, pagination.getStartIndex(), pagination.getEndIndex());

			mav.addObject("list", pagingList);
		}
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zfi/doc/search_zterm_pop");
		return mav;
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > AJAX(지급조건 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zfi/doc/retrieveZTERMonblur")
	public ModelAndView retrieveZTERMonblur(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap req_data = new HashMap();
		req_data.put("search_type", "I_ZTERM");
		req_data.put("search_text", (String) request.getParameter("ZTERM"));

		logger.debug("@@@" + req_data);
		ArrayList<HashMap<String, String>> result = zfi_doc_Service.retrieveZTERM(req_data);

		HashMap resultMap = new HashMap();
		if (result.size() > 0) {
			resultMap.put("ZTERM", result.get(0).get("ZTERM"));
			resultMap.put("TEXT1", result.get(0).get("TEXT1"));
		}
		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > 팝업(설비오더 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zfi/doc/retrieveAUFNR")
	public ModelAndView retrieveAUFNR(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));

		if (paramMap.get("search_type") != null) {
			ArrayList<HashMap<String, String>> list = zfi_doc_Service.retrieveAUFNR(paramMap);
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
		mav.setViewName("/yp/zfi/doc/search_aufnr_pop");
		return mav;
	}


	/**
	 * 재무관리 > 전표관리 > 회계전표 등록 > AJAX(설비오더 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zfi/doc/retrieveAjaxAUFNR")
	public ModelAndView retrieveAjaxAUFNR(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap req_data = new HashMap();
		req_data.put("search_type", "I_AUFNR");
		req_data.put("search_text", (String) request.getParameter("AUFNR"));

		logger.debug("$$" + req_data);
		ArrayList<HashMap<String, String>> result = zfi_doc_Service.retrieveAUFNR(req_data);

		HashMap resultMap = new HashMap();
		if (result.get(0).get("msg") != null) {
			resultMap.put("MSG", result.get(0).get("msg"));
		} else if (result.size() > 0) {
			resultMap.put("AUFNR", result.get(0).get("AUFNR"));
			resultMap.put("KTEXT", result.get(0).get("KTEXT"));
			resultMap.put("KOSTL", result.get(0).get("KOSTL"));
			resultMap.put("LTEXT", result.get(0).get("LTEXT"));
		}
		return new ModelAndView("DataToJson", resultMap);
	}
	/* ## document_regpage popup 끝 ############################################################################################################### */
}
