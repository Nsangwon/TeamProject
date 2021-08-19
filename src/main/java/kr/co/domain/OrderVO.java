package kr.co.domain;

import java.io.Serializable;

public class OrderVO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int orderNum;
	private String orderProdName;
	private int orderProdPrice;
	private int orderProdQuantity;
	private String orderProdSize;
	private String orderUserId;
	private String orderUserAddress;
	private int orderProdStatus;
	private long orderTrackingNum;
	
	
	public OrderVO() {
		// TODO Auto-generated constructor stub
	}


	public OrderVO(int orderNum, String orderProdName, int orderProdPrice, int orderProdQuantity, String orderProdSize,
			String orderUserId, String orderUserAddress, int orderProdStatus, long orderTrackingNum) {
		super();
		this.orderNum = orderNum;
		this.orderProdName = orderProdName;
		this.orderProdPrice = orderProdPrice;
		this.orderProdQuantity = orderProdQuantity;
		this.orderProdSize = orderProdSize;
		this.orderUserId = orderUserId;
		this.orderUserAddress = orderUserAddress;
		this.orderProdStatus = orderProdStatus;
		this.orderTrackingNum = orderTrackingNum;
	}


	public int getOrderNum() {
		return orderNum;
	}


	public void setOrderNum(int orderNum) {
		this.orderNum = orderNum;
	}


	public String getOrderProdName() {
		return orderProdName;
	}


	public void setOrderProdName(String orderProdName) {
		this.orderProdName = orderProdName;
	}


	public int getOrderProdPrice() {
		return orderProdPrice;
	}


	public void setOrderProdPrice(int orderProdPrice) {
		this.orderProdPrice = orderProdPrice;
	}


	public int getOrderProdQuantity() {
		return orderProdQuantity;
	}


	public void setOrderProdQuantity(int orderProdQuantity) {
		this.orderProdQuantity = orderProdQuantity;
	}


	public String getOrderProdSize() {
		return orderProdSize;
	}


	public void setOrderProdSize(String orderProdSize) {
		this.orderProdSize = orderProdSize;
	}


	public String getOrderUserId() {
		return orderUserId;
	}


	public void setOrderUserId(String orderUserId) {
		this.orderUserId = orderUserId;
	}


	public String getOrderUserAddress() {
		return orderUserAddress;
	}


	public void setOrderUserAddress(String orderUserAddress) {
		this.orderUserAddress = orderUserAddress;
	}


	public int getOrderProdStatus() {
		return orderProdStatus;
	}


	public void setOrderProdStatus(int orderProdStatus) {
		this.orderProdStatus = orderProdStatus;
	}


	public long getOrderTrackingNum() {
		return orderTrackingNum;
	}


	public void setOrderTrackingNum(int orderTrackingNum) {
		this.orderTrackingNum = orderTrackingNum;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
}