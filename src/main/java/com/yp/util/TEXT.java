package com.yp.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



/**
 * Created with IntelliJ IDEA.<br>
 * User: marco<br>
 * Date: 13. 10. 31<br>
 * Time: ?��?�� 12:40<br>
 * To change this template use File | Settings | File Templates.<br>
 * <p>
 * Text ?��?��?���? View ?��?��?�� ?��?�� Class
 * </p>
 */
public class TEXT  {

	protected StringBuilder strOut;

	public TEXT() {
		strOut = new StringBuilder();
	}

	public TEXT put(String s) {
		strOut.append(s);
		return this;
	}

	public TEXT putln(String s) {
		strOut.append(s).append(System.getProperty("line.separator"));
		return this;
	}

	public void reset() {
		strOut.delete(0, strOut.length());
	}

	public String doDisplay(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
			throws Exception {
		httpservletresponse.setContentType("text/plain");
		httpservletresponse.getWriter().print(strOut.toString());
		return null;
	}
}
