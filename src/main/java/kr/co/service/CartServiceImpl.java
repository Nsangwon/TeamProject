package kr.co.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.domain.CartDTO;
import kr.co.persistence.CartDAO;

@Service
public class CartServiceImpl implements CartService{
	
	@Autowired
	private CartDAO cDao;
	
	@Override
	public int insert(CartDTO vo) {
		return cDao.insert(vo);
	}

	@Override
	public int delete(int cartNo) {
		return cDao.delete(cartNo);
	}

	@Override
	public int update(CartDTO vo) {
		return cDao.update(vo);
	}

	@Override
	public List<CartDTO> orderCheckList(int parseInt) {
		return cDao.orderCheckList(parseInt);
	}

	
}
