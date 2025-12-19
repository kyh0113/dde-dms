package com.yp.test.srvc;

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

import com.vicurus.it.core.common.Util;
import com.yp.common.srvc.FixtureHistoryService;
import com.yp.fixture.srvc.intf.YPFixtureService;
import com.yp.test.srvc.intf.YPTestService;

@Repository
public class YPTestServiceImpl implements YPTestService {
	
	private static final Logger logger = LoggerFactory.getLogger(YPTestServiceImpl.class);

	// config.properties 에서 설정 정보 가져오기 시작
	private static String NAMESPACE;

	@Value("#{config['db.vendor']}")
	public void setNAMESPACE(String value) {
		this.NAMESPACE = value + ".";
	}
	// config.properties 에서 설정 정보 가져오기 끝

	@Autowired
	@Resource(name = "sqlSession")
	private SqlSession query;

	@Override
	public List<Object> select_daily_zinc_production(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Object> resultList = query.selectList(NAMESPACE + "yp_test.select_daily_zinc_production", null);
		logger.debug("resultList:{}",resultList);
		return resultList;
	}

}
