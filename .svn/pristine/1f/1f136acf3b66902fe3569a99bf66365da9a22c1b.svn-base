package com.yp.fixture.srvc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.yp.common.srvc.FixtureHistoryService;
import com.yp.fixture.srvc.intf.YPFixtureService;

@Repository
public class YPFixtureServiceImpl implements YPFixtureService {
	
	private static final Logger logger = LoggerFactory.getLogger(YPFixtureServiceImpl.class);

	// config.properties 에서 설정 정보 가져오기 시작
	private static String NAMESPACE;

	@Value("#{config['db.vendor']}")
	public void setNAMESPACE(String value) {
		this.NAMESPACE = value + ".";
	}
	// config.properties 에서 설정 정보 가져오기 끝

	@Autowired
	@Resource(name = "sqlSession")
	private SqlSession query;
	
	@Autowired
	private FixtureHistoryService history;

	@Override
	public List<Object> fixture_list(HashMap paramMap) throws Exception {
		List<Object> resultList = query.selectList(NAMESPACE + "yp_fixture.pop_fixture_list");
		return resultList;
	}

	@Override
	public List<Object> fixture_req_list(HashMap paramMap) throws Exception {
		String[] codes = paramMap.get("CODES").toString().split(";");
		ArrayList<String> CODES =  new ArrayList<String>();
		for(String s:codes){
			CODES.add(s);
		}
		paramMap.put("CODES", CODES);
		
		List<Object> resultList = query.selectList(NAMESPACE + "yp_fixture.fixture_req_list", paramMap);
		return resultList;
	}

	@Override
	@Transactional
	public int fixture_req_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		logger.debug("[TEST]paramMap:{}",paramMap);
		
		String next_fixture_req_code = query.selectOne(NAMESPACE + "yp_fixture.get_next_fixture_req_code", paramMap);
		logger.debug("[TEST]next_fixture_req_code:{}",next_fixture_req_code);
		int chk_cnt = 0;
		int cnt = 0;
		
		/**
		 * COM_FIXTURE_REQ_MST Insert
		 */
		paramMap.put("FIXTURE_REQ_CODE", next_fixture_req_code);
		cnt += query.insert(NAMESPACE + "yp_fixture.fixture_req_mst_insert", paramMap);
		
		
		/**
		 * COM_FIXTURE_REQ_DTL Insert
		 */
		JSONParser jsonParse = new JSONParser();
		//Json(String) => JsonArray 변환
		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("table_data").toString());
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("FIXTURE_REQ_CODE", next_fixture_req_code);
			
			/**
			 * 요청수량과 재고수량에 따라 
			 * 내부에서 불출 요청수량, 발주 요청수량을 자동으로 계산
			 *	
			 *	1. 요청수량 > 재고수량
			 *	 - 불출 요청수량 = 재고수량
			 *	 - 발주 요청수량 = 요청수량 - 재고수량
			 *	
			 *	2. 요청수량 <= 재고수량 
			 *	 - 불출 요청수량 = 요청수량
			 */
			//재고수량 조회
			Map stockInfoMap = query.selectOne(NAMESPACE + "yp_fixture.get_fixture_stock_amount", jsonObj);
			logger.debug("[TEST]stockInfoMap:{}", stockInfoMap);
			int stockAmount = Integer.parseInt(stockInfoMap.get("STOCK_AMOUNT").toString());
			int availableStockAmout = Integer.parseInt(stockInfoMap.get("AVAILABLE_STOCK_AMOUNT").toString());
			
			int reqAmount = Integer.parseInt(jsonObj.get("REQ_AMOUNT").toString());
			int dispenseReqAmount = 0;
			int purchaseReqAmount = 0;

			//발주 및 불출 요청수량 계산
			if(reqAmount > availableStockAmout){
				dispenseReqAmount = availableStockAmout;
				purchaseReqAmount = reqAmount - availableStockAmout;
			}else{
				dispenseReqAmount = reqAmount;
			}
			
			jsonObj.put("DISPENSE_REQ_AMOUNT", dispenseReqAmount);
			jsonObj.put("PURCHASE_REQ_AMOUNT", purchaseReqAmount);
			
			cnt += query.insert(NAMESPACE + "yp_fixture.fixture_req_dtl_insert", jsonObj);
			
		}
		
		return cnt;
	}

	@Override
	@Transactional
	public int fixture_edoc_status_update(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> parseMap = new HashMap<String, Object>();
		logger.debug("[TEST]paramMap:{}", paramMap);
		String[] codes = paramMap.get("CODES").toString().split(";");
		ArrayList<String> CODES =  new ArrayList<String>();
		for(String s:codes){
			CODES.add(s);
		}
		
		String edocStatus = paramMap.get("EDOC_STATUS") == null ? "" : paramMap.get("EDOC_STATUS").toString();
		
		parseMap.put("EDOC_NO", paramMap.get("EDOC_NO"));
		parseMap.put("EDOC_STATUS", edocStatus);
		parseMap.put("CODES", CODES);
		
		int cnt = 0;
		
		/**
		 * 요청상태에 대한 정보
		 * U : 발주미완료
		 * I : 발주중
		 * E : 구매완료
		 * 결재완료 경우엔, req_status 수정
		 */
		if("F".equals(edocStatus) || "S".equals(edocStatus) || "E".equals(edocStatus)){
			parseMap.put("REQ_STATUS", "U");
		}else{
			parseMap.put("REQ_STATUS", null);
		}
		parseMap.put("REQ_STATUS","U");
		cnt += query.update(NAMESPACE + "yp_fixture.fixture_req_dtl_req_status_update", parseMap);
		cnt += query.update(NAMESPACE + "yp_fixture.fixture_req_dtl_edoc_update", parseMap);
		
		return cnt;
	}

	@Override
	public boolean is_available_edoc_approval(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		//Json(String) => JsonObject 변환
		JSONParser jsonParse = new JSONParser();
		JSONObject jsonObj = (JSONObject) jsonParse.parse(paramMap.get("row").toString());
		
		Map edocStatusInfoMap = query.selectOne(NAMESPACE + "yp_fixture.is_available_edoc_approval", jsonObj);
		String edocStatus = edocStatusInfoMap.get("edoc_status") == null ? "" : edocStatusInfoMap.get("edoc_status").toString();
		
		/**
		 * [전자결재 상태표]
		 * A : SAP에서 작성완료  => X
		 * 0 : 결재진행중 => 결재중
		 * 4 : 결재진행중 => X
		 * 5 : 반려상태 => 반려
		 * 7 : 결재상신을 취소한 상태 => 회수
		 * F : 수신결재완료 => 완료
		 * D : 사용자에의한 삭제 => 삭제
		 * U : 수신결재완료 => X
		 * J : 수신결재반려후 반송 => X
		 * E : 내부결재종료 => 완료
		 * R : 수신접수 => X
		 * S : 내부결재완료 => 완료
		 * C : 완전삭제 => X
		 */
		if(util.isEmpty(edocStatus)){
			return true;
		}else if("5".equals(edocStatus)){
			return true;
		}else{
			return false;
		}
	}

	@Override
	public List<Object> fixture_req_pop_list(Map paramMap) throws Exception {
		List<Object> resultList = query.selectList(NAMESPACE + "yp_fixture.pop_fixture_req_list", paramMap);
		return resultList;
	}

	@Override
	public List<Object> fixture_req_pop_xls_list(Map parseMap) throws Exception {
		List<Object> resultList = query.selectList(NAMESPACE + "yp_fixture.pop_fixture_req_list", parseMap);
		return resultList;
	}

	@Override
	public boolean fixture_is_availalbe_purchase_req(Map paramMap) throws Exception {
		return query.selectOne(NAMESPACE + "yp_fixture.fixture_is_availalbe_purchase_req", paramMap);
	}

	@Override
	public int fixture_req_purchase(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		logger.debug("[TEST]paramMap:{}",paramMap);
		
		String codes = paramMap.get("codes") == null ? "" : paramMap.get("codes").toString();
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(codes);
		
		paramMap.put("CODES", jsonArr);
		
		int cnt = 0;
		
		/**
		 * 비품 요청 상태 진행 상태 Update
		 * U : 미완료
		 * I : 발주중
		 * E : 구매완료
		 */
		paramMap.put("REQ_STATUS", "I");
		cnt += query.insert(NAMESPACE + "yp_fixture.fixture_req_dtl_req_status_update", paramMap);
		
		return cnt;
	}

	@Override
	public boolean fixture_is_availalbe_finish_purchase(Map paramMap) throws Exception {
		logger.debug("[TEST]paramMap:{}",paramMap);
		return query.selectOne(NAMESPACE + "yp_fixture.fixture_is_availalbe_finish_purchase", paramMap);
	}

	@Override
	@Transactional
	public int fixture_req_purchase_finish(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		logger.debug("[TEST]paramMap:{}",paramMap);
		
		String codes = paramMap.get("codes") == null ? "" : paramMap.get("codes").toString();
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(codes);
		
		paramMap.put("CODES", jsonArr);
		
		int cnt = 0;
		
		/**
		 * 비품 요청 상태 진행 상태 Update
		 * U : 미완료
		 * I : 발주중
		 * E : 구매완료
		 */
		paramMap.put("REQ_STATUS", "E");
		cnt += query.update(NAMESPACE + "yp_fixture.fixture_req_dtl_req_status_update", paramMap);
		
		/**
		 * 재고수량을 없앨 업데이트할 데이터를 가져온다.
		 */
		List<Map> updateDataList = query.selectList(NAMESPACE + "yp_fixture.fixture_get_update_date", paramMap);
		for(Map updataDataMap : updateDataList){
			logger.debug("[TEST]updataDataMap:{}",updataDataMap);
			/**
			 * 재고수량을 업데이트 한다.
			 */
			cnt += query.update(NAMESPACE + "yp_fixture.fixture_stock_update", updataDataMap);
		}
		
		return cnt;
	}

	@Override
	@Transactional
	public int fixture_master_save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		logger.debug("[TEST]paramMap: {}", paramMap);
		
		int cnt = 0;
		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("grid_data").toString());
		
		logger.debug("[TEST]jsonArr: {}", jsonArr);
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("s_emp_code", paramMap.get("s_emp_code"));
			String rowStatus = jsonObj.get("ROW_STATUS").toString();
			logger.debug("[TEST]rowStatus: {}", rowStatus);
			
			/**
			 * 생성
			 */
			if("C".equals(rowStatus)){
				/**
				 * 마스터 데이터 추가
				 */
				query.insert(NAMESPACE + "yp_fixture.fixture_master_insert", jsonObj);
				
				/**
				 * [History] 마스터 데이터 생성 이력
				 */
				history.setHistory("master", "C", jsonObj);
				
				/**
				 * 재고수량 처리
				 */
				sotck_amount_dispose(jsonObj);
				
			/**
			 * 수정
			 */
			}else if("U".equals(rowStatus)){
				/**
				 * [History] 마스터 데이터 수정 이력
				 */
				history.setHistory("master", "U", jsonObj);
				
				/**
				 * 마스터 데이터 수정
				 */
				query.update(NAMESPACE + "yp_fixture.fixture_master_update", jsonObj);
				
				
				/**
				 * 재고수량 처리
				 */
				sotck_amount_dispose(jsonObj);
				
			/**
			 * 삭제
			 */
			}else if("D".equals(rowStatus)){
				/**
				 * 재고수량 및 마스터 데이터 삭제
				 */
				query.delete(NAMESPACE + "yp_fixture.fixture_stock_delete", jsonObj);
				/**
				 * [History] 마스터 데이터 삭제 이력
				 */
				history.setHistory("master", "D", jsonObj);
				
				query.delete(NAMESPACE + "yp_fixture.fixture_master_delete", jsonObj);
				/**
				 * [History] 재고수량 삭제 이력
				 */
				history.setHistory("stock", "D", jsonObj);
			}
			
			cnt ++;
		}
		
		return cnt;
	}
	
	@Override
	public List<Map<String, Object>> fixture_master_key_list() throws Exception {
		List<Map<String, Object>> resultList = query.selectList(NAMESPACE + "yp_fixture.fixture_master_key_list");
		return resultList;
	}
	
	@Transactional
	private void sotck_amount_dispose(JSONObject jsonObj){
		Boolean is_exist = query.selectOne(NAMESPACE + "yp_fixture.is_exist_fixture_stock_data", jsonObj);
		/**
		 * 재고수량 데이터 자체가 없을 경우 추가
		 * 재고수량 데이터 자체가 있을 경우 수정
		 */
		if(is_exist){
			/**
			 * 재고수량을 변경할게 있다면 업데이트
			 * 재고수량이 전과 같다면 그냥 패스
			 * 
			 * 마스터 데이터와 재고수량 데이터가 묶여서 추가,수정,삭제를 일괄 처리 하다보니
			 * 재고수량이 변했는지 변하지 않았는지 판단을 해줘야함.
			 */
			Map fixtureStockMap = query.selectOne(NAMESPACE + "yp_fixture.fixture_stock_single", jsonObj);
			int beforeStockAmount = Integer.parseInt(fixtureStockMap.get("STOCK_AMOUNT").toString());
			int changeStockAmount = Util.isEmpty(jsonObj.get("STOCK_AMOUNT")) ? 0 : Integer.parseInt(jsonObj.get("STOCK_AMOUNT").toString());
			
			
			if(beforeStockAmount != changeStockAmount){
				query.update(NAMESPACE + "yp_fixture.fixture_stock_update_plain", jsonObj);
				history.setHistory("stock", "U", jsonObj);
			}
		}else{
			query.insert(NAMESPACE + "yp_fixture.fixture_stock_insert", jsonObj);
			history.setHistory("stock", "C", jsonObj);
		}
	}
}
