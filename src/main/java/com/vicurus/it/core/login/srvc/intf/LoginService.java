package com.vicurus.it.core.login.srvc.intf;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface LoginService {
	@SuppressWarnings("rawtypes")
	public int ChkId(HttpServletRequest request, HttpServletResponse response) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public List ChkIdPwd(HttpServletRequest request, HttpServletResponse response) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public int LoginFail(HttpServletRequest request, HttpServletResponse response) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public void InitLoginFailCnt(Map map) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public Map CreateMenuByAuth(HttpServletRequest request, HttpServletResponse response) throws SQLException;

	@SuppressWarnings("rawtypes")
	public String CreateMenuByAuthOld(HttpServletRequest request, HttpServletResponse response) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public Map resetPassword(HttpServletRequest request, HttpServletResponse response) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public int insertSysLog_Login(HttpServletRequest request, HttpServletResponse response) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public int insertSysLog_Logout(HttpServletRequest request, HttpServletResponse response) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public void insertSysLog_Logout(HashMap map);
	
	@SuppressWarnings("rawtypes")
	public int selectCntSysLog_Login(HttpServletRequest request, HttpServletResponse response) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public List selectSysLog_Login_Last(HttpServletRequest request, HttpServletResponse response) throws SQLException;
	
	
	
	@SuppressWarnings("rawtypes")
	public void updateLogout_datetime(HttpServletRequest request);
	
	@SuppressWarnings("rawtypes")
	public void Scheduler_UserStatus_N();
}
