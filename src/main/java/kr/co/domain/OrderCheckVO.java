package kr.co.domain;

import java.io.Serializable;

public class OrderCheckVO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String prodName;
	private int prodPrice;
	private String prodSize;
	private int prodQuantity;
	
	
	public OrderCheckVO() {
		// TODO Auto-generated constructor stub
	}


	public OrderCheckVO(String prodName, int prodPrice, String prodSize, int prodQuantity) {
		super();
		this.prodName = prodName;
		this.prodPrice = prodPrice;
		this.prodSize = prodSize;
		this.prodQuantity = prodQuantity;
	}


	public String getProdName() {
		return prodName;
	}


	public void setProdName(String prodName) {
		this.prodName = prodName;
	}


	public int getProdPrice() {
		return prodPrice;
	}


	public void setProdPrice(int prodPrice) {
		this.prodPrice = prodPrice;
	}


	public String getProdSize() {
		return prodSize;
	}


	public void setProdSize(String prodSize) {
		this.prodSize = prodSize;
	}


	public int getProdQuantity() {
		return prodQuantity;
	}


	public void setProdQuantity(int prodQuantity) {
		this.prodQuantity = prodQuantity;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	

}
