package kr.co.persistence;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.domain.CartDTO;
import kr.co.domain.LoginDTO;
import kr.co.domain.MemberDTO;
import kr.co.domain.OrderVO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	
	@Autowired
	private SqlSession session;
	private final String NAMESPACE ="kr.co.member";
	
	//------------------------------------------
	@Override
	public void insert(MemberDTO dto) {
		session.insert(NAMESPACE + ".insert", dto);
	}


	@Override
	public int idcheck(String userId) {
		return session.selectOne(NAMESPACE + ".idcheck", userId);
	}

	@Override
	public int getAmount() {
		return session.selectOne(NAMESPACE + ".getAmount");
	}


	@Override
	public List<MemberDTO> list(int startNum) {
		RowBounds rb = new RowBounds(startNum - 1, 10);
		return session.selectList(NAMESPACE + ".list", null, rb);
	}


	@Override
	public int getSearchAmount(Map<String, Object> map) {
		return session.selectOne(NAMESPACE + ".getSearchAmount", map);
	}


	@Override
	public List<MemberDTO> search(Map<String, Object> map, int startNum) {
		RowBounds rb = new RowBounds(startNum - 1, 10);
		return session.selectList(NAMESPACE + ".search", map, rb);
	}

	@Override
	public void deleteMember(String userId) {
		session.delete(NAMESPACE + ".deleteMember", userId);
	}

	@Override
	public MemberDTO findId(String userEmail) {
		return session.selectOne(NAMESPACE + ".findId", userEmail);
	}


	@Override
	public MemberDTO findPw(Map<String, Object> map) {
		return session.selectOne(NAMESPACE + ".findPw", map);
	}


	@Override
	public void updateFindPw(Map<String, Object> map) {
		session.update(NAMESPACE + ".updateFindPw", map);
	}


	@Override
	public List<CartDTO> cartlist(String userId) {
		return session.selectList(NAMESPACE + ".cartlist", userId);
	}

	
	
	//-------------------
	
	
	
	@Override
	public void updateOrderProdStatus(OrderVO orderVO) {
		session.update(NAMESPACE+".updateOrderProdStatus", orderVO);
	}
	
	@Override
	public List<OrderVO> managementList(int startNum) {
		RowBounds rb = new RowBounds(startNum-1, 10);
		return session.selectList(NAMESPACE+".managementList",null, rb);
	}
	
	@Override
	public int managementlistAmount() {
		// TODO Auto-generated method stub
		return session.selectOne(NAMESPACE+".managementlistAmount");
	}
	
	@Override
	public void deleteOrder(int orderNum) {
		// TODO Auto-generated method stub
	session.delete(NAMESPACE+".deleteOrder", orderNum)	;
	}
	
	
	@Override
	public void updateOrderAddress(OrderVO orderVO) {
		// TODO Auto-generated method stub
		session.update(NAMESPACE+".updateOrderAddress", orderVO);
	}
	
	
	@Override
	public OrderVO readOrder(int orderNum) {
		// TODO Auto-generated method stub
		return session.selectOne(NAMESPACE+".readOrder", orderNum);
	}
	
	@Override
	public int orderAmount(String userId) {
		// TODO Auto-generated method stub
		return session.selectOne(NAMESPACE+".orderAmount", userId);
	}
	
	@Override
	public List<OrderVO> orderList(String userId,int startnum) {
		// TODO Auto-generated method stub
		RowBounds rb = new RowBounds(startnum-1, 10);
		return session.selectList(NAMESPACE+".orderList", userId, rb);
	}
	
	
	@Override
	public void updateGrade(MemberDTO dto) {
		// TODO Auto-generated method stub
	session.update(NAMESPACE + ".updateGrade", dto)	;
	}

	
	@Override
	public void updateMyself(MemberDTO memberDTO) {
		// TODO Auto-generated method stub
		session.update(NAMESPACE+".updateMyself", memberDTO);
	}
	
	@Override
	public MemberDTO readInfo(String userId) {
		// TODO Auto-generated method stub
		return session.selectOne(NAMESPACE+".readInfo", userId);
	}
	
	@Override
	public MemberDTO login(LoginDTO login) {
		// TODO Auto-generated method stub
		return session.selectOne(NAMESPACE+".login", login);
	}

	@Override
	public String selectEmail(String orderUserId) {
		// TODO Auto-generated method stub
		return session.selectOne(NAMESPACE+".selectEmail", orderUserId);
	}


	@Override
	public int emailcheck(String userEmail) {
		return session.selectOne(NAMESPACE + ".emailcheck", userEmail);
	}


	@Override
	public void order(OrderVO vo) {
		session.insert(NAMESPACE + ".order" , vo);
	}
	
}