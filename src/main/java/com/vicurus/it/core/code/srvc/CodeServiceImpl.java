package com.vicurus.it.core.code.srvc;

import java.sql.SQLException;
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
import org.springframework.transaction.annotation.Transactional;

import com.vicurus.it.core.code.srvc.intf.CodeService;
import com.vicurus.it.core.common.Util;


@Repository
public class CodeServiceImpl implements CodeService {
	
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
	
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(CodeServiceImpl.class);
	
	@SuppressWarnings("rawtypes")
	@Override
	public List getCodeMasterList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List dataList = query.selectList(NAMESPACE+"Code.getCodeMasterList");
		return dataList;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getCodeMasterYN(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		paramMap.put("code", "SYS_A_001");							//사용유무 코드 하드코딩
		List dataList = query.selectList(NAMESPACE+"Code.getCodeMasterYN", paramMap);
		return dataList;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public Map getCodeMasterSelect(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		Map dataMap = query.selectOne(NAMESPACE+"Code.getCodeMasterSelect", paramMap);
		return dataMap;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map setCodeMasterMerge(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = query.update(NAMESPACE+"Code.setCodeMasterMerge", paramMap);
		Map returnMap = new HashMap();
		returnMap.put("result", result);
		return returnMap;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List getCodeDetailList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		List dataList = query.selectList(NAMESPACE+"Code.getCodeDetailList", paramMap);
		return dataList;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public Map getCodeDetailSelect(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		Map dataMap = query.selectOne(NAMESPACE+"Code.getCodeDetailSelect", paramMap);
		return dataMap;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map setCodeDetailMerge(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = query.update(NAMESPACE+"Code.setCodeDetailMerge", paramMap);
		Map dataMap = new HashMap();
		dataMap.put("result", result);
		return dataMap;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map selectMasterCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, false);
		HashMap returnMap = new HashMap();
		List<HashMap> list = new ArrayList();
		List modList = null;
		list = query.selectList(NAMESPACE+"Code.selectMasterCode", paramMap);
		returnMap.put("detail", list);
		return returnMap;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map selectDetailCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, false);
		HashMap returnMap = new HashMap();
		List<HashMap> list = new ArrayList();
		List modList = null;
		list = query.selectList(NAMESPACE+"Code.selectDetailCode", paramMap);
		returnMap.put("detail", list);
		return returnMap;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int deleteMasterCode(List paramList) throws SQLException {
		int paramListSize = paramList.size();
		int result = 0;
		for(int i = 0; i < paramListSize; i++){
			result += query.delete(NAMESPACE+"Code.deleteMasterCode1", paramList.get(i));	//상세코드 삭제
			result += query.delete(NAMESPACE+"Code.deleteMasterCode2", paramList.get(i));	//마스터코드 삭제
		}
		
		return result;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int deleteDetailCode(List paramList) throws SQLException {
		int paramListSize = paramList.size();
		int result = 0;
		for(int i = 0; i < paramListSize; i++){
			result += query.delete(NAMESPACE+"Code.deleteDetailCode", paramList.get(i));	//상세코드 삭제
		}
		
		return result;
	}

	

	
}
