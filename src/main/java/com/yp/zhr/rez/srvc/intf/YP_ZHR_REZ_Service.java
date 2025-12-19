package com.yp.zhr.rez.srvc.intf;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YP_ZHR_REZ_Service {
	
	/* 3 인사관리 */
	/* 3.3.리조트예약 */
	/* 3.3.1. 리조트예약신청 */
	
	//리조트 예약등록
	public Map<String, Object> createResortReservReg(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public HashMap<String, Object> createResortReservReg_1(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//리조트 코드 리스트
	public ArrayList<HashMap<String, String>> resortCodeList(HashMap paramMap) throws Exception;
	
	//선호지역 코드 리스트
	public ArrayList<HashMap<String, String>> regionCodeList(HashMap paramMap) throws Exception;
	
	@SuppressWarnings("rawtypes")
	public int deleteResortRez(List paramList) throws Exception;
	
	public Map<String, Object> resortRefuseReg(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public HashMap<String, String> resortRezList(HashMap paramMap) throws Exception;
	
	//선호지역코드 삭제
	public int deleteRegionCode(List paramList) throws Exception;
	
	//리조트코드 삭제
	public int deleteResortCode(List paramList) throws Exception;
	
	//리조트코드 수정
	public int mergeResortCode(HashMap<String,Object> paramMap) throws Exception;
	
	//리조트코드 등록
	public int createResortCode(HashMap<String,Object> paramMap) throws Exception;
	
	//선호지역코드 수정
	public int mergeRegionCode(HashMap<String,Object> paramMap) throws Exception;
	
	//선호지역코드 등록
	public int createRegionCode(HashMap<String,Object> paramMap) throws Exception;
	
	//리조트 예약등록수정
	public Map<String, Object> updateResortReservReg(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//리조트 예약등록수정관리자
	public Map<String, Object> updateResortReservAdReg(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//리조트 파일 확인
	public Map<String, Object> resortRezFileYn() throws Exception;
	
	//리조트 파일 insert
	public int createResortFile(HashMap<String,Object> paramMap) throws SQLException;
	
	//리조트 파일 update
	public int updateResortFile(HashMap<String,Object> paramMap) throws SQLException;
	
	// 파일명 가져오기
	public String resortRezFileNm() throws Exception;
	
	
//	//도시락 신청등록
//	public HashMap<String, Object> createDosilakReg(HttpServletRequest request, HttpServletResponse response) throws Exception;
//	//도시락 신청취소
//	public HashMap<String, Object> deleteDosilakAppli(HttpServletRequest request, HttpServletResponse response) throws Exception;
//	
//	public List<Object> retrieveEmpWorkList(HashMap req_data) throws Exception;
//	
//	//도시락 집계등록
//	public HashMap<String, Object> updateDosilakOk(HttpServletRequest request, HttpServletResponse response) throws Exception;
//	//도시락 집계취소
//	public HashMap<String, Object> updateDosilakOkCancel(HttpServletRequest request, HttpServletResponse response) throws Exception;
//	
//	//식당 수기 등록
//	public HashMap<String, Object> createRestaurantReg(HttpServletRequest request, HttpServletResponse response) throws Exception;
}