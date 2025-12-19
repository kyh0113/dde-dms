package com.yp.zwc.eai.srvc;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import com.vicurus.it.core.common.Util;
import com.yp.zwc.eai.srvc.intf.YP_ZWC_EAI_Service;

@Repository
public class YP_ZWC_EAI_ServiceImpl implements YP_ZWC_EAI_Service {
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
	
	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_EAI_ServiceImpl.class);
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public List<HashMap<String, Object>> working_monthly_report(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		// 테스트
//		paramMap.put("BASE_YYYY", "2020");
//		paramMap.put("DEPT_CODE", "12345678");
		
		return query.selectList(NAMESPACE + "yp_zwc_eai.working_monthly_report", paramMap);
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public List<HashMap<String, Object>> working_subc_pst_adj(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		// 테스트
//		paramMap.put("BASE_YYYY", "2020");
//		paramMap.put("DEPT_CODE", "12345678");
		
		return query.selectList(NAMESPACE + "yp_zwc_eai.working_subc_pst_adj", paramMap);
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public List<HashMap<String, Object>> working_subc_cost_count(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		// 테스트
//		paramMap.put("BASE_YYYY", "2020");
//		paramMap.put("DEPT_CODE", "12345678");
		
		return query.selectList(NAMESPACE + "yp_zwc_eai.working_subc_cost_count", paramMap);
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public List<HashMap<String, Object>> working_reto_cost_count(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		// 테스트
//		paramMap.put("BASE_YYYY", "2020");
//		paramMap.put("DEPT_CODE", "12345678");
		
		return query.selectList(NAMESPACE + "yp_zwc_eai.working_reto_cost_count", paramMap);
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public List<HashMap<String, Object>> construction_chk_rpt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		// 테스트
//		paramMap.put("BASE_YYYY", "2020");
//		paramMap.put("DEPT_CODE", "12345678");
		
		return query.selectList(NAMESPACE + "yp_zwc_eai.construction_chk_rpt", paramMap);
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public int working_eai_status(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> parseMap = new HashMap<String, Object>();
		int result = 0;
		String[] paeseStr = null;
		
		logger.debug("상태값 변경 대상 - {}", paramMap.get("FORM_ID"));
		
		if("EF160326495662695".equals(paramMap.get("FORM_ID"))) { // 도급월보
			// 업데이트 조건식 파라미터 파싱 - 딜리미터 : ;
			paeseStr = paramMap.get("PKSTR").toString().split(";");
			
			parseMap.put("BASE_YYYY", paeseStr[0]);
			parseMap.put("DEPT_CODE", paeseStr[1]);
			parseMap.put("DOC_NO", paramMap.get("DOC_NO"));
			parseMap.put("FORM_ID", paramMap.get("FORM_ID"));
			parseMap.put("GW_ID", paramMap.get("GW_ID"));
			parseMap.put("DOC_STATUS", paramMap.get("DOC_STATUS"));
			parseMap.put("DATE", paramMap.get("DATE"));
			
			result = query.update(NAMESPACE + "yp_zwc_eai.working_monthly_report_status", parseMap);
		}else if("EF160393522503521".equals(paramMap.get("FORM_ID"))) { // 도급비조정안
			parseMap.put("BASE_YYYY", paramMap.get("PKSTR"));
			parseMap.put("DOC_NO", paramMap.get("DOC_NO"));
			parseMap.put("FORM_ID", paramMap.get("FORM_ID"));
			parseMap.put("GW_ID", paramMap.get("GW_ID"));
			parseMap.put("DOC_STATUS", paramMap.get("DOC_STATUS"));
			parseMap.put("DATE", paramMap.get("DATE"));
			
			result = query.update(NAMESPACE + "yp_zwc_eai.working_subc_pst_adj_status", parseMap);
		}else if("EF160393526682558".equals(paramMap.get("FORM_ID"))) { // 도급비집계
			// 업데이트 조건식 파라미터 파싱 - 딜리미터 : ;
			paeseStr = paramMap.get("PKSTR").toString().split(";");
			
			parseMap.put("CHECK_YYYYMM", paeseStr[0]);
			parseMap.put("GUBUN_CODE", paeseStr[1]);
			parseMap.put("DOC_NO", paramMap.get("DOC_NO"));
			parseMap.put("FORM_ID", paramMap.get("FORM_ID"));
			parseMap.put("GW_ID", paramMap.get("GW_ID"));
			parseMap.put("DOC_STATUS", paramMap.get("DOC_STATUS"));
			parseMap.put("DATE", paramMap.get("DATE"));
			
			result = query.update(NAMESPACE + "yp_zwc_eai.working_subc_cost_count_status", parseMap);
		}else if("EF160393533676302".equals(paramMap.get("FORM_ID"))) { // 소급비집계
			// 업데이트 조건식 파라미터 파싱 - 딜리미터 : ;
			paeseStr = paramMap.get("PKSTR").toString().split(";");
			
			parseMap.put("CHECK_YYYY", paeseStr[0]);
			parseMap.put("GUBUN_CODE", paeseStr[1]);
			parseMap.put("DOC_NO", paramMap.get("DOC_NO"));
			parseMap.put("FORM_ID", paramMap.get("FORM_ID"));
			parseMap.put("GW_ID", paramMap.get("GW_ID"));
			parseMap.put("DOC_STATUS", paramMap.get("DOC_STATUS"));
			parseMap.put("DATE", paramMap.get("DATE"));
			
			result = query.update(NAMESPACE + "yp_zwc_eai.working_reto_cost_count_status", parseMap);
		}else if("EF160490866259885".equals(paramMap.get("FORM_ID"))) { // 정비용역 검수보고서 - EF160611673164688
			// 업데이트 조건식 파라미터 파싱 - 딜리미터 : ;
			paeseStr = paramMap.get("PKSTR").toString().split(";");
			
			parseMap.put("REPORT_CODE", paeseStr[1]);
			parseMap.put("DOC_NO", paramMap.get("DOC_NO"));
			parseMap.put("FORM_ID", paramMap.get("FORM_ID"));
			parseMap.put("GW_ID", paramMap.get("GW_ID"));
			parseMap.put("DOC_STATUS", paramMap.get("DOC_STATUS"));
			parseMap.put("DATE", paramMap.get("DATE"));
			
			result = query.update(NAMESPACE + "yp_zwc_eai.construction_chk_rpt_status", parseMap);
		}
		
		return result;
	}
	
	@Override
	public List wsd_edoc_write(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		logger.debug("@@"+paramMap);
		return query.selectList(NAMESPACE + "yp_zwc_eai.wsd_edoc_write", paramMap);
	}
	
	@Override
	public int working_eai_log(HashMap<String, Object> finalMap) throws Exception {
		int result = 0;
		
		result = query.insert(NAMESPACE + "yp_zwc_eai.working_eai_log", finalMap);
		
		return result;
	}
}
