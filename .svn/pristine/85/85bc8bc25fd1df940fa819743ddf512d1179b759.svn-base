package com.yp.zcs.ipt.srvc;

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
import org.springframework.util.StringUtils;

import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoTable;
import com.vicurus.it.core.common.Util;
import com.yp.sap.SapJcoConnection;
import com.yp.zcs.ctr.srvc.intf.YP_ZCS_CTR_Service;
import com.yp.zcs.ipt.srvc.intf.YP_ZCS_IPT_Service;


@Repository
public class YP_ZCS_IPT_ServiceImpl implements YP_ZCS_IPT_Service  {
	
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

	private static final Logger logger = LoggerFactory.getLogger(YP_ZCS_IPT_ServiceImpl.class);
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public List<HashMap<String, String>> select_zcs_ipt_mon_manh_read(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		List<HashMap<String, String>> list1 = new ArrayList<HashMap<String,String>>();
		list1 = query.selectList(NAMESPACE + "yp_zcs_ipt.select_zcs_ipt_mon_manh_create", req_data);
		return list1;
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public HashMap<String, Object> select_zcs_ipt_mon_manh_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		int cnt = query.selectOne(NAMESPACE + "yp_zcs_ipt.pre_select_zcs_ipt_mon_manh_create", req_data);
		List<HashMap<String, String>> list1 = new ArrayList<HashMap<String,String>>();
		HashMap map2 = new HashMap();
		if(cnt > 0) {
			list1 = query.selectList(NAMESPACE + "yp_zcs_ipt.select_zcs_ipt_mon_manh_create", req_data);
			map2 = query.selectOne(NAMESPACE + "yp_zcs_ipt.select_zcs_ipt_mon_manh_create_commute", req_data);
			data.put("list1", list1);
			data.put("map2", map2);
		}else {
			list1 = query.selectList(NAMESPACE + "yp_zcs_ipt.select_zcs_ipt_mon_manh_create_new", req_data);
			map2 = query.selectOne(NAMESPACE + "yp_zcs_ipt.select_zcs_ipt_mon_manh_create_commute_new", req_data);
			data.put("list1", list1);
			data.put("map2", map2);
		}
		
		return data;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int merge_zcs_ipt_mon_manh_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		// 월보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【저장】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code") );
			result += query.update(NAMESPACE + "yp_zcs_ipt.merge_zcs_ipt_mon_manh_create", jsonObj);
		}
		
		// 하단 저장
		jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO2").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【저장】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code") );
			query.update(NAMESPACE + "yp_zcs_ipt.merge_zcs_ipt_mon_manh_create_commute", jsonObj);
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked", "unused"})
	@Transactional
	@Override
	public int delete_zcs_ipt_mon_manh_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		int cnt = 0;
		
		// 월보 삭제
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code") );
			logger.debug("【삭제】월보 삭제 데이터 확인 - {}", jsonObj);
			result += query.delete(NAMESPACE + "yp_zcs_ipt.delete_zcs_ipt_mon_manh_create", jsonObj);
		}
		
		// 월보 데이터 건수 확인
		jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO2").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code") );
			logger.debug("【삭제】월보 건수 데이터 확인 - {}", jsonObj);
			cnt = query.selectOne(NAMESPACE + "yp_zcs_ipt.pre_select_zcs_ipt_mon_manh_create", jsonObj);
		}
		
		// 하단 삭제
		if(cnt == 0) {
			jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO2").toString());
			for (int i = 0; i < jsonArr.size(); i++) {
				JSONObject jsonObj = (JSONObject) jsonArr.get(i);
				jsonObj.put("s_emp_code", req_data.get("s_emp_code") );
				logger.debug("【삭제】월보 하단 데이터 확인 - {}", jsonObj);
				query.delete(NAMESPACE + "yp_zcs_ipt.delete_zcs_ipt_mon_manh_create_commute", jsonObj);
			}
		}else {
			jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO2").toString());
			for (int i = 0; i < jsonArr.size(); i++) {
				JSONObject jsonObj = (JSONObject) jsonArr.get(i);
				jsonObj.put("s_emp_code", req_data.get("s_emp_code") );
				logger.debug("【수정】월보 하단 데이터 확인 - {}", jsonObj);
				query.delete(NAMESPACE + "yp_zcs_ipt.merge_zcs_ipt_mon_manh_create_commute", jsonObj);
			}
		}
		return result;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public int select_chk_enable_proc(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int cnt = 0;
		
		cnt = query.selectOne(NAMESPACE + "yp_zcs_ipt.select_chk_enable_proc", req_data);
		
		return cnt;
	}
	
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
	public ArrayList<HashMap<String, String>> retrieveVAPLZ(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();
		
		// RFC 명
		JCoFunction function = jcoConnect.getFunction("Z_TAGIF_003");
		
		// RFC 파라미터 - 순서가 중요한지 확인 필요
		if ("1".equals(req_data.get("search_type"))) {
			function.getImportParameterList().setValue("I_ARBPL", (String) req_data.get("search_text"));
			function.getImportParameterList().setValue("I_KTEXT", "");
		} else if("2".equals(req_data.get("search_type"))) {
			function.getImportParameterList().setValue("I_ARBPL", "");
			function.getImportParameterList().setValue("I_KTEXT", (String) req_data.get("search_text"));
		}
		
		// RFC 호출
		jcoConnect.execute(function);
		
		// RFC 결과
		JCoTable table = function.getTableParameterList().getTable("GT_DISP");
		
		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
		
		return list;
	}

	@Override
	public int zcs_ipt_mon_manh_create_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		
		int cnt = 0;
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("gridData").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
		    jsonObj.put("s_emp_code",req_data.get("s_emp_code"));
		    cnt += query.update(NAMESPACE + "yp_zcs_ipt.merge_construction_month_rpt1", jsonObj); 
		}
		return cnt;
	}

	@Override
	public int month_manh_excelUpload_check(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
	    int result = query.selectOne(NAMESPACE + "yp_zcs_ipt.month_manh_excelUpload_check", req_data);
		
		return result;
	}

	@Override
	public int month_manh_delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int result = 0;
		
		JSONParser jsonParse = new JSONParser();
	    JSONArray jsonArr = (JSONArray)
	    jsonParse.parse(req_data.get("gridData").toString());
	    for (int i = 0; i < jsonArr.size(); i++) { 
	    	JSONObject jsonObj = (JSONObject) jsonArr.get(i);
		    result += query.update(NAMESPACE + "yp_zcs_ipt.month_manh_delete", jsonObj); 
	    }
	    
	    return result;
	}

	@Override
	public int month_opt_excelUpload_check(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
	    int result = query.selectOne(NAMESPACE + "yp_zcs_ipt.month_opt_excelUpload_check", req_data);
		
		return result;
	}

	@Override
	public int zcs_ipt_mon_opt_create_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		
		int cnt = 0;
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("gridData").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
		    jsonObj.put("s_emp_code",req_data.get("s_emp_code"));
		    cnt += query.update(NAMESPACE + "yp_zcs_ipt.merge_construction_month_rpt2", jsonObj); 
		}
		return cnt;
	}

	@Override
	public int month_opt_delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int result = 0;
		
		JSONParser jsonParse = new JSONParser();
	    JSONArray jsonArr = (JSONArray)
	    jsonParse.parse(req_data.get("gridData").toString());
	    for (int i = 0; i < jsonArr.size(); i++) { 
	    	JSONObject jsonObj = (JSONObject) jsonArr.get(i);
		    result += query.update(NAMESPACE + "yp_zcs_ipt.month_opt_delete", jsonObj); 
	    }
	    
	    return result;
	}

	@Override
	public int month_excelUpload_check(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
	    int result = query.selectOne(NAMESPACE + "yp_zcs_ipt.month_excelUpload_check", req_data);
		
		return result;
	}

	@Override
	public int zcs_ipt_mon_create_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		
		int cnt = 0;
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("gridData").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
		    jsonObj.put("s_emp_code",req_data.get("s_emp_code"));
		    cnt += query.update(NAMESPACE + "yp_zcs_ipt.merge_construction_month_rpt3", jsonObj); 
		}
		return cnt;
	}

	@Override
	public int month_delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int result = 0;
		
		JSONParser jsonParse = new JSONParser();
	    JSONArray jsonArr = (JSONArray)
	    jsonParse.parse(req_data.get("gridData").toString());
	    for (int i = 0; i < jsonArr.size(); i++) { 
	    	JSONObject jsonObj = (JSONObject) jsonArr.get(i);
		    result += query.update(NAMESPACE + "yp_zcs_ipt.month_delete", jsonObj); 
	    }
	    
	    return result;
	}

	@Override
	public ArrayList<HashMap<String, String>> unexpectedBySAP(HashMap req_data) throws Exception{
		SapJcoConnection jcoConnect = new SapJcoConnection();
		
		//20201117_khj 코드 및 이름 넣어서 조회하는 테이블 추가
		JCoFunction function = jcoConnect.getFunction("Z_TAGIF_002");
		
		if ("1".equals(req_data.get("search_type"))) {
			function.getImportParameterList().setValue("I_AUFNR", (String)req_data.get("search_text")); //오더번호
			function.getImportParameterList().setValue("I_VATXT", ""); //작업장명
		} else if ("2".equals(req_data.get("search_type"))) {
			function.getImportParameterList().setValue("I_AUFNR", ""); //오더번호
			function.getImportParameterList().setValue("I_VATXT", (String)req_data.get("search_text")); //작업장명
		}
		
		jcoConnect.execute(function);
			
		JCoTable table = function.getTableParameterList().getTable("GT_DISP");
		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
		return list;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List select_zcs_ipt_process_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		return query.selectList(NAMESPACE + "yp_zcs_ipt.select_zcs_ipt_process_list", req_data);
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List select_zcs_ipt_worker_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		return query.selectList(NAMESPACE + "yp_zcs_ipt.select_zcs_ipt_worker_list", req_data);
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List select_construction_monthly_rpt2_excel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		return query.selectList(NAMESPACE + "yp_zcs_ipt.select_construction_monthly_rpt2_excel", req_data);
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List select_zcs_ipt_unexpected_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		return query.selectList(NAMESPACE + "yp_zcs_ipt.select_zcs_ipt_unexpected_list", req_data);
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	@Transactional
	public int proc_zcs_ipt_unexpected_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		
		// 3. SAP 선언
		SapJcoConnection jcoConnect = new SapJcoConnection();
		
		JCoFunction function = jcoConnect.getFunction("Z_TAGIF_001");
		
		JCoTable GT_DISP = function.getTableParameterList().getTable("GT_DISP");
		
		function.getImportParameterList().setValue("I_GUBUN", "2");
		
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			
			// 1. UPDATE
			result += query.update(NAMESPACE + "yp_zcs_ipt.update_tbl_wk_access", jsonObj);
			
			//오더번호 확인
			int cnt = query.selectOne(NAMESPACE + "yp_zcs_ipt.unexpected_aufnr_check", jsonObj);
			
			// 2. INSERT
			if(cnt < 1) query.insert(NAMESPACE + "yp_zcs_ipt.insert_tbl_wk", jsonObj);
			
			// 3. SAP 파라미터 세팅
			GT_DISP.appendRow();
			
			GT_DISP.setValue("WORKSEQNR", jsonObj.get("WORK_SEQ"));
			String aufnr = jsonObj.get("AUFNR").toString();
			GT_DISP.setValue("AUFNR", (aufnr.length() > 8 ? aufnr.substring(6, 11) : aufnr));
			GT_DISP.setValue("USER_NAME", "");
			GT_DISP.setValue("SABUN", "");
			GT_DISP.setValue("W_START_DATE", "");
			GT_DISP.setValue("W_START_TIME", "");
			GT_DISP.setValue("W_END_DATE", "");
			GT_DISP.setValue("W_END_TIME", "");
			GT_DISP.setValue("REG_DATE", "");
			GT_DISP.setValue("UPDATE_DATE", "");
		}
		
		// 3. SAP 호출
		jcoConnect.execute(function);
		
		// RFC 결과
		String flag = function.getExportParameterList().getString("E_FLAG");
		String msg = function.getExportParameterList().getString("E_MESSAGE");
		logger.debug("돌발 작업/오더 매핑 SAP 호출 결과 - [{}] / [{}]", flag, msg);
		
		return result;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List popup_company_id(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		return query.selectList(NAMESPACE + "yp_zcs_ipt.popup_company_id", req_data);
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List popup_name(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		return query.selectList(NAMESPACE + "yp_zcs_ipt.popup_name", req_data);
	}
}
