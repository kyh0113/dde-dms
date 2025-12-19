package com.vicurus.it.core.common;

public class Pagination {
	/** 한 페이지당 게시글 수 **/
	private int pageSize = 2;
	/** 한 블럭(range)당 페이지 수 **/
	private int rangeSize = 5;
	/** 현재 페이지 **/
	private int curPage = 1;
	/** 현재 블럭(range) **/
	private int curRange = 1;
	/** 총 게시글 수 **/
	private int listCnt;
	/** 총 페이지 수 **/
	private int pageCnt;
	/** 총 블럭(range) 수 **/
	private int rangeCnt;
	/** 시작 페이지 **/
	private int startPage = 1;
	/** 끝 페이지 **/
	private int endPage = 1;
	/** 시작 index **/
	private int startIndex = 0;
	/** 종료 index **/
	private int endIndex = 0;
	/** 이전 페이지 **/
	private int prevPage;
	/** 다음 페이지 **/
	private int nextPage;

	/**
	 * 페이징 처리 순서 1. 총 페이지수 > 2. 총 블럭(range)수 > 3. range setting
	 * 
	 * @param listCnt
	 * @param curPage
	 */
	public Pagination(int pageSize, int rangeSize, int listCnt, int curPage) {
		// 총 게시물 수와 현재 페이지를 Controller로 부터 받아온다.
		// 현재 페이지
		setCurPage(curPage);
		// 총 게시물 수
		setListCnt(listCnt);
		// 한 페이지당 게시물 수
		setPageSize(pageSize);
		// 한 블럭당 페이지 수
		setRangeSize(rangeSize);
		// 1. 총 페이지 수
		setPageCnt(listCnt);
		// 2. 총 블럭(range)수
		setRangeCnt(pageCnt);
		// 3. 블럭(range) setting
		rangeSetting(curPage);
		/** DB 질의를 위한 startIndex 설정 **/
		setStartIndex(curPage);
	}

	public int getPageSize() {
		return this.pageSize;
	}

	public int getRangeSize() {
		return this.rangeSize;
	}

	public int getStartPage() {
		return this.startPage;
	}

	public int getEndPage() {
		return this.endPage;
	}

	public int getStartIndex() {
		return this.startIndex;
	}

	public int getPrevPage() {
		return this.prevPage;
	}

	public int getNextPage() {
		return this.nextPage;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public void setRangeSize(int rangeSize) {
		this.rangeSize = rangeSize;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getCurPage() {
		return this.curPage;
	}

	public void setListCnt(int listCnt) {
		this.listCnt = listCnt;
	}

	public int getListCnt() {
		return this.listCnt;
	}
	
	public String getListCntStr() {
		return CommonUtil.comma(String.valueOf(this.listCnt));
	}

	public void setPageCnt(int listCnt) {
		this.pageCnt = (int) Math.ceil(listCnt * 1.0 / pageSize);
	}

	public int getPageCnt() {
		return this.pageCnt;
	}

	public void setRangeCnt(int pageCnt) {
		this.rangeCnt = (int) Math.ceil(pageCnt * 1.0 / rangeSize);
	}

	public int getRangeCnt() {
		return this.rangeCnt;
	}

	public int getStartpage() {
		return this.startPage;
	}

	public void rangeSetting(int curPage) {
		setCurRange(curPage);
		this.startPage = (curRange - 1) * rangeSize + 1;
		this.endPage = startPage + rangeSize - 1;
		if (endPage > pageCnt) {
			this.endPage = pageCnt;
		}
		this.prevPage = curPage - 1;
		this.nextPage = curPage + 1;
	}

	public void setCurRange(int curPage) {
		this.curRange = (int) ((curPage - 1) / rangeSize) + 1;
	}

	public int getCurRange() {
		return this.curRange;
	}

	public void setStartIndex(int curPage) {
		this.startIndex = (curPage - 1) * this.pageSize + 1;
		this.endIndex = (this.startIndex - 1) + this.pageSize;
	}
	
	public int getEndIndex() {
		return this.endIndex;
	}
}
