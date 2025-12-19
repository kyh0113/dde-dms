package com.yp.zhr.rez.cntr;

import java.util.ArrayList;
import java.util.Enumeration;
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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import com.vicurus.it.core.common.Util;
import com.yp.login.srvc.intf.YPLoginService;
import com.yp.util.DateUtil;
import com.yp.zhr.lbm.srvc.intf.YP_ZHR_LBM_Service;
import com.yp.zwc.ent.srvc.intf.YP_ZWC_ENT_Service;
import com.yp.zhr.rez.srvc.intf.YP_ZHR_REZ_Service;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
//import com.vicurus.it.core.code.srvc.intf.CodeService; //삭제 필요
import com.yp.common.srvc.intf.CommonService;

@Controller
public class YP_ZHR_REZ_Controller {

	@Autowired
	private YP_ZHR_LBM_Service zhrService;

	@Autowired
	private YPLoginService lService;
	
	@Autowired
	private YP_ZWC_ENT_Service zwcService; //삭제예정
	
	//@Autowired
	//private CodeService codeService;  //삭제예정
	
	@Autowired
	private YP_ZHR_REZ_Service rezService;
	
	@Autowired
	CommonService cs;

	@SuppressWarnings("unused")
	private static String FILE_HOME_PATH;
	
	@SuppressWarnings("static-access")
	@Value("#{config['file.uploadDirResource']}")
	public void setFILE_HOME_PATH(String value) {
		this.FILE_HOME_PATH = value;
	}
	// config.properties 에서 설정 정보 가져오기 끝
	
	
	private static final Logger logger = LoggerFactory.getLogger(YP_ZHR_REZ_Controller.class);
	
	
	/**
	 * 리조트 예약 화면 리스트    
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * 인사관리 > 도시락관리 > 도시락 신청 등록
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zhr/rez/zhr_rez_list", method = RequestMethod.POST)
	public ModelAndView zhrRezList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		paramMap.put("sdate", DateUtil.getToday());
		paramMap.put("edate", DateUtil.getSevenDay());
		
		// session attr to param
		HttpSession session = request.getSession();
		
		Enumeration se = session.getAttributeNames();
		
		while(se.hasMoreElements()){
			String getse = se.nextElement()+"";
		    System.out.println("@@@@@@@ session : "+getse+" : "+session.getAttribute(getse));
		}

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
		
		ArrayList<HashMap<String, String>> resortList = rezService.resortCodeList(paramMap);
		mav.addObject("resortlist",resortList);
		
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zhr/rez/zhr_rez_list");
		
		return mav;
	}
	
	
	/**
	 *
	 * 리조트 예약 팝업 화면
	 * 조업도급관리 > 협력업체관리 > 출입인원 목록 > 출입인원 등록팝업
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/popup/zhr/rez/zhrRezCreate")
	@SuppressWarnings("unchecked")
	public ModelAndView zhrRezCreate(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8");
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("empCode", session.getAttribute("empCode"));
		paramMap.put("userName", session.getAttribute("userName"));
		paramMap.put("userDeptCd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("userDept", session.getAttribute("userDept"));
		paramMap.put("userPos", session.getAttribute("userPos"));
		paramMap.put("userPosCd", session.getAttribute("userPosCd"));
		
		String gubun = (String) session.getAttribute("gubun");
		String auth  = session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH").toString();
		paramMap.put("gubun", gubun);
		paramMap.put("auth", auth);
		if(paramMap.get("auth") == null) paramMap.put("auth","US");
		logger.debug("zhrRezCreate.auth = "+auth);
		logger.debug("zhrRezCreate.gubun = "+gubun);
		
		paramMap.put("home_road", FILE_HOME_PATH);
		ArrayList<HashMap<String, String>> resortList = rezService.resortCodeList(paramMap);
		mav.addObject("resortlist",resortList);
		
//		if(gubun.equals("ent")){
//			if(session.getAttribute("gubun").equals("ent")) { //업체관리자인 경우 본인업체만 선택가능함
//				logger.debug("ent_code - [{}]", session.getAttribute("empCode"));
////				paramMap.put("ent_code", "27");
//				paramMap.put("ent_code", session.getAttribute("empCode"));
//				ArrayList<HashMap<String, String>> entCodeList = new ArrayList<HashMap<String,String>>();
//				HashMap<String, String> entMap = new HashMap<String, String>();
//				entMap.put("ENT_CODE", paramMap.get("empCode").toString());
//				entMap.put("ENT_NAME", paramMap.get("userName").toString());
//				entCodeList.add(entMap);
//				mav.addObject("entlist",entCodeList);
//			}
//		/**
//		 * 시스템관리자, 메뉴관리자, 도급계약관리자
//		 * 20220726 smh SCM권한도 추가
//		 */
//		}else if("CA".equals(auth) || "SA".equals(auth) || "MA".equals(auth) || "SCM".equals(auth)) {
//			ArrayList<HashMap<String, String>> entCodeList = zwcService.enterpriseCodeList(paramMap);
//			mav.addObject("entlist",entCodeList);
//		}

		String resortRezFileNm = rezService.resortRezFileNm();
		mav.addObject("resortRezFileNm",resortRezFileNm); // resort upload excel 파일명
		
		mav.addObject("req_data",paramMap);
		mav.setViewName("/yp/zhr/rez/zhr_rez_create_pop");
		
		return mav;
	}
	
	
	// 리조트 등록관리 메인
	@RequestMapping("/yp/zhr/rez/zhr_rez_reg_mng")
	public ModelAndView init(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝
		
		//List combo_CodeMaster = (List) codeService.getCodeMasterList(request, response);
		//mav.addObject("combo_CodeMaster", combo_CodeMaster);
		
		//코드 셀렉트리스트 만들기 영역
		//List combo_CodeMaster = (List) commonUtil.getCommonCodeForCombo("COM_USE"); // 사용유무
		//mav.addObject("combo_CodeMaster", combo_CodeMaster);
		//코드 셀렉트리스트 만들기 영역 끝
		
		mav.setViewName("/yp/zhr/rez/zhr_rez_reg_mng");
		return mav;
	}
	
	
	/**
	 * 조업도급관리 > 협력업체관리 > 출입인원 목록 > 출입인원 등록팝업 > 출입입원 등록
	 * 인사관리 > 리조트 예약 > 리조트 예약신청 > 리조트 예약신청 팝업 저장
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/zhr/rez/createResortReservControl")
	public ModelAndView createResortReservControl(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/xml; charset=utf-8");
		HashMap resultMap = new HashMap();
		resultMap.put("msg", "등록중 오류가 발생하였습니다.\n관리자에게 문의해 주세요.");
		resultMap.put("result_code", -1);
		
		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		String gubun = (String) session.getAttribute("gubun");
		String auth = session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH").toString();
		
		//System.out.println("auth --> " + auth);  auth SA gubun USER
		
		Enumeration params = request.getParameterNames();
		System.out.println("----------------------------");
		while (params.hasMoreElements()){
		    String name = (String)params.nextElement();
		    System.out.println(name + " : " +request.getParameter(name));
		}
		System.out.println("----------------------------");
		
		Map map = rezService.createResortReservReg(request, response);
		
		int iResult = (int) map.get("result");
		if(iResult == 1){
			resultMap.put("msg", "정상적으로 등록되었습니다.");
			resultMap.put("code", "00");
			resultMap.put("result_code", "1");
		}

//	       Iterator<String> mapIter = map.keySet().iterator();
//	        while(mapIter.hasNext()){
//	            String key = mapIter.next();
//	            Object value = map.get( key );
//	            System.out.println(key+" : "+value);
//	       }

//		boolean dupli_check = zwcService.retrieveSubcByCode((String)paramMap.get("subc_code"));	//출입번호 중복체크
//		if(!dupli_check){
//			resultMap.put("msg", "출입번호가 중복됩니다.");
//			resultMap.put("result_code", 0);
//		}else{
//			int no_entry_check = zwcService.noEntryCheck(paramMap);	//출입금지 인원 체크
//			/**
//			 * 20201201_khj CA권한도 등록할 수 있도록 추가
//			 * 20220726 smh SCM권한도 추가
//			 */
//			if(("SA".equals(auth) || "MA".equals(auth) || gubun.equals("ent") || "CA".equals(auth) || "SCM".equals(auth))){
//				if(no_entry_check == 0) {
//					int insert = zwcService.createAccessControl(paramMap); //출입인원 등록
//					if(insert >= 1){
//						resultMap.put("msg", "정상적으로 등록되었습니다.");
//						resultMap.put("code", "00");
//						resultMap.put("result_code", 1);
//					}
//				}else{
//					resultMap.put("msg", "출입금지된 인원입니다.");
//				}
//			}else{
//				resultMap.put("msg", "권한이 없습니다.\n관리자에게 문의해 주세요.");
//			}
//		}
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	/**
	 * 콤보 선호지역 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zhr/rez/resortRegionList", method = RequestMethod.POST)
	public ModelAndView regionCodeList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap<String, Object> req_data = (HashMap<String, Object>) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		ArrayList<HashMap<String, String>> result = (ArrayList<HashMap<String, String>>) rezService.regionCodeList(req_data);
		
		HashMap resultMap = new HashMap();
		resultMap.put("list", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	/**
	 * 선택항목삭제
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	/*
	 * ajax파라미터가 jsonstr 이므로 paramData로 받아서 jackson 라이브러리를 사용해 list로 컨버트 한다.
	 * */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value="/yp/zhr/rez/deleteResortRez")
	public ModelAndView deleteResortRez(@RequestBody String paramData, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();
		ObjectMapper om = new ObjectMapper();
		List rowDatas = om.readValue(paramData, new TypeReference<List<Map>>(){});
		
		int result = rezService.deleteResortRez(rowDatas);
		
		resultMap.put("result", result);
		
		return new ModelAndView("DataToJson", resultMap);		
	}
	
	
	/**
	 * 리조트 예약 관리자 화면 리스트    
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zhr/rez/zhr_rez_admission_list", method = RequestMethod.POST)
	public ModelAndView zhrRezAdmissionList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		paramMap.put("sdate", DateUtil.getToday());
		paramMap.put("edate", DateUtil.getSevenDay());

		// session attr to param
		HttpSession session = request.getSession();

		Enumeration se = session.getAttributeNames();
		   
		while(se.hasMoreElements()){
			String getse = se.nextElement()+"";
		    System.out.println("@@@@@@@ session : "+getse+" : "+session.getAttribute(getse));
		}

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

		ArrayList<HashMap<String, String>> resortList = rezService.resortCodeList(paramMap);
		mav.addObject("resortlist",resortList);

		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zhr/rez/zhr_rez_admission_list");

		return mav;
	}
	
	
	/**
	 * 
	 * 리조트 예약 승인 팝업 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/popup/zhr/rez/zhrRezAdmissionVue")
	@SuppressWarnings("unchecked")
	public ModelAndView zhrRezAdmissoinVu(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8");
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("empCode", session.getAttribute("empCode"));
		paramMap.put("userName", session.getAttribute("userName"));
		paramMap.put("userDeptCd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("userDept", session.getAttribute("userDept"));

		String gubun = (String) session.getAttribute("gubun");
		String auth  = session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH").toString();
		paramMap.put("gubun", gubun);
		paramMap.put("auth", auth);
		if(paramMap.get("auth") == null) paramMap.put("auth","US");
		logger.debug("zhrRezCreate.auth = "+auth);
		logger.debug("zhrRezCreate.gubun = "+gubun);
		
		ArrayList<HashMap<String, String>> resortList = rezService.resortCodeList(paramMap);
		mav.addObject("resortlist",resortList);
		
		if(gubun.equals("ent")){	
			if(session.getAttribute("gubun").equals("ent")) { //업체관리자인 경우 본인업체만 선택가능함
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
		
		if(paramMap.get("SEQ") != null) {
			ArrayList<HashMap<String, String>> subconDetail = zwcService.accessControlDetail((String)paramMap.get("SEQ"));
			String subc_code = subconDetail.get(0).get("SUBC_CODE");
			mav.addObject("data",subconDetail);
		}
		
		mav.addObject("req_data",paramMap);
		mav.setViewName("/yp/zhr/rez/zhr_rez_admission_pop");
		
		return mav;
	}
	
	
	/**
	 *
	 * 리조트 예약 승인 팝업 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/popup/zhr/rez/zhrRezAdmissionViewPop")
	@SuppressWarnings("unchecked")
	public ModelAndView zhrRezAdmissionView(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8");
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("empCode", session.getAttribute("empCode"));
		paramMap.put("userName", session.getAttribute("userName"));
		paramMap.put("userDeptCd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("userDept", session.getAttribute("userDept"));
		
		String gubun = (String) session.getAttribute("gubun");
		String auth  = session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH").toString();
		paramMap.put("gubun", gubun);
		paramMap.put("auth", auth);
		if(paramMap.get("auth") == null) paramMap.put("auth","US");
		logger.debug("zhrRezCreate.auth = "+auth);
		logger.debug("zhrRezCreate.gubun = "+gubun);
		
		ArrayList<HashMap<String, String>> resortList = rezService.resortCodeList(paramMap);
		mav.addObject("resortlist",resortList);
		
		mav.addObject("req_data",paramMap);
		mav.setViewName("/yp/zhr/rez/zhr_rez_admissionview_pop");
		
		return mav;
	}
	
	
	/**
	 * 조업도급관리 > 협력업체관리 > 출입인원 목록 > 출입인원 등록팝업 > 출입입원 등록
	 * 인사관리 > 리조트 예약 > 리조트 예약관리 > 리조트 예약 승인 거절
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/zhr/rez/resortRefuseControl")
	public ModelAndView resortRefuseControl(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/xml; charset=utf-8");
		HashMap resultMap = new HashMap();
		resultMap.put("msg", "등록중 오류가 발생하였습니다.\n관리자에게 문의해 주세요.");
		resultMap.put("result_code", -1);
		
		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		String gubun = (String) session.getAttribute("gubun");
		String auth = session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH").toString();
		
		//System.out.println("auth --> " + auth); auth SA gubun USER
		
		Enumeration params = request.getParameterNames();
		System.out.println("----------------------------");
		while (params.hasMoreElements()){
		    String name = (String)params.nextElement();
		    System.out.println(name + " : " +request.getParameter(name));
		}
		System.out.println("----------------------------");
		
		Map map = rezService.resortRefuseReg(request, response);
		
		int iResult = (int) map.get("result");
		if(iResult == 1){
			resultMap.put("msg", "정상적으로 등록되었습니다.");
			resultMap.put("code", "00");
			resultMap.put("result_code", "1");
		}
		
//	       Iterator<String> mapIter = map.keySet().iterator();
//	        while(mapIter.hasNext()){
//	            String key = mapIter.next();
//	            Object value = map.get( key );
//	            System.out.println(key+" : "+value);
//	       }

		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	/**
	 *
	 * 리조트 예약 결과보기 팝업 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/popup/zhr/rez/zhrRezView")
	@SuppressWarnings("unchecked")
	public ModelAndView zhrRezView(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8");
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("empCode", session.getAttribute("empCode"));
		paramMap.put("userName", session.getAttribute("userName"));
		paramMap.put("userDeptCd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("userDept", session.getAttribute("userDept"));

//		Enumeration params = request.getParameterNames();
//		System.out.println("----------------------------");
//		while (params.hasMoreElements()){
//		    String name = (String)params.nextElement();
//		    System.out.println(name + " : " +request.getParameter(name));
//		}
//		System.out.println("----------------------------");
//		
//		
//	    Iterator<String> mapIter = paramMap.keySet().iterator();
//        while(mapIter.hasNext()){
//            String key = mapIter.next();
//            Object value = paramMap.get( key );
//            System.out.println(key+" : "+value);
//      }

		String gubun = (String) session.getAttribute("gubun");
		String auth  = session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH").toString();
		paramMap.put("gubun", gubun);
		paramMap.put("auth", auth);
		if(paramMap.get("auth") == null) paramMap.put("auth","US");
		logger.debug("zhrRezCreate.auth = "+auth);
		logger.debug("zhrRezCreate.gubun = "+gubun);

		HashMap<String, String> resortRezList = rezService.resortRezList(paramMap);
		mav.addObject("resortRezlist",resortRezList);

		mav.addObject("req_data",paramMap);
		mav.setViewName("/yp/zhr/rez/zhr_rez_view_pop");
		
		return mav;
	}
	
	
	/**
	 * 선호지역 삭제
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value="/yp/zhr/rez/deleteRegionCode")
	public ModelAndView deleteRegionCode(@RequestBody String paramData, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();
		ObjectMapper om = new ObjectMapper();
		List rowDatas = om.readValue(paramData, new TypeReference<List<Map>>(){});
		
		int result = rezService.deleteRegionCode(rowDatas);
		
		resultMap.put("result", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	/**
	 * 리조트 코드 삭제
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value="/yp/zhr/rez/deleteResortCode")
	public ModelAndView deleteResortCode(@RequestBody String paramData, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();
		ObjectMapper om = new ObjectMapper();
		List rowDatas = om.readValue(paramData, new TypeReference<List<Map>>(){});
		
		int result = rezService.deleteResortCode(rowDatas);
		
		resultMap.put("result", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	/**
	 * 리조트 코드 수정
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value="/yp/zhr/rez/mergeResortCode")
	public ModelAndView mergeResortCode(@RequestBody String paramData, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();
		//ObjectMapper om = new ObjectMapper();
		//List rowDatas = om.readValue(paramData, new TypeReference<List<Map>>(){});
		
		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		paramMap.put("emp_cd", session.getAttribute("empCode"));
		
		int result = rezService.mergeResortCode(paramMap);
		resultMap.put("result", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	/**
	 * 리조트 코드 등록
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value="/yp/zhr/rez/createResortCode")
	public ModelAndView createResortCode(@RequestBody String paramData, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();

		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_cd", session.getAttribute("empCode"));
		
		int result = rezService.createResortCode(paramMap);
		
		resultMap.put("result", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	/**
	 * 선호지역 코드 수정
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value="/yp/zhr/rez/mergeRegionCode")
	public ModelAndView mergeRegionCode(@RequestBody String paramData, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();

		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		paramMap.put("emp_cd", session.getAttribute("empCode"));
		
		int result = rezService.mergeRegionCode(paramMap);
		resultMap.put("result", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	/**
	 * 선호지역 코드 등록
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value="/yp/zhr/rez/createRegionCode")
	public ModelAndView createRegionCode(@RequestBody String paramData, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();

		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_cd", session.getAttribute("empCode"));
		
		Enumeration params = request.getParameterNames();
		System.out.println("----------------------------");
		while (params.hasMoreElements()){
		    String name = (String)params.nextElement();
		    System.out.println(name + " : " +request.getParameter(name));
		}
		System.out.println("----------------------------");
		
		int result = rezService.createRegionCode(paramMap);
		
		resultMap.put("result", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	/**
	 * 파일 등록
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/yp/popup/zhr/rez/fileReg")
	public ModelAndView resortFileReg(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		logger.debug("paramMap="+paramMap);
		
		mav.addObject("req_data", paramMap);
		//mav.setViewName("/yp/common/file_reg_pop");
		mav.setViewName("/yp/zhr/rez/file_reg_pop");
		return mav;
	}
	
	
	/**
	 *
	 * 리조트 예약 결과보기 팝업 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/popup/zhr/rez/zhrRezModView")
	@SuppressWarnings("unchecked")
	public ModelAndView zhrRezModView(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("empCode", session.getAttribute("empCode"));
		paramMap.put("userName", session.getAttribute("userName"));
		paramMap.put("userDeptCd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("userDept", session.getAttribute("userDept"));
		paramMap.put("userPos", session.getAttribute("userPos"));
		
		Enumeration params = request.getParameterNames();

		while (params.hasMoreElements()){
		    String name = (String)params.nextElement();
		    System.out.println(name + " : " +request.getParameter(name));
		}

//	    Iterator<String> mapIter = paramMap.keySet().iterator();
//        while(mapIter.hasNext()){
//            String key = mapIter.next();
//            Object value = paramMap.get( key );
//            System.out.println(key+" : "+value);
//        }

		String gubun = (String) session.getAttribute("gubun");
		String auth  = session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH").toString();
		paramMap.put("gubun", gubun);
		paramMap.put("auth", auth);
		if(paramMap.get("auth") == null) paramMap.put("auth","US");
		logger.debug("zhrRezCreate.auth = "+auth);
		logger.debug("zhrRezCreate.gubun = "+gubun);

		HashMap<String, String> resortRezList = rezService.resortRezList(paramMap);
		mav.addObject("resortRezlist",resortRezList); //resort 등록 데이타
		
		resortRezList.put("resort_cd", resortRezList.get("RESORT_CD"));
		
		ArrayList<HashMap<String, String>> resortList = rezService.resortCodeList(paramMap);
		mav.addObject("resortlist",resortList); // resort 리스트
		
		ArrayList<HashMap<String, String>> regionList = (ArrayList<HashMap<String, String>>) rezService.regionCodeList(resortRezList);
		mav.addObject("regionlist",regionList); // resort 리스트
		
		String resortRezFileNm = rezService.resortRezFileNm();
		mav.addObject("resortRezFileNm",resortRezFileNm); // resort upload excel 파일명

		mav.addObject("req_data",paramMap);
		mav.setViewName("/yp/zhr/rez/zhr_rez_modify_pop");
		
		return mav;
	}
	
	
	/**
	 * 
	 * 리조트 관리자 예약 결과보기 팝업 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/popup/zhr/rez/zhrRezAdmissionModPop")
	@SuppressWarnings("unchecked")
	public ModelAndView zhrRezAdmissionModView(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8");

		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("empCode", session.getAttribute("empCode"));
		paramMap.put("userName", session.getAttribute("userName"));
		paramMap.put("userDeptCd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("userDept", session.getAttribute("userDept"));

//		Enumeration params = request.getParameterNames();
//
//		while (params.hasMoreElements()){
//		    String name = (String)params.nextElement();
//		    System.out.println(name + " : " +request.getParameter(name));
//		}

//	    Iterator<String> mapIter = paramMap.keySet().iterator();
//        while(mapIter.hasNext()){
//            String key = mapIter.next();
//            Object value = paramMap.get( key );
//            System.out.println(key+" : "+value);
//        }

		String gubun = (String) session.getAttribute("gubun");
		String auth  = session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH").toString();
		paramMap.put("gubun", gubun);
		paramMap.put("auth", auth);
		if(paramMap.get("auth") == null) paramMap.put("auth","US");
		logger.debug("zhrRezCreate.auth = "+auth);
		logger.debug("zhrRezCreate.gubun = "+gubun);
		
		paramMap.put("SEQ",paramMap.get("seq"));
		
		HashMap<String, String> resortRezList = rezService.resortRezList(paramMap);
		mav.addObject("resortRezlist",resortRezList); //resort 등록 데이타
		
		resortRezList.put("resort_cd", resortRezList.get("RESORT_CD"));
		
		ArrayList<HashMap<String, String>> resortList = rezService.resortCodeList(paramMap);
		mav.addObject("resortlist",resortList); // resort 리스트
		
		ArrayList<HashMap<String, String>> regionList = (ArrayList<HashMap<String, String>>) rezService.regionCodeList(resortRezList);
		mav.addObject("regionlist",regionList); // resort 리스트
		
		mav.addObject("req_data",paramMap);
		mav.setViewName("/yp/zhr/rez/zhr_rez_admissionmodify_pop");
		
		return mav;
	}
	
	
	/**
	 * 인사관리 > 리조트 예약 > 리조트 예약신청 > 리조트 예약신청 팝업 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/zhr/rez/updateResortReservControl")
	public ModelAndView updateResortReservControl(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/xml; charset=utf-8");
		HashMap resultMap = new HashMap();
		resultMap.put("msg", "등록중 오류가 발생하였습니다.\n관리자에게 문의해 주세요.");
		resultMap.put("result_code", -1);
		
		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		String gubun = (String) session.getAttribute("gubun");
		String auth = session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH").toString();
		
		Enumeration params = request.getParameterNames();
		System.out.println("----------------------------");
		while (params.hasMoreElements()){
		    String name = (String)params.nextElement();
		    System.out.println(name + " : " +request.getParameter(name));
		}
		System.out.println("----------------------------");

		Map map = rezService.updateResortReservReg(request, response);
		
		int iResult = (int) map.get("result");
		if(iResult == 1){
			resultMap.put("msg", "정상적으로 등록되었습니다.");
			resultMap.put("code", "00");
			resultMap.put("result_code", "1");
		}
		
//	       Iterator<String> mapIter = map.keySet().iterator();
//	         while(mapIter.hasNext()){
//	             String key = mapIter.next();
//	             Object value = map.get( key );
//	             System.out.println(key+" : "+value);
//	         }

		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	/**
	 * 인사관리 > 리조트 예약 > 리조트 예약신청 > 리조트 예약신청 팝업 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/zhr/rez/updateResortReservAdReg")
	public ModelAndView updateResortReservAdReg(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/xml; charset=utf-8");
		HashMap resultMap = new HashMap();
		resultMap.put("msg", "등록중 오류가 발생하였습니다.\n관리자에게 문의해 주세요.");
		resultMap.put("result_code", -1);
		
		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		String gubun = (String) session.getAttribute("gubun");
		String auth = session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH").toString();
		
		Map map = rezService.updateResortReservAdReg(request, response);
		
		int iResult = (int) map.get("result");
		if(iResult == 1){
			resultMap.put("msg", "정상적으로 등록되었습니다.");
			resultMap.put("code", "00");
			resultMap.put("result_code", "1");
		}
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	/**
	 * 파일 업로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/yp/zhr/rez/fileUploadResort")
	public ModelAndView fileUploadResort(ModelMap model, MultipartHttpServletRequest mRequest, HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/xml; charset=utf-8");
		HashMap resultMap = new HashMap();
		resultMap.put("msg", "등록중 오류가 발생하였습니다.\n관리자에게 문의해 주세요.");
		resultMap.put("result_code", -1);

		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		String type = (String)paramMap.get("type");
		
		HttpSession session = request.getSession();
		paramMap.put("emp_cd", session.getAttribute("empCode"));
		
		ArrayList<HashMap<String, String>> result = cs.fileUpload(request, response, mRequest);
		if(result != null){
			resultMap.put("msg", "파일이 등록되었습니다.");
			//arraylist 로 받아 그냥 적용 실제 파일은 하나임
			for(int i=0; i<result.size(); i++){
				resultMap.put("uploadPath"+i, result.get(i).get("uploadPath"));
				resultMap.put("fileName"+i, result.get(i).get("fileName"));
				paramMap.put("file_url", result.get(i).get("uploadPath"));
				paramMap.put("file_name", result.get(i).get("fileName"));
			}
			resultMap.put("result_code", 1);
			
			paramMap.put("seq", 1);  // 강제 지정 로우 하나
			
			Map couMap = rezService.resortRezFileYn();
			
			int resultYn = 0;
			
			if (Integer.parseInt(String.valueOf(couMap.get("COU"))) == 0){
				
				resultYn = rezService.createResortFile(paramMap);
				
			}else{
				
				resultYn = rezService.updateResortFile(paramMap);
				
			}

			//Map map = rezService.updateResortReservAdReg(request, response);

		}
		return new ModelAndView("DataToJson", resultMap);
	}
	
}