package com.yp.zhr.lbm.srvc;

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
import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoTable;
import com.vicurus.it.core.common.Util;
import com.yp.sap.SapJcoConnection;
import com.yp.util.DateUtil;
import org.springframework.transaction.annotation.Transactional;
import com.yp.zhr.lbm.srvc.intf.YP_ZHR_LBM_Service;

@Repository
public class YP_ZHR_LBM_ServiceImpl implements YP_ZHR_LBM_Service {

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

	private static final Logger logger = LoggerFactory.getLogger(YP_ZHR_LBM_ServiceImpl.class);


	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Transactional
	@Override
	public HashMap createDosilakReg(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HashMap resultMap = new HashMap();
		resultMap.put("msg", "등록중 오류가 발생하였습니다.\n관리자에게 문의해 주세요.");
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("reg_emp", (String) session.getAttribute("empCode"));//등록자 사번
		paramMap.put("reg_emp_name", (String) session.getAttribute("userName"));//등록자 성명
		paramMap.put("reg_dept",(String) session.getAttribute("userDept"));//등록자 부서명
		paramMap.put("insert_type","US");
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("gridData").toString());
		
		ArrayList<String> no = new ArrayList<String>();
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			
			//집계여부가 "집계완료" 아닌 경우에만 등록 가능한 로직임
			if(!"Y".equals(jsonObj.get("STATUS"))) {
				 no.add((String) jsonObj.get("EMP_CD"));
			}
		}

		paramMap.put("no", no);
		
		int result = 0;

		List dupli_list = query.selectList(NAMESPACE+"yp_ZHR.retrieveDosilakRegCheck",paramMap); //등록 중복조회
		logger.debug("dupli_list:{}",dupli_list);
		
		if(dupli_list.size() > 0){
			ArrayList<String>  temp1 = new ArrayList<String>();
			ArrayList<String>  temp2 = new ArrayList<String>();
			
			//2020-08-11 smh 수정
			//ArrayList => HashMap 캐스팅 에러
			//HashMap을 newHashMap()으로 수정
//			HashMap tempMap = (HashMap) dupli_list;
			HashMap tempMap = new HashMap();
			
			for(int i=0; i < dupli_list.size(); i++) {
				tempMap = (HashMap)dupli_list.get(i);
				temp1.add((String) tempMap.get("EMP_CD"));
			}

			//2020-08-11 smh 수정
			//캐스팅 에러
			//String[]을 List<String>로 수정
			//temp1 : 중복되는 사용자 코드 정보를 저장
			//temp2 : 등록하려고 보낸 사용자 코드 정보를 저장
//			for(String reqstr:(String[])paramMap.get("no")){
//				temp2.add(reqstr);
//			}
			for(String reqstr:(List<String>)paramMap.get("no")){
				temp2.add(reqstr);
			}
			
			logger.debug("temp1:"+temp1);
			logger.debug("temp2:"+temp2);
			
			java.util.Collection<String> result1 = CollectionUtils.subtract(temp2, temp1);//차집합
//			Collection<String> result2 = CollectionUtils.union(temp2, temp1);//합집합
//			Collection<String> result3 = CollectionUtils.intersection(temp2, temp1);//교집합

			logger.debug(""+result1.size());
			paramMap.put("no", result1);
			if(result1.size() >= 1)
				result = query.insert(NAMESPACE+"yp_ZHR.createDosilakReg", paramMap);
			else
				resultMap.put("msg", "이미 등록된 데이터입니다.");
		}else{
			result = query.insert(NAMESPACE+"yp_ZHR.createDosilakReg", paramMap);
		}
		
		if(result > 0) {
			resultMap.put("msg", result+"건 등록이 완료되었습니다.");
			resultMap.put("code", "00");
		}

		resultMap.put("result",result);
		
		return resultMap;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Transactional
	@Override
	public HashMap deleteDosilakAppli(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HashMap resultMap = new HashMap();
		resultMap.put("msg", "등록중 오류가 발생하였습니다.\n관리자에게 문의해 주세요.");
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("upd_emp", (String) session.getAttribute("empCode"));//등록자 사번
		logger.info("도시락신청 삭제 : "+paramMap);
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("gridData").toString());
		
		ArrayList<String> no = new ArrayList<String>();
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("{}", jsonObj);
			
			//집계여부가 "집계완료" 아닌 경우에만 등록 가능한 로직임
			if(!"Y".equals(jsonObj.get("STATUS"))) {
				 no.add((String) jsonObj.get("EMP_CD"));
			}
		}
		
		paramMap.put("no", no);
		
		int update = query.update(NAMESPACE+"yp_ZHR.deleteDosilakAppli",paramMap);
		
		if(update > 0) {
			resultMap.put("msg", update+"건 신청취소가 완료되었습니다.");
			resultMap.put("code", "00");
		
		}else{
			resultMap.put("msg", "취소에 실패하였습니다.\n관리자에게 문의해 주세요.");
			resultMap.put("code", "01");
		}


		resultMap.put("result",update);
		
		return resultMap;
	}

	@Override
	public List<Object> retrieveEmpWorkList(HashMap req_data) throws Exception {
		// TODO Auto-generated method stub
		return query.selectList(NAMESPACE+"yp_ZHR.retrieveEmpWorkList", req_data);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Transactional
	@Override
	public HashMap updateDosilakOk(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		resultMap.put("msg", "등록중 오류가 발생하였습니다.\n관리자에게 문의해 주세요.");
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
//		logger.debug("[넘어온]paramMap = "+paramMap);
		
		HttpSession session = request.getSession();
		paramMap.put("upd_emp", (String) session.getAttribute("empCode"));//등록자 사번
//		logger.debug("[세션추가]paramMap = "+paramMap);
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("gridData").toString());
		
		//seq데이터 추출하기
		ArrayList<String> seq = new ArrayList<String>();
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
//			logger.debug("[gridData]{}", jsonObj);
			
			seq.add(String.valueOf(jsonObj.get("SEQ")));
		}
		paramMap.put("seq", seq);
		
		
		int update = query.update(NAMESPACE+"yp_ZHR.updateDosilakOk",paramMap);
		
		if(update > 0) {
			resultMap.put("msg", update+"건 집계가 완료되었습니다.");
			resultMap.put("code", "00");
		
		}else{
			resultMap.put("msg", "집계에 실패하였습니다.\\n관리자에게 문의해 주세요.");
			resultMap.put("code", "01");
		}
		
		return resultMap;
		
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Transactional
	@Override
	public HashMap updateDosilakOkCancel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		resultMap.put("msg", "등록중 오류가 발생하였습니다.\n관리자에게 문의해 주세요.");
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
//		logger.debug("[넘어온]paramMap = "+paramMap);
		
		HttpSession session = request.getSession();
		paramMap.put("upd_emp", (String) session.getAttribute("empCode"));//등록자 사번
//		logger.debug("[세션추가]paramMap = "+paramMap);
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("gridData").toString());
		
		//seq데이터 추출하기
		ArrayList<String> seq = new ArrayList<String>();
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
//			logger.debug("[gridData]{}", jsonObj);
			
			seq.add(String.valueOf(jsonObj.get("SEQ")));
		}
		paramMap.put("seq", seq);
		
		
		int update = query.update(NAMESPACE+"yp_ZHR.updateDosilakOkCancel",paramMap);
		
		if(update > 0) {
			resultMap.put("msg", update+"건 집계취소가 완료되었습니다.");
			resultMap.put("code", "00");
		
		}else{
			resultMap.put("msg", "취소에 실패하였습니다.\\n관리자에게 문의해 주세요.");
			resultMap.put("code", "01");
		}
		
		return resultMap;
		
	}

	@Override
	public HashMap<String, Object> createRestaurantReg(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();
		resultMap.put("msg", "등록중 오류가 발생하였습니다.\n관리자에게 문의해 주세요.");
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("reg_emp", (String) session.getAttribute("empCode"));//등록자 사번
		paramMap.put("reg_emp_name", (String) session.getAttribute("userName"));//등록자 성명
		paramMap.put("reg_dept",(String) session.getAttribute("userDept"));//등록자 부서명
		paramMap.put("insert_type","US");
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("gridData").toString());
		
		ArrayList<String> no = new ArrayList<String>();
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("{}", jsonObj);
			
			//집계여부가 "집계완료" 아닌 경우에만 등록 가능한 로직임
			if(!"Y".equals(jsonObj.get("STATUS"))) {
				 no.add((String) jsonObj.get("EMP_CD"));
			}
		}

		paramMap.put("no", no);
		logger.debug("createDosilakReg.data = "+paramMap);
		
		int result = 0;

		logger.debug("NAMESPACE = "+NAMESPACE);
		List dupli_list = query.selectList(NAMESPACE+"yp_ZHR.retrieveRestaurantCheck",paramMap); //등록 중복조회
		logger.debug("dupli_list = "+dupli_list);
		
		if(dupli_list.size() > 0){
			ArrayList<String>  temp1 = new ArrayList<String>();
			ArrayList<String>  temp2 = new ArrayList<String>();
			
			//2020-08-11 smh 수정
			//ArrayList => HashMap 캐스팅 에러
			//HashMap을 newHashMap()으로 수정
//			HashMap tempMap = (HashMap) dupli_list;
			HashMap tempMap = new HashMap();
			
			for(int i=0; i < dupli_list.size(); i++) {
				tempMap = (HashMap)dupli_list.get(i);
				temp1.add((String) tempMap.get("EMP_CD"));
			}

			//2020-08-11 smh 수정
			//캐스팅 에러
			//String[]을 List<String>로 수정
			//temp1 : 중복되는 사용자 코드 정보를 저장
			//temp2 : 등록하려고 보낸 사용자 코드 정보를 저장
//			for(String reqstr:(String[])paramMap.get("no")){
//				temp2.add(reqstr);
//			}
			for(String reqstr:(List<String>)paramMap.get("no")){
				temp2.add(reqstr);
			}
			
			logger.debug("temp1:"+temp1);
			logger.debug("temp2:"+temp2);
			
			java.util.Collection<String> result1 = CollectionUtils.subtract(temp2, temp1);//차집합
//			Collection<String> result2 = CollectionUtils.union(temp2, temp1);//합집합
//			Collection<String> result3 = CollectionUtils.intersection(temp2, temp1);//교집합

			logger.debug(""+result1.size());
			paramMap.put("no", result1);
			if(result1.size() >= 1)
				result = query.insert(NAMESPACE+"yp_ZHR.createRestaurant", paramMap);
			else
				resultMap.put("msg", "이미 등록된 데이터입니다.");
		}else{
			logger.debug("createRestaurant 실행전");
			logger.debug("paramMap:"+paramMap);
			result = query.insert(NAMESPACE+"yp_ZHR.createRestaurant", paramMap);
			logger.debug("createRestaurant 실행후");
		}
		
		if(result > 0) {
			resultMap.put("msg", result+"건 등록이 완료되었습니다.");
			resultMap.put("code", "00");
		}

		resultMap.put("result",result);
		
		return resultMap;
	}
	
}
