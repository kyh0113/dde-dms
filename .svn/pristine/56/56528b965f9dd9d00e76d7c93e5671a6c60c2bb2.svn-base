package com.yp.batch.srvc;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoTable;
import com.yp.batch.srvc.intf.BatchService;
import com.yp.sap.SapJcoConnection;
import com.yp.util.DateUtil;


@Service("BatchService")
public class BatchServiceImpl<SampleMapper> implements BatchService {

	private static final Logger logger = LoggerFactory.getLogger(BatchService.class);

	// config.properties 에서 설정 정보 가져오기 시작
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
	
	@Autowired
	@Resource(name = "sqlSession3")
	private SqlSession query_cas;

	@Autowired
	@Resource(name = "sqlSession4")
	private SqlSession query_bi;

	@Override
	public void retrieveSalary(String sabun, String yyyymm) throws Exception {
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();

		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("ZHR_INSA_008");
		function.getImportParameterList().setValue("I_SABUN", sabun);
		function.getImportParameterList().setValue("I_TYPE", "1");
		function.getImportParameterList().setValue("I_PAYDT", yyyymm);

		jcoConnect.execute(function);

		JCoTable table = function.getTableParameterList().getTable("T_ZHRS0830");

		jcoConnect.execute(function);

		list = jcoConnect.createSapList(table);
		logger.debug("" + list);
		logger.debug("이름:" + table.getString("HG_NAME") + ", 직급:" + table.getString("JIKGUEB_NAME") + ", 급여달:" + yyyymm);
		logger.debug("기본급:{}", table.getString("GBGUEB"));
		logger.debug("실지급액:{}", table.getString("CI_JG_ACK"));

	}

	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void batchSAP() throws Exception {

//		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
//		SapJcoConnection jcoConnect = new SapJcoConnection();
//		JCoFunction function = jcoConnect.getFunction("ZHR_INSA_001");
//		jcoConnect.execute(function);
//
//		JCoTable table = function.getTableParameterList().getTable("T_ZHRS0730A");
//
//		jcoConnect.execute(function);
//		list = jcoConnect.createSapList(table);
//		logger.debug("table=" + table);

		 try{
		 SapJcoConnection jcoConnect = new SapJcoConnection();
		 JCoFunction function = jcoConnect.getFunction("ZHR_WEB_INSA_002");
		
		 logger.info("===batch RFC(INSA) START===");
		 jcoConnect.execute(function);
		
		 JCoTable table = function.getTableParameterList().getTable("T_ZHRS0772");
		
		 ArrayList<HashMap<String, String>> saplist = jcoConnect.createSapList(table);
		 logger.info("===batch RFC(INSA) END===");
		 logger.debug("batchSAP.size = " + saplist.size());
		 logger.debug("table="+table);
		
		 HashMap<String, String> syncmap = new HashMap<String, String>();
		 List<HashMap<String, String>> wplist = query.selectList(NAMESPACE + "yp_batch.retrieveEmpWorkGroup");
		
		 String process = "";
		
		 int cnt = 0;
		
		 if(saplist.size() > 0){
		 for(HashMap<String, String> sapmap : saplist){
		 for(HashMap<String, String> wpmap : wplist){
		 cnt++;
		 //
		 if(sapmap.get("PERNR").equals(wpmap.get("PERNR"))){ //사번찾기
		 syncmap = sapmap;
		 if(!sapmap.get("ORGEH").equals(wpmap.get("ORGEH"))){
		 process = "update";
		 logger.debug("부서 변경");
		 }else if(!sapmap.get("ORGTX").equals(wpmap.get("ORGTX"))){
		 process = "update";
		 logger.debug("부서 텍스트 변경");
		 }else if(!sapmap.get("ZCLSS").equals(wpmap.get("ZCLSS"))){
		 process = "update";
		 logger.debug("근무반 변경");
		 }else if(!sapmap.get("ZCLST").equals(wpmap.get("ZCLST"))){
		 process = "update";
		 logger.debug("근무반 텍스트 변경");
		 }else if(!sapmap.get("SCHKZ").equals(wpmap.get("SCHKZ"))){
		 process = "update";
		 logger.debug("근무조 변경");
		 }else if(!sapmap.get("JO_NAME").equals(wpmap.get("JO_NAME"))){
		 process = "update";
		 logger.debug("근무조 텍스트 변경");
		 }else if(!sapmap.get("BTRTL").equals(wpmap.get("BTRTL"))){
		 process = "update";
		 logger.debug("사업장 변경");
		 }else{
		 process="nothing";
		 logger.debug("변경사항 없음");
		 }

		 
		 if(process.equals("update")){
		 int updrows = query.update(NAMESPACE + "yp_batch.updateEmpWorkGroup",syncmap);
		 logger.info("update : "+syncmap.get("PERNR"));
		 }
		 wplist.remove(syncmap);
		 break;
		 }
		 }
		
		 if(!process.equals("update") && !process.equals("nothing")){
		 process = "insert";
		 syncmap.put("PERNR", sapmap.get("PERNR")); //사번
		 syncmap.put("ORGEH", sapmap.get("ORGEH")); //부서코드
		 syncmap.put("ORGTX", sapmap.get("ORGTX")); //부서명
		 syncmap.put("ZCLSS", sapmap.get("ZCLSS")); //근무반 코드
		 syncmap.put("ZCLST", sapmap.get("ZCLST")); //근무반 명
		 syncmap.put("SCHKZ", sapmap.get("SCHKZ")); //근무조 코드
		 syncmap.put("JO_NAME", sapmap.get("JO_NAME")); //근무조 명
		 syncmap.put("BTRTL", sapmap.get("BTRTL")); //사업장 코드
		 logger.debug("insert date="+sapmap.get("PERNR")+":"+sapmap.get("ORGEH")+":"+sapmap.get("ORGTX")+":"+sapmap.get("ZCLSS")+":"+sapmap.get("ZCLST")+":"+sapmap.get("SCHKZ")+":"+sapmap.get("JO_NAME")+":"+sapmap.get("BTRTL"));
		 int insrows = query.update(NAMESPACE + "yp_batch.createEmpWorkGroup",syncmap);
		 logger.info("insert : "+syncmap.get("PERNR"));
		 }
		 process = "";
		 syncmap.clear();
		 cnt++;
		 }
		 // logger.debug("cnt="+cnt);
		 }else{
		 logger.info("SAP 인사정보 rows 없음!!");
		 }
		 }catch (Exception e){
		 logger.debug("오류발생 : "+e.getMessage());
		 }
		 logger.info("===batch process end~! ===");

	}

	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void batchSyncTimecard(String yesterday) throws Exception {

		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("ZHR_PER_DAILY_REPORT");

		logger.info("===batch RFC(Timecard) START===");
		logger.info("수행날짜:" + yesterday);
		function.getImportParameterList().setValue("I_BEGDA", yesterday); // 시작일
		function.getImportParameterList().setValue("I_ENDDA", yesterday); // 종료일
		function.getImportParameterList().setValue("I_AUTH", "SA"); // 권한
		function.getImportParameterList().setValue("I_OTYPE", "P");
		jcoConnect.execute(function);

		JCoTable table = function.getTableParameterList().getTable("T_REPORT");

		ArrayList<HashMap<String, String>> list = jcoConnect.createSapList(table);
		logger.info("===batch RFC(Timecard) END===");
		// logger.debug("table="+table);
		int insert_rows = 0;
		int fail_rows = 0;

		for (int i = 0; i < list.size(); i++) {
			try {
				insert_rows += query.update(NAMESPACE + "yp_batch.createTimecard", list.get(i));

			} catch (Exception e) {
				fail_rows++;
				logger.info("실패-" + list.get(i).get("PERNR") + "(" + list.get(i).get("ENAME") + ")");
				e.printStackTrace();
			}
		}
		logger.info("Daily_report - 성공 : " + insert_rows + "/" + list.size() + "건, 실패 : " + fail_rows + "건");
		insert_rows = 0;
		fail_rows = 0;

		String sdate = DateUtil.setDatePattern(yesterday);
		HashMap req_data = new HashMap();
		req_data.put("auth", "SA");
		req_data.put("sdate", sdate);
		req_data.put("edate", sdate);

		logger.info("===batch (updateTimecard) START===");

		List<HashMap<String, String>> plan_list = query.selectList(NAMESPACE + "yp_batch.retrieveOvertimePlanAndRegList", req_data);

		HashMap<String, String> plan_data = new HashMap<String, String>();

		for (int i = 0; i < plan_list.size(); i++) {
			plan_data = plan_list.get(i);
			try {
				HashMap<String, String> update_data = query.selectOne(NAMESPACE + "yp_batch.retrieveDailyReport", plan_data);
				update_data.put("WORK_OVERTIME", plan_data.get("WORK_OVERTIME"));
				HashMap<String, Object> ture_work = this.getOvetime(update_data, plan_data);
				update_data.put("TRUE_OT", String.format("%.2f", ture_work.get("t_ot")));
				update_data.put("TRUE_START", (String) ture_work.get("ot_start"));
				update_data.put("TRUE_END", (String) ture_work.get("ot_end"));
				logger.debug("&&&" + update_data);
				insert_rows += query.update(NAMESPACE + "yp_batch.updateOvertimePlanTimecard", update_data);
			} catch (Exception e) {
				fail_rows++;
				logger.info("실패-" + plan_data.get("EMP_CODE") + "(" + plan_data.get("EMP_NAME") + ")");
				e.printStackTrace();
			}
			logger.info("Overtime_plan - 성공 : " + insert_rows + "/" + plan_list.size() + "건, 실패 : " + fail_rows + "건");
		}
		logger.info("===batch (updateTimecard) END===");
	}

	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void batchSeokpoSoneData(String today) throws Exception {
		logger.info("===batch (batchSeokpoSoneData) {} Start===", today);

		String day = StringUtils.replace(today, "/", "");
		List<HashMap<String, String>> list = query.selectList(NAMESPACE + "yp_batch.retrieveSeokpoSoneData", day);
		logger.debug("데이터 행 수: {}", list.size());

		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("ZHR_GET_COM_DATA");
		JCoTable table = function.getTableParameterList().getTable("T_DATA");

		for (int i = 0; i < list.size(); i++) {
			table.appendRow();
			table.setValue("Z01_KUNMU_DT", (String) list.get(i).get("Z01_KUNMU_DT"));
			table.setValue("Z01_SERIAL_NUM", String.valueOf(list.get(i).get("Z01_SERIAL_NUM")));
			table.setValue("Z01_SABUN", (String) list.get(i).get("Z01_SABUN"));
			table.setValue("Z01_KUNMU_TYPE", (String) list.get(i).get("Z01_KUNMU_TYPE"));
			table.setValue("Z01_KUNMU_TIME", (String) list.get(i).get("Z01_KUNMU_TIME"));
			table.setValue("Z01_YOIL", (String) list.get(i).get("Z01_YOIL"));
			table.setValue("Z01_CARD_ID", (String) list.get(i).get("Z01_CARD_ID"));
			table.setValue("Z01_READER_NUM", (String) list.get(i).get("Z01_READER_NUM"));
			table.setValue("Z01_READER_INDEX", (String) list.get(i).get("Z01_READER_INDEX"));
		}

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		String result = function.getExportParameterList().getString("E_FLAG");
		String msg = function.getExportParameterList().getString("E_MESSAGE");

		logger.info("결과: {}", result);
		logger.info("메시지: {}", msg);
		logger.info("===batch (batchSeokpoSoneData) End===");
	}

	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void batchBonsaCapsData(String today) throws Exception {
		logger.info("===batch (batchBonsaCapsData) {} Start===", today);

		String day = StringUtils.replace(today, "/", "");
		List<HashMap<String, String>> list = query.selectList(NAMESPACE + "yp_batch.retrieveBonsaCapsData", day);
		logger.debug("데이터 행 수: {}", list.size());
		logger.debug("금일날짜: {}", day);

		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("ZHR_GET_ATTEDANCE_BONSA");
		function.getImportParameterList().setValue("I_DATE", day); // 시작일
		JCoTable table = function.getTableParameterList().getTable("T_ZHRT0110");
		//JCoTable table = function.getTableParameterList().getTable("ZHRT0110");

		for (int i = 0; i < list.size(); i++) {
			table.appendRow();
			table.setValue("MANDT", "100"); //클라이언트
			table.setValue("Z02_KUNMU_DT", (String) list.get(i).get("E_DATE")); //근태일자
			table.setValue("Z02_SERIAL_NUM", String.valueOf(list.get(i).get("NUM"))); //순번
			table.setValue("Z02_SABUN", (String) list.get(i).get("E_IDNO")); //사용자 사번
			table.setValue("Z02_KUNMU_TYPE", (String) list.get(i).get("E_MODE")); //근무타입
			table.setValue("Z02_KUNMU_TIME", (String) list.get(i).get("E_TIME")); //근무시간
			table.setValue("Z02_YOIL","00"); //요일
			table.setValue("Z02_CARD_ID", (String) list.get(i).get("E_CARD")); //카드번호
			table.setValue("Z02_READER_NUM", String.valueOf(list.get(i).get("G_ID"))); //리더기넘버
			table.setValue("Z02_READER_INDEX","00"); //리더기인덱스
			table.setValue("Z02_CREATE_DATE", (String) list.get(i).get("CREATE_DATE")); //근태생성일
			table.setValue("Z02_CREATE_TIME", (String) list.get(i).get("CREATE_TIME")); //근태생성시간
			table.setValue("Z02_CREATE_USER", "IFGW01"); //데이터생성자
		}

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		String result = function.getExportParameterList().getString("E_FLAG");
		String msg = function.getExportParameterList().getString("E_MESSAGE");

		logger.info("결과: {}", result);
		logger.info("메시지: {}", msg);
		logger.info("===batch (batchBonsaCapsData) End===");
	}


	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void batchAnsanCapsData(String today) throws Exception {
		logger.info("===batch (batchAnsanCapsData) {} Start===", today);

		String day = StringUtils.replace(today, "/", "");
		List<HashMap<String, String>> list = query.selectList(NAMESPACE + "yp_batch.retrieveAnsanCapsData", day);
		logger.debug("데이터 행 수: {}", list.size());
		logger.debug("금일날짜: {}", day);

		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("ZHR_GET_ATTEDANCE_BONSA");
		function.getImportParameterList().setValue("I_DATE", day); // 시작일
		JCoTable table = function.getTableParameterList().getTable("T_ZHRT0130");
		//JCoTable table = function.getTableParameterList().getTable("ZHRT0110");

		for (int i = 0; i < list.size(); i++) {
			table.appendRow();
			table.setValue("MANDT", "100"); //클라이언트
			table.setValue("Z02_KUNMU_DT", (String) list.get(i).get("E_DATE")); //근태일자
			table.setValue("Z02_SERIAL_NUM", String.valueOf(list.get(i).get("NUM"))); //순번
			table.setValue("Z02_SABUN", (String) list.get(i).get("E_IDNO")); //사용자 사번
			table.setValue("Z02_KUNMU_TYPE", (String) list.get(i).get("E_MODE")); //근무타입
			table.setValue("Z02_KUNMU_TIME", (String) list.get(i).get("E_TIME")); //근무시간
			table.setValue("Z02_YOIL","00"); //요일
			table.setValue("Z02_CARD_ID", (String) list.get(i).get("E_CARD")); //카드번호
			table.setValue("Z02_READER_NUM", String.valueOf(list.get(i).get("G_ID"))); //리더기넘버
			table.setValue("Z02_READER_INDEX","00"); //리더기인덱스
			table.setValue("Z02_CREATE_DATE", (String) list.get(i).get("CREATE_DATE")); //근태생성일
			table.setValue("Z02_CREATE_TIME", (String) list.get(i).get("CREATE_TIME")); //근태생성시간
			table.setValue("Z02_CREATE_USER", "IFGW01"); //데이터생성자
		}

		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		String result = function.getExportParameterList().getString("E_FLAG");
		String msg = function.getExportParameterList().getString("E_MESSAGE");

		logger.info("결과: {}", result);
		logger.info("메시지: {}", msg);
		logger.info("===batch (batchAnsanCapsData) End===");
	}


	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void batchWorkingBIData(String yesterday) throws Exception {
		logger.info("===batch (batchWorkingBIData) {} Strart===", yesterday);

		int day = Integer.parseInt(yesterday.substring(6));
		ArrayList<HashMap<String, String>> datalist = new ArrayList<HashMap<String, String>>();
		HashMap<String, String> data = new HashMap<String, String>();

		data.put("yyyy", yesterday.substring(0, 4));
		data.put("mm", yesterday.substring(4, 6));
		data.put("dd", yesterday.substring(6, 8));
		logger.debug("BI조회 : {}", data);
		List<HashMap<String, String>> map = query.selectList(NAMESPACE + "yp_batch.retrieveWorkingBIData", data);

		for (int i = 0; i < map.size(); i++) {
			data = new HashMap<String, String>();
			switch (map.get(i).get("MPOINT")) {
			case "023877": // 석고 원심분리기 운전
				data.put("contract_code", "03019");
				data.put("vendor_code", "V3");
				break;
			case "022471": // 황산동 생산2차
				data.put("contract_code", "03017");
				data.put("vendor_code", "V3");
				break;
			case "401510": // doss 1공장
				data.put("contract_code", "06004");
				data.put("vendor_code", "V6");
				break;
			case "022392": // doss 2공장-1
				data.put("contract_code", "02004");
				data.put("vendor_code", "V2");
				break;
			// case "022393" : //doss 2공장-2
			// data.put("contract_code", "02004");
			// data.put("vendor_code", "");
			// break;
			case "401332": // 1공장 alloy scrumming
				data.put("contract_code", "06003");
				data.put("vendor_code", "V6");
				break;
			case "401335": // 주조1공장 대형아연제조
				data.put("contract_code", "06002");
				data.put("vendor_code", "V6");
				break;
			case "401348": // 주조2공장 대형아연제조
				data.put("contract_code", "02002");
				data.put("vendor_code", "V2");
				break;
			case "401338": // 2공장 slab 주조기 운전
				data.put("contract_code", "02003");
				data.put("vendor_code", "V2");
				break;
			case "024253": // 전해1 자동박리기운전
				data.put("contract_code", "05001");
				data.put("vendor_code", "V5");
				break;
			case "020569": // 전해2 자동박리기 보조
				data.put("contract_code", "05003");
				data.put("vendor_code", "V5");
				break;
			case "023428": // tsl1 f/b분해
				data.put("contract_code", "04001");
				data.put("vendor_code", "V4");
				break;
			case "022699": // tsl2 f/b분해
				data.put("contract_code", "04003");
				data.put("vendor_code", "V4");
				break;
			/*
			 * 확인중 case "021871" : //정광투입 data.put("contract_code", ""); data.put("vendor_code", ""); break;
			 */
			default:
				data.put("contract_code", "");
				break;
			}

			if (data.get("contract_code").length() > 0) {
				data.put("yyyy", yesterday.substring(0, 4));
				data.put("date", yesterday);
				data.put("mpoint", map.get(i).get("MPOINT"));
				data.put("workload", String.valueOf(map.get(i).get("VALUE" + String.valueOf(day))));
				datalist.add(data);
			}
			logger.debug("입력 : {}", data);
		}

		logger.debug("{}", datalist);
		int result = query.insert(NAMESPACE + "yp_batch.createWorkingBIData", datalist);
		logger.info("결과: {}", result);
		// logger.info("메시지: {}",msg);
		logger.info("===batch (batchWorkingBIData) End===");
	}


	@SuppressWarnings({ "unused" })
	private HashMap<String, Object> getOvetime(HashMap<String, String> data, HashMap<String, String> pdata) {

		HashMap<String, Object> result = new HashMap<String, Object>();

		float plan_time = Float.parseFloat(data.get("WORK_OVERTIME")); // 계획연장시간
		float regular_time = Float.parseFloat(data.get("NOMTIME")); // 원근무 정규시수
		String work_type = data.get("TPROG").substring(2); // 원근무 코드

		if (data.get("IN_TIME1") != null || data.get("OUT_TIME1") != null) {
			// 19.11.08 실초과근무 계산법 변경
			int plan_start = Integer.parseInt(StringUtils.replace(pdata.get("WORK_STARTTIME"), ":", "") + "00");
			int true_start = Integer.parseInt(data.get("IN_TIME1"));
			int plan_end = Integer.parseInt(StringUtils.replace(pdata.get("WORK_ENDTIME"), ":", "") + "00");
			int true_end = Integer.parseInt(data.get("OUT_TIME1"));

			// NT근무일경우 다음날로 계산
			// 신청시간이 12시 이전이면 다음날로 인식하여 24시를 더해줌
			if (work_type.equals("NT")) {
				if (plan_start < 120000) {
					plan_start += 240000;
					plan_end += 240000;
				}
				if ((plan_end - true_end < 240000)) {
					true_end += 240000;
				}
			}

			String ot_start = plan_start > true_start ? StringUtils.replace(pdata.get("WORK_STARTTIME"), ":", "") + "00" : data.get("IN_TIME1"); // 시작시간은 늦은시간 적용
			String ot_end = plan_end < true_end ? StringUtils.replace(pdata.get("WORK_ENDTIME"), ":", "") + "00" : data.get("OUT_TIME1"); // 종료시간은 빠른시간 적용

			int s_hour = Integer.parseInt(ot_start.substring(0, 2));
			float s_min = Float.parseFloat(ot_start.substring(2, 4));
			int e_hour = Integer.parseInt(ot_end.substring(0, 2));
			float e_min = Float.parseFloat(ot_end.substring(2, 4));

			if (s_min > e_min) {// 분단위 확인
				e_hour = e_hour - 1;
				e_min = e_min + 60;
			}
			float work_min = (e_min - s_min) * 10 / 600;

			if (s_hour > e_hour) {
				e_hour = e_hour + 24;
			}
			float work_hour = e_hour - s_hour;
			float t_ot = work_hour + work_min;

			result.put("ot_start", ot_start);
			result.put("ot_end", ot_end);
			result.put("t_ot", t_ot);
		} else {
			// 출퇴근 기록이 없을 경우
			result.put("ot_start", "000000");
			result.put("ot_end", "000000");
			result.put("t_ot", 0.00);
		}

		return result;
	}

	@Override
	public void sapTransferEmoInfo() throws Exception {
		logger.info("###############################################");
		logger.info("########## sapTransferEmoInfo start! ###########");
		logger.info("###############################################");
		try {
			List<HashMap<String, String>> empList = query.selectList(NAMESPACE + "yp_batch.sapTransferEmoInfo");

			SapJcoConnection jcoConnect = new SapJcoConnection();

			JCoFunction function = jcoConnect.getFunction("Z_COMMON_GW_GET_INFO");
			JCoTable table = function.getTableParameterList().getTable("T_GWINFO");
			for (int i = 0; i < empList.size(); i++) {
				table.appendRow();
				table.setValue("EMP_ID", (String) empList.get(i).get("EMP_ID"));
				table.setValue("USER_ID", (String) empList.get(i).get("USER_ID"));
				table.setValue("EMP_CODE", (String) empList.get(i).get("EMP_CD"));
				table.setValue("EMP_NAME", (String) empList.get(i).get("USER_NAME"));
				table.setValue("PASSWORD", (String) empList.get(i).get("SAP_PWD"));
				table.setValue("CMP_ID", (String) empList.get(i).get("CMP_ID"));
				table.setValue("EMP_STATUS", (String) empList.get(i).get("EMP_STATUS"));
				logger.info(i + ":" + (String) empList.get(i).get("USER_ID") + "/" + (String) empList.get(i).get("SAP_PWD"));
			}
			jcoConnect.execute(function);
		} catch (Exception e) {
			logger.info("###############################################");
			logger.info("###### sapTransferEmoInfo end! ########");
			logger.info("###############################################");
			e.printStackTrace();
		}
	}

	
	/**
	 * YPWEBPOTAL-27 ENT_CODE 코드 앞의 0삭제 건
	 * 배치 > TBL_WEIGHT_DATA 의 ENT_CODE 필드의 코드 변경
	 * 
	 * 10자리일경우에 6자리로 변경하는데 앞에 0이 포함되어있을경우에만 해당한다.
	 * 
	 * 05:00 (매일 1회)
	 */
	@Override
	public void setWeightTableEntCodeFieldReplaceData() throws Exception {
		// TODO Auto-generated method stub

		logger.info("###############################################");
		logger.info("########## setWeightTableEntCodeFieldReplaceData start! ###########");
		logger.info("###############################################");
		
		try {
			int updrows = query.update(NAMESPACE + "yp_batch.updateWeightTableEntCodeFieldData");
			
			logger.info("updrows : " + updrows);
			
		} catch (Exception e) {
			logger.info("###############################################");
			logger.info("###### setWeightTableEntCodeFieldReplaceData end! ########");
			logger.info("###############################################");
			e.printStackTrace();
		}
		
	}
	
	
	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void batchMSSQLData() throws Exception {
		logger.info("===batch (batchMSSQLData) {} Start===");

		List<HashMap<String, String>> list = query_cas.selectList(NAMESPACE + "yp_batch.selectMssqlTest");
		logger.debug("데이터 행 수: {}", list.size());

		SapJcoConnection jcoConnect = new SapJcoConnection();
		JCoFunction function = jcoConnect.getFunction("ZHR_GET_COM_DATA");
		JCoTable table = function.getTableParameterList().getTable("T_DATA");
		
		for (int i = 0; i < 2; i++) {
			table.appendRow();
			table.setValue("Z01_KUNMU_DT", "20221026");
			table.setValue("Z01_SERIAL_NUM", 11);
			table.setValue("Z01_SABUN", (String) list.get(i).get("FINAL_WEIGHT"));
			table.setValue("Z01_KUNMU_TYPE", "05");
			table.setValue("Z01_KUNMU_TIME", "0608");
			table.setValue("Z01_YOIL","02");
			table.setValue("Z01_CARD_ID", (String) list.get(i).get("CAR_NUM"));
			table.setValue("Z01_READER_NUM", "24");
			table.setValue("Z01_READER_INDEX", "10");
			
			System.out.println();
			System.out.println(list.toString());
		}
		
		
		
		// RFC 호출
		jcoConnect.execute(function);

		// RFC 결과
		String result = function.getExportParameterList().getString("E_FLAG");
		String msg = function.getExportParameterList().getString("E_MESSAGE");

		logger.info("결과: {}", result);
		logger.info("메시지: {}", msg);
		logger.info("===batch (batchSeokpoSoneData) End===");
	}

	@Override
	public void batchInsertDate() throws Exception {
		// TODO Auto-generated method stub
		Calendar cal = Calendar.getInstance();
        String today = new SimpleDateFormat("yyyyMMdd").format(cal.getTime());

        cal.add(Calendar.DATE, 3); // 3일 후의 값을 넣기
        String dateForInsert = new SimpleDateFormat("yyyyMMdd").format(cal.getTime());
        int month = cal.get(Calendar.MONTH) + 1;
        int weekNum = cal.get(Calendar.WEEK_OF_YEAR);
        int quarter = (int) Math.ceil((double)month / 3);

        HashMap<String, String> data = new HashMap<String, String>();
        data.put("BASE_DT", dateForInsert);
        data.put("CREATE_DATE", today);
        data.put("YYYY", dateForInsert.substring(0, 4));
        data.put("MM", dateForInsert.substring(4, 6));
        data.put("QUARTER", Integer.toString(quarter)+"분기");
        data.put("WW", Integer.toString(weekNum+1)+"주차");

        if(month / 6 >= 1){
            data.put("HALF", "하반기");
        }else {
            data.put("HALF", "상반기");
        }
	    
	    
		logger.info("###############################################");
		logger.info("########## Insert BI NEW DATE DATA start! ###########");
		logger.info("###############################################");
		try {
			logger.info("입력 날짜(BASE_DT) : " + dateForInsert);
			
			int result = query_bi.insert(NAMESPACE + "yp_batch.insertNewDate", data);
			
		    logger.info("결과 : " + result);
		} catch (Exception e) {
			logger.info("###############################################");
			logger.info("###### Insert BI NEW DATE DATA end! ########");
			logger.info("###############################################");
			e.printStackTrace();
		}
	   
	}

}