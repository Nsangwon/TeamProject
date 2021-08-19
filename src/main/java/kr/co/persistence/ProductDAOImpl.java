package kr.co.persistence;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.domain.OrderVO;
import kr.co.domain.ProductVO;

@Repository
public class ProductDAOImpl implements ProductDAO {

	@Autowired
	private SqlSession session;

	private final String NAMESPACE = "kr.co.product";

	@Override
	public int getBnoForAttach() {
		return session.selectOne(NAMESPACE + ".getBnoForAttach");
	}

	@Override
	public void insertProduct(ProductVO prodVO) {
		session.insert(NAMESPACE + ".insertProduct", prodVO);
	}

	@Override
	public int getProdAmount() {
		return session.selectOne(NAMESPACE + ".getProdAmount");
	}
	
	@Override
	public List<ProductVO> listProd(int startNum, Map<String, Object> map) {
		
		RowBounds rb = new RowBounds(startNum - 1, 12);
		
		return session.selectList(NAMESPACE + ".listProd", map, rb);
	}
	
	@Override
	public ProductVO prodRead(String prodName) {
		return session.selectOne(NAMESPACE + ".prodRead", prodName);
	}
	
	@Override
	public void readcnt(String prodName) {
		session.update(NAMESPACE + ".readcnt", prodName);
		
	}

	@Override
	public ProductVO prodUpdate(String prodName) {
		// TODO Auto-generated method stub
		return session.selectOne(NAMESPACE + ".prodRead", prodName);
	}

	@Override
	public void updateProduct(ProductVO prodVO) {
		session.update(NAMESPACE + ".updateProduct", prodVO);
		
	}

	@Override
	public String getThumnail(String prodName) {
		// TODO Auto-generated method stub
		return session.selectOne(NAMESPACE + ".getThumnail", prodName);
	}
	
	@Override
	public List<String> getThumbFilePath(String prodName) {
		return session.selectList(NAMESPACE + ".getThumbFilePath", prodName);
	}
	
	@Override
	public void deleteProd(String prodName) {
		session.delete(NAMESPACE + ".deleteProd", prodName);
	}

	@Override
	public ProductVO getContent(int bno) {
		// TODO Auto-generated method stub
		return session.selectOne(NAMESPACE+".getContent", bno);
	}

	@Override
	public String prodNameDupCheck(String prodName) {
		// TODO Auto-generated method stub
		return session.selectOne(NAMESPACE + ".prodNameDupCheck", prodName);
	}
	
	@Override
	public ProductVO review(Integer prodBno) {
		
		return session.selectOne(NAMESPACE+".review", prodBno);
	}

	@Override
	public void order(OrderVO vo) {
		session.insert(NAMESPACE+".order" , vo);		
	}

	
	

}
