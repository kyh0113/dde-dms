package com.vicurus.it.biz.sample.cntr;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.vicurus.it.core.common.Util;
import com.yp.login.srvc.intf.YPLoginService;
import com.vicurus.it.biz.sample.srvc.intf.SampleService;


@Controller
public class SampleController {
	private static final Logger logger = LoggerFactory.getLogger(SampleController.class);
	
	@Autowired
	private SampleService sampleService;
	@Autowired
	private YPLoginService lService;
	
	@RequestMapping(value="/biz/sample/sample_page1", method = RequestMethod.POST)
	public ModelAndView sample_page1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		mav.setViewName("/biz/sample/sample_page1");
		return mav;
	}
	
	/* Sample1 저장	*/
	@RequestMapping(value="/biz/sample/sample1Merge", method = RequestMethod.POST)
	public ModelAndView sample1Merge(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();
		resultMap = sampleService.sample1Merge(request,response);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	
}
