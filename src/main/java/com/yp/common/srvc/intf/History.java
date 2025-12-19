package com.yp.common.srvc.intf;

import java.util.Map;

import org.json.simple.JSONObject;

public interface History {
	
	/**
	 * history 설정
	 * 
	 * dispatcher : 분별자 - 분기처리용
	 * state : C, U, D 판별
	 * obj : 데이터
	 */
	void setHistory(String dispatcher,String state, Object obj);
}
