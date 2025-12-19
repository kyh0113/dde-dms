package com.yp.common.cntr;

import org.apache.commons.io.FilenameUtils;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.servlet.view.RedirectView;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sap.conn.jco.JCoDestination;
import com.sap.conn.jco.JCoDestinationManager;
import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoTable;
import com.vicurus.it.core.common.Util;
import com.yp.common.srvc.intf.CommonService;

import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
 
import com.vicurus.it.core.file.cntr.FileController;
import com.yp.util.DateUtil;

@Controller
public class YPCommonController{

	private static final Logger logger = LoggerFactory.getLogger(YPCommonController.class);
	private static final String FILE_NAME_CHAR_SET = "KSC5601";
	
	@Autowired
	CommonService cs;
	
	// config.properties 에서 설정 정보 가져오기 시작
	@SuppressWarnings("unused")
	private static String FILE_HOME_PATH;

	@SuppressWarnings("static-access")
	@Value("#{config['file.uploadDirResource']}")
	public void setFILE_HOME_PATH(String value) {
		this.FILE_HOME_PATH = value;
	}
	// config.properties 에서 설정 정보 가져오기 끝
	
	@RequestMapping("/yp/popup/imgReg")
	public String imgReg(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		model.addAttribute("type",request.getParameter("type"));
		model.addAttribute("BASE_YYYY",request.getParameter("BASE_YYYY"));
		model.addAttribute("VENDOR_CODE",request.getParameter("VENDOR_CODE"));
		model.addAttribute("GUBUN_CODE_AGGREGATION",request.getParameter("GUBUN_CODE_AGGREGATION"));
		return "/yp/common/img_reg_pop";
	}
	
	@RequestMapping("/yp/popup/fileReg")
	public ModelAndView contFileReg(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		logger.debug("paramMap="+paramMap);
		
		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/common/file_reg_pop");
		return mav;
	}
	
	@RequestMapping("/yp/popup/jusoPopup")
	public String jusoPopup(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		//return "/yp/common/juso_popup";
		return "/yp/common/jusoPopup";
	}
	
	@RequestMapping("/yp/popup/imgPopup")
	public String imgPopup(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		model.addAttribute("url",request.getParameter("url"));
		return "/yp/common/img_popup";
	}
	
	@RequestMapping("/yp/lme/table")
	public String lmeTable(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		String opt_Date = "";
		if(request.getParameter("LME_DATE") != null && request.getParameter("LME_DATE") != ""){
			opt_Date = ((String)request.getParameter("LME_DATE")).replaceAll("-", "");
		}else{
			opt_Date = DateUtil.getCurrentDateTime().substring(0,10).replaceAll("/", "");
		}
		
		String excute_date = opt_Date;
		String content = "";
		for(int i=0;i<7;i++){
			logger.debug("execute_date-"+i+" : "+excute_date);
			content = cs.getContent(excute_date);
			model.addAttribute("html_date",excute_date);
			
			if(content.equals("nodata")){
				excute_date = DateUtil.getYesterday(excute_date);
				model.addAttribute("html_date",excute_date);
			}else{
				model.addAttribute("content",content);
				break;
			}
		}
		
		if(content.equals("nodata")){
			model.addAttribute("content","일주일간 데이터가 없습니다. 날짜를 지정해 주세요.");
		}
		return "/yp/common/lme_table";
	}
	
	
	/**
	 * 코드 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/yp/code_list")
	public void code_list(HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/xml; charset=utf-8");
		JSONObject json = new JSONObject();
		
		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		List<HashMap<String, String>> result = cs.code_list(paramMap);
		
		//for(int i=0;i<result.size();i++){
			json.put("result",result);
		//}
		
		PrintWriter out	= response.getWriter();
		out.print(json);
	}
	
	 /**
	 * 파일 다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/yp/fileDown")
	public void fileDown(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String filePath = "";
		String fileName = "";
		try {
			Util util = new Util();
			Map paramMap = util.getParamToMap(request, false);

			//redirect filedown
			Map<String, ?> redirectMap = RequestContextUtils.getInputFlashMap(request);
			if( redirectMap  != null ){
		        String param1 =  (String)redirectMap.get("url") ;  // 오브젝트 타입이라 캐스팅해줌
		        paramMap.put("url", param1);
		    }
		
			String url = (String) paramMap.get("url");
			logger.debug("cont.fileDown url=" + url);
			String ext = FilenameUtils.getExtension(url);	//파일 확장자
			fileName = FilenameUtils.getBaseName(url);
			if(!fileName.contains(".pdf")) {	//파일명에 .pdf 포함된 경우는 pdf to img 컨버팅 한 경우임, 파일다운시 이미지파일 말고 원본 pdf파일을 다운받도록 설정
				fileName = fileName + '.' + ext;
			}
			filePath = FILE_HOME_PATH + FilenameUtils.getFullPath(url).replace("/uploadFiles", "") + fileName;
			
			File file = new File(filePath);
			logger.debug("파일생성");
			if (file.exists()) {
				logger.debug("파일존재");
				String mimetype = "application/x-msdownload";
				response.setContentType(mimetype);
				setDisposition(request, response, fileName);
				response.setContentLength((int) file.length());
				BufferedInputStream in = null;
				BufferedOutputStream out = null;
				try {
					in = new BufferedInputStream(new FileInputStream(file));
					out = new BufferedOutputStream(response.getOutputStream());
					FileCopyUtils.copy(in, out);
					out.flush();
					out.toString();
					logger.debug("파일보냄");
				} catch (Exception ex) {
					ex.printStackTrace();
					logger.debug("IGNORED: " + ex.getMessage());
				} finally {
					if (in != null) {
						try {
							in.close();
						} catch (Exception ignore) {
							ignore.printStackTrace();
							logger.debug("IGNORED: " + ignore.getMessage());
						}
					}
					if (out != null) {
						try {
							out.close();
						} catch (Exception ignore) {
							ignore.printStackTrace();
							logger.debug("IGNORED: " + ignore.getMessage());
						}
					}
				}
			}else{
				logger.debug("파일을 찾지못함//file_path="+filePath);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("파일 다운로드 에러");
		}
	}
	
	/**
	 * 파일 업로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/yp/fileUpload")
	public ModelAndView fileUpload(ModelMap model, MultipartHttpServletRequest mRequest, HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/xml; charset=utf-8");
		HashMap resultMap = new HashMap();
		resultMap.put("msg", "등록중 오류가 발생하였습니다.\n관리자에게 문의해 주세요.");
		resultMap.put("result_code", -1);
		
		Util util = new Util();
		HashMap<String, Object> paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		String type = (String)paramMap.get("type");
		
		ArrayList<HashMap<String, String>> result = cs.fileUpload(request, response, mRequest);
		if(result != null){
			resultMap.put("msg", "파일이 등록되었습니다.");
			for(int i=0; i<result.size(); i++){
				resultMap.put("uploadPath"+i, result.get(i).get("uploadPath"));
				resultMap.put("fileName"+i, result.get(i).get("fileName"));
			}
			resultMap.put("result_code", 1);
		}
		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	//브라우저별 파일다운로드 설정
	private void setDisposition(HttpServletRequest request, HttpServletResponse response, String filename)
			throws Exception {
		String browser = getBrowser(request);
		String dispositionPrefix = "attachment; filename=";
		String encodedFilename = null;
		if (browser.equals("MSIE")) {
			encodedFilename = "\"" + new String(filename.getBytes(FILE_NAME_CHAR_SET), "8859_1") + "\"";
		} else if (browser.equals("Firefox")) {
			encodedFilename = "\"" + new String(filename.getBytes(FILE_NAME_CHAR_SET), "8859_1") + "\"";
		} else if (browser.equals("Opera")) {
			encodedFilename = "\"" + new String(filename.getBytes(FILE_NAME_CHAR_SET), "8859_1") + "\"";
		} else if (browser.equals("Chrome")) {
			encodedFilename = "\"" + new String(filename.getBytes(FILE_NAME_CHAR_SET), "8859_1") + "\"";
		} else {
			throw new IOException("Not supported browser");
		}
		response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);
		if ("Opera".equals(browser)) {
			response.setContentType("application/octet-stream;charset=MS949");
		}
	}
	
	private String getBrowser(HttpServletRequest request) {
        String header = request.getHeader("User-Agent");
        if (header.indexOf("MSIE") > -1) {
            return "MSIE";
        } else if (header.indexOf("Chrome") > -1) {
            return "Chrome";
        } else if (header.indexOf("Opera") > -1) {
            return "Opera";
        }
        return "Firefox";
    }
}
