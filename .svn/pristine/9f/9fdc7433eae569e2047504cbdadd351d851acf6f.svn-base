package com.yp.zwc.upw.srvc;

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
import com.vicurus.it.core.common.Util;
import com.yp.zwc.upw.srvc.intf.YP_ZWC_UPW_Service;

@Repository
public class YP_ZWC_UPW_ServiceImpl implements YP_ZWC_UPW_Service {

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

	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_UPW_ServiceImpl.class);

	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, Object>> select_cb_working_master_w(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_upw.select_cb_working_master_w", req_data);
		return result;
	}
	
	@Override
	public List<HashMap<String, Object>> select_tbl_working_unit_price(HashMap<String, Object> req_data) throws Exception {
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_upw.select_tbl_working_unit_price", req_data);
		return result;
	}
	
	@Override
	public List<HashMap<String, Object>> select_tbl_working_combined_cost(HashMap<String, Object> req_data) throws Exception {
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_upw.select_tbl_working_combined_cost", req_data);
		return result;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, String>> select_zwc_upw_list_report(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, String>> result = new ArrayList<HashMap<String,String>>();
		result = query.selectList(NAMESPACE + "yp_zwc_upw.select_zwc_upw_list", req_data);
		return result;
	}

	
	@SuppressWarnings("unchecked")
	@Override
	public int save_zwc_upw_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap<String, Object> req_data = (HashMap<String, Object>) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int result = query.update(NAMESPACE + "yp_zwc_upw.save_zwc_upw_create", req_data);
		return result;
	}
}
