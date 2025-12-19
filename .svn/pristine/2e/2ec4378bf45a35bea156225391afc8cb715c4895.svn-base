package com.vicurus.it.core.common.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.springframework.core.io.FileSystemResourceLoader;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Component;


/**
 * 프로퍼티파일 읽어서 value 제공 유틸
 */


@Component("prop")
public class ContextPropUtil {
    private Properties propFile;

    public void setPropFile(String proFile) throws IOException {
        FileSystemResourceLoader fileSystemResourceLoader = new FileSystemResourceLoader();
        Resource propResource = fileSystemResourceLoader.getResource(proFile);
        InputStream is = propResource.getInputStream();
        propFile = new Properties();
        propFile.load(is);
    }
    
    public String get(String key) {
    	//propFile 은 key,value 형태의 오브젝트
    	
	     if ( propFile != null ) {
	    	 return propFile.getProperty(key);
	     }
	     
	     return "";
    }
}