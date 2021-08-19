package kr.co.persistence;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.domain.ProdStockDTO;

@Repository
public class ProdStockDAOImpl implements ProdStockDAO{
	
	@Autowired
	private SqlSession session;
	
	private final String NAMESPACE = "kr.co.prodStock";
	
	@Override
	public void insertProdStock(ProdStockDTO prodStockDTO) {
		session.insert(NAMESPACE + ".insertProdStock", prodStockDTO);
	}
	
	@Override
	public ProdStockDTO prodStockRead(String prodName) {
		return session.selectOne(NAMESPACE + ".prodStockRead", prodName);
	}
	
	@Override
	public void updateProdStock(ProdStockDTO prodStockDTO) {
		session.update(NAMESPACE + ".updateProdStock", prodStockDTO);
		
	}
	@Override
	public void quantity(Map<String, Object> map) {
		session.update(NAMESPACE+".quantity", map);
		
	}

}
