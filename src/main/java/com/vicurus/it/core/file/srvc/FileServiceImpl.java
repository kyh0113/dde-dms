package com.vicurus.it.core.file.srvc;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.PixelGrabber;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.jfree.util.Log;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.vicurus.it.core.common.Util;
import com.vicurus.it.core.common.WebUtil;
import com.vicurus.it.core.file.cntr.FileRenamePolicy;
import com.vicurus.it.core.file.srvc.intf.FileService;
import com.vicurus.it.core.waf.mvc.IFileRenamePolicy;
import com.yp.common.srvc.FixtureHistoryService;


@Service("FileService")
public class FileServiceImpl implements FileService {

	//config.properties 에서 설정 정보 가져오기 시작
	private static String NAMESPACE;
			
	@Value("#{config['db.vendor']}")
	public void setNAMESPACE(String value) {
		this.NAMESPACE = value + ".";
	}
	//config.properties 에서 설정 정보 가져오기 끝
	
	@Autowired
    @Qualifier("sqlSession")
	private SqlSession query;
	
	
	//config.properties 에서 설정 정보 가져오기 시작
	@Value("#{config['file.permitExt_Image']}")
    private String permitExt_Image;
	
	@Value("#{config['file.permitExt_Common']}")
	private String permitExt_Common;
	
	@Value("#{config['file.commonDir']}")
	private String commonDir;
	
	@Value("#{config['file.imgDir']}")
	private String imgDir;
	
	@Value("#{config['file.thumbnailDir']}")
    private String thumbnailDir;
	
	@Value("#{config['file.thumbnail280Dir']}")
    private String thumbnail280Dir;
	
	@Value("#{config['file.fileSizeLimits']}")
    private String fileSizeLimits;
	//config.properties 에서 설정 정보 가져오기 끝
	private static final Logger logger = LoggerFactory.getLogger(FileServiceImpl.class);
	
	@Autowired
	private FixtureHistoryService history;
	
	@Override
	@Transactional // (중요) *Transaction 관리시 선언해 준다.
	public String webFileUpload(HttpServletRequest request) throws Exception{
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		boolean file_id_YN = false;													//파일번호 여부
		String result_code = null;													//리턴 변수
		IFileRenamePolicy renamePolicy = null;										//첨부파일리네임 객체 선언
		String curYear = Integer.toString(WebUtil.getYear());						//현재 년도 가져오기
		String curMonth = Integer.toString(WebUtil.getMonth());						//현재 월 가져오기
		if (curMonth.length() == 1) curMonth = "0" + curMonth;						//현재 월 1자리를 2자리로 변경
		String curDay = Integer.toString(WebUtil.getDay());							//현재 일 가져오기
		if (curDay.length() == 1) curDay = "0" + curDay;							//현재 일 1자리를 2자리로 변경
		long file_size_limits = Integer.parseInt(fileSizeLimits) * 1024 * 1024;		//첨부파일 용량제한 MB단위 설정(1024 byte= 1KB)
		
		String saveDir = curYear + "/" + curMonth + "/" + curDay + "/";		//첨부파일 담을 현재날짜 디렉토리
		String realFolder = imgDir;											//실제 첨부파일 홈디렉토리
		String ThumbnailFolder = thumbnailDir;								//실제 첨부파일 썸네일 홈디렉토리
		String Thumbnail_280_Folder = thumbnail280Dir;						//실제 첨부파일 썸네일280 홈디렉토리
		
		MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest) request;
		
		List<MultipartFile> files = multipartRequest.getFiles("afile");		//폼에서 넘어온 파일 담기(등록모드)
		
		if(files.isEmpty()){												//폼에서 넘어온 파일 담기(수정모드)
			files = multipartRequest.getFiles("e_afile");
		}
		if(paramMap.get("file_id") != null ){								//첨부파일 있는 경우
			file_id_YN = true;
		}
		
		 for(MultipartFile file : files){
			 
			 if(!file.isEmpty()){
	                //String fileName = new String( file.getOriginalFilename().getBytes( "8859_1"), "UTF-8");

				 	String fileName = new String( file.getOriginalFilename());			//파일명 가져오기
				 	fileName = FilenameUtils.getBaseName(file.getOriginalFilename()) + '.' + FilenameUtils.getExtension(file.getOriginalFilename());
	                long fileSize = file.getSize();										//파일 사이즈 가져오기

	                //System.out.println(fileName+" - "+fileSize);
	                
	                renamePolicy = new FileRenamePolicy(realFolder, curYear, curMonth, curDay);	//첨부파일 디렉토리 유무 체크 및 생성
	                
	                File ufile = new File(realFolder + saveDir, fileName);    			//file 객체 생성(ex:홈디렉토리/2016/08/08/xxx.txt)
	                
	                //System.out.println("ufile은  "+ ufile);            

	                String file_name= fileName;            								//Map에 담을 파일명 생성

	                //System.out.println("file_name은  "+ file_name);

	                String file_size = Integer.toString((int)file.getSize());			//Map에 담을 파일사이즈 생성

	                //System.out.println("file_size은  "+ file_size);            

	                String file_path = realFolder+saveDir;    							//Map에 담을 파일경로 생성

	                //System.out.println("file_path은  "+ file_path);
	                //System.out.println("file_size_limits = " + file_size_limits);
	                //System.out.println("fileSize = " + fileSize);
	                if(file_size_limits < fileSize){									//파일크기가 10MB 이상인 경우
	                	result_code = "-1";
	                	return result_code;
	                }else{																//파일크기가 10MB 이하인 경우
		                //파일 저장 
		                File saveFile = renameFile(ufile, realFolder+saveDir);			//파일명 변경 후 저장(현재시간+"_"+파일명)
		                file.transferTo(saveFile);										//해당 경로로 파일 복사								
		                
		                paramMap.put("file_name", file_name);							//Map에 파일명 담기
		                paramMap.put("file_size", file_size);							//Map에 파일사이즈 담기
		                paramMap.put("file_path", file_path+saveFile.getName());		//Map에 파일경로 담기            
		                
		                //썸네일 만들기
		                int dot = saveFile.getName().lastIndexOf(".");					//파일 확장자 추출
		                String ext = saveFile.getName().substring(dot);					//파일 확장자 추출
		                ext = ext.toLowerCase();										//파일 확장자 소문자로 변경
		                paramMap.put("file_type", ext);									//Map에 파일확장자 담기
		                
		                renamePolicy = new FileRenamePolicy(ThumbnailFolder, curYear, curMonth, curDay);			//썸네일 디렉토리 유무 체크 및 생성
		                renamePolicy = new FileRenamePolicy(Thumbnail_280_Folder, curYear, curMonth, curDay);		//썸네일280 디렉토리 유무 체크 및 생성
		                
		                if (ext.equals(".jpg") || ext.equals(".bmp") || ext.equals(".png") || ext.equals(".gif")) {	//이미지파일 확장자인 경우 썸네일 생성
		                	File orgFile = new File(file_path+saveFile.getName()); 									//해당 경로의 첨부파일 가져오기
		                	File destFile = new File(ThumbnailFolder + saveDir + saveFile.getName());				//썸네일 디렉토리에 파일 생성
		                	File destFile_208 = new File(Thumbnail_280_Folder + saveDir + saveFile.getName());		//썸네일280 디렉토리에 파일 생성
		  				  
			  				Image srcImg = ImageIO.read(orgFile);													//이미지 파일 읽기
			  				int srcWidth = srcImg.getWidth(null);													//이미지 파일 가로길이 가져오기
		  				
			  				//썸네일 생성
			  				if(srcWidth >= 800){																	//이미지 가로길이가 800 이상이면
			  					//System.out.println("사이즈는 800이상");
			  					resize(orgFile, destFile, 800, -1);													//이미지 사이즈 변경(가로 800 X 세로 비율)
			  				}else if(srcWidth < 800){																//이미지 가로길이가 800 미만이면
			  					//System.out.println("사이즈는 800이하");
			  					resize(orgFile, destFile, 0, 0);													//이미지 사이즈 변경(원래 가로길이 X 원래 세로길이)
			  				}
			  				
			  				//썸네일280 생성
			  				if(srcWidth >= 280){																	//이미지 가로길이가 280 이상이면
			  					//System.out.println("사이즈는 280이상");
			  					resize(orgFile, destFile_208, 280, -1);												//이미지 사이즈 변경(가로 270 X 세로 비율)
			  				}else if(srcWidth < 280){																//이미지 가로길이가 280 미만이면
			  					//System.out.println("사이즈는 280이하");
			  					resize(orgFile, destFile_208, 0, 0);												//이미지 사이즈 변경(원래 가로길이 X 원래 세로길이)
			  				}
			  				
			  				paramMap.put("Thumbnail", ThumbnailFolder + saveDir + saveFile.getName());				//Map에 썸네일 경로 담기
			                paramMap.put("Thumbnail_280", Thumbnail_280_Folder + saveDir + saveFile.getName());		//Map에 썸네일280 경로 담기
			                paramMap.put("represent_yn", "N");														//Map에 대표이미지여부 담기
			  				
		                }else{																						//이미지 파일 아닌경우
		                	paramMap.put("Thumbnail", "");															//Map에 썸네일 경로 담기
			                paramMap.put("Thumbnail_280", "");														//Map에 썸네일280 경로 담기
			                paramMap.put("represent_yn", "N");														//Map에 대표이미지여부 담기
		                }
		                
		                
		                //DB 저장
		                if(file_id_YN == false){								//기존에 첨부파일 미등록인 경우
		                	file_id_YN = true;
		                	paramMap.put("represent_yn", "Y");					//최초 첨부파일 등록시 대표이미지여부 "Y"		                	
		                }
		                //System.out.println("파일 DB저장 전 파라메터?"+paramMap.toString());
		                int result = query.insert(NAMESPACE+"File.InsertFile", paramMap);	//DB에 저장
		                
		        		if(result > 0){
		        			//DB저장 완료 
		        			result_code = Integer.toString(result);
		        		}
		           		
		                
	                }
	            }
			 }
			return result_code;
	}
	
	@SuppressWarnings({ "rawtypes", "unused", "unchecked" })
	@Override
	public String ImageInfoUpload(final MultipartHttpServletRequest multipartRequest, Map paramMap) throws Exception {
		logger.debug("ImageInfoUpload");
//		Util util = new Util();
//		Map paramMap = util.getParamToMap(request,false);
		paramMap.put("file_idx", 0);
		boolean file_id_YN = false;
		int result_code = 0;
		IFileRenamePolicy renamePolicy = null;
		String curYear = Integer.toString(WebUtil.getYear());
		String curMonth = Integer.toString(WebUtil.getMonth());
		if (curMonth.length() == 1) curMonth = "0" + curMonth;
		String curDay = Integer.toString(WebUtil.getDay());
		if (curDay.length() == 1) curDay = "0" + curDay;
		long file_size_limits = Integer.parseInt(fileSizeLimits) * 1024 * 1024;
		String saveDir = curYear + "/" + curMonth + "/" + curDay + "/";
		String realFolder = imgDir;
		String ThumbnailFolder = thumbnailDir;
		String Thumbnail_280_Folder = thumbnail280Dir;
		//MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		List<MultipartFile> files = multipartRequest.getFiles("photo");// input:file 의 name과 매핑
		if(paramMap.get("file_id") != null ){
			file_id_YN = true;
		}
		for(MultipartFile file : files){
			if(!file.isEmpty()){
				String fileName = new String( file.getOriginalFilename());
				fileName = FilenameUtils.getBaseName(file.getOriginalFilename()) + '.' + FilenameUtils.getExtension(file.getOriginalFilename());
				long fileSize = file.getSize();
				logger.debug(fileName+" - "+fileSize);
				renamePolicy = new FileRenamePolicy(realFolder, curYear, curMonth, curDay);
				File ufile = new File(realFolder + saveDir, fileName);
				String file_name= fileName;
				String file_size = Integer.toString((int)file.getSize());
				String file_path = realFolder+saveDir;
				if(file_size_limits < fileSize){
					result_code = -1;
				}else{
					File saveFile = renameFile(ufile, realFolder+saveDir);
					file.transferTo(saveFile);
					paramMap.put("file_name", file_name);
					paramMap.put("file_size", file_size);
					paramMap.put("file_path", file_path+saveFile.getName());
					int dot = saveFile.getName().lastIndexOf(".");
					String ext = saveFile.getName().substring(dot);
					ext = ext.toLowerCase();
					paramMap.put("file_type", ext);
					renamePolicy = new FileRenamePolicy(ThumbnailFolder, curYear, curMonth, curDay);
					renamePolicy = new FileRenamePolicy(Thumbnail_280_Folder, curYear, curMonth, curDay);
					if (ext.equals(".jpeg") || ext.equals(".jpg") || ext.equals(".bmp") || ext.equals(".png") || ext.equals(".gif")) {
						paramMap.put("Thumbnail", ThumbnailFolder + saveDir + saveFile.getName());
						paramMap.put("Thumbnail_280", Thumbnail_280_Folder + saveDir + saveFile.getName());
						paramMap.put("represent_yn", "N");
					}else{
						paramMap.put("Thumbnail", "");
						paramMap.put("Thumbnail_280", "");
						paramMap.put("represent_yn", "N");
					}
					if(file_id_YN == false){
						file_id_YN = true;
						paramMap.put("represent_yn", "Y");
						result_code = query.insert(NAMESPACE+"File.InsertFileInfo", paramMap);
					}
				}
			}
		}
		logger.debug("paramMap: {}", paramMap);
		return "";	
	}
	@SuppressWarnings({ "rawtypes", "unused", "unchecked" })
	@Override
	public String ImageUpload(final MultipartHttpServletRequest multipartRequest, Map paramMap) throws Exception {
		logger.debug("ImageInfoUpload");
//		Util util = new Util();
//		Map paramMap = util.getParamToMap(request,false);
		paramMap.put("file_idx", 0);
		boolean file_id_YN = false;
		int result_code = 0;
		IFileRenamePolicy renamePolicy = null;
		String curYear = Integer.toString(WebUtil.getYear());
		String curMonth = Integer.toString(WebUtil.getMonth());
		if (curMonth.length() == 1) curMonth = "0" + curMonth;
		String curDay = Integer.toString(WebUtil.getDay());
		if (curDay.length() == 1) curDay = "0" + curDay;
		long file_size_limits = Integer.parseInt(fileSizeLimits) * 1024 * 1024;
		String saveDir = curYear + "/" + curMonth + "/" + curDay + "/";
		String realFolder = imgDir;
		String ThumbnailFolder = thumbnailDir;
		String Thumbnail_280_Folder = thumbnail280Dir;
		//MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String,MultipartFile> fileGroup = multipartRequest.getFileMap();
		MultipartFile file = (MultipartFile)fileGroup.get("Filedata");// input:file 의 name과 매핑
		if(paramMap.get("file_id") != null ){
			file_id_YN = true;
		}
		String file_result = "";
		if(!file.isEmpty()){
			String fileName = new String( file.getOriginalFilename());
			fileName = FilenameUtils.getBaseName(file.getOriginalFilename()) + '.' + FilenameUtils.getExtension(file.getOriginalFilename());
			long fileSize = file.getSize();
			logger.debug(fileName+" - "+fileSize);
			renamePolicy = new FileRenamePolicy(realFolder, curYear, curMonth, curDay);
			File ufile = new File(realFolder + saveDir, fileName);
			String file_name= fileName;
			String file_size = Integer.toString((int)file.getSize());
			String file_path = realFolder+saveDir;
			if(file_size_limits < fileSize){
				result_code = -1;
			}else{
				File saveFile = renameFile(ufile, realFolder+saveDir);
				file.transferTo(saveFile);
				paramMap.put("saveFile", saveFile.getName());
				paramMap.put("file_name", file_name);
				paramMap.put("file_size", file_size);
				paramMap.put("file_path", file_path+saveFile.getName());
				int dot = saveFile.getName().lastIndexOf(".");
				String ext = saveFile.getName().substring(dot);
				ext = ext.toLowerCase();
				paramMap.put("file_type", ext);
				renamePolicy = new FileRenamePolicy(ThumbnailFolder, curYear, curMonth, curDay);
				renamePolicy = new FileRenamePolicy(Thumbnail_280_Folder, curYear, curMonth, curDay);
				if (ext.equals(".jpeg") || ext.equals(".jpg") || ext.equals(".bmp") || ext.equals(".png") || ext.equals(".gif")) {
					paramMap.put("Thumbnail", ThumbnailFolder + saveDir + saveFile.getName());
					paramMap.put("Thumbnail_280", Thumbnail_280_Folder + saveDir + saveFile.getName());
					paramMap.put("represent_yn", "N");
				}else{
					paramMap.put("Thumbnail", "");
					paramMap.put("Thumbnail_280", "");
					paramMap.put("represent_yn", "N");
				}
				if(file_id_YN == false){
					file_id_YN = true;
					paramMap.put("represent_yn", "Y");
//					result_code = query.insert("File.InsertFileInfo", paramMap);
					result_code = query.insert(NAMESPACE+"File.InsertFileInfoTest_first", paramMap);
				}
				file_result += "&bNewLine=true&sFileName="+file_name+"&sFileURL="+"/files/webfile/"+ saveDir + saveFile.getName();
			}
			paramMap.put("file_result", file_result);
		}else{
			file_result += "&errstr=error";
			paramMap.put("file_result", file_result);
		}
		logger.debug("paramMap: {}", paramMap);
		return "";	
	}
	@SuppressWarnings({ "rawtypes", "unused", "unchecked" })
	@Override
	public Map CommonUpload(final MultipartHttpServletRequest multipartRequest, Map paramMap) throws Exception {
		paramMap.put("result_code", 0);
		boolean file_id_YN = false;
		int result_code = 0;
		IFileRenamePolicy renamePolicy = null;
		String curYear = Integer.toString(WebUtil.getYear());
		String curMonth = Integer.toString(WebUtil.getMonth());
		if (curMonth.length() == 1) curMonth = "0" + curMonth;
		String curDay = Integer.toString(WebUtil.getDay());
		if (curDay.length() == 1) curDay = "0" + curDay;
		long file_size_limits = Integer.parseInt(fileSizeLimits) * 1024 * 1024;
		String saveDir = curYear + "/" + curMonth + "/" + curDay + "/";
		String realFolder = commonDir;
		
		//CommonsMultipartResolver commonsMultipartResolver = new CommonsMultipartResolver();
        //MultipartHttpServletRequest multipartRequest = commonsMultipartResolver.resolveMultipart(request);
		
		//MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		
		Map<String,MultipartFile> fileGroup = multipartRequest.getFileMap();
		List<MultipartFile> files = multipartRequest.getFiles("Filedata");// input:file 의 name과 매핑

		int loop_seq = 1;
		String attach_no = "";
		if(paramMap.get("attach_no")==null || paramMap.get("attach_no").equals("NULL")){
			java.text.SimpleDateFormat formatter=new java.text.SimpleDateFormat("yyyyMMddHHmmssSSS"); 
			attach_no = formatter.format(new java.util.Date());
		}else{
			attach_no = (String) paramMap.get("attach_no");
		}
		paramMap.put("attach_no", attach_no);
		for(MultipartFile file : files){
			if(!file.isEmpty()){
				String fileName = new String( file.getOriginalFilename());
				fileName = FilenameUtils.getBaseName(file.getOriginalFilename()) + '.' + FilenameUtils.getExtension(file.getOriginalFilename());
				long fileSize = file.getSize();
				logger.debug(fileName+" - "+fileSize);
				renamePolicy = new FileRenamePolicy(realFolder, curYear, curMonth, curDay);
				File ufile = new File(realFolder + saveDir, fileName);
				String file_name= fileName;
				String file_size = Integer.toString((int)file.getSize());
				String file_path = realFolder+saveDir;
				if(file_size_limits < fileSize){
					paramMap.put("result_code", -1);
					return paramMap;
				}else{
					File saveFile = renameFile(ufile, realFolder+saveDir);
					file.transferTo(saveFile);
					paramMap.put("attach_no", attach_no);
					paramMap.put("sys_file_name", saveFile.getName());
					paramMap.put("src_file_name", file_name);
					paramMap.put("file_size", file_size);
					paramMap.put("file_dir", file_path+saveFile.getName());
					int dot = saveFile.getName().lastIndexOf(".");
					String ext = saveFile.getName().substring(dot);
					ext = ext.toLowerCase();
					paramMap.put("file_type", ext);
					if (permitExt_Common.indexOf(ext) > -1) {
						result_code = query.insert(NAMESPACE+"File.ICMInsertFileInfo", paramMap);
						loop_seq++;
						paramMap.put("result_code", result_code);
					}else{
						paramMap.put("result_code", -1);
						paramMap.put("result_msg", "파일업로드 실패");
						return paramMap;
					}
				}
			}
		}
		logger.debug("paramMap service: {}", paramMap);
		return paramMap;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public int deleteFile(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = query.delete(NAMESPACE+"File.deleteFile", paramMap);
		return result;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public int deleteFileTest(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);
		return query.delete(NAMESPACE+"File.deleteFileTest", paramMap);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map deleteFile_with_deleteBoard(HttpServletRequest request, Map paramMap) throws Exception{
		List deleteFile_list = query.selectList(NAMESPACE+"File.selectFileList_for_delete", paramMap);
		Iterator<HashMap> deleteFile_iter  = deleteFile_list.iterator();
		while(deleteFile_iter.hasNext()){
			HashMap deleteFile_map = deleteFile_iter.next();
			String deleteFile = deleteFile_map.get("file_path").toString();
			File deleteFile_file = new File(deleteFile);
			if(deleteFile_file.exists()){
				if(deleteFile_file.delete()){
					logger.debug(" ** Result of delete file: [{}] {}", deleteFile, "Remove success!");
				}else{
					logger.debug(" ** Result of delete file: [{}] {}", deleteFile, "Remove fail(File not found)..");
				}
			}
			query.delete(NAMESPACE+"File.deleteFileTest", paramMap);
		}
		return paramMap;
	}
	
	/************
	 * 
	 * @param src 			원본 File
	 * @param dest			썸네일 File
	 * @param width			썸네일 width   : 100일 경우: 썸네일 가로가 100, 0일경우: 이미지크기로 썸네일 가로 설정, -1일경우: 비율로 가로 설정
	 * @param height		썸네일 height	 : 100일 경우: 썸네일 세로가 100, 0일경우: 이미지크기로 썸네일 세로 설정, -1일경우: 비율로 세로 설정
	 * @throws Exception
	 */
	@Override
	public void resize(File src, File dest, int width, int height) throws Exception {
		Image srcImg = ImageIO.read(src);
		  int srcWidth = srcImg.getWidth(null);
		  int srcHeight = srcImg.getHeight(null);
		  int destWidth = -1, destHeight = -1;
		  if (width == 0) { 		//가로가 0일경우
		   destWidth = srcWidth; 	//썸네일이미지는 이미지 크기와 동일하게 한다
		  } else if (width > 0) { 
		   destWidth = width; 		//0보다 크면 지정한 크기를 썸네일 가로로 한다.
		  }
		  if (height == 0) { 		//세로가 0일경우
		   destHeight = srcHeight;  //썸네일이미지는 이미지 크기와 동일하게 한다
		  } else if (height > 0) { 
		   destHeight = height; 	//0보다 크면 지정한 크기를 썸네일 세로로 한다.
		  }
		  
		  if(width == -1 && height == -1){  // 가로세로가 -1일경우
			  destWidth = srcWidth;  		//이미지 크기가 썸네일이 된다.
			  destHeight = srcHeight;
		  }else if(width==-1){ 				// 가로만 -1일 경우 세로를 기준으로 가로 비율을 맞춘다. 
		     double ratio = ((double)destHeight)/((double)srcHeight);
		     destWidth=(int)((double)srcHeight*ratio);
		  }else if(height==-1){ 			// 세로만 -1일 경우 가로를 기준으로 세로 비율을 맞춘다.
		     double ratio = ((double)destWidth)/((double)srcWidth);
		     //System.out.println(ratio);
		     //System.out.println(destHeight);
		     destHeight=(int)((double)srcHeight*ratio);
		  }
		  Image imgTarget = srcImg.getScaledInstance(destWidth, destHeight, Image.SCALE_SMOOTH);
		  int pixels[] = new int[destWidth * destHeight];
		  PixelGrabber pg = new PixelGrabber(imgTarget, 0, 0, destWidth, destHeight, pixels, 0, destWidth);
		  try {
		   pg.grabPixels();
		  } catch (InterruptedException e) {
		   throw new IOException(e.getMessage());
		  } catch (Exception e) {
		   e.printStackTrace();
		  }
		  //System.out.println("destWidth = " + destWidth);
		  //System.out.println("destHeight = " + destHeight);
		  BufferedImage destImg = new BufferedImage(destWidth, destHeight, BufferedImage.TYPE_INT_RGB);
		  destImg.setRGB(0, 0, destWidth, destHeight, pixels, 0, destWidth);
		  ImageIO.write(destImg, "jpg", dest);
	}
	
	@Override
	public File renameFile(File file, String directory) {
        File rFile = null;
        if (file != null) {
//        	쓸데없는 짓 하지마라 - 나중에 파일 찾을 수 없다.
//			String fileName = System.currentTimeMillis() + "_" + getFileName(file.getName());
//			logger.debug("fileName {}", file.getName());
			String fileName = System.currentTimeMillis() + "_" + file.getName();
//			logger.debug("fileName {}", fileName);
            rFile = new File(directory, fileName); 
            file.renameTo(rFile);
            
            if(rFile.exists()==true){  //파일명 중복일경우
	            String name = fileName;
	            String body = null;
	            String ext = null;
	
	            int dot = name.lastIndexOf(".");
	            if (dot != -1) {
	                body = name.substring(0, dot);
	                ext = name.substring(dot);  // "." 포함
	            } else {
	                body = name;
	                ext = "";
	            }
	            int count = 0;
	            while (!renameFile(file, rFile) && count < 9999) {
					count++;
					String newName = body + count + ext;
					rFile = new File(directory, newName);
	            }
            }
        }else { //유니크한 파일명일경우
        	//아무것도 안함
        }
        return rFile;
    }
	
	/**
     * 한글 문자를 영문자로 변환한 파일명을 반환한다.
     * 불포함 확장자가 있을경우 확장자를 변환한다.
     * @param str
     * @return
     */
    public String getFileName(String str) {
        String result = str;
        if (str != null) {
            StringBuffer sb = new StringBuffer();
            char[] charArray = str.toCharArray();
            for (int i = 0; i < charArray.length; i++) {    
                if (charArray[i] > 127) {
                    sb.append(Integer.toHexString((int)(charArray[i])).toUpperCase());
                } else {
                    sb.append(charArray[i]);
                }
            }
            
            
            
            // 확장자 검사
            // 확장자가 jsp, asp, php일 경우 확장자를 바꿔준다.
            int dot = sb.lastIndexOf(".");
            if (dot != -1) {
                String ext = sb.substring(dot);  // "." 포함
                if (".jsp".equalsIgnoreCase(ext) || ".asp".equalsIgnoreCase(ext) || ".php".equalsIgnoreCase(ext)
                    	|| ".inc".equalsIgnoreCase(ext) 
//                    	|| ".htm".equalsIgnoreCase(ext)  || ".html".equalsIgnoreCase(ext)
                    	|| ".phtml".equalsIgnoreCase(ext) || ".php3".equalsIgnoreCase(ext)|| ".js".equalsIgnoreCase(ext)
                    	|| ".cgi".equalsIgnoreCase(ext) || ".php4".equalsIgnoreCase(ext)
                    	) {
                    sb.append(".xxx");
                }
            }
            
            result = sb.toString();
        }
        return result;
    }
	
	public boolean renameFile(File srcFile, File desFile) {
        return !desFile.exists() && srcFile.renameTo(desFile);
    }
	
	@Override
	@Transactional
	public String fileDown(HttpServletRequest request) throws Exception{
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		
		String uploadDir = (String)paramMap.get("file_path");
		return null;
	}
	
	@Override
	@Transactional
	public String fileRepresent(HttpServletRequest request) throws Exception{
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)

		int result = query.update(NAMESPACE+"File.UpdateRepresent_N", paramMap);
		if(result > 0){
			result = query.update(NAMESPACE+"File.UpdateRepresent_Y", paramMap);
		}
		return Integer.toString(result);
	}
	
	@Override
	@Transactional
	public String fileDelete(HttpServletRequest request) throws Exception{
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = query.delete(NAMESPACE+"File.DeleteFile_sample", paramMap);
		return Integer.toString(result);
	}
         
    /**
     * 축소될 width값을 가지고 비율에 맞게 height를 구한다
     * @param orgWidth         원본width
     * @param orgHeight        원본 height
     * @param width   		   변경될 width
     * @return
     */
	public int getRatioHeight(int orgWidth, int orgHeight, int width) {
		return orgHeight / (orgWidth / width);
	}

	/**
	 * ICM FILE
	 * 하태현
	 * **/
	@Override
	public List FileList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		List resultList = query.selectList(NAMESPACE+"File.ICMFileList", paramMap);
		return resultList;
	}

	@Override
	public int icmFileDelete(HttpServletRequest request, HttpServletResponse response) {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = -1;
		File file = new File((String) paramMap.get("file_dir"));
		if(file.delete()) {
			result = query.delete(NAMESPACE+"File.ICMFileDelete", paramMap);
		}
		
		return result;
	}

	@Override
	public int xlsxUpload(MultipartFile file, MultipartHttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		//System.out.println("[xlsxUpload]paramMap:"+paramMap);
		int result = 0;
		try {
			Map insertCellMap = new HashMap();
			List key = new ArrayList();
			String insertQuery = (paramMap.get("insertQuery")==null)?"":(String) paramMap.get("insertQuery");
			String updateQuery = (paramMap.get("updateQuery")==null)?"":(String) paramMap.get("updateQuery");
			String deleteQuery = (paramMap.get("deleteQuery")==null)?"":(String) paramMap.get("deleteQuery");
			String deleteQuery2 = (paramMap.get("deleteQuery2")==null)?"":(String) paramMap.get("deleteQuery2");
			String deleteQuery3 = (paramMap.get("deleteQuery3")==null)?"":(String) paramMap.get("deleteQuery3");
			if(!updateQuery.equals("")) {
				result = query.update(updateQuery,paramMap);
			}
			if(!deleteQuery.equals("")) {
				result = query.delete(deleteQuery,paramMap);
			}
			if(!deleteQuery2.equals("")) {
				result = query.delete(deleteQuery2,paramMap);
			}
			if(!deleteQuery3.equals("")) {
				result = query.delete(deleteQuery3,paramMap);
			}

			int i = 0;
			// Creates a workbook object from the uploaded excelfile
			XSSFWorkbook workbook = new XSSFWorkbook(file.getInputStream());

			// Creates a worksheet object representing the first sheet
			XSSFSheet worksheet = workbook.getSheetAt(0);

			// Reads the data in excel file until last row is encountered
			while (i <= worksheet.getLastRowNum()) {			
				// Creates an object representing a single row in excel
				XSSFRow row = worksheet.getRow(i++);
				if(i==1) {
					for(int j=0; j<row.getLastCellNum(); j++){
						key.add(row.getCell(j).getStringCellValue());
					}
					//System.out.println(key.toString());
					insertCellMap.putAll(paramMap);
					continue;
				}

				//2번쨰 행 건너뛰기
				if(i==2){ continue; }
				//if(i==3){ continue; }

				for(int j=0; j<row.getLastCellNum(); j++) {
					String cellValue = "";
					if(row.getCell(j) != null) {
						row.getCell(j).setCellType(XSSFCell.CELL_TYPE_STRING);
						cellValue = row.getCell(j).getStringCellValue();
					}
					insertCellMap.put(key.get(j), cellValue);
				}

				insertCellMap.put("index", i-3);
				logger.debug("insertCellMap:"+insertCellMap);
				result = query.insert(insertQuery, insertCellMap);

			}	
			//workbook.close();
			String updateQueryFinal = (paramMap.get("updateQueryFinal")==null)?"":(String) paramMap.get("updateQueryFinal");
			if(!updateQueryFinal.equals("")) {
				result += query.update(updateQueryFinal,paramMap);
			}
			String insertQueryFinal = (paramMap.get("insertQueryFinal")==null)?"":(String) paramMap.get("insertQueryFinal");
			if(!insertQueryFinal.equals("")) {
				result += query.insert(insertQueryFinal,paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception();
		}
 
		return result;
	}

	@Override
	public int xlsxUpload_Mon(MultipartFile file, MultipartHttpServletRequest request, HttpServletResponse response, ArrayList<String> KOSTLLIST, HashMap<String, String> KOSTMAP) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		//System.out.println("[xlsxUpload]paramMap:"+paramMap);
		int result = 0;
		try {
			Map insertCellMap = new HashMap();
			List key = new ArrayList();
			String insertQuery = (paramMap.get("insertQuery")==null)?"":(String) paramMap.get("insertQuery");
			String updateQuery = (paramMap.get("updateQuery")==null)?"":(String) paramMap.get("updateQuery");
			String deleteQuery = (paramMap.get("deleteQuery")==null)?"":(String) paramMap.get("deleteQuery");
			String deleteQuery2 = (paramMap.get("deleteQuery2")==null)?"":(String) paramMap.get("deleteQuery2");
			String deleteQuery3 = (paramMap.get("deleteQuery3")==null)?"":(String) paramMap.get("deleteQuery3");
			if(!updateQuery.equals("")) {
				result = query.update(updateQuery,paramMap);
			}
			if(!deleteQuery.equals("")) {
				result = query.delete(deleteQuery,paramMap);
			}
			if(!deleteQuery2.equals("")) {
				result = query.delete(deleteQuery2,paramMap);
			}
			if(!deleteQuery3.equals("")) {
				result = query.delete(deleteQuery3,paramMap);
			}

			int i = 0;
			// Creates a workbook object from the uploaded excelfile
			XSSFWorkbook workbook = new XSSFWorkbook(file.getInputStream());

			// Creates a worksheet object representing the first sheet
			XSSFSheet worksheet = workbook.getSheetAt(0);

			// Reads the data in excel file until last row is encountered
			while (i <= worksheet.getLastRowNum()) {			
				// Creates an object representing a single row in excel
				XSSFRow row = worksheet.getRow(i++);
				if(i==1) {
					for(int j=0; j<row.getLastCellNum(); j++) {
						key.add(row.getCell(j).getStringCellValue());
					}
					//System.out.println(key.toString());
					insertCellMap.putAll(paramMap);
					continue;
				}

				//2번쨰 행 건너뛰기
				if(i==2){ continue; }

				for(int j=0; j<row.getLastCellNum(); j++) {
					String cellValue = "";
					if(row.getCell(j) != null) {
						row.getCell(j).setCellType(XSSFCell.CELL_TYPE_STRING);

						if(j == 5) {	//코스트센터 코드 정합성 체크
							if(KOSTLLIST.contains(row.getCell(j).getStringCellValue())) {
								//System.out.println("유효한 코스트센터코드입니다.");
								cellValue = cellValue = row.getCell(j).getStringCellValue();					   //코스트센터 코드 담기
								insertCellMap.put("COST_NAME", KOSTMAP.get(row.getCell(j).getStringCellValue()));  //코스트센터명  담기
							} else {
								//System.out.println("유효하지않은 코스트센터코드입니다.");
								cellValue = "";						 //코스트센터 코드 담기
								insertCellMap.put("COST_NAME", "");  //코스트센터명  담기
							}
						} else {
							cellValue = row.getCell(j).getStringCellValue();	
						}
						//System.out.println("key?"+key.get(j)+"::value?"+cellValue);
					}
					insertCellMap.put(key.get(j), cellValue);
				}

				insertCellMap.put("index", i-3);
				logger.debug("insertCellMap:"+insertCellMap);
				result = query.insert(insertQuery, insertCellMap);

			}
			//workbook.close();
			String updateQueryFinal = (paramMap.get("updateQueryFinal")==null)?"":(String) paramMap.get("updateQueryFinal");
			if(!updateQueryFinal.equals("")) {
				result += query.update(updateQueryFinal,paramMap);
			}
			String insertQueryFinal = (paramMap.get("insertQueryFinal")==null)?"":(String) paramMap.get("insertQueryFinal");
			if(!insertQueryFinal.equals("")) {
				result += query.insert(insertQueryFinal,paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception();
		}
 
		return result;
	}

	
		
	@Override
	public int xlsxUpload_Inv(MultipartFile file, MultipartHttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		//System.out.println("[xlsxUpload]paramMap:"+paramMap);
		int result = 0;
		try {
			Map insertCellMap = new HashMap();
			List key = new ArrayList();
			String insertQuery = (paramMap.get("insertQuery")==null)?"":(String) paramMap.get("insertQuery");
			String updateQuery = (paramMap.get("updateQuery")==null)?"":(String) paramMap.get("updateQuery");
			String deleteQuery = (paramMap.get("deleteQuery")==null)?"":(String) paramMap.get("deleteQuery");
			String deleteQuery2 = (paramMap.get("deleteQuery2")==null)?"":(String) paramMap.get("deleteQuery2");
			String deleteQuery3 = (paramMap.get("deleteQuery3")==null)?"":(String) paramMap.get("deleteQuery3");
			if(!updateQuery.equals("")) {
				result = query.update(updateQuery,paramMap);
			}
			if(!deleteQuery.equals("")) {
				result = query.delete(deleteQuery,paramMap);
			}
			if(!deleteQuery2.equals("")) {
				result = query.delete(deleteQuery2,paramMap);
			}
			if(!deleteQuery3.equals("")) {
				result = query.delete(deleteQuery3,paramMap);
			}

			int i = 0;
			// Creates a workbook object from the uploaded excelfile
			XSSFWorkbook workbook = new XSSFWorkbook(file.getInputStream());

			// Creates a worksheet object representing the first sheet
			XSSFSheet worksheet = workbook.getSheetAt(3);

			// Reads the data in excel file until last row is encountered
			while (i <= worksheet.getLastRowNum()) {			
				// Creates an object representing a single row in excel
				XSSFRow row = worksheet.getRow(i++);
				if(i==1) {
					for(int j=0; j<row.getLastCellNum(); j++) {
						key.add(row.getCell(j).getStringCellValue());
					}
					//System.out.println(key.toString());
					insertCellMap.putAll(paramMap);
					continue;
				}

				//1,2,3번쨰 행 건너뛰기
				//if(i==1){ continue; }
				if(i==2){ continue; }
				if(i==3){ continue; }

				for(int j=0; j<row.getLastCellNum(); j++) {
					String cellValue = "";
					if(row.getCell(j) != null) {
						row.getCell(j).setCellType(XSSFCell.CELL_TYPE_STRING);
						cellValue = row.getCell(j).getStringCellValue();
					}
					insertCellMap.put(key.get(j), cellValue);
				}

				insertCellMap.put("index", i-3);
				logger.debug("insertCellMap:"+insertCellMap);
				result = query.insert(insertQuery, insertCellMap);

			}	
			//workbook.close();
			String updateQueryFinal = (paramMap.get("updateQueryFinal")==null)?"":(String) paramMap.get("updateQueryFinal");
			if(!updateQueryFinal.equals("")) {
				result += query.update(updateQueryFinal,paramMap);
			}
			String insertQueryFinal = (paramMap.get("insertQueryFinal")==null)?"":(String) paramMap.get("insertQueryFinal");
			if(!insertQueryFinal.equals("")) {
				result += query.insert(insertQueryFinal,paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception();
		}
 
		return result;
	}
	
	
	
	@Override
	public int xlsUpload(MultipartFile file, MultipartHttpServletRequest request, HttpServletResponse response) {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	@Transactional
	public Map xlsxUploadFixture(MultipartFile file, MultipartHttpServletRequest request, HttpServletResponse response, List<String> keyList) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		logger.debug("[xlsxUpload]paramMap:{}:",paramMap);

		int insertCnt = 0;
		int updateCnt = 0;
		Map resultMsg = new HashMap();

		try {
			Map cellMap = new HashMap();
			List<String> keys = new ArrayList<String>();

			String insertQuery = (paramMap.get("insertQuery")==null)?"":(String) paramMap.get("insertQuery");
			String updateQuery = (paramMap.get("updateQuery")==null)?"":(String) paramMap.get("updateQuery");
			String deleteQuery = (paramMap.get("deleteQuery")==null)?"":(String) paramMap.get("deleteQuery");
			String deleteQuery2 = (paramMap.get("deleteQuery2")==null)?"":(String) paramMap.get("deleteQuery2");
			String deleteQuery3 = (paramMap.get("deleteQuery3")==null)?"":(String) paramMap.get("deleteQuery3");

			/**
			 * 데이터를 Merge 시킬거라 update or delte 전처리를 주석처리
			 */
			/*
			if(!updateQuery.equals("")) {
				result = query.update(updateQuery,paramMap);
			}
			if(!deleteQuery.equals("")) {
				result = query.delete(deleteQuery,paramMap);
			}
			if(!deleteQuery2.equals("")) {
				result = query.delete(deleteQuery2,paramMap);
			}
			if(!deleteQuery3.equals("")) {
				result = query.delete(deleteQuery3,paramMap);
			}
			*/

			int i = 0;
			int pkIndex = 0;
			// Creates a workbook object from the uploaded excelfile
			XSSFWorkbook workbook = new XSSFWorkbook(file.getInputStream());

			// Creates a worksheet object representing the first sheet
			XSSFSheet worksheet = workbook.getSheetAt(0);

			logger.debug("[TEST] worksheet.getLastRowNum():{}", worksheet.getLastRowNum());
			// Reads the data in excel file until last row is encountered
			rowLoop :
			while (i <= worksheet.getLastRowNum()) {
				// Creates an object representing a single row in excel
				XSSFRow row = worksheet.getRow(i++);
				if(i==1) {
					for(int j=0; j<row.getLastCellNum(); j++) {
						keys.add(row.getCell(j).getStringCellValue());
					}
					//System.out.println(key.toString());
					cellMap.putAll(paramMap);

					/**
					 * fixture_name(PK) 없으면 예외 처리
					 */
					if(!keys.contains("FIXTURE_NAME")) {
						throw new Exception("Excel에 Pimary Key인 fixture_name 컬럼이 없습니다.");
					}

					/**
					 * Primary Key Index를 찾는다
					 */
					for(int k=0; k<keys.size(); k++) {
						String key = "";
						key = keys.get(k).toString();
						if("FIXTURE_NAME".equals(key)) {
							pkIndex = k;
							break;
						}
					}

					continue;

				}

				//2번째 행 건너뛰기
				if(i==2){ continue; }

				Boolean isExist = false;

				colLoop :
				for(int j=0; j<row.getLastCellNum(); j++) {
					String cellValue = "";
					if(row.getCell(j) != null) {
						row.getCell(j).setCellType(XSSFCell.CELL_TYPE_STRING);
						cellValue = row.getCell(j).getStringCellValue();
					}

					if(pkIndex == j) {
						/**
						 * Insert할지 Update할지 판단
						 */
						if(keyList.contains(cellValue)) {
							isExist = true;
						}
						/**
						 * PK 없으면 빠져나가자
						 */
						if(Util.isEmpty(cellValue)) {
							break rowLoop;
						}
					}

					cellMap.put(keys.get(j), cellValue);
				}

				cellMap.put("index", i-3);
				logger.debug("cellMap:"+cellMap);

				/**
				 * 1줄 씩 Insert 시키고 있음
				 * 나중에 ( , )로 묶어서 일괄 Insert를 시켜도 괜찮을 것 같다.
				 * 새로운 데이터는 Insert, 존재하는 데이터는 Update
				 */
				if (isExist) {
					history.setHistory("master", "U", cellMap);
					updateCnt += query.update(updateQuery, cellMap);
				} else {
					insertCnt += query.insert(insertQuery, cellMap);
					history.setHistory("master", "U", cellMap);
				}
			}		
			//workbook.close();

			//String updateQueryFinal = (paramMap.get("updateQueryFinal")==null)?"":(String) paramMap.get("updateQueryFinal");
			//if(!updateQueryFinal.equals("")) {
				//result += query.update(updateQueryFinal,paramMap);
			//}
			//String insertQueryFinal = (paramMap.get("insertQueryFinal")==null)?"":(String) paramMap.get("insertQueryFinal");
			//if(!insertQueryFinal.equals("")) {
				//result += query.insert(insertQueryFinal,paramMap);
			//}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception();
		}

		resultMsg.put("C", insertCnt); //생성 개수
		resultMsg.put("U", updateCnt); //수정 개수
		resultMsg.put("state", "S"); //상태 성공
 
		return resultMsg;
	}

}
