package com.yp.zwc.ipt.cntr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.vicurus.it.core.common.Util;
import com.yp.login.srvc.intf.YPLoginService;
import com.yp.util.DateUtil;
import com.yp.zwc.ctr.srvc.intf.YP_ZWC_CTR_Service;
import com.yp.zwc.ipt.srvc.intf.YP_ZWC_IPT_Service;

@Controller
public class YP_ZWC_IPT_Controller {

	@Autowired
	private YP_ZWC_IPT_Service zwcService;

	@Autowired
	private YP_ZWC_CTR_Service zwc_ctr_Service;
	
	@Autowired
	private YPLoginService lService;
	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_IPT_Controller.class);
	
	/**
	 * 계획대비실적
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zwc/ipt/zwc_ipt_performance", method = RequestMethod.POST)
	public ModelAndView zwc_ipt_performance(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】계획대비실적");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		HttpSession session = request.getSession();
		
		mav.addObject("auth", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH"));
		
		// 2020-08-25 jamerl -	화면 최초 로드시 소속 부서, 반, 근무조 조회
		List<HashMap> result = zwc_ctr_Service.select_emp_work_dept(request, response);
		logger.debug("result = {}", result);
		
		HashMap<String, Object> dept_param = new HashMap<String, Object>();
		if(result.size() > 0) {
			// 2020-08-20 jamerl - 권한, 소속 부서, 반, 조의 정보가 반드시 필요
			dept_param.put("s_authogrp_code", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH"));
			dept_param.put("orgeh", result.get(0).get("ORGEH"));
			dept_param.put("zclss", result.get(0).get("ZCLSS"));
			dept_param.put("schkz", result.get(0).get("SCHKZ"));
			dept_param.put("emp_code",(String) session.getAttribute("empCode"));
			logger.debug("orgeh", result.get(0).get("ORGEH"));
			mav.addObject("orgeh", result.get(0).get("ORGEH"));
			mav.addObject("zclss", result.get(0).get("ZCLSS"));
			mav.addObject("schkz", result.get(0).get("SCHKZ"));
			
			List teamList = zwc_ctr_Service.select_team_list(dept_param);
			mav.addObject("teamList", teamList);
		}else {
			// 2020-11-23 jamerl - 협력사는 부서정보가 없음. 혹시 협력사가 부서정보가 있는 화면을 쓰게되면 아래 로직을 구현해야 함.
			// 현재는 그런 화면 없음
			// 화면 출력에서 에러는 발생되지 않지만 실제 데이터는 조회되지 않도록 조회조건값을 부서코드가 아닌 값으로 임시조치
			mav.addObject("orgeh", "부서정보없음");
			mav.addObject("teamList", new ArrayList());
		}
		
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		mav.addObject("cb_working_master_v", zwcService.select_cb_working_master_v(req_data));
		mav.setViewName("/yp/zwc/ipt/zwc_ipt_performance");
		
		return mav;
	}
	
	/**
	 * 계획대비실적 > 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/ipt/select_zwc_ipt_performance", method = RequestMethod.POST)
	public ModelAndView select_zwc_ipt_performance(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】조업도급 > 비용처리 > 계획대비실적");
		HashMap resultMap = new HashMap();
		
		resultMap.put("list", zwcService.select_zwc_ipt_performance(request, response));
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value = "/yp/xls/zwc/ipt/select_zwc_ipt_performance", method = RequestMethod.POST)
	public ModelAndView xls_select_zwc_ipt_performance(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【엑셀다운로드】조업도급 > 비용처리 > 계획대비실적");
		ModelAndView mav = new ModelAndView();
		
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		list = (ArrayList<HashMap<String, String>>) zwcService.select_zwc_ipt_performance(request, response);

		mav.addObject("alllist", list);

		mav.setViewName("/yp/zwc/ipt/xls/zwc_ipt_performance");
		return mav;
	}
	
	/**
	 * 일보등록 모니터링 현황
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zwc/ipt/zwc_ipt_monitor", method = RequestMethod.POST)
	public ModelAndView zwc_ipt_monitor(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】일보등록 모니터링 현황");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		HttpSession session = request.getSession();
		
		mav.addObject("auth", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH"));
		
		// 2020-08-25 jamerl -	화면 최초 로드시 소속 부서, 반, 근무조 조회
		List<HashMap> result = zwc_ctr_Service.select_emp_work_dept(request, response);
		logger.debug("result = {}", result);
		
		HashMap<String, Object> dept_param = new HashMap<String, Object>();
		if(result.size() > 0) {
			// 2020-08-20 jamerl - 권한, 소속 부서, 반, 조의 정보가 반드시 필요
			dept_param.put("s_authogrp_code", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH"));
			dept_param.put("orgeh", result.get(0).get("ORGEH"));
			dept_param.put("zclss", result.get(0).get("ZCLSS"));
			dept_param.put("schkz", result.get(0).get("SCHKZ"));
			dept_param.put("emp_code",(String) session.getAttribute("empCode"));
			logger.debug("orgeh", result.get(0).get("ORGEH"));
			mav.addObject("orgeh", result.get(0).get("ORGEH"));
			mav.addObject("zclss", result.get(0).get("ZCLSS"));
			mav.addObject("schkz", result.get(0).get("SCHKZ"));
			
			List teamList = zwc_ctr_Service.select_team_list(dept_param);
			mav.addObject("teamList", teamList);
		}else {
			// 2020-11-23 jamerl - 협력사는 부서정보가 없음. 혹시 협력사가 부서정보가 있는 화면을 쓰게되면 아래 로직을 구현해야 함.
			// 현재는 그런 화면 없음
			// 화면 출력에서 에러는 발생되지 않지만 실제 데이터는 조회되지 않도록 조회조건값을 부서코드가 아닌 값으로 임시조치
			mav.addObject("orgeh", "부서정보없음");
			mav.addObject("teamList", new ArrayList());
		}
		mav.setViewName("/yp/zwc/ipt/zwc_ipt_monitor");
		
		return mav;
	}

	/**
	 * 조업도급 > 도급검수 > 도급비 집계처리
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zwc/ipt/zwc_ipt_sum_create", method = RequestMethod.POST)
	public ModelAndView zwc_ipt_sum_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】조업도급 > 도급검수 > 도급비 집계처리");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		// session attr to param
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", ((String) session.getAttribute("userName")));
		paramMap.put("dept_cd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("dept_name", ((String) session.getAttribute("userDept")));
		paramMap.put("zclss", ((String) session.getAttribute("zclss")));
		paramMap.put("zclst", ((String) session.getAttribute("zclst")));
		paramMap.put("schkz", ((String) session.getAttribute("schkz")));
		paramMap.put("jo_name", ((String) session.getAttribute("jo_name")));
		paramMap.put("auth", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH"));

		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");

		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zwc/ipt/zwc_ipt_sum_create");

		return mav;
	}
	
	/**
	 * 조업도급 > 도급검수 > 도급비집계 조회 > 전자결재 가능여부 확인(모든 도급월보 결재완료 되었는지 확인)
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt/zwc_ipt_sum_list_check_a")
	public ModelAndView zwc_ipt_sum_list_check_a(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【전자결재 가능여부 확인】조업도급 > 도급검수 > 도급비집계 조회 > 전자결재 가능여부 확인(모든 도급월보 결재완료 되었는지 확인)");
		HashMap resultMap = new HashMap();
		
		String result = zwcService.zwc_ipt_sum_list_check_a(request, response);
		logger.debug("【전자결재 가능여부 확인 결과】 - 【{}】", result);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 도급검수 > 도급비집계 조회 > 전자결재 가능여부 확인(도급비집계 전자결재 상태 확인)
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt/zwc_ipt_sum_list_check_b")
	public ModelAndView zwc_ipt_sum_list_check_b(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【전자결재 가능여부 확인】조업도급 > 도급검수 > 도급비집계 조회 > 전자결재 가능여부 확인(도급비집계 전자결재 상태 확인)");
		HashMap resultMap = new HashMap();
		
		String result = zwcService.zwc_ipt_sum_list_check_b(request, response);
		logger.debug("【전자결재 가능여부 확인 결과】 - 【{}】", result);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 도급검수 > 도급비 집계처리 실행
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt/zwc_ipt_sum_create_exec")
	public ModelAndView zwc_ipt_sum_create_exec(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【집계처리 실행】조업도급 > 도급검수 > 도급비 집계처리 실행");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap resultMap = new HashMap();
		
		int result = zwcService.zwc_ipt_sum_create_exec(req_data);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 도급검수 > 도급집계표 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zwc/ipt/zwc_ipt_sum_list", method = RequestMethod.POST)
	public ModelAndView zwc_ipt_sum_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		// session attr to param
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", ((String) session.getAttribute("userName")));
		paramMap.put("dept_cd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("dept_name", ((String) session.getAttribute("userDept")));
		paramMap.put("zclss", ((String) session.getAttribute("zclss")));
		paramMap.put("zclst", ((String) session.getAttribute("zclst")));
		paramMap.put("schkz", ((String) session.getAttribute("schkz")));
		paramMap.put("jo_name", ((String) session.getAttribute("jo_name")));
		paramMap.put("auth", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH"));

		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");

		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zwc/ipt/zwc_ipt_sum_list");

		return mav;
	}
	
	/**
	 * 조업도급 > 도급검수 > 도급비 집계 상세조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value = "/yp/zwc/ipt/zwc_ipt_sum_list_dt", method = RequestMethod.POST)
	public ModelAndView zwc_ipt_sum_list_dt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】조업도급 > 도급검수 > 도급비 집계 상세조회");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		mav.addObject("cb_working_master_v", zwcService.select_cb_working_master_v(req_data));
		mav.setViewName("/yp/zwc/ipt/zwc_ipt_sum_list_dt");
		
		return mav;
	}
	
	/**
	 * 조업도급 > 도급검수 > 도급집계표 조회 > 엑셀 다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/yp/xls/zwc/ipt/zwc_ipt_sum_list", method = RequestMethod.POST)
	public ModelAndView xls_zwc_ipt_sum_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		List<HashMap<String, String>> list = zwcService.select_zwc_ipt_list_report(request, response);

		mav.addObject("alllist", list);
		mav.addObject("GUBUN_CODE", req_data.get("GUBUN_CODE"));

		mav.setViewName("/yp/zwc/ipt/xls/zwc_ipt_sum_list");
		return mav;
	}
	
	/**
	 * 조업도급 > 도급검수 > 도급집계표 조회 > 팝업(상세 조회)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/popup/zwc/ipt/zwc_ipt_detail_list")
	public ModelAndView zwc_ipt_detail_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		mav.addObject("CHECK_YYYYMM", paramMap.get("CHECK_YYYYMM"));
		mav.addObject("VENDOR_CODE", paramMap.get("VENDOR_CODE"));
		mav.addObject("GUBUN_CODE", paramMap.get("GUBUN_CODE"));
		mav.addObject("VENDOR_NAME", paramMap.get("VENDOR_NAME"));
		
		List list = zwcService.select_zwc_ipt_detail_list(request, response);
		
		mav.addObject("detail_list", list);
		
		mav.setViewName("/yp/zwc/ipt/zwc_ipt_sum_detail_pop");
		return mav;
	}

	/**
	 * 조업도급 > 도급검수 > 도급비 집계 조회 > 도급비청구서
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping("/yp/popup/zwc/ipt/zwc_ipt_contract_bill")
	public ModelAndView zwc_ipt_contract_bill(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【팝업 - 도급비청구서】조업도급 > 도급검수 > 도급비 집계 조회 ");
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = zwcService.zwc_ipt_contract_bill(request, response);
		
		mav.addObject("BASE_YYYY", req_data.get("BASE_YYYY"));
		mav.addObject("VENDOR_NAME", req_data.get("VENDOR_NAME"));
		mav.addObject("REPRESENTATIVE", zwcService.zwc_ipt_contract_bill_representative(request, response));
		mav.addObject("list", result);
		
//		List<HashMap<String, Object>> resultAll = new ArrayList<HashMap<String,Object>>();
//		resultAll.addAll(result);
//		resultAll.addAll(result);
//		resultAll.addAll(result);
//		resultAll.addAll(result);
//		resultAll.addAll(result);
//		resultAll.addAll(result);
//		resultAll.addAll(result);
//		resultAll.addAll(result);
//		resultAll.addAll(result);
//		resultAll.addAll(result);
//		resultAll.addAll(result);
//		mav.addObject("list", resultAll);
		mav.setViewName("/yp/zwc/ipt/zwc_ipt_contract_bill");
		
		return mav;
	}
	
	/**
	 * 조업도급 > 도급검수 > 도급비 집계 조회 > 전표생성
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/popup/zwc/ipt/zwc_ipt_doc_create")
	public ModelAndView zwc_ipt_doc_create(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【팝업 - 전표생성】조업도급 > 도급검수 > 도급비 집계 조회 ");
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		mav.addObject("GUBUN_CODE", req_data.get("GUBUN_CODE_AGGREGATION"));	//0:저장품,1:저장품 외
		mav.addObject("BASE_YYYY", req_data.get("BASE_YYYY"));					//검수년월
		mav.addObject("GJAHR", req_data.get("BASE_YYYY").toString().substring(0, 4));	//회계연도
		mav.addObject("VENDOR_CODE", req_data.get("VENDOR_CODE"));				//벤더코드
		mav.addObject("VENDOR_NAME", req_data.get("VENDOR_NAME"));				//벤더명
		mav.addObject("SAP_CODE", req_data.get("SAP_CODE"));					//업체 SAP코드
		mav.addObject("HKONT", req_data.get("HKONT"));							//총계정원장계정 - 저장품:43307115, 저장품외:43204101
		mav.addObject("TOTAL", req_data.get("TOTAL"));							//도급비 집계표 합계(총지급금액)
		mav.addObject("VAT", req_data.get("VAT"));								//부가세
		mav.addObject("SUB_TOTAL", req_data.get("SUB_TOTAL"));					//공급가액
		
		List<HashMap<String, Object>> result = zwcService.zwc_ipt_doc_create_dt_list(request, response);	//전표생성 저장할 상세목록 가져오기

		JSONArray jArray = new JSONArray();
		for (int i = 0; i < result.size(); i++) {
			JSONObject data= new JSONObject();
			data.put("BSCHL", "40");											//전기키
			if("0".equals(result.get(i).get("GUBUN_CODE"))) data.put("HKONT", "43307115");	//총계정원장계정(저장품)
			else data.put("HKONT", "43204101");												//총계정원장계정(저장품외)
			data.put("ZKOSTL", "230104");										//집행부서
			data.put("KOSTL", result.get(i).get("COST_CODE"));					//코스트센터
			data.put("CHECK_YYYYMM", result.get(i).get("CHECK_YYYYMM"));		//검수년월
			data.put("BASE_YYYY", result.get(i).get("BASE_YYYY"));				//기준년도
			data.put("VENDOR_CODE", result.get(i).get("VENDOR_CODE"));			//벤더코드
			data.put("CONTRACT_CODE", result.get(i).get("CONTRACT_CODE"));		//계약코드
			//20201117_khj 도급비상세조회의 월도급비 사용하면 안되고 월보의 지급액을 사용해야 된다고 함
			//data.put("WRBTR", result.get(i).get("ADJUST_SUBCONTRACTING_COST"));	//전표통화금액 : 도급비상세조회의 월도급비
			data.put("WRBTR", result.get(i).get("SUB_TOTAL"));					//전표통화금액 : 월보등록의 지급액
			data.put("SGTXT", result.get(i).get("CONTRACT_NAME"));				//품목텍스트 : 거래처별 계약명(도급비 집계 상세조회)
			data.put("MENGE", result.get(i).get("MENINS").toString());			//수량 : 인력계약(1) - 도급월보의 월기준량, 물량계약(2) - 도급월보의 실적물량(집계), 저장품(3)
			data.put("MEINS", result.get(i).get("UNIT_NAME"));					//기본단위 : 도급계약의 단위
			jArray.add(i, data);
		}
		
		/*
		//20201103_khj 상세데이터 마지막에 부가세 데이터 추가삽입 시작
		JSONObject data= new JSONObject();
		data.put("BSCHL", "40");											//전기키
		data.put("HKONT", "11404101");										//총계정원장계정(부가세는 하드코딩)
		data.put("ZKOSTL", "");												//집행부서(해당없음)
		data.put("KOSTL", "");												//코스트센터(해당없음)
		data.put("CHECK_YYYYMM", "");										//검수년월
		data.put("BASE_YYYY", "");											//기준년도
		data.put("VENDOR_CODE", "");										//벤더코드
		data.put("CONTRACT_CODE", "");										//계약코드(해당없음)
		data.put("WRBTR", Long.parseLong(req_data.get("VAT").toString()));	//전표통화금액 : 부가세 넣기
		data.put("SGTXT", "");												//품목텍스트 : 거래처별 계약명(도급비 집계 상세조회)
		data.put("MENGE", "");												//수량(해당없음)
		data.put("MEINS", "");												//기본단위(해당없음)
		jArray.add(data);
		//20201103_khj 상세데이터 마지막에 부가세 데이터 추가삽입 끝
		*/
		mav.addObject("list", jArray);
		mav.setViewName("/yp/zwc/ipt/zwc_ipt_doc_create");
		
		return mav;
	}
	
	/**
	 * 조업도급 > 도급검수 > 도급비 집계 조회 > 전표생성 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked", "unused"})
	@RequestMapping("/yp/zwc/ipt/zwc_ipt_doc_create_save")
	public ModelAndView zwc_ipt_doc_create_save(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【팝업 - 전표생성】조업도급 > 도급검수 > 도급비 집계 조회 ");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		req_data.put("emp_code", session.getAttribute("empCode"));		//사번 담기
		
		String[] return_str = zwcService.createDocument(req_data);		//전표생성

		if(!"".equals(return_str[0])) {
			req_data.put("flag", return_str[0]);
			req_data.put("doc_no", return_str[2]);
			if("S".equals(return_str[0])) {	//전표생성 성공시
				int result = zwcService.updateDocumentNumber(req_data);		//전표생성 후 도급비테이블에 전표번호 UPDATE
			}
		}
		
		HashMap resultMap = new HashMap();
		resultMap.put("flag", return_str[0]);
		resultMap.put("msg", return_str[1]);
		resultMap.put("doc_no", return_str[2]);

		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 도급검수 > 도급일보 등록
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/ipt/zwc_ipt_daily_create", method = RequestMethod.POST)
	public ModelAndView zwc_ipt_daily_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】조업도급 > 도급검수 > 도급일보 등록");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		// 부서 세팅
		Util util = new Util();
		HashMap req_data = (HashMap)util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		
		req_data.put("emp_code",(String) session.getAttribute("empCode"));
		req_data.put("emp_name",((String) session.getAttribute("userName")));
		req_data.put("user_deptcd",((String) session.getAttribute("userDeptCd")));
		req_data.put("user_dept",((String) session.getAttribute("userDept")));
		req_data.put("ofc_name",((String) session.getAttribute("userOfc")));
		req_data.put("auth", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH"));
		
		// 2020-08-25 jamerl -	화면 최초 로드시 소속 부서, 반, 근무조 조회
		List<HashMap> result = zwc_ctr_Service.select_emp_work_dept(request, response);
		logger.debug("result = {}", result);
		
		HashMap<String, Object> dept_param = new HashMap<String, Object>();
		if(result.size() > 0) {
			// 2020-08-20 jamerl - 권한, 소속 부서, 반, 조의 정보가 반드시 필요
			dept_param.put("s_authogrp_code", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH"));
			dept_param.put("orgeh", result.get(0).get("ORGEH"));
			dept_param.put("zclss", result.get(0).get("ZCLSS"));
			dept_param.put("schkz", result.get(0).get("SCHKZ"));
			dept_param.put("emp_code",(String) session.getAttribute("empCode"));
			
			mav.addObject("orgeh", result.get(0).get("ORGEH"));
			mav.addObject("zclss", result.get(0).get("ZCLSS"));
			mav.addObject("schkz", result.get(0).get("SCHKZ"));
			
			List teamList = zwc_ctr_Service.select_team_list(dept_param);
			mav.addObject("teamList", teamList);
		}else {
			// 2020-11-23 jamerl - 협력사는 부서정보가 없음. 혹시 협력사가 부서정보가 있는 화면을 쓰게되면 아래 로직을 구현해야 함.
			// 현재는 그런 화면 없음
			// 화면 출력에서 에러는 발생되지 않지만 실제 데이터는 조회되지 않도록 조회조건값을 부서코드가 아닌 값으로 임시조치
			mav.addObject("orgeh", "부서정보없음");
			mav.addObject("teamList", new ArrayList());
		}
		
		List<HashMap<String, Object>> cb_working_master_v = zwcService.select_cb_working_master_v(req_data);
		List<HashMap<String, Object>> cb_tbl_working_subc = new ArrayList<HashMap<String,Object>>();
		if(cb_working_master_v.size() > 0) {
			//req_data.put("VENDOR_CODE", cb_working_master_v.get(0).get("CODE"));
			req_data.put("BASE_YYYY", DateUtil.getToday().substring(0, 4));
			cb_tbl_working_subc = zwcService.select_cb_tbl_working_subc(req_data);
		}
		
		mav.addObject("cb_tbl_working_subc", cb_tbl_working_subc);
		mav.addObject("cb_working_master_v", cb_working_master_v);
		
		mav.setViewName("/yp/zwc/ipt/zwc_ipt_daily_create");
		return mav;
	}
	
	/**
	 * 조업도급 > 도급검수 > 도급일보 등록 > 계약콤보 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt/select_cb_tbl_working_subc")
	public ModelAndView select_cb_tbl_working_subc(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【계약콤보 조회】조업도급 > 도급검수 > 도급일보 등록 ");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap resultMap = new HashMap();
		
		List result = zwcService.select_cb_tbl_working_subc(req_data);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 도급검수 > 도급일보 등록 > 도급일보 등록 - 마스터
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt/merge_tbl_working_daily_report")
	public ModelAndView merge_tbl_working_daily_report(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【도급일보 마스터 저장】조업도급 > 도급검수 > 도급일보 등록 ");
		HashMap resultMap = new HashMap();
		
		int result = zwcService.merge_tbl_working_daily_report(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 도급검수 > 도급일보 등록 > 도급일보 팀장확인, 취소(단건)
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt/update_tbl_working_daily_report_tlc")
	public ModelAndView update_tbl_working_daily_report_tlc(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【도급일보 마스터 저장】조업도급 > 도급검수 > 도급일보 팀장확인, 취소(단건) ");
		HashMap resultMap = new HashMap();
		
		int result = zwcService.update_tbl_working_daily_report_tlc(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 도급검수 > 도급일보 등록 > 도급일보 팀장확인(일괄)
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt/update_tbl_working_daily_report_tlc_y")
	public ModelAndView update_tbl_working_daily_report_tlc_y(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【도급일보 마스터 저장】조업도급 > 도급검수 > 도급일보 팀장확인(일괄) ");
		HashMap resultMap = new HashMap();
		
		int result = zwcService.update_tbl_working_daily_report_tlc_y(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 도급검수 > 도급일보 등록 > 도급일보 팀장취소(일괄)
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt/update_tbl_working_daily_report_tlc_n")
	public ModelAndView update_tbl_working_daily_report_tlc_n(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【도급일보 마스터 저장】조업도급 > 도급검수 > 도급일보 팀장취소(일괄) ");
		HashMap resultMap = new HashMap();
		
		int result = zwcService.update_tbl_working_daily_report_tlc_n(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 도급검수 > 도급일보 등록 > 도급일보 등록 - 상세
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt/merge_tbl_working_daily_report_dt")
	public ModelAndView merge_tbl_working_daily_report_dt(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【도급일보 상세 저장】조업도급 > 도급검수 > 도급일보 등록 ");
		HashMap resultMap = new HashMap();
		
		int result = zwcService.merge_tbl_working_daily_report_dt(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 조업도급 > 도급검수 > 도급월보 등록
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/ipt/zwc_ipt_mon_create", method = RequestMethod.POST)
	public ModelAndView zwc_ipt_mon_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】조업도급 > 도급검수 > 도급월보 등록");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		// 부서 세팅
		Util util = new Util();
		HashMap req_data = (HashMap)util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		
		req_data.put("emp_code",(String) session.getAttribute("empCode"));
		req_data.put("emp_name",((String) session.getAttribute("userName")));
		req_data.put("user_deptcd",((String) session.getAttribute("userDeptCd")));
		req_data.put("user_dept",((String) session.getAttribute("userDept")));
		req_data.put("ofc_name",((String) session.getAttribute("userOfc")));
		req_data.put("auth", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH"));
		
		// 2020-08-25 jamerl -	화면 최초 로드시 소속 부서, 반, 근무조 조회
		List<HashMap> result = zwc_ctr_Service.select_emp_work_dept(request, response);
		logger.debug("result = {}", result);
		
		HashMap<String, Object> dept_param = new HashMap<String, Object>();
		if(result.size() > 0) {
			// 2020-08-20 jamerl - 권한, 소속 부서, 반, 조의 정보가 반드시 필요
			dept_param.put("s_authogrp_code", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH"));
			dept_param.put("orgeh", result.get(0).get("ORGEH"));
			dept_param.put("zclss", result.get(0).get("ZCLSS"));
			dept_param.put("schkz", result.get(0).get("SCHKZ"));
			dept_param.put("emp_code",(String) session.getAttribute("empCode"));
			
			mav.addObject("orgeh", result.get(0).get("ORGEH"));
			mav.addObject("zclss", result.get(0).get("ZCLSS"));
			mav.addObject("schkz", result.get(0).get("SCHKZ"));
			
			List teamList = zwc_ctr_Service.select_team_list(dept_param);
			mav.addObject("teamList", teamList);
		}else {
			// 2020-11-23 jamerl - 협력사는 부서정보가 없음. 혹시 협력사가 부서정보가 있는 화면을 쓰게되면 아래 로직을 구현해야 함.
			// 현재는 그런 화면 없음
			// 화면 출력에서 에러는 발생되지 않지만 실제 데이터는 조회되지 않도록 조회조건값을 부서코드가 아닌 값으로 임시조치
			mav.addObject("orgeh", "부서정보없음");
			mav.addObject("teamList", new ArrayList());
		}
		List<HashMap<String, Object>> cb_working_master_v = zwcService.select_cb_working_master_v(req_data);
		List<HashMap<String, Object>> cb_tbl_working_subc = new ArrayList<HashMap<String,Object>>();
		if(cb_working_master_v.size() > 0) {
			req_data.put("VENDOR_CODE", cb_working_master_v.get(0).get("CODE"));
			cb_tbl_working_subc = zwcService.select_cb_tbl_working_subc(req_data);
		}
		mav.addObject("cb_tbl_working_subc", cb_tbl_working_subc);
		mav.addObject("cb_working_master_v", cb_working_master_v);
		
		mav.setViewName("/yp/zwc/ipt/zwc_ipt_mon_create");
		return mav;
	}
	
	/**
	 * 조업도급 > 소급처리 > 도급비 집계표 > 전자결재 가능여부 확인
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt/zwc_rst_summary_list_check")
	public ModelAndView zwc_rst_summary_list_check(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【전자결재 가능여부 확인】조업도급 > 소급처리 > 도급비 집계표 > 전자결재 가능여부 확인");
		HashMap resultMap = new HashMap();
		
		String result = zwcService.zwc_rst_summary_list_check(request, response);
		logger.debug("【전자결재 가능여부 확인 결과】 - 【{}】", result);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 계약갱신 > 도급계약 조정(안) > 전자결재 가능여부 확인
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt/zwc_rpt_post_intervention_check")
	public ModelAndView zwc_rpt_post_intervention_check(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【전자결재 가능여부 확인】조업도급 > 계약갱신 > 도급계약 조정(안) > 전자결재 가능여부 확인");
		HashMap resultMap = new HashMap();
		
		String result = zwcService.zwc_rpt_post_intervention_check(request, response);
		logger.debug("【전자결재 가능여부 확인 결과】 - 【{}】", result);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 도급검수 > 도급월보 등록 > 전자결재 초기화
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt/zwc_ipt_mon_create_status_reset")
	public ModelAndView zwc_ipt_mon_create_status_reset(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【전자결재 초기화】조업도급 > 도급검수 > 도급월보 등록");
		HashMap resultMap = new HashMap();
		
		int result = zwcService.zwc_ipt_mon_create_status_reset(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 비용처리 > 도급비 집계표 > 전자결재 초기화
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt/zwc_ipt_sum_list_status_reset")
	public ModelAndView zwc_ipt_sum_list_status_reset(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【전자결재 초기화】조업도급 > 비용처리 > 도급비 집계표");
		HashMap resultMap = new HashMap();
		
		int result = zwcService.zwc_ipt_sum_list_status_reset(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 도급검수 > 도급월보 등록 > 전자결재 가능여부 확인
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt/zwc_ipt_mon_create_check")
	public ModelAndView zwc_ipt_mon_create_check(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【전자결재 가능여부 확인】조업도급 > 도급검수 > 도급월보 등록 > 전자결재 가능여부 확인");
		HashMap resultMap = new HashMap();
		
		String result = zwcService.zwc_ipt_mon_create_check(request, response);
		logger.debug("【전자결재 가능여부 확인 결과】 - 【{}】", result);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 도급검수 > 도급월보 등록 > 전자결재 상태 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt/pre_select_tbl_working_monthly_report")
	public ModelAndView pre_select_tbl_working_monthly_report(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【전자결재 상태 조회】조업도급 > 도급검수 > 도급월보 등록 ");
		HashMap resultMap = new HashMap();
		
		int result = zwcService.pre_select_tbl_working_monthly_report(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 도급검수 > 도급월보 등록 > 집계
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt/insert_tbl_working_monthly_report")
	public ModelAndView insert_tbl_working_monthly_report(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【집계】조업도급 > 도급검수 > 도급월보 등록 ");
		HashMap resultMap = new HashMap();
		
		int result = zwcService.insert_tbl_working_monthly_report(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 도급검수 > 도급월보 등록 > 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt/update_tbl_working_monthly_report")
	public ModelAndView update_tbl_working_monthly_report(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【저장】조업도급 > 도급검수 > 도급월보 등록 ");
		HashMap resultMap = new HashMap();
		
		int result = zwcService.update_tbl_working_monthly_report(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
}
