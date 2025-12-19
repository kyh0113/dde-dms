package com.yp.zmm.inv.srvc;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
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
import com.vicurus.it.core.common.WebUtil;
import com.yp.sap.SapJcoConnection;
import com.yp.zmm.inv.srvc.intf.YP_ZMM_INV_Service;

@Repository
public class YP_ZMM_INV_ServiceImpl implements YP_ZMM_INV_Service {

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

	private static final Logger logger = LoggerFactory.getLogger(YP_ZMM_INV_ServiceImpl.class);

	@SuppressWarnings("rawtypes")
	@Override
	public HashMap<String, Object> select_tbl_inv_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> data = new HashMap<String, Object>();

		List<HashMap<String, String>> list1 = new ArrayList<HashMap<String,String>>();
		HashMap map2 = new HashMap();

			list1 = query.selectList(NAMESPACE + "yp_zmm.select_tbl_inv_list", req_data);
			map2 = query.selectOne(NAMESPACE + "yp_zmm.select_tbl_inv_bigo", req_data);
			data.put("list1", list1);
			data.put("map2", map2);

		return data;
	}

	@SuppressWarnings({"rawtypes", "unchecked", "unused"})
	@Transactional
	@Override
	public int zmm_inv_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		
		int result = 0;
		int cnt = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		
		for (int i = 0; i < jsonArr.size(); i++) {
			//HashMap<String, Object> sub_data = new HashMap<String, Object>();
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", (String) session.getAttribute("empCode"));// 등록자 사번
			req_data.put("CHK_DT", jsonObj.get("CHK_DT"));
			req_data.put("CONCENT_T_B", jsonObj.get("CONCENT_T_B"));
			req_data.put("CONCENT_D_B", jsonObj.get("CONCENT_D_B"));
			req_data.put("CONCENT_S_B", jsonObj.get("CONCENT_S_B"));
			req_data.put("PROD_C_B", jsonObj.get("PROD_C_B"));
			req_data.put("PROD_I_B", jsonObj.get("PROD_I_B"));
			req_data.put("EXTIN_INV_B", jsonObj.get("EXTIN_INV_B"));
			req_data.put("CAKE_C_B", jsonObj.get("CAKE_C_B"));
			req_data.put("CATHODE_H_B", jsonObj.get("CATHODE_H_B"));
			req_data.put("CATHODE_L_B", jsonObj.get("CATHODE_L_B"));
			req_data.put("ZINC_A_B", jsonObj.get("ZINC_A_B"));
			req_data.put("ZINC_C_B", jsonObj.get("ZINC_C_B"));
			req_data.put("ZINC_S_B", jsonObj.get("ZINC_S_B"));
			req_data.put("ZINC_T_B", jsonObj.get("ZINC_T_B"));
			req_data.put("ZINC_EX_B", jsonObj.get("ZINC_EX_B"));

			logger.debug("{}", req_data);

			result += query.update(NAMESPACE+"yp_zmm.update_zmm_inv_list", jsonObj);
		}
		result = query.update(NAMESPACE+"yp_zmm.update_zmm_inv_bigo", req_data);
		return result;
	}

}
