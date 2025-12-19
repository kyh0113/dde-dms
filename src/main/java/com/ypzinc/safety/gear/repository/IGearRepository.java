package com.ypzinc.safety.gear.repository;

import com.ypzinc.safety.gear.model.Gear;
import java.util.*;

public interface IGearRepository {
	// 등록
	void insertGear(Gear gear);
	
	// 수정
	void modifyGear(Gear gear);
	
	// 전체 조회
	List<Gear> selectGearList();
	
	// 검색 조회
	List<Gear> selectGearSearch(Map<String, Object> map);
	
	// 삭제
	void removeByCodes(List<String> gearCodes);
}
