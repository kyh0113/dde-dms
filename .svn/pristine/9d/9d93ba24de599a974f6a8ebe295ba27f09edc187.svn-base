package com.yp.zwc.mst.srvc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
import com.yp.zwc.mst.srvc.intf.YP_ZWC_MST_Service;

@Repository
public class YP_ZWC_MST_ServiceImpl implements YP_ZWC_MST_Service {

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

	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_MST_ServiceImpl.class);

	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, Object>> select_cb_enterprice_gubun(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_mst.select_cb_enterprice_gubun", req_data);
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int zwc_mst_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int cnt = 0;

		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			if (jsonObj.get("STATUS") == null) {
				if("V".equals(jsonObj.get("CODE"))) {
					jsonObj.put("SEQ", query.selectOne(NAMESPACE + "yp_zwc_mst.select_seq_working_master_v"));
				}else if("W".equals(jsonObj.get("CODE"))) {
					jsonObj.put("SEQ", query.selectOne(NAMESPACE + "yp_zwc_mst.select_seq_working_master_w"));
				}else if("N".equals(jsonObj.get("CODE"))) {
					jsonObj.put("SEQ", query.selectOne(NAMESPACE + "yp_zwc_mst.select_seq_working_master_n"));
				}else if("P".equals(jsonObj.get("CODE"))) {
					jsonObj.put("SEQ", query.selectOne(NAMESPACE + "yp_zwc_mst.select_seq_working_master_p", jsonObj));
				}else if("C".equals(jsonObj.get("CODE"))) {
					jsonObj.put("SEQ", query.selectOne(NAMESPACE + "yp_zwc_mst.select_seq_working_master_c"));
				}else if("U".equals(jsonObj.get("CODE"))) {
					jsonObj.put("SEQ", query.selectOne(NAMESPACE + "yp_zwc_mst.select_seq_working_master_u"));
				}
				logger.debug("{}", jsonObj);
				cnt += query.insert(NAMESPACE + "yp_zwc_mst.insert_zwc_mst", jsonObj);
			}else {
				jsonObj.put("CODE_TYPE", jsonObj.get("CODE").toString().substring(0, 1));
				logger.debug("{}", jsonObj);
				cnt += query.update(NAMESPACE + "yp_zwc_mst.update_zwc_mst", jsonObj);
			}
		}
		return cnt;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int zwc_mst_delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int cnt = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			if(jsonObj.get("CODE").toString().length() == 1) {
				continue;
			}
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			logger.debug("{}", jsonObj);
			cnt += query.update(NAMESPACE + "yp_zwc_mst.delete_zwc_mst", jsonObj);
		}
		return cnt;
	}
}
