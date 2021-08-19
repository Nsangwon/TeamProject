package kr.co.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.domain.CartDTO;

@Repository
public class CartDAOImpl implements CartDAO{
	
	@Autowired
	private SqlSession session;
	private final String NAMESPACE = "kr.co.cart";
	
	
	@Override
	public int insert(CartDTO vo) {
		return session.insert(NAMESPACE + ".insert", vo);
	}
	
	
	@Override
	public int delete(int cartNo) {
		return session.delete(NAMESPACE + ".delete", cartNo);
	}


	@Override
	public int update(CartDTO vo) {
		return session.update(NAMESPACE + ".update", vo);
	}


	@Override
	public List<CartDTO> orderCheckList(int parseInt) {
		return session.selectList(NAMESPACE + ".list", parseInt);
	}

	
}
