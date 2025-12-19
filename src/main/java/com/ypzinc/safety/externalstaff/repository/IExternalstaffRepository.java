package com.ypzinc.safety.externalstaff.repository;

import java.util.List;
import java.util.Map;

import com.ypzinc.safety.externalstaff.model.Externalstaff;

public interface IExternalstaffRepository {
	
		// 등록
		void insertExternalstaff(Externalstaff externalstaff);
		
		// 수정
		void modifyExternalstaff(Externalstaff externalstaff);
		
		// 전체 조회
		List<Externalstaff> selectExternalstaffList();
		
		// 검색 조회
		List<Externalstaff> selectExternalstaffSearch(Map<String, Object> map);
		
		// 삭제
		void removeByIds(List<String> externalstaffIds);

}
