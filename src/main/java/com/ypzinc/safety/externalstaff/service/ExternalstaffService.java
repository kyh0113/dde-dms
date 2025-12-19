package com.ypzinc.safety.externalstaff.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ypzinc.safety.externalstaff.model.Externalstaff;
import com.ypzinc.safety.externalstaff.repository.IExternalstaffRepository;

@Service
public class ExternalstaffService implements IExternalstaffService {
	
	@Autowired
	private IExternalstaffRepository externalstaffRepository;

	@Override
	public void registerExternalstaff(Externalstaff externalstaff) {
		externalstaffRepository.insertExternalstaff(externalstaff);
	}

	@Override
	public void updateExternalstaff(Externalstaff externalstaff) {
		externalstaffRepository.modifyExternalstaff(externalstaff);
	}

	@Override
	public List<Externalstaff> getExternalstaffList() {
		return externalstaffRepository.selectExternalstaffList();
	}

	@Override
	public List<Externalstaff> getExternalstaffList(String type, String keyword) {
		// 검색어가 없거나 비어있으면 -> 그냥 전체 리스트 가져오기
		if (keyword == null || keyword.trim().equals("")) {
			return externalstaffRepository.selectExternalstaffList();
		}
		
		// 검색어가 있으면 -> 검색용 쿼리 실행
		Map<String, Object> map = new HashMap<>();
		map.put("searchType", type);
		map.put("keyword", keyword);
		
		return externalstaffRepository.selectExternalstaffSearch(map);
	}

	@Override
	@Transactional
	public void deleteByIds(List<String> getIds) {
		// 파라미터로 받은 getIds를 그대로 넘김
		if (getIds != null && !getIds.isEmpty()) {
			externalstaffRepository.removeByIds(getIds);
		}
	}
}
