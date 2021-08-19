package kr.co.persistence;

import java.util.List;


public interface ProdAttachDAO {

	void insertAttachInfo(String filePath, int bno);

	void updateBno(int prodBno);

	void deleteAttachFileBno(int bno);

	void updateAttachInfo(String filePath, int bno);

	List<String> getAttFilePath(int prodBno);

	void deleteFileImgBno(String imgRealName , int bno);

}
