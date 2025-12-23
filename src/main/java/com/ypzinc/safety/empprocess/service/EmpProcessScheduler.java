package com.ypzinc.safety.empprocess.service;

import com.ypzinc.safety.empprocess.repository.IEmpProcessRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
@EnableScheduling
public class EmpProcessScheduler {

    @Autowired
    private IEmpProcessRepository empProcessRepository;

    /**
     * 매일 새벽 3시에 실행 (Cron 표현식: 초 분 시 일 월 요일)
     * 조직도 동기화 로직을 수행합니다.
     */
    @Transactional
    @Scheduled(cron = "*/30 * * * * *")
    public void syncOrganizationData() {
        try {
            // 1. 조직도 동기화 (신규 추가 및 기존 정보 업데이트)
            // repository에 추가할 메서드 이름은 예시입니다.
            empProcessRepository.mergeEmpProcessFromGW();
            
            // 2. 퇴사자 처리 (조직도에 없는 인원 삭제)
            empProcessRepository.deleteRetiredEmp();
            
            System.out.println(">>> [배치] 조직도 동기화 및 퇴사자 정리 완료");
        } catch (Exception e) {
            System.err.println(">>> [배치] 오류 발생: " + e.getMessage());
        }
    }
}