package com.yp.zmm.raw.cntr;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
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
import com.vicurus.it.core.common.WebUtil;
import com.yp.common.srvc.intf.CommonService;
import com.yp.login.srvc.intf.YPLoginService;
import com.yp.util.DateUtil;
import com.yp.zmm.raw.srvc.intf.YP_ZMM_RAW_Service;

@Controller
public class YP_ZMM_RAW_Controller {

	@Autowired
	private YP_ZMM_RAW_Service zmmService;
	@Autowired
	private YPLoginService lService;
	@Autowired
	private CommonService commonService;

	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(YP_ZMM_RAW_Controller.class);

	
	/**
	 * 구매관리 > 원료관리 > 입항스케줄 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/raw/zmm_raw_schedule_read", method = RequestMethod.POST)
	public ModelAndView zmm_raw_schedule_read(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		
		//session attr to param
		HttpSession session = request.getSession();
		paramMap.put("emp_code",(String) session.getAttribute("empCode"));
		paramMap.put("emp_name",((String) session.getAttribute("userName")));
		paramMap.put("user_dept",((String) session.getAttribute("userDept")));
		paramMap.put("user_dept_code",((String) session.getAttribute("userDeptCd")));
		paramMap.put("auth", (String) session.getAttribute("MM_AUTH"));
		if(paramMap.get("auth") == null) paramMap.put("auth","US");

		paramMap.put("lme_date", DateUtil.getYesterday());

		//현재 월 ~ 3개월 뒤 월 세팅
		String year  = Integer.toString(WebUtil.getYear());
		String month = Integer.toString(WebUtil.getMonth());
		if (month.length() == 1) month = "0" + month;
		String day   = "01";
		String current_month = year + "/" + month + "/" + day;	//ex)2020/08/01
		String next_month = WebUtil.getDateAdd(String.valueOf(WebUtil.getYear()), String.valueOf(WebUtil.getMonth()), 3);	//202011
		next_month = next_month.substring(0, 4) + "/" + next_month.substring(4, 6) + "/" + day;

		paramMap.put("current_month", current_month);
		paramMap.put("next_month", next_month);
		
		mav.addObject("req_data", paramMap);
		
		mav.setViewName("/yp/zmm/raw/zmm_raw_schedule_read");

		return mav;
	}
	
	/**
	 * 구매관리 > 원료관리 > 입항스케줄 조회 > 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/raw/zmm_raw_schedule_read_search", method = RequestMethod.POST)
	public ModelAndView zmm_raw_schedule_read_search(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		ArrayList<HashMap<String, String>> lme_chk = zmmService.retrieveLME_check(paramMap);
		
		int result = 0;
		if(0 == lme_chk.size()){
			paramMap.put("empty", "Y");	//미존재
		}else{
			paramMap.put("empty", "N");	//존재
		}
		
		ArrayList<HashMap<String, String>> lme     = zmmService.retrieveLME(paramMap);		//LME 데이터 가져오기
		ArrayList<HashMap<String, String>> lme_avg = zmmService.retrieveLME_AVG(paramMap);	//LME 평균 데이터 가져오기
		
		HashMap resultMap = new HashMap();
		resultMap.put("lme", lme);
		resultMap.put("lme_avg", lme_avg);

		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 구매관리 > 원료관리 > 입항스케줄 조회 > LME 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/raw/createLME")
	public ModelAndView createLME(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();
		paramMap.put("emp_code",(String) session.getAttribute("empCode"));
		logger.debug("$$"+paramMap);
		
		ArrayList<HashMap<String, String>> lme = zmmService.retrieveLME_check(paramMap);
		
		int result = 0;
		if(0 == lme.size()){
			result = zmmService.createLME(paramMap);
		}else{
			result = zmmService.updateLME(paramMap);
		}
		
		Map resultMap = new HashMap();
		
		if(result > 0) {
			resultMap.put("result_code", result);
			resultMap.put("msg", "저장 되었습니다.");
		}else { 
			resultMap.put("result_code", result);
			resultMap.put("msg", "저장중 오류가 발생하였습니다.");
		}
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 구매관리 > 원료관리 > 입항스케줄 조회 > 입항스케줄 엑셀다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/xls/zmm/raw/zmm_raw_schedule_read", method = RequestMethod.POST)
	public ModelAndView xls_zmm_raw_schedule_read(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		ArrayList<HashMap<String, String>> list = zmmService.retrieveArrivalScheduleList(paramMap);	//입항스케줄 데이터 가져오기
	
		mav.addObject("list", list);
		
		mav.setViewName("/yp/zmm/raw/xls/zmm_raw_schedule_read");
		
		return mav;
	}
	
	/**
	 * 구매관리 > 원료관리 > 입항스케줄 > 광종 코드팝업
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/popup/zmm/raw/retrieveItemPop")
	public ModelAndView retrieveItemPop(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8");
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		ArrayList<HashMap<String, String>> itemList = zmmService.retrieveItemBySAP(paramMap);
		
		mav.addObject("list", itemList);
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zmm/raw/item_list_pop");
		
		return mav;
	}
	
	/**
	 * 구매관리 > 원료관리 > 입항스케줄 > 업체 코드팝업
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/popup/zmm/raw/retrieveVendorPop")
	public ModelAndView retrieveVendorPop(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8");
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		ArrayList<HashMap<String, String>> vendorList = zmmService.retrieveVendorBySAP(paramMap);
		
		mav.addObject("list", vendorList);
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zmm/raw/vendor_list_pop");
		
		return mav;
	}
	
	
	/**
	 * 구매관리 > 원료관리 > 입항스케줄 조회 > 입항스케줄 등록
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/raw/createArrivalSchedule")
	public ModelAndView createArrivalSchedule(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();
		paramMap.put("emp_code",(String) session.getAttribute("empCode"));
		logger.debug("$$"+paramMap);

		Map resultMap = new HashMap();
		
		int result = zmmService.createArrivalSchedule(paramMap);
		
	
		if(result >= 2) {
			resultMap.put("result_code", result);
			resultMap.put("msg", "저장 되었습니다.");
		}else {
			resultMap.put("result_code", result);
			resultMap.put("msg", "저장중 오류가 발생하였습니다.");
		}
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 구매관리 > 원료관리 > 입항스케줄 조회 > 입항스케줄 수정
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/raw/updateArrivalSchedule")
	public ModelAndView updateArrivalSchedule(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();
		paramMap.put("emp_code",(String) session.getAttribute("empCode"));
		logger.debug("$$"+paramMap);

		Map resultMap = new HashMap();
		
		int result = zmmService.updateArrivalSchedule(paramMap);
		
	
		if(result >= 2) {
			resultMap.put("result_code", result);
			resultMap.put("msg", "수정 되었습니다.");
		}else { 
			resultMap.put("result_code", result);
			resultMap.put("msg", "수정중 오류가 발생하였습니다.");
		}
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 구매관리 > 원료관리 > 입항스케줄 조회 > 입항스케줄 삭제
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/raw/deleteArrivalSchedule")
	public ModelAndView deleteArrivalSchedule(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();
		paramMap.put("emp_code",(String) session.getAttribute("empCode"));
		logger.debug("$$"+paramMap);

		Map resultMap = new HashMap();
		
		int result = zmmService.deleteArrivalSchedule(paramMap);
		
	
		if(result >= 2) {
			resultMap.put("result_code", result);
			resultMap.put("msg", "삭제 되었습니다.");
		}else { 
			resultMap.put("result_code", result);
			resultMap.put("msg", "삭제중 오류가 발생하였습니다.");
		}
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 구매관리 > 원료관리 > 입항스케줄 조회 > Typical Assay, Invoice Assay 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/raw/AssayList")
	public ModelAndView AssayList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();
		paramMap.put("emp_code",(String) session.getAttribute("empCode"));
		logger.debug("$$"+paramMap);

		ArrayList<HashMap<String, String>> list = zmmService.AssayList(paramMap);
		Map resultMap = new HashMap();
		resultMap.put("list", list);
		resultMap.put("req_data", paramMap);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 구매관리 > 원료관리 > 입항스케줄 조회 > Typical Assay 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/raw/createTypicalAssay")
	public ModelAndView createtypicalAssay(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();
		paramMap.put("emp_code",(String) session.getAttribute("empCode"));
		logger.debug("$$"+paramMap);

		Map resultMap = new HashMap();
		
		int result = zmmService.createTypicalAssay(paramMap);
		
	
		if(result >= 1) {
			resultMap.put("result_code", result);
			resultMap.put("msg", "저장 되었습니다.");
		}else { 
			resultMap.put("result_code", result);
			resultMap.put("msg", "저장중 오류가 발생하였습니다.");
		}
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 구매관리 > 원료관리 > 입항스케줄 조회 > Invoice Assay 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zmm/raw/createInvoiceAssay")
	public ModelAndView createInvoiceAssay(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();
		paramMap.put("emp_code",(String) session.getAttribute("empCode"));
		logger.debug("$$"+paramMap);

		Map resultMap = new HashMap();
		
		int result = zmmService.createInvoiceAssay(paramMap);
		
	
		if(result >= 1) {
			resultMap.put("result_code", result);
			resultMap.put("msg", "저장 되었습니다.");
		}else { 
			resultMap.put("result_code", result);
			resultMap.put("msg", "저장중 오류가 발생하였습니다.");
		}
		
		return new ModelAndView("DataToJson", resultMap);
	}
}
