package com.yp.zcs.ipt2.cntr;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.vicurus.it.core.common.Util;
import com.yp.login.srvc.intf.YPLoginService;
import com.yp.zcs.ipt2.srvc.intf.YP_ZCS_IPT2_Service;

@Controller
public class YP_ZCS_IPT2_Controller {
	@Autowired
	private YP_ZCS_IPT2_Service YP_ZCS_IPT2_Service;
	@Autowired
	private YPLoginService lService;
	private static final Logger logger = LoggerFactory.getLogger(YP_ZCS_IPT2_Controller.class);

	/* # 일보(공수) 시작 ################################################################################################################################################ */
	/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # 일보확정(공수) 시작 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/ipt2/zcs_ipt2_daily_rpt1", method = RequestMethod.POST)
	public ModelAndView zcs_ipt2_daily_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】정비용역 > 도급일보 > 일보확정(공수)");
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		String ent_ent_code = "";
		String ent_vendor_code = "";
		String ent_vendor_name = "";
		if ("Y".equals(request.getParameter("P_RESPONSE_VIEW"))) {
			ent_ent_code = request.getParameter("P_ENT_CODE");
			ent_vendor_code = request.getParameter("P_VENDOR_CODE");
			ent_vendor_name = request.getParameter("P_VENDOR_NAME");
			mav.addObject("P_RESPONSE_VIEW", request.getParameter("P_RESPONSE_VIEW"));
			mav.addObject("P_CONTRACT_CODE", request.getParameter("P_CONTRACT_CODE"));
			mav.addObject("P_CONTRACT_NAME", request.getParameter("P_CONTRACT_NAME"));
			mav.addObject("P_CONTRACT_PEOPLE_CNT", request.getParameter("P_CONTRACT_PEOPLE_CNT"));
			mav.addObject("P_DAILY_REQ_PEOPLE_CNT", request.getParameter("P_DAILY_REQ_PEOPLE_CNT"));
			mav.addObject("P_ENT_CODE", request.getParameter("P_ENT_CODE"));
			mav.addObject("P_VENDOR_CODE", request.getParameter("P_VENDOR_CODE"));
			mav.addObject("P_VENDOR_NAME", request.getParameter("P_VENDOR_NAME"));
			mav.addObject("P_WORK_DT", request.getParameter("P_WORK_DT"));
		} else if ("SA".equals(session.getAttribute("s_authogrp_code"))) {
			ent_ent_code = "101936";
			ent_vendor_code = "V25";
			ent_vendor_name = "주식회사 창성기계";
		} else if ("CC".equals(session.getAttribute("s_authogrp_code"))) {
			ent_ent_code = (String) session.getAttribute("ent_ent_code");
			ent_vendor_code = (String) session.getAttribute("ent_vendor_code");
			ent_vendor_name = (String) session.getAttribute("ent_vendor_name");
		}

		mav.addObject("ent_ent_code", ent_ent_code);
		mav.addObject("ent_vendor_code", ent_vendor_code);
		mav.addObject("ent_vendor_name", ent_vendor_name);

		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		mav.setViewName("/yp/zcs/ipt2/zcs_ipt2_daily_rpt1");
		return mav;
	}

	private HashMap<String, Object> remain_time_confirm(String work_dt) throws Exception {
		logger.debug("【조회】확정 - 잔여시간 조회");
		HashMap<String, Object> rt = new HashMap<String, Object>();
		int possible_base_dt = (1 + 1); // 잔여시간은 1일을 추가해 줌
		int possible_dt = 0;

		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd");
		Date today_dt = new Date();
		Date limit_dt = new Date();
		Calendar today_cal = Calendar.getInstance();
		Calendar limit_cal = Calendar.getInstance();
		String today_str = sdf1.format(today_dt);
		today_dt = sdf1.parse(today_str);
		today_cal.setTime(today_dt);

		limit_dt = sdf2.parse(work_dt.replace("/", ""));
		limit_cal.setTime(limit_dt);

		logger.debug("선택 데이터 - [{}], 요일(1:일, 2:월, ... , 6:금, 7:토) - [{}]", work_dt, limit_cal.get(Calendar.DAY_OF_WEEK));
		// 확정
		if (limit_cal.get(Calendar.DAY_OF_WEEK) == 6) {
			// 금요일
			possible_dt = possible_base_dt + 2;
		} else if (limit_cal.get(Calendar.DAY_OF_WEEK) == 7) {
			// 토요일
			possible_dt = possible_base_dt + 1;
		} else {
			possible_dt = possible_base_dt;
		}
		logger.debug("추가일수 - [{}]", possible_dt);
		// 가능일자 설정
		limit_cal.add(Calendar.DATE, possible_dt);
		logger.debug("오늘 - [{}], 가능일자 - [{}]", sdf1.format(today_cal.getTime()), sdf1.format(limit_cal.getTime()));
		long diff = limit_cal.getTimeInMillis() - today_cal.getTimeInMillis();
		long sec = diff / 1000;
		long min = diff / ( 60 * 1000 );
		long hour = diff / ( 60 * 60 * 1000 );
		long day = diff / ( 24 * 60 * 60 * 1000 );
		Object[] obj = { day, prefix_hms( hour ), prefix_hms( min - hour * 60 ), prefix_hms( sec - min * 60 ) };
		logger.debug("day - {}, hour - {}, min - {}, sec - {}", obj);
		if(diff < 0) {
			rt.put( "remain_bool", true );
			rt.put( "remain_time", "00:00:00" );
		}else {
			rt.put( "remain_bool", false );
//			rt.put( "remain_time", prefix_hms( hour - day * 24 ) + ":" + prefix_hms( min - hour * 60 ) + ":" + prefix_hms( sec - min * 60 ) );
			rt.put( "remain_time", prefix_hms( hour ) + ":" + prefix_hms( min - hour * 60 ) + ":" + prefix_hms( sec - min * 60 ) );
		}
		return rt;
	}
	private String prefix_hms(long s) throws Exception {
		String t = "";
		t = String.valueOf(s);
		return t.length() == 1 ? "0" + t : t;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/select_remain_time_confirm", method = RequestMethod.POST)
	public ModelAndView select_remain_time_confirm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 지정 간격 호출해야 하는 경우 구현할 것
		logger.debug("【확정기한 조회】정비용역 > 도급일보 > 일보확정(공수)");
		HashMap resultMap = new HashMap();
		String work_dt = request.getParameter("WORK_DT");

		int possible_base_dt = 1;
		int possible_dt = 0;

		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd");
		Date today_dt = new Date();
		Date limit_dt = new Date();
		Calendar today_cal = Calendar.getInstance();
		Calendar limit_cal = Calendar.getInstance();
		String today_str = sdf1.format(today_dt);
		today_dt = sdf1.parse(today_str);
		today_cal.setTime(today_dt);

		limit_dt = sdf2.parse(work_dt.replace("/", ""));
		limit_cal.setTime(limit_dt);

		logger.debug("선택 데이터 - [{}], 요일(1:일, 2:월, ... , 6:금, 7:토) - [{}]", work_dt, limit_cal.get(Calendar.DAY_OF_WEEK));
		// 확정
		if (limit_cal.get(Calendar.DAY_OF_WEEK) == 6) {
			// 금요일
			possible_dt = possible_base_dt + 2;
		} else if (limit_cal.get(Calendar.DAY_OF_WEEK) == 7) {
			// 토요일
			possible_dt = possible_base_dt + 1;
		} else {
			possible_dt = possible_base_dt;
		}
		logger.debug("추가일수 - [{}]", possible_dt);
		// 가능일자 설정
		limit_cal.add(Calendar.DATE, possible_dt);
		logger.debug("오늘 - [{}], 가능일자 - [{}]", sdf1.format(today_cal.getTime()), sdf1.format(limit_cal.getTime()));
		long diff = limit_cal.getTimeInMillis() - today_cal.getTimeInMillis();
		long sec = diff / 1000;
		long min = diff / ( 60 * 1000 );
		long hour = diff / ( 60 * 60 * 1000 );
		long day = diff / ( 24 * 60 * 60 * 1000 );
		
		if(diff < 0) {
			resultMap.put( "remain_bool", true );
			resultMap.put( "remain_time", "00:00:00" );
		}else {
			resultMap.put( "remain_bool", false );
			resultMap.put( "remain_time", ( hour - day * 24 ) + ":" + ( min - hour * 60 ) + ":" + ( sec - min * 60 ) );
		}
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/select_zcs_ipt2_daily_rpt1", method = RequestMethod.POST)
	public ModelAndView select_zcs_ipt2_daily_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】정비용역 > 도급일보 > 일보확정(공수)");
		HashMap resultMap = new HashMap();
		HashMap data = new HashMap();
		data = YP_ZCS_IPT2_Service.select_zcs_ipt2_daily_rpt1(request, response);
		resultMap.put("list1", data.get("list1"));
		resultMap.put("remain", remain_time_confirm(request.getParameter("WORK_DT")));
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/delete_zcs_ipt2_daily_rpt1", method = RequestMethod.POST)
	public ModelAndView delete_zcs_ipt2_daily_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【삭제】정비용역 > 도급일보 > 일보확정(공수)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.delete_zcs_ipt2_daily_rpt1(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/merge_zcs_ipt2_daily_rpt1", method = RequestMethod.POST)
	public ModelAndView merge_zcs_ipt2_daily_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【저장】정비용역 > 도급일보 > 일보확정(공수)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.merge_zcs_ipt2_daily_rpt1(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/pre_select_zcs_ipt2_daily_rpt1", method = RequestMethod.POST)
	public ModelAndView pre_select_zcs_ipt2_daily_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【승인여부 확인】정비용역 > 도급일보 > 일보확정(공수)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.pre_select_zcs_ipt2_daily_rpt1(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zcs/ipt2/possible")
	public ModelAndView possible(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap resultMap = new HashMap();

		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		String possible_str = "";
		int possible_base_dt = 0;

		if ("C".equals(req_data.get("POSSIBLE"))) {
			possible_str = "확정/확정취소";
			// 일보일자 포함 이틀
			possible_base_dt = 1;
		} else if ("A".equals(req_data.get("POSSIBLE"))) {
			possible_str = "승인/승인취소";
			// 일보일자 포함 사흘
			possible_base_dt = 2;
		} else {
			resultMap.put("possible", false);
			resultMap.put("possible_msg", "확인/승인 파라미터가 지정되지 않았습니다. 시스템 관리자에게 문의하세요.");
			return new ModelAndView("DataToJson", resultMap);
		}
		logger.debug("【컨트롤러】조업도급 > 도급검수 > 도급일보(협력사) > {} 가능 여부 확인", possible_str);

		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		Date today_dt = new Date();
		Date limit_dt = new Date();
		Calendar today_cal = Calendar.getInstance();
		Calendar limit_cal = Calendar.getInstance();
		String today_str = formatter.format(today_dt);
		today_dt = formatter.parse(today_str);
		today_cal.setTime(today_dt);
		boolean rt = true;
		
		int rt_cnt = 0;

		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			limit_dt = formatter.parse(jsonObj.get("WORK_DT").toString().replace("/", ""));
			limit_cal.setTime(limit_dt);
			int possible_dt = 0;

			logger.debug("선택 데이터 - [{}], 요일(1:일, 2:월, ... , 6:금, 7:토) - [{}]", jsonObj.get("WORK_DT"), limit_cal.get(Calendar.DAY_OF_WEEK));
			if ("C".equals(req_data.get("POSSIBLE"))) {
				// 확정
				if (limit_cal.get(Calendar.DAY_OF_WEEK) == 6) {
					// 금요일
					possible_dt = possible_base_dt + 2;
				} else if (limit_cal.get(Calendar.DAY_OF_WEEK) == 7) {
					// 토요일
					possible_dt = possible_base_dt + 1;
				} else {
					possible_dt = possible_base_dt;
				}
			} else {
				// 승인
				if (limit_cal.get(Calendar.DAY_OF_WEEK) == 5) {
					// 목요일
					possible_dt = possible_base_dt + 3;
				} else if (limit_cal.get(Calendar.DAY_OF_WEEK) == 6) {
					// 금요일
					possible_dt = possible_base_dt + 2;
				} else if (limit_cal.get(Calendar.DAY_OF_WEEK) == 7) {
					// 토요일
					possible_dt = possible_base_dt + 1;
				} else {
					possible_dt = possible_base_dt;
				}
			}
			logger.debug("추가일수 - [{}]", possible_dt);
			// 가능일자 설정
			limit_cal.add(Calendar.DATE, possible_dt);
			logger.debug("오늘 - [{}], 가능일자 - [{}]", sdf.format(today_cal.getTime()), sdf.format(limit_cal.getTime()));
			// 관리자가 허용한 경우 처리할 수 있도록 허용 로직 추가
			// 이곳에 추가
			if( "Y".equals( jsonObj.get("RELEASE_YN") ) ) {
				logger.debug("기간해제! 결과와 무관하게 true, 결과 - [{}]", !today_cal.after(limit_cal));
				continue;
			}else {
				if (today_cal.after(limit_cal)) {
					logger.debug("결과 - [{}]", !today_cal.after(limit_cal));
					if( !"Y".equals( jsonObj.get("RELEASE_YN") ) ) {
						// 가능일자 초과 처리
						rt_cnt++;
					}
				}
			}
		}
		if( rt_cnt > 0 ) {
			rt = false;
		}

		resultMap.put("possible", rt);
		if (!rt) {
			resultMap.put("possible_msg", "처리 일자를 초과하여 【" + possible_str + "】할 수 없습니다.");
		}
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/update_confirm_zcs_ipt2_daily_rpt1", method = RequestMethod.POST)
	public ModelAndView update_confirm_zcs_ipt2_daily_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【확정】정비용역 > 도급일보 > 일보확정(공수)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.update_confirm_zcs_ipt2_daily_rpt1(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/update_cancel_zcs_ipt2_daily_rpt1", method = RequestMethod.POST)
	public ModelAndView update_cancel_zcs_ipt2_daily_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【확정취소】정비용역 > 도급일보 > 일보확정(공수)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.update_cancel_zcs_ipt2_daily_rpt1(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # 일보확정(공수) 끝 */

	/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # 일보승인(공수) 시작 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/ipt2/zcs_ipt2_daily_aprv1", method = RequestMethod.POST)
	public ModelAndView zcs_ipt2_daily_aprv1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】정비용역 > 도급일보 > 일보승인(공수)");
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		String ent_ent_code = "";
		String ent_vendor_code = "";
		String ent_vendor_name = "";
		if ("Y".equals(request.getParameter("P_RESPONSE_VIEW"))) {
			ent_ent_code = request.getParameter("P_ENT_CODE");
			ent_vendor_code = request.getParameter("P_VENDOR_CODE");
			ent_vendor_name = request.getParameter("P_VENDOR_NAME");
			mav.addObject("P_RESPONSE_VIEW", request.getParameter("P_RESPONSE_VIEW"));
			mav.addObject("P_CONTRACT_CODE", request.getParameter("P_CONTRACT_CODE"));
			mav.addObject("P_CONTRACT_NAME", request.getParameter("P_CONTRACT_NAME"));
			mav.addObject("P_CONTRACT_PEOPLE_CNT", request.getParameter("P_CONTRACT_PEOPLE_CNT"));
			mav.addObject("P_DAILY_REQ_PEOPLE_CNT", request.getParameter("P_DAILY_REQ_PEOPLE_CNT"));
			mav.addObject("P_ENT_CODE", request.getParameter("P_ENT_CODE"));
			mav.addObject("P_VENDOR_CODE", request.getParameter("P_VENDOR_CODE"));
			mav.addObject("P_VENDOR_NAME", request.getParameter("P_VENDOR_NAME"));
			mav.addObject("P_WORK_DT", request.getParameter("P_WORK_DT"));
		} else if ("SA".equals(session.getAttribute("s_authogrp_code"))) {
			ent_ent_code = "101936";
			ent_vendor_code = "V25";
			ent_vendor_name = "주식회사 창성기계";
		} else if ("CC".equals(session.getAttribute("s_authogrp_code"))) {
			ent_ent_code = (String) session.getAttribute("ent_ent_code");
			ent_vendor_code = (String) session.getAttribute("ent_vendor_code");
			ent_vendor_name = (String) session.getAttribute("ent_vendor_name");
		}

		mav.addObject("ent_ent_code", ent_ent_code);
		mav.addObject("ent_vendor_code", ent_vendor_code);
		mav.addObject("ent_vendor_name", ent_vendor_name);

		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		mav.setViewName("/yp/zcs/ipt2/zcs_ipt2_daily_aprv1");
		return mav;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/select_zcs_ipt2_daily_aprv1", method = RequestMethod.POST)
	public ModelAndView select_zcs_ipt2_daily_aprv1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】정비용역 > 도급일보 > 일보승인(공수)");
		HashMap resultMap = new HashMap();
		HashMap data = new HashMap();
		data = YP_ZCS_IPT2_Service.select_zcs_ipt2_daily_aprv1(request, response);
		resultMap.put("list1", data.get("list1"));
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/update_aprv_zcs_ipt2_daily_aprv1", method = RequestMethod.POST)
	public ModelAndView update_aprv_zcs_ipt2_daily_aprv1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【승인】정비용역 > 도급일보 > 일보승인(공수)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.update_aprv_zcs_ipt2_daily_aprv1(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/update_reject_zcs_ipt2_daily_aprv1", method = RequestMethod.POST)
	public ModelAndView update_reject_zcs_ipt2_daily_aprv1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【승인취소】정비용역 > 도급일보 > 일보승인(공수)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.update_reject_zcs_ipt2_daily_aprv1(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/lock_zcs_ipt2_daily_aprv1", method = RequestMethod.POST)
	public ModelAndView lock_zcs_ipt2_daily_aprv1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【기한설정】정비용역 > 도급일보 > 일보승인(공수)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.lock_zcs_ipt2_daily_aprv1(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/release_zcs_ipt2_daily_aprv1", method = RequestMethod.POST)
	public ModelAndView release_zcs_ipt2_daily_aprv1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【기한해제】정비용역 > 도급일보 > 일보승인(공수)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.release_zcs_ipt2_daily_aprv1(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # 일보승인(공수) 끝 */
	/* # 일보(공수) 종료 ################################################################################################################################################ */

	/* # 일보(작업) 시작 ################################################################################################################################################ */
	/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # 일보확정(작업) 시작 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/ipt2/zcs_ipt2_daily_rpt2", method = RequestMethod.POST)
	public ModelAndView zcs_ipt2_daily_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】정비용역 > 도급일보 > 일보확정(작업)");
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		String ent_ent_code = "";
		String ent_vendor_code = "";
		String ent_vendor_name = "";
		if ("Y".equals(request.getParameter("P_RESPONSE_VIEW"))) {
			ent_ent_code = request.getParameter("P_ENT_CODE");
			ent_vendor_code = request.getParameter("P_VENDOR_CODE");
			ent_vendor_name = request.getParameter("P_VENDOR_NAME");
			mav.addObject("P_RESPONSE_VIEW", request.getParameter("P_RESPONSE_VIEW"));
			mav.addObject("P_CONTRACT_CODE", request.getParameter("P_CONTRACT_CODE"));
			mav.addObject("P_CONTRACT_NAME", request.getParameter("P_CONTRACT_NAME"));
			mav.addObject("P_CONTRACT_PEOPLE_CNT", request.getParameter("P_CONTRACT_PEOPLE_CNT"));
			mav.addObject("P_DAILY_REQ_PEOPLE_CNT", request.getParameter("P_DAILY_REQ_PEOPLE_CNT"));
			mav.addObject("P_ENT_CODE", request.getParameter("P_ENT_CODE"));
			mav.addObject("P_VENDOR_CODE", request.getParameter("P_VENDOR_CODE"));
			mav.addObject("P_VENDOR_NAME", request.getParameter("P_VENDOR_NAME"));
			mav.addObject("P_WORK_DT", request.getParameter("P_WORK_DT"));
		} else if ("SA".equals(session.getAttribute("s_authogrp_code"))) {
			ent_ent_code = "101936";
			ent_vendor_code = "V25";
			ent_vendor_name = "주식회사 창성기계";
		} else if ("CC".equals(session.getAttribute("s_authogrp_code"))) {
			ent_ent_code = (String) session.getAttribute("ent_ent_code");
			ent_vendor_code = (String) session.getAttribute("ent_vendor_code");
			ent_vendor_name = (String) session.getAttribute("ent_vendor_name");
		}

		mav.addObject("ent_ent_code", ent_ent_code);
		mav.addObject("ent_vendor_code", ent_vendor_code);
		mav.addObject("ent_vendor_name", ent_vendor_name);

		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		mav.setViewName("/yp/zcs/ipt2/zcs_ipt2_daily_rpt2");
		return mav;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/select_zcs_ipt2_daily_rpt2", method = RequestMethod.POST)
	public ModelAndView select_zcs_ipt2_daily_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】정비용역 > 도급일보 > 일보확정(작업)");
		HashMap resultMap = new HashMap();
		HashMap data = new HashMap();
		data = YP_ZCS_IPT2_Service.select_zcs_ipt2_daily_rpt2(request, response);
		resultMap.put("list1", data.get("list1"));
		resultMap.put("list2", data.get("list2"));
		resultMap.put("list3", data.get("list3"));
		resultMap.put("remain", remain_time_confirm(request.getParameter("WORK_DT")));
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/delete_zcs_ipt2_daily_rpt2", method = RequestMethod.POST)
	public ModelAndView delete_zcs_ipt2_daily_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【삭제】정비용역 > 도급일보 > 일보확정(작업)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.delete_zcs_ipt2_daily_rpt2(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/delete_zcs_ipt2_daily_rpt2_tag", method = RequestMethod.POST)
	public ModelAndView delete_zcs_ipt2_daily_rpt2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【삭제】정비용역 > 도급일보 > 일보확정(작업-태그데이터)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.delete_zcs_ipt2_daily_rpt2_tag(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/merge_zcs_ipt2_daily_rpt2", method = RequestMethod.POST)
	public ModelAndView merge_zcs_ipt2_daily_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【저장】정비용역 > 도급일보 > 일보확정(작업)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.merge_zcs_ipt2_daily_rpt2(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/merge_zcs_ipt2_daily_rpt2_tag", method = RequestMethod.POST)
	public ModelAndView merge_zcs_ipt2_daily_rpt2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【저장】정비용역 > 도급일보 > 일보확정(작업-태그데이터)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.merge_zcs_ipt2_daily_rpt2_tag(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/pre_select_zcs_ipt2_daily_rpt2", method = RequestMethod.POST)
	public ModelAndView pre_select_zcs_ipt2_daily_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【승인여부 확인】정비용역 > 도급일보 > 일보확정(작업)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.pre_select_zcs_ipt2_daily_rpt2(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/pre_select_zcs_ipt2_daily_rpt2_tag", method = RequestMethod.POST)
	public ModelAndView pre_select_zcs_ipt2_daily_rpt2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【승인여부 확인】정비용역 > 도급일보 > 일보확정(작업-태그데이터)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.pre_select_zcs_ipt2_daily_rpt2_tag(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/update_confirm_zcs_ipt2_daily_rpt2", method = RequestMethod.POST)
	public ModelAndView update_confirm_zcs_ipt2_daily_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【확정】정비용역 > 도급일보 > 일보확정(작업)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.update_confirm_zcs_ipt2_daily_rpt2(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/update_cancel_zcs_ipt2_daily_rpt2", method = RequestMethod.POST)
	public ModelAndView update_cancel_zcs_ipt2_daily_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【확정취소】정비용역 > 도급일보 > 일보확정(작업)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.update_cancel_zcs_ipt2_daily_rpt2(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/update_confirm_zcs_ipt2_daily_rpt2_tag", method = RequestMethod.POST)
	public ModelAndView update_confirm_zcs_ipt2_daily_rpt2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【확정】정비용역 > 도급일보 > 일보확정(작업-태그데이터)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.update_confirm_zcs_ipt2_daily_rpt2_tag(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/update_cancel_zcs_ipt2_daily_rpt2_tag", method = RequestMethod.POST)
	public ModelAndView update_cancel_zcs_ipt2_daily_rpt2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【확정취소】정비용역 > 도급일보 > 일보확정(작업-태그데이터)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.update_cancel_zcs_ipt2_daily_rpt2_tag(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # 일보확정(작업) 끝 */

	/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # 일보승인(작업) 시작 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/ipt2/zcs_ipt2_daily_aprv2", method = RequestMethod.POST)
	public ModelAndView zcs_ipt2_daily_aprv2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】정비용역 > 도급일보 > 일보승인(작업)");
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		String ent_ent_code = "";
		String ent_vendor_code = "";
		String ent_vendor_name = "";
		if ("Y".equals(request.getParameter("P_RESPONSE_VIEW"))) {
			ent_ent_code = request.getParameter("P_ENT_CODE");
			ent_vendor_code = request.getParameter("P_VENDOR_CODE");
			ent_vendor_name = request.getParameter("P_VENDOR_NAME");
			mav.addObject("P_RESPONSE_VIEW", request.getParameter("P_RESPONSE_VIEW"));
			mav.addObject("P_CONTRACT_CODE", request.getParameter("P_CONTRACT_CODE"));
			mav.addObject("P_CONTRACT_NAME", request.getParameter("P_CONTRACT_NAME"));
			mav.addObject("P_CONTRACT_PEOPLE_CNT", request.getParameter("P_CONTRACT_PEOPLE_CNT"));
			mav.addObject("P_DAILY_REQ_PEOPLE_CNT", request.getParameter("P_DAILY_REQ_PEOPLE_CNT"));
			mav.addObject("P_ENT_CODE", request.getParameter("P_ENT_CODE"));
			mav.addObject("P_VENDOR_CODE", request.getParameter("P_VENDOR_CODE"));
			mav.addObject("P_VENDOR_NAME", request.getParameter("P_VENDOR_NAME"));
			mav.addObject("P_WORK_DT", request.getParameter("P_WORK_DT"));
		} else if ("SA".equals(session.getAttribute("s_authogrp_code"))) {
			ent_ent_code = "101936";
			ent_vendor_code = "V25";
			ent_vendor_name = "주식회사 창성기계";
		} else if ("CC".equals(session.getAttribute("s_authogrp_code"))) {
			ent_ent_code = (String) session.getAttribute("ent_ent_code");
			ent_vendor_code = (String) session.getAttribute("ent_vendor_code");
			ent_vendor_name = (String) session.getAttribute("ent_vendor_name");
		}

		mav.addObject("ent_ent_code", ent_ent_code);
		mav.addObject("ent_vendor_code", ent_vendor_code);
		mav.addObject("ent_vendor_name", ent_vendor_name);

		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		mav.setViewName("/yp/zcs/ipt2/zcs_ipt2_daily_aprv2");
		return mav;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/select_zcs_ipt2_daily_aprv2", method = RequestMethod.POST)
	public ModelAndView select_zcs_ipt2_daily_aprv2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】정비용역 > 도급일보 > 일보승인(작업)");
		HashMap resultMap = new HashMap();
		HashMap data = new HashMap();
		data = YP_ZCS_IPT2_Service.select_zcs_ipt2_daily_aprv2(request, response);
		resultMap.put("list1", data.get("list1"));
		resultMap.put("list2", data.get("list2"));
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/update_aprv_zcs_ipt2_daily_aprv2", method = RequestMethod.POST)
	public ModelAndView update_aprv_zcs_ipt2_daily_aprv2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【승인】정비용역 > 도급일보 > 일보승인(작업)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.update_aprv_zcs_ipt2_daily_aprv2(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/update_reject_zcs_ipt2_daily_aprv2", method = RequestMethod.POST)
	public ModelAndView update_reject_zcs_ipt2_daily_aprv2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【승인취소】정비용역 > 도급일보 > 일보승인(작업)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.update_reject_zcs_ipt2_daily_aprv2(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/update_aprv_zcs_ipt2_daily_aprv2_tag", method = RequestMethod.POST)
	public ModelAndView update_aprv_zcs_ipt2_daily_aprv2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【승인】정비용역 > 도급일보 > 일보승인(작업-태그데이터)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.update_aprv_zcs_ipt2_daily_aprv2_tag(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/update_reject_zcs_ipt2_daily_aprv2_tag", method = RequestMethod.POST)
	public ModelAndView update_reject_zcs_ipt2_daily_aprv2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【승인취소】정비용역 > 도급일보 > 일보승인(작업-태그데이터)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.update_reject_zcs_ipt2_daily_aprv2_tag(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/lock_zcs_ipt2_daily_aprv2", method = RequestMethod.POST)
	public ModelAndView lock_zcs_ipt2_daily_aprv2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【기한설정】정비용역 > 도급일보 > 일보승인(작업)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.lock_zcs_ipt2_daily_aprv2(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/release_zcs_ipt2_daily_aprv2", method = RequestMethod.POST)
	public ModelAndView release_zcs_ipt2_daily_aprv2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【기한해제】정비용역 > 도급일보 > 일보승인(작업)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.release_zcs_ipt2_daily_aprv2(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/lock_zcs_ipt2_daily_aprv2_tag", method = RequestMethod.POST)
	public ModelAndView lock_zcs_ipt2_daily_aprv2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【기한설정】정비용역 > 도급일보 > 일보승인(작업)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.lock_zcs_ipt2_daily_aprv2_tag(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/release_zcs_ipt2_daily_aprv2_tag", method = RequestMethod.POST)
	public ModelAndView release_zcs_ipt2_daily_aprv2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【기한해제】정비용역 > 도급일보 > 일보승인(작업)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.release_zcs_ipt2_daily_aprv2_tag(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # 일보확정(작업) 끝 */
	/* # 일보(작업) 종료 ################################################################################################################################################ */

	/* # 일보(월정액) 시작 ################################################################################################################################################ */
	/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # 일보확정(월정액) 시작 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/ipt2/zcs_ipt2_daily_rpt3", method = RequestMethod.POST)
	public ModelAndView zcs_ipt2_daily_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】정비용역 > 도급일보 > 일보확정(월정액)");
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		String ent_ent_code = "";
		String ent_vendor_code = "";
		String ent_vendor_name = "";
		if ("Y".equals(request.getParameter("P_RESPONSE_VIEW"))) {
			ent_ent_code = request.getParameter("P_ENT_CODE");
			ent_vendor_code = request.getParameter("P_VENDOR_CODE");
			ent_vendor_name = request.getParameter("P_VENDOR_NAME");
			mav.addObject("P_RESPONSE_VIEW", request.getParameter("P_RESPONSE_VIEW"));
			mav.addObject("P_CONTRACT_CODE", request.getParameter("P_CONTRACT_CODE"));
			mav.addObject("P_CONTRACT_NAME", request.getParameter("P_CONTRACT_NAME"));
			mav.addObject("P_CONTRACT_PEOPLE_CNT", request.getParameter("P_CONTRACT_PEOPLE_CNT"));
			mav.addObject("P_DAILY_REQ_PEOPLE_CNT", request.getParameter("P_DAILY_REQ_PEOPLE_CNT"));
			mav.addObject("P_ENT_CODE", request.getParameter("P_ENT_CODE"));
			mav.addObject("P_VENDOR_CODE", request.getParameter("P_VENDOR_CODE"));
			mav.addObject("P_VENDOR_NAME", request.getParameter("P_VENDOR_NAME"));
			mav.addObject("P_WORK_DT", request.getParameter("P_WORK_DT"));
		} else if ("SA".equals(session.getAttribute("s_authogrp_code"))) {
			ent_ent_code = "101936";
			ent_vendor_code = "V25";
			ent_vendor_name = "주식회사 창성기계";
		} else if ("CC".equals(session.getAttribute("s_authogrp_code"))) {
			ent_ent_code = (String) session.getAttribute("ent_ent_code");
			ent_vendor_code = (String) session.getAttribute("ent_vendor_code");
			ent_vendor_name = (String) session.getAttribute("ent_vendor_name");
		}

		mav.addObject("ent_ent_code", ent_ent_code);
		mav.addObject("ent_vendor_code", ent_vendor_code);
		mav.addObject("ent_vendor_name", ent_vendor_name);

		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		mav.setViewName("/yp/zcs/ipt2/zcs_ipt2_daily_rpt3");
		return mav;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/select_zcs_ipt2_daily_rpt3", method = RequestMethod.POST)
	public ModelAndView select_zcs_ipt2_daily_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】정비용역 > 도급일보 > 일보확정(월정액)");
		HashMap resultMap = new HashMap();
		HashMap data = new HashMap();
		data = YP_ZCS_IPT2_Service.select_zcs_ipt2_daily_rpt3(request, response);
		resultMap.put("list1", data.get("list1"));
		resultMap.put("remain", remain_time_confirm(request.getParameter("WORK_DT")));
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/delete_zcs_ipt2_daily_rpt3", method = RequestMethod.POST)
	public ModelAndView delete_zcs_ipt2_daily_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【삭제】정비용역 > 도급일보 > 일보확정(월정액)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.delete_zcs_ipt2_daily_rpt3(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/merge_zcs_ipt2_daily_rpt3", method = RequestMethod.POST)
	public ModelAndView merge_zcs_ipt2_daily_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【저장】정비용역 > 도급일보 > 일보확정(월정액)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.merge_zcs_ipt2_daily_rpt3(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/pre_select_zcs_ipt2_daily_rpt3", method = RequestMethod.POST)
	public ModelAndView pre_select_zcs_ipt2_daily_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【승인여부 확인】정비용역 > 도급일보 > 일보확정(월정액)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.pre_select_zcs_ipt2_daily_rpt3(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/update_confirm_zcs_ipt2_daily_rpt3", method = RequestMethod.POST)
	public ModelAndView update_confirm_zcs_ipt2_daily_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【확정】정비용역 > 도급일보 > 일보확정(월정액)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.update_confirm_zcs_ipt2_daily_rpt3(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/update_cancel_zcs_ipt2_daily_rpt3", method = RequestMethod.POST)
	public ModelAndView update_cancel_zcs_ipt2_daily_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【확정취소】정비용역 > 도급일보 > 일보확정(월정액)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.update_cancel_zcs_ipt2_daily_rpt3(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # 일보확정(월정액) 끝 */

	/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # 일보승인(월정액) 시작 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/ipt2/zcs_ipt2_daily_aprv3", method = RequestMethod.POST)
	public ModelAndView zcs_ipt2_daily_aprv3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】정비용역 > 도급일보 > 일보승인(월정액)");
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		String ent_ent_code = "";
		String ent_vendor_code = "";
		String ent_vendor_name = "";
		if ("Y".equals(request.getParameter("P_RESPONSE_VIEW"))) {
			ent_ent_code = request.getParameter("P_ENT_CODE");
			ent_vendor_code = request.getParameter("P_VENDOR_CODE");
			ent_vendor_name = request.getParameter("P_VENDOR_NAME");
			mav.addObject("P_RESPONSE_VIEW", request.getParameter("P_RESPONSE_VIEW"));
			mav.addObject("P_CONTRACT_CODE", request.getParameter("P_CONTRACT_CODE"));
			mav.addObject("P_CONTRACT_NAME", request.getParameter("P_CONTRACT_NAME"));
			mav.addObject("P_CONTRACT_PEOPLE_CNT", request.getParameter("P_CONTRACT_PEOPLE_CNT"));
			mav.addObject("P_DAILY_REQ_PEOPLE_CNT", request.getParameter("P_DAILY_REQ_PEOPLE_CNT"));
			mav.addObject("P_ENT_CODE", request.getParameter("P_ENT_CODE"));
			mav.addObject("P_VENDOR_CODE", request.getParameter("P_VENDOR_CODE"));
			mav.addObject("P_VENDOR_NAME", request.getParameter("P_VENDOR_NAME"));
			mav.addObject("P_WORK_DT", request.getParameter("P_WORK_DT"));
		} else if ("SA".equals(session.getAttribute("s_authogrp_code"))) {
			ent_ent_code = "101936";
			ent_vendor_code = "V25";
			ent_vendor_name = "주식회사 창성기계";
		} else if ("CC".equals(session.getAttribute("s_authogrp_code"))) {
			ent_ent_code = (String) session.getAttribute("ent_ent_code");
			ent_vendor_code = (String) session.getAttribute("ent_vendor_code");
			ent_vendor_name = (String) session.getAttribute("ent_vendor_name");
		}

		mav.addObject("ent_ent_code", ent_ent_code);
		mav.addObject("ent_vendor_code", ent_vendor_code);
		mav.addObject("ent_vendor_name", ent_vendor_name);

		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		mav.setViewName("/yp/zcs/ipt2/zcs_ipt2_daily_aprv3");
		return mav;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/select_zcs_ipt2_daily_aprv3", method = RequestMethod.POST)
	public ModelAndView select_zcs_ipt2_daily_aprv3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】정비용역 > 도급일보 > 일보승인(월정액)");
		HashMap resultMap = new HashMap();
		HashMap data = new HashMap();
		data = YP_ZCS_IPT2_Service.select_zcs_ipt2_daily_aprv3(request, response);
		resultMap.put("list1", data.get("list1"));
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/update_aprv_zcs_ipt2_daily_aprv3", method = RequestMethod.POST)
	public ModelAndView update_aprv_zcs_ipt2_daily_aprv3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【승인】정비용역 > 도급일보 > 일보승인(월정액)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.update_aprv_zcs_ipt2_daily_aprv3(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/update_reject_zcs_ipt2_daily_aprv3", method = RequestMethod.POST)
	public ModelAndView update_reject_zcs_ipt2_daily_aprv3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【승인취소】정비용역 > 도급일보 > 일보승인(월정액)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.update_reject_zcs_ipt2_daily_aprv3(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/lock_zcs_ipt2_daily_aprv3", method = RequestMethod.POST)
	public ModelAndView lock_zcs_ipt2_daily_aprv3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【기한설정】정비용역 > 도급일보 > 일보승인(월정액)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.lock_zcs_ipt2_daily_aprv3(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/release_zcs_ipt2_daily_aprv3", method = RequestMethod.POST)
	public ModelAndView release_zcs_ipt2_daily_aprv3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【기한해제】정비용역 > 도급일보 > 일보승인(월정액)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.release_zcs_ipt2_daily_aprv3(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # 일보승인(월정액) 끝 */
	/* # 일보(월정액) 종료 ################################################################################################################################################ */

	/* # 일보조회 시작 ################################################################################################################################################ */
	/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # 일보조회 시작 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/ipt2/zcs_ipt2_daily_view", method = RequestMethod.POST)
	public ModelAndView zcs_ipt2_daily_view(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】정비용역 > 도급일보 > 일보조회");
		ModelAndView mav = new ModelAndView();

		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		mav.setViewName("/yp/zcs/ipt2/zcs_ipt2_daily_view");
		return mav;
	}
	/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # 일보조회 끝 */

	/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # 일보조회(협력업체) 시작 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/ipt2/zcs_ipt2_daily_view_cc", method = RequestMethod.POST)
	public ModelAndView zcs_ipt2_daily_view_cc(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】정비용역 > 도급일보 > 일보조회(협력업체)");
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		String ent_ent_code = "";
		String ent_vendor_code = "";
		String ent_vendor_name = "";
		if ("SA".equals(session.getAttribute("s_authogrp_code"))) {
			ent_ent_code = "101936";
			ent_vendor_code = "V25";
			ent_vendor_name = "주식회사 창성기계";
		} else {
			ent_ent_code = (String) session.getAttribute("ent_ent_code");
			ent_vendor_code = (String) session.getAttribute("ent_vendor_code");
			ent_vendor_name = (String) session.getAttribute("ent_vendor_name");
		}

		mav.addObject("ent_ent_code", ent_ent_code);
		mav.addObject("ent_vendor_code", ent_vendor_code);
		mav.addObject("ent_vendor_name", ent_vendor_name);

		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		mav.setViewName("/yp/zcs/ipt2/zcs_ipt2_daily_view_cc");
		return mav;
	}
	/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # 일보조회(협력업체) 끝 */
	/* # 일보조회 종료 ################################################################################################################################################ */

	/* # 월보등록 시작 ################################################################################################################################################ */
	/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # 월보등록(공수) 시작 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/ipt2/zcs_ipt2_month_rpt1", method = RequestMethod.POST)
	public ModelAndView zcs_ipt2_month_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】정비용역 > 비용처리 > 월보등록(공수)");
		ModelAndView mav = new ModelAndView();

		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		mav.setViewName("/yp/zcs/ipt2/zcs_ipt2_month_rpt1");
		return mav;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/select_zcs_ipt2_month_rpt1", method = RequestMethod.POST)
	public ModelAndView select_zcs_ipt2_month_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】정비용역 > 비용처리 > 월보등록(공수)");
		HashMap resultMap = new HashMap();
		HashMap data = new HashMap();
		data = YP_ZCS_IPT2_Service.select_zcs_ipt2_month_rpt1(request, response);
		resultMap.put("list1", data.get("list1"));
		resultMap.put("list2", data.get("map2"));

		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/delete_zcs_ipt2_month_rpt1", method = RequestMethod.POST)
	public ModelAndView delete_zcs_ipt2_month_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【삭제】정비용역 > 비용처리 > 월보등록(공수)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.delete_zcs_ipt2_month_rpt1(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/merge_zcs_ipt2_month_rpt1", method = RequestMethod.POST)
	public ModelAndView merge_zcs_ipt2_month_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【저장】정비용역 > 비용처리 > 월보등록(공수)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.merge_zcs_ipt2_month_rpt1(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # 월보등록(공수) 끝 */

	/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # 월보등록(작업) 시작 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/ipt2/zcs_ipt2_month_rpt2", method = RequestMethod.POST)
	public ModelAndView zcs_ipt2_month_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】정비용역 > 비용처리 > 월보등록(작업)");
		ModelAndView mav = new ModelAndView();

		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		mav.setViewName("/yp/zcs/ipt2/zcs_ipt2_month_rpt2");
		return mav;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/select_zcs_ipt2_month_rpt2", method = RequestMethod.POST)
	public ModelAndView select_zcs_ipt2_month_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】정비용역 > 비용처리 > 월보등록(작업)");
		HashMap resultMap = new HashMap();
		HashMap data = new HashMap();
		data = YP_ZCS_IPT2_Service.select_zcs_ipt2_month_rpt2(request, response);
		resultMap.put("list1", data.get("list1"));
		resultMap.put("list2", data.get("list2"));

		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/delete_zcs_ipt2_month_rpt2", method = RequestMethod.POST)
	public ModelAndView delete_zcs_ipt2_month_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【작업 삭제】정비용역 > 비용처리 > 월보등록(작업)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.delete_zcs_ipt2_month_rpt2(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/delete_zcs_ipt2_month_rpt2_tag", method = RequestMethod.POST)
	public ModelAndView delete_zcs_ipt2_month_rpt2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【태그데이터 삭제】정비용역 > 비용처리 > 월보등록(작업)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.delete_zcs_ipt2_month_rpt2_tag(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/merge_zcs_ipt2_month_rpt2", method = RequestMethod.POST)
	public ModelAndView merge_zcs_ipt2_month_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【작업 저장】정비용역 > 비용처리 > 월보등록(작업)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.merge_zcs_ipt2_month_rpt2(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/merge_zcs_ipt2_month_rpt2_tag", method = RequestMethod.POST)
	public ModelAndView merge_zcs_ipt2_month_rpt2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【태그데이터 저장】정비용역 > 비용처리 > 월보등록(작업)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.merge_zcs_ipt2_month_rpt2_tag(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # 월보등록(작업) 끝 */

	/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # 월보등록(월정액) 시작 */
	@SuppressWarnings({"rawtypes"})
	@RequestMapping(value = "/yp/zcs/ipt2/zcs_ipt2_month_rpt3", method = RequestMethod.POST)
	public ModelAndView zcs_ipt2_month_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】정비용역 > 비용처리 > 월보등록(월정액)");
		ModelAndView mav = new ModelAndView();

		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		mav.setViewName("/yp/zcs/ipt2/zcs_ipt2_month_rpt3");
		return mav;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/select_zcs_ipt2_month_rpt3", method = RequestMethod.POST)
	public ModelAndView select_zcs_ipt2_month_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】정비용역 > 비용처리 > 월보등록(월정액)");
		HashMap resultMap = new HashMap();
		HashMap data = new HashMap();
		data = YP_ZCS_IPT2_Service.select_zcs_ipt2_month_rpt3(request, response);
		resultMap.put("list1", data.get("list1"));
		resultMap.put("list2", data.get("map2"));

		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/delete_zcs_ipt2_month_rpt3", method = RequestMethod.POST)
	public ModelAndView delete_zcs_ipt2_month_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【삭제】정비용역 > 비용처리 > 월보등록(월정액)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.delete_zcs_ipt2_month_rpt3(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value = "/yp/zcs/ipt2/merge_zcs_ipt2_month_rpt3", method = RequestMethod.POST)
	public ModelAndView merge_zcs_ipt2_month_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【저장】정비용역 > 비용처리 > 월보등록(월정액)");
		HashMap resultMap = new HashMap();
		int result = 0;
		result = YP_ZCS_IPT2_Service.merge_zcs_ipt2_month_rpt3(request, response);
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # 월보등록(월정액) 끝 */
	/* # 월보등록 종료 ################################################################################################################################################ */
}
