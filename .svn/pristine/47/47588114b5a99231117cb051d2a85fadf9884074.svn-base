package com.yp.login.srvc.intf;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YPLoginService {
	/* 웹포털 > 왼쪽 메뉴 */
	@SuppressWarnings("rawtypes")
	public Map CreateMenuByAuth(HttpServletRequest request, HttpServletResponse response) throws SQLException;
	/* 웹포털 > 왼쪽 메뉴 */
	@SuppressWarnings("rawtypes")
	public Map select_breadcrumb(HttpServletRequest request, HttpServletResponse response) throws SQLException;
	/*
	 * 2022-06-21 smh 추가 
	 * 웹포털 > 왼쪽 메뉴 - 레벨 유동적 
	 */
	public List select_breadcrumb_hierarchy(HttpServletRequest request, HttpServletResponse response) throws SQLException;
	
	
	/* 웹포털 > 로그인 */
	public boolean loginCheckUser(String id, String pwd) throws Exception;
	public boolean loginCheckAff(String id, String pwd) throws Exception;
	public boolean loginCheckEnt(String id, String pwd) throws Exception;
	
	public boolean loginCheckEnt_reset(String id, String pwd) throws Exception;
	public int update_pwd_reset(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	@SuppressWarnings("rawtypes")
	public HashMap retrieveUserInfo(String loginId) throws Exception;
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap> retrieveUserAuth(String string) throws Exception;
	@SuppressWarnings("rawtypes")
	public ArrayList<HashMap> retrieveUserSysAuth(String string) throws Exception;
	@SuppressWarnings("rawtypes")
	public HashMap retrieveUserPosition(String loginId) throws Exception;
	@SuppressWarnings("rawtypes")
	public HashMap retrieveWorkInfo(String emp_cd) throws Exception;
	@SuppressWarnings("rawtypes")
	public HashMap retrieveEntCorp(String id) throws Exception;
	@SuppressWarnings("rawtypes")
	public HashMap retrieveAffCorp(String id) throws Exception;
	public int f_href_with_auth(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
