package com.vicurus.it.core.auth.cntr;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.vicurus.it.core.auth.srvc.intf.AuthService;
import com.vicurus.it.core.common.Util;
import com.yp.login.srvc.intf.YPLoginService;


@Controller
public class AuthController {
	@Autowired
	private AuthService authService;
	
	@Autowired
	private YPLoginService lService;

	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(AuthController.class);
	
	//20191027_khj 한화생명 보안관련 항목으로 유추하기쉬운 관리자페이지 지양(URL변경)
	@RequestMapping(value="/core/staff/auth/auth_management", method = RequestMethod.POST)
	public ModelAndView init(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ModelAndView mav = new ModelAndView();
		mav.setViewName("/core/staff/auth/auth_management");
		return mav;
	}
	
	
	@RequestMapping(value="/core/staff/auth/mergeAuth", method = RequestMethod.POST)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ModelAndView mergeAuth(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map map = new HashMap();
		map = authService.mergeAuth(request, response);
		return new ModelAndView("DataToJson", map);	
	}
	
	
	/*
	 * ajax파라미터가 jsonstr 이므로 paramData로 받아서 jackson 라이브러리를 사용해 list로 컨버트 한다.
	 * */
	@RequestMapping(value="/core/staff/auth/authUserMenu_save", method = RequestMethod.POST)
	@ResponseBody
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ModelAndView authUserMenu_save(@RequestBody String paramData, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();
		ObjectMapper om = new ObjectMapper();
		
		List rowDatas = om.readValue(paramData, new TypeReference<List<Map>>(){});
		
		int result = authService.authUserMenu_save(rowDatas, request);

		resultMap.put("result", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/*
	 * ajax파라미터가 jsonstr 이므로 paramData로 받아서 jackson 라이브러리를 사용해 list로 컨버트 한다.
	 * */
	@RequestMapping(value="/core/staff/auth/deleteAuth", method = RequestMethod.POST)
	@ResponseBody
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ModelAndView deleteAuth(@RequestBody String paramData, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();
		ObjectMapper om = new ObjectMapper();
		List rowDatas = om.readValue(paramData, new TypeReference<List<Map>>(){});
		
		int result = authService.deleteAuth(rowDatas);
		
		resultMap.put("result", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/*
	 * ajax파라미터가 jsonstr 이므로 paramData로 받아서 jackson 라이브러리를 사용해 list로 컨버트 한다.
	 * */
	@RequestMapping(value="/core/staff/auth/mappingUserAuth", method = RequestMethod.POST)
	@ResponseBody
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ModelAndView mappingUserAuth(@RequestBody String paramData, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();
		ObjectMapper om = new ObjectMapper();
		List rowDatas = om.readValue(paramData, new TypeReference<List<Map>>(){});
		
		int result = authService.mappingUserAuth(rowDatas);
		
		resultMap.put("result", result);
		
		return new ModelAndView("DataToJson", resultMap);		
	
	}
	
	//20191028 smh 한화생명 보안관련. DB암복호화
	@RequestMapping(value="/core/staff/secure/dbEncryptDecrypt", method = RequestMethod.POST)
	public ModelAndView dbEncryptDecrypt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/core/staff/secure/dbEncryptDecrypt");
		return mav;
	}
	

	@RequestMapping(value="/core/staff/encrypt", method = RequestMethod.POST)
	@ResponseBody
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ModelAndView encrypt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, false);
		String encrypt = (String)paramMap.get("encrypt");
		
		Map resultMap = new HashMap();

		StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();  
        encryptor.setAlgorithm("PBEWITHMD5ANDDES");  
        encryptor.setPassword("mtgi1234");  
        String encrypt_result = encryptor.encrypt(encrypt);
		
		resultMap.put("encrypt_result", encrypt_result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/core/staff/decrypt", method = RequestMethod.POST)
	@ResponseBody
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ModelAndView decrypt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, false);
		String decrypt = (String)paramMap.get("decrypt");
		
		Map resultMap = new HashMap();

		StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();  
        encryptor.setAlgorithm("PBEWITHMD5ANDDES");  
        encryptor.setPassword("mtgi1234");  
        String decrypt_result = encryptor.decrypt(decrypt);
		
		resultMap.put("decrypt_result", decrypt_result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 관리자 > 시스템 관리 > 데이터 권한관리
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/core/staff/auth/data_auth_management", method = RequestMethod.POST)
	public ModelAndView data_auth_management(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】관리자 > 시스템 관리 > 데이터 권한관리");
		ModelAndView mav = new ModelAndView();
		
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		mav.setViewName("/core/staff/auth/data_auth_management");
		return mav;
	}
	
	/**
	 * 관리자 > 시스템 관리 > 데이터 권한관리 > 저장
	 * @param paramData
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/core/staff/auth/mappingUserDataAuth", method = RequestMethod.POST)
	@ResponseBody
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ModelAndView mappingUserDataAuth(@RequestBody String paramData, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【저장】관리자 > 시스템 관리 > 데이터 권한관리");
		Map resultMap = new HashMap();
		ObjectMapper om = new ObjectMapper();
		List rowDatas = om.readValue(paramData, new TypeReference<List<Map>>(){});
		
		int result = authService.mappingUserDataAuth(rowDatas);
		
		resultMap.put("result", result);
		
		return new ModelAndView("DataToJson", resultMap);
	
	}
}
