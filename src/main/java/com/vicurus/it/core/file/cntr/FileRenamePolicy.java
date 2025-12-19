package com.vicurus.it.core.file.cntr;

import java.io.File;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vicurus.it.core.waf.mvc.IFileRenamePolicy;


/**
 * 첨부파일 네이밍 정책
 * @author 
 *
 */
public class FileRenamePolicy implements IFileRenamePolicy {

	private static final Logger logger = LoggerFactory.getLogger(FileRenamePolicy.class);
	
    protected File directory;
    /**
     * 생성자
     * @param mainType
     */
    public FileRenamePolicy(String uploadDirectory, String mainType) {
        String uploadDirStr = uploadDirectory;
        directory = new File(uploadDirStr, mainType);
        if (!directory.exists()) {
            directory.mkdirs();
        }
    }
    /**
     * 생성자
     * @param mainType
     * @param subType
     */
    public FileRenamePolicy(String uploadDirectory, String mainType, String subType) {
        String uploadDirStr = uploadDirectory;
        directory = new File(new File(uploadDirStr, mainType), subType);
        if (!directory.exists()) {
            directory.mkdirs();
        }
    }
    /**
     * 생성자
     * @param mainType
     * @param subType
     * @param subSubType
     */
    public FileRenamePolicy(String uploadDirectory, String mainType, String subType,String subSubType) {
        String uploadDirStr = uploadDirectory;
        directory = new File ( new File(new File(uploadDirStr, mainType), subType),subSubType);
        if (!directory.exists()) {
            directory.mkdirs();
        }
    }
    
    /**
     * 생성자
     * @param mainType
     * @param subType
     * @param subSubType
     * @param subSubSubType
     */
    public FileRenamePolicy(String uploadDirectory, String mainType, String subType, String subSubType, String subSubSubType) {
        String uploadDirStr = uploadDirectory;
        directory = new File(new File( new File(new File(uploadDirStr, mainType), subType),subSubType),subSubSubType);
        if (!directory.exists()) {
            directory.mkdirs();
        }
    } 
    
    /**
     * 생성자
     * @param uploadDirectory
     * @param mainType
     * @param subType
     * @param subSubType
     * @param subSubSubType
     * @param subSubSubSubType
     */
    public FileRenamePolicy(String uploadDirectory, String mainType, String subType, String subSubType, String subSubSubType, String subSubSubSubType) {
        String uploadDirStr = uploadDirectory;
        directory = new File(new File(new File( new File(new File(uploadDirStr, mainType), subType),subSubType),subSubSubType), subSubSubSubType);
        if (!directory.exists()) {
            directory.mkdirs();
        }
    }
    
    /**
     * 파일 명을 변경한다
     */
    public File renameFile(File file) {
        File rFile = null;
        if (file != null) {
//        	쓸데없는 짓 하지마라 - 나중에 파일 찾을 수 없다.
//        	String fileName = System.currentTimeMillis() + "_" + getFileName(file.getName());
//        	logger.debug("fileName {}", file.getName());
        	String fileName = System.currentTimeMillis() + "_" + file.getName();
//        	logger.debug("fileName {}", fileName);
            rFile = new File(directory, fileName);
            if (file.renameTo(rFile)) {
                // 아무것도 안함
            } else {
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
        }
        return rFile;
    }
    
    private boolean renameFile(File srcFile, File desFile) {
        return !desFile.exists() && srcFile.renameTo(desFile);
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
            
            result = sb.toString();
        }
        return result;
    }
}
