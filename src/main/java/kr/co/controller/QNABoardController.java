package kr.co.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.domain.QNABoardVO;
import kr.co.domain.QNAPageTO;
import kr.co.service.QNABoardService;

@Controller
@RequestMapping("/qna")
public class QNABoardController {

	@Autowired
	private QNABoardService bService;

	@RequestMapping(value = "/myQNA/{id}", method = RequestMethod.GET)
	public String myList(Model model, @PathVariable("id") String id) {
		int amount = bService.getMyListAmount(id);

		QNAPageTO<QNABoardVO> to = new QNAPageTO<QNABoardVO>(1);
		to.setAmount(amount);

		List<QNABoardVO> list = bService.mylist(to.getStartNum(), id);
		to.setList(list);
		
		model.addAttribute("to", to);
		
		return "qna/myQNA";
	}
}
