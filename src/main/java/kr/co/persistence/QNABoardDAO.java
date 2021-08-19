package kr.co.persistence;

import java.util.List;

import kr.co.domain.LoginDTO;
import kr.co.domain.ProductVO;
import kr.co.domain.QNABoardVO;

public interface QNABoardDAO {
	public void insert(QNABoardVO vo);
	public void update(QNABoardVO vo);
	public void delete(Integer qQno);
	public void deleteqReproot(Integer qQno);
	public void deleteAll(Integer qBno);
	public List<QNABoardVO> list(Integer startNum, Integer qQno);
	public void answer(QNABoardVO vo);
	public int getAmount(Integer qBno);
	public String getPw(Integer qQno);
	public LoginDTO getNowLogin(String userId);
	public ProductVO getBno(String prodName);
	public int getMyListAmount(String id);
	public List<QNABoardVO> myList(Integer startNum, String id);
	public String getProdName(Integer qBno);
}
