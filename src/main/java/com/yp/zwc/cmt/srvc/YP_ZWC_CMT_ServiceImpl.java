package com.yp.zwc.cmt.srvc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
import com.yp.zwc.cmt.srvc.intf.YP_ZWC_CMT_Service;

@Repository
public class YP_ZWC_CMT_ServiceImpl implements YP_ZWC_CMT_Service {

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

	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_CMT_ServiceImpl.class);

}
