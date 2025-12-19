package com.yp.zwc.eai.cntr;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONValue;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.vicurus.it.core.common.Util;
import com.yp.zwc.eai.srvc.intf.YP_ZWC_EAI_Service;

@Controller
public class YP_ZWC_EAI_Controller {
	@Autowired
	private YP_ZWC_EAI_Service zwc_eai_Service;
	
	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_EAI_Controller.class);
	
	/**
	 * 전자결재I/F - 도급월보 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zwc/eai/working_monthly_report")
	public void working_monthly_report(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String from = "【전자결재I/F】도급월보";
		logger.debug(from);
		List list = zwc_eai_Service.working_monthly_report(request, response);
		this.JsonFlush(request, response, list, from);
	}
	
	/**
	 * 전자결재I/F - 도급비 조정(안) 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zwc/eai/working_subc_pst_adj")
	public void working_subc_pst_adj(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String from = "【전자결재I/F】도급비 조정(안)";
		logger.debug(from);
		List list = zwc_eai_Service.working_subc_pst_adj(request, response);
		this.JsonFlush(request, response, list, from);
	}
	
	/**
	 * 전자결재I/F - 도급비 집계 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zwc/eai/working_subc_cost_count")
	public void working_subc_cost_count(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String from = "【전자결재I/F】도급비 집계";
		logger.debug(from);
		List list = zwc_eai_Service.working_subc_cost_count(request, response);
		this.JsonFlush(request, response, list, from);
	}
	
	/**
	 * 전자결재I/F - 소급비 집계 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zwc/eai/working_reto_cost_count")
	public void working_reto_cost_count(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String from = "【전자결재I/F】소급비 집계";
		logger.debug(from);
		List list = zwc_eai_Service.working_reto_cost_count(request, response);
		this.JsonFlush(request, response, list, from);
	}
	
	/**
	 * 전자결재I/F - 소급비 집계 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/eai/construction_chk_rpt")
	public void construction_chk_rpt(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String from = "【전자결재I/F】정비용역 검수보고서";
		logger.debug(from);
		List list = zwc_eai_Service.construction_chk_rpt(request, response);
		this.JsonFlush(request, response, list, from);
	}
		

	
	/**
	 * 전자결재I/F - 전자결재 상태변경
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked"})
	@RequestMapping(value = "/yp/zwc/eai/working_eai_status")
	public void working_eai_status(HttpServletRequest request, HttpServletResponse response){
		String from = "【상태변경I/F】도급월보";
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		String RESULT = "";
		String MESSAGE = "";
		
		logger.debug(from);
		try {
			int result = 0;
			result = zwc_eai_Service.working_eai_status(request, response);
			logger.debug("UPDATE {} 건 완료", result);
			if(result > 0) {
				RESULT = "S";
				MESSAGE = "성공";
				map.put("RESULT", RESULT);
				map.put("MESSAGE", MESSAGE);
				list.add(map);
			}else {
				RESULT = "E";
				MESSAGE = "상태가 변경 된 대상이 존재하지 않습니다.";
				map.put("RESULT", RESULT);
				map.put("MESSAGE", MESSAGE);
				list.add(map);
			}
		} catch (Exception e) {
			logger.error("{} - {}", e.getCause(), e.toString());
			RESULT = "E";
			MESSAGE = this.subStrByte(e.toString(), 4000);
			map.put("RESULT", RESULT);
			map.put("MESSAGE", MESSAGE); // 4000바이트 초과 문자열 잘라내기
			list.add(map);
			e.printStackTrace();
		} finally {
			logger.debug("{}", list);
			this.JsonFlush(request, response, list, from);
			// 2020-10-289 jamerl - 처리 결과 로깅 테이블에 INSERT 처리 (전정대 - 화면으로 확인하지는 않기로 함)
			try {
				Util util = new Util();
				HashMap<String, Object> finalMap = (HashMap<String, Object>) util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
				finalMap.put("RESULT", RESULT);
				finalMap.put("MESSAGE", MESSAGE);
				zwc_eai_Service.working_eai_log(finalMap);
			}catch (Exception e) {
				logger.error("[{}] - [{}]", e.getMessage(), e);
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * JSON Flush 기능
	 * @param request
	 * @param response
	 * @param list
	 * @param from
	 */
	@SuppressWarnings({"rawtypes", "static-access"})
	private void JsonFlush(HttpServletRequest request, HttpServletResponse response, List list, String from) {
		PrintWriter out = null;
		try {
			Util util = new Util();
			String jsonString = JSONValue.toJSONString(list);
			response.setContentType("text/plain;charset=utf-8");// json
			jsonString = jsonString.replace("\"org.springframework.validation.BindingResult.string\":org.springframework.validation.BeanPropertyBindingResult: 0 errors,", "");
			
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
	 * byte단위로 문자열을 자르는 함수
	 *  - 2바이트, 3바이트 문자열이 잘리는 부분은 제거 (한글 등)
	 *  - 자르고 뒤에 ...을 붙인다.
	 * @param str : 자를 문자열
	 * @param cutlen : 자를 바이트 수
	 * @return 자르고 뒤에 ...을 붙인 문자열
	 */
	private String subStrByte(String str, int cutlen) {
		if(!str.isEmpty()) {
			str = str.trim();
			if(str.getBytes().length <= cutlen) {
				return str;
			} else {
				StringBuffer sbStr = new StringBuffer(cutlen);
				int nCnt = 0;
				for(char ch: str.toCharArray())
				{
					nCnt += String.valueOf(ch).getBytes().length;
					if(nCnt > cutlen)  break;
					sbStr.append(ch);
				}
				return sbStr.toString();
			}
		}
		else {
			return "";
		}
	}
}
