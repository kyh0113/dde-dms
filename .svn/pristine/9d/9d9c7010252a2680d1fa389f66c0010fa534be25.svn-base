package com.vicurus.it.core.waf.taglib.html;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.vicurus.it.core.common.util.TypeConvertUtil;

/**
 * 체크박스 생성
 * @author 포스트코리아
 *
 */
public class CheckBox {
    
    private String name;
    private String id;
    private String[] values;
    private String script;
    private String[] texts;
    private String[] checkedValues;
    private String space;
    private int columnSize = 100;
    
    private final Log logger = LogFactory.getLog(getClass());
    
    public CheckBox(String name, String id, String[] values, String[] texts, String script, String[] checkedValues,  String space, String columnSize) {
        this.name = name;
        this.id = id;
        this.script = script;
        this.values = values;
        this.texts = texts;
        this.checkedValues = checkedValues;
        this.space = (space == null) ? "" : space;
        this.columnSize = TypeConvertUtil.convertInt(columnSize, 100);

    }


    public String buildHtml() {
        StringBuffer html = new StringBuffer();
        try {
            int size = (values.length == texts.length) ? values.length : 0;
            int idIdx = 1;
            int Idx = 0;
            for (int i = 0; i < size-1 ; i++) {
                if (i > 0) {
                    html.append(space);
                    if (i % columnSize == 0) {
                        html.append("<br/>");
                    }
                }
                Idx = idIdx++;
                html.append("<label class=\"checkbox inline\"><INPUT type=\"checkbox\" name=\"").append(name).append("_"+Idx).append("\" id=\"").append(id).append("_"+Idx).append("\"");
                html.append(" value=\"").append(values[i+1]).append("\"");
                if(isCheckedValue(values[i+1])){
                    html.append(" checked=\"checked\"");                    
                }
                if (script != null) {
                    html.append(" ").append(script);
                }
                html.append(">").append(texts[i+1]).append("</label> \n");

            }
        } catch (Exception e) {
            logger.error(e);
        }
        
        return html.toString();
    }
    
    protected boolean isCheckedValue(String value) {
        boolean result = false;
        if(value != null && checkedValues != null){
            for (int i = 0; i < checkedValues.length; i++) {
                if (value.equalsIgnoreCase(checkedValues[i])) {
                    result = true;
                    break;
                }
            }
        }
        return result;
    }
}
