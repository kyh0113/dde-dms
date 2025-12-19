package com.vicurus.it.core.viewResolver;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONValue;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.view.AbstractView;

import com.vicurus.it.core.common.Util;

/**
 * <p>
 * ResultJsonView.
 * </p>
 * 
 * @author YAME
 * @version $Revision: 001 $Date: 2013-07-01
 */
public class ReturnJson extends AbstractView {
	private static final Logger logger = LoggerFactory.getLogger(ReturnJson.class);
	private PrintWriter out;

	@Override
	@SuppressWarnings({"rawtypes", "static-access", "unchecked"})
	protected void renderMergedOutputModel(Map map, HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			Util util = new Util();
			Map<String, Object> map2 = map;
			String jsonString = JSONValue.toJSONString(map2);
			response.setContentType("text/plain;charset=utf-8");// json
			// response.setContentType("text/plaiapplication/json;charset=utf-8");//json
			jsonString = jsonString.replace("\"org.springframework.validation.BindingResult.string\":org.springframework.validation.BeanPropertyBindingResult: 0 errors,", "");

			// 20191026_khj XSS 필터적용
			jsonString = util.XSSFilter(jsonString);

			out = response.getWriter();
			// System.out.println("ReturnJson:" + jsonString);
//			logger.debug("ReturnJson: {}", JsonEnterConvert(jsonString));
			out.println(jsonString); // json
		} catch (IOException e) {
			logger.error(e.getMessage());
			e.printStackTrace();
			System.err.println("IOException : " + e.getMessage());
		} catch (Throwable e) {
			logger.error(e.getMessage());
			e.printStackTrace();
			System.err.println("Throwable : " + e.getMessage());
		} finally {
			out.flush();
			out.close();
		}
	}

	private String JsonEnterConvert(String json) {

		if (json == null || json.length() < 2)
			return json;

		final int len = json.length();
		final StringBuilder sb = new StringBuilder();
		char c;
		String tab = "";
		boolean beginEnd = true;
		for (int i = 0; i < len; i++) {
			c = json.charAt(i);
			switch (c) {
				case '{':
				case '[': {
					sb.append(c);
					if (beginEnd) {
						tab += "\t";
						sb.append("\n");
						sb.append(tab);
					}
					break;
				}
				case '}':
				case ']': {
					if (beginEnd) {
						tab = tab.substring(0, tab.length() - 1);
						sb.append("\n");
						sb.append(tab);
					}
					sb.append(c);
					break;
				}
				case '"': {
					if (json.charAt(i - 1) != '\\')
						beginEnd = !beginEnd;
					sb.append(c);
					break;
				}
				case ',': {
					sb.append(c);
					if (beginEnd) {
						sb.append("\n");
						sb.append(tab);
					}
					break;
				}
				default: {
					sb.append(c);
				}
			}// switch end

		}
		if (sb.length() > 0)
			sb.insert(0, '\n');
		return sb.toString();
	}
}
