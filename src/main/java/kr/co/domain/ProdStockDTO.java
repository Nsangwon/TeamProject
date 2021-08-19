package kr.co.domain;

import java.io.Serializable;

public class ProdStockDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String prodName;
	private Integer prodStockSSize;
	private Integer prodStockMSize;
	private Integer prodStockLSize;

	public ProdStockDTO() {
		// TODO Auto-generated constructor stub
	}

	public ProdStockDTO(String prodName, Integer prodStockSSize, Integer prodStockMSize, Integer prodStockLSize) {
		super();
		this.prodName = prodName;
		this.prodStockSSize = prodStockSSize;
		this.prodStockMSize = prodStockMSize;
		this.prodStockLSize = prodStockLSize;
	}

	public String getProdName() {
		return prodName;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}

	public Integer getProdStockSSize() {
		return prodStockSSize;
	}

	public void setProdStockSSize(Integer prodStockSSize) {
		this.prodStockSSize = prodStockSSize;
	}

	public Integer getProdStockMSize() {
		return prodStockMSize;
	}

	public void setProdStockMSize(Integer prodStockMSize) {
		this.prodStockMSize = prodStockMSize;
	}

	public Integer getProdStockLSize() {
		return prodStockLSize;
	}

	public void setProdStockLSize(Integer prodStockLSize) {
		this.prodStockLSize = prodStockLSize;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	
}