package com.yp.zwc.ent2.cntr;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.vicurus.it.core.common.Pagination;
import com.vicurus.it.core.common.Util;
import com.vicurus.it.core.common.WebUtil;
import com.yp.common.srvc.intf.CommonService;
import com.yp.login.srvc.intf.YPLoginService;
import com.yp.util.DateUtil;
import com.yp.zfi.doc.srvc.intf.YP_ZFI_DOC_Service;
import com.yp.zwc.ent2.srvc.intf.YP_ZWC_ENT2_Service;
import com.yp.zwc.ipt2.srvc.intf.YP_ZWC_IPT2_Service;

@Controller
public class YP_ZWC_ENT2_Controller {

	@Autowired
	private YP_ZWC_IPT2_Service YP_ZWC_IPT2_Service;
	@Autowired
	private YP_ZWC_ENT2_Service YP_ZWC_ENT2_Service;
	@Autowired
	private YPLoginService lService;
	@Autowired
	private CommonService commonService;

	@Autowired
	private YP_ZFI_DOC_Service zfi_doc_Service;

	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_ENT2_Controller.class);

	
	/**
	 * 조업도급관리 > 협력업체 관리 > 업체 목록
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zwc/ent2/zwc_ent2_data_search", method = RequestMethod.POST)
	public ModelAndView zwc_ent2_data_search(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
		paramMap.put("auth", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH"));
		if(paramMap.get("auth") == null) paramMap.put("auth","US");

		mav.addObject("req_data", paramMap);
		
//		List<HashMap<String, Object>> cb_working_master_v = YP_ZWC_IPT2_Service.select_cb_working_master_v(req_data);
		List<HashMap<String, Object>> cb_working_master_v = new ArrayList<HashMap<String, Object>>();
		HashMap map_v = new HashMap<String, Object>();
		if("SA".equals(session.getAttribute("s_authogrp_code"))) {
			map_v.put("CODE", "V1");
			map_v.put("CODE_NAME", "세진 ENT");
			cb_working_master_v.add(map_v);
		}else {
			map_v.put("CODE", session.getAttribute("ent_vendor_code"));
			map_v.put("CODE_NAME", session.getAttribute("ent_vendor_name"));
			cb_working_master_v.add(map_v);
		}
		
		List<HashMap<String, Object>> cb_tbl_working_subc = new ArrayList<HashMap<String,Object>>();
		if(cb_working_master_v.size() > 0) {
			paramMap.put("VENDOR_CODE", cb_working_master_v.get(0).get("CODE"));
			paramMap.put("BASE_YYYY", DateUtil.getToday().substring(0, 4));
			cb_tbl_working_subc = YP_ZWC_IPT2_Service.select_cb_tbl_working_subc(paramMap);
		}
		
		mav.addObject("cb_tbl_working_subc", cb_tbl_working_subc);
		mav.addObject("cb_working_master_v", cb_working_master_v);
		
		mav.setViewName("/yp/zwc/ent2/zwc_ent2_data_search");

		return mav;
	}
	
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/xls/zwc/ent2/zwc_ent2_data_search", method = RequestMethod.POST)
	public ModelAndView xls_zwc_ent2_data_search(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		ArrayList<HashMap<String, String>> list = YP_ZWC_ENT2_Service.xls_zwc_ent2_data_search(paramMap);	//업체목록 데이터 가져오기
		mav.addObject("list", list);
		mav.setViewName("/yp/zwc/ent2/xls/zwc_ent2_data_search");
		return mav;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zwc/ent2/zwc_ent2_data_search_worker_popup")
	public ModelAndView zwc_ent2_data_search_worker_popup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("target", paramMap.get("target"));

		//mav.addObject("WORKTYPE_LIST", zwc_ctr_Service.select_zwc_ctr_worktype_list(paramMap));		//근무형태 셀렉트리스트
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zwc/ent2/zwc_ent2_data_search_worker_popup");
		return mav;
	}
}