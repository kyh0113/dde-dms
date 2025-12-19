package com.yp.zhr.rez.srvc;

import java.io.PrintWriter;
import java.sql.SQLException;
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
import com.yp.zhr.rez.srvc.intf.YP_ZHR_REZ_Service;
import com.yp.zhr.lbm.srvc.intf.YP_ZHR_LBM_Service;

@Repository
public class YP_ZHR_REZ_ServiceImpl implements YP_ZHR_REZ_Service {
	
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
	
	private static final Logger logger = LoggerFactory.getLogger(YP_ZHR_REZ_ServiceImpl.class);
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map createResortReservReg(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
//		int result = query.update(NAMESPACE+"Code.setCodeMasterMerge", paramMap);
		int result = query.insert(NAMESPACE+"yp_ZHR.createResortReservReg", paramMap);
		
		Map returnMap = new HashMap();
		returnMap.put("result", result);
		return returnMap;
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Transactional
	@Override
	public HashMap createResortReservReg_1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
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
//				HashMap tempMap = (HashMap) dupli_list;
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
//				for(String reqstr:(String[])paramMap.get("no")){
//					temp2.add(reqstr);
//				}
			for(String reqstr:(List<String>)paramMap.get("no")){
				temp2.add(reqstr);
			}
			
			logger.debug("temp1:"+temp1);
			logger.debug("temp2:"+temp2);
			
			java.util.Collection<String> result1 = CollectionUtils.subtract(temp2, temp1);//차집합
//				Collection<String> result2 = CollectionUtils.union(temp2, temp1);//합집합
//				Collection<String> result3 = CollectionUtils.intersection(temp2, temp1);//교집합

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
	
	
	//resort code list
	@Override
	public ArrayList<HashMap<String, String>> resortCodeList(HashMap paramMap) throws Exception {
		// TODO Auto-generated method stub
		return (ArrayList)query.selectList(NAMESPACE+"yp_ZHR.resortCodeList", paramMap);
	}
	
	
	//region code list
	@Override
	public ArrayList<HashMap<String, String>> regionCodeList(HashMap paramMap) throws Exception {
		// TODO Auto-generated method stub
		return (ArrayList)query.selectList(NAMESPACE+"yp_ZHR.regionCodeList", paramMap);
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int deleteResortRez(List paramList) throws SQLException {
		int paramListSize = paramList.size();
		int result = 0;
		for(int i = 0; i < paramListSize; i++){
			result += query.delete(NAMESPACE+"yp_ZHR.deleteResortRez", paramList.get(i));	//상세코드 삭제
		}
		
		return result;
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map resortRefuseReg(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		if(paramMap.get("status").equals("F")){
			String refuseReason = (String) paramMap.get("refuse_reason");
			refuseReason = refuseReason + " " + " [기타 문의사항은 인적자원관리팀 유하나 사원에게 이메일로 문의 바랍니다.]";
			
			paramMap.put("refuse_reason",refuseReason);
		}
		int result = query.update(NAMESPACE+"yp_ZHR.resortRefuseReg", paramMap);
		
		Map returnMap = new HashMap();
		returnMap.put("result", result);
		return returnMap;
	}
	
	
	@Override
	public HashMap<String, String> resortRezList(HashMap paramMap) throws Exception {
		// TODO Auto-generated method stub
		return (HashMap<String, String>)query.selectOne(NAMESPACE+"yp_ZHR.resortRezOne", paramMap);
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int deleteRegionCode(List paramList) throws SQLException {
		int paramListSize = paramList.size();
		int result = 0;
		for(int i = 0; i < paramListSize; i++){
			result += query.delete(NAMESPACE+"yp_ZHR.deleteRegionCode", paramList.get(i));	//상세코드 삭제
		}
		
		return result;
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int deleteResortCode(List paramList) throws SQLException {
		int paramListSize = paramList.size();
		int result = 0;
		for(int i = 0; i < paramListSize; i++){
			result += query.update(NAMESPACE+"yp_ZHR.deleteResortCode", paramList.get(i));	//상세코드 삭제
		}
		
		return result;
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int mergeResortCode(HashMap<String,Object> paramMap) throws SQLException {
		//int paramListSize = paramList.size();
		int result = 0;
		//for(int i = 0; i < paramListSize; i++){
			result += query.update(NAMESPACE+"yp_ZHR.mergeResortCode", paramMap);	//리조트명 수정
		//}
		
		return result;
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int createResortCode(HashMap<String,Object> paramMap) throws SQLException {
		int result = 0;
			result += query.insert(NAMESPACE+"yp_ZHR.createResortCode", paramMap);	//리조트코드 등록
		
		return result;
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int mergeRegionCode(HashMap<String,Object> paramMap) throws SQLException {
		int result = 0;
			result += query.update(NAMESPACE+"yp_ZHR.mergeRegionCode", paramMap);	//리조트코드 등록
		
		return result;
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int createRegionCode(HashMap<String,Object> paramMap) throws SQLException {
		int result = 0;
			result += query.insert(NAMESPACE+"yp_ZHR.createRegionCode", paramMap);	//리조트코드 등록
		
		return result;
	}
	
	
	//리조트 예약등록수정
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map updateResortReservReg(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = query.update(NAMESPACE+"yp_ZHR.updateResortReservReg", paramMap);
		
		Map returnMap = new HashMap();
		returnMap.put("result", result);
		return returnMap;
	}
	
	
	//리조트 예약등록수정 관리자
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map updateResortReservAdReg(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = query.update(NAMESPACE+"yp_ZHR.updateResortReservAdReg", paramMap);
		
		Map returnMap = new HashMap();
		returnMap.put("result", result);
		return returnMap;
	}
	
	
	//리조트 파일 유무
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map resortRezFileYn() throws Exception {

		Map YnMap = query.selectOne(NAMESPACE+"yp_ZHR.resortRezFileYn");
		return YnMap;
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int createResortFile(HashMap<String,Object> paramMap) throws SQLException {
		int result = 0;
			result += query.insert(NAMESPACE+"yp_ZHR.createResortFile", paramMap);	//리조트코드 등록
		
		return result;
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int updateResortFile(HashMap<String,Object> paramMap) throws SQLException {
		int result = 0;
			result += query.update(NAMESPACE+"yp_ZHR.updateResortFile", paramMap);	//리조트코드 등록
		
		return result;
	}
	
	
	//upload 파일명
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public String resortRezFileNm() throws Exception {

		String rezFileNm  = query.selectOne(NAMESPACE+"yp_ZHR.resortRezFileNm");
		return rezFileNm;
	}
	
}