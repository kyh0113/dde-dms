package com.yp.zwc.rpt.srvc.intf;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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

import com.vicurus.it.core.common.Util;
import com.yp.zwc.rpt.srvc.YP_ZWC_RPT_Service;

@Repository
public class YP_ZWC_RPT_ServiceImpl implements YP_ZWC_RPT_Service{
	
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
	
	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_RPT_ServiceImpl.class);
	
	@SuppressWarnings("rawtypes")
	@Override
	public String select_vendor_name(HashMap req_data) throws Exception {
		String result = query.selectOne(NAMESPACE + "yp_zwc_rpt.select_vendor_name", req_data);
		return result;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, Object>> select_cb_working_master_v(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_rpt.select_cb_working_master_v", req_data);
		return result;
	}

	@SuppressWarnings("rawtypes")
	@Override
	@Transactional
	public int merge_zwc_rpt_subc_cost_adjust(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int result = 0;
		// 조정안 삭제 후 집계
		query.delete(NAMESPACE + "yp_zwc_rpt.delete_subc_cost_adjust", req_data);
		result += query.update(NAMESPACE + "yp_zwc_rpt.merge_subc_cost_adjust", req_data);
		// 산출근거 삭제 후 집계
		query.delete(NAMESPACE + "yp_zwc_rpt.delete_zwc_rpt_subc_cost_basis", req_data);
		result += query.update(NAMESPACE + "yp_zwc_rpt.merge_zwc_rpt_subc_cost_basis", req_data);
		
		return result;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	@Transactional
	public int merge_zwc_rpt_post_intervention(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int result = 0;
		// 조정안 삭제 후 집계
		query.delete(NAMESPACE + "yp_zwc_rpt.delete_tbl_working_subc_pst_adj", req_data);
		result += query.insert(NAMESPACE + "yp_zwc_rpt.insert_tbl_working_subc_pst_adj", req_data);
		
		return result;
	}

	// 2020-10-07 jamerl - 트랜잭션으로 묶기위해 선행 서비스에 포함시킴
//	@Override
//	@Transactional
//	public int merge_zwc_rpt_subc_cost_basis(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		Util util = new Util();
//		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
//		
//		int result = 0;
//		result += query.update(NAMESPACE + "yp_zwc_rpt.merge_zwc_rpt_subc_cost_basis", req_data);
//		return result;
//	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, Object>> select_zwc_rpt_intervention_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_rpt.select_zwc_rpt_intervention_list", req_data);
		return result;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, Object>> select_zwc_rpt_gubun_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_rpt.select_zwc_rpt_gubun_list", req_data);
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int zwc_rpt_subc_cost_adjust_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		
		int result = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("dataList").toString());
		
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", (String) session.getAttribute("empCode"));// 등록자 사번
			logger.debug("{}", jsonObj);
			result += query.update(NAMESPACE + "yp_zwc_rpt.zwc_rpt_subc_cost_adjust_save", jsonObj);
		}
		
		jsonArr = (JSONArray) jsonParse.parse(paramMap.get("dataList2").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", (String) session.getAttribute("empCode"));// 등록자 사번
			logger.debug("{}", jsonObj);
			query.update(NAMESPACE + "yp_zwc_rpt.zwc_rpt_subc_cost_adjust_save2", jsonObj);
		}
		
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int zwc_rpt_subc_cost_adjust_save2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		
		int result = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("dataList2").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", (String) session.getAttribute("empCode"));// 등록자 사번
			logger.debug("{}", jsonObj);
			query.update(NAMESPACE + "yp_zwc_rpt.zwc_rpt_subc_cost_adjust_save2", jsonObj);
		}
		
		return result;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, Object>> zwc_rpt_select_contract_name(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_rpt.zwc_rpt_select_contract_name", req_data);
		return result;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, Object>> zwc_rpt_select_reason_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_rpt.select_reason_list", req_data);
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	public int zwc_rpt_reason_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		
		int result = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("dataList").toString());
		
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", (String) session.getAttribute("empCode"));// 등록자 사번
			logger.debug("{}", jsonObj);
			result += query.update(NAMESPACE + "yp_zwc_rpt.zwc_rpt_reason_save", jsonObj);
		}
		
		return result;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, Object>> select_zwc_rpt_pop_reason(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zwc_rpt.select_pop_reason_list", req_data);
		return result;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, Object>> select_tbl_working_subc_pst_adj(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		
		result = query.selectList(NAMESPACE + "yp_zwc_rpt.select_tbl_working_subc_pst_adj", req_data);
		
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int update_tbl_working_subc_pst_adj(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		
		int result = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("dataList").toString());
		
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", (String) session.getAttribute("empCode"));// 등록자 사번
			logger.debug("{}", jsonObj);
			result += query.update(NAMESPACE + "yp_zwc_rpt.update_tbl_working_subc_pst_adj", jsonObj);
		}
		return result;
	}
}
