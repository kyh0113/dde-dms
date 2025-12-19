package com.yp.zmm.raw.srvc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
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
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.util.StringUtils;
import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoTable;
import com.vicurus.it.core.common.Util;
import com.yp.sap.SapJcoConnection;
import com.yp.util.DateUtil;
import com.yp.zmm.raw.srvc.intf.YP_ZMM_RAW_Service;

@Repository
public class YP_ZMM_RAW_ServiceImpl implements YP_ZMM_RAW_Service {

	// config.properties 에서 설정 정보 가져오기 시작
	@SuppressWarnings("unused")
	private static String NAMESPACE;
	private static String MAIL_USE_YN;

	@SuppressWarnings("static-access")
	@Value("#{config['db.vendor']}")
	public void setNAMESPACE(String value) {
		this.NAMESPACE = value + ".";
	}
	@Value("#{config['mail.use']}")
	public void setMAIL_USE_YN(String value) {
		this.MAIL_USE_YN = value;
	}
	// config.properties 에서 설정 정보 가져오기 끝

	@Autowired
	@Resource(name = "sqlSession")
	private SqlSession query;
	
	@Autowired
	@Resource(name = "sqlSession2")
	private SqlSession query_mssql;

	private static final Logger logger = LoggerFactory.getLogger(YP_ZMM_RAW_ServiceImpl.class);

	@Override
	public ArrayList<HashMap<String, String>> retrieveLME(HashMap paramMap) throws Exception {
		// TODO Auto-generated method stub
		return (ArrayList) query.selectList(NAMESPACE+"yp_zmm.retrieveLME", paramMap);
	}
	
	@Override
	public ArrayList<HashMap<String, String>> retrieveLME_AVG(HashMap paramMap) throws Exception {
		// TODO Auto-generated method stub
		return (ArrayList) query.selectList(NAMESPACE+"yp_zmm.retrieveLME_AVG", paramMap);
	}
	
	@Override
	public ArrayList<HashMap<String, String>> retrieveArrivalScheduleList(HashMap paramMap) throws Exception {
		// TODO Auto-generated method stub
		return (ArrayList) query.selectList(NAMESPACE+"yp_zmm.retrieveArrivalScheduleList", paramMap);
	}
	
	@Override
	public ArrayList<HashMap<String, String>> retrieveLME_check(HashMap paramMap) throws Exception {
		// TODO Auto-generated method stub
		return (ArrayList) query.selectList(NAMESPACE+"yp_zmm.retrieveLME_check", paramMap);
	}
	
	@Transactional
	@Override
	public int createLME(HashMap req_data) throws Exception{
		return query.insert(NAMESPACE+"yp_zmm.createLME", req_data);
	}
	
	@Transactional
	@Override
	public int updateLME(HashMap req_data) throws Exception{
		return query.update(NAMESPACE+"yp_zmm.updateLME", req_data);
	}
	
	@Override
	public ArrayList<HashMap<String, String>> retrieveItemBySAP(HashMap req_data) throws Exception{
		SapJcoConnection jcoConnect = new SapJcoConnection();
		
		if(req_data.get("search_text") == null) {	//전체 검색(팝업 초기엔 전체검색 결과를 제공)
			JCoFunction function = jcoConnect.getFunction("ZPP_BLEND_001");
		    function.getImportParameterList().setValue("I_PIN","1");	//1.item, 2.vendor
		    
		    jcoConnect.execute(function);
			
		    JCoTable table = function.getTableParameterList().getTable("TB_IF_R_001");
		    ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
		    return list;
		
		}else{	//건당 코드검색
			//20201117_khj 코드 및 이름 넣어서 조회하는 테이블 추가
		    JCoFunction function = jcoConnect.getFunction("ZPP_BLEND_002");

		    function.getImportParameterList().setValue("I_LIFNR", "");	//명칭
		    function.getImportParameterList().setValue("I_MIN_CD",req_data.get("search_text"));	//코드

		    jcoConnect.execute(function);
			
		    JCoTable table = function.getTableParameterList().getTable("TB_IF_R_001");
		    ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
		    return list;
		}  
	}
	
	@Override
	public ArrayList<HashMap<String, String>> retrieveVendorBySAP(HashMap req_data) throws Exception{
		SapJcoConnection jcoConnect = new SapJcoConnection();
		
		if(req_data.get("search_text") == null) {	//전체 검색(팝업 초기엔 전체검색 결과를 제공)
			JCoFunction function = jcoConnect.getFunction("ZPP_BLEND_001");
		    function.getImportParameterList().setValue("I_PIN","2");	//1.item, 2.vendor
		    
		    jcoConnect.execute(function);
			
		    JCoTable table = function.getTableParameterList().getTable("TB_IF_R_002");
		    ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
		    return list;
		
		}else{	//건당 코드검색
			//20201117_khj 코드 및 이름 넣어서 조회하는 테이블 추가
		    JCoFunction function = jcoConnect.getFunction("ZPP_BLEND_002");

		    function.getImportParameterList().setValue("I_LIFNR", req_data.get("search_text"));	//명칭
		    function.getImportParameterList().setValue("I_MIN_CD","");	//코드
		   
		    jcoConnect.execute(function);
			
		    JCoTable table = function.getTableParameterList().getTable("TB_IF_R_002");
		    ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
		    return list;
		}  
	}
	
	@Transactional
	@Override
	public int createArrivalSchedule(HashMap req_data) throws Exception{
		HashMap reg_data = new HashMap();
		int result = 0;

		try {
			JSONParser jsonParse = new JSONParser();
			JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("gridData").toString());
			for (int i = 0; i < jsonArr.size(); i++) {
				JSONObject jsonObj = (JSONObject) jsonArr.get(i);
				logger.debug("{}", jsonObj);
				String tmp = (String)jsonObj.get("VENDOR_CD");
				req_data.put("VENDOR_CD",Integer.parseInt(tmp));
				reg_data.put("PO_NO", jsonObj.get("PO_NO"));								//주문번호
				reg_data.put("RECEIPT_NO", jsonObj.get("RECEIPT_NO"));					//입고번호(사용안하기로함)
				reg_data.put("VENDOR_CD", jsonObj.get("VENDOR_CD"));						//업체코드*
				reg_data.put("VENDOR_NM", jsonObj.get("VENDOR_NM"));						//업체명
				reg_data.put("ITEM_CD", jsonObj.get("ITEM_CD"));							//광종코드*
				reg_data.put("ITEM_NM", jsonObj.get("ITEM_NM"));							//광종명
				reg_data.put("ORDER1", jsonObj.get("ORDER1"));								//차수
				reg_data.put("ORDER2", jsonObj.get("ORDER2").toString().toUpperCase());		//입고차수*
				reg_data.put("SHIP_NM", jsonObj.get("SHIP_NM"));							//선박명
				reg_data.put("DMT", jsonObj.get("DMT"));									//입고수량*
				reg_data.put("LAYCAN", jsonObj.get("LAYCAN"));								//Laycan
				reg_data.put("UPLOAD_DATE", StringUtils.replace((String)jsonObj.get("UPLOAD_DATE"),"/",""));	//선적일
				reg_data.put("SHIP_DATE", StringUtils.replace((String)jsonObj.get("SHIP_DATE"),"/",""));		//실제입항일
				
				if( jsonObj.get("RECEIPT") == Boolean.TRUE) jsonObj.put("RECEIPT", "Y");
				reg_data.put("RECEIPT", (String)jsonObj.get("RECEIPT"));					//BL(수령)
				
				if( jsonObj.get("DELAY") == Boolean.TRUE) jsonObj.put("DELAY", "Y");
				reg_data.put("DELAY", (String)jsonObj.get("DELAY"));						//BL(전달)
				
				reg_data.put("ITINERARY", jsonObj.get("ITINERARY"));						//Itinerary
				reg_data.put("ARRIVAL_DATE",  StringUtils.replace((String)jsonObj.get("ARRIVAL_DATE"),"/",""));//BL입항일*
				reg_data.put("UNLOAD_DATE",  StringUtils.replace((String)jsonObj.get("UNLOAD_DATE"),"/",""));	//하역일
				
				if( jsonObj.get("UNLOAD_YN") == Boolean.TRUE) jsonObj.put("UNLOAD_YN", "Y");
				reg_data.put("UNLOAD_YN", (String)jsonObj.get("UNLOAD_YN"));				//하역여부
				
				reg_data.put("SHIP_VENDOR", jsonObj.get("SHIP_VENDOR"));					//선사
				reg_data.put("SURVEYOR", jsonObj.get("SURVEYOR"));							//surveyor
				
				if( jsonObj.get("TT") == Boolean.TRUE) jsonObj.put("TT", "Y");
				reg_data.put("TT", (String)jsonObj.get("TT"));								//지불방법(T/T)
				
				if( jsonObj.get("LC") == Boolean.TRUE) jsonObj.put("LC", "Y");
				reg_data.put("LC", (String)jsonObj.get("LC"));								//지불방법(L/C)
				
				reg_data.put("CONDITION", jsonObj.get("CONDITION"));						//지불방법(조건)
				reg_data.put("USER_ID", req_data.get("emp_code"));							//등록자 사번
				
				//reg_data.put("SYSTIMESTAMP", query.selectOne(NAMESPACE+"yp_zmm.getSYSTIMESTAMP"));		//현재시간

				result += query.insert(NAMESPACE+"yp_zmm.createArrivalSchedule", reg_data);					//웹포털 DB 반영
				if(result >= 1) {
					if(MAIL_USE_YN.equals("Y")) {
						this.sendMail(reg_data);	//데이터 등록시 원료팀에 메일발송
					}
					result += query_mssql.insert(NAMESPACE+"yp_zmm.createArrivalSchedule_ms", reg_data);	//정광블렌딩 DB 반영(DB link 불가)
				}
				if(result != 2) throw new Exception();
			}
		}catch(Exception e) {
			logger.debug("insert Rollback start");
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();	//운영테스트 허용시 같이 주석풀어주자
			logger.debug("insert Rollback");
		}
		return result;
	}
	
	@Transactional
	@Override
	public int updateArrivalSchedule(HashMap req_data) throws Exception{
		HashMap upd_data = new HashMap();
		int result = 0;

		try {
			JSONParser jsonParse = new JSONParser();
			JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("gridData").toString());
			for (int i = 0; i < jsonArr.size(); i++) {
				JSONObject jsonObj = (JSONObject) jsonArr.get(i);
				logger.debug("{}", jsonObj);
				String tmp = (String)jsonObj.get("VENDOR_CD");
				req_data.put("VENDOR_CD",Integer.parseInt(tmp));
				upd_data.put("SEQ", jsonObj.get("SEQ"));
				upd_data.put("PO_NO", jsonObj.get("PO_NO"));					//주문번호
				upd_data.put("RECEIPT_NO", jsonObj.get("RECEIPT_NO"));		//입고번호(사용안하기로함)
				upd_data.put("VENDOR_CD", jsonObj.get("VENDOR_CD"));			//업체코드*
				upd_data.put("VENDOR_NM", jsonObj.get("VENDOR_NM"));			//업체명
				upd_data.put("ITEM_CD", jsonObj.get("ITEM_CD"));				//광종코드*
				upd_data.put("ITEM_NM", jsonObj.get("ITEM_NM"));				//광종명
				upd_data.put("ORDER1", jsonObj.get("ORDER1"));					//차수
				upd_data.put("ORDER2", jsonObj.get("ORDER2").toString().toUpperCase());	//입고차수*
				upd_data.put("SHIP_NM", jsonObj.get("SHIP_NM"));				//선박명
				upd_data.put("DMT", jsonObj.get("DMT"));						//입고수량*
				upd_data.put("LAYCAN", jsonObj.get("LAYCAN"));					//Laycan
				upd_data.put("UPLOAD_DATE", StringUtils.replace((String)jsonObj.get("UPLOAD_DATE"),"/",""));	//선적일
				upd_data.put("SHIP_DATE", StringUtils.replace((String)jsonObj.get("SHIP_DATE"),"/",""));		//실제입항일
				
				if( jsonObj.get("RECEIPT") == Boolean.TRUE) jsonObj.put("RECEIPT", "Y");
				upd_data.put("RECEIPT", (String)jsonObj.get("RECEIPT"));		//BL(수령)

				if( jsonObj.get("DELAY") == Boolean.TRUE) jsonObj.put("DELAY", "Y");
				upd_data.put("DELAY", (String)jsonObj.get("DELAY"));			//BL(전달)
				
				upd_data.put("ITINERARY", jsonObj.get("ITINERARY"));			//Itinerary

				upd_data.put("ORIGINAL_ARRIVAL_DATE",  StringUtils.replace((String)jsonObj.get("ORIGINAL_ARRIVAL_DATE"),"/",""));//BL입항일(key값 구분위한 수정없는 데이터)

				upd_data.put("ARRIVAL_DATE",  StringUtils.replace((String)jsonObj.get("ARRIVAL_DATE"),"/",""));	//BL입항일*

				if( jsonObj.get("ARRIVAL_DATE_FIX") == Boolean.TRUE) {
					jsonObj.put("ARRIVAL_DATE_FIX", "Y");		//BL입항일 FIX 여부
				}else {
					jsonObj.put("ARRIVAL_DATE_FIX", "");		//BL입항일 FIX 여부
				}
				upd_data.put("ARRIVAL_DATE_FIX", (String)jsonObj.get("ARRIVAL_DATE_FIX"));
				
				upd_data.put("UNLOAD_DATE",  StringUtils.replace((String)jsonObj.get("UNLOAD_DATE"),"/",""));	//하역일
				
				if( jsonObj.get("UNLOAD_YN") == Boolean.TRUE) jsonObj.put("UNLOAD_YN", "Y");
				upd_data.put("UNLOAD_YN", (String)jsonObj.get("UNLOAD_YN"));	//하역여부
				
				upd_data.put("SHIP_VENDOR", jsonObj.get("SHIP_VENDOR"));		//선사
				upd_data.put("SURVEYOR", jsonObj.get("SURVEYOR"));				//surveyor
				
				if( jsonObj.get("TT") == Boolean.TRUE) jsonObj.put("TT", "Y");
				upd_data.put("TT", (String)jsonObj.get("TT"));					//지불방법(T/T)
				
				if( jsonObj.get("LC") == Boolean.TRUE) jsonObj.put("LC", "Y");
				upd_data.put("LC", (String)jsonObj.get("LC"));					//지불방법(L/C)
				
				upd_data.put("CONDITION", jsonObj.get("CONDITION"));			//지불방법(조건)
				upd_data.put("USER_ID", req_data.get("emp_code"));				//등록자 사번
				
				
				int chk_cnt = 0;	//존재여부 체크 변두
				chk_cnt = query.selectOne(NAMESPACE+"yp_zmm.ArrivalScheduleChk", upd_data);	//웹포털 DB에 존재하는 스케줄데이터인지 체크
				
				if(chk_cnt > 0) {	//존재
					result += query.update(NAMESPACE+"yp_zmm.updateArrivalSchedule", upd_data);		//웹포털 DB UPDATE 반영
				}else {	//미존재
					result += query.insert(NAMESPACE+"yp_zmm.createArrivalSchedule", upd_data);		//웹포털 DB INSERT 반영
				}
				
				
				if(result >= 1) {
					if(MAIL_USE_YN.equals("Y")) {
						this.sendMail(upd_data);	//데이터 등록시 원료팀에 메일발송
					}		
					
					chk_cnt = 0;
					chk_cnt = query_mssql.selectOne(NAMESPACE+"yp_zmm.ArrivalScheduleChk_ms", upd_data);	//정광블렌딩 DB에 존재하는 스케줄데이터인지 체크
					if(chk_cnt > 0) {	//존재
						result += query_mssql.update(NAMESPACE+"yp_zmm.updateArrivalSchedule_ms", upd_data);	//정광블렌딩 DB UPDATE 반영(DB link 불가)
					}else {	//미존재
						result += query_mssql.insert(NAMESPACE+"yp_zmm.createArrivalSchedule_ms", upd_data);	//정광블렌딩 DB INSERT 반영(DB link 불가)
					}

				}
				if(result != 2) throw new Exception();
			}
		}catch(Exception e) {
			logger.debug("update Rollback start");
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();	//운영테스트 허용시 같이 주석풀어주자
			logger.debug("update Rollback");
		}
		return result;
	}
	
	@Transactional
	@Override
	public int deleteArrivalSchedule(HashMap req_data) throws Exception{
		HashMap del_data = new HashMap();
		int result = 0;

		try {
			JSONParser jsonParse = new JSONParser();
			JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("gridData").toString());
			for (int i = 0; i < jsonArr.size(); i++) {
				JSONObject jsonObj = (JSONObject) jsonArr.get(i);
				logger.debug("{}", jsonObj);

				del_data.put("ITEM_CD", jsonObj.get("ITEM_CD"));	//광종코드* KEY
				del_data.put("SEQ", jsonObj.get("SEQ"));			//시퀀스 KEY
				del_data.put("ORDER2", jsonObj.get("ORDER2"));		//입고차수* KEY
				del_data.put("ORIGINAL_ARRIVAL_DATE",  StringUtils.replace((String)jsonObj.get("ORIGINAL_ARRIVAL_DATE"),"/",""));//BL입항일(key값 구분위한 수정없는 데이터) KEY
				
				result += query.delete(NAMESPACE+"yp_zmm.deleteArrivalSchedule", del_data);					//웹포털 DB 반영
				if(result >= 1) {
					result += query_mssql.delete(NAMESPACE+"yp_zmm.deleteArrivalSchedule_ms", del_data);	//정광블렌딩 DB 반영_입항스케줄 삭제(DB link 불가)
					result += query_mssql.delete(NAMESPACE+"yp_zmm.deleteAssay_ms", del_data);				//정광블렌딩 DB 반영_분석데이터 삭제(DB link 불가)
				}
				if(result < 2) throw new Exception();
			}
		}catch(Exception e) {
			logger.debug("delete Rollback start");
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();	//운영테스트 허용시 같이 주석풀어주자
			logger.debug("delete Rollback");
		}
		return result;
	}
	
	//원료팀 메일발송
	private void sendMail(HashMap update_data) throws AddressException, MessagingException { 
		
		String host = "121.134.200.226"; 
		final String username = "software@ypzinc.co.kr"; 
		final String password = "wjstks12!@"; 
		int port=25;
		
		// 메일 내용
		String recipient = "resourceteam@ypzinc.co.kr"; //수신자
		String subject = "[시스템] 입항스케줄 내용이 변경되었습니다."; //메일 제목 
		//메일 내용 입력해주세요. 
		String body = "<Strong>입항스케줄 변경내용 (변경자 : "+update_data.get("USER_ID")+")</strong><br><br>"
					+ "업체 : "+update_data.get("VENDOR_NM")+"<br>"
					+ "광종 : "+update_data.get("ITEM_NM")+"<br>"
					+ "차수 : "+update_data.get("ORDER1")+"<br>"
					+ "입고차수 : "+update_data.get("ORDER2")+"<br>"
					+ "선박명 : "+update_data.get("SHIP_NM")+"<br>"
					+ "DMT : "+update_data.get("DMT")+"<br>"
					+ "Laycan : "+update_data.get("LAYCAN")+"<br>"
					+ "B/L <br>"
					+ "수령 : "+update_data.get("RECEIPT")+"<br>"
					+ "전달 : "+update_data.get("DELAY")+"<br>"
					+ "itinerary : "+update_data.get("ITINERARY")+"<br>"
					+ "BL입항일 : "+update_data.get("ARRIVAL_DATE")+"<br>"
					+ "실제입항일 : "+update_data.get("SHIP_DATE")+"<br>"
//						+ "실제하역일 : "+update_data.get("UNLOAD_DATE")+"<br>"
					+ "선사 : "+update_data.get("SHIP_VENDOR")+"<br>"
					+ "Surveyor : "+update_data.get("SURVEYOR")+"<br>"
					+ "지불조건 <br>"
					+ "T/T : "+update_data.get("TT")+"<br>"
					+ "L/C : "+update_data.get("LC")+"<br>"
					+ "조건 : "+update_data.get("CONDITION")+"<br>";
		
		Properties props = System.getProperties(); // 정보를 담기 위한 객체 생성 
		
		// SMTP 서버 정보 설정 
		props.put("mail.smtp.host", host); 
		props.put("mail.smtp.port", port); 
		props.put("mail.smtp.auth", "true"); 
		props.put("mail.smtp.ssl.enable", "false"); 
		props.put("mail.smtp.ssl.trust", host); 
		
		//Session 생성 
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() { 
			protected javax.mail.PasswordAuthentication getPasswordAuthentication() { 
				return new javax.mail.PasswordAuthentication(username, password); 
			} 
		}); 
		session.setDebug(false); //for debug 
		Message mimeMessage = new MimeMessage(session); //MimeMessage 생성 
		mimeMessage.setFrom(new InternetAddress("software@ypzinc.co.kr")); //발신자 셋팅
		mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); //수신자셋팅  .TO(수신) .CC(참조) .BCC(숨은참조)
		mimeMessage.setSubject(subject); //제목셋팅 
		mimeMessage.setContent(body, "text/html;charset=euc-kr"); //내용셋팅
		Transport.send(mimeMessage); //javax.mail.Transport.send() 이용
	}
	
	@Override
	public ArrayList<HashMap<String, String>> AssayList(HashMap paramMap) throws Exception {
		// TODO Auto-generated method stub
		return (ArrayList) query_mssql.selectList(NAMESPACE+"yp_zmm.AssayList_ms", paramMap);
	}
	
	@Transactional
	@Override
	public int createTypicalAssay(HashMap req_data) throws Exception{
		HashMap save_data = new HashMap();
		int result = 0;
		save_data.put("USER_ID", req_data.get("emp_code"));						//사번
		save_data.put("ITEM_CD", req_data.get("ITEM_CD"));						//광종코드* KEY
		save_data.put("RECEIPT_TYPE", (String)req_data.get("RECEIPT_TYPE"));	//입고차수* KEY
		save_data.put("RECEIPT_DATE",  StringUtils.replace((String)req_data.get("RECEIPT_DATE"),"/",""));//BL입항일(key값 구분위한 수정없는 데이터) KEY

		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("gridData").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("{}", jsonObj);
	       Iterator<String> keys = jsonObj.keySet().iterator(); 
	       while( keys.hasNext() ){
	    	   String key = keys.next(); 
	    	   if(!"$$hashKey".equals(key)) {
	    		   save_data.put("TEST_CD", key);
	    		   save_data.put("VALUE", jsonObj.get(key));
	    		   result += query_mssql.update(NAMESPACE+"yp_zmm.createTypicalAssay_ms", save_data);	//정광블렌딩 DB 반영(DB link 불가)
	    	   }
	       }
		}
		return result;
	}
	
	@Transactional
	@Override
	public int createInvoiceAssay(HashMap req_data) throws Exception{
		HashMap save_data = new HashMap();
		int result = 0;
		save_data.put("USER_ID", req_data.get("emp_code"));						//사번
		save_data.put("ITEM_CD", req_data.get("ITEM_CD"));						//광종코드* KEY
		save_data.put("RECEIPT_TYPE", (String)req_data.get("RECEIPT_TYPE"));	//입고차수* KEY
		save_data.put("RECEIPT_DATE",  StringUtils.replace((String)req_data.get("RECEIPT_DATE"),"/",""));//BL입항일(key값 구분위한 수정없는 데이터) KEY

		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("gridData").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("{}", jsonObj);

	       Iterator<String> keys = jsonObj.keySet().iterator(); 
	       while( keys.hasNext() ){
	    	   String key = keys.next(); 
	    	   if(!"$$hashKey".equals(key)) {
	    		   save_data.put("TEST_CD", key);
	    		   save_data.put("VALUE", jsonObj.get(key));
	    		   result += query_mssql.update(NAMESPACE+"yp_zmm.createInvoiceAssay_ms", save_data);	//정광블렌딩 DB 반영(DB link 불가)
	    	   }
	       }
		}
		return result;
	}
	
	
}
