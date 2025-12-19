package com.vicurus.it.core.interceptor;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.IOUtils;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import com.vicurus.it.core.common.SessionList;
import com.vicurus.it.core.common.Util;
import com.vicurus.it.core.common.srvc.intf.CommonService;
import com.vicurus.it.core.login.srvc.intf.LoginService;
import com.vicurus.it.core.validation.srvc.intf.ValidationService;

public class Interceptor extends HandlerInterceptorAdapter{
	@Autowired
	private CommonService commonService;
	@Autowired
	private LoginService loginService;
	@Autowired
	private ValidationService validationService;
	
	private static final Logger logger = LoggerFactory.getLogger(Interceptor.class);
	
	//config.properties 에서 설정 정보 가져오기 시작
	@Value("#{config['session.outMSG']}")
	private String sessionoutMSG;
	
	@Value("#{config['sys.adminIP']}")
	private String adminIP;
	
	@Value("#{config['sys.action_log']}")
	private String actionLog;
	//config.properties 에서 설정 정보 가져오기 끝
	
	Util util = new Util();
	
	@SuppressWarnings("unchecked")
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		SessionList sessionList = new SessionList();
		
		String user_id    = (String) request.getSession().getAttribute("s_emp_code");
		String client_ip  = util.getIp(request);
		String session_ip = (String)request.getSession().getAttribute("ip") == null? "" : (String)request.getSession().getAttribute("ip");
		
		//ajax 요청 유무
		String requestAjaxCheck =  (String)request.getHeader("X-Requested-With");
		logger.debug("request uri -> URI: {}", request.getRequestURI());
		
		try{
			
			logger.debug("URI: {}", request.getRequestURI());
			logger.debug("Interceptor SessionID: {}", request.getSession().getId());
			
			//해당 URL은 인터셉터 하이패스
			if(
					//"/core/login/ChkId.do".equals(request.getRequestURI()) || 
					"/core/login/login".equals(request.getRequestURI()) ||
					"/".equals(request.getRequestURI()) ||
					"/core/login/sessionError.do".equals(request.getRequestURI()) ||
					"/core/error/400.do".equals(request.getRequestURI()) ||
					"/core/error/401.do".equals(request.getRequestURI()) ||
					"/core/error/403.do".equals(request.getRequestURI()) ||
					"/core/error/404.do".equals(request.getRequestURI()) ||
					"/core/error/405.do".equals(request.getRequestURI()) ||
					"/core/error/500.do".equals(request.getRequestURI()) ||
					"/core/login/resetPassword".equals(request.getRequestURI())||
					"/core/login/dup_login.do".equals(request.getRequestURI())||
					"/core/login/sessionOut.do".equals(request.getRequestURI())
			){
				return true;
			}else if(
				/**
				 * 전자결재 영역
				 */
				// 2020-10-21 jamerl - 영풍 그룹웨어 전자결재 데이터 요청 URL
				"/yp/popup/login/pwd_reset".equals(request.getRequestURI()) ||
				"/yp/popup/login/update_pwd_reset".equals(request.getRequestURI()) ||
				"/yp/zwc/eai/working_monthly_report".equals(request.getRequestURI()) ||
				"/yp/zwc/eai/working_subc_pst_adj".equals(request.getRequestURI()) ||
				"/yp/zwc/eai/working_subc_cost_count".equals(request.getRequestURI()) ||
				"/yp/zwc/eai/working_reto_cost_count".equals(request.getRequestURI()) ||
				"/yp/zcs/eai/construction_chk_rpt".equals(request.getRequestURI()) ||
				"/yp/zwc/eai/working_eai_status".equals(request.getRequestURI()) ||
				"/yp/zpp/wsd/wsd_edoc_write".equals(request.getRequestURI()) ||
				"/yp/popup/zpp/wsd/gw_wsd_detail".equals(request.getRequestURI()) ||
				"/yp/zpp/wsd/wsd_edoc_status".equals(request.getRequestURI()) ||
				"/yp/zpp/wsd/zpp_wsd_link".equals(request.getRequestURI()) ||
				"/yp/zmm/aw/zmm_weight_calc_edoc_write".equals(request.getRequestURI()) ||
				"/yp/zmm/aw/zmm_edoc_status_update".equals(request.getRequestURI()) ||
				"/yp/zmm/aw/retrieveMATNR_SW".equals(request.getRequestURI()) ||
				"/yp/zmm/aw/retrieveKUNNR_SW".equals(request.getRequestURI()) ||
				
				// 2025-01-20 ichwang - 삼우계량 JSON 연동개발 추가
				"/yp/zmm/aw/zmm_weight_data_json".equals(request.getRequestURI()) ||
				"/yp/zmm/aw/zmm_weight_data_edoc_write".equals(request.getRequestURI()) ||
				"/yp/zmm/aw/zmm_edoc_data_update".equals(request.getRequestURI()) ||
				
				// 비품
				"/yp/fixture/fixture_req_data".equals(request.getRequestURI()) ||
				"/yp/fixture/fixture_edoc_status_update".equals(request.getRequestURI()) ||
				
				//전산작업
				"/yp/wr/wr_req_data".equals(request.getRequestURI()) ||
				"/yp/wr/wr_edoc_status_update".equals(request.getRequestURI()) ||
				"/yp/wr/wr_edoc_status_update_report".equals(request.getRequestURI()) ||
				"/yp/wr/wr_edoc_status_update_final".equals(request.getRequestURI()) ||
				
				"/yp/wr/wr_req_data_D".equals(request.getRequestURI()) ||
				"/yp/wr/wr_req_data_A".equals(request.getRequestURI()) ||
				"/yp/wr/wr_req_data_E".equals(request.getRequestURI()) ||
				"/yp/wr/wr_req_data_B".equals(request.getRequestURI()) ||
				
				// 정광심판판정
				"/zpp/ore/zpp_ore_fixed_value/edoc/req_data".equals(request.getRequestURI()) ||
				"/zpp/ore/zpp_ore_fixed_value/edoc/status".equals(request.getRequestURI()) ||
				"/zpp/ore/zpp_ore_request/edoc/req_data_html".equals(request.getRequestURI()) ||
				"/zpp/ore/zpp_ore_seller_query/edoc/req_data_html".equals(request.getRequestURI()) ||
				"/zpp/ore/zpp_ore_seller_query/edoc/status".equals(request.getRequestURI()) ||
				"/zpp/ore/zpp_ore_seller_compare/edoc/req_data_html".equals(request.getRequestURI()) ||
				"/zpp/ore/zpp_ore_seller_compare/edoc/status".equals(request.getRequestURI()) ||
				
				//테스트
				"/yp/test/get_test_data".equals(request.getRequestURI()) ||
				"/yp/test/get_test_data2".equals(request.getRequestURI()) ||
				"/yp/test/status_test".equals(request.getRequestURI()) ||
				"/yp/test/get_test_column_data".equals(request.getRequestURI())
			){
				logger.debug("영풍 그룹웨어 전자결재 데이터 요청 URL - {}", request.getRequestURI());
				return true;
			}else if(
				// 2022-10-12 smh - API endpoint 하이패스
				"/yp/api/endpoint/get_daily_zinc_prod".equals(request.getRequestURI()) ||
				// 2022-10-31 smh - DLP 정책 적용 하이패스
				"/yp/api/sendisapi_json".equals(request.getRequestURI()) ||
				// 2020-07-14 jamerl - 영풍 웹포털 인터셉터 하이패스 추가
				"/yp/login/login".equals(request.getRequestURI())
			){
				return true;
			}else{

				if(this.actionLog.equals("Y")) {
					commonService.sysActionLog(request);
				}
				
				//20191027_khj 세션의 사용자IP와 클라이언트 요청IP의 유효성 확인 시작
				if(!session_ip.equals("")) {
					if(!client_ip.equals(session_ip)) {
						logger.debug("Client IP and Server IP are different!! : {}", client_ip+":"+session_ip);
						response.sendRedirect("/core/error/403.do");
						
						if(this.actionLog.equals("Y")) {
							commonService.finish("Y");
						}
						return false;
					}
				}
				//20191027_khj 세션의 사용자IP와 클라이언트 요청IP의 유효성 확인 끝
				
			}
			
			
			//20191027_khj 관리자전용 페이지 접근 가능 IP확인 시작
//			if(request.getRequestURI().contains("/staff/") || request.getRequestURI().contains("/admin/")) {
//				boolean admin_chk = false;
//				adminIP = adminIP.trim(); //IP 공백제거
//				//관리자전용 페이지 접근 가능 IP 설정되어 있으면 체크
//				if(!adminIP.equals("")) {
//					String[] ip_list = adminIP.split(",");
//					for(int i = 0; i < ip_list.length; i++) {
//						 if(ip_list[i].matches(client_ip)){
//							//System.out.println("여기오면 관리자페이지 접근가능");
//							admin_chk = true;
//						 }
//					}
//					if(!admin_chk) {
//						response.sendRedirect("/core/error/403.do");
//						if(this.actionLog.equals("Y")) {
//							commonService.finish("Y");
//						}
//						return false;
//					}
//				}
//				
//			}
			//20191027_khj 관리자전용 페이지 접근 가능 IP확인 끝
			
			
			//20191022_khj 로긴실패로 잠긴 계정 체크 시작
			if("/core/login/ChkId.do".equals(request.getRequestURI())){
				
				int cnt =  validationService.LoginLockYNCheck(request, response);
				
				if(cnt > 0) { //잠긴계정
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					JSONObject jobj = new JSONObject();
					jobj.put("FROM_SERV_CD", -6);
					jobj.put("FROM_SERV_MSG", "계정이 잠김 상태입니다. 관리자에게 문의주세요.");
					response.getWriter().write(jobj.toJSONString());
					if(this.actionLog.equals("Y")) {
						commonService.finish("Y");
					}
					return false;
				}else {
					return true;
				}
				
			}else if("/yp/login/loginCheck".equals(request.getRequestURI())) { // 2020-07-14 jamerl - 영풍 웹포탈 로그인
				int cnt = validationService.LoginLockYNCheck(request, response);
				if(cnt > 0) { //잠긴계정
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					JSONObject jobj = new JSONObject();
					jobj.put("FROM_SERV_CD", -6);
					jobj.put("FROM_SERV_MSG", "계정이 잠김 상태입니다. 관리자에게 문의주세요.");
					response.getWriter().write(jobj.toJSONString());
					if(this.actionLog.equals("Y")) {
						commonService.finish("Y");
					}
					return false;
				}else {
					return true;
				}
			}
			////20191022_khj 로긴실패로 잠긴 계정 체크 끝

			if(request.getSession().getAttribute("s_emp_code") == null && !"/core/login/logout.do".equals(request.getRequestURI())){
				//System.out.println("여기오면 아이디없고 로그아웃url 아닌경우");
				loginService.insertSysLog_Logout(request, response);
				request.getSession().removeAttribute("empCode");
				request.getSession().invalidate();

				//세션이 끊긴 상태에서 ajax 요청시
				if(requestAjaxCheck != null) {
					//logger.debug("여기오면 세션이 끊긴 상태에서 ajax 요청시다, 403 에러 강제 유발");
					response.setStatus(403);
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					JSONObject jobj = new JSONObject();
					jobj.put("biz_validation_message", "SESSIONNO");
					response.getWriter().write(jobj.toJSONString());
					
				}else{ //세션이 끊긴 상태에서 비ajax 요청시
					
					//logger.debug("여기오면 세션이 끊긴 상태에서 비ajax 요청시다,");
					//response.setContentType("text/html; charset=UTF-8");
					//PrintWriter writer = response.getWriter();
					//writer.println("<script>alert('"+sessionoutMSG+"'); location.replace('/core/login/login');</script>");
					//response.sendRedirect("/core/login/login");
					
					response.sendRedirect("/core/login/sessionOut.do");
				
					return false;
				}

				return false;
				
			}else if("/core/login/logout.do".equals(request.getRequestURI()) ){
				//System.out.println("여기오면 로그아웃인경우");
				//로그아웃
				return false;
				
			}else if("/yp/login/logout".equals(request.getRequestURI()) ){
				//System.out.println("여기오면 로그아웃인경우");
				//로그아웃
				return false;
				
			}else{
				logger.debug("세션 기획득 상태 -> SessionID: {}", request.getSession().getId());
				//20191015_khj 중복로그인 방지 추가
				if(user_id != null) {
					String exist_sessionId = sessionList.getHashMap().get(user_id);
					if(exist_sessionId != null) {
						if(!exist_sessionId.equals(request.getSession().getId())) {
							loginService.insertSysLog_Logout(request, response);
							//request.getSession().removeAttribute("s_emp_code");
							request.getSession().invalidate();
							response.sendRedirect("/core/login/dup_login.do");
							return false;
						}
					}
				}
				
				SimpleDateFormat format2 = new SimpleDateFormat ("yyyy년 MM월 dd일");
				String format_time2 = format2.format (System.currentTimeMillis());
				request.setAttribute("current_date", format_time2);
				logger.debug("세션 기획득 상태 -> URI: {}", request.getRequestURI());
				//////////////////validation 공통 처리 시작
				boolean validationResult = validationCheck(request, response);
				return validationResult;
				/////////////////validation 공통 처리 끝
			}

		}catch(Exception e){
			e.printStackTrace();
			logger.error("{}", e);
		}

		return true;
	}
	
	private boolean validationCheck(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("UTF-8");
		boolean returnTF = false;
		String validationText = "";
		String json = "";
		Integer result = 0;
		switch(request.getRequestURI()){
			
			//별도 밸리데이션 항목 case문 삽입영역
			
			default : returnTF = true;
			break;
		}
		
		if(!returnTF){
			//System.out.println("액션 실행 불가");
			//System.out.println("여기오면 validation 실패, 403 에러 강제 유발");
			response.setStatus(402); //20191128_khj 403에러를 강제유발 시키면 세션이 끊기기때문에, 강제로 402에러로 대체
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			JSONObject jobj = new JSONObject();
			jobj.put("biz_validation_message", validationText);
			response.getWriter().write(jobj.toJSONString());
		}
		return returnTF;
	}
	
	private List excelUploadValidationCheck(HttpServletRequest request) throws Exception{
	
		String insertQuery = request.getParameter("insertQuery");
		List resultList = new ArrayList();
		Integer result = 0;
		switch(insertQuery){
		case "biz_dept.user_insert" : 
			//result = validationService.userAllocCheck();
			if(result !=null && result != 0){
				resultList.add(false);
				resultList.add("평가에 할당된 사원이 있습니다. 업로드를 진행 할 수 없습니다.");
			}else{
				resultList.add(true);
				resultList.add("");
			}
		break;
		
		default : resultList.add(true);
		   		  resultList.add("");
		break;
		}
		return resultList;
	}
	
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		
		if(modelAndView != null) {
		
			if(		
					"/core/error/400.do".contains(modelAndView.getViewName()) ||
					"/core/error/401.do".contains(modelAndView.getViewName()) ||
					"/core/error/403.do".contains(modelAndView.getViewName()) ||
					"/core/error/404.do".contains(modelAndView.getViewName()) ||
					"/core/error/405.do".contains(modelAndView.getViewName()) ||
					"/core/error/500.do".contains(modelAndView.getViewName()) 
			){
				if(this.actionLog.equals("Y")) {
					commonService.finish("Y");
				}
				
			}else {
				
				if(this.actionLog.equals("Y")) {
					//session check
					if(request.getSession().getAttribute("s_emp_code") != null) {
						commonService.finish("N");
					}
				}
				
			}

		}
	}
}
