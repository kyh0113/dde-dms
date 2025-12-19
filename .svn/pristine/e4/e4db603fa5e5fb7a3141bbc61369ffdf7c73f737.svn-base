package com.vicurus.it.core.menu.srvc;

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
import org.springframework.transaction.annotation.Transactional;

import com.vicurus.it.core.common.Util;
import com.vicurus.it.core.menu.srvc.intf.MenuService;

@Repository
public class MenuServiceImpl implements MenuService {
	
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
	
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(MenuServiceImpl.class);
	
	
	@SuppressWarnings("rawtypes")
	@Override
	public List menuTree(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		return query.selectList(NAMESPACE+"Menu.menuTree", paramMap);
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List menuTree_sort(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		return query.selectList(NAMESPACE+"Menu.menuTree_sort", paramMap);
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List getMenuTree(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		return query.selectList(NAMESPACE+"Menu.getMenuTree", paramMap);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map insertTopMenu(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = query.insert(NAMESPACE+"Menu.insertTopMenu", paramMap);
		Map resultMap = new HashMap();
		resultMap.put("result", result);
		return resultMap;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Transactional
	@Override
	public Map insertSubMenu(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = query.insert(NAMESPACE+"Menu.insertSubMenu", paramMap);
		result += query.update(NAMESPACE+"Menu.updateParentMenu", paramMap);
		Map resultMap = new HashMap();
		resultMap.put("result", result);
		return resultMap;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map updateMenu(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = query.update(NAMESPACE+"Menu.updateMenu", paramMap);
		Map resultMap = new HashMap();
		resultMap.put("result", result);
		return resultMap;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map deleteMenu(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = query.delete(NAMESPACE+"Menu.deleteMenu", paramMap);
		if(result > 0){
			result += query.delete(NAMESPACE+"Menu.deleteChildMenu", paramMap);
		}
		Map resultMap = new HashMap();
		resultMap.put("result", result);
		return resultMap;
	}

	@Override
	public List selectRankFPView(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@SuppressWarnings({ "rawtypes" })
	@Override
	public List selectInsurerCodeView(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, false);
		return query.selectList(NAMESPACE+"Menu.selectInsurerCodeView", paramMap);
	}
	
	@SuppressWarnings({ "rawtypes" })
	@Override
	public List selectRank(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, false);
		return query.selectList(NAMESPACE+"Menu.selectRank", paramMap);
	}
	
	@SuppressWarnings({ "rawtypes" })
	@Override
	public List selectExpiredCar(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, false);
		return query.selectList(NAMESPACE+"Menu.selectExpiredCar", paramMap);
	}
	
	@SuppressWarnings({ "rawtypes" })
	@Override
	public List selectExpiredGeneral(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, false);
		return query.selectList(NAMESPACE+"Menu.selectExpiredGeneral", paramMap);
	}
	
	@SuppressWarnings({ "rawtypes" })
	@Override
	public List selectMyCRM(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, false);
		return query.selectList(NAMESPACE+"Menu.selectMyCRM", paramMap);
	}

	@Override
	public List selectCommonView(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List selectCarView(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List selectMyCustomerView(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
	
}
