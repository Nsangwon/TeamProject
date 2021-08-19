package kr.co.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.domain.ProductVO;
import kr.co.service.ProductService;

@Controller
@RequestMapping("/prodBoard")
public class ReviewReplyController {

	@Autowired
	private ProductService pService;
	
	@RequestMapping(value = "/review/{prodBno}", method = RequestMethod.GET)
	public String reveiw(Model model,@PathVariable("prodBno") Integer prodBno) {
		ProductVO vo = pService.review(prodBno);
		model.addAttribute("vo", vo);
		
		return "/prodBoard/review";
	}
}
