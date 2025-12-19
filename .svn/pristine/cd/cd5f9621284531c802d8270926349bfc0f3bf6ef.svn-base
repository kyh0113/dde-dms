package com.yp.zhw.cntr;

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

import com.vicurus.it.core.common.CommonUtil;
import com.yp.login.srvc.intf.YPLoginService;
import com.yp.zhw.srvc.intf.YP_ZHW_Service;


@Controller
public class YP_ZHW_Controller {
	@Autowired
	private YP_ZHW_Service ypZhwService;
	
	@Autowired
	private YPLoginService lService;
	
	private static final Logger logger = LoggerFactory.getLogger(YP_ZHW_Controller.class);

	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/yp/zhw/zhw_tablet_list", method = RequestMethod.POST)
	public ModelAndView tablet_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】관리자 > HW 관리 > 테블릿 현황 조회");
		ModelAndView mav = new ModelAndView();
		
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		
		mav.setViewName("/yp/zhw/zhw_tablet_list");
		return mav;
	}
	
	
}