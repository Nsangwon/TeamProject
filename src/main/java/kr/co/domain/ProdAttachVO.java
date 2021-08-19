package kr.co.domain;

import java.io.Serializable;

/**
 * 
 * @author kijungyoon
 * 
 * ONLY READ
 */
public class ProdAttachVO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String prodAttProdImg;
	private int prodAttBno;
	private int prodAttPreBno;
	private String prodAttRegdate;

	public ProdAttachVO() {
		// TODO Auto-generated constructor stub
	}

	public ProdAttachVO(String prodAttProdImg, int prodAttBno, int prodAttPreBno, String prodAttRegdate) {
		super();
		this.prodAttProdImg = prodAttProdImg;
		this.prodAttBno = prodAttBno;
		this.prodAttPreBno = prodAttPreBno;
		this.prodAttRegdate = prodAttRegdate;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getProdAttProdImg() {
		return prodAttProdImg;
	}

	public int getProdAttBno() {
		return prodAttBno;
	}

	public int getProdAttPreBno() {
		return prodAttPreBno;
	}

	public String getProdAttRegdate() {
		return prodAttRegdate;
	}

}
