package com.yp.zmm.aw.srvc;

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
import com.vicurus.it.core.common.WebUtil;
import com.yp.sap.SapJcoConnection;
import com.yp.zmm.aw.srvc.intf.YP_ZMM_AW_Service;

@Repository
public class YP_ZMM_AW_ServiceImpl implements YP_ZMM_AW_Service {
	
	// @Autowired
	// SapJcoConnection sapJcoConnection;
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
	
	@Autowired
	@Resource(name = "sqlSession3")
	private SqlSession query_cas;
	
	private static final Logger logger = LoggerFactory.getLogger(YP_ZMM_AW_ServiceImpl.class);
	
	@SuppressWarnings({ "unused", "rawtypes" })
	@Override
	public ArrayList<HashMap<String, String>> zmm_weight_list(HashMap paramMap) throws Exception {
		return (ArrayList) query.selectList(NAMESPACE + "yp_zmm_aw.select_zmm_weight_data_list", paramMap);
	}
	
	
	@SuppressWarnings({ "unused", "rawtypes" })
	@Override
	public int zmm_weight_delete(HashMap paramMap) throws Exception {
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("SEQ").toString());
		ArrayList<String> SEQS = new ArrayList<String>();
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			SEQS.add(String.valueOf(jsonObj.get("SEQ")));
		}
		paramMap.put("SEQS", SEQS);
		int result = query.delete(NAMESPACE + "yp_zmm_aw.zmm_weight_delete", paramMap);
		return result;
	}
	
	
	@SuppressWarnings({ "unused", "rawtypes" })
	@Override
	public int zmm_weight_save(HashMap paramMap) throws Exception {
		int cnt = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			// 수정이 아닌것은 제외
			//if (!jsonObj.containsKey("IS_MOD")) {
				//continue;
			//}
			jsonObj.put("s_emp_code", paramMap.get("s_emp_code"));
			//jsonObj.put("IS_NEW", paramMap.get("IS_NEW"));
			//jsonObj.put("IS_MOD", paramMap.get("IS_MOD"));
			//logger.debug("{}", jsonObj.get("IS_NEW"));
			
			if("Y".equals(jsonObj.get("IS_NEW"))) {
				cnt += query.update(NAMESPACE + "yp_zmm_aw.zmm_weight_data_insert", jsonObj);
			}
			else
			{
				cnt += query.update(NAMESPACE + "yp_zmm_aw.zmm_weight_save", jsonObj);
			}
		}
		return cnt;
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public int zmm_weight_dailyclosing(HashMap paramMap) throws Exception {
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("SEQ").toString());
		ArrayList<String> SEQS = new ArrayList<String>();
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			SEQS.add(String.valueOf(jsonObj.get("SEQ")));
		}
		paramMap.put("SEQS", SEQS);
		logger.debug("++" + paramMap);
		int result = query.delete(NAMESPACE + "yp_zmm_aw.zmm_weight_update_dclosing", paramMap);
		
		/*
		 * 2022.10.27 kjy ent_code 10자리 -> 6자리로 update 쿼리
		 */
		logger.info("###############################################");
		logger.info("########## setWeightTableEntCodeFieldReplaceData start! ###########");
		logger.info("###############################################");
		
		int updrows = query.update(NAMESPACE + "yp_zmm_aw.updateWeightTableEntCodeFieldData");
		
		logger.info("updrows : " + updrows);
		return result;
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public int zmm_weight_monthlyclosing(HashMap paramMap) throws Exception {
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("SEQ").toString());
		ArrayList<String> SEQS = new ArrayList<String>();
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			SEQS.add(String.valueOf(jsonObj.get("SEQ")));
		}
		paramMap.put("SEQS", SEQS);
		int result = query.delete(NAMESPACE + "yp_zmm_aw.zmm_weight_update_mclosing", paramMap);
		
		/*
		 * 2022.10.27 kjy ent_code 10자리 -> 6자리로 update 쿼리
		 */
		logger.info("###############################################");
		logger.info("########## setWeightTableEntCodeFieldReplaceData start! ###########");
		logger.info("###############################################");
		
		int updrows = query.update(NAMESPACE + "yp_zmm_aw.updateWeightTableEntCodeFieldData");
		
		logger.info("updrows : " + updrows);
		return result;
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int zmm_weight_cont_create_prc(HashMap paramMap) throws Exception {
		String YYYY = ((String) paramMap.get("effective_date")).substring(0, 4);
		String cont_code = "";
		paramMap.put("YYYY", YYYY);
		int max_code = query.selectOne(NAMESPACE + "yp_zmm_aw.zmm_weight_cont_code_max", paramMap);
		if (max_code == 0) {
			cont_code = YYYY + "001";
		} else {
			cont_code = Integer.toString(max_code + 1);
		}
		paramMap.put("cont_code", cont_code);
		paramMap.put("cont_no", "1");
		query.insert(NAMESPACE + "yp_zmm_aw.zmm_weight_cont_create_master", paramMap);
		
		int cnt = 0;
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("ROW_NO").toString());
		logger.debug("jsonArr={}", jsonArr);
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("CONT_CODE", cont_code);
			jsonObj.put("CONT_NO", "1");
			jsonObj.put("ENT_CODE", paramMap.get("ent_code"));
			cnt += query.insert(NAMESPACE + "yp_zmm_aw.zmm_weight_cont_create_product", jsonObj);
		}
		return cnt;
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public ArrayList<HashMap<String, String>> retrieveKUNNR(HashMap paramMap) throws Exception {
		SapJcoConnection sapJcoConnection = new SapJcoConnection();
		// sapJcoConnection = new SapJcoConnection();
		
		// RFC 명
		JCoFunction function = sapJcoConnection.getFunction("ZMM_WEIGH_002");
		
		// RFC 파라미터
		function.getImportParameterList().setValue((String) paramMap.get("search_type"), "*" + (String) paramMap.get("search_text") + "*");
		
		// RFC 호출
		sapJcoConnection.execute(function);
		
		// RFC 결과
		JCoTable table = function.getTableParameterList().getTable("T_KUNNR");
		
		ArrayList<HashMap<String, String>> list = sapJcoConnection.createSapList(table);
		
		return list;
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public ArrayList<HashMap<String, String>> retrieveMATNR(HashMap paramMap) throws Exception {
		SapJcoConnection sapJcoConnection = new SapJcoConnection();
		// sapJcoConnection = new SapJcoConnection();
		
		// RFC 명
		JCoFunction function = sapJcoConnection.getFunction("ZMM_WEIGH_001");
		
		// RFC 파라미터
		function.getImportParameterList().setValue((String) paramMap.get("search_type"), "*" + (String) paramMap.get("search_text") + "*");
		
		// RFC 호출
		sapJcoConnection.execute(function);
		
		// RFC 결과
		JCoTable table = function.getTableParameterList().getTable("T_MATNR");
		
		ArrayList<HashMap<String, String>> list = sapJcoConnection.createSapList(table);
		
		return list;
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public ArrayList<HashMap<String, String>> retrieveBill(HashMap paramMap) throws Exception {
		SapJcoConnection sapJcoConnection = new SapJcoConnection();
		// sapJcoConnection = new SapJcoConnection();
		
		// RFC 명
		JCoFunction function = sapJcoConnection.getFunction("ZWEB_POPUP_SBLIST");
		
		// RFC 파라미터
		function.getImportParameterList().setValue("I_SUPNO", (String) paramMap.get("REG_NO"));
		//function.getImportParameterList().setValue("ZMKDT_S", (String) paramMap.get("sdate"));
		//function.getImportParameterList().setValue("ZMKDT_E", (String) paramMap.get("edate"));
		function.getImportParameterList().setValue("ZMKDT_S", StringUtils.replace((String) paramMap.get("sdate"), "/", ""));
		function.getImportParameterList().setValue("ZMKDT_E", StringUtils.replace((String) paramMap.get("edate"), "/", ""));
		//function.getImportParameterList().setValue("I_SUPNO", "4488701968");
		//function.getImportParameterList().setValue("ZMKDT_S", "20250101");
		//function.getImportParameterList().setValue("ZMKDT_E", "20250429");
		
		// RFC 호출
		sapJcoConnection.execute(function);
		
		// RFC 결과
		JCoTable table = function.getTableParameterList().getTable("GT_DISP_OUT");
		
		ArrayList<HashMap<String, String>> list = sapJcoConnection.createSapList(table);
		
		return list;
	}
	
	
	@SuppressWarnings({"rawtypes", "unused"})
	@Override
	public String[] retrieveLIFNR(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_POPUP_LIFNR");
		
		function.getImportParameterList().setValue("I_LIFNR", (String) req_data.get("I_LIFNR"));
		
		// RFC 호출
		jcoConnect.execute(function);

		JCoTable table = function.getTableParameterList().getTable("GT_DISP");
		
		// RFC 결과
		String STCD2 = function.getExportParameterList().getString("E_STCD2");
		String NAME1 = function.getExportParameterList().getString("E_NAME1");
		String HKONT = function.getExportParameterList().getString("E_HKONT");
		String BVTYP = function.getExportParameterList().getString("E_BVTYP");
		String BANKN = function.getExportParameterList().getString("E_BANKN");
		String ZTERM = function.getExportParameterList().getString("E_ZTERM");
		String TEXT1 = function.getExportParameterList().getString("E_TEXT1");
		
		String[] return_str = {STCD2, NAME1, HKONT, BVTYP, BANKN, ZTERM, TEXT1};
		
		return return_str;

	}
	
	
	@SuppressWarnings({"rawtypes", "unused"})
	@Override
	public String[] retrieveBUDGET(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_POPUP_BUDGET");
		
		
		function.getImportParameterList().setValue("I_BUKRS", "1000"); // 회사코드 1000고정
		function.getImportParameterList().setValue("I_BUPLA","1200");
		function.getImportParameterList().setValue("I_KOSTL", "214101");
		function.getImportParameterList().setValue("I_ZKOSTL", "230201");
		function.getImportParameterList().setValue("I_HKONT", "43324201");
		function.getImportParameterList().setValue("I_BUDAT", (String) req_data.get("I_BUDAT"));
		
		// RFC 호출
		jcoConnect.execute(function);
		
		// RFC 결과
		String E_AVAIL_AMT = function.getExportParameterList().getString("E_AVAIL_AMT");
		
		String[] return_str = {E_AVAIL_AMT};
		
		return return_str;

	}
	
	
	@SuppressWarnings({"rawtypes", "unused"})
	@Override
	public String[] createDocument(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();
		logger.debug("FIServiceImpl.createDocument.data=" + req_data);

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_POSTING_DOCUMENT");

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue("I_ZPERNR", req_data.get("emp_code")); // 사번
		//if ("5".equals((String) req_data.get("doc_type"))) {
		function.getImportParameterList().setValue("I_IMPORT", ""); // 수입전표 일때
		//}
		
		// RFC 파라미터 - 순서가 중요한지 확인 필요
		JCoTable ZFIS0010 = function.getTableParameterList().getTable("ZFIS0010_W"); // 기본정보, 구매처정보
		ZFIS0010.appendRow();
		//if ("5".equals((String) req_data.get("doc_type"))){
			//ZFIS0010.setValue("BLART", "CA"); // 전표유형 수입=CA
		//}else{
		ZFIS0010.setValue("BLART", "SA"); // 전표유형
		//}
		ZFIS0010.setValue("BUKRS", "1200"); // 회사코드
		
		//if(!WebUtil.isNull(req_data.get("BUDAT"))){
		ZFIS0010.setValue("GJAHR", ((String) req_data.get("I_BUDAT")).substring(0, 4)); // 회계년도
		//ZFIS0010.setValue("GJAHR", "2025"); // 회계년도
		//logger.debug("GJAHR:{}", ZFIS0010.getValue("GJAHR"));
		//}
		
		ZFIS0010.setValue("BUDAT", StringUtils.replace((String) req_data.get("I_BUDAT"), "/", "")); // 전표 전기일
		//ZFIS0010.setValue("BUDAT", StringUtils.replace((String) req_data.get("BUDAT"), "/", "")); // 전표 전기일
		//logger.debug("BUDAT:{}", ZFIS0010.getValue("BUDAT"));
		
		ZFIS0010.setValue("BLDAT", StringUtils.replace((String) req_data.get("I_BUDAT"), "/", "")); // 전표 증빙일
		//logger.debug("### BLDAT:{}", ZFIS0010.getValue("BLDAT"));
		
		ZFIS0010.setValue("WAERS", "KRW"); // 통화
		//logger.debug("WAERS:{}", ZFIS0010.getValue("WAERS"));
		
		ZFIS0010.setValue("KURSF", StringUtils.replace((String) "", ",", "")); // 환율
		//ZFIS0010.setValue("KURSF", StringUtils.replace((String) req_data.get("KURSF"), ",", "")); // 환율
		//logger.debug("KURSF:{}", ZFIS0010.getValue("KURSF"));
		
		ZFIS0010.setValue("BUPLA", "1200"); // 사업장
		//logger.debug("BUPLA:{}", ZFIS0010.getValue("BUPLA"));
		
		ZFIS0010.setValue("BKTXT", "5월 폐기물 처리비("+req_data.get("ENT")+")"); // 전표헤더 텍스트"
		
		//logger.debug("BKTXT:{}", ZFIS0010.getValue("BKTXT"));
		
		ZFIS0010.setValue("AGKOA", "S"); // 계정 유형
		//logger.debug("AGKOA:{}", ZFIS0010.getValue("AGKOA"));
		
		ZFIS0010.setValue("LIFNR", req_data.get("I_LIFNR")); // 공급업체
		//logger.debug("LIFNR:{}", ZFIS0010.getValue("LIFNR"));
		
		ZFIS0010.setValue("STCD2", req_data.get("STCD2")); // 사업자등록번호
		//logger.debug("STCD2:{}", ZFIS0010.getValue("STCD2"));
		
		ZFIS0010.setValue("NAME1", req_data.get("NAME1")); // 상호
		//logger.debug("NAME1:{}", ZFIS0010.getValue("NAME1"));
		
		ZFIS0010.setValue("HKONT", "21103101"); // 계정과목
		//logger.debug("HKONT:{}", ZFIS0010.getValue("HKONT"));
		
		ZFIS0010.setValue("MWSKZ", "11"); // 세금코드
		//logger.debug("MWSKZ:{}", ZFIS0010.getValue("MWSKZ"));
		
		ZFIS0010.setValue("BVTYP", req_data.get("BVTYP")); // 은행코드
		//logger.debug("BVTYP:{}", ZFIS0010.getValue("BVTYP"));
		
		ZFIS0010.setValue("BANKN", req_data.get("BANKN")); // 계좌번호
		//logger.debug("BANKN:{}", ZFIS0010.getValue("BANKN"));
		
		ZFIS0010.setValue("SGTXT", req_data.get("SGTXT")); // 텍스트
		//logger.debug("SGTXT:{}", ZFIS0010.getValue("SGTXT"));
		
		ZFIS0010.setValue("ZSUPAMT", StringUtils.replace((String) req_data.get("HWBAS"), ",", "")); // 공급가액
		//logger.debug("ZSUPAMT:{}", ZFIS0010.getValue("ZSUPAMT"));
		
		ZFIS0010.setValue("WMWST", StringUtils.replace((String) req_data.get("HWSTE"), ",", "")); // 세액
		//logger.debug("WMWST:{}", ZFIS0010.getValue("WMWST"));
		
		ZFIS0010.setValue("ZEXPAMT", 0); // 추가액
		//logger.debug("ZEXPAMT:{}", ZFIS0010.getValue("ZEXPAMT"));
		
		ZFIS0010.setValue("WSKTO", 0); // 할인액
		//logger.debug("WSKTO:{}", ZFIS0010.getValue("WSKTO"));
		
		ZFIS0010.setValue("ZTOPAY", StringUtils.replace((String) req_data.get("ZTTAT"), ",", "")); // 총지급액
		//logger.debug("ZTOPAY:{}", ZFIS0010.getValue("ZTOPAY"));
		
		ZFIS0010.setValue("KTOKK", req_data.get("I_LIFNR")); // 거래처 분류코드
		//logger.debug("KTOKK:{}", ZFIS0010.getValue("KTOKK"));
		
		ZFIS0010.setValue("ZTERM", req_data.get("ZTERM")); // 지급조건
		//logger.debug("ZTERM:{}", ZFIS0010.getValue("ZTERM"));
		
		ZFIS0010.setValue("GSBER", "1200"); // 사업영역
		//logger.debug("GSBER:{}", ZFIS0010.getValue("GSBER"));
		
		JCoTable ZFIS0020 = function.getTableParameterList().getTable("ZFIS0020_W"); // 전표 개별항목

		//JSONParser jsonParse = new JSONParser();
		//JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("row_no").toString());
		//for (int i = 0; i < jsonArr.size(); i++) {
			//JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			//logger.debug("{}", jsonObj);
			ZFIS0020.appendRow();
			ZFIS0020.setValue("BSCHL", "40"); // 차변대변
			//logger.debug("BSCHL:{}", ZFIS0020.getValue("BSCHL"));
			
			ZFIS0020.setValue("HKONT", "43324201"); // 계정과목
			//logger.debug("HKONT:{}", ZFIS0020.getValue("HKONT"));
			
			ZFIS0020.setValue("TXT_50", "(제조)지급수수료-폐기물처리비"); // 계정텍스트
			//logger.debug("TXT_50:{}", ZFIS0020.getValue("TXT_50"));
			
			ZFIS0020.setValue("ZKOSTL", "230201"); // 집행부서
			//ZFIS0020.setValue("ZKOSTL", jsonObj.get("ZKOSTL")); // 집행부서
			//logger.debug("ZKOSTL:{}", ZFIS0020.getValue("ZKOSTL"));
			
			ZFIS0020.setValue("ZKTEXT", "재료물류"); // 집행부서명
			//ZFIS0020.setValue("ZKTEXT", jsonObj.get("ZKTEXT")); // 집행부서명
			//logger.debug("ZKTEXT:{}", ZFIS0020.getValue("ZKTEXT"));
			
			ZFIS0020.setValue("KOSTL", "214101"); // 코스트센터
			//ZFIS0020.setValue("KOSTL", jsonObj.get("KOSTL")); // 코스트센터
			//logger.debug("KOSTL:{}", ZFIS0020.getValue("KOSTL"));
			
			ZFIS0020.setValue("LTEXT", "용해"); // 코스트센터명
			//ZFIS0020.setValue("LTEXT", jsonObj.get("LTEXT")); // 코스트센터명
			//logger.debug("LTEXT:{}", ZFIS0020.getValue("LTEXT"));

			ZFIS0020.setValue("AVAIL_AMT", StringUtils.replace((String) req_data.get("AVAIL_AMT"), ",", "")); // 가용예산
			//logger.debug("AVAIL_AMT:{}", ZFIS0020.getValue("AVAIL_AMT"));
			
			ZFIS0020.setValue("CHK", ""); // 추가경비
			//logger.debug("CHK:{}", ZFIS0020.getValue("CHK"));
			
			ZFIS0020.setValue("XNEGP", ""); // 마이너스 구분
			//logger.debug("XNEGP:{}", ZFIS0020.getValue("XNEGP"));
			
			if (!StringUtils.hasLength((String) req_data.get("HWBAS"))) { //is null
				ZFIS0020.setValue("WRBTR", StringUtils.replace((String) req_data.get("HWBAS"), ",", "")); // 금액
			
			}else {
				ZFIS0020.setValue("WRBTR", StringUtils.replace((String) req_data.get("HWBAS"), ",", "").replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 금액
			}
			//logger.debug("WRBTR:{}", ZFIS0020.getValue("WRBTR"));
			
			//if (!StringUtils.hasLength((String) jsonObj.get("STCD2"))) {	//is null
			ZFIS0020.setValue("STCD2", ""); // 사업자등록번호
			//}else {	//not null
				//ZFIS0020.setValue("STCD2", jsonObj.get("STCD2").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 사업자등록번호
			//}
			//logger.debug("STCD2:{}", ZFIS0020.getValue("STCD2"));
			
			//if (!StringUtils.hasLength((String) jsonObj.get("NAME1"))) {	//is null
			ZFIS0020.setValue("NAME1", req_data.get("ENT"));
			//ZFIS0020.setValue("NAME1", jsonObj.get("NAME1")); // 거래처명
			
			//}else { //not null
				//ZFIS0020.setValue("NAME1", jsonObj.get("NAME1").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 거래처명
			//}
			//logger.debug("NAME1:{}", ZFIS0020.getValue("NAME1"));
			
			//if (!StringUtils.hasLength((String) jsonObj.get("SGTXT"))) { //is null
			//ZFIS0020.setValue("SGTXT", req_data.get("SGTXT")); // 텍스트
			ZFIS0020.setValue("SGTXT", "4월 폐기물 처리비("+req_data.get("ENT")+")"); // 텍스트
			
			
			//}else {	//not null
				//ZFIS0020.setValue("SGTXT", jsonObj.get("SGTXT").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 텍스트
			//}
			//logger.debug("SGTXT:{}", ZFIS0020.getValue("SGTXT"));
			
			//if (!StringUtils.hasLength((String) jsonObj.get("POSID"))) {	//is null
				//ZFIS0020.setValue("POSID", jsonObj.get("POSID")); 			// WBS코드
			//}else {	//not null
				//ZFIS0020.setValue("POSID", jsonObj.get("POSID").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // WBS코드
			//}
			//logger.debug("POSID:{}", ZFIS0020.getValue("POSID"));
			
			//ZFIS0020.setValue("POST1", jsonObj.get("POST1")); // WBS코드명
			//logger.debug("POST1:{}", ZFIS0020.getValue("POST1"));
			
			//if (!StringUtils.hasLength((String) jsonObj.get("VBELN"))) {	//is null
				//ZFIS0020.setValue("VBELN", jsonObj.get("VBELN")); 			// 판매오더
			//}else {	//not null
				//ZFIS0020.setValue("VBELN", jsonObj.get("VBELN").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 판매오더
			//}
			//logger.debug("VBELN:{}", ZFIS0020.getValue("VBELN"));
			
			//ZFIS0020.setValue("VTWEG", jsonObj.get("VTWEG")); // 유통경로
			//ZFIS0020.setValue("VTWEG", ""); // 유통경로
			//logger.debug("VTWEG:{}", ZFIS0020.getValue("VTWEG"));
			
			//if (!StringUtils.hasLength((String) jsonObj.get("MVGR1"))) {	//is null
				//ZFIS0020.setValue("MVGR1", jsonObj.get("MVGR1")); // 자재그룹
			//}else {	//not null
				//ZFIS0020.setValue("MVGR1", jsonObj.get("MVGR1").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 자재그룹
			//}
			//logger.debug("MVGR1:{}", ZFIS0020.getValue("MVGR1"));
			
			//ZFIS0020.setValue("WW002", jsonObj.get("WW002")); // 매출구분
			//logger.debug("WW002:{}", ZFIS0020.getValue("WW002"));
			
			//ZFIS0020.setValue("MENGE", StringUtils.replace((String) jsonObj.get("MENGE"), ",", "")); // 수량
			//logger.debug("MENGE:{}", ZFIS0020.getValue("MENGE"));
			
			//if (!StringUtils.hasLength((String) jsonObj.get("MEINS"))) {	//is null
				//ZFIS0020.setValue("MEINS", jsonObj.get("MEINS")); 			// 단위
			//}else{	//not null
				//ZFIS0020.setValue("MEINS", jsonObj.get("MEINS").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 단위
			//}
			//logger.debug("MEINS:{}", ZFIS0020.getValue("MEINS"));
			
			//if (!StringUtils.hasLength((String) jsonObj.get("ZBSTKD"))) {	//is null
				//ZFIS0020.setValue("ZBSTKD", jsonObj.get("ZBSTKD")); 		// 구매오더
			//}else {	//not null
				//ZFIS0020.setValue("ZBSTKD", jsonObj.get("ZBSTKD").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 구매오더
			//}
			//logger.debug("ZBSTKD:{}", ZFIS0020.getValue("ZBSTKD"));
			
			//if (!StringUtils.hasLength((String) jsonObj.get("ZCCODE"))) {	//is null
				//ZFIS0020.setValue("ZCCODE", jsonObj.get("ZCCODE")); 		// 차량코드
			//}else {	//not null
				//ZFIS0020.setValue("ZCCODE", jsonObj.get("ZCCODE").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 차량코드
			//}
			//logger.debug("ZCCODE:{}", ZFIS0020.getValue("ZCCODE"));
			
			//if (!StringUtils.hasLength((String) jsonObj.get("ZCTEXT"))) {	//is null
				//ZFIS0020.setValue("ZCTEXT", jsonObj.get("ZCTEXT")); 		// 차량코드명
			//}else {	//not null
				//ZFIS0020.setValue("ZCTEXT", jsonObj.get("ZCTEXT").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "" )); // 차량코드명
			//}
			//logger.debug("ZCTEXT:{}", ZFIS0020.getValue("ZCTEXT"));
			
			//if (!StringUtils.hasLength((String) jsonObj.get("AUFNR"))) {	//is null
				//ZFIS0020.setValue("AUFNR", jsonObj.get("AUFNR")); // 설비오더 19.04추가
			//}else{	//not null
				//ZFIS0020.setValue("AUFNR", jsonObj.get("AUFNR").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "" )); // 설비오더 19.04추가
			//}
			//logger.debug("AUFNR:{}", ZFIS0020.getValue("AUFNR"));
			
			//ZFIS0020.setValue("VALUT", StringUtils.replace((String) jsonObj.get("VALUT"), "/", "")); // 기준일 20.06추가
			//logger.debug("VALUT:{}", ZFIS0020.getValue("VALUT"));
			
			//ZFIS0020.setValue("ZFBDT", StringUtils.replace((String) jsonObj.get("ZFBDT"), "/", "")); // 지급기산일 20.06추가
			//logger.debug("ZFBDT:{}", ZFIS0020.getValue("ZFBDT"));
		//}

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		String result = function.getExportParameterList().getString("E_FLAG");
		String msg = function.getExportParameterList().getString("E_MESSAGE");
		String doc_no = function.getExportParameterList().getString("E_BELNR");

		JCoTable table = function.getTableParameterList().getTable("ZFIS0010_W");
		logger.debug(result + "||" + msg);
		String[] return_str = {result, msg};

		/**
		 * YPWEBPOTAL-16 차량계량 정산 > 전자결재 상태값 변경 오류 및 전표번호 리턴 오류
		 * doc_no(E_BELNR) 값을 TBL_WEIGHT_CALC 테이블에 CALC_CODE 조건에 FI_DOC_NO 업데이트
		 * */
		// S
		
		String[] codes = req_data.get("CALC_CODE").toString().split(";");
		ArrayList<String> CODES = new ArrayList<String>();
		for (String s : codes) {
			CODES.add(s);
		}
		
		if("S".equals(result)){
			req_data.put("CODES", CODES);
			req_data.put("FI_DOC_NO", doc_no);
			query.update(NAMESPACE + "yp_zmm_aw.zmm_weight_fidocno_update", req_data);
		}
		
		return return_str;
	}
	
	
	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void retrieveMATNR_SW() throws Exception {
		
		 try{
		 SapJcoConnection jcoConnect = new SapJcoConnection();
		 JCoFunction function = jcoConnect.getFunction("ZMM_WEIGH_001");
		 
		 jcoConnect.execute(function);
		 
		 JCoTable table = function.getTableParameterList().getTable("T_MATNR");
		 
		 ArrayList<HashMap<String, String>> saplist = jcoConnect.createSapList(table);
		 
		 HashMap<String, String> syncmap = new HashMap<String, String>();
		 List<HashMap<String, String>> wplist = query.selectList(NAMESPACE + "yp_zmm_aw.zmm_weight_product_detail");
		 
		 String process = "";
		 
		 int cnt = 0;
		 
		 if(saplist.size() > 0){
			 for(HashMap<String, String> sapmap : saplist){
				 for(HashMap<String, String> wpmap : wplist){
					 cnt++;
					 if(sapmap.get("MATNR").equals(wpmap.get("MATNR"))){ //SAP 코드
						 syncmap = sapmap;
						 if(!sapmap.get("MAKTX").equals(wpmap.get("MAKTX"))){ //SAP 명
							 process = "update";
							 logger.debug("SAP 명 변경");
						 }else{
							 process="nothing";
							 logger.debug("변경사항 없음");
						 }
						 
						 if(process.equals("update")){
							 int updrows = query.update(NAMESPACE + "yp_zmm_aw.updateWeight_product",syncmap);
						 }
						 wplist.remove(syncmap);
						 break;
					 }
				 }
				 
				 if(!process.equals("update") && !process.equals("nothing")){
					 process = "insert";
					 syncmap.put("MATNR", sapmap.get("MATNR")); // SAP 코드
					 syncmap.put("MAKTX", sapmap.get("MAKTX")); // SAP 명
					 
					 int insrows = query.update(NAMESPACE + "yp_zmm_aw.createWeight_product",syncmap);
					 logger.info("insert : "+syncmap.get("MATNR"));
				 }
				 process = "";
				 syncmap.clear();
				 cnt++;
			 }
		 }else{
			 logger.info("SAP 정보 rows 없음!!");
		 }
		 }catch (Exception e){
			 logger.debug("오류발생 : "+e.getMessage());
		 }
	}
	
	
	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void retrieveKUNNR_SW() throws Exception {
		
		 try{
		 SapJcoConnection jcoConnect = new SapJcoConnection();
		 JCoFunction function = jcoConnect.getFunction("ZMM_WEIGH_002");
		 
		 jcoConnect.execute(function);
		 
		 JCoTable table = function.getTableParameterList().getTable("T_KUNNR");
		 
		 ArrayList<HashMap<String, String>> saplist = jcoConnect.createSapList(table);
		 
		 HashMap<String, String> syncmap = new HashMap<String, String>();
		 List<HashMap<String, String>> wplist = query.selectList(NAMESPACE + "yp_zmm_aw.zmm_weight_company_detail");
		 
		 String process = "";
		 
		 int cnt = 0;
		 
		 if(saplist.size() > 0){
			 for(HashMap<String, String> sapmap : saplist){
				 for(HashMap<String, String> wpmap : wplist){
					 cnt++;
					 if(sapmap.get("KUNNR").equals(wpmap.get("KUNNR"))){ //SAP 코드
						 syncmap = sapmap;
						 if(!sapmap.get("NAME1").equals(wpmap.get("NAME1"))){ //SAP 명
							 process = "update";
							 logger.debug("SAP 명 변경");
						 }else{
							 process = "nothing";
							 logger.debug("변경사항 없음");
						 }
						 
						 if(process.equals("update")){
							 int updrows = query.update(NAMESPACE + "yp_zmm_aw.updateWeight_company",syncmap);
						 }
						 wplist.remove(syncmap);
						 break;
					 }
				 }
				 
				 if(!process.equals("update") && !process.equals("nothing")){
					 process = "insert";
					 syncmap.put("KUNNR", sapmap.get("KUNNR")); // SAP 코드
					 syncmap.put("NAME1", sapmap.get("NAME1")); // SAP 명
					 
					 int insrows = query.update(NAMESPACE + "yp_zmm_aw.createWeight_company",syncmap);
					 logger.info("insert : "+syncmap.get("KUNNR"));
				 }
				 process = "";
				 syncmap.clear();
				 cnt++;
			 }
		 }else{
			 logger.info("SAP 정보 rows 없음!!");
		 }
		 }catch (Exception e){
			 logger.debug("오류발생 : "+e.getMessage());
		 }
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<HashMap<String, Object>> zmm_weight_p_name_list(HashMap paramMap) throws Exception {
		return query_cas.selectList(NAMESPACE + "yp_zmm_aw.zmm_weight_p_name_list", paramMap);
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public ArrayList<HashMap<String, String>> retrieveVKBUR(HashMap paramMap) throws Exception {
		SapJcoConnection sapJcoConnection = new SapJcoConnection();
		
		// RFC 명
		JCoFunction function = sapJcoConnection.getFunction("ZMM_WEIGH_004");
		
		// RFC 파라미터
		function.getImportParameterList().setValue("I_SALES_ORG", (String) paramMap.get("I_SALES_ORG"));
		function.getImportParameterList().setValue("I_DISTR_CHAN", (String) paramMap.get("I_DISTR_CHAN"));
		function.getImportParameterList().setValue("I_DIVISION", (String) paramMap.get("I_DIVISION"));
		
		// RFC 호출
		sapJcoConnection.execute(function);
		
		// RFC 결과
		JCoTable table = function.getTableParameterList().getTable("T_SALES_OFF");
		
		ArrayList<HashMap<String, String>> list = sapJcoConnection.createSapList(table);
		
		return list;
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<HashMap<String, Object>> zmm_p_detail_code_cas(HashMap paramMap) throws Exception {
		return query_cas.selectList(NAMESPACE + "yp_zmm_aw.zmm_weight_p_detail_code_list", paramMap);
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public HashMap<String, String> zmm_weight_p_code_list(HashMap paramMap) throws Exception {
		return query_cas.selectOne(NAMESPACE + "yp_zmm_aw.zmm_weight_p_code_list", paramMap);
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public HashMap<String, String> zmm_weight_p_name_cas(HashMap paramMap) throws Exception {
		List temp = query_cas.selectList(NAMESPACE + "yp_zmm_aw.zmm_weight_p_name_cas", paramMap);
		HashMap<String, String> result = (HashMap<String, String>) temp.get(0);
		return result;
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public HashMap<String, String> zmm_weight_cont_detail(HashMap paramMap) throws Exception {
		return query.selectOne(NAMESPACE + "yp_zmm_aw.zmm_weight_cont_detail", paramMap);
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public int zmm_weight_cont_detail_save(HashMap paramMap) throws Exception {
		
		/*
		 * 2022.08.03 JhOh
			YPWEBPOTAL-17 차량계량마스터 수정 시 오류
			 - <update> 구문 <insert> 로 수정
			 - zmm_weight_cont_seq_no seq next value 함수 추가
			 - 발췌한 value : zmm_weight_cont_create_master, zmm_weight_cont_create_product 에 공통 키값으로 참조 전송
		 *
		 * */
		//String nextSeqValue = query.selectOne(NAMESPACE + "yp_zmm_aw.zmm_weight_cont_seq_no");
		//int max_cont_no = query.selectOne(NAMESPACE + "yp_zmm_aw.zmm_weight_cont_no", paramMap);
		
		//logger.debug("!!! nextSeqValue ", nextSeqValue);
		//logger.debug("!!! max_cont_no ", max_cont_no);
		
		//paramMap.put("master_seq", nextSeqValue);
		//paramMap.put("cont_no", max_cont_no + 1);
		//query.insert(NAMESPACE + "yp_zmm_aw.zmm_weight_cont_create_master", paramMap);
		
		int cnt = 0;
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("ROW_NO").toString());
		logger.debug("jsonArr={}", jsonArr);
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			
			//jsonObj.put("MASTER_SEQ_FK", nextSeqValue);
			jsonObj.put("CONT_CODE", paramMap.get("cont_code"));
			jsonObj.put("CONT_NO", paramMap.get("cont_no"));
			jsonObj.put("ENT_CODE", paramMap.get("ent_code"));
			cnt += query.insert(NAMESPACE + "yp_zmm_aw.zmm_weight_cont_create_product", jsonObj);
		}
		return cnt;
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int zmm_weight_cont_delete(HashMap paramMap) throws Exception {
		//int max_cont_no = query.selectOne(NAMESPACE + "yp_zmm_aw.zmm_weight_cont_no", paramMap);
		//int cont_no = Integer.parseInt(paramMap.get("cont_no").toString());
		//logger.debug(max_cont_no + "/" + cont_no);
		int cnt = 0;
		//if (max_cont_no == cont_no) {
		cnt += query.delete(NAMESPACE + "yp_zmm_aw.zmm_weight_cont_delete_master", paramMap);
		cnt += query.delete(NAMESPACE + "yp_zmm_aw.zmm_weight_cont_delete_product", paramMap);
		//}
		return cnt;
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<Object> calc_detail_list(HashMap paramMap) throws Exception {
		return query.selectList(NAMESPACE + "yp_zmm_aw.calc_detail_list", paramMap);
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	@Transactional(rollbackFor = Exception.class)
	public String[] so_create_save(HashMap req_data) throws Exception {
		SapJcoConnection sapJcoConnection = new SapJcoConnection();
		
		// RFC 명
		JCoFunction function = sapJcoConnection.getFunction("ZMM_WEIGH_003");
		
		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue("I_DOC_TYPE", (String) req_data.get("I_DOC_TYPE"));
		function.getImportParameterList().setValue("I_SALES_ORG", (String) req_data.get("I_SALES_ORG"));
		function.getImportParameterList().setValue("I_DISTR_CHAN", (String) req_data.get("I_DISTR_CHAN"));
		function.getImportParameterList().setValue("I_DIVISION", (String) req_data.get("I_DIVISION"));
		function.getImportParameterList().setValue("I_SALES_OFF", (String) req_data.get("I_SALES_OFF"));
		function.getImportParameterList().setValue("I_MATERIAL", (String) req_data.get("I_MATERIAL"));
		function.getImportParameterList().setValue("I_SC_REQ_QTY", StringUtils.replace((String) req_data.get("I_SC_REQ_QTY"), ",", ""));
		function.getImportParameterList().setValue("I_ZPRE_VALUE", StringUtils.replace((String) req_data.get("I_ZPRE_VALUE"), ",", ""));
		/**
		 * 2022-06-16 YPWEBPOTAL-3 차량계량 정산 > 오더 생성 > 고객 코드 수정 차량계량 정산 > 오더 생성 > 고객에서 고객 코드 검색 시 6자리로 나오는데, SAP에서는 코드를 10자리로 인식해야합니다.코드 앞에 0을 4개 입력하여 SAP로 넘어가도록 변경 요청 드립니다.
		 */
		function.getImportParameterList().setValue("I_PART_PARTN_NUMB", WebUtil.leftPad(WebUtil.checkNull(req_data.get("I_PART_PARTN_NUMB")), 10));
		
		// RFC 호출
		sapJcoConnection.execute(function);
		
		// RFC 결과
		String so_no = function.getExportParameterList().getString("E_SALESDOCUMENT_EX");
		String msg = function.getExportParameterList().getString("E_MESSAGE");
		String[] return_str = { so_no, msg, "" };
		if (so_no != "") {
			req_data.put("SO_NO", so_no);
			int upd = query.update(NAMESPACE + "yp_zmm_aw.zmm_weight_so_update", req_data);
			if (upd < 1)
				return_str[2] = "판매오더 저장에 오류가 발생하였습니다.(SAP에는 정상등록)";
		} else {
			return_str[2] = return_str[1];
		}
		return return_str;
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int zmm_weight_calc_save(HashMap paramMap) throws Exception {
		int chk_cnt = 0;
		int cnt = 0;
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("ROW_NO").toString());
		//logger.debug("jsonArr={}", jsonArr);
		String code_str = query.selectOne(NAMESPACE + "yp_zmm_aw.zmm_weight_calc_code_max", paramMap);
		String code_new = "";
		//logger.debug("code_str=" + code_str);
		if (code_str.equals("0")) {
			code_new = "0001";
		} else {
			code_new = code_str.substring(8);
			int temp = Integer.parseInt(code_new) + 1;
			code_new = String.format("%04d", temp);
		}
		code_str = paramMap.get("DATE") + code_new;
		
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			chk_cnt = query.selectOne(NAMESPACE + "yp_zmm_aw.zmm_weight_calc_chk", jsonObj);
			
			if (chk_cnt > 0) {
				cnt += query.update(NAMESPACE + "yp_zmm_aw.zmm_weight_calc_update", jsonObj);
			} else if (chk_cnt == 0) {
				jsonObj.put("CALC_CODE", code_str);
				
				//logger.debug("insert로직:" + jsonObj);
				jsonObj.put("sdate", paramMap.get("sdate"));
				jsonObj.put("edate", paramMap.get("edate"));
				jsonObj.put("COM_W", paramMap.get("COM_W"));
				int upd = query.update(NAMESPACE + "yp_zmm_aw.zmm_weight_data_update", jsonObj);
				if (upd > 0)
					jsonObj.put("COM_W", paramMap.get("COM_W"));
					cnt += query.insert(NAMESPACE + "yp_zmm_aw.zmm_weight_calc_insert", jsonObj);
					
				code_new = code_str.substring(8);
				int temp1 = Integer.parseInt(code_new) + 1;
				code_new = String.format("%04d", temp1);
				code_str = paramMap.get("DATE") + code_new;
			}
		}
		return cnt;
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<HashMap<String, Object>> zmm_weight_calc_edoc_list(HashMap paramMap) throws Exception {
		String[] codes = paramMap.get("CALC_CODE").toString().split(";");
		ArrayList<String> CODES = new ArrayList<String>();
		for (String s : codes) {
			CODES.add(s);
		}
		paramMap.put("CODES", CODES);
		return query.selectList(NAMESPACE + "yp_zmm_aw.zmm_weight_calc_edoc_list", paramMap);
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<HashMap<String, Object>> zmm_weight_data_edoc_list(HashMap paramMap) throws Exception {
		String[] codes = paramMap.get("CALC_CODE").toString().split(";");
		ArrayList<String> CODES = new ArrayList<String>();
		for (String s : codes) {
			CODES.add(s);
		}
		paramMap.put("CODES", CODES);
		return query.selectList(NAMESPACE + "yp_zmm_aw.zmm_weight_data_edoc_list", paramMap);
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<Object> zmm_weight_edoc_calc_detail_list(HashMap paramMap) throws Exception {
		String[] codes = paramMap.get("CALC_CODE").toString().split(";");
		ArrayList<String> CODES = new ArrayList<String>();
		for (String s : codes) {
			CODES.add(s);
		}
		paramMap.put("CODES", CODES);
		return query.selectList(NAMESPACE + "yp_zmm_aw.zmm_weight_edoc_calc_detail_list", paramMap);
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int zmm_edoc_status_update(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> parseMap = new HashMap<String, Object>();
		
		String[] codes = paramMap.get("CALC_CODE").toString().split(";");
		ArrayList<String> CODES = new ArrayList<String>();
		for (String s : codes) {
			CODES.add(s);
		}
		
		parseMap.put("EDOC_NO", paramMap.get("EDOC_NO"));
		parseMap.put("EDOC_STATUS", paramMap.get("EDOC_STATUS"));
		parseMap.put("WORKER", paramMap.get("WORKER"));
		parseMap.put("CALC_CODE", CODES);
		parseMap.put("APP_ID", paramMap.get("APP_ID"));
		
		if (paramMap.get("EDOC_STATUS").equals("0")) { // 결재 상신
			query.insert(NAMESPACE + "yp_zmm_aw.zmm_weight_edoc_if_insert", parseMap);
		} else { // 결재 완료
			query.update(NAMESPACE + "yp_zmm_aw.zmm_weight_edoc_if_update", parseMap);
		}
		return query.update(NAMESPACE + "yp_zmm_aw.zmm_weight_edoc_calc_update", parseMap);
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int zmm_edoc_data_update(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> parseMap = new HashMap<String, Object>();
		
		String[] codes = paramMap.get("CALC_CODE").toString().split(";");
		ArrayList<String> CODES = new ArrayList<String>();
		for (String s : codes) {
			CODES.add(s);
		}
		
		parseMap.put("EDOC_NO", paramMap.get("EDOC_NO"));
		parseMap.put("EDOC_STATUS", paramMap.get("EDOC_STATUS"));
		parseMap.put("WORKER", paramMap.get("WORKER"));
		parseMap.put("CALC_CODE", CODES);
		
		//if (paramMap.get("EDOC_STATUS").equals("0")) { // 결재 상신
			//query.insert(NAMESPACE + "yp_zmm_aw.zmm_weight_edoc_if_insert", parseMap);
		//} else { // 결재 완료
			//query.update(NAMESPACE + "yp_zmm_aw.zmm_weight_edoc_if_update", parseMap);
		//}
		
		//logger.debug("jsonArr={}", parseMap);
		return query.update(NAMESPACE + "yp_zmm_aw.zmm_weight_edoc_data_update", parseMap);
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int zmm_weight_data_json(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> parseMap = new HashMap<String, Object>();
		
		parseMap.put("TRUCK_NO", paramMap.get("TRUCK_NO"));
		parseMap.put("ENT", paramMap.get("ENT"));
		parseMap.put("ENT_CODE", paramMap.get("ENT_CODE"));
		parseMap.put("P_NAME", paramMap.get("P_NAME"));
		parseMap.put("P_CODE", paramMap.get("P_CODE"));
		parseMap.put("P_DETAIL_NAME", paramMap.get("P_DETAIL_NAME"));
		parseMap.put("P_DETAIL_CODE", paramMap.get("P_DETAIL_CODE"));
		parseMap.put("P_DETAIL_CODE_SAP", paramMap.get("P_DETAIL_CODE_SAP"));
		parseMap.put("WEIGHT1", paramMap.get("WEIGHT1"));
		parseMap.put("DATE1", paramMap.get("DATE1"));
		parseMap.put("WEIGHT2", paramMap.get("WEIGHT2"));
		parseMap.put("DATE2", paramMap.get("DATE2"));
		parseMap.put("FINAL_WEIGHT", paramMap.get("FINAL_WEIGHT"));
		parseMap.put("LOADING_PLACE", paramMap.get("LOADING_PLACE"));
		parseMap.put("STACKING_PLACE", paramMap.get("STACKING_PLACE"));
		parseMap.put("SCALE_GB", paramMap.get("SCALE_GB"));
		parseMap.put("REG_DATE", paramMap.get("REG_DATE"));
		parseMap.put("REG_WORKER", paramMap.get("REG_WORKER"));
		parseMap.put("UPD_DATE", paramMap.get("UPD_DATE"));
		parseMap.put("UPD_WORKER", paramMap.get("UPD_WORKER"));
		
		return query.update(NAMESPACE + "yp_zmm_aw.zmm_weight_data_insert", parseMap);
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public HashMap<String, Object> fi_doc_regpage(HashMap paramMap) throws Exception {
		
		logger.debug("serv:paramMap=" + paramMap);
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("data").toString());
		logger.debug("jsonArr={}", jsonArr);
		JSONObject jsonObj_temp = (JSONObject) jsonArr.get(0);
		ArrayList<HashMap<String, String>> list1 = new ArrayList<HashMap<String, String>>();
		HashMap<String, String> map1 = new HashMap<String, String>();
		map1.put("BUPLA", "1200"); // 사업장
		map1.put("BKTXT", "폐기물 처리비"); // 전표헤더 텍스트
		map1.put("LIFNR", (String) jsonObj_temp.get("ENT_CODE")); // 거래처
		map1.put("HKONT", "21103101"); // 계정과목
		map1.put("MWSKZ", "11"); // 세금코드
		map1.put("ZTERM", "E228"); // 지급기준
		map1.put("SGTXT", "폐기물 처리비"); // 텍스트
		int total_pay = 0;
		
		ArrayList<HashMap<String, String>> list2 = new ArrayList<HashMap<String, String>>();
		for (int i = 0; i < jsonArr.size(); i++) {
			HashMap<String, String> map2 = new HashMap<String, String>();
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			map2.put("BSCHL", "40"); // 차/대
			map2.put("HKONT", "43324201"); // 계정
			map2.put("TXT_50", "(제조)지급수수료-폐기물처리비"); // 계정 텍스트
			map2.put("ZKOSTL", "214101"); // 집행부서
			map2.put("ZKTEXT", "용해"); // 집행부서 텍스트
			map2.put("KOSTL", "230201"); // 코스트센터
			map2.put("LTEXT", "재료물류"); // 코스트센터 텍스트
			map2.put("SGTXT", "폐기물 처리비"); // 텍스트
			map2.put("SGTXT", (String) jsonObj.get("P_DETAIL_NAME")); // 텍스트
			
			HashMap<String, String> cont_amount = query.selectOne(NAMESPACE + "yp_zmm_aw.zmm_weight_calc_payment", jsonObj);
			
			/**
			 * YPWEBPOTAL-16
			 * 차량계량 정산 > 전자결재 상태값 변경 오류 및 전표번호 리턴 오류
			 * null 체크가 되어있지 않는 구문
			 * 초기값을 0 으로 설정 후 계산하게 변경
			 * */
			Long a = (long) 0;
			if(cont_amount != null) {
				if(!cont_amount.get("CONT_AMOUNT").isEmpty()) {
					a = Long.parseLong(cont_amount.get("CONT_AMOUNT"));
				}
			}
			
			Long b = (long) 0;
			if(jsonObj != null) {
				if(jsonObj.get("CALC_W") != null) {
					b = Long.parseLong(jsonObj.get("CALC_W") + "");
				}
			}
			
			logger.debug("** CONT_AMOUNT : " + a);
			logger.debug("** CALC_W : " + b);
			Long pay = a * b;
			Long WRBTR = (long) 0;
			if(cont_amount != null) {
				if ("ton".equals(cont_amount.get("WEIGHT_UNIT"))) {
					WRBTR = pay / 1000;
				}
			}
			
			map2.put("WRBTR", WRBTR.toString()); // 비용
			total_pay += WRBTR;
			list2.add(map2);
		}
		
		map1.put("ZSUPAMT", String.valueOf(total_pay)); // 지급비용
		list1.add(map1);
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("ZFIS0010_W", list1);
		result.put("ZFIS0020_W", list2);
		return result;
	}
	
}