package com.yp.zwc.cct.srvc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.vicurus.it.core.common.Util;
import com.yp.zwc.cct.srvc.intf.YP_ZWC_CCT_Service;

@Repository
public class YP_ZWC_CCT_ServiceImpl implements YP_ZWC_CCT_Service {

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

	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_CCT_ServiceImpl.class);

	@SuppressWarnings({"unchecked", "rawtypes"})
	@Transactional
	@Override
	public ArrayList<HashMap<String, String>> zwc_cct_select(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMapWithNull(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		return (ArrayList) query.selectList(NAMESPACE+"yp_zwc_cct.select_zwc_cct_combined_cost", paramMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	public int zwc_cct_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map req_data = util.getParamToMapWithNull(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		req_data.put("emp_cd", (String) session.getAttribute("empCode"));//등록자 사번
		logger.debug("req_data:{}",req_data);
		
		//이미 데이터가 존재하는지 판별하기
		//cnt(0: 데이터 존재하지 않음, 1이상 : 데이터 이미 존재)
		int cnt = query.selectOne(NAMESPACE+"yp_zwc_cct.select_zwc_cct_combined_cost_cnt", req_data);
		logger.debug("cnt:"+cnt);
		
		int result = 0;
		//데이터가 이미 존재할 경우
		if(cnt > 0) {
			result = query.update(NAMESPACE+"yp_zwc_cct.update_zwc_cct_combined_cost", req_data);
		//데이터가 아직 존재하지 않을 경우
		}else {
			result = query.insert(NAMESPACE+"yp_zwc_cct.insert_zwc_cct_combined_cost", req_data);
		}
		
		return result;
	}
	
}
