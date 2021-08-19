package kr.co.domain;

import java.io.Serializable;

public class ProductVO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String prodName;
	private int prodBno;
	private String prodCategory;
	private String prodTitle;
	private String prodContent;
	private int prodReadCnt;
	private String prodRegdate;
	private String prodUpdatedate;
	private Integer prodPrice;
	private int prodSalesCount;
	private String prodThumbnail;
	
	
	
	public ProductVO() {
		// TODO Auto-generated constructor stub
	}

	public ProductVO(String prodName, int prodBno, String prodCategory, String prodTitle, String prodContent,
			int prodReadCnt, String prodRegdate, String prodUpdatedate, Integer prodPrice, int prodSalesCount,
			String prodThumbnail) {
		super();
		this.prodName = prodName;
		this.prodBno = prodBno;
		this.prodCategory = prodCategory;
		this.prodTitle = prodTitle;
		this.prodContent = prodContent;
		this.prodReadCnt = prodReadCnt;
		this.prodRegdate = prodRegdate;
		this.prodUpdatedate = prodUpdatedate;
		this.prodPrice = prodPrice;
		this.prodSalesCount = prodSalesCount;
		this.prodThumbnail = prodThumbnail;
	}

	public String getProdName() {
		return prodName;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}

	public int getProdBno() {
		return prodBno;
	}

	public void setProdBno(int prodBno) {
		this.prodBno = prodBno;
	}

	public String getProdCategory() {
		return prodCategory;
	}

	public void setProdCategory(String prodCategory) {
		this.prodCategory = prodCategory;
	}

	public String getProdTitle() {
		return prodTitle;
	}

	public void setProdTitle(String prodTitle) {
		this.prodTitle = prodTitle;
	}

	public String getProdContent() {
		return prodContent;
	}

	public void setProdContent(String prodContent) {
		this.prodContent = prodContent;
	}

	public int getProdReadCnt() {
		return prodReadCnt;
	}

	public void setProdReadCnt(int prodReadCnt) {
		this.prodReadCnt = prodReadCnt;
	}

	public String getProdRegdate() {
		return prodRegdate;
	}

	public void setProdRegdate(String prodRegdate) {
		this.prodRegdate = prodRegdate;
	}

	public String getProdUpdatedate() {
		return prodUpdatedate;
	}

	public void setProdUpdatedate(String prodUpdatedate) {
		this.prodUpdatedate = prodUpdatedate;
	}

	public Integer getProdPrice() {
		return prodPrice;
	}

	public void setProdPrice(Integer prodPrice) {
		this.prodPrice = prodPrice;
	}

	public int getProdSalesCount() {
		return prodSalesCount;
	}

	public void setProdSalesCount(int prodSalesCount) {
		this.prodSalesCount = prodSalesCount;
	}

	public String getProdThumbnail() {
		return prodThumbnail;
	}

	public void setProdThumbnail(String prodThumbnail) {
		this.prodThumbnail = prodThumbnail;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	

}
