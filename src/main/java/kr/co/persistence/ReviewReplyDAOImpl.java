package kr.co.persistence;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.domain.ReviewPageTO;
import kr.co.domain.ReviewReplyVO;

@Repository
public class ReviewReplyDAOImpl implements ReviewReplyDAO{
	
	@Autowired
	private SqlSession session;
	
	private final String NAMESPACE ="kr.co.review";
	
	
	@Override
	public void insert(ReviewReplyVO vo) {
		session.insert(NAMESPACE+".insert", vo);
	}

	@Override
	public List<ReviewReplyVO> list(int reBno) {
		return session.selectList(NAMESPACE+".list", reBno);
	}
	
	@Override
	public int delete(int reRno) {
		return session.delete(NAMESPACE+".delete", reRno);
	}
	
	@Override
	public int update(ReviewReplyVO vo) {
		return session.update(NAMESPACE+".update", vo);
	}
	
	@Override
	public List<ReviewReplyVO> list(int startNum, int reBno) {
		ReviewPageTO<ReviewReplyVO> to = new ReviewPageTO<ReviewReplyVO>();
		int perPage = to.getPerPage();
		RowBounds rb = new RowBounds(startNum-1, perPage);
		
		return session.selectList(NAMESPACE+".list", reBno, rb);
	}
	
	@Override
	public int getAmount(int reBno) {
		return session.selectOne(NAMESPACE+".getAmount", reBno);
	}
}
