package com.ypzinc.safety.gear.service;

import com.ypzinc.safety.gear.model.Gear;
import java.util.*;

public interface IGearService {
	// 등록
	void registerGear(Gear gear);
	
	// 수정
	void updateGear(Gear gear);
	
	// 전체 조회
	List<Gear> getGearList();
	
	// 검색 조회
	List<Gear> getGearList(String type, String keyword);
	
	// 삭제
	void deleteByCodes(List<String> getCodes);
}
