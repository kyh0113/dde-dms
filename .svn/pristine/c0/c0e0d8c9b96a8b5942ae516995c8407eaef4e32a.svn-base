package  com.yp.util.pagination;

import java.text.MessageFormat;

/**
 * Created with IntelliJ IDEA.<br>
 * User: marco<br>
 * Date: 13. 10. 31<br>
 * Time: 오후 12:40<br>
 * To change this template use File | Settings | File Templates.<br>
 * <p>
 * 기본적인 페이징 기능이 구현되어 있으며, 화면에서 아래와 같이 display
 * </p>
 */
public class PaginationRenderer {

	/**
	 * <p>
	 * [처음]
	 * </p>
	 */
	public String firstPageLabel;

	/**
	 * <p>
	 * [이전]
	 * </p>
	 */
	public String previousPageLabel;

	/**
	 * <p>
	 * 현재 페이지 번호
	 * </p>
	 */
	public String currentPageLabel;

	/**
	 * <p>
	 * 현재 페이지를 제외한 페이지 번호
	 * </p>
	 */
	public String otherPageLabel;

	/**
	 * <p>
	 * [다음]
	 * </p>
	 */
	public String nextPageLabel;

	/**
	 * <p>
	 * [마지막]
	 * </p>
	 */
	public String lastPageLabel;

	public PaginationRenderer() {
//		firstPageLabel = "<span class=\"next_end_n4\"><a href=\"#\" onclick=\"{0}({1}); return false;\"><span class=\"prev_n1\">처음</span></a>&#160;</span>";
//		previousPageLabel = "<span class=\"pre_n4\"><a href=\"#\" onclick=\"{0}({1}); return false;\"><span class=\"prev_n2\">이전</span></a></span>";
//		currentPageLabel = "<a href=\"#\" onclick=\"return false;\"><span>{0}</span></a>";
//		otherPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\"><span>{2}</span></a>";
//		nextPageLabel = "<span class=\"next_n4\"><a href=\"#\" onclick=\"{0}({1}); return false;\"><span class=\"next_n2\">다음</span></a></span>";
//		lastPageLabel = "<span class=\"next_end_n4\"><a href=\"#\" onclick=\"{0}({1}); return false;\"><span class=\"next_n1\">마지막</span></a>&#160;</span>";
			
			firstPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" class=\"pre_end_n\">◀◀</a>";
			previousPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" class=\"pre_n\">◀</a>";
			currentPageLabel = "<a href=\"#\" onclick=\"return false;\"><strong style=\"font-size: 150%;\">{0}</strong></a>";
			otherPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">{2}</a>";
			nextPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" class=\"next_n\">▶</a>";
			lastPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" class=\"next_end_n\">▶▶</a>";
	}

	public void setPaginationType(String type) {
		if (type.equals("image")) {
			firstPageLabel = "<li class=\"img\"><a href=\"#\" onclick=\"{0}({1}); \"><img src=\"/images/btn/btn_first.gif\" alt=\"처음페이지\" /></a></li>";
			previousPageLabel = "<li class=\"img\"><a href=\"#\" onclick=\"{0}({1}); \"><img src=\"/images/btn/btn_prev.gif\" alt=\"이전페이지\" /></a></li>";
			currentPageLabel = "<li><strong style=\"font-size: 150%;\">{0}</strong></li>";
			otherPageLabel = "<li><a href=\"#\" onclick=\"{0}({1}); \">{2}</a></li>";
			nextPageLabel = "<li class=\"img\"><a href=\"#\" onclick=\"{0}({1}); \"><img src=\"/images/btn/btn_next.gif\" alt=\"다음페이지\" /></a></li>";
			lastPageLabel = "<li class=\"img\"><a href=\"#\" onclick=\"{0}({1}); \"><img src=\"/images/btn/btn_last.gif\" alt=\"마지막페이지\" /></a></li>";
		}
	}

	/**
	 * <p>
	 * 페이징 구조 Render
	 * </p>
	 * 
	 * @param paginationInfo the pagination info
	 * @param jsFunction the js function
	 * @return the string
	 */
	public String renderPagination(PaginationInfo paginationInfo, String jsFunction) {
		StringBuffer strBuff = new StringBuffer("<div class=\"pagenation\">");

		if (paginationInfo != null) {

			int firstPageNo = 1;
			int firstPageNoOnPageList = paginationInfo.getFirstPageNoOnPageList();
			int totalPageCount = paginationInfo.getTotalPageCount();
			int pageSize = paginationInfo.getPageSize();
			int lastPageNoOnPageList = paginationInfo.getLastPageNoOnPageList();
			int currentPageNo = paginationInfo.getCurrentPageNo();
			int lastPageNo = paginationInfo.getTotalPageCount();

			if (totalPageCount > pageSize) {
				if (firstPageNoOnPageList > pageSize) {
					strBuff.append(MessageFormat.format(firstPageLabel,
							new Object[] { jsFunction, Integer.toString(firstPageNo) }));
					strBuff.append(MessageFormat.format(previousPageLabel,
							new Object[] { jsFunction, Integer.toString(firstPageNoOnPageList - 1) }));
				} else {
					strBuff.append(MessageFormat.format(firstPageLabel,
							new Object[] { jsFunction, Integer.toString(firstPageNo) }));
					strBuff.append(MessageFormat.format(previousPageLabel,
							new Object[] { jsFunction, Integer.toString(firstPageNo) }));
				}
			}

			for (int i = firstPageNoOnPageList; i <= lastPageNoOnPageList; i++) {
				if (i == currentPageNo) {
					strBuff.append(MessageFormat.format(currentPageLabel, new Object[] { Integer.toString(i) }));
				} else {
					strBuff.append(MessageFormat.format(otherPageLabel, new Object[] { jsFunction, Integer.toString(i),
							Integer.toString(i) }));
				}
			}

			if (totalPageCount > pageSize) {
				if (lastPageNoOnPageList < totalPageCount) {
					strBuff.append(MessageFormat.format(nextPageLabel,
							new Object[] { jsFunction, Integer.toString(firstPageNoOnPageList + pageSize) }));
					strBuff.append(MessageFormat.format(lastPageLabel,
							new Object[] { jsFunction, Integer.toString(lastPageNo) }));
				} else {
					strBuff.append(MessageFormat.format(nextPageLabel,
							new Object[] { jsFunction, Integer.toString(lastPageNo) }));
					strBuff.append(MessageFormat.format(lastPageLabel,
							new Object[] { jsFunction, Integer.toString(lastPageNo) }));
				}
			}
		}
		strBuff.append("</div>");
		return strBuff.toString();
	}
}
