package com.vicurus.it.core.auth.srvc;

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

import com.vicurus.it.core.auth.srvc.intf.AuthService;
import com.vicurus.it.core.common.Util;

@Repository
public class AuthServiceImpl implements AuthService {
	
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(AuthServiceImpl.class);
	
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
	public Map mergeAuth(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = query.update(NAMESPACE+"Auth.mergeAuth", paramMap);
		Map resultMap = new HashMap();
		resultMap.put("result", result);
		return resultMap;
	}
	
	@Override
	public int authUserMenu_save(List paramList, HttpServletRequest request) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		int paramListSize = paramList.size();
		int result = 0;
		result = query.delete(NAMESPACE+"Auth.deleteAuthMenu", paramList.get(0));

		for(int i = 0; i < paramListSize; i++){
			Map tempMap = (Map)paramList.get(i);
			tempMap.put("s_emp_code", paramMap.get("s_emp_code"));
			if("Y".equals(tempMap.get("use_yn"))) {
				result += query.insert(NAMESPACE+"Auth.insertAuthMenu",tempMap);
			}else {
				result = result + 1;
			}
		}
		
		return result;
	}
	
	@Override
	public int deleteAuth(List paramList) throws Exception {
		int paramListSize = paramList.size();
		int result = 0;
		for(int i = 0; i < paramListSize; i++){
			result += query.delete(NAMESPACE+"Auth.deleteAuth", paramList.get(i));
			result += query.delete(NAMESPACE+"Auth.deleteAuth_menu", paramList.get(i));
			result += query.delete(NAMESPACE+"Auth.deleteAuth_user", paramList.get(i));
		}
		return result;
	}
	
	@Override
	public int mappingUserAuth(List paramList) throws Exception {
		int paramListSize = paramList.size();
		int result = 0;
		result += query.delete(NAMESPACE+"Auth.deleteAuthUser", paramList.get(0));		//사용자별 권한테이블 삭제
		for(int i = 0; i < paramListSize; i++){
			result += query.insert(NAMESPACE+"Auth.insertAuthUser", paramList.get(i));	//변경된 권한으로 삽입
			result += query.insert(NAMESPACE+"Auth.insertAuthUser_history", paramList.get(i));	//권한변경 이력쌓기
			result += query.update(NAMESPACE+"Auth.updateAuthUser", paramList.get(i));	//사용자테이블에 권한수정
		}
		
		return result;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public int mappingUserDataAuth(List paramList) throws Exception {
		int paramListSize = paramList.size();
		int result = 0;
		result += query.delete(NAMESPACE+"Auth.deleteDataAuthUser", paramList.get(0));		//사용자별 권한테이블 삭제
		for(int i = 0; i < paramListSize; i++){
			result += query.insert(NAMESPACE+"Auth.insertDataAuthUser", paramList.get(i));	//변경된 권한으로 삽입
			result += query.insert(NAMESPACE+"Auth.insertDataAuthUser_history", paramList.get(i));	//권한변경 이력쌓기
		}
		
		return result;
	}
	
}