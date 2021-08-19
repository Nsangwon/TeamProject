package kr.co.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.domain.LoginDTO;
import kr.co.domain.ProductVO;
import kr.co.domain.QNABoardVO;
import kr.co.persistence.QNABoardDAO;

@Service
public class QNABoardServiceImpl implements QNABoardService {
	
	@Autowired
	private QNABoardDAO qDao;
	
	@Transactional
	@Override
	public void insert(QNABoardVO vo) 
	{
		// TODO Auto-generated method stub
		qDao.insert(vo);
	}

	@Override
	public void update(QNABoardVO vo) {
		// TODO Auto-generated method stub
		qDao.update(vo);
	}

	@Transactional
	@Override
	public void delete(Integer qQno) {
		qDao.delete(qQno);
	}

	@Override
	public void deleteqReproot(int qQno) {
		// TODO Auto-generated method stub
		qDao.deleteqReproot(qQno);
	}
	
	@Override
	public void deleteAll(Integer qBno) {
		// TODO Auto-generated method stub
		qDao.deleteAll(qBno);
	}

	@Override
	public List<QNABoardVO> list(Integer startNum, Integer qQno) {
		// TODO Auto-generated method stub
		return qDao.list(startNum, qQno);
	}

	@Override
	public void answer(QNABoardVO vo) {
		// TODO Auto-generated method stub
		qDao.answer(vo);
	}

	@Override
	public int getAmount(Integer qBno) {
		// TODO Auto-generated method stub
		return qDao.getAmount(qBno);
	}

	@Override
	public String getPw(Integer qQno) {
		// TODO Auto-generated method stub
		return qDao.getPw(qQno);
	}

	@Override
	public LoginDTO getNowLogin(String userId) {
		// TODO Auto-generated method stub
		return qDao.getNowLogin(userId);
	}

	@Override
	public ProductVO getBno(String prodName) {
		// TODO Auto-generated method stub
		return qDao.getBno(prodName);
	}

	@Override
	public int getMyListAmount(String id) {
		// TODO Auto-generated method stub
		return qDao.getMyListAmount(id);
	}

	@Override
	public List<QNABoardVO> mylist(Integer startNum, String id) {
		// TODO Auto-generated method stub
		return qDao.myList(startNum, id);
	}

	@Override
	public String getProdName(Integer qBno) {
		// TODO Auto-generated method stub
		return qDao.getProdName(qBno);
	}
}
