package com.vicurus.it.core.login.cntr;

import java.security.PrivateKey;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.vicurus.it.core.common.SessionList;
import com.vicurus.it.core.common.Util;
import com.vicurus.it.core.login.srvc.intf.LoginService;
import com.vicurus.it.core.secure.HttpRequestWithModifiableParameters;
import com.vicurus.it.core.secure.PasswordEncoding;
import com.vicurus.it.core.secure.RSA;
import com.vicurus.it.core.secure.RSAUtil;
import com.vicurus.it.core.secure.RequestWrapper;
import com.vicurus.it.core.secure.SHAPasswordEncoder;

@Controller
public class LoginController {
	
	//config.properties 에서 설정 정보 가져오기 시작
	@Value("#{config['session.outTime']}")
    private int sessionoutTime;
	
	@Value("#{config['sys.minIDLen']}")
	private int minIDLen;
	
	@Value("#{config['sys.maxIDLen']}")
	private int maxIDLen;
	
	@Value("#{config['company.name']}")
	private String companyName;
	
	@Value("#{config['sys.action_log']}")
	private String action_log;
	//config.properties 에서 설정 정보 가져오기 끝
	
	@Autowired
	private LoginService loginService;
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	//20191024_khj RSA 암호화 추가
	//public RSAUtil rsaUtil;
	RSAUtil rsaUtil = new RSAUtil();
	
	@RequestMapping(value="/core/login/sessionOK.do")
	public ModelAndView sessionOK(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map menu = loginService.CreateMenuByAuth(request, response);
		//logger.info("menu : {}",menu);
		request.setAttribute("menu", menu);
		return new ModelAndView("/core/decorators/sessionOK");
	}
	
	@RequestMapping(value="/core/login/sessionNO.do")
	public ModelAndView sessionNO(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("/core/decorators/sessionNO");
	}
	
	@RequestMapping(value="/core/login/sessionError.do")
	public ModelAndView sessionError(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("/core/login/sessionError");
//		return new ModelAndView("/");
	}
	
	@RequestMapping(value="/core/login/login")	//20191024_khj RSA 암호화 추가
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws Exception {		
		// RSA 키 생성
	    PrivateKey key = (PrivateKey) request.getSession().getAttribute("RSAprivateKey");
	    if (key != null) { // 기존 key 파기
	        request.getSession().removeAttribute("RSAprivateKey");
	    }
	    
	    RSA rsa = rsaUtil.createRSA();
	    ModelAndView mav = new ModelAndView();
	    mav.addObject("modulus", rsa.getModulus());									//로그인폼에 hidden값 세팅준비
	    mav.addObject("exponent", rsa.getExponent());								//로그인폼에 hidden값 세팅준비
	    request.getSession().setAttribute("RSAprivateKey", rsa.getPrivateKey());	//세션에 RSA 개인키를 저장
		mav.setViewName("/core/login/login");
	    
		return mav;
	}
	
	@RequestMapping(value="/core/login/logout.do", method = RequestMethod.POST)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("/core/login/login");
	}
	
	@RequestMapping(value="/core/login/ChkId.do", method = RequestMethod.POST)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ModelAndView ChkId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int cnt = 0;
		int login_fail_cnt = 0;
		Map map = new HashMap();
		List returnList = new ArrayList();
		SessionList sessionList = new SessionList();
		request.getSession().setMaxInactiveInterval(60 * sessionoutTime);	//세션 유지시간(config의 세션타임아웃 참조)
		
		//20191016_khj 로그인 아이디 유효성체크 시작
		Util util = new Util();
		String user_id = request.getParameter("uid") == null? "" : request.getParameter("uid");
		//String password = request.getParameter("upwd") == null? "" : request.getParameter("upwd");
		String password = request.getParameter("QSjJEwnV6COzaOemHJfMLA==") == null? "" : request.getParameter("QSjJEwnV6COzaOemHJfMLA==");	//upwd
		
		boolean chk = false;
	    if (util.validateRequired(user_id)) {
	    	if (util.validateLength(user_id, minIDLen, maxIDLen)) {	//ID 최소길이와 최대길이 체크
		    	chk = true;
		    }
	    }
	    //로그인 아이디 유효성체크 실패시
		if(!chk) {
			map.put("FROM_SERV_CD", -1);
			map.put("FROM_SERV_MSG", "로그인이 실패했습니다.(5회이상 실패시 계정이 잠깁니다.) \n올바른 로그인 정보임에도 지속적 실패인 경우 관리자에게 문의 주십시오.");
			return new ModelAndView("DataToJson", map);
		}
		//20191016_khj 로그인 아이디 유효성체크  끝
		
		
		//20191024_khj RSA
		// 개인키 취득
		//System.out.println("서버로 넘어온 개인키?"+request.getSession().getAttribute("RSAprivateKey"));
		//System.out.println("서버로 넘어온 비밀번호?"+password);
	    PrivateKey key = (PrivateKey) request.getSession().getAttribute("RSAprivateKey");
	    if (key == null) {
	    	map.put("FROM_SERV_CD", -7);
			map.put("FROM_SERV_MSG", "로그인이 실패했습니다.(5회이상 실패시 계정이 잠깁니다.) \n올바른 로그인 정보임에도 지속적 실패인 경우 관리자에게 문의 주십시오.");
			return new ModelAndView("DataToJson", map);
	    }
	 
	    //비밀번호 복호화
	    try {

	        String pw = rsaUtil.getDecryptText(key, password);
	        //System.out.println("복호화완료 PW:"+pw);
	        
	        // 복호화된 평문을 request에 다시 세팅해주기
	        HttpRequestWithModifiableParameters param = new HttpRequestWithModifiableParameters(request);
	        param.setParameter("upwd", pw); 
	        request = (HttpServletRequest)param;

	        
	    } catch (Exception e) {
	    	map.put("FROM_SERV_CD", -7);
			map.put("FROM_SERV_MSG", "로그인이 실패했습니다.(5회이상 실패시 계정이 잠깁니다.) \n올바른 로그인 정보임에도 지속적 실패인 경우 관리자에게 문의 주십시오.");
			return new ModelAndView("DataToJson", map);
	    }
	    //System.out.println("request에 비번 교체된지 확인?"+request.getParameter("upwd"));
	    //20191024_khj RSA
		

		try {
			
			//2019-10-28 smh DB PW암호화(SHA256 암호화).시작
			String upwd = request.getParameter("upwd");
			
			SHAPasswordEncoder shaPasswordEncoder = new SHAPasswordEncoder(256);
			
	        shaPasswordEncoder.setEncodeHashAsBase64(true);
	        
	        PasswordEncoding passwordEncoding = new PasswordEncoding(shaPasswordEncoder);

	        String upwdSHAEnc = passwordEncoding.encode(upwd);

	        // 복호화된 평문을 request에 다시 세팅해주기
	        HttpRequestWithModifiableParameters param = new HttpRequestWithModifiableParameters(request);
	        param.setParameter("upwd", upwdSHAEnc); 
	        request = (HttpServletRequest)param;
	        //2019-10-28 smh DB PW암호화(SHA256 암호화).끝
			//---------------------------------------------
			cnt = loginService.ChkId(request, response);
			logger.debug("결과는 [{}]입니다.", cnt);
			if(cnt > 0){				
				returnList = loginService.ChkIdPwd(request, response);
				Map returnMap = new HashMap();

				if(returnList.size() != 0 ){

					returnMap = (Map) returnList.get(0);

					//로그인 결과 파라메터
					if(returnMap.get("status").equals("D")){
						if(Integer.parseInt( String.valueOf(returnMap.get("diff_day"))) >= 60){
							// 20191027_khj ADD 2달이상 계정 미사용자 사용중지
							map.put("FROM_SERV_CD", -8);
							map.put("FROM_SERV_MSG", "2개월 이상 미사용 계정입니다. \n관리자에게 문의 주십시오.");
							return new ModelAndView("DataToJson", map);
						}else {
							map.put("FROM_SERV_CD", -2); // 사용불가 아이디 ICM
							map.put("FROM_SERV_MSG", "등록되어 있지 않은 계정이거나 잠긴 계정입니다. \n관리자에게 문의 주십시오.");
							return new ModelAndView("DataToJson", map);
						}	
					}
					if(returnMap.get("nowuse_yn").equals("Y")){
						map.put("FROM_SERV_CD", -3); // 이미로그인 ICM
						map.put("FROM_SERV_MSG", "이미 사용자가 로그온 되어 있는 계정입니다.");
						return new ModelAndView("DataToJson", map);
					}
					if(returnMap.get("authogrp_code").equals("NA")){ 
						map.put("FROM_SERV_CD", -4); // 내부통제 권한없음 ICM 
						map.put("FROM_SERV_MSG", "시스템 사용 권한이 없습니다.");
						return new ModelAndView("DataToJson", map);
					}
					if(returnMap.get("pwddateyn").equals("N")){
						map.put("FROM_SERV_CD", -5); // 비밀번호 초기화 해야함 111111임
						map.put("FROM_SERV_MSG", "초기암호입니다. 암호 변경 후 다시 로그인 해주십시오.");
						return new ModelAndView("DataToJson", map);
					}
					
					//20191028_khj 분기마다 1번씩 패스워드 변경하도록 처리(현재월의 분기정보와 패스워드변경월의 분기정보를 비교)
					//1월,2월,3월        = 1분기 
					//4월,5월,6월        = 2분기
					//7월,8월,9월        = 3분기
					//10월,11월,12월 = 4분기
					//System.out.println("현재분기?"+returnMap.get("current_month") + "::패스워드변경분기?"+returnMap.get("quarter_period"));
					if(!returnMap.get("current_month").equals(returnMap.get("quarter_period"))){
						map.put("FROM_SERV_CD", -9); // 비밀번호 초기화 해야함 111111임
						map.put("FROM_SERV_MSG", "보안정책으로 분기마다 암호변경이 필요합니다. \n암호 변경 후 다시 로그인 해주십시오.");
						return new ModelAndView("DataToJson", map);
					}
					
					map.put("FROM_SERV_CD", 1);
					map.put("FROM_SERV_MSG", "인증성공");
					map.put("FROM_SERV_INIT_PAGE", returnMap.get("init_page"));

					request.getSession().setAttribute("s_emp_code", returnMap.get("emp_code"));//사용자ID
					request.getSession().setAttribute("s_emp_name", returnMap.get("emp_name"));//사용자명
					request.getSession().setAttribute("s_authogrp_code", returnMap.get("authogrp_code"));//권한그룹
					request.getSession().setAttribute("s_dept_code", returnMap.get("dept_code"));//부서코드
					request.getSession().setAttribute("s_position_code", returnMap.get("position_code"));//직급코드
					request.getSession().setAttribute("s_dept_name", returnMap.get("dept_name"));//부서이름
					//request.getSession().setAttribute("s_pwddateYN", returnMap.get("pwddateYN"));//패스워드변경여부
					//request.getSession().setAttribute("s_nowuse_yn", returnMap.get("nowuse_yn"));//중복로그인방지
					request.getSession().setAttribute("s_status", returnMap.get("status"));// 사용여부상태 C = 생성 / D = 삭제
					//request.getSession().setAttribute("s_dcauthogrp_code", returnMap.get("dcauthogrp_code"));//공시사용여부
					
					//20200416_khj sessionOut시 Action log 남기기 위한 필드
					request.getSession().setAttribute("s_action_log", action_log);
					
					//20191203_khj 세션에 회사명 추가
					request.getSession().setAttribute("s_company_name", companyName);
					
					
					//20191027_khj 클라이언트 IP주소 얻는 방법 변경(인터셉터의 함수와 동일하기 위함)
					//request.getSession().setAttribute("ip", request.getRemoteAddr());//사용자 ip
					request.getSession().setAttribute("ip", util.getClientIp(request));//사용자 ip
					returnMap.put("ip", util.getClientIp(request));
					
					
					//20191015_khj 로긴 성공시 비밀번호 불일치카운트 초기화 및 로그인일시 기록
					loginService.InitLoginFailCnt(returnMap);
					
					
					//로그인 기록 남기기
					loginService.insertSysLog_Login(request, response);
					
					
					//20191015_khj 세션정보 담기(이중 로그인 방지)
					String session_id = request.getSession().getId();
					sessionList.getHashMap().put((String) returnMap.get("emp_code"),session_id);
					//request.getSession().setAttribute("session_id",session_id);
					
					// 로그인프로세스 최종단계에서 session에 저장된 개인키 초기화
				    request.getSession().removeAttribute("RSAprivateKey");
					
					return new ModelAndView("DataToJson", map);
				}else{//비번틀림

					login_fail_cnt = loginService.LoginFail(request, response); //비번불일치 5회 기능
					if(login_fail_cnt > 4){
						login_fail_cnt = 5;
						map.put("FROM_SERV_MSG", "로그인이 실패했습니다.(5회이상 실패시 계정이 잠깁니다.) \n올바른 로그인 정보임에도 지속적 실패인 경우 관리자에게 문의 주십시오.");
					}else{
						map.put("FROM_SERV_MSG", "로그인이 실패했습니다.(5회이상 실패시 계정이 잠깁니다.) \n올바른 로그인 정보임에도 지속적 실패인 경우 관리자에게 문의 주십시오.");
					}
					map.put("FROM_SERV_CD", -1);
					map.put("FROM_SERV_FAIL_CNT", login_fail_cnt);

				}
			}else{//아이디없음
				map.put("FROM_SERV_CD", -1);
				map.put("FROM_SERV_MSG", "로그인이 실패했습니다.(5회이상 실패시 계정이 잠깁니다.) \n올바른 로그인 정보임에도 지속적 실패인 경우 관리자에게 문의 주십시오.");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			String message = e.getMessage().substring(e.getMessage().lastIndexOf("Cause") , e.getMessage().length());
		    map.put("Exception", "(" + request.getRequestURI() +") " + message);
		}
		return new ModelAndView("DataToJson", map);
	}
	
	@RequestMapping(value="/core/login/resetPassword", method = RequestMethod.POST)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ModelAndView resetPassword(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map map = new HashMap();
		String new_password = request.getParameter("new_password") == null? "" : request.getParameter("new_password");

		//20191024_khj RSA
		// 개인키 취득
		//System.out.println("서버로 넘어온 개인키?" + request.getSession().getAttribute("RSAprivateKey"));
		//System.out.println("서버로 넘어온 비밀번호?" + new_password);
		PrivateKey key = (PrivateKey) request.getSession().getAttribute("RSAprivateKey");
		if (key == null) {
			map.put("FROM_SERV_CD", -1);
			map.put("FROM_SERV_MSG", "비밀번호 변경이 실패했습니다. \n다시 시도해주십시오. \n해당 증상 지속시 관리자에게 문의 주십시오.");
			return new ModelAndView("DataToJson", map);
		}

		// session에 저장된 개인키 초기화
		//request.getSession().removeAttribute("RSAprivateKey");

		// 비밀번호 복호화
		try {
			String pw = rsaUtil.getDecryptText(key, new_password);
			//System.out.println("복호화완료 PW:" + pw);

			// 복호화된 평문을 request에 다시 세팅해주기
			HttpRequestWithModifiableParameters param = new HttpRequestWithModifiableParameters(request);
			param.setParameter("new_password", pw);
			request = (HttpServletRequest) param;

		} catch (Exception e) {
			map.put("FROM_SERV_CD", -1);
			map.put("FROM_SERV_MSG", "비밀번호 변경이 실패했습니다. \n다시 시도해주십시오. \n해당 증상 지속시 관리자에게 문의 주십시오.");
			return new ModelAndView("DataToJson", map);
		}
		//System.out.println("request에 비번 교체된지 확인?" + request.getParameter("new_password"));
		// 20191024_khj RSA
		
		//2019-10-28 smh DB PW암호화(SHA256 암호화).시작
		String upwd = request.getParameter("new_password");
		
		SHAPasswordEncoder shaPasswordEncoder = new SHAPasswordEncoder(256);
		
        shaPasswordEncoder.setEncodeHashAsBase64(true);
        
        PasswordEncoding passwordEncoding = new PasswordEncoding(shaPasswordEncoder);

        String upwdSHAEnc = passwordEncoding.encode(upwd);

        // 복호화된 평문을 request에 다시 세팅해주기
        HttpRequestWithModifiableParameters param = new HttpRequestWithModifiableParameters(request);
        param.setParameter("upwd", upwdSHAEnc); 
        request = (HttpServletRequest)param;
        //2019-10-28 smh DB PW암호화(SHA256 암호화).끝
		
		map = loginService.resetPassword(request, response);
		map.put("FROM_SERV_CD", 1);
		return new ModelAndView("DataToJson", map);
	}
	
	// 중복로그인 알림 페이지
	@RequestMapping(value="/core/login/dup_login.do")
	public ModelAndView dup_login(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("/core/login/dup_login");
	}
	
	// 세션아웃 페이지
	@RequestMapping(value="/core/login/sessionOut.do")
	public ModelAndView sessionOut(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("/core/login/sessionOut");
	}
	
	// 최근 로그인로그 정보 가져오기
	@RequestMapping(value="/core/loginLogChk", method = RequestMethod.POST)
	public ModelAndView popupChk(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map resultMap = new HashMap();
		int loginLogNum = loginService.selectCntSysLog_Login(request,response);
		
		if(loginLogNum>1) {
			List list = loginService.selectSysLog_Login_Last(request,response);
			resultMap.put("loginLogLastInfo", list);
		}
		
		resultMap.put("loginLogNum", loginLogNum);
		return new ModelAndView("DataToJson", resultMap);
	}
}
