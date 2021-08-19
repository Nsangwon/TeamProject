package kr.co.persistence;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class KakaoPayDAOImpl implements KakaoPayDAO {

	@Autowired
	private SqlSession session;
	private final String NAMESPACE = "kr.co.kPay";

	@Override
	public void setONum(int orderNum, String orderUserId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("oNum", orderNum);
		map.put("orderId", orderUserId);
		
		session.insert(NAMESPACE + ".setNum", map);
	}
	
	@Override
	public void setTid(String tid) {
		session.update(NAMESPACE + ".setTid", tid);
	}


	@Override
	public String getTid() {
		return session.selectOne(NAMESPACE + ".getTid");
	}

	@Override
	public void deleteTid() {
		session.delete(NAMESPACE + ".deleteTid");
	}

	@Override
	public int getNum() {
		return session.selectOne(NAMESPACE + ".getNum");
	}
	
	@Override
	public String getId() {
		return session.selectOne(NAMESPACE + ".getId");
	}


}
