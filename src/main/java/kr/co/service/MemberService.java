package kr.co.service;

import java.util.List;
import java.util.Map;

import kr.co.domain.CartDTO;
import kr.co.domain.LoginDTO;
import kr.co.domain.MemberDTO;
import kr.co.domain.OrderVO;

public interface MemberService {
	
	void insert(MemberDTO dto);
	
	int idcheck(String userId);

	int getAmount();

	List<MemberDTO> list(int startNum);

	int getSearchAmount(Map<String, Object> map);

	List<MemberDTO> search(Map<String, Object> map, int startNum);
	
	void deleteMember(String userId);

	MemberDTO findId(String userEmail);

	MemberDTO findPw(Map<String, Object> map);

	void updateFindPw(Map<String, Object> map);

	List<CartDTO> cartlist(String userId);

	
	//-------------------------------
	
	MemberDTO login(LoginDTO login);
	
	MemberDTO readInfo(String userId);
	
	void updateMyself(MemberDTO dto);
	
	void updateGrade(MemberDTO dto);
	
	List<OrderVO> orderList(String userId, int startNum);
	
	int orderAmount(String userId);
	
	OrderVO readOrder(int orderNum);
	
	void updateOrderAddress(OrderVO orderVO);
	
	void deleteOrder(int orderNum);
	
	int managementlistAmount();
	
	List<OrderVO> managementList(int startNum);
	
	void updateOrderProdStatus(OrderVO orderVO);
	
	String selectEmail(String orderUserId);

	int emailcheck(String userEmail);

	void order(OrderVO vo);


}