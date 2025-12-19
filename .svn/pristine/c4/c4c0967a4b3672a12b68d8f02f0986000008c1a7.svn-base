package com.yp.zfi.bud.srvc;

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
import com.yp.sap.SapJcoConnection;
import com.yp.util.DateUtil;
import com.yp.zfi.bud.srvc.intf.YP_ZFI_BUD_Service;

@Repository
public class YP_ZFI_BUD_ServiceImpl implements YP_ZFI_BUD_Service {

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

	private static final Logger logger = LoggerFactory.getLogger(YP_ZFI_BUD_ServiceImpl.class);

	@SuppressWarnings({"rawtypes"})
	public HashMap<String, Object> exec(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		logger.debug("RFC_FUNC - 【{}】", paramMap.get("RFC_FUNC"));

		HashMap<String, Object> result = new HashMap<String, Object>();
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();

		if ("ZWEB_BUDGET_LIST".equals(paramMap.get("RFC_FUNC"))) {
			list = this.ui_select_retrieveBudgetList(request, response);
			result.put("list", list);
		}else if("ZWEB_BUDGET_CHANGE".equals(paramMap.get("RFC_FUNC"))) {		//예산신청 조회
			list = this.ui_select_retrieveBudgetModifyList(request, response);
			result.put("list", list);
		}else if("ZWEB_BUDGET_CHANGE2".equals(paramMap.get("RFC_FUNC"))) {		//예산신청 조회("전용")
			list = this.ui_select_retrieveBudgetOnlyList(request, response);
			result.put("list", list);
		}else if("ZWEB_BUDGET_CHANGE2".equals(paramMap.get("RFC_FUNC"))) {		//예산신청 조회("전용")
			list = this.ui_select_retrieveBudgetOnlyList(request, response);
			result.put("list", list);
		}else if("ZFI_BUD_APPROVAL".equals(paramMap.get("RFC_FUNC"))) {			//예산신청 조회("전용")
			result = this.retrieveBudgetDocWriteList(request, response);
		}else if("ZWEB_BUDGET_CJE0_LIST".equals(paramMap.get("RFC_FUNC"))) {	//WBS 예산 조회
			result = this.ui_select_retrieveBudgetStatus(request, response);
		}else if("ZWEB_BUDGET_WBS_LIST".equals(paramMap.get("RFC_FUNC"))) {		//WBS 예산 상세조회
			result = this.ui_select_retrieveBudgetWbsList(request, response);
		} else {
			logger.error("일치하는 RFC_FUNC가 없습니다.");
		}
		logger.debug("\t【RFC RESULT】\n\t{}", result);

		return result;
	}
	
	
	@Override
	public ArrayList<HashMap<String, String>> ui_select_retrieveBudgetList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Util util = new Util();
		Map paramMap = util.getParamToMapWithNull(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		//날짜 파라메터 기본값 세팅
		if (paramMap.get("SPMON_S") == null || paramMap.get("SPMON_E") == null) {
			paramMap.put("SPMON_S", DateUtil.getTodayMonth());
			paramMap.put("SPMON_E", DateUtil.getTodayMonth());
		}

		SapJcoConnection jcoConnect = new SapJcoConnection();
		//RFC명
		JCoFunction function = jcoConnect.getFunction("ZWEB_BUDGET_LIST");

		function.getImportParameterList().setValue("I_GSBER_S",(String)paramMap.get("GSBER_S"));		//사업영역(S)
	    function.getImportParameterList().setValue("I_GSBER_E",(String)paramMap.get("GSBER_E"));		//사업영역(E)
	    function.getImportParameterList().setValue("I_RORG_S",(String)paramMap.get("RORG_S"));			//집행부서(S)
	    //function.getImportParameterList().setValue("I_RORG_E",(String)paramMap.get("RORG_E"));			//집행부서(E)
	    function.getImportParameterList().setValue("I_BORG_S",(String)paramMap.get("BORG_S"));			//예산조직(S)
	    function.getImportParameterList().setValue("I_BORG_E",(String)paramMap.get("BORG_E"));			//예산조직(E)
	    function.getImportParameterList().setValue("I_BACT_S",(String)paramMap.get("BACT_S"));			//예산계정(S)
	    function.getImportParameterList().setValue("I_BACT_E",(String)paramMap.get("BACT_E"));			//예산계정(E)
	    function.getImportParameterList().setValue("I_SPMON_S",StringUtils.replace((String)paramMap.get("SPMON_S"), "/", ""));		//년월(S)
	    function.getImportParameterList().setValue("I_SPMON_E",StringUtils.replace((String)paramMap.get("SPMON_E"), "/", ""));		//년월(E)
	    function.getImportParameterList().setValue("I_VARI",(String)paramMap.get("VARI"));				//집행부서내예산조직별보기
	    function.getImportParameterList().setValue("I_PERNR",(String)paramMap.get("EMPCODE"));			//사번

//	    // RFC 파라미터 - 테이블 형태
//	 	JCoTable GT_RORG = function.getTableParameterList().getTable("GT_RORG"); // 집행부서
//	 	GT_RORG.appendRow();
//	 	GT_RORG.setValue("SIGN",   (String)paramMap.get("RORG_SIGN")); 		 	 // ABAP: ID: I/E (포함/제외된 값)
//	 	GT_RORG.setValue("OPTION", (String)paramMap.get("RORG_OPTION")); 		 // ABAP: 선택옵션 (EQ/BT/CP/...)
//	 	GT_RORG.setValue("LOW",    (String)paramMap.get("RORG_S")); 			 // 동적 선택에 대한 '일반' 선택 옵션
//	 	GT_RORG.setValue("HIGH",   (String)paramMap.get("RORG_E")); 			 // 동적 선택에 대한 '일반' 선택 옵션
//	 	
//	 	// RFC 파라미터 - 테이블 형태
//	 	JCoTable GT_BACT = function.getTableParameterList().getTable("GT_BACT"); // 예산계정
//	 	GT_BACT.appendRow();
//	 	GT_BACT.setValue("SIGN",   (String)paramMap.get("BACT_SIGN")); 		 	 // ABAP: ID: I/E (포함/제외된 값)
//	 	GT_BACT.setValue("OPTION", (String)paramMap.get("BACT_OPTION")); 		 // ABAP: 선택옵션 (EQ/BT/CP/...)
//	 	GT_BACT.setValue("LOW",    (String)paramMap.get("BACT_S")); 			 // 동적 선택에 대한 '일반' 선택 옵션
//	 	GT_BACT.setValue("HIGH",   (String)paramMap.get("BACT_E")); 			 // 동적 선택에 대한 '일반' 선택 옵션
//	 	
//	 	// RFC 파라미터 - 테이블 형태
//	 	JCoTable GT_BORG = function.getTableParameterList().getTable("GT_BORG"); // 예산조직
//	 	GT_BORG.appendRow();
//	 	GT_BORG.setValue("SIGN",   (String)paramMap.get("BORG_SIGN")); 		     // ABAP: ID: I/E (포함/제외된 값)
//	 	GT_BORG.setValue("OPTION", (String)paramMap.get("BORG_OPTION")); 		 // ABAP: 선택옵션 (EQ/BT/CP/...)
//	 	GT_BORG.setValue("LOW",    (String)paramMap.get("BORG_S")); 			 // 동적 선택에 대한 '일반' 선택 옵션
//	 	GT_BORG.setValue("HIGH",   (String)paramMap.get("BORG_E")); 			 // 동적 선택에 대한 '일반' 선택 옵션

	    logger.debug("rfc start!");
	    // RFC 호출
	 	jcoConnect.execute(function);
	    logger.debug("rfc finish!");
	    logger.debug("FLAG:"+function.getExportParameterList().getString("E_FLAG")+" / MESSAGE:"+function.getExportParameterList().getString("E_MESSAGE"));
	    
	    // RFC 결과
	 	JCoTable table = function.getTableParameterList().getTable("GT_DISP");
	 	
	 	// RFC 결과 ArrayList 치환
	 	ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
	 	
	 	HashMap<String, Object> result = new HashMap<String, Object>();
	 	result.put("list", list);
	 	result.put("ep_flag", function.getExportParameterList().getString("E_FLAG"));	//exparam
	 	result.put("ep_msg", function.getExportParameterList().getString("E_MESSAGE"));	//exparam

		return list;
	}
	
	
	@Override
	public HashMap<String, Object> retrieveBACT(HashMap req_data) throws Exception{
		
		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("ZWEB_POPUP_ZCOBACT");
		
		function.getImportParameterList().setValue((String)req_data.get("search_type"),(String)req_data.get("search_text"));
		function.getImportParameterList().setValue("I_SEBU","");										//단일문자표시
		function.getImportParameterList().setValue("I_GSBER",(String)req_data.get("I_GSBER"));			//사업영역

//		function.getImportParameterList().setValue("I_RORG",(String)req_data.get("search_text"));		//집행부서
//		function.getImportParameterList().setValue("I_BORG",(String)req_data.get("search_text"));		//예산조직
//		function.getImportParameterList().setValue("I_SPMON",(String)req_data.get("search_text"));		//년월from
//		function.getImportParameterList().setValue("I_SPMON2",(String)req_data.get("search_text"));		//년월to
		
	    logger.debug("rfc start!");
	    jcoConnect.execute(function);
	    logger.debug("rfc finish!");
	    logger.debug("FLAG:"+function.getExportParameterList().getString("E_FLAG")+" / MESSAGE:"+function.getExportParameterList().getString("E_MESSAGE"));
	    logger.debug("HKONT:"+function.getExportParameterList().getString("E_HKONT")+" / TXT_50:"+function.getExportParameterList().getString("E_TXT_50"));
	    logger.debug("AMT:"+function.getExportParameterList().getString("E_AMT"));
	    
	    HashMap<String, String> ex_param = new HashMap<String, String>();
	    ex_param.put("E_FLAG", function.getExportParameterList().getString("E_FLAG"));
	    ex_param.put("E_MESSAGE", function.getExportParameterList().getString("E_MESSAGE"));
	    ex_param.put("E_HKONT", function.getExportParameterList().getString("E_HKONT"));
	    ex_param.put("E_TXT_50", function.getExportParameterList().getString("E_TXT_50"));
	    ex_param.put("E_AMT", function.getExportParameterList().getString("E_AMT"));
	    
	    JCoTable table = function.getTableParameterList().getTable("GT_DISP");
	 	ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
	 	
	 	HashMap<String, Object> result = new HashMap<String, Object>();
	 	result.put("ex_param", ex_param);
	 	result.put("list", list);
		return result;
	}
	
	
	@Override
	public ArrayList<HashMap<String, String>> retrieveKOSTL(HashMap req_data) throws Exception{
		SapJcoConnection jcoConnect = new SapJcoConnection();
 	    JCoFunction function = jcoConnect.getFunction("ZWEB_POPUP_KOSTL");
 	    function.getImportParameterList().setValue((String)req_data.get("search_type"),(String)req_data.get("search_text"));
 	    function.getImportParameterList().setValue("I_GUBUN",req_data.get("type"));
 	    function.getImportParameterList().setValue("I_PERNR",req_data.get("emp_code"));
 	    jcoConnect.execute(function);
 	    
 	    JCoTable table = function.getTableParameterList().getTable("GT_DISP");
 	   
 	    ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
 	    logger.debug("list = " + list);
 	    return list;
	}
	
	
	@Override
	public ArrayList<HashMap<String, String>> retrieveDetailAmtPlan(HashMap req_data) throws Exception{
		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("ZWEB_BUDGET_DETAIL_PLAN");
		
		function.getImportParameterList().setValue("I_GSBER",(String)req_data.get("I_GSBER"));
		function.getImportParameterList().setValue("I_RORG",(String)req_data.get("I_RORG"));
		function.getImportParameterList().setValue("I_BORG",(String)req_data.get("I_BORG"));
		function.getImportParameterList().setValue("I_BACT",(String)req_data.get("I_BACT"));
		function.getImportParameterList().setValue("I_SPMON",(String)req_data.get("I_SPMON"));
		function.getImportParameterList().setValue("I_ACTIME",(String)req_data.get("I_ACTIME"));
		
	    logger.debug("rfc start!");
	    jcoConnect.execute(function);
	    logger.debug("rfc finish!");
	    logger.debug("FLAG:"+function.getExportParameterList().getString("E_FLAG")+" / MESSAGE:"+function.getExportParameterList().getString("E_MESSAGE"));
	    
	    JCoTable table = function.getTableParameterList().getTable("GT_DISP");
	 	ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
	 	
		return list;
	}
	
	
	@Override
	public ArrayList<HashMap<String, String>> retrieveDetailAmtACT(HashMap req_data) throws Exception{
		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("ZWEB_BUDGET_DETAIL_ACT");

		function.getImportParameterList().setValue("I_GSBER",(String)req_data.get("I_GSBER"));
		function.getImportParameterList().setValue("I_RORG",(String)req_data.get("I_RORG"));
		function.getImportParameterList().setValue("I_BORG",(String)req_data.get("I_BORG"));
		function.getImportParameterList().setValue("I_BACT",(String)req_data.get("I_BACT"));
		function.getImportParameterList().setValue("I_SPMON",(String)req_data.get("I_SPMON"));
		function.getImportParameterList().setValue("I_ACTIME",(String)req_data.get("I_ACTIME"));
		
	    logger.debug("rfc start!");
	    jcoConnect.execute(function);
	    logger.debug("rfc finish!");
	    logger.debug("FLAG:"+function.getExportParameterList().getString("E_FLAG")+" / MESSAGE:"+function.getExportParameterList().getString("E_MESSAGE"));
	    
	    JCoTable table = function.getTableParameterList().getTable("GT_DISP");
	 	ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
	 	
		return list;
	}
	
	
	@Override
	public String retrieveDocumentPop(HashMap req_data) throws Exception{
		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("Z_FI_008");
	    
	    function.getImportParameterList().setValue("V_BUKRS","1000");	//회사코드 1000고정
	    function.getImportParameterList().setValue("V_BELNR",(String)req_data.get("BELNR"));
	    function.getImportParameterList().setValue("V_GJAHR",((String) req_data.get("BUDAT")).substring(0, 4));
	    
	    logger.debug("rfc start!");
	    jcoConnect.execute(function);
	    logger.debug("rfc finish!");
	    String docno = function.getExportParameterList().getString("E_DOCNO");
	    
	    logger.debug(docno);
	    return docno;
	}
	
	
	@Override
	public ArrayList<HashMap<String, String>> ui_select_retrieveBudgetModifyList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		Util util = new Util();
		Map req_data = util.getParamToMapWithNull(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		//날짜 파라메터 기본값 세팅
		if (req_data.get("SPMON_S") == null || req_data.get("SPMON_E") == null) {
			req_data.put("SPMON_S", DateUtil.getTodayMonth());
			req_data.put("SPMON_E", DateUtil.getTodayMonth());
		}
		
		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("ZWEB_BUDGET_CHANGE");

		function.getImportParameterList().setValue("I_GSBER_S",(String)req_data.get("GSBER_S"));		//사업영역(S)
	    function.getImportParameterList().setValue("I_GSBER_E",(String)req_data.get("GSBER_E"));		//사업영역(E)
	    function.getImportParameterList().setValue("I_RORG_S",(String)req_data.get("RORG_S"));			//집행부서(S)
	    //function.getImportParameterList().setValue("I_RORG_E",(String)req_data.get("RORG_E"));			//집행부서(E)
	    function.getImportParameterList().setValue("I_BORG_S",(String)req_data.get("BORG_S"));			//예산조직(S)
	    function.getImportParameterList().setValue("I_BORG_E",(String)req_data.get("BORG_E"));			//예산조직(E)
	    function.getImportParameterList().setValue("I_BACT_S",(String)req_data.get("BACT_S"));			//예산계정(S)
	    function.getImportParameterList().setValue("I_BACT_E",(String)req_data.get("BACT_E"));			//예산계정(E)
	    function.getImportParameterList().setValue("I_SPMON_S",StringUtils.replace((String)req_data.get("SPMON_S"), "/", ""));		//전기년월(S)
	    function.getImportParameterList().setValue("I_SPMON_E",StringUtils.replace((String)req_data.get("SPMON_E"), "/", ""));		//전기년월(E)
	    function.getImportParameterList().setValue("I_SPMON_F",StringUtils.replace((String)req_data.get("SPMON_F"), "/", ""));		//from(조기/이월)
	    function.getImportParameterList().setValue("I_SPMON_T",StringUtils.replace((String)req_data.get("SPMON_T"), "/", ""));		//to(조기/이월)
	    function.getImportParameterList().setValue("I_GUBUN",(String)req_data.get("GUBUN"));			//집행부서내예산조직별보기
	    function.getImportParameterList().setValue("I_STATU",(String)req_data.get("STATU"));			//승인상태
	    function.getImportParameterList().setValue("I_PERNR",(String)req_data.get("empCode"));			//사번

	    logger.debug("rfc start!");
	    jcoConnect.execute(function);
	    logger.debug("rfc finish!");
	    logger.debug("FLAG:"+function.getExportParameterList().getString("E_FLAG")+" / MESSAGE:"+function.getExportParameterList().getString("E_MESSAGE"));
	    
	    JCoTable table = function.getTableParameterList().getTable("GT_DISP");
	 	ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
	 	HashMap<String, Object> result = new HashMap<String, Object>();
	 	result.put("list", list);
	 	result.put("ep_flag", function.getExportParameterList().getString("E_FLAG"));	//exparam
	 	result.put("ep_msg", function.getExportParameterList().getString("E_MESSAGE"));	//exparam
		
	 	return list;
	}
	
	
	@Override
	public HashMap<String, Object> retrieveBudgetOnlyList(HashMap req_data) throws Exception{
		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("ZWEB_BUDGET_CHANGE");
		
		function.getImportParameterList().setValue("I_GSBER_S",(String)req_data.get("GSBER_S"));		//사업영역(S)
		function.getImportParameterList().setValue("I_RORG_S",(String)req_data.get("RORG_S"));			//집행부서(S)
		function.getImportParameterList().setValue("I_SPMON_S",StringUtils.replace((String)req_data.get("SPMON_S"), "/", ""));		//전기년월(S)
		function.getImportParameterList().setValue("I_SPMON_E",StringUtils.replace((String)req_data.get("SPMON_E"), "/", ""));		//전기년월(E)
		function.getImportParameterList().setValue("I_STATU",(String)req_data.get("STATU"));			//승인상태
		function.getImportParameterList().setValue("I_GUBUN","C");
		function.getImportParameterList().setValue("I_PERNR",(String)req_data.get("empCode"));			//사번
		
		logger.debug("rfc start!");
	    jcoConnect.execute(function);
	    logger.debug("rfc finish!");
	    
	    JCoTable table = function.getTableParameterList().getTable("GT_DISP");
	 	ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
	 	HashMap<String, Object> result = new HashMap<String, Object>();
	 	result.put("list", list);
	 	result.put("ep_flag", function.getExportParameterList().getString("E_FLAG"));
	 	result.put("ep_msg", function.getExportParameterList().getString("E_MESSAGE"));
	 	
		return result;
	}
	
	
	@Override
	public HashMap<String, String> retrieveAjaxBACT(HashMap req_data) throws Exception{
		
		/**
		 * kjy 2022.11.14 : 예산신청 -> 예산계정 검색 시 리스트로 들어오는 항목 컨버팅
		 */
		String rorg = (String)req_data.get("RORG_"+(String)req_data.get("target")).toString();
		rorg  = convertString(rorg);

		String borg = (String)req_data.get("BORG_"+(String)req_data.get("target")).toString();
		borg  = convertString(borg);
		
		String spmon = (String)req_data.get("SPMON_S_"+(String)req_data.get("target")).toString();
		spmon  = convertString(spmon);

		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("ZWEB_POPUP_ZCOBACT");
		function.getImportParameterList().setValue("I_RORG",rorg);	//집행부서
		function.getImportParameterList().setValue("I_BORG",borg);	//예산부서
		function.getImportParameterList().setValue("I_SPMON",StringUtils.replace(spmon, "/", ""));	//전용년월
//컨버팅 이전		
//		function.getImportParameterList().setValue("I_RORG",(String)req_data.get("RORG_"+(String)req_data.get("target")));	//집행부서
//		function.getImportParameterList().setValue("I_BORG",(String)req_data.get("BORG_"+(String)req_data.get("target")));	//예산부서
//		function.getImportParameterList().setValue("I_SPMON",StringUtils.replace((String)req_data.get("SPMON_S_"+(String)req_data.get("target")), "/", ""));	//전용년월
		
		function.getImportParameterList().setValue((String)req_data.get("search_type"),(String)req_data.get("search_text"));	//계정코드
		function.getImportParameterList().setValue("I_SEBU","X");									//단일문자표시
		function.getImportParameterList().setValue("I_GSBER",(String)req_data.get("GSBER_R"));		//사업영역
		
	    logger.debug("rfc start!");
	    jcoConnect.execute(function);
	    logger.debug("rfc finish!");
	    
	    HashMap<String, String> ex_param = new HashMap<String, String>();
	    ex_param.put("E_FLAG", function.getExportParameterList().getString("E_FLAG"));
	    ex_param.put("E_MESSAGE", function.getExportParameterList().getString("E_MESSAGE"));
	    ex_param.put("E_HKONT", function.getExportParameterList().getString("E_HKONT"));
	    ex_param.put("E_TXT_50", function.getExportParameterList().getString("E_TXT_50"));
	    ex_param.put("E_AMT", function.getExportParameterList().getString("E_AMT"));
	    
//	    JCoTable table = function.getTableParameterList().getTable("GT_DISP");
//	 	ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
	 	
		return ex_param;
	}

	/**
	 * kjy 2022.11.14 : 예산신청 -> 예산계정 검색 시 리스트로 들어오는 항목 컨버팅
	 */
	public String convertString(String str) {
		String arr[] = str.split(",");
		if(str.length() > 10) {
			return arr[0].substring(1);
		}
		return arr[0].substring(0);
	}
	
	
	@Override
	public String[] createBudgetToSAP(HashMap req_data) throws Exception{
		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("ZWEB_BUDGET_CHANGE_SAVE");
		JCoTable GT_DISP = function.getTableParameterList().getTable("GT_DISP");

		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("gridData").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("{}", jsonObj);
    		GT_DISP.appendRow();
    		GT_DISP.setValue("GSBER",(String)req_data.get("GSBER_R"));	//사업영역코드(조회영역)
    		GT_DISP.setValue("RORG", (String)jsonObj.get("RORG"));		//집행부서코드
    		GT_DISP.setValue("BORG", (String)jsonObj.get("BORG"));		//예산조직코드
    		GT_DISP.setValue("BACT", (String)jsonObj.get("BACT"));		//계정코드
    		GT_DISP.setValue("SPMON", StringUtils.replace((String)jsonObj.get("SPMON"), "/", ""));	//입력년월
    		GT_DISP.setValue("VALTP", (String)req_data.get("VALTP_R"));	//신청유형
    		GT_DISP.setValue("STATU","1");								//상태코드
    		GT_DISP.setValue("VALUE",(String)jsonObj.get("VALUE"));		//금액
    		GT_DISP.setValue("DOCUM",(String)jsonObj.get("DOCUM"));		//내역
    		GT_DISP.setValue("PERNR",(String)req_data.get("emp_code"));	//유저아이디
		}
		
		logger.debug("rfc start!");
	    jcoConnect.execute(function);
	    logger.debug("rfc finish!");
	    logger.debug("FLAG:"+function.getExportParameterList().getString("E_FLAG")+" / MESSAGE:"+function.getExportParameterList().getString("E_MESSAGE"));
	    
	    String[] result = {function.getExportParameterList().getString("E_FLAG"),function.getExportParameterList().getString("E_MESSAGE")};
	 	
		return result;
	}
	
	
	@Override
	public String[] updateBudgetToSAP(HashMap req_data) throws Exception{
		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("ZWEB_BUDGET_CHANGE_SAVE");
		JCoTable GT_DISP = function.getTableParameterList().getTable("GT_DISP");
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("gridData").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("{}", jsonObj);
			GT_DISP.appendRow();
    		GT_DISP.setValue("SEQ",(String)jsonObj.get("SEQ"));
    		GT_DISP.setValue("GSBER",(String)req_data.get("GSBER_R"));	//사업영역코드(조회영역)
    		GT_DISP.setValue("SPMON",StringUtils.replace((String)jsonObj.get("SPMON"), "/", ""));	//입력년월
			GT_DISP.setValue("SPMON2",StringUtils.replace((String)jsonObj.get("SPMON2"), "/", ""));	//입력년월
			GT_DISP.setValue("RORG",(String)jsonObj.get("RORG"));		//집행조직코드
			GT_DISP.setValue("BORG",(String)jsonObj.get("BORG"));		//예산조직코드
			GT_DISP.setValue("BACT",(String)jsonObj.get("BACT"));		//계정코드
			GT_DISP.setValue("REMAMT",StringUtils.replace((String)jsonObj.get("REMAMT"), ",", ""));	//잔액
    		GT_DISP.setValue("VALUE",(String)jsonObj.get("VALUE"));		//금액
    		GT_DISP.setValue("DOCUM",(String)jsonObj.get("DOCUM"));		//내역
    		GT_DISP.setValue("VALTP",(String)req_data.get("VALTP_R"));	//신청유형코드
    		GT_DISP.setValue("STATU",(String)jsonObj.get("STATU"));		//상태코드
    		GT_DISP.setValue("PERNR",(String)req_data.get("emp_code"));	//세션유저아이디
		}

	    logger.debug("rfc start!");
	    jcoConnect.execute(function);
	    logger.debug("rfc finish!");
	    logger.debug("FLAG:"+function.getExportParameterList().getString("E_FLAG")+" / MESSAGE:"+function.getExportParameterList().getString("E_MESSAGE"));
	    
	    String[] result = {function.getExportParameterList().getString("E_FLAG"),function.getExportParameterList().getString("E_MESSAGE")};
	 	
		return result;
	}
	
	
	@Override
	public String[] deleteBudgetToSAP(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("ZWEB_BUDGET_CHANGE_DELETE");
		
		JCoTable GT_DISP = function.getTableParameterList().getTable("GT_DISP");
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("gridData").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("{}", jsonObj);
			
			GT_DISP.appendRow();
    		GT_DISP.setValue("SEQ",(String)jsonObj.get("SEQ"));			//시퀀스
    		GT_DISP.setValue("GSBER",(String)req_data.get("GSBER_R"));	//사엽영역(본사,석포,안성휴게소)
    		GT_DISP.setValue("SPMON",(String)jsonObj.get("SPMON"));		//입력년월1(from)
			GT_DISP.setValue("SPMON2",(String)jsonObj.get("SPMON2"));	//입력년월2(to)
			GT_DISP.setValue("RORG", (String)jsonObj.get("RORG"));		//집행부서 코드
    		GT_DISP.setValue("BORG", (String)jsonObj.get("BORG"));		//예산조직 코드
    		GT_DISP.setValue("BACT", (String)jsonObj.get("BACT"));		//계정 코드
    		GT_DISP.setValue("VALUE",(String)jsonObj.get("VALUE"));		//잔액
    		GT_DISP.setValue("DOCUM",(String)jsonObj.get("DOCUM"));		//내역
    		GT_DISP.setValue("VALTP",(String)req_data.get("VALTP_R"));	//신청유형
    		GT_DISP.setValue("STATU",(String)jsonObj.get("STATU"));		//상태 코드
    		GT_DISP.setValue("PERNR",(String)req_data.get("emp_code"));	//유저아이디
		}
	
		logger.debug("rfc start!");
	    jcoConnect.execute(function);
	    logger.debug("rfc finish!");
	    logger.debug("FLAG:"+function.getExportParameterList().getString("E_FLAG")+" / MESSAGE:"+function.getExportParameterList().getString("E_MESSAGE"));
	    
	    String[] result = {function.getExportParameterList().getString("E_FLAG"),function.getExportParameterList().getString("E_MESSAGE")};
	 	
		return result;
	}
	
	
	@Override
	public ArrayList<HashMap<String, String>> ui_select_retrieveBudgetOnlyList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		Util util = new Util();
		Map req_data = util.getParamToMapWithNull(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("ZWEB_BUDGET_CHANGE");
		
		function.getImportParameterList().setValue("I_GSBER_S",(String)req_data.get("GSBER_S"));		//사업영역(S)
		function.getImportParameterList().setValue("I_RORG_S",(String)req_data.get("RORG_S"));			//집행부서(S)
		function.getImportParameterList().setValue("I_SPMON_S",StringUtils.replace((String)req_data.get("SPMON_S"), "/", ""));		//전기년월(S)
		function.getImportParameterList().setValue("I_SPMON_E",StringUtils.replace((String)req_data.get("SPMON_E"), "/", ""));		//전기년월(E)
		function.getImportParameterList().setValue("I_STATU",(String)req_data.get("STATU"));			//승인상태
		function.getImportParameterList().setValue("I_GUBUN","C");
		function.getImportParameterList().setValue("I_PERNR",(String)req_data.get("empCode"));			//사번
		
		logger.debug("rfc start!");
	    jcoConnect.execute(function);
	    logger.debug("rfc finish!");
	    
	    JCoTable table = function.getTableParameterList().getTable("GT_DISP");
	 	ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
	 	HashMap<String, Object> result = new HashMap<String, Object>();
	 	result.put("list", list);
	 	result.put("ep_flag", function.getExportParameterList().getString("E_FLAG"));
	 	result.put("ep_msg", function.getExportParameterList().getString("E_MESSAGE"));
	 	
		return list;
	}
	
	
	@Override
	public String[] createBudgetOnlyToSAP(HashMap req_data) throws Exception{
		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("ZWEB_BUDGET_CHANGE_SAVE");
		function.getImportParameterList().setValue("I_GUBUN","C");
		
		String[] row_no = (String[]) req_data.get("add_index");
		JCoTable GT_DISP = function.getTableParameterList().getTable("GT_DISP");

		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("gridData").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("{}", jsonObj);
    		GT_DISP.appendRow();
    		GT_DISP.setValue("GSBER",(String)jsonObj.get("GSBER"));		//사업영역코드
    		GT_DISP.setValue("SPMON", StringUtils.replace((String)jsonObj.get("SPMON"), "/", ""));	//전용년월
    		GT_DISP.setValue("RORG", (String)jsonObj.get("RORG"));		//집행부서코드
    		GT_DISP.setValue("BORG", (String)jsonObj.get("BORG"));		//예산조직코드
    		GT_DISP.setValue("C_GSBER",(String)jsonObj.get("GSBER"));	//사업영역코드
			GT_DISP.setValue("C_BORG",(String)jsonObj.get("C_BORG"));	//전용 예산조직코드
    		GT_DISP.setValue("BACT", (String)jsonObj.get("BACT"));		//계정코드
    		GT_DISP.setValue("REMAMT",StringUtils.replace((String)jsonObj.get("REMAMT"), ",", ""));	//잔액
    		GT_DISP.setValue("VALUE",(String)jsonObj.get("VALUE"));		//금액
			GT_DISP.setValue("DOCUM",(String)jsonObj.get("DOCUM"));		//내역
			GT_DISP.setValue("VALTP","C");								//신청유형
		}

		logger.debug("rfc start!");
	    jcoConnect.execute(function);
	    logger.debug("rfc finish!");
	    
	    String[] result = {function.getExportParameterList().getString("E_FLAG"),function.getExportParameterList().getString("E_MESSAGE")};
	    return result;
	}
	
	
	@Override
	public String deleteBudgetOnlyToSAP(HashMap req_data) throws Exception{
		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("ZWEB_BUDGET_CHANGE_DELETE");
		function.getImportParameterList().setValue("I_GUBUN","C");
		
		JCoTable GT_DISP = function.getTableParameterList().getTable("GT_DISP");
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("gridData").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("{}", jsonObj);
			GT_DISP.appendRow();
			GT_DISP.setValue("SEQ",(String)jsonObj.get("SEQ"));										//시퀀스
			GT_DISP.setValue("GSBER",(String)jsonObj.get("GSBER"));									//사업영역코드
			GT_DISP.setValue("SPMON",StringUtils.replace((String)jsonObj.get("SPMON"), "/", ""));	//전용년월
			GT_DISP.setValue("RORG", (String)jsonObj.get("RORG"));									//집행부서코드
    		GT_DISP.setValue("BORG", (String)jsonObj.get("BORG"));									//예산조직코드
			GT_DISP.setValue("C_GSBER",(String)jsonObj.get("GSBER"));								//사업영역코드
			GT_DISP.setValue("C_BORG",(String)jsonObj.get("C_BORG"));								//전용 예산조직코드
    		GT_DISP.setValue("BACT", (String)jsonObj.get("BACT"));									//계정코드
    		GT_DISP.setValue("REMAMT",StringUtils.replace((String)jsonObj.get("REMAMT"), ",", ""));	//잔액
    		GT_DISP.setValue("VALUE",(String)jsonObj.get("VALUE"));									//금액
			GT_DISP.setValue("DOCUM",(String)jsonObj.get("DOCUM"));									//내역
		}

		logger.debug("rfc start!");
	    jcoConnect.execute(function);
	    logger.debug("rfc finish!");
	    
	    return function.getExportParameterList().getString("E_MESSAGE");
	}
	
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	public HashMap<String, Object> retrieveBudgetDocWriteList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Util util = new Util();
		Map req_data = util.getParamToMapWithNull(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		req_data.put("empCode", session.getAttribute("empCode"));
		
		SapJcoConnection jcoConnect = new SapJcoConnection();
		
		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_BUDGET_GWLIST");
		
		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue("I_GSBER_S",(String)req_data.get("GSBER_S"));		//사업영역(S)
		function.getImportParameterList().setValue("I_GSBER_E",(String)req_data.get("GSBER_E"));		//사업영역(E)
		function.getImportParameterList().setValue("I_RORG_S",(String)req_data.get("RORG_S"));			//집행부서(S)
		//function.getImportParameterList().setValue("I_RORG_E",(String)req_data.get("RORG_E"));			//집행부서(E)
		function.getImportParameterList().setValue("I_BORG_S",(String)req_data.get("BORG_S"));			//예산조직(S)
		function.getImportParameterList().setValue("I_BORG_E",(String)req_data.get("BORG_E"));			//예산조직(E)
		function.getImportParameterList().setValue("I_BACT_S",(String)req_data.get("BACT_S"));			//예산계정(S)
		function.getImportParameterList().setValue("I_BACT_E",(String)req_data.get("BACT_E"));			//예산계정(E)
		function.getImportParameterList().setValue("I_SPMON_S",StringUtils.replace((String)req_data.get("SPMON_S"), "/", ""));		//전기년월(S)
		function.getImportParameterList().setValue("I_SPMON_E",StringUtils.replace((String)req_data.get("SPMON_E"), "/", ""));		//전기년월(E)
		function.getImportParameterList().setValue("I_VALTP",(String)req_data.get("GUBUN"));			//집행부서내예산조직별보기
		function.getImportParameterList().setValue("I_STATU",(String)req_data.get("STATU"));			//승인상태
		function.getImportParameterList().setValue("I_PERNR",(String)req_data.get("empCode"));			//사번

		// RFC 호출
		jcoConnect.execute(function);
		
		logger.debug("FLAG:"+function.getExportParameterList().getString("E_FLAG")+" / MESSAGE:"+function.getExportParameterList().getString("E_MESSAGE"));
		
		// RFC 결과
		JCoTable table = function.getTableParameterList().getTable("GT_DISP");
		
		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		result.put("list", list);
//		result.put("ep_flag", function.getExportParameterList().getString("E_FLAG"));	//exparam
//		result.put("ep_msg", function.getExportParameterList().getString("E_MESSAGE"));	//exparam
		result.put("YP_RFC_CODE", function.getExportParameterList().getString("E_FLAG"));	//exparam
		result.put("YP_RFC_MSG", function.getExportParameterList().getString("E_MESSAGE"));	//exparam

		return result;
	}
	
	
	@SuppressWarnings("rawtypes")
	@Override
	public String[] retreveEdocPop(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();
		
		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZWEB_BUDGET_GW");
//		String[] chk_no = (String[]) req_data.get("chk_no");

		// RFC 결과
		JCoTable GT_DISP = function.getTableParameterList().getTable("GT_DISP");
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("chk_no").toString());
		logger.debug("jsonArr.size() - {}", jsonArr.size());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			GT_DISP.appendRow();
			GT_DISP.setValue("SEQ", (String) jsonObj.get("SEQ"));
			GT_DISP.setValue("GSBER", (String) jsonObj.get("GSBER"));
			GT_DISP.setValue("SPMON", (String) jsonObj.get("SPMON"));
			GT_DISP.setValue("SPMON2", (String) jsonObj.get("SPMON2"));
			GT_DISP.setValue("C_SPMON", (String) jsonObj.get("C_SPMON"));
			GT_DISP.setValue("RORG", (String) jsonObj.get("RORG"));
			GT_DISP.setValue("BORG", (String) jsonObj.get("BORG"));
			GT_DISP.setValue("BACT", (String) jsonObj.get("BACT"));
			GT_DISP.setValue("VALUE", (String) jsonObj.get("VALUE"));
			GT_DISP.setValue("DOCUM", (String) jsonObj.get("DOCUM"));
			GT_DISP.setValue("VALTP", (String) jsonObj.get("VALTP"));
			GT_DISP.setValue("STATU", (String) jsonObj.get("STATU"));
			GT_DISP.setValue("C_SEQ", (String) jsonObj.get("C_SEQ"));
			GT_DISP.setValue("C_TYPE", (String) jsonObj.get("C_TYPE"));
			GT_DISP.setValue("C_GSBER", (String) jsonObj.get("C_GSBER"));
			GT_DISP.setValue("C_BORG", (String) jsonObj.get("C_BORG"));
			GT_DISP.setValue("C_BACT", (String) jsonObj.get("C_BACT"));
			GT_DISP.setValue("PERNR", (String) req_data.get("emp_code"));
			logger.debug("VALUE - {}", jsonObj.get("VALUE"));
		}

		// RFC 호출
		jcoConnect.execute(function);
		logger.debug("FLAG:" + function.getExportParameterList().getString("E_FLAG") + " / MESSAGE:" + function.getExportParameterList().getString("E_MESSAGE") + "\nURL:" + function.getExportParameterList().getString("E_URL"));

		String[] result = {function.getExportParameterList().getString("E_FLAG"), function.getExportParameterList().getString("E_MESSAGE"), function.getExportParameterList().getString("E_URL")};

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
 	    logger.debug("list = " + list);

		return list;
 	    
	}
	
	
	@Override
	public HashMap<String, Object> ui_select_retrieveBudgetStatus(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		Util util = new Util();
		Map req_data = util.getParamToMapWithNull(request, true); 	// 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();
		req_data.put("empCode", session.getAttribute("empCode"));	//사번 파라메터 담기
		
		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("ZWEB_BUDGET_CJE0_LIST");

		function.getImportParameterList().setValue("I_PSPID",(String)req_data.get("POSID"));				//WBS코드
		function.getImportParameterList().setValue("I_PERNR",(String)req_data.get("empCode"));				//사번
		function.getImportParameterList().setValue("I_GUBUN",(String)req_data.get("GUBUN"));				//구분  X:상세화면,B:예산,S:실제,Y:약정
		function.getImportParameterList().setValue("I_YYYYMM",StringUtils.replace((String)req_data.get("YYYYMM"), "/", ""));		//년월

		logger.debug("rfc start!");
	    jcoConnect.execute(function);
	    logger.debug("rfc finish!");
	    
	    JCoTable table = function.getTableParameterList().getTable("GT_DISP");
	 	ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
	 	JCoTable tablex = function.getTableParameterList().getTable("GT_DISP_X");
	 	ArrayList<HashMap<String, String>> listx = jcoConnect.createSapList(tablex);
	 	JCoTable tableb = function.getTableParameterList().getTable("GT_DISP_B");
	 	ArrayList<HashMap<String, String>> listb = jcoConnect.createSapList(tableb);
	 	JCoTable tables = function.getTableParameterList().getTable("GT_DISP_S");
	 	ArrayList<HashMap<String, String>> lists = jcoConnect.createSapList(tables);
	 	JCoTable tabley = function.getTableParameterList().getTable("GT_DISP_Y");
	 	ArrayList<HashMap<String, String>> listy = jcoConnect.createSapList(tabley);
		HashMap<String, Object> result = new HashMap<String, Object>();
	 	
		if("X".equals(req_data.get("GUBUN"))) {
			result.put("list", listx);
		 	result.put("ep_flag", function.getExportParameterList().getString("E_FLAG"));
		 	result.put("ep_msg", function.getExportParameterList().getString("E_MESSAGE"));
		} else {
			result.put("list", list);
			result.put("YP_RFC_CODE", function.getExportParameterList().getString("E_FLAG"));
			result.put("YP_RFC_MSG", function.getExportParameterList().getString("E_MESSAGE"));
		}

	 	result.put("listb", listb);
	 	result.put("lists", lists);
	 	result.put("listy", listy);

	 	logger.debug("table="+tablex);
	 	return result;
	}
	
	
	@Override
	public HashMap<String, Object> ui_select_retrieveBudgetWbsList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		Util util = new Util();
		Map req_data = util.getParamToMapWithNull(request, true); 	// 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		req_data.put("empCode", session.getAttribute("empCode"));	//사번 파라메터 담기
		
		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("ZWEB_BUDGET_WBS_LIST");

		function.getImportParameterList().setValue("I_GUBUN",(String)req_data.get("GUBUN"));				//구분  1:투자,8:보수
		function.getImportParameterList().setValue("I_BUDAT_S",StringUtils.replace((String)req_data.get("BUDAT_S"), "/", ""));		//전기일(S)
		function.getImportParameterList().setValue("I_BUDAT_E",StringUtils.replace((String)req_data.get("BUDAT_E"), "/", ""));		//전기일(E)
		function.getImportParameterList().setValue("I_RORG_S",(String)req_data.get("RORG_S"));				//집행부서(S)
		function.getImportParameterList().setValue("I_PSPID",(String)req_data.get("POSID"));				//WBS코드
		function.getImportParameterList().setValue("I_GRIR",(String)req_data.get("GRIR"));					//GR/IR 계정 포함
		function.getImportParameterList().setValue("I_PERNR",(String)req_data.get("empCode"));				//사번
		
		if(req_data.containsKey("PRJ1")) {
			function.getImportParameterList().setValue("I_PRJ1",(String)req_data.get("PRJ1"));				//프로젝트 속성 구분(환경개선)
		}
		if(req_data.containsKey("PRJ2")) {
			function.getImportParameterList().setValue("I_PRJ2",(String)req_data.get("PRJ2"));				//프로젝트 속성 구분(생산증대)
		}
		if(req_data.containsKey("PRJ3")) {
			function.getImportParameterList().setValue("I_PRJ3",(String)req_data.get("PRJ3"));				//프로젝트 속성 구분(설비대체)
		}
		if(req_data.containsKey("PRJ4")) {
			function.getImportParameterList().setValue("I_PRJ4",(String)req_data.get("PRJ4"));				//프로젝트 속성 구분(안전관리)
		}
		if(req_data.containsKey("PRJ5")) {
			function.getImportParameterList().setValue("I_PRJ5",(String)req_data.get("PRJ5"));				//프로젝트 속성 구분(기타)
		}

		logger.debug("rfc start!");
	    jcoConnect.execute(function);
	    logger.debug("rfc finish!");
	    
	    JCoTable table = function.getTableParameterList().getTable("GT_DISP");
	 	ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
		HashMap<String, Object> result = new HashMap<String, Object>();
	 	result.put("list", list);
//	 	result.put("ep_flag", function.getExportParameterList().getString("E_FLAG"));
//	 	result.put("ep_msg", function.getExportParameterList().getString("E_MESSAGE"));
	 	result.put("YP_RFC_CODE", function.getExportParameterList().getString("E_FLAG"));
		result.put("YP_RFC_MSG", function.getExportParameterList().getString("E_MESSAGE"));
		
	 	return result;
	}
	
	
	@Override
	public HashMap<String, Object> retrieveBudgetWbsDetailList(HashMap req_data) throws Exception{
		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("ZWEB_BUDGET_WBS_LIST_DETAIL");
		
		function.getImportParameterList().setValue("I_GUBUN",(String)req_data.get("GUBUN"));		//구분  1:투자,8:보수
		function.getImportParameterList().setValue("I_GUBUN2",(String)req_data.get("GUBUN2"));		//구분  1:계약금액,2:투자금액,3:지급금액
		function.getImportParameterList().setValue("I_BUDAT_S",StringUtils.replace((String)req_data.get("BUDAT_S"), "/", ""));		//전기일(S)
		function.getImportParameterList().setValue("I_BUDAT_E",StringUtils.replace((String)req_data.get("BUDAT_E"), "/", ""));		//전기일(E)
		function.getImportParameterList().setValue("I_PSPID",(String)req_data.get("PSPID"));		//WBS코드
		if("1".equals((String)req_data.get("GRIR")))
			function.getImportParameterList().setValue("I_GRIR",(String)req_data.get("GRIR"));		//GR/IR 계정 포함
		
		logger.debug("rfc start!");
	    jcoConnect.execute(function);
	    logger.debug("rfc finish!");
	    
	    String export_table = "GT_DISP";
	    if("2".equals((String)req_data.get("GUBUN2"))) export_table = "GT_DISP2";
	    else if("3".equals((String)req_data.get("GUBUN2"))) export_table = "GT_DISP3";
	    
	    JCoTable table = function.getTableParameterList().getTable(export_table);
	 	ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
	 	
		HashMap<String, Object> result = new HashMap<String, Object>();
	 	result.put("list", list);
	 	result.put("ep_flag", function.getExportParameterList().getString("E_FLAG"));
	 	result.put("ep_msg", function.getExportParameterList().getString("E_MESSAGE"));
		
	 	return result;
	}
	
}
