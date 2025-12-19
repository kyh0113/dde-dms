package com.vicurus.it.core.uigrid.cntr;

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

import com.vicurus.it.core.uigrid.srvc.intf.UiGridService;

@Controller
public class UiGridController {
	private static final Logger logger = LoggerFactory.getLogger(UiGridController.class);
	
	@Autowired
	private UiGridService uiGridService;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/uiGridLoad", method = RequestMethod.POST)
	public ModelAndView gridLoad(HttpServletRequest request, HttpServletResponse response) throws Exception{
		//Map resultMap = gridService.gridLoad();
		logger.info("listQuery : {}",request.getParameter("listQuery"));
		Map resultMap = uiGridService.gridLoad(request, response);
		
		logger.info("grid load");
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
}
