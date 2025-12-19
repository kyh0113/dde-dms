package com.yp.common.srvc;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vicurus.it.core.common.Util;
import com.yp.common.srvc.intf.History;
import com.yp.fixture.srvc.YPFixtureServiceImpl;

@Service("FixtureMasterHistoryService")
public class FixtureHistoryService implements History {
	
	private static final Logger logger = LoggerFactory.getLogger(YPFixtureServiceImpl.class);

	private static String NAMESPACE;

	@Value("#{config['db.vendor']}")
	public void setNAMESPACE(String value) {
		this.NAMESPACE = value + ".";
	}

	@Autowired
	@Resource(name = "sqlSession")
	private SqlSession query;

	@Override
	@Transactional
	public void setHistory(String dispatcher, String state, Object obj) {
		
		if(obj instanceof JSONObject){
			JSONObject jsonObj = (JSONObject) obj;
			if("master".equals(dispatcher)){
				try {
					set_fixture_master_history(state, jsonObj);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}else if("stock".equals(dispatcher)){
				try {
					set_fixture_stock_history(state, jsonObj);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}else if(obj instanceof HashMap){
			HashMap map = (HashMap) obj;
			if("master".equals(dispatcher)){
				try {
					set_fixture_master_history(state, map);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}else if("stock".equals(dispatcher)){
				try {
					set_fixture_stock_history(state, map);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	private void set_fixture_master_history(String state, HashMap map) throws Exception {
		StringBuilder sb = new StringBuilder();
		logger.debug("[TEST]=====History시작=====");
		/**
		 * 생성
		 */
		if("C".equals(state)){
			sb.append("[생성]");
			sb.append(Util.isEmpty(map.get("FIXTURE_NAME").toString()) ? "" : map.get("FIXTURE_NAME").toString());
			sb.append("이(가) 생성 되었습니다.");
			map.put("STATE", "C");
		/**
		 * 수정
		 */
		}else if("U".equals(state)){
			/**
			 * 프로시저 내부에서 Select로 변경전 데이터를 가져와서 비교하므로
			 * Update 전에 Update될 Message를 받아온다.
			 */
			query.selectList(NAMESPACE + "yp_fixture.PROC_GET_F_M_MSG", map);
			
			sb.append(Util.isEmpty(map.get("RESULT")) ? "" : map.get("RESULT").toString());
			
			map.put("STATE", "U");
		/**
		 * 삭제
		 */
		}else if("D".equals(state)){
			sb.append("[삭제]");
			sb.append(Util.isEmpty(map.get("FIXTURE_NAME").toString()) ? "" : map.get("FIXTURE_NAME").toString());
			sb.append("이(가) 삭제 되었습니다.");
			map.put("STATE", "D");
		}
		
		map.put("HISTORY", sb.toString());
		logger.debug("[TEST]History:{}",sb.toString());
		query.insert(NAMESPACE + "yp_fixture.fixture_hist_insert", map);
	}
	
	private void set_fixture_master_history(String state, JSONObject jsonObj) throws Exception {
		StringBuilder sb = new StringBuilder();
		logger.debug("[TEST]=====History시작=====");
		/**
		 * 생성
		 */
		if("C".equals(state)){
			sb.append("[생성]");
			sb.append(Util.isEmpty(jsonObj.get("FIXTURE_NAME").toString()) ? "" : jsonObj.get("FIXTURE_NAME").toString());
			sb.append("이(가) 생성 되었습니다.");
			jsonObj.put("STATE", "C");
			/**
			 * 수정
			 */
		}else if("U".equals(state)){
			/**
			 * 프로시저 내부에서 Select로 변경전 데이터를 가져와서 비교하므로
			 * Update 전에 Update될 Message를 받아온다.
			 */
			query.selectList(NAMESPACE + "yp_fixture.PROC_GET_F_M_MSG", jsonObj);
			
			sb.append(Util.isEmpty(jsonObj.get("RESULT")) ? "" : jsonObj.get("RESULT").toString());
			
			jsonObj.put("STATE", "U");
			/**
			 * 삭제
			 */
		}else if("D".equals(state)){
			sb.append("[삭제]");
			sb.append(Util.isEmpty(jsonObj.get("FIXTURE_NAME").toString()) ? "" : jsonObj.get("FIXTURE_NAME").toString());
			sb.append("이(가) 삭제 되었습니다.");
			jsonObj.put("STATE", "D");
		}
		
		jsonObj.put("HISTORY", sb.toString());
		logger.debug("[TEST]History:{}",sb.toString());
		query.insert(NAMESPACE + "yp_fixture.fixture_hist_insert", jsonObj);
	}
	
	private void set_fixture_stock_history(String state, HashMap map) throws Exception {
		StringBuilder sb = new StringBuilder();
		logger.debug("[TEST]=====History시작=====");

		/**
		 * 생성
		 */
		if("C".equals(state)){
			sb.append("[생성]");
			sb.append(Util.isEmpty(map.get("FIXTURE_NAME").toString()) ? "" : map.get("FIXTURE_NAME").toString());
			sb.append("의 수량이 ");
			sb.append(Integer.parseInt(map.get("STOCK_AMOUNT").toString()));
			sb.append("개로 초기화 되었습니다.");
			map.put("STATE", "C");
		/**
		 * 수정
		 */
		}else if("U".equals(state)){
			sb.append("[수정]");
			sb.append(Util.isEmpty(map.get("FIXTURE_NAME").toString()) ? "" : map.get("FIXTURE_NAME").toString());
			sb.append("의 수량이 ");
			sb.append(Integer.parseInt(map.get("STOCK_AMOUNT").toString()));
			sb.append("개로 변경로 되었습니다.");
			map.put("STATE", "U");
		/**
		 * 삭제
		 */
		}else if("D".equals(state)){
			sb.append("[삭제]");
			sb.append(Util.isEmpty(map.get("FIXTURE_NAME").toString()) ? "" : map.get("FIXTURE_NAME").toString());
			sb.append("의 수량 데이터가 삭제 됐습니다. ");
			map.put("STATE", "D");
		}
		
		map.put("HISTORY", sb.toString());
		query.insert(NAMESPACE + "yp_fixture.fixture_hist_insert", map);
	}	
	
	private void set_fixture_stock_history(String state,JSONObject jsonObj) throws Exception {
		StringBuilder sb = new StringBuilder();
		logger.debug("[TEST]=====History시작=====");
		
		/**
		 * 생성
		 */
		if("C".equals(state)){
			sb.append("[생성]");
			sb.append(Util.isEmpty(jsonObj.get("FIXTURE_NAME").toString()) ? "" : jsonObj.get("FIXTURE_NAME").toString());
			sb.append("의 수량이 ");
			sb.append(Integer.parseInt(jsonObj.get("STOCK_AMOUNT").toString()));
			sb.append("개로 초기화 되었습니다.");
			jsonObj.put("STATE", "C");
			/**
			 * 수정
			 */
		}else if("U".equals(state)){
			sb.append("[수정]");
			sb.append(Util.isEmpty(jsonObj.get("FIXTURE_NAME").toString()) ? "" : jsonObj.get("FIXTURE_NAME").toString());
			sb.append("의 수량이 ");
			sb.append(Integer.parseInt(jsonObj.get("STOCK_AMOUNT").toString()));
			sb.append("개로 변경로 되었습니다.");
			jsonObj.put("STATE", "U");
			/**
			 * 삭제
			 */
		}else if("D".equals(state)){
			sb.append("[삭제]");
			sb.append(Util.isEmpty(jsonObj.get("FIXTURE_NAME").toString()) ? "" : jsonObj.get("FIXTURE_NAME").toString());
			sb.append("의 수량 데이터가 삭제 됐습니다. ");
			jsonObj.put("STATE", "D");
		}
		
		jsonObj.put("HISTORY", sb.toString());
		query.insert(NAMESPACE + "yp_fixture.fixture_hist_insert", jsonObj);
	}	

}
