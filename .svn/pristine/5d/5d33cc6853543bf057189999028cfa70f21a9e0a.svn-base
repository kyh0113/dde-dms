package com.vicurus.it.biz.dashboard.srvc;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.vicurus.it.core.common.Util;
import com.vicurus.it.biz.dashboard.srvc.intf.DashBoardService;

@Repository
public class DashBoardServiceImpl implements DashBoardService{
	
	private static final Logger logger = LoggerFactory.getLogger(DashBoardServiceImpl.class);
	
	//config.properties 에서 설정 정보 가져오기 시작
	private static String NAMESPACE;
			
	@Value("#{config['db.vendor']}")
	public void setNAMESPACE(String value) {
		this.NAMESPACE = value + ".";
	}
	//config.properties 에서 설정 정보 가져오기 끝
	
	
	@Autowired
	@Resource(name="sqlSession")
	private SqlSession query;
	
	

	@Override
	public int auditAdd(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)

		int result = query.insert(NAMESPACE+"biz_dashBoard.auditAdd", paramMap);
		return result;
	}
	
	@Override
	@Transactional
	public int auditEdit(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = query.update(NAMESPACE+"biz_dashBoard.auditEdit", paramMap);
		return result;
	}
	
	
	@Override
	public String getMaxDeptCode(Map paramMap) throws Exception {
		String dept_code = query.selectOne(NAMESPACE+"biz_dashBoard.getMaxDeptCode", paramMap);
		return dept_code;
	}
	
	@Override
	public Map getProgress_elc_dt_dept(Map paramMap) throws Exception {
		List list = query.selectList(NAMESPACE+"biz_dashBoard.getProgress_elc_dt_dept", paramMap);
		Map result_map = new HashMap();
		result_map.put("progress_list", list);
		return result_map;
	}
	
	@Override
	public Map getProgress_plc_dt_dept(Map paramMap) throws Exception {
		List list = query.selectList(NAMESPACE+"biz_dashBoard.getProgress_plc_dt_dept", paramMap);
		Map result_map = new HashMap();
		result_map.put("progress_list", list);
		return result_map;
	}
	
	@Override
	public Map getProgress_elc_ot_dept(Map paramMap) throws Exception {
		List list = query.selectList(NAMESPACE+"biz_dashBoard.getProgress_elc_ot_dept", paramMap);
		Map result_map = new HashMap();
		result_map.put("progress_list", list);
		return result_map;
	}
	
	@Override
	public Map getProgress_plc_ot_dept(Map paramMap) throws Exception {
		List list = query.selectList(NAMESPACE+"biz_dashBoard.getProgress_plc_ot_dept", paramMap);
		Map result_map = new HashMap();
		result_map.put("progress_list", list);
		return result_map;
	}
	
	@Override
	public Map getProgress_plc_ot_tester(Map paramMap) throws Exception {
		List list = query.selectList(NAMESPACE+"biz_dashBoard.getProgress_plc_ot_tester", paramMap);
		Map result_map = new HashMap();
		result_map.put("progress_list", list);
		return result_map;
	}

	@Override
	public Map getDashBoardChart(Map paramMap) throws Exception {
		// TODO Auto-generated method stub
		Map resultMap = new HashMap();
		resultMap.put("section1_account", query.selectOne(NAMESPACE+"biz_dashBoardChart.account_cnt",paramMap));
		resultMap.put("section1_process", query.selectOne(NAMESPACE+"biz_dashBoardChart.process_cnt",paramMap));
		resultMap.put("section1_elc", query.selectOne(NAMESPACE+"biz_dashBoardChart.elc_cnt",paramMap));
		resultMap.put("section1_plc", query.selectOne(NAMESPACE+"biz_dashBoardChart.plc_cnt",paramMap));
		resultMap.put("section1_remark", query.selectOne(NAMESPACE+"biz_dashBoardChart.remark_cnt",paramMap));
		resultMap.put("section1_mrc_ipe", query.selectOne(NAMESPACE+"biz_dashBoardChart.mrc_ipe_cnt",paramMap));
		resultMap.put("section2_performm_percent", query.selectOne(NAMESPACE+"biz_dashBoardChart.perform_percent",paramMap));
		
		resultMap.put("total_test_progress", query.selectOne(NAMESPACE+"biz_dashBoardChart.total_test_progress",paramMap));
		resultMap.put("test_progress", query.selectList(NAMESPACE+"biz_dashBoardChart.test_progress",paramMap));
		resultMap.put("gap_progress", query.selectOne(NAMESPACE+"biz_dashBoardChart.gap_progress",paramMap));
		resultMap.put("dept_progress", query.selectList(NAMESPACE+"biz_dashBoardChart.dept_progress",paramMap));
		
		return resultMap;
	}

	@Override
	public Map modal_account_cnt(Map paramMap) throws Exception {
		Map resultMap = new HashMap();
		resultMap.put("modal_account_cnt", query.selectList(NAMESPACE+"biz_dashBoardChart.modal_account_cnt",paramMap));
		return resultMap;
	}

	@Override
	public Map modal_process_cnt(Map paramMap) throws Exception {
		Map resultMap = new HashMap();
		resultMap.put("modal_process_cnt", query.selectList(NAMESPACE+"biz_dashBoardChart.modal_process_cnt",paramMap));
		return resultMap;
	}
	
	@Override
	public Map getDashBoardStepbar(Map paramMap) throws Exception {
		// TODO Auto-generated method stub
		Map resultMap = new HashMap();
		resultMap = (Map)query.selectOne(NAMESPACE+"biz_dashBoardChart.stepbar",paramMap);
		return resultMap;
	}
	
	@Override
	public Map top5Chart(Map paramMap) throws Exception {
		// TODO Auto-generated method stub
		Map resultMap = new HashMap();
		
		String test_type = (String)paramMap.get("gubun");	//평가유형
		
		if(test_type.equals("elc_dt_dept") ) {				//전사설계평가
			resultMap.put("Top5List",    query.selectList(NAMESPACE+"biz_dashBoardChart.getTestApproved_Top5_elcdt",paramMap));
			resultMap.put("Bottom5List", query.selectList(NAMESPACE+"biz_dashBoardChart.getTestApproved_Bottom5_elcdt",paramMap));
		}else if(test_type.equals("plc_dt_dept") ) {		//프로세스설계평가
			resultMap.put("Top5List",    query.selectList(NAMESPACE+"biz_dashBoardChart.getTestApproved_Top5_plcdt",paramMap));
			resultMap.put("Bottom5List", query.selectList(NAMESPACE+"biz_dashBoardChart.getTestApproved_Bottom5_plcdt",paramMap));
		}else if(test_type.equals("elc_ot_dept") ) {		//전사운영평가
			resultMap.put("Top5List",    query.selectList(NAMESPACE+"biz_dashBoardChart.getTestApproved_Top5_elcot",paramMap));
			resultMap.put("Bottom5List", query.selectList(NAMESPACE+"biz_dashBoardChart.getTestApproved_Bottom5_elcot",paramMap));
		}else{												//프로세스운영평가
			resultMap.put("Top5List",    query.selectList(NAMESPACE+"biz_dashBoardChart.getTestApproved_Top5_plcot",paramMap));
			resultMap.put("Bottom5List", query.selectList(NAMESPACE+"biz_dashBoardChart.getTestApproved_Bottom5_plcot",paramMap));
		}
		
		return resultMap;
	}
	
	@Override
	public Map TotalGapChart(Map paramMap) throws Exception {
		// TODO Auto-generated method stub
		Map resultMap = new HashMap();
		List list = query.selectList(NAMESPACE+"biz_dashBoardChart.TotalGapChart",paramMap);
		Collections.reverse(list);				//차트에 오름차순으로 표현하기 위해 역순 정렬
		resultMap.put("TotalGapChart", list);	//미비점추이
		resultMap.put("GapProgressDetail", query.selectList("biz_dashBoardChart.gap_progress_detail",paramMap));	//미비점 평가별 상세진행
		
		return resultMap;
	}

	@Override
	public Map modal_control_cnt(Map paramMap) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map modal_remark_cnt(Map paramMap) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map modal_mrc_ipe_cnt(Map paramMap) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map GapDetailInfo(Map paramMap) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
}
