package com.vicurus.it.core.excel.cntr;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.vicurus.it.core.excel.srvc.intf.ExcelService;


@Controller
public class ExcelUploadController {
	
	/** logger */
	private static final Logger logger = LoggerFactory.getLogger(ExcelUploadController.class);
	
	
	@Autowired
	private ExcelService ExcelService;
    
	/**
	 * 샘플 엑셀업로드
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/sample/excel_upload.do")
	public ModelAndView ExcelUpload(final MultipartHttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		try { 
			Map resultMap = new HashMap();
			
			int result = ExcelService.ExcelUpload(request, response);

    		resultMap.put("excel_msg", result);
    		
    		return new ModelAndView("DataToJson", resultMap);			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} 
	}
	
	/**
	 * 샘플 엑셀업로드 최종반영
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/sample/excel_save.do")
	public ModelAndView ExcelSave(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		try { 
			Map map = ExcelService.ExcelSave(request, response);
			
    		return new ModelAndView("DataToJson", map);			
			
		} catch (Exception e) {
			throw e;
		} 
		
		
	}
	
}
