package com.yp.edoc.zpp.ore.srvc;

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
import com.yp.edoc.zpp.ore.srvc.intf.YPEdocService;
import com.yp.fixture.srvc.intf.YPFixtureService;
import com.yp.test.srvc.intf.YPTestService;

@Repository
public class YPEdocServiceImpl implements YPEdocService {
	
	private static final Logger logger = LoggerFactory.getLogger(YPEdocServiceImpl.class);

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
	public Map<String, Object> select_ore_edoc_info_single(HashMap paramMap) throws Exception {
		HashMap map = query.selectOne(NAMESPACE + "yp_edoc.select_ore_edoc_info_single", paramMap);
		return map;
	}

	@Override
	public Map<String, Object> select_ore_analysis_master(HashMap paramMap) throws Exception {
		HashMap map = query.selectOne(NAMESPACE + "yp_edoc.select_ore_analysis_master", paramMap);
		return map;
	}

	@Override
	public Map<String, Object> select_ore_component_analysis(HashMap paramMap) throws Exception {
		HashMap map = query.selectOne(NAMESPACE + "yp_edoc.select_ore_component_analysis", paramMap);
		return map;
	}

	@Override
	public int insert_ore_edoc_info(HashMap paramMap) throws Exception {
		int cnt = 0;
		cnt += query.update(NAMESPACE + "yp_edoc.zpp_ore_edoc_insert", paramMap);
		return cnt;
	}

	@Override
	public int update_ore_edoc_status(HashMap paramMap) throws Exception {
		int cnt = 0;
		cnt += query.update(NAMESPACE + "yp_edoc.zpp_ore_edoc_status_update", paramMap);
		return cnt;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public HashMap<String, String> zpp_ore_load_bl_edoc_info(HashMap paramMap) throws Exception {
		logger.debug("on zpp_ore_load_bl_edoc_info");
        logger.debug("@@"+paramMap);

        HashMap<String, String> result = query.selectOne(NAMESPACE+"yp_edoc.zpp_ore_load_bl_edoc_info", paramMap);
        logger.debug("{}", result.size());

        return result;
	}

	@Override
	public HashMap<String, String> zpp_ore_load_seller_query_edoc_info(HashMap paramMap) throws Exception {
		logger.debug("on zpp_ore_load_seller_query_edoc_info");
        logger.debug("@@"+paramMap);

        HashMap<String, String> result = query.selectOne(NAMESPACE+"yp_edoc.zpp_ore_load_seller_query_edoc_info", paramMap);
        logger.debug("{}", result.size());

        return result;
	}

	@Override
	public List<HashMap<String, Object>> zpp_ore_load_seller_compare_edoc_info(HashMap paramMap) throws Exception {
		logger.debug("on zpp_ore_load_seller_compare_edoc_info");
        logger.debug("@@"+paramMap);

        List result = query.selectList(NAMESPACE+"yp_edoc.zpp_ore_load_seller_compare_edoc_info", paramMap);
        logger.debug("{}", result.size());

        return result;
	}


}
