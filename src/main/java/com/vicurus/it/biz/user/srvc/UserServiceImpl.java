package com.vicurus.it.biz.user.srvc;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.vicurus.it.core.common.Util;
import com.vicurus.it.core.common.WebUtil;
import com.vicurus.it.core.file.cntr.FileRenamePolicy;
import com.vicurus.it.core.waf.mvc.IFileRenamePolicy;
import com.vicurus.it.biz.user.srvc.intf.UserService;


@Repository
public class UserServiceImpl implements UserService {
	
	//config.properties 에서 설정 정보 가져오기 시작
	private static String NAMESPACE;
			
	@Value("#{config['db.vendor']}")
	public void setNAMESPACE(String value) {
		this.NAMESPACE = value + ".";
	}
	//config.properties 에서 설정 정보 가져오기 끝
	
	@Autowired
	@Resource(name="sqlSession")
	private SqlSession query;
	
	@Value("#{config['file.imgDir']}")
	private String imgDir;
	
	@Value("#{config['file.thumbnailDir']}")
    private String thumbnailDir;
	
	@Value("#{config['file.thumbnail280Dir']}")
    private String thumbnail280Dir;
	
	@Value("#{config['file.fileSizeLimits']}")
	private String fileSizeLimits;
	private static final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);

	@Override
	public List deptList(HttpServletRequest request, HttpServletResponse response) {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		List deptList = query.selectList(NAMESPACE+"biz_dept.deptList", paramMap);
		return deptList;
	}

	@Override
	@Transactional
	public int userDeptModify(HttpServletRequest request, List paramList) throws Exception {
		Util util = new Util();
		int result = 0;
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		for(int i=0; i<paramList.size(); i++){
			result += query.update(NAMESPACE+"biz_dept.user_dept_modify",paramList.get(i));
		}
		return result;
	}

	@Override
	public List authgrp_info(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List resultList = query.selectList(NAMESPACE+"icm_approvalManagement.authgrp_info");
		return resultList;
	}

	@Override
	public List apploval_type_info(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List resultList = query.selectList(NAMESPACE+"icm_approvalManagement.apploval_type_info");
		return resultList;
	}

	@Override
	public Map userDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		Map resutlMap = new HashMap(); 
		Map userDetail = query.selectOne(NAMESPACE+"biz_dept.userDetail",paramMap);
		List positionList = query.selectList(NAMESPACE+"biz_dept.positionList");
		
		resutlMap.put("userDetail",userDetail);
		resutlMap.put("positionList",positionList);
		
		return resutlMap;
	}
	
	@Override
	public Map userDetailForSign(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		Map userDetail = query.selectOne(NAMESPACE+"biz_dept.userDetailForSign",paramMap);
		return userDetail;
	}
	@Override
	public Map checkId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		Integer result = query.selectOne(NAMESPACE+"Login.ChkId",paramMap);
		Map resultMap = new HashMap();
		resultMap.put("result", result);
		
		return resultMap;
	}

	@Override
	public Map userModify(final MultipartHttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		paramMap = ImageUpload(request,paramMap);	
		
		result = query.update(NAMESPACE+"biz_dept.userModify",paramMap);
		Map resultMap = new HashMap();
		resultMap.put("result", result);
		return resultMap;
	}

	@Override
	public Map userPerInsert(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		result = query.insert(NAMESPACE+"biz_dept.userPerInsert",paramMap);
		Map resultMap = new HashMap();
		resultMap.put("result", result);
		return resultMap;
	}

	@Override
	@Transactional
	public Map userPerDelete(List paramList) throws Exception {
		Map resultMap = new HashMap();
		
		int result = 0;
		for(int i=0; i<paramList.size(); i++){
			result += query.update(NAMESPACE+"biz_dept.userPerDelete",paramList.get(i));
		}
		resultMap.put("result", result);
		return resultMap;
	}

	@Override
	public Map deptAdd(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		Map resultMap = new HashMap();
		String updetp_code = String.valueOf(paramMap.get("deptAddModal_updept_code"));
		if(updetp_code.equals("0")){
			int topcheckCnt = query.selectOne(NAMESPACE+"biz_dept.topdeptExistCheck",paramMap);
			if(topcheckCnt == 0){
				result = query.insert(NAMESPACE+"biz_dept.deptInsert", paramMap);
			}else{
				result = -2;
			}
		}else{
			int checkCnt = query.selectOne(NAMESPACE+"biz_dept.deptExistCheck",paramMap);
			if(checkCnt == 0){
				result = query.insert(NAMESPACE+"biz_dept.deptInsert", paramMap);
			}else{
				result = -1;
			}
		}
		resultMap.put("result", result);
		return resultMap;
	}

	@Override
	@Transactional
	public Map deptRemove(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		Map resultMap = new HashMap();
		result += query.delete(NAMESPACE+"biz_dept.userDeleteCon",paramMap);
		result += query.delete(NAMESPACE+"biz_dept.deptDeleteCon",paramMap);
		resultMap.put("result", result);
		return resultMap;
	}

	@Override
	@Transactional
	public Map approvalLineSave(Map paramMap) throws Exception {
		Map resultMap = new HashMap();
		List mainList = new ArrayList();
		List subList = new ArrayList();
		mainList = (List) paramMap.get("first");
		subList = (List) paramMap.get("second");
		int mainListSize = mainList.size();
		int subListSize = subList.size();
		logger.info("main : {}", mainList);
		logger.info("subList : {}", subList);
		int result = 0;
		for(int i=0; i<mainListSize; i++){
			Map mainMap = (Map) mainList.get(i);
			result += query.delete(NAMESPACE+"icm_approvalManagement.approvalLine_delete",mainMap);
			for(int j=0; j<subListSize; j++){
				Map subMap = new HashMap();
				subMap = (Map) subList.get(j);
				subMap.put("emp_code", mainMap.get("emp_code"));
				subMap.put("gwdoc_type", mainMap.get("gwdoc_type"));
				result += query.update(NAMESPACE+"icm_approvalManagement.approvalLine_insert",subMap);
			}
		}

		resultMap.put("result", result);
		return resultMap;
	}

	@Override
	public Map approvalLineDelete(List paramList) throws Exception {
		Map resultMap = new HashMap();
		int result = 0;
		int listSize = paramList.size();
		for(int i=0; i<listSize; i++){
			result += query.delete(NAMESPACE+"icm_approvalManagement.approvalLine_delete",paramList.get(i));
		}
		resultMap.put("result", result);
		return resultMap;
	}
	
	public Map ImageUpload(final MultipartHttpServletRequest multipartRequest, Map paramMap) throws Exception {
		logger.debug("ImageInfoUpload");
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
		MultipartFile signimg = (MultipartFile)fileGroup.get("userDetailModal_signimg_dir");// input:file 의 name과 매핑 
		MultipartFile stampimg = (MultipartFile)fileGroup.get("userDetailModal_stampimg_dir");
		List fileList = new ArrayList();
		fileList.add(signimg);
		fileList.add(stampimg);
		
		for(int i=0; i<fileList.size(); i++){
			String file_result = "";
			MultipartFile file = (MultipartFile) fileList.get(i);
			if(file!=null && !file.isEmpty()){
				String fileName = new String( file.getOriginalFilename());
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
					int dot = saveFile.getName().lastIndexOf(".");
					String ext = saveFile.getName().substring(dot);
					ext = ext.toLowerCase();
					renamePolicy = new FileRenamePolicy(ThumbnailFolder, curYear, curMonth, curDay);
					renamePolicy = new FileRenamePolicy(Thumbnail_280_Folder, curYear, curMonth, curDay);
					file_result += imgDir + saveDir + saveFile.getName();
				}
				paramMap.put(i == 0?"userDetailModal_signimg_dir":"userDetailModal_stampimg_dir", file_result);
			}
		}
		return paramMap;
	}
	public File renameFile(File file, String directory) {
        File rFile = null;
        if (file != null) {
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
	public boolean renameFile(File srcFile, File desFile) {
        return !desFile.exists() && srcFile.renameTo(desFile);
    }

	@Override
	public Map deptUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		Map resultMap = new HashMap();
		result += query.delete(NAMESPACE+"biz_dept.deptUpdate",paramMap);
		resultMap.put("result", result);
		return resultMap;
	}

	@Override
	public Map userPasswordReset(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		int result = 0;
		Map resultMap = new HashMap();
		result = query.update(NAMESPACE+"biz_dept.userPasswordReset",paramMap);
		resultMap.put("result", result);
		return resultMap;
	}

	@Override
	public int allUserPwInit(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int result = 0;
		Map resultMap = new HashMap();
		result = query.update(NAMESPACE+"biz_dept.allUserPwInit",paramMap);
		
		return result;
	}

	@Override
	public int allUserStatusUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request,false);	//폼에서 날아오는 모든 파라메터 담음(싱글)
		
		int result = 0;
		Map resultMap = new HashMap();
		result = query.update(NAMESPACE+"biz_dept.allUserStatusUpdate",paramMap);
		
		return result;
	}
}
