package com.yp.zwc.nft.srvc;

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

import com.vicurus.it.core.common.Util;
import com.yp.zwc.nft.srvc.intf.YP_ZWC_NFT_Service;
import com.yp.zwc.ptc.srvc.intf.YP_ZWC_PTC_ServiceImpl;

@Repository
public class YP_ZWC_NFT_ServiceImpl implements YP_ZWC_NFT_Service{
	
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
		
		private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_NFT_ServiceImpl.class);

		@Override
		public List<HashMap<String, Object>> select_cb_working_master_v(HttpServletRequest request, HttpServletResponse response) throws Exception {
			Util util = new Util();
			HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
			
			List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
			result = query.selectList(NAMESPACE + "yp_zwc_nft.select_cb_working_master_v", req_data);
			return result;
		}

		@Override
		public List<HashMap<String, Object>> select_cb_working_master_n(HttpServletRequest request, HttpServletResponse response) throws Exception {
			Util util = new Util();
			HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
			
			List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
			result = query.selectList(NAMESPACE + "yp_zwc_nft.select_cb_working_master_n", req_data);
			return result;
		}
		
		@Override
		public List<HashMap<String, Object>> select_zwc_nft_working_subc_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
			Util util = new Util();
			HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
			
			List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
			result = query.selectList(NAMESPACE + "yp_zwc_nft.select_zwc_nft_working_subc_list", req_data);
			return result;
		}

		@Override
		public List<HashMap<String, Object>> select_zwc_nft_dt_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
			Util util = new Util();
			HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
			
			List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
			result = query.selectList(NAMESPACE + "yp_zwc_nft.select_zwc_nft_dt_list", req_data);
			return result;
		}

		@Override
		public int zwc_nft_create_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
			Util util = new Util();
			HashMap req_data = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
			
			int result = 0;
			
			JSONParser jsonParse = new JSONParser();
			JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("gridData").toString());
			List<Map<String, Object>> list = util.getListMapFromJsonArray(jsonArr);
			
			//데이터 수정/저장
			for (int i = 0; i < list.size(); i++) {
				Map<String, Object> mapData = list.get(i);
				mapData.put("s_emp_code", req_data.get("s_emp_code"));
				
				//TBL_WORKING_NFT 존재여부 체크
				int working_nft_chk = query.selectOne(NAMESPACE + "yp_zwc_nft.working_nft_chk", mapData);
				//존재할경우
				if(working_nft_chk > 0) {
					result += query.update(NAMESPACE + "yp_zwc_nft.working_nft_update", mapData);
				//존재하지 않을경우
				}else {
					//TBL_WORKING_NFT INSERT
					result += query.insert(NAMESPACE + "yp_zwc_nft.zwc_nft_create_save_working", mapData);
				}
				
				// TBL_WORKING_NFT_DT 삭제 - 연도, 업체코드, 계약코드 조건
				query.delete(NAMESPACE + "yp_zwc_nft.delete_working_nft_dt", mapData);
				
				for ( String key : mapData.keySet() ) {
					//첫번째 key가 N으로 시작할경우
					if('N' == key.charAt(0)) {
						String noxious_factor_code = key;
						String check_yn = mapData.get(noxious_factor_code).toString();
						
						HashMap paramMap = new HashMap();
						paramMap.put("BASE_YYYY", mapData.get("BASE_YYYY"));
						paramMap.put("CONTRACT_CODE", mapData.get("CONTRACT_CODE"));
						paramMap.put("VENDOR_CODE", mapData.get("VENDOR_CODE"));
						paramMap.put("s_emp_code", mapData.get("s_emp_code"));
						//유해인자 코드 세팅
						paramMap.put("NOXIOUS_FACTOR_CODE", noxious_factor_code);
						//체크유무 세팅
						paramMap.put("CHECK_YN",  check_yn);
						
						// 2020-10-13 smh - delete insert 로직으로 변경
						//TBL_WORKING_NFT_DT 존재여부 체크
//						int working_ptc_dt_chk = query.selectOne(NAMESPACE +"yp_zwc_nft.working_nft_dt_chk", paramMap);
//						//데이터가 존재할경우 
//						if(working_ptc_dt_chk > 0) { 
//							//TBL_WORKING_NFT_DT UPDATE
//							query.update(NAMESPACE + "yp_zwc_nft.working_nft_dt_update", paramMap);
//						//데이터가 존재하지 않을경우 
//						}else { 
//							//TBL_WORKING_NFT_DT INSERT 
							query.insert(NAMESPACE +"yp_zwc_nft.zwc_nft_dt_insert", paramMap); 
//						}
						 
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
			result = query.selectList(NAMESPACE + "yp_zwc_nft.select_column_make_list", req_data);
			return result;
		}

}
