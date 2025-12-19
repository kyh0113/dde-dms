package com.vicurus.it.core.excel.srvc.intf;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartHttpServletRequest;




public interface ExcelService {
	
	@SuppressWarnings("rawtypes")
	public Map excelDownloadWithQuery(Map map) throws Exception;
	@SuppressWarnings("rawtypes")
	public Map excelDown(Map map) throws Exception;
	public int ExcelUpload(final MultipartHttpServletRequest request, HttpServletResponse response) throws Exception;
	@SuppressWarnings("rawtypes")
	public Map ExcelSave(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
