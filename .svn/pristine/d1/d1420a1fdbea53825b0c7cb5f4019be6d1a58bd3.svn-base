package com.yp.zfi.bud.cntr;

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
import com.yp.common.srvc.intf.CommonService;
import com.yp.login.srvc.intf.YPLoginService;
import com.yp.zfi.bud.srvc.intf.YP_ZFI_BUD_Service;

@Controller
public class YP_ZFI_BUD_Controller {

	@Autowired
	private YP_ZFI_BUD_Service zfiService;
	@Autowired
	private YPLoginService lService;
	@SuppressWarnings("unused")
	@Autowired
	private CommonService commonService;


	private static final Logger logger = LoggerFactory.getLogger(YP_ZFI_BUD_Controller.class);

	/**
	 * 재무관리 > 예산관리 > 예산조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes","unchecked"})
	@RequestMapping(value = "/yp/zfi/bud/zfi_bud_read", method = RequestMethod.POST)
	public ModelAndView zfi_bud_read(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
		paramMap.put("auth", (String) session.getAttribute("FI_AUTH"));
		if(paramMap.get("auth") == null) paramMap.put("auth","US");
		
		
		mav.addObject("req_data", paramMap);
		
		mav.setViewName("/yp/zfi/bud/zfi_bud_read");
		
		return mav;
	}
	
	/**
	 * 재무관리 > 예산관리 > 예산조회 > 엑셀 다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/yp/xls/zfi/bud/zfi_bud_read", method = RequestMethod.POST)
	public ModelAndView xls_zfi_bud_read(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		list = zfiService.ui_select_retrieveBudgetList(request, response);

		mav.addObject("alllist", list);

		mav.setViewName("/yp/zfi/bud/xls/zfi_bud_read");
		return mav;
	}
	
	/**
	 * 재무관리 > 예산관리 > 예산조회 > 예산계정 팝업
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/popup/zfi/bud/retrieveBACT")
	@SuppressWarnings("unchecked")
	public ModelAndView retrieveBACT(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8");
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		logger.debug((String) paramMap.get("search_type"));
		if(paramMap.get("search_type") == null){
			paramMap.put("search_type", "I_BACTTXT");
			paramMap.put("search_text", "");
		}
		HttpSession session = request.getSession();
		paramMap.put("empCode", session.getAttribute("empCode"));
		
		//20200903_khj 백승지대리 요청으로 검색어 없으면 조회 안되도록
		if(!"".equals(paramMap.get("search_text")) ){
			HashMap<String, Object> result = zfiService.retrieveBACT(paramMap);
			mav.addObject("ex_param",result.get("ex_param"));
			mav.addObject("list",result.get("list"));
		};
		
		mav.addObject("req_data",paramMap);
		mav.setViewName("/yp/zfi/bud/search_bact_pop");
		
		return mav;
	}
	
	/**
	 * 재무관리 > 예산관리 > 예산조회 > 집행부서 팝업
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/popup/zfi/bud/retrieveKOSTL2")
	@SuppressWarnings("unchecked")
	public ModelAndView retrieveKOSTL2(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8");
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code",(String) session.getAttribute("empCode"));
		logger.debug("$$"+paramMap);

		logger.debug((String) paramMap.get("search_type"));
		if((String) paramMap.get("search_type") == null) paramMap.put("search_type","I_LTEXT");
		
		ArrayList<HashMap<String, String>> KOSTLList = zfiService.retrieveKOSTL(paramMap);
		mav.addObject("list",KOSTLList);
		mav.addObject("req_data",paramMap);
		mav.setViewName("/yp/zfi/bud/search_kostl_pop2");
		
		return mav;
	}
	
	/**
	 * 재무관리 > 예산관리 > 예산조회 > 예산금액 상세팝업
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping("/yp/popup/zfi/bud/retrieveDetailAmtPlan")
	public ModelAndView retrieveDetailAmtPlan(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8");
		String excel_flag = StringUtils.isEmpty(request.getParameter("excel_flag")) ? "" : request.getParameter("excel_flag");		// ""=list, "1"=exel, "2"=initial
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		logger.debug("$$"+paramMap);
		ArrayList<HashMap<String, String>> DetailAmtPlanList = zfiService.retrieveDetailAmtPlan(paramMap);
		
		mav.addObject("list",DetailAmtPlanList);
		mav.addObject("req_data",paramMap);
		
		if(excel_flag.equals("1")) {
			mav.setViewName("/yp/zfi/bud/xls/search_detail_amt_plan_pop");
		}else {
			mav.setViewName("/yp/zfi/bud/search_detail_amt_plan_pop");
		}
		
		
		return mav;
	}
	
	/**
	 * 재무관리 > 예산관리 > 예산조회 > 예산금액 상세팝업
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping("/yp/popup/zfi/bud/retrieveDetailAmtAct")
	public ModelAndView retrieveDetailAmtAct(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8");
		String excel_flag = StringUtils.isEmpty(request.getParameter("excel_flag")) ? "" : request.getParameter("excel_flag");		// ""=list, "1"=exel, "2"=initial
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		logger.debug("$$"+paramMap);
		ArrayList<HashMap<String, String>> DetailAmtACTList = zfiService.retrieveDetailAmtACT(paramMap);
	
		
		mav.addObject("list",DetailAmtACTList);
		mav.addObject("req_data",paramMap);
		
		if(excel_flag.equals("1")) {
			mav.setViewName("/yp/zfi/bud/xls/search_detail_amt_act_pop");
		}else {
			mav.setViewName("/yp/zfi/bud/search_detail_amt_act_pop");
		}
		
		
		return mav;
	}
	
	/**
	 * 재무관리 > 예산관리 > 예산조회 > 사용금액 상세팝업 > 그룹웨어 팝업
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes","unchecked"})
	@RequestMapping("/yp/popup/zfi/bud/retrieveDocumentPop")
	public void retrieveDocumentPop(HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/xml; charset=utf-8");
		JSONObject json = new JSONObject();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		logger.debug("$$"+paramMap);
		String docno = zfiService.retrieveDocumentPop(paramMap);

		json.put("docno",docno);
		json.put("bukrs","1000");//회사코드 1000고정
		json.put("belnr",(String) paramMap.get("BELNR"));
		json.put("gjahr",((String) paramMap.get("BUDAT")).substring(0, 4));
		
		PrintWriter out	= response.getWriter();
		out.print(json);
	}
	
	
	/**
	 * 재무관리 > 예산관리 > 예산신청
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes","unchecked"})
	@RequestMapping(value = "/yp/zfi/bud/zfi_bud_create", method = RequestMethod.POST)
	public ModelAndView zfi_bud_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
		paramMap.put("auth", (String) session.getAttribute("FI_AUTH"));
		if(paramMap.get("auth") == null) paramMap.put("auth","US");
		
		
		mav.addObject("req_data", paramMap);
		
		mav.setViewName("/yp/zfi/bud/zfi_bud_create");
		
		return mav;
	}
	

	/**
	 * 재무관리 > 예산관리 > 예산신청 > 집행부서 검색팝업, 조직 검색팝업
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes","unchecked"})
	@RequestMapping("/yp/popup/zfi/bud/retrieveKOSTL")
	public ModelAndView retrieveKOSTL(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8");
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code",(String) session.getAttribute("empCode"));
		logger.debug("$$"+paramMap);
		logger.debug((String) paramMap.get("search_type"));
		if(paramMap.get("search_type") != null){
			ArrayList<HashMap<String, String>> KOSTLList = zfiService.retrieveKOSTL(paramMap);
			mav.addObject("list",KOSTLList);
		}
		
		mav.addObject("req_data",paramMap);
		mav.setViewName("/yp/zfi/bud/search_kostl_pop");
		return mav;
	}
	

	/**
	 * 재무관리 > 예산관리 > 예산신청 > 전용 조건선택시
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes","unchecked"})
	@RequestMapping("/yp/zfi/bud/retrieveBudgetOnlyList")
	public ModelAndView retrieveBudgetOnlyList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		logger.debug("retrieveBudgetOnlyList***"+paramMap);
		if(paramMap.get("search_type") != null){
			paramMap.put("empCode", session.getAttribute("empCode"));
			HashMap<String, Object> result = zfiService.retrieveBudgetOnlyList(paramMap);
			mav.addObject("list",result.get("list"));
			mav.addObject("ep_flag",result.get("ep_flag"));
			mav.addObject("ep_msg",result.get("ep_msg"));
			mav.addObject("search_flag","1");
		}
		
		mav.addObject("req_data",paramMap);
		mav.setViewName("/yp/zfi/bud/budget_only");
		return mav;
	}
	
	/**
	 * 재무관리 > 예산관리 > 예산신청 > 예산계정 팝업에서 예산계정 선택시
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes","unchecked"})
	@RequestMapping("/yp/zfi/bud/retrieveAjaxBACT")
	public ModelAndView retrieveAjaxBACT(HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/xml; charset=utf-8");
		HashMap resultMap = new HashMap();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		String target = (String)request.getParameter("target");
		paramMap.put("search_type","I_BACT");
		paramMap.put("search_text", (String)request.getParameter("BACT_"+target));
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code",(String) session.getAttribute("empCode"));
		logger.debug("$$"+paramMap);

		HashMap<String, String> result = zfiService.retrieveAjaxBACT(paramMap);
		if(result.size() > 0){
			resultMap.put("AMT",result.get("E_AMT"));
			resultMap.put("TXT_50",result.get("E_TXT_50"));
		}
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 재무관리 > 예산관리 > 예산신청 > 입력창 변경시
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes","unchecked"})
	@RequestMapping("/yp/zfi/bud/retrieveAjaxKOSTL2")
	public ModelAndView retrieveAjaxKOSTL2(HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/xml; charset=utf-8");
		HashMap resultMap = new HashMap();
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		String target = (String)request.getParameter("target");
		String type = (String)request.getParameter("type");

		if(type.equals("R")) type = "RORG";
		else if(type.equals("B")) type = "BORG";
		else if(type.equals("C") || type.equals("C_B")) type = "C_BORG";
		
		logger.debug(type+"_"+target);
		paramMap.put("search_type","I_KOSTL");
		paramMap.put("search_text", (String)request.getParameter(type+"_"+target) == null ? paramMap.get(type+"_"+"S") : (String)request.getParameter(type+"_"+target));
		HttpSession session = request.getSession();
		paramMap.put("emp_code",(String) session.getAttribute("empCode"));

		logger.debug("$$"+paramMap);

		ArrayList<HashMap<String, String>> result = zfiService.retrieveKOSTL(paramMap);
		if(result.size() > 0){
			resultMap.put("KOST1",result.get(0).get("KOST1"));
			resultMap.put("VERAK",result.get(0).get("VERAK"));
		}
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 재무관리 > 예산관리 > 예산신청 > 저장(추가)
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes","unchecked"})
	@RequestMapping("/yp/zfi/bud/createBudgetToSAP")
	public ModelAndView createBudgetToSAP(HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/xml; charset=utf-8");
		HashMap resultMap = new HashMap();

		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code",(String) session.getAttribute("empCode"));
		logger.debug("$$"+paramMap);

		String[] result = zfiService.createBudgetToSAP(paramMap);
		 
		resultMap.put("result",result[0]);
		resultMap.put("msg",result[1]);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 재무관리 > 예산관리 > 예산신청 > 저장(수정)
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes","unchecked"})
	@RequestMapping("/yp/zfi/bud/updateBudgetToSAP")
	public ModelAndView updateBudgetToSAP(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		response.setContentType("text/xml; charset=utf-8");
		HashMap resultMap = new HashMap();
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code",(String) session.getAttribute("empCode"));
		logger.debug("$$"+paramMap);
		String[] result = zfiService.updateBudgetToSAP(paramMap);
		 
		resultMap.put("result",result[0]);
		resultMap.put("msg",result[1]);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 재무관리 > 예산관리 > 예산신청 > 저장(삭제)
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/zfi/bud/deleteBudgetToSAP")
	public ModelAndView deleteBudgetToSAP(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		response.setContentType("text/xml; charset=utf-8");
		HashMap resultMap = new HashMap();
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code",(String) session.getAttribute("empCode"));
		logger.debug("$$"+paramMap);

		String[] result = zfiService.deleteBudgetToSAP(paramMap);
		 
		resultMap.put("result",result[0]);
		resultMap.put("msg",result[1]);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 재무관리 > 예산관리 > 예산신청 > 전용 저장(추가)
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/zfi/bud/createBudgetOnlyToSAP")
	public ModelAndView createBudgetOnlyToSAP(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		response.setContentType("text/xml; charset=utf-8");
		HashMap resultMap = new HashMap();
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		paramMap.put("add_index",request.getParameterValues("add_index"));
		HttpSession session = request.getSession();
		paramMap.put("emp_code",(String) session.getAttribute("empCode"));
		logger.debug("$$"+paramMap);
		String result[] = zfiService.createBudgetOnlyToSAP(paramMap);
		 
		resultMap.put("result",result[0]);
		resultMap.put("msg",result[1]);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 재무관리 > 예산관리 > 예산신청 > 전용 저장(삭제)
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/zfi/bud/deleteBudgetOnlyToSAP")
	public ModelAndView deleteBudgetOnlyToSAP(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		response.setContentType("text/xml; charset=utf-8");
		HashMap resultMap = new HashMap();
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code",(String) session.getAttribute("empCode"));
		logger.debug("$$"+paramMap.get("NO"));
		
		String result = zfiService.deleteBudgetOnlyToSAP(paramMap);
		 

		resultMap.put("msg",result);
		
		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 재무관리 > 예산관리 > 예산조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zfi/bud/zfi_bud_approval", method = RequestMethod.POST)
	public ModelAndView zfi_bud_approval(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		HashMap req_data = new HashMap();
		
		req_data.put("GSBER_S","1100");
		req_data.put("GUBUN","I");
		
		mav.addObject("req_data",req_data);
		
		mav.setViewName("/yp/zfi/bud/zfi_bud_approval");
		
		return mav;
	}
	
	/**
	 * 재무관리 > 예산관리 > 예산조회 > 결재상신
	 * @param model
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/popup/zfi/bud/retreveEdocPop")
	public ModelAndView retreveEdocPop(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Util util = new Util();
		HashMap req_data = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
//		req_data.put("chk_no", request.getParameterValues("chk_no"));
		
		HttpSession session = request.getSession();
		req_data.put("emp_code",(String) session.getAttribute("empCode"));
		
		String[] result = zfiService.retreveEdocPop(req_data);
		
		HashMap resultMap = new HashMap();
		resultMap.put("result",result[0]);
		resultMap.put("msg",result[1]);
		resultMap.put("url",result[2]);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	
	/**
	 * 재무관리 > 예산관리 > 투보수 예산 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zfi/bud/zfi_bud_wbs_read", method = RequestMethod.POST)
	public ModelAndView zfi_bud_wbs_read(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
		paramMap.put("auth", (String) session.getAttribute("FI_AUTH"));
		if(paramMap.get("auth") == null) paramMap.put("auth","US");
		
		
		mav.addObject("req_data", paramMap);
		
		mav.setViewName("/yp/zfi/bud/zfi_bud_wbs_read");
		
		return mav;
	}
	
	/**
	 * 재무관리 > 예산관리 > 투보수 예산 조회 > 엑셀 다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/yp/zfi/bud/xls/zfi_bud_wbs_read", method = RequestMethod.POST)
	public ModelAndView xls_zfi_bud_wbs_read(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		HashMap<String, Object> result = zfiService.ui_select_retrieveBudgetStatus(request, response);

		mav.addObject("list", result.get("list"));
		
		mav.setViewName("/yp/zfi/bud/xls/zfi_bud_wbs_read");
		return mav;
	}
	
	/**
	 * 재무관리 > 예산관리 > 투보수 예산 상세 조회 > 엑셀 다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/yp/zfi/bud/xls/zfi_bud_wbs_read_detail", method = RequestMethod.POST)
	public ModelAndView xls_zfi_bud_wbs_read_detail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		HashMap<String, Object> result = zfiService.ui_select_retrieveBudgetStatus(request, response);

		mav.addObject("listx", result.get("list"));
		
		mav.setViewName("/yp/zfi/bud/xls/zfi_bud_wbs_read_detail");
		return mav;
	}
	
	/**
	 * 재무관리 > 예산관리 > 투보수 예산 상세 조회 > 예산 상세 >엑셀 다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/yp/zfi/bud/xls/zfi_bud_wbs_read_detail_b", method = RequestMethod.POST)
	public ModelAndView xls_zfi_bud_wbs_read_detail_b(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		HashMap<String, Object> result = zfiService.ui_select_retrieveBudgetStatus(request, response);

		mav.addObject("listb", result.get("listb"));
		
		mav.setViewName("/yp/zfi/bud/xls/zfi_bud_wbs_read_detail_b");
		return mav;
	}
	
	/**
	 * 재무관리 > 예산관리 > 투보수 예산 상세 조회 > 실적 상세 >엑셀 다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/yp/zfi/bud/xls/zfi_bud_wbs_read_detail_s", method = RequestMethod.POST)
	public ModelAndView xls_zfi_bud_wbs_read_detail_s(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		HashMap<String, Object> result = zfiService.ui_select_retrieveBudgetStatus(request, response);

		mav.addObject("lists", result.get("lists"));
		
		mav.setViewName("/yp/zfi/bud/xls/zfi_bud_wbs_read_detail_s");
		return mav;
	}
	
	/**
	 * 재무관리 > 예산관리 > 투보수 예산 상세 조회 > 약정 상세 >엑셀 다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/yp/zfi/bud/xls/zfi_bud_wbs_read_detail_y", method = RequestMethod.POST)
	public ModelAndView xls_zfi_bud_wbs_read_detail_y(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		HashMap<String, Object> result = zfiService.ui_select_retrieveBudgetStatus(request, response);

		mav.addObject("listy", result.get("listy"));
		
		mav.setViewName("/yp/zfi/bud/xls/zfi_bud_wbs_read_detail_y");
		return mav;
	}
	
	/**
	 * 재무관리 > 예산관리 > 투보수 예산 조회 > WBS코드조회 팝업
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/popup/zfi/bud/retrievePOSID")
	public ModelAndView retrievePOSID( HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8");
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		logger.debug("$$"+paramMap);
		logger.debug((String) paramMap.get("search_type"));
		
		//페이징 관련
		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));
		//페이징 관련
		
		if(paramMap.get("search_type") != null){
			ArrayList<HashMap<String, String>> list = zfiService.retrievePOSID(paramMap);
			int totCnt = list.size();

			//페이징 관련
			Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
			mav.addObject("pagination", pagination);
			
			paramMap.put("firstRecordIndex", pagination.getStartIndex());
			paramMap.put("lastRecordIndex", pagination.getEndIndex());

			ArrayList<HashMap<String, String>> pagingList = util.pagingListOfERPList(list, pagination.getStartIndex(), pagination.getEndIndex());
			//페이징 관련
			
			mav.addObject("list", pagingList);	//페이징 결과 리스트 담기
		}

		
		mav.addObject("req_data",paramMap);
		mav.setViewName("/yp/zfi/bud/search_posid_pop");
		
		return mav;
	}
	

	/**
	 * 재무관리 > 예산관리 > 투보수 예산 조회 > 월별 WBS 코드내역 팝업
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/popup/bud/retrieveBudgetStatusReportPop")
	public ModelAndView retrieveBudgetStatusReportPop(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		logger.debug("retrieveBudgetStatus***"+paramMap);
		paramMap.put("empCode", session.getAttribute("empCode"));
		HashMap<String, Object> result = zfiService.ui_select_retrieveBudgetStatus(request, response);
		mav.addObject("listb",result.get("listb"));
		mav.addObject("lists",result.get("lists"));
		mav.addObject("listy",result.get("listy"));
		mav.addObject("ep_flag",result.get("ep_flag"));
		mav.addObject("ep_msg",result.get("ep_msg"));
		mav.addObject("req_data",paramMap);
		
		String return_page = "";
		if("B".equals((String)paramMap.get("GUBUN"))) {
			return_page = "budget_status_b_pop";
		}
		else if("S".equals((String)paramMap.get("GUBUN"))) {
			return_page = "budget_status_s_pop";
		}
		else if("Y".equals((String)paramMap.get("GUBUN"))) {
			return_page = "budget_status_y_pop";
		}
		
		if("1".equals((String)paramMap.get("excel_flag"))) {
			mav.setViewName("/yp/zfi/bud/xls/" + return_page);
		}else {
			mav.setViewName("/yp/zfi/bud/" + return_page);
		}
		
		return mav;
	}
	
	
	/**
	 * 재무관리 > 예산관리 > 투보수 예산 상세조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zfi/bud/zfi_bud_wbs_detail_read", method = RequestMethod.POST)
	public ModelAndView zfi_bud_wbs_detail_read(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
		paramMap.put("auth", (String) session.getAttribute("FI_AUTH"));
		if(paramMap.get("auth") == null) paramMap.put("auth","US");
		
		
		mav.addObject("req_data", paramMap);
		
		mav.setViewName("/yp/zfi/bud/zfi_bud_wbs_detail_read");

		return mav;
	}
	
	/**
	 * 재무관리 > 예산관리 > 투보수 예산 상세조회 > 엑셀 다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/yp/xls/zfi/bud/zfi_bud_wbs_detail_read", method = RequestMethod.POST)
	public ModelAndView xls_zfi_bud_wbs_detail_read(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		HashMap<String, Object> result = zfiService.ui_select_retrieveBudgetWbsList(request, response);

		mav.addObject("list", result.get("list"));
		
		mav.setViewName("/yp/zfi/bud/xls/zfi_bud_wbs_detail_read");
		return mav;
	}
	
	/**
	 * 재무관리 > 예산관리 > 투보수 예산 상세조회 > WBS 상세내역 팝업
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/popup/zfi/bud/zfi_bud_wbs_detail_read_pop")
	public ModelAndView zfi_bud_wbs_detail_read_pop(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap req_data = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		logger.debug("zfi_bud_wbs_detail_read_pop***"+req_data);
		req_data.put("empCode", session.getAttribute("empCode"));
		HashMap<String, Object> result = zfiService.retrieveBudgetWbsDetailList(req_data);
		mav.addObject("listwbs",result.get("list"));
		mav.addObject("ep_flag",result.get("ep_flag"));
		mav.addObject("ep_msg",result.get("ep_msg"));
		mav.addObject("req_data",req_data);
		
		String return_page = "zfi_bud_wbs_detail_read_pop";
		if("1".equals((String)req_data.get("excel_flag"))) {
			mav.setViewName("/yp/zfi/bud/xls/" + return_page);
		}else {
			mav.setViewName("/yp/zfi/bud/" + return_page);
		}
		
		return mav;
	}
	
	
}
