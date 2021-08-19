package kr.co.service;

import java.util.List;

import kr.co.domain.CartDTO;

public interface CartService {

	int insert(CartDTO vo);
	
	int delete(int cartNo);
	
	int update(CartDTO vo);

	List<CartDTO> orderCheckList(int parseInt);


}
