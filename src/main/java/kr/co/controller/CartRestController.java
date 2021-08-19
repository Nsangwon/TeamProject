package kr.co.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import kr.co.domain.CartDTO;
import kr.co.service.CartService;

@RestController
@RequestMapping("/carts")
public class CartRestController {
	
	@Autowired
	private CartService cService;

	
	@RequestMapping(value = "/cart", method = RequestMethod.DELETE)
	public int delete(@RequestBody Map<String, Object> map) {
		int result = 0;
		
		String cartNoArr = map.get("cartNo").toString();	// 배열로 전송하고 map로 받은 cartNo 가져오기

		cartNoArr = cartNoArr.replace(" ", "");	// 문자열 공백 제거
		
		String[] cartNo = cartNoArr.split("\\[|,|\\]");	// 문자열 '[' ',' ']' 제거

		for (int i = 1; i < cartNo.length; i++) {
			result = cService.delete(Integer.parseInt(cartNo[i]));	// 체크 선택한 cartNo 값을 비교하여 삭제
		}

		return result;
	}
	
	
	@RequestMapping(value = "/cart", method = RequestMethod.PUT)
	public int update(@RequestBody Map<String, Object> map) {
		int cartNo = Integer.parseInt(map.get("cartNo").toString());
		String userId = map.get("userId").toString();
		String prodName = map.get("prodName").toString();
		String prodSize = map.get("prodSize").toString();
		int amount = Integer.parseInt(map.get("amount").toString());

		CartDTO vo = new CartDTO(cartNo, userId, prodName, prodSize, amount);
		
		int result = cService.update(vo);
		return result;
	}
	
	
	@RequestMapping(value = "/cart", method = RequestMethod.POST)
	public int insert(@RequestBody Map<String, Object> map) {
		String userId = map.get("userId").toString();
		String prodName = map.get("prodName").toString();
		String prodSize = map.get("prodSize").toString();
		int amount = Integer.parseInt(map.get("amount").toString());
		
		CartDTO vo = new CartDTO(-1, userId, prodName, prodSize, amount);
		int result = cService.insert(vo);
		
		return result;
	}
}
