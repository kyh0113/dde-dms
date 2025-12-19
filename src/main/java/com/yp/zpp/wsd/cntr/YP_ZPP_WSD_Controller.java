package com.yp.zpp.wsd.cntr;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.vicurus.it.core.common.Util;
import com.yp.common.srvc.intf.CommonService;
import com.yp.edoc.zpp.ore.srvc.intf.YPEdocService;
import com.yp.login.srvc.intf.YPLoginService;
import com.yp.util.DateUtil;
import com.yp.zpp.wsd.srvc.intf.YP_ZPP_WSD_Service;


@Controller
public class YP_ZPP_WSD_Controller {

	@Autowired
	private YP_ZPP_WSD_Service zppService;
	@Autowired
	private CommonService commonService;
	@Autowired
	private YPLoginService lService;
	
	@Autowired
	private YPEdocService edocService;
	
	@Value("#{config['session.outTime']}")
	private int sessionoutTime;
	
	@Value("#{config['sys.action_log']}")
	private String action_log;
	
	
	
	private static final Logger logger = LoggerFactory.getLogger(YP_ZPP_WSD_Controller.class);

	/**
	 * 생산관리 > 캐소드 블렌딩 예측 등록 리스트 화면
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zpp/ctd/zpp_ctd_dashboard", method = RequestMethod.POST)
	public ModelAndView zpp_ctd_dashboard(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 캐소드 블렌딩");
		ModelAndView mav = new ModelAndView();
		mav.addObject("hierarchy", "000004");
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		// session attr to param
		HttpSession session = request.getSession();

		paramMap.put("sdate", DateUtil.getToday());
		paramMap.put("edate", DateUtil.getToday());

		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", ((String) session.getAttribute("userName")));
		paramMap.put("dept_cd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("dept_name", ((String) session.getAttribute("userDept")));
		paramMap.put("auth", (String) session.getAttribute("PP_AUTH"));
		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");

		paramMap.put("type", "wsd_type");
		paramMap.put("type_level", "1");
		List<HashMap<String, String>> clist1 = commonService.code_list(paramMap);
		paramMap.put("type", "wsd_type");
		paramMap.put("type_level", "2");
		if(paramMap.get("srch_type1") != null) paramMap.put("upper_val", paramMap.get("srch_type1"));
		else paramMap.put("upper_val", "배소");
		List<HashMap<String, String>> clist2 = commonService.code_list(paramMap);

		LocalDate now = LocalDate.now();
		String start_date = String.format("%04d%02d%02d", now.getYear(), now.getMonthValue(), now.getDayOfMonth());
		String end_date = start_date;
		HashMap pm1 = new HashMap<String, String>();
		pm1.put("sdate",  start_date + "000000");
		pm1.put("edate",  end_date + "235959");
		List cathode_list = zppService.zpp_ctd_cathode_list(pm1);

		logger.debug("{}", cathode_list);

		mav.addObject("list", cathode_list);
		mav.addObject("clist2", clist2);
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/ctd/zpp_ctd_dashboard");

		return mav;
	}

	//	캐소드 블렌딩 등록
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/ctd/zpp_ctd_register_popup")
	public ModelAndView zpp_ctd_register_popup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 캐소드 블렌딩 등록 화면");

		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("target", paramMap.get("target"));

		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/ctd/zpp_ctd_register_popup");

		return mav;
	}

	/**
	 * 생산관리 > 캐소드 블렌딩 등록조회 > 캐소드 블렌딩 작업 지시 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/ctd/zpp_ctd_insert_master", method = RequestMethod.POST)
	public ModelAndView zpp_ctd_insert_master(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 캐소드 블렌딩 등록 화면 > 데이터 저장");
		
		Util util = new Util();
		HashMap<String, Object> req_data = (HashMap<String, Object>) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		//	Job Index는 현재 시각 기준으로 생성
		LocalDate now_d = LocalDate.now();
		LocalTime now_t = LocalTime.now();
		String regDate = String.format("%04d%02d%02d%02d%02d%02d",
			now_d.getYear(), now_d.getMonthValue(), now_d.getDayOfMonth(), now_t.getHour(), now_t.getMinute(), now_t.getSecond());
		logger.debug("[TEST]regDate:{}",regDate);
		logger.debug("[TEST]JOB_TIME:{}",req_data.get("JOB_TIME"));
		logger.debug("[TEST]MACHINE_NO:{}",req_data.get("MACHINE_NO"));
		
		String jobIndex = regDate + req_data.get("JOB_TIME") + req_data.get("MACHINE_NO");
		logger.debug("[TEST]jobIndex:{}",jobIndex);

		paramMap.put("JOB_INDEX", 		jobIndex);
		paramMap.put("JOB_DATE", 		(String) req_data.get("JOB_DATE"));
		paramMap.put("MACHINE_NO", 		(String) req_data.get("MACHINE_NO"));
		paramMap.put("JOB_TIME", 		(String) req_data.get("JOB_TIME"));
		paramMap.put("WORKER", 			(String) req_data.get("WORKER"));
		paramMap.put("REMAIN_AOUNT", 	req_data.get("REMAIN_AMOUNT"));
		paramMap.put("REMAIN_LEVEL", 	req_data.get("REMAIN_LEVEL"));
		paramMap.put("M1_LOT_CNT", 		req_data.get("M1_LOT_CNT"));
		paramMap.put("M1_WEIGHT", 		req_data.get("M1_WEIGHT"));
		paramMap.put("M1_RESULT", 		0);
		paramMap.put("M2_LOT_CNT", 		req_data.get("M2_LOT_CNT"));
		paramMap.put("M2_WEIGHT", 		req_data.get("M2_WEIGHT"));
		paramMap.put("M2_RESULT", 		0);
		paramMap.put("M3_LOT_CNT", 		req_data.get("M3_LOT_CNT"));
		paramMap.put("M3_WEIGHT", 		req_data.get("M3_WEIGHT"));
		paramMap.put("M3_RESULT", 		0);
		paramMap.put("M4_LOT_CNT", 		req_data.get("M4_LOT_CNT"));
		paramMap.put("M4_WEIGHT", 		req_data.get("M4_WEIGHT"));
		paramMap.put("M4_RESULT", 		0);
		paramMap.put("M5_LOT_CNT", 		req_data.get("M5_LOT_CNT"));
		paramMap.put("M5_WEIGHT", 		req_data.get("M5_WEIGHT"));
		paramMap.put("M5_RESULT", 		0);
		paramMap.put("M6_LOT_CNT", 		req_data.get("M6_LOT_CNT"));
		paramMap.put("M6_WEIGHT", 		req_data.get("M6_WEIGHT"));
		paramMap.put("M6_RESULT", 		0);
		paramMap.put("M7_LOT_CNT", 		req_data.get("M7_LOT_CNT"));
		paramMap.put("M7_WEIGHT", 		req_data.get("M7_WEIGHT"));
		paramMap.put("M7_RESULT", 		0);
		paramMap.put("M8_LOT_CNT", 		req_data.get("M8_LOT_CNT"));
		paramMap.put("M8_WEIGHT", 		req_data.get("M8_WEIGHT"));
		paramMap.put("M8_RESULT", 		0);
		paramMap.put("PREDICT_LEVEL", 	req_data.get("PREDICT_LEVEL"));
		paramMap.put("TABLET_WORKER", 	"");
		paramMap.put("TABLET_REG_DATETIME", 	"");
		paramMap.put("REG_DATE", 		regDate);

		//	logger.debug("{}", paramMap);

		String result = zppService.zpp_ctd_insert_master(paramMap);
		
		HashMap<String, String> json = new HashMap<String, String>();
		json.put("result", "success");

		return new ModelAndView("DataToJson", json);
	}

	//	캐소드 블렌딩 SETUP
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/ctd/zpp_ctd_setup_popup")
	public ModelAndView zpp_ctd_setup_popup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 캐소드 블렌딩 SETUP");

		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("target", paramMap.get("target"));

		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/ctd/zpp_ctd_setup_popup");

		return mav;
	}

	/**
	 * 생산관리 > 캐소드 블렌딩 등록 조회 > 기본SETTING 읽어오기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ctd/zpp_ctd_envdata", method = RequestMethod.POST)
	public ModelAndView zpp_ctd_envdata(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, String> json = zppService.zpp_ctd_envdata(paramMap);
		
		return new ModelAndView("DataToJson", json);
	}

	/**
	 * 생산관리 > 캐소드 블렌딩 등록조회 > 캐소드 블렌딩 작업 지시 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/ctd/zpp_ctd_insert_envdata", method = RequestMethod.POST)
	public ModelAndView zpp_ctd_insert_envdata(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 캐소드 블렌딩 셋업 화면 > 데이터 저장");
		
		Util util = new Util();
		HashMap<String, Object> req_data = (HashMap<String, Object>) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		logger.debug("{}", paramMap);

		String result = zppService.zpp_ctd_insert_envdata(paramMap);
		
		HashMap<String, String> json = new HashMap<String, String>();
		json.put("result", "success");

		return new ModelAndView("DataToJson", json);
	}

	/**
	 * 생산관리 > 캐스트 블렌딩 등록조회 > 그래프 데이터 읽어오기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ctd/zpp_ctd_graph_list", method = RequestMethod.POST)
	public ModelAndView zpp_ctd_graph_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		List<HashMap<String, String>> jsonList = zppService.zpp_ctd_graph_list(paramMap);

		Map resultMap = new HashMap();
		resultMap.put("graphList", jsonList);

		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 생산관리 > 정광 - 정광 수입BL 정보 현황 (원료팀)
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_bl_list", method = RequestMethod.POST)
	public ModelAndView zpp_ore_bl_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 - 정광수입BL정보현황");
		ModelAndView mav = new ModelAndView();
		mav.addObject("hierarchy", "000004");
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		// session attr to param
		HttpSession session = request.getSession();

		Calendar cal = Calendar.getInstance();
		String format = "yyyy/MM/dd";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		cal.add(cal.YEAR, -3); 	//	3년 전 날짜
		String date_str = sdf.format(cal.getTime());
		
		paramMap.put("sdate", date_str);
		paramMap.put("edate", DateUtil.getToday());

		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", ((String) session.getAttribute("userName")));
		paramMap.put("dept_cd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("dept_name", ((String) session.getAttribute("userDept")));
		paramMap.put("auth", (String) session.getAttribute("PP_AUTH"));
		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");

		paramMap.put("type", "wsd_type");
		paramMap.put("type_level", "1");
		List<HashMap<String, String>> clist1 = commonService.code_list(paramMap);
		paramMap.put("type", "wsd_type");
		paramMap.put("type_level", "2");
		if(paramMap.get("srch_type1") != null) paramMap.put("upper_val", paramMap.get("srch_type1"));
		else paramMap.put("upper_val", "배소");
		List<HashMap<String, String>> clist2 = commonService.code_list(paramMap);

		LocalDate now = LocalDate.now();
		String start_date = String.format("%04d%02d%02d", now.getYear(), now.getMonthValue(), now.getDayOfMonth());
		String end_date = start_date;
		HashMap pm1 = new HashMap<String, String>();
		pm1.put("sdate",  start_date + "000000");
		pm1.put("edate",  end_date + "235959");
		List cathode_list = zppService.zpp_ctd_cathode_list(pm1);

		logger.debug("{}", cathode_list);

		mav.addObject("list", cathode_list);
		mav.addObject("clist2", clist2);
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/ore/zpp_ore_bl_list");

		return mav;
	}

	/**
	 * 생산관리 > 정광 > BL LIST 읽어오기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_req_bl_list", method = RequestMethod.POST)
	public ModelAndView zpp_ore_req_bl_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		List<HashMap<String, String>> jsonList = zppService.zpp_ore_req_bl_list(paramMap);

		Map resultMap = new HashMap();
		resultMap.put("bl_list", jsonList);

		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 생산관리 > 정광 > BL 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/ore/zpp_ore_insert_bl_info", method = RequestMethod.POST)
	public ModelAndView zpp_ore_insert_bl_info(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 > BL 데이터 저장");
		
		Util util = new Util();
		HashMap<String, Object> req_data = (HashMap<String, Object>) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		logger.debug("{}", paramMap);

		//	1:INSERT , 2:UPDATE
		String result1 = "";
		String result2 = "";

		if(Integer.parseInt((String) paramMap.get("MODE")) == 1) {
			logger.debug("BL INFO 저장 =>>> INSERT MODE");
			result1 = zppService.zpp_ore_insert_bl_info(paramMap);
			result2 = zppService.zpp_ore_insert_master_info(paramMap);
		}
		else {
			logger.debug("BL INFO 저장 =>>> UPDATE MODE");
			result1 = zppService.zpp_ore_update_bl_info(paramMap);
			result2 = zppService.zpp_ore_update_master_info(paramMap);
		}

		HashMap<String, String> json = new HashMap<String, String>();
		json.put("result", "success");

		return new ModelAndView("DataToJson", json);
	}

	/**
	 * 생산관리 > 정광 > 시험연구팀 초기 BL 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/ore/zpp_ore_insert_bl_info2", method = RequestMethod.POST)
	public ModelAndView zpp_ore_insert_bl_info2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 > 시험연구팀 초기 BL 데이터 저장");
		
		Util util = new Util();
		HashMap<String, Object> req_data = (HashMap<String, Object>) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		logger.debug("시험연구팀 저장 : {}", paramMap);

		//	1:INSERT , 2:UPDATE
		String result1 = "";
		String result2 = "";
		String result3 = "";

		if(Integer.parseInt((String) paramMap.get("MODE")) == 1) {
			logger.debug("BL INFO 저장 =>>> INSERT MODE");
			result1 = zppService.zpp_ore_insert_bl_info(paramMap);
			result2 = zppService.zpp_ore_insert_master_info(paramMap);

			String master_id = paramMap.get("MASTER_ID").toString();
			List<HashMap<String, String>> rl = get_Ingredient_List(master_id);

			logger.debug("정광입고검수결과등록 저장 =>>> INSERT MODE");
			String result = zppService.zpp_ore_insert_analysis_result(paramMap);

			for(int ac = 0;ac < rl.size();ac ++)
			{
				String ing_cd = rl.get(ac).get("INGREDIENT_ID");

				for(int i = 0;i < 30; i ++)
				{
					String dmt_field = String.format("DMT_%d", i + 1);
					double dmt_amount = Double.parseDouble(paramMap.get(dmt_field).toString());
					HashMap hm = new HashMap<String, String>();

					hm.clear();
					hm.put("MASTER_ID", master_id);
					hm.put("INGREDIENT_ID", ing_cd);
					hm.put("LOT_NO", String.format("%d", i + 1));
					hm.put("DMT", String.format("%f", dmt_amount));

					zppService.zpp_ore_insert_analysis_dmt(hm);
				}
			}

			paramMap.put("status", 1);
			zppService.zpp_ore_update_state(paramMap);

			logger.debug("정광 성분분석 결과 초기값 저장 =>>> INSERT MODE");
			logger.debug("시험연구팀 저장 #2 : {}", paramMap);
			result3 = zppService.zpp_ore_insert_init_value(paramMap);

			paramMap.put("status", 2);
			zppService.zpp_ore_update_state(paramMap);
		}
		else {
			logger.debug("BL INFO 저장 =>>> UPDATE MODE");
			result1 = zppService.zpp_ore_update_bl_info(paramMap);
			result2 = zppService.zpp_ore_update_master_info(paramMap);

			String master_id = paramMap.get("MASTER_ID").toString();
			List<HashMap<String, String>> rl = get_Ingredient_List(master_id);

			logger.debug("정광입고검수결과등록 저장 =>>> UPDATE MODE");
			String result = zppService.zpp_ore_update_analysis_result(paramMap);

			for(int ac = 0;ac < rl.size();ac ++)
			{
				String ing_cd = rl.get(ac).get("INGREDIENT_ID");

				for(int i = 0;i < 30; i ++)
				{
					String dmt_field = String.format("DMT_%d", i + 1);
					double dmt_amount = Double.parseDouble(paramMap.get(dmt_field).toString());
					HashMap hm = new HashMap<String, String>();

					hm.clear();
					hm.put("MASTER_ID", master_id);
					hm.put("INGREDIENT_ID", ing_cd);
					hm.put("LOT_NO", String.format("%d", i + 1));
					hm.put("DMT", String.format("%f", dmt_amount));

					zppService.zpp_ore_update_analysis_dmt(hm);
				}
			}

			logger.debug("정광 성분분석 결과 초기값 저장 =>>> UPDATE MODE");
			result3 = zppService.zpp_ore_update_init_value(paramMap);
		}

		zppService.zpp_ore_update_master_lot_count(paramMap);

		HashMap<String, String> json = new HashMap<String, String>();
		json.put("result", "success");

		return new ModelAndView("DataToJson", json);
	}

	/**
	 * 생산관리 > 정광 > B/L 정보 읽어오기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_req_bl_info", method = RequestMethod.POST)
	public ModelAndView zpp_ore_req_bl_info(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> result = new HashMap();
		if(zppService.zpp_ore_bl_info_count(paramMap) > 0) {
			HashMap<String, String> json = zppService.zpp_ore_load_bl_info(paramMap);
			result.put("data_count", 1);
			result.put("data", json);
		}
		else {
			result.put("data_count", 0);
		}

		return new ModelAndView("DataToJson", result);
	}


	/**
	 * 생산관리 > 정광 > 시험연구팀 등록 정보 읽어오기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_req_bl_info2", method = RequestMethod.POST)
	public ModelAndView zpp_ore_req_bl_info2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> result = new HashMap();

		if(zppService.zpp_ore_bl_info_count(paramMap) > 0) {
			HashMap<String, String> json_res = new HashMap();

			HashMap<String, String> json_bl_info = zppService.zpp_ore_load_bl_info(paramMap);
			HashMap<String, String> json_master_info = zppService.zpp_ore_load_analysis_master(paramMap);
			HashMap<String, String> json_component_res = zppService.zpp_ore_load_component_analysis_info(paramMap);
			HashMap<String, String> json_mt_info = zppService.zpp_ore_load_mt_info(paramMap);

			json_res.put("VESSEL_NAME", json_master_info.get("VESSEL_NAME").toString());
			json_res.put("DMT", String.valueOf(json_bl_info.get("DMT")));
			json_res.put("LBL_IG_1", json_bl_info.get("LBL_IG_1").toString());
			json_res.put("LBL_IG_2", json_bl_info.get("LBL_IG_2").toString());

			if(json_bl_info.get("LBL_IG_3") == null) json_res.put("LBL_IG_3", "");
			else json_res.put("LBL_IG_3", json_bl_info.get("LBL_IG_3").toString());

			if(json_bl_info.get("LBL_IG_4") == null) json_res.put("LBL_IG_4", "");
			else json_res.put("LBL_IG_4", json_bl_info.get("LBL_IG_4").toString());

			for(int i = 0;i < 31;i ++)
			{
				String key_name = String.format("IG_CODE_%d", i + 1);
				String val_name = String.format("IG_VALUE_%d", i + 1);

				json_res.put(key_name, json_component_res.get(key_name).toString());
				json_res.put(val_name, String.valueOf(json_component_res.get(val_name)));
			}

			json_res.put("PM_100_VALUE", String.valueOf(json_component_res.get("PM_100_VALUE")));
			json_res.put("PM_200_VALUE", String.valueOf(json_component_res.get("PM_200_VALUE")));
			json_res.put("PM_325_VALUE", String.valueOf(json_component_res.get("PM_325_VALUE")));
			json_res.put("PM_400_VALUE", String.valueOf(json_component_res.get("PM_400_VALUE")));
			json_res.put("PM_M400_VALUE", String.valueOf(json_component_res.get("PM_M400_VALUE")));

			json_res.put("LOT_COUNT", String.valueOf(json_master_info.get("LOT_COUNT")));

			String ig_code = json_bl_info.get("LBL_IG_1").toString();

			HashMap hm = new HashMap<String, String>();

			for(int i = 0;i < 30;i ++)
			{
				hm.put("MASTER_ID", paramMap.get("MASTER_ID").toString());
				hm.put("INGREDIENT_ID", ig_code);
				hm.put("LOT_NO", i + 1);

				HashMap<String, String> ar_res = zppService.zpp_ore_get_ar_value(hm);

				String dmt_name = String.format("DMT_%d", i + 1);

				json_res.put(dmt_name, String.valueOf(json_mt_info.get(dmt_name)));

				for(int j = 0;j < 4;j ++)
				{
					String key_name = String.format("LOT_%d_IG_%d_VALUE", i + 1, j + 1);

					json_res.put(key_name, String.valueOf(json_component_res.get(key_name)));
				}
			}

			if(json_bl_info.get("CPS_IG_1") == null) json_res.put("CPS_IG_1", "");
			else json_res.put("CPS_IG_1", json_bl_info.get("CPS_IG_1").toString());

			if(json_bl_info.get("CPS_IG_2") == null) json_res.put("CPS_IG_2", "");
			else json_res.put("CPS_IG_2", json_bl_info.get("CPS_IG_2").toString());

			if(json_bl_info.get("CPS_IG_3") == null) json_res.put("CPS_IG_3", "");
			else json_res.put("CPS_IG_3", json_bl_info.get("CPS_IG_3").toString());

			if(json_bl_info.get("CPS_IG_4") == null) json_res.put("CPS_IG_4", "");
			else json_res.put("CPS_IG_4", json_bl_info.get("CPS_IG_4").toString());

			if(json_bl_info.get("CPS_IG_5") == null) json_res.put("CPS_IG_5", "");
			else json_res.put("CPS_IG_5", json_bl_info.get("CPS_IG_5").toString());

			logger.debug("{}", json_res);

			result.put("data_count", 1);
			result.put("data", json_res);
		}
		else {
			result.put("data_count", 0);
		}

		return new ModelAndView("DataToJson", result);
	}

	//	생산관리 > 정광 - 정광성분분석요청
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/ore/zpp_ore_request_popup")
	public ModelAndView zpp_ore_request_popup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 - 정광성분분석요청");

		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("target", paramMap.get("target"));

		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/ore/zpp_ore_request_popup");

		return mav;
	}

	//	생산관리 > 정광 - 시험연구팀 결과 등록
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/ore/zpp_ore_test_register_popup")
	public ModelAndView zpp_ore_test_register_popup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 - 시험연구팀 결과 등록");

		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("target", paramMap.get("target"));

		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/ore/zpp_ore_test_register_popup");

		return mav;
	}

	//	생산관리 > 정광 - 정광입고검수결과등록
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/ore/zpp_ore_register_popup")
	public ModelAndView zpp_ore_register_popup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 - 정광입고검수결과등록");

		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("target", paramMap.get("target"));

		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/ore/zpp_ore_register_popup");

		return mav;
	}

	/**
	 * 생산관리 > 정광 > 정광입고검수결과등록 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/ore/zpp_ore_insert_result", method = RequestMethod.POST)
	public ModelAndView zpp_ore_insert_result(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 > 정광입고검수결과등록 저장");
		
		Util util = new Util();
		HashMap<String, Object> req_data = (HashMap<String, Object>) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		logger.debug("{}", paramMap);

		//	1:INSERT , 2:UPDATE
		String result = "";
		String master_id = paramMap.get("MASTER_ID").toString();
		List<HashMap<String, String>> rl = get_Ingredient_List(master_id);

		if(Integer.parseInt((String) paramMap.get("MODE")) == 1) {
			logger.debug("정광입고검수결과등록 저장 =>>> INSERT MODE");
			result = zppService.zpp_ore_insert_analysis_result(paramMap);

			for(int ac = 0;ac < rl.size();ac ++)
			{
				String ing_cd = rl.get(ac).get("INGREDIENT_ID");

				for(int i = 0;i < 30; i ++)
				{
					String dmt_field = String.format("DMT_%d", i + 1);
					double dmt_amount = Double.parseDouble(paramMap.get(dmt_field).toString());
					HashMap hm = new HashMap<String, String>();

					hm.clear();
					hm.put("MASTER_ID", master_id);
					hm.put("INGREDIENT_ID", ing_cd);
					hm.put("LOT_NO", String.format("%d", i + 1));
					hm.put("DMT", String.format("%f", dmt_amount));

					zppService.zpp_ore_insert_analysis_dmt(hm);
				}
			}

			paramMap.put("status", 1);
			zppService.zpp_ore_update_state(paramMap);
		}
		else {
			logger.debug("정광입고검수결과등록 저장 =>>> UPDATE MODE");
			result = zppService.zpp_ore_update_analysis_result(paramMap);

			for(int ac = 0;ac < rl.size();ac ++)
			{
				String ing_cd = rl.get(ac).get("INGREDIENT_ID");

				for(int i = 0;i < 30; i ++)
				{
					String dmt_field = String.format("DMT_%d", i + 1);
					double dmt_amount = Double.parseDouble(paramMap.get(dmt_field).toString());
					HashMap hm = new HashMap<String, String>();

					hm.clear();
					hm.put("MASTER_ID", master_id);
					hm.put("INGREDIENT_ID", ing_cd);
					hm.put("LOT_NO", String.format("%d", i + 1));
					hm.put("DMT", String.format("%f", dmt_amount));

					zppService.zpp_ore_update_analysis_dmt(hm);
				}
			}
		}

		zppService.zpp_ore_update_master_lot_count(paramMap);

		HashMap<String, String> json = new HashMap<String, String>();
		json.put("result", "success");

		return new ModelAndView("DataToJson", json);
	}

	/**
	 * 생산관리 > 정광 > 수량등록정보 읽어오기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_req_mt_info", method = RequestMethod.POST)
	public ModelAndView zpp_ore_req_mt_info(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> result = new HashMap();
		if(zppService.zpp_ore_mt_info_count(paramMap) > 0) {
			HashMap<String, String> json = zppService.zpp_ore_load_mt_info(paramMap);
			result.put("data_count", 1);
			result.put("data", json);
		}
		else {
			result.put("data_count", 0);
		}

		return new ModelAndView("DataToJson", result);
	}

	//	생산관리 > 정광 - 정광 성분분석 결과 초기값 등록
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/ore/zpp_ore_init_value")
	public ModelAndView zpp_ore_init_value(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 - 정광성분분석결과초기값등록");

		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("target", paramMap.get("target"));

		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/ore/zpp_ore_init_value");

		return mav;
	}

	/**
	 * 생산관리 > 정광 > 정광 성분분석 결과 초기값 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/ore/zpp_ore_insert_init_value", method = RequestMethod.POST)
	public ModelAndView zpp_ore_insert_init_value(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 > 정광 성분분석 결과 초기값 저장");
		
		Util util = new Util();
		HashMap<String, Object> req_data = (HashMap<String, Object>) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		logger.debug("{}", paramMap);

		String result = "";

		if(Integer.parseInt((String) paramMap.get("MODE")) == 1) {
			logger.debug("정광 성분분석 결과 초기값 저장 =>>> INSERT MODE");
			result = zppService.zpp_ore_insert_init_value(paramMap);
			paramMap.put("status", 2);
			zppService.zpp_ore_update_state(paramMap);
		}
		else {
			logger.debug("정광 성분분석 결과 초기값 저장 =>>> UPDATE MODE");
			result = zppService.zpp_ore_update_init_value(paramMap);
		}

		HashMap<String, String> json = new HashMap<String, String>();
		json.put("result", "success");

		return new ModelAndView("DataToJson", json);
	}

	/**
	 * 생산관리 > 정광 > 기존 초기값 읽어오기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_req_component_analysis_info", method = RequestMethod.POST)
	public ModelAndView zpp_ore_req_component_analysis_info(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> result = new HashMap();
		if(zppService.zpp_ore_component_analysis_info_count(paramMap) > 0) {
			logger.debug("lot_count : " + zppService.zpp_ore_get_lot_count(paramMap));

			HashMap<String, String> json = zppService.zpp_ore_load_component_analysis_info(paramMap);
			json.put("LOT_COUNT", Integer.toString(zppService.zpp_ore_get_lot_count(paramMap)));
			result.put("data_count", 1);
			result.put("data", json);
		}
		else {
			result.put("data_count", 0);

			HashMap<String, String> json = new HashMap<String, String>();
			json.put("LOT_COUNT", Integer.toString(zppService.zpp_ore_get_lot_count(paramMap)));
			result.put("data", json);
		}

		return new ModelAndView("DataToJson", result);
	}

	/**
	 * 생산관리 >정광 > 정광 성분분석 초기값 불러오기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_get_init_value", method = RequestMethod.POST)
	public ModelAndView zpp_ore_get_init_value(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		List<HashMap<String, String>> jsonList = zppService.zpp_ore_get_init_value(paramMap);

		Map resultMap = new HashMap();
		resultMap.put("initValueList", jsonList);

		return new ModelAndView("DataToJson", resultMap);
	}

	//	생산관리 > 정광 - 정광 성분분석 초기값 조정
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/ore/zpp_ore_adjust_value")
	public ModelAndView zpp_ore_adjust_value(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 - 정광성분분석초기값조정");

		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("target", paramMap.get("target"));

		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/ore/zpp_ore_adjust_value");

		return mav;
	}

	/**
	 * 생산관리 > 정광 > 정광 성분분석 결과 조정값 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/ore/zpp_ore_update_adjust_value", method = RequestMethod.POST)
	public ModelAndView zpp_ore_update_adjust_value(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 > 정광 성분분석 결과 조정값 저장");
		
		Util util = new Util();
		HashMap<String, Object> req_data = (HashMap<String, Object>) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		logger.debug("{}", paramMap);

		String result = zppService.zpp_ore_update_adjust_value(paramMap);

		//	TBL_ORE_ANALYSIS_RESULT에도 UPDATE
		String master_id = paramMap.get("MASTER_ID").toString();
		List<HashMap<String, String>> rl = get_Ingredient_List(master_id);

		for(int ac = 0;ac < rl.size();ac ++)
		{
			String ing_cd = rl.get(ac).get("INGREDIENT_ID");

			for(int i = 0;i < 22;i ++)
			{
				HashMap hm = new HashMap<String, String>();

				String ig_field = String.format("IG_%d_%d", ac + 1, i + 1);
				double ig_amount = Double.parseDouble(paramMap.get(ig_field).toString());

				hm.clear();
				hm.put("MASTER_ID", master_id);
				hm.put("INGREDIENT_ID", ing_cd);
				hm.put("LOT_NO", String.format("%d", i + 1));
				hm.put("YP", String.format("%f", ig_amount));

				zppService.zpp_ore_update_analysis_yp(hm);
			}
		}

		paramMap.put("status", 3);
		zppService.zpp_ore_update_state(paramMap);

		HashMap<String, String> json = new HashMap<String, String>();
		json.put("result", "success");

		return new ModelAndView("DataToJson", json);
	}

	//	생산관리 > 정광 - 정광 성분분석 최종값 조회
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/ore/zpp_ore_fixed_value")
	public ModelAndView zpp_ore_fixed_value(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 - 정광성분분석최종값조회");

		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		// 공통 - 네비게이션 시작
		List breadcrumbList = lService.select_breadcrumb_hierarchy(request, response);
		Map currentMenuInfo = (Map) breadcrumbList.get(breadcrumbList.size()-1);
		mav.addObject("breadcrumbList", breadcrumbList);
		mav.addObject("current_menu", currentMenuInfo);
		// 공통 - 네비게이션 끝
		
		/**
		 * 2022-11-18 smh 전자결재 유무 추가
		 */
		Map oreEdocInfoMap = edocService.select_ore_edoc_info_single(paramMap);
		logger.debug("[TEST]menu_id:{}", paramMap.get("MENU_ID"));
		logger.debug("[TEST]oreEdocInfoMap:{}", oreEdocInfoMap);

		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("target", paramMap.get("target"));
		paramMap.put("menu_id", currentMenuInfo.get("menu_id"));

		mav.addObject("req_data", paramMap);
		
		String jsonString = JSONValue.toJSONString(oreEdocInfoMap);
		mav.addObject("oreEdocInfoMap", jsonString);
		
		mav.setViewName("/yp/zpp/ore/zpp_ore_fixed_value");
		
		return mav;
	}

	//	생산관리 > 정광 - SELLER 송부용 분석결과 조회
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/ore/zpp_ore_popup_seller_query")
	public ModelAndView zpp_ore_popup_seller_query(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 - SELLER 솓부용 분석결과 조회");

		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		// 공통 - 네비게이션 시작
		List breadcrumbList = lService.select_breadcrumb_hierarchy(request, response);
		Map currentMenuInfo = (Map) breadcrumbList.get(breadcrumbList.size()-1);
		mav.addObject("breadcrumbList", breadcrumbList);
		mav.addObject("current_menu", currentMenuInfo);
		// 공통 - 네비게이션 끝
		
		/**
		 * 2022-12-16 smh 전자결재 유무 추가
		 */
		paramMap.put("MENU_ID", currentMenuInfo.get("menu_id"));
		Map oreEdocInfoMap = edocService.select_ore_edoc_info_single(paramMap);
		logger.debug("[TEST]menu_id:{}", paramMap.get("MENU_ID"));
		logger.debug("[TEST]oreEdocInfoMap:{}", oreEdocInfoMap);
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("target", paramMap.get("target"));

		mav.addObject("req_data", paramMap);
		
		String jsonString = JSONValue.toJSONString(oreEdocInfoMap);
		mav.addObject("oreEdocInfoMap", jsonString);
		
		mav.setViewName("/yp/zpp/ore/zpp_ore_popup_seller_query");

		return mav;
	}

	/**
	 * 생산관리 >정광 > SELLER 성분 분석결과 값 불러오기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_get_seller_value", method = RequestMethod.POST)
	public ModelAndView zpp_ore_get_seller_value(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		logger.debug("생산관리 >정광 > SELLER 성분 분석결과 값 불러오기");
		logger.debug("{}", paramMap);

		Map resultMap = new HashMap();
		String master_id = paramMap.get("MASTER_ID").toString();
		List<HashMap<String, String>> rl = get_Ingredient_List(master_id);

		for(int ac = 0;ac < rl.size();ac ++)
		{
			String ing_cd = rl.get(ac).get("INGREDIENT_ID");

			for(int i = 0;i < 30;i ++)
			{
				HashMap hm = new HashMap<String, String>();

				hm.clear();
				hm.put("MASTER_ID", master_id);
				hm.put("INGREDIENT_ID", ing_cd);
				hm.put("LOT_NO", Integer.toString(i + 1));

				logger.debug("HM Contents : {}", hm);

				double seller_value = zppService.zpp_ore_get_seller_value(hm);
				String key_name = String.format("LOT_%d_IG_%d_VALUE", i + 1, ac + 1);
				resultMap.put(key_name, seller_value);
			}
		}

		resultMap.put("LOT_COUNT", Integer.toString(zppService.zpp_ore_get_lot_count(paramMap)));

		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 생산관리 >정광 > SELLER 성분 분석결과 값 저장하기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_set_seller_value", method = RequestMethod.POST)
	public ModelAndView zpp_ore_set_seller_value(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HashMap hm = new HashMap<String, String>();

		Map resultMap = new HashMap();
		String master_id = paramMap.get("MASTER_ID").toString();
		List<HashMap<String, String>> rl = get_Ingredient_List(master_id);

		for(int ac = 0;ac < rl.size();ac ++)
		{
			String ing_cd = rl.get(ac).get("INGREDIENT_ID");

			for(int i = 0;i < 22;i ++)
			{
				String key_name = String.format("LOT_%d_IG_%d_VALUE", i + 1, ac + 1);
				Double key_value = Double.parseDouble(paramMap.get(key_name).toString());

				hm.clear();
				hm.put("MASTER_ID", master_id);
				hm.put("INGREDIENT_ID", ing_cd);
				hm.put("LOT_NO", Integer.toString(i + 1));
				hm.put("SELLER", key_value);
				zppService.zpp_ore_set_seller_value(hm);
			}
		}

		paramMap.put("status", 4);
		zppService.zpp_ore_update_state(paramMap);

		return new ModelAndView("DataToJson", resultMap);
	}

	//	생산관리 > 정광 - SELLER 성분 분석결과 비교조회
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/ore/zpp_ore_popup_compare")
	public ModelAndView zpp_ore_popup_compare(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 - SELLER 성분 분석결과 비교조회");

		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		// 공통 - 네비게이션 시작
		List breadcrumbList = lService.select_breadcrumb_hierarchy(request, response);
		Map currentMenuInfo = (Map) breadcrumbList.get(breadcrumbList.size()-1);
		mav.addObject("breadcrumbList", breadcrumbList);
		mav.addObject("current_menu", currentMenuInfo);
		// 공통 - 네비게이션 끝
		
		/**
		 * 2022-12-16 smh 전자결재 유무 추가
		 */
		paramMap.put("MENU_ID", currentMenuInfo.get("menu_id"));
		Map oreEdocInfoMap = edocService.select_ore_edoc_info_single(paramMap);
		logger.debug("[TEST]menu_id:{}", paramMap.get("MENU_ID"));
		logger.debug("[TEST]oreEdocInfoMap:{}", oreEdocInfoMap);
		String jsonString = JSONValue.toJSONString(oreEdocInfoMap);
		mav.addObject("oreEdocInfoMap", jsonString);
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("target", paramMap.get("target"));

		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/ore/zpp_ore_popup_compare");

		return mav;
	}

	/**
	 * 생산관리 >정광 > YP / SELLER 성분 분석결과 불러오기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_get_compare_value", method = RequestMethod.POST)
	public ModelAndView zpp_ore_get_compare_value(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HashMap hm = new HashMap<String, String>();

		Map resultMap = new HashMap();
		String master_id = paramMap.get("MASTER_ID").toString();
		List<HashMap<String, String>> rl = get_Ingredient_List(master_id);

		for(int ac = 0;ac < rl.size();ac ++)
		{
			String ing_cd = rl.get(ac).get("INGREDIENT_ID");

			for(int i = 0;i < 30;i ++)
			{
				hm.clear();
				hm.put("MASTER_ID", master_id);
				hm.put("INGREDIENT_ID", ing_cd);
				hm.put("LOT_NO", Integer.toString(i + 1));

				logger.debug("hm : {}", hm);

				double dmt_value = zppService.zpp_ore_get_dmt_value(hm);
				double yp_value = zppService.zpp_ore_get_yp_value(hm);
				double seller_value = zppService.zpp_ore_get_seller_value(hm);
				String yp_action = zppService.zpp_ore_get_yp_action(hm);

				String key_name = String.format("DMT_%d_%d", i + 1, ac + 1);
				resultMap.put(key_name, dmt_value);

				key_name = String.format("YP_%d_%d", i + 1, ac + 1);
				resultMap.put(key_name, yp_value);

				key_name = String.format("SELLER_%d_%d", i + 1, ac + 1);
				resultMap.put(key_name, seller_value);

				key_name = String.format("YP_ACTION_%d_%d", i + 1, ac + 1);
				if(yp_action.equals("UMPIRE")) resultMap.put(key_name, 1);
				else if(yp_action.equals("SPLIT")) resultMap.put(key_name, 2);
				else resultMap.put(key_name, 0);
			}
		}
		resultMap.put("LOT_COUNT", Integer.toString(zppService.zpp_ore_get_lot_count(paramMap)));
		
		/**
		 * 2022-12-16 smh 전자결재 유무 추가
		 */
		Map oreEdocInfoMap = edocService.select_ore_edoc_info_single(paramMap);
		resultMap.put("oreEdocInfoMap", oreEdocInfoMap);

		return new ModelAndView("DataToJson", resultMap);
	}

	//	생산관리 > 정광 - SELLER 성분 분석결과 등록
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/ore/zpp_ore_popup_seller_register")
	public ModelAndView zpp_ore_popup_seller_register(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 - SELLER 성분 분석결과 등록");

		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("target", paramMap.get("target"));

		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/ore/zpp_ore_popup_seller_register");

		return mav;
	}

	/**
	 * 생산관리 >정광 > 정광 성분분석 최종값 불러오기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_get_fixed_value", method = RequestMethod.POST)
	public ModelAndView zpp_ore_get_fixed_value(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		ModelAndView mav = new ModelAndView();
		
		HashMap<String, String> jsonList = zppService.zpp_ore_get_fixed_value(paramMap);
		String lotCount = Integer.toString(zppService.zpp_ore_get_lot_count(paramMap));
		
		/**
		 * 2022-12-16 smh 전자결재 유무 추가
		 */
		Map oreEdocInfoMap = edocService.select_ore_edoc_info_single(paramMap);

		Map resultMap = new HashMap();
		resultMap.put("fixedValueList", jsonList);
		resultMap.put("LOT_COUNT", lotCount);
		resultMap.put("oreEdocInfoMap", oreEdocInfoMap);

		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 생산관리 > 정광 - 성분분석 결과 등록
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_reg_result", method = RequestMethod.POST)
	public ModelAndView zpp_ore_reg_result(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 - 성분분석 결과 등록");
		ModelAndView mav = new ModelAndView();
		mav.addObject("hierarchy", "000004");
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		// session attr to param
		HttpSession session = request.getSession();

		Calendar cal = Calendar.getInstance();
		String format = "yyyy/MM/dd";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		cal.add(cal.YEAR, -3); 	//	3년 전 날짜
		String date_str = sdf.format(cal.getTime());
		
		paramMap.put("sdate", date_str);
		paramMap.put("edate", DateUtil.getToday());

		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", ((String) session.getAttribute("userName")));
		paramMap.put("dept_cd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("dept_name", ((String) session.getAttribute("userDept")));
		paramMap.put("auth", (String) session.getAttribute("PP_AUTH"));
		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");

		paramMap.put("type", "wsd_type");
		paramMap.put("type_level", "1");
		List<HashMap<String, String>> clist1 = commonService.code_list(paramMap);
		paramMap.put("type", "wsd_type");
		paramMap.put("type_level", "2");
		if(paramMap.get("srch_type1") != null) paramMap.put("upper_val", paramMap.get("srch_type1"));
		else paramMap.put("upper_val", "배소");
		List<HashMap<String, String>> clist2 = commonService.code_list(paramMap);

		LocalDate now = LocalDate.now();
		String start_date = String.format("%04d%02d%02d", now.getYear(), now.getMonthValue(), now.getDayOfMonth());
		String end_date = start_date;
		HashMap pm1 = new HashMap<String, String>();
		pm1.put("sdate",  start_date + "000000");
		pm1.put("edate",  end_date + "235959");
		List cathode_list = zppService.zpp_ctd_cathode_list(pm1);

		logger.debug("{}", cathode_list);

		mav.addObject("list", cathode_list);
		mav.addObject("clist2", clist2);
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/ore/zpp_ore_reg_result");

		return mav;
	}
	
	/**
	 * 생산관리 > 정광 - 성분분석 최종결과 등록
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_reg_final", method = RequestMethod.POST)
	public ModelAndView zpp_ore_reg_final(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 - 성분분석 최종 결과 등록");
		ModelAndView mav = new ModelAndView();
		mav.addObject("hierarchy", "000004");
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		// session attr to param
		HttpSession session = request.getSession();

		Calendar cal = Calendar.getInstance();
		String format = "yyyy/MM/dd";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		cal.add(cal.YEAR, -3); 	//	3년 전 날짜
		String date_str = sdf.format(cal.getTime());
		
		paramMap.put("sdate", date_str);
		paramMap.put("edate", DateUtil.getToday());

		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", ((String) session.getAttribute("userName")));
		paramMap.put("dept_cd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("dept_name", ((String) session.getAttribute("userDept")));
		paramMap.put("auth", (String) session.getAttribute("PP_AUTH"));
		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");

		paramMap.put("type", "wsd_type");
		paramMap.put("type_level", "1");
		List<HashMap<String, String>> clist1 = commonService.code_list(paramMap);
		paramMap.put("type", "wsd_type");
		paramMap.put("type_level", "2");
		if(paramMap.get("srch_type1") != null) paramMap.put("upper_val", paramMap.get("srch_type1"));
		else paramMap.put("upper_val", "배소");
		List<HashMap<String, String>> clist2 = commonService.code_list(paramMap);

		LocalDate now = LocalDate.now();
		String start_date = String.format("%04d%02d%02d", now.getYear(), now.getMonthValue(), now.getDayOfMonth());
		String end_date = start_date;
		HashMap pm1 = new HashMap<String, String>();
		pm1.put("sdate",  start_date + "000000");
		pm1.put("edate",  end_date + "235959");
		List cathode_list = zppService.zpp_ctd_cathode_list(pm1);

		logger.debug("{}", cathode_list);

		mav.addObject("list", cathode_list);
		mav.addObject("clist2", clist2);
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/ore/zpp_ore_reg_final");

		return mav;
	}
	
	/**
	 * 생산관리 > 정광 - seller 송부용 성분분석 결과 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_seller_query", method = RequestMethod.POST)
	public ModelAndView zpp_ore_seller_query(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 - seller 송부용 성분분석 결과 조회");
		ModelAndView mav = new ModelAndView();
		mav.addObject("hierarchy", "000004");
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		// session attr to param
		HttpSession session = request.getSession();

		Calendar cal = Calendar.getInstance();
		String format = "yyyy/MM/dd";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		cal.add(cal.YEAR, -3); 	//	3년 전 날짜
		String date_str = sdf.format(cal.getTime());
		
		paramMap.put("sdate", date_str);
		paramMap.put("edate", DateUtil.getToday());

		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", ((String) session.getAttribute("userName")));
		paramMap.put("dept_cd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("dept_name", ((String) session.getAttribute("userDept")));
		paramMap.put("auth", (String) session.getAttribute("PP_AUTH"));
		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");

		paramMap.put("type", "wsd_type");
		paramMap.put("type_level", "1");
		List<HashMap<String, String>> clist1 = commonService.code_list(paramMap);
		paramMap.put("type", "wsd_type");
		paramMap.put("type_level", "2");
		if(paramMap.get("srch_type1") != null) paramMap.put("upper_val", paramMap.get("srch_type1"));
		else paramMap.put("upper_val", "배소");
		List<HashMap<String, String>> clist2 = commonService.code_list(paramMap);

		LocalDate now = LocalDate.now();
		String start_date = String.format("%04d%02d%02d", now.getYear(), now.getMonthValue(), now.getDayOfMonth());
		String end_date = start_date;
		HashMap pm1 = new HashMap<String, String>();
		pm1.put("sdate",  start_date + "000000");
		pm1.put("edate",  end_date + "235959");
		List cathode_list = zppService.zpp_ctd_cathode_list(pm1);

		logger.debug("{}", cathode_list);

		mav.addObject("list", cathode_list);
		mav.addObject("clist2", clist2);
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/ore/zpp_ore_seller_query");

		return mav;
	}
	
	/**
	 * 생산관리 > 정광 - seller 성분분석 결과 등록
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_seller_result", method = RequestMethod.POST)
	public ModelAndView zpp_ore_seller_result(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 - seller 성분분석 결과 등록");
		ModelAndView mav = new ModelAndView();
		mav.addObject("hierarchy", "000004");
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		// session attr to param
		HttpSession session = request.getSession();

		Calendar cal = Calendar.getInstance();
		String format = "yyyy/MM/dd";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		cal.add(cal.YEAR, -3); 	//	3년 전 날짜
		String date_str = sdf.format(cal.getTime());
		
		paramMap.put("sdate", date_str);
		paramMap.put("edate", DateUtil.getToday());

		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", ((String) session.getAttribute("userName")));
		paramMap.put("dept_cd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("dept_name", ((String) session.getAttribute("userDept")));
		paramMap.put("auth", (String) session.getAttribute("PP_AUTH"));
		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");

		paramMap.put("type", "wsd_type");
		paramMap.put("type_level", "1");
		List<HashMap<String, String>> clist1 = commonService.code_list(paramMap);
		paramMap.put("type", "wsd_type");
		paramMap.put("type_level", "2");
		if(paramMap.get("srch_type1") != null) paramMap.put("upper_val", paramMap.get("srch_type1"));
		else paramMap.put("upper_val", "배소");
		List<HashMap<String, String>> clist2 = commonService.code_list(paramMap);

		LocalDate now = LocalDate.now();
		String start_date = String.format("%04d%02d%02d", now.getYear(), now.getMonthValue(), now.getDayOfMonth());
		String end_date = start_date;
		HashMap pm1 = new HashMap<String, String>();
		pm1.put("sdate",  start_date + "000000");
		pm1.put("edate",  end_date + "235959");
		List cathode_list = zppService.zpp_ctd_cathode_list(pm1);

		logger.debug("{}", cathode_list);

		mav.addObject("list", cathode_list);
		mav.addObject("clist2", clist2);
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/ore/zpp_ore_seller_result");

		return mav;
	}
	
	/**
	 * 생산관리 > 정광 - seller 성분분석 결과 비교
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_seller_compare", method = RequestMethod.POST)
	public ModelAndView zpp_ore_seller_compare(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 - seller 성분분석 결과 비교");
		ModelAndView mav = new ModelAndView();
		mav.addObject("hierarchy", "000004");
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		// session attr to param
		HttpSession session = request.getSession();

		Calendar cal = Calendar.getInstance();
		String format = "yyyy/MM/dd";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		cal.add(cal.YEAR, -3); 	//	3년 전 날짜
		String date_str = sdf.format(cal.getTime());
		
		paramMap.put("sdate", date_str);
		paramMap.put("edate", DateUtil.getToday());

		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", ((String) session.getAttribute("userName")));
		paramMap.put("dept_cd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("dept_name", ((String) session.getAttribute("userDept")));
		paramMap.put("auth", (String) session.getAttribute("PP_AUTH"));
		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");

		paramMap.put("type", "wsd_type");
		paramMap.put("type_level", "1");
		List<HashMap<String, String>> clist1 = commonService.code_list(paramMap);
		paramMap.put("type", "wsd_type");
		paramMap.put("type_level", "2");
		if(paramMap.get("srch_type1") != null) paramMap.put("upper_val", paramMap.get("srch_type1"));
		else paramMap.put("upper_val", "배소");
		List<HashMap<String, String>> clist2 = commonService.code_list(paramMap);

		LocalDate now = LocalDate.now();
		String start_date = String.format("%04d%02d%02d", now.getYear(), now.getMonthValue(), now.getDayOfMonth());
		String end_date = start_date;
		HashMap pm1 = new HashMap<String, String>();
		pm1.put("sdate",  start_date + "000000");
		pm1.put("edate",  end_date + "235959");
		List cathode_list = zppService.zpp_ctd_cathode_list(pm1);

		logger.debug("{}", cathode_list);

		mav.addObject("list", cathode_list);
		mav.addObject("clist2", clist2);
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/ore/zpp_ore_seller_compare");

		return mav;
	}
	
	/**
	 * 생산관리 >정광 > 정광 대상 의뢰 대상 선택 / 이전 선택 값 보기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_get_umpire_decision", method = RequestMethod.POST)
	public ModelAndView zpp_ore_get_umpire_decision(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HashMap hm = new HashMap<String, String>();

		Map resultMap = new HashMap();
		String master_id = paramMap.get("MASTER_ID").toString();
		List<HashMap<String, String>> rl = get_Ingredient_List(master_id);

		for(int ac = 0;ac < rl.size();ac ++)
		{
			String ing_cd = rl.get(ac).get("INGREDIENT_ID");

			for(int i = 0;i < 30;i ++)
			{
				hm.clear();
				hm.put("MASTER_ID", master_id);
				hm.put("INGREDIENT_ID", ing_cd);
				hm.put("LOT_NO", Integer.toString(i + 1));

				double dmt_value = zppService.zpp_ore_get_dmt_value(hm);
				double yp_value = zppService.zpp_ore_get_yp_value(hm);
				double seller_value = zppService.zpp_ore_get_seller_value(hm);
				String yp_action = zppService.zpp_ore_get_yp_action(hm);
				String seller_action = zppService.zpp_ore_get_seller_action(hm);
				Integer yp_action_val = 0;
				Integer seller_action_val = 0;

				String key_name = String.format("DMT_%d_%d", i + 1, ac + 1);
				resultMap.put(key_name, dmt_value);

				key_name = String.format("YP_%d_%d", i + 1, ac + 1);
				resultMap.put(key_name, yp_value);

				key_name = String.format("SELLER_%d_%d", i + 1, ac + 1);
				resultMap.put(key_name, seller_value);

				if(seller_action.compareTo("UMPIRE") == 0) seller_action_val = 1;
				else if(seller_action.compareTo("SPLIT") == 0) seller_action_val = 2;
				else seller_action_val = 0;

				key_name = String.format("SELLER_ACTION_%d_%d", i + 1, ac + 1);
				resultMap.put(key_name, seller_action_val);

				if(yp_action.compareTo("UMPIRE") == 0) yp_action_val = 1;
				else if(yp_action.compareTo("SPLIT") == 0) yp_action_val = 2;
				else yp_action_val = 0;

				key_name = String.format("YP_ACTION_%d_%d", i + 1, ac + 1);
				resultMap.put(key_name, yp_action_val);
			}
		}
		resultMap.put("LOT_COUNT", Integer.toString(zppService.zpp_ore_get_lot_count(paramMap)));

		return new ModelAndView("DataToJson", resultMap);
	}


	//	생산관리 > 정광 - POPUP - 정광 심판판정 의뢰 대상 조회
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/ore/zpp_ore_popup_query_umpire")
	public ModelAndView zpp_ore_popup_query_umpire(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 - 정광 심판판정 의뢰 대상 조회");

		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("target", paramMap.get("target"));

		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/ore/zpp_ore_popup_query_umpire");

		return mav;
	}

	/**
	 * 생산관리 >정광 > 정광 심판판정 의뢰 대상 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_set_umpire_decision", method = RequestMethod.POST)
	public ModelAndView zpp_ore_set_umpire_decision(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HashMap hm = new HashMap<String, String>();

		Map resultMap = new HashMap();
		String master_id = paramMap.get("MASTER_ID").toString();
		int [] ig_umpire = {0, 0, 0, 0};
		int [] ig_split = {0, 0, 0, 0};

		List<HashMap<String, String>> rl = get_Ingredient_List(master_id);

		for(int ac = 0;ac < rl.size();ac ++)
		{
			String ing_cd = rl.get(ac).get("INGREDIENT_ID");

			for(int i = 0;i < 22;i ++)
			{
				String key_name = String.format("YP_ACTION_%d_%d", i + 1, ac + 1);
				Integer key_value = Integer.parseInt(paramMap.get(key_name).toString());
				String key_str = "";

				if(key_value == 0) key_str = "";
				else if(key_value ==1)
				{
					key_str = "UMPIRE";
					ig_umpire[ac] ++;
				}
				else 
				{
					key_str = "SPLIT";
					ig_split[ac] ++;
				}

				hm.clear();
				hm.put("MASTER_ID", master_id);
				hm.put("INGREDIENT_ID", ing_cd);
				hm.put("LOT_NO", Integer.toString(i + 1));
				hm.put("YP_ACTION", key_str);
				zppService.zpp_ore_set_yp_action(hm);
			}

			for(int i = 0;i < 22;i ++)
			{
				String key_name = String.format("SELLER_ACTION_%d_%d", i + 1, ac + 1);
				Integer key_value = Integer.parseInt(paramMap.get(key_name).toString());
				String key_str = "";

				if(key_value == 0) key_str = "";
				else if(key_value ==1)
				{
					key_str = "UMPIRE";
				}
				else 
				{
					key_str = "SPLIT";
				}

				hm.clear();
				hm.put("MASTER_ID", master_id);
				hm.put("INGREDIENT_ID", ing_cd);
				hm.put("LOT_NO", Integer.toString(i + 1));
				hm.put("SELLER_ACTION", key_str);
				zppService.zpp_ore_set_seller_action(hm);
			}
		}

		hm.clear();
		hm.put("MASTER_ID", master_id);
		hm.put("IG_1_SPLIT", ig_split[0]);
		hm.put("IG_1_UMPIRE", ig_umpire[0]);
		hm.put("IG_2_SPLIT", ig_split[1]);
		hm.put("IG_2_UMPIRE", ig_umpire[1]);
		hm.put("IG_3_SPLIT", ig_split[2]);
		hm.put("IG_3_UMPIRE", ig_umpire[2]);
		hm.put("IG_4_SPLIT", ig_split[3]);
		hm.put("IG_4_UMPIRE", ig_umpire[3]);
		zppService.zpp_ore_set_master_split_umpire(hm);

		paramMap.put("status", 6);
		zppService.zpp_ore_update_state(paramMap);

		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 생산관리 > 정광 - 정광 심판판정 의뢰 대상 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_umpire_query", method = RequestMethod.POST)
	public ModelAndView zpp_ore_umpire_query(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 - 정광 심판판정 의뢰 대상 조회");
		ModelAndView mav = new ModelAndView();
		mav.addObject("hierarchy", "000004");
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		// session attr to param
		HttpSession session = request.getSession();

		Calendar cal = Calendar.getInstance();
		String format = "yyyy/MM/dd";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		cal.add(cal.YEAR, -3); 	//	3년 전 날짜
		String date_str = sdf.format(cal.getTime());
		
		paramMap.put("sdate", date_str);
		paramMap.put("edate", DateUtil.getToday());

		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", ((String) session.getAttribute("userName")));
		paramMap.put("dept_cd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("dept_name", ((String) session.getAttribute("userDept")));
		paramMap.put("auth", (String) session.getAttribute("PP_AUTH"));
		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");

		paramMap.put("type", "wsd_type");
		paramMap.put("type_level", "1");
		List<HashMap<String, String>> clist1 = commonService.code_list(paramMap);
		paramMap.put("type", "wsd_type");
		paramMap.put("type_level", "2");
		if(paramMap.get("srch_type1") != null) paramMap.put("upper_val", paramMap.get("srch_type1"));
		else paramMap.put("upper_val", "배소");
		List<HashMap<String, String>> clist2 = commonService.code_list(paramMap);

		LocalDate now = LocalDate.now();
		String start_date = String.format("%04d%02d%02d", now.getYear(), now.getMonthValue(), now.getDayOfMonth());
		String end_date = start_date;
		HashMap pm1 = new HashMap<String, String>();
		pm1.put("sdate",  start_date + "000000");
		pm1.put("edate",  end_date + "235959");
		List cathode_list = zppService.zpp_ctd_cathode_list(pm1);

		logger.debug("{}", cathode_list);

		mav.addObject("list", cathode_list);
		mav.addObject("clist2", clist2);
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/ore/zpp_ore_umpire_query");

		return mav;
	}
	
	/**
	 * 생산관리 > 정광 - 정광 심판판정 결과 등록
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_umpire_result", method = RequestMethod.POST)
	public ModelAndView zpp_ore_umpire_result(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 - 정광 심판판정 결과 등록");
		ModelAndView mav = new ModelAndView();
		mav.addObject("hierarchy", "000004");
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		// session attr to param
		HttpSession session = request.getSession();

		Calendar cal = Calendar.getInstance();
		String format = "yyyy/MM/dd";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		cal.add(cal.YEAR, -3); 	//	3년 전 날짜
		String date_str = sdf.format(cal.getTime());
		
		paramMap.put("sdate", date_str);
		paramMap.put("edate", DateUtil.getToday());

		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", ((String) session.getAttribute("userName")));
		paramMap.put("dept_cd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("dept_name", ((String) session.getAttribute("userDept")));
		paramMap.put("auth", (String) session.getAttribute("PP_AUTH"));
		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");

		paramMap.put("type", "wsd_type");
		paramMap.put("type_level", "1");
		List<HashMap<String, String>> clist1 = commonService.code_list(paramMap);
		paramMap.put("type", "wsd_type");
		paramMap.put("type_level", "2");
		if(paramMap.get("srch_type1") != null) paramMap.put("upper_val", paramMap.get("srch_type1"));
		else paramMap.put("upper_val", "배소");
		List<HashMap<String, String>> clist2 = commonService.code_list(paramMap);

		LocalDate now = LocalDate.now();
		String start_date = String.format("%04d%02d%02d", now.getYear(), now.getMonthValue(), now.getDayOfMonth());
		String end_date = start_date;
		HashMap pm1 = new HashMap<String, String>();
		pm1.put("sdate",  start_date + "000000");
		pm1.put("edate",  end_date + "235959");
		List cathode_list = zppService.zpp_ctd_cathode_list(pm1);

		logger.debug("{}", cathode_list);

		mav.addObject("list", cathode_list);
		mav.addObject("clist2", clist2);
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/ore/zpp_ore_umpire_result");

		return mav;
	}

	//	생산관리 > 정광 - POPUP - 정광 심판판정 결과 등록
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/ore/zpp_ore_popup_umpire_result")
	public ModelAndView zpp_ore_popup_umpire_result(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 - 정광 심판판정 결과 저장");

		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("target", paramMap.get("target"));

		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/ore/zpp_ore_popup_umpire_result");

		return mav;
	}

	/**
	 * 생산관리 >정광 > 정광 심판 판정 결과 읽어오기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_get_umpire_result", method = RequestMethod.POST)
	public ModelAndView zpp_ore_get_umpire_result(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HashMap hm = new HashMap<String, String>();

		Map resultMap = new HashMap();
		String master_id = paramMap.get("MASTER_ID").toString();
		List<HashMap<String, String>> rl = get_Ingredient_List(master_id);

		for(int ac = 0;ac < rl.size();ac ++)
		{
			String ing_cd = rl.get(ac).get("INGREDIENT_ID");

			for(int i = 0;i < 30;i ++)
			{
				hm.clear();
				hm.put("MASTER_ID", master_id);
				hm.put("INGREDIENT_ID", ing_cd);
				hm.put("LOT_NO", Integer.toString(i + 1));

				HashMap<String, String> ar_value = zppService.zpp_ore_get_ar_value(hm);
				double dmt_value = Double.parseDouble(String.valueOf(ar_value.get("DMT")));
				double yp_value = Double.parseDouble(String.valueOf(ar_value.get("YP")));
				double seller_value = Double.parseDouble(String.valueOf(ar_value.get("SELLER")));
				String yp_action = ar_value.get("YP_ACTION");
				String seller_action = ar_value.get("SELLER_ACTION");
				Integer yp_action_val = 0;
				Integer seller_action_val = 0;
				double settle_value = Double.parseDouble(String.valueOf(ar_value.get("SETTLE")));
				double umpire_value = Double.parseDouble(String.valueOf(ar_value.get("UMPIRE")));
				double state_value = Double.parseDouble(String.valueOf(ar_value.get("STATE")));

				String key_name = String.format("DMT_%d_%d", i + 1, ac + 1);
				resultMap.put(key_name, dmt_value);

				key_name = String.format("YP_%d_%d", i + 1, ac + 1);
				resultMap.put(key_name, yp_value);

				key_name = String.format("SELLER_%d_%d", i + 1, ac + 1);
				resultMap.put(key_name, seller_value);

				if(yp_action.compareTo("UMPIRE") == 0) yp_action_val = 1;
				else if(yp_action.compareTo("SPLIT") == 0) yp_action_val = 2;
				else yp_action_val = 0;

				key_name = String.format("YP_ACTION_%d_%d", i + 1, ac + 1);
				resultMap.put(key_name, yp_action_val);

				if(seller_action.compareTo("UMPIRE") == 0) seller_action_val = 1;
				else if(seller_action.compareTo("SPLIT") == 0) seller_action_val = 2;
				else seller_action_val = 0;

				key_name = String.format("SELLER_ACTION_%d_%d", i + 1, ac + 1);
				resultMap.put(key_name, seller_action_val);

				key_name = String.format("SETTLE_%d_%d", i + 1, ac + 1);
				resultMap.put(key_name, settle_value);

				key_name = String.format("UMPIRE_%d_%d", i + 1, ac + 1);
				resultMap.put(key_name, umpire_value);

				key_name = String.format("STATE_%d_%d", i + 1, ac + 1);
				resultMap.put(key_name, state_value);
			}
		}
		resultMap.put("LOT_COUNT", Integer.toString(zppService.zpp_ore_get_lot_count(paramMap)));

		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 생산관리 >정광 > 정광 심판판정 결과 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_save_umpire_result", method = RequestMethod.POST)
	public ModelAndView zpp_ore_save_umpire_result(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HashMap hm = new HashMap<String, String>();
		Map resultMap = new HashMap();
		String master_id = paramMap.get("MASTER_ID").toString();
		int[] ig_win = {0, 0, 0, 0};
		int[] ig_lose = {0, 0, 0, 0};

		List<HashMap<String, String>> rl = get_Ingredient_List(master_id);

		for(int ac = 0;ac < rl.size();ac ++)
		{
			String ing_cd = rl.get(ac).get("INGREDIENT_ID");

			for(int i = 0;i < 22;i ++)
			{
				String key_name = String.format("SETTLE_%d_%d", i + 1, ac + 1);
				double settle_value = Double.parseDouble(paramMap.get(key_name).toString());
				key_name = String.format("UMPIRE_%d_%d", i + 1, ac + 1);
				double umpire_value = Double.parseDouble(paramMap.get(key_name).toString());
				key_name = String.format("STATE_%d_%d", i + 1, ac + 1);
				double state_value = Double.parseDouble(paramMap.get(key_name).toString());

				hm.clear();
				hm.put("MASTER_ID", master_id);
				hm.put("INGREDIENT_ID", ing_cd);
				hm.put("LOT_NO", Integer.toString(i + 1));
				hm.put("SETTLE", settle_value);
				hm.put("UMPIRE", umpire_value);
				hm.put("STATE", state_value);

				if(state_value == 1.0) ig_win[ac] ++;
				else if(state_value == 2.0) ig_lose[ac] ++;

				zppService.zpp_ore_set_settle_umpire_value(hm);
			}
		}

		hm.clear();
		hm.put("MASTER_ID", master_id);
		hm.put("IG_1_WIN", ig_win[0]);
		hm.put("IG_1_FAIL", ig_lose[0]);
		hm.put("IG_2_WIN", ig_win[1]);
		hm.put("IG_2_FAIL", ig_lose[1]);
		hm.put("IG_3_WIN", ig_win[2]);
		hm.put("IG_3_FAIL", ig_lose[2]);
		hm.put("IG_4_WIN", ig_win[3]);
		hm.put("IG_4_FAIL", ig_lose[3]);
		zppService.zpp_ore_set_master_win_fail(hm);

		paramMap.put("status", 7);
		zppService.zpp_ore_update_state(paramMap);

		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 생산관리 >정광 > 정광 심판판정 결과 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_set_umpire_result", method = RequestMethod.POST)
	public ModelAndView zpp_ore_set_umpire_result(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HashMap hm = new HashMap<String, String>();
		Map resultMap = new HashMap();
		String master_id = paramMap.get("MASTER_ID").toString();
		List<HashMap<String, String>> rl = get_Ingredient_List(master_id);

		for(int ac = 0;ac < rl.size();ac ++)
		{
			String ing_cd = rl.get(ac).get("INGREDIENT_ID");

			for(int i = 0;i < 22;i ++)
			{
				String key_name = String.format("SETTLE_%d_%d", i + 1, ac + 1);
				Integer key_value = Integer.parseInt(paramMap.get(key_name).toString());
				String key_str = "";

				if(key_value == 0) key_str = "";
				else if(key_value ==1) key_str = "UMPIRE";
				else key_str = "SPLIT";

				hm.clear();
				hm.put("MASTER_ID", master_id);
				hm.put("INGREDIENT_ID", ing_cd);
				hm.put("LOT_NO", Integer.toString(i + 1));
				hm.put("YP_ACTION", key_str);
				zppService.zpp_ore_set_yp_action(hm);
			}
		}

		paramMap.put("status", 6);
		zppService.zpp_ore_update_state(paramMap);

		return new ModelAndView("DataToJson", resultMap);
	}

	//	생산관리 > 정광 - POPUP - 정광 심판판정 결과 조회
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/ore/zpp_ore_umpire_list")
	public ModelAndView zpp_ore_umpire_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 - 정광 심판판정 결과 조회");

		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("target", paramMap.get("target"));

		Calendar cal = Calendar.getInstance();
		String format = "yyyy/MM/dd";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		cal.add(cal.YEAR, -3); 	//	3년 전 날짜
		String date_str = sdf.format(cal.getTime());
		
		paramMap.put("sdate", date_str);
		paramMap.put("edate", DateUtil.getToday());
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", ((String) session.getAttribute("userName")));
		paramMap.put("dept_cd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("dept_name", ((String) session.getAttribute("userDept")));
		paramMap.put("auth", (String) session.getAttribute("PP_AUTH"));
		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");

		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/ore/zpp_ore_umpire_list");

		return mav;
	}

		//	생산관리 > 정광 - EXCEL - 정광 심판 이력 종합 Excel Download
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/xls/zpp/ore/zpp_ore_bl_xls_list")
	public ModelAndView zpp_ore_bl_xls_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【엑셀다운로드】생산관리 > 정광 > 정광 심판 이력 종합");
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("target", paramMap.get("target"));

		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		list = (ArrayList<HashMap<String, String>>) zppService.zpp_ore_req_bl_list_xls(paramMap);

		for(int li = 0;li < list.size(); li ++)
		{
			String material_id = list.get(li).get("MATERIAL_ID").toString();
			String sheet_id = list.get(li).get("SHEET").toString();
			String seller_id = list.get(li).get("SELLER_ID").toString();

			HashMap pm1 = new HashMap<String, String>();
			pm1.put("MATERIAL_ID",  material_id);
			pm1.put("SELLER_ID",  seller_id);

			String material_name = zppService.zpp_ore_get_material_name(pm1);
			String seller_name = zppService.zpp_ore_get_seller_name(pm1);

			if(sheet_id.equals("0")) {}
			else
			{
				material_name = material_name + "(" + sheet_id + ")";
			}

			list.get(li).put("MATERIAL_NAME", material_name);
			list.get(li).put("SELLER_NAME", seller_name);

			String status_str = String.valueOf(list.get(li).get("STATUS"));
			int status = Integer.parseInt(status_str);
			String s1, s2, s3, s4, s5, s6, s7, s8, s9;

			//	로트별 수량 등록
			if(status == 0) s1 = "미등록";
			else s1 = "등록완료";

			//	성분결과초기값등록
			if(status < 2) s2 = "미등록";
			else s2= "등록완료";

			//	성분결과초기값조정
			if(status < 3) s3 = "미등록";
			else s3 = "등록완료";

			//	성분결과최종값조회
			if(status < 3) s4 = "조회불가";
			else s4 = "조회";

			//	Seller 송부용 분석결과 조회
			if(status < 3) s5 = "조회불가";
			else s5 = "조회";

			//	Seller 성분분석 결과등록
			if(status < 4) s6 = "미등록";
			else s6 = "등록완료";

			//	Seller 성분분석결과 비교조회
			if(status < 4) s7 = "조회불가";
			else s7 = "조회";

			//	정광심판판정의뢰대상조회
			if(status < 5) s8 = "조회불가";
			else s8 = "조회";

			//	정광심판판정결과등록
			if(status < 7) s9 = "미등록";
			else s9 = "등록완료";

			list.get(li).put("S1", s1);
			list.get(li).put("S2", s2);
			list.get(li).put("S3", s3);
			list.get(li).put("S4", s4);
			list.get(li).put("S5", s5);
			list.get(li).put("S6", s6);
			list.get(li).put("S7", s7);
			list.get(li).put("S8", s8);
			list.get(li).put("S9", s9);
		}

		mav.addObject("alllist", list);

		mav.setViewName("/yp/zpp/ore/xls/zpp_ore_bl_list_xls");

		return mav;
	}

	//	생산관리 > 정광 - EXCEL - 정광 심판판정 결과 조회 Excel Download
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/xls/zpp/ore/zpp_ore_umpire_xls_list")
	public ModelAndView zpp_ore_umpire_xls_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【엑셀다운로드】생산관리 > 정광 > 정광 심판 판정 결과 조회");
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("target", paramMap.get("target"));

		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		list = (ArrayList<HashMap<String, String>>) zppService.zpp_ore_get_master_list_xls(paramMap);

		for(int li = 0;li < list.size(); li ++)
		{
			String material_id = list.get(li).get("MATERIAL_ID").toString();
			String sheet_id = list.get(li).get("SHEET").toString();
			String seller_id = list.get(li).get("SELLER_ID").toString();

			HashMap pm1 = new HashMap<String, String>();
			pm1.put("MATERIAL_ID",  material_id);
			pm1.put("SELLER_ID",  seller_id);

			String material_name = zppService.zpp_ore_get_material_name(pm1);
			String seller_name = zppService.zpp_ore_get_seller_name(pm1);

			if(sheet_id.equals("0")) {}
			else
			{
				material_name = material_name + "(" + sheet_id + ")";
			}

			list.get(li).put("MATERIAL_NAME", material_name);
			list.get(li).put("SELLER_NAME", seller_name);
		}

		mav.addObject("alllist", list);

		mav.setViewName("/yp/zpp/ore/xls/zpp_ore_umpire_list_xls");

		return mav;
	}


/**
	 * 생산관리 > 정광 - 정광 심판판정 결과 조회 (승패)
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_judge_result", method = RequestMethod.POST)
	public ModelAndView zpp_ore_judge_result(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 - 정광 심판판정 결과 조회 (승패)");
		ModelAndView mav = new ModelAndView();
		mav.addObject("hierarchy", "000004");
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		// session attr to param
		HttpSession session = request.getSession();

		Calendar cal = Calendar.getInstance();
		String format = "yyyy/MM/dd";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		cal.add(cal.YEAR, -3); 	//	3년 전 날짜
		String date_str = sdf.format(cal.getTime());
		
		paramMap.put("sdate", date_str);
		paramMap.put("edate", DateUtil.getToday());

		logger.debug("start_date : {}",  DateUtil.getToday());

		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", ((String) session.getAttribute("userName")));
		paramMap.put("dept_cd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("dept_name", ((String) session.getAttribute("userDept")));
		paramMap.put("auth", (String) session.getAttribute("PP_AUTH"));
		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");

		paramMap.put("type", "wsd_type");
		paramMap.put("type_level", "1");
		List<HashMap<String, String>> clist1 = commonService.code_list(paramMap);
		paramMap.put("type", "wsd_type");
		paramMap.put("type_level", "2");
		if(paramMap.get("srch_type1") != null) paramMap.put("upper_val", paramMap.get("srch_type1"));
		else paramMap.put("upper_val", "배소");
		List<HashMap<String, String>> clist2 = commonService.code_list(paramMap);

		LocalDate now = LocalDate.now().minusYears(1);
		String start_date = String.format("%04d%02d%02d", now.getYear(), now.getMonthValue(), now.getDayOfMonth());

		now = LocalDate.now();
		String end_date = String.format("%04d%02d%02d", now.getYear(), now.getMonthValue(), now.getDayOfMonth());
		HashMap pm1 = new HashMap<String, String>();
		pm1.put("sdate",  start_date + "000000");
		pm1.put("edate",  end_date + "235959");
		List cathode_list = zppService.zpp_ctd_cathode_list(pm1);

		logger.debug("{}", cathode_list);

		mav.addObject("list", cathode_list);
		mav.addObject("clist2", clist2);
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/ore/zpp_ore_judge_result");

		return mav;
	}

	/**
	 * 생산관리 > 정광 - 정광 심판판정 결과 조회 (업체별)
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_judge_result2", method = RequestMethod.POST)
	public ModelAndView zpp_ore_judge_result2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 - 정광 심판판정 결과 조회 (업체별)");
		ModelAndView mav = new ModelAndView();
		mav.addObject("hierarchy", "000004");
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		// session attr to param
		HttpSession session = request.getSession();

		Calendar cal = Calendar.getInstance();
		String format = "yyyy/MM/dd";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		cal.add(cal.YEAR, -3); 	//	3년 전 날짜
		String date_str = sdf.format(cal.getTime());
		
		paramMap.put("sdate", date_str);
		paramMap.put("edate", DateUtil.getToday());

		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", ((String) session.getAttribute("userName")));
		paramMap.put("dept_cd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("dept_name", ((String) session.getAttribute("userDept")));
		paramMap.put("auth", (String) session.getAttribute("PP_AUTH"));
		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");

		paramMap.put("type", "wsd_type");
		paramMap.put("type_level", "1");
		List<HashMap<String, String>> clist1 = commonService.code_list(paramMap);
		paramMap.put("type", "wsd_type");
		paramMap.put("type_level", "2");
		if(paramMap.get("srch_type1") != null) paramMap.put("upper_val", paramMap.get("srch_type1"));
		else paramMap.put("upper_val", "배소");
		List<HashMap<String, String>> clist2 = commonService.code_list(paramMap);

		LocalDate now = LocalDate.now();
		String start_date = String.format("%04d%02d%02d", now.getYear(), now.getMonthValue(), now.getDayOfMonth());
		String end_date = start_date;
		HashMap pm1 = new HashMap<String, String>();
		pm1.put("sdate",  start_date + "000000");
		pm1.put("edate",  end_date + "235959");
		List cathode_list = zppService.zpp_ctd_cathode_list(pm1);

		logger.debug("{}", cathode_list);

		mav.addObject("list", cathode_list);
		mav.addObject("clist2", clist2);
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/ore/zpp_ore_judge_result2");

		return mav;
	}

	/**
	 * 생산관리 >정광 > 정광 심판 판정 결과 LIST 읽어오기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_req_umpire_list", method = RequestMethod.POST)
	public ModelAndView zpp_ore_req_umpire_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		List<HashMap<String, String>> masterList = zppService.zpp_ore_req_master_list(paramMap);
		HashMap pm = new HashMap<String, String>();

		//	결과 조회는 Zn, Ag, Au 기준으로만 실행
		for(int m_idx = 0;m_idx < masterList.size();m_idx ++)
		{
			String master_id = masterList.get(m_idx).get("MASTER_ID").toString();

			//	List<HashMap<String, String>> rl = get_Ingredient_List(master_id);
			List<HashMap<String, String>> rl = new ArrayList<HashMap<String, String>>();
			HashMap<String, String> map1 = new HashMap<String, String>();
			HashMap<String, String> map2 = new HashMap<String, String>();
			HashMap<String, String> map3 = new HashMap<String, String>();

			//	Zn
			map1.put("INGREDIENT_ID", "YPIG-0001");
			map1.put("INGREDIENT_NAME", "Zn");
			rl.add(map1);
			//	Ag
			map2.put("INGREDIENT_ID", "YPIG-0007");
			map2.put("INGREDIENT_NAME", "Ag");
			rl.add(map2);
			//	Au
			map3.put("INGREDIENT_ID", "YPIG-0031");
			map3.put("INGREDIENT_NAME", "Au");
			rl.add(map3);

			logger.debug("{}", rl);

			for(int ac = 0;ac < rl.size();ac ++)
			{
				String ing_cd = rl.get(ac).get("INGREDIENT_ID");
				double ig_avg = 0;

				pm.clear();
				pm.put("MASTER_ID",  masterList.get(m_idx).get("MASTER_ID").toString());
				pm.put("MATERIAL_ID",  masterList.get(m_idx).get("MATERIAL_ID").toString());
				pm.put("SELLER_ID",  masterList.get(m_idx).get("SELLER_ID").toString());
				pm.put("IMPORT_DATE",  masterList.get(m_idx).get("IMPORT_DATE").toString());
				pm.put("INGREDIENT_ID", ing_cd);

				ig_avg = zppService.zpp_ore_get_ig_avg(pm);

				logger.debug("{} {}", ing_cd, ig_avg);

				String put_key_str = String.format("IG_%d_AVG", ac + 1);
				masterList.get(m_idx).put(put_key_str, Double.toString(ig_avg));
			}
		}

		Map resultMap = new HashMap();
		resultMap.put("master_list", masterList);

		return new ModelAndView("DataToJson", resultMap);
	}

	//	생산관리 > 정광 - POPUP - 정광 심판판정 결과 상세 조회
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/ore/zpp_ore_popup_umpire_detail")
	public ModelAndView zpp_ore_popup_umpire_detail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 정광 - 정광 심판판정 결과 상세 조회");

		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("target", paramMap.get("target"));

		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/ore/zpp_ore_popup_umpire_detail");

		return mav;
	}

	/**
	 * 생산관리 > 정광 > IngredientList 읽기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_req_ig_list", method = RequestMethod.POST)
	public ModelAndView zpp_ore_req_ig_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HashMap<String, String> ret = zppService.zpp_ore_get_lbl_ig(paramMap);

		List<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		HashMap<String, String> map = new HashMap<String, String>();
		HashMap<String, String> map1 = new HashMap<String, String>();

		if(ret.get("LBL_IG_1") == null) {
			map1.put("INGREDIENT_ID", "");
			map1.put("INGREDIENT_NAME", "");
		}
		else {
			String ingredient_id = ret.get("LBL_IG_1").toString();

			map.put("INGREDIENT_ID", ingredient_id);

			map1.put("INGREDIENT_ID", ingredient_id);
			map1.put("INGREDIENT_NAME", zppService.zpp_ore_get_ingredient_name(map));
		}
		list.add(map1);

		HashMap<String, String> map2 = new HashMap<String, String>();
		if(ret.get("LBL_IG_2") == null) {
			map2.put("INGREDIENT_ID", "");
			map2.put("INGREDIENT_NAME", "");
		}
		else {
			String ingredient_id = ret.get("LBL_IG_2").toString();

			map.put("INGREDIENT_ID", ingredient_id);

			map2.put("INGREDIENT_ID", ingredient_id);
			map2.put("INGREDIENT_NAME", zppService.zpp_ore_get_ingredient_name(map));
		}
		list.add(map2);

		HashMap<String, String> map3 = new HashMap<String, String>();
		if(ret.get("LBL_IG_3") == null) {
		}
		else {
			String ingredient_id = ret.get("LBL_IG_3").toString();

			map.put("INGREDIENT_ID", ingredient_id);

			map3.put("INGREDIENT_ID", ingredient_id);
			map3.put("INGREDIENT_NAME", zppService.zpp_ore_get_ingredient_name(map));

			list.add(map3);
		}

		HashMap<String, String> map4 = new HashMap<String, String>();
		if(ret.get("LBL_IG_4") == null) {
		}
		else {
			String ingredient_id = ret.get("LBL_IG_4").toString();

			map.put("INGREDIENT_ID", ingredient_id);

			map4.put("INGREDIENT_ID", ingredient_id);
			map4.put("INGREDIENT_NAME", zppService.zpp_ore_get_ingredient_name(map));

			list.add(map4);
		}

		Map resultMap = new HashMap();
		resultMap.put("ig_list", list);

		logger.debug("get_ig_list : {} - ", list);

		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 생산관리 > 정광 > CompositeList 읽기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_req_cps_ig_list", method = RequestMethod.POST)
	public ModelAndView zpp_ore_req_cps_ig_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HashMap<String, String> ret = zppService.zpp_ore_get_cps_ig(paramMap);

		List<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		HashMap<String, String> map = new HashMap<String, String>();
		HashMap<String, String> map1 = new HashMap<String, String>();

		if(ret.get("CPS_IG_1") == null) {
			map1.put("INGREDIENT_ID", "");
			map1.put("INGREDIENT_NAME", "");
		}
		else {
			String ingredient_id = ret.get("CPS_IG_1").toString();

			map.put("INGREDIENT_ID", ingredient_id);
			map1.put("INGREDIENT_ID", ingredient_id);
			map1.put("INGREDIENT_NAME", zppService.zpp_ore_get_ingredient_name(map));
		}
		list.add(map1);

		HashMap<String, String> map2 = new HashMap<String, String>();
		if(ret.get("CPS_IG_2") == null) {
			map2.put("INGREDIENT_ID", "");
			map2.put("INGREDIENT_NAME", "");
		}
		else {
			String ingredient_id = ret.get("CPS_IG_2").toString();

			map.put("INGREDIENT_ID", ingredient_id);
			map2.put("INGREDIENT_ID", ingredient_id);
			map2.put("INGREDIENT_NAME", zppService.zpp_ore_get_ingredient_name(map));
		}
		list.add(map2);

		HashMap<String, String> map3 = new HashMap<String, String>();
		if(ret.get("CPS_IG_3") == null) {
			map3.put("INGREDIENT_ID", "");
			map3.put("INGREDIENT_NAME", "");
		}
		else {
			String ingredient_id = ret.get("CPS_IG_3").toString();

			map.put("INGREDIENT_ID", ingredient_id);
			map3.put("INGREDIENT_ID", ingredient_id);
			map3.put("INGREDIENT_NAME", zppService.zpp_ore_get_ingredient_name(map));
		}
		list.add(map3);

		HashMap<String, String> map4 = new HashMap<String, String>();
		if(ret.get("CPS_IG_4") == null) {
			map4.put("INGREDIENT_ID", "");
			map4.put("INGREDIENT_NAME", "");
		}
		else {
			String ingredient_id = ret.get("CPS_IG_4").toString();

			map.put("INGREDIENT_ID", ingredient_id);
			map4.put("INGREDIENT_ID", ingredient_id);
			map4.put("INGREDIENT_NAME", zppService.zpp_ore_get_ingredient_name(map));
		}
		list.add(map4);

		HashMap<String, String> map5 = new HashMap<String, String>();
		if(ret.get("CPS_IG_5") == null) {
			map5.put("INGREDIENT_ID", "");
			map5.put("INGREDIENT_NAME", "");
		}
		else {
			String ingredient_id = ret.get("CPS_IG_5").toString();

			map.put("INGREDIENT_ID", ingredient_id);
			map5.put("INGREDIENT_ID", ingredient_id);
			map5.put("INGREDIENT_NAME", zppService.zpp_ore_get_ingredient_name(map));
		}
		list.add(map5);

		Map resultMap = new HashMap();
		resultMap.put("cps_ig_list", list);

		logger.debug("get_cps_ig_list : {} - ", list);

		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 생산관리 > 정광 > MASTER ID 등록 여부 읽기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_select_bl_info", method = RequestMethod.POST)
	public ModelAndView zpp_ore_select_bl_info(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HashMap<String, Object> result = new HashMap();

		if(zppService.zpp_ore_master_info_count(paramMap) > 0) {
			result.put("data_count", 1);
		}
		else {
			result.put("data_count", 0);
		}

		return new ModelAndView("DataToJson", result);
	}

	/**
	 * 생산관리 > 정광 > BL 삭제
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_delete_bl", method = RequestMethod.POST)
	public ModelAndView zpp_ore_delete_bl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		zppService.zpp_ore_delete_analysis_master(paramMap);
		zppService.zpp_ore_delete_analysis_result(paramMap);
		zppService.zpp_ore_delete_bl_info(paramMap);
		zppService.zpp_ore_delete_component_analysis(paramMap);
		zppService.zpp_ore_delete_mt_info(paramMap);

		Map resultMap = new HashMap();
		resultMap.put("result", "OK");

		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 생산관리 >정광 > 광종 데이터 읽어오기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_get_material_list", method = RequestMethod.POST)
	public ModelAndView zpp_ore_get_material_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		List<HashMap<String, String>> jsonList = zppService.zpp_ore_get_material_list(paramMap);

		Map resultMap = new HashMap();
		resultMap.put("listValue", jsonList);

		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 생산관리 >정광 > SELLER 데이터 읽어오기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_get_seller_list", method = RequestMethod.POST)
	public ModelAndView zpp_ore_get_seller_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		List<HashMap<String, String>> jsonList = zppService.zpp_ore_get_seller_list(paramMap);

		Map resultMap = new HashMap();
		resultMap.put("listValue", jsonList);

		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 생산관리 >정광 > INGREDIENT 데이터 읽어오기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/ore/zpp_ore_get_ingredient_list", method = RequestMethod.POST)
	public ModelAndView zpp_ore_get_ingredient_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		List<HashMap<String, String>> jsonList = zppService.zpp_ore_get_ingredient_list(paramMap);

		Map resultMap = new HashMap();
		resultMap.put("listValue", jsonList);

		return new ModelAndView("DataToJson", resultMap);
	}


	/**
	 * 생산관리 > 작업표준서 관리 > 작업표준서 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zpp/wsd/zpp_wsd_list", method = RequestMethod.POST)
	public ModelAndView zpp_wsd_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】생산관리 > 작업/검수 표준서 > 조회");
		ModelAndView mav = new ModelAndView();
		mav.addObject("hierarchy", "000004");
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		// session attr to param
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", ((String) session.getAttribute("userName")));
		paramMap.put("dept_cd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("dept_name", ((String) session.getAttribute("userDept")));
		paramMap.put("s_authogrp_code", ((String) session.getAttribute("s_authogrp_code")));
		logger.debug("[TEST]s_authogrp_code:{}",paramMap.get("s_authogrp_code"));
		paramMap.put("auth", (String) session.getAttribute("PP_AUTH"));
		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");
		
		logger.debug("[TEST]auth:{}",paramMap.get("auth"));

		paramMap.put("type", "wsd_type");
		paramMap.put("type_level", "1");
		
		/**
		 * commonService 에 있는 그냥 TBL_CODE_LIST 조회에서
		 * zppService 에 생산관리용 부서에 맞는 wsd_type Code List를 가져오는 Method 정의
		 * SA(시스템 관리자)나 MA(메뉴관리자) 또는 생산관리에 대한 권한이 WM(조업 **)일 경우, 기존과 같이 wsd_type의 모든 Code List를 가져온다.
		 * 나머지의 경우에는, 자신의 부서에 맞는 wsd_type의 Code List를 가져온다.
		 */
		// 2022.10.17 jykim - 주석해제
		List<HashMap<String, String>> clist1 = zppService.zpp_wsd_auth_dept_map_code_list(paramMap);
		
		
		paramMap.put("type", "wsd_type");
		paramMap.put("type_level", "2");
		if(paramMap.get("srch_type1") != null) paramMap.put("upper_val", paramMap.get("srch_type1"));
		else paramMap.put("upper_val", clist1.size() > 0 ? clist1.get(0).get("VALUE").toString() : "");
		List<HashMap<String, String>> clist2 = commonService.code_list(paramMap);
		
		mav.addObject("clist1", clist1);
		mav.addObject("clist2", clist2);
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/wsd/zpp_wsd_list");

		return mav;
	}
	
	/**
	 * 생산관리에 대한 권한 및 자신의 부서에 맞는 코드 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/yp/zpp/wsd/zpp_wsd_auth_dept_map_code_list", method = RequestMethod.POST)
	public void zpp_wsd_auth_dept_map_code_list(HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/xml; charset=utf-8");
		JSONObject json = new JSONObject();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		paramMap.put("type", "wsd_type");
		
		HttpSession session = request.getSession();
		
		String ppAuth = session.getAttribute("PP_AUTH") == null ? "" : session.getAttribute("PP_AUTH").toString();	
		if(!Util.isEmpty(ppAuth)){
			paramMap.put("auth", ppAuth);
		}
		/**
		 * 2022-10-19 smh. 
		 * 2 Level Code 데이터는 부서에 상관없이 상위 코드에 따라서 해당하는 값을 가져오자
		 */
//		List<HashMap<String, String>> result = zppService.zpp_wsd_auth_dept_map_code_list(paramMap);
		List<HashMap<String, String>> result = commonService.code_list(paramMap);
		
		json.put("result",result);
		
		PrintWriter out	= response.getWriter();
		out.print(json);
	}
	
	/**
	 * 생산관리 > 작업표준서 관리 > 작업표준서 상세보기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zpp/wsd/zpp_wsd_detail", method = RequestMethod.POST)
	public ModelAndView zpp_wsd_detail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		// session attr to param
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", ((String) session.getAttribute("userName")));
		
		/**
		 * 2022-12-21 smh 조업도급 데이터 권한 추가
		 */
		paramMap.put("auth", (String) session.getAttribute("WC_AUTH"));
		
		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");
		
		List<HashMap<String, String>> version_list = zppService.zpp_wsd_version_list(paramMap);
		
		
		
		mav.addObject("req_data", paramMap);
		mav.addObject("vlist", version_list);
		mav.setViewName("/yp/zpp/wsd/zpp_wsd_detail");

		return mav;
	}
	
	/**
	 * 전자결재 작업표준서 상세보기
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/yp/popup/zpp/wsd/gw_wsd_detail", method = RequestMethod.GET)
	public ModelAndView gw_wsd_detail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【그룹웨어 화면호출】생산관리 > 작업표준서 > 작업표준서 상세보기 팝업 ");
		ModelAndView mav = new ModelAndView();
	
		String referer = (String)request.getHeader("referer") == null ? "" : (String)request.getHeader("referer");
		
		boolean referCheck = (referer.contains("ypgw.ypzinc.co.kr") || referer.contains("gwdev.ypzinc.co.kr"));
		logger.debug("gwlogin - "+referer);
		
		if (referCheck) {
			HttpSession session = request.getSession(false);
			if (session != null) {
				session.invalidate(); // 초기화
			}
			session = request.getSession(true);
			
			// sessionOut시 Action log 남기기 위한 필드
			session.setAttribute("s_action_log", action_log);
			logger.debug("sessionoutTime - {}", sessionoutTime);
			session.setMaxInactiveInterval(60 * sessionoutTime); // 세션 유지시간(config의 세션타임아웃 참조)
			
			Util util = new Util();
			HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
	
			HashMap<String, String> data = zppService.zpp_wsd_link(paramMap);
			
			mav.addObject("req_data", paramMap);
			mav.addObject("data", data);
			mav.setViewName("/yp/zpp/wsd/gw_wsd_detail_pop");
		}	

		return mav;
	}
	
	/**
	 * 작업표준서 전자결재 상신 연동
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/yp/zpp/wsd/wsd_edoc_write", method = RequestMethod.POST)
	public void wsd_edoc_write(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String from = "【전자결재I/F】작업표준서";
		logger.debug(from);
		List list = zppService.wsd_edoc_write(request, response);
		this.JsonFlush(request, response, list, from);
	}
	
	/**
	 * 작업표준서 전자결재 상태 연동
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/yp/zpp/wsd/wsd_edoc_status", method = RequestMethod.POST)
	public void wsd_edoc_status(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String from = "【전자결재I/F】작업표준서 상태변경";
		logger.debug(from);
		List list = zppService.wsd_edoc_status(request, response);
		this.JsonFlush(request, response, list, from);
	}

	/**
	 * 생산관리 > 작업표준서 관리 > 작업표준서 상세보기 pdf 파일 url 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/wsd/wsd_view_link", method = RequestMethod.POST)
	public ModelAndView wsd_view_link(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, String> json = zppService.zpp_wsd_link(paramMap);

		return new ModelAndView("DataToJson", json);
	}

	/**
	 * 생산관리 > 작업표준서 관리 > 작업표준서 등록
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/popup/zpp/wsd/zpp_wsd_create", method = RequestMethod.POST)
	public ModelAndView zpp_wsd_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
//		Map breadcrumb = lService.select_breadcrumb(request, response);
//		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		// session attr to param
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", ((String) session.getAttribute("userName")));
		paramMap.put("dept_cd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("dept_name", ((String) session.getAttribute("userDept")));
		paramMap.put("auth", (String) session.getAttribute("HR_AUTH"));
		
		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");
		
		HashMap<String, String> code_data = new HashMap<String, String>();
		code_data.put("type", "wsd_type");
		code_data.put("type_level", "1");
		code_data.put("dept_cd", paramMap.get("dept_cd") != null ? paramMap.get("dept_cd").toString() : "");
		code_data.put("s_authogrp_code", (String) session.getAttribute("s_authogrp_code"));
		code_data.put("auth", paramMap.get("auth") != null ? paramMap.get("auth").toString() : "");
		List<HashMap<String, String>> clist = commonService.code_list(code_data);
		
		mav.addObject("clist", clist);
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/wsd/wsd_create_pop");

		return mav;
	}

	/**
	 * 생산관리 > 작업표준서 관리 > 작업표준서 등록 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/wsd/zpp_wsd_create_save", method = RequestMethod.POST)
	public ModelAndView zpp_wsd_create_save(HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest multipartRequest) throws Exception {
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", (String) session.getAttribute("empName"));
		
		ArrayList<HashMap<String, String>> upload_result = commonService.fileUpload(request,response,multipartRequest);
		paramMap.put("uploadPath", upload_result.get(0).get("uploadPath"));
		paramMap.put("fileName", upload_result.get(0).get("fileName"));
		paramMap.put("pdf_url", upload_result.get(1).get("uploadPath"));
		paramMap.put("pdf_name", upload_result.get(1).get("fileName"));
		
		String result = zppService.zpp_wsd_create_save(paramMap);
		logger.debug("***"+upload_result);
		
		HashMap<String, String> json = new HashMap<String, String>();
		json.put("result", "success");
		
		return new ModelAndView("DataToJson", json);
	}

	
	/**
	 * 생산관리 > 작업표준서 관리 > 작업표준서 갱신
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/popup/zpp/wsd/zpp_wsd_update", method = RequestMethod.POST)
	public ModelAndView zpp_wsd_update(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		// session attr to param
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", ((String) session.getAttribute("userName")));
		paramMap.put("dept_cd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("dept_name", ((String) session.getAttribute("userDept")));

		HashMap<String, String> map = zppService.zpp_wsd_list(paramMap);
		paramMap.put("TYPE1", map.get("TYPE1"));
		paramMap.put("TYPE2", map.get("TYPE2"));
		paramMap.put("CODE", map.get("CODE"));
		paramMap.put("DOC_TITLE", map.get("DOC_TITLE"));
		paramMap.put("VERSION", map.get("VERSION"));
		
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zpp/wsd/wsd_update_pop");

		return mav;
	}
	
	/**
	 * 생산관리 > 작업표준서 관리 > 작업표준서 갱신 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/popup/zpp/wsd/zpp_wsd_update_save", method = RequestMethod.POST)
	public ModelAndView zpp_wsd_update_save(HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest multipartRequest) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", (String) session.getAttribute("empName"));
		
		ArrayList<HashMap<String, String>> upload_result = commonService.fileUpload(request,response,multipartRequest);
		paramMap.put("uploadPath", upload_result.get(0).get("uploadPath"));
		paramMap.put("fileName", upload_result.get(0).get("fileName"));
		paramMap.put("pdf_url", upload_result.get(1).get("uploadPath"));
		paramMap.put("pdf_name", upload_result.get(1).get("fileName"));
		
		
		String result = zppService.zpp_wsd_update_save(paramMap);
		logger.debug("***"+upload_result);
		
		HashMap<String, String> json = new HashMap<String, String>();
		json.put("result", "success");
		
		return new ModelAndView("DataToJson", json);
	}
	
	
	/**
	 * 생산관리 > 작업표준서 관리 > 작업표준서 엑셀 다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zpp/wsd/zpp_wsd_download", method = RequestMethod.POST)
	public ModelAndView zpp_wsd_download(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttr) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HashMap<String, String> rs_map = zppService.zpp_wsd_link(paramMap);
		paramMap.put("url", rs_map.get("FILE_URL") +  rs_map.get("FILE_NAME"));
		logger.debug("***"+paramMap.get("url"));
		redirectAttr.addFlashAttribute("url",paramMap.get("url"));

		mav.setViewName("redirect:/yp/fileDown");
		
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

	private List<HashMap<String, String>> get_Ingredient_List(String master_id) throws Exception {
		HashMap pm1 = new HashMap<String, String>();

		pm1.put("MASTER_ID", master_id);
		HashMap<String, String> ret = zppService.zpp_ore_get_lbl_ig(pm1);

		List<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		HashMap<String, String> map = new HashMap<String, String>();
		HashMap<String, String> map1 = new HashMap<String, String>();

		if(ret.get("LBL_IG_1") == null) {
			map1.put("INGREDIENT_ID", "");
			map1.put("INGREDIENT_NAME", "");
		}
		else {
			String ingredient_id = ret.get("LBL_IG_1").toString();

			map.put("INGREDIENT_ID", ingredient_id);

			map1.put("INGREDIENT_ID", ingredient_id);
			map1.put("INGREDIENT_NAME", zppService.zpp_ore_get_ingredient_name(map));
		}
		list.add(map1);

		HashMap<String, String> map2 = new HashMap<String, String>();
		if(ret.get("LBL_IG_2") == null) {
			map2.put("INGREDIENT_ID", "");
			map2.put("INGREDIENT_NAME", "");
		}
		else {
			String ingredient_id = ret.get("LBL_IG_2").toString();

			map.put("INGREDIENT_ID", ingredient_id);

			map2.put("INGREDIENT_ID", ingredient_id);
			map2.put("INGREDIENT_NAME", zppService.zpp_ore_get_ingredient_name(map));
		}
		list.add(map2);

		HashMap<String, String> map3 = new HashMap<String, String>();
		if(ret.get("LBL_IG_3") == null) {
		}
		else {
			String ingredient_id = ret.get("LBL_IG_3").toString();

			map.put("INGREDIENT_ID", ingredient_id);

			map3.put("INGREDIENT_ID", ingredient_id);
			map3.put("INGREDIENT_NAME", zppService.zpp_ore_get_ingredient_name(map));

			list.add(map3);
		}

		HashMap<String, String> map4 = new HashMap<String, String>();
		if(ret.get("LBL_IG_4") == null) {
		}
		else {
			String ingredient_id = ret.get("LBL_IG_4").toString();

			map.put("INGREDIENT_ID", ingredient_id);

			map4.put("INGREDIENT_ID", ingredient_id);
			map4.put("INGREDIENT_NAME", zppService.zpp_ore_get_ingredient_name(map));

			list.add(map4);
		}

		return list;
	}

	private List<HashMap<String, String>> get_Composite_List(String master_id) throws Exception {
		HashMap pm1 = new HashMap<String, String>();

		pm1.put("MASTER_ID", master_id);
		HashMap<String, String> ret = zppService.zpp_ore_get_cps_ig(pm1);

		List<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		HashMap<String, String> map = new HashMap<String, String>();
		HashMap<String, String> map1 = new HashMap<String, String>();

		if(ret.get("CPS_IG_1") == null) {
			map1.put("INGREDIENT_ID", "");
			map1.put("INGREDIENT_NAME", "");
		}
		else {
			String ingredient_id = ret.get("CPS_IG_1").toString();

			map.put("INGREDIENT_ID", ingredient_id);

			map1.put("INGREDIENT_ID", ingredient_id);
			map1.put("INGREDIENT_NAME", zppService.zpp_ore_get_ingredient_name(map));
		}
		list.add(map1);

		HashMap<String, String> map2 = new HashMap<String, String>();
		if(ret.get("CPS_IG_2") == null) {
			map2.put("INGREDIENT_ID", "");
			map2.put("INGREDIENT_NAME", "");
		}
		else {
			String ingredient_id = ret.get("CPS_IG_2").toString();

			map.put("INGREDIENT_ID", ingredient_id);

			map2.put("INGREDIENT_ID", ingredient_id);
			map2.put("INGREDIENT_NAME", zppService.zpp_ore_get_ingredient_name(map));
		}
		list.add(map2);

		HashMap<String, String> map3 = new HashMap<String, String>();
		if(ret.get("CPS_IG_3") == null) {
			map3.put("INGREDIENT_ID", "");
			map3.put("INGREDIENT_NAME", "");
		}
		else {
			String ingredient_id = ret.get("CPS_IG_3").toString();

			map.put("INGREDIENT_ID", ingredient_id);

			map3.put("INGREDIENT_ID", ingredient_id);
			map3.put("INGREDIENT_NAME", zppService.zpp_ore_get_ingredient_name(map));
		}
		list.add(map3);

		HashMap<String, String> map4 = new HashMap<String, String>();
		if(ret.get("CPS_IG_4") == null) {
			map4.put("INGREDIENT_ID", "");
			map4.put("INGREDIENT_NAME", "");
		}
		else {
			String ingredient_id = ret.get("CPS_IG_4").toString();

			map.put("INGREDIENT_ID", ingredient_id);

			map4.put("INGREDIENT_ID", ingredient_id);
			map4.put("INGREDIENT_NAME", zppService.zpp_ore_get_ingredient_name(map));
		}
		list.add(map4);

		HashMap<String, String> map5 = new HashMap<String, String>();
		if(ret.get("CPS_IG_5") == null) {
			map5.put("INGREDIENT_ID", "");
			map5.put("INGREDIENT_NAME", "");
		}
		else {
			String ingredient_id = ret.get("CPS_IG_5").toString();

			map.put("INGREDIENT_ID", ingredient_id);

			map4.put("INGREDIENT_ID", ingredient_id);
			map4.put("INGREDIENT_NAME", zppService.zpp_ore_get_ingredient_name(map));
		}
		list.add(map5);

		return list;
	}
}
