package kr.co.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.domain.KakaoPayReadyVO;
import kr.co.domain.OrderVO;
import kr.co.persistence.KakaoPayDAO;

@RequestMapping("/kakaoPay")
@Controller
public class KakaoPayController {

	@Autowired
	private KakaoPayDAO kDAO;

	   @RequestMapping(value = "/kakaoPayCancel", method = RequestMethod.GET)
	   public String kakaoPayCancel()
	   {
	      kDAO.deleteTid();
	      
	      return "back";
	   }
	
	@RequestMapping(value = "/payReady", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public void kakaoPayGet() {

	}
	
	@ResponseBody
	@RequestMapping(value = "/payReady", method = RequestMethod.POST)
	public String kakaoPayPost(@RequestBody OrderVO orderVO) {

		try {
			URL address = new URL("https://kapi.kakao.com/v1/payment/ready");
			HttpURLConnection conn = (HttpURLConnection) address.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "KakaoAK 9461755b34d81bc1c7ff55440aad4160");
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			conn.setDoOutput(true);

			String cid = "cid=TC0ONETIME&";
			String poi = "partner_order_id=9999&";
			String pui = "partner_user_id=kpApiTest&";
			String itemName = "item_name=" + orderVO.getOrderProdName() + "&";
			String quantity = "quantity=" + Integer.toString(orderVO.getOrderProdQuantity()) + "&";
			String price = "total_amount=" + Integer.toString(orderVO.getOrderProdPrice()*orderVO.getOrderProdQuantity()) + "&";
			String tax = "tax_free_amount=" + Integer.toString(orderVO.getOrderProdPrice() / 10) + "&";
			String success = "approval_url=http://localhost:8089/kakaoPay/paySuccess&";
			String cancel = "cancel_url=http://localhost:8089/kakaoPayCancel&";
			String fail = "fail_url=http://localhost:8089/kakaoPaySuccessFail";
			System.out.println(orderVO.getOrderUserId());
			
			kDAO.setONum(orderVO.getOrderNum(), orderVO.getOrderUserId());

			String params = cid + poi + pui + itemName + quantity + price + tax + success + cancel + fail;
			OutputStream data = conn.getOutputStream();
			DataOutputStream dataOutput = new DataOutputStream(data);
			dataOutput.writeBytes(params);
			dataOutput.close();

			int result = conn.getResponseCode();
			

			InputStream inputData;
			if (result == 200) {
				inputData = conn.getInputStream();
			} else {
				inputData = conn.getErrorStream();
			}

			InputStreamReader dataReader = new InputStreamReader(inputData);

			BufferedReader buff = new BufferedReader(dataReader);

			return buff.readLine();

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return "error";

	}

	@RequestMapping(value = "/getTid", method = RequestMethod.POST)
	public void getTid(@RequestBody KakaoPayReadyVO kpVO) {
		
		kDAO.setTid(kpVO.getTid());

		String tid = kDAO.getTid();
		System.out.println(tid);

	}

	@RequestMapping(value = "/paySuccess", method = RequestMethod.GET)
	public String kakaoPaySuccess(@RequestParam("pg_token") String pg_token, Model model) {
		if (kDAO.getTid() != null) {
			try {
				URL address = new URL("https://kapi.kakao.com/v1/payment/approve");
				HttpURLConnection conn = (HttpURLConnection) address.openConnection();
				conn.setRequestMethod("POST");
				conn.setRequestProperty("Authorization", "KakaoAK 9461755b34d81bc1c7ff55440aad4160");
				conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
				conn.setDoOutput(true);
				
				int oNum = kDAO.getNum();
				String orderUserId = kDAO.getId();
				

				String cid = "cid=TC0ONETIME&";
				String tid = "tid=" + (kDAO.getTid()) + "&";
				String poi = "partner_order_id=9999&";
				String pui = "partner_user_id=kpApiTest&";
				String token = "pg_token=" + pg_token;

				String params = cid + tid + poi + pui + token;
				OutputStream data = conn.getOutputStream();
				DataOutputStream dataOutput = new DataOutputStream(data);
				dataOutput.writeBytes(params);
				dataOutput.close();

				int result = conn.getResponseCode();

				InputStream inputData;
				if (result == 200) {
					inputData = conn.getInputStream();
				} else {
					inputData = conn.getErrorStream();
				}

				InputStreamReader dataReader = new InputStreamReader(inputData);

				BufferedReader buff = new BufferedReader(dataReader);
				model.addAttribute("approve", buff.readLine());
				model.addAttribute("orderNum", oNum);
				model.addAttribute("orderUserId", orderUserId);
				return "/member/payapprove";

			} catch (MalformedURLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				kDAO.deleteTid();
			}
		}
		
		kDAO.deleteTid();
		return null;

	}
}
