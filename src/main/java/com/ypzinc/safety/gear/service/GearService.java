package com.ypzinc.safety.gear.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ypzinc.safety.gear.model.Gear;
import com.ypzinc.safety.gear.repository.IGearRepository;

@Service
public class GearService implements IGearService{
	
	@Autowired
	private IGearRepository gearRepository; // 
	
	@Override
	public void registerGear(Gear gear) {
		gearRepository.insertGear(gear);
		
	}

	@Override
	public List<Gear> getGearList() {
		return gearRepository.selectGearList();
	}

	@Override
	@Transactional
	public void deleteByCodes(List<String> gearCodes) {
		if(gearCodes != null && !gearCodes.isEmpty()){
			gearRepository.removeByCodes(gearCodes);
		}
	}

	@Override
    public void updateGear(Gear gear) {
        gearRepository.modifyGear(gear);
    }

	@Override
	public List<Gear> getGearList(String searchType, String keyword) {
	    // 검색어가 없거나 비어있으면 -> 그냥 전체 리스트 가져오기
	    if (keyword == null || keyword.trim().equals("")) {
	        return gearRepository.selectGearList();
	    }
	    
	    // 검색어가 있으면 -> 검색용 쿼리 실행
	    Map<String, Object> map = new HashMap<>();
	    map.put("searchType", searchType);
	    map.put("keyword", keyword);
	    
	    return gearRepository.selectGearSearch(map);
	}


}
