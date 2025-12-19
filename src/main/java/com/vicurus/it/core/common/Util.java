package com.vicurus.it.core.common;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoTable;
import com.yp.sap.SapJcoConnection;

public class Util {
	private double count;
	private double page;
	private int start;
	private double row_view;	//현재 보여질 페이지
	private double totalPage;
	
	private static final Logger logger = LoggerFactory.getLogger(Util.class);
	
	/**
     * 빈 값인지 체크
     * @param str
     * @return
     */
    public boolean isNull(String str) {
        return (str == null || "".equals(str.trim()));
    }
	/**
     * request객체의 인자들을 Map 객체에 셋팅한다. 
     * @param request
     * @return parametersMap
     */
    @SuppressWarnings("rawtypes")
	public Map getParamToMap(HttpServletRequest request){
    	
		return getParamToMap(request, false);
	}
    /**
     * request객체의 인자들을 Map 객체에 셋팅한다. <br>
     * 파라미터명을 대문자로 처리하고자 할 경우 추가 파라미터 설정. 
     * @param request
     * @param convertParamNameToUpperCase 대소문자로 할 경우 true, 아무 변환도 안 할 경우 false
     * @return parametersMap
     */     
    @SuppressWarnings({ "unchecked", "rawtypes" })
	public Map getParamToMap(HttpServletRequest request, boolean convertParamNameToUpperCase){ //ICM 사용 - 20180809 하태현
    	
		Enumeration em = request.getParameterNames();
		
		Map parametersMap = new HashMap();
		
		String reqType = "N";
		String cntType = request.getContentType();
		if(!isNull(cntType)){
			if("multi".equals(cntType.substring(0, 5))){
				reqType = "Y";
			}
		}
		// 세션정보 삽입.
		//String ip = request.getHeader("X-FORWARDED-FOR");
		

		String s_emp_code = request.getSession().getAttribute("s_emp_code") == null ? "" : request.getSession().getAttribute("s_emp_code").toString();
		String s_emp_name = request.getSession().getAttribute("s_emp_name") == null ? "" : request.getSession().getAttribute("s_emp_name").toString();
		String s_authogrp_code = request.getSession().getAttribute("s_authogrp_code") == null ? "" : request.getSession().getAttribute("s_authogrp_code").toString();
		String s_dept_code = request.getSession().getAttribute("s_dept_code") == null ? "" : request.getSession().getAttribute("s_dept_code").toString();
		String s_position_code = request.getSession().getAttribute("s_position_code") == null ? "" : request.getSession().getAttribute("s_position_code").toString();
		String s_dept_name = request.getSession().getAttribute("s_dept_name") == null ? "" : request.getSession().getAttribute("s_dept_name").toString();
		String s_status = request.getSession().getAttribute("s_status") == null ? "" : request.getSession().getAttribute("s_status").toString();
		String ip = request.getSession().getAttribute("ip") == null ? "" : request.getSession().getAttribute("ip").toString();
		// 2020-08-19 jamerl - 데이터범위권한 추가
		String auth = request.getSession().getAttribute("auth") == null ? "US" : request.getSession().getAttribute("auth").toString();
		

		parametersMap.put("s_emp_code", s_emp_code);
		parametersMap.put("empCode", s_emp_code);
		parametersMap.put("s_emp_name", s_emp_name);
		parametersMap.put("s_authogrp_code", s_authogrp_code);
		parametersMap.put("s_dept_code", s_dept_code);
		parametersMap.put("s_position_code", s_position_code);
		parametersMap.put("s_dept_name", s_dept_name);
		parametersMap.put("s_status", s_status);
		parametersMap.put("ip", ip);
		parametersMap.put("auth", auth);
		
		
		while (em.hasMoreElements()) {
			
			String str = (String) em.nextElement();
			if(str.equals("stringList")){continue;}
			
			String[] vals = request.getParameterValues(str);
			
			if(vals != null && vals.length>1) {
//				parametersMap.put((convertParamNameToUpperCase ? str.toUpperCase(): str), vals);	// 2015-12-14 jamerl  배열로 넘어온 데이터 맵으로 담으면 덮어씌워져서 리스트로 처리 
				List parametersList = new ArrayList();
//				logger.debug("\t[param:array] "+str);
				if(logger.isDebugEnabled()){
					for(int i=0; i<vals.length; i++){
						
						if(!isNull(vals[i])){
//							parametersMap.put((convertParamNameToUpperCase ? str.toUpperCase(): str), new String(vals[i].trim())); // 2015-12-14 jamerl 주석처리
							parametersList.add(new String(vals[i].trim()));	// 2015-12-14 jamerl 배열로 넘어온 데이터 맵으로 담으면 덮어씌워져서 리스트로 처리
						}
//						logger.debug("\t[param:array] "+str + " : "	+ vals[i]);	// 2015-12-14 jamerl 주석처리
					}
					str = str.replaceAll("\\[", "");	// 2015-12-14 jamerl "[", "]" 없앰
					str = str.replaceAll("\\]", "");	// 2015-12-14 jamerl "[", "]" 없앰
					if("mi".equals(str)){
						parametersMap.put("s_menu_id", parametersList);
					}else{
						logger.debug("\t[param:array] "+str + " : "	+ parametersList);
						// 여기서 넣는다.
						parametersMap.put((convertParamNameToUpperCase ? str.toUpperCase(): str), parametersList);
					}
				}
			}else{
				String val = "";
				if("Y".equals(reqType)){
					val = request.getParameter(str);
				}else{
					val = request.getParameter(str);
				}
				if(!isNull(val)){
					if("mi".equals(str)){
						parametersMap.put("s_menu_id", new String(val.trim()));
						request.getSession().setAttribute("s_menu_id", new String(val.trim()));
					}else{
						String[] array = null;
						if(str.startsWith("vitf_for_in_")){
							logger.debug("{}, {}", val, val.getClass().toString());
							array = val.split("▧");
							logger.debug("{}, {}", array, array.getClass().toString());
							List<String> param_list = new ArrayList(Arrays.asList(array));
							logger.debug("\t[param] "+str + " : "	+ param_list);
							parametersMap.put((convertParamNameToUpperCase ? str.toUpperCase(): str), param_list);
						}else{
							logger.debug("\t[param] "+str + " : "	+ val);
							parametersMap.put((convertParamNameToUpperCase ? str.toUpperCase(): str), new String(val.trim()));	
						}
					}
				}
			}
		}

		
		logger.debug("\t[empCode ] [{}]", s_emp_code );
		logger.debug("\t[s_emp_code ] [{}]", s_emp_code );
		logger.debug("\t[s_emp_name ] [{}]", s_emp_name );
		logger.debug("\t[s_authogrp_code ] [{}]", s_authogrp_code );
		logger.debug("\t[s_dept_code  ] [{}]", s_dept_code );
		logger.debug("\t[s_position_code ] [{}]", s_position_code );
		logger.debug("\t[s_dept_name ] [{}]", s_dept_name );
		logger.debug("\t[s_status] [{}]", s_status);
		logger.debug("\t[ip] [{}]", ip);
		logger.debug("\t[auth] [{}]", auth);
		
		
		if(request.getAttribute("attach_no")!=null){
			parametersMap.put("attach_no", request.getAttribute("attach_no"));
		}
		return parametersMap;
	}
    
    /**
     * request객체의 인자들을 Map 객체에 셋팅한다.<br>getParamToMap과 차이점은 null 혹은 빈 값도 파라미터에 추가한다는 점이다.
     * 파라미터명을 대문자로 처리하고자 할 경우 추가 파라미터 설정. 
     * @param request
     * @param convertParamNameToUpperCase 대소문자로 할 경우 true, 아무 변환도 안 할 경우 false
     * @return parametersMap
     */     
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public HashMap getParamToMapWithNull(HttpServletRequest request, boolean convertParamNameToUpperCase){
    	
    	Enumeration em = request.getParameterNames();
    	
    	HashMap parametersMap = new HashMap();
    	
    	String reqType = "N";
    	String cntType = request.getContentType();
    	if(!isNull(cntType)){
    		if("multi".equals(cntType.substring(0, 5))){
    			reqType = "Y";
    		}
    	}
    	// 세션정보 삽입.
    	String s_emp_code = request.getSession().getAttribute("s_emp_code") == null ? "" : request.getSession().getAttribute("s_emp_code").toString();
    	String s_user_id = request.getSession().getAttribute("s_user_id") == null ? "" : request.getSession().getAttribute("s_user_id").toString();
    	String s_user_name = request.getSession().getAttribute("s_user_name") == null ? "" : request.getSession().getAttribute("s_user_name").toString();
    	String s_authogrp_code = request.getSession().getAttribute("s_authogrp_code") == null ? "" : request.getSession().getAttribute("s_authogrp_code").toString();
    	String s_dept_code = request.getSession().getAttribute("userDeptCd") == null ? "" : request.getSession().getAttribute("userDeptCd").toString();
    	
    	parametersMap.put("s_emp_code", s_emp_code);
    	parametersMap.put("emp_code", s_emp_code);
    	parametersMap.put("empCode", s_emp_code);
    	parametersMap.put("s_user_name", s_user_name);
    	parametersMap.put("s_dept_code", s_dept_code);
    	parametersMap.put("s_authogrp_code", s_authogrp_code);
    	
    	
    	logger.debug("\t[session:s_authogrp_code] [{}]", s_authogrp_code);
    	logger.debug("\t[session:s_emp_code] [{}]", s_emp_code);
    	logger.debug("\t[session:emp_code] [{}]", s_emp_code);
    	logger.debug("\t[session:empCode] [{}]", s_emp_code);
    	logger.debug("\t[session:s_user_name] [{}]", s_user_name);
    	logger.debug("\t[session:s_dept_code] [{}]", s_dept_code);
    	
    	while (em.hasMoreElements()) {
    		String str = (String) em.nextElement();
    		
    		String[] vals = request.getParameterValues(str);
    		
    		if(vals != null && vals.length>1) {
//				parametersMap.put((convertParamNameToUpperCase ? str.toUpperCase(): str), vals);	// 2015-12-14 jamerl  배열로 넘어온 데이터 맵으로 담으면 덮어씌워져서 리스트로 처리 
    			List parametersList = new ArrayList();
//				logger.debug("\t[param:array] "+str);
    			if(logger.isDebugEnabled()){
    				for(int i=0; i<vals.length; i++){
    					
//    					if(!isNull(vals[i])){
//							parametersMap.put((convertParamNameToUpperCase ? str.toUpperCase(): str), new String(vals[i].trim())); // 2015-12-14 jamerl 주석처리
    						parametersList.add(new String(vals[i].trim()));	// 2015-12-14 jamerl 배열로 넘어온 데이터 맵으로 담으면 덮어씌워져서 리스트로 처리
//    					}
//						logger.debug("\t[param:array] "+str + " : "	+ vals[i]);	// 2015-12-14 jamerl 주석처리
    				}
    				str = str.replaceAll("\\[", "");	// 2015-12-14 jamerl "[", "]" 없앰
    				str = str.replaceAll("\\]", "");	// 2015-12-14 jamerl "[", "]" 없앰
    				logger.debug("\t[param:array] "+str + " : "	+ parametersList);
    				// 여기서 넣는다.
    				parametersMap.put((convertParamNameToUpperCase ? str.toUpperCase(): str), parametersList);
    			}
    		}else{
    			String val = "";
    			if("Y".equals(reqType)){
    				val = request.getParameter(str);
    			}else{
    				val = request.getParameter(str);
    			}
    			if(!isNull(val)){
    				parametersMap.put((convertParamNameToUpperCase ? str.toUpperCase(): str), new String(val == null ? null : val.trim()));
    			}
    			logger.debug("\t[param] "+str + " : "	+ val);
    		}
    	}
    	return parametersMap;
    }
  	
  	@SuppressWarnings("rawtypes")
	public int getTotalPage(Map paramHash, Double count){
  		this.count = count;
  		if(this.count > 0){
  			this.row_view = Double.parseDouble(paramHash.get("rows").toString());
  			this.page = Double.parseDouble(paramHash.get("page").toString());
  			this.totalPage =   Math.ceil(this.count / row_view);
  		}else{
  			this.totalPage = 0;
  		}
  		
  		if(this.page > this.totalPage){
  			this.totalPage = this.page;
  		}
  		return (int)totalPage;
  	}
  	
  	public int getPage(){
  		return (int)this.page;
  	}
  	
  	public int start(){
  		start = (((int)this.row_view * (int)this.page) - (int)this.row_view) + 1;
  		return start;
  	}
  	
  	public int end(){
  		return (int)this.row_view * (int)this.page;
  	}
  	
  	/**
     * date값을 받아와서 날짜형식이 맞는지 체크후 true or false 리턴
     * @param date
     * @return boolean
     */
    public static boolean isDate(CharSequence date) {

    	// some regular expression
    	String time = "(\\s(([01]?\\d)|(2[0123]))[:](([012345]\\d)|(60))"
    	+ "[:](([012345]\\d)|(60)))?"; // with a space before, zero or one time

    	// no check for leap years (Schaltjahr)
    	// and 31.02.2006 will also be correct
    	String day = "(([12]\\d)|(3[01])|(0?[1-9]))"; // 01 up to 31
    	String month = "((1[012])|(0\\d))"; // 01 up to 12
    	String year = "\\d{4}";

    	// define here all date format
    	ArrayList<Pattern> patterns = new ArrayList();
    	patterns.add(Pattern.compile(day + "[-.]" + month + "[-.]" + year + time));
    	patterns.add(Pattern.compile(year + "-" + month + "-" + day + time));
    	// here you can add more date formats if you want

    	// check dates
    	for (Pattern p : patterns){
    		if (p.matcher(date).matches()){
    			return true;
    		}			 		
    	}
    	return false;
    	}
    
    /**
     * 숫자형인지 체크후 true or false 리턴
     * @param string
     * @return boolean
     */
    public static boolean isNumber(String str_num) {
        try {
            double str = Double.parseDouble(str_num);
        }
        catch(NumberFormatException e) {
            return false;
        }
        return true;
    }
    
  
    /**
     * 문자열이 null이 아니면서 0보다 긴지 확인 후 true or false 리턴
     * @param value
     * @return
     */
    public static boolean validateRequired(String value) {
    	boolean isFieldValid = false;
    	if (value != null && value.trim().length() > 0) {
    		isFieldValid = true;
    	}
    	return isFieldValid;
    }
    
    /**
     * 문자열의 길이를 최소~최대길이확인 후 true or false 리턴
     * @param value
     * @param minLength
     * @param maxLength
     * @return
     */
    public static boolean validateLength(String value, int minLength, int maxLength) {
    	String validatedValue = value;    	
    	if (!validateRequired(value)) {
    		validatedValue = "";
    	}
    	return (validatedValue.length() >= minLength && validatedValue.length() <= maxLength);
    }
    
    /**
     * XSS 필터
     * @param value
     * @param minLength
     * @param maxLength
     * @return
     */
    public static String XSSFilter(String data){
    	data = data
    	//.replaceAll("&#", "")
    	//.replaceAll("&", "&amp;")
    	//.replaceAll("<", "&lt;")
    	//.replaceAll(">", "&gt;")
    	//.replaceAll("/", "&#x2F;")
    	.replaceAll("eval\\((.*)\\)", "")
    	.replaceAll("[\\\"\\'][\\s]*javascript:(.*)[\\\"\\']", "\"\"")
    	.replaceAll("[\\\"\\'][\\s]*vbscript:(.*)[\\\"\\']", "\"\"")
    	.replaceAll("document.cookie", "&#100;&#111;&#99;&#117;&#109;&#101;&#110;&#116;&#46;&#99;&#111;&#111;&#107;&#105;&#101;")
    	.replaceAll("<script", "&lt;script")
    	.replaceAll("script>", "script&gt;")
    	.replaceAll("<iframe", "&lt;iframe")
    	.replaceAll("<object", "&lt;object")
    	.replaceAll("<embed", "&lt;embed")
    	.replaceAll("onload", "no_onload")
    	.replaceAll("expression", "no_expression")
    	.replaceAll("onmouseover", "no_onmouseover")
    	.replaceAll("onmouseout", "no_onmouseout")
    	.replaceAll("onclick", "no_onclick");
    	return data;
    }
    
    /**
     * 클라이언트 IP주소 얻기
     * @param HttpServletRequest request
     * @return ip
     */
    public String getClientIp(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
 
        //logger.info(">>>> X-FORWARDED-FOR : " + ip);
 
        if (ip == null) {
            ip = request.getHeader("Proxy-Client-IP");
            //logger.info(">>>> Proxy-Client-IP : " + ip);
        }
        if (ip == null) {
            ip = request.getHeader("WL-Proxy-Client-IP"); // 웹로직
            //logger.info(">>>> WL-Proxy-Client-IP : " + ip);
        }
        if (ip == null) {
            ip = request.getHeader("HTTP_CLIENT_IP");
            //logger.info(">>>> HTTP_CLIENT_IP : " + ip);
        }
        if (ip == null) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
            //logger.info(">>>> HTTP_X_FORWARDED_FOR : " + ip);
        }
        if (ip == null) {
            ip = request.getRemoteAddr();
        }
        
        //logger.info(">>>> Result : IP Address : "+ip);
 
        return ip;
 
    }
    
    /**
     * 서버 시간 가져오기(월/일)
     * */
    public String getServerDate_MM_DD() {
    	SimpleDateFormat sdf = new SimpleDateFormat("MM/dd");
    	Calendar c1 = Calendar.getInstance();
    	String strToday = sdf.format(c1.getTime());
    	return strToday;
    }
    
    /**
     * 서버 시간 가져오기(시/분)
     * */
    public String getServerDate_HH_mm() {
    	SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
    	Calendar c1 = Calendar.getInstance();
    	String strToday = sdf.format(c1.getTime());
    	return strToday;
    }
    
    public String getIp(HttpServletRequest request) {
   	 
        String ip = request.getHeader("X-Forwarded-For");
 
        //logger.info(">>>> X-FORWARDED-FOR : " + ip);
 
        if (ip == null) {
            ip = request.getHeader("Proxy-Client-IP");
            //logger.info(">>>> Proxy-Client-IP : " + ip);
        }
        if (ip == null) {
            ip = request.getHeader("WL-Proxy-Client-IP"); // 웹로직
            //logger.info(">>>> WL-Proxy-Client-IP : " + ip);
        }
        if (ip == null) {
            ip = request.getHeader("HTTP_CLIENT_IP");
            //logger.info(">>>> HTTP_CLIENT_IP : " + ip);
        }
        if (ip == null) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
            //logger.info(">>>> HTTP_X_FORWARDED_FOR : " + ip);
        }
        if (ip == null) {
            ip = request.getRemoteAddr();
        }
        
        //logger.info(">>>> Result : IP Address : "+ip);
 
        return ip;
 
    }

	/**
	 * 페이징 from SAP(ArrayList<HashMap<String, String>>)
	 * @param erpList
	 * @param firstidx
	 * @param lastidx
	 * @return
	 * @throws Exception
	 */
	public ArrayList<HashMap<String, String>> pagingListOfERPList(ArrayList<HashMap<String, String>> erpList, int firstidx, int lastidx) throws Exception {

		ArrayList<HashMap<String, String>> pagingList = new ArrayList<HashMap<String, String>>();

		if (firstidx > lastidx) {
			int tmp = lastidx;
			lastidx = firstidx;
			firstidx = tmp;
		}
		if (lastidx > erpList.size()) {
			lastidx = erpList.size();
		}

		for (int i = firstidx; i <= lastidx; i++) {
			pagingList.add(erpList.get(i - 1));
			// System.out.println(i);
		}
		// logger.debug("pagingListOfERPList = "+pagingList);
		return pagingList;
	}
	
	/**
	 * 페이징 from SQL(List)
	 * @param erpList
	 * @param firstidx
	 * @param lastidx
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	public List pagingListOfERPList(List erpList, int firstidx, int lastidx) throws Exception {
		
		List pagingList = new ArrayList<HashMap<String, Object>>();
		
		if (firstidx > lastidx) {
			int tmp = lastidx;
			lastidx = firstidx;
			firstidx = tmp;
		}
		if (lastidx > erpList.size()) {
			lastidx = erpList.size();
		}
		
		for (int i = firstidx; i <= lastidx; i++) {
			pagingList.add(erpList.get(i - 1));
			// System.out.println(i);
		}
		// logger.debug("pagingListOfERPList = "+pagingList);
		return pagingList;
	}

	/**
	 * 문자열 오름차순
	 *
	 */
	public class StringAscCompare implements Comparator<HashMap<String, String>> {
		/**
		 * 오름차순(ASC)
		 */
		@Override
		public int compare(HashMap<String, String> arg0, HashMap<String, String> arg1) {
			return arg0.get("STEXT").compareTo(arg1.get("STEXT"));
		}

	}

	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> retrieveWorkShift(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("ZHR_GET_SEL_SCH");
		function.getImportParameterList().setValue("I_PERNR", req_data.get("emp_code"));
		function.getImportParameterList().setValue("I_BEGDA", StringUtils.replace((String) req_data.get("sdate"), "/", ""));
		function.getImportParameterList().setValue("I_ENDDA", StringUtils.replace((String) req_data.get("edate"), "/", ""));
		function.getImportParameterList().setValue("I_AUTH", req_data.get("auth"));
		logger.debug("RFC START");
		jcoConnect.execute(function);

		JCoTable table = function.getTableParameterList().getTable("T_SCHKZ");

		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
		// logger.debug("table = " + table);
		logger.debug("list = " + list);
		return list;
	}

	public ArrayList<HashMap<String, String>> retrieveWorkGroup(HashMap req_data) throws Exception {

		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("ZHR_GET_SEL_CLS");
		function.getImportParameterList().setValue("I_PERNR", req_data.get("emp_code"));
		function.getImportParameterList().setValue("I_BEGDA", StringUtils.replace((String) req_data.get("sdate"), "/", ""));
		function.getImportParameterList().setValue("I_ENDDA", StringUtils.replace((String) req_data.get("edate"), "/", ""));
		function.getImportParameterList().setValue("I_AUTH", req_data.get("auth"));
		function.getImportParameterList().setValue("I_OTYPE", "P");
		logger.debug("RFC START");
		jcoConnect.execute(function);

		JCoTable table = function.getTableParameterList().getTable("T_CLASS");
		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
		// logger.debug("list = " + list);
		Collections.sort(list, new StringAscCompare());
		// logger.debug("table = " + table);
		logger.debug("sort.list = " + list);
		return list;
	}

	public ArrayList<HashMap<String, String>> retrieveTeamname(HashMap req_data) throws Exception {

		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("ZHR_GET_ORG_PER");
		function.getImportParameterList().setValue("I_PERNR", req_data.get("emp_code"));
		function.getImportParameterList().setValue("I_BEGDA", StringUtils.replace((String) req_data.get("sdate"), "/", ""));
		function.getImportParameterList().setValue("I_ENDDA", StringUtils.replace((String) req_data.get("edate"), "/", ""));
		function.getImportParameterList().setValue("I_AUTH", req_data.get("auth"));
		if ("SA".equals(req_data.get("auth")) || "MA".equals(req_data.get("auth")))
			function.getImportParameterList().setValue("I_OTYPE", req_data.get("otype")); // I_OTYPE=O(부서),P(사원)
		logger.debug("RFC START");
		jcoConnect.execute(function);

		JCoTable table;
		if ("O".equals(req_data.get("otype")))
			table = function.getTableParameterList().getTable("T_ORGEH");
		else
			table = function.getTableParameterList().getTable("T_PERNR");

		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
		ArrayList<HashMap<String, String>> return_list = new ArrayList<HashMap<String, String>>();

		// 팀이외의 조직제거
		// String stext = "";
		// String temp = "";
		// for(int i=0;i<list.size();i++){
		// stext = list.get(i).get("STEXT");
		// temp = stext.substring(stext.length()-1);
		// if(temp.equals("팀") || temp.equals("실")) return_list.add(list.get(i));
		// else if(stext.equals("동해사무소") || stext.equals("비상환경안전단") || stext.equals("설비혁신TF")) return_list.add(list.get(i));
		// }

		// 정렬
		// Collections.sort(return_list, new StringAscCompare());
		Collections.sort(list, new StringAscCompare());
		// logger.debug("table = " + table);
		// logger.debug("list = " + list);
		// logger.debug("return_list = " + return_list);
		// return return_list;
		return list;
	}
	
	/**
     * JsonObject를 Map<String, String>으로 변환한다.
     *
     * @param jsonObj JSONObject.
     * @return Map<String, Object>.
     */
    @SuppressWarnings("unchecked")
    public static Map<String, Object> getMapFromJsonObject( JSONObject jsonObj ){
        Map<String, Object> map = null;
        try {
            map = new ObjectMapper().readValue(jsonObj.toJSONString(), Map.class) ;
        } catch (JsonParseException e) {
            e.printStackTrace();
        } catch (JsonMappingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
 
        return map;
    }
 
    /**
     * JsonArray를 List<Map<String, String>>으로 변환한다.
     *
     * @param jsonArray JSONArray.
     * @return List<Map<String, Object>>.
     */
    public static List<Map<String, Object>> getListMapFromJsonArray( JSONArray jsonArray ){
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        if( jsonArray != null ){
            int jsonSize = jsonArray.size();
            for( int i = 0; i < jsonSize; i++ ) {
                Map<String, Object> map = Util.getMapFromJsonObject( (JSONObject) jsonArray.get(i) );
                list.add( map );
            }
        }
        return list;
    }
    
    /**
	 * 문자열이 숫자인지 아닌지 판별
	 *
	 */
  	public static boolean isStringDouble(String s) {
  	    try {
  	        Double.parseDouble(s);
  	        return true;
  	    } catch (NumberFormatException e) {
  	        return false;
  	    }
  	}
  	
  	public static boolean isEmpty(Object object){
  		if(object == null || "".equals(object)){
  			return true;
  		}
  		return false;
  	}

}
