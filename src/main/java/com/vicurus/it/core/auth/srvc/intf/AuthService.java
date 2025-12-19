package com.vicurus.it.core.auth.srvc.intf;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface AuthService {
	
	
	public Map mergeAuth(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int authUserMenu_save(List paramList, HttpServletRequest request) throws Exception;
	
	public int deleteAuth(List paramList) throws Exception;
	
	public int mappingUserAuth(List paramList) throws Exception;
	@SuppressWarnings("rawtypes")
	public int mappingUserDataAuth(List paramList) throws Exception;
}
