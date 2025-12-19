package com.vicurus.it.biz.board.cntr;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.vicurus.it.core.common.Util;
import com.vicurus.it.core.file.srvc.intf.FileService;
import com.vicurus.it.biz.board.srvc.intf.BoardService;
import com.vicurus.it.biz.dashboard.cntr.DashBoardController;

@Controller
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private FileService fileService;
	
	//----------------------------------- 공지게시판 ----------------------------------------------------------
	@RequestMapping(value="/biz/board", method = RequestMethod.POST)
	public ModelAndView board(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		String emp_cd = (String) session.getAttribute("empCode");//등록자 사번		
		
		int boardNo = -1;
		if(paramMap.get("board_no")!=null) {
			boardNo = Integer.parseInt(paramMap.get("board_no").toString());
		}
		mav.addObject("emp_cd",emp_cd);
		mav.addObject("board_no",boardNo);
		mav.setViewName("/biz/board/board");
		return mav;
	}
	
	@RequestMapping(value="/biz/board/insertBoard", method = RequestMethod.POST)
	public ModelAndView insertBoard(final MultipartHttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_cd", (String) session.getAttribute("empCode"));//등록자 사번
		
//		Map before = boardService.boardGetAttachNo(request, response);
//		paramMap.put("attach_no", (before==null)?null:before.get("attach_no"));
		
		Map resultFileInsert = fileService.CommonUpload(request,paramMap);
		
		request.setAttribute("attach_no", resultFileInsert.get("attach_no"));

		int result = boardService.board_insert(request, paramMap);
		
		Map resultMap = new HashMap();
	
		resultMap.put("result", result);
			
		return new ModelAndView("DataToJson", resultMap);
	}

	
	@RequestMapping(value="/biz/board/boardDetail", method = RequestMethod.POST)
	public ModelAndView boardDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map boardViewMap = boardService.board_view(request);
		
		request.setAttribute("attach_no", boardViewMap.get("attach_no"));
		
		List<Map> fileList = boardService.board_view_file_list(request, response);
		
		Map resultMap = new HashMap();
		resultMap.put("boardView", boardViewMap);
		resultMap.put("fileList", fileList);
			
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/biz/board/boardDetailMain", method = RequestMethod.POST)
	public ModelAndView boardDetailMain(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map resultMap = boardService.board_view_main(request);
			
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/biz/board/updatetBoard", method = RequestMethod.POST)
	public ModelAndView updateBoard(final MultipartHttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
//		Map before = boardService.boardGetAttachNo(request, response);
//		paramMap.put("attach_no", (before==null)?null:before.get("attach_no"));
		
		Map resultFileInsert = fileService.CommonUpload(request,paramMap);
		
		
		request.setAttribute("attach_no", resultFileInsert.get("attach_no"));

		int result = boardService.board_update(request, paramMap);
		
		
		Map resultMap = new HashMap();
	
		resultMap.put("result", result);
			
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/biz/board/boardDelete", method = RequestMethod.POST)
	public ModelAndView deleteBoard(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int result = boardService.board_delete(request);
		
		Map resultMap = new HashMap();
	
		resultMap.put("result", result);
			
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/biz/board/popupChk", method = RequestMethod.POST)
	public ModelAndView popupChk(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
		Map resultMap = new HashMap();
		
		int result = boardService.popupChk(request,response);
		
		resultMap.put("popupNum", result);
			
		return new ModelAndView("DataToJson", resultMap);
	}
	//----------------------------------------------------------------------------------------------------------
	
	//----------------------------------- 일반게시판 ----------------------------------------------------------
	@RequestMapping(value="/biz/board2", method = RequestMethod.POST)
	public ModelAndView board2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		String emp_cd = (String) session.getAttribute("empCode");//등록자 사번		
		
		int boardNo = -1;
		if(paramMap.get("board_no")!=null) {
			boardNo = Integer.parseInt(paramMap.get("board_no").toString());
		}
		mav.addObject("emp_cd",emp_cd);
		mav.addObject("board_no",boardNo);
		mav.setViewName("/biz/board/board2");
		return mav;
	}
	
	@RequestMapping(value="/biz/board/insertBoard2", method = RequestMethod.POST)
	public ModelAndView insertBoard2(final MultipartHttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		paramMap.put("emp_cd", (String) session.getAttribute("empCode"));//등록자 사번
		
//		Map before = boardService.boardGetAttachNo(request, response);
//		paramMap.put("attach_no", (before==null)?null:before.get("attach_no"));
		
		Map resultFileInsert = fileService.CommonUpload(request,paramMap);
		
		request.setAttribute("attach_no", resultFileInsert.get("attach_no"));

		int result = boardService.board_insert2(request, paramMap);
		
		Map resultMap = new HashMap();
	
		resultMap.put("result", result);
			
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/biz/board/boardDetail2", method = RequestMethod.POST)
	public ModelAndView boardDetail2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map boardViewMap = boardService.board_view2(request);
		
		request.setAttribute("attach_no", boardViewMap.get("attach_no"));
		
		List<Map> fileList = boardService.board_view_file_list(request, response);
		
		Map resultMap = new HashMap();
		resultMap.put("boardView", boardViewMap);
		resultMap.put("fileList", fileList);
			
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/biz/board/boardDetailComment", method = RequestMethod.POST)
	public ModelAndView boardDetailComment(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List boardCommentList = boardService.board_comment_select2(request, response); 
		
		Map resultMap = new HashMap();
		resultMap.put("boardCommentList", boardCommentList);
			
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/biz/board/boardDelete2", method = RequestMethod.POST)
	public ModelAndView deleteBoard2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//게시글 삭제
		int result = boardService.board_delete2(request);
		//관련된 댓글 삭제
		result += boardService.deleteCommentByBoardNo(request, response);
		
		Map resultMap = new HashMap();
	
		resultMap.put("result", result);
			
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/biz/board/updatetBoard2", method = RequestMethod.POST)
	public ModelAndView updateBoard2(final MultipartHttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
//		Map before = boardService.boardGetAttachNo(request, response);
//		paramMap.put("attach_no", (before==null)?null:before.get("attach_no"));
		
		Map resultFileInsert = fileService.CommonUpload(request,paramMap);
		
		
		request.setAttribute("attach_no", resultFileInsert.get("attach_no"));

		int result = boardService.board_update2(request, paramMap);
		
		
		Map resultMap = new HashMap();
	
		resultMap.put("result", result);
			
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/biz/board/insertComment", method = RequestMethod.POST)
	public ModelAndView insert_comment(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int result = boardService.insert_comment(request, response);
		
		Map resultMap = new HashMap();
	
		resultMap.put("result", result);
			
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/biz/board/updateComment", method = RequestMethod.POST)
	public ModelAndView updateComment(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int result = boardService.updateComment(request, response);
		
		Map resultMap = new HashMap();
	
		resultMap.put("result", result);
			
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@RequestMapping(value="/biz/board/deleteComment", method = RequestMethod.POST)
	public ModelAndView deleteComment(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int result = boardService.deleteComment(request, response);
		
		Map resultMap = new HashMap();
	
		resultMap.put("result", result);
			
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	
}
