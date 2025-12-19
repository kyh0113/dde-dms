package com.yp.api.endpoint.cntr;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONValue;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.vicurus.it.core.common.Util;
import com.yp.api.endpoint.srvc.intf.YPApiEndpointService;
import com.yp.login.srvc.intf.YPLoginService;

@Controller
public class YPApiEndpointController {

	private static final Logger logger = LoggerFactory.getLogger(YPApiEndpointController.class);

	@Autowired
	private YPLoginService lService;
	@Autowired
	private YPApiEndpointService apiEndpoinService;

	@CrossOrigin(origins = "*", allowedHeaders = "*")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/api/endpoint/get_daily_zinc_prod")
	public ModelAndView get_daily_zinc_prod(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List list = apiEndpoinService.select_daily_zinc_production(request, response);

		ModelAndView mav = new ModelAndView();
		mav.addObject("list", list);

		mav.setViewName("/yp/api/endpoint/daily_zinc_prod");
		return mav;
	}	
	
	

	/**
	 * DLP 정책 업데이트
	 *  - &quot; => " 로 변경
	 *  - 이유 : 그룹웨어 전자결재 문서에 "(쌍따옴포)를 저장할 수가 없었음. "(쌍따옴표) => quot;로 변경하여 저장 
	 *  - http://211.35.173.51:8080/WWSASTEST/api/isapi/sendisapi_json 로 업데이트 Request
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/api/sendisapi_json")
	public void SendIsapiJson(HttpServletRequest request, HttpServletResponse response) {
		String from = "[TEST] sendisapi_json";
		logger.debug(from);
		
		String jsonData = "";
		String targetURL = "http://211.35.173.51:8080/WWSAS/api/isapi/sendisapi_json"; //WWSAS_TEST
		
		logger.debug(targetURL);
		
		HttpURLConnection.setFollowRedirects(false);
		HttpURLConnection connection = null;
		
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		String RESULT = "";
		String MESSAGE = "";
		
		logger.debug("Try 들어가기 전");
		
		try {
			if(request.getParameter("JSON_DATA") != null){
				jsonData = request.getParameter("JSON_DATA").toString();
				jsonData = jsonData.replaceAll("&quot;", "\"");
				logger.debug("[TEST]jsonData:{}",jsonData);
				
				/**
				 * REST http Connection 생성
				 */
			    URL url = new URL(targetURL);
			    connection = (HttpURLConnection) url.openConnection();
			    connection.setRequestMethod("POST"); 
			    connection.setDoOutput(true);
			    connection.setRequestProperty("Content-Type", "application/json");
			    connection.setRequestProperty("Accept-Charset", "UTF-8"); 
			    connection.setConnectTimeout(10000);
			    connection.setReadTimeout(10000);
			    //logger.debug("응답코드 : " + connection.getResponseCode());

				logger.debug("==========connection 성공===================");
			    
			    /**
				 * REST http 요청 보내기
				 */
			    BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(connection.getOutputStream(), "UTF-8"));
			    bw.write(jsonData);
			    bw.flush();
			    bw.close();
			    
			    /**
			     * REST http response 받기
			     */
			    InputStream is = connection.getInputStream();
			    BufferedReader rd = new BufferedReader(new InputStreamReader(is, "UTF-8"));
			    
			    StringBuilder strBuilder = new StringBuilder(); 
			    String line;
			    while ((line = rd.readLine()) != null) {
			    	strBuilder.append(line);
			    	strBuilder.append('\r');
			    }
			    rd.close();
			    
			    /**
			     * PrintWriter로 반환 
			     */
			    RESULT = "S";
				MESSAGE = strBuilder.toString();
				map.put("RESULT", RESULT);
				map.put("MESSAGE", MESSAGE);
				list.add(map);
				
			    logger.debug("[TEST]DLP API 정책 적용 응답 : {}", MESSAGE);
			}
		} catch (Exception e) {
			RESULT = "E";
			MESSAGE = "에러발생";
			map.put("RESULT", RESULT);
			map.put("MESSAGE", e);
			list.add(map);
				
			logger.error(e.getMessage(), e);
		    e.printStackTrace();
		} finally {
		    if (connection != null) {
		        connection.disconnect();
		    }
		}
		
		this.JsonFlush(request, response, list, from);
	}
	
	

	
	

	/**
	 * JSON Flush 기능
	 * 
	 * @param request
	 * @param response
	 * @param list
	 * @param from
	 */
	@SuppressWarnings({ "rawtypes", "static-access" })
	private void JsonFlush(HttpServletRequest request, HttpServletResponse response, Object data, String from) {
		PrintWriter out = null;
		try {
			Util util = new Util();
			String jsonString = JSONValue.toJSONString(data);
			response.setContentType("text/plain;charset=utf-8");// json
			jsonString = jsonString.replace(
					"\"org.springframework.validation.BindingResult.string\":org.springframework.validation.BeanPropertyBindingResult: 0 errors,",
					"");

			// 20191026_khj XSS 필터적용
			jsonString = util.XSSFilter(jsonString);
			logger.debug("{} ReturnJson: {}", from, JsonEnterConvert(jsonString));

			out = response.getWriter();
			out.println(jsonString);
		} catch (IOException e) {
			logger.error("{} - {}", e.getMessage(), e);
			e.printStackTrace();
			System.err.println("IOException : " + e.getMessage());
		} catch (Throwable e) {
			logger.error("{} - {}", e.getMessage(), e);
			e.printStackTrace();
			System.err.println("Throwable : " + e.getMessage());
		} finally {
			out.flush();
			out.close();
		}
	}

	/**
	 * 디버깅용 JSON 보기좋게 표시
	 * 
	 * @param json
	 * @return
	 */
	private String JsonEnterConvert(String json) {
		if (json == null || json.length() < 2) {
			return json;
		}

		final int len = json.length();
		final StringBuilder sb = new StringBuilder();
		char c;
		String tab = "";
		boolean beginEnd = true;
		for (int i = 0; i < len; i++) {
			c = json.charAt(i);
			switch (c) {
			case '{':
			case '[': {
				sb.append(c);
				if (beginEnd) {
					tab += "\t";
					sb.append("\n");
					sb.append(tab);
				}
				break;
			}
			case '}':
			case ']': {
				if (beginEnd) {
					tab = tab.substring(0, tab.length() - 1);
					sb.append("\n");
					sb.append(tab);
				}
				sb.append(c);
				break;
			}
			case '"': {
				if (json.charAt(i - 1) != '\\')
					beginEnd = !beginEnd;
				sb.append(c);
				break;
			}
			case ',': {
				sb.append(c);
				if (beginEnd) {
					sb.append("\n");
					sb.append(tab);
				}
				break;
			}
			default: {
				sb.append(c);
			}
			}// switch end
		}
		if (sb.length() > 0)
			sb.insert(0, '\n');
		return sb.toString();
	}

	/**
	 * byte단위로 문자열을 자르는 함수 - 2바이트, 3바이트 문자열이 잘리는 부분은 제거 (한글 등) - 자르고 뒤에 ...을
	 * 붙인다.
	 * 
	 * @param str
	 *            : 자를 문자열
	 * @param cutlen
	 *            : 자를 바이트 수
	 * @return 자르고 뒤에 ...을 붙인 문자열
	 */
	private String subStrByte(String str, int cutlen) {
		if (!str.isEmpty()) {
			str = str.trim();
			if (str.getBytes().length <= cutlen) {
				return str;
			} else {
				StringBuffer sbStr = new StringBuffer(cutlen);
				int nCnt = 0;
				for (char ch : str.toCharArray()) {
					nCnt += String.valueOf(ch).getBytes().length;
					if (nCnt > cutlen)
						break;
					sbStr.append(ch);
				}
				return sbStr.toString();
			}
		} else {
			return "";
		}
	}
}
