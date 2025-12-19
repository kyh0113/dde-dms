package com.ypzinc.safety.empprocess.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ypzinc.safety.empprocess.model.EmpProcess;
import com.ypzinc.safety.empprocess.model.ProcessCode;
import com.ypzinc.safety.empprocess.service.IEmpProcessService;

@Controller
@RequestMapping("/dde-dms") // 1. 기본 경로를 짧게 잡습니다.
public class EmpProcessController {

    @Autowired
    private IEmpProcessService empProcessService;

    // 2. 화면 이동 (사이드바 링크: /dde-dms/master/dept-personnel 대응)
    @RequestMapping(value = "/master/dept-personnel", method = RequestMethod.GET)
    public String empProcessList(Model model) {
        
        List<ProcessCode> processCodeList = empProcessService.selectProcessCodeList();
        model.addAttribute("processCodeList", processCodeList);
        
        // JSP 파일 위치: /WEB-INF/views/dde-dms/master/dept-personnel.jsp
        return "dde-dms/master/dept-personnel"; 
    }

    // 3. 직원 목록 조회 (JSP의 AJAX 경로: /dde-dms/master/emp-process/search 대응)
    // ※ JSP 코드를 고치지 않기 위해 여기 주소를 맞춰줍니다.
    @RequestMapping(value = "/master/emp-process/search", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> selectList(@RequestParam Map<String, Object> params) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<EmpProcess> list = empProcessService.selectEmpProcessList(params);
            result.put("result", "success");
            result.put("data", list);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("result", "fail");
            result.put("message", e.getMessage());
        }
        return result;
    }

    // 4. 공정 저장 (JSP의 AJAX 경로: /dde-dms/master/emp-process/save 대응)
    @RequestMapping(value = "/master/emp-process/save", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> saveProcess(EmpProcess empProcess) {
        Map<String, Object> result = new HashMap<>();
        try {
            empProcessService.saveEmpProcess(empProcess);
            result.put("result", "success");
        } catch (Exception e) {
            e.printStackTrace();
            result.put("result", "fail");
        }
        return result;
    }
}