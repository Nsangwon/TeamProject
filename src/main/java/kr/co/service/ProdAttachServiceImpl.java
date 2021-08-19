package kr.co.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.persistence.ProdAttachDAO;

@Service
public class ProdAttachServiceImpl implements ProdAttachService {

	@Autowired
	private ProdAttachDAO prodAttachDAO;

	@Override
	public void insertAttachInfo(String filePath, int bno) {
		prodAttachDAO.insertAttachInfo(filePath, bno);
	}

	@Override
	public void updateBno(int prodBno) {
		prodAttachDAO.updateBno(prodBno);
	}

	@Override
	public void UpdateAttachInfo(String filePath, int bno) {
		prodAttachDAO.updateAttachInfo(filePath, bno);
	}

	@Override
	public List<String> getAttFilePath(int prodBno) {
		return prodAttachDAO.getAttFilePath(prodBno);
	}

	

	

}
