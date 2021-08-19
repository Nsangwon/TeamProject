package kr.co.domain;

import java.util.Date;


public class KakaoPayReadyVO {

	private String tid, next_redirect_pc_url;
	private Date created_at;
	private Integer oNum;
	private String orderUserId;

	public KakaoPayReadyVO() {
		// TODO Auto-generated constructor stub
	}

	public KakaoPayReadyVO(String tid, String next_redirect_pc_url, Date created_at, Integer oNum, String orderUserId) {
		super();
		this.tid = tid;
		this.next_redirect_pc_url = next_redirect_pc_url;
		this.created_at = created_at;
		this.oNum = oNum;
		this.orderUserId = orderUserId;
	}

	public String getTid() {
		return tid;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}

	public String getNext_redirect_pc_url() {
		return next_redirect_pc_url;
	}

	public void setNext_redirect_pc_url(String next_redirect_pc_url) {
		this.next_redirect_pc_url = next_redirect_pc_url;
	}

	public Date getCreated_at() {
		return created_at;
	}

	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}

	public Integer getoNum() {
		return oNum;
	}

	public void setoNum(Integer oNum) {
		this.oNum = oNum;
	}

	public String getOrderUserId() {
		return orderUserId;
	}

	public void setOrderUserId(String orderUserId) {
		this.orderUserId = orderUserId;
	}

}
