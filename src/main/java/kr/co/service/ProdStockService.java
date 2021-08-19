package kr.co.service;

import kr.co.domain.ProdStockDTO;

public interface ProdStockService {

	void insertProdStock(ProdStockDTO prodStockDTO);

	ProdStockDTO prodStockRead(String prodName);
	
	void updateProdStock(ProdStockDTO prodStockDTO);

}
