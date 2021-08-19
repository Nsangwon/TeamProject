package kr.co.persistence;

import java.util.List;
import java.util.Map;

import kr.co.domain.CartDTO;
import kr.co.domain.LoginDTO;
import kr.co.domain.MemberDTO;
import kr.co.domain.OrderVO;

public interface MemberDAO {
	
	public MemberDTO login(LoginDTO login);

	public MemberDTO readInfo(String userId);

	public void updateMyself(MemberDTO memberDTO);

	public void updateGrade(MemberDTO dto);

	public List<OrderVO> orderList(String userId, int startnum);

	public int orderAmount(String userId);

	public OrderVO readOrder(int orderNum);

	public void updateOrderAddress(OrderVO orderVO);

	public void deleteOrder(int orderNum);

	public int managementlistAmount();

	public List<OrderVO> managementList(int startNum);

	public void updateOrderProdStatus(OrderVO orderVO);

	public String selectEmail(String orderUserId);
	
	//-------------------------------------------
	
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

	int emailcheck(String userEmail);

	void order(OrderVO vo);

}
