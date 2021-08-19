package kr.co.persistence;

import java.util.List;

import kr.co.domain.ReviewReplyVO;

public interface ReviewReplyDAO {
	
	public void insert(ReviewReplyVO vo);

	public List<ReviewReplyVO> list(int reBno);

	public int delete(int reRno);

	public int update(ReviewReplyVO vo);

	public List<ReviewReplyVO> list(int startNum, int reBno);

	public int getAmount(int reBno);

}
