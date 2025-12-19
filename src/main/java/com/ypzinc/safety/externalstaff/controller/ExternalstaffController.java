package com.ypzinc.safety.externalstaff.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

// [추가] 공정 드롭다운을 위해 필요한 클래스 Import
import com.ypzinc.safety.empprocess.model.ProcessCode;
import com.ypzinc.safety.empprocess.service.IEmpProcessService;

import com.ypzinc.safety.externalstaff.model.Externalstaff;
import com.ypzinc.safety.externalstaff.service.IExternalstaffService;

@Controller
@RequestMapping("/dde-dms") // 기본 경로
public class ExternalstaffController {

	@Autowired
	private IExternalstaffService externalstaffService;
	
	// [추가] 부서/공정 드롭다운 목록을 가져오기 위한 서비스 주입
	@Autowired
	private IEmpProcessService empProcessService;
	
	/**
	 * 1. 조회 페이지 (GET)
	 * URL: /dde-dms/master/external-staff
	 * 설명: 화면을 보여주면서, 검색 데이터와 '공정 드롭다운 메뉴' 데이터를 같이 보냅니다.
	 */
	@RequestMapping(value = "/master/external-staff", method = RequestMethod.GET)
	public String externalstaffList(Model model, 
			@RequestParam(required = false, defaultValue = "") String searchType,
			@RequestParam(required = false, defaultValue = "") String keyword) {
		
		// 1) 검색 서비스 호출 (기존 로직 유지)
		List<Externalstaff> list = externalstaffService.getExternalstaffList(searchType, keyword);
		model.addAttribute("list", list);
		
		// 2) [추가] 공정 코드 목록 조회 (이게 있어야 JSP에서 드롭다운이 만들어집니다!)
		List<ProcessCode> processCodeList = empProcessService.selectProcessCodeList();
		model.addAttribute("processCodeList", processCodeList);
		
		// JSP 파일 경로
		return "dde-dms/master/external-staff"; 
	}
	
	/**
	 * 2. 등록 (POST)
	 * URL: /dde-dms/master/external-staff/register
	 */
	@RequestMapping(value = "/master/external-staff/register", method = RequestMethod.POST)
	public String registerExternalstaff(Externalstaff externalstaff) {
		System.out.println(">>> 등록 요청 들어옴: " + externalstaff);
		externalstaffService.registerExternalstaff(externalstaff);
		
		return "redirect:/dde-dms/master/external-staff";
	}
	
	/**
	 * 3. 수정 (POST)
	 * URL: /dde-dms/master/external-staff/update
	 */
	@RequestMapping(value = "/master/external-staff/update", method = RequestMethod.POST)
	public String updateExternalstaff(Externalstaff externalstaff) {
		try {
			System.out.println("수정 요청 들어옴 ID: " + externalstaff.getId());
			externalstaffService.updateExternalstaff(externalstaff);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/dde-dms/master/external-staff";
	}
	
	/**
	 * 4. 삭제 (POST - AJAX)
	 * URL: /dde-dms/master/external-staff/delete
	 */
	@RequestMapping(value = "/master/external-staff/delete", method = RequestMethod.POST)
	@ResponseBody
	public String deleteExternalstaffs(@RequestBody List<String> getIds) {
		try {
			System.out.println("삭제 요청된 ID 목록 : " + getIds);
			externalstaffService.deleteByIds(getIds);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}
	
}