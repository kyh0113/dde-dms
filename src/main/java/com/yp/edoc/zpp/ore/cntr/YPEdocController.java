package com.yp.edoc.zpp.ore.cntr;

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
import org.springframework.web.servlet.ModelAndView;

import com.vicurus.it.core.common.Util;
import com.yp.edoc.zpp.ore.srvc.intf.YPEdocService;
import com.yp.login.srvc.intf.YPLoginService;
import com.yp.zpp.wsd.srvc.intf.YP_ZPP_WSD_Service;

@Controller
public class YPEdocController {

	private static final Logger logger = LoggerFactory.getLogger(YPEdocController.class);

	@Autowired
	private YPLoginService lService;
	@Autowired
	private YPEdocService edocService;
	@Autowired
	private YP_ZPP_WSD_Service zppService;
	
	
	/**
	 * 전자결재I/F - 정광심판판정 - 최종값 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/zpp/ore/zpp_ore_fixed_value/edoc/req_data") // /yp/test/get_test_data
	public void zpp_ore_fixed_value_edoc_req_data(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String from = "[전자결재I/F] 정광성분분석 최종값 데이터 요청";
		logger.debug(from);
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		logger.debug("[TEST]MASTER_ID:{}", paramMap.get("MASTER_ID").toString());
		
		Map masterMap = edocService.select_ore_analysis_master(paramMap);
		logger.debug("[TEST]masterMap:{}", masterMap);
		
		Map componentAnalysisMap = edocService.select_ore_component_analysis(paramMap);
		logger.debug("[TEST]componentAnalysisMap:{}", componentAnalysisMap);
		
		Map result = new HashMap<String, Object>();
		
		/**
		 * 광종
		 */
		result.put("material", masterMap.get("MATERIAL_NAME").toString());
		
		/**
		 * 업체
		 */
		result.put("seller", masterMap.get("SELLER_NAME").toString());
		
		/**
		 * 입항일자
		 */
		result.put("importDate", masterMap.get("IMPORT_DATE").toString());
		
		/**
		 * Lot Count
		 */
		result.put("lotCount", Integer.parseInt(Util.isEmpty(masterMap.get("LOT_COUNT")) ? "0" : masterMap.get("LOT_COUNT").toString()));
		
		/**
		 * 성분 평균값
		 */
		Map ingredientAverageMap = new LinkedHashMap<String, Object>();
		
		for(int i=1; i<31; i++){
			String ig_name = "IG_NAME_" + i;
			String ig_value = "IG_VALUE_" + i;
			ingredientAverageMap.put(componentAnalysisMap.get(ig_name).toString(), Double.parseDouble(componentAnalysisMap.get(ig_value).toString()));
		}
		
		result.put("ingredientAverageData", ingredientAverageMap);
		
		/**
		 * Particle Size
		 */
		Map particleSizeMap = new LinkedHashMap<String, Object>();
		
		particleSizeMap.put("100", Double.parseDouble(componentAnalysisMap.get("PM_100_VALUE").toString()));
		particleSizeMap.put("200", Double.parseDouble(componentAnalysisMap.get("PM_200_VALUE").toString()));
		particleSizeMap.put("325", Double.parseDouble(componentAnalysisMap.get("PM_325_VALUE").toString()));
		particleSizeMap.put("400", Double.parseDouble(componentAnalysisMap.get("PM_400_VALUE").toString()));
		particleSizeMap.put("-400", Double.parseDouble(componentAnalysisMap.get("PM_M400_VALUE").toString()));
		
		result.put("particleSizeData", particleSizeMap);
		
		
		/**
		 * Lot by Lot별 데이터
		 */
		List list = new LinkedList<LinkedHashMap<String, Object>>();
		
//		for(int i=0; i<lotCount; i++){
//			
//			lotByLotDataMap.put("LOT_NO", i+1);
//			//lotByLotDataMap.put("YPIG-0001", 52.99 + i); //Zn
//			//lotByLotDataMap.put("YPIG-0007", 142 + i);  //Ag
//			//lotByLotDataMap.put("YPIG-0023", 4.15 + i);  //SiO2
//			lotByLotDataMap.put("Zn", 52.99 + i);
//			lotByLotDataMap.put("Ag", 142 + i);
//			lotByLotDataMap.put("Sio2", 4.15 + i);
//			list.add(lotByLotDataMap);
//		}
		
		/**
		 * TODO : 나중에 다시 바꿔 줘야함. 임시적으로 하드코딩임.
		 * TODO LOT_1_IG_1_VALUE => LOT_1_IG_1_RES.
		 * 
		 * LOT_1_IG_1_VALUE : 1번 로트의 Zn 성분
		 * LOT_1_IG_2_VALUE : 1번 로트의 Ag 성분
		 * LOT_1_IG_3_VALUE : 1번 로트의 Sio2 성분
		 * 
		 * LOT_2_IG_1_VALUE : 2번 로트의 Zn 성분
		 * LOT_2_IG_2_VALUE : 2번 로트의 Ag 성분
		 * LOT_2_IG_3_VALUE : 2번 로트의 Sio2 성분
		 * 				.
		 * 				.
		 * 				.
		 */
		for(int i=1; i<31; i++){
			Map lotByLotDataMap = new LinkedHashMap<String, Object>();
			// 현재 하드코딩으로 
			for(int j=1; j<4; j++){
				String lot_ig = "LOT_" + i + "_IG_" + j + "_VALUE";
				lotByLotDataMap.put("LOT_NO", i);
				switch(j){
					case 1: lotByLotDataMap.put("Zn", Double.parseDouble(componentAnalysisMap.get(lot_ig).toString()));
							break;
					case 2: lotByLotDataMap.put("Ag", Double.parseDouble(componentAnalysisMap.get(lot_ig).toString()));
						break;
					case 3: lotByLotDataMap.put("Sio2", Double.parseDouble(componentAnalysisMap.get(lot_ig).toString()));
						break;
				}
				
			}
			list.add(lotByLotDataMap);
		}
		result.put("lotByLotData", list);
		
		
		String jsonString = JSONValue.toJSONString(result);
		
		Map resultMap = new HashMap<String, String>();
		resultMap.put("RESULT", jsonString);
		
		logger.debug("[TEST]resultMap:{}",resultMap);
		
		this.JsonFlush(request, response, resultMap, from);
	}
	
	/**
	 * 전자결재I/F - 정광심판판정 최종값 상태연동
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/zpp/ore/zpp_ore_fixed_value/edoc/status")
	public void zpp_ore_fixed_value_edoc_status(HttpServletRequest request, HttpServletResponse response){
		String from = "[상태변경I/F] 정광심판판정 최종값 상태연동";
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		String RESULT = "";
		String MESSAGE = "";
		
		try {
			int result = 0;
			
			Util util = new Util();
			HashMap paramMap = util.getParamToMapWithNull(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
			
			/**
			 * 전자결재 존재 유무에 따른 Insert, Update 
			 */
			Map edocInfo = edocService.select_ore_edoc_info_single(paramMap);
			logger.debug("edocInfo: {}", edocInfo);
			
			if(util.isEmpty(edocInfo)){
				// Insert
				result += edocService.insert_ore_edoc_info(paramMap);
			}else{
				// Update
				result += edocService.update_ore_edoc_status(paramMap);
			}
			
			
			logger.debug("INSERT/UPDATE {} 건 완료", result);
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
	 * 전자결재I/F - 정광심판판정 - 정광성분분석요청 공문
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@CrossOrigin(origins = "*", allowedHeaders = "*")
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/zpp/ore/zpp_ore_request/edoc/req_data_html") 
	public ModelAndView zpp_ore_request_edoc_req_data_html(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String from = "[전자결재I/F] 정광성분분석 최종값 데이터 요청";
		logger.debug(from);
		
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HashMap<String, String> map = new HashMap();
		map = edocService.zpp_ore_load_bl_edoc_info(paramMap);

		String jsonString = JSONValue.toJSONString(map);
		mav.addObject("bl_data_string", jsonString);
		mav.addObject("bl_data", map);
		mav.setViewName("/yp/zpp/ore/edoc/zpp_ore_request_edoc");

		return mav;
	}
	
	/**
	 * 전자결재I/F - 정광심판판정 - 정광성분분석 Seller 송부용 분석결과 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@CrossOrigin(origins = "*", allowedHeaders = "*")
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/zpp/ore/zpp_ore_seller_query/edoc/req_data_html") 
	public ModelAndView zpp_ore_seller_query_edoc_req_data_html(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String from = "[전자결재I/F] 정광성분분석 Seller 송부용 분석결과 조회";
		logger.debug(from);
		
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HashMap<String, String> map = new HashMap();
		map = edocService.zpp_ore_load_seller_query_edoc_info(paramMap);

		String jsonString = JSONValue.toJSONString(map);
		mav.addObject("req_data_string", jsonString);
		mav.addObject("req_data", map);
		
		logger.debug("[TEST]data_string:{}",jsonString);
		logger.debug("[TEST]data:{}",map);
		
		mav.setViewName("/yp/zpp/ore/edoc/zpp_ore_seller_query_edoc");

		return mav;
	}
	
	/**
	 * 전자결재I/F - 정광심판판정 - 정광성분분석 Seller 송부용 분석결과 상태연동
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/zpp/ore/zpp_ore_seller_query/edoc/status")
	public void zpp_ore_seller_query_edoc_status(HttpServletRequest request, HttpServletResponse response){
		String from = "[상태변경I/F] 정광성분분석 Seller 송부용 분석결과 상태연동";
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		String RESULT = "";
		String MESSAGE = "";
		
		try {
			int result = 0;
			
			Util util = new Util();
			HashMap paramMap = util.getParamToMapWithNull(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
			
			/**
			 * 전자결재 존재 유무에 따른 Insert, Update 
			 */
			Map edocInfo = edocService.select_ore_edoc_info_single(paramMap);
			logger.debug("edocInfo: {}", edocInfo);
			
			if(util.isEmpty(edocInfo)){
				// Insert
				result += edocService.insert_ore_edoc_info(paramMap);
			}else{
				// Update
				result += edocService.update_ore_edoc_status(paramMap);
			}
			
			
			logger.debug("INSERT/UPDATE {} 건 완료", result);
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
	 * 전자결재I/F - 정광심판판정 - Seller 성분분석결과 비교 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@CrossOrigin(origins = "*", allowedHeaders = "*")
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/zpp/ore/zpp_ore_seller_compare/edoc/req_data_html") 
	public ModelAndView zpp_ore_seller_compare_edoc_req_data_html(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String from = "[전자결재I/F] 정광성분분석 Seller 송부용 분석결과 조회";
		logger.debug(from);
		
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List list = edocService.zpp_ore_load_seller_compare_edoc_info(paramMap);

		String jsonString = JSONValue.toJSONString(list);
		mav.addObject("req_data_string", jsonString);
		mav.addObject("req_data", list);
		
		logger.debug("[TEST]data_string:{}",jsonString);
		logger.debug("[TEST]data:{}",list);
		
		mav.setViewName("/yp/zpp/ore/edoc/zpp_ore_seller_compare_edoc");

		return mav;
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
