package com.vicurus.it.core.file.cntr;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.vicurus.it.core.common.Util;
import com.vicurus.it.core.file.srvc.intf.FileService;
import com.yp.fixture.srvc.intf.YPFixtureService;
import com.yp.zfi.bud.srvc.intf.YP_ZFI_BUD_Service;

@Controller
public class FileController {

	/** logger */
	private static final Logger logger = LoggerFactory.getLogger(FileController.class);

	//config.properties 에서 설정 정보 가져오기 시작
	private static String NAMESPACE;

	@Value("#{config['db.vendor']}")
	public void setNAMESPACE(String value) {
		this.NAMESPACE = value + ".";
	}
	//config.properties 에서 설정 정보 가져오기 끝

	@Autowired
	private YP_ZFI_BUD_Service zfiService;

	@Autowired
	private YPFixtureService fixture_service;

	/** FileService */
	@Autowired
	private FileService fileService;

	@Value("#{config['file.templateDir']}")
	private String templateDir;

	@Value("#{config['file.zipfileDir']}")
	private String zipfileDir;

	@Autowired
    @Qualifier("sqlSession")
	private SqlSession query;

	private static final String FILE_NAME_CHAR_SET = "KSC5601";

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value="/biz/ICMFileList", method = RequestMethod.POST)
	public ModelAndView init(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		List resultList = fileService.FileList(request, response);
		Map resultMap = new HashMap();
		resultMap.put("files", resultList);
		return new ModelAndView("DataToJson", resultMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value="/biz/ICMFileDelete", method = RequestMethod.POST)
	public ModelAndView ICMFileDelete(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		int result = fileService.icmFileDelete(request, response);
		Map resultMap = new HashMap();
		resultMap.put("files", result);
		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 파일 다운로드
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/biz/ICMTemplateDownload", method=RequestMethod.POST)
	public void ICMTemplateDownload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String filePath = "";
		String fileName ="";
		try {
			Util util = new Util();
			Map paramMap = util.getParamToMap(request,false);

			fileName = (String) paramMap.get("file_name");
			filePath = templateDir + fileName;

			File file = new File(filePath);
			if (file.exists()) {
				String mimetype = "application/x-msdownload";
				response.setContentType(mimetype);
				setDisposition(request, response, fileName);
				response.setContentLength((int)file.length());
				BufferedInputStream in = null;
				BufferedOutputStream out = null;
				try {
					in = new BufferedInputStream(new FileInputStream(file));
					out = new BufferedOutputStream(response.getOutputStream());
					FileCopyUtils.copy(in, out);
					out.flush();
					out.toString();
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
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("파일 다운로드 에러");
		}

	}

	/**
	 * 파일 다운로드
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/biz/ICMFileDownload", method=RequestMethod.POST)
	public void downloadFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String filePath = "";
		String fileName ="";
		try {
			Util util = new Util();
			Map paramMap = util.getParamToMap(request,false);
			Map fileMap = query.selectOne(NAMESPACE+"File.ICMDownloadFile", paramMap);
			filePath = (String) fileMap.get("file_dir");
			fileName = (String) fileMap.get("src_file_name");
			File file = new File(filePath);
			if (file.exists()) {
				String mimetype = "application/x-msdownload";
				response.setContentType(mimetype);
				setDisposition(request, response, fileName);
				response.setContentLength((int)file.length());
				BufferedInputStream in = null;
				BufferedOutputStream out = null;
				try {
					in = new BufferedInputStream(new FileInputStream(file));
					out = new BufferedOutputStream(response.getOutputStream());
					FileCopyUtils.copy(in, out);
					out.flush();
					out.toString();
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
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("파일 다운로드 에러");
		}

	}

	@RequestMapping(value="/core/file/downloadFileURL.do")
	public void downloadFileURL(HttpServletRequest request, HttpServletResponse response) throws Exception {
		FileWriter fw = new FileWriter("C:\\vims 바로가기.url");
        fw.write("[InternetShortcut]\n");
        fw.write("URL=" + "http://vims.vicurus.com/" + "\n");
        fw.flush();
        fw.close();
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/core/file/downloadFileTest.do")
	public void downloadFileTest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String filePath = "";
		String fileName ="";
		try {
			Util util = new Util();
			Map paramMap = util.getParamToMap(request,false);
			Map fileMap = query.selectOne(NAMESPACE+"File.downloadFileTest", paramMap);
			filePath = (String) fileMap.get("file_path");
			fileName = (String) fileMap.get("file_name");
			File file = new File(filePath);
			if (file.exists()) {
				String mimetype = "application/x-msdownload";
				response.setContentType(mimetype);
				setDisposition(request, response, fileName);
				response.setContentLength((int)file.length());
				BufferedInputStream in = null;
				BufferedOutputStream out = null;
				try {
					in = new BufferedInputStream(new FileInputStream(file));
					out = new BufferedOutputStream(response.getOutputStream());
					FileCopyUtils.copy(in, out);
					out.flush();
					out.toString();
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
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("파일 다운로드 에러");
		}

	}

	//브라우저별 파일다운로드 설정
	private void setDisposition(HttpServletRequest request, HttpServletResponse response, String filename) throws Exception {
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
		if ("Opera".equals(browser)){
			response.setContentType("application/octet-stream;charset=MS949");
		}
    }

	/**
	 * 파일 다운로드
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/file/filedown.do", method=RequestMethod.POST)
	public void fileDown(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String filePath = "";
		String fileName ="";
		try {
			Util util = new Util();
			Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
			Map fileMap = query.selectOne(NAMESPACE+"File.GetFilePath", paramMap);
			filePath = (String) fileMap.get("FILE_PATH");		//나머지 경로(파일이름까지)
    		fileName = (String) fileMap.get("FILE_NAME");		//화면에 보여질 파일명

    		//System.out.println("filePath = " + filePath);
    		//System.out.println("fileName = " + fileName);

    		File file = new File(filePath);

			if (file.exists()) {								//파일 유무 확인
				String mimetype = "application/x-msdownload";
				response.setContentType(mimetype);
				setDisposition(request, response, fileName);	//브라우저별 파일다운로드 설정
				response.setContentLength((int)file.length());

				BufferedInputStream in = null;
				BufferedOutputStream out = null;

				try {
				    in = new BufferedInputStream(new FileInputStream(file));
				    out = new BufferedOutputStream(response.getOutputStream());
				    FileCopyUtils.copy(in, out);
				    out.flush();
				    out.toString();
				} catch (Exception ex) {
					ex.printStackTrace();
					logger.debug("IGNORED: " + ex.getMessage());
					//return new ModelAndView("ResultJsonView",walker.returnException(ex.toString()));
				} finally {
				    if (in != null) {
						try {
						    in.close();
						} catch (Exception ignore) {
						    // no-op
							ignore.printStackTrace();
						    logger.debug("IGNORED: " + ignore.getMessage());
						}
				    }
				    if (out != null) {
						try {
						    out.close();
						} catch (Exception ignore) {
						    // no-op
							ignore.printStackTrace();
						    logger.debug("IGNORED: " + ignore.getMessage());
						}
				    }
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			//System.out.println("파일 다운로드 에러");
		    //return new ModelAndView("ResultJsonView",walker.returnException(e.toString()));
    	}

	}

	/**
	 * 대표이미지등록
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/file/fileRepresent.do")
	public ModelAndView fileRepresent(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map map = new HashMap();
		String result = "-1";
		
		try { 
			result = fileService.fileRepresent(request);
			
		} catch (Exception e) {
			e.printStackTrace();
			//System.out.println("대표이미지등록 에러");
			logger.debug("IGNORED: " + e.getMessage());
    	} 	
		
		map.put("result_code", result);
		
		return new ModelAndView("DataToJson", map);
	}
	
	/**
	 * 파일 삭제
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/file/fileDelete.do")
	public ModelAndView fileDelete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map map = new HashMap();
		String result = "-1";
		
		try { 
			result = fileService.fileDelete(request);
			
		} catch (Exception e) {
			e.printStackTrace();
			//System.out.println("파일삭제 에러");
			logger.debug("IGNORED: " + e.getMessage());
    	} 	
		
		map.put("result_code", result);
		
		return new ModelAndView("DataToJson", map);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/file/fileDeleteTest.do")
	public ModelAndView fileDeleteTest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);
		Map map = new HashMap();
		int result = -1;
		try {
			fileService.deleteFile_with_deleteBoard(request, paramMap);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("IGNORED: " + e.getMessage());
		}
		map.put("result_code", result);
		return new ModelAndView("DataToJson", map);
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

	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/file/uploadImage.do")
	public String uploadImage(final MultipartHttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);
		fileService.ImageUpload(request, paramMap);
		request.setAttribute("paramMap", paramMap);
		//return new ModelAndView("/core/se/callback");
		return "redirect:" + paramMap.get("callback") + "?callback_func="+paramMap.get("callback_func")+paramMap.get("file_result");
	}
	@RequestMapping(value="/file/uploadImageCallback.do")
	public ModelAndView uploadImageCallback(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("/core/se/callback");
	}

	@RequestMapping(value="/file/excelUpload")
	public ModelAndView excelRead(final MultipartHttpServletRequest multipartRequest, HttpServletResponse response, Model model) throws Exception {
		Map resultMap = new HashMap();
		Util util = new Util();
		int result = 0;

		//MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultipartFile file = multipartRequest.getFile("excelfile");

		int dot = file.getOriginalFilename().lastIndexOf(".");
		logger.debug("dot:"+dot);

        String ext = file.getOriginalFilename().substring(dot);					//파일 확장자 추출
        logger.debug("ext:"+ext);

        if (!util.isNull(ext)) {												//파일 확장자 대문자로 변경
			ext = ext.toUpperCase();
		}

        if (".XLSX".equals(ext)) {
        	//result = icmExcelService.xlsxUpload(file, request, response);
        	result = fileService.xlsxUpload(file, multipartRequest, response);
        } else {
        	//result = icmExcelService.xlsUpload(file, request, response);
        	result = fileService.xlsUpload(file, multipartRequest, response);
        }
        resultMap.put("result", result);

		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 엑셀업로드(월보등록 전용)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/file/excelUpload_Mon")
	public ModelAndView excelUpload_Mon(final MultipartHttpServletRequest multipartRequest, HttpServletResponse response, Model model) throws Exception {
		Map resultMap = new HashMap();
		Util util = new Util();
		int result = 0;

		//RFC로 코스트센터 데이터 가져오기 시작
		HashMap req_data = (HashMap) util.getParamToMap(multipartRequest, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		req_data.put("search_type","I_LTEXT");
		req_data.put("search_text", "**");
		req_data.put("type", "C");
		ArrayList<HashMap<String, String>> list = zfiService.retrieveKOSTL(req_data);	//코스트센터 리스트 가져오기
		ArrayList<String> KOSTLLIST = new ArrayList();	//코스트센터 코드만 담은 리스트
		HashMap KOSTMAP = new HashMap();				//코스트센터 코드 및 코드명 담은 맵
		for (HashMap<String, String> row : list) {
			String kostl_code = row.get("KOSTL").toString().substring(4);	//5번째부터 코드시작(0000110603 -> 0000 제거해서 6자리로 사용)
	        String kostl_name = row.get("VERAK");
			KOSTLLIST.add(kostl_code);
			KOSTMAP.put(kostl_code, kostl_name);	//Map에 코스트센터코드, 코스트센터명 담기
	    }
		//RFC로 코스트센터 데이터 가져오기 끝

		//MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultipartFile file = multipartRequest.getFile("excelfile");

		int dot = file.getOriginalFilename().lastIndexOf(".");
		logger.debug("dot:"+dot);

        String ext = file.getOriginalFilename().substring(dot);					//파일 확장자 추출
        logger.debug("ext:"+ext);

        if (!util.isNull(ext)) {												//파일 확장자 대문자로 변경
			ext = ext.toUpperCase();
		}

        if (".XLSX".equals(ext)) {
        	result = fileService.xlsxUpload_Mon(file, multipartRequest, response, KOSTLLIST, KOSTMAP);
        }

        resultMap.put("result", result);

		return new ModelAndView("DataToJson", resultMap);
	}



	/**
	 * 엑셀업로드(주요재고현황 전용)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/file/excelUpload_Inv")
	public ModelAndView excelUpload_inv(final MultipartHttpServletRequest multipartRequest, HttpServletResponse response, Model model) throws Exception {
		Map resultMap = new HashMap();
		Util util = new Util();
		int result = 0;

		//MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultipartFile file = multipartRequest.getFile("excelfile");

		int dot = file.getOriginalFilename().lastIndexOf(".");
		logger.debug("dot:"+dot);

        String ext = file.getOriginalFilename().substring(dot);					//파일 확장자 추출
        logger.debug("ext:"+ext);

        if (!util.isNull(ext)) {												//파일 확장자 대문자로 변경
			ext = ext.toUpperCase();
		}

        if (".XLSX".equals(ext)) {
        	//result = icmExcelService.xlsxUpload(file, request, response);
        	result = fileService.xlsxUpload_Inv(file, multipartRequest, response);
        } 

        resultMap.put("result", result);

		return new ModelAndView("DataToJson", resultMap);
	}
	
	
	
	/**
	 * 엑셀 업로드(비품 마스터)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/file/excelUploadFixture")
	public ModelAndView excelUploadFixture(final MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception {
		Map resultMap = new HashMap();
		Map resultUpload = new HashMap();
		Util util = new Util();

		// Fixture Master 데이터 가져오기
		HashMap req_data = (HashMap) util.getParamToMap(multipartRequest, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		List<Map<String, Object>> list = fixture_service.fixture_master_key_list();
		List<String> keyList = new ArrayList<String>();

		for(Map map : list) {
			String fixtureName = map.get("fixture_name") == null ? "" : map.get("fixture_name").toString();
			keyList.add(map.get("fixture_name").toString());
		}

		//MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultipartFile file = multipartRequest.getFile("excelfile");

		int dot = file.getOriginalFilename().lastIndexOf(".");
		logger.debug("dot:"+dot);

        String ext = file.getOriginalFilename().substring(dot);					//파일 확장자 추출
        logger.debug("ext:"+ext);

        if (!util.isNull(ext)) {												//파일 확장자 대문자로 변경
			ext = ext.toUpperCase();
		}

        if (".XLSX".equals(ext)) {
        	resultUpload = fileService.xlsxUploadFixture(file, multipartRequest, response, keyList);
        }

        resultMap.put("result", resultUpload);

		return new ModelAndView("DataToJson", resultMap);
	}

	/**
	 * 파일 다운로드
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/file/templateDownload")
	public void templateDownload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String filePath = "";
		String fileName ="";
		try {
			Util util = new Util();
			Map paramMap = util.getParamToMap(request,false);

			fileName = (String) paramMap.get("file_name");
			filePath = templateDir + fileName;
			logger.debug("fileName:"+fileName);
			logger.debug("filePath:"+filePath);

			File file = new File(filePath);
			logger.debug("파일생성");
			if (file.exists()) {
				logger.debug("파일존재");
				String mimetype = "application/x-msdownload";
				response.setContentType(mimetype);
				setDisposition(request, response, fileName);
				response.setContentLength((int)file.length());
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
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("파일 다운로드 에러");
		}
	}

	/**
	 * 20200508_khj 일괄 다운로드 기능 추가
	 * 압축파일 다운로드
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/icm/ICMFileDownloadAll", method=RequestMethod.POST)
	public void downloadFileAll(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String downfileName = "";
		String zipFile = zipfileDir;

		try {
			Util util = new Util();
			Map paramMap = util.getParamToMap(request,false);
			zipFile += (String)paramMap.get("attach_no") + ".zip";

			//2020-09-08 smh 수정
			//COM_ATTACH를 attach_no으로 단순 조회
			//List fileList = query.selectList("File.ICMDownloadFileAll", paramMap);
			List fileList = query.selectList(NAMESPACE+"File.ICMFileList", paramMap);

		    FileOutputStream fout = new FileOutputStream(zipFile);
		    ZipOutputStream zout = new ZipOutputStream(fout);

			for(int i = 0; i < fileList.size(); i++) {
				//본래 파일명 유지, 경로제외 파일압축을 위해 new File로 
				Map tempMap = (Map)fileList.get(i);

				//2020-09-08 smh 수정
				//downfileName을 단순 attach_no.zip으로 변경
				//download .zip file명 담기
				/*
				 * if(i == 0) { if("".equals(tempMap.get("term_code"))) { downfileName =
				 * tempMap.get("gubun") + "_" + tempMap.get("title") + ".zip"; }else {
				 * downfileName = tempMap.get("term_code") + "_" + tempMap.get("gubun") + "_" +
				 * tempMap.get("title") + ".zip"; } }
				 */
				downfileName = (String)paramMap.get("attach_no") + ".zip";

				//zipEntry에 값 넣을때 중복파일명 처리 필요!!

				ZipEntry zipEntry = new ZipEntry(new File( String.valueOf(i+1) + "." + (String) tempMap.get("src_file_name")).getName());
		        zout.putNextEntry(zipEntry);

		        //경로포함 압축
		        //zout.putNextEntry(new ZipEntry((String) tempMap.get("src_file_name")));

		        FileInputStream fin = new FileInputStream((String) tempMap.get("file_dir"));
		        byte[] buffer = new byte[1024];
		        int length;

		        // input file을 1024바이트로 읽음, zip stream에 읽은 바이트를 씀
		        while((length = fin.read(buffer)) > 0) {
		            zout.write(buffer, 0, length);
		        }

		        zout.closeEntry();
		        fin.close();
			}

			zout.close();

			//response header setting
			response.setContentType("application/zip");
			setDisposition(request, response, downfileName);

			FileInputStream fis      = new FileInputStream(zipFile);
		    BufferedInputStream bis  = new BufferedInputStream(fis);
		    ServletOutputStream so   = response.getOutputStream();
		    BufferedOutputStream bos = new BufferedOutputStream(so);

			try {

			    byte[] data = new byte[2048];
			    int input=0;

			    while((input=bis.read(data))!= -1) {
			        bos.write(data,0,input);
			        bos.flush();
			    }

			} catch(Exception ex) {
				ex.printStackTrace();
				//logger.debug("IGNORED: " + ex.getMessage());
			} finally {

				if(bos!=null) bos.close();
			    if(bis!=null) bis.close();
			    if(so!=null) so.close();
			    if(fis!=null) fis.close();

			    //파일 다운로드 완료 후 해당 zip파일 삭제
			    //File file = new File(zipFile);
			    //file.delete();
			}

		} catch (Exception e) {
			e.printStackTrace();
			logger.error("파일 다운로드 에러");
		}
	}
}
