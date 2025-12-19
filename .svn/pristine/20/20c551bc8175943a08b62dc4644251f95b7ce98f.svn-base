package com.vicurus.it.core.common;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.vicurus.it.core.code.srvc.intf.CodeService;

@Controller
public class errorPage {
	@Autowired
	private CodeService codeService;
	private static final Logger logger = LoggerFactory.getLogger(errorPage.class);
	
	@RequestMapping("/core/error/404.do")
	public ModelAndView error404(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("error404");
		return new ModelAndView("/core/error/404");
//		response.setCharacterEncoding("euc-kr");
//		PrintWriter writer = response.getWriter();
//		writer.println("<script type='text/javascript'>");
//		writer.println("alert('해당 파일이 존재하지 않습니다.');");
//		writer.println("history.back();");
//		writer.println("</script>");
//		writer.flush();
		
	}

	@RequestMapping("/core/error/400.do")
	public ModelAndView error400(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("error400");
		return new ModelAndView("/core/error/400");
	}
	
	@RequestMapping("/core/error/401.do")
	public ModelAndView error401(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("error401");
		return new ModelAndView("/core/error/401");
	}
	
	@RequestMapping("/core/error/403.do")
	public ModelAndView error403(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("error403");
		return new ModelAndView("/core/error/403");
	}
	
	@RequestMapping("/core/error/405.do")
	public ModelAndView error405(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("error405");
		return new ModelAndView("/core/error/405");
	}
	
	@RequestMapping("/core/error/500.do")
	public ModelAndView error500(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("error500");
		return new ModelAndView("/core/error/500");
	}
}