package com.vicurus.it.core.common.srvc;

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
import org.springframework.transaction.annotation.Transactional;

import com.vicurus.it.core.common.Util;
import com.vicurus.it.core.common.srvc.intf.CommonService;
import com.vicurus.it.core.secure.HttpRequestWithModifiableParameters;
import com.vicurus.it.core.secure.PasswordEncoding;
import com.vicurus.it.core.secure.SHAPasswordEncoder;


@Repository
public class CommonServiceImpl implements CommonService {

	//config.properties 에서 설정 정보 가져오기 시작
	private static String NAMESPACE;
	
	@Value("${db.vendor}")
	public void setNAMESPACE(String value) {
		this.NAMESPACE = value + ".";
	}
	//config.properties 에서 설정 정보 가져오기 끝
	
	@Autowired
	@Resource(name="sqlSession")
	private SqlSession query;

	
	private static final Logger logger = LoggerFactory.getLogger(CommonServiceImpl.class);
	
	public String ACTION_KEY = "NOT ACTION KEY";
	public String ERROR_YN = "N";
	
	
	Util util = new Util();
	
	
	@Override
	public String getActionKey() {
		// TODO Auto-generated method stub
		return query.selectOne(NAMESPACE+"Common.getActionKey");
	}

	@Override
	public void initActionLog(Map actionMap) {
		// TODO Auto-generated method stub
		query.insert(NAMESPACE+"Common.initActionLog", actionMap);
	}
	
	@Override
	public void finishActionLog(Map actionMap) {
		// TODO Auto-generated method stub
		query.update(NAMESPACE+"Common.finishActionLog", actionMap);
	}
	
	@Override
    public void sysActionLog(HttpServletRequest request) {

    	String id = getActionKey();
    	this.ACTION_KEY = request.getSession().getId() + "_" + id;
    	Map actionMap = new HashMap();
    	actionMap.put("id", this.ACTION_KEY);

    	if(request.getRequestURI().equals("/uiGridLoad")) {
    		actionMap.put("url", request.getRequestURI() + ":" +request.getParameter("listQuery"));
    	}else {
    		actionMap.put("url", request.getRequestURI());
    	}
    		
    	actionMap.put("ip", util.getIp(request));
    		
    	if((String) request.getSession().getAttribute("s_emp_code") == null){
			actionMap.put("user_id","NOT LOGIN");
		}else{
			actionMap.put("user_id", (String) request.getSession().getAttribute("s_emp_code"));
		}
    		
    	initActionLog(actionMap);
    }
	
	@Override
    public void sysActionLog(Map map) {
		//sessionOut Action Logging
    	String id = getActionKey();
    	this.ACTION_KEY = map.get("s_id") + "_" + id;
    	Map actionMap = new HashMap();
    	actionMap.put("id", this.ACTION_KEY);
    	actionMap.put("url", "SESSION OUT");
    	actionMap.put("ip", map.get("ip"));
    		
    	if((String) map.get("s_emp_code") == null){
			actionMap.put("user_id","NOT LOGIN");
		}else{
			actionMap.put("user_id", (String) map.get("s_emp_code"));
		}
    		
    	initActionLog(actionMap);
    }
    
	@Override
    public void finish(String error_yn) {
		try{

				if(!this.ACTION_KEY.equals("NOT ACTION KEY")) {
					Map actionMap = new HashMap();
					actionMap.put("id", this.ACTION_KEY);
					this.ERROR_YN = error_yn;
					actionMap.put("error_yn", this.ERROR_YN);
					finishActionLog(actionMap);
				}
			
		}catch(Exception e){
			System.out.println(e.toString());
		}
	}
    
}
