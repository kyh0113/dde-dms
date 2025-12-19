package com.vicurus.it.core.icmExcel.cntr;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.vicurus.it.core.common.Util;
import com.vicurus.it.core.icmExcel.srvc.intf.IcmExcelService;

@Controller
public class IcmExcelUploadController {
	private static final Logger logger = LoggerFactory.getLogger(IcmExcelDownLoadController.class);
	private static final String xlsx = "XlsxDownForICM";
	private static final String xls = "XlsDownForICM";
	
	@Autowired
	private IcmExcelService icmExcelService;
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/core/excel/excelUpload")
	public ModelAndView init(final MultipartHttpServletRequest multipartRequest, HttpServletResponse response, Model model) throws Exception {
		Map resultMap = new HashMap();
		Util util = new Util();
		int result = 0;
		
		//MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultipartFile file = multipartRequest.getFile("excelfile");
		
		
		int dot = file.getOriginalFilename().lastIndexOf(".");

        String ext = file.getOriginalFilename().substring(dot);					//파일 확장자 추출
		
        if (!util.isNull(ext)){												//파일 확장자 대문자로 변경
			ext = ext.toUpperCase();
		}
        
        if (".XLSX".equals(ext)) {
        	//result = icmExcelService.xlsxUpload(file, request, response);
        	result = icmExcelService.xlsxUpload(file, multipartRequest, response);
        }else{
        	//result = icmExcelService.xlsUpload(file, request, response);
        	result = icmExcelService.xlsUpload(file, multipartRequest, response);
        }
        resultMap.put("result", result);
        
		return new ModelAndView("DataToJson", resultMap);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/core/excel/excelUploadBatch")
	public ModelAndView excelUploadBatch(final MultipartHttpServletRequest multipartRequest, HttpServletResponse response, Model model) throws Exception {
		Map resultMap = new HashMap();
		Util util = new Util();
		int result = 0;
		
		//MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultipartFile file = multipartRequest.getFile("excelfile");
		
		
		int dot = file.getOriginalFilename().lastIndexOf(".");

        String ext = file.getOriginalFilename().substring(dot);					//파일 확장자 추출
		
        if (!util.isNull(ext)){												//파일 확장자 대문자로 변경
			ext = ext.toUpperCase();
		}
        
        if (".XLSX".equals(ext)) {
        	//result = icmExcelService.xlsxUploadBatch(file, request, response);
        	result = icmExcelService.xlsxUploadBatch(file, multipartRequest, response);
        }else{
        	//result = icmExcelService.xlsUpload(file, request, response);
        	result = icmExcelService.xlsUpload(file, multipartRequest, response);
        }
		
        resultMap.put("result", result);
        
		return new ModelAndView("DataToJson", resultMap);
	}
}
