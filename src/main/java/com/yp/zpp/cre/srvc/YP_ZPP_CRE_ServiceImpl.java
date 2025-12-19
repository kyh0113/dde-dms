package com.yp.zpp.cre.srvc;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.CollectionUtils;
import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoTable;
import com.vicurus.it.core.common.Util;
import com.yp.sap.SapJcoConnection;
import com.yp.util.DateUtil;
import org.springframework.transaction.annotation.Transactional;
import com.yp.zpp.cre.srvc.intf.YP_ZPP_CRE_Service;

@Repository
public class YP_ZPP_CRE_ServiceImpl implements YP_ZPP_CRE_Service {

	// config.properties 에서 설정 정보 가져오기 시작
	@SuppressWarnings("unused")
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

	private static final Logger logger = LoggerFactory.getLogger(YP_ZPP_CRE_ServiceImpl.class);

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int zpp_cre_reg(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map req_data = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int cnt = 0;
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
		    jsonObj.put("s_emp_code",req_data.get("s_emp_code"));
		    jsonObj.put("STD_DT", req_data.get("STD_DT"));
			logger.debug("{}", jsonObj);
		    cnt = query.insert(NAMESPACE + "yp_zpp.merge_creatCreReg", jsonObj);
		    
		}
		return cnt;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int deleteAccessControl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int cnt = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("{}", jsonObj);
			jsonObj.put("STD_DT", req_data.get("STD_DT"));	//기준일자


			cnt += query.delete(NAMESPACE+"yp_zpp.deleteAccessControl", jsonObj);	//청소실적 삭제
		}

		return cnt;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public HashMap<String, Object> retrieveBFDT(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> data = new HashMap<String, Object>();

		HashMap map = new HashMap();

		req_data.put("ser_factory",  req_data.get("FACTORY_NM"));
		req_data.put("ser_line", req_data.get("F_LINE"));
		req_data.put("ser_row", req_data.get("F_ROW"));
		req_data.put("ser_cldt", req_data.get("CLEAN_DT"));

		map = query.selectOne(NAMESPACE + "yp_zpp.select_zpp_cre_bfdt", req_data);
		data.put("BF_DT", map.get("BF_DT"));
		data.put("BF_DT1", map.get("BF_DT1"));
		data.put("CALC_CLEAN", map.get("CALC_CLEAN"));

		//logger.debug("{}", map);

		return data;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public HashMap<String, Object> select_tbl_cre_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> data = new HashMap<String, Object>();

		List<HashMap<String, String>> list1 = new ArrayList<HashMap<String,String>>();
		HashMap map2 = new HashMap();

		list1 = query.selectList(NAMESPACE + "yp_zpp.select_tbl_cre_list", req_data);
		data.put("list1", list1);

		return data;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public HashMap<String, Object> select_tbl_cre_list_pop(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> data = new HashMap<String, Object>();

		List<HashMap<String, String>> list1 = new ArrayList<HashMap<String,String>>();
		HashMap map2 = new HashMap();

		list1 = query.selectList(NAMESPACE + "yp_zpp.select_tbl_cre_list_pop", req_data);
		
		
		logger.debug("{}", list1);
		
		data.put("list1", list1);

		return data;
	}

}
