package com.yp.zcs.ctr.srvc;

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
import org.springframework.util.StringUtils;

import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoTable;
import com.vicurus.it.core.common.Util;
import com.yp.sap.SapJcoConnection;
import com.yp.zcs.ctr.srvc.intf.YP_ZCS_CTR_Service;


@Repository
public class YP_ZCS_CTR_ServiceImpl implements YP_ZCS_CTR_Service  {
	
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

	private static final Logger logger = LoggerFactory.getLogger(YP_ZCS_CTR_ServiceImpl.class);

	@Override
	public List<HashMap<String, Object>> select_pay_code_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zcs_ctr.select_pay_code_list", req_data);
		return result;
	}

	@Override
	public ArrayList<HashMap<String, String>> retrievePOSID(HashMap req_data) throws Exception{
		SapJcoConnection jcoConnect = new SapJcoConnection();
 	    JCoFunction function = jcoConnect.getFunction("ZWEB_POPUP_POSID");
 	    function.getImportParameterList().setValue((String)req_data.get("search_type"),(String)req_data.get("search_text"));
 	    jcoConnect.execute(function);
 	    
 	    JCoTable table = function.getTableParameterList().getTable("GT_DISP");
 	   
 	    ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
 	    //logger.debug("list = " + list);

		return list;
 	    
	}

	@Override
	@Transactional
	public HashMap zcs_ctr_manh_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		//logger.debug("req_data :{}",req_data);
		
		HashMap resultMap = new HashMap();
		
		String contract_code = "";
		//계약코드 없을때 생성
		if(StringUtils.isEmpty(req_data.get("CONTRACT_CODE"))) {
			// (년도 + 업체코드)를 포함하는 계약코드가 몇개 있는지 count
			// 채번룰 LPAD 패턴 00 변경
			String temp_contract_code = req_data.get("YYYY").toString() + String.format("%02d", Integer.parseInt(req_data.get("VENDOR_CODE").toString().replaceAll("V", "")));
			
			req_data.put("TEMP_CONTRACT_CODE", temp_contract_code);
			int cnt = query.selectOne(NAMESPACE + "yp_zcs_ctr.select_construction_subc_cnt", req_data);
			
			//일의 자리 숫자라면 앞에 0 붙이기
			String cntString = "";
			if(cnt < 10){
				cntString = "00" + (cnt+1);
			}else if(cnt < 100) {
				cntString = "0" + (cnt+1);
			}else {
				cntString = (cnt+1)+"";
			}
			
			
			//계약코드 완성
			contract_code = temp_contract_code + cntString;
			req_data.put("CONTRACT_CODE", contract_code);
		//계약코드 있을때
		}else {
			contract_code = req_data.get("CONTRACT_CODE").toString();
		}
		
		//logger.debug("contract_code :{}",contract_code);
		
		String PAY_STANDARD = req_data.get("PAY_STANDARD").toString();
		int result = 0;
		//지급기준(공수)
		if("1".equals(PAY_STANDARD)) {
			//TBL_CONSTRUCTION_SUBC Merge
			result = query.update(NAMESPACE + "yp_zcs_ctr.merge_construction_subc", req_data);
		  
		    //TBL_CONSTRUCTION_SUBC_COST Merge 
			JSONParser jsonParse = new JSONParser();
		    JSONArray jsonArr = (JSONArray)
		    jsonParse.parse(req_data.get("gridData").toString());
		    for (int i = 0; i < jsonArr.size(); i++) { 
		    	JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			    jsonObj.put("CONTRACT_CODE", contract_code); 
			    jsonObj.put("s_emp_code",req_data.get("s_emp_code"));
			    //logger.debug("jsonObj:{}", jsonObj); 
			    result += query.update(NAMESPACE + "yp_zcs_ctr.merge_construction_subc_cost", jsonObj); 
		    }
		//지급기준(작업)
		}else if("2".equals(PAY_STANDARD)) {
			//TBL_CONSTRUCTION_SUBC Merge
			result = query.update(NAMESPACE + "yp_zcs_ctr.merge_construction_subc", req_data);
			
			//TBL_CONSTRUCTION_SUBC_EMP_COST Merge 
			JSONParser jsonParse = new JSONParser();
		    JSONArray jsonArrLabor = (JSONArray)jsonParse.parse(req_data.get("laborGridData").toString());
		    for (int i = 0; i < jsonArrLabor.size(); i++) { 
		    	JSONObject jsonObj = (JSONObject) jsonArrLabor.get(i);
			    jsonObj.put("CONTRACT_CODE", contract_code); 
			    jsonObj.put("s_emp_code",req_data.get("s_emp_code"));
			    //logger.debug("인건비 jsonObj:{}", jsonObj); 
			    result += query.update(NAMESPACE + "yp_zcs_ctr.merge_construction_subc_emp_cost", jsonObj); 
		    }
		    //TBL_CONSTRUCTION_SUBC_COST Merge 
		    JSONArray jsonArrExpense = (JSONArray)jsonParse.parse(req_data.get("expenseGridData").toString());
		    for (int i = 0; i < jsonArrExpense.size(); i++) { 
		    	JSONObject jsonObj = (JSONObject) jsonArrExpense.get(i);
			    jsonObj.put("CONTRACT_CODE", contract_code); 
			    jsonObj.put("s_emp_code",req_data.get("s_emp_code"));
			    //logger.debug("비용/기타 jsonObj:{}", jsonObj);
			    result += query.update(NAMESPACE + "yp_zcs_ctr.merge_construction_subc_cost", jsonObj);
		    }
		//지급기준(월정액)
		}else if("3".equals(PAY_STANDARD)) {
			//TBL_CONSTRUCTION_SUBC Merge
			result = query.update(NAMESPACE + "yp_zcs_ctr.merge_construction_subc", req_data);
		}
		
		
	    resultMap.put("result",result);
		resultMap.put("CONTRACT_CODE",contract_code);
		
		return resultMap;
	}

	@Override
	public int zcs_ctr_manh_delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		String PAY_STANDARD = req_data.get("PAY_STANDARD").toString();
		int result = 0;
		//지급기준(공수)
		if("1".equals(PAY_STANDARD)) {
		    //TBL_CONSTRUCTION_SUBC_COST Delete
			JSONParser jsonParse = new JSONParser();
		    JSONArray jsonArr = (JSONArray)
		    jsonParse.parse(req_data.get("gridData").toString());
		    for (int i = 0; i < jsonArr.size(); i++) { 
		    	JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			    result += query.update(NAMESPACE + "yp_zcs_ctr.delete_construction_subc_cost", jsonObj); 
		    }
		//지급기준(작업) - 인건비
		}else if("2".equals(PAY_STANDARD) && "labor".equals(req_data.get("flag").toString())) {
			//TBL_CONSTRUCTION_SUBC_EMP_COST Delete 
			JSONParser jsonParse = new JSONParser();
		    JSONArray jsonArrLabor = (JSONArray)jsonParse.parse(req_data.get("laborGridData").toString());
		    for (int i = 0; i < jsonArrLabor.size(); i++) { 
		    	JSONObject jsonObj = (JSONObject) jsonArrLabor.get(i);
			    result += query.update(NAMESPACE + "yp_zcs_ctr.delete_construction_subc_emp_cost", jsonObj); 
		    }
	    //지급기준(작업) - 경비/기타
		}else if("2".equals(PAY_STANDARD) && "expense".equals(req_data.get("flag").toString())) {
			//TBL_CONSTRUCTION_SUBC_COST Delete 
			JSONParser jsonParse = new JSONParser();
		    JSONArray jsonArrExpense = (JSONArray)jsonParse.parse(req_data.get("expenseGridData").toString());
		    for (int i = 0; i < jsonArrExpense.size(); i++) { 
		    	JSONObject jsonObj = (JSONObject) jsonArrExpense.get(i);
			    result += query.update(NAMESPACE + "yp_zcs_ctr.delete_construction_subc_cost", jsonObj); 
		    }
		}
		
		return result;
	}

	@Override
	public ArrayList<HashMap<String, String>> retrieveContarctName(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, String>> list = new ArrayList<HashMap<String,String>>();
		list = query.selectList(NAMESPACE + "yp_zcs_ctr.select_construction_subc", req_data);
		return (ArrayList<HashMap<String, String>>) list;
	}

	@Override
	public List<HashMap<String, Object>> select_contstruction_subc(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		list = query.selectList(NAMESPACE + "yp_zcs_ctr.select_construction_subc_list", req_data);
		return list;
	}

	@Override
	public List<HashMap<String, Object>> select_contstruction_subc_cost(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		list = query.selectList(NAMESPACE + "yp_zcs_ctr.select_contstruction_subc_cost", req_data);
		return list;
	}

	@Override
	public List<HashMap<String, Object>> select_contstruction_subc_emp_cost(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		list = query.selectList(NAMESPACE + "yp_zcs_ctr.select_contstruction_subc_emp_cost", req_data);
		return list;
	}

	@Override
	public ArrayList<HashMap<String, String>> select_working_master_v(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, String>> result = new ArrayList<HashMap<String,String>>();
		result = query.selectList(NAMESPACE + "yp_zcs_ctr.select_working_master_v", req_data);
		return (ArrayList<HashMap<String, String>>) result;
	}

	@Override
	public int select_exist_monthly_rpt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int result = 0;
		
		JSONParser jsonParse = new JSONParser();
	    JSONArray jsonArr = (JSONArray)
	    jsonParse.parse(req_data.get("gridData").toString());
	    for (int i = 0; i < jsonArr.size(); i++) { 
	    	JSONObject jsonObj = (JSONObject) jsonArr.get(i);
		    int count = query.selectOne(NAMESPACE + "yp_zcs_ctr.select_exist_monthly_rpt", jsonObj);
		    result += count;
	    }
		
		return result;
	}

	@Override
	@Transactional
	public int zcs_ctr_manh_read_delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int result = 0;
		
		JSONParser jsonParse = new JSONParser();
	    JSONArray jsonArr = (JSONArray)
	    jsonParse.parse(req_data.get("gridData").toString());
	    for (int i = 0; i < jsonArr.size(); i++) { 
	    	JSONObject jsonObj = (JSONObject) jsonArr.get(i);
		    result += query.update(NAMESPACE + "yp_zcs_ctr.delete_construction_subc", jsonObj); 
		    result += query.update(NAMESPACE + "yp_zcs_ctr.delete_construction_subc_cost", jsonObj);
		    result += query.update(NAMESPACE + "yp_zcs_ctr.delete_construction_subc_emp_cost", jsonObj); 
	    }
	    
	    return result;
	}

}
