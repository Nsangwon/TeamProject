package kr.co.domain;

import java.io.Serializable;
import java.util.List;

public class ReviewPageTO<T> implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int curPage = 1;
	private int perPage = 6;	
	private int perLine = 5;	

	private int amount;	
	private int totalPage;	
	private int startNum;
	private int endNum;
	private List<T> list;
	private int beginPageNum;
	private int finishPageNum;

	public ReviewPageTO() {
		executeChangeValue();
	}

	public ReviewPageTO(int curPage) {
		super();
		this.curPage = curPage;
		executeChangeValue();
	}

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
		executeChangeValue();
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

	public void setStartNum(int starNum) {
		this.startNum = starNum;
	}

	public int getEndNum() {
		return endNum;
	}

	public void setEndNum(int endNum) {
		this.endNum = endNum;
	}

	public List<T> getList() {
		return list;
	}

	public void setList(List<T> list) {
		this.list = list;
	}

	public int getBeginPageNum() {
		return beginPageNum;
	}

	public void setBeginPageNum(int beginPageNum) {
		this.beginPageNum = beginPageNum;
	}

	public int getFinishPageNum() {
		return finishPageNum;
	}

	public void setFinishPageNum(int finishPageNum) {
		this.finishPageNum = finishPageNum;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	private void executeChangeValue() {
		totalPage = (amount - 1) / perPage + 1;
		startNum = (curPage - 1) * perPage + 1;
		endNum = curPage * perPage;
		if (endNum > amount) {
			endNum = amount;
		}
		beginPageNum = ((curPage - 1) / perLine) * perLine + 1;
		finishPageNum = beginPageNum + perLine - 1;
		if (finishPageNum > totalPage) {
			finishPageNum = totalPage;
		}

	}

}
