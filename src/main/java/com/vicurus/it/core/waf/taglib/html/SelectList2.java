package com.vicurus.it.core.waf.taglib.html;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.vicurus.it.core.common.WebUtil;
import com.vicurus.it.core.waf.taglib.HtmlConstants;

/**
 * <p>
 * SelectList.
 * </p>
 * @author YAME
 * @version $Revision: 001  $Date: 2013-07-01 
 */
public class SelectList2 implements HtmlConstants {
	
	private String name;
	private String id;
	private String script;
	private String[] optionValues;
	private String[] optionNames;
	
	private String selectedValue;
	
	private String defaultValue;
	
	private final Log logger = LogFactory.getLog(getClass());

	
	public SelectList2(String name, String id,  String script, String[] optionValues, String[] optionNames, String selectedValue, String defaultValue) {
		this.name = name;
		this.id = id;
		this.script = script;
        this.optionValues = optionValues;
        this.optionNames = optionNames;
		this.selectedValue = (selectedValue != null) ? selectedValue.trim() : selectedValue;
		this.defaultValue = (defaultValue != null) ? defaultValue.trim() : defaultValue;
	}


	public String buildHtml() {
		StringBuffer html = new StringBuffer();
		try {
			html.append("<select name=\'").append(name).append("\'");
			
			if(id != null){
				html.append(" id=\'").append(id).append("\'");
			}
			if (script != null) {
				html.append(" ");
				html.append(script);	
			}
			html.append(">");
            if (optionValues != null) {
                int size = (optionValues.length == optionNames.length) ? optionValues.length : 0;
                for (int i = 0; i < size ; i++) {
                    html.append("    <option value=\'").append(optionValues[i]).append("\'");
                    if(!WebUtil.isNull(selectedValue)){
	                    if (optionValues[i].equalsIgnoreCase(selectedValue) || optionNames[i].trim().equalsIgnoreCase(selectedValue)) {
	                        html.append(" selected=\'selected\'");
	                    }
                    }else{
	                    if (optionValues[i].equalsIgnoreCase(defaultValue) || optionNames[i].trim().equalsIgnoreCase(defaultValue)) {
	                        html.append(" selected=\'selected\'");
	                    }
                    }
                    html.append(">");
                    html.append(optionNames[i]).append("</option>");
                }                
            }
			html.append("</select>");
		} catch (Exception e) {
			logger.error(e);
			
		}

		return html.toString();
	}
}
