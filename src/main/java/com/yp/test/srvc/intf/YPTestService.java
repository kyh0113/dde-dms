package com.yp.test.srvc.intf;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YPTestService {
	public List<Object> select_daily_zinc_production (HttpServletRequest request, HttpServletResponse response) throws Exception;
}
