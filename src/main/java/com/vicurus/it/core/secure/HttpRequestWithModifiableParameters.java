package com.vicurus.it.core.secure;

import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

/**
 * 20191024_khj Wrapper 클래스 추가, 로그인폼에서 날아오는 암호화된 비밀번호를 복호화 후 request객체에 다시 담기 위함
 * 원래 존재하던 request의 key,value를 hashMap에 복사하고, 다시 request에 덮어씌운다 
 */

public class HttpRequestWithModifiableParameters extends HttpServletRequestWrapper 
{ 
	HashMap params; 
	
	/**
	 * @param request 
	 */ 
	public HttpRequestWithModifiableParameters(HttpServletRequest request) { 
		super(request); 
		this.params = new HashMap(request.getParameterMap()); 
	} 
	
	/* (non-Javadoc) * @see javax.servlet.ServletRequest#getParameter(java.lang.String) */ 
	public String getParameter(String name) { 
		String returnValue = null; 
		String[] paramArray = getParameterValues(name); 
		if (paramArray != null && paramArray.length > 0){ 
			returnValue = paramArray[0]; 
		}
		
		return returnValue; 
		
	} 
	
	/* (non-Javadoc) * @see javax.servlet.ServletRequest#getParameterMap() */ 
	public Map getParameterMap() { 
		return Collections.unmodifiableMap(params); 
	} 
	
	/* (non-Javadoc) * @see javax.servlet.ServletRequest#getParameterNames() */ 
	
	public Enumeration getParameterNames() { 
		return Collections.enumeration(params.keySet()); 
	} 
	
	/* (non-Javadoc) * @see javax.servlet.ServletRequest#getParameterValues(java.lang.String) */ 
	public String[] getParameterValues(String name) { 
		String[] result = null; 
		String[] temp = (String[])params.get(name); 
		if (temp != null){ 
			result = new String[temp.length]; 
			System.arraycopy(temp, 0, result, 0, temp.length); 
		} 
		
		return result; 
	} 
	
	/** Sets the a single value for the parameter. Overwrites any current values. 
	 * @param name Name of the parameter to set 
	 * @param value Value of the parameter. 
	 */ 
	public void setParameter(String name, String value){ 
		String[] oneParam = {value}; 
		setParameter(name, oneParam); 
	} 
	
	/** Sets multiple values for a parameter. 
	 * Overwrites any current values. 
	 * @param name Name of the parameter to set 
	 * @param values String[] of values. 
	 */ 
	public void setParameter(String name, String[] values){ 
		params.put(name, values); 
	} 
	
}

