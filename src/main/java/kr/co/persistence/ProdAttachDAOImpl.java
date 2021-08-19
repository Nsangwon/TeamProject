package kr.co.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProdAttachDAOImpl implements ProdAttachDAO {

	@Autowired
	private SqlSession session;

	private final String NAMESPACE = "kr.co.prodAttach";

	@Override
	public void insertAttachInfo(String filePath, int bno) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("filePath", filePath);
		map.put("bno", bno);

		session.insert(NAMESPACE + ".insertAttachInfo", map);
	}

	@Override
	public void updateBno(int prodBno) {
		session.update(NAMESPACE + ".updateBno", prodBno);
	}

	@Override
	public void deleteAttachFileBno(int bno) {
		session.delete(NAMESPACE + ".deleteAttachFileBno", bno);

	}

	@Override
	public void updateAttachInfo(String filePath, int bno) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("filePath", filePath);
		map.put("bno", bno);

		session.update(NAMESPACE + ".updateAttachInfo", map);
	}

	@Override
	public List<String> getAttFilePath(int prodBno) {
		return session.selectList(NAMESPACE + ".getAttFilePath", prodBno);
	}

	@Override
	public void deleteFileImgBno(String imgRealName ,  int bno) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("imgRealName", imgRealName);
		map.put("bno", bno);
		
		session.delete(NAMESPACE + ".deleteFileImgBno", map);
		
	}

}
