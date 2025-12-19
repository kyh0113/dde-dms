package com.vicurus.it.biz.dashboard.cntr;

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
import com.vicurus.it.biz.dashboard.srvc.intf.DashBoardService;


@Controller
public class DashBoardController {
	private static final Logger logger = LoggerFactory.getLogger(DashBoardController.class);
	
	@Autowired
	private DashBoardService dashBoardService;
	
	
	@RequestMapping(value="/biz/dashBoard")
	public ModelAndView dashBoard(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();

		mav.setViewName("/biz/dashBoard/dashBoard");
		return mav;
	}
	
	
	@RequestMapping(value="/icm/dashBoard/auditAdd", method = RequestMethod.POST)
	public ModelAndView auditAdd(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int result = dashBoardService.auditAdd(request, response);
		
		Map resultMap = new HashMap();
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/icm/dashBoard/auditEdit", method = RequestMethod.POST)
	public ModelAndView auditEdit(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int result = dashBoardService.auditEdit(request, response);
		
		Map resultMap = new HashMap();
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	
	/* 대쉬보드 차트 */
	@RequestMapping(value="/biz/dashBoard/dashBoardChart")
	public ModelAndView dashBoardChart(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		Map  resultMap =  new HashMap();
		resultMap = dashBoardService.getDashBoardChart(paramMap);
		return new ModelAndView("DataToJson", resultMap);
	}

	
	/* 대쉬보드 스텝바 */
	@RequestMapping(value="/biz/dashBoard/modal_account_cnt")
	public ModelAndView modal_account_cnt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		Map  resultMap =  new HashMap();
		resultMap = dashBoardService.modal_account_cnt(paramMap);
		return new ModelAndView("DataToJson", resultMap);
	}
	
}
