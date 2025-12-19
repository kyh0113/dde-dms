
package com.vicurus.it.core.waf.taglib.html;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;





import com.vicurus.it.core.common.util.StringUtil;
import com.vicurus.it.core.common.util.TypeConvertUtil;
import com.vicurus.it.core.waf.taglib.DefaultTagSupport;
/**
 * <pre><xmp>
 * 게시물 페이징
 * ex)
 * 	<html:pagingEx parameters='${parameters}' left02Img="" left01Img="" right01Img="" right02Img=""/> 
 * </xmp></pre> 
 * @author admin
 *
 */
public class PagingTagEx extends DefaultTagSupport {

    private static final long serialVersionUID = -6420080584917643106L;
    private String numOfRows;
    private String numOfPages;
    private String startPage;
    private String endPage;
    private String totalPage;
    private String cPage;
    private String total;
    
    private String formId;
    
    public int doStartTag() throws JspException {
        return (SKIP_BODY);
    }

    public int doEndTag() throws JspException {
        try {
            HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();
            
            
            int numOfRows = TypeConvertUtil.convertInt(getParsedValue(this.numOfRows, "numOfRows"), 10);
            int numOfPages = TypeConvertUtil.convertInt(getParsedValue(this.numOfPages, "numOfPages"), 10);
            int startPage = TypeConvertUtil.convertInt(getParsedValue(this.startPage, "startPage"), 1);
            int endPage = TypeConvertUtil.convertInt(getParsedValue(this.endPage, "endPage"), 1);
            int totalPage = TypeConvertUtil.convertInt(getParsedValue(this.totalPage, "totalPage"), -1);
            int cPage = TypeConvertUtil.convertInt(getParsedValue(this.cPage, "cPage"), 1);
            int total = TypeConvertUtil.convertInt(getParsedValue(this.total, "total"), 0);
            if (totalPage < 0) {
                totalPage = total / numOfRows;
            }
            if(cPage == 0 ) cPage = 1;
            //System.out.println("startpage = "+ startPage);
            //System.out.println("cPage = "+ cPage);
            
            int prePageSet = (cPage - 1) / numOfPages * numOfPages;
            int nextPageSet = (cPage + numOfPages - 1) / numOfPages * numOfPages + 1;
            
            StringBuffer html = new StringBuffer();
            
            html.append("\n");
            //처음
            html.append("<a class=\"pre_end\" href=\"javascript:goPageQuery('1')\">").append("처음").append("</a>\n");
            //이전
            if (prePageSet == 0) prePageSet = 1;
            html.append("<a class=\"pre\" href=\"javascript:goPageQuery('").append(prePageSet).append("')\">").append("이전").append("</a>\n");
            
            //페이징
        	for (int i = startPage; i <= endPage; i++) {
        		/*// 참조
        		if (i == startPage) html.append(" fir");
        		else if (i == endPage) html.append(" last");
        		if (i == cPage) html.append(" selected");
        		*/
                if (i == cPage) { //현재페이지         
                	html.append("<strong>").append(i).append("</strong>");
                } else {
            		html.append("<a href=\"javascript:goPageQuery('").append(i).append("')\">").append(i).append("</a>\n");
                }
            }
            // 다음
        	if (nextPageSet > totalPage ) nextPageSet = totalPage;
        	html.append("<a class=\"next\" href=\"javascript:goPageQuery('").append(nextPageSet).append("')\">").append("다음").append("</a>\n");
        	// 마지막
        	html.append("<a class=\"next_end\" href=\"javascript:goPageQuery('").append(totalPage).append("')\">").append("끝").append("</a>\n");
            html.append("\n");
            
            // script 사용
        	html.append("<script type=\"text/javascript\">");
        	if(formId == null || formId.equals("")){
        		html.append("alert(\"페이지에 전송폼 아이디를 넣어주세요.\");");
        	}else{
        		html.append("$(\"#"+formId+"\").append(\"<input type='hidden' id='cPage' name='cPage' value='"+cPage+"'>\");");
        	}
        	html.append("</script>");
             
            JspWriter out = super.pageContext.getOut();
            out.print(html.toString());
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return (SKIP_BODY);
    }
    
    /**
     * @param setFormId The totalPage to set.
     */
    public void setFormId(String formId) {
        this.formId = formId;
    }

    /**
     * @param totalPage The totalPage to set.
     */
    public void setTotalPage(String totalPage) {
        this.totalPage = totalPage;
    }


    /**
     * @param page The cPage to set.
     */
    public void setCPage(String page) {
        cPage = page;
    }
    /**
     * @param endPage The endPage to set.
     */
    public void setEndPage(String endPage) {
        this.endPage = endPage;
    }
    /**
     * @param nextPageSet The nextPageSet to set.
     */
    public void setNumOfPages(String nextPageSet) {
        this.numOfPages = nextPageSet;
    }
    /**
     * @param prePageSet The prePageSet to set.
     */
    public void setNumOfRows(String prePageSet) {
        this.numOfRows = prePageSet;
    }
    /**
     * @param startPage The startPage to set.
     */
    public void setStartPage(String startPage) {
        this.startPage = startPage;
    }
    /**
     * @param total The total to set.
     */
    public void setTotal(String total) {
        this.total = total;
    }
}
