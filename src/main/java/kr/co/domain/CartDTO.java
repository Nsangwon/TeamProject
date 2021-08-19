package kr.co.domain;

import java.io.Serializable;

public class CartDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int cartNo;
	private String userId;
	private String prodName;
	private String prodSize;
	private int amount;
	
	private MemberDTO memberDTO;
	private ProductVO productVO;
	private ProdStockDTO prodStockDTO;
	

	public CartDTO() {
	// TODO Auto-generated constructor stub
	}


	public CartDTO(int cartNo, String userId, String prodName, String prodSize, int amount) {
		super();
		this.cartNo = cartNo;
		this.userId = userId;
		this.prodName = prodName;
		this.prodSize = prodSize;
		this.amount = amount;
	}


	public int getCartNo() {
		return cartNo;
	}


	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public String getProdName() {
		return prodName;
	}


	public void setProdName(String prodName) {
		this.prodName = prodName;
	}


	public String getProdSize() {
		return prodSize;
	}


	public void setProdSize(String prodSize) {
		this.prodSize = prodSize;
	}


	public int getAmount() {
		return amount;
	}


	public void setAmount(int amount) {
		this.amount = amount;
	}


	public MemberDTO getMemberDTO() {
		return memberDTO;
	}


	public void setMemberDTO(MemberDTO memberDTO) {
		this.memberDTO = memberDTO;
	}


	public ProductVO getProductVO() {
		return productVO;
	}


	public void setProductVO(ProductVO productVO) {
		this.productVO = productVO;
	}


	public ProdStockDTO getProdStockDTO() {
		return prodStockDTO;
	}


	public void setProdStockDTO(ProdStockDTO prodStockDTO) {
		this.prodStockDTO = prodStockDTO;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	
	
}
