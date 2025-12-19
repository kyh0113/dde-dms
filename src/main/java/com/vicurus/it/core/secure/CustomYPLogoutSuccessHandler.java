package com.vicurus.it.core.secure;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.stereotype.Component;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.FrameworkServlet;

import com.vicurus.it.core.common.srvc.intf.CommonService;
import com.vicurus.it.core.common.util.ContextPropUtil;
import com.vicurus.it.core.login.srvc.intf.LoginService;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class CustomYPLogoutSuccessHandler implements LogoutSuccessHandler {

	@Autowired
	@Resource(name = "prop")
	public ContextPropUtil prop;
	public static String SYS_ACTION_LOG;

	private static final Logger logger = LoggerFactory.getLogger(CustomYPLogoutSuccessHandler.class);

	@PostConstruct
	void init() {
		SYS_ACTION_LOG = prop.get("sys.action_log");
	}

	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {

		// WebApplicationContextUtils으로 직접 스프링컨텍스트를 불러와서 service를 찾고 직접 생성해야 한다.
		WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext(), FrameworkServlet.SERVLET_CONTEXT_PREFIX + "appServlet");
		CommonService commonService = (CommonService) context.getBean("commonServiceImpl");
		LoginService loginService = (LoginService) context.getBean("loginServiceImpl");

		try {
			// 세션종료시 로그아웃 시간 기록하기
			if (SYS_ACTION_LOG.equals("Y")) {
				commonService.sysActionLog(request); // action logging
			}
			loginService.updateLogout_datetime(request); // user logging
			request.getSession().invalidate();
		} catch (Exception e) {
			e.printStackTrace();
			commonService.finish("Y");
		} finally {
			// logger.debug("로그아웃시 finally");
		}
		logger.debug("시큐리티 로그오프 URL 패턴 - 영풍");
		response.setStatus(HttpServletResponse.SC_OK);
		response.sendRedirect("/yp/login/login");
	}
}
