package com.yp.zwc.rpt.cntr;

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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import com.vicurus.it.core.common.Util;
import com.yp.login.srvc.intf.YPLoginService;
import com.yp.zwc.rpt.srvc.YP_ZWC_RPT_Service;

@Controller
public class YP_ZWC_RPT_Controller {

	@Autowired
	private YP_ZWC_RPT_Service zwc_rpt_Service;
	
	@Autowired
	private YPLoginService lService;
	
	@Value("#{config['session.outTime']}")
	private int sessionoutTime;
	
	@Value("#{config['sys.action_log']}")
	private String action_log;
	
	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_RPT_Controller.class);


	/**
	 * 영풍 그룹웨어 > 점핑
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/yp/view")
	public ModelAndView view(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		if("ZWC_RPT_INTERVENTION".equals(req_data.get("DESTINATION"))) {
			logger.debug("【그룹웨어 화면호출 리다이렉트】조업도급관리 > 보고서 > 도급비 조정(안) 상세보기");
			mav.addObject("RECEIVE_BASE_YYYY", req_data.get("RECEIVE_BASE_YYYY"));
			mav.addObject("RECEIVE_VENDOR_CODE", req_data.get("RECEIVE_VENDOR_CODE"));
			mav.addObject("RECEIVE_VENDOR_NAME", zwc_rpt_Service.select_vendor_name(req_data));
			mav.setViewName(req_data.get("DESTINATION_SRC").toString());
			return mav;
		}else if("ZCS_CPT_MANH_VIEW".equals(req_data.get("DESTINATION"))) {
			logger.debug("【그룹웨어 화면호출 리다이렉트】공사용역 > 검수보고서 > 검수보고서(공수) 상세보기 ");
			mav.addObject("REPORT_CODE", req_data.get("RECEIVE_REPORT_CODE"));
			mav.setViewName(req_data.get("DESTINATION_SRC").toString());
			return mav;
		}else if("ZCS_CPT_OPT_VIEW".equals(req_data.get("DESTINATION"))) {
			logger.debug("【그룹웨어 화면호출 리다이렉트】공사용역 > 검수보고서 > 검수보고서(공수) 상세보기 ");
			mav.addObject("REPORT_CODE", req_data.get("RECEIVE_REPORT_CODE"));
			mav.setViewName(req_data.get("DESTINATION_SRC").toString());
			return mav;
		}else if("ZCS_CPT_MON_VIEW".equals(req_data.get("DESTINATION"))) {
			logger.debug("【그룹웨어 화면호출 리다이렉트】공사용역 > 검수보고서 > 검수보고서(공수) 상세보기 ");
			mav.addObject("REPORT_CODE", req_data.get("RECEIVE_REPORT_CODE"));
			mav.setViewName(req_data.get("DESTINATION_SRC").toString());
			return mav;
		}else {
			mav.setViewName("/");
			return mav;
		}
	}
	
	/**
	 * 조업도급관리 > 보고서 > 업체별 도급비 조정(안) 상세보기 > 그룹웨어 통한 로그인
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping("/yp/zwc/rpt/zwc_rpt_intervention_view")
	public ModelAndView zwc_rpt_intervention_view(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【그룹웨어 화면호출】조업도급관리 > 보고서 > 도급비 조정(안) 상세보기");
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
				
				String RECEIVE_BASE_YYYY = (String) request.getParameter("BASE_YYYY");
				String RECEIVE_VENDOR_CODE = (String) request.getParameter("VENDOR_CODE");
				
				// 테스트 데이터
//				mav.addObject("RECEIVE_BASE_YYYY", "2010");
//				mav.addObject("RECEIVE_VENDOR_CODE", "V1");
				
				mav.addObject("RECEIVE_BASE_YYYY", RECEIVE_BASE_YYYY);
				mav.addObject("RECEIVE_VENDOR_CODE", RECEIVE_VENDOR_CODE);
				mav.addObject("hierarchy", "000005");
				mav.addObject("DESTINATION", "ZWC_RPT_INTERVENTION");
				mav.addObject("DESTINATION_SRC", "/yp/zwc/rpt/zwc_rpt_intervention_view");
				
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
	 * 조업도급관리 > 보고서 > 업체별 도급비 조정(안)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zwc/rpt/zwc_rpt_intervention")
	public ModelAndView zwc_ptc_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.addObject("cb_working_master_v", zwc_rpt_Service.select_cb_working_master_v(request, response));
		//mav.addObject("cb_working_recent_master_p", zwc_ptc_Service.select_cb_working_recent_master_p(request, response));
		
		mav.setViewName("/yp/zwc/rpt/zwc_rpt_intervention");
		return mav;
	}
	
	/**
	 * 조업도급관리 > 보고서 > 업체별 도급비 조정(안) > 집계
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/rpt/select_zwc_rpt_total", method = RequestMethod.POST)
	public ModelAndView select_zwc_rpt_total(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		int result = 0;
		
		//조급비조정 집계 및 산출근거 집계
		result += zwc_rpt_Service.merge_zwc_rpt_subc_cost_adjust(request, response);
//		//산출근거 집계
//		result += zwc_rpt_Service.merge_zwc_rpt_subc_cost_basis(request, response);
		
		resultMap.put("result",result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급관리 > 보고서 > 업체별 도급비 조정(안) 상세조회 > 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/rpt/select_zwc_rpt_intervention_list_view", method = RequestMethod.POST)
	public ModelAndView select_zwc_rpt_intervention_list_view(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		
		resultMap.put("rpt_intervention_list", zwc_rpt_Service.select_zwc_rpt_intervention_list(request, response));
		resultMap.put("rpt_gubun_list", zwc_rpt_Service.select_zwc_rpt_gubun_list(request, response));
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급관리 > 보고서 > 업체별 도급비 조정(안) > 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/rpt/select_zwc_rpt_intervention_list", method = RequestMethod.POST)
	public ModelAndView select_zwc_rpt_intervention_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		
		resultMap.put("rpt_intervention_list", zwc_rpt_Service.select_zwc_rpt_intervention_list(request, response));
		resultMap.put("rpt_gubun_list", zwc_rpt_Service.select_zwc_rpt_gubun_list(request, response));
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급관리 > 보고서 > 업체별 도급비 조정(안) > 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/rpt/zwc_rpt_intervention_save", method = RequestMethod.POST)
	public ModelAndView zwc_rpt_intervention_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		
		int result = 0;
		result = zwc_rpt_Service.zwc_rpt_subc_cost_adjust_save(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급관리 > 보고서 > 업체별 도급비 조정(안) > 저장 - 물량변경
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/rpt/zwc_rpt_intervention_save2", method = RequestMethod.POST)
	public ModelAndView zwc_rpt_intervention_save2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		
		int result = 0;
		result = zwc_rpt_Service.zwc_rpt_subc_cost_adjust_save2(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급관리 > 보고서 > 업체별 도급비 조정(안) > 엑셀 다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/yp/xls/zwc/rpt/zwc_rpt_intervention", method = RequestMethod.POST)
	public ModelAndView xls_zwc_ipt_sum_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		mav.addObject("BASE_YYYY", req_data.get("BASE_YYYY"));
		mav.addObject("VENDOR_CODE", req_data.get("VENDOR_CODE"));

		mav.setViewName("/yp/zwc/rpt/xls/zwc_rpt_intervention");
		return mav;
	}
	
	/**
	 * 조업도급관리 > 보고서 > 업체별 도급비 조정(안) > 팝업(업체별 도급비 산출근거)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/popup/zwc/rpt/zwc_rpt_pop_reason")
	public ModelAndView zwc_rpt_pop_reason(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List pop_reason_list = zwc_rpt_Service.select_zwc_rpt_pop_reason(request, response);
		
		mav.addObject("BASE_YYYY", paramMap.get("BASE_YYYY"));
		mav.addObject("VENDOR_CODE", paramMap.get("VENDOR_CODE"));
		mav.addObject("VENDOR_NAME", paramMap.get("VENDOR_NAME"));
		mav.addObject("CONTRACT_CODE", paramMap.get("CONTRACT_CODE"));
		mav.addObject("CONTRACT_NAME", paramMap.get("CONTRACT_NAME"));
		mav.addObject("pop_reason_list", pop_reason_list);
		
		mav.setViewName("/yp/zwc/rpt/zwc_rpt_detail_list_pop");
		return mav;
	}
	
	/**
	 * 조업도급관리 > 보고서 > 계약별 산출근거
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zwc/rpt/zwc_rpt_reason", method = RequestMethod.POST)
	public ModelAndView zwc_rpt_reason(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.addObject("cb_working_master_v", zwc_rpt_Service.select_cb_working_master_v(request, response));
		
		mav.setViewName("/yp/zwc/rpt/zwc_rpt_reason");
		return mav;
	}
	
	/**
	 * 조업도급관리 > 보고서 > 계약별 산출근거 > 계약명 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/rpt/select_contract_name", method = RequestMethod.POST)
	public ModelAndView select_contract_name(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		
		resultMap.put("contract_name_list", zwc_rpt_Service.zwc_rpt_select_contract_name(request, response));
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급관리 > 보고서 > 계약별 산출근거 > 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/rpt/select_rpt_reason_list", method = RequestMethod.POST)
	public ModelAndView select_rpt_reason_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		
		resultMap.put("rpt_reason_list", zwc_rpt_Service.zwc_rpt_select_reason_list(request, response));
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	
	/**
	 * 조업도급관리 > 보고서 > 계약별 산출근거  > 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/rpt/zwc_rpt_reason_save", method = RequestMethod.POST)
	public ModelAndView zwc_rpt_reason_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		
		int result = 0;
		result = zwc_rpt_Service.zwc_rpt_reason_save(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 조업도급관리 > 보고서 > 도급비 조정(안)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zwc/rpt/zwc_rpt_post_intervention", method = RequestMethod.POST)
	public ModelAndView zwc_rpt_post_intervention(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】조업도급관리 > 보고서 > 도급비 조정(안)");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		mav.addObject("cb_working_master_v", zwc_rpt_Service.select_cb_working_master_v(request, response));
		
		mav.setViewName("/yp/zwc/rpt/zwc_rpt_post_intervention");
		return mav;
	}
	
	/**
	 * 조업도급관리 > 보고서 > 도급비 조정(안) > 집계
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/rpt/merge_zwc_rpt_post_intervention", method = RequestMethod.POST)
	public ModelAndView merge_zwc_rpt_post_intervention(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【집계】조업도급관리 > 보고서 > 도급비 조정(안)");
		HashMap resultMap = new HashMap();
		int result = 0;
		
		//조급비조정 집계 및 산출근거 집계
		result += zwc_rpt_Service.merge_zwc_rpt_post_intervention(request, response);
		
		resultMap.put("result",result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급관리 > 보고서 > 도급비 조정(안) > 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/rpt/select_tbl_working_subc_pst_adj", method = RequestMethod.POST)
	public ModelAndView select_tbl_working_subc_pst_adj(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】조업도급관리 > 보고서 > 도급비 조정(안)");
		HashMap resultMap = new HashMap();
		
		resultMap.put("rpt_intervention_list", zwc_rpt_Service.select_tbl_working_subc_pst_adj(request, response));
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급관리 > 보고서 > 도급비 조정(안) > 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/rpt/update_tbl_working_subc_pst_adj", method = RequestMethod.POST)
	public ModelAndView update_tbl_working_subc_pst_adj(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【저장】조업도급관리 > 보고서 > 도급비 조정(안)");
		HashMap resultMap = new HashMap();
		
		resultMap.put("rpt_intervention_list", zwc_rpt_Service.update_tbl_working_subc_pst_adj(request, response));
		
		return new ModelAndView("DataToJson", resultMap);
	}
}
