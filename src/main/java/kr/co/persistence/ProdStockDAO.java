package kr.co.persistence;

import java.util.Map;

import kr.co.domain.ProdStockDTO;

public interface ProdStockDAO {

	void insertProdStock(ProdStockDTO prodStockDTO);

	ProdStockDTO prodStockRead(String prodName);
	
	void updateProdStock(ProdStockDTO prodStockDTO);

	void quantity(Map<String, Object> map);
}
