package com.yp.zwc.ent.cntr;

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
import com.yp.zwc.ent.srvc.intf.YP_ZWC_ENT_Service;
import com.yp.zwc.ipt2.srvc.intf.YP_ZWC_IPT2_Service;

@Controller
public class YP_ZWC_ENT_Controller {

	@Autowired
	private YP_ZWC_IPT2_Service YP_ZWC_IPT2_Service;
	@Autowired
	private YP_ZWC_ENT_Service zwcService;
	@Autowired
	private YPLoginService lService;
	@Autowired
	private CommonService commonService;

	@Autowired
	private YP_ZFI_DOC_Service zfi_doc_Service;

	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_ENT_Controller.class);

	
	/**
	 * 조업도급관리 > 협력업체 관리 > 업체 목록
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zwc/ent/zwc_ent_list", method = RequestMethod.POST)
	public ModelAndView zwc_ent_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
		
		mav.setViewName("/yp/zwc/ent/zwc_ent_list");

		return mav;
	}
	
	/**
	 * 조업도급관리 > 협력업체관리 > 업체목록 > 업체목록 엑셀다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/xls/zwc/ent/zwc_ent_list", method = RequestMethod.POST)
	public ModelAndView xls_zwc_ent_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		ArrayList<HashMap<String, String>> list = zwcService.enterpriseList(paramMap);	//업체목록 데이터 가져오기
		mav.addObject("list", list);
		mav.setViewName("/yp/zwc/ent/xls/zwc_ent_list");
		return mav;
	}
	
	/**
	 * 조업도급관리 > 협력업체관리 > 업체목록 > 업체 상세팝업
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/popup/zwc/ent/entDetail")
	@SuppressWarnings("unchecked")
	public ModelAndView entDetail(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8");
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("empCode", session.getAttribute("empCode"));
		paramMap.put("userName", session.getAttribute("userName"));
		
		mav.addObject("req_data",paramMap);
		mav.setViewName("/yp/zwc/ent/zwc_ent_pop");
		
		return mav;
	}
	
	/**
	 * 조업도급관리 > 협력업체관리 > 업체목록 > 업체 등록
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/zwc/ent/createEnt")
	public ModelAndView createEnt(ModelMap model, MultipartHttpServletRequest mRequest, HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/xml; charset=utf-8");
		HashMap resultMap = new HashMap();
		resultMap.put("msg", "등록중 오류가 발생하였습니다.\n관리자에게 문의해 주세요.");
		resultMap.put("result_code", -1);
		
		Util util = new Util();
		HashMap req_data = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		String empCode = (String) session.getAttribute("empCode");
		//String auth = (String) session.getAttribute("HR_AUTH");
		String auth = session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH").toString();

		req_data.put("emp_code", empCode);
		logger.debug("@@@"+req_data+"@@");
		
		/**
		 * 20201202_khj "CA" 권한도 업체 등록 가능토록 변경
		 * 20220801 smh SCM 보안관리자 마스터 권한도 업체 등록 가능토록 변경 
		 */
		if("SA".equals(auth) || "MA".equals(auth) || "CA".equals(auth) || "SCM".equals(auth)){		
			int chk_duplication = zwcService.retrieveEntCnt(req_data);
			
			if(chk_duplication < 1){
				HashMap<String, String> result = commonService.ImgfileUpload(request, response, mRequest);
				req_data.put("license_url", result.get("license_url"));
				
				int insert = zwcService.createEnt(req_data);	//업체 등록
				
				//if("error".equals(file_url)) json.put("msg", "파일등록 오류");
				//else
				if(insert > 0) resultMap.put("msg","등록 되었습니다.");
				resultMap.put("result_code", 1);
			}else{
				resultMap.put("msg", "업체명 또는 관리자ID가 중복됩니다.\n다시 확인후 등록해 주세요.");
			}
		}else{
			resultMap.put("msg", "권한이 없습니다.");
		}
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급관리 > 협력업체관리 > 업체목록 > 업체 수정
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/zwc/ent/updateEnt")
	public ModelAndView updateEnt(ModelMap model, MultipartHttpServletRequest mRequest, HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/xml; charset=utf-8");
		HashMap resultMap = new HashMap();
		resultMap.put("msg", "수정중 오류가 발생하였습니다.\n관리자에게 문의해 주세요.");
		resultMap.put("result_code", -1);
		
		Util util = new Util();
		HashMap req_data = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		String empCode = (String) session.getAttribute("empCode");
		//String auth = (String) session.getAttribute("HR_AUTH");
		String auth = session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH").toString();
		
		req_data.put("emp_code", empCode);
		//req_data.put("auth","US");
		logger.debug("!!!"+req_data+"!!!");
		
		/**
		 * 20201202_khj "CA" 권한도 업체 수정 가능토록 변경
		 * 20220802 smh "SCM" 권한도 업체 수장 가능토록 변경
		 */
		if("SA".equals(auth) || "MA".equals(auth) || "CA".equals(auth) || "SCM".equals(auth)){		
			int chk_duplication = zwcService.retrieveEntCnt(req_data);
			
			if(chk_duplication < 1){
				if(mRequest.getFile("license_url") != null){
					HashMap<String, String> result = commonService.ImgfileUpload(request, response, mRequest);
					req_data.put("license_url", result.get("license_url"));
				}
				
				int upd = zwcService.updateEnt(req_data);	//업체 수정
				
				if(upd > 0) {
					
					resultMap.put("msg","수정 되었습니다.");
					resultMap.put("result_code", 1);
				}
			}else{
				resultMap.put("msg", "업체명 또는 관리자ID가 중복됩니다.\n다시 확인후 등록해 주세요.");
			}
		}else{
			resultMap.put("msg", "권한이 없습니다.");
		}
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@SuppressWarnings({"unchecked", "rawtypes"})
	@RequestMapping("/yp/zwc/ent/updateEnt_reset_pwd")
	public ModelAndView updateEnt_reset_pwd(HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/xml; charset=utf-8");
		HashMap resultMap = new HashMap();
		
		Util util = new Util();
		HashMap req_data = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int upd = zwcService.updateEnt_reset_pwd(req_data);	//업체 수정
		resultMap.put("result_code", upd);
		
		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 조업도급관리 > 협력업체 관리 > 업체 목록 > 팝업(업체 검색)
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zwc/ent/retrieveLIFNR")
	public ModelAndView retrieveLIFNR(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		int currentPage = StringUtils.isEmpty(request.getParameter("page")) ? 1 : Integer.parseInt(request.getParameter("page"));
		int pageSize = StringUtils.isEmpty(request.getParameter("pageSize")) ? 15 : Integer.parseInt(request.getParameter("pageSize"));
		int rangeSize = StringUtils.isEmpty(request.getParameter("rangeSize")) ? 10 : Integer.parseInt(request.getParameter("rangeSize"));

		if (paramMap.get("search_type") != null) {
			ArrayList<HashMap<String, String>> list = zfi_doc_Service.retrieveLIFNR(paramMap);
			int totCnt = list.size();

			Pagination pagination = new Pagination(pageSize, rangeSize, totCnt, currentPage);
			mav.addObject("pagination", pagination);

			paramMap.put("firstRecordIndex", pagination.getStartIndex());
			paramMap.put("lastRecordIndex", pagination.getEndIndex());

			ArrayList<HashMap<String, String>> pagingList = util.pagingListOfERPList(list, pagination.getStartIndex(), pagination.getEndIndex());
			logger.debug("{}", pagingList);
			mav.addObject("list", pagingList);
		}
		paramMap.put("target", paramMap.get("target"));
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zwc/ent/search_lifnr_pop");
		return mav;
	}
	
	/**
	 * 조업도급관리 > 협력업체 관리 > 출입인원 목록
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zwc/ent/zwc_ent_actl_list", method = RequestMethod.POST)
	public ModelAndView zwc_ent_actl_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
		paramMap.put("auth", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH").toString());
		if(paramMap.get("auth") == null) paramMap.put("auth","US");
		String gubun = (String) session.getAttribute("gubun");
		paramMap.put("gubun", gubun);
		
		if(gubun.equals("ent")){//업체계정시 해당업체 인원만 조회가능
			paramMap.put("ent_name", (String) session.getAttribute("userName"));
		}
		mav.addObject("req_data", paramMap);
		
		List teamList = zwcService.cb_ent_list(request, response);
		mav.addObject("teamList", teamList);
		
		mav.setViewName("/yp/zwc/ent/zwc_ent_actl_list");

		return mav;
	}
	
	/**
	 * 조업도급관리 > 협력업체관리 > 출입인원 목록 > 출입인원 목록 엑셀다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/xls/zwc/ent/zwc_ent_actl_list", method = RequestMethod.POST)
	public ModelAndView xls_zwc_ent_actl_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		ArrayList<HashMap<String, String>> list = zwcService.accesscontrolList(paramMap);	//업체목록 데이터 가져오기
		mav.addObject("list", list);
		mav.setViewName("/yp/zwc/ent/xls/zwc_ent_actl_list");
		return mav;
	}
	
	/**
	 * 조업도급관리 > 협력업체관리 > 출입인원 목록 > 출입인원 등록팝업
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/popup/zwc/ent/actlDetail")
	@SuppressWarnings("unchecked")
	public ModelAndView actlDetail(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8");
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("empCode", session.getAttribute("empCode"));
		paramMap.put("userName", session.getAttribute("userName"));
		String gubun = (String) session.getAttribute("gubun");
		String auth  = session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH").toString();
		paramMap.put("gubun", gubun);
		paramMap.put("auth", auth);
		if(paramMap.get("auth") == null) paramMap.put("auth","US");
		logger.debug("retrieveSubcontractList.auth = "+auth);
		logger.debug("retrieveSubcontractList.gubun = "+gubun);
		
		if(gubun.equals("ent")){	
			if(session.getAttribute("gubun").equals("ent")) {	//업체관리자인 경우 본인업체만 선택가능함
				logger.debug("ent_code - [{}]", session.getAttribute("empCode"));
//				paramMap.put("ent_code", "27");
				paramMap.put("ent_code", session.getAttribute("empCode"));
				ArrayList<HashMap<String, String>> entCodeList = new ArrayList<HashMap<String,String>>();
				HashMap<String, String> entMap = new HashMap<String, String>();
				entMap.put("ENT_CODE", paramMap.get("empCode").toString());
				entMap.put("ENT_NAME", paramMap.get("userName").toString());
				entCodeList.add(entMap);
				mav.addObject("entlist",entCodeList);
			}
		/**
		 * 시스템관리자, 메뉴관리자, 도급계약관리자
		 * 20220726 smh SCM권한도 추가
		 */
		}else if("CA".equals(auth) || "SA".equals(auth) || "MA".equals(auth) || "SCM".equals(auth)) {
			ArrayList<HashMap<String, String>> entCodeList = zwcService.enterpriseCodeList(paramMap);
			mav.addObject("entlist",entCodeList);
		}
		
		if(paramMap.get("SEQ") != null){
			ArrayList<HashMap<String, String>> subconDetail = zwcService.accessControlDetail((String)paramMap.get("SEQ"));
			String subc_code = subconDetail.get(0).get("SUBC_CODE");
			mav.addObject("data",subconDetail);
		}
		
		mav.addObject("req_data",paramMap);
		mav.setViewName("/yp/zwc/ent/zwc_ent_actl_pop");
		
		return mav;
	}
	
	/**
	 * 조업도급관리 > 협력업체관리 > 출입인원 목록 > 출입인원 등록팝업 > 사진등록 or 서약서등록
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/zwc/ent/imgUpload") //증명사진 업로드
	public ModelAndView imgUpload(ModelMap model, MultipartHttpServletRequest mRequest, HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/xml; charset=utf-8");
		HashMap resultMap = new HashMap();
		resultMap.put("msg", "등록중 오류가 발생하였습니다.\n관리자에게 문의해 주세요.");
		resultMap.put("result_code", -1);
		
		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		String type = (String)paramMap.get("type");
		
		HashMap<String, String> result = commonService.ImgfileUpload(request, response, mRequest);
		
		if(result != null){
			resultMap.put("msg", "사진이 등록되었습니다.");
			if("oath".equals(type)) {	//서약서 업로드
				resultMap.put("url", result.get("oath_url"));
			}else if("health".equals(type)) {	//검진 업로드
				resultMap.put("url", result.get("health_url"));
			}else if("zwc_ipt2_contract_bill".equals(type)) {	// 청구서 첨부
				paramMap.put("ATTACH_URL", result.get("zwc_ipt2_contract_bill_url"));
				
				resultMap.put("url", result.get("zwc_ipt2_contract_bill_url"));
				resultMap.put("ATTACH_YN", "Y");
				resultMap.put("msg", "청구서가 등록되었습니다.");
				YP_ZWC_IPT2_Service.update_zwc_ipt2_contract_bill_upload(paramMap);
			}else {						//증명사진 업로드
				resultMap.put("url", result.get("img_url"));
			}
			
			resultMap.put("result_code", 1);
		} 
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급관리 > 협력업체관리 > 출입인원 목록 > 출입인원 등록팝업 > 출입입원 등록
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/zwc/ent/createAccessControl")
	public ModelAndView createSubcontract(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/xml; charset=utf-8");
		HashMap resultMap = new HashMap();
		resultMap.put("msg", "등록중 오류가 발생하였습니다.\n관리자에게 문의해 주세요.");
		resultMap.put("result_code", -1);
		
		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		String gubun = (String) session.getAttribute("gubun");
		String auth = session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH").toString();

		boolean dupli_check = zwcService.retrieveSubcByCode((String)paramMap.get("subc_code"));	//출입번호 중복체크
		if(!dupli_check){
			resultMap.put("msg", "출입번호가 중복됩니다.");
			resultMap.put("result_code", 0);
		}else {
			int no_entry_check = zwcService.noEntryCheck(paramMap);	//출입금지 인원 체크
			/**
			 * 20201201_khj CA권한도 등록할 수 있도록 추가
			 * 20220726 smh SCM권한도 추가
			 */
			if(("SA".equals(auth) || "MA".equals(auth) || gubun.equals("ent") || "CA".equals(auth) || "SCM".equals(auth))){	
				if(no_entry_check == 0) {
					int insert = zwcService.createAccessControl(paramMap);	//출입인원 등록
					if(insert >= 1){
						resultMap.put("msg", "정상적으로 등록되었습니다.");
						resultMap.put("code", "00");
						resultMap.put("result_code", 1);
					}
				}else {
					resultMap.put("msg", "출입금지된 인원입니다.");
				}
			}else{
				resultMap.put("msg", "권한이 없습니다.\n관리자에게 문의해 주세요.");
			}
		}
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급관리 > 협력업체관리 > 출입인원 목록 > 출입인원 상세팝업 > 출입입원 수정
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/zwc/ent/updateAccessControl")
	public ModelAndView updateAccessControl(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/xml; charset=utf-8");
		HashMap resultMap = new HashMap();
		resultMap.put("msg", "수정중 오류가 발생하였습니다.\n관리자에게 문의해 주세요.");
		resultMap.put("result_code", -1);

		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		paramMap.put("upd_date", "y");
	
		//20201210_khj 조용래 대리 요청으로 출입번호 수정 가능하게끔 처리
		String subc_code_modify = (String)paramMap.get("chk_modify") == null ? "" : (String)paramMap.get("chk_modify");
		paramMap.put("subc_code_modify", subc_code_modify);
		
		boolean dupli_check = true;
		if(!"".equals(subc_code_modify)) {
			dupli_check = zwcService.retrieveSubcByCode((String)paramMap.get("subc_code"));	//출입번호 중복체크
		}
		
		if(!dupli_check){
			resultMap.put("msg", "출입번호가 중복됩니다.");
			resultMap.put("result_code", 0);
		}else {
			int insert = zwcService.updateAccessControl(paramMap);	//출입인원 수정
			if(insert > 0) {
				resultMap.put("msg", "정상적으로 수정되었습니다.");
				resultMap.put("result_code", 1);
			}
		}
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급관리 > 협력업체관리 > 출입인원 목록 > 출입입원 삭제
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zwc/ent/deleteAccessControl")
	public ModelAndView deleteAccessControl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		resultMap.put("msg", "삭제중 오류가 발생하였습니다.\n관리자에게 문의해 주세요.");
		resultMap.put("result_code", -1);
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();
		paramMap.put("emp_code",(String) session.getAttribute("empCode"));
		String auth = session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH").toString();
		
		/**
		 * 시스템관리자, 메뉴관리자만 삭제가능
		 * 20201201_khj CA권한도 삭제할 수 있도록 추가
		 * 20220726 smh SCM 보안관리실 마스터 권한도 추가
		 */
		if("SA".equals(auth) || "MA".equals(auth) || "CA".equals(auth) || "SCM".equals(auth)){	
			int delete = zwcService.deleteAccessControl(paramMap);	//출입인원 삭제
			if(delete > 0){
				resultMap.put("msg", "정상적으로 삭제되었습니다.");
				resultMap.put("code", "00");
				resultMap.put("result_code", 1);
			}else{
				resultMap.put("msg", "삭제에 실패하였습니다.\n관리자에게 문의해 주세요.");
			} 
		}else{
			resultMap.put("msg", "권한이 없습니다.\n관리자에게 문의해 주세요.");
		}

		return new ModelAndView("DataToJson", resultMap);
	}
}
