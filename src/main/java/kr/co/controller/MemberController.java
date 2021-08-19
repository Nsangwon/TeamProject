package kr.co.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.domain.CartDTO;
import kr.co.domain.LoginDTO;
import kr.co.domain.MemberDTO;
import kr.co.domain.OrderVO;
import kr.co.domain.PageTO;
import kr.co.service.MemberService;

import java.security.SecureRandom;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;


@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService mService;

	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private BCryptPasswordEncoder userPwEncoder;
	
	
	// 장바구니 리스트에서 선택 주문
	@ResponseBody
	@RequestMapping(value = "/order", method = RequestMethod.POST)
	public String order(OrderVO vo, HttpServletRequest request, String checkOrder,
						String sample4_postcode, String sample4_roadAddress, String sample4_detailAddress) {
		HttpSession session = request.getSession();
		MemberDTO loginSession = (MemberDTO) session.getAttribute("login");
		String userAddress = "(" + sample4_postcode + ") " + sample4_roadAddress + " " + sample4_detailAddress;
		
		String userId = loginSession.getUserId();
		
		if (userId == null) {
			System.out.println("로그인이 필요한 작업입니다.");
			return "/member/wrong_login_info";
			
		} else {
			Map<String, Object> map = new HashMap<String, Object>();
			
			// 문자열 '[{' ',' '}]', '"', 'prodName', 'prodSize', 'prodPrice', 'prodQuantity' 제거
			String chkReplace1 = checkOrder.replaceAll("\\[\\{", "").replaceAll("\\}\\]", "");
			String chkReplace2 = chkReplace1.replaceAll("\"prodName\":", "").replaceAll("\"prodSize\":", "").replaceAll("\"prodPrice\":", "").replaceAll("\"prodQuantity\":", "");
			String chkReplace3 = chkReplace2.replaceAll("\\},\\{", "\\},").replaceAll("\"", "");
			
			// 문자열 '},' 을 기점으로 제거 후 ajax로 받아온 데이터 [prodName, prodSize, prodPrice, prodQuantity]으로 배열 생성
			String[] chkArr1 = chkReplace3.split("\\},");

			vo.setOrderUserId(userId);
			vo.setOrderUserAddress(userAddress);
			
			for (int i = 0; i < chkArr1.length; i++) {
				// 문자열 ',' 을 기점으로 제거 후 배열 생성
				String[] chkArr2 = chkArr1[i].split(",");
				
				// prodName, prodSize, prodPrice, prodQuantity 부분만 필요하므로 4씩 나눈 나머지를 기점으로 map에 저장
				for (int j = 0; j < chkArr2.length; j++) {
					if (j % 4 == 0) {
						map.put("prodName", chkArr2[j].toString());
						
					} else if (j % 4 == 1) {
						map.put("prodSize", chkArr2[j].toString());
						
					} else if (j % 4 == 2) {
						map.put("prodPrice", Integer.parseInt(chkArr2[j]));
						
					} else if (j % 4 == 3) {
						map.put("prodQuantity", Integer.parseInt(chkArr2[j]));
					}
				}
				
				vo.setOrderProdName(map.get("prodName").toString());
				vo.setOrderProdSize(map.get("prodSize").toString());
				vo.setOrderProdPrice(Integer.parseInt(map.get("prodPrice").toString()));
				vo.setOrderProdQuantity(Integer.parseInt(map.get("prodQuantity").toString()));
				mService.order(vo);
			}
			
			return "success";
		}
		
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/emailcheck", method = RequestMethod.POST)
	public int emailCheck(String userEmail) {
		int checkResult = mService.emailcheck(userEmail);
		return checkResult;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/idcheck", method = RequestMethod.POST)
	public int idCheck(String userId) {
		int checkResult = mService.idcheck(userId);
		return checkResult;
	}
	
	
	@RequestMapping(value = "/cartlist/{userId}", method = RequestMethod.GET)
	public String cartlist(Model model, @PathVariable("userId") String userId, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberDTO loginSession = (MemberDTO) session.getAttribute("login");
		
		if (loginSession ==  null) {
			System.out.println("로그인이 필요한 작업입니다.");

			return "/member/wrong_login_info";
			
		} else if (!loginSession.getUserId().equals(userId)) {

			return "/member/warning";
			
		} else {
			List<CartDTO> list = mService.cartlist(userId);
			
			model.addAttribute("list", list);
			
			return "/member/cartlist";
		}
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/findPwResult", method = RequestMethod.POST)
	public String findPw(String userId, String userEmail, Model model) {
		char[] charSet = new char[] { 
        		'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 
        		'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 
        		'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 
        		'!', '@', '#', '$', '%', '^', '&' };
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("userEmail", userEmail);
		
		MemberDTO vo = mService.findPw(map);

		model.addAttribute("vo", vo);

        StringBuffer sb = new StringBuffer(); 
        SecureRandom sRandom = new SecureRandom();
        
        sRandom.setSeed(new Date().getTime()); 
        int idx = 0;
		if (vo != null) {
			for (int i=0; i<8; i++) { 
				idx = sRandom.nextInt(charSet.length); 
				sb.append(charSet[idx]); 
			}
			System.out.println("이메일 전송 완료");
			System.out.println("이메일 주소 : " + userEmail);
			System.out.println("임시비밀번호 : " + sb.toString()); 
			//---------
			String setFrom = "msn6903@naver.com";
			String toMail = userEmail;
			String title = "Ezen TestSHOP 임시비밀번호.";
			String content = userId+"님을 위한 임시비밀번호." + "<br><br>"  + sb + "입니다." + "<br>" + "접속 후 비밀번호를 변경해주세요";
			
			try {
				
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
				helper.setFrom(setFrom);
				helper.setTo(toMail);
				helper.setSubject(title);
				helper.setText(content, true);
				mailSender.send(message);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
	        String userPw = sb.toString();
	        
	        String secureUserPw = userPwEncoder.encode(userPw);

	        map.put("userPw", secureUserPw);
	        
	        mService.updateFindPw(map);
	        
	        return userPw;
	        
		} else {
			return "X";
		}
	}


	@RequestMapping(value = "/findPw", method = RequestMethod.GET)
	public void findPw() {
		
	}
	
	

	@ResponseBody
	@RequestMapping(value = "/findIdResult", method = RequestMethod.POST)
	public String findId(String userEmail, Model model) {
		MemberDTO vo = mService.findId(userEmail);

		model.addAttribute("vo", vo);
		
		if (vo != null) {
			String userId = vo.getUserId();
			String findUserId = userId.substring(0, userId.length()-2) + "**";
			return findUserId;
			
		} else {
			return "X";
		}	
			
	}
	
	
	
	@RequestMapping(value = "/findId", method = RequestMethod.GET)
	public void findId() {
		
	}
	
	
	// 회원 목록 검색
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public void search(String selector, String keyword, int curPage, Model model) {
				
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("selector", selector);
		map.put("keyword", keyword);
			
		int getSearchAmount = mService.getSearchAmount(map);
			
		PageTO<MemberDTO> to = new PageTO<MemberDTO>(curPage);
		to.setAmount(getSearchAmount);
		List<MemberDTO> list = mService.search(map, to.getStartNum());
		to.setList(list);
			
		model.addAttribute("to", to);
	}
			
			
	// 회원 목록 페이징
	@RequestMapping(value = "/list/{curPage}", method = RequestMethod.GET)
	public String list(@PathVariable("curPage") int curPage, Model model) {
		int getAmount = mService.getAmount();

		PageTO<MemberDTO> to = new PageTO<MemberDTO>(curPage);
		to.setAmount(getAmount);
			
		List<MemberDTO> list = mService.list(to.getStartNum());
		to.setList(list);
		model.addAttribute("to", to);
				
		return "/member/list";
	}
			
			
	// 회원 목록
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void list(Model model) {
		int curPage = 1;
		int getAmount = mService.getAmount();

		PageTO<MemberDTO> to = new PageTO<MemberDTO>(curPage);
		to.setAmount(getAmount);
				
		List<MemberDTO> list = mService.list(to.getStartNum());
		to.setList(list);
				
		model.addAttribute("to", to);
	}		
	
	
	
	
	
	
	
	
	
	
//---------------------------------------------------------------

	@RequestMapping(value = "/managementlist/{curPage}", method = RequestMethod.GET)
	public String managementlist(@PathVariable("curPage") int curPage,Model model) {

		int managementlistAmount = mService.managementlistAmount();
		PageTO<OrderVO> to = new PageTO<OrderVO>(curPage);
		to.setAmount(managementlistAmount);
		
		
		List<OrderVO> list = mService.managementList(to.getStartNum());
		
		to.setList(list);
		model.addAttribute("list", list);
		model.addAttribute("to", to);
		
		return "/member/managementlist";
	}
	
	
	@RequestMapping(value = "/managementlist", method = RequestMethod.GET)
	public void managementlist(Model model) {
		int curPage = 1;
		int managementlistAmount = mService.managementlistAmount();
		PageTO<OrderVO> to = new PageTO<OrderVO>(curPage);
		to.setAmount(managementlistAmount);
		
		
		List<OrderVO> list = mService.managementList(to.getStartNum());
		
		to.setList(list);
		model.addAttribute("list", list);
		model.addAttribute("to", to);
	}
	
	
	@RequestMapping(value = "/orderManagement/{orderNum}", method = RequestMethod.GET)
	public String orderManagement(@PathVariable ("orderNum") int orderNum, Model model) {
		OrderVO vo = mService.readOrder(orderNum);
		
		model.addAttribute("vo", vo);
		return "/member/orderManagement";
	}
	
	
	
	@RequestMapping(value = "/orderManagement", method = RequestMethod.POST)
	@ResponseBody
	public String orderManagement(int orderNum, int orderProdStatus, long orderTrackingNum, String orderUserId) {
		if (orderProdStatus == 2) {
			System.out.println(orderTrackingNum);

			mService.updateOrderProdStatus(
					new OrderVO(orderNum, null, 0, 0, null, null, null, orderProdStatus, orderTrackingNum));

			String userEmail = mService.selectEmail(orderUserId);

			System.out.println(userEmail);
			System.out.println("메일 전송 완료");
			System.out.println("운송장번호 : " + orderTrackingNum);

			String setFrom = "msn6903@naver.com";
			String toMail = userEmail;
			String title = "Ezen TestSHOP에서 고객님이 주문하신 상품의 배송이 시작되었습니다.";
			String content = "고객님께서 주문하신 상품의 운송장번호는 " + orderTrackingNum + "입니다.";
			try {

				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
				helper.setFrom(setFrom);
				helper.setTo(toMail);
				helper.setSubject(title);
				helper.setText(content, true);
				mailSender.send(message);

			} catch (Exception e) {
				e.printStackTrace();
			}

			return "1";

		} else if (orderProdStatus == 3) {
			System.out.println(orderTrackingNum);

			mService.updateOrderProdStatus(
					new OrderVO(orderNum, null, 0, 0, null, null, null, orderProdStatus, orderTrackingNum));

			String userEmail = mService.selectEmail(orderUserId);

			System.out.println(userEmail);
			System.out.println("메일 전송 완료");
			System.out.println("운송장번호 : " + orderTrackingNum);

			String setFrom = "msn6903@naver.com";
			String toMail = userEmail;
			String title = "Ezen TestSHOP 상품 도착 알림.";
			String content = "고객님께서 주분하신 상품의 배송이 완료되었습니다. 운송장번호 " + orderTrackingNum + "상품에 대한 추가 문의는 홈페이지를 통해 남겨주세요.";
			try {

				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
				helper.setFrom(setFrom);
				helper.setTo(toMail);
				helper.setSubject(title);
				helper.setText(content, true);
				mailSender.send(message);

			} catch (Exception e) {
				e.printStackTrace();
			}

			return "1";
		}

		else {
			System.out.println(orderTrackingNum);

			mService.updateOrderProdStatus(new OrderVO(orderNum, null, 0, 0, null, null, null, orderProdStatus, 0));

			String userEmail = mService.selectEmail(orderUserId);

			System.out.println(userEmail);

			return "1";
		}
	}
	
	
	@RequestMapping(value = "/deleteOrder", method = RequestMethod.POST)
	@ResponseBody
	public String deleteOrder(int orderNum) {
		mService.deleteOrder(orderNum);

		return "/member/orderTracking";
	}
	
	
//	/member/updateOrderAddress
	@RequestMapping(value = "/updateOrderAddress", method = RequestMethod.POST)
	@ResponseBody
	public String updateOrderAddress(int orderNum,String sample4_postcode, String sample4_roadAddress, String sample4_detailAddress) {
		String orderUserAddress  = "(" + sample4_postcode + ") " + sample4_roadAddress + " " + sample4_detailAddress;

		mService.updateOrderAddress(new OrderVO(orderNum, null, 0, 0, null, null, orderUserAddress, 0,0));
		
		return "1";
		
	}
	
	
	@RequestMapping(value = "/readOrder/{orderNum}", method = RequestMethod.GET)
	public String readOrder(@PathVariable("orderNum") int orderNum, Model model) {
		OrderVO vo = mService.readOrder(orderNum);
		
		model.addAttribute("vo", vo);
		return "/member/readOrder";
	}

	
	@RequestMapping(value = "/orderTracking/{curPage}/{userId}", method = RequestMethod.GET)
	public String orderTracking(@PathVariable("curPage") int curPage, @PathVariable("userId") String userId, Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberDTO loginSession = (MemberDTO) session.getAttribute("login");
		
		if (!loginSession.getUserId().equals(userId)) {
			return "/member/warning";
		} 
		
		int orderAmount = mService.orderAmount(userId);
		PageTO<OrderVO> to = new PageTO<OrderVO>(curPage);
		to.setAmount(orderAmount);

		List<OrderVO> list = mService.orderList(userId, to.getStartNum());
		
		to.setList(list);
		model.addAttribute("list", list);
		model.addAttribute("to", to);

		return "/member/orderTracking";
	}
	
	
	
	
	@RequestMapping(value = "/orderTracking/{orderUserId}", method = RequestMethod.GET)
	public String orderTracking(@PathVariable("orderUserId") String orderUserId, Model model, HttpServletRequest request) {
		
		String userId = orderUserId;
		
		HttpSession session = request.getSession();
		MemberDTO loginSession = (MemberDTO) session.getAttribute("login");
		
		if (!loginSession.getUserId().equals(userId)) {
			return "/member/warning";
		} 
		
		int curPage = 1;
		int orderAmount = mService.orderAmount(userId);
		PageTO<OrderVO> to = new PageTO<OrderVO>(curPage);
		to.setAmount(orderAmount);
		
		List<OrderVO> list = mService.orderList(userId,to.getStartNum());
		
		to.setList(list);
		model.addAttribute("list", list);
		model.addAttribute("to", to);
		
		return "/member/orderTracking";
	}
	

	
	
	@RequestMapping(value = "/updateGrade", method = RequestMethod.POST)
	public String updateGrade(MemberDTO dto, String userId, int userGrade) {
		dto.setUserId(userId);
		dto.setUserGrade(userGrade);
		
		mService.updateGrade(dto);

		return "redirect:/member/list";

	}
	
	
	

	@RequestMapping(value = "/readByAdmin/{userId}", method = RequestMethod.GET)
	public String readByAdmin(@PathVariable("userId") String userId, Model model) {
		MemberDTO dto = mService.readInfo(userId);

		model.addAttribute("dto", dto);

		return "/member/readByAdmin";

	}

	
	@RequestMapping(value = "/noadmin", method = RequestMethod.GET)
	public void noadmin() {

	}

	
	@RequestMapping(value = "/updateMyself", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String updateMyself(String userId, String userPw, String userName, String userEmail, String userBirthday,
			String userAddress, String sample4_postcode,String sample4_roadAddress, String sample4_detailAddress) {
		
		String secureUserPw = userPwEncoder.encode(userPw);
		
		if (sample4_postcode == "") {
			String userAddressTrue = userAddress;
			
			mService.updateMyself(
					new MemberDTO(userId, secureUserPw, userName, userEmail, userBirthday, userAddressTrue, null, null, 0));

			return userAddressTrue;
			
		}else {
			String userAddressTrue = "(" + sample4_postcode + ") " + sample4_roadAddress + " " + sample4_detailAddress;
			mService.updateMyself(
					new MemberDTO(userId, secureUserPw, userName, userEmail, userBirthday, userAddressTrue, null, null, 0));

			return userAddressTrue;
		}

	}

	
	// 관리자용 회원 삭제
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String delete(String userId) {
		
		mService.deleteMember(userId);
		
		// userGrade가 관리자일 때 이동, 일반 사용자는 loginGet.jsp로 이동
		return "/member/list";	
	}
	

	@RequestMapping(value = "/readSelf", method = RequestMethod.POST)
	public void read(String readuserId, Model model) {
		String userId = readuserId;

		MemberDTO dto = mService.readInfo(userId);

		model.addAttribute("dto", dto);

	}
	
	
	@ResponseBody
	@RequestMapping(value = "/readInfoCheck", method = RequestMethod.GET)
	public int readInfoCheck(String userId, String userPw) {

		MemberDTO dto = mService.readInfo(userId);
		boolean isUserPw = userPwEncoder.matches(userPw, dto.getUserPw());

		if (isUserPw) {
			return 1;
			
		} else {
			return 0;
		}
	}



	@RequestMapping(value = "/sign", method = RequestMethod.POST)
	public String sign(MemberDTO dto, int userGrade, String sample4_postcode, String sample4_roadAddress, String sample4_detailAddress) {
		
		String secureUserPw = userPwEncoder.encode(dto.getUserPw());
		String userAddress = "(" + sample4_postcode + ") " + sample4_roadAddress + " " + sample4_detailAddress;
		
		dto.setUserPw(secureUserPw);
		dto.setUserAddress(userAddress);
		dto.setUserGrade(userGrade);

		mService.insert(dto);
		
		return "redirect:/member/loginGet";
	}

	@ResponseBody
	@RequestMapping(value = "/mailCheck", method = RequestMethod.GET)
	public String mailCheckGET(String userEmail){

		System.out.println("이메일 데이터 전송 확인");
		System.out.println("이메일 주소 : " + userEmail);
		
		Random random = new Random();
		random.setSeed(new Date().getTime()); // 현재 시간을 기반으로 매번 변경되는 시드값을 사용
		
		int checkNum = random.nextInt(888888) + 111111;
		System.out.println("인증번호 : " + checkNum);

	
		String setFrom = "msn6903@naver.com";
		String toMail = userEmail;
		String title = "Ezen TestSHOP 회원가입 인증메일입니다..";
		String content = "회원가입을 위한 인증번호." + "<br><br>" + "6자리 숫자 " + checkNum + "입니다." + "<br>"
				+ "인증번호를 입력해 회원가입을 완료해주세요.";
		try {

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String num = Integer.toString(checkNum);

		return num;
	}
	

	@RequestMapping(value = "/adress", method = RequestMethod.GET)
	public void adress() {

	}

	@RequestMapping(value = "/sign", method = RequestMethod.GET)
	public void sign() {

	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout() {

		return "redirect:/";

	}


	@RequestMapping(value = "/loginGet", method = RequestMethod.GET)
	public void login() {
	
 
	}

	@RequestMapping(value = "/loginPost", method = RequestMethod.POST)
	public void login(LoginDTO login, Model model) {
		MemberDTO dto = mService.login(login);
		
		if (dto != null) {
			boolean isUserPw = userPwEncoder.matches(login.getUserPw(), dto.getUserPw());

			if (isUserPw) {
				model.addAttribute("login", dto);
			}
			
		} else {
			System.out.println("아이디 혹은 비밀번호를 잘못 입력하셨거나 등록되지 않은 아이디입니다.");
		}
	}

}
