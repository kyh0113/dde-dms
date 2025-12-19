package com.yp.zwc.ipt.srvc;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoTable;
import com.vicurus.it.core.common.Util;
import com.vicurus.it.core.common.WebUtil;
import com.yp.sap.SapJcoConnection;
import com.yp.zwc.ipt.srvc.intf.YP_ZWC_IPT_Service;

@Repository
public class YP_ZWC_IPT_ServiceImpl implements YP_ZWC_IPT_Service {
	
	// config.properties 에서 설정 정보 가져오기 시작
	private static String NAMESPACE;

	@SuppressWarnings("static-access")
	@Value("#{config['db.vendor']}")
	public void setNAMESPACE(String value) {
		this.NAMESPACE = value + ".";
	}
	// config.properties 에서 설정 정보 가져오기 끝

	@Autowired
	@Resource(name = "sqlSession")
	private SqlSession query;

	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_IPT_ServiceImpl.class);
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public List<HashMap<String, String>> select_zwc_ipt_performance(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		List<HashMap<String, String>> list = query.selectList(NAMESPACE + "yp_zwc_ipt.select_zwc_ipt_performance", req_data);
		return list;
	}
	
	@SuppressWarnings("rawtypes")
	public HashMap<String, Object> exec(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		logger.debug("RFC_FUNC - 【{}】", paramMap.get("RFC_FUNC"));

		HashMap<String, Object> result = new HashMap<String, Object>();
		List<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();

		if ("ZWEB_CHECK_DOCUMENT".equals(paramMap.get("RFC_FUNC"))) {
			list = this.zweb_check_document(request, response);	//전표 유효성 검사
			result.put("list", list);
		} else {
			logger.error("일치하는 RFC_FUNC가 없습니다.");
		}

		return result;
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public String zwc_ipt_sum_list_check_a(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HashMap<String, BigDecimal> result = new HashMap<String, BigDecimal>();
		String result_str = "N1";
		
		result = query.selectOne(NAMESPACE + "yp_zwc_ipt.zwc_ipt_sum_list_check_a", req_data);	//체크 조회
		logger.debug("COUNT_TOTAL - {}", result.get("COUNT_TOTAL"));
		logger.debug("COUNT_OK - {}", result.get("COUNT_OK"));
		logger.debug("COUNT_NO - {}", result.get("COUNT_NO"));
		if(result.get("COUNT_TOTAL").intValue() == 0) {
			// 도급비집계 대상 없음.
			result_str = "N2";
		}else if(result.get("COUNT_OK").intValue() == result.get("COUNT_TOTAL").intValue()) {
			result_str = "Y";
		}
		
		return result_str; 
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public String zwc_ipt_sum_list_check_b(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HashMap<String, BigDecimal> result = new HashMap<String, BigDecimal>();
		String result_str = "N1";
		
		result = query.selectOne(NAMESPACE + "yp_zwc_ipt.zwc_ipt_sum_list_check_b", req_data);	//체크 조회
		logger.debug("COUNT_TOTAL - {}", result.get("COUNT_TOTAL"));
		logger.debug("COUNT_OK - {}", result.get("COUNT_OK"));
		logger.debug("COUNT_NO - {}", result.get("COUNT_NO"));
		if(result.get("COUNT_TOTAL").intValue() == 0) {
			// 도급비집계 대상 없음.
			result_str = "N2";
		}else if(result.get("COUNT_OK").intValue() == result.get("COUNT_TOTAL").intValue()) {
			result_str = "Y";
		}
		
		return result_str; 
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public String zwc_ipt_mon_create_check(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HashMap<String, BigDecimal> result = new HashMap<String, BigDecimal>();
		String result_str = "N1";
		
		result = query.selectOne(NAMESPACE + "yp_zwc_ipt.zwc_ipt_mon_create_check", req_data);	//체크 조회
		logger.debug("COUNT_TOTAL - {}", result.get("COUNT_TOTAL"));
		logger.debug("COUNT_OK - {}", result.get("COUNT_OK"));
		logger.debug("COUNT_NO - {}", result.get("COUNT_NO"));
		if(result.get("COUNT_TOTAL").intValue() == 0) {
			// 도급비집계 대상 없음.
			result_str = "N2";
		}else if(result.get("COUNT_OK").intValue() == result.get("COUNT_TOTAL").intValue()) {
			result_str = "Y";
		}
		
		return result_str; 
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public String zwc_rpt_post_intervention_check(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HashMap<String, BigDecimal> result = new HashMap<String, BigDecimal>();
		String result_str = "N1";
		
		result = query.selectOne(NAMESPACE + "yp_zwc_ipt.zwc_rpt_post_intervention_check", req_data);	//체크 조회
		logger.debug("COUNT_TOTAL - {}", result.get("COUNT_TOTAL"));
		logger.debug("COUNT_OK - {}", result.get("COUNT_OK"));
		logger.debug("COUNT_NO - {}", result.get("COUNT_NO"));
		if(result.get("COUNT_TOTAL").intValue() == 0) {
			// 도급비집계 대상 없음.
			result_str = "N2";
		}else if(result.get("COUNT_OK").intValue() == result.get("COUNT_TOTAL").intValue()) {
			result_str = "Y";
		}
		
		return result_str; 
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public String zwc_rst_summary_list_check(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HashMap<String, BigDecimal> result = new HashMap<String, BigDecimal>();
		String result_str = "N1";
		
		result = query.selectOne(NAMESPACE + "yp_zwc_ipt.zwc_rst_summary_list_check", req_data);	//체크 조회
		logger.debug("COUNT_TOTAL - {}", result.get("COUNT_TOTAL"));
		logger.debug("COUNT_OK - {}", result.get("COUNT_OK"));
		logger.debug("COUNT_NO - {}", result.get("COUNT_NO"));
		if(result.get("COUNT_TOTAL").intValue() == 0) {
			// 도급비집계 대상 없음.
			result_str = "N2";
		}else if(result.get("COUNT_OK").intValue() == result.get("COUNT_TOTAL").intValue()) {
			result_str = "Y";
		}
		
		return result_str; 
	}

	@SuppressWarnings({"rawtypes", "unchecked", "static-access"})
	@Override
	@Transactional
	public int zwc_ipt_sum_create_exec(HashMap req_data) throws Exception {
		WebUtil w_util = new WebUtil();
		int result = 0;
		String year  = req_data.get("BASE_YYYYMM").toString().replace("/", "").substring(0, 4);
		String month = req_data.get("BASE_YYYYMM").toString().replace("/", "").substring(4, 6);
		req_data.put("PREV_YYYYMM", w_util.getDateAdd(year, month, -1)); 	//검수년월 직전년월 파라메터 세팅
		
		result += query.delete(NAMESPACE + "yp_zwc_ipt.zwc_ipt_sum_create_delete", req_data);	//삭제
		result += query.insert(NAMESPACE + "yp_zwc_ipt.zwc_ipt_sum_create_exec", req_data);		//삽입
		
		return result; 
	}
	
	@SuppressWarnings({"rawtypes"})
	@Transactional
	@Override
	public List<HashMap<String, String>> select_zwc_ipt_list_report(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		List<HashMap<String, String>> list = query.selectList(NAMESPACE + "yp_zwc_ipt.select_subc_cost_count", req_data);
		return list;
	}

	@SuppressWarnings({"rawtypes", "unchecked", "static-access"})
	@Override
	public List<HashMap<String, String>> select_zwc_ipt_detail_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		WebUtil w_util = new WebUtil();
		String year  = req_data.get("BASE_YYYYMM").toString().replace("/", "").substring(0, 4);
		String month = req_data.get("BASE_YYYYMM").toString().replace("/", "").substring(4, 6);
		req_data.put("PREV_YYYYMM", w_util.getDateAdd(year, month, -1)); 	//검수년월 직전년월 파라메터 세팅
		
		List<HashMap<String, String>> result = new ArrayList<HashMap<String,String>>();
		result = query.selectList(NAMESPACE + "yp_zwc_ipt.select_zwc_ipt_detail_list", req_data);
		return result;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, Object>> select_cb_working_master_v(HashMap req_data) throws Exception {
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_ipt.select_cb_working_master_v", req_data);
		return result;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, Object>> select_cb_tbl_working_subc(HashMap req_data) throws Exception {
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_ipt.select_cb_tbl_working_subc", req_data);
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int merge_tbl_working_daily_report(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			logger.debug("도급일보 마스터 - {}", jsonObj);
		
			result += query.update(NAMESPACE + "yp_zwc_ipt.merge_tbl_working_daily_report", jsonObj);
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int update_tbl_working_daily_report_tlc(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			logger.debug("도급일보 마스터 - {}", jsonObj);
			
			result += query.update(NAMESPACE + "yp_zwc_ipt.update_tbl_working_daily_report_tlc", jsonObj);
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int update_tbl_working_daily_report_tlc_y(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		JSONParser jsonParse = new JSONParser();
		// 도급월보 전자결재 진행중, 결재완료 상태인 경우에는 승인불가
		// 1. 전자결재 상태조회
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		JSONObject jsonObj = (JSONObject) jsonArr.get(0);
		jsonObj.put("CHECK_YYYYMM", String.valueOf( jsonObj.get("BASE_YYYYMMDD") ).substring(0, 6));
		int selectRtn = query.selectOne(NAMESPACE + "yp_zwc_ipt.pre_select_tbl_working_monthly_report", jsonObj);
		if(selectRtn > 0) {
			return -99;	// 승인불가, 도급월보에서 반려 혹은 신규 상태로 만들어 놓고 진행
		}
		
		jsonParse = new JSONParser();
		jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonSubObj = (JSONObject) jsonArr.get(i);
			jsonSubObj.put("s_emp_code", req_data.get("s_emp_code"));
			jsonSubObj.put("TEAM_LEADER_CONFIRM_STR", "Y");
			logger.debug("도급일보 마스터 - {}", jsonSubObj);
			
			result += query.update(NAMESPACE + "yp_zwc_ipt.update_tbl_working_daily_report_tlc", jsonSubObj);
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int update_tbl_working_daily_report_tlc_n(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		JSONParser jsonParse = new JSONParser();
		// 도급월보 전자결재 진행중, 결재완료 상태인 경우에는 취소불가
		// 1. 전자결재 상태조회
		// 2. 도급월보 데이터 삭제
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		JSONObject jsonObj = (JSONObject) jsonArr.get(0);
		jsonObj.put("CHECK_YYYYMM", String.valueOf( jsonObj.get("BASE_YYYYMMDD") ).substring(0, 6));
		int selectRtn = query.selectOne(NAMESPACE + "yp_zwc_ipt.pre_select_tbl_working_monthly_report", jsonObj);
		if(selectRtn > 0) {
			return -99;	// 승인불가, 도급월보에서 반려 혹은 신규 상태로 만들어 놓고 진행
		}
		query.delete(NAMESPACE + "yp_zwc_ipt.delete_tbl_working_monthly_report", jsonObj);
		
		jsonParse = new JSONParser();
		jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonSubObj = (JSONObject) jsonArr.get(i);
			jsonSubObj.put("s_emp_code", req_data.get("s_emp_code"));
			jsonSubObj.put("TEAM_LEADER_CONFIRM_STR", "N");
			logger.debug("도급일보 마스터 - {}", jsonObj);
			
			result += query.update(NAMESPACE + "yp_zwc_ipt.update_tbl_working_daily_report_tlc", jsonSubObj);
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int merge_tbl_working_daily_report_dt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		JSONObject jsonObjSum = new JSONObject();
		
		float SUM_MANHOUR = 0;
		float SUM_COLLECTION_MANHOUR = 0;
		float SUM_WORKLOAD = 0;
		
		JSONObject jsonObjCnt = (JSONObject) jsonArr.get(0);
		int cnt = query.selectOne(NAMESPACE + "yp_zwc_ipt.pre_update_tbl_working_daily_report", jsonObjCnt);
		if(cnt > 0) {
			float MANHOUR = 0;
			float COLLECTION_MANHOUR = 0;
			for (int i = 0; i < jsonArr.size(); i++) {
				JSONObject jsonObj = (JSONObject) jsonArr.get(i);
				jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
				logger.debug("도급일보 상세 - {}", jsonObj);
				
				if(jsonObj.get("MANHOUR") == null) {
					jsonObj.put("MANHOUR", 0f);
				}
//				if(jsonObj.get("COLLECTION_MANHOUR") == null) {
//					jsonObj.put("COLLECTION_MANHOUR", 0f);
//				}
				if(jsonObj.get("WORKLOAD") == null) {
					jsonObj.put("WORKLOAD", 0f);
				}
				result += query.update(NAMESPACE + "yp_zwc_ipt.merge_tbl_working_daily_report_dt", jsonObj);
				
				if(i == 0) {
					jsonObjSum = jsonObj;
				}
				
				// 2020-12-07 jamerl - 조용래 : 소수점 입력가능
				// 해당 값이 null, 실수형이면 소수형으로 변환
				// 공수
				MANHOUR = (jsonObj.get("MANHOUR") == null || jsonObj.get("MANHOUR").toString() == "") ? 0 : ("java.lang.Long".equals(jsonObj.get("MANHOUR").getClass().getName())) ? ((Long) jsonObj.get("MANHOUR")).floatValue() : Float.parseFloat((String)jsonObj.get("MANHOUR"));
				// 보정공수
				COLLECTION_MANHOUR = (jsonObj.get("COLLECTION_MANHOUR") == null || "".equals(jsonObj.get("COLLECTION_MANHOUR"))) ? 0 : ("java.lang.Long".equals(jsonObj.get("COLLECTION_MANHOUR").getClass().getName())) ? ((Long)jsonObj.get("COLLECTION_MANHOUR")).floatValue() : Float.parseFloat((String)jsonObj.get("COLLECTION_MANHOUR"));
				
				// 공수 누적합
				SUM_MANHOUR += MANHOUR;
				
				// 실공수 누적합 - 보정공수 값이 없는 경우 공수 값이 사용됨
				SUM_COLLECTION_MANHOUR += ((jsonObj.get("COLLECTION_MANHOUR") == null || "".equals(jsonObj.get("COLLECTION_MANHOUR"))) ? MANHOUR : COLLECTION_MANHOUR);
				logger.debug("실공수: {}", ((jsonObj.get("COLLECTION_MANHOUR") == null || "".equals(jsonObj.get("COLLECTION_MANHOUR"))) ? MANHOUR : COLLECTION_MANHOUR));
				
				SUM_WORKLOAD += (jsonObj.get("WORKLOAD") == null || jsonObj.get("WORKLOAD").toString() == "") ? 0 : ("java.lang.Long".equals(jsonObj.get("WORKLOAD").getClass().getName())) ? ((Long) jsonObj.get("WORKLOAD")).floatValue() : Float.parseFloat((String)jsonObj.get("WORKLOAD"));
				logger.debug("합계중(투입공수, 실공수, 작업량): {}", new float[]{SUM_MANHOUR, SUM_COLLECTION_MANHOUR, SUM_WORKLOAD});
//				logger.debug("SUM_COLLECTION_MANHOUR - [{}]", SUM_COLLECTION_MANHOUR);
//				logger.debug("SUM_WORKLOAD - [{}]", SUM_WORKLOAD);
			}
			jsonObjSum.put("SUM_MANHOUR", SUM_MANHOUR);
			jsonObjSum.put("SUM_COLLECTION_MANHOUR", SUM_COLLECTION_MANHOUR);
			jsonObjSum.put("SUM_WORKLOAD", SUM_WORKLOAD);
			
			query.update(NAMESPACE + "yp_zwc_ipt.update_tbl_working_daily_report", jsonObjSum);
		}else {
			result = -1;
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	public int pre_select_tbl_working_monthly_report(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("CHECK_YYYYMM", req_data.get("BASE_YYYY"));
			logger.debug("도급월보 등록 > 전자결재 상태 조회 - {}", jsonObj);
			result += (int) query.selectOne(NAMESPACE + "yp_zwc_ipt.pre_select_tbl_working_monthly_report", jsonObj);
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int insert_tbl_working_monthly_report(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			jsonObj.put("CHECK_YYYYMM", req_data.get("BASE_YYYY"));
			logger.debug("도급월보 등록 > 집계 - {}", jsonObj);
			// 삭제후 삽입
			query.delete(NAMESPACE + "yp_zwc_ipt.delete_tbl_working_monthly_report", jsonObj);
			result += query.insert(NAMESPACE + "yp_zwc_ipt.insert_tbl_working_monthly_report", jsonObj);
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int update_tbl_working_monthly_report(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			logger.debug("도급월보 등록 > 저장 - {}", jsonObj);
			
			result += query.update(NAMESPACE + "yp_zwc_ipt.update_tbl_working_monthly_report", jsonObj);
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public List<HashMap<String, Object>> zwc_ipt_contract_bill(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		
		result = query.selectList(NAMESPACE + "yp_zwc_ipt.select_tbl_working_monthly_report", req_data);
		
		return result;
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public String zwc_ipt_contract_bill_representative(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		String result = "";
		
		result = query.selectOne(NAMESPACE + "yp_zwc_ipt.zwc_ipt_contract_bill_representative", req_data);
		
		return result;
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public List<HashMap<String, Object>> zwc_ipt_doc_create_dt_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		WebUtil w_util = new WebUtil();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		
		String year  = req_data.get("BASE_YYYY").toString().replace("/", "").substring(0, 4);
		String month = req_data.get("BASE_YYYY").toString().replace("/", "").substring(4, 6);
		req_data.put("PREV_YYYYMM", w_util.getDateAdd(year, month, -1)); 	//검수년월 직전년월 파라메터 세팅
		req_data.put("BASE_YYYY", req_data.get("BASE_YYYY").toString().replace("/", ""));
		result = query.selectList(NAMESPACE + "yp_zwc_ipt.select_zwc_ipt_doc_create_dt_list", req_data);
		
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unused"})
	@Override
	public String[] createDocument(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();
		logger.debug("zwcService.createDocument.data=" + req_data);

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_POSTING_DOCUMENT");

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue("I_ZPERNR", req_data.get("emp_code")); // 사번
		if ("5".equals((String) req_data.get("doc_type"))) {
			function.getImportParameterList().setValue("I_IMPORT", "X"); // 수입전표 일때
		}

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		JCoTable ZFIS0010 = function.getTableParameterList().getTable("ZFIS0010_W"); // 기본정보, 구매처정보
		ZFIS0010.appendRow();

		ZFIS0010.setValue("BLART", "SA"); // 전표유형
		ZFIS0010.setValue("BUKRS", "1000"); // 회사코드
		ZFIS0010.setValue("GJAHR", ((String) req_data.get("BUDAT")).substring(0, 4)); // 회계년도
		logger.debug("GJAHR:{}", ZFIS0010.getValue("GJAHR"));
		
		ZFIS0010.setValue("BUDAT", StringUtils.replace((String) req_data.get("BUDAT"), "/", "")); // 전표 전기일
		logger.debug("BUDAT:{}", ZFIS0010.getValue("BUDAT"));
		
		ZFIS0010.setValue("BLDAT", StringUtils.replace((String) req_data.get("BLDAT"), "/", "")); // 전표 증빙일
		logger.debug("BLDAT:{}", ZFIS0010.getValue("BLDAT"));
		
		ZFIS0010.setValue("WAERS", req_data.get("WAERS")); // 통화
		logger.debug("WAERS:{}", ZFIS0010.getValue("WAERS"));
		
		ZFIS0010.setValue("KURSF", StringUtils.replace((String) req_data.get("KURSF"), ",", "")); // 환율
		logger.debug("KURSF:{}", ZFIS0010.getValue("KURSF"));
		
		ZFIS0010.setValue("BUPLA", req_data.get("BUPLA")); // 사업장
		logger.debug("BUPLA:{}", ZFIS0010.getValue("BUPLA"));
		
		ZFIS0010.setValue("BKTXT", req_data.get("BKTXT")); // 전표헤더 텍스트
		logger.debug("BKTXT:{}", ZFIS0010.getValue("BKTXT"));
		
		ZFIS0010.setValue("AGKOA", req_data.get("AGKOA")); // 계정 유형
		logger.debug("AGKOA:{}", ZFIS0010.getValue("AGKOA"));
		
		ZFIS0010.setValue("LIFNR", req_data.get("LIFNR")); // 공급업체
		logger.debug("LIFNR:{}", ZFIS0010.getValue("LIFNR"));
		
		ZFIS0010.setValue("STCD2", req_data.get("STCD2")); // 사업자등록번호
		logger.debug("STCD2:{}", ZFIS0010.getValue("STCD2"));
		
		ZFIS0010.setValue("NAME1", req_data.get("NAME1")); // 상호
		logger.debug("NAME1:{}", ZFIS0010.getValue("NAME1"));
		
		ZFIS0010.setValue("HKONT", "21103101"); 			// 계정과목(헤더:미지급금-원화_하드코딩)
		logger.debug("HKONT:{}", ZFIS0010.getValue("HKONT"));
		
		ZFIS0010.setValue("MWSKZ", "11"); // 세금코드 / 20201112_khj 백승지대리 요청으로 "11"로 하드코딩
		logger.debug("MWSKZ:{}", ZFIS0010.getValue("MWSKZ"));
		
		ZFIS0010.setValue("BVTYP", req_data.get("BVTYP")); // 은행코드
		logger.debug("BVTYP:{}", ZFIS0010.getValue("BVTYP"));
		
		ZFIS0010.setValue("BANKN", req_data.get("BANKN")); // 계좌번호
		logger.debug("BANKN:{}", ZFIS0010.getValue("BANKN"));
		
		ZFIS0010.setValue("SGTXT", req_data.get("BKTXT")); // 텍스트 >> 20201118_khj 백승지 대리 요청으로 SGTXT에 BKTXT값을 세팅
		logger.debug("SGTXT:{}", ZFIS0010.getValue("SGTXT"));
		
		ZFIS0010.setValue("ZSUPAMT", StringUtils.replace((String) req_data.get("ZSUPAMT"), ",", "")); // 공급가액
		logger.debug("ZSUPAMT:{}", ZFIS0010.getValue("ZSUPAMT"));
		
		ZFIS0010.setValue("WMWST", StringUtils.replace((String) req_data.get("WMWST"), ",", "")); // 세액
		logger.debug("WMWST:{}", ZFIS0010.getValue("WMWST"));
		
		ZFIS0010.setValue("ZEXPAMT", StringUtils.replace((String) req_data.get("ZEXPAMT"), ",", "")); // 추가액
		logger.debug("ZEXPAMT:{}", ZFIS0010.getValue("ZEXPAMT"));
		
		ZFIS0010.setValue("WSKTO", StringUtils.replace((String) req_data.get("WSKTO"), ",", "")); // 할인액
		logger.debug("WSKTO:{}", ZFIS0010.getValue("WSKTO"));
		
		ZFIS0010.setValue("ZTOPAY", StringUtils.replace((String) req_data.get("ZTOPAY"), ",", "")); // 총지급액
		logger.debug("ZTOPAY:{}", ZFIS0010.getValue("ZTOPAY"));
		
		ZFIS0010.setValue("KTOKK", req_data.get("KTOKK")); // 거래처 분류코드
		logger.debug("KTOKK:{}", ZFIS0010.getValue("KTOKK"));
		
		ZFIS0010.setValue("ZTERM", req_data.get("ZTERM")); // 지급조건
		logger.debug("ZTERM:{}", ZFIS0010.getValue("ZTERM"));
		
		ZFIS0010.setValue("GSBER", req_data.get("BUPLA")); // 사업영역
		logger.debug("GSBER:{}", ZFIS0010.getValue("GSBER"));
		
		//ZFIS0010.setValue("DMBTR", StringUtils.replace((String) req_data.get("DMBTR"), ",", "")); // 현지통화금액 : 도급비 합계
		ZFIS0010.setValue("DMBTR", ""); // 현지통화금액 : 도급비 합계 >> 20201117_khj 백승지 대리 요청으로 파라미터 제외
		logger.debug("DMBTR:{}", ZFIS0010.getValue("DMBTR"));


		JCoTable ZFIS0020 = function.getTableParameterList().getTable("ZFIS0020_W"); // 전표 개별항목

		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("rows").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			//logger.debug("{}", jsonObj);
			ZFIS0020.appendRow();
			ZFIS0020.setValue("BSCHL", jsonObj.get("BSCHL")); // 차변대변
			logger.debug("BSCHL:{}", ZFIS0020.getValue("BSCHL"));
			
			ZFIS0020.setValue("HKONT", jsonObj.get("HKONT")); // 계정과목
			logger.debug("HKONT:{}", ZFIS0020.getValue("HKONT"));
			
			ZFIS0020.setValue("TXT_50", jsonObj.get("ZGLTXT")); // 계정텍스트
			logger.debug("TXT_50:{}", ZFIS0020.getValue("TXT_50"));
			
			ZFIS0020.setValue("ZKOSTL", jsonObj.get("ZKOSTL")); // 집행부서
			logger.debug("ZKOSTL:{}", ZFIS0020.getValue("ZKOSTL"));
			
			ZFIS0020.setValue("ZKTEXT", jsonObj.get("ZKTEXT")); // 집행부서명
			logger.debug("ZKTEXT:{}", ZFIS0020.getValue("ZKTEXT"));
			
			ZFIS0020.setValue("KOSTL", jsonObj.get("KOSTL")); // 코스트센터
			logger.debug("KOSTL:{}", ZFIS0020.getValue("KOSTL"));
			
			ZFIS0020.setValue("LTEXT", jsonObj.get("LTEXT")); // 코스트센터명
			logger.debug("LTEXT:{}", ZFIS0020.getValue("LTEXT"));
			
			ZFIS0020.setValue("AVAIL_AMT", StringUtils.replace((String) jsonObj.get("AVAIL_AMT"), ",", "")); // 가용예산
			logger.debug("AVAIL_AMT:{}", ZFIS0020.getValue("AVAIL_AMT"));
			
			ZFIS0020.setValue("CHK", jsonObj.get("CHK")); // 추가경비
			logger.debug("CHK:{}", ZFIS0020.getValue("CHK"));
			
			ZFIS0020.setValue("XNEGP", jsonObj.get("NCK")); // 마이너스 구분
			logger.debug("XNEGP:{}", ZFIS0020.getValue("XNEGP"));
			
			if (!StringUtils.hasLength((String.valueOf(jsonObj.get("WRBTR"))))) {	//is null
				ZFIS0020.setValue("WRBTR", StringUtils.replace((String) jsonObj.get("WRBTR"), ",", "")); // 금액
			}else {
				ZFIS0020.setValue("WRBTR", StringUtils.replace(String.valueOf(jsonObj.get("WRBTR")), ",", "").replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 금액
			}
			logger.debug("WRBTR:{}", ZFIS0020.getValue("WRBTR"));
			
			if (!StringUtils.hasLength((String) jsonObj.get("STCD2"))) {	//is null
				ZFIS0020.setValue("STCD2", jsonObj.get("STCD2")); 			// 사업자등록번호
			}else {	//not null
				ZFIS0020.setValue("STCD2", jsonObj.get("STCD2").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 사업자등록번호
			}
			logger.debug("STCD2:{}", ZFIS0020.getValue("STCD2"));
			
			if (!StringUtils.hasLength((String) jsonObj.get("NAME1"))) {	//is null
				ZFIS0020.setValue("NAME1", jsonObj.get("NAME1")); 			// 거래처명
			}else {	//not null
				ZFIS0020.setValue("NAME1", jsonObj.get("NAME1").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 거래처명
			}
			logger.debug("NAME1:{}", ZFIS0020.getValue("NAME1"));
			
			if (!StringUtils.hasLength((String) jsonObj.get("SGTXT"))) {	//is null
				ZFIS0020.setValue("SGTXT", jsonObj.get("SGTXT")); 			// 텍스트
			}else {	//not null
				ZFIS0020.setValue("SGTXT", jsonObj.get("SGTXT").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 텍스트
			}
			logger.debug("SGTXT:{}", ZFIS0020.getValue("SGTXT"));
			
			if (!StringUtils.hasLength((String) jsonObj.get("POSID"))) {	//is null
				ZFIS0020.setValue("POSID", jsonObj.get("POSID")); 			// WBS코드
			}else {	//not null
				ZFIS0020.setValue("POSID", jsonObj.get("POSID").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // WBS코드
			}
			logger.debug("POSID:{}", ZFIS0020.getValue("POSID"));
			
			ZFIS0020.setValue("POST1", jsonObj.get("POST1")); // WBS코드명
			logger.debug("POST1:{}", ZFIS0020.getValue("POST1"));
			
			if (!StringUtils.hasLength((String) jsonObj.get("VBELN"))) {	//is null
				ZFIS0020.setValue("VBELN", jsonObj.get("VBELN")); 			// 판매오더
			}else {	//not null
				ZFIS0020.setValue("VBELN", jsonObj.get("VBELN").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 판매오더
			}
			logger.debug("VBELN:{}", ZFIS0020.getValue("VBELN"));
			
			ZFIS0020.setValue("VTWEG", jsonObj.get("VTWEG")); // 유통경로
			//ZFIS0020.setValue("VTWEG", ""); // 유통경로
			logger.debug("VTWEG:{}", ZFIS0020.getValue("VTWEG"));
			
			if (!StringUtils.hasLength((String) jsonObj.get("MVGR1"))) {	//is null
				ZFIS0020.setValue("MVGR1", jsonObj.get("MVGR1")); // 자재그룹
			}else {	//not null
				ZFIS0020.setValue("MVGR1", jsonObj.get("MVGR1").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 자재그룹
			}
			logger.debug("MVGR1:{}", ZFIS0020.getValue("MVGR1"));
			
			ZFIS0020.setValue("WW002", jsonObj.get("WW002")); // 매출구분
			logger.debug("WW002:{}", ZFIS0020.getValue("WW002"));
			
			ZFIS0020.setValue("MENGE", StringUtils.replace(String.valueOf(jsonObj.get("MENGE")), ",", "")); // 수량
			logger.debug("MENGE:{}", ZFIS0020.getValue("MENGE"));
			
			if (!StringUtils.hasLength((String) jsonObj.get("MEINS"))) {	//is null
				ZFIS0020.setValue("MEINS", jsonObj.get("MEINS")); 			// 단위
			}else{	//not null
				ZFIS0020.setValue("MEINS", jsonObj.get("MEINS").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "").replace("Cycle", "CYC").replace("대", "EA1")); // 단위, 20201207_khj 조용대 대리 요청으로 Cycle 단위는 CYC로 변경, 20210204_khj 조용래 대리 요청으로 "대" >> "EA1"
			}
			logger.debug("MEINS:{}", ZFIS0020.getValue("MEINS"));
			
			if (!StringUtils.hasLength((String) jsonObj.get("ZBSTKD"))) {	//is null
				ZFIS0020.setValue("ZBSTKD", jsonObj.get("ZBSTKD")); 		// 구매오더
			}else {	//not null
				ZFIS0020.setValue("ZBSTKD", jsonObj.get("ZBSTKD").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 구매오더
			}
			logger.debug("ZBSTKD:{}", ZFIS0020.getValue("ZBSTKD"));
			
			if (!StringUtils.hasLength((String) jsonObj.get("ZCCODE"))) {	//is null
				ZFIS0020.setValue("ZCCODE", jsonObj.get("ZCCODE")); 		// 차량코드
			}else {	//not null
				ZFIS0020.setValue("ZCCODE", jsonObj.get("ZCCODE").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 차량코드
			}
			logger.debug("ZCCODE:{}", ZFIS0020.getValue("ZCCODE"));
			
			if (!StringUtils.hasLength((String) jsonObj.get("ZCTEXT"))) {	//is null
				ZFIS0020.setValue("ZCTEXT", jsonObj.get("ZCTEXT")); 		// 차량코드명
			}else {	//not null
				ZFIS0020.setValue("ZCTEXT", jsonObj.get("ZCTEXT").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "" )); // 차량코드명
			}
			logger.debug("ZCTEXT:{}", ZFIS0020.getValue("ZCTEXT"));
			
			if (!StringUtils.hasLength((String) jsonObj.get("AUFNR"))) {	//is null
				ZFIS0020.setValue("AUFNR", jsonObj.get("AUFNR")); // 설비오더 19.04추가
			}else{	//not null
				ZFIS0020.setValue("AUFNR", jsonObj.get("AUFNR").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "" )); // 설비오더 19.04추가
			}
			logger.debug("AUFNR:{}", ZFIS0020.getValue("AUFNR"));
			
			ZFIS0020.setValue("VALUT", StringUtils.replace((String) jsonObj.get("VALUT"), "/", "")); // 기준일 20.06추가
			logger.debug("VALUT:{}", ZFIS0020.getValue("VALUT"));
			
			ZFIS0020.setValue("ZFBDT", StringUtils.replace((String) jsonObj.get("ZFBDT"), "/", "")); // 지급기산일 20.06추가
			logger.debug("ZFBDT:{}", ZFIS0020.getValue("ZFBDT"));
		}

		
		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		String result = function.getExportParameterList().getString("E_FLAG");	//S:성공,E:실패
		String msg = function.getExportParameterList().getString("E_MESSAGE");	//메시지텍스트
		String doc_no = function.getExportParameterList().getString("E_BELNR");	//전표번호

		JCoTable table = function.getTableParameterList().getTable("ZFIS0010_W");
		JCoTable table2 = function.getTableParameterList().getTable("ZFIS0020_W");

		logger.debug(result + "||" + msg + "||" + doc_no);
		String[] return_str = {result, msg, doc_no};

		return return_str;
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public int updateDocumentNumber(HashMap req_data) throws Exception {
		return query.update(NAMESPACE + "yp_zwc_ipt.updateDocumentNumber", req_data);
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public List<HashMap<String, String>> zweb_check_document(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		//1.도급비 집계표 조회시 조회대상의 전표번호 리스트를 가져오기
		List target_list = query.selectList(NAMESPACE + "yp_zwc_ipt.DocumentCheckList", req_data);
		
		
		//2.Roop 돌면서 1건씩 RFC를 통한 SAP 전표 유효성 검사 하고, 유효하지 않은 전표번호는 초기화 UPDATE
		if(target_list.size() > 0) {
			
			for(int i=0; i < target_list.size(); i++) {
				SapJcoConnection jcoConnect = new SapJcoConnection();
				//RFC명
				JCoFunction function = jcoConnect.getFunction("ZWEB_CHECK_DOCUMENT");	//전표 유효성 체크
			    function.getImportParameterList().setValue("I_ZPERNR", (String)req_data.get("empCode"));	//사번
				
				HashMap tempMap = (HashMap)target_list.get(i);
				
			    JCoTable IT_DATA = function.getTableParameterList().getTable("IT_DATA");
			    IT_DATA.appendRow();
			    IT_DATA.setValue("BUKRS", "1000");	//회사코드 1000고정
			    IT_DATA.setValue("GJAHR", tempMap.get("BUDAT").toString().substring(0, 4));	//전기일-yyyy
			    IT_DATA.setValue("BELNR", (String)tempMap.get("SLIP_NUMBER"));	//전표번호
			    
			    logger.debug("rfc start!");
			    // RFC 호출
			 	jcoConnect.execute(function);
			 	
			    logger.debug("rfc finish!");
			    logger.debug("FLAG:"+function.getExportParameterList().getString("E_FLAG")+" / MESSAGE:"+function.getExportParameterList().getString("E_MESSAGE"));
			    
			    // RFC 결과
			 	JCoTable table = function.getTableParameterList().getTable("ET_DATA");
			 	
			 	if("S".equals(function.getExportParameterList().getString("E_FLAG"))) {	//RFC 실행 성공
			 		if("E".equals(table.getValue("CK"))) {	// SAP에 존재하지 않는 전표번호인 경우 전표번호 초기화 업데이트 쿼리실행
			 			logger.debug("해당 전표번호["+table.getValue("BELNR")+"]는 SAP에 존재하지 않는 전표번호입니다!!");
			 			int result = query.update(NAMESPACE + "yp_zwc_ipt.DocumentNumberInit", tempMap);	//도급비 전표번호 초기화 업데이트(유효성 체크 에러인 전표번호만)
			 			if(result > 0) {
			 				logger.debug("해당 전표번호["+table.getValue("BELNR")+"]는 도급비집계 테이블에서 초기화 되었습니다!!");
			 			}
			 		}
			 	}
			}
		}
		
		
		//3.조회조건에 맞는 결과 리스트 조회
		List result_list = query.selectList(NAMESPACE + "yp_zwc_ipt.select_subc_cost_count", req_data);
		
		return result_list;
	}
	
	@SuppressWarnings("rawtypes")
	public int zwc_ipt_mon_create_status_reset(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		result = query.update(NAMESPACE + "yp_zwc_ipt.zwc_ipt_mon_create_status_reset", req_data);
		
		return result;
	}
	
	@SuppressWarnings("rawtypes")
	public int zwc_ipt_sum_list_status_reset(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		result = query.update(NAMESPACE + "yp_zwc_ipt.zwc_ipt_sum_list_status_reset", req_data);
		
		return result;
	}
}
