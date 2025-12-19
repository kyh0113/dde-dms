package com.vicurus.it.core.common.cntr;

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
import com.vicurus.it.core.common.srvc.intf.CommonService;
import com.vicurus.it.core.login.srvc.intf.LoginService;
import com.vicurus.it.core.secure.HttpRequestWithModifiableParameters;
import com.vicurus.it.core.secure.PasswordEncoding;
import com.vicurus.it.core.secure.RSA;
import com.vicurus.it.core.secure.RSAUtil;
import com.vicurus.it.core.secure.RequestWrapper;
import com.vicurus.it.core.secure.SHAPasswordEncoder;

@Controller
public class CommonController {
	
	//config.properties 에서 설정 정보 가져오기 시작
	@Value("#{config['session.outTime']}")
    private int sessionoutTime;
	
	//config.properties 에서 설정 정보 가져오기 끝
	
	@Autowired
	private CommonService commonService;
	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);
	
	
	
}
