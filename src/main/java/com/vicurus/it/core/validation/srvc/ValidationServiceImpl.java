package com.vicurus.it.core.validation.srvc;

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

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.vicurus.it.core.common.Util;
import com.vicurus.it.core.validation.srvc.intf.ValidationService;

@Repository
public class ValidationServiceImpl implements ValidationService{
	private static final Logger logger = LoggerFactory.getLogger(ValidationServiceImpl.class);
	
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
	public Integer LoginLockYNCheck(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		Util util = new Util();
		Map paramMap = util.getParamToMap(request);
		return query.selectOne(NAMESPACE+"biz_validation.LoginLockYNCheck", paramMap);
	}
	
	
}
