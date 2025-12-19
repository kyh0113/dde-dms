package com.yp.zhr.tna.srvc;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoStructure;
import com.sap.conn.jco.JCoTable;
import com.vicurus.it.core.common.Util;
import com.yp.sap.SapJcoConnection;
import com.yp.util.DateUtil;
import com.yp.zhr.tna.srvc.intf.YP_ZHR_TNA_Service;

@Repository
public class YP_ZHR_TNA_ServiceImpl implements YP_ZHR_TNA_Service {

	// config.properties 에서 설정 정보 가져오기 시작
	@SuppressWarnings("unused")
	private static String NAMESPACE;

	@SuppressWarnings("static-access")
	@Value("#{config['db.vendor']}")
	public void setNAMESPACE(String value) {
		this.NAMESPACE = value + ".";
	}
	// config.properties 에서 설정 정보 가져오기 끝

	@Autowired
	@Resource(name = "sqlSession")
	private SqlSession query;

	private static final Logger logger = LoggerFactory.getLogger(YP_ZHR_TNA_ServiceImpl.class);

	private String sortColumn = "DATE";
	
	/**
	 * 문자열 오름차순
	 *
	 */
	public class StringAscCompare implements Comparator<HashMap<String, String>> {
		/**
		 * 오름차순(ASC)
		 */
		@Override
		public int compare(HashMap<String, String> arg0, HashMap<String, String> arg1) {
			// TODO Auto-generated method stub
			return arg0.get(sortColumn).compareTo(arg1.get(sortColumn));
		}
	}

	/**
	 * 문자열 내림차순
	 *
	 */
	public class StringDescCompare implements Comparator<HashMap<String, String>> {
		/**
		 * 내림차순(DESC)
		 */
		@Override
		public int compare(HashMap<String, String> arg0, HashMap<String, String> arg1) {
			// TODO Auto-generated method stub
			String sortColumn = "";
			return arg1.get(sortColumn).compareTo(arg0.get(sortColumn));
		}
	}
	
	@SuppressWarnings("rawtypes")
	public HashMap<String, Object> exec(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		logger.debug("RFC_FUNC - 【{}】", paramMap.get("RFC_FUNC"));

		HashMap<String, Object> result = new HashMap<String, Object>();
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();

		if ("ZHR_PER_DAILY_REPORT".equals(paramMap.get("RFC_FUNC"))) {
			list = this.zhr_per_daily_report(request, response);
			result.put("list", list);
		} else if ("ZHR_PER_OVERTIME_REPORT".equals(paramMap.get("RFC_FUNC"))) {
			list = this.zhr_per_overtime_report(request, response);
			result.put("list", list);
		} else {
			logger.error("일치하는 RFC_FUNC가 없습니다.");
		}

		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	public ArrayList<HashMap<String, String>> zhr_per_daily_report(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map req_data = util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();
		req_data.put("emp_code", (String) session.getAttribute("empCode"));
		req_data.put("emp_name", ((String) session.getAttribute("userName")));
		req_data.put("user_dept", ((String) session.getAttribute("userDept")));
		req_data.put("ofc_name", ((String) session.getAttribute("userOfc")));
		req_data.put("auth", (String) session.getAttribute("HR_AUTH"));
		if(req_data.get("auth") == null) req_data.put("auth","US");
//		req_data.put("auth", (String) session.getAttribute("auth"));
//		if (req_data.get("auth") == null) {
//			if ("팀장".equals(req_data.get("ofc_name")))
//				req_data.put("auth", "TM");
//			// else if("조장".equals(req_data.get("ofc_name"))) req_data.put("auth","SM");
//			else
//				req_data.put("auth", "US");
//		}

		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZHR_PER_DAILY_REPORT");

		// RFC 파라미터 - 순서가 중요한지 확인 필요
		function.getImportParameterList().setValue("I_PERNR", req_data.get("emp_code")); // 검색사번
		function.getImportParameterList().setValue("I_BEGDA", StringUtils.replace((String) req_data.get("sdate"), "/", "")); // 시작일
		function.getImportParameterList().setValue("I_ENDDA", StringUtils.replace((String) req_data.get("edate"), "/", "")); // 종료일
		function.getImportParameterList().setValue("I_ORGEH", req_data.get("ser_teamname")); // 조직코드
		function.getImportParameterList().setValue("I_CLASS", req_data.get("ser_group")); // 반
		function.getImportParameterList().setValue("I_SCHKZ", req_data.get("ser_shift")); // 근무 조
		function.getImportParameterList().setValue("I_ENAME", req_data.get("ser_name")); // 검색 사원명
		function.getImportParameterList().setValue("I_AUTH", req_data.get("auth")); // 권한
		if ("SA".equals(req_data.get("auth")) || "MA".equals(req_data.get("auth")))
			function.getImportParameterList().setValue("I_OTYPE", "P");

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		JCoTable table = function.getTableParameterList().getTable("T_REPORT");

		// RFC 결과 ArrayList 치환
		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);

//		Collections.sort(list, new StringAscCompare());

		return list;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	public List select_zhr_per_daily_report(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		List dataList = query.selectList(NAMESPACE + "yp_zhr_tna.select_zhr_per_daily_report", paramMap);

		return dataList;
	}

	@SuppressWarnings({"rawtypes"})
	@Override
	public List retrieveEmpWorkInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		List dataList = query.selectList(NAMESPACE + "yp_zhr_tna.retrieveEmpWorkInfo", paramMap);

		return dataList;
	}

	@SuppressWarnings("rawtypes")
	@Override
	/**
	 * RFC 조회
	 */
	public ArrayList<HashMap<String, String>> retrieveTimecardList(HashMap req_data) throws Exception {

		SapJcoConnection jcoConnect = new SapJcoConnection();
		logger.debug("retrieveTimecardList.data=" + req_data);
		JCoFunction function = jcoConnect.getFunction("ZHR_PER_DAILY_REPORT");
		function.getImportParameterList().setValue("I_PERNR", req_data.get("emp_code")); // 검색사번
		function.getImportParameterList().setValue("I_BEGDA", StringUtils.replace((String) req_data.get("sdate"), "/", "")); // 시작일
		function.getImportParameterList().setValue("I_ENDDA", StringUtils.replace((String) req_data.get("edate"), "/", "")); // 종료일
		function.getImportParameterList().setValue("I_ORGEH", req_data.get("ser_teamname")); // 조직코드
		function.getImportParameterList().setValue("I_CLASS", req_data.get("ser_group")); // 반
		function.getImportParameterList().setValue("I_SCHKZ", req_data.get("ser_shift")); // 근무 조
		function.getImportParameterList().setValue("I_ENAME", req_data.get("ser_name")); // 검색 사원명
		function.getImportParameterList().setValue("I_AUTH", req_data.get("auth")); // 권한
		if ("SA".equals(req_data.get("auth")) || "MA".equals(req_data.get("auth")))
			function.getImportParameterList().setValue("I_OTYPE", "P");
		logger.debug("rfc start~~");
		jcoConnect.execute(function);
		logger.debug("rfc end~~");

		JCoTable table = function.getTableParameterList().getTable("T_REPORT");

		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);

		sortColumn = "DATE";
		logger.debug(sortColumn);
		Collections.sort(list, new StringAscCompare());
		// Object obj = list.get(1).get("DATE");
		// logger.debug("///" + obj+" : "+table.getDate("DATE")+" : "+ table.getRecordMetaData().getFieldCount());
		return list;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public HashMap<String, ArrayList<HashMap<String, String>>> retrieveVacationEmpList(HashMap req_data) throws Exception {
		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("Z_HR_005");
		function.getImportParameterList().setValue("P_ORGEH", req_data.get("userDeptCd")); // 부서코드
		function.getImportParameterList().setValue("P_DATUM", StringUtils.replace((String) req_data.get("work_startdate"), "/", "")); // 기준일
		logger.debug("rfc start~~");
		jcoConnect.execute(function);
		logger.debug("rfc end~~");

		JCoTable table = function.getTableParameterList().getTable("T_ZHRT0330");
		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);

		ArrayList<HashMap<String, String>> data = new ArrayList<HashMap<String, String>>();
		HashMap<String, String> data_map = new HashMap<String, String>();
		String msg = function.getExportParameterList().getString("V_RESULT");
		data_map.put("msg", msg);
		data.add(data_map);

		HashMap<String, ArrayList<HashMap<String, String>>> result = new HashMap<String, ArrayList<HashMap<String, String>>>();
		result.put("data", data);
		result.put("list", list);

		return result;
	}

	@Override
	public HashMap<String, String> retrieveUpperDepartment(String dept_cd) throws Exception {
		HashMap<String, String> result = query.selectOne(NAMESPACE + "yp_zhr_tna.retrieveUpperDepartment", dept_cd);
		return result;
	}

	@SuppressWarnings({"unchecked", "rawtypes"})
	@Override
	@Transactional
	public HashMap<String, String> createOvertime(HashMap req_data) throws Exception {
		logger.debug("createOvertimePlan.service.req_data=" + req_data);
		HashMap<String, String> result = new HashMap<String, String>();
		result.put("code", "");
		String[] row_no = (String[]) req_data.get("no");
		int cnt = 0;

		// 정규근무시간, 출퇴근시간 컬럼 추가 해양함
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("row_no").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			HashMap data = new HashMap();
			logger.debug("*** data = {}", data);
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("{}", jsonObj);
			String frdt = jsonObj.get("WORK_STARTDATE") + " " + jsonObj.get("TRUE_WORK_STARTTIME");
			String todt = jsonObj.get("WORK_ENDDATE") + " " + jsonObj.get("TRUE_WORK_ENDTIME");
			data.put("frdt", frdt);
			data.put("todt", todt);
			data.put("reg_worker", req_data.get("reg_worker"));
			data.put("reg_worker_name", req_data.get("reg_worker_name"));
			data.put("work_startdate", jsonObj.get("WORK_STARTDATE"));
			data.put("work_enddate", jsonObj.get("WORK_ENDDATE"));
			data.put("true_work_starttime", jsonObj.get("TRUE_WORK_STARTTIME"));
			data.put("true_work_endtime", jsonObj.get("TRUE_WORK_ENDTIME"));
			data.put("emp_code", jsonObj.get("EMP_CODE"));
			data.put("emp_name", jsonObj.get("EMP_NAME"));
			
			HashMap<String,String> upperDeptName = this.retrieveUpperDepartment((String)jsonObj.get("TEAM_CODE"));
			logger.debug(upperDeptName.get("DEPT_CD"));

			if("50000001".equals(upperDeptName.get("DEPT_CD"))) data.put("work_place", "1100");		//본사
			else if("50000002".equals(upperDeptName.get("DEPT_CD"))) data.put("work_place","1200");	//석포제련소
			else if("50000003".equals(upperDeptName.get("DEPT_CD"))) data.put("work_place","1300");	//안성휴게소
			else if("60007226".equals(upperDeptName.get("DEPT_CD"))) data.put("work_place","1600");	//그린메탈캠퍼스
			
			
//			data.put("team_code", req_data.get("team_code"));
//			data.put("team_name", req_data.get("team_name"));
			// 2020-09-09 jamerl - 조용래, 전정대 : 세션의 부서코드, 명 대신 파라미터의 부서코드, 명을 사용하도록 변경
			data.put("team_code", jsonObj.get("TEAM_CODE"));
			data.put("team_name", jsonObj.get("TEAM_NAME"));
			data.put("origin_work_code", jsonObj.get("ORIGIN_WORK_CODE"));
			data.put("origin_work", jsonObj.get("ORIGIN_WORK"));
			data.put("over_work_code", jsonObj.get("OVER_WORK_CODE"));
			data.put("over_work", jsonObj.get("OVER_WORK"));
			data.put("work_type1_code", jsonObj.get("WORK_TYPE1_CODE"));
			data.put("work_type1", jsonObj.get("WORK_TYPE1"));
			data.put("origin_worker_code", jsonObj.get("ORIGIN_WORKER_CODE"));
			data.put("origin_worker_name", jsonObj.get("ORIGIN_WORKER_NAME"));
			data.put("work_type2_code", jsonObj.get("WORK_TYPE2_CODE"));
			data.put("work_type2", jsonObj.get("WORK_TYPE2"));
			data.put("work_dsc", jsonObj.get("WORK_DSC"));
			logger.debug("{}", jsonObj);
			data.put("true_overtime", String.format("%.2f", Float.parseFloat((String) jsonObj.get("OVERTIME"))));
			// % : 명령 시작을 의미, 0 : 채워질 문자, 2 : 총 자리수, D : 십진수로 된 정수 (f:소수점 숫자)

			data.put("work_shift", jsonObj.get("WORK_SHIFT"));
			data.put("work_shift_code", jsonObj.get("WORK_SHIFT_CODE"));
			data.put("work_group", jsonObj.get("WORK_GROUP"));
			data.put("work_group_code", jsonObj.get("WORK_GROUP_CODE"));

			data.put("time_card1", jsonObj.get("TIME_CARD1"));
			data.put("time_card2", jsonObj.get("TIME_CARD2"));
			data.put("regular_work1", jsonObj.get("REGULAR_WORK1"));
			data.put("regular_work2", jsonObj.get("REGULAR_WORK2"));
			data.put("rest_stime", jsonObj.get("REST_STIME"));
			data.put("rest_etime", jsonObj.get("REST_ETIME"));

			int znumc = query.selectOne(NAMESPACE + "yp_zhr_tna.retrieveOvertimeZnumc", data);
			logger.debug("znumc = {}", znumc);
			data.put("znumc", znumc + 1);

			int dupli_time_chk = query.selectOne(NAMESPACE + "yp_zhr_tna.retrieveOvertimeDupliCheck", data);// 근무신청시간 중복확인
			if (dupli_time_chk >= 1) {
				result.put("code", "02");
				result.put("proc_row", Integer.toString(i));
			} else {
				float week_worktime = retrieveOvertimeByWeek(data);//주휴다음일~주휴일 시간외근무 12시간 확인
//				float week_worktime = retrieveOvertimeByWeekBySunToSatur(data);// 일요일~토요일 12시간확인
				logger.debug("before week_worktime = {}", week_worktime);
				
				week_worktime += Float.valueOf((String) data.get("true_overtime"));
				logger.debug("after week_worktime = {}", week_worktime);
				
				if (week_worktime > 12.0) {
					if("B".equals(data.get("work_type1_code"))){//연장근무만 주별 근무시간 체크 (임시)
						
						if (!"SA".equals(req_data.get("auth")) && !"MA_HR".equals(req_data.get("auth"))){
							result.put("code", "03");
							result.put("proc_row", Integer.toString(i));
						}
						
					}//연장근무만 주별 근무시간 체크 (임시)
				}
			}

			if (result.get("code").equals("") || result.get("code").equals("00")) {
				int row = query.insert(NAMESPACE + "yp_zhr_tna.createOvertime", data);
				if (row > 0) {
					result.put("code", "00");
					cnt += row;
//					cnt += 1;
				} else {
					result.put("code", "02");
				}
				result.put("proc_row", Integer.toString(i));
			}
		}
		result.put("cnt", Integer.toString(cnt));
		return result;
	}

	@SuppressWarnings({"unchecked", "rawtypes"})
	public float retrieveOvertimeByWeek(HashMap req_data) throws Exception{
		
		SapJcoConnection jcoConnect = new SapJcoConnection();
	    JCoFunction function = jcoConnect.getFunction("ZHR_GET_WEEK_HOLIDAYS");
	    function.getImportParameterList().setValue("I_PERNR",req_data.get("emp_code"));	//사번
	    function.getImportParameterList().setValue("I_DATE",StringUtils.replace((String)req_data.get("work_startdate"), "/", ""));	//기준일
	    logger.debug("rfc start~~");
	    jcoConnect.execute(function);
	    logger.debug("rfc end~~");
	    
	    JCoTable table = function.getTableParameterList().getTable("T_HOLIDAY");
	   
	    logger.debug("table = " + table);
	    ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
	    
	    SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		Date date = formatter.parse(list.get(0).get("DATE"));
		logger.debug("RFC반환 주휴일:"+date);
		
	    Calendar cal = Calendar.getInstance();
		cal.setTime(date);
	    
		cal.add(Calendar.DATE,+1);
		String sdate = new SimpleDateFormat("yyyy/MM/dd").format(cal.getTime());
		cal.add(Calendar.DATE,+6);
		String edate = new SimpleDateFormat("yyyy/MM/dd").format(cal.getTime());
		logger.debug("조회 주휴다음일~주휴일:"+sdate+"~"+edate);
	    req_data.put("sdate", sdate);
	    req_data.put("edate", edate);
	    return query.selectOne(NAMESPACE + "yp_zhr_tna.retrieveOvertimeByWeek", req_data);
	}
	
	@SuppressWarnings({"unchecked", "rawtypes"})
	public float retrieveOvertimeByWeekBySunToSatur(HashMap req_data) throws Exception {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		Date date = formatter.parse(StringUtils.replace((String) req_data.get("work_startdate"), "/", ""));

		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		int daynum = cal.get(Calendar.DAY_OF_WEEK); // 요일숫자 (1:일요일~7:토요일)
		cal.add(Calendar.DATE, -daynum + 1);
		String sdate = new SimpleDateFormat("yyyy/MM/dd").format(cal.getTime());
		cal.add(Calendar.DATE, +6);
		String edate = new SimpleDateFormat("yyyy/MM/dd").format(cal.getTime());
		req_data.put("sdate", sdate);
		req_data.put("edate", edate);
		return query.selectOne(NAMESPACE + "yp_zhr_tna.retrieveOvertimeByWeek", req_data);
	}
	
	@SuppressWarnings({"unchecked", "rawtypes"})
	@Transactional
	public int updateOverPlanStauts(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int result = 0;

		Util util = new Util();
		HashMap req_data = (HashMap)util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		String empCode = (String) session.getAttribute("empCode");
		String userName = (String) session.getAttribute("userName");
		String auth = (String) session.getAttribute("HR_AUTH");
		String ofc = (String) session.getAttribute("userOfc");//직책

		HashMap data = new HashMap();
		data.put("upd_flag", req_data.get("upd_flag"));
		data.put("emp_code", empCode);
		data.put("emp_name", userName);
		
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("seq").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			data.put("seq", jsonObj.get("SEQ"));
			result += query.update(NAMESPACE + "yp_zhr_tna.updateOverPlanStauts", data);
		}
		
		return result;
	}
	
	@SuppressWarnings({"unchecked", "rawtypes"})
	public List retrieveOvertimePlanListBySeq(HashMap req_data) throws Exception {
		List result = new ArrayList();
		result = query.selectList(NAMESPACE + "yp_zhr_tna.retrieveOvertimePlanListBySeq", req_data);
		return result;
	}
	
	@Override
	public HashMap<String, Object> createOverPlanToSAP(HttpServletRequest request, ArrayList<HashMap<String, String>> list) throws Exception{
		HttpSession session = request.getSession();
		
		SapJcoConnection jcoConnect = new SapJcoConnection();
	    JCoFunction function = jcoConnect.getFunction("ZHR_GET_EX_DATA");
	    JCoTable T_DATA = function.getTableParameterList().getTable("T_DATA");
	    String regdate,regtime = "";
	    String apprdate,apprtime = "";
	    
	    logger.debug("createOverPlanToSAP.list="+list);
	    for(int i=0;i<list.size();i++){
	    	regdate = new SimpleDateFormat("yyyyMMdd").format(list.get(i).get("REG_DATE"));
	    	regtime = new SimpleDateFormat("HHmmss").format(list.get(i).get("REG_DATE"));
	    	//apprdate = new SimpleDateFormat("yyyyMMdd").format(list.get(i).get("APPROVAL_DATE"));
	    	//apprtime = new SimpleDateFormat("HHmmss").format(list.get(i).get("APPROVAL_DATE"));
	    	
	    	T_DATA.appendRow();
	    	T_DATA.setValue("SEQ",String.valueOf(list.get(i).get("SEQ")));											//LIST.SEQ(NUMBER-38)
	    	T_DATA.setValue("CHK","1");																				//체크박스(1)
	    	T_DATA.setValue("PERNR",list.get(i).get("EMP_CODE"));													//근무자 사번(8)
	    	T_DATA.setValue("ENAME",list.get(i).get("EMP_NAME"));													//근무자 이름(40)
	    	T_DATA.setValue("ZREDT",StringUtils.replace(list.get(i).get("WORK_STARTDATE"),"/",""));					//근무일(8)
		    T_DATA.setValue("ZNUMC", String.valueOf(list.get(i).get("ZNUMC")));										//순번(3)
		    T_DATA.setValue("BTRTL",list.get(i).get("WORK_PLACE"));													//인사 하위영역(4)
		    T_DATA.setValue("ORGEH",list.get(i).get("TEAM_CODE"));													//부서코드(8)
		    T_DATA.setValue("ORGEH_T",list.get(i).get("TEAM_NAME"));												//부서명(40)
		    T_DATA.setValue("ZCLSS",list.get(i).get("WORK_GROUP_CODE"));											//반(8)
		    T_DATA.setValue("SCHKZ",list.get(i).get("WORK_SHIFT_CODE"));											//근무조(4)
		    T_DATA.setValue("ZWORK_O",list.get(i).get("ORIGIN_WORK_CODE"));											//원근무조(4)
		    T_DATA.setValue("ZOPER",list.get(i).get("WORK_TYPE1_CODE") + " " + list.get(i).get("WORK_TYPE1"));		//작업구분(4)
		    T_DATA.setValue("ZOPERNM",list.get(i).get("WORK_TYPE2_CODE"));											//작업세부구분(4)
		    T_DATA.setValue("ZOPERRN",list.get(i).get("WORK_DSC"));													//작업사유(20)
		    T_DATA.setValue("ZGTIM_O",list.get(i).get("REGULAR_WORK1"));											//정상출근시간(6)
		    T_DATA.setValue("ZLTIM_O",list.get(i).get("REGULAR_WORK2"));											//정상퇴근시간(6)
		    T_DATA.setValue("ZGTIM_R",list.get(i).get("TIME_CARD1"));												//실출근시간(6)
		    T_DATA.setValue("ZLTIM_R",list.get(i).get("TIME_CARD2"));												//실퇴근시간(6)
		    T_DATA.setValue("ZJOB1",list.get(i).get("OVER_WORK_CODE"));												//근무직(4)

		    /*   계획과 실적 컬럼 분리 18.07.19       
		    String true_start = list.get(i).get("TRUE_WORK_STARTTIME") != null ? list.get(i).get("TRUE_WORK_STARTTIME") : "";
		    String true_end = list.get(i).get("TRUE_WORK_ENDTIME") != null ? list.get(i).get("TRUE_WORK_ENDTIME") : "";
		    */
		    T_DATA.setValue("ZGTIM_EX",StringUtils.replace(list.get(i).get("TRUE_WORK_STARTTIME")+"00",":",""));		//연장시작(6)
		    T_DATA.setValue("ZLTIM_EX",StringUtils.replace(list.get(i).get("TRUE_WORK_ENDTIME")+"00",":",""));			//연장종료(6)
		    
		    String rests = list.get(i).get("REST_STIME") == null ? "0000" :  list.get(i).get("REST_STIME");
		    String reste = list.get(i).get("REST_ETIME") == null ? "0000" :  list.get(i).get("REST_ETIME");
		    T_DATA.setValue("ZGTIM_RE",StringUtils.replace(rests+"00",":",""));				//근무직에따른 휴식시간(6)
		    T_DATA.setValue("ZLTIM_RE",StringUtils.replace(reste+"00",":",""));				//근무직에따른 휴식종료(6)
		    
		    T_DATA.setValue("ZSTE1","1");																			//상태(1)  2.확정  1.승인  0.신청
		    T_DATA.setValue("ZRESN",list.get(i).get("MODIFY_DSC"));													//사유(40)
		    T_DATA.setValue("ZREQDT",regdate);																		//요청일(8)
		    T_DATA.setValue("ZREQTM",regtime);																		//요청시간(6)
		    T_DATA.setValue("ZREQNM",list.get(i).get("EMP_CODE"));													//요청자(8)
		    T_DATA.setValue("ZCONDT",StringUtils.replace(DateUtil.getToday(),"/",""));	//필요한가?	apprdate		//확인일(8)
		    T_DATA.setValue("ZCONTM",StringUtils.replace(DateUtil.getTodayTime(),":",""));	//필요한가?	apprtime													//확인시간(6)
		    T_DATA.setValue("ZCONNM",session.getAttribute("empCode"));												//확인자(8)
//		    T_DATA.setValue("ZDESDT",StringUtils.replace(DateUtil.getToday(),"/",""));								//확정일(8)
//		    T_DATA.setValue("ZDESNM",list.get(i).get("EMP_CODE"));													//확정자(8)
		    //확정일,확정자 데이터 안보냄 2020.06.05 조용래 요청
		    T_DATA.setValue("WON_PERNR",list.get(i).get("ORIGIN_WORKER_NAME"));										//원근무자 이름(50)
		    T_DATA.setValue("PERNR1",list.get(i).get("ORIGIN_WORKER"));												//원근무자 사번(8)
		    
		    /* 20년 3월 프로세스 변경으로 인한 주석처리
		    //계획시간, 실초과시간 비교 작은값을 입력
		    if(list.get(i).get("TRUE_OVERTIME") == null) list.get(i).put("TRUE_OVERTIME", "0");
		    float t_ot = Float.valueOf(list.get(i).get("TRUE_OVERTIME"));
		    float p_ot = Float.valueOf(list.get(i).get("WORK_OVERTIME"));
		    //초과근무시간 소수에서 문자열로 변환
		    float init = t_ot > p_ot ? p_ot : t_ot;
		    
		    int no_int = (int)init;
		    float f = (init - no_int)*60;//소수점자리만
		    String overtime = "";
		    
		    if(String.valueOf(no_int).length() < 2) overtime = "0"+String.valueOf(no_int);
		    else overtime = String.valueOf(no_int);
		    
		    if(String.valueOf((int)f).length() < 2) overtime += "0"+String.valueOf((int)f);
		    else overtime += String.valueOf((int)f);
		    
		    logger.debug("%%"+overtime);
		    logger.debug("%%"+regdate);
		    T_DATA.setValue("ZTIME",overtime+"00");					//총신청시간(연장종료-연장시작)(6)
		    */
		    
		    /*20년 3월 수정내용 */
		    T_DATA.setValue("ZTIME",list.get(i).get("TRUE_OVERTIME")+"00");
		}
	    logger.debug("rfc start~~");
	    jcoConnect.execute(function);
	    logger.debug("rfc end~~");
	    JCoStructure e_return = function.getExportParameterList().getStructure("E_RETURN");
	    JCoTable table = function.getTableParameterList().getTable("T_DATA");
	 	ArrayList<HashMap<String, String>> result_table = jcoConnect.createSapList(table);
	    String NO = "";
	    try{ NO = e_return.getString("NO") != null ? e_return.getString("NO") : "0";}
	    catch(Exception e){}
	    logger.debug("%%"+NO);
	    HashMap<String, String> ex_param = new HashMap<String, String>();
	    ex_param.put("TYPE", e_return.getString("TYPE"));
	    ex_param.put("MESSAGE", e_return.getString("MESSAGE"));
	    ex_param.put("NO", NO);
	    
	    HashMap<String, Object> resultmap = new HashMap<String, Object>();
	    resultmap.put("ex_param", ex_param);
	    resultmap.put("list", result_table);
	    
	    return resultmap;    
	}
	
	@SuppressWarnings({"unchecked", "rawtypes"})
	@Transactional
	public int updateOverPlanConfirm(HttpServletRequest request, ArrayList list) throws Exception {
		int result = 0;
		
		HttpSession session = request.getSession();
		String empCode = (String) session.getAttribute("empCode");
		String userName = (String) session.getAttribute("userName");
		String auth = (String) session.getAttribute("HR_AUTH");
		String ofc = (String) session.getAttribute("userOfc");//직책

		HashMap data = new HashMap();
		data.put("emp_code", empCode);
		data.put("emp_name", userName);
		
		for (int i = 0; i < list.size(); i++) {
			data.put("seq", list.get(i));
			result += query.update(NAMESPACE + "yp_zhr_tna.updateOverPlanConfirm", data);
		}
		
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Override
	public ArrayList<HashMap<String, String>> zhr_per_overtime_report(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map req_data = util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();
		req_data.put("emp_code", (String) session.getAttribute("empCode"));
		req_data.put("ser_teamcode", (String) session.getAttribute("userDeptCd"));
		req_data.put("auth", (String) session.getAttribute("auth"));
//		if(req_data.get("auth") == null){
//			if("팀장".equals(req_data.get("ofc_name")))	req_data.put("auth","TM");
//			else if("조장".equals(req_data.get("ofc_name")))	req_data.put("auth","SM");
//			else 	req_data.put("auth","US");
//		}

		SapJcoConnection jcoConnect = new SapJcoConnection();

		// RFC 명
		JCoFunction function = jcoConnect.getFunction("ZHR_PER_OVERTIME_REPORT");

		// RFC 파라미터 - 순서가 중요한지 확인 필요
	    function.getImportParameterList().setValue("I_PERNR",req_data.get("emp_code"));	//사번
	    function.getImportParameterList().setValue("I_BEGDA",StringUtils.replace((String)req_data.get("sdate"), "/", ""));	//시작일
		function.getImportParameterList().setValue("I_ENDDA",StringUtils.replace((String)req_data.get("edate"), "/", ""));	//종료일
		function.getImportParameterList().setValue("I_ORGEH",req_data.get("ser_teamcode"));	//조직코드
	    function.getImportParameterList().setValue("I_CLASS",req_data.get("ser_group"));	//반
	    function.getImportParameterList().setValue("I_SCHKZ",req_data.get("ser_shift"));	//근무 조
	    function.getImportParameterList().setValue("I_ENAME",req_data.get("ser_name"));	//사원성명
	    function.getImportParameterList().setValue("I_AUTH",req_data.get("auth"));	//권한
	    function.getImportParameterList().setValue("I_OTYPE","P");	//고정값

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		JCoTable table = function.getTableParameterList().getTable("T_REPORT");

		// RFC 결과 ArrayList 치환
		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);

		sortColumn = "ZREDT";
		Collections.sort(list, new StringAscCompare());

		return list;
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public List select_emp_work_dept(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List dataList = query.selectList(NAMESPACE + "yp_zhr_tna.select_emp_work_dept", paramMap);
		
		return dataList;
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public List select_team_list(HashMap<String, Object> param) throws Exception {
		List dataList = null;
		
		//20.09.06 임원 분기처리
		if("IM".equals(param.get("s_authogrp_code"))){
			dataList = this.zhr_get_org_per(param);
		}else{
			dataList = query.selectList(NAMESPACE + "yp_zhr_tna.select_team_list", param);
		}
		
		return dataList;
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public List select_group_list(HashMap<String, Object> param) throws Exception {
		List dataList = query.selectList(NAMESPACE + "yp_zhr_tna.select_group_list", param);
		return dataList;
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public List select_shift_list(HashMap<String, Object> param) throws Exception {
		List dataList = query.selectList(NAMESPACE + "yp_zhr_tna.select_shift_list", param);
		return dataList;
	}
	
	
	public ArrayList<HashMap<String, String>> zhr_get_org_per(HashMap<String, Object> param) throws Exception {

		SapJcoConnection jcoConnect = new SapJcoConnection();
 	    JCoFunction function = jcoConnect.getFunction("ZHR_GET_ORG_PER");
 	    function.getImportParameterList().setValue("I_PERNR",param.get("emp_code"));
 	    function.getImportParameterList().setValue("I_BEGDA",StringUtils.replace(DateUtil.getToday(),"/",""));
	    function.getImportParameterList().setValue("I_ENDDA",StringUtils.replace(DateUtil.getToday(),"/",""));
 	    function.getImportParameterList().setValue("I_AUTH",param.get("s_authogrp_code"));
 	    function.getImportParameterList().setValue("I_OTYPE","O");		//I_OTYPE=O(부서),P(사원)
 	   
 	    jcoConnect.execute(function);
 	    
 	    JCoTable table = function.getTableParameterList().getTable("T_ORGEH");
 	    ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
 	    
 	    return list;
	}
}
