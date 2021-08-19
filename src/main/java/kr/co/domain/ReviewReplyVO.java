package kr.co.domain;

import java.io.Serializable;

public class ReviewReplyVO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int reRno;
	private int reBno;
	private String reWriter;
	private String reContent;
	private String reRegdate;
	private String reUpdatedate;
	private int reStar;
	
	public ReviewReplyVO() {
		
	}

	public ReviewReplyVO(int reRno, int reBno, String reWriter, String reContent, String reRegdate,
			String reUpdatedate, int reStar) {
		super();
		this.reRno = reRno;
		this.reBno = reBno;
		this.reWriter = reWriter;
		this.reContent = reContent;
		this.reRegdate = reRegdate;
		this.reUpdatedate = reUpdatedate;
		this.reStar = reStar;
		
	}
	
	
	public int getReStar() {
		return reStar;
	}

	public void setReStar(int reStar) {
		this.reStar = reStar;
	}

	public int getReRno() {
		return reRno;
	}

	public void setReRno(int reRno) {
		this.reRno = reRno;
	}

	public int getReBno() {
		return reBno;
	}

	public void setReBno(int reBno) {
		this.reBno = reBno;
	}

	public String getReWriter() {
		return reWriter;
	}

	public void setReWriter(String reWriter) {
		this.reWriter = reWriter;
	}

	public String getReContent() {
		return reContent;
	}

	public void setReContent(String reContent) {
		this.reContent = reContent;
	}

	public String getReRegdate() {
		return reRegdate;
	}

	public void setReRegdate(String reRegdate) {
		this.reRegdate = reRegdate;
	}

	public String getReUpdatedate() {
		return reUpdatedate;
	}

	public void setReUpdatedate(String reUpdatedate) {
		this.reUpdatedate = reUpdatedate;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public ReviewReplyVO(int reRno) {
		super();
		this.reRno = reRno;
	}

	@Override
	public String toString() {
		return "ReviewReplyVO [reRno=" + reRno + ", reWriter=" + reWriter + ", reUpdatedate=" + reUpdatedate + "]";
	}
	
	
	
	
	
}
