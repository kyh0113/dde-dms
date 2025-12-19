package com.yp.wr.cntr;

import com.vicurus.it.core.common.Pagination;
import com.vicurus.it.core.common.Util;
import com.yp.fixture.srvc.intf.YPFixtureService;
import com.yp.login.srvc.intf.YPLoginService;
import com.yp.util.DateUtil;
import com.yp.wr.srvc.intf.wr_Service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller //이 클래스가 컨트롤러임을 나타내는 어노테이션 
public class wr_wController {
	@Autowired
	  private wr_Service wrService;
  
	private static final Logger logger = LoggerFactory.getLogger(com.yp.wr.cntr.wr_wController.class);

   @Autowired
   private YPLoginService lService;
   
   
  
   @SuppressWarnings({ "rawtypes", "unchecked" })
   @RequestMapping(value="/yp/wr/wr_write", method = RequestMethod.POST)
   public ModelAndView wrwrite(HttpServletRequest request, HttpServletResponse response) throws Exception {
      Util util = new Util();
      HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
      ModelAndView mav = new ModelAndView();
      
      logger.debug("【화면호출】전산작업관리 > 의뢰서 작성");
      
	   // 공통 - 네비게이션 시작
		List breadcrumbList = lService.select_breadcrumb_hierarchy(request, response);
		mav.addObject("breadcrumbList", breadcrumbList);
		mav.addObject("current_menu", breadcrumbList.get(breadcrumbList.size()-1));
		// 공통 - 네비게이션 끝

      // session attr to param
      HttpSession session = request.getSession();


      mav.addObject("req_data", paramMap);
      mav.setViewName("/yp/wr/wr_write");

      return mav;
   }
   
 //작업현황목록(전산팀)
   @RequestMapping(value="/yp/wr/wr_list", method = RequestMethod.POST)
   public ModelAndView wrlist(HttpServletRequest request, HttpServletResponse response) throws Exception {
      Util util = new Util();
      HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
      ModelAndView mav = new ModelAndView();
      
      logger.debug("【화면호출】전산작업관리 > 작업내역");
      
	  	// 공통 - 네비게이션 시작
		List breadcrumbList = lService.select_breadcrumb_hierarchy(request, response);
		mav.addObject("breadcrumbList", breadcrumbList);
		mav.addObject("current_menu", breadcrumbList.get(breadcrumbList.size()-1));
		// 공통 - 네비게이션 끝
      
      paramMap.put("pdate", DateUtil.getToday());
      
      mav.setViewName("/yp/wr/wr_list");
      
      return mav;
   }
   
   //의뢰서목록(현업)
   @RequestMapping(value="/yp/wr/wr_write_list", method = RequestMethod.POST)
   public ModelAndView wrwritelist(HttpServletRequest request, HttpServletResponse response) throws Exception {
      Util util = new Util();
      HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
      ModelAndView mav = new ModelAndView();
      
      logger.debug("【화면호출】전산작업관리 > 작업내역");
      
	  	// 공통 - 네비게이션 시작
		List breadcrumbList = lService.select_breadcrumb_hierarchy(request, response);
		mav.addObject("breadcrumbList", breadcrumbList);
		mav.addObject("current_menu", breadcrumbList.get(breadcrumbList.size()-1));
		// 공통 - 네비게이션 끝
      
      paramMap.put("pdate", DateUtil.getToday());
      
      mav.setViewName("/yp/wr/wr_write_list");
      
      return mav;
   }
   
   
   /* 전자결재I/F - 전산작업 전자결재 데이터 연동 시작 - 의뢰서  */
  	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/wr/wr_req_data")
	public void fixture_req_data(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String from = "[전자결재I/F] 전산요청 데이터 연동- 의뢰서";
		logger.debug(from);
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
	    
	    
		logger.debug("[전자결재] paramMap:"+paramMap);
		List list = wrService.wr_req_list(paramMap);		
		
		this.JsonFlush(request, response, list, from);		
	}
  	/* 전자결재I/F - 전산작업 전자결재 데이터 연동 끝  */
  	
  	/* 전자결재I/F - 전산작업 전자결재 데이터 연동 시작 - 보고서  */
  	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/wr/wr_req_data_D")
	public void fixture_req_data_b(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String from = "[전자결재I/F] 전산요청 데이터 연동- 보고서";
		logger.debug(from);
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)    
	    
		logger.debug("[전자결재] paramMap:"+paramMap);
		List list = wrService.wr_req_list_D(paramMap);
	
		this.JsonFlush(request, response, list, from);		
	}
  	/* 전자결재I/F - 전산작업 전자결재 데이터 연동 끝  */
  	
  	/* 전자결재I/F - 전산작업 전자결재 데이터 연동 시작 - 처리서  */
  	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/wr/wr_req_data_A")
	public void wr_req_data_A(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String from = "[전자결재I/F] 전산요청 데이터 연동- 처리서";
		logger.debug(from);
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)    
	    
		logger.debug("[전자결재] paramMap:"+paramMap);
		List list = wrService.wr_req_list_A(paramMap);
	
		this.JsonFlush(request, response, list, from);		
	}
  	/* 전자결재I/F - 전산작업 전자결재 데이터 연동 끝  */
  	
  	/* 전자결재I/F - 전산작업 전자결재 데이터 연동 시작 - 자체보고서  */
  	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/wr/wr_req_data_E")
	public void wr_req_data_E(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String from = "[전자결재I/F] 전산요청 데이터 연동- 자체보고서";
		logger.debug(from);
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)    
	    
		logger.debug("[전자결재] paramMap:"+paramMap);
		List list = wrService.wr_req_list_E(paramMap);
	
		this.JsonFlush(request, response, list, from);		
	}
  	/* 전자결재I/F - 전산작업 전자결재 데이터 연동 끝  */
  	
  	/* 전자결재I/F - 전산작업 전자결재 데이터 연동 시작 - 자체처리서  */
  	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/wr/wr_req_data_B")
	public void wr_req_data_B(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String from = "[전자결재I/F] 전산요청 데이터 연동- 자체처리서";
		logger.debug(from);
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)    
	    
		logger.debug("[전자결재] paramMap:"+paramMap);
		List list = wrService.wr_req_list_B(paramMap);
	
		this.JsonFlush(request, response, list, from);		
	}
  	/* 전자결재I/F - 전산작업 전자결재 데이터 연동 끝  */
	

  	/* 전자결재I/F - 전산작업 전자결재 상태연동 연동 시작  - 의뢰서*/
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/wr/wr_edoc_status_update")
	public void fixture_edoc_status_update(HttpServletRequest request, HttpServletResponse response){
		String from = "[상태변경I/F] 전산상태연동";
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		String RESULT = "";
		String MESSAGE = "";
		
		try {
			int result = 0;
			result = wrService.wr_edoc_status_update(request, response);
			logger.debug("UPDATE {} 건 완료", result);
			if(result > 0) {
				RESULT = "S";
				MESSAGE = "성공";
				map.put("RESULT", RESULT);
				map.put("MESSAGE", MESSAGE);
				list.add(map);
			}else {
				RESULT = "E";
				MESSAGE = "상태가 변경 된 대상이 존재하지 않습니다.";
				map.put("RESULT", RESULT);
				map.put("MESSAGE", MESSAGE);
				list.add(map);
			}
		} catch (Exception e) {
			logger.error("{} - {}", e.getCause(), e.toString());
			RESULT = "E";
			MESSAGE = this.subStrByte(e.toString(), 4000);
			map.put("RESULT", RESULT);
			map.put("MESSAGE", MESSAGE); // 4000바이트 초과 문자열 잘라내기
			list.add(map);
			//e.printStackTrace();
		} finally {
			logger.debug("{}", list);
			this.JsonFlush(request, response, list, from);
		}
	}
	/* 전자결재I/F - 전산작업 전자결재 상태연동 연동 끝  - 의뢰서*/
	
	/* 전자결재I/F - 전산작업 전자결재 상태연동 연동 시작  - 보고서*/
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/wr/wr_edoc_status_update_report")
	public void report_edoc_status_update(HttpServletRequest request, HttpServletResponse response){
		String from = "[상태변경I/F] 전산상태연동";
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		String RESULT = "";
		String MESSAGE = "";
		
		try {
			int result = 0;
			result = wrService.wr_edoc_status_update_report(request, response);
			logger.debug("UPDATE {} 건 완료", result);
			if(result > 0) {
				RESULT = "S";
				MESSAGE = "성공";
				map.put("RESULT", RESULT);
				map.put("MESSAGE", MESSAGE);
				list.add(map);
			}else {
				RESULT = "E";
				MESSAGE = "상태가 변경 된 대상이 존재하지 않습니다.";
				map.put("RESULT", RESULT);
				map.put("MESSAGE", MESSAGE);
				list.add(map);
			}
		} catch (Exception e) {
			logger.error("{} - {}", e.getCause(), e.toString());
			RESULT = "E";
			MESSAGE = this.subStrByte(e.toString(), 4000);
			map.put("RESULT", RESULT);
			map.put("MESSAGE", MESSAGE); // 4000바이트 초과 문자열 잘라내기
			list.add(map);
			//e.printStackTrace();
		} finally {
			logger.debug("{}", list);
			this.JsonFlush(request, response, list, from);
		}
	}
	/* 전자결재I/F - 전산작업 전자결재 상태연동 연동 끝  - 보고서*/
	
	/* 전자결재I/F - 전산작업 전자결재 상태연동 연동 시작  - 처리서*/
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/wr/wr_edoc_status_update_final")
	public void final_edoc_status_update(HttpServletRequest request, HttpServletResponse response){
		String from = "[상태변경I/F] 전산상태연동";
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		String RESULT = "";
		String MESSAGE = "";
		
		try {
			int result = 0;
			result = wrService.wr_edoc_status_update_final(request, response);
			logger.debug("UPDATE {} 건 완료", result);
			if(result > 0) {
				RESULT = "S";
				MESSAGE = "성공";
				map.put("RESULT", RESULT);
				map.put("MESSAGE", MESSAGE);
				list.add(map);
			}else {
				RESULT = "E";
				MESSAGE = "상태가 변경 된 대상이 존재하지 않습니다.";
				map.put("RESULT", RESULT);
				map.put("MESSAGE", MESSAGE);
				list.add(map);
			}
		} catch (Exception e) {
			logger.error("{} - {}", e.getCause(), e.toString());
			RESULT = "E";
			MESSAGE = this.subStrByte(e.toString(), 4000);
			map.put("RESULT", RESULT);
			map.put("MESSAGE", MESSAGE); // 4000바이트 초과 문자열 잘라내기
			list.add(map);
			//e.printStackTrace();
		} finally {
			logger.debug("{}", list);
			this.JsonFlush(request, response, list, from);
		}
	}
	/* 전자결재I/F - 전산작업 전자결재 상태연동 연동 끝  - 처리서*/
	

	@SuppressWarnings({ "rawtypes", "unchecked" })
	 @RequestMapping(value="/yp/wr/wr_report")
	 public ModelAndView wrreport(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    Util util = new Util();
	    HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
	    ModelAndView mav = new ModelAndView();
	    
	    logger.debug("【화면호출】전산작업관리 > 보고서 작성");
	    
	    // 공통 - 네비게이션 시작
 		List breadcrumbList = lService.select_breadcrumb_hierarchy(request, response);
 		mav.addObject("breadcrumbList", breadcrumbList);
 		mav.addObject("current_menu", breadcrumbList.get(breadcrumbList.size()-1));
 		// 공통 - 네비게이션 끝
	
	 		
	 		
	    mav.addObject("req_data", paramMap);
	    mav.setViewName("/yp/wr/wr_report");
	    
	    return mav;
	 }
	 
	 
   
   @SuppressWarnings({ "rawtypes", "unchecked" })
   @RequestMapping(value="/yp/wr/wr_report_in", method = RequestMethod.POST)
   public ModelAndView wrreportin(HttpServletRequest request, HttpServletResponse response) throws Exception {
      Util util = new Util();
      HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
      ModelAndView mav = new ModelAndView();
      
      logger.debug("【화면호출】전산작업관리 > 자체처리보고서 작성");
      
      // 공통 - 네비게이션 시작
   		List breadcrumbList = lService.select_breadcrumb_hierarchy(request, response);
   		mav.addObject("breadcrumbList", breadcrumbList);
   		mav.addObject("current_menu", breadcrumbList.get(breadcrumbList.size()-1));
   		// 공통 - 네비게이션 끝
      
      paramMap.put("sdate", DateUtil.getToday());
      paramMap.put("edate", DateUtil.getSevenDay());

      // session attr to param
      HttpSession session = request.getSession();


      paramMap.put("emp_code", (String) session.getAttribute("empCode"));
      paramMap.put("emp_name", ((String) session.getAttribute("userName")));
      paramMap.put("dept_cd", ((String) session.getAttribute("userDeptCd")));
      paramMap.put("dept_name", ((String) session.getAttribute("userDept")));
      paramMap.put("zclss", ((String) session.getAttribute("zclss")));
      paramMap.put("zclst", ((String) session.getAttribute("zclst")));
      paramMap.put("schkz", ((String) session.getAttribute("schkz")));
      paramMap.put("jo_name", ((String) session.getAttribute("jo_name")));
      paramMap.put("auth", (String) session.getAttribute("HR_AUTH"));
      if (paramMap.get("auth") == null)
         paramMap.put("auth", "US");


      mav.addObject("req_data", paramMap);
      mav.setViewName("/yp/wr/wr_report_in");

      return mav;
   }
   
   @SuppressWarnings({ "rawtypes", "unchecked" })
   @RequestMapping(value="/yp/wr/wr_final", method = RequestMethod.POST)
   public ModelAndView wrfinal(HttpServletRequest request, HttpServletResponse response) throws Exception {
      Util util = new Util();
      HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
      ModelAndView mav = new ModelAndView();
      
      logger.debug("【화면호출】전산작업관리 > 처리서 작성");
      
      // 공통 - 네비게이션 시작
   		List breadcrumbList = lService.select_breadcrumb_hierarchy(request, response);
   		mav.addObject("breadcrumbList", breadcrumbList);
   		mav.addObject("current_menu", breadcrumbList.get(breadcrumbList.size()-1));
   		// 공통 - 네비게이션 끝
      
      paramMap.put("sdate", DateUtil.getToday());
      paramMap.put("edate", DateUtil.getSevenDay());

      // session attr to param
      HttpSession session = request.getSession();


      paramMap.put("emp_code", (String) session.getAttribute("empCode"));
      paramMap.put("emp_name", ((String) session.getAttribute("userName")));
      paramMap.put("dept_cd", ((String) session.getAttribute("userDeptCd")));
      paramMap.put("dept_name", ((String) session.getAttribute("userDept")));
      paramMap.put("zclss", ((String) session.getAttribute("zclss")));
      paramMap.put("zclst", ((String) session.getAttribute("zclst")));
      paramMap.put("schkz", ((String) session.getAttribute("schkz")));
      paramMap.put("jo_name", ((String) session.getAttribute("jo_name")));
      paramMap.put("auth", (String) session.getAttribute("HR_AUTH"));
      if (paramMap.get("auth") == null)
         paramMap.put("auth", "US");


      mav.addObject("req_data", paramMap);
      mav.setViewName("/yp/wr/wr_final");

      return mav;
   }
   
   
   @SuppressWarnings({ "rawtypes", "unchecked" })
   @RequestMapping(value="/yp/wr/wr_final_in", method = RequestMethod.POST)
   public ModelAndView wrfinalin(HttpServletRequest request, HttpServletResponse response) throws Exception {
      Util util = new Util();
      HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
      ModelAndView mav = new ModelAndView();
      
      logger.debug("【화면호출】전산작업관리 > 자체처리보고서 작성");
      
      // 공통 - 네비게이션 시작
   		List breadcrumbList = lService.select_breadcrumb_hierarchy(request, response);
   		mav.addObject("breadcrumbList", breadcrumbList);
   		mav.addObject("current_menu", breadcrumbList.get(breadcrumbList.size()-1));
   		// 공통 - 네비게이션 끝
      
      paramMap.put("sdate", DateUtil.getToday());
      paramMap.put("edate", DateUtil.getSevenDay());

      // session attr to param
      HttpSession session = request.getSession();


      paramMap.put("emp_code", (String) session.getAttribute("empCode"));
      paramMap.put("emp_name", ((String) session.getAttribute("userName")));
      paramMap.put("dept_cd", ((String) session.getAttribute("userDeptCd")));
      paramMap.put("dept_name", ((String) session.getAttribute("userDept")));
      paramMap.put("zclss", ((String) session.getAttribute("zclss")));
      paramMap.put("zclst", ((String) session.getAttribute("zclst")));
      paramMap.put("schkz", ((String) session.getAttribute("schkz")));
      paramMap.put("jo_name", ((String) session.getAttribute("jo_name")));
      paramMap.put("auth", (String) session.getAttribute("HR_AUTH"));
      if (paramMap.get("auth") == null)
         paramMap.put("auth", "US");


      mav.addObject("req_data", paramMap);
      mav.setViewName("/yp/wr/wr_final_in");

      return mav;
   }
   
   //추가
   @RequestMapping({"/yp/wr/wr_write_insert"})
   public ModelAndView wrwrite_insert(HttpServletRequest request, HttpServletResponse response) throws Exception {
     HashMap<Object, Object> resultMap = new HashMap<>();
     logger.debug("", resultMap);
     resultMap.put("", Integer.valueOf(this.wrService.wr_write_insert(request, response)));
     
     //resultMap.put("WR_CD", Integer.valueOf(this.wrService.wr_cd_select(request, response)));
     
     return new ModelAndView("DataToJson");
   }
   //추가
   
 //추가
   @RequestMapping({"/yp/wr/wr_final_insert"})
   public ModelAndView wrfinal_insert(HttpServletRequest request, HttpServletResponse response) throws Exception {
     HashMap<Object, Object> resultMap = new HashMap<>();
     logger.debug("", resultMap);

     resultMap = wrService.wr_final_insert(request, response);

     return new ModelAndView("DataToJson");
   }
   //추가
   
 //보고서팝업작성
   @RequestMapping({"/yp/wr/wr_report_insert"})
   public ModelAndView wrreport_insert(HttpServletRequest request, HttpServletResponse response) throws Exception {
     HashMap<Object, Object> resultMap = new HashMap<>();
     logger.debug("", resultMap);

     resultMap = wrService.wr_report_insert(request, response);

     return new ModelAndView("DataToJson");
   }
   //보고서팝업작성
   
 //의뢰서팝업작성
   @RequestMapping({"/yp/wr/wr_writepop_insert"})
   public ModelAndView wr_writepop_insert(HttpServletRequest request, HttpServletResponse response) throws Exception {
     HashMap<Object, Object> resultMap = new HashMap<>();
     logger.debug("", resultMap);

     resultMap = wrService.wr_writepop_insert(request, response);

     return new ModelAndView("DataToJson");
   }
   //의뢰서팝업작성
   
 //자체처리보고서팝업작성
   @RequestMapping({"/yp/wr/wr_reportinpop_insert"})
   public ModelAndView wr_reportinpop_insert(HttpServletRequest request, HttpServletResponse response) throws Exception {
     HashMap<Object, Object> resultMap = new HashMap<>();
     logger.debug("", resultMap);

     resultMap = wrService.wr_reportinpop_insert(request, response);

     return new ModelAndView("DataToJson");
   }
   //자체처리보고서팝업작성
   
//   @SuppressWarnings({"rawtypes", "unchecked"})
//	@RequestMapping(value = "/yp/wr/wr_report_pop")
//	public ModelAndView fixture_req_dtl_pop(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		ModelAndView mav = new ModelAndView();
//
//		Util util = new Util();
//		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
//		String gridData = paramMap.get("gridData").toString();
//		
//		// ----------------gridData뽑아내기----------------------------------------------------
//		JSONParser jsonParse = new JSONParser();
//		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("gridData").toString());
//		List<Map<String, Object>> paramList = util.getListMapFromJsonArray(jsonArr);
//		// ----------------------------------------------------------------------------------
//		
//		/**
//		 * fixture_req_code를 list로 묶고
//		 * CODES Key - Value 쌓으로 만들기
//		 */
//		ArrayList<String> WR_CODES =  new ArrayList<String>();
//		for(int i=0; i<paramList.size(); i++){
//			WR_CODES.add(paramList.get(i).get("WR_CODES").toString());
//		}
//		paramMap.put("WR_CODES", WR_CODES);
//		logger.debug("[TEST]paramMap:{}",paramMap);
//		
//		/**
//		 * 비품 요청 현황 리스트
//		 * 
//		 */
//		List list = wrService.wr_report_pop(paramMap);
//		
//		mav.addObject("grid_data", gridData);
//		mav.addObject("req_data", paramMap);
//		mav.setViewName("/yp/wr/wr_report_pop");
//		return mav;
//	}
   
   @RequestMapping("/yp/wr/wr_report_pop")
	@SuppressWarnings("unchecked")
	public ModelAndView entDetail(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8");
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("empCode", session.getAttribute("empCode"));
		paramMap.put("userName", session.getAttribute("userName"));
		
		mav.addObject("req_data",paramMap);
		mav.setViewName("/yp/wr/wr_report_pop");
		
		return mav;
	}
   
   @RequestMapping("/yp/wr/wr_final_pop")
	@SuppressWarnings("unchecked")
	public ModelAndView entDetailf(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8");
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("empCode", session.getAttribute("empCode"));
		paramMap.put("userName", session.getAttribute("userName"));
		
		mav.addObject("req_data",paramMap);
		mav.setViewName("/yp/wr/wr_final_pop");
		
		return mav;
	}
   
   @RequestMapping("/yp/wr/wr_final_in_pop")
	@SuppressWarnings("unchecked")
	public ModelAndView entDetaile(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8");
		
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("empCode", session.getAttribute("empCode"));
		paramMap.put("userName", session.getAttribute("userName"));
		
		mav.addObject("req_data",paramMap);
		mav.setViewName("/yp/wr/wr_final_in_pop");
		
		return mav;
	}
   
   @RequestMapping("/yp/wr/wr_write_pop")
  	@SuppressWarnings("unchecked")
  	public ModelAndView wr_write(HttpServletRequest request, HttpServletResponse response) throws Exception{
  		request.setCharacterEncoding("UTF-8");
  		
  		ModelAndView mav = new ModelAndView();
  		Util util = new Util();
  		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
  		
  		HttpSession session = request.getSession();
  		paramMap.put("empCode", session.getAttribute("empCode"));
  		paramMap.put("userName", session.getAttribute("userName"));
  		
  		mav.addObject("req_data",paramMap);
  		mav.setViewName("/yp/wr/wr_write_pop");
  		
  		return mav;
  	}
   
   @RequestMapping("/yp/wr/wr_report_in_pop")
 	@SuppressWarnings("unchecked")
 	public ModelAndView wr_report_in(HttpServletRequest request, HttpServletResponse response) throws Exception{
 		request.setCharacterEncoding("UTF-8");
 		
 		ModelAndView mav = new ModelAndView();
 		Util util = new Util();
 		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
 		
 		HttpSession session = request.getSession();
 		paramMap.put("empCode", session.getAttribute("empCode"));
 		paramMap.put("userName", session.getAttribute("userName"));
 		
 		mav.addObject("req_data",paramMap);
 		mav.setViewName("/yp/wr/wr_report_in_pop");
 		
 		return mav;
 	}
   
   
   /**
	 * JSON Flush 기능
	 * @param request
	 * @param response
	 * @param list
	 * @param from
	 */
	@SuppressWarnings({"rawtypes", "static-access"})
	private void JsonFlush(HttpServletRequest request, HttpServletResponse response, List list, String from) {
		PrintWriter out = null;
		try {
			Util util = new Util();
			String jsonString = JSONValue.toJSONString(list);
			response.setContentType("text/plain;charset=utf-8");// json
			jsonString = jsonString.replace("\"org.springframework.validation.BindingResult.string\":org.springframework.validation.BeanPropertyBindingResult: 0 errors,", "");
			
			// 20191026_khj XSS 필터적용
			jsonString = util.XSSFilter(jsonString);
			logger.debug("{} ReturnJson: {}", from, JsonEnterConvert(jsonString));
			
			out = response.getWriter();
			out.println(jsonString);
		} catch (IOException e) {
			logger.error("{} - {}", e.getMessage(), e);
			e.printStackTrace();
			System.err.println("IOException : " + e.getMessage());
		} catch (Throwable e) {
			logger.error("{} - {}", e.getMessage(), e);
			e.printStackTrace();
			System.err.println("Throwable : " + e.getMessage());
		} finally {
			out.flush();
			out.close();
		}
	}
	
	/**
	 * 디버깅용 JSON 보기좋게 표시
	 * @param json
	 * @return
	 */
	private String JsonEnterConvert(String json) {
		if (json == null || json.length() < 2) {
			return json;
		}
		
		final int len = json.length();
		final StringBuilder sb = new StringBuilder();
		char c;
		String tab = "";
		boolean beginEnd = true;
		for (int i = 0; i < len; i++) {
			c = json.charAt(i);
			switch (c) {
				case '{':
				case '[': {
					sb.append(c);
					if (beginEnd) {
						tab += "\t";
						sb.append("\n");
						sb.append(tab);
					}
					break;
				}
				case '}':
				case ']': {
					if (beginEnd) {
						tab = tab.substring(0, tab.length() - 1);
						sb.append("\n");
						sb.append(tab);
					}
					sb.append(c);
					break;
				}
				case '"': {
					if (json.charAt(i - 1) != '\\')
						beginEnd = !beginEnd;
					sb.append(c);
					break;
				}
				case ',': {
					sb.append(c);
					if (beginEnd) {
						sb.append("\n");
						sb.append(tab);
					}
					break;
				}
				default: {
					sb.append(c);
				}
			}// switch end
		}
		if (sb.length() > 0)
			sb.insert(0, '\n');
		return sb.toString();
	}
	
  
	/**
	 * byte단위로 문자열을 자르는 함수
	 *  - 2바이트, 3바이트 문자열이 잘리는 부분은 제거 (한글 등)
	 *  - 자르고 뒤에 ...을 붙인다.
	 * @param str : 자를 문자열
	 * @param cutlen : 자를 바이트 수
	 * @return 자르고 뒤에 ...을 붙인 문자열
	 */
	private String subStrByte(String str, int cutlen) {
		if(!str.isEmpty()) {
			str = str.trim();
			if(str.getBytes().length <= cutlen) {
				return str;
			} else {
				StringBuffer sbStr = new StringBuffer(cutlen);
				int nCnt = 0;
				for(char ch: str.toCharArray())
				{
					nCnt += String.valueOf(ch).getBytes().length;
					if(nCnt > cutlen)  break;
					sbStr.append(ch);
				}
				return sbStr.toString();
			}
		}
		else {
			return "";
		}
	}
   
}