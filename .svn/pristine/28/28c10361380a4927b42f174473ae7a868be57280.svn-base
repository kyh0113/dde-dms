package com.yp.zcs.ctr.cntr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
import com.yp.zcs.ctr.srvc.intf.YP_ZCS_CTR_Service;

@Controller
public class YP_ZCS_CTR_Controller {

	@Autowired
	private YP_ZCS_CTR_Service zcs_ctr_Service;
	
	@Autowired
	private YPLoginService lService;

	private static final Logger logger = LoggerFactory.getLogger(YP_ZCS_CTR_Controller.class);

	/**
	 * 공사용역 > 계약관리 > 계약등록
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/ctr/zcs_ctr_manh_create", method = RequestMethod.POST)
	public ModelAndView zcs_ctr_manh_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		List pay_code_list = zcs_ctr_Service.select_pay_code_list(request, response);
		mav.addObject("pay_code_list", pay_code_list);
		mav.addObject("CONTRACT_CODE", paramMap.get("CONTRACT_CODE"));
		
		mav.setViewName("/yp/zcs/ctr/zcs_ctr_manh_create");
		return mav;
	}
	
	/**
	 *  공사용역 > 계약관리 > 계약등록 > 팝업(업체 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zcs/ctr/select_working_master_v")
	public ModelAndView select_working_master_v(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));

		if (paramMap.get("search_type") != null) {
			ArrayList<HashMap<String, String>> list = zcs_ctr_Service.select_working_master_v(request,response);
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
		if(paramMap.get("first_flag") == null) {
			mav.addObject("first_flag", "Y");
		}else {
			mav.addObject("first_flag", "N");
		}
		mav.setViewName("/yp/zcs/ctr/search_working_master_v_pop");
		return mav;
	}
	
	/**
	 * 공사용역 > 계약관리 > 계약등록 > WBS코드조회 팝업
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/popup/zcs/ctr/retrievePOSID")
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
			ArrayList<HashMap<String, String>> list = zcs_ctr_Service.retrievePOSID(paramMap);
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
		mav.setViewName("/yp/zcs/ctr/search_posid_pop");
		
		return mav;
	}
	
	/**
	 * 공사용역 > 계약관리 > 계약등록 > 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zcs/ctr/zcs_ctr_manh_save", method = RequestMethod.POST)
	public ModelAndView zcs_ctr_manh_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = zcs_ctr_Service.zcs_ctr_manh_save(request, response);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 공사용역 > 계약관리 > 계약등록 > 삭제
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zcs/ctr/zcs_ctr_manh_delete", method = RequestMethod.POST)
	public ModelAndView zcs_ctr_manh_delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		int result = zcs_ctr_Service.zcs_ctr_manh_delete(request, response);
		
		resultMap.put("result",result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 공사용역 > 계약관리 > 계약 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zcs/ctr/zcs_ctr_manh_read", method = RequestMethod.POST)
	public ModelAndView zcs_ctr_manh_read(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		List pay_code_list = zcs_ctr_Service.select_pay_code_list(request, response);
		mav.addObject("pay_code_list", pay_code_list);
		
		mav.setViewName("/yp/zcs/ctr/zcs_ctr_manh_read");
		return mav;
	}
	
	/**
	 *  공사용역 > 계약관리 > 계약조회 > 팝업(계약명 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zcs/ctr/retrieveContarctName")
	public ModelAndView retrieveContarctName(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));

		if (paramMap.get("search_type") != null) {
			ArrayList<HashMap<String, String>> list = zcs_ctr_Service.retrieveContarctName(request, response);
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
		mav.setViewName("/yp/zcs/ctr/search_contarct_name_pop");
		return mav;
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
	
	@RequestMapping(value="/yp/zcs/ctr/zcs_ctr_manh_create_select", method = RequestMethod.POST)
	public ModelAndView zcs_ctr_manh_create_select(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		
		List contstruction_subc_list = zcs_ctr_Service.select_contstruction_subc(request, response);
		//List contstruction_subc_cost_list = zcs_ctr_Service.select_contstruction_subc_cost(request, response);
		//List contstruction_subc_emp_cost_list = zcs_ctr_Service.select_contstruction_subc_emp_cost(request, response);
		
		resultMap.put("contstruction_subc_list",contstruction_subc_list);
		//resultMap.put("contstruction_subc_cost_list",contstruction_subc_cost_list);
		//resultMap.put("contstruction_subc_emp_cost_list",contstruction_subc_emp_cost_list);
			
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 *  공사용역 > 계약관리 > 계약조회 > 월보테이블에 계약코드 존재유무 확인
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value="/yp/zcs/ctr/select_exist_monthly_rpt", method = RequestMethod.POST)
	public ModelAndView select_exist_monthly_rpt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		
		int cnt = zcs_ctr_Service.select_exist_monthly_rpt(request, response);
		
		//월보테이블에 해당 계약코드 존재
		if(cnt>0) {
			resultMap.put("result",true);
		//월보테이블에 해당 계약코드 존재하지 않음
		}else {
			resultMap.put("result",false);
		}
			
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 공사용역 > 계약관리 > 계약조회 > 삭제
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zcs/ctr/zcs_ctr_manh_read_delete", method = RequestMethod.POST)
	public ModelAndView zcs_ctr_manh_read_delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		int result = zcs_ctr_Service.zcs_ctr_manh_read_delete(request, response);
		
		resultMap.put("result",result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
}
