package com.yp.common.srvc.intf;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartHttpServletRequest;


public interface CommonService {
	
	
	public ArrayList<HashMap<String, String>> pagingListOfERPList(ArrayList<HashMap<String, String>> erpList, int firstidx, int lastidx) throws Exception;
	
	/* 영풍 전용 파일 업로드 */
	public ArrayList<HashMap<String, String>> fileUpload(HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest mRequest) throws Exception;
	
	/* 영풍 전용 이미지 파일 업로드(이미지 보기가 필요한 경우 사용) */
	public HashMap<String, String> ImgfileUpload(HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest mRequest) throws Exception;

	public List<HashMap<String, String>> code_list(HashMap<String, String> code_data) throws Exception;

	public String getContent(String excute_date) throws Exception;

}

