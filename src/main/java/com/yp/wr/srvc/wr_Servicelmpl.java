package com.yp.wr.srvc;

import com.vicurus.it.core.common.Util;
import com.yp.wr.srvc.intf.wr_Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

@Repository
public class wr_Servicelmpl implements wr_Service {
  private static final Logger logger = LoggerFactory.getLogger(com.yp.wr.srvc.wr_Servicelmpl.class);
  
  private static String NAMESPACE;
  
  @Autowired
  @Resource(name = "sqlSession")
  private SqlSession query;
  
  public Map create_wr_write(HttpServletRequest request, HttpServletResponse response) throws Exception {
    Util util = new Util();
    Map paramMap = util.getParamToMap(request, false);
    int result = this.query.insert(String.valueOf(NAMESPACE) + "yp_wr.wr_report_insert", paramMap);
    Map<Object, Object> returnMap = new HashMap<>();
    returnMap.put("result", Integer.valueOf(result));
    return returnMap;
  }
  
  @Value("#{config['db.vendor']}")
  public void setNAMESPACE(String value) {
    NAMESPACE = String.valueOf(value) + ".";
  }
  
  public int wr_write_insert(HttpServletRequest request, HttpServletResponse response) throws Exception {
    Util util = new Util();
    HashMap req_data = (HashMap)util.getParamToMap(request, false);
    HttpSession session = request.getSession();
    int result = 0;
    int cnt = 0;
    result = this.query.update(String.valueOf(NAMESPACE) + "yp_wr.wr_report_insert", req_data);
    logger.debug("{result}", req_data);
    return result;
  }
  
  
  
//처리서작성
  public HashMap wr_final_insert(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    Util util = new Util();
	    HashMap req_data = (HashMap)util.getParamToMap(request, false);
	    HttpSession session = request.getSession();
	    int result = 0;
	    int cnt = 0;
	    HashMap<String, Object> data = new HashMap<String, Object>();
   
	    Calendar cal = Calendar.getInstance();
        String today = new SimpleDateFormat("yyyyMMdd").format(cal.getTime());
		String day = StringUtils.replace(today, "/", "");
		
	    result = this.query.update(String.valueOf(NAMESPACE) + "yp_wr.wr_final_insert", req_data);
	    
	    result = this.query.update(String.valueOf(NAMESPACE) + "yp_wr.wr_final_list_update", req_data);

	    logger.debug("{출력}", data);
	    return data;
	  }
//처리서작성
  
//보고서작성
public HashMap wr_report_insert(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    Util util = new Util();
	    HashMap req_data = (HashMap)util.getParamToMap(request, false);
	    HttpSession session = request.getSession();
	    int result = 0;
	    int cnt = 0;
	    HashMap<String, Object> data = new HashMap<String, Object>();
 
	    Calendar cal = Calendar.getInstance();
      String today = new SimpleDateFormat("yyyyMMdd").format(cal.getTime());
		String day = StringUtils.replace(today, "/", "");
		
		req_data.put("today", day);
		req_data.put("userDeptCd", (String) session.getAttribute("userDeptCd"));
		req_data.put("empCode", (String) session.getAttribute("empCode"));
		

		//logger.debug("{day}", req_data);
		
	    result = this.query.update(String.valueOf(NAMESPACE) + "yp_wr.wr_report_insert", req_data);
	    
	    result = this.query.update(String.valueOf(NAMESPACE) + "yp_wr.wr_report_list_update", req_data);

	    //result.put(1, day+(String) session.getAttribute("userDeptCd")+(String) session.getAttribute("empCode")+data.get("WR_CD"));
	    //data.put("WR_CD", "12345");

	    logger.debug("{출력}", data);
	    return data;
	  }
//보고서작성 

//의뢰서팝업작성
public HashMap wr_writepop_insert(HttpServletRequest request, HttpServletResponse response) throws Exception {
    Util util = new Util();
    HashMap req_data = (HashMap)util.getParamToMap(request, false);
    HttpSession session = request.getSession();
    int result = 0;
    int cnt = 0;
    HashMap<String, Object> data = new HashMap<String, Object>();

    Calendar cal = Calendar.getInstance();
    String today = new SimpleDateFormat("yyyyMMdd").format(cal.getTime());
	String day = StringUtils.replace(today, "/", "");
	
	req_data.put("today", day);
	req_data.put("userDeptCd", (String) session.getAttribute("userDeptCd"));
	req_data.put("empCode", (String) session.getAttribute("empCode"));
	
	req_data.put("wr_codes", day+(String) session.getAttribute("userDeptCd")+(String) session.getAttribute("empCode"));
	
	//logger.debug("{day}", req_data);
	
	data = query.selectOne(NAMESPACE + "yp_wr.wr_req_get", req_data);
	data.put("wr_codes", day+(String) session.getAttribute("userDeptCd")+(String) session.getAttribute("empCode"));
	req_data.put("wr_codes", day+(String) session.getAttribute("userDeptCd")+(String) session.getAttribute("empCode")+data.get("WR_CD"));
	
    result = this.query.update(String.valueOf(NAMESPACE) + "yp_wr.wr_writepop_insert", req_data);
    
    result = this.query.update(String.valueOf(NAMESPACE) + "yp_wr.wr_writepop_insert2", req_data);

    //result.put(1, day+(String) session.getAttribute("userDeptCd")+(String) session.getAttribute("empCode")+data.get("WR_CD"));
    //data.put("WR_CD", "12345");

    logger.debug("{출력}", data);
    return data;
}
//의뢰서팝업작성


//자체처리보고서팝업작성
public HashMap wr_reportinpop_insert(HttpServletRequest request, HttpServletResponse response) throws Exception {
  Util util = new Util();
  HashMap req_data = (HashMap)util.getParamToMap(request, false);
  HttpSession session = request.getSession();
  int result = 0;
  int cnt = 0;
  HashMap<String, Object> data = new HashMap<String, Object>();

  Calendar cal = Calendar.getInstance();
  String today = new SimpleDateFormat("yyyyMMdd").format(cal.getTime());
	String day = StringUtils.replace(today, "/", "");
	
	req_data.put("today", day);
	req_data.put("userDeptCd", (String) session.getAttribute("userDeptCd"));
	req_data.put("empCode", (String) session.getAttribute("empCode"));
	
	req_data.put("wr_codes", day+(String) session.getAttribute("userDeptCd")+(String) session.getAttribute("empCode"));
	
	//logger.debug("{day}", req_data);
	
	data = query.selectOne(NAMESPACE + "yp_wr.wr_req_get", req_data);
	data.put("wr_codes", day+(String) session.getAttribute("userDeptCd")+(String) session.getAttribute("empCode"));
	req_data.put("wr_codes", day+(String) session.getAttribute("userDeptCd")+(String) session.getAttribute("empCode")+data.get("WR_CD"));

  //보고서테이블
  result = this.query.update(String.valueOf(NAMESPACE) + "yp_wr.wr_report_insert", req_data);
  
  //메인테이블
  result = this.query.update(String.valueOf(NAMESPACE) + "yp_wr.wr_writepop_insert2", req_data);

  //result.put(1, day+(String) session.getAttribute("userDeptCd")+(String) session.getAttribute("empCode")+data.get("WR_CD"));
  //data.put("WR_CD", "12345");

  logger.debug("{출력}", data);
  return data;
}
//자체처리보고서팝업작성

  
  public List<Object> wr_report(HashMap paramMap) throws Exception {
    return null;
  }
  
  
  
  @Override
	public List<Object> wr_req_list(HashMap paramMap) throws Exception {
		String[] wr_codes = paramMap.get("WR_CODES").toString().split(";");
		ArrayList<String> WR_CODES =  new ArrayList<String>();
		for(String s:wr_codes){
			WR_CODES.add(s);
		}
		paramMap.put("WR_CODES", WR_CODES);
		
		List<Object> resultList = query.selectList(NAMESPACE + "yp_wr.wr_req_list", paramMap);
		return resultList;
	}
  
  @Override
	public List<Object> wr_req_list_D(HashMap paramMap) throws Exception {
		String[] wr_codes = paramMap.get("WR_CODES").toString().split(";");
		ArrayList<String> WR_CODES =  new ArrayList<String>();
		for(String s:wr_codes){
			WR_CODES.add(s);
		}
		paramMap.put("WR_CODES", WR_CODES);
		
		List<Object> resultList = query.selectList(NAMESPACE + "yp_wr.wr_req_list_D", paramMap);
		return resultList;
	}
  
  @Override
	public List<Object> wr_req_list_A(HashMap paramMap) throws Exception {
		String[] wr_codes = paramMap.get("WR_CODES").toString().split(";");
		ArrayList<String> WR_CODES =  new ArrayList<String>();
		for(String s:wr_codes){
			WR_CODES.add(s);
		}
		paramMap.put("WR_CODES", WR_CODES);
		
		List<Object> resultList = query.selectList(NAMESPACE + "yp_wr.wr_req_list_A", paramMap);
		return resultList;
	}
  
  @Override
	public List<Object> wr_req_list_E(HashMap paramMap) throws Exception {
		String[] wr_codes = paramMap.get("WR_CODES").toString().split(";");
		ArrayList<String> WR_CODES =  new ArrayList<String>();
		for(String s:wr_codes){
			WR_CODES.add(s);
		}
		paramMap.put("WR_CODES", WR_CODES);
		
		List<Object> resultList = query.selectList(NAMESPACE + "yp_wr.wr_req_list_E", paramMap);
		return resultList;
	}
  
  @Override
	public List<Object> wr_req_list_B(HashMap paramMap) throws Exception {
		String[] wr_codes = paramMap.get("WR_CODES").toString().split(";");
		ArrayList<String> WR_CODES =  new ArrayList<String>();
		for(String s:wr_codes){
			WR_CODES.add(s);
		}
		paramMap.put("WR_CODES", WR_CODES);
		
		List<Object> resultList = query.selectList(NAMESPACE + "yp_wr.wr_req_list_B", paramMap);
		return resultList;
	}
  

  
  @Override
	@Transactional
	public int wr_edoc_status_update(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> parseMap = new HashMap<String, Object>();
		logger.debug("[TEST]paramMap:{}", paramMap);
		String[] wr_codes = paramMap.get("WR_CODES").toString().split(";");
		ArrayList<String> WR_CODES =  new ArrayList<String>();
		for(String s:wr_codes){
			WR_CODES.add(s);
		}
		
		String edocStatus = paramMap.get("EDOC_STATUS") == null ? "" : paramMap.get("EDOC_STATUS").toString();
		
		parseMap.put("EDOC_NO", paramMap.get("EDOC_NO"));
		parseMap.put("EDOC_STATUS", edocStatus);
		parseMap.put("WR_CODES", WR_CODES);
		
		int cnt = 0;

		cnt += query.update(NAMESPACE + "yp_wr.wr_req_dtl_edoc_update", parseMap);
	
		
		return cnt;
	}
  
  @Override
	@Transactional
	public int wr_edoc_status_update_report(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> parseMap = new HashMap<String, Object>();
		logger.debug("[TEST]paramMap:{}", paramMap);
		String[] wr_codes = paramMap.get("WR_CODES").toString().split(";");
		ArrayList<String> WR_CODES =  new ArrayList<String>();
		for(String s:wr_codes){
			WR_CODES.add(s);
		}
		
		String edocStatus = paramMap.get("EDOC_STATUS_R") == null ? "" : paramMap.get("EDOC_STATUS_R").toString();
		
		parseMap.put("EDOC_NO_R", paramMap.get("EDOC_NO_R"));
		parseMap.put("EDOC_STATUS_R", edocStatus);
		parseMap.put("WR_CODES", WR_CODES);
		
		int cnt = 0;

		cnt += query.update(NAMESPACE + "yp_wr.wr_req_dtl_edoc_update_report", parseMap);
		
		return cnt;
	}
  
  @Override
	@Transactional
	public int wr_edoc_status_update_final(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HashMap<String, Object> parseMap = new HashMap<String, Object>();
		logger.debug("[TEST]paramMap:{}", paramMap);
		String[] wr_codes = paramMap.get("WR_CODES").toString().split(";");
		ArrayList<String> WR_CODES =  new ArrayList<String>();
		for(String s:wr_codes){
			WR_CODES.add(s);
		}
		
		String edocStatus = paramMap.get("EDOC_STATUS_F") == null ? "" : paramMap.get("EDOC_STATUS_F").toString();
		
		parseMap.put("EDOC_NO_F", paramMap.get("EDOC_NO_F"));
		parseMap.put("EDOC_STATUS_F", edocStatus);
		parseMap.put("WR_CODES", WR_CODES);
		
		int cnt = 0;

		cnt += query.update(NAMESPACE + "yp_wr.wr_req_dtl_edoc_update_final", parseMap);
		
		return cnt;
	}
  
  
  
  @Override
	public List<Object> wr_report_pop(Map paramMap) throws Exception {
		List<Object> resultList = query.selectList(NAMESPACE + "yp_wr.wr_report_pop", paramMap);
		return resultList;
	}

}


	


