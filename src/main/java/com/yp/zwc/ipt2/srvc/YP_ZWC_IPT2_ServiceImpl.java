package com.yp.zwc.ipt2.srvc;

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
import com.yp.zwc.ipt2.srvc.intf.YP_ZWC_IPT2_Service;

@Repository
public class YP_ZWC_IPT2_ServiceImpl implements YP_ZWC_IPT2_Service {
	
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

	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_IPT2_ServiceImpl.class);

	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, Object>> select_cb_tbl_working_subc(HashMap req_data) throws Exception {
		logger.debug("Service - [{}]", "select_cb_tbl_working_subc");
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_ipt2.select_cb_tbl_working_subc", req_data);
		return result;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, Object>> select_cb_working_master_v(HashMap req_data) throws Exception {
		logger.debug("Service - [{}]", "select_cb_working_master_v");
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_ipt2.select_cb_working_master_v", req_data);
		return result;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, Object>> select_cb_tbl_working_subc_approval(HashMap req_data) throws Exception {
		logger.debug("Service - [{}]", "select_cb_tbl_working_subc_approval");
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_ipt2.select_cb_tbl_working_subc_approval", req_data);
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int save_tbl_working_daily_report(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【서비스】조업도급 > 도급검수 > 도급일보(협력사) > 저장");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray auto_rows = (JSONArray) jsonParse.parse(req_data.get("auto_rows").toString());
		JSONArray manual_rows = (JSONArray) jsonParse.parse(req_data.get("manual_rows").toString());
		for (int i = 0; i < auto_rows.size(); i++) {
			JSONObject jsonObj = (JSONObject) auto_rows.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			if( "Y".equals( jsonObj.get("DATA_STATUS") ) ) {
				logger.debug("INSERT - 선택 데이터(태그) - {}", jsonObj);
				result += query.insert(NAMESPACE + "yp_zwc_ipt2.insert_tbl_working_daily_report", jsonObj);
			}else {
				logger.debug("UPDATE - 선택 데이터(태그) - {}", jsonObj);
				result += query.update(NAMESPACE + "yp_zwc_ipt2.update_tbl_working_daily_report", jsonObj);
			}
		}
		for (int i = 0; i < manual_rows.size(); i++) {
			JSONObject jsonObj = (JSONObject) manual_rows.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			
			int cnt = 0;
			cnt = query.selectOne(NAMESPACE + "yp_zwc_ipt2.insert_count_tbl_working_daily_report", jsonObj);
			
			if( cnt == 0 ) {
				logger.debug("INSERT - 선택 데이터(추가) - {}", jsonObj);
				result += query.insert(NAMESPACE + "yp_zwc_ipt2.insert_tbl_working_daily_report", jsonObj);
			}else {
				logger.debug("UPDATE - 선택 데이터(추가) - {}", jsonObj);
				result += query.update(NAMESPACE + "yp_zwc_ipt2.update_tbl_working_daily_report", jsonObj);
			}
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int delete_tbl_working_daily_report(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【서비스】조업도급 > 도급검수 > 도급일보(협력사) > 삭제");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			logger.debug("선택 데이터 - {}", jsonObj);
			
			result += query.delete(NAMESPACE + "yp_zwc_ipt2.delete_tbl_working_daily_report", jsonObj);
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int confirm_tbl_working_daily_report(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【서비스】조업도급 > 도급검수 > 도급일보(협력사) > 확정");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			logger.debug("선택 데이터 - {}", jsonObj);
			
			result += query.update(NAMESPACE + "yp_zwc_ipt2.confirm_tbl_working_daily_report", jsonObj);
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int merge_tbl_working_daily_approval(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			logger.debug("도급일보 마스터 - {}", jsonObj);
		
			result += query.update(NAMESPACE + "yp_zwc_ipt2.merge_tbl_working_daily_approval", jsonObj);
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int merge_tbl_working_daily_approval_dt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		JSONObject jsonObjSum = new JSONObject();
		
		float SUM_MANHOUR = 0;
		float SUM_COLLECTION_MANHOUR = 0;
		float SUM_WORKLOAD_DT = 0;
		float SUM_COLLECTION_WORKLOAD = 0;
		
		float SUM_EXTENSION_HOUR = 0;
		float SUM_HOLIDAY_HOUR = 0;
		float SUM_NIGHT_HOUR = 0;
		float SUM_LATE_HOUR = 0;
		
		JSONObject jsonObjCnt = (JSONObject) jsonArr.get(0);
		int cnt = query.selectOne(NAMESPACE + "yp_zwc_ipt2.pre_update_tbl_working_daily_approval", jsonObjCnt);
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
				result += query.update(NAMESPACE + "yp_zwc_ipt2.merge_tbl_working_daily_approval_dt", jsonObj);
				
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
//				SUM_COLLECTION_MANHOUR += ((jsonObj.get("COLLECTION_MANHOUR") == null || "".equals(jsonObj.get("COLLECTION_MANHOUR"))) ? MANHOUR : COLLECTION_MANHOUR);
//				logger.debug("실공수: {}", ((jsonObj.get("COLLECTION_MANHOUR") == null || "".equals(jsonObj.get("COLLECTION_MANHOUR"))) ? MANHOUR : COLLECTION_MANHOUR));
				SUM_COLLECTION_MANHOUR += ( MANHOUR + COLLECTION_MANHOUR );
				logger.debug("실공수: {}", SUM_COLLECTION_MANHOUR);
				
				SUM_WORKLOAD_DT += (jsonObj.get("WORKLOAD") == null || jsonObj.get("WORKLOAD").toString() == "") ? 0 : ("java.lang.Long".equals(jsonObj.get("WORKLOAD").getClass().getName())) ? ((Long) jsonObj.get("WORKLOAD")).floatValue() : Float.parseFloat((String)jsonObj.get("WORKLOAD"));
				logger.debug("합계중(투입공수, 실공수, 작업량): {}", new float[]{SUM_MANHOUR, SUM_COLLECTION_MANHOUR, SUM_WORKLOAD_DT});
				
				SUM_EXTENSION_HOUR += (jsonObj.get("EXTENSION_HOUR") == null || jsonObj.get("EXTENSION_HOUR").toString() == "") ? 0 : ("java.lang.Long".equals(jsonObj.get("EXTENSION_HOUR").getClass().getName())) ? ((Long) jsonObj.get("EXTENSION_HOUR")).floatValue() : Float.parseFloat((String)jsonObj.get("EXTENSION_HOUR"));
				SUM_HOLIDAY_HOUR += (jsonObj.get("HOLIDAY_HOUR") == null || jsonObj.get("HOLIDAY_HOUR").toString() == "") ? 0 : ("java.lang.Long".equals(jsonObj.get("HOLIDAY_HOUR").getClass().getName())) ? ((Long) jsonObj.get("HOLIDAY_HOUR")).floatValue() : Float.parseFloat((String)jsonObj.get("HOLIDAY_HOUR"));
				SUM_NIGHT_HOUR += (jsonObj.get("NIGHT_HOUR") == null || jsonObj.get("NIGHT_HOUR").toString() == "") ? 0 : ("java.lang.Long".equals(jsonObj.get("NIGHT_HOUR").getClass().getName())) ? ((Long) jsonObj.get("NIGHT_HOUR")).floatValue() : Float.parseFloat((String)jsonObj.get("NIGHT_HOUR"));
				SUM_LATE_HOUR += (jsonObj.get("LATE_HOUR") == null || jsonObj.get("LATE_HOUR").toString() == "") ? 0 : ("java.lang.Long".equals(jsonObj.get("LATE_HOUR").getClass().getName())) ? ((Long) jsonObj.get("LATE_HOUR")).floatValue() : Float.parseFloat((String)jsonObj.get("LATE_HOUR"));
				logger.debug("연장, 휴일, 야간, 지각: {}", new float[]{SUM_MANHOUR, SUM_COLLECTION_MANHOUR, SUM_WORKLOAD_DT});
			}
			jsonObjSum.put("SUM_MANHOUR", 0f); // 투입공수 미사용
			jsonObjSum.put("SUM_COLLECTION_MANHOUR", SUM_COLLECTION_MANHOUR);
			jsonObjSum.put("SUM_WORKLOAD_DT", SUM_WORKLOAD_DT);
			
			// 연장, 휴일, 야간, 지각 도급일보(협력사) 데이터 사용
			jsonObjSum.put("SUM_EXTENSION_HOUR", SUM_EXTENSION_HOUR);
			jsonObjSum.put("SUM_HOLIDAY_HOUR", SUM_HOLIDAY_HOUR);
			jsonObjSum.put("SUM_NIGHT_HOUR", SUM_NIGHT_HOUR);
			jsonObjSum.put("SUM_LATE_HOUR", SUM_LATE_HOUR);
			
			query.update(NAMESPACE + "yp_zwc_ipt2.update_tbl_working_daily_approval", jsonObjSum);
		}else {
			result = -1;
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int update_tbl_working_daily_approval_tlc(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			logger.debug("도급일보 마스터 - {}", jsonObj);
			
			result += query.update(NAMESPACE + "yp_zwc_ipt2.update_tbl_working_daily_approval_tlc", jsonObj);
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int update_tbl_working_daily_approval_tlc_y(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		JSONParser jsonParse = new JSONParser();
		// 도급월보 전자결재 진행중, 결재완료 상태인 경우에는 승인불가
		// 1. 전자결재 상태조회
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		JSONObject jsonObj = (JSONObject) jsonArr.get(0);
		jsonObj.put("CHECK_YYYYMM", String.valueOf( jsonObj.get("BASE_YYYYMMDD") ).substring(0, 6));
		int selectRtn = query.selectOne(NAMESPACE + "yp_zwc_ipt2.pre_select_tbl_working_monthly_approval", jsonObj);
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
			
			result += query.update(NAMESPACE + "yp_zwc_ipt2.update_tbl_working_daily_approval_tlc", jsonSubObj);
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int update_tbl_working_daily_approval_tlc_n(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
		int selectRtn = query.selectOne(NAMESPACE + "yp_zwc_ipt2.pre_select_tbl_working_monthly_approval", jsonObj);
		if(selectRtn > 0) {
			return -99;	// 승인불가, 도급월보에서 반려 혹은 신규 상태로 만들어 놓고 진행
		}
		query.delete(NAMESPACE + "yp_zwc_ipt2.delete_tbl_working_monthly_approval", jsonObj);
		
		jsonParse = new JSONParser();
		jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonSubObj = (JSONObject) jsonArr.get(i);
			jsonSubObj.put("s_emp_code", req_data.get("s_emp_code"));
			jsonSubObj.put("TEAM_LEADER_CONFIRM_STR", "N");
			logger.debug("도급일보 마스터 - {}", jsonObj);
			
			result += query.update(NAMESPACE + "yp_zwc_ipt2.update_tbl_working_daily_approval_tlc", jsonSubObj);
		}
		return result;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public int pre_select_ipt2_contract_bill(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("Service - [{}]", "pre_select_ipt2_contract_bill");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int result = 1;
		int chk = 0;
		chk = query.selectOne(NAMESPACE + "yp_zwc_ipt2.pre_select_ipt2_contract_bill_exist", req_data);
		logger.debug("도급비집계 존재여부 확인( 0↑ 가능 ) - [{}]", chk);
		if(chk == 0) {
			result = -90;
			logger.debug("RESULT  - [{}]", result);
			return result;
		}
		chk = query.selectOne(NAMESPACE + "yp_zwc_ipt2.pre_select_ipt2_contract_bill_status", req_data);
		logger.debug("도급비집계 결재상태 확인( 0↑ 불가능 ) - [{}]", chk);
		if(chk > 0) {
			result = -80;
			logger.debug("RESULT  - [{}]", result);
			return result;
		}
		logger.debug("RESULT  - [{}]", result);
		return result;
	}
	
	@Override
	@Transactional
	public int update_zwc_ipt2_contract_bill_upload(HashMap<String, Object> req_data) throws Exception {
		logger.debug("Service - [{}]", "update_zwc_ipt2_contract_bill_upload");
		
		int result = 0;
		result = query.update(NAMESPACE + "yp_zwc_ipt2.update_zwc_ipt2_contract_bill_upload", req_data);
		return result;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public HashMap<String, Object> select_zwc_ipt2_contract_bill_upload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("Service - [{}]", "select_zwc_ipt2_contract_bill_upload");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		result = query.selectOne(NAMESPACE + "yp_zwc_ipt2.select_zwc_ipt2_contract_bill_upload", req_data);
		return result;
	}
}
