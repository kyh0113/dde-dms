package com.yp.zwc.ent.srvc;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import com.yp.zwc.ent.srvc.intf.YP_ZWC_ENT_Service;

@Repository
public class YP_ZWC_ENT_ServiceImpl implements YP_ZWC_ENT_Service {

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

	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_ENT_ServiceImpl.class);

	@Override
	public int retrieveEntCnt(HashMap paramMap) throws Exception {
		// TODO Auto-generated method stub
		return query.selectOne(NAMESPACE+"yp_zwc_ent.retrieveEntCnt", paramMap);
	}
	
	@Override
	public ArrayList<HashMap<String, String>> enterpriseList(HashMap paramMap) throws Exception {
		// TODO Auto-generated method stub
		return (ArrayList)query.selectList(NAMESPACE+"yp_zwc_ent.enterpriseList", paramMap);
	}
	
	@SuppressWarnings({"unchecked", "rawtypes"})
	@Override
	@Transactional
	public int createEnt(HashMap paramMap) throws Exception {
		paramMap.put("SEQ", query.selectOne(NAMESPACE + "yp_zwc_mst.select_seq_working_master_v"));
		query.update(NAMESPACE+"Auth.createEnt2", paramMap);
		// 현재 협력업체 등록시 시스템 권한부여 하지 않음. 자동 매핑하려면 이 곳에서 쿼리 날리면 됨
		// oracle.Auth.insertAuthUser
		// auth_id : 권한코드( 아마 CC )
		// user_id : 업체코드( SAP_CODE )
		// 2022-01-21 jamerl - 협력업체 등록시 협력업체 권한 부여
		HashMap subParam = new HashMap();
		subParam.put("auth_id", "CC"); // 협력업체
		subParam.put("user_id", paramMap.get("ent_code"));
		subParam.put("s_emp_code", paramMap.get("s_emp_code"));
		query.insert(NAMESPACE+"Auth.insertAuthUser", subParam);
		
		return query.insert(NAMESPACE+"yp_zwc_ent.createEnt", paramMap);
	}
	
	@Override
	public int updateEnt(HashMap paramMap) throws Exception {
		query.update(NAMESPACE+"yp_zwc_ent.updateEnt2", paramMap);
		return query.update(NAMESPACE+"yp_zwc_ent.updateEnt", paramMap);
	}
	
	@Override
	public int updateEnt_reset_pwd(HashMap paramMap) throws Exception {
		return query.update(NAMESPACE+"yp_zwc_ent.updateEnt_reset_pwd", paramMap);
	}
	
	@Override
	public ArrayList<HashMap<String, String>> accesscontrolList(HashMap paramMap) throws Exception {
		// TODO Auto-generated method stub
		return (ArrayList)query.selectList(NAMESPACE+"yp_zwc_ent.accesscontrolList", paramMap);
	}

	@Override
	public ArrayList<HashMap<String, String>> enterpriseCodeList(HashMap paramMap) throws Exception {
		// TODO Auto-generated method stub
		return (ArrayList)query.selectList(NAMESPACE+"yp_zwc_ent.enterpriseCodeList", paramMap);
	}
	
	@Override
	public boolean retrieveSubcByCode(String subc_code) throws Exception{
		int chk = query.selectOne(NAMESPACE+"yp_zwc_ent.retrieveSubcByCode", subc_code);
		return chk == 0;
	}
	
	@Override
	@Transactional
	public int createAccessControl(HashMap<String, Object> req_data) throws Exception{
		int insert = 0;
		logger.debug("***"+req_data);
		//20201202_khj 조용래 대리 요청으로 자동채번 아닌 직접입력한 출입번호를 등록
		//String subc_code = createSubcCode(req_data);
		//req_data.put("subc_code", subc_code);
		insert = query.insert(NAMESPACE+"yp_zwc_ent.createSubcontract", req_data);
		logger.debug("%%%"+req_data.get("subc_code"));		
		return insert;
	}
	
	@Override
	public int noEntryCheck(HashMap<String, Object> req_data) throws Exception{
		int chk = 0; 
		chk = query.selectOne(NAMESPACE+"yp_zwc_ent.noEntryCheck", req_data);
		return chk;
	}
	
	@Override
	public String createSubcCode(HashMap<String, Object> req_data)throws Exception{
		logger.debug("createSubcCode.req_data="+req_data);
		String code = (String) req_data.get("ent_code");
		
		ArrayList<HashMap<String, String>> ent_info = (ArrayList)query.selectList(NAMESPACE+"yp_zwc_ent.retrieveEntDetail", code);
		HashMap<String, String> result = ent_info.get(0);
		logger.debug("##"+result);
		SimpleDateFormat simpleformat = new SimpleDateFormat ("yy");
		Date nowDate = new Date();
		String this_year = simpleformat.format(nowDate);
		
		//출입인원 코드 = 업체유형(D or J) + 업체코드 (00) + 등록연도 (0000) + 신청순서 (000)
		String subc_code = result.get("ENT_TYPE") + (String) req_data.get("ent_code") + this_year;
		logger.debug("createSubcCode.code="+subc_code);
		return subc_code;
	}
	
	@Override
	public ArrayList<HashMap<String, String>> accessControlDetail(String seq)throws Exception{
		return (ArrayList)query.selectList(NAMESPACE+"yp_zwc_ent.accessControlDetail", seq);
	}
	
	@Override
	@Transactional
	public int updateAccessControl(HashMap<String, Object> req_data) throws Exception{
		HashMap update_data = new HashMap();
		int insert = 0;
		insert = query.update(NAMESPACE+"yp_zwc_ent.updateAccessControl", req_data);	//출입인원 정보 수정
		
		//20201211_khj 출입번호 수정시 작업자맵핑 테이블도 변경된 출입번호로 수정
		if(!"".equals(req_data.get("subc_code_modify"))) {
			update_data.put("emp_code", req_data.get("emp_code"));				//변경자 사번	
			update_data.put("ORI_SUBC_CODE", req_data.get("ori_subc_code"));	//변경 전 출입번호	
			update_data.put("SUBC_CODE", req_data.get("subc_code"));			//변경 후 출입번호	
			insert += query.update(NAMESPACE+"yp_zwc_ent.updateWorkerMapping", update_data);	//변경된 출입번호로 작업자맵핑의 출입번호 수정
		}
		
		return insert;
	}
	
	@Override
	@Transactional
	public int deleteAccessControl(HashMap<String, Object> req_data) throws Exception{
		HashMap del_data = new HashMap();
		int result = 0;

		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("gridData").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("{}", jsonObj);
			del_data.put("SUBC_CODE", jsonObj.get("SUBC_CODE"));	//출입번호		
			result += query.delete(NAMESPACE+"yp_zwc_ent.deleteAccessControl", del_data);	//출입인원 삭제
			result += query.delete(NAMESPACE+"yp_zwc_ent.deleteWorkerMapping", del_data);	//작업자맵핑 삭제
		}

		return result;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List cb_ent_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return query.selectList( NAMESPACE + "yp_zwc_ent.cb_ent_list");
	}
}
