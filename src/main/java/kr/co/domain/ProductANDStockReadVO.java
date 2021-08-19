package kr.co.domain;

public class ProductANDStockReadVO {
	private String prodName;
	private int prodBno;
	private int prodCategory;
	private String prodTitle;
	private String prodContent;
	private int prodReadCnt;
	private String prodRegdate;
	private String prodUpdatedate;
	private Integer prodPrice;
	private int prodSalesCount;
	private String prodStockName;
	private Integer prodStockSSzie;
	private Integer prodStockMSize;
	private Integer prodStockLSize;

	public ProductANDStockReadVO() {
		// TODO Auto-generated constructor stub
	}

	public ProductANDStockReadVO(String prodName, int prodBno, int prodCategory, String prodTitle, String prodContent,
			int prodReadCnt, String prodRegdate, String prodUpdatedate, Integer prodPrice, int prodSalesCount,
			String prodStockName, Integer prodStockSSzie, Integer prodStockMSize, Integer prodStockLSize) {
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
		this.prodStockName = prodStockName;
		this.prodStockSSzie = prodStockSSzie;
		this.prodStockMSize = prodStockMSize;
		this.prodStockLSize = prodStockLSize;
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

	public int getProdCategory() {
		return prodCategory;
	}

	public void setProdCategory(int prodCategory) {
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

	public String getProdStockName() {
		return prodStockName;
	}

	public void setProdStockName(String prodStockName) {
		this.prodStockName = prodStockName;
	}

	public Integer getProdStockSSzie() {
		return prodStockSSzie;
	}

	public void setProdStockSSzie(Integer prodStockSSzie) {
		this.prodStockSSzie = prodStockSSzie;
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

	
}
