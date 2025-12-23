package com.ypzinc.safety.empprocess.repository;

import java.util.List;
import java.util.Map;

import com.ypzinc.safety.empprocess.model.EmpProcess;
import com.ypzinc.safety.empprocess.model.ProcessCode;


public interface IEmpProcessRepository {

    // 1. [내부직원] 목록 조회 (그룹웨어 + 공정정보)
    List<EmpProcess> selectEmpProcessList(Map<String, Object> params);

    // 2. [내부직원] 공정 정보 저장 (Merge)
    void saveEmpProcess(EmpProcess empProcess);

    // 3. [공통] 부서별 공정 코드 목록 조회 (드롭다운용)
    // TBL_PROCESS_CODE 테이블 조회
    List<ProcessCode> selectProcessCodeList();
    
    void mergeEmpProcessFromGW();
    void deleteRetiredEmp();
}