package  com.yp.util.pagination;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;


public class PaginationTag extends TagSupport {

	private static final long serialVersionUID = -1834974553643629734L;

	private PaginationInfo paginationInfo;

	private String type;

	private String jsFunction;

	
	
	public PaginationInfo getPaginationInfo() {
		return paginationInfo;
	}

	public void setPaginationInfo(PaginationInfo paginationInfo) {
		this.paginationInfo = paginationInfo;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getJsFunction() {
		return jsFunction;
	}

	public void setJsFunction(String jsFunction) {
		this.jsFunction = jsFunction;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int doEndTag() throws JspException {

		try {
			JspWriter out = pageContext.getOut();

			PaginationRenderer paginationRenderer = new PaginationRenderer();
			paginationRenderer.setPaginationType(type);
			String contents = paginationRenderer.renderPagination(paginationInfo, jsFunction);

			out.println(contents);
			//System.out.println(contents);
			return EVAL_PAGE;
		} catch (IOException e) {
			e.printStackTrace();
			throw new JspException();
		}
	}
}
