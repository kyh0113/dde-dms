package com.yp.zwc.ctr.srvc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.yp.sap.SapJcoConnection;
import com.yp.util.DateUtil;
import com.yp.zwc.ctr.srvc.intf.YP_ZWC_CTR_Service;

@Repository
public class YP_ZWC_CTR_ServiceImpl implements YP_ZWC_CTR_Service {

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

	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_CTR_ServiceImpl.class);

	@SuppressWarnings("rawtypes")
	@Override
	public ArrayList<HashMap<String, String>> retrieveKOSTL(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_POPUP_KOSTL");

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue((String) req_data.get("search_type"), (String) req_data.get("search_text"));
		function.getImportParameterList().setValue("I_GUBUN", req_data.get("type"));
		function.getImportParameterList().setValue("I_PERNR", req_data.get("emp_code"));

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		JCoTable table = function.getTableParameterList().getTable("GT_DISP");

		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);

		return list;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List retrieveDEPT(HashMap req_data) throws Exception {
		return query.selectList(NAMESPACE+"yp_zwc_ctr.select_retrieveDEPT", req_data);
	}

	@SuppressWarnings({"unchecked", "rawtypes"})
	@Override
	public ArrayList<HashMap<String, String>> zwc_ctr_select(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		return (ArrayList) query.selectList(NAMESPACE+"yp_zwc_ctr.select_zwc_ctr", paramMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	public List<HashMap<String, Object>> select_cb_gubun_yp_subc_gubun(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		req_data.put("CODE", "YP_SUBC_GUBUN");
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		
		result = query.selectList(NAMESPACE + "yp_zwc_ctr.select_cb_gubun", req_data);
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	public List<HashMap<String, Object>> select_cb_gubun_yp_factory_gubun(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		req_data.put("CODE", "YP_FACTORY_GUBUN");
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		
		result = query.selectList(NAMESPACE + "yp_zwc_ctr.select_cb_gubun", req_data);
		return result;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, Object>> select_cb_working_master_u(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_ctr.select_cb_working_master_u", req_data);
		return result;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, Object>> select_cb_working_master_v(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_ctr.select_cb_working_master_v", req_data);
		return result;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, Object>> select_cb_working_master_w(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_ctr.select_cb_working_master_w", req_data);
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	public int zwc_ctr_delete_chk(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int cnt = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			if(jsonObj.containsKey("IS_NEW")) {
				continue;
			}
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			logger.debug("{}", jsonObj);
			cnt += (Integer)query.selectOne(NAMESPACE + "yp_zwc_ctr.zwc_ctr_delete_chk", jsonObj);
		}
		return cnt;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int zwc_ctr_delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int cnt = 0;
		
		/* 삭제대상
			·도급계약 - TBL_WORKING_SUBC
			·도급계약 내용 - TBL_WORKING_SUBC_CTN
			·도급계약 내용 상세 - TBL_WORKING_SUBC_CTN_DT
			·계약별 보호구 수량 - TBL_WORKING_PTC
			·계약별 보호구 수량 상세 - TBL_WORKING_PTC_DT
			·계약별 유해인자 - TBL_WORKING_NFT
			·계약별 유해인자 상세 - TBL_WORKING_NFT_DT
		*/
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			if(jsonObj.containsKey("IS_NEW")) {
				continue;
			}
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			logger.debug("{}", jsonObj);
			cnt += query.delete(NAMESPACE + "yp_zwc_ctr.zwc_ctr_delete", jsonObj);
			query.delete(NAMESPACE + "yp_zwc_ctr.delete_tbl_working_subc_ctn", jsonObj);
			query.delete(NAMESPACE + "yp_zwc_ctr.delete_tbl_working_subc_ctn_dt", jsonObj);
			query.delete(NAMESPACE + "yp_zwc_ctr.delete_tbl_working_ptc", jsonObj);
			query.delete(NAMESPACE + "yp_zwc_ctr.delete_tbl_working_ptc_dt", jsonObj);
			query.delete(NAMESPACE + "yp_zwc_ctr.delete_tbl_working_nft", jsonObj);
			query.delete(NAMESPACE + "yp_zwc_ctr.delete_tbl_working_nft_dt", jsonObj);
		}
		return cnt;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int zwc_ctr_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map req_data = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int cnt = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			// 신규, 수정 건 모두 아닌 경우(변경없이 선택 된 경우) MERGE에서 제외
			if(!jsonObj.containsKey("IS_NEW") && !jsonObj.containsKey("IS_MOD")) {
				continue;
			}
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			logger.debug("{}", jsonObj);
			cnt += query.update(NAMESPACE + "yp_zwc_ctr.merge_zwc_ctr", jsonObj);
		}
		return cnt;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int zwc_ctr_ref_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map req_data = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int cnt = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			jsonObj.put("BASE_YYYY_NEW", req_data.get("BASE_YYYY_NEW"));
			logger.debug("{}", jsonObj);
			
			int exist = 0;
			
			exist = query.selectOne(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_master_cnt", jsonObj);
			if(exist == 0) {
				cnt = query.insert(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_master_insert", jsonObj);
				logger.debug("【TBL_WORKING_MASTER】 {} 건 삽입", cnt);
			}else{
				logger.debug("【TBL_WORKING_MASTER】 {} 건 중복 - 패스", cnt);
			}
			
			exist = query.selectOne(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_unit_price_cnt", jsonObj);
			if(exist == 0) {
				cnt = query.insert(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_unit_price_insert", jsonObj);
				logger.debug("【TBL_WORKING_UNIT_PRICE】 {} 건 삽입", cnt);
			}else{
				logger.debug("【TBL_WORKING_UNIT_PRICE】 {} 건 중복 - 패스", cnt);
			}
			
			exist = query.selectOne(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_combined_cost_cnt", jsonObj);
			if(exist == 0) {
				cnt = query.insert(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_combined_cost_insert", jsonObj);
				logger.debug("【TBL_WORKING_COMBINED_COST】 {} 건 삽입", cnt);
			}else{
				logger.debug("【TBL_WORKING_COMBINED_COST】 {} 건 중복 - 패스", cnt);
			}
			
			exist = query.selectOne(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_ent_cost_cnt", jsonObj);
			if(exist == 0) {
				cnt = query.insert(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_ent_cost_insert", jsonObj);
				logger.debug("【TBL_WORKING_ENT_COST】 {} 건 삽입", cnt);
			}else{
				logger.debug("【TBL_WORKING_ENT_COST】 {} 건 중복 - 패스", cnt);
			}
			
			exist = query.selectOne(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_ent_unit_price_cnt", jsonObj);
			if(exist == 0) {
				cnt = query.insert(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_ent_unit_price_insert", jsonObj);
				logger.debug("【TBL_WORKING_ENT_UNIT_PRICE】 {} 건 삽입", cnt);
			}else{
				logger.debug("【TBL_WORKING_ENT_UNIT_PRICE】 {} 건 중복 - 패스", cnt);
			}
			
			exist = query.selectOne(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_ent_unit_price_dt_cnt", jsonObj);
			if(exist == 0) {
				cnt = query.insert(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_ent_unit_price_dt_insert", jsonObj);
				logger.debug("【TBL_WORKING_ENT_UNIT_PRICE_DT】 {} 건 삽입", cnt);
			}else{
				logger.debug("【TBL_WORKING_ENT_UNIT_PRICE_DT】 {} 건 중복 - 패스", cnt);
			}
			
			exist = query.selectOne(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_nft_cnt", jsonObj);
			if(exist == 0) {
				cnt = query.insert(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_nft_insert", jsonObj);
				logger.debug("【TBL_WORKING_NFT】 {} 건 삽입", cnt);
			}else{
				logger.debug("【TBL_WORKING_NFT】 {} 건 중복 - 패스", cnt);
			}
			
			exist = query.selectOne(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_nft_dt_cnt", jsonObj);
			if(exist == 0) {
				cnt = query.insert(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_nft_dt_insert", jsonObj);
				logger.debug("【TBL_WORKING_NFT_DT】 {} 건 삽입", cnt);
			}else{
				logger.debug("【TBL_WORKING_NFT_DT】 {} 건 중복 - 패스", cnt);
			}
			
			exist = query.selectOne(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_ptc_cnt", jsonObj);
			if(exist == 0) {
				cnt = query.insert(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_ptc_insert", jsonObj);
				logger.debug("【TBL_WORKING_PTC】 {} 건 삽입", cnt);
			}else{
				logger.debug("【TBL_WORKING_PTC】 {} 건 중복 - 패스", cnt);
			}
			
			exist = query.selectOne(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_ptc_dt_cnt", jsonObj);
			if(exist == 0) {
				cnt = query.insert(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_ptc_dt_insert", jsonObj);
				logger.debug("【TBL_WORKING_PTC_DT】 {} 건 삽입", cnt);
			}else{
				logger.debug("【TBL_WORKING_PTC_DT】 {} 건 중복 - 패스", cnt);
			}
			
			exist = query.selectOne(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_subc_cnt", jsonObj);
			if(exist == 0) {
				cnt = query.insert(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_subc_insert", jsonObj);
				logger.debug("【TBL_WORKING_SUBC】 {} 건 삽입", cnt);
			}else{
				logger.debug("【TBL_WORKING_SUBC】 {} 건 중복 - 패스", cnt);
			}
			
			exist = query.selectOne(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_subc_ctn_cnt", jsonObj);
			if(exist == 0) {
				cnt = query.insert(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_subc_ctn_insert", jsonObj);
				logger.debug("【TBL_WORKING_SUBC_CTN】 {} 건 삽입", cnt);
			}else{
				logger.debug("【TBL_WORKING_SUBC_CTN】 {} 건 중복 - 패스", cnt);
			}
			
			exist = query.selectOne(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_subc_ctn_dt_cnt", jsonObj);
			if(exist == 0) {
				cnt = query.insert(NAMESPACE + "yp_zwc_ctr.ref_tbl_working_subc_ctn_dt_insert", jsonObj);
				logger.debug("【TBL_WORKING_SUBC_CTN_DT】 {} 건 삽입", cnt);
			}else{
				logger.debug("【TBL_WORKING_SUBC_CTN_DT】 {} 건 중복 - 패스", cnt);
			}
		}
		return 1;
	}

	@SuppressWarnings({"unchecked", "rawtypes"})
	@Override
	public ArrayList<HashMap<String, String>> select_zwc_ctr_detail_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		paramMap.put("RESULT", null);
		query.selectList(NAMESPACE + "yp_zwc_ctr.select_zwc_ctr_detail_create", paramMap);
		logger.debug("RESULT {}", paramMap.get("RESULT"));
		return (ArrayList) paramMap.get("RESULT");
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public List select_zwc_ctr_detail_create_final_unit_price(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map req_data = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		List result = new ArrayList();
		
		JSONParser jsonParse = new JSONParser();
		JSONObject jsonObj = (JSONObject) jsonParse.parse(req_data.get("ROW_NO").toString());
		result = query.selectList(NAMESPACE + "yp_zwc_ctr.select_zwc_ctr_detail_create_final_unit_price", jsonObj);
		return result;
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public Float select_zwc_ctr_detail_create_month_amount_ptc(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map req_data = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		Float result = 0f;
		
		JSONParser jsonParse = new JSONParser();
		JSONObject jsonObj = (JSONObject) jsonParse.parse(req_data.get("ROW_NO").toString());
		result = query.selectOne(NAMESPACE + "yp_zwc_ctr.select_zwc_ctr_detail_create_month_amount_ptc", jsonObj);
		return result;
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public Float select_zwc_ctr_detail_create_month_amount_nft(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map req_data = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		Float result = 0f;
		
		JSONParser jsonParse = new JSONParser();
		JSONObject jsonObj = (JSONObject) jsonParse.parse(req_data.get("ROW_NO").toString());
		result = query.selectOne(NAMESPACE + "yp_zwc_ctr.select_zwc_ctr_detail_create_month_amount_nft", jsonObj);
		return result;
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public HashMap select_overtime_pay(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map req_data = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap result = new HashMap();
		
		result = query.selectOne(NAMESPACE + "yp_zwc_ctr.select_overtime_pay", req_data);
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int zwc_ctr_detail_create_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map req_data = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 1;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			logger.debug("도급계약내용 마스터 - {}", jsonObj);
			
			result = query.update(NAMESPACE + "yp_zwc_ctr.merge_zwc_ctr_subc_ctn", jsonObj); // 도급계약내용 마스터 머지
			
			List<HashMap<String, Object>> worktype_list = (ArrayList) query.selectList(NAMESPACE + "yp_zwc_ctr.select_zwc_ctr_detail_create_final_unit_price", jsonObj);
			Iterator<HashMap<String, Object>> iter = worktype_list.iterator();
			
			JSONObject jsonSubObj = new JSONObject();
			while (iter.hasNext()) {
				HashMap submap = iter.next();
				logger.debug("1: {}", submap);
				logger.debug("2: {}", submap.get("WORKTYPE_CODE"));
				logger.debug("3: {}", jsonObj.get(submap.get("WORKTYPE_CODE")));
				
				jsonSubObj.put("BASE_YYYY", jsonObj.get("BASE_YYYY")); // 연도
				jsonSubObj.put("VENDOR_CODE", jsonObj.get("VENDOR_CODE")); // 업체코드
				jsonSubObj.put("CONTRACT_CODE", jsonObj.get("CONTRACT_CODE")); // 계약코드
				jsonSubObj.put("WORKTYPE_CODE", submap.get("WORKTYPE_CODE")); // 근무형태코드
				jsonSubObj.put("MAN_QTY", jsonObj.get(submap.get("WORKTYPE_CODE"))); // 근무형태별 인원
				jsonSubObj.put("s_emp_code", req_data.get("s_emp_code"));
				logger.debug("도급계약내용 상세 - {}", jsonSubObj);
				
				result = query.update(NAMESPACE + "yp_zwc_ctr.merge_zwc_ctr_subc_ctn_dt", jsonSubObj); // 도급계약내용 상세 머지
			}
		}
		return result;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public ArrayList<HashMap<String, String>> select_zwc_ctr_worker_list(HashMap req_data) throws Exception {
		return (ArrayList)query.selectList(NAMESPACE + "yp_zwc_ctr.select_zwc_ctr_worker_list", req_data);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List<HashMap<String, Object>> select_zwc_ctr_worktype_list(HashMap req_data) throws Exception {
		return (ArrayList)query.selectList(NAMESPACE + "yp_zwc_ctr.select_zwc_ctr_worktype_list", req_data);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List<HashMap<String, Object>> zwc_ctr_worker_mapping_validation(HashMap req_data) throws Exception {
		return (ArrayList)query.selectList(NAMESPACE + "yp_zwc_ctr.zwc_ctr_worker_mapping_validation", req_data);
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	@Transactional
	public int zwc_ctr_worker_delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int cnt = query.delete(NAMESPACE + "yp_zwc_ctr.zwc_ctr_worker_delete", req_data);
		return cnt;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int zwc_ctr_worker_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		
		int cnt = 0;
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("gridData").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("emp_code", (String) session.getAttribute("empCode"));
			cnt += query.insert(NAMESPACE + "yp_zwc_ctr.zwc_ctr_worker_create", jsonObj);
		}
		return cnt;
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public List select_emp_work_dept(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List dataList = query.selectList(NAMESPACE + "yp_zwc_ctr.select_emp_work_dept", paramMap);
		
		return dataList;
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public List select_team_list(HashMap<String, Object> param) throws Exception {
		List dataList = null;
		
		//20.09.06 임원 분기처리
		if("IM".equals(param.get("s_authogrp_code"))){
			dataList = this.zhr_get_org_per(param);
		}else{
			dataList = query.selectList(NAMESPACE + "yp_zwc_ctr.select_team_list", param);
		}
		
		return dataList;
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public List select_group_list(HashMap<String, Object> param) throws Exception {
		List dataList = query.selectList(NAMESPACE + "yp_zwc_ctr.select_group_list", param);
		return dataList;
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public List select_shift_list(HashMap<String, Object> param) throws Exception {
		List dataList = query.selectList(NAMESPACE + "yp_zwc_ctr.select_shift_list", param);
		return dataList;
	}
	
	
	public ArrayList<HashMap<String, String>> zhr_get_org_per(HashMap<String, Object> param) throws Exception {

		SapJcoConnection jcoConnect = new SapJcoConnection();
 	    JCoFunction function = jcoConnect.getFunction("ZHR_GET_ORG_PER");
 	    function.getImportParameterList().setValue("I_PERNR",param.get("emp_code"));
 	    function.getImportParameterList().setValue("I_BEGDA",StringUtils.replace(DateUtil.getToday(),"/",""));
	    function.getImportParameterList().setValue("I_ENDDA",StringUtils.replace(DateUtil.getToday(),"/",""));
 	    function.getImportParameterList().setValue("I_AUTH",param.get("s_authogrp_code"));
 	    function.getImportParameterList().setValue("I_OTYPE","O");		//I_OTYPE=O(부서),P(사원)
 	   
 	    jcoConnect.execute(function);
 	    
 	    JCoTable table = function.getTableParameterList().getTable("T_ORGEH");
 	    ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
 	    
 	    return list;
	}
}
