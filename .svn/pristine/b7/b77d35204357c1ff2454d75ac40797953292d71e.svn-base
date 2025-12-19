package com.yp.common.srvc;

import org.apache.ibatis.session.SqlSession;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.ImageType;
import org.apache.pdfbox.rendering.PDFRenderer;
import org.apache.pdfbox.tools.imageio.ImageIOUtil;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sap.conn.jco.JCoFieldIterator;
import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoParameterField;
import com.sap.conn.jco.JCoParameterFieldIterator;
import com.sap.conn.jco.JCoParameterList;
import com.sap.conn.jco.JCoTable;
import com.vicurus.it.core.common.Util;
import com.vicurus.it.core.file.srvc.intf.FileService;
import com.yp.common.srvc.intf.CommonService;



@Service("CommonService")
public class CommonServiceImpl<SampleMapper> implements CommonService {
	
	// config.properties 에서 설정 정보 가져오기 시작
	@SuppressWarnings("unused")
	private static String NAMESPACE;

	@SuppressWarnings("static-access")
	@Value("#{config['db.vendor']}")
	public void setNAMESPACE(String value) {
		this.NAMESPACE = value + ".";
	}
	
	@SuppressWarnings("unused")
	private static String FILE_HOME_PATH;

	@SuppressWarnings("static-access")
	@Value("#{config['file.uploadDirResource']}")
	public void setFILE_HOME_PATH(String value) {
		this.FILE_HOME_PATH = value;
	}
	// config.properties 에서 설정 정보 가져오기 끝
	
	@Autowired
	private FileService fileService;
	
	@Autowired
	@Resource(name = "sqlSession")
	private SqlSession query;
	
	private static final Logger logger = LoggerFactory.getLogger(CommonService.class);

    
    @Override
    public ArrayList<HashMap<String, String>> pagingListOfERPList(ArrayList<HashMap<String, String>> erpList, int firstidx, int lastidx) throws Exception{
    	
    	ArrayList<HashMap<String, String>> pagingList = new ArrayList<HashMap<String, String>>();
    	
    	if(firstidx > lastidx){
    		int tmp = lastidx;
    		lastidx = firstidx;
    		firstidx = tmp;
    	}
    	if(lastidx > erpList.size()){
    		lastidx = erpList.size();
    	}
    	
    	for(int i=firstidx;i<=lastidx;i++){
    		pagingList.add(erpList.get(i-1));
//    		System.out.println(i);
    	}
//    	logger.debug("pagingListOfERPList = "+pagingList);
    	return pagingList;
    }
    
    /* 영풍 전용 파일업로드 */
    @Override
	public ArrayList<HashMap<String, String>> fileUpload(HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest mRequest) throws Exception{
    	ArrayList<HashMap<String, String>> result_list = new ArrayList<HashMap<String, String>>();
    	
    	Date now = new Date();
    	SimpleDateFormat formatter = new SimpleDateFormat ("yyyyMMddHHmmssSSS");	//동시간 중복 피하기 위해 밀리세컨드까지 사용
    	Iterator<String> files = mRequest.getFileNames();
    
    	while(files.hasNext()){
    		HashMap<String, String> result = new HashMap<String, String>();
    		String foldername = files.next();
        	MultipartFile mFile = mRequest.getFile(foldername);
        	
        	if(mFile == null) return null;
    		String uploadPath = FILE_HOME_PATH + foldername + "/";
    		String preFileName = formatter.format(now) + "_" ;
    		String saveFileName = mFile.getOriginalFilename();
    		
    		saveFileName = saveFileName.substring(saveFileName.lastIndexOf("\\") + 1);	//IE11에선 파일명이 아닌 파일 Full path가 리턴되서 별도처리
    		logger.debug("filename.orgin:"+saveFileName);
    		saveFileName = saveFileName.replaceAll("[^\uAC00-\uD7A30-9a-zA-Z.]", "");	//220330 특수문자 삭제
    		logger.debug("filename.encode:"+saveFileName);
    		
    		String file_url = FILE_HOME_PATH + foldername + "/" + preFileName + saveFileName;
    		logger.debug("fileUpload." + uploadPath);
    		File dir = new File(uploadPath);
    	
    		if (!dir.isDirectory()) {
    			dir.mkdirs();
    		}
    		
    		if(mFile.getOriginalFilename() != null && !mFile.getOriginalFilename().equals("")) {
    			
    			if(new File(uploadPath + preFileName + saveFileName).exists()) {
    				File backupFile = new File(uploadPath + preFileName + saveFileName);
    				backupFile.renameTo(new File(uploadPath + saveFileName+ "_" + System.currentTimeMillis()));
    			}

    			try {
    				mFile.transferTo(new File(uploadPath + preFileName + saveFileName));
    				result.put("uploadPath", uploadPath);
    				result.put("fileName", preFileName + saveFileName);
    				
    				logger.debug("server save path : " + uploadPath + preFileName + saveFileName);
    				
    				//logger.debug("encodeFileName : " + encodeFileName);
    				
    			} catch (IllegalStateException e) {
    				e.printStackTrace();
    				result = null;
    			} catch (Exception e) {
    				e.printStackTrace();
    				result = null;
    			}
    			
    			result_list.add(result);
    		} 
    	}
    	
		return result_list;
    }
    
    /* 영풍 전용 이미지파일 업로드(이미지 보기가 필요한 경우 사용) */
    @Override
	public HashMap<String, String> ImgfileUpload(HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest mRequest) throws Exception{
		HashMap<String, String> result = new HashMap<String, String>();
    	Date now = new Date();
    	SimpleDateFormat formatter = new SimpleDateFormat ("yyyyMMddHHmmssSSS");	//동시간 중복 피하기 위해 밀리세컨드까지 사용
    	Iterator<String> files = mRequest.getFileNames();
    
    	while(files.hasNext()){
    		String foldername = files.next();
        	MultipartFile mFile = mRequest.getFile(foldername);
        	
        	if(mFile == null) {
        		return null;
        	}
        	
    		String uploadPath = FILE_HOME_PATH + foldername + "/";
    		String preFileName = formatter.format(now) + "_" ;
    		String saveFileName = mFile.getOriginalFilename();

    		int dot = saveFileName.lastIndexOf(".");					//파일 확장자 추출
			String ext = saveFileName.substring(dot);					//파일 확장자 추출
			ext = ext.toLowerCase();									//파일 확장자 소문자로 변경

    		saveFileName = saveFileName.substring(saveFileName.lastIndexOf("\\") + 1);	//실제파일명, IE11에선 파일명이 아닌 파일 Full path가 리턴되서 별도처리
    		
    		String file_url = "/uploadFiles/" + foldername + "/" + preFileName + saveFileName;	//상대경로를 포함한 파일명
    	
    		File dir = new File(uploadPath);
    	
    		if (!dir.isDirectory()) {	//디렉토리 유무 확인 후 없으면 생성
    			dir.mkdirs();
    		}
    		
    		if(mFile.getOriginalFilename() != null && !mFile.getOriginalFilename().equals("")) {
    			
    			if(new File(uploadPath + preFileName + saveFileName).exists()) {
    				File backupFile = new File(uploadPath + preFileName + saveFileName);
    				backupFile.renameTo(new File(uploadPath + saveFileName+ "_" + System.currentTimeMillis()));
    			}

    			try {
    				mFile.transferTo(new File(uploadPath + preFileName + saveFileName));
    				result.put(foldername, file_url);
    								
    				logger.debug("server save path : " + uploadPath + preFileName + saveFileName);
    				
    				//logger.debug("encodeFileName : " + encodeFileName);
    				
    				
    				//업로드된 파일이 PDF파일인 경우 첫페이지를 이미지로 컨버트
    				if(ext.equals(".pdf")) {
    					logger.debug("PDF convert to IMG start");
    	                File orgFile = new File(uploadPath + preFileName + saveFileName); 							//해당 경로의 첨부파일 가져오기
    	            	File pdf_to_img = new File(orgFile + ".jpg");
    	            	
    	            	try {
    	            		//pdf to image start
    	                	//String pdfFilename = orgFile.getName();
    	                	//System.out.println("PDF org 파일명??"+orgFile);	//풀 경로
    	                	//System.out.println("PDF 파일명??"+pdfFilename);	//파일명만
    			            PDDocument document = PDDocument.load( orgFile );
    			            PDFRenderer pdfRenderer = new PDFRenderer( document );
    			            //System.out.println( "PDF 전체페이지 수 : " + document.getNumberOfPages() );
    			            BufferedImage bim = pdfRenderer.renderImageWithDPI( 0, 100, ImageType.RGB );

    			            //pdf 첫페이지만 이미지로 생성
    			            ImageIOUtil.writeImage( bim, orgFile + ".jpg", 100 );
    		
    			            document.close();
    	                	//pdf to image end
    			            
    			            Image srcImg = ImageIO.read(pdf_to_img);	
    		  				
    			            int srcWidth = srcImg.getWidth(null);													//이미지 파일 가로길이 가져오기
			  				
			  				//썸네일 생성(pdf to img 파일 그대로 사용시 브라우저에서 view모드시 400에러 발생, 반드시 jpg이미지로 리사이징 필요)
			  				if(srcWidth >= 800){																	//이미지 가로길이가 800 이상이면
			  					fileService.resize(pdf_to_img, pdf_to_img, 800, -1);								//이미지 사이즈 변경(가로 800 X 세로 비율)
			  				}else if(srcWidth < 800){																//이미지 가로길이가 800 미만이면
			  					fileService.resize(pdf_to_img, pdf_to_img, 0, 0);									//이미지 사이즈 변경(원래 가로길이 X 원래 세로길이)
			  				}
    			            
    			            result.put(foldername, file_url+".jpg");	//DB에 저장될 파일 FULL PATH 뒤에 컨버팅 된 이미지파일의 확장자 붙여주기

    	            	}catch(Exception e) {
    	            		logger.debug("PDF to IMG Error:" + e.getMessage());
    	            	}finally {
    	            		//PDF 파일을 성공적으로 썸네일 완료했으면 업로드 폴더 안 pdf파일의 이미지파일은 삭제
    	            		//pdf_to_img.delete();
    	            	}
    	            }
    				
    			} catch (IllegalStateException e) {
    				e.printStackTrace();
    				result = null;
    			} catch (Exception e) {
    				e.printStackTrace();
    				result = null;
    			}
    		} 
    	}
    	
		return result;
    }

    
    /**  */
    @Override
    public List<HashMap<String, String>> code_list(HashMap<String, String> code_data) throws Exception{
    	return query.selectList(NAMESPACE+"Code.select_code_list", code_data);
    }
    
    @Override
	public String getContent(String excute_date) throws Exception{
		Document doc = null;
		logger.debug("getContent.excute_date="+excute_date);
		excute_date = excute_date.replaceAll("-", "");
		try{
			if(excute_date.equals("") || excute_date == null)
			{
				//doc = Jsoup.connect("http://www.koreazinc.co.kr/serviceLME/LMEPRICE.asp").get();
				doc = Jsoup.connect("https://www.sls.sorincorporation.com/Common/LMEPRICE.do").get();
			}
			else
			{
				String cbx_YY = excute_date.substring(0,4);
				String cbx_MM = excute_date.substring(4,6);
				String cbx_DD = excute_date.substring(6,8);
				logger.debug("입력날짜 : "+cbx_YY+"y  "+cbx_MM+" m "+cbx_DD);
				//doc = Jsoup.connect("http://www.koreazinc.co.kr/serviceLME/LMEPRICE.asp?cbx_YY="+cbx_YY+"&cbx_MM="+cbx_MM+"&cbx_DD="+cbx_DD).get();
				doc = Jsoup.connect("https://www.sls.sorincorporation.com/Common/LMEPRICE.do?LME_DATE="+cbx_YY+"-"+"03"+"-"+"31").get();
				logger.info("request url = "+"https://www.sls.sorincorporation.com/Common/LMEPRICE.do?LME_DATE="+cbx_YY+"-"+"03"+"-"+"31");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		//doc = Jsoup.connect("https://www.sls.sorincorporation.com/Common/LMEPRICE.do").timeout(60).get();
		String document = doc.select("div.content").html();
		//logger.info("%%%"+document);
		//logger.info("%%%"+doc);
	
		if(doc.select(".borderT td").text().trim().length() >500){	//data_empty=416,data_not_empty=1802
			
			return document;
		}else{
			return "nodata";
			//return "<div class=\"noData\"><div>검색된 자료가 없습니다.</div></div>";
		}
	}
    
        
}
