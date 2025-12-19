package com.vicurus.it.core.secure;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.vicurus.it.core.interceptor.Interceptor;
import com.vicurus.it.core.login.srvc.intf.LoginService;

@Component
public class Scheduler {
    Logger logger = LoggerFactory.getLogger(Scheduler.class);
 
    @Autowired
	private LoginService loginService;
    
    /*
     *매일 12시(자정)에 실행, 2개월(60일)이상 미접속자 잠금처리!! 단, 운영자권한 제외하고!! 
     */
    @Scheduled(cron="0 0 0 * * *")
    public void Scheduler() {
        try{
        	logger.debug("Scheduler Success!!");
            loginService.Scheduler_UserStatus_N();
        }catch(Exception e){
            //e.printStackTrace();
            logger.debug("Scheduler Error: {}", e);
        }
    }
    
    
    
}
