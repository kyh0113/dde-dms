package com.yp.util;

import java.util.Enumeration;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;


public class RequestMapUtil {
	
	public HashMap<String, Object> getParameterMap(HttpServletRequest request){

		HashMap parameterMap = new HashMap();
		Enumeration enums = request.getParameterNames();
		
		while(enums.hasMoreElements()){
			String paramName = (String)enums.nextElement();
			String[] parameters = request.getParameterValues(paramName);
	
			if(parameters.length > 1){ // Parameter�� �迭�� ���
				parameterMap.put(paramName, parameters);
			}else{ // Parameter�� �迭�� �ƴ� ���
				parameterMap.put(paramName, parameters[0]);
			}
		}

		return parameterMap;
	}

}
