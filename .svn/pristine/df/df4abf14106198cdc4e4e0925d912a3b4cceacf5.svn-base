package com.vicurus.it.core.menu.cntr;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.vicurus.it.core.menu.srvc.intf.MenuService;
import com.vicurus.it.biz.board.srvc.intf.BoardService;


@Controller
public class MenuController {
	@Autowired
	private MenuService menuService;
	
	@Autowired
	private BoardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(MenuController.class);
	
	//2019-08-18 smh 수정. 팝업창을 위한 popup_yn='Y'인 ic_board를 조회한다.
	@RequestMapping(value="/core/menu/main") //ICM 사용 - 20180809하태현
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//popupList 조회
		Map resultMap = boardService.popupYList(request,response);
		
		ModelAndView mav = new ModelAndView();
		//이전경로 추가
		mav.addObject("beforURI", request.getHeader("referer"));
		mav.addObject("popupData", resultMap);
		mav.setViewName("/biz/main");
		return mav;
	}
	//2019-08-18 smh 수정 끝
	
	@RequestMapping(value="/core/staff/menu/menu_management", method = RequestMethod.POST)
	public ModelAndView init(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/core/staff/menu/menu_management");
		return mav;
	}
	
	@RequestMapping(value="/core/staff/menu/menuTree", method = RequestMethod.POST)
	public ModelAndView menuTree(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List menuList = menuService.menuTree(request, response);
		Map resultMap = new HashMap();
		resultMap.put("treeList", menuList);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/core/staff/menu/menuTree_sort", method = RequestMethod.POST)
	public ModelAndView menuTree_sort_num(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List menuList = menuService.menuTree_sort(request, response);
		Map resultMap = new HashMap();
		resultMap.put("treeList", menuList);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/core/staff/menu/addTopMenu")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ModelAndView addTopMenu(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map map = new HashMap();
		map = menuService.insertTopMenu(request, response);
		return new ModelAndView("DataToJson", map);	
	}
	
	@RequestMapping(value="/core/staff/menu/updateMenu")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ModelAndView updateMenu(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map map = new HashMap();
		map = menuService.updateMenu(request, response);
		return new ModelAndView("DataToJson", map);	
	}

	@RequestMapping(value="/core/staff/menu/addSubMenu")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ModelAndView addSubMenu(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map map = new HashMap();
		map = menuService.insertSubMenu(request, response);
		return new ModelAndView("DataToJson", map);	
	}
	
	@RequestMapping(value="/core/staff/menu/deleteMenu")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ModelAndView deleteMenu(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map map = new HashMap();
		map = menuService.deleteMenu(request, response);
		return new ModelAndView("DataToJson", map);	
	}
	
	
	
	
	
	
	
	
	@RequestMapping(value="/core/menu/getMenuTree.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ModelAndView getMenuTree(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map map = new HashMap();
		List treeList = menuService.getMenuTree(request, response);
		map.put("treeList", treeList);
		return new ModelAndView("DataToJson", map);	
	}
	
	
	
	
	
	
}