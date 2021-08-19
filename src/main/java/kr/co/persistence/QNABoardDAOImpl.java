package kr.co.persistence;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.domain.LoginDTO;
import kr.co.domain.ProductVO;
import kr.co.domain.QNABoardVO;

@Repository
public class QNABoardDAOImpl implements QNABoardDAO {
	
	@Autowired
	private SqlSession session;
	
	private final String NAMESPACE="kr.co.qna";
	
	@Override
	public void insert(QNABoardVO vo){
		session.insert(NAMESPACE + ".insert", vo);
	}

	@Override
	public void update(QNABoardVO vo) {
		session.update(NAMESPACE+".update", vo);
	}

	@Override
	public void delete(Integer qQno) {
		// TODO Auto-generated method stub
		session.delete(NAMESPACE+".delete", qQno);
	}
	
	@Override
	public void deleteqReproot(Integer qQno) {
		// TODO Auto-generated method stub
		session.delete(NAMESPACE+".deleteqReproot", qQno);
	}
	
	@Override
	public void deleteAll(Integer qBno) {
		// TODO Auto-generated method stub
		session.delete(NAMESPACE+".deleteAll", qBno);
	}

	@Override
	public List<QNABoardVO> list(Integer startNum, Integer qBno) {

		RowBounds rb = new RowBounds(startNum-1, 6);
		List<QNABoardVO> list = session.selectList(NAMESPACE+".list", qBno, rb); 
		
		return list;
	}
	
	@Override
	public void answer(QNABoardVO vo) {
		// TODO Auto-generated method stub
		session.selectOne(NAMESPACE+".answer", vo);
	}

	@Override
	public int getAmount(Integer qBno) {
		// TODO Auto-generated method stub
		return session.selectOne(NAMESPACE+".getAmount", qBno);
	}

	@Override
	public String getPw(Integer qQno) {
		// TODO Auto-generated method stub
		return session.selectOne(NAMESPACE+".getPw", qQno);
	}

	@Override
	public LoginDTO getNowLogin(String userId) {
		// TODO Auto-generated method stub
		return session.selectOne(NAMESPACE + ".getNowLogin", userId);
	}

	@Override
	public ProductVO getBno(String prodName) {
		// TODO Auto-generated method stub
		return session.selectOne(NAMESPACE + ".getBno", prodName);
	}

	@Override
	public int getMyListAmount(String id) {
		// TODO Auto-generated method stub
		return session.selectOne(NAMESPACE + ".getMyListAmount", id);
	}

	@Override
	public List<QNABoardVO> myList(Integer startNum, String id) {
		// TODO Auto-generated method stub
		RowBounds rb = new RowBounds(startNum-1, 6);
		List<QNABoardVO> list = session.selectList(NAMESPACE+".myList", id, rb); 
		
		return list;
	}

	@Override
	public String getProdName(Integer qBno) {
		// TODO Auto-generated method stub
		return session.selectOne(NAMESPACE + ".getProdName", qBno);
	}
}