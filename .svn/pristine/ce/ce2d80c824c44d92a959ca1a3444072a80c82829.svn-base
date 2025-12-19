package com.vicurus.it.core.icmExcel.cntr;

import java.net.URLEncoder;
import java.util.ArrayList;
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
import org.springframework.web.servlet.ModelAndView;

import com.vicurus.it.core.common.Util;
import com.vicurus.it.core.icmExcel.srvc.intf.IcmExcelService;



@Controller
public class IcmExcelDownLoadController {
	private static final Logger logger = LoggerFactory.getLogger(IcmExcelDownLoadController.class);
	private static final String xlsx = "XlsxDownForICM";
	private static final String xls = "XlsDownForICM";
	
	@Autowired
	private IcmExcelService icmExcelService;
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/core/excel/excelDown")
	public ModelAndView init(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)

		String version = (String) paramMap.get("version");
	    String filename = (String) paramMap.get("filename");
	    
		String browser = getBrowser(request);

		if (browser.contains("MSIE")||browser.contains("Trident")) {
		       String docName = URLEncoder.encode(filename).replaceAll("\\+", "%20");
		       response.setHeader("Content-Disposition", "attachment;filename=" + docName + "." + version + ";");
		} else if (browser.contains("Firefox")) {
		       String docName = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
		       response.setHeader("Content-Disposition", "attachment; filename=\"" + docName + "." + version + "\"");
		} else if (browser.contains("Opera")) {
		       String docName = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
		       response.setHeader("Content-Disposition", "attachment; filename=\"" + docName + "." + version + "\"");
		} else if (browser.contains("Chrome")) {
		       String docName = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
		       response.setHeader("Content-Disposition", "attachment; filename=\"" + docName + "." + version + "\"");
		}
		
		Map viewParam = new HashMap();
		List<Map> dataList = new ArrayList();
		if((String) paramMap.get("listQuery") != null){
			dataList = icmExcelService.excelList(paramMap);
		}

		//System.out.println(dataList.toString());
		viewParam.put("dataList", dataList);
		viewParam.put("version", request.getParameter("version"));
		viewParam.put("filename", filename);
		
		String downloadForm = version.equals("xlsx")?xlsx:xls;

		return new ModelAndView(downloadForm, "datas", viewParam);
	}
	
	private String getBrowser(HttpServletRequest request) {
        String header =request.getHeader("User-Agent");
        if (header.contains("MSIE")) {
               return "MSIE";
        } else if(header.contains("Chrome")) {
               return "Chrome";
        } else if(header.contains("Opera")) {
               return "Opera";
        }
        return "Firefox";
	}
}
