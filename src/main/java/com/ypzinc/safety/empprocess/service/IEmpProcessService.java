package com.ypzinc.safety.empprocess.service;

import java.util.List;
import java.util.Map;
import com.ypzinc.safety.empprocess.model.EmpProcess;
import com.ypzinc.safety.empprocess.model.ProcessCode;


public interface IEmpProcessService {
    // 내부직원 조회
    List<EmpProcess> selectEmpProcessList(Map<String, Object> params);
    
    // 내부직원 공정 저장
    void saveEmpProcess(EmpProcess empProcess);
    
    // 공정 코드 목록 조회 (외부직원 컨트롤러에서도 이걸 호출해서 씀)
    List<ProcessCode> selectProcessCodeList();
}