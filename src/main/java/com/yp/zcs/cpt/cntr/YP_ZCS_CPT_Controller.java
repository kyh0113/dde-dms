package com.yp.zcs.cpt.cntr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import com.vicurus.it.core.common.Pagination;
import com.vicurus.it.core.common.Util;
import com.yp.login.srvc.intf.YPLoginService;
import com.yp.zcs.cpt.srvc.intf.YP_ZCS_CPT_Service;
import com.yp.zcs.ipt.srvc.intf.YP_ZCS_IPT_Service;

@Controller
public class YP_ZCS_CPT_Controller {

	@Autowired
	private YP_ZCS_CPT_Service zcs_cpt_Service;
	
	@Autowired
	private YPLoginService lService;
	
	@Value("#{config['session.outTime']}")
	private int sessionoutTime;
	
	@Value("#{config['sys.action_log']}")
	private String action_log;

	private static final Logger logger = LoggerFactory.getLogger(YP_ZCS_CPT_Controller.class);
	
	/**
	 * 공사용역 > 검수보고서 > 검수보고서 등록(공수) > 작업내역
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/cpt/select_zcs_cpt_manh_create3", method = RequestMethod.POST)
	public ModelAndView select_zcs_cpt_manh_create3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】공사용역 > 검수보고서 > 검수보고서 등록(공수) > 작업내역");
		HashMap resultMap = new HashMap();
		HashMap data = new HashMap();
		data = zcs_cpt_Service.select_zcs_cpt_manh_create3(request, response);
		resultMap.put("list1", data.get("list1"));
		resultMap.put("list2", data.get("map2"));
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/********************************* (공수) 시작      ***********************************************/
	/**
	 * 공사용역 > 검수보고서 > 검수보고서(공수)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/cpt/zcs_cpt_manh_create", method = RequestMethod.POST)
	public ModelAndView zcs_cpt_manh_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		//보고서 코드 추가
		mav.addObject("REPORT_CODE", paramMap.get("REPORT_CODE"));
		
		mav.setViewName("/yp/zcs/cpt/zcs_cpt_manh_create");
		return mav;
	}
	
	/**
	 * 공사용역 > 검수보고서 > 검수보고서(공수) > 조회(검수보고서, 작업내역) *** 거래처, 계약코드, 월보년월로 데이터 가져오기
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/cpt/select_zcs_cpt_manh_create", method = RequestMethod.POST)
	public ModelAndView select_zcs_cpt_manh_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		
		resultMap.put("inspection_manh_list1", zcs_cpt_Service.select_inspection_manh_list1(request, response));
		resultMap.put("inspection_manh_list2", zcs_cpt_Service.select_inspection_manh_list2(request, response));
		resultMap.put("section_dt", zcs_cpt_Service.select_monthly_rpt1_section_dt(request, response));
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 공사용역 > 검수보고서 > 검수보고서(공수) > 조회(검수보고서, 작업내역) *** 보고서코드로 데이터 가져오기
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/cpt/select_zcs_cpt_manh_create2", method = RequestMethod.POST)
	public ModelAndView select_zcs_cpt_manh_create2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		
		resultMap.put("inspection_manh_list2", zcs_cpt_Service.select_inspection_manh_list2_using_report_code(request, response));
		resultMap.put("construction_chk_rpt", zcs_cpt_Service.select_construction_chk_rpt(request, response));
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 공사용역 > 검수보고서 > 검수보고서(공수) > 조회(작업현황) *** 거래처, 계약코드, 월보년월로 데이터 가져오기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zcs/cpt/select_work_status_manh")
	public ModelAndView select_work_status_manh(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HashMap resultMap = new HashMap();
		
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		list = zcs_cpt_Service.select_work_status_list_manh(request, response);
		//logger.debug("[TEST]list:{}",list);
		
		//날짜별 합계 구하기
		int size = list.size();
		HashMap<String, Object> sumByDateMap = new HashMap<String, Object>();
		for(int i=0; i<size; i++) {
			Map tempMap = list.get(i);
			Iterator<String> keys = tempMap.keySet().iterator();
			while ( keys.hasNext() ) {
			    String key = keys.next();
			    
			    //컬럼 key가 숫자(날짜를 의미)일때
			    if(Util.isStringDouble(key)) {
			    	//값이 있을 때
			    	if(tempMap.get(key) != null && Util.isStringDouble(tempMap.get(key).toString())) {
				    	double befor_value = (sumByDateMap.get(key) == null)?0: Double.parseDouble(sumByDateMap.get(key).toString());
				    	double value = Double.parseDouble(tempMap.get(key).toString());
				    	sumByDateMap.put(key, value+befor_value);
			    	//값이 없을 때
				    }else if(tempMap.get(key) == null) {
				    	double befor_value = (sumByDateMap.get(key) == null)?0: Double.parseDouble(sumByDateMap.get(key).toString());
				    	double value = 0;
				    	sumByDateMap.put(key, value+befor_value);
				    }
			    }
			    
			}   
		}
		
		//날짜별 합계 추가
		resultMap.put("sum_by_date_map", sumByDateMap);
		resultMap.put("work_status_list", list);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 공사용역 > 검수보고서 > 검수보고서(작업) > 조회(작업현황) *** 거래처, 계약코드, 월보년월로 데이터 가져오기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zcs/cpt/select_work_status_opt")
	public ModelAndView select_work_status_opt(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HashMap resultMap = new HashMap();
		
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		list = zcs_cpt_Service.select_work_status_list_opt(request, response);
		//logger.debug("[TEST]list:{}",list);
		
		//날짜별 합계 구하기
		int size = list.size();
		HashMap<String, Object> sumByDateMap = new HashMap<String, Object>();
		HashMap<String, Object> sumByDateMap2 = new HashMap<String, Object>();	//코스트센터별 소계
		ArrayList sumByCostList = new ArrayList();	//코스트센터별 소계 리스트
		String before_cost = "";		//소계를 위한 변수
		
		for(int i=0; i < size; i++) {
			Map tempMap = list.get(i);
			
			if(i == 0) before_cost = (String)tempMap.get("COST_CODE");	//최초 코스트센터코드 세팅
		    String current_cost = (String)tempMap.get("COST_CODE");		//현재 코스트센터코드 세팅

		    //코스트센터가 달라지는 시점에 소계 리스트에 Add
			if(!before_cost.equals(current_cost)) {
	    		sumByCostList.add(sumByDateMap2);
	    		sumByDateMap2 = new HashMap();	//Map 객체 생성, 안하면 Map의 마지막 값만을 참조하게됨
	    	}
			

			Iterator<String> keys = tempMap.keySet().iterator();
			while ( keys.hasNext() ) {	//while start
			    String key = keys.next();

			    //컬럼 key가 숫자(날짜를 의미)일때
			    if(Util.isStringDouble(key)) {
			    	
			    	//값이 있을 때
			    	if(tempMap.get(key) != null && Util.isStringDouble(tempMap.get(key).toString())) {
				    	double befor_value = (sumByDateMap.get(key) == null)?0: Double.parseDouble(sumByDateMap.get(key).toString());
				    	double befor_value2 = (sumByDateMap2.get(key) == null)?0: Double.parseDouble(sumByDateMap2.get(key).toString());	//소계 전용
				    	double value = Double.parseDouble(tempMap.get(key).toString());
				    	sumByDateMap.put(key, value+befor_value);

				    	if(before_cost.equals(current_cost)) {
				    		double temp = Double.sum(value, befor_value2);
				    		sumByDateMap2.put(key, temp);	//소계
				    	}else {
				    		double temp = value;
				    		sumByDateMap2.put(key, temp);	//소계
				    	}
				    	
			    	//값이 없을 때
				    }else if(tempMap.get(key) == null) {
				    	double befor_value = (sumByDateMap.get(key) == null)?0: Double.parseDouble(sumByDateMap.get(key).toString());
				    	double befor_value2 = (sumByDateMap2.get(key) == null)?0: Double.parseDouble(sumByDateMap2.get(key).toString());	//소계 전용
				    	double value = 0;
				    	sumByDateMap.put(key, value+befor_value);
				    	
				    	if(before_cost.equals(current_cost)) {
				    		double temp = Double.sum(value, befor_value2);
				    		sumByDateMap2.put(key, temp);	//소계
				    	}else {
				    		double temp = value;
				    		sumByDateMap2.put(key, temp);	//소계
				    	}
				    }
			    }
			    
			    
			}   //while end
			
			//마지막 Row 코스트센터 소계 리스트에 Add
			if(i == size-1) {
	    		sumByCostList.add(sumByDateMap2);
	    	}
	    	
			before_cost = current_cost;	//현재 코스트코드를 이전 코스트코드로 셋
			
		}

		//날짜별 합계 추가
		resultMap.put("sum_by_date_map", sumByDateMap);
		resultMap.put("work_status_list", list);
		
		//코스트센터별 소계 추가
		resultMap.put("sumByCostList", sumByCostList);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 공사용역 > 검수보고서 > 검수보고서(공수,작업) > 조회(작업현황)  *** 보고서코드로 데이터 가져오기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zcs/cpt/select_work_status2")
	public ModelAndView select_work_status2(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HashMap resultMap = new HashMap();
		
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		list = zcs_cpt_Service.select_work_status_list_using_report_code(request, response);
		
		//logger.debug("[TEST]list:{}",list);
		
		//날짜별 합계 구하기
		int size = list.size();
		HashMap<String, Object> sumByDateMap = new HashMap<String, Object>();
		HashMap<String, Object> sumByDateMap2 = new HashMap<String, Object>();	//코스트센터별 소계
		ArrayList sumByCostList = new ArrayList();	//코스트센터별 소계 리스트
		String before_cost = "";		//소계를 위한 변수
		
		for(int i=0; i<size; i++) {
			Map tempMap = list.get(i);
			
			if(i == 0) before_cost = (String)tempMap.get("COST_CODE");	//최초 코스트센터코드 세팅
		    String current_cost = (String)tempMap.get("COST_CODE");		//현재 코스트센터코드 세팅

		    //코스트센터가 달라지는 시점에 소계 리스트에 Add
			if(!before_cost.equals(current_cost)) {
	    		sumByCostList.add(sumByDateMap2);
	    		sumByDateMap2 = new HashMap();	//Map 객체 생성, 안하면 Map의 마지막 값만을 참조하게됨
	    	}
			
			Iterator<String> keys = tempMap.keySet().iterator();
			while ( keys.hasNext() ) {
			    String key = keys.next();
			    
				//컬럼 key가 숫자(날짜를 의미)일때
			    if(Util.isStringDouble(key)) {
			    	
			    	//값이 있을 때
			    	if(tempMap.get(key) != null && Util.isStringDouble(tempMap.get(key).toString())) {
				    	double befor_value = (sumByDateMap.get(key) == null)?0: Double.parseDouble(sumByDateMap.get(key).toString());
				    	double befor_value2 = (sumByDateMap2.get(key) == null)?0: Double.parseDouble(sumByDateMap2.get(key).toString());	//소계 전용
				    	double value = Double.parseDouble(tempMap.get(key).toString());
				    	sumByDateMap.put(key, value+befor_value);

				    	if(before_cost.equals(current_cost)) {
				    		double temp = Double.sum(value, befor_value2);
				    		sumByDateMap2.put(key, temp);	//소계
				    	}else {
				    		double temp = value;
				    		sumByDateMap2.put(key, temp);	//소계
				    	}
				    	
			    	//값이 없을 때
				    }else if(tempMap.get(key) == null) {
				    	double befor_value = (sumByDateMap.get(key) == null)?0: Double.parseDouble(sumByDateMap.get(key).toString());
				    	double befor_value2 = (sumByDateMap2.get(key) == null)?0: Double.parseDouble(sumByDateMap2.get(key).toString());	//소계 전용
				    	double value = 0;
				    	sumByDateMap.put(key, value+befor_value);
				    	
				    	if(before_cost.equals(current_cost)) {
				    		double temp = Double.sum(value, befor_value2);
				    		sumByDateMap2.put(key, temp);	//소계
				    	}else {
				    		double temp = value;
				    		sumByDateMap2.put(key, temp);	//소계
				    	}
				    }
			    }
			    
			}   
			
			//마지막 Row 코스트센터 소계 리스트에 Add
			if(i == size-1) {
	    		sumByCostList.add(sumByDateMap2);
	    	}
	    	
			before_cost = current_cost;	//현재 코스트코드를 이전 코스트코드로 셋
			
		}
		
		//날짜별 합계 추가
		resultMap.put("sum_by_date_map", sumByDateMap);
		resultMap.put("work_status_list", list);
		

		//코스트센터별 소계 추가
		resultMap.put("sumByCostList", sumByCostList);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	
	/**
	 * 공사용역 > 검수보고서 > 검수보고서(공수) > 저장 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/cpt/zcs_cpt_manh_create_save", method = RequestMethod.POST)
	public ModelAndView zcs_cpt_manh_create_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = zcs_cpt_Service.zcs_cpt_manh_save(request, response);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 공사용역 > 검수보고서 > 검수보고서 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/cpt/zcs_cpt_read", method = RequestMethod.POST)
	public ModelAndView zcs_cpt_read(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		List pay_code_list = zcs_cpt_Service.select_pay_code_list(request, response);
		mav.addObject("pay_code_list", pay_code_list);
		
		mav.setViewName("/yp/zcs/cpt/zcs_cpt_read");
		return mav;
	}
	
	/**
	 *  정비용역 > 검수보고서 > 검수보고서 조회 > 보고서코드 조회
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zcs/cpt/retrieveReportName")
	public ModelAndView retrieveReportName(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));

		if (paramMap.get("search_type") != null) {
			ArrayList<HashMap<String, String>> list = zcs_cpt_Service.retrieveReportName(request, response);
			int totCnt = list.size();

			Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
			mav.addObject("pagination", pagination);

			paramMap.put("firstRecordIndex", pagination.getStartIndex());
			paramMap.put("lastRecordIndex", pagination.getEndIndex());

			ArrayList<HashMap<String, String>> pagingList = util.pagingListOfERPList(list, pagination.getStartIndex(), pagination.getEndIndex());
			//logger.debug("{}", pagingList);
			mav.addObject("list", pagingList);
		}
		paramMap.put("type", paramMap.get("type"));
		paramMap.put("target", paramMap.get("target"));
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zcs/cpt/search_report_name_pop");
		return mav;
	}
	
	/**
	 * 정비용역 > 검수보고서 > 검수보고서 조회 > 삭제
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zcs/cpt/zcs_cpt_rpt_delete", method = RequestMethod.POST)
	public ModelAndView zcs_cpt_rpt_delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		int result = zcs_cpt_Service.zcs_cpt_rpt_delete(request, response);
		
		resultMap.put("result",result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 *  공사용역 > 계약관리 > 계약등록 > 조회
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value="/yp/zcs/cpt/zcs_cpt_manh_create_select", method = RequestMethod.POST)
	public ModelAndView zcs_ctr_manh_create_select(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		
		List contstruction_report_list = zcs_cpt_Service.select_construction_chk_rpt(request, response);
		
		resultMap.put("contstruction_report_list",contstruction_report_list);
			
		return new ModelAndView("DataToJson", resultMap);
	}
	/********************************* (공수) 끝      ***********************************************/
	
	
	
	/********************************* (작업) 시작      ***********************************************/
	/**
	 * 공사용역 > 검수보고서 > 검수보고서(공수)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/cpt/zcs_cpt_opt_create", method = RequestMethod.POST)
	public ModelAndView zcs_cpt_opt_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		//보고서 코드 추가
		mav.addObject("REPORT_CODE", paramMap.get("REPORT_CODE"));
		
		mav.setViewName("/yp/zcs/cpt/zcs_cpt_opt_create");
		return mav;
	}
	
	/**
	 * 공사용역 > 검수보고서 > 검수보고서(공수) > 조회(검수보고서, 작업내역) *** 거래처, 계약코드, 월보년월로 데이터 가져오기
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/cpt/select_zcs_cpt_opt_create", method = RequestMethod.POST)
	public ModelAndView select_zcs_cpt_opt_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		
		resultMap.put("inspection_opt_list1", zcs_cpt_Service.select_inspection_opt_list1(request, response));
		resultMap.put("inspection_opt_list2", zcs_cpt_Service.select_inspection_opt_list2(request, response));
		resultMap.put("section_dt", zcs_cpt_Service.select_monthly_rpt2_section_dt(request, response));
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 공사용역 > 검수보고서 > 검수보고서(공수) > 조회(검수보고서, 작업내역) *** 보고서코드로 데이터 가져오기
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/cpt/select_zcs_cpt_opt_create2", method = RequestMethod.POST)
	public ModelAndView select_zcs_cpt_opt_create2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		
		resultMap.put("inspection_opt_list2", zcs_cpt_Service.select_inspection_opt_list2_using_report_code(request, response));
		resultMap.put("construction_chk_rpt", zcs_cpt_Service.select_construction_chk_rpt(request, response));
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 공사용역 > 검수보고서 > 검수보고서(공수) > 저장 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/cpt/zcs_cpt_opt_create_save", method = RequestMethod.POST)
	public ModelAndView zcs_cpt_opt_create_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = zcs_cpt_Service.zcs_cpt_opt_save(request, response);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 *  공사용역 > 계약관리 > 계약등록 > 조회
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/yp/zcs/cpt/zcs_cpt_opt_create_select", method = RequestMethod.POST)
	public ModelAndView zcs_cpt_opt_create_select(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		
		List contstruction_report_list = zcs_cpt_Service.select_construction_chk_rpt(request, response);
		
		resultMap.put("contstruction_report_list",contstruction_report_list);
			
		return new ModelAndView("DataToJson", resultMap);
	}
	/********************************* (작업) 끝      ***********************************************/
	
	
	
	
	/* 검수보고서(월정액) 시작*/
	/**
	 * 공사용역 > 용영검수 > 검수보고서(월정액)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/cpt/zcs_cpt_mon_create", method = RequestMethod.POST)
	public ModelAndView zcs_cpt_mon_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		//보고서 코드 추가
		mav.addObject("REPORT_CODE", paramMap.get("REPORT_CODE"));
		
		mav.setViewName("/yp/zcs/cpt/zcs_cpt_mon_create");
		return mav;
	}
	
	/**
	 * 공사용역 > 용영검수 > 검수보고서(월정액) > 조회(검수보고서)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/cpt/select_zcs_cpt_mon_create", method = RequestMethod.POST)
	public ModelAndView select_zcs_cpt_mon_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		
		resultMap.put("inspection_mon_list1", zcs_cpt_Service.select_inspection_mon_list1(request, response));
		resultMap.put("inspection_mon_list2", zcs_cpt_Service.select_inspection_mon_list2(request, response));
		resultMap.put("section_dt", zcs_cpt_Service.select_monthly_rpt3_section_dt(request, response));
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 공사용역 > 용영검수 > 검수보고서(월정액) > 조회(검수보고서)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/cpt/select_zcs_cpt_mon_create2", method = RequestMethod.POST)
	public ModelAndView select_zcs_cpt_mon_create2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		
		resultMap.put("inspection_mon_list2", zcs_cpt_Service.select_inspection_mon_list2_using_report_code(request, response));
		resultMap.put("construction_chk_rpt", zcs_cpt_Service.select_construction_chk_rpt(request, response));
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 공사용역 > 검수보고서 > 검수보고서(월정액) > 저장 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/cpt/zcs_cpt_mon_create_save", method = RequestMethod.POST)
	public ModelAndView zcs_cpt_mon_create_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = zcs_cpt_Service.zcs_cpt_mon_save(request, response);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 *  공사용역 > 계약관리 > 계약등록 > 조회
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/yp/zcs/cpt/zcs_cpt_mon_create_select", method = RequestMethod.POST)
	public ModelAndView zcs_cpt_mon_create_select(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		
		List contstruction_report_list = zcs_cpt_Service.select_construction_chk_rpt(request, response);
		
		resultMap.put("contstruction_report_list",contstruction_report_list);
			
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 공사용역 > 검수보고서 > 검수보고서(공수) 상세보기 > 그룹웨어 통한 로그인
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping("/yp/zcs/cpt/zcs_cpt_view")
	public ModelAndView zcs_cpt_view(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【그룹웨어 화면호출】공사용역 > 검수보고서 > 검수보고서 상세보기 ");
		String page = "";
		try{
			String userid = (String) request.getParameter("userid");
			String referer = (String)request.getHeader("referer") == null ? "" : (String)request.getHeader("referer");
			
			boolean loginCheck = (referer.contains("ypgw.ypzinc.co.kr") || referer.contains("gwdev.ypzinc.co.kr"));
			logger.debug("gwlogin - "+referer);
			
			if (loginCheck) {
				
				HttpSession session = request.getSession(false);
				if (session != null) {
					session.invalidate(); // 초기화
				}
				session = request.getSession(true);
				
				// 20200416_khj sessionOut시 Action log 남기기 위한 필드
				session.setAttribute("s_action_log", action_log);
				logger.debug("sessionoutTime - {}", sessionoutTime);
				session.setMaxInactiveInterval(60 * sessionoutTime); // 세션 유지시간(config의 세션타임아웃 참조)
				
				// userInfoSet(req_data, request, response);
				HashMap map = lService.retrieveUserInfo(userid);
				logger.debug("map : " + map);
				ArrayList<HashMap> auth_map = lService.retrieveUserAuth((String) map.get("EMP_CD"));
				ArrayList<HashMap> s_authogrp_code = lService.retrieveUserSysAuth((String) map.get("EMP_CD"));
//					logger.debug("auth_map : " + auth_map);

				session.setAttribute("empCode", map.get("EMP_CD"));
				session.setAttribute("s_emp_code", map.get("EMP_CD"));
				session.setAttribute("userId", map.get("USER_ID"));
				session.setAttribute("userName", map.get("USER_NAME"));
				session.setAttribute("gubun", map.get("GUBUN"));

				logger.debug("auth_map - {}", auth_map);
				// 2020-08-19 jamerl - 데이조범위 권한이 없으면 일반으로 설정
//				if (auth_map.size() == 0) {
//					session.setAttribute("auth", "US");
//				} else {
//					session.setAttribute("auth", auth_map.get(0).get("DATA_AUTH_ID"));
//				}
				if (auth_map.size() > 0) {
					//2020-11-17 jjd - 데이터권한 변경
					for(HashMap auth : auth_map){
						String menu = (String) auth.get("MENU_CODE");
						String auth_id = (String) auth.get("DATA_AUTH_ID");
						session.setAttribute(menu+"_AUTH", auth_id);
					}
				}

				logger.debug("s_authogrp_code - {}", s_authogrp_code);
				// 2020-08-19 jamerl - 데이조범위 권한이 없으면 일반으로 설정
				if (s_authogrp_code.size() == 0) {
					session.setAttribute("s_authogrp_code", "US");
				} else {
					session.setAttribute("s_authogrp_code", s_authogrp_code.get(0).get("AUTH_ID"));
				}

				if ("user".equals(map.get("GUBUN"))) {
					HashMap userPos = lService.retrieveUserPosition(userid);
					session.setAttribute("userDeptCd", userPos.get("DEPT_CD"));
					session.setAttribute("userDept", userPos.get("DEPT_NAME"));
					session.setAttribute("userPosCd", userPos.get("POS_CD"));
					session.setAttribute("userPos", userPos.get("POS_NAME"));
					session.setAttribute("userOfcCd", userPos.get("OFC_CD"));
					session.setAttribute("userOfc", userPos.get("OFC_NAME"));
					session.setAttribute("corpCode", "YPZINC");
					session.setAttribute("corpName", "(주)영풍");
					logger.debug("loginCont.userDeptCd=" + session.getAttribute("userDeptCd") + " / "
							+ userPos.get("DEPT_CD"));

					// 도시락관리 추가
					HashMap workinfo = lService.retrieveWorkInfo((String) map.get("EMP_CD"));
					if (workinfo != null) {
						session.setAttribute("zclss", workinfo.get("ZCLSS"));
						session.setAttribute("zclst", workinfo.get("ZCLST"));
						session.setAttribute("schkz", workinfo.get("SCHKZ"));
						session.setAttribute("jo_name", workinfo.get("JO_NAME"));
					}
				}
				
				ModelAndView mav = new ModelAndView();
				
				String RECEIVE_REPORT_CODE = (String) request.getParameter("REPORT_CODE");
				String RECEIVE_PAY_STANDARD = (String) request.getParameter("PAY_STANDARD");
				
				// 테스트 데이터
//				mav.addObject("RECEIVE_BASE_YYYY", "2010");
//				mav.addObject("RECEIVE_VENDOR_CODE", "V1");
				
				mav.addObject("RECEIVE_REPORT_CODE", RECEIVE_REPORT_CODE);
				mav.addObject("hierarchy", "000006");
				
				if("1".equals(RECEIVE_PAY_STANDARD)) {
					logger.debug("【그룹웨어 화면호출】공사용역 > 검수보고서 > 검수보고서(공수) 상세보기 ");
					mav.addObject("DESTINATION", "ZCS_CPT_MANH_VIEW");
					mav.addObject("DESTINATION_SRC", "/yp/zcs/cpt/zcs_cpt_manh_view");
				}else if("2".equals(RECEIVE_PAY_STANDARD)) {
					logger.debug("【그룹웨어 화면호출】공사용역 > 검수보고서 > 검수보고서(작업) 상세보기 ");
					mav.addObject("DESTINATION", "ZCS_CPT_OPT_VIEW");
					mav.addObject("DESTINATION_SRC", "/yp/zcs/cpt/zcs_cpt_opt_view");
				}else if("3".equals(RECEIVE_PAY_STANDARD)) {
					logger.debug("【그룹웨어 화면호출】공사용역 > 검수보고서 > 검수보고서(월정액) 상세보기 ");
					mav.addObject("DESTINATION", "ZCS_CPT_MON_VIEW");
					mav.addObject("DESTINATION_SRC", "/yp/zcs/cpt/zcs_cpt_mon_view");
				}
				
				mav.setViewName("redirect:/yp/view");
				return mav;
			} else {
				page = "/core/error/405.do";
				RedirectView rv = new RedirectView(page);
				rv.setExposeModelAttributes(false);
				return new ModelAndView(rv);
			}
		}catch(Exception e){
			e.printStackTrace();
			page = "/core/error/405.do";
			RedirectView rv = new RedirectView(page);
			rv.setExposeModelAttributes(false);
			return new ModelAndView(rv);
		}
	}
	
	/**
	 * 공사용역 > 검수보고서 > 검수보고서(공수) 상세보기
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/cpt/zcs_cpt_manh_view", method = RequestMethod.POST)
	public ModelAndView zcs_cpt_manh_view(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		//보고서 코드 추가
		mav.addObject("REPORT_CODE", paramMap.get("RECEIVE_REPORT_CODE"));
		
		mav.setViewName("/yp/zcs/cpt/zcs_cpt_manh_view");
		return mav;
	}
}
