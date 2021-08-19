package kr.co.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.domain.ProdStockDTO;
import kr.co.persistence.ProdStockDAO;

@Service
public class ProdStockServiceImpl implements ProdStockService{
	
	@Autowired
	private ProdStockDAO prodStockDAO;
	
	@Override
	public void insertProdStock(ProdStockDTO prodStockDTO) {
		prodStockDAO.insertProdStock(prodStockDTO);
	}
	
	@Override
	public ProdStockDTO prodStockRead(String prodName) {
		return prodStockDAO.prodStockRead(prodName);
	}
	
	@Override
	public void updateProdStock(ProdStockDTO prodStockDTO) {
		prodStockDAO.updateProdStock(prodStockDTO);
		
	}

}
