package com.yp.test.cntr;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONValue;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.vicurus.it.core.common.Util;
import com.yp.login.srvc.intf.YPLoginService;
import com.yp.test.srvc.intf.YPTestService;
import com.yp.zpp.wsd.srvc.intf.YP_ZPP_WSD_Service;

@Controller
public class YPTestController {
	
	private static final Logger logger = LoggerFactory.getLogger(YPTestController.class);
	
	@Autowired
	private YPLoginService lService;
	@Autowired
	private YP_ZPP_WSD_Service zppService;
	@Autowired
	private YPTestService testService;
	
	@RequestMapping(value="/yp/test/testRoute", method = RequestMethod.POST)
	public ModelAndView testRoute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		ModelAndView mav = new ModelAndView();
		
		logger.debug("[화면호출]테스트 라우트");
		
		// 공통 - 네비게이션 시작
		List breadcrumbList = lService.select_breadcrumb_hierarchy(request, response);
		mav.addObject("breadcrumbList", breadcrumbList);
		mav.addObject("current_menu", breadcrumbList.get(breadcrumbList.size()-1));
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/test/test_route");
		return mav;
	}
	
	
	@RequestMapping(value="/yp/test/testDoc", method = RequestMethod.POST)
	public ModelAndView fixtureList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		ModelAndView mav = new ModelAndView();
		
		logger.debug("【화면호출】테스트 > 전자결재 테스트");
		
		// 공통 - 네비게이션 시작
		List breadcrumbList = lService.select_breadcrumb_hierarchy(request, response);
		mav.addObject("breadcrumbList", breadcrumbList);
		mav.addObject("current_menu", breadcrumbList.get(breadcrumbList.size()-1));
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/test/test_edoc");
		return mav;
	}
	
	@RequestMapping(value="/yp/test/testGrid", method = RequestMethod.POST)
	public ModelAndView testGrid(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		ModelAndView mav = new ModelAndView();
		
		logger.debug("【화면호출】테스트 > grid 테스트");
		
		// 공통 - 네비게이션 시작
		List breadcrumbList = lService.select_breadcrumb_hierarchy(request, response);
		mav.addObject("breadcrumbList", breadcrumbList);
		mav.addObject("current_menu", breadcrumbList.get(breadcrumbList.size()-1));
		// 공통 - 네비게이션 끝
		
		mav.setViewName("/yp/test/test_grid");
		return mav;
	}
	
//	@SuppressWarnings({"rawtypes", "unchecked"})
//	@RequestMapping(value = "/yp/test/get_test_data")
//	public void get_test_data(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		String from = "[전자결재I/F] 정광성분분석 데이터 테스트";
//		logger.debug(from);
//		
//		Util util = new Util();
//		HashMap paramMap = util.getParamToMapWithNull(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
//		logger.debug("[TEST]MASTER_ID:{}", paramMap.get("MASTER_ID").toString());
//		
//		Map result = new HashMap<String, Object>();
//		
//		int lotCount = 22;
//		
//		/**
//		 * 광종
//		 */
//		result.put("material", "Bolivian");
//		
//		/**
//		 * 업체
//		 */
//		result.put("seller", "BHP");
//		
//		/**
//		 * 입항일자
//		 */
//		result.put("importDate", "2019-01-28");
//		
//		/**
//		 * Lot Count
//		 */
//		result.put("lotCount", lotCount);
//		
//		/**
//		 * 성분 평균값
//		 */
//		Map ingredientAverageMap = new LinkedHashMap<String, Object>();
//		//ingredientAverageMap.put("YPIG-0001", 10);  //Zn
//		//ingredientAverageMap.put("YPIG-0002", 11);  //Fe
//		//ingredientAverageMap.put("YPIG-0003", 12);  //T.S
//		//ingredientAverageMap.put("YPIG-0004", 13);  //Pb
//		//ingredientAverageMap.put("YPIG-0005", 14);  //Cu
//		//ingredientAverageMap.put("YPIG-0006", 15);  //Cd
//		//ingredientAverageMap.put("YPIG-0007", 16);  //Ag
//		//ingredientAverageMap.put("YPIG-0008", 17);  //MgO
//		//ingredientAverageMap.put("YPIG-0009", 18);  //CaO
//		//ingredientAverageMap.put("YPIG-0010", 19);  //Mn
//		//ingredientAverageMap.put("YPIG-0011", 20);  //Ni
//		//ingredientAverageMap.put("YPIG-0012", 21);  //Sb
//		//ingredientAverageMap.put("YPIG-0013", 22);  //As
//		//ingredientAverageMap.put("YPIG-0014", 23);  //Co
//		//ingredientAverageMap.put("YPIG-0015", 24);  //Ge
//		//ingredientAverageMap.put("YPIG-0016", 25);  //Fe
//		//ingredientAverageMap.put("YPIG-0017", 26);  //Sn
//		//ingredientAverageMap.put("YPIG-0018", 27);  //Hg
//		//ingredientAverageMap.put("YPIG-0019", 28);  //Al2So3
//		//ingredientAverageMap.put("YPIG-0020", 29);  //In
//		//ingredientAverageMap.put("YPIG-0021", 39);  //Cr
//		//ingredientAverageMap.put("YPIG-0022", 31);  //Cl
//		//ingredientAverageMap.put("YPIG-0023", 32);  //SiO2
//		//ingredientAverageMap.put("YPIG-0024", 33);  //B
//		//ingredientAverageMap.put("YPIG-0025", 34);  //Se
//		//ingredientAverageMap.put("YPIG-0026", 35);  //Ga
//		//ingredientAverageMap.put("YPIG-0027", 36);  //Mo
//		//ingredientAverageMap.put("YPIG-0028", 37);  //Ti
//		//ingredientAverageMap.put("YPIG-0029", 38);  //Bi
//		//ingredientAverageMap.put("YPIG-0030", 39);  //K
//		//ingredientAverageMap.put("YPIG-0031", 40);  //Au
//		
//		ingredientAverageMap.put("Zn", 10); 
//		ingredientAverageMap.put("Fe", 11); 
//		ingredientAverageMap.put("T.S", 12); 
//		ingredientAverageMap.put("Pb", 13); 
//		ingredientAverageMap.put("Cu", 14); 
//		ingredientAverageMap.put("Cd", 15); 
//		ingredientAverageMap.put("Ag", 16); 
//		ingredientAverageMap.put("MgO", 17); 
//		ingredientAverageMap.put("CaO", 18); 
//		ingredientAverageMap.put("Mn", 19); 
//		ingredientAverageMap.put("Ni", 20); 
//		ingredientAverageMap.put("Sb", 21); 
//		ingredientAverageMap.put("As", 22); 
//		ingredientAverageMap.put("Co", 23); 
//		ingredientAverageMap.put("Ge", 24); 
//		ingredientAverageMap.put("Fe", 25); 
//		ingredientAverageMap.put("Sn", 26); 
//		ingredientAverageMap.put("Hg", 27); 
//		ingredientAverageMap.put("Al2So3", 28); 
//		ingredientAverageMap.put("In", 29); 
//		ingredientAverageMap.put("Cr", 39); 
//		ingredientAverageMap.put("Cl", 31); 
//		ingredientAverageMap.put("SiO2", 32); 
//		ingredientAverageMap.put("B", 33); 
//		ingredientAverageMap.put("Se", 34); 
//		ingredientAverageMap.put("Ga", 35); 
//		ingredientAverageMap.put("Mo", 36); 
//		ingredientAverageMap.put("Ti", 37); 
//		ingredientAverageMap.put("Bi", 38); 
//		ingredientAverageMap.put("K", 39); 
//		ingredientAverageMap.put("Au", 40); 
//
//		result.put("ingredientAverageData", ingredientAverageMap);
//		
//		/**
//		 * Particle Size
//		 */
//		Map particleSizeMap = new LinkedHashMap<String, Object>();
//		particleSizeMap.put("100", 0.02);
//		particleSizeMap.put("200", 1.08);
//		particleSizeMap.put("325", 4.46);
//		particleSizeMap.put("400", 1.24);
//		particleSizeMap.put("-400", 93.2);
//		result.put("particleSizeData", particleSizeMap);
//		
//		
//		/**
//		 * Lot by Lot별 데이터
//		 */
//		List list = new LinkedList<LinkedHashMap<String, Object>>();
//		for(int i=0; i<lotCount; i++){
//			Map lotByLotDataMap = new LinkedHashMap<String, Object>();
//			lotByLotDataMap.put("LOT_NO", i+1);
//			//lotByLotDataMap.put("YPIG-0001", 52.99 + i); //Zn
//			//lotByLotDataMap.put("YPIG-0007", 142 + i);  //Ag
//			//lotByLotDataMap.put("YPIG-0023", 4.15 + i);  //SiO2
//			lotByLotDataMap.put("Zn", 52.99 + i);
//			lotByLotDataMap.put("Ag", 142 + i);
//			lotByLotDataMap.put("Sio2", 4.15 + i);
//			list.add(lotByLotDataMap);
//		}
//		result.put("lotByLotData", list);
//		
//		String jsonString = JSONValue.toJSONString(result);
//		
//		Map resultMap = new HashMap<String, String>();
//		resultMap.put("RESULT", jsonString);
//		
//		logger.debug("[TEST]resultMap:{}",resultMap);
//		
//		this.JsonFlush(request, response, resultMap, from);
//	}
	
	/**
	 * 전자결재I/F - 정광심판판정 최종값 전자결재 상태연동
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_edoc_status")
	public void zpp_ore_edoc_status_update(HttpServletRequest request, HttpServletResponse response){
		String from = "[상태변경I/F] 정광심판판정 최종값 상태연동";
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		String RESULT = "";
		String MESSAGE = "";
		
		try {
			int result = 0;
//			result = zppService.fixture_edoc_status_update(request, response);
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
			//e.printStackTrace();
		} finally {
			logger.debug("{}", list);
			this.JsonFlush(request, response, list, from);
		}
	}
	
	@CrossOrigin(origins="*", allowedHeaders = "*")
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/test/get_test_data2")
	public ModelAndView get_test_data2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String from = "테스트";
		logger.debug(from);
		
		List list = testService.select_daily_zinc_production(request, response);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("list",list);
		
		mav.setViewName("/yp/test/test_html");
		return mav;
	}
	
	/**
	 * 전자결재I/F - 상태연동 테스트
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/test/status_test")
	public void status_test(HttpServletRequest request, HttpServletResponse response){
		String from = "[상태변경I/F] 상태연동";
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		String RESULT = "";
		String MESSAGE = "";
		
		try {
			int result = 0;
			if(request.getParameter("CODES") != null){
				logger.debug("[TEST]CODES:{}",request.getParameter("CODES").toString());
			}
			
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
			//e.printStackTrace();
		} finally {
			logger.debug("{}", list);
			this.JsonFlush(request, response, list, from);
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
	private void JsonFlush(HttpServletRequest request, HttpServletResponse response, Object data, String from) {
		PrintWriter out = null;
		try {
			Util util = new Util();
			String jsonString = JSONValue.toJSONString(data);
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

