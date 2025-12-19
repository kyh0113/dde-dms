package com.yp.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created with IntelliJ IDEA.<br>
 * User: marco<br>
 * Date: 13. 10. 31<br>
 * Time: ?��?�� 12:40<br>
 * To change this template use File | Settings | File Templates.<br>
 * <p>
 * javascript ?��?��?���? View ?��?��?�� ?��?�� Class
 * </p>
 */
public class JS extends TEXT {

	private HttpServletRequest req;
	private HttpServletResponse res;

	/**
	 * @param res
	 */
	public JS(HttpServletRequest req, HttpServletResponse res) {
		this.req = req;
		this.res = res;
	}
	
	public JS(HttpServletResponse res) {
		this.res = res;
	}

	/**
	 * <p>
	 * javascript:history.back(); 기능
	 * </p>
	 * 
	 * @return the jS
	 */
	public JS back() {
		return (JS) put("history.back();");
	}

	/**
	 * <p>
	 * javascript:alert(); 기능
	 * </p>
	 * 
	 * @param str the str
	 * @return the jS
	 */
	public JS alert(String str) {
		return (JS) put(String.format("alert(\"%s\");", new Object[] { str }));
//		return (JS) put(String.format("swalWarning(\"%s\");", new Object[] { str }));
	}

	/**
	 * <p>
	 * javascript:window.href 기능
	 * </p>
	 * 
	 * @param str the str
	 * @return the jS
	 */
	public JS redirect(String str) {
		return (JS) put(String.format("location.replace(\"%s\");", new Object[] { str }));
	}

	/**
	 * <p>
	 * javascript:window.opener.href 기능
	 * </p>
	 * 
	 * @param str the str
	 * @return the jS
	 */
	public JS parentRedirect(String str) {
		return (JS) put(String.format("opener.location.replace(\"%s\");", new Object[] { str }));
	}

	/**
	 * <p>
	 * javascript:self.close() 기능
	 * </p>
	 * 
	 * @return the jS
	 */
	public JS close() {
		return (JS) put(String.format("self.close();"));
	}

	/**
	 * <p>
	 * javascript:reload() 기능
	 * </p>
	 * 
	 * @return the jS
	 */
	public JS reload() {
		return (JS) put(String.format("location.reload();"));
	}

	/**
	 * <p>
	 * javascript:opener.reload() 기능
	 * </p>
	 * 
	 * @return the jS
	 */
	public JS parentReload() {
		return (JS) put(String.format("opener.location.reload();"));
	}

	public String doDisplay(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
			throws Exception {
		httpservletresponse.setContentType("text/html");
		((PrintWriter) (httpservletrequest = (HttpServletRequest) httpservletresponse.getWriter()))
				.println("<script type=\"text/JS\">");
		((PrintWriter) httpservletrequest).print(strOut.toString());
		((PrintWriter) httpservletrequest).print("</script>");
		return null;
	}

	/**
	 * <p>
	 * View�? Load()
	 * </p>
	 * 
	 * @return the string
	 * @throws IOException the iO exception
	 */
	public String load() throws IOException {
		res.setContentType("text/html");
		res.setCharacterEncoding("UTF-8");
		res.setContentType("text/html");
		res.getWriter().print("<script type=\'text/javascript\'>");
		res.getWriter().print(strOut.toString());
		res.getWriter().print("</script>");
		return null;
	}
	/**
	 * View Flush
	 * @return
	 * @throws IOException
	 */
	public void flush() throws IOException {
		res.setContentType("text/html");
		res.setCharacterEncoding("UTF-8");
		res.setContentType("text/html");
		res.getWriter().print("<script type=\'text/javascript\'>");
		res.getWriter().print(strOut.toString());
		res.getWriter().print("</script>");
		PrintWriter out = res.getWriter();
		out.flush();
	}

	/**
	 * <p>
	 * javascript: swalInfo(); 기능
	 * </p>
	 * 
	 * @param str the str
	 * @return the jS
	 */
	public JS swalInfoCB(String str, String str2) {
		return (JS) put(String.format("swalInfoCB(\"%s\", %s);", new Object[] { str }, new Object[] { str2 }));
	}
}
