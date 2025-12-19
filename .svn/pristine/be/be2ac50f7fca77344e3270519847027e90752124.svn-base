package com.yp.zcs.ipt.cntr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
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
import com.yp.login.srvc.intf.YPLoginService;
import com.yp.zcs.ctr.srvc.intf.YP_ZCS_CTR_Service;
import com.yp.zcs.ipt.srvc.intf.YP_ZCS_IPT_Service;

@Controller
public class YP_ZCS_IPT_Controller {

	@Autowired
	private YP_ZCS_IPT_Service zcs_ipt_Service;
	
	@Autowired
	private YPLoginService lService;

	private static final Logger logger = LoggerFactory.getLogger(YP_ZCS_IPT_Controller.class);
	
	/**
	 * 공사용역 > 결재상태 체크
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zcs/ipt/select_chk_enable_proc")
	public ModelAndView select_chk_enable_proc(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【결재상태 체크】공사용역");
		HashMap resultMap = new HashMap();
		int result = 0;
		
		result = zcs_ipt_Service.select_chk_enable_proc(request, response);
		logger.debug("【결재상태 체크 결과】 - {} : {}", result, (result == 0 ? "미진행, 변경 가능." : "진행 혹은 완료, 변경 불가능!"));
		
		resultMap.put("result", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 공사용역 > 용역검수 > 월보 조회(공수)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/ipt/zcs_ipt_mon_manh_read", method = RequestMethod.POST)
	public ModelAndView zcs_ipt_mon_manh_read(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】공사용역 > 용역검수 > 월보 조회(공수)");
		ModelAndView mav = new ModelAndView();
		
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/zcs/ipt/zcs_ipt_mon_manh_read");
		return mav;
	}
	
	/**
	 * 월보 조회 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt/select_zcs_ipt_mon_manh_read", method = RequestMethod.POST)
	public ModelAndView select_zcs_ipt_mon_manh_read(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】공사용역 > 용역검수 > 월보 조회(공수)");
		HashMap resultMap = new HashMap();
		List list = new ArrayList();
		list = zcs_ipt_Service.select_zcs_ipt_mon_manh_read(request, response);
		resultMap.put("list", list);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 공사용역 > 용역검수 > 월보 등록(공수)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/ipt/zcs_ipt_mon_manh_create", method = RequestMethod.POST)
	public ModelAndView zcs_ipt_mon_manh_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】공사용역 > 용역검수 > 월보 등록(공수)");
		ModelAndView mav = new ModelAndView();
		
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/zcs/ipt/zcs_ipt_mon_manh_create");
		return mav;
	}
	
	/**
	 * 월보 등록 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt/select_zcs_ipt_mon_manh_create", method = RequestMethod.POST)
	public ModelAndView select_zcs_ipt_mon_manh_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】공사용역 > 용역검수 > 월보 등록(공수)");
		HashMap resultMap = new HashMap();
		HashMap data = new HashMap();
		data = zcs_ipt_Service.select_zcs_ipt_mon_manh_create(request, response);
		resultMap.put("list1", data.get("list1"));
		resultMap.put("list2", data.get("map2"));
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 월보등록 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt/merge_zcs_ipt_mon_manh_create", method = RequestMethod.POST)
	public ModelAndView merge_zcs_ipt_mon_manh_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【저장】공사용역 > 용역검수 > 월보등록(공수)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = zcs_ipt_Service.merge_zcs_ipt_mon_manh_create(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 월보등록 삭제
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt/delete_zcs_ipt_mon_manh_create", method = RequestMethod.POST)
	public ModelAndView delete_zcs_ipt_mon_manh_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【삭제】공사용역 > 용역검수 > 월보등록(공수)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = zcs_ipt_Service.delete_zcs_ipt_mon_manh_create(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	//-- 삭제
	/**
	 * 공사용역 > 용역검수 > 월보등록(공수)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/ipt/zcs_ipt_mon_manh_create_OLD", method = RequestMethod.POST)
	public ModelAndView zcs_ipt_mon_manh_create_OLD(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/zcs/ipt/zcs_ipt_mon_manh_create_OLD");
		return mav;
	}
	
	/**
	 * 공사용역 > 용역검수 > 월보등록(공수) > 팝업(코스트센터 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zcs/ipt/retrieveKOSTL")
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
			ArrayList<HashMap<String, String>> list = zcs_ipt_Service.retrieveKOSTL(paramMap);
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
		mav.setViewName("/yp/zcs/ipt/search_kostl_pop");
		return mav;
	}
	
	/**
	 * 공사용역 > 용역검수 > 월보등록(공수) > 저장 
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zcs/ipt/zcs_ipt_mon_manh_create_save")
	public ModelAndView zcs_ipt_mon_manh_create_save(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HashMap resultMap = new HashMap();
		int result = 0;
		
		result = zcs_ipt_Service.zcs_ipt_mon_manh_create_save(request, response);
		
		resultMap.put("result", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 *  공사용역 > 계약관리 > 계약조회(공수) > 월보테이블에 계약코드 존재유무 확인
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value="/yp/zcs/ipt/month_manh_excelUpload_check", method = RequestMethod.POST)
	public ModelAndView month_manh_excelUpload_check(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		
		int cnt = zcs_ipt_Service.month_manh_excelUpload_check(request, response);
		
		//월보테이블(공수)에 해당 데이터 이미 존재
		if(cnt>0) {
			resultMap.put("result",true);
		//월보테이블(공수)에 해당 데이터 이미 존재하지 않음
		}else {
			resultMap.put("result",false);
		}
			
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	/**
	 * 공사용역 > 계약관리 > 계약등록(공수) > 삭제
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zcs/ipt/month_manh_delete", method = RequestMethod.POST)
	public ModelAndView month_manh_delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		int result = zcs_ipt_Service.month_manh_delete(request, response);
		
		resultMap.put("result",result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 공사용역 > 용역검수 > 월보조회(작업)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/ipt/zcs_ipt_mon_opt_read", method = RequestMethod.POST)
	public ModelAndView zcs_ipt_mon_opt_read(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/zcs/ipt/zcs_ipt_mon_opt_read");
		return mav;
	}
	
	/**
	 * 공사용역 > 용역검수 > 월보등록(작업)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/ipt/zcs_ipt_mon_opt_create", method = RequestMethod.POST)
	public ModelAndView zcs_ipt_mon_opt_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/zcs/ipt/zcs_ipt_mon_opt_create");
		return mav;
	}
	
	/**
	 * 공사용역 > 용역검수 > 월보등록(작업) > 작업 다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/yp/xls/zcs/ipt/select_construction_monthly_rpt2_excel")
	public ModelAndView select_construction_monthly_rpt2_excel(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【엑셀다운로드】공사용역 > 용역검수 > 월보등록(작업) > 작업 다운로드");
		ModelAndView mav = new ModelAndView();
		
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		list = (ArrayList<HashMap<String, String>>) zcs_ipt_Service.select_construction_monthly_rpt2_excel(request, response);

		mav.addObject("alllist", list);

		mav.setViewName("/yp/zcs/ipt/xls/zcs_ipt_mon_opt_create");
		return mav;
	}
	
	/**
	 *  공사용역 > 계약관리 > 계약조회(작업) > 월보테이블에 계약코드 존재유무 확인
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value="/yp/zcs/ipt/month_opt_excelUpload_check", method = RequestMethod.POST)
	public ModelAndView month_opt_excelUpload_check(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		
		int cnt = zcs_ipt_Service.month_opt_excelUpload_check(request, response);
		
		//월보테이블(작업)에 해당 데이터 이미 존재
		if(cnt>0) {
			resultMap.put("result",true);
		//월보테이블(작업)에 해당 데이터 이미 존재하지 않음
		}else {
			resultMap.put("result",false);
		}
			
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 공사용역 > 용역검수 > 월보등록(작업) > 저장 
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zcs/ipt/zcs_ipt_mon_opt_create_save")
	public ModelAndView zcs_ipt_mon_opt_create_save(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HashMap resultMap = new HashMap();
		int result = 0;
		
		result = zcs_ipt_Service.zcs_ipt_mon_opt_create_save(request, response);
		
		resultMap.put("result", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 공사용역 > 계약관리 > 계약등록(공수) > 삭제
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zcs/ipt/month_opt_delete", method = RequestMethod.POST)
	public ModelAndView month_opt_delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		int result = zcs_ipt_Service.month_opt_delete(request, response);
		
		resultMap.put("result",result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 공사용역 > 용역검수 > 월보조회(월정액)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/ipt/zcs_ipt_mon_read", method = RequestMethod.POST)
	public ModelAndView zcs_ipt_mon_read(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/zcs/ipt/zcs_ipt_mon_read");
		return mav;
	}
	
	/**
	 * 공사용역 > 용역검수 > 월보등록(월정액)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/ipt/zcs_ipt_mon_create", method = RequestMethod.POST)
	public ModelAndView zcs_ipt_mon_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/zcs/ipt/zcs_ipt_mon_create");
		return mav;
	}
	
	/**
	 *  공사용역 > 계약관리 > 계약조회(월정액) > 월보테이블에 계약코드 존재유무 확인
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value="/yp/zcs/ipt/month_excelUpload_check", method = RequestMethod.POST)
	public ModelAndView month_excelUpload_check(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		
		int cnt = zcs_ipt_Service.month_excelUpload_check(request, response);
		
		//월보테이블(작업)에 해당 데이터 이미 존재
		if(cnt>0) {
			resultMap.put("result",true);
		//월보테이블(작업)에 해당 데이터 이미 존재하지 않음
		}else {
			resultMap.put("result",false);
		}
			
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 공사용역 > 용역검수 > 월보등록(월정액) > 저장 
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zcs/ipt/zcs_ipt_mon_create_save")
	public ModelAndView zcs_ipt_mon_create_save(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HashMap resultMap = new HashMap();
		int result = 0;
		
		result = zcs_ipt_Service.zcs_ipt_mon_create_save(request, response);
		
		resultMap.put("result", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 공사용역 > 계약관리 > 계약등록(월정액) > 삭제
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zcs/ipt/month_delete", method = RequestMethod.POST)
	public ModelAndView month_delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		int result = zcs_ipt_Service.month_delete(request, response);
		
		resultMap.put("result",result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 공사용역 > 용역검수 > 월보등록(공수) > AJAX(코스트센터 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zcs/ipt/retrieveAjaxKOSTL")
	public ModelAndView retrieveAjaxKOSTL(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap req_data = new HashMap();
		req_data.put("search_type", "I_KOSTL");
		req_data.put("search_text", (String) request.getParameter("COST_CODE"));

		HttpSession session = request.getSession();
		req_data.put("emp_code", (String) session.getAttribute("empCode"));

		logger.debug("$$" + req_data);

		ArrayList<HashMap<String, String>> result = zcs_ipt_Service.retrieveKOSTL(req_data);

		HashMap resultMap = new HashMap();
		if (result.size() > 0) {
			resultMap.put("KOST1", result.get(0).get("KOST1"));
			resultMap.put("VERAK", result.get(0).get("VERAK"));
		}
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 정비용역 > 용역검수 > 작업 진행/완료 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author jamerl
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/ipt/zcs_ipt_process_list", method = RequestMethod.POST)
	public ModelAndView zcs_ipt_process_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】정비용역 > 용역검수 > 작업 진행/완료 조회");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/zcs/ipt/zcs_ipt_process_list");
		return mav;
	}
	
	/**
	 * 정비용역 > 용역검수 > 작업자 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author jamerl
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zcs/ipt/select_zcs_ipt_process_list")
	public ModelAndView select_zcs_ipt_process_list(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【조회】정비용역 > 용역검수 > 작업 진행/완료 조회");
		HashMap resultMap = new HashMap();
		resultMap.put("result", zcs_ipt_Service.select_zcs_ipt_process_list(request, response));
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 정비용역 > 용역검수 > 작업 진행/완료 조회 > 엑셀다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/yp/xls/zcs/ipt/select_zcs_ipt_process_list")
	public ModelAndView xls_select_zcs_ipt_process_list(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【엑셀다운로드】정비용역 > 용역검수 > 작업 진행/완료 조회");
		ModelAndView mav = new ModelAndView();
		
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		list = (ArrayList<HashMap<String, String>>) zcs_ipt_Service.select_zcs_ipt_process_list(request, response);

		mav.addObject("alllist", list);

		mav.setViewName("/yp/zcs/ipt/xls/zcs_ipt_process_list");
		return mav;
	}
	
	/**
	 * 정비용역 > 용역검수 > 작업자 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author jamerl
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/ipt/zcs_ipt_worker_list", method = RequestMethod.POST)
	public ModelAndView zcs_ipt_worker_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】정비용역 > 용역검수 > 작업자 조회");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/zcs/ipt/zcs_ipt_worker_list");
		return mav;
	}
	
	/**
	 * 정비용역 > 용역검수 > 작업자 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author jamerl
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zcs/ipt/select_zcs_ipt_worker_list")
	public ModelAndView select_zcs_ipt_worker_list(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【조회】정비용역 > 용역검수 > 작업자 조회");
		HashMap resultMap = new HashMap();
		resultMap.put("result", zcs_ipt_Service.select_zcs_ipt_worker_list(request, response));
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 정비용역 > 용역검수 > 작업자 조회 > 엑셀다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/yp/xls/zcs/ipt/select_zcs_ipt_worker_list")
	public ModelAndView xls_select_zcs_ipt_worker_list(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【엑셀다운로드】정비용역 > 용역검수 > 작업자 조회");
		ModelAndView mav = new ModelAndView();
		
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		list = (ArrayList<HashMap<String, String>>) zcs_ipt_Service.select_zcs_ipt_worker_list(request, response);

		mav.addObject("alllist", list);

		mav.setViewName("/yp/zcs/ipt/xls/zcs_ipt_worker_list");
		return mav;
	}
	
	/**
	 * 정비용역 > 용역검수 > 돌발 작업/오더 매핑
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author jamerl
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/ipt/zcs_ipt_unexpected_list", method = RequestMethod.POST)
	public ModelAndView zcs_ipt_unexpected_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】정비용역 > 용역검수 > 돌발 작업/오더 매핑");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/zcs/ipt/zcs_ipt_unexpected_list");
		return mav;
	}
	
	/**
	 * 정비용역 > 용역검수 > 돌발 작업/오더 매핑
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author jamerl
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zcs/ipt/select_zcs_ipt_unexpected_list")
	public ModelAndView select_zcs_ipt_unexpected_list(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【조회】정비용역 > 용역검수 > 돌발 작업/오더 매핑");
		HashMap resultMap = new HashMap();
		resultMap.put("result", zcs_ipt_Service.select_zcs_ipt_unexpected_list(request, response));
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 정비용역 > 용역검수 > 돌발 작업/오더 매핑 > 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt/proc_zcs_ipt_unexpected_list")
	public ModelAndView proc_zcs_ipt_unexpected_list(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【저장】정비용역 > 용역검수 > 돌발 작업/오더 매핑");
		HashMap resultMap = new HashMap();
		
		int result = zcs_ipt_Service.proc_zcs_ipt_unexpected_list(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 정비용역 > 용역검수 > 거래처 팝업
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author jamerl
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zcs/ipt/popup_company_id", method = RequestMethod.POST)
	public ModelAndView popup_company_id(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【팝업】정비용역 > 용역검수 > 거래처");
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));
		
		List list = zcs_ipt_Service.popup_company_id(request, response);
		int totCnt = list.size();
		
		Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
		mav.addObject("pagination", pagination);
		
		paramMap.put("firstRecordIndex", pagination.getStartIndex());
		paramMap.put("lastRecordIndex", pagination.getEndIndex());
		
		List pagingList = util.pagingListOfERPList(list, pagination.getStartIndex(), pagination.getEndIndex());
		
		mav.addObject("list", pagingList);
		
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zcs/ipt/zcs_ipt_popup_company_id");
		return mav;
	}
	
	/**
	 * 정비용역 > 용역검수 > 작업자 팝업
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author jamerl
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zcs/ipt/popup_name", method = RequestMethod.POST)
	public ModelAndView popup_name(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【팝업】정비용역 > 용역검수 > 작업자 팝업");
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		
		List list = zcs_ipt_Service.popup_name(request, response);
		int totCnt = list.size();
		
		Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
		mav.addObject("pagination", pagination);
		
		paramMap.put("firstRecordIndex", pagination.getStartIndex());
		paramMap.put("lastRecordIndex", pagination.getEndIndex());
		
		List pagingList = util.pagingListOfERPList(list, pagination.getStartIndex(), pagination.getEndIndex());
		
		mav.addObject("list", pagingList);
		
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zcs/ipt/zcs_ipt_popup_name");
		return mav;
	}

	/**
	 * 정비용역 > 용역검수 > 작업 진행/완료 조회 > 코스트센터 팝업
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zcs/ipt/retrieveKOSTL_search")
	public ModelAndView retrieveKOSTL_search(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【팝업】정비용역 > 용역검수 > 작업 진행/완료 조회 > 코스트센터 팝업");
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		
		if (paramMap.get("search_type") != null) {
			ArrayList<HashMap<String, String>> list = zcs_ipt_Service.retrieveKOSTL(paramMap);
			int totCnt = list.size();
			
			Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
			mav.addObject("pagination", pagination);
			
			paramMap.put("firstRecordIndex", pagination.getStartIndex());
			paramMap.put("lastRecordIndex", pagination.getEndIndex());
			
			ArrayList<HashMap<String, String>> pagingList = util.pagingListOfERPList(list, pagination.getStartIndex(), pagination.getEndIndex());
			
			mav.addObject("list", pagingList);
		}
		paramMap.put("type", paramMap.get("type"));
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zcs/ipt/search_kostl_pop_search");
		return mav;
	}
	
	/**
	 * 정비용역 > 용역검수 > 작업 진행/완료 조회 > 작업장 팝업
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zcs/ipt/retrieveVAPLZ")
	public ModelAndView retrieveVAPLZ(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【팝업】정비용역 > 용역검수 > 작업 진행/완료 조회 > 작업장 팝업");
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		
		if (paramMap.get("search_type") != null) {
			ArrayList<HashMap<String, String>> list = zcs_ipt_Service.retrieveVAPLZ(paramMap);
			int totCnt = list.size();
			
			Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
			mav.addObject("pagination", pagination);
			
			paramMap.put("firstRecordIndex", pagination.getStartIndex());
			paramMap.put("lastRecordIndex", pagination.getEndIndex());
			
			ArrayList<HashMap<String, String>> pagingList = util.pagingListOfERPList(list, pagination.getStartIndex(), pagination.getEndIndex());
			
			mav.addObject("list", pagingList);
		}
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zcs/ipt/search_vaplz_pop");
		return mav;
	}
	
	/**
	 * 정비용역 > 용역검수 > 돌발 작업/오더 팝업
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author jamerl
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zcs/ipt/unexpectedPop")
	public ModelAndView unexpectedPop(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【팝업】정비용역 > 용역검수 > 돌발 작업/오더 팝업");
		request.setCharacterEncoding("UTF-8");
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap paramMap = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));
		
		if (paramMap.get("search_type") != null) {
			ArrayList<HashMap<String, String>> unexpectedList = zcs_ipt_Service.unexpectedBySAP(paramMap);
			int totCnt = unexpectedList.size();
			
			Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
			mav.addObject("pagination", pagination);
			
			paramMap.put("firstRecordIndex", pagination.getStartIndex());
			paramMap.put("lastRecordIndex", pagination.getEndIndex());
			
			ArrayList<HashMap<String, String>> pagingList = util.pagingListOfERPList(unexpectedList, pagination.getStartIndex(), pagination.getEndIndex());
			
			mav.addObject("list", pagingList);
		}
		
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zcs/ipt/search_unexpected_pop");
		return mav;
	}
	
	/**
	 * SAP오더 팝업
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @author jamerl
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zcs/ipt/sapPop")
	public ModelAndView sapPop(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【팝업】SAP 오더 검색 팝업");
		request.setCharacterEncoding("UTF-8");
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap paramMap = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));
		
		if (paramMap.get("search_type") != null) {
			ArrayList<HashMap<String, String>> unexpectedList = zcs_ipt_Service.unexpectedBySAP(paramMap);
			int totCnt = unexpectedList.size();
			
			Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
			mav.addObject("pagination", pagination);
			
			paramMap.put("firstRecordIndex", pagination.getStartIndex());
			paramMap.put("lastRecordIndex", pagination.getEndIndex());
			
			ArrayList<HashMap<String, String>> pagingList = util.pagingListOfERPList(unexpectedList, pagination.getStartIndex(), pagination.getEndIndex());
			
			mav.addObject("list", pagingList);
		}
		
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zcs/ipt/search_sap_pop");
		return mav;
	}
}