package kr.co.persistence;

import java.util.List;
import java.util.Map;

import kr.co.domain.OrderVO;
import kr.co.domain.ProductVO;

public interface ProductDAO {

	int getBnoForAttach();

	void insertProduct(ProductVO prodVO);

	int getProdAmount();

	List<ProductVO> listProd(int startNum, Map<String, Object> map);

	ProductVO prodRead(String prodName);

	void readcnt(String prodName);

	ProductVO prodUpdate(String prodName);

	void updateProduct(ProductVO prodVO);

	String getThumnail(String prodName);

	List<String> getThumbFilePath(String prodName);

	void deleteProd(String prodName);

	ProductVO getContent(int bno);

	String prodNameDupCheck(String prodName);

	ProductVO review(Integer prodBno);

	void order(OrderVO vo);

	

}
