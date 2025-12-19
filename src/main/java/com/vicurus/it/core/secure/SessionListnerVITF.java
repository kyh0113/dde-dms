package com.vicurus.it.core.secure;

import java.sql.SQLException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.ibatis.session.SqlSession;
//import org.joda.time.format.DateTimeFormat;
//import org.joda.time.format.DateTimeFormatter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.FrameworkServlet;

import com.vicurus.it.core.common.srvc.intf.CommonService;
import com.vicurus.it.core.common.util.ContextPropUtil;
import com.vicurus.it.core.login.srvc.LoginServiceImpl;
import com.vicurus.it.core.login.srvc.intf.LoginService;

@Component
public class SessionListnerVITF implements HttpSessionListener {
	//HttpSessionListener는 스피링컨텍스트를 참조할 수 없어서 @Autowired로 객체를 생성할 수 없음
	
	
	private static final Logger logger = LoggerFactory.getLogger(SessionListnerVITF.class);
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public void sessionCreated(HttpSessionEvent arg0) {
		// 세션 생성시 호출
		HttpSession session = arg0.getSession();
		long time = session.getCreationTime();
//		DateTimeFormatter fmt = DateTimeFormat.forPattern("yyyy-MM-dd hh:mm:ss");
		HashMap hMap = new HashMap();
		hMap.put("s_emp_code", session.getAttribute("s_emp_code"));
		hMap.put("s_id", session.getId());
//		logger.debug("[{}]에 생성된 세션 - {}", fmt.print(time), hMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public void sessionDestroyed(HttpSessionEvent arg0){
		// 세션 만료시 호출
		HttpSession session = arg0.getSession();
//		Enumeration enm = session.getAttributeNames();
//		while(enm.hasMoreElements()){
//			logger.debug("getAttributeNames - {} : {}", enm.nextElement(), session.getAttribute(enm.nextElement().toString()));
//		}
		long last_time = session.getLastAccessedTime();
		long now_time = System.currentTimeMillis();
		HashMap hMap = new HashMap();
		hMap.put("s_emp_code", session.getAttribute("s_emp_code"));
		hMap.put("s_id", session.getId());
		logger.debug("{}ms 만에 세션이 죽음 - {}", now_time - last_time, hMap);
//		Enumeration enm = session.getAttributeNames();
//		while(enm.hasMoreElements()){
//			logger.debug("getAttributeNames - {} : {}", enm.nextElement(), session.getAttribute(enm.nextElement().toString()));
//			System.out.println("getAttributeNames?"+enm.nextElement());
//		}
		
		

		HashMap paramMap = new HashMap();
		paramMap.put("s_id", session.getId());							//session id
		paramMap.put("s_emp_code", session.getAttribute("s_emp_code"));	//user_id
		paramMap.put("ip", session.getAttribute("ip"));					//ip


		logger.debug("세션정보 {}", paramMap);
		

		if(session.getAttribute("s_emp_code") != null){
			
			//WebApplicationContextUtils으로 직접 스프링컨텍스트를 불러와서 service를 찾고 직접 생성해야 한다.
			WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext( session.getServletContext(), FrameworkServlet.SERVLET_CONTEXT_PREFIX + "appServlet" );
			CommonService commonService = (CommonService) context.getBean("commonServiceImpl");
			LoginServiceImpl LoginService = (LoginServiceImpl) context.getBean("loginServiceImpl");

			//세션종료시 로그아웃 시간 기록하기
        	if("Y".equals(session.getAttribute("s_action_log"))) {
        		commonService.sysActionLog(paramMap);		//action logging
        	}
			LoginService.insertSysLog_Logout(paramMap);		//user logging

			
			//끝
		}
	}
}
