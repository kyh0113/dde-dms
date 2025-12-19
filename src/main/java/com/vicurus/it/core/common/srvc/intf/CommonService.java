package com.vicurus.it.core.common.srvc.intf;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface CommonService {

	@SuppressWarnings("rawtypes")
	public String getActionKey();
	
	@SuppressWarnings("rawtypes")
	public void initActionLog(Map actionMap);
	
	@SuppressWarnings("rawtypes")
	public void finishActionLog(Map actionMap);
	
	@SuppressWarnings("rawtypes")
	public void sysActionLog(HttpServletRequest request);
	
	@SuppressWarnings("rawtypes")
	public void sysActionLog(Map map);
	
	@SuppressWarnings("rawtypes")
	public void finish(String error_yn);
	
}
