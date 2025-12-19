package com.yp.zfi.doc.srvc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
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
import org.springframework.util.StringUtils;
import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoTable;
import com.vicurus.it.core.common.Util;
import com.vicurus.it.core.common.WebUtil;
import com.yp.sap.SapJcoConnection;
import com.yp.util.DateUtil;
import com.yp.zfi.doc.srvc.intf.YP_ZFI_DOC_Service;

@Repository
public class YP_ZFI_DOC_ServiceImpl implements YP_ZFI_DOC_Service {

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

	private static final Logger logger = LoggerFactory.getLogger(YP_ZFI_DOC_ServiceImpl.class);

	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap<String, String>> exec(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		logger.debug("RFC_FUNC - 【{}】", paramMap.get("RFC_FUNC"));

		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();

		if ("ZWEB_LIST_DOCUMENT".equals(paramMap.get("RFC_FUNC"))) {
			list = this.ui_select_cs_notice_list(request, response);
		} else {
			logger.error("일치하는 RFC_FUNC가 없습니다.");
		}

		return list;
	}
	
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	public ArrayList<HashMap<String, String>> ui_select_cs_notice_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		if (paramMap.get("budat_s") == null || paramMap.get("budat_e") == null) {
			paramMap.put("budat_s", DateUtil.getToday());
			paramMap.put("budat_e", DateUtil.getToday());
		}

		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_LIST_DOCUMENT");

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue("I_ZPERNR", paramMap.get("emp_code")); // 사번
		function.getImportParameterList().setValue("I_BUDAT_S", StringUtils.replace((String) paramMap.get("budat_s"), "/", "")); // 전기일 시작일
		function.getImportParameterList().setValue("I_BUDAT_E", StringUtils.replace((String) paramMap.get("budat_e"), "/", "")); // 전기일 종료일
		function.getImportParameterList().setValue("I_BLDAT_S", StringUtils.replace((String) paramMap.get("bldat_s"), "/", "")); // 증빙일 시작일
		function.getImportParameterList().setValue("I_BLDAT_E", StringUtils.replace((String) paramMap.get("bldat_e"), "/", "")); // 증빙일 종료일
		function.getImportParameterList().setValue("I_CPUDT_S", StringUtils.replace((String) paramMap.get("cpudt_s"), "/", "")); // 입력일 시작일
		function.getImportParameterList().setValue("I_CPUDT_E", StringUtils.replace((String) paramMap.get("cpudt_e"), "/", "")); // 입력일 종료일
		if (paramMap.get("xblnr") != null) {
			function.getImportParameterList().setValue("I_XBLNR", (String) paramMap.get("xblnr")); // 참조번호
		}
		
		HttpSession session = request.getSession();
		if ("SA".equals((String) session.getAttribute("FI_AUTH")) || "MA".equals((String) session.getAttribute("FI_AUTH"))) {
			function.getImportParameterList().setValue("I_AUTH", "1"); // 권한 0:부서, 1:전체
		} else {
			function.getImportParameterList().setValue("I_AUTH", "0");
		}
		function.getImportParameterList().setValue("I_BKTXT", (String) paramMap.get("bktxt")); // 전표헤더 텍스트
		function.getImportParameterList().setValue("I_BELNR", (String) paramMap.get("belnr")); // 전표번호
		function.getImportParameterList().setValue("I_ZSNAME", paramMap.get("ser_name")); // 작성자

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		JCoTable table = function.getTableParameterList().getTable("GT_DISP");

		// RFC 결과 ArrayList 치환
		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);

		return list;
	}
	
	
	@SuppressWarnings("rawtypes")
	@Override
	public HashMap<String, ArrayList<HashMap<String, String>>> retrievePrintDocument1(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("Z_FI_008");

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue("V_BUKRS", "1000"); // 회사코드 1000고정
		function.getImportParameterList().setValue("V_BELNR", (String) req_data.get("IBELNR"));
		function.getImportParameterList().setValue("V_GJAHR", (String) req_data.get("IGJAHR"));

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		JCoTable table1 = function.getTableParameterList().getTable("T_OUT1");
		// RFC 결과 ArrayList 치환
		ArrayList<HashMap<String, String>> headermap = jcoConnect.createSapList(table1);

		// RFC 결과
		JCoTable table2 = function.getTableParameterList().getTable("T_OUT2");
		// RFC 결과 ArrayList 치환
		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table2);

		HashMap<String, ArrayList<HashMap<String, String>>> result = new HashMap<String, ArrayList<HashMap<String, String>>>();
		result.put("headermap", headermap);
		result.put("list", list);

		return result;
	}
	
	
	@SuppressWarnings("rawtypes")
	@Override
	public HashMap<String, ArrayList<HashMap<String, String>>> retrievePrintDocument2(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_PRINT_040");

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue("I_BUKRS", "1000"); // 회사코드 1000고정
		function.getImportParameterList().setValue("I_BELNR", (String) req_data.get("IBELNR"));
		function.getImportParameterList().setValue("I_GJAHR", (String) req_data.get("IGJAHR"));
		function.getImportParameterList().setValue("I_ZPERNR", (String) req_data.get("empCode"));
		function.getImportParameterList().setValue("I_GUBUN", "X");

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		JCoTable table1 = function.getTableParameterList().getTable("GT_HEADER");
		// RFC 결과 ArrayList 치환
		ArrayList<HashMap<String, String>> headermap = jcoConnect.createSapList(table1);
		
		// RFC 결과
		JCoTable table2 = function.getTableParameterList().getTable("GT_DISP");
		// RFC 결과 ArrayList 치환
		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table2);
		
		// RFC 결과
		JCoTable table3 = function.getTableParameterList().getTable("GT_ETC");
		// RFC 결과 ArrayList 치환
		ArrayList<HashMap<String, String>> etc = jcoConnect.createSapList(table3);
		
		HashMap<String, ArrayList<HashMap<String, String>>> result = new HashMap<String, ArrayList<HashMap<String, String>>>();
		result.put("headermap", headermap);
		result.put("list", list);
		result.put("etc", etc);
		
		return result;
	}
	
	
	@SuppressWarnings({"rawtypes", "unused"})
	@Override
	public String removeDocument(HashMap req_data) throws Exception {
		
		
		SapJcoConnection jcoConnect = new SapJcoConnection();
		
		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_DELETE_DOCUMENT");
		logger.debug("$$$$ 1 $$$$$");
		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue("I_BUKRS", req_data.get("1000"));
		logger.debug("$$$$ 2 $$$$$");
		function.getImportParameterList().setValue("I_GJAHR", req_data.get("IGJAHR"));
		logger.debug("$$$$ 3 $$$$$");
		function.getImportParameterList().setValue("I_BELNR", req_data.get("IBELNR"));
		logger.debug("$$$$ "+(String)req_data.get("s_emp_code")+" $$$$$");
		function.getImportParameterList().setValue("I_ZPERNR", (String)req_data.get("s_emp_code"));
		logger.debug("$$$$ 5 $$$$$");
		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		String result = function.getExportParameterList().getString("E_FLAG");
		String msg = function.getExportParameterList().getString("E_MESSAGE");

		return msg;
	}
	
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public String retrieveDocumentPop(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("Z_FI_008");

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue("V_BUKRS", "1000"); // 회사코드 1000고정
		function.getImportParameterList().setValue("V_BELNR", (String) req_data.get("BELNR"));
		function.getImportParameterList().setValue("V_GJAHR", ((String) req_data.get("BUDAT")).substring(0, 4));

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		String result = function.getExportParameterList().getString("E_DOCNO");

		return result;
	}
	
	
	@SuppressWarnings({"unused", "rawtypes"})
	@Override
	public String[] createDocWrite(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("Z_FI_007_BROWSER");

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue("I_BUKRS", "1000"); // 회사코드 1000고정
		function.getImportParameterList().setValue("I_BELNR", (String) req_data.get("IBELNR"));
		function.getImportParameterList().setValue("I_GJAHR", (String) req_data.get("IGJAHR"));
		function.getImportParameterList().setValue("I_GUBUN", (String) req_data.get("GUBUN"));
		function.getImportParameterList().setValue("I_PERNR", req_data.get("emp_code"));
		function.getImportParameterList().setValue("I_GW", "X"); // 웹포털 구분자

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		String result = function.getExportParameterList().getString("E_TYPE");
		String msg = function.getExportParameterList().getString("E_MSG");
		String url = function.getExportParameterList().getString("E_URL");
		String url1 = function.getExportParameterList().getString("E_URL2");
		String prtno = function.getExportParameterList().getString("E_ZPRTNO");

		String[] return_str = {result, msg, url};

		return return_str;
	}
	
	
	@SuppressWarnings("rawtypes")
	@Override
	public HashMap<String, Object> retrieveDocumentDetail(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_COPY_DOCUMENT");

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue("I_BUKRS", "1000"); // 회사코드 1000 고정
		function.getImportParameterList().setValue("I_GJAHR", req_data.get("IGJAHR")); // 회계연도
		function.getImportParameterList().setValue("I_BELNR", req_data.get("IBELNR")); // 전표번호

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		JCoTable ZFIS0010_W = function.getTableParameterList().getTable("ZFIS0010_W");
		JCoTable ZFIS0020_W = function.getTableParameterList().getTable("ZFIS0020_W");
		ArrayList<HashMap<String, String>> list10 = jcoConnect.createSapList(ZFIS0010_W);
		ArrayList<HashMap<String, String>> list20 = jcoConnect.createSapList(ZFIS0020_W);
		if (list10.size() > 0) {
			list10.get(0).put("BLDAT", DateUtil.setDatePattern(list10.get(0).get("BLDAT")));
			list10.get(0).put("BUDAT", DateUtil.setDatePattern(list10.get(0).get("BUDAT")));
		}
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("ZFIS0010_W", list10);
		result.put("ZFIS0020_W", list20);

		// logger.debug("result = "+list10);
		return result;
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
		if ("5".equals((String) req_data.get("doc_type"))) {
			function.getImportParameterList().setValue("I_IMPORT", "X"); // 수입전표 일때
		}

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		JCoTable ZFIS0010 = function.getTableParameterList().getTable("ZFIS0010_W"); // 기본정보, 구매처정보
		ZFIS0010.appendRow();
		if ("5".equals((String) req_data.get("doc_type"))){
			ZFIS0010.setValue("BLART", "CA"); // 전표유형 수입=CA
		}else{
			ZFIS0010.setValue("BLART", "SA"); // 전표유형
		}
		ZFIS0010.setValue("BUKRS", "1000"); // 회사코드
		
		if(!WebUtil.isNull(req_data.get("BUDAT"))){
			ZFIS0010.setValue("GJAHR", ((String) req_data.get("BUDAT")).substring(0, 4)); // 회계년도
			logger.debug("GJAHR:{}", ZFIS0010.getValue("GJAHR"));
		}
		
		ZFIS0010.setValue("BUDAT", StringUtils.replace((String) req_data.get("BUDAT"), "/", "")); // 전표 전기일
		logger.debug("BUDAT:{}", ZFIS0010.getValue("BUDAT"));
		
		ZFIS0010.setValue("BLDAT", StringUtils.replace((String) req_data.get("BLDAT"), "/", "")); // 전표 증빙일
		logger.debug("### BLDAT:{}", ZFIS0010.getValue("BLDAT"));
		
		ZFIS0010.setValue("WAERS", req_data.get("WAERS")); // 통화
		logger.debug("WAERS:{}", ZFIS0010.getValue("WAERS"));
		
		ZFIS0010.setValue("KURSF", StringUtils.replace((String) req_data.get("KURSF"), ",", "")); // 환율
		logger.debug("KURSF:{}", ZFIS0010.getValue("KURSF"));
		
		ZFIS0010.setValue("BUPLA", req_data.get("BUPLA")); // 사업장
		logger.debug("BUPLA:{}", ZFIS0010.getValue("BUPLA"));
		
		ZFIS0010.setValue("BKTXT", req_data.get("BKTXT")); // 전표헤더 텍스트
		logger.debug("BKTXT:{}", ZFIS0010.getValue("BKTXT"));
		
		ZFIS0010.setValue("AGKOA", req_data.get("AGKOA")); // 계정 유형
		logger.debug("AGKOA:{}", ZFIS0010.getValue("AGKOA"));
		
		ZFIS0010.setValue("LIFNR", req_data.get("LIFNR")); // 공급업체
		logger.debug("LIFNR:{}", ZFIS0010.getValue("LIFNR"));
		
		ZFIS0010.setValue("STCD2", req_data.get("STCD2")); // 사업자등록번호
		logger.debug("STCD2:{}", ZFIS0010.getValue("STCD2"));
		
		ZFIS0010.setValue("NAME1", req_data.get("NAME1")); // 상호
		logger.debug("NAME1:{}", ZFIS0010.getValue("NAME1"));
		
		ZFIS0010.setValue("HKONT", req_data.get("HKONT")); // 계정과목
		logger.debug("HKONT:{}", ZFIS0010.getValue("HKONT"));
		
		ZFIS0010.setValue("MWSKZ", req_data.get("MWSKZ")); // 세금코드
		logger.debug("MWSKZ:{}", ZFIS0010.getValue("MWSKZ"));
		
		ZFIS0010.setValue("BVTYP", req_data.get("BVTYP")); // 은행코드
		logger.debug("BVTYP:{}", ZFIS0010.getValue("BVTYP"));
		
		ZFIS0010.setValue("BANKN", req_data.get("BANKN")); // 계좌번호
		logger.debug("BANKN:{}", ZFIS0010.getValue("BANKN"));
		
		ZFIS0010.setValue("SGTXT", req_data.get("SGTXT")); // 텍스트
		logger.debug("SGTXT:{}", ZFIS0010.getValue("SGTXT"));
		
		ZFIS0010.setValue("ZSUPAMT", StringUtils.replace((String) req_data.get("ZSUPAMT"), ",", "")); // 공급가액
		logger.debug("ZSUPAMT:{}", ZFIS0010.getValue("ZSUPAMT"));
		
		ZFIS0010.setValue("WMWST", StringUtils.replace((String) req_data.get("WMWST"), ",", "")); // 세액
		logger.debug("WMWST:{}", ZFIS0010.getValue("WMWST"));
		
		ZFIS0010.setValue("ZEXPAMT", StringUtils.replace((String) req_data.get("ZEXPAMT"), ",", "")); // 추가액
		logger.debug("ZEXPAMT:{}", ZFIS0010.getValue("ZEXPAMT"));
		
		ZFIS0010.setValue("WSKTO", StringUtils.replace((String) req_data.get("WSKTO"), ",", "")); // 할인액
		logger.debug("WSKTO:{}", ZFIS0010.getValue("WSKTO"));
		
		ZFIS0010.setValue("ZTOPAY", StringUtils.replace((String) req_data.get("ZTOPAY"), ",", "")); // 총지급액
		logger.debug("ZTOPAY:{}", ZFIS0010.getValue("ZTOPAY"));
		
		ZFIS0010.setValue("KTOKK", req_data.get("KTOKK")); // 거래처 분류코드
		logger.debug("KTOKK:{}", ZFIS0010.getValue("KTOKK"));
		
		ZFIS0010.setValue("ZTERM", req_data.get("ZTERM")); // 지급조건
		logger.debug("ZTERM:{}", ZFIS0010.getValue("ZTERM"));
		
		ZFIS0010.setValue("GSBER", req_data.get("BUPLA")); // 사업영역
		logger.debug("GSBER:{}", ZFIS0010.getValue("GSBER"));


		JCoTable ZFIS0020 = function.getTableParameterList().getTable("ZFIS0020_W"); // 전표 개별항목

		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("row_no").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			//logger.debug("{}", jsonObj);
			ZFIS0020.appendRow();
			ZFIS0020.setValue("BSCHL", jsonObj.get("BSCHL")); // 차변대변
			logger.debug("BSCHL:{}", ZFIS0020.getValue("BSCHL"));
			
			ZFIS0020.setValue("HKONT", jsonObj.get("HKONT")); // 계정과목
			logger.debug("HKONT:{}", ZFIS0020.getValue("HKONT"));
			
			ZFIS0020.setValue("TXT_50", jsonObj.get("ZGLTXT")); // 계정텍스트
			logger.debug("TXT_50:{}", ZFIS0020.getValue("TXT_50"));
			
			ZFIS0020.setValue("ZKOSTL", jsonObj.get("ZKOSTL")); // 집행부서
			logger.debug("ZKOSTL:{}", ZFIS0020.getValue("ZKOSTL"));
			
			ZFIS0020.setValue("ZKTEXT", jsonObj.get("ZKTEXT")); // 집행부서명
			logger.debug("ZKTEXT:{}", ZFIS0020.getValue("ZKTEXT"));
			
			ZFIS0020.setValue("KOSTL", jsonObj.get("KOSTL")); // 코스트센터
			logger.debug("KOSTL:{}", ZFIS0020.getValue("KOSTL"));
			
			ZFIS0020.setValue("LTEXT", jsonObj.get("LTEXT")); // 코스트센터명
			logger.debug("LTEXT:{}", ZFIS0020.getValue("LTEXT"));
			
			ZFIS0020.setValue("AVAIL_AMT", StringUtils.replace((String) jsonObj.get("AVAIL_AMT"), ",", "")); // 가용예산
			logger.debug("AVAIL_AMT:{}", ZFIS0020.getValue("AVAIL_AMT"));
			
			ZFIS0020.setValue("CHK", jsonObj.get("CHK")); // 추가경비
			logger.debug("CHK:{}", ZFIS0020.getValue("CHK"));
			
			ZFIS0020.setValue("XNEGP", jsonObj.get("NCK")); // 마이너스 구분
			logger.debug("XNEGP:{}", ZFIS0020.getValue("XNEGP"));
			
			if (!StringUtils.hasLength((String) jsonObj.get("WRBTR"))) {	//is null
				ZFIS0020.setValue("WRBTR", StringUtils.replace((String) jsonObj.get("WRBTR"), ",", "")); // 금액
			}else {
				ZFIS0020.setValue("WRBTR", StringUtils.replace((String) jsonObj.get("WRBTR"), ",", "").replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 금액
			}
			logger.debug("WRBTR:{}", ZFIS0020.getValue("WRBTR"));
			
			if (!StringUtils.hasLength((String) jsonObj.get("STCD2"))) {	//is null
				ZFIS0020.setValue("STCD2", jsonObj.get("STCD2")); 			// 사업자등록번호
			}else {	//not null
				ZFIS0020.setValue("STCD2", jsonObj.get("STCD2").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 사업자등록번호
			}
			logger.debug("STCD2:{}", ZFIS0020.getValue("STCD2"));
			
			if (!StringUtils.hasLength((String) jsonObj.get("NAME1"))) {	//is null
				ZFIS0020.setValue("NAME1", jsonObj.get("NAME1")); 			// 거래처명
			}else {	//not null
				ZFIS0020.setValue("NAME1", jsonObj.get("NAME1").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 거래처명
			}
			logger.debug("NAME1:{}", ZFIS0020.getValue("NAME1"));
			
			if (!StringUtils.hasLength((String) jsonObj.get("SGTXT"))) {	//is null
				ZFIS0020.setValue("SGTXT", jsonObj.get("SGTXT")); 			// 텍스트
			}else {	//not null
				ZFIS0020.setValue("SGTXT", jsonObj.get("SGTXT").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 텍스트
			}
			logger.debug("SGTXT:{}", ZFIS0020.getValue("SGTXT"));
			
			if (!StringUtils.hasLength((String) jsonObj.get("POSID"))) {	//is null
				ZFIS0020.setValue("POSID", jsonObj.get("POSID")); 			// WBS코드
			}else {	//not null
				ZFIS0020.setValue("POSID", jsonObj.get("POSID").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // WBS코드
			}
			logger.debug("POSID:{}", ZFIS0020.getValue("POSID"));
			
			ZFIS0020.setValue("POST1", jsonObj.get("POST1")); // WBS코드명
			logger.debug("POST1:{}", ZFIS0020.getValue("POST1"));
			
			if (!StringUtils.hasLength((String) jsonObj.get("VBELN"))) {	//is null
				ZFIS0020.setValue("VBELN", jsonObj.get("VBELN")); 			// 판매오더
			}else {	//not null
				ZFIS0020.setValue("VBELN", jsonObj.get("VBELN").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 판매오더
			}
			logger.debug("VBELN:{}", ZFIS0020.getValue("VBELN"));
			
			ZFIS0020.setValue("VTWEG", jsonObj.get("VTWEG")); // 유통경로
			//ZFIS0020.setValue("VTWEG", ""); // 유통경로
			logger.debug("VTWEG:{}", ZFIS0020.getValue("VTWEG"));
			
			if (!StringUtils.hasLength((String) jsonObj.get("MVGR1"))) {	//is null
				ZFIS0020.setValue("MVGR1", jsonObj.get("MVGR1")); // 자재그룹
			}else {	//not null
				ZFIS0020.setValue("MVGR1", jsonObj.get("MVGR1").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 자재그룹
			}
			logger.debug("MVGR1:{}", ZFIS0020.getValue("MVGR1"));
			
			ZFIS0020.setValue("WW002", jsonObj.get("WW002")); // 매출구분
			logger.debug("WW002:{}", ZFIS0020.getValue("WW002"));
			
			ZFIS0020.setValue("MENGE", StringUtils.replace((String) jsonObj.get("MENGE"), ",", "")); // 수량
			logger.debug("MENGE:{}", ZFIS0020.getValue("MENGE"));
			
			if (!StringUtils.hasLength((String) jsonObj.get("MEINS"))) {	//is null
				ZFIS0020.setValue("MEINS", jsonObj.get("MEINS")); 			// 단위
			}else{	//not null
				ZFIS0020.setValue("MEINS", jsonObj.get("MEINS").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 단위
			}
			logger.debug("MEINS:{}", ZFIS0020.getValue("MEINS"));
			
			if (!StringUtils.hasLength((String) jsonObj.get("ZBSTKD"))) {	//is null
				ZFIS0020.setValue("ZBSTKD", jsonObj.get("ZBSTKD")); 		// 구매오더
			}else {	//not null
				ZFIS0020.setValue("ZBSTKD", jsonObj.get("ZBSTKD").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 구매오더
			}
			logger.debug("ZBSTKD:{}", ZFIS0020.getValue("ZBSTKD"));
			
			if (!StringUtils.hasLength((String) jsonObj.get("ZCCODE"))) {	//is null
				ZFIS0020.setValue("ZCCODE", jsonObj.get("ZCCODE")); 		// 차량코드
			}else {	//not null
				ZFIS0020.setValue("ZCCODE", jsonObj.get("ZCCODE").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "")); // 차량코드
			}
			logger.debug("ZCCODE:{}", ZFIS0020.getValue("ZCCODE"));
			
			if (!StringUtils.hasLength((String) jsonObj.get("ZCTEXT"))) {	//is null
				ZFIS0020.setValue("ZCTEXT", jsonObj.get("ZCTEXT")); 		// 차량코드명
			}else {	//not null
				ZFIS0020.setValue("ZCTEXT", jsonObj.get("ZCTEXT").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "" )); // 차량코드명
			}
			logger.debug("ZCTEXT:{}", ZFIS0020.getValue("ZCTEXT"));
			
			if (!StringUtils.hasLength((String) jsonObj.get("AUFNR"))) {	//is null
				ZFIS0020.setValue("AUFNR", jsonObj.get("AUFNR")); // 설비오더 19.04추가
			}else{	//not null
				ZFIS0020.setValue("AUFNR", jsonObj.get("AUFNR").toString().replaceAll("(\\r\\n|\\r|\\n|\\n\\r)", "" )); // 설비오더 19.04추가
			}
			logger.debug("AUFNR:{}", ZFIS0020.getValue("AUFNR"));
			
			ZFIS0020.setValue("VALUT", StringUtils.replace((String) jsonObj.get("VALUT"), "/", "")); // 기준일 20.06추가
			logger.debug("VALUT:{}", ZFIS0020.getValue("VALUT"));
			
			ZFIS0020.setValue("ZFBDT", StringUtils.replace((String) jsonObj.get("ZFBDT"), "/", "")); // 지급기산일 20.06추가
			logger.debug("ZFBDT:{}", ZFIS0020.getValue("ZFBDT"));
		}

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
		//if("S".equals(result)){
			//req_data.put("FI_DOC_NO", doc_no);
			//query.update(NAMESPACE + "yp_zmm_aw.zmm_weight_fidocno_update", req_data);
		//}
		
		return return_str;
	}
	
	
	@SuppressWarnings("rawtypes")
	@Override
	public ArrayList<HashMap<String, String>> retrieveLIFNR(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_POPUP_LIFNR");

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue((String) req_data.get("search_type"), (String) req_data.get("search_text"));
		// function.getImportParameterList().setValue("I_KTOKK",(String)req_data.get("search_bukr"));
		if ("5".equals((String) req_data.get("doc_type"))) {
			function.getImportParameterList().setValue("I_AGKOA", req_data.get("AGKOA")); // 계정 유형
		}
		// function.getImportParameterList().setValue("I_GUBUN",req_data.get("I_GUBUN"));

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		JCoTable table = function.getTableParameterList().getTable("GT_DISP");

		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);

		return list;
	}
	
	
	@SuppressWarnings({"unused", "rawtypes"})
	@Override
	public ArrayList<HashMap<String, String>> retrieveSAKNR(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_POPUP_SAKNR");

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue((String) req_data.get("search_type"), (String) req_data.get("search_text"));
		function.getImportParameterList().setValue("I_LIFNR", (String) req_data.get("LIFNR"));
		if ("5".equals((String) req_data.get("doc_type"))) {
			function.getImportParameterList().setValue("I_AGKOA", req_data.get("AGKOA")); // 계정 유형
		}

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		JCoTable table = function.getTableParameterList().getTable("GT_DISP");

		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);

		String E_HKONT = function.getExportParameterList().getString("E_HKONT");

		return list;
	}


	@SuppressWarnings("rawtypes")
	@Override
	public HashMap<String, String> retrieveSAKNRonBlur(HashMap req_data) throws Exception {
		HashMap<String, String> result = new HashMap<String, String>();

		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_POPUP_SAKNR");

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue((String) req_data.get("search_type"), (String) req_data.get("search_text"));
		function.getImportParameterList().setValue("I_LIFNR", (String) req_data.get("LIFNR"));
		if ("5".equals((String) req_data.get("doc_type"))) {
			function.getImportParameterList().setValue("I_AGKOA", req_data.get("AGKOA")); // 계정 유형
		}

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		String E_HKONT = function.getExportParameterList().getString("E_HKONT");
		String E_TXT_50 = function.getExportParameterList().getString("E_TXT_50");

		result.put("E_HKONT", E_HKONT);
		result.put("E_TXT_50", E_TXT_50);
		return result;
	}
	
	
	@SuppressWarnings("rawtypes")
	@Override
	public ArrayList<HashMap<String, String>> retrieveTAXPC(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_POPUP_TAXPC");

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue("I_MWSKZ", (String) req_data.get("I_MWSKZ"));
		function.getImportParameterList().setValue("I_TEXT1", "");
		if ("5".equals((String) req_data.get("doc_type"))) {
			function.getImportParameterList().setValue("I_IMPORT", "X"); // 수입전표 일때
		}
		function.getImportParameterList().setValue("I_GUBUN", "X");

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		JCoTable table = function.getTableParameterList().getTable("GT_DISP");

		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);

		return list;
	}
	
	
	@SuppressWarnings("rawtypes")
	@Override
	public ArrayList<HashMap<String, String>> retrieveBANKN(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_POPUP_BANKN");

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue("I_LIFNR", (String) req_data.get("LIFNR"));
		function.getImportParameterList().setValue("I_GUBUN", "X");

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		JCoTable table = function.getTableParameterList().getTable("GT_DISP");

		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);

		return list;
	}
	
	
	@SuppressWarnings("rawtypes")
	@Override
	public ArrayList<HashMap<String, String>> retrieveWAERS(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_POPUP_WAERS");

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue((String) req_data.get("search_type"), (String) req_data.get("search_text"));
		function.getImportParameterList().setValue("I_BUDAT", StringUtils.replace((String) req_data.get("BUDAT"), "/", ""));

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		JCoTable table = function.getTableParameterList().getTable("GT_DISP");

		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);

		return list;
	}
	
	
	@SuppressWarnings("rawtypes")
	@Override
	public HashMap<String, Object> retrieveBANKA(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_POPUP_BNKA");

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue((String) req_data.get("search_type"), (String) req_data.get("search_text"));

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		JCoTable table = function.getTableParameterList().getTable("GT_DISP");

		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);

		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("list", list);
		result.put("E_FLAG", function.getExportParameterList().getValue("E_FLAG"));
		result.put("E_MESSAGE", function.getExportParameterList().getValue("E_MESSAGE"));

		return result;
	}
	
	
	@SuppressWarnings("rawtypes")
	@Override
	public ArrayList<HashMap<String, String>> retrieveHKONT(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_POPUP_HKONT");

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue((String) req_data.get("search_type"), (String) req_data.get("search_text"));

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		JCoTable table = function.getTableParameterList().getTable("GT_DISP");

		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);

		return list;
	}
	
	
	@SuppressWarnings("rawtypes")
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
	public ArrayList<HashMap<String, String>> retrievePOSID(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_POPUP_POSID");

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue((String) req_data.get("search_type"), (String) req_data.get("search_text"));

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		JCoTable table = function.getTableParameterList().getTable("GT_DISP");

		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);

		return list;
	}
	
	
	@SuppressWarnings("rawtypes")
	@Override
	public ArrayList<HashMap<String, String>> retrieveMVGR(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_POPUP_MVGR1");

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue((String) req_data.get("search_type"), (String) req_data.get("search_text"));

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		JCoTable table = function.getTableParameterList().getTable("GT_DISP");

		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);

		return list;
	}
	
	
	@SuppressWarnings("rawtypes")
	@Override
	public ArrayList<HashMap<String, String>> retrieveVBELN(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_POPUP_VBELN");

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue((String) req_data.get("search_type"), (String) req_data.get("search_text"));

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		JCoTable table = function.getTableParameterList().getTable("GT_DISP");

		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);

		return list;
	}
	
	
	@SuppressWarnings("rawtypes")
	@Override
	public ArrayList<HashMap<String, String>> retrieveMEINS(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_POPUP_MEINS");

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue((String) req_data.get("search_type"), (String) req_data.get("search_text"));

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		JCoTable table = function.getTableParameterList().getTable("GT_DISP");

		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);

		return list;
	}
	
	
	@SuppressWarnings("rawtypes")
	@Override
	public ArrayList<HashMap<String, String>> retrieveZCCODE(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_POPUP_ZCCODE");

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue((String) req_data.get("search_type"), (String) req_data.get("search_text"));

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		JCoTable table = function.getTableParameterList().getTable("GT_DISP");

		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);

		return list;
	}
	
	
	@SuppressWarnings("rawtypes")
	@Override
	public ArrayList<HashMap<String, String>> retrieveZTERM(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();
		
		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_POPUP_ZTERM");
		
		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue((String) req_data.get("search_type"), (String) req_data.get("search_text"));
		function.getImportParameterList().setValue("I_GUBUN", "X");
		
		// RFC 호출
		jcoConnect.execute(function);
		
		// RFC 결과
		JCoTable table = function.getTableParameterList().getTable("GT_DISP");
		
		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
		
		return list;
	}
	
	
	@SuppressWarnings("rawtypes")
	@Override
	public ArrayList<HashMap<String, String>> retrieveAUFNR(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();
		
		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_POPUP_AUFNR");
		
		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue((String) req_data.get("search_type"), (String) req_data.get("search_text"));
		
		// RFC 호출
		jcoConnect.execute(function);
		
		// RFC 결과
		String flag = function.getExportParameterList().getString("E_FLAG");
		String msg = function.getExportParameterList().getString("E_MESSAGE");
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		if ("E".equals(flag)) {
			HashMap<String, String> row = new HashMap<String, String>();
			row.put("msg", msg);
			list.add(row);
		} else {
			JCoTable table = function.getTableParameterList().getTable("GT_DISP");
			list = jcoConnect.createSapList(table);
		}
		
		return list;
	}
	
	
	@Override
	public String retrieveBUDGET(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_POPUP_BUDGET");
		
		String target = (String) req_data.get("target");
		
		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue("I_BUKRS", "1000"); // 회사코드 1000고정
		function.getImportParameterList().setValue("I_BUPLA", (String) req_data.get("BUPLA"));
		function.getImportParameterList().setValue("I_KOSTL", (String) req_data.get("KOSTL"));
		function.getImportParameterList().setValue("I_ZKOSTL", (String) req_data.get("ZKOSTL"));
		function.getImportParameterList().setValue("I_HKONT", (String) req_data.get("HKONT"));
		function.getImportParameterList().setValue("I_BUDAT", StringUtils.replace((String) req_data.get("BUDAT"), "/", ""));
		
		// RFC 호출
		jcoConnect.execute(function);
		
		// RFC 결과
		String result = function.getExportParameterList().getString("E_AVAIL_AMT");
		
		return result;
	}
}
