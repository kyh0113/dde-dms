package com.ypzinc.safety.externalstaff.service;

import java.util.List;

import com.ypzinc.safety.externalstaff.model.Externalstaff;


public interface IExternalstaffService {
		// 등록
		void registerExternalstaff(Externalstaff externalstaff);
		
		// 수정
		void updateExternalstaff(Externalstaff externalstaff);
		
		// 전체 조회
		List<Externalstaff> getExternalstaffList();
		
		// 검색 조회
		List<Externalstaff> getExternalstaffList(String type, String keyword);
		
		// 삭제
		void deleteByIds(List<String> getIds);
}
