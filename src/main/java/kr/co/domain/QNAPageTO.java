package kr.co.domain;

import java.util.List;

public class QNAPageTO<T> 
{
	private int curPage = 1;

	// < 페이지 당 갯수 조정
	private int perPage = 6;
	// < 페이지 갯수 조정
	private int perLine = 5;

	// < 게시글 총 갯수
	private int amount;

	// < 페이지 총 갯수
	private int totalPage;

	// < 현재 페이지의 시작지점 (게시글 번호)
	private int startNum;
	// < 현재 페이지의 끝 지점 (게시글 번호)
	private int endNum;

	// < 게시글 리스트
	private List<T> list;
	
	// < 게시글 제목 리스트
	private List<String> prodNameList;

	// < 현재 페이지 기준 왼쪽 시작지점
	private int beginPageNum;
	// < 현제 페이지 기준 오른쪽 끝 지점
	private int finishPageNum;

	public QNAPageTO() 
	{
		executeChangeValue();
	}

	public QNAPageTO(int curPage) 
	{
		super();
		this.curPage = curPage;
		executeChangeValue();
	}

	public int getCurPage() { return curPage; }
	public void setCurPage(int curPage) 
	{
		this.curPage = curPage;
		executeChangeValue();
	}

	public int getPerPage() { return perPage; }
	public void setPerPage(int perPage) 
	{
		this.perPage = perPage;
		executeChangeValue();
	}

	public int getPerLine() { return perLine; }
	public void setPerLine(int perLine) 
	{
		this.perLine = perLine;
		executeChangeValue();
	}

	public int getAmount() { return amount; }
	public void setAmount(int amount) 
	{
		this.amount = amount;
		executeChangeValue();
	}

	public int getTotalPage() { return totalPage; }
	public void setTotalPage(int totalPage) { this.totalPage = totalPage; }

	public int getStartNum() { return startNum; }
	public void setStartNum(int starNum) { this.startNum = starNum; }

	public int getEndNum() { return endNum; }
	public void setEndNum(int endNum) { this.endNum = endNum; }

	public List<T> getList() { return list; }
	public void setList(List<T> list) { this.list = list; }
	
	public List<String> getProdNameList() { return prodNameList; }
	public void setProdNameList(List<String> prodNameList) { this.prodNameList = prodNameList; }

	public int getBeginPageNum() { return beginPageNum; }
	public void setBeginPageNum(int beginPageNum) { this.beginPageNum = beginPageNum; }

	public int getFinishPageNum() { return finishPageNum; }
	public void setFinishPageNum(int finishPageNum) { this.finishPageNum = finishPageNum; }

	private void executeChangeValue() 
	{
		totalPage = (amount - 1) / perPage + 1;
		startNum = (curPage - 1) * perPage + 1;
		endNum = curPage * perPage;

		if (endNum > amount) 
		{
			endNum = amount;
		}

		beginPageNum = ((curPage - 1) / perLine) * perLine + 1;
		finishPageNum = beginPageNum + perLine - 1;

		if (finishPageNum > totalPage) 
		{
			finishPageNum = totalPage;
		}
	}
}