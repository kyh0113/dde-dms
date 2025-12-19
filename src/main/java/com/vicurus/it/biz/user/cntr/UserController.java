package com.vicurus.it.biz.user.cntr;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.vicurus.it.biz.user.srvc.intf.UserService;

@Controller
public class UserController {
	@Autowired
	private UserService UserService;
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	
	//부서 메인
	@RequestMapping(value="/biz/dept_main", method = RequestMethod.POST)
	public ModelAndView dept_main(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/biz/dept_user/dept_main");
		return mav;
	}
	
	//사용자 메인
	@RequestMapping(value="/biz/user_main", method = RequestMethod.POST)
	public ModelAndView user_main(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/biz/dept_user/dept_user_main");
		return mav;
	}
	
	
	
	
	
	
	
	
	@RequestMapping(value="/icm/deptList", method = RequestMethod.POST)
	public ModelAndView termClose(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List deptList = UserService.deptList(request, response);
		Map resultMap = new HashMap();
		resultMap.put("treeList", deptList);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/icm/userDetail", method = RequestMethod.POST)
	public ModelAndView userDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = UserService.userDetail(request, response);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/*
	 * ajax파라미터가 jsonstr 이므로 paramData로 받아서 jackson 라이브러리를 사용해 list로 컨버트 한다.
	 * */
	@RequestMapping(value="/icm/user_dept_modify", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView user_dept_modify(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();
		ObjectMapper om = new ObjectMapper();
		List rowDatas = om.readValue((String)request.getAttribute("listString"), new TypeReference<List<Map>>(){});
		
		logger.info("user_dept_modify params : {}",rowDatas);
		
		int result = UserService.userDeptModify(request, rowDatas);
		
		resultMap.put("result", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/icm/checkId", method = RequestMethod.POST)
	public ModelAndView checkId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = UserService.checkId(request, response);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/icm/userPasswordReset", method = RequestMethod.POST)
	public ModelAndView userPasswordReset(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = UserService.userPasswordReset(request, response);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/icm/userModify", method = RequestMethod.POST)
	public ModelAndView userModify(final MultipartHttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = UserService.userModify(request, response);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/icm/userPerInsert", method = RequestMethod.POST)
	public ModelAndView userPerInsert(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = UserService.userPerInsert(request, response);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/icm/userPerDelete", method = RequestMethod.POST)
	public ModelAndView userDelete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();
		ObjectMapper om = new ObjectMapper();
		List rowDatas = om.readValue((String)request.getAttribute("listString"), new TypeReference<List<Map>>(){});
		resultMap = UserService.userPerDelete(rowDatas);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	
	
	
	@RequestMapping(value="/icm/deptAdd", method = RequestMethod.POST)
	public ModelAndView deptAdd(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();
		resultMap = UserService.deptAdd(request, response);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/icm/deptRemove", method = RequestMethod.POST)
	public ModelAndView deptRemove(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();
		resultMap = UserService.deptRemove(request, response);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/icm/deptUpdate", method = RequestMethod.POST)
	public ModelAndView deptUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();
		resultMap = UserService.deptUpdate(request, response);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/icm/allUserPwInit", method = RequestMethod.POST)
	public ModelAndView allUserPwInit(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();
		
		int result = UserService.allUserPwInit(request, response);
		
		resultMap.put("result", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/icm/allUserStatusUpdate", method = RequestMethod.POST)
	public ModelAndView allUserStatusC(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();
		
		int result = UserService.allUserStatusUpdate(request, response);
		
		resultMap.put("result", result);
		
		return new ModelAndView("DataToJson", resultMap);
	}
	
}
