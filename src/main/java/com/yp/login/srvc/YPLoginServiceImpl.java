package com.yp.login.srvc;

import java.sql.SQLException;
import java.util.ArrayList;
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
import com.sap.conn.jco.util.Codecs.Hex;
import com.vicurus.it.core.common.Util;
import com.yp.login.srvc.intf.YPLoginService;
import com.yp.util.Base64Util;
import com.yp.util.HashUtil;

@Repository
public class YPLoginServiceImpl implements YPLoginService {

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

	private static final Logger logger = LoggerFactory.getLogger(YPLoginServiceImpl.class);

	/**
	 * 권한에 의한 메뉴 조회
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	public Map CreateMenuByAuth(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		Map returnMap = new HashMap();

		List menu = query.selectList(NAMESPACE + "Menu.getMenuList", paramMap);

//		paramMap.put("menu_path", request.getRequestURI());

//		List breadcrumb = query.selectList(NAMESPACE + "Menu.breadcrumb", paramMap);

		//logger.debug("hierarchy - {}", paramMap.get("hierarchy"));
		String hierarchy = paramMap.get("hierarchy") == null ? request.getAttribute("hierarchy").toString() : paramMap.get("hierarchy").toString();
		returnMap.put("hierarchy", hierarchy.split(";")[0]);
		
		returnMap.put("topmenu", menu);
		returnMap.put("leftmenu", menu);
		returnMap.put("submenu", menu);
		returnMap.put("submenu2", menu);
//		returnMap.put("breadcrumb", breadcrumb);
		return returnMap;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	public Map select_breadcrumb(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		paramMap.put("menu_path", request.getRequestURI());

		List breadcrumb = query.selectList(NAMESPACE + "Menu.breadcrumb", paramMap);
		
		Map returnMap = new HashMap();
		returnMap.put("breadcrumb", breadcrumb);
		
		return returnMap;
	}
	
	/*
	 * 2022-06-21 smh 추가 
	 * 웹포털 > 왼쪽 메뉴 - 레벨 유동적 
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	public List select_breadcrumb_hierarchy(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		paramMap.put("menu_path", request.getRequestURI());
		
		List beadCrumbList = new ArrayList<Map<String, Object>>();

		Map map = query.selectOne(NAMESPACE + "Menu.breadcrumbHierarchy", paramMap);
		String[] menuNames = map.get("path").toString().substring(1).split(";");
		paramMap.put("menu_path", null);
		for(String menuId : menuNames){
			paramMap.put("menu_id", menuId);
			beadCrumbList.add(query.selectOne(NAMESPACE + "Menu.breadcrumbHierarchy", paramMap));
		}
		
		return beadCrumbList;
	}

	@Override
	public boolean loginCheckUser(String id, String pwd) throws Exception {
		logger.debug("id : {}", id);
		logger.debug("pwd : {}", pwd);
		
		String hexPwd = Hex.encode(pwd.getBytes("utf-8"));
		logger.debug("hexPwd : {}", hexPwd);
		hexPwd = hexPwd.toLowerCase();
		logger.debug("pwd : {}", pwd);
		
		String sel_pw = query.selectOne(NAMESPACE + "yp_login.retrievePwdUser", id);
		logger.debug("sel_pw : {}", sel_pw);

		if(sel_pw == null) {
			return false;
		}
		
		String pwd_encrypt = HashUtil.getSHA256Str(HashUtil.getSHA256Str(HashUtil.getSHA256Str(Base64Util.decode(Base64Util.decode(Base64Util.decode(pwd))))));
		logger.debug("sel_pw = " + sel_pw);
		logger.debug("pwd_encrypt = " + pwd_encrypt);

		return hexPwd.equals(sel_pw);
	}

	@Override
	public boolean loginCheckAff(String id, String pwd) throws Exception {
		String sel_pw = query.selectOne(NAMESPACE + "yp_login.retrievePwdAff", id);

		if(sel_pw == null) {
			return false;
		}
		
		logger.debug("sel_pw = " + sel_pw);

		return pwd.equals(sel_pw);
	}

	@Override
	public boolean loginCheckEnt(String id, String pwd) throws Exception {
		String sel_pw = query.selectOne(NAMESPACE + "yp_login.retrievePwdEnt", id);

		if(sel_pw == null) {
			return false;
		}
		
		logger.debug("sel_pw = " + sel_pw);

		return pwd.equals(sel_pw);
	}
	
	@Override
	public boolean loginCheckEnt_reset(String id, String pwd) throws Exception {
		int cnt = query.selectOne(NAMESPACE + "yp_login.loginCheckEnt_reset", id);
		if(cnt == 1) {
			return true;
		}
		return false;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public int update_pwd_reset(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int rt = query.update(NAMESPACE + "yp_zwc_ent.update_pwd_reset", paramMap);
		return rt;
	}

	@SuppressWarnings({"rawtypes"})
	@Override
	public HashMap retrieveUserInfo(String loginId) throws Exception {
		HashMap result = new HashMap();
		result = query.selectOne(NAMESPACE + "yp_login.retrieveUserInfo", loginId);
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	public ArrayList<HashMap> retrieveUserAuth(String string) throws Exception {
		ArrayList result = new ArrayList<HashMap>();
		result = (ArrayList) query.selectList(NAMESPACE + "yp_login.retrieveUserAuth", string);
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	public ArrayList<HashMap> retrieveUserSysAuth(String string) throws Exception {
		ArrayList result = new ArrayList<HashMap>();
		result = (ArrayList) query.selectList(NAMESPACE + "yp_login.retrieveUserSysAuth", string);
		return result;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public HashMap retrieveUserPosition(String loginId) throws Exception {
		HashMap result = new HashMap();
		result = query.selectOne(NAMESPACE + "yp_login.retrieveUserPosition", loginId);
		return result;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public HashMap retrieveWorkInfo(String emp_cd) throws Exception {
		HashMap result = new HashMap();
		result = query.selectOne(NAMESPACE + "yp_login.retrieveWorkInfo", emp_cd);
		return result;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public HashMap retrieveEntCorp(String id) throws Exception{
		return query.selectOne(NAMESPACE + "yp_login.retrieveEntCorp",id);
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public HashMap retrieveAffCorp(String id) throws Exception{
		return query.selectOne(NAMESPACE + "yp_login.retrieveAffCorp",id);
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public int f_href_with_auth(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = query.selectOne(NAMESPACE + "yp_login.f_href_with_auth", paramMap);
		return result;
	}
}
