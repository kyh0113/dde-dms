package com.yp.zwc.smc.srvc;

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
import com.yp.zwc.smc.srvc.intf.YP_ZWC_SMC_Service;

@Repository
public class YP_ZWC_SMC_ServiceImpl implements YP_ZWC_SMC_Service {

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

	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_SMC_ServiceImpl.class);

	@SuppressWarnings({"unchecked", "rawtypes"})
	@Transactional
	@Override
	public ArrayList<HashMap<String, String>> zwc_smc_select(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		return (ArrayList) query.selectList(NAMESPACE+"yp_zwc_smc.select_zwc_smc", paramMap);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, Object>> select_cb_working_master_v(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_smc.select_cb_working_master_v", req_data);
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int zwc_smc_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map req_data = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int cnt = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			logger.debug("{}", jsonObj);
			cnt += query.update(NAMESPACE + "yp_zwc_smc.merge_zwc_smc", jsonObj);
		}
		return cnt;
	}
	
}
