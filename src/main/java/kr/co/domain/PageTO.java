package kr.co.domain;

import java.util.List;

public class PageTO<T> {
	private int curPage = 1;
	private int perPage = 12;
	private int perLine = 10;
	private int amount;
	private int totalPage;
	private int startNum;
	private int endNum;
	private int beginPageNum;
	private int finishPageNum;
	private int previousPageNum;
	private int nextPageNum;
	private List<T> list;
	
	public PageTO() {
		executeChangeValue();
	}
	
	public PageTO(int curPage) {
		this.curPage = curPage;
		executeChangeValue();
	}

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getPerPage() {
		return perPage;
	}

	public void setPerPage(int perPage) {
		this.perPage = perPage;
		executeChangeValue();
	}

	public int getPerLine() {
		return perLine;
	}

	public void setPerLine(int perLine) {
		this.perLine = perLine;
		executeChangeValue();
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
		executeChangeValue();
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getStartNum() {
		return startNum;
	}

	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}

	public int getEndNum() {
		return endNum;
	}

	public void setEndNum(int endNum) {
		this.endNum = endNum;
	}

	public int getBeginPageNum() {
		return beginPageNum;
	}

	public void setBeginPageNum(int beginPageNum) {
		this.beginPageNum = beginPageNum;
	}

	public int getPreviousPageNum() {
		return previousPageNum;
	}

	public void setPreviousPageNum(int previousPageNum) {
		this.previousPageNum = previousPageNum;
	}

	public int getNextPageNum() {
		return nextPageNum;
	}

	public void setNextPageNum(int nextPageNum) {
		this.nextPageNum = nextPageNum;
	}

	public int getFinishPageNum() {
		return finishPageNum;
	}

	public void setFinishPageNum(int finishPageNum) {
		this.finishPageNum = finishPageNum;
	}

	public List<T> getList() {
		return list;
	}

	public void setList(List<T> list) {
		this.list = list;
	}
	
	private void executeChangeValue() {
		totalPage = (amount - 1) / perPage + 1;
		startNum = (curPage - 1) * perPage + 1;
		endNum = curPage * perPage;
		if (endNum > amount) {
			endNum = amount;
		}
		
		beginPageNum = ((curPage - 1) / perLine) * perLine + 1;

		previousPageNum = beginPageNum - 1;
		if (previousPageNum == 0) {
			previousPageNum = beginPageNum;
		}
		
		finishPageNum = beginPageNum + perLine - 1;
		if (finishPageNum > totalPage) {
			finishPageNum = totalPage;
		}
		
		nextPageNum = finishPageNum + 1 ;
		if (nextPageNum > totalPage) {
			nextPageNum = finishPageNum;
		}
	}
	
	
}
