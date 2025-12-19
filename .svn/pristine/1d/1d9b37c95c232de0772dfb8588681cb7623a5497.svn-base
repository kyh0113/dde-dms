package com.vicurus.it.biz.board.srvc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import com.vicurus.it.core.common.Util;
import com.vicurus.it.biz.board.cntr.BoardController;
import com.vicurus.it.biz.board.srvc.intf.BoardService;

@Repository
public class BoardServiceImpl implements BoardService {

	private static final Logger logger = LoggerFactory.getLogger(BoardServiceImpl.class);

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

	@Override
	public Map boardGetAttachNo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		Map resultMap = query.selectOne(NAMESPACE + "biz_board.board_get_attach_no", paramMap);
		return resultMap;
	}

	@Override
	public int board_insert(HttpServletRequest request, Map paramMap) throws Exception {
		// popup_yn이 'Y'인 행을 'N'으로 update한다
		if ("Y".equals(paramMap.get("popup_yn"))) {
			query.update(NAMESPACE + "biz_board.board_update_popupY", paramMap);
		}
		// 작성한 form데이터로 insert한다
		int result = query.insert(NAMESPACE + "biz_board.board_insert", paramMap);
		return result;
	}

	@Override
	public Map board_view(HttpServletRequest request) throws Exception {

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();

		// ----------------gridData뽑아내기----------------------------------------------------
		JSONParser jsonParse = new JSONParser();
		JSONObject jsonObj = (JSONObject) jsonParse.parse(paramMap.get("gridData").toString());

		jsonObj.put("emp_cd", (String) session.getAttribute("empCode"));// 등록자 사번
		logger.debug("{}", jsonObj);
		// ----------------------------------------------------------------------------------

		// 조회수 증가
		query.update(NAMESPACE + "biz_board.board_cnt_up", jsonObj);

		// 상세데이터
		Map resultMap = query.selectOne(NAMESPACE + "biz_board.board_select", jsonObj);

		return resultMap;
	}

	@Override
	public int board_update(HttpServletRequest request, Map paramMap) throws Exception {
		HttpSession session = request.getSession();
		paramMap.put("emp_cd", (String) session.getAttribute("empCode"));// 등록자 사번
		
		// popup_yn이 'Y'인 행을 'N'으로 update한다
		if ("Y".equals(paramMap.get("update_popup_yn"))) {
			query.update(NAMESPACE + "biz_board.board_update_popupY", paramMap);
		}
		// 작성한 form데이터로 update한다
		int result = query.update(NAMESPACE + "biz_board.board_update", paramMap);
		return result;
	}

	@Override
	public int board_delete(HttpServletRequest request) throws Exception {
		int result = 0;

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();

		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("gridData").toString());

		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("emp_cd", (String) session.getAttribute("empCode"));// 등록자 사번
			logger.debug("{}", jsonObj);
			result = query.delete(NAMESPACE + "biz_board.board_delete", jsonObj);
			result = query.delete(NAMESPACE + "biz_board.board_attach_delete", jsonObj);
		}

		return result;
	}

	@Override
	public Map popupYList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map resultMap = query.selectOne(NAMESPACE + "biz_board.popupData");
		return resultMap;
	}

	@Override
	public int popupChk(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int result = query.selectOne(NAMESPACE + "biz_board.popupChk");
		return result;
	}

	@Override
	public List<Map> board_select(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Map> resultList = query.selectList(NAMESPACE + "biz_board.board_list_select");
		return resultList;
	}

	@Override
	public Map board_view_main(HttpServletRequest request) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();

		paramMap.put("emp_cd", (String) session.getAttribute("empCode"));// 등록자 사번
		logger.debug("{}", paramMap);
		// ----------------------------------------------------------------------------------

		// 조회수 증가
		query.update(NAMESPACE + "biz_board.board_cnt_up", paramMap);

		// 상세데이터
		Map resultMap = query.selectOne(NAMESPACE + "biz_board.board_select", paramMap);

		return resultMap;
	}

	@Override
	public List<Map> board_view_file_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<Map> resultList = query.selectList(NAMESPACE + "biz_board.board_view_file_list", request.getAttribute("attach_no"));
		return resultList;
	}
	
	@Override
	public int board_insert2(HttpServletRequest request, Map paramMap) throws Exception {
		// popup_yn이 'Y'인 행을 'N'으로 update한다
		//if ("Y".equals(paramMap.get("popup_yn"))) {
		//	query.update(NAMESPACE + "biz_board.board_update_popupY", paramMap);
		//}
		// 작성한 form데이터로 insert한다
		int result = query.insert(NAMESPACE + "biz_board.board_insert2", paramMap);
		return result;
	}

	@Override
	public int board_delete2(HttpServletRequest request) throws Exception {
		int result = 0;

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();

		JSONParser jsonParse = new JSONParser();
		JSONArray jsonArr = (JSONArray) jsonParse.parse(paramMap.get("gridData").toString());

		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArr.get(i);
			jsonObj.put("emp_cd", (String) session.getAttribute("empCode"));// 등록자 사번
			logger.debug("{}", jsonObj);
			result = query.delete(NAMESPACE + "biz_board.board_delete2", jsonObj);
			result = query.delete(NAMESPACE + "biz_board.board_attach_delete", jsonObj);
		}

		return result;
	}

	@Override
	public Map board_view2(HttpServletRequest request) throws Exception {

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		HttpSession session = request.getSession();

		// ----------------gridData뽑아내기----------------------------------------------------
		JSONParser jsonParse = new JSONParser();
		JSONObject jsonObj = (JSONObject) jsonParse.parse(paramMap.get("gridData").toString());

		jsonObj.put("emp_cd", (String) session.getAttribute("empCode"));// 등록자 사번
		logger.debug("{}", jsonObj);
		// ----------------------------------------------------------------------------------

		// 조회수 증가
		query.update(NAMESPACE + "biz_board.board_cnt_up2", jsonObj);

		// 상세데이터
		Map resultMap = query.selectOne(NAMESPACE + "biz_board.board_select2", jsonObj);

		return resultMap;
	}
	
	@Override
	public int board_update2(HttpServletRequest request, Map paramMap) throws Exception {
		// popup_yn이 'Y'인 행을 'N'으로 update한다
		//if ("Y".equals(paramMap.get("update_popup_yn"))) {
		//	query.update(NAMESPACE + "biz_board.board_update_popupY", paramMap);
		//}
		// 작성한 form데이터로 update한다
		HttpSession session = request.getSession();
		paramMap.put("emp_cd", (String) session.getAttribute("empCode"));// 등록자 사번
		int result = query.update(NAMESPACE + "biz_board.board_update2", paramMap);
		return result;
	}

	@Override
	public int insert_comment(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();
		paramMap.put("s_emp_cd", (String) session.getAttribute("empCode"));// 등록자 사번
		
		int result = query.insert(NAMESPACE + "biz_board.insert_comment", paramMap);
		
		return result;
	}

	@Override
	public List<HashMap<String, Object>> board_comment_select2(HttpServletRequest request, HttpServletResponse response)throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();
		paramMap.put("s_emp_cd", (String) session.getAttribute("empCode"));// 등록자 사번
		
		List list = query.selectList(NAMESPACE+"biz_board.board_comment_select2", paramMap);
		
		return list;
	}

	@Override
	public int updateComment(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();
		paramMap.put("s_emp_cd", (String) session.getAttribute("empCode"));// 등록자 사번
		
		int result = query.insert(NAMESPACE + "biz_board.update_comment", paramMap);
		
		return result;
	}

	@Override
	public int deleteComment(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();
		paramMap.put("s_emp_cd", (String) session.getAttribute("empCode"));// 등록자 사번
		
		int result = query.insert(NAMESPACE + "biz_board.delete_comment", paramMap);
		
		return result;
	}

	@Override
	public int deleteCommentByBoardNo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		HttpSession session = request.getSession();
		paramMap.put("s_emp_cd", (String) session.getAttribute("empCode"));// 등록자 사번
		
		int result = query.insert(NAMESPACE + "biz_board.delete_comment_by_board_no", paramMap);
		
		return result;
	}
	
}
