package com.vicurus.it.core.common;

import java.util.concurrent.ConcurrentHashMap;

public final class SessionList {

	private static ConcurrentHashMap<String, String> loginUserInfo = new ConcurrentHashMap<>();
	
	public static synchronized ConcurrentHashMap<String, String> getHashMap(){
		return loginUserInfo;
	}
	
	public static synchronized void sethashMap(ConcurrentHashMap<String, String> target) {
		loginUserInfo = target;
	}
	
	
}
