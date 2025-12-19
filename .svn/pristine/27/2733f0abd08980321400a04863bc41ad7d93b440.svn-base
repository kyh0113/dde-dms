package com.yp.api.endpoint.srvc;

import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.ArrayList;
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

import com.vicurus.it.core.common.Util;
import com.yp.api.endpoint.srvc.intf.YPApiEndpointService;

@Repository
public class YPApiEndpointServiceImpl implements YPApiEndpointService {
	
	private static final Logger logger = LoggerFactory.getLogger(YPApiEndpointServiceImpl.class);

	private static String NAMESPACE;

	@Value("#{config['db.vendor']}")
	public void setNAMESPACE(String value) {
		this.NAMESPACE = value + ".";
	}

	@Autowired
	@Resource(name = "sqlSession")
	private SqlSession query;

	@Override
	public List<HashMap<String, Object>> select_daily_zinc_production(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map paramMap = new HashMap();
		query.selectList(NAMESPACE + "yp_api_endpoint.select_daily_zinc_production", paramMap);
		List<HashMap<String, Object>> list = (ArrayList) paramMap.get("RESULT");
		
		/**
		 * 구분생성
		 * 천단위 콤마표시
		 * 달성률 계산
		 */
		DecimalFormat df = new DecimalFormat("###,###");
		df.setRoundingMode(RoundingMode.HALF_UP);
		
		DecimalFormat dfRage = new DecimalFormat("###,###.#");
		dfRage.setRoundingMode(RoundingMode.HALF_UP);
		
		for(int i=0; i<list.size(); i++){
			Map item = list.get(i);
			double daily_plan = Double.parseDouble(Util.isEmpty(item.get("DAILY_PLAN")) ? "0" : item.get("DAILY_PLAN").toString());
			double daily_performance = Double.parseDouble(Util.isEmpty(item.get("DAILY_PERFORMANCE")) ? "0" : item.get("DAILY_PERFORMANCE").toString());
			double monthly_plan = Double.parseDouble(Util.isEmpty(item.get("MONTHLY_PLAN")) ? "0" : item.get("MONTHLY_PLAN").toString());
			double monthly_performance = Double.parseDouble(Util.isEmpty(item.get("MONTHLY_PERFORMANCE")) ? "0" : item.get("MONTHLY_PERFORMANCE").toString());
			
			double daily_achievement_rate = 0;
			double monthly_achievement_rate = 0;
			
			/**
			 * 일일 계획이 0 이라면, 일일 달성률도 0
			 * [아연 캐소드, 아연괴]
			 *  - 일일 계획이 0이라면, 일일 달성률은 0
			 * [정류기전력원단이, 1공장, 2공장]
			 *  - 일일 실적이 0이라면, 일일 달성률은 0
			 */
			//정류기 전력원 단위 계, 1/2공장
			if(i == 2 || i == 3 || i == 4){
				if(daily_performance == 0){
					daily_achievement_rate = 0;
				}else{
					daily_achievement_rate = daily_plan / daily_performance * 100;
				}
			//아연캐소드, 아연괴
			}else{
				if(daily_plan == 0){
					daily_achievement_rate = 0;
				}else{
					daily_achievement_rate = daily_performance / daily_plan * 100;
				}
				
			}
			
			/**
			 * 월 달성률은 아연캐소드, 아연괴만 있음.
			 * 월 계획이 0 이라면, 월 달성률도 0
			 */
			if(monthly_plan == 0){
				monthly_achievement_rate = 0;
			}else{
				monthly_achievement_rate = monthly_performance / monthly_plan * 100;
			}
			
			logger.debug("daily_plan : {}", daily_plan);
			logger.debug("daily_performance : {}", daily_performance);
			logger.debug("monthly_plan : {}", monthly_plan);
			logger.debug("monthly_performance : {}", monthly_performance);
			logger.debug("daily_achievement_rate : {}", daily_achievement_rate);
			logger.debug("monthly_achievement_rate : {}", monthly_achievement_rate);
			/**
			 * 구분 생성
			 */
			//아연 캐소드 
			if(i == 0){
				item.put("GUBUN", "아연 캐소드");
				
			//아연괴
			}else if(i == 1){
				item.put("GUBUN", "아연괴");
			//정류기 전력원단위
			}else if(i == 2){
				item.put("GUBUN", "정류기 전력원단위");
			//정류기 전력원단위 1공장
			}else if(i == 3){
				item.put("GUBUN", "1공장");
			//정류기 전력원단위 2공장
			}else if(i == 4){
				item.put("GUBUN", "2공장");
			}
			
			item.put("DAILY_PLAN", df.format(daily_plan));
			item.put("DAILY_PERFORMANCE", df.format(daily_performance));
			item.put("DAILY_ACHIEVEMENT_RATE", dfRage.format(daily_achievement_rate));
			
			item.put("MONTHLY_PLAN", df.format(monthly_plan));
			item.put("MONTHLY_PERFORMANCE", df.format(monthly_performance));
			item.put("MONTHLY_ACHIEVEMENT_RATE", dfRage.format(monthly_achievement_rate));
			
			
		}
		
		logger.debug("list : {}", list);
		
		return list;
	}

}
