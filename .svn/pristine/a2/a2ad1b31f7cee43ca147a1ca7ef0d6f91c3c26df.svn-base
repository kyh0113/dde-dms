package com.vicurus.it.biz.sample.srvc;

import java.util.ArrayList;
import java.util.Collections;
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
import org.springframework.transaction.annotation.Transactional;

import com.vicurus.it.core.common.Util;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.vicurus.it.biz.sample.srvc.intf.SampleService;

@Repository
public class SampleServiceImpl implements SampleService{
	
	private static final Logger logger = LoggerFactory.getLogger(SampleServiceImpl.class);
	
	//config.properties 에서 설정 정보 가져오기 시작
	private static String NAMESPACE;
			
	@Value("#{config['db.vendor']}")
	public void setNAMESPACE(String value) {
		this.NAMESPACE = value + ".";
	}
	//config.properties 에서 설정 정보 가져오기 끝
	
	
	@Autowired
	@Resource(name="sqlSession")
	private SqlSession query;


	@Override
	@Transactional
	public Map sample1Merge(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request);

		int result = 0;
		String stringList = request.getParameter("stringList");
		ObjectMapper om = new ObjectMapper();
		List paramList = om.readValue(stringList, new TypeReference<List<Map>>(){});
		for(int i=0; i<paramList.size(); i++){
			Map tempMap = new HashMap();
			tempMap = (Map)paramList.get(i);
			tempMap.put("s_emp_code", paramMap.get("s_emp_code"));
			result += query.update(NAMESPACE+"biz_sample.sample1Merge",tempMap);                         
		}
		Map resultMap = new HashMap();
		resultMap.put("result",result);
		return resultMap;
	}

	
}
