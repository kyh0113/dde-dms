package com.vicurus.it.core.uigrid.srvc;

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
import com.vicurus.it.core.uigrid.srvc.intf.UiGridService;
import com.yp.zfi.bud.srvc.intf.YP_ZFI_BUD_Service;
import com.yp.zfi.doc.srvc.intf.YP_ZFI_DOC_Service;
import com.yp.zhr.tna.srvc.intf.YP_ZHR_TNA_Service;
import com.yp.zwc.ipt.srvc.intf.YP_ZWC_IPT_Service;
import com.yp.zwc.rst.srvc.intf.YP_ZWC_RST_Service;


@Repository
public class UiGridServiceImpl implements UiGridService{
	private static final Logger logger = LoggerFactory.getLogger(UiGridServiceImpl.class);
	
	//config.properties 에서 설정 정보 가져오기 시작
	private static String NAMESPACE;
			
	@SuppressWarnings("static-access")
	@Value("#{config['db.vendor']}")
	public void setNAMESPACE(String value) {
		this.NAMESPACE = value + ".";
	}
	//config.properties 에서 설정 정보 가져오기 끝
	
	@Autowired
	@Resource(name="sqlSession")
	private SqlSession query;
	
	@Autowired
	private YP_ZFI_DOC_Service zfi_doc_Service;
	
	@Autowired
	private YP_ZFI_BUD_Service zfi_bud_Service;
	
	@Autowired
	private YP_ZHR_TNA_Service zhr_tna_Service;
	
	@Autowired
	private YP_ZWC_IPT_Service zwc_ipt_Service;
	
	@Autowired
	private YP_ZWC_RST_Service zwc_rst_Service;
	
	@SuppressWarnings({"unchecked", "rawtypes"})
	@Override
	public Map gridLoad(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();
		Util util = new Util();
		
		Map paramMap = util.getParamToMap(request);
		int pageNumber = Integer.parseInt((String) paramMap.get("pageNumber"));
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int start = 0;
		int end = 0;
		boolean last = false;
		boolean first = true;
		if(pageNumber == 0){
			start = (pageNumber+1);
			end = pageSize;
		}else{
			start = (pageNumber)*pageSize+1;
			end = (pageNumber+1)*pageSize;
		}
		paramMap.put("start", start);
		paramMap.put("end", end);
		
		HashMap resultHashMap = new HashMap();
		List resultList = new ArrayList();
		Double totalCnt = 0d;
		
		long before = 0l;
		long after = 0l;
		double calc = 0d;
		
		logger.debug("EXEC_RFC : {}", paramMap.get("EXEC_RFC"));
		if("Y".equals(paramMap.get("EXEC_RFC"))) {
			logger.debug("RFC_TYPE : {}", paramMap.get("RFC_TYPE"));
			if("ZFI_DOC".equals(paramMap.get("RFC_TYPE"))) {
				before = System.currentTimeMillis();
				logger.debug("시작 : {}", before);

				// RFC 호출 > ArrayList<HashMap<String, String>>
				resultList = zfi_doc_Service.exec(request, response);
				totalCnt = new Double(resultList.size());
				
				after = System.currentTimeMillis();
				logger.debug("종료 : {}", after);
				
				calc = after - before;
				logger.info("소요시간 : {} 초", String.format("%,.3f", calc / 1000.0));
			}else if("ZFI_BUD".equals(paramMap.get("RFC_TYPE"))) {
				before = System.currentTimeMillis();
				logger.debug("시작 : {}", before);

				// RFC 호출 > ArrayList<HashMap<String, String>>
				resultHashMap = zfi_bud_Service.exec(request, response);
				resultList = (ArrayList) resultHashMap.get("list");
				totalCnt = new Double(resultList.size());
				
				resultMap.put("YP_RFC_CODE", resultHashMap.get("YP_RFC_CODE"));
				resultMap.put("YP_RFC_MSG", resultHashMap.get("YP_RFC_MSG"));
				
				after = System.currentTimeMillis();
				logger.debug("종료 : {}", after);
				
				calc = after - before;
				logger.info("소요시간 : {} 초", String.format("%,.3f", calc / 1000.0));
			}else if("ZHR_TNA".equals(paramMap.get("RFC_TYPE"))) {
				before = System.currentTimeMillis();
				logger.debug("시작 : {}", before);
				
				// RFC 호출 > ArrayList<HashMap<String, String>>
				resultHashMap = zhr_tna_Service.exec(request, response);
				resultList = (ArrayList) resultHashMap.get("list");
				totalCnt = new Double(resultList.size());
				
				resultMap.put("YP_RFC_CODE", resultHashMap.get("YP_RFC_CODE"));
				resultMap.put("YP_RFC_MSG", resultHashMap.get("YP_RFC_MSG"));
				
				after = System.currentTimeMillis();
				logger.debug("종료 : {}", after);
				
				calc = after - before;
				logger.info("소요시간 : {} 초", String.format("%,.3f", calc / 1000.0));
			}else if("ZWC_IPT".equals(paramMap.get("RFC_TYPE"))) {
				before = System.currentTimeMillis();
				logger.debug("시작 : {}", before);
				
				// RFC 호출 > ArrayList<HashMap<String, String>>
				resultHashMap = zwc_ipt_Service.exec(request, response);
				resultList = (ArrayList) resultHashMap.get("list");
				totalCnt = new Double(resultList.size());
				
				resultMap.put("YP_RFC_CODE", resultHashMap.get("YP_RFC_CODE"));
				resultMap.put("YP_RFC_MSG", resultHashMap.get("YP_RFC_MSG"));
				
				after = System.currentTimeMillis();
				logger.debug("종료 : {}", after);
				
				calc = after - before;
				logger.info("소요시간 : {} 초", String.format("%,.3f", calc / 1000.0));	
			}else if("ZWC_RST".equals(paramMap.get("RFC_TYPE"))) {
				before = System.currentTimeMillis();
				logger.debug("시작 : {}", before);
				
				// RFC 호출 > ArrayList<HashMap<String, String>>
				resultHashMap = zwc_rst_Service.exec(request, response);
				resultList = (ArrayList) resultHashMap.get("list");
				totalCnt = new Double(resultList.size());
				
				resultMap.put("YP_RFC_CODE", resultHashMap.get("YP_RFC_CODE"));
				resultMap.put("YP_RFC_MSG", resultHashMap.get("YP_RFC_MSG"));
				
				after = System.currentTimeMillis();
				logger.debug("종료 : {}", after);
				
				calc = after - before;
				logger.info("소요시간 : {} 초", String.format("%,.3f", calc / 1000.0));		
			}else {
				logger.error("존재하지 않는 RFC 타입");
			}
		}else {
			before = System.currentTimeMillis();
			logger.debug("시작 : {}", before);
			totalCnt = query.selectOne(NAMESPACE + (String) paramMap.get("cntQuery"), paramMap);
			after = System.currentTimeMillis();
			logger.debug("종료 : {}", after);
			calc = after - before;
			logger.info("소요시간 : {} 초", String.format("%,.3f", calc / 1000.0));
			
			logger.debug("시작 : {}", before);
			resultList = query.selectList(NAMESPACE + (String) paramMap.get("listQuery"), paramMap);
			after = System.currentTimeMillis();
			logger.debug("종료 : {}", after);
			calc = after - before;
			logger.info("소요시간 : {} 초", String.format("%,.3f", calc / 1000.0));
		}
		
		int totalPage = (int) Math.ceil(totalCnt/pageSize);
		if(pageNumber == 0){
			if(totalPage == 1){
				first = true;
				last = true;
			}else{
				first=true;
				last=false;
			}
		}else{
			if(pageNumber+1<totalPage){
				first = false;
				last = false;
			}else{
				first = false;
				last = true;
			}
		}
		
		resultMap.put("content", resultList); 			//data list
		resultMap.put("last", last);   				//마지막페이지인지
		resultMap.put("totalElements",totalCnt);    	//총데이터 갯수
		//resultMap.put("totalPages",2000);			//총 페이지 수 - 안보내도 ui-grid가 알아서 계산해서 뿌려줌
		resultMap.put("size",pageSize);				 	//페이지당 보여줄 데이터 로우
		//resultMap.put("number", null);			//페이지 번호 - 바뀌지않음....
		resultMap.put("sort", null);				//소트할 컬럼
		resultMap.put("first", first);				//첫페이지인지
		//resultMap.put("numberOfElements", null);	// ??
		
		return resultMap;
	}

}
