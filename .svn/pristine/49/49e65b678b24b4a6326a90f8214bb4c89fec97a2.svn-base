package com.vicurus.it.core.code.cntr;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.vicurus.it.core.code.srvc.intf.CodeService;
import com.vicurus.it.core.common.CommonUtil;
import com.vicurus.it.core.common.util.ListWrapper;


@Controller
public class CodeController {
	@Autowired
	private CodeService codeService;
	@Autowired
	private CommonUtil commonUtil;
	
	private static final Logger logger = LoggerFactory.getLogger(CodeController.class);
	
	@RequestMapping("/core/staff/code/code_management")
	public ModelAndView init(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		List combo_CodeMaster = (List) codeService.getCodeMasterList(request, response);
		mav.addObject("combo_CodeMaster", combo_CodeMaster);
		
		//코드 셀렉트리스트 만들기 영역
		//List combo_CodeMaster = (List) commonUtil.getCommonCodeForCombo("COM_USE");// 사용유무
		//mav.addObject("combo_CodeMaster", combo_CodeMaster);
		//코드 셀렉트리스트 만들기 영억 끝
		
		mav.setViewName("/core/staff/code/code_management");
		return mav;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/core/staff/code/mergeMasterCode")
	public ModelAndView mergeMasterCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map map = codeService.setCodeMasterMerge(request, response);
		
    	return new ModelAndView("DataToJson", map);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/core/staff/code/mergeDetailCode")
	public ModelAndView mergeDetailCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map map = codeService.setCodeDetailMerge(request, response);
		
    	return new ModelAndView("DataToJson", map);
	}
	
	/*
	 * ajax파라미터가 jsonstr 이므로 paramData로 받아서 jackson 라이브러리를 사용해 list로 컨버트 한다.
	 * */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/core/staff/code/deleteMasterCode")
	public ModelAndView deleteMasterCode(@RequestBody String paramData, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map resultMap = new HashMap();
		ObjectMapper om = new ObjectMapper();
		List rowDatas = om.readValue(paramData, new TypeReference<List<Map>>(){});
		
		int result = codeService.deleteMasterCode(rowDatas);
		
		resultMap.put("result", result);
		
		return new ModelAndView("DataToJson", resultMap);		
	}
	
	/*
	 * ajax파라미터가 jsonstr 이므로 paramData로 받아서 jackson 라이브러리를 사용해 list로 컨버트 한다.
	 * */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/core/staff/code/deleteDetailCode")
	public ModelAndView deleteDetailCode(@RequestBody String paramData, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map resultMap = new HashMap();
		ObjectMapper om = new ObjectMapper();
		List rowDatas = om.readValue(paramData, new TypeReference<List<Map>>(){});
		
		int result = codeService.deleteDetailCode(rowDatas);
		
		resultMap.put("result", result);
		
		return new ModelAndView("DataToJson", resultMap);		
	}
	
	
	//서버의 오늘날짜를 클라이언트로
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/getCurDate")
	public ModelAndView getCurDate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map map = new HashMap();
		SimpleDateFormat  formatter04 = new SimpleDateFormat("yyyy-MM-dd");
		String todate =  formatter04.format(new Date());
		map.put("cdate", todate);
    	return new ModelAndView("DataToJson", map);
	}
	
	
	
}