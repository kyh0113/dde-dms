package com.yp.login.cntr;

import java.security.PrivateKey;
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

import com.vicurus.it.biz.board.srvc.intf.BoardService;
import com.vicurus.it.core.common.Util;
import com.vicurus.it.core.secure.RSA;
import com.vicurus.it.core.secure.RSAUtil;
import com.yp.login.srvc.intf.YPLoginService;

@Controller
public class YPLoginController {
	@Autowired
	private YPLoginService lService;
	
	@Autowired
	private BoardService boardService;

	// config.properties 에서 설정 정보 가져오기 시작
	@Value("#{config['session.outTime']}")
	private int sessionoutTime;

	@Value("#{config['sys.action_log']}")
	private String action_log;
	// config.properties 에서 설정 정보 가져오기 끝

	private static final Logger logger = LoggerFactory.getLogger(YPLoginController.class);

	// public RSAUtil rsaUtil;
	RSAUtil rsaUtil = new RSAUtil();

	@RequestMapping(value = "/yp_decorator/yp_session_not_exist")
	public ModelAndView yp_session_not_exist(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/yp/decorators/yp_session_not_exist");
		return mav;
	}

	@RequestMapping(value = "/yp_decorator/yp_session_exist_main")
	public ModelAndView yp_session_exist_main(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/yp/decorators/yp_session_exist_main");
		return mav;
	}
	
	/**
	 * 2022-10-12 smh
	 * API Endpoint용 Decorator로 추가. 
	 */
	@RequestMapping(value = "/yp_decorator/yp_api_endpoint")
	public ModelAndView yp_api_endpoint(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/yp/decorators/yp_api_endpoint");
		return mav;
	}
	
	/**
	 * 영풍 웹포털 > 왼쪽 메뉴 조회
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/yp_decorator/yp_session_exist")
	public ModelAndView yp_session_exist(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		 Map menu = lService.CreateMenuByAuth(request, response);
		 //logger.info("menu : {}",menu);
		 mav.addObject("menu", menu);
		 mav.addObject("hierarchy", menu.get("hierarchy"));
		mav.setViewName("/yp/decorators/yp_session_exist");
		return mav;
	}

	/**
	 * 영풍 웹포털 > 로그인 페이지 이동
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/yp/login/login")
	public ModelAndView view_login(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// RSA 키 생성
		PrivateKey key = (PrivateKey) request.getSession().getAttribute("RSAprivateKey");
		if (key != null) { // 기존 key 파기
			request.getSession().removeAttribute("RSAprivateKey");
		}

		RSA rsa = rsaUtil.createRSA();
		ModelAndView mav = new ModelAndView();
		mav.addObject("modulus", rsa.getModulus()); // 로그인폼에 hidden값 세팅준비
		mav.addObject("exponent", rsa.getExponent()); // 로그인폼에 hidden값 세팅준비
		request.getSession().setAttribute("RSAprivateKey", rsa.getPrivateKey()); // 세션에 RSA 개인키를 저장
		mav.setViewName("/yp/login/login");
		return mav;
	}
	
	/**
	 * 영풍 웹포털 > 로그아웃
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/yp/login/logout")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("/yp/login/login");
	}

	/**
	 * 영풍 웹포털 > 그룹웨어 통한 로그인
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/login/gwlogin")
	public ModelAndView gwlogin(HttpServletRequest request, HttpServletResponse response) throws Exception{

		String page = "";
		try{
			String userid = (String) request.getParameter("userid");
			String referer = (String)request.getHeader("referer") == null ? "" : (String)request.getHeader("referer");

			boolean loginCheck = (referer.contains("ypgw.ypzinc.co.kr") || referer.contains("gwdev.ypzinc.co.kr"));
			logger.debug("gwlogin - "+referer);
			
			page = login_process(loginCheck,userid,request,response);

		}catch(Exception e){
			e.printStackTrace();
			page = "/yp/login/login";
		}
		
		
		RedirectView rv = new RedirectView(page);
		rv.setExposeModelAttributes(false);
		return new ModelAndView(rv);
	}
	
	/**
	 * 영풍 웹포털 > 로그인
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/login/loginCheck", method = RequestMethod.POST)
	public ModelAndView select(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//		RequestMapUtil reqUtil = new RequestMapUtil();
		Util reqUtil = new Util();
		HashMap req_data = reqUtil.getParamToMapWithNull(request, false);
		boolean login = false;
		if (req_data.get("type").equals("vicurus")) {
			HttpSession session = request.getSession(false);
			if (session != null)
				session.invalidate(); // 초기화
			session = request.getSession(true);
			session.setAttribute("empCode", "9999");
			session.setAttribute("s_emp_code", "9999");
			session.setAttribute("userId", "9999");
			session.setAttribute("userName", "비큐러스정보기술");
			session.setAttribute("gubun", "user");
			session.setAttribute("auth", null);
			
			//20200416_khj sessionOut시 Action log 남기기 위한 필드
			session.setAttribute("s_action_log", action_log);
			session.setMaxInactiveInterval(60 * sessionoutTime);	//세션 유지시간(config의 세션타임아웃 참조)
			
//			mav.setViewName("/yp/main");
//			return mav;
			return new ModelAndView("redirect:/yp/main");
		} else if (req_data.get("type").equals("yp")) {
			login = lService.loginCheckUser((String) req_data.get("id"), (String) req_data.get("password"));
		} else if (req_data.get("type").equals("aff")) {
			login = lService.loginCheckAff((String) req_data.get("id"), (String) req_data.get("password"));
		} else if (req_data.get("type").equals("ent")) {
			login = lService.loginCheckEnt((String) req_data.get("id"), (String) req_data.get("password"));
			if(login) {
				/* 아이디 비밀번호 동일하면 비번 변경하도록 처리 */
				boolean reset = lService.loginCheckEnt_reset((String) req_data.get("id"), (String) req_data.get("password"));
				if(reset) {
					HashMap returnMap = new HashMap();
					returnMap.put("code", -99);
					returnMap.put("msg", "비밀번호를 변경해야 합니다.");
					return new ModelAndView("DataToJson", returnMap);
				}
			}
		}
		logger.debug("login - {}, {} ", req_data.get("type"), login);
		
		String id = (String) req_data.get("id");
		String page = login_process(login, id, request, response);
		
		if(login){
//			RedirectView rv = new RedirectView("/yp/main");
//			rv.setExposeModelAttributes(false);
//			return new ModelAndView(rv);
//			mav.setViewName("/yp/main");
//			return mav;
			HashMap returnMap = new HashMap();
			returnMap.put("code", 1);
			return new ModelAndView("DataToJson", returnMap);
//			return new ModelAndView("redirect:/yp/main");
		} else {
//			JS js = new JS(response);
//			js.alert("로그인 정보가 일치하지 않습니다.");
//			js.back();
//			js.flush();
//			return null;
			HashMap returnMap = new HashMap();
			returnMap.put("code", -1);
			returnMap.put("msg", "로그인 정보가 일치하지 않습니다.");
			return new ModelAndView("DataToJson", returnMap);
		}
	}

	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/popup/login/pwd_reset")
	public ModelAndView pwd_reset(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/login/pwd_reset_pop");
		return mav;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/login/update_pwd_reset")
	public ModelAndView update_pwd_reset(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap returnMap = new HashMap();
		returnMap.put("result", lService.update_pwd_reset(request, response));
		return new ModelAndView("DataToJson", returnMap);
	}

	/**
	 * 영풍 웹포털 > 메인 페이지 이동
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/yp/main")
	public ModelAndView view_main(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		//popupList 조회
		Map resultMap = boardService.popupYList(request,response);
		//게시판 조회
		List<Map> boardList = boardService.board_select(request,response);
		//
		int result = boardService.popupChk(request,response);
		
		
		HttpSession session = request.getSession();
		String emp_code = session.getAttribute("empCode").toString();
		
		mav.addObject("emp_code", emp_code);
			
		mav.addObject("popupData", resultMap);
		mav.addObject("popupNum", result);
		mav.addObject("boardList", boardList);
		
		mav.setViewName("/yp/main");
		return mav;
	}
	

	/**
	 * 영풍 웹포털 > 로그인
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/login/f_href_with_auth", method = RequestMethod.POST)
	public ModelAndView f_href_with_auth(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap returnMap = new HashMap();
		returnMap.put("code", lService.f_href_with_auth(request, response));
		return new ModelAndView("DataToJson", returnMap);
	}
	
	/**
	 * 영풍 웹포털 > 로그인 프로세스
	 * 
	 * @param request
	 * @param response
	 * @return 
	 * @return
	 * @throws Exception
	 */
	String login_process(boolean check, String id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String page = "";
		
		if (check) {
			// userInfoSet(req_data, request, response);
			HashMap map = lService.retrieveUserInfo(id);
			logger.debug("map : " + map);
			ArrayList<HashMap> auth_map = lService.retrieveUserAuth((String) map.get("EMP_CD"));
			ArrayList<HashMap> s_authogrp_code = lService.retrieveUserSysAuth((String) map.get("EMP_CD"));
//				logger.debug("auth_map : " + auth_map);

			HttpSession session = request.getSession(false);
			if (session != null)
				session.invalidate(); // 초기화
			session = request.getSession(true);

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

			// 20200416_khj sessionOut시 Action log 남기기 위한 필드
			session.setAttribute("s_action_log", action_log);
			session.setMaxInactiveInterval(60 * sessionoutTime); // 세션 유지시간(config의 세션타임아웃 참조)

			if ("user".equals(map.get("GUBUN"))) {
				HashMap userPos = lService.retrieveUserPosition(id);
				session.setAttribute("userDeptCd", userPos.get("DEPT_CD"));
				session.setAttribute("userDept", userPos.get("DEPT_NAME"));
				session.setAttribute("userPosCd", userPos.get("POS_CD"));
				session.setAttribute("userPos", userPos.get("POS_NAME"));
				session.setAttribute("userOfcCd", userPos.get("OFC_CD"));
				session.setAttribute("userOfc", userPos.get("OFC_NAME"));
				session.setAttribute("corpCode", "YPZINC");
				session.setAttribute("corpName", "(주)영풍");
				logger.debug("loginCont.userDeptCd=" + session.getAttribute("userDeptCd") + " / " + userPos.get("DEPT_CD"));

				// 도시락관리 추가
				HashMap workinfo = lService.retrieveWorkInfo((String) map.get("EMP_CD"));
				if (workinfo != null) {
					session.setAttribute("zclss", workinfo.get("ZCLSS"));
					session.setAttribute("zclst", workinfo.get("ZCLST"));
					session.setAttribute("schkz", workinfo.get("SCHKZ"));
					session.setAttribute("jo_name", workinfo.get("JO_NAME"));
				}
			}
			
			if("aff".equals((String)map.get("GUBUN"))){
				HashMap compay = lService.retrieveAffCorp(id);
				session.setAttribute("corpCode", compay.get("CORP_CODE"));
				session.setAttribute("corpName", compay.get("CORP_NAME"));
			}
			
			// [yp3] 2021-10-25 jamerl - 협력사 로그인시 업체코드, 명칭 세션 설정
			if("ent".equals((String)map.get("GUBUN"))){
				HashMap compay = lService.retrieveEntCorp(id);
				session.setAttribute("ent_ent_code", compay.get("ENT_CODE"));
				session.setAttribute("ent_vendor_code", compay.get("ENT_VENDOR_CODE"));
				session.setAttribute("ent_vendor_name", compay.get("ENT_VENDOR_NAME"));
			}
			
			page = "/yp/main";
//			RedirectView rv = new RedirectView(page);
//			rv.setExposeModelAttributes(false);
//			return new ModelAndView(rv);

		} else {

			page = "/yp/login/login";
//			RedirectView rv = new RedirectView(page);
//			rv.setExposeModelAttributes(false);
//			return new ModelAndView(rv);
		}
		return page;
	}
	
}
