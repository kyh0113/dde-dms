package com.vicurus.it.core.waf.taglib.html;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.vicurus.it.core.waf.taglib.HtmlConstants;

/**
 * <p>
 * RadioButton.
 * </p>
 * @author YAME
 * @version $Revision: 001  $Date: 2013-07-01 
 */
public class RadioButton implements HtmlConstants {
	
	private String name;
	private String id;
	private String script;
	private String[] values;
	private String[] texts;
	private String checkedValue;
	private String defaultValue;
	private String space;
	private String[] imgs;
	private String[] bigimgs;
	private String[] ids;

	
	private final Log logger = LogFactory.getLog(getClass());
	
	public RadioButton(String name, String id,String[] values, String script, String checkedValue, String defaultValue, String[] texts,  String space, String[] ids) {
		this.name = name;
		this.id = id;
		this.script = (script != null) ? " " + script + " " : "";
		this.values = values;
		this.texts = (texts != null) ? texts : this.values;
		this.checkedValue = checkedValue;
		this.defaultValue = (checkedValue==null||"".equals(checkedValue.trim())) ? defaultValue : checkedValue;
		this.space = (space == null) ? "" : space;
		this.ids = ids;
	}

	public RadioButton(String name, String id,String[] values, String script, String checkedValue, String defaultValue, String[] texts,  String space, String[] imgs, String[] ids, String[] bigimgs) {
		this.name = name;
		this.id = id;
		this.script = (script != null) ? " " + script + " " : "";
		this.values = values;
		this.texts = (texts != null) ? texts : this.values;
		this.checkedValue = checkedValue;
		this.defaultValue = (checkedValue==null||"".equals(checkedValue.trim())) ? defaultValue : checkedValue;
		this.space = (space == null) ? "" : space;
		this.imgs = (imgs != null) ? imgs : null;
		this.bigimgs = (bigimgs != null) ? bigimgs : null;
		this.ids = ids;
	}

	public String buildHtml() {
		StringBuffer html = new StringBuffer();
		try {
			int size = (values.length == texts.length) ? values.length : 0;
			for (int i = 0; i < size ; i++) {
			    if (i > 0) {
			        html.append(space);
			    }
				html.append("<label class=\"radio inline\"><input hideFocus type=\"radio\" name=\"").append(name).append("\"").append(" id=\"").append(id).append("\"");
				if(ids != null){
				html.append(" id=\"").append(ids[i]).append("\"");
				}
				html.append(" value=\"").append(values[i]).append("\"");
				html.append(script);
				if (values[i].equalsIgnoreCase(checkedValue) || values[i].equalsIgnoreCase(defaultValue)) {
					html.append(" checked=\"checked\"");
				}
				if(ids != null){
					html.append(" /> <label for=\"").append(ids[i]).append("\">").append(texts[i]).append("</label> \n");
				}else{
					html.append(" />").append(texts[i]).append("</label> \n");	
				}
			}
		} catch (Exception e) {
			//logger.println(Logger.ERROR, e, this);
			System.out.println("TAG : " + e.toString());
		}
		return html.toString();
	}
	
	public String buildHtml2() {
		StringBuffer html = new StringBuffer();
		try {
			int size = (values.length == texts.length) ? values.length : 0;
			for (int i = 0; i < size ; i++) {
			    html.append("<li><a href='#'><img src=\"/images/app/").append(imgs[i]).append("\" alt='미리보기' onclick='preview(\""+ bigimgs [i]+"\");return false;' /></a><br />");
				html.append("<input hideFocus type=\"radio\" name=\"").append(name).append("\"");
				html.append(" value=\"").append(values[i]).append("\"");
				html.append(script);
				if (values[i].equalsIgnoreCase(checkedValue) || values[i].equalsIgnoreCase(defaultValue)) {
					html.append(" checked");
				}
				html.append(">").append(texts[i]);
				html.append("</li>");
			}
			
			
		} catch (Exception e) {
			//logger.println(Logger.ERROR, e, this);
		}
		return html.toString();
	}	
}
