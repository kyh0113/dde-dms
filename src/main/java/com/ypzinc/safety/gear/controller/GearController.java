package com.ypzinc.safety.gear.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ypzinc.safety.gear.model.Gear;
import com.ypzinc.safety.gear.service.IGearService;

@Controller
@RequestMapping("/dde-dms") 
public class GearController {
    
    @Autowired
    private IGearService gearService;

    // 메인 페이지 진입 시 -> 장비 등록(리스트) 페이지로 이동
    // 404 에러 방지를 위해 "" 와 "/" 두 가지 경우를 모두 잡도록 설정했습니다.
    @RequestMapping(value = {"", "/"}, method = RequestMethod.GET)
    public String gearList() {
        return "redirect:/dde-dms/ppe/register"; 
    }
    
    // 조회 페이지 (GET)
    @RequestMapping(value = "/ppe/register", method = RequestMethod.GET)
    public String register(Model model, 
                           @RequestParam(required = false, defaultValue = "") String searchType, 
                           @RequestParam(required = false, defaultValue = "") String keyword) {
        
        List<Gear> list = gearService.getGearList(searchType, keyword);
        
        model.addAttribute("gearList", list);
        model.addAttribute("searchType", searchType);
        model.addAttribute("keyword", keyword);
        
        return "dde-dms/ppe/register";
    }
    
    // 재고관리 페이지 이동
    @RequestMapping(value = "/ppe/inventory", method = RequestMethod.GET)
    public String inventory() {
        return "dde-dms/ppe/inventory";
    }
    
    // [수정됨] 등록 로직 (POST) -> /add 추가
    @RequestMapping(value = "/ppe/register/add", method = RequestMethod.POST)
    public String registerGear(Gear gear){
        System.out.println(">>> 등록 요청 들어옴: " + gear);
        gearService.registerGear(gear);
        return "redirect:/dde-dms/ppe/register";
    }
    
    // [수정됨] 수정 로직 -> /update 추가
    @RequestMapping(value = "/ppe/register/update", method = RequestMethod.POST)
    public String updateGear(Gear gear) {
        try {
            System.out.println("수정 요청 들어옴: " + gear.getGearCode()); 
            gearService.updateGear(gear);
        } catch (Exception e) {
            e.printStackTrace(); 
        }
        return "redirect:/dde-dms/ppe/register";
    }
    
    // [수정됨] 삭제 로직 -> /delete 추가
    @RequestMapping(value = "/ppe/register/delete", method = RequestMethod.POST)
    @ResponseBody 
    public String deleteGears(@RequestBody List<String> selectedIds) {
        try{
            System.out.println("삭제 요청된 ID 목록 : " + selectedIds);
            gearService.deleteByCodes(selectedIds);
            return "success";
        } catch (Exception e) { 
            e.printStackTrace();
            return "fail";
        }
    }
}