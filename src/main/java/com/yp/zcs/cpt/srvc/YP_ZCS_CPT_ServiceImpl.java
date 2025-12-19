package com.yp.zcs.cpt.srvc;

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
import org.springframework.util.StringUtils;

import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoTable;
import com.vicurus.it.core.common.Util;
import com.yp.sap.SapJcoConnection;
import com.yp.zcs.cpt.srvc.intf.YP_ZCS_CPT_Service;


@Repository
public class YP_ZCS_CPT_ServiceImpl implements YP_ZCS_CPT_Service  {
	
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

	private static final Logger logger = LoggerFactory.getLogger(YP_ZCS_CPT_ServiceImpl.class);

	
	@SuppressWarnings({"rawtypes"})
	@Override
	public HashMap<String, Object> select_zcs_cpt_manh_create3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = ( HashMap ) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		List<HashMap<String, String>> list1 = new ArrayList<HashMap<String,String>>();
		HashMap map2 = new HashMap();
		
		if(req_data.get("REPORT_CODE") == null) {
			logger.debug("작업내역 보고서 Ｘ 파라미터 - {}", req_data);
			list1 = query.selectList(NAMESPACE + "yp_zcs_cpt.select_zcs_cpt_manh_create3_new", req_data);
			map2 = query.selectOne(NAMESPACE + "yp_zcs_cpt.select_zcs_cpt_manh_create3_commute_new", req_data);
			data.put("list1", list1);
			data.put("map2", map2);
		}else {
			logger.debug("작업내역 보고서 Ｏ 파라미터 - {}", req_data);
			list1 = query.selectList(NAMESPACE + "yp_zcs_cpt.select_zcs_cpt_manh_create3", req_data);
			map2 = query.selectOne(NAMESPACE + "yp_zcs_cpt.select_zcs_cpt_manh_create3_commute", req_data);
			data.put("list1", list1);
			data.put("map2", map2);
		}
		
		return data;
	}
	
	@Override
	public List<HashMap<String, Object>> select_inspection_manh_list1(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zcs_cpt.select_inspection_manh_list1", req_data);
		return result;
	}

	@Override
	public List<HashMap<String, Object>> select_inspection_manh_list2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zcs_cpt.select_inspection_manh_list2", req_data);
		return result;
	}

	@Override
	public ArrayList<HashMap<String, String>> select_work_status_list_manh(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		//공수 월보 계약건 조회
		int cnt = query.selectOne(NAMESPACE + "yp_zcs_cpt.select_monthly_rpt1_cnt", paramMap);
		//계약건이 있을 경우
		if(cnt > 0) {
			paramMap.put("RESULT", null);
			//logger.debug("[TEST]paramMap {}:", paramMap);
			query.selectList(NAMESPACE + "yp_zcs_cpt.select_work_status_list_manh", paramMap);
			//logger.debug("RESULT {}", paramMap.get("RESULT"));
			return (ArrayList) paramMap.get("RESULT");
		}
		
		//계약건이 없을 경우, 빈 리스트 리턴
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>> ();
		return list;
	}
	
	@Override
	public ArrayList<HashMap<String, String>> select_work_status_list_opt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		//공수 월보 계약건 조회
		int cnt = query.selectOne(NAMESPACE + "yp_zcs_cpt.select_monthly_rpt2_cnt", paramMap);
		//계약건이 있을 경우
		if(cnt > 0) {
			paramMap.put("RESULT", null);
			//logger.debug("[TEST]paramMap {}:", paramMap);
			query.selectList(NAMESPACE + "yp_zcs_cpt.select_work_status_list_opt", paramMap);
			//logger.debug("RESULT {}", paramMap.get("RESULT"));
			return (ArrayList) paramMap.get("RESULT");
		}
		
		//계약건이 없을 경우, 빈 리스트 리턴
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>> ();
		return list;
	}

	@Override
	@Transactional
	public HashMap zcs_cpt_manh_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		//logger.debug("req_data :{}",req_data);
		
		HashMap resultMap = new HashMap();
		
		String report_code = "";
		//보고서코드 없을때 생성
		if(StringUtils.isEmpty(req_data.get("REPORT_CODE"))) {
			//(년도 + 업체코드)를 포함하는 보고서코드가 몇개 있는지 count
			String temp_vendor_code = req_data.get("VENDOR_CODE").toString().replaceAll("V", "");
			if(Integer.parseInt(temp_vendor_code) < 10){
				temp_vendor_code = "0" + temp_vendor_code;
			}
			
			String temp_report_code = req_data.get("BASE_YYYYMM").toString().substring(0,4) + temp_vendor_code;
			
			req_data.put("TEMP_REPORT_CODE", temp_report_code);
			int cnt = query.selectOne(NAMESPACE + "yp_zcs_cpt.select_construction_chk_rpt_cnt", req_data);
			
			//일의 자리 숫자라면 앞에 0 붙이기
			String cntString = "";
			if(cnt < 10){
				cntString = "00" + (cnt+1);
			}else if(cnt < 100) {
				cntString = "0" + (cnt+1);
			}else {
				cntString = (cnt+1)+"";
			}
			
			//보고서코드 완성
			report_code = temp_report_code + cntString;
			req_data.put("REPORT_CODE", report_code);
		//보고서코드 있을때
		}else {
			report_code = req_data.get("REPORT_CODE").toString();
		}
		
		//logger.debug("[TEST]report_code :{}",report_code);
		
		//거래처 계약코드 월보년월로 TBL_CONSTRUCTION_CHK_RPT가 존재하는지 확인
		//존재할경우, 
		//TBL_CONSTRUCTION_CHK_RPT만 MERGE문 돌아가고
		//TBL_CONSTRUCTION_CHK_RPT_DT,TBL_CONSTRUCTION_CHK_RPT_DT2의 INSERT는 실행되지 않는다
		
		int count = query.selectOne(NAMESPACE + "yp_zcs_cpt.construction_chk_rpt_count", req_data);
		int result = 0;
		
		//존재하지 않을경우
		if(count < 1) {
			//TBL_CONSTRUCTION_CHK_RPT MERGE
			result += query.update(NAMESPACE + "yp_zcs_cpt.merge_construction_chk_rpt", req_data);
			
			//logger.debug("[TEST]insert_construction_chk_rpt_dt");
			//logger.debug("[TEST]insert_construction_chk_rpt_dt2");
			
			//TBL_CONSTRUCTION_CHK_RPT_DT INSERT 
			result += query.update(NAMESPACE + "yp_zcs_cpt.insert_construction_chk_rpt_dt_manh", req_data);
			
			//TBL_CONSTRUCTION_CHK_RPT_DT2 INSERT 
			result += query.update(NAMESPACE + "yp_zcs_cpt.insert_construction_chk_rpt_dt2_manh", req_data);
			
			//TBL_CONSTRUCTION_CHK_RPT_DT3 INSERT (신규) 
			result += query.update(NAMESPACE + "yp_zcs_cpt.insert_construction_chk_rpt_dt3_manh", req_data);
		}
		
	    resultMap.put("result",result);
		resultMap.put("REPORT_CODE",report_code);
		
		return resultMap;
	}

	@Override
	public List<HashMap<String, Object>> select_pay_code_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zcs_cpt.select_pay_code_list", req_data);
		return result;
	}
	
	@Override
	public ArrayList<HashMap<String, String>> retrieveReportName(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, String>> list = new ArrayList<HashMap<String,String>>();
		list = query.selectList(NAMESPACE + "yp_zcs_cpt.select_construction_chk_rpt", req_data);
		return (ArrayList<HashMap<String, String>>) list;
	}

	@Override
	@Transactional
	public int zcs_cpt_rpt_delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int result = 0;
		
		JSONParser jsonParse = new JSONParser();
	    JSONArray jsonArr = (JSONArray)
	    jsonParse.parse(req_data.get("gridData").toString());
	    for (int i = 0; i < jsonArr.size(); i++) { 
	    	JSONObject jsonObj = (JSONObject) jsonArr.get(i);
	    	//검수보고서 삭제
		    //TBL_CONSTRUCTION_CHK_RPT Delete
		    result += query.update(NAMESPACE + "yp_zcs_cpt.delete_construction_chk_rpt", jsonObj); 
		    
		    //검수보고서 상세1 삭제
		    //TBL_CONSTRUCTION_CHK_RPT_DT Delete
		    result += query.update(NAMESPACE + "yp_zcs_cpt.delete_construction_chk_rpt_dt", jsonObj); 
		    
		    //검수보고서 상세2 삭제
		    //TBL_CONSTRUCTION_CHK_RPT_DT2 Delete
		    result += query.update(NAMESPACE + "yp_zcs_cpt.delete_construction_chk_rpt_dt2", jsonObj); 
		    
		    //검수보고서 상세3 삭제
		    //TBL_CONSTRUCTION_CHK_RPT_DT3 Delete
		    result += query.update(NAMESPACE + "yp_zcs_cpt.delete_construction_chk_rpt_dt3", jsonObj); 
	    }
		return result;
	}

	@Override
	public List<HashMap<String, Object>> select_construction_chk_rpt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		list = query.selectList(NAMESPACE + "yp_zcs_cpt.select_construction_chk_rpt_load", req_data);
		return list;
	}

	@Override
	public List<HashMap<String, Object>> select_inspection_manh_list2_using_report_code(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zcs_cpt.select_inspection_manh_list2_using_report_code", req_data);
		return result;
	}
	
	
	

	/* 검수보고서(월정액) 시작*/
	@Override
	public List<HashMap<String, Object>> select_inspection_mon_list1(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zcs_cpt.select_inspection_mon_list1", req_data);
		return result;
	}

	@Override
	public List<HashMap<String, Object>> select_inspection_mon_list2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zcs_cpt.select_inspection_mon_list2", req_data);
		return result;
	}

	@Override
	@Transactional
	public HashMap zcs_cpt_mon_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		//logger.debug("req_data :{}",req_data);
		
		HashMap resultMap = new HashMap();
		
		String report_code = "";
		//보고서코드 없을때 생성
		if(StringUtils.isEmpty(req_data.get("REPORT_CODE"))) {
			//(년도 + 업체코드)를 포함하는 보고서코드가 몇개 있는지 count
			String temp_vendor_code = req_data.get("VENDOR_CODE").toString().replaceAll("V", "");
			if(Integer.parseInt(temp_vendor_code) < 10){
				temp_vendor_code = "0" + temp_vendor_code;
			}
			
			String temp_report_code = req_data.get("BASE_YYYYMM").toString().substring(0,4) + temp_vendor_code;
			
			req_data.put("TEMP_REPORT_CODE", temp_report_code);
			int cnt = query.selectOne(NAMESPACE + "yp_zcs_cpt.select_construction_chk_rpt_cnt", req_data);
			
			//일의 자리 숫자라면 앞에 0 붙이기
			String cntString = "";
			if(cnt < 10){
				cntString = "00" + (cnt+1);
			}else if(cnt < 100) {
				cntString = "0" + (cnt+1);
			}else {
				cntString = (cnt+1)+"";
			}
			
			//보고서코드 완성
			report_code = temp_report_code + cntString;
			req_data.put("REPORT_CODE", report_code);
		//보고서코드 있을때
		}else {
			report_code = req_data.get("REPORT_CODE").toString();
		}

		//거래처 계약코드 월보년월로 TBL_CONSTRUCTION_CHK_RPT가 존재하는지 확인
		//존재할경우, 
		//TBL_CONSTRUCTION_CHK_RPT만 MERGE문 돌아가고
		//TBL_CONSTRUCTION_CHK_RPT_DT,TBL_CONSTRUCTION_CHK_RPT_DT2의 INSERT는 실행되지 않는다
		
		int count = query.selectOne(NAMESPACE + "yp_zcs_cpt.construction_chk_rpt_count", req_data);
		int result = 0;

		//존재하지 않을경우
		if(count < 1) {
			//TBL_CONSTRUCTION_CHK_RPT MERGE
			result += query.update(NAMESPACE + "yp_zcs_cpt.merge_construction_chk_rpt", req_data);
			
			//TBL_CONSTRUCTION_CHK_RPT_DT INSERT 
			result += query.update(NAMESPACE + "yp_zcs_cpt.insert_construction_chk_rpt_dt_mon", req_data);
			
			//TBL_CONSTRUCTION_CHK_RPT_DT2 INSERT 
			result += query.update(NAMESPACE + "yp_zcs_cpt.insert_construction_chk_rpt_dt2_mon", req_data);
		}
		
	    resultMap.put("result",result);
		resultMap.put("REPORT_CODE",report_code);
		
		return resultMap;
	}

	@Override
	public ArrayList<HashMap<String, String>> select_work_status_list_using_report_code(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		paramMap.put("RESULT", null);
		query.selectList(NAMESPACE + "yp_zcs_cpt.select_work_status_list_using_report_code", paramMap);
		logger.debug("RESULT {}", paramMap.get("RESULT"));
		return (ArrayList) paramMap.get("RESULT");
	}

	@Override
	public List<HashMap<String, Object>> select_inspection_opt_list1(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zcs_cpt.select_inspection_opt_list1", req_data);
		return result;
	}

	@Override
	public List<HashMap<String, Object>> select_inspection_opt_list2(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zcs_cpt.select_inspection_opt_list2", req_data);
		return result;
	}

	@Override
	public List<HashMap<String, Object>> select_inspection_opt_list2_using_report_code(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zcs_cpt.select_inspection_opt_list2_using_report_code", req_data);
		return result;
	}

	@Override
	@Transactional
	public HashMap zcs_cpt_opt_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		//logger.debug("req_data :{}",req_data);
		
		HashMap resultMap = new HashMap();
		
		String report_code = "";
		//보고서코드 없을때 생성
		if(StringUtils.isEmpty(req_data.get("REPORT_CODE"))) {
			//(년도 + 업체코드)를 포함하는 보고서코드가 몇개 있는지 count
			String temp_vendor_code = req_data.get("VENDOR_CODE").toString().replaceAll("V", "");
			if(Integer.parseInt(temp_vendor_code) < 10){
				temp_vendor_code = "0" + temp_vendor_code;
			}
			
			String temp_report_code = req_data.get("BASE_YYYYMM").toString().substring(0,4) + temp_vendor_code;
			
			req_data.put("TEMP_REPORT_CODE", temp_report_code);
			int cnt = query.selectOne(NAMESPACE + "yp_zcs_cpt.select_construction_chk_rpt_cnt", req_data);
			
			//일의 자리 숫자라면 앞에 0 붙이기
			String cntString = "";
			if(cnt < 10){
				cntString = "00" + (cnt+1);
			}else if(cnt < 100) {
				cntString = "0" + (cnt+1);
			}else {
				cntString = (cnt+1)+"";
			}
			
			//보고서코드 완성
			report_code = temp_report_code + cntString;
			req_data.put("REPORT_CODE", report_code);
		//보고서코드 있을때
		}else {
			report_code = req_data.get("REPORT_CODE").toString();
		}
		
		//거래처 계약코드 월보년월로 TBL_CONSTRUCTION_CHK_RPT가 존재하는지 확인
		//존재할경우, 
		//TBL_CONSTRUCTION_CHK_RPT만 MERGE문 돌아가고
		//TBL_CONSTRUCTION_CHK_RPT_DT는 실행되지 않는다

		int count = query.selectOne(NAMESPACE + "yp_zcs_cpt.construction_chk_rpt_count", req_data);
		int result = 0;

		//존재하지 않을경우
		if(count < 1) {
			//TBL_CONSTRUCTION_CHK_RPT MERGE
			result += query.update(NAMESPACE + "yp_zcs_cpt.merge_construction_chk_rpt", req_data);
			
			logger.debug("[TEST]insert_construction_chk_rpt_dt");
			logger.debug("[TEST]insert_construction_chk_rpt_dt2");
			//TBL_CONSTRUCTION_CHK_RPT_DT INSERT 
			result += query.update(NAMESPACE + "yp_zcs_cpt.insert_construction_chk_rpt_dt_opt", req_data);
			
			//TBL_CONSTRUCTION_CHK_RPT_DT2 INSERT 
			result += query.update(NAMESPACE + "yp_zcs_cpt.insert_construction_chk_rpt_dt2_opt", req_data);
		}
		
	    resultMap.put("result",result);
		resultMap.put("REPORT_CODE",report_code);
		
		return resultMap;
	}

	@Override
	public List<HashMap<String, Object>> select_inspection_mon_list2_using_report_code(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		result = query.selectList(NAMESPACE + "yp_zcs_cpt.select_inspection_mon_list2_using_report_code", req_data);
		return result;
	}
	
	@Override
	public HashMap<String, Object> select_monthly_rpt1_section_dt(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HashMap<String, Object> result = new HashMap<String,Object>();
		result = query.selectOne(NAMESPACE + "yp_zcs_cpt.select_monthly_rpt1_section_dt", req_data);
		return result;
	}
	
	@Override
	public HashMap<String, Object> select_monthly_rpt2_section_dt(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HashMap<String, Object> result = new HashMap<String,Object>();
		result = query.selectOne(NAMESPACE + "yp_zcs_cpt.select_monthly_rpt2_section_dt", req_data);
		return result;
	}
	
	@Override
	public HashMap<String, Object> select_monthly_rpt3_section_dt(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HashMap<String, Object> result = new HashMap<String,Object>();
		result = query.selectOne(NAMESPACE + "yp_zcs_cpt.select_monthly_rpt3_section_dt", req_data);
		return result;
	}

}
