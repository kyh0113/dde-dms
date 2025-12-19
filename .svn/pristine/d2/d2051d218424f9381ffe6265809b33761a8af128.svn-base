package com.yp.zhr.lbm.cntr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.vicurus.it.core.common.Util;
import com.yp.login.srvc.intf.YPLoginService;
import com.yp.zhr.lbm.srvc.intf.YP_ZHR_LBM_Service;

@Controller
public class YP_ZHR_LBM_Controller {

	@Autowired
	private YP_ZHR_LBM_Service zhrService;
	@Autowired
	private YPLoginService lService;
	private static final Logger logger = LoggerFactory.getLogger(YP_ZHR_LBM_Controller.class);

	/**
	 * 인사관리 > 도시락관리 > 도시락 신청 등록
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zhr/lbm/zhr_lbm_create", method = RequestMethod.POST)
	public ModelAndView zfi_lbm_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
		paramMap.put("auth", (String) session.getAttribute("HR_AUTH"));
		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");

		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zhr/lbm/zhr_lbm_create");

		return mav;
	}

	/**
	 * 인사관리 > 도시락관리 > 도시락 신청등록
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zhr/lbm/createDosilakAppli", method = RequestMethod.POST)
	public ModelAndView sample1Merge(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map resultMap = new HashMap();
		resultMap = zhrService.createDosilakReg(request, response);
		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 인사관리 > 도시락관리 > 도시락 신청취소
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zhr/lbm/deleteDosilakAppli", method = RequestMethod.POST)
	public ModelAndView deleteDosilakAppli(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();
		resultMap = zhrService.deleteDosilakAppli(request, response);
		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 인사관리 > 도시락관리 > 도시락 신청등록 > 추가버튼(사원검색팝업)
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/yp/popup/zhr/lbm/retrieveEmpWorkList")
	public ModelAndView retrieveEmpWorkList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();
		paramMap.put("orgeh", (String) session.getAttribute("userDeptCd"));
		paramMap.put("search_type", (String) request.getParameter("search_type"));
		paramMap.put("search_text", (String) request.getParameter("search_text"));
		if ("12016233".equals((String) session.getAttribute("empCode"))) {
			logger.debug("조용래");
		} else {
			paramMap.put("zclss", ((String) session.getAttribute("zclss")));
			paramMap.put("schkz", ((String) session.getAttribute("schkz")));
		}

		//if (!paramMap.isEmpty()) {
		List empList = zhrService.retrieveEmpWorkList(paramMap);
		mav.addObject("list", empList);
		mav.addObject("req_data", paramMap);
		//}
		mav.setViewName("/yp/zhr/lbm/search_emp_pop");
		return mav;
	}

	/**
	 * 인사관리 > 도시락관리 > 도시락 신청 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zhr/lbm/zhr_lbm_read", method = RequestMethod.POST)
	public ModelAndView zhr_lbm_read(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
		paramMap.put("user_dept", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("dept_name", (String) session.getAttribute("userDept"));
		paramMap.put("auth", (String) session.getAttribute("HR_AUTH"));
		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");

		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zhr/lbm/zhr_lbm_read");

		return mav;
	}

	/**
	 * 인사관리 > 도시락관리 > 도시락 집계등록
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zhr/lbm/zhr_lbm_sum_create", method = RequestMethod.POST)
	public ModelAndView zhr_lbm_sum_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
	
		// session attr to param
		HttpSession session = request.getSession();
		paramMap.put("emp_name",((String) session.getAttribute("userName")));
		paramMap.put("user_dept",((String) session.getAttribute("userDept")));
		paramMap.put("auth", (String) session.getAttribute("HR_AUTH"));
		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");

		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zhr/lbm/zhr_lbm_sum_create");

		return mav;
	}
	
	/**
	 * 인사관리 > 도시락관리 > 도시락 집계등록
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zhr/lbm/updateDosilakOk", method = RequestMethod.POST)
	public ModelAndView updateDosilakOk(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();
		resultMap = zhrService.updateDosilakOk(request, response);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 인사관리 > 도시락관리 > 도시락 집계취소
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zhr/lbm/updateDosilakOkCancel", method = RequestMethod.POST)
	public ModelAndView updateDosilakOkCancel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();
		resultMap = zhrService.updateDosilakOkCancel(request, response);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 인사관리 > 도시락관리 > 도시락 집계조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zhr/lbm/zhr_lbm_sum_list", method = RequestMethod.POST)
	public ModelAndView zhr_lbm_sum_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("auth", (String) session.getAttribute("HR_AUTH"));
		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");
		
		mav.addObject("req_data", paramMap);

		mav.setViewName("/yp/zhr/lbm/zhr_lbm_sum_list");

		return mav;
	}
	
	/**
	 * 인사관리 > 도시락관리 > 도시락 기간집계조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zhr/lbm/zhr_lbm_peorid_sum_list", method = RequestMethod.POST)
	public ModelAndView zhr_lbm_peorid_sum_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		Util util = new Util();
		HashMap req_data = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		req_data.put("emp_name",((String) session.getAttribute("userName")));
		
		if(!"welstory".equals((String) session.getAttribute("userId"))){
			req_data.put("dept_cd",((String) session.getAttribute("userDeptCd")));
		}
		
		req_data.put("auth", (String) session.getAttribute("HR_AUTH"));
		if (req_data.get("auth") == null)
			req_data.put("auth", "US");
		
		mav.addObject("req_data", req_data);

		mav.setViewName("/yp/zhr/lbm/zhr_lbm_peorid_sum_list");

		return mav;
	}
	
	/**
	 * 인사관리 > 도시락관리 > 월간 식대 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zhr/lbm/zhr_lbm_monthly_bill_read", method = RequestMethod.POST)
	public ModelAndView zhr_lbm_monthly_bill_read(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
	
		// session attr to param
		HttpSession session = request.getSession();
		paramMap.put("emp_cd",((String) session.getAttribute("empCode")));
		
		mav.addObject("req_data", paramMap);

		mav.setViewName("/yp/zhr/lbm/zhr_lbm_monthly_bill_read");

		return mav;
	}
	
	/**
	 * 인사관리 > 도시락관리 > 식당 관리
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unused" })
	@RequestMapping(value = "/yp/zhr/lbm/zhr_lbm_rest_mng", method = RequestMethod.POST)
	public ModelAndView zhr_lbm_rest_mng(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)		

		mav.setViewName("/yp/zhr/lbm/zhr_lbm_rest_mng");

		return mav;
	}
	
	/**
	 * 인사관리 > 도시락관리 > 식당 관리
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zhr/lbm/createRestaurant", method = RequestMethod.POST)
	@Transactional
	public ModelAndView createRestaurant(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		Map resultMap = new HashMap();
		resultMap = zhrService.createRestaurantReg(request, response);
		return new ModelAndView("DataToJson", resultMap);
	}


}
