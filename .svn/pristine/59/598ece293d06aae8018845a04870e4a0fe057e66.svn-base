package com.vicurus.it.core.excel.cntr;

import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
import com.vicurus.it.core.common.Util;
import com.vicurus.it.core.excel.srvc.intf.ExcelService;

@Controller
public class ExcelDownloadController {
	
	/** logger */
	private static final Logger logger = LoggerFactory.getLogger(ExcelDownloadController.class);
	
	@Autowired
	private ExcelService ExcelService;
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/core/excel/excelDownloadWithQuery.do")
	public String excelDownloadWithQuery(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		//logger.debug("----- excelDownloadWithQuery start -----");
		
		Map returnMap = null;
		ArrayList list = null; 
		try { 
			Util util = new Util();
			Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
			returnMap = (Map) ExcelService.excelDownloadWithQuery(paramMap);
			list =  (ArrayList) returnMap.get("dataList");
			paramMap.put("excelList", list);
			model.addAttribute("excelList", paramMap);
			return "excelDownloadWithQuery";
		} catch (Exception e) {
			logger.debug("{}","excelDownloadWithQuery ERROR!");
			throw e;
		} 
	}
    
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/core/excel/excelDown.do")
	public String init(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		//System.out.println("----- ExcelDownloadController start -----");
		
		Map returnMap = null;
		List list = null; 
		try { 
			Util util = new Util();
			Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
			returnMap = (Map) ExcelService.excelDown(paramMap);
			list =  (List) returnMap.get("dataList");
			paramMap.put("excelList", list);
			model.addAttribute("excelList", paramMap);
			//엑셀 데이터가 65000건 이상인 경우 .xlsx로 엑셀다운로드
			if((Integer)returnMap.get("end") > 65000){
				return "excelDownloadXlsx";
			}else{
				return "excelDownloadXls";
			}
		} catch (Exception e) {
			logger.debug("{}","ExcelDownloadController ERROR!");
			throw e;
		} 
	}
	
	@RequestMapping("/core/excel/excelDownHtml.do")
	public void ExcelDownHtml(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		//System.out.println("----- ExcelDownloadController start -----");
			 
		try { 
			Util util = new Util();
			Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
			PrintWriter out = response.getWriter();
			String fileName = (String) paramMap.get("excel_name");	//엑셀파일명 받기
			String data = (String) paramMap.get("excel_list");		//JqGrid to HTML 데이터 받기
			String data2 = data.replaceAll("mso-number-format: @;", "mso-number-format:\\\\@;");	//엑셀 0으로 시작하는문자열 보여주기위해 텍스트포맷 설정

			//엑셀 파일명에 붙일 현재시간 생성 시작
			Calendar calendar = Calendar.getInstance();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy_MM_dd_HH_mm_ss");
			String today = dateFormat.format(calendar.getTime());
			//엑셀 파일명에 붙일 현재시간 생성 끝	
			
			if(data2 != null && fileName != null){
				//data = URLDecoder.decode(data, "UTF-8");
				
				//엑셀 파일명 생성 시작
				fileName = fileName + "_" + today + ".xls";	      
				
				//엑셀 파일명 생성 시
				String userAgent = request.getHeader("User-Agent");
				if(userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1){
					//System.out.println("여기타면 익스플로러");
					fileName = URLEncoder.encode(fileName, "utf-8");
				}else{
					//System.out.println("여기타면 익스플로러 아니당");
					fileName = new String(fileName.getBytes("utf-8"), "iso-8859-1");
				}
				//엑셀 파일명 생성 끝
				
				response.setCharacterEncoding("utf-8");
				response.setContentType("application/vnd.ms-excel");
				response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
				response.setHeader("Content-Transfer-Encoding", "binary");					
				response.setHeader("Pragma", "no-cache;");
				response.setHeader("Expires", "-1;");

				out.println(data2);
			}

		} catch (Exception e) {
			logger.debug("{}","ExcelDownloadController ERROR!");
			throw e;
		} 
	}
	
}
