package com.vicurus.it.biz.sample.srvc.intf;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface SampleService {

	public Map sample1Merge(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
}
