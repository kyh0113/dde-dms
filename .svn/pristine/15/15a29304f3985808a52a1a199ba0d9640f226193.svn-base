package com.yp.zwc.upc.srvc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.vicurus.it.core.common.Util;
import com.yp.zwc.upc.srvc.intf.YP_ZWC_UPC_Service;

@Repository
public class YP_ZWC_UPC_ServiceImpl implements YP_ZWC_UPC_Service {

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

	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_UPC_ServiceImpl.class);

	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, Object>> select_cb_working_master_v(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_upc.select_cb_working_master_v", req_data);
		return result;
	}
	
	@Override
	public List<HashMap<String, Object>> select_tbl_working_ent_cost(HashMap<String, Object> req_data) throws Exception {
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_upc.select_tbl_working_ent_cost", req_data);
		return result;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public HashMap<String, Object> save_zwc_upc_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int result = 0;
		Util util = new Util();
		HashMap<String, Object> req_data = (HashMap<String, Object>) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		for(int i=1; i<=13; i++) {
			HashMap<String, Object> sub_data = new HashMap<String, Object>();
			sub_data.put("BASE_YYYY", req_data.get("BASE_YYYY"));
			sub_data.put("VENDOR_CODE", req_data.get("VENDOR_CODE"));
			sub_data.put("COST_CODE", "C".concat(String.valueOf(i)));
			sub_data.put("COST_AMOUNT", req_data.get("C".concat(String.valueOf(i))));
			sub_data.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zwc_upc.save_zwc_upc_create", sub_data);
		}
		resultMap.put("insert1", result);
		logger.debug("【TBL_WORKING_ENT_COST】 저장 건수 : {}건", result);
		
		result = 0;
		result += query.update(NAMESPACE + "yp_zwc_upc.save_zwc_upc_create_price", req_data);
		resultMap.put("insert2", result);
		logger.debug("【TBL_WORKING_ENT_UNIT_PRICE】 저장 건수 : {}건", result);
		
		result = 0;
		result += query.update(NAMESPACE + "yp_zwc_upc.save_zwc_upc_create_price_dt", req_data);
		resultMap.put("insert3", result);
		logger.debug("【TBL_WORKING_ENT_UNIT_PRICE_DT】 저장 건수 : {}건", result);
		
		return resultMap;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, Object>> select_cb_working_master_w(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_upc.select_cb_working_master_w", req_data);
		return result;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, String>> select_zwc_upc_list_report(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, String>> result = new ArrayList<HashMap<String,String>>();
		result = query.selectList(NAMESPACE + "yp_zwc_upc.select_zwc_upc_list", req_data);
		return result;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, String>> select_zwc_upc_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, String>> result = new ArrayList<HashMap<String,String>>();
		result = query.selectList(NAMESPACE + "yp_zwc_upc.select_zwc_upc_list", req_data);
		return result;
		
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, String>> select_zwc_upc_vendor_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, String>> result = new ArrayList<HashMap<String,String>>();
		result = query.selectList(NAMESPACE + "yp_zwc_upc.select_zwc_upc_vendor_list", req_data);
		return result;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, String>> select_zwc_upc_detail_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, String>> result = new ArrayList<HashMap<String,String>>();
		result = query.selectList(NAMESPACE + "yp_zwc_upc.select_zwc_upc_detail_list", req_data);
		return result;
	}
}
