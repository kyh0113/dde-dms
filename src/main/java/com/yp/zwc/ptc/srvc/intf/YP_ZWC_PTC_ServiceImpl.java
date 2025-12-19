package com.yp.zwc.ptc.srvc.intf;

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

import com.vicurus.it.core.common.Util;
import com.yp.zwc.ptc.cntr.YP_ZWC_PTC_Controller;
import com.yp.zwc.ptc.srvc.YP_ZWC_PTC_Service;
import com.yp.zwc.upc.srvc.YP_ZWC_UPC_ServiceImpl;

@Repository
public class YP_ZWC_PTC_ServiceImpl implements YP_ZWC_PTC_Service{
	
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
	
	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_PTC_ServiceImpl.class);
	
	
	@Override
	public List<HashMap<String, Object>> select_cb_working_master_v(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_ptc.select_cb_working_master_v", req_data);
		return result;
	}

	@Override
	public List<HashMap<String, Object>> select_cb_working_master_p(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_ptc.select_cb_working_master_p", req_data);
		return result;
	}

	@Override
	public int select_zwc_ptc_list_cnt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int cnt = query.selectOne(NAMESPACE + "yp_zwc_ptc.select_zwc_ptc_list_cnt", req_data);
		return cnt;
	}

	@Override
	public int select_zwc_ptc_dt_cnt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int cnt = query.selectOne(NAMESPACE + "yp_zwc_ptc.select_zwc_ptc_dt_cnt", req_data);
		return cnt;
	}

	@Override
	public List<HashMap<String, Object>> select_zwc_ptc_working_subc_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_ptc.select_zwc_ptc_working_subc_list", req_data);
		return result;
	}

	@Override
	public List<HashMap<String, Object>> select_zwc_ptc_dt_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_ptc.select_zwc_ptc_dt_list", req_data);
		return result;
	}

	@Override
	public List<HashMap<String, Object>> select_cb_working_recent_master_p(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_ptc.select_cb_working_recent_master_p", req_data);
		return result;
	}

	@SuppressWarnings({"static-access", "rawtypes", "unchecked"})
	@Override
	@Transactional
	public int zwc_ptc_create_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int result = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("gridData").toString());
		List<Map<String, Object>> list = util.getListMapFromJsonArray(jsonArr);
		
		JSONObject jsonUnitPriceObj = (JSONObject) jsonParse.parse(req_data.get("unit_price_obj").toString());
		Map<String, Object> unitPriceMap = util.getMapFromJsonObject(jsonUnitPriceObj);
		
		//데이터 수정/저장
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> mapData = list.get(i);
			mapData.put("s_emp_code", req_data.get("s_emp_code"));
			
			//TBL_WORKING_PTC 존재여부 체크
			int working_ptc_chk = query.selectOne(NAMESPACE + "yp_zwc_ptc.working_ptc_chk", mapData);
			//존재할경우
			if(working_ptc_chk > 0) {
				result += query.update(NAMESPACE + "yp_zwc_ptc.working_ptc_update", mapData);
			//존재하지 않을경우
			}else {
				//TBL_WORKING_PTC INSERT
				result += query.insert(NAMESPACE + "yp_zwc_ptc.zwc_ptc_create_save_working_ptc", mapData);
			}
			
			// TBL_WORKING_PTC_DT 삭제 - 연도, 업체코드, 계약코드 조건
			query.delete(NAMESPACE + "yp_zwc_ptc.delete_working_ptc_dt", mapData);
			
			for ( String key : mapData.keySet() ) {
				//보호구 수량 데이터일 경우
				String[] str = key.split("_");
				if(str.length> 1 && str[0].contains("P")) {
					String protector_code = str[0];
					int qty = Integer.parseInt(mapData.get(key).toString());
					HashMap paramMap = new HashMap();
					
					paramMap.put("BASE_YYYY", mapData.get("BASE_YYYY"));
					paramMap.put("CONTRACT_CODE", mapData.get("CONTRACT_CODE"));
					paramMap.put("VENDOR_CODE", mapData.get("VENDOR_CODE"));
					paramMap.put("s_emp_code", mapData.get("s_emp_code"));
					//보호구 코드 세팅
					paramMap.put("PROTECTOR_CODE", protector_code);
					//수량 세팅
					paramMap.put("QTY",  qty);
					//보호구와 맞는 단가 가져오기
					for(String unitKey : unitPriceMap.keySet()) {
						if(protector_code.equals(unitKey.split("_")[0])) {
							paramMap.put("UNIT_PRICE",  unitPriceMap.get(unitKey));
						}
					}

					// 2020-10-13 jamerl - delete insert 로직으로 변경
					//TBL_WORKING_PTC_DT 존재여부 체크
//					int working_ptc_dt_chk = query.selectOne(NAMESPACE + "yp_zwc_ptc.working_ptc_dt_chk", paramMap);
//					//데이터가 존재할경우
//					if(working_ptc_dt_chk > 0) {
//						//TBL_WORKING_PTC_DT UPDATE
//						query.update(NAMESPACE + "yp_zwc_ptc.working_ptc_dt_update", paramMap);
//					//데이터가 존재하지 않을경우
//					}else {
						//TBL_WORKING_PTC_DT INSERT
						query.insert(NAMESPACE + "yp_zwc_ptc.zwc_ptc_dt_insert", paramMap);
//					}
				
				}
						
			}
		}
		
		return result;
	}

	@Override
	public List<HashMap<String, Object>> select_column_make_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_ptc.select_column_make_list", req_data);
		return result;
	}

}
