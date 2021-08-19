package kr.co.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.domain.ReviewReplyVO;
import kr.co.persistence.ReviewReplyDAO;

@Service
public class ReviewReplyServiceImpl implements ReviewReplyService{

	@Autowired
	private ReviewReplyDAO rRDao;
	
	@Override
	public void insert(ReviewReplyVO vo) {
		rRDao.insert(vo);
	}
	
	@Override
	public List<ReviewReplyVO> list(int reBno) {
		return rRDao.list(reBno);
	}
	
	@Override
	public int delete(int reRno) {
		return rRDao.delete(reRno);
	}
	
	@Override
	public int update(ReviewReplyVO vo) {
		return rRDao.update(vo);
	}
	
	@Override
	public List<ReviewReplyVO> list(int startNum, int reBno) {
		return rRDao.list(startNum,reBno);
	}
	
	@Override
	public int getAmount(int reBno) {
		
		return rRDao.getAmount(reBno);
	}
}
