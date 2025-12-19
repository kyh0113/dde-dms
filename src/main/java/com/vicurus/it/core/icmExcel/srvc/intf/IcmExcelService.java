package com.vicurus.it.core.icmExcel.srvc.intf;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface IcmExcelService {

	@SuppressWarnings("rawtypes")
	public List excelList(Map param) throws Exception;
	
//	public int xlsxUpload(MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int xlsxUpload(MultipartFile file, final MultipartHttpServletRequest request, HttpServletResponse response) throws Exception;
	
//	public int xlsUpload(MultipartFile file, HttpServletRequest request, HttpServletResponse response);
	public int xlsUpload(MultipartFile file, final MultipartHttpServletRequest request, HttpServletResponse response);
	
//	public int xlsxUploadBatch(MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int xlsxUploadBatch(MultipartFile file, final MultipartHttpServletRequest request, HttpServletResponse response) throws Exception;
}
