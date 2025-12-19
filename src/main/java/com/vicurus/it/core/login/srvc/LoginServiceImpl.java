package com.vicurus.it.core.login.srvc;

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
import org.springframework.stereotype.Service;

import com.vicurus.it.core.common.Util;
import com.vicurus.it.core.login.srvc.intf.LoginService;
import com.vicurus.it.core.secure.HttpRequestWithModifiableParameters;
import com.vicurus.it.core.secure.PasswordEncoding;
import com.vicurus.it.core.secure.SHAPasswordEncoder;


@Repository
public class LoginServiceImpl implements LoginService {

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
	

	
	private static final Logger logger = LoggerFactory.getLogger(LoginServiceImpl.class);
	
	@SuppressWarnings("rawtypes")
	@Override
	public int ChkId(HttpServletRequest request, HttpServletResponse response) throws SQLException { //ICM 사용 - 20180809 하태현
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		return query.selectOne(NAMESPACE+"Login.ChkId", paramMap);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List ChkIdPwd(HttpServletRequest request, HttpServletResponse response) throws SQLException { //ICM 사용 - 20180809 하태현
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		return query.selectList(NAMESPACE+"Login.ChkIdPwd", paramMap);
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public int LoginFail(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		int login_fail_cnt = 0;
		int result = query.update(NAMESPACE+"Login.LoginFail", paramMap);			//로그인실패카운트 증가 및 유저테이블에 로그인실패한 일시를 Louout_datetime에 기록한다
		if(result > 0){
			login_fail_cnt =  query.selectOne(NAMESPACE+"Login.GetLoginFailCnt", paramMap);	//로그인실패카운트 가져오기
		}
		
		return login_fail_cnt;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public void InitLoginFailCnt(Map paramMap) throws SQLException {
		query.update(NAMESPACE+"Login.InitLoginFailCnt", paramMap);	//로그인실패카운트 초기화
	}
	
	
	/**
	 * 권한에 의한 메뉴 조회
	 */
	@SuppressWarnings({ "rawtypes" })
	@Override
	public Map CreateMenuByAuth(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		Map returnMap = new HashMap();

		List menu = query.selectList(NAMESPACE+"Menu.getMenuList",paramMap);

		paramMap.put("menu_path",request.getRequestURI());

		List breadcrumb = query.selectList(NAMESPACE+"Menu.breadcrumb", paramMap);

		returnMap.put("topmenu", menu);
		returnMap.put("leftmenu", menu);
		returnMap.put("submenu", menu);
		returnMap.put("submenu2", menu);
		returnMap.put("breadcrumb", breadcrumb);
		return returnMap;
	}
	
	/**
	 * 권한에 의한 메뉴 조회
	 */
	@SuppressWarnings({ "rawtypes" })
	@Override
	public String CreateMenuByAuthOld(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		StringBuffer sb = new StringBuffer();
		List returnList = new ArrayList();
		
		returnList = query.selectList(NAMESPACE+"Login.CreateMenuByAuth", paramMap);
		
		for(int i = 0; i < returnList.size(); i++){
			HashMap rowMap = (HashMap) returnList.get(i);
			String menu_name = rowMap.get("MENU_TITLE").toString();
			String menu_url = rowMap.get("MENU_URL").toString();
			String menu_hierarchy = rowMap.get("HIERARCHY").toString();
			String next_hierarchy = "";
			boolean last_yn = false;
			int level = Integer.parseInt(rowMap.get("MENU_LEVEL").toString());
			int next_level = -1; // 맨마지막은 -1 이 된다.
			
			if(i != returnList.size()-1 ){
				HashMap nextRowMap = (HashMap)returnList.get(i+1);
				next_level = Integer.parseInt(nextRowMap.get("MENU_LEVEL").toString());
				next_hierarchy = nextRowMap.get("HIERARCHY").toString();
				if(next_hierarchy.indexOf(menu_hierarchy) > -1){
					last_yn = true;
				}
			}
//			Object[] obj = {"","","", false, 0, 0};
//			obj[0] = menu_name;
//			obj[1] = menu_hierarchy;
//			obj[2] = next_hierarchy;
//			obj[3] = last_yn;
//			obj[0] = next_level;
//			obj[1] = level;
//			obj[2] = menu_name;
			
//			logger.debug("{}, {} - {}, {}, 다음레벨{} 비교 레벨{}", obj);
//			logger.debug("다음레벨 [{}] VS 레벨 [{}] - 메뉴명[{}]", obj);
			
			if(level == 0){	//탑메뉴
				if(last_yn){	//탑메뉴 && 하위폴더 O
//					sb.append("<li class='ui-widget-header'>").append(menu_name).append("</li><!--탑메뉴 닫기-->\n");
					sb.append("<li class='dropdown'><a class='dropdown-toggle' data-toggle='dropdown' data-hover='dropdown' href='#'>").append(menu_name).append(" <b class='caret'></b></a>");
				}else{	//탑메뉴 && 하위폴더 X
//					sb.append("<li class='ui-widget-header'>").append(menu_name).append("</li><!--탑메뉴닫기-->\n");
					sb.append("<li class='dropdown'><a class='dropdown-toggle' data-toggle='dropdown' data-hover='dropdown' href='").append(menu_url).append("'>").append(menu_name).append("</a></li>");
				}
				
				if(next_level != -1 && next_level > level){	//다음행 O && 다음행 최상위 X
//					sb.append("<ul>\n");
					sb.append("<ul class='dropdown-menu'>");
				}
			}else{
				if(last_yn){	//하위폴더 O
//					sb.append("<li class='notHeader'>").append(menu_name);
					sb.append("<li class='dropdown-submenu'><a tabindex='-1' href='#'>").append(menu_name).append("</a>");
				}else{
//					sb.append("<li class='notHeader' vicId='menu' link='").append(menu_url).append("'>").append(menu_name);
					sb.append("<li><a tabindex='-1' href='").append(menu_url).append("'>").append(menu_name).append("</a>");
				}
				
				if(next_level != -1 && next_level > level){	//다음행 O && 하위메뉴 O
//					sb.append("<ul class='dropdown-menu'>\n");
					sb.append("<ul class='dropdown-menu'>");
				}else if(next_level != -1 && next_level < level){	//다음행 O && 메뉴그룹의 마지막메뉴
//					sb.append("</li></ul><!--1 닫기-->\n");
					sb.append("</li></ul>");
					if(next_level == 0){
						if(level != 1){
//							sb.append("</li></ul></li><!--2 닫기-->\n");
							sb.append("</li>");
							for(int loop = 1; loop < level; loop++){
								sb.append("</ul></li>");
							}
						}else{
							sb.append("</li>");
						}
					}else{
						sb.append("</li>");
					}
				}else if(next_level != -1 && next_level == level){	// 같은 메뉴그룹 && 같은 메뉴레벨
//					sb.append("</li><!--3 닫기-->\n");
					sb.append("</li>");
				}
				if(next_level == -1){
//					sb.append("</li><!--4 닫기-->\n");
					sb.append("</li>");
					if(level != 1){
						for(int k = 0 ; k < level ; k++){
//							sb.append("</ul>\n</li><!--5 닫기-->\n");
							sb.append("</ul></li>");
						}
					}else{
//						sb.append("</ul>\n</li><!--6 닫기-->\n");
						sb.append("</ul></li>");
					}
				}
			}
		}	//END for문
		logger.debug("\n"+sb.toString());
		return sb.toString();
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public int insertSysLog_Login(HttpServletRequest request, HttpServletResponse response) throws SQLException { //ICM 사용 - 20180809 하태현
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);
		return query.insert(NAMESPACE+"Common.insertSysLog_Login", paramMap);
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public int insertSysLog_Logout(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);
		int result = 0;
		result += query.insert(NAMESPACE+"Common.insertSysLog_Logout", paramMap);
		result += query.update(NAMESPACE+"Common.updateLogout_datetime", paramMap);
		return result;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public void insertSysLog_Logout(HashMap map) {
		query.insert(NAMESPACE+"Common.insertSysLog_Logout", map);
		query.update(NAMESPACE+"Common.updateLogout_datetime", map);
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public Map resetPassword(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request);
		
		int result = query.update(NAMESPACE+"Login.resetPassword",paramMap);
		Map resultMap = new HashMap();
		resultMap.put("result", result);
		return resultMap;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public void updateLogout_datetime(HttpServletRequest request) {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request);
		query.insert(NAMESPACE+"Common.updateLogout_datetime", paramMap);
	}
	
	
	@SuppressWarnings("rawtypes")
	@Override
	public void Scheduler_UserStatus_N() {
		query.insert(NAMESPACE+"Common.Scheduler_UserStatus_N");
	}

	@Override
	public int selectCntSysLog_Login(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);
		return query.selectOne(NAMESPACE+"Common.selectCntSysLog_Login", paramMap);
	}

	@Override
	public List selectSysLog_Login_Last(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);
		
		return query.selectList(NAMESPACE+"Common.selectSysLog_Login_Last", paramMap);
	}
}
