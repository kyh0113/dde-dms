package com.vicurus.it.biz.board.srvc.intf;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

@Service
@SuppressWarnings("rawtypes")
public interface BoardService {
	
	//----------------------------------- 공지 게시판 ------------------------------------------------------------
	public Map boardGetAttachNo(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int board_insert(HttpServletRequest request, Map paramMap) throws Exception;
	
	public Map board_view(HttpServletRequest request) throws Exception;
	
	public Map board_view_main(HttpServletRequest request) throws Exception;
	
	public int board_update(HttpServletRequest request, Map paramMap) throws Exception;
	
	public int board_delete(HttpServletRequest request) throws Exception;

	public Map popupYList(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int popupChk(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public List<Map> board_select(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public List<Map> board_view_file_list(HttpServletRequest request, HttpServletResponse response) throws Exception;
	//--------------------------------------------------------------------------------------------------------
	
	//----------------------------------- 일반 게시판 ------------------------------------------------------------
	public int board_delete2(HttpServletRequest request) throws Exception;
	
	public int board_insert2(HttpServletRequest request, Map paramMap) throws Exception;
	
	public Map board_view2(HttpServletRequest request) throws Exception;
	
	public int board_update2(HttpServletRequest request, Map paramMap) throws Exception;
	
	public int insert_comment(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public List<HashMap<String, Object>> board_comment_select2(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int updateComment(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int deleteComment(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int deleteCommentByBoardNo(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
