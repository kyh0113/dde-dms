package com.vicurus.it.biz.user.srvc.intf;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface UserService {
	
	public List deptList(HttpServletRequest request, HttpServletResponse response); 
	
	public int userDeptModify(HttpServletRequest request, List paramList) throws Exception;
	
	public List authgrp_info(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public List apploval_type_info(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public Map userDetail(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public Map userDetailForSign(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public Map checkId(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public Map userPasswordReset(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
//	public Map userModify(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public Map userModify(final MultipartHttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public Map userPerInsert(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public Map userPerDelete(List paramList) throws Exception;
	
	public Map deptAdd(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public Map deptRemove(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public Map deptUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public Map approvalLineSave(Map paramMap) throws Exception;
	
	public Map approvalLineDelete(List paramList) throws Exception;
	
	public int allUserPwInit(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int allUserStatusUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
