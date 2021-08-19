package kr.co.service;

import java.util.List;

public interface ProdAttachService {

	void insertAttachInfo(String filePath, int bno);

	void updateBno(int prodBno);

	void UpdateAttachInfo(String filePath, int bno);

	List<String> getAttFilePath(int prodBno);

}
