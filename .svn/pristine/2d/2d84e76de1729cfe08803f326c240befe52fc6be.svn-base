package com.vicurus.it.core.file.srvc.intf;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface FileService {
	@SuppressWarnings("rawtypes")
	public File renameFile(File file, String directory);
	@SuppressWarnings("rawtypes")
	public String getFileName(String str);
	@SuppressWarnings("rawtypes")
	public boolean renameFile(File srcFile, File desFile);
	@SuppressWarnings("rawtypes")
	public String webFileUpload(HttpServletRequest request) throws Exception;
	@SuppressWarnings("rawtypes")
	public String fileDown(HttpServletRequest request) throws Exception;
	@SuppressWarnings("rawtypes")
	public String fileRepresent(HttpServletRequest request) throws Exception;
	@SuppressWarnings("rawtypes")
	public String fileDelete(HttpServletRequest request) throws Exception;
//	@SuppressWarnings("rawtypes")
//	public String ImageInfoUpload(HttpServletRequest request, Map paramMap) throws Exception;
	@SuppressWarnings("rawtypes")
	public String ImageInfoUpload(final MultipartHttpServletRequest request, Map paramMap) throws Exception;
//	@SuppressWarnings("rawtypes")
//	public String ImageUpload(HttpServletRequest request, Map paramMap) throws Exception;
	@SuppressWarnings("rawtypes")
	public String ImageUpload(final MultipartHttpServletRequest request, Map paramMap) throws Exception;
	public int deleteFile(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int deleteFileTest(HttpServletRequest request, HttpServletResponse response) throws Exception;
	@SuppressWarnings("rawtypes")
	public Map deleteFile_with_deleteBoard(HttpServletRequest request, Map paramMap) throws Exception;
	//icm file 하태현
	
	//20191026_khj Multipart요청도 XSS필터 적용위해 파라메터 변경함
//	@SuppressWarnings("rawtypes")
//	public Map CommonUpload(HttpServletRequest request, Map paramMap) throws Exception;
	@SuppressWarnings("rawtypes")
	public Map CommonUpload(final MultipartHttpServletRequest request, Map paramMap) throws Exception;
	
	@SuppressWarnings("rawtypes")
	public List FileList(HttpServletRequest request, HttpServletResponse response) throws Exception;
	@SuppressWarnings("rawtypes")
	public int icmFileDelete(HttpServletRequest request, HttpServletResponse response);
	
	public int xlsxUpload(MultipartFile file, final MultipartHttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int xlsxUpload_Mon(MultipartFile file, final MultipartHttpServletRequest request, HttpServletResponse response, ArrayList<String> list, HashMap<String, String> map) throws Exception;
	
	public int xlsxUpload_Inv(MultipartFile file, final MultipartHttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public int xlsUpload(MultipartFile file, final MultipartHttpServletRequest request, HttpServletResponse response);
	
	public void resize(File src, File dest, int width, int height) throws Exception;
	
	public Map xlsxUploadFixture(MultipartFile file, final MultipartHttpServletRequest request, HttpServletResponse response, List<String> keyList) throws Exception;
	
}
