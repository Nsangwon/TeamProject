package kr.co.domain;

import java.io.Serializable;

/**
 * 
 * @author kijungyoon #READ ONLY
 *
 */
public class ProdThumVO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String prodName;
	private int prodBno;
	private int prodCategory;
	private Integer prodPrice;
	private int prodSalesCount;
	private String prodRegdate;
	private String prodThumbnail;

	public ProdThumVO() {
		// TODO Auto-generated constructor stub
	}

	public ProdThumVO(String prodName, int prodBno, int prodCategory, Integer prodPrice, int prodSalesCount,
			String prodRegdate, String prodThumbnail) {
		super();
		this.prodName = prodName;
		this.prodBno = prodBno;
		this.prodCategory = prodCategory;
		this.prodPrice = prodPrice;
		this.prodSalesCount = prodSalesCount;
		this.prodRegdate = prodRegdate;
		this.prodThumbnail = prodThumbnail;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getProdName() {
		return prodName;
	}

	public int getProdBno() {
		return prodBno;
	}

	public int getProdCategory() {
		return prodCategory;
	}

	public Integer getProdPrice() {
		return prodPrice;
	}

	public int getProdSalesCount() {
		return prodSalesCount;
	}

	public String getProdRegdate() {
		return prodRegdate;
	}

	public String getProdThumbnail() {
		return prodThumbnail;
	}

}
