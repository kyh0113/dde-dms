package com.ypzinc.safety.empprocess.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ypzinc.safety.empprocess.model.EmpProcess;
import com.ypzinc.safety.empprocess.model.ProcessCode;
import com.ypzinc.safety.empprocess.repository.IEmpProcessRepository;
import com.ypzinc.safety.empprocess.service.IEmpProcessService;

@Service // ★ 이 어노테이션이 있어야 스프링이 서비스로 인식합니다!
public class EmpProcessService implements IEmpProcessService {

    @Autowired
    private IEmpProcessRepository empProcessRepository;

    // 1. 내부 직원 목록 조회
    @Override
    public List<EmpProcess> selectEmpProcessList(Map<String, Object> params) {
        return empProcessRepository.selectEmpProcessList(params);
    }

    // 2. 공정 저장
    @Override
    public void saveEmpProcess(EmpProcess empProcess) {
        empProcessRepository.saveEmpProcess(empProcess);
    }

    // 3. 공정 코드 목록 조회 (드롭다운용)
    @Override
    public List<ProcessCode> selectProcessCodeList() {
        return empProcessRepository.selectProcessCodeList();
    }
}