package com.vicurus.it.core.validation.srvc.intf;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface ValidationService {
	
	public Integer LoginLockYNCheck(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
