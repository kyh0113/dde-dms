package com.yp.fixture.cntr;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;
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
import com.yp.fixture.srvc.intf.YPFixtureService;
import com.yp.login.srvc.intf.YPLoginService;

@Controller
public class YPFixtureController {
	
	private static final Logger logger = LoggerFactory.getLogger(YPFixtureController.class);
	
	@Autowired
	private YPFixtureService fixture_service;
	
	@Autowired
	private YPLoginService lService;
	
	@RequestMapping(value="/yp/fixture/fixtureList", method = RequestMethod.POST)
	public ModelAndView fixtureList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		ModelAndView mav = new ModelAndView();
		
		logger.debug("【화면호출】비품관리 > 전산비품 재고 조회");
		
		// 공통 - 네비게이션 시작
		List breadcrumbList = lService.select_breadcrumb_hierarchy(request, response);
		mav.addObject("breadcrumbList", breadcrumbList);
		mav.addObject("current_menu", breadcrumbList.get(breadcrumbList.size()-1));
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/fixture/fixture_list");
		return mav;
	}
	
	/**
	 * 비품관리 > 전산비품 재고 조회 > 비품팝업
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/fixture/fixtureReqPop")
	public ModelAndView fixture_req_pop(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		String gridData = paramMap.get("gridData").toString();
		
		// ----------------gridData뽑아내기----------------------------------------------------
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("gridData").toString());
		List<Map<String, Object>> list = util.getListMapFromJsonArray(jsonArr);
		int totCnt = list.size();
		// ----------------------------------------------------------------------------------
		
		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));

		

		Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
		mav.addObject("pagination", pagination);

		paramMap.put("firstRecordIndex", pagination.getStartIndex());
		paramMap.put("lastRecordIndex", pagination.getEndIndex());

		List<Object> pagingList = util.pagingListOfERPList(list, pagination.getStartIndex(), pagination.getEndIndex());
//		logger.debug("[TEST]pagingList:{}", pagingList);
		mav.addObject("list", pagingList);
		
		mav.addObject("grid_data", gridData);
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/fixture/fixture_req_pop");
		return mav;
	}
	
	/**
	 * 비품관리 > 전산비품 재고 조회 > 비품팝업 > 요청 데이터 생성
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/fixture/fixture_req_create")
	public ModelAndView fixture_req_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("【생성】비품관리 > 전산비품 재고 조회 > 비품팝업");
		HashMap resultMap = new HashMap();
		int result = fixture_service.fixture_req_create(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
		
	}
	
	
/**
 * ======================================================= [전산비품 요청 현황 조회] =======================================================
 */
	@RequestMapping(value="/yp/fixture/fixtureReqList", method = RequestMethod.POST)
	public ModelAndView fixtureReqList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		ModelAndView mav = new ModelAndView();
		
		logger.debug("【화면호출】비품관리 > 전산비품 요청 현황 조회");
		
		// 공통 - 네비게이션 시작
		List breadcrumbList = lService.select_breadcrumb_hierarchy(request, response);
		mav.addObject("breadcrumbList", breadcrumbList);
		mav.addObject("current_menu", breadcrumbList.get(breadcrumbList.size()-1));
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/fixture/fixture_req_list");
		return mav;
	}
	
	/**
	 * 결재상신 가능여부 체크 
	 */
	@RequestMapping(value="/yp/fixture/isAvailableEdocApproval", method = RequestMethod.POST)
	public ModelAndView isAvailableEdocApproval(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【결재상신 가능여부 체크】비품관리 > 전산비품 요청 현황 조회");
		HashMap resultMap = new HashMap();
		Boolean is_available_edoc_approval = fixture_service.is_available_edoc_approval(request, response);
		
		resultMap.put("result", is_available_edoc_approval);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 전자결재I/F - 비품요청 전자결재 데이터 연동
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/fixture/fixture_req_data")
	public void fixture_req_data(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String from = "[전자결재I/F] 비품요청 데이터 연동";
		logger.debug(from);
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
//		logger.debug("[전자결재] paramMap:"+paramMap);
		List list = fixture_service.fixture_req_list(paramMap);
		
		this.JsonFlush(request, response, list, from);
	}
	
	/**
	 * 전자결재I/F - 비품요청 전자결재 상태연동
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/fixture/fixture_edoc_status_update")
	public void fixture_edoc_status_update(HttpServletRequest request, HttpServletResponse response){
		String from = "[상태변경I/F] 비품불출요청 상태연동";
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		String RESULT = "";
		String MESSAGE = "";
		
		try {
			int result = 0;
			result = fixture_service.fixture_edoc_status_update(request, response);
			logger.debug("UPDATE {} 건 완료", result);
			if(result > 0) {
				RESULT = "S";
				MESSAGE = "성공";
				map.put("RESULT", RESULT);
				map.put("MESSAGE", MESSAGE);
				list.add(map);
			}else {
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
	 * 비품관리 > 전산비품 요청 현황 > 비품요청 상세 팝업
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/fixture/fixtureReqDtlPop")
	public ModelAndView fixture_req_dtl_pop(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		String gridData = paramMap.get("gridData").toString();
		
		// ----------------gridData뽑아내기----------------------------------------------------
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("gridData").toString());
		List<Map<String, Object>> paramList = util.getListMapFromJsonArray(jsonArr);
		// ----------------------------------------------------------------------------------
		
		/**
		 * fixture_req_code를 list로 묶고
		 * CODES Key - Value 쌓으로 만들기
		 */
		ArrayList<String> CODES =  new ArrayList<String>();
		for(int i=0; i<paramList.size(); i++){
			CODES.add(paramList.get(i).get("FIXTURE_REQ_CODE").toString());
		}
		paramMap.put("CODES", CODES);
		logger.debug("[TEST]paramMap:{}",paramMap);
		
		/**
		 * 비품 요청 현황 리스트
		 */
		List list = fixture_service.fixture_req_pop_list(paramMap);
		
		/**
		 * 발주요청 가능여부
		 */
		boolean isAvailablePurchaseReq = fixture_service.fixture_is_availalbe_purchase_req(paramMap);
		
		/**
		 * 구매완료 가능여부
		 */
		boolean isAvailableFinishPurchase = fixture_service.fixture_is_availalbe_finish_purchase(paramMap);
		
		int totCnt = list.size();
		
		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));

		Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
		mav.addObject("pagination", pagination);

		paramMap.put("firstRecordIndex", pagination.getStartIndex());
		paramMap.put("lastRecordIndex", pagination.getEndIndex());

		List<Object> pagingList = util.pagingListOfERPList(list, pagination.getStartIndex(), pagination.getEndIndex());
		
		logger.debug("[TEST]isAvailablePurchaseReq:{}", isAvailablePurchaseReq);
		logger.debug("[TEST]isAvailableFinishPurchase:{}", isAvailableFinishPurchase);
		
		mav.addObject("list", pagingList);
		
		mav.addObject("is_availalbe_finish_purchase", isAvailableFinishPurchase);
		mav.addObject("is_available_purchase_req", isAvailablePurchaseReq);
		mav.addObject("grid_data", gridData);
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/fixture/fixture_req_dtl_pop");
		return mav;
	}
	
	/**
	 * 비품관리 > 전산비품 요청 상세 현황 > 엑셀 다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/yp/popup/fixture/xls/fixture_req_dtl_list", method = RequestMethod.POST)
	public ModelAndView xls_zfi_doc_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		String gridData = paramMap.get("gridData").toString();
		
		// ----------------gridData뽑아내기----------------------------------------------------
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("gridData").toString());
		List<Map<String, Object>> paramList = util.getListMapFromJsonArray(jsonArr);
		// ----------------------------------------------------------------------------------
		
		/**
		 * fixture_req_code를 list로 묶고
		 * CODES Key - Value 쌓으로 만들기
		 */
		ArrayList<String> CODES =  new ArrayList<String>();
		for(int i=0; i<paramList.size(); i++){
			CODES.add(paramList.get(i).get("FIXTURE_REQ_CODE").toString());
		}
		paramMap.put("CODES", CODES);
		logger.debug("[TEST]paramMap:{}",paramMap);
		
		List list = fixture_service.fixture_req_pop_xls_list(paramMap);
		
		mav.addObject("alllist", list);
		mav.setViewName("/yp/fixture/xls/fixture_req_dtl_list");
		return mav;
	}
	
	/**
	 * 비품관리 > 전산비품 요청 현황 > 발주요청
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/fixture/fixture_req_purchase")
	public ModelAndView fixture_req_purchase(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【생성】비품관리 > 전산비품 재고 조회 > 비품팝업 > 발주요청");
		HashMap resultMap = new HashMap();
		
		int result = fixture_service.fixture_req_purchase(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 비품관리 > 전산비품 요청 현황 > 구매완료
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/fixture/fixture_req_purchase_finish")
	public ModelAndView fixture_req_purchase_finish(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【생성】비품관리 > 전산비품 재고 조회 > 비품팝업 > 구매완료");
		HashMap resultMap = new HashMap();
		
		int result = fixture_service.fixture_req_purchase_finish(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * ======================================================= [전산비품 마스터] =======================================================
	 */
	@RequestMapping(value="/yp/fixture/fixture_master_list", method = RequestMethod.POST)
	public ModelAndView fixtureMasterList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		ModelAndView mav = new ModelAndView();
		
		logger.debug("【화면호출】비품관리 > 전산비품 마스터");
		
		// 공통 - 네비게이션 시작
		List breadcrumbList = lService.select_breadcrumb_hierarchy(request, response);
		mav.addObject("breadcrumbList", breadcrumbList);
		mav.addObject("current_menu", breadcrumbList.get(breadcrumbList.size()-1));
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/fixture/fixture_master_list");
		return mav;
	}
	
	@RequestMapping(value="/yp/fixture/fixture_master_save", method = RequestMethod.POST)
	public ModelAndView fixtureMasterSave(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】비품관리 > 전산비품 마스터 > 저장");
		
		int result_cnt = fixture_service.fixture_master_save(request, response);
		HashMap<String, String> json = new HashMap<String, String>();
		json.put("result", Integer.toString(result_cnt));

		return new ModelAndView("DataToJson", json);
	}
	
	/**
	 * ======================================================= [전산비품 마스터 이력 조회] =======================================================
	 */
	@RequestMapping(value="/yp/fixture/fixture_master_hist_list", method = RequestMethod.POST)
	public ModelAndView fixtureMasterHistList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		ModelAndView mav = new ModelAndView();
		
		logger.debug("【화면호출】비품관리 > 전산비품 마스터 이력 조회");
		
		// 공통 - 네비게이션 시작
		List breadcrumbList = lService.select_breadcrumb_hierarchy(request, response);
		mav.addObject("breadcrumbList", breadcrumbList);
		mav.addObject("current_menu", breadcrumbList.get(breadcrumbList.size()-1));
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/fixture/fixture_master_hist_list");
		return mav;
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
			response.setContentType("text/plain;charset=utf-8");// json
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
			}// switch end
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
					if(nCnt > cutlen)  break;
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

