package com.yp.zcs.ipt2.srvc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.vicurus.it.core.common.Util;
import com.yp.zcs.ipt2.srvc.intf.YP_ZCS_IPT2_Service;


@Repository
public class YP_ZCS_IPT2_ServiceImpl implements YP_ZCS_IPT2_Service {

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

	private static final Logger logger = LoggerFactory.getLogger(YP_ZCS_IPT2_ServiceImpl.class);

	@SuppressWarnings({"rawtypes"})
	@Override
	public HashMap<String, Object> select_zcs_ipt2_daily_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】정비용역 > 도급일보 > 일보확정(공수)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> data = new HashMap<String, Object>();
		List<HashMap<String, String>> list1 = new ArrayList<HashMap<String, String>>();
		list1 = query.selectList(NAMESPACE + "yp_zcs_ipt2.select_zcs_ipt2_daily_rpt1", req_data);
		data.put("list1", list1);
		return data;
	}

	@SuppressWarnings({"rawtypes", "unchecked", "unused"})
	@Transactional
	@Override
	public int delete_zcs_ipt2_daily_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【삭제】정비용역 > 도급일보 > 일보확정(공수)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		int cnt = 0;

		// 일보 삭제
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			logger.debug("【삭제】일보확정 데이터 확인 - {}", jsonObj);
			result += query.delete(NAMESPACE + "yp_zcs_ipt2.delete_zcs_ipt2_daily_rpt1", jsonObj);
		}
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int merge_zcs_ipt2_daily_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【저장】정비용역 > 도급일보 > 일보확정(공수)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【저장】일보확정 데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.merge_zcs_ipt2_daily_rpt1", jsonObj);
			/* 2022-01-04 jamerl - 돌발작업 로직 추가 */
			if ( "Y".equals( jsonObj.get("UNEXPECTED_YN") ) ){
				query.update(NAMESPACE + "yp_zcs_ipt2.update_tbl_wk_access_aufnr_unexpected", jsonObj);
			}
		}
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int pre_select_zcs_ipt2_daily_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【승인여부 확인】정비용역 > 도급일보 > 일보확정(공수)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【승인여부 확인】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			int rt = query.selectOne(NAMESPACE + "yp_zcs_ipt2.pre_select_zcs_ipt2_daily_rpt1", jsonObj);
			result += rt;
		}
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int update_confirm_zcs_ipt2_daily_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【확정】정비용역 > 도급일보 > 일보확정(공수)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【확정】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.update_confirm_zcs_ipt2_daily_rpt1", jsonObj);
		}
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int update_cancel_zcs_ipt2_daily_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【확정취소】정비용역 > 도급일보 > 일보확정(공수)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【확정취소】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.update_cancel_zcs_ipt2_daily_rpt1", jsonObj);
		}
		return result;
	}

	@SuppressWarnings({"rawtypes"})
	@Override
	public HashMap<String, Object> select_zcs_ipt2_daily_aprv1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】정비용역 > 도급일보 > 일보승인(공수)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> data = new HashMap<String, Object>();
		List<HashMap<String, String>> list1 = new ArrayList<HashMap<String, String>>();
		list1 = query.selectList(NAMESPACE + "yp_zcs_ipt2.select_zcs_ipt2_daily_aprv1", req_data);
		data.put("list1", list1);
		return data;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int update_aprv_zcs_ipt2_daily_aprv1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【승인】정비용역 > 도급일보 > 일보승인(공수)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【승인】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.update_aprv_zcs_ipt2_daily_aprv1", jsonObj);
		}
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int update_reject_zcs_ipt2_daily_aprv1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【승인취소】정비용역 > 도급일보 > 일보승인(공수)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【승인취소】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.update_reject_zcs_ipt2_daily_aprv1", jsonObj);
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int lock_zcs_ipt2_daily_aprv1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【기한설정】정비용역 > 도급일보 > 일보승인(공수)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【기한설정】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.lock_zcs_ipt2_daily_aprv1", jsonObj);
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int release_zcs_ipt2_daily_aprv1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【기한해제】정비용역 > 도급일보 > 일보승인(공수)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【기한해제】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.release_zcs_ipt2_daily_aprv1", jsonObj);
		}
		return result;
	}

	@SuppressWarnings({"rawtypes"})
	@Override
	public HashMap<String, Object> select_zcs_ipt2_daily_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】정비용역 > 도급일보 > 일보확정(작업-태그데이터)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> data = new HashMap<String, Object>();
		List<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		list = query.selectList(NAMESPACE + "yp_zcs_ipt2.select_zcs_ipt2_daily_rpt2_tag", req_data);
		data.put("list1", list);
		list = query.selectList(NAMESPACE + "yp_zcs_ipt2.select_zcs_ipt2_daily_rpt2", req_data);
		data.put("list2", list);
		list = query.selectList(NAMESPACE + "yp_zcs_ipt2.select_tbl_construction_subc_emp_cost", req_data);
		data.put("list3", list);
		return data;
	}

	@SuppressWarnings({"rawtypes", "unchecked", "unused"})
	@Transactional
	@Override
	public int delete_zcs_ipt2_daily_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【삭제】정비용역 > 도급일보 > 일보확정(작업-태그데이터)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		int cnt = 0;

		// 일보 삭제
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			logger.debug("【삭제】일보확정 데이터 확인 - {}", jsonObj);
			result += query.delete(NAMESPACE + "yp_zcs_ipt2.delete_zcs_ipt2_daily_rpt2", jsonObj);
		}
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked", "unused"})
	@Transactional
	@Override
	public int delete_zcs_ipt2_daily_rpt2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【삭제】정비용역 > 도급일보 > 일보확정(작업-태그데이터)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		int cnt = 0;

		// 일보 삭제
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			logger.debug("【삭제】일보확정 데이터 확인 - {}", jsonObj);
			result += query.delete(NAMESPACE + "yp_zcs_ipt2.delete_zcs_ipt2_daily_rpt2_tag", jsonObj);
		}
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int merge_zcs_ipt2_daily_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【저장】정비용역 > 도급일보 > 일보확정(작업)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【저장】일보확정 데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.merge_zcs_ipt2_daily_rpt2", jsonObj);
		}
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int merge_zcs_ipt2_daily_rpt2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【저장】정비용역 > 도급일보 > 일보확정(작업-태그데이터)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【저장】일보확정 데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.merge_zcs_ipt2_daily_rpt2_tag", jsonObj);
			/* 2022-01-04 jamerl - 돌발작업 로직 추가 */
			if ( "Y".equals( jsonObj.get("UNEXPECTED_YN") ) ){
				query.update(NAMESPACE + "yp_zcs_ipt2.update_tbl_wk_access_aufnr_unexpected", jsonObj);
			}
		}
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int pre_select_zcs_ipt2_daily_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【승인여부 확인】정비용역 > 도급일보 > 일보확정(작업)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【승인여부 확인】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			int rt = query.selectOne(NAMESPACE + "yp_zcs_ipt2.pre_select_zcs_ipt2_daily_rpt2", jsonObj);
			result += rt;
		}
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int pre_select_zcs_ipt2_daily_rpt2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【승인여부 확인】정비용역 > 도급일보 > 일보확정(작업-태그데이터)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【승인여부 확인】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			int rt = query.selectOne(NAMESPACE + "yp_zcs_ipt2.pre_select_zcs_ipt2_daily_rpt2_tag", jsonObj);
			result += rt;
		}
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int update_confirm_zcs_ipt2_daily_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【확정】정비용역 > 도급일보 > 일보확정(작업)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【확정】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.update_confirm_zcs_ipt2_daily_rpt2", jsonObj);
		}
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int update_cancel_zcs_ipt2_daily_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【확정취소】정비용역 > 도급일보 > 일보확정(작업)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【확정취소】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.update_cancel_zcs_ipt2_daily_rpt2", jsonObj);
		}
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int update_confirm_zcs_ipt2_daily_rpt2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【확정】정비용역 > 도급일보 > 일보확정(작업-태그데이터)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【확정】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.update_confirm_zcs_ipt2_daily_rpt2_tag", jsonObj);
		}
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int update_cancel_zcs_ipt2_daily_rpt2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【확정취소】정비용역 > 도급일보 > 일보확정(작업-태그데이터)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【확정취소】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.update_cancel_zcs_ipt2_daily_rpt2_tag", jsonObj);
		}
		return result;
	}

	@SuppressWarnings({"rawtypes"})
	@Override
	public HashMap<String, Object> select_zcs_ipt2_daily_aprv2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】정비용역 > 도급일보 > 일보승인(작업)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> data = new HashMap<String, Object>();
		List<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		list = query.selectList(NAMESPACE + "yp_zcs_ipt2.select_zcs_ipt2_daily_aprv2_tag", req_data);
		data.put("list1", list);
		list = query.selectList(NAMESPACE + "yp_zcs_ipt2.select_zcs_ipt2_daily_aprv2", req_data);
		data.put("list2", list);
		list = query.selectList(NAMESPACE + "yp_zcs_ipt2.select_tbl_construction_subc_emp_cost", req_data);
		data.put("list3", list);
		return data;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int update_aprv_zcs_ipt2_daily_aprv2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【승인】정비용역 > 도급일보 > 일보승인(작업)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【승인】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.update_aprv_zcs_ipt2_daily_aprv2", jsonObj);
		}
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int update_reject_zcs_ipt2_daily_aprv2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【승인취소】정비용역 > 도급일보 > 일보승인(작업)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【승인취소】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.update_reject_zcs_ipt2_daily_aprv2", jsonObj);
		}
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int update_aprv_zcs_ipt2_daily_aprv2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【승인】정비용역 > 도급일보 > 일보승인(작업-태그데이터)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【승인】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.update_aprv_zcs_ipt2_daily_aprv2_tag", jsonObj);
		}
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int update_reject_zcs_ipt2_daily_aprv2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【승인취소】정비용역 > 도급일보 > 일보승인(작업-태그데이터)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【승인취소】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.update_reject_zcs_ipt2_daily_aprv2_tag", jsonObj);
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int lock_zcs_ipt2_daily_aprv2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【기한설정】정비용역 > 도급일보 > 일보승인(작업)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【기한설정】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.lock_zcs_ipt2_daily_aprv2", jsonObj);
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int release_zcs_ipt2_daily_aprv2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【기한해제】정비용역 > 도급일보 > 일보승인(작업)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【기한해제】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.release_zcs_ipt2_daily_aprv2", jsonObj);
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int lock_zcs_ipt2_daily_aprv2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【기한설정】정비용역 > 도급일보 > 일보승인(작업-태그데이터)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【기한설정】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.lock_zcs_ipt2_daily_aprv2_tag", jsonObj);
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int release_zcs_ipt2_daily_aprv2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【기한해제】정비용역 > 도급일보 > 일보승인(작업-태그데이터)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【기한해제】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.release_zcs_ipt2_daily_aprv2_tag", jsonObj);
		}
		return result;
	}

	@SuppressWarnings({"rawtypes"})
	@Override
	public HashMap<String, Object> select_zcs_ipt2_daily_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】정비용역 > 도급일보 > 일보확정(월정액)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> data = new HashMap<String, Object>();
		List<HashMap<String, String>> list1 = new ArrayList<HashMap<String, String>>();
		list1 = query.selectList(NAMESPACE + "yp_zcs_ipt2.select_zcs_ipt2_daily_rpt3", req_data);
		data.put("list1", list1);
		return data;
	}

	@SuppressWarnings({"rawtypes", "unchecked", "unused"})
	@Transactional
	@Override
	public int delete_zcs_ipt2_daily_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【삭제】정비용역 > 도급일보 > 일보확정(월정액)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		int cnt = 0;

		// 일보 삭제
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			logger.debug("【삭제】일보확정 데이터 확인 - {}", jsonObj);
			result += query.delete(NAMESPACE + "yp_zcs_ipt2.delete_zcs_ipt2_daily_rpt3", jsonObj);
		}
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int merge_zcs_ipt2_daily_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【저장】정비용역 > 도급일보 > 일보확정(월정액)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【저장】일보확정 데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.merge_zcs_ipt2_daily_rpt3", jsonObj);
			/* 2022-01-04 jamerl - 돌발작업 로직 추가 */
			if ( "Y".equals( jsonObj.get("UNEXPECTED_YN") ) ){
				query.update(NAMESPACE + "yp_zcs_ipt2.update_tbl_wk_access_aufnr_unexpected", jsonObj);
			}
		}
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int pre_select_zcs_ipt2_daily_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【승인여부 확인】정비용역 > 도급일보 > 일보확정(월정액)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【승인여부 확인】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			int rt = query.selectOne(NAMESPACE + "yp_zcs_ipt2.pre_select_zcs_ipt2_daily_rpt3", jsonObj);
			result += rt;
		}
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int update_confirm_zcs_ipt2_daily_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【확정】정비용역 > 도급일보 > 일보확정(월정액)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【확정】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.update_confirm_zcs_ipt2_daily_rpt3", jsonObj);
		}
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int update_cancel_zcs_ipt2_daily_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【확정취소】정비용역 > 도급일보 > 일보확정(월정액)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【확정취소】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.update_cancel_zcs_ipt2_daily_rpt3", jsonObj);
		}
		return result;
	}

	@SuppressWarnings({"rawtypes"})
	@Override
	public HashMap<String, Object> select_zcs_ipt2_daily_aprv3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】정비용역 > 도급일보 > 일보승인(월정액)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> data = new HashMap<String, Object>();
		List<HashMap<String, String>> list1 = new ArrayList<HashMap<String, String>>();
		list1 = query.selectList(NAMESPACE + "yp_zcs_ipt2.select_zcs_ipt2_daily_aprv3", req_data);
		data.put("list1", list1);
		return data;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int update_aprv_zcs_ipt2_daily_aprv3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【승인】정비용역 > 도급일보 > 일보승인(월정액)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【승인】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.update_aprv_zcs_ipt2_daily_aprv3", jsonObj);
		}
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int update_reject_zcs_ipt2_daily_aprv3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【승인취소】정비용역 > 도급일보 > 일보승인(월정액)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【승인취소】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.update_reject_zcs_ipt2_daily_aprv3", jsonObj);
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int lock_zcs_ipt2_daily_aprv3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【기한설정】정비용역 > 도급일보 > 일보승인(월정액)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【기한설정】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.lock_zcs_ipt2_daily_aprv3", jsonObj);
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int release_zcs_ipt2_daily_aprv3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【기한해제】정비용역 > 도급일보 > 일보승인(월정액)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		// 일보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【기한해제】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.release_zcs_ipt2_daily_aprv3", jsonObj);
		}
		return result;
	}

	@SuppressWarnings({"rawtypes"})
	@Override
	public HashMap<String, Object> select_zcs_ipt2_month_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】정비용역 > 비용처리 > 월보등록(공수)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> data = new HashMap<String, Object>();

		int cnt = query.selectOne(NAMESPACE + "yp_zcs_ipt2.pre_select_zcs_ipt2_month_rpt1", req_data);
		List<HashMap<String, String>> list1 = new ArrayList<HashMap<String, String>>();
		HashMap map2 = new HashMap();
		if (cnt > 0) {
			list1 = query.selectList(NAMESPACE + "yp_zcs_ipt2.select_zcs_ipt2_month_rpt1", req_data);
			map2 = query.selectOne(NAMESPACE + "yp_zcs_ipt2.select_zcs_ipt2_month_rpt1_commute", req_data);
			data.put("list1", list1);
			data.put("map2", map2);
		} else {
			list1 = query.selectList(NAMESPACE + "yp_zcs_ipt2.select_zcs_ipt2_month_rpt1_new", req_data);
			map2 = query.selectOne(NAMESPACE + "yp_zcs_ipt2.select_zcs_ipt2_month_rpt1_commute_new", req_data);
			data.put("list1", list1);
			data.put("map2", map2);
		}
		return data;
	}

	@SuppressWarnings({"rawtypes", "unchecked", "unused"})
	@Transactional
	@Override
	public int delete_zcs_ipt2_month_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【삭제】정비용역 > 비용처리 > 월보등록(공수)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		int cnt = 0;

		// 월보 삭제
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			logger.debug("【삭제】월보 삭제 데이터 확인 - {}", jsonObj);
			result = query.delete(NAMESPACE + "yp_zcs_ipt2.delete_zcs_ipt2_month_rpt1", jsonObj);
			break;
		}
		jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO2").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			logger.debug("【삭제】월보 하단 데이터 확인 - {}", jsonObj);
			query.delete(NAMESPACE + "yp_zcs_ipt2.delete_zcs_ipt2_month_rpt1_commute", jsonObj);
		}
		return result;
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int merge_zcs_ipt2_month_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【저장】정비용역 > 비용처리 > 월보등록(공수)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;

		// 월보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【저장】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.merge_zcs_ipt2_month_rpt1", jsonObj);
		}

		// 하단 저장
		jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO2").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【저장】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			query.update(NAMESPACE + "yp_zcs_ipt2.merge_zcs_ipt2_month_rpt1_commute", jsonObj);
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public HashMap<String, Object> select_zcs_ipt2_month_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】정비용역 > 비용처리 > 월보등록(작업)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		int cnt = query.selectOne(NAMESPACE + "yp_zcs_ipt2.pre_select_zcs_ipt2_month_rpt2_tag", req_data);
		List<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		if (cnt > 0) {
			list = query.selectList(NAMESPACE + "yp_zcs_ipt2.select_zcs_ipt2_month_rpt2_tag", req_data);
			data.put("list1", list);
		} else {
			list = query.selectList(NAMESPACE + "yp_zcs_ipt2.select_zcs_ipt2_month_rpt2_tag_new", req_data);
			data.put("list1", list);
		}
		cnt = query.selectOne(NAMESPACE + "yp_zcs_ipt2.pre_select_zcs_ipt2_month_rpt2", req_data);
		list = new ArrayList<HashMap<String, String>>();
		if (cnt > 0) {
			list = query.selectList(NAMESPACE + "yp_zcs_ipt2.select_zcs_ipt2_month_rpt2", req_data);
			data.put("list2", list);
		} else {
			list = query.selectList(NAMESPACE + "yp_zcs_ipt2.select_zcs_ipt2_month_rpt2_new", req_data);
			data.put("list2", list);
		}
		return data;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked", "unused"})
	@Transactional
	@Override
	public int delete_zcs_ipt2_month_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【작업 삭제】정비용역 > 비용처리 > 월보등록(작업)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		int cnt = 0;
		
		// 월보 삭제
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			logger.debug("【작업 삭제】월보 삭제 데이터 확인 - {}", jsonObj);
			result = query.delete(NAMESPACE + "yp_zcs_ipt2.delete_zcs_ipt2_month_rpt2", jsonObj);
			break;
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked", "unused"})
	@Transactional
	@Override
	public int delete_zcs_ipt2_month_rpt2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【태그데이터 삭제】정비용역 > 비용처리 > 월보등록(작업)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		int cnt = 0;
		
		// 월보 삭제
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			logger.debug("【태그데이터 삭제】월보 삭제 데이터 확인 - {}", jsonObj);
			result = query.delete(NAMESPACE + "yp_zcs_ipt2.delete_zcs_ipt2_month_rpt2_tag", jsonObj);
			break;
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int merge_zcs_ipt2_month_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【작업 저장】정비용역 > 비용처리 > 월보등록(작업)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		// 월보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【작업 저장】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.merge_zcs_ipt2_month_rpt2", jsonObj);
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int merge_zcs_ipt2_month_rpt2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【태그데이터 저장】정비용역 > 비용처리 > 월보등록(작업)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		// 월보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【태그데이터 저장】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.merge_zcs_ipt2_month_rpt2_tag", jsonObj);
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes"})
	@Override
	public HashMap<String, Object> select_zcs_ipt2_month_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【조회】정비용역 > 비용처리 > 월보등록(월정액)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		int cnt = query.selectOne(NAMESPACE + "yp_zcs_ipt2.pre_select_zcs_ipt2_month_rpt3", req_data);
		List<HashMap<String, String>> list1 = new ArrayList<HashMap<String, String>>();
		if (cnt > 0) {
			list1 = query.selectList(NAMESPACE + "yp_zcs_ipt2.select_zcs_ipt2_month_rpt3", req_data);
			data.put("list1", list1);
		} else {
			list1 = query.selectList(NAMESPACE + "yp_zcs_ipt2.select_zcs_ipt2_month_rpt3_new", req_data);
			data.put("list1", list1);
		}
		return data;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked", "unused"})
	@Transactional
	@Override
	public int delete_zcs_ipt2_month_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【삭제】정비용역 > 비용처리 > 월보등록(월정액)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		int cnt = 0;
		
		// 월보 삭제
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			logger.debug("【삭제】월보 삭제 데이터 확인 - {}", jsonObj);
			result = query.delete(NAMESPACE + "yp_zcs_ipt2.delete_zcs_ipt2_month_rpt3", jsonObj);
			break;
		}
		return result;
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	@Transactional
	@Override
	public int merge_zcs_ipt2_month_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【저장】정비용역 > 비용처리 > 월보등록(월정액)");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		
		// 월보 저장
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(req_data.get("ROW_NO").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			logger.debug("【저장】데이터 확인 - {}", jsonObj);
			jsonObj.put("s_emp_code", req_data.get("s_emp_code"));
			result += query.update(NAMESPACE + "yp_zcs_ipt2.merge_zcs_ipt2_month_rpt3", jsonObj);
		}
		return result;
	}
}
