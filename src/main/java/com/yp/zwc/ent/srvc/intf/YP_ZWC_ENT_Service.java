package com.yp.zwc.ent.srvc.intf;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YP_ZWC_ENT_Service {

	/* 업체 존재 체크 */
	public int retrieveEntCnt(HashMap paramMap) throws Exception;
	
	/* 업체 목록 */
	public ArrayList<HashMap<String, String>> enterpriseList(HashMap paramMap) throws Exception;
	
	/* 업체 등록 */
	public int createEnt(HashMap paramMap) throws Exception;
	
	/* 업체 수정 */
	public int updateEnt(HashMap paramMap) throws Exception;
	public int updateEnt_reset_pwd(HashMap paramMap) throws Exception;
	
	/* 출입인원 목록 */
	public ArrayList<HashMap<String, String>> accesscontrolList(HashMap paramMap) throws Exception;
	
	/* 협력업체 코드 리스트 */
	public ArrayList<HashMap<String, String>> enterpriseCodeList(HashMap paramMap) throws Exception;
	
	/* 출입인원 중복체크 */
	public boolean retrieveSubcByCode(String subc_code) throws Exception;
	
	/* 출입인원 등록 */
	public int createAccessControl(HashMap<String, Object> req_data) throws Exception;
	
	/* 출입금지 인원 체크*/
	public int noEntryCheck(HashMap<String, Object> req_data) throws Exception;
	
	/* 출입코드생성 */
	public String createSubcCode(HashMap<String, Object> req_data) throws Exception;
	
	/* 출입관리인원 상세 */
	public ArrayList<HashMap<String, String>> accessControlDetail(String seq) throws Exception;
	
	/* 출입인원 수정 */
	public int updateAccessControl(HashMap<String, Object> req_data) throws Exception;
	
	/* 출입인원 삭제 */
	public int deleteAccessControl(HashMap<String, Object> req_data) throws Exception;
	
	/* 협력사 콤보 */
	@SuppressWarnings("rawtypes")
	public List cb_ent_list(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
