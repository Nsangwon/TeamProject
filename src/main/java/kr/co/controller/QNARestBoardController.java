package kr.co.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import kr.co.domain.QNABoardVO;
import kr.co.domain.QNAPageTO;
import kr.co.service.QNABoardService;

@RestController
@RequestMapping("/qnaPage")
public class QNARestBoardController {

	@Autowired
	private QNABoardService bService;

	@RequestMapping(value = "/delete", method = RequestMethod.DELETE)
	public void delete(@RequestBody Map<String, Object> map) {
		int qQno = Integer.parseInt(map.get("qQno").toString());
		
		bService.delete(qQno);
	}
	
	@RequestMapping(value = "/deleteqReproot", method = RequestMethod.DELETE)
	public void deleteqReproot(@RequestBody Map<String, Object> map) {
		int qQno = Integer.parseInt(map.get("qQno").toString());
		
		bService.deleteqReproot(qQno);
	}
	
	@RequestMapping(value = "/deleteAll", method = RequestMethod.DELETE)
	public void deleteAll(@RequestBody Map<String, Object> map) {
		int qBno = Integer.parseInt(map.get("qBno").toString());
		
		bService.deleteAll(qBno);
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public void update(@RequestBody Map<String, Object> map) {
		
		int qQno = Integer.parseInt(map.get("qQno").toString());
		
		QNABoardVO vo = new QNABoardVO();
		
		vo.setqQno(qQno);
		vo.setqTitle(map.get("qTitle").toString());
		vo.setqContent(map.get("qContent").toString());

		bService.update(vo);
	}
	
	@RequestMapping(value = "/myQNA/{id}", method = RequestMethod.GET)
	public void myList(Model model, @PathVariable("id") String id) {
		int amount = bService.getMyListAmount(id);

		QNAPageTO<QNABoardVO> to = new QNAPageTO<QNABoardVO>(1);
		to.setAmount(amount);

		List<QNABoardVO> list = bService.mylist(to.getStartNum(), id);
		to.setList(list);
		
		model.addAttribute("prodNameList", getProdName(list));
		
		model.addAttribute("to", to);
	}
	
	@RequestMapping(value = "/myList/{id}/{curPage}", method = RequestMethod.GET)
	public QNAPageTO<QNABoardVO> myList(Model model, @PathVariable("id") String id, 
									@PathVariable("curPage") int curPage) {
		int amount = bService.getMyListAmount(id);

		QNAPageTO<QNABoardVO> to = new QNAPageTO<QNABoardVO>(curPage);
		to.setAmount(amount);

		List<QNABoardVO> list = bService.mylist(to.getStartNum(), id);
		to.setList(list);
		to.setProdNameList(getProdName(list));
		
		return to;
	}
	
	public List<String> getProdName(List<QNABoardVO> list) {
		
		List<String> nameList = new ArrayList<String>();
		
		for(int i = 0; i < list.size(); i++)
		{
			String prodName = bService.getProdName(list.get(i).getqBno());
			nameList.add(prodName);
		}
				
		return nameList;
	}
	
	@RequestMapping(value = "/list/{qBno}/{curPage}", method = RequestMethod.GET)
	public QNAPageTO<QNABoardVO> list(@PathVariable("qBno") Integer qBno, 
									@PathVariable("curPage") int curPage) {
		int amount = bService.getAmount(qBno);

		QNAPageTO<QNABoardVO> to = new QNAPageTO<QNABoardVO>(curPage);
		to.setAmount(amount);

		List<QNABoardVO> list = bService.list(to.getStartNum(), qBno);
		to.setList(list);
		
		return to;
	}

	@RequestMapping(value = "/list/{qBno}", method = RequestMethod.GET)
	public QNAPageTO<QNABoardVO> list(@PathVariable("qBno") Integer qBno) {
		int curPage = 1;
		int amount = bService.getAmount(qBno);

		QNAPageTO<QNABoardVO> to = new QNAPageTO<QNABoardVO>(curPage);
		to.setAmount(amount);

		List<QNABoardVO> list = bService.list(to.getStartNum(), qBno);
		to.setList(list);
		
		return to;
	}
	
	@RequestMapping(value = "/getPw", method = RequestMethod.POST)
	public String getPw(@RequestBody Map<String, Object> map) {

		int qQno = Integer.parseInt(map.get("qQno").toString());
		
		String password = bService.getPw(qQno);
		
		return password.trim();
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public void insert(@RequestBody Map<String, Object> map) {
		int qBno = Integer.parseInt(map.get("qBno").toString());
		String qTitle = map.get("qTitle").toString();
		String qWriter = map.get("qWriter").toString();
		String qContent = map.get("qContent").toString();
		String qPassword = map.get("qPassword").toString();
		String qUserId = map.get("qUserId").toString();
		
		
		
		QNABoardVO vo = new QNABoardVO(0, qBno, qTitle, qWriter, qContent, qPassword, null, null, 0, 0, 0, qUserId);
		for(int i = 0;i<30;i++) {
			vo.setqTitle(qTitle+i);
		bService.insert(vo);
		}
	}
	
	@RequestMapping(value = "/answer", method = RequestMethod.POST)
	public void answer(@RequestBody Map<String, Object> map) {
		int qQno = Integer.parseInt(map.get("qQno").toString());
		int qBno = Integer.parseInt(map.get("qBno").toString());
		String qTitle = map.get("qTitle").toString();
		String qWriter = map.get("qWriter").toString();
		String qContent = map.get("qContent").toString();
		String qPassword = map.get("qPassword").toString();
		String qUserId = map.get("qUserId").toString();
		
		
		
		QNABoardVO vo = new QNABoardVO(0, qBno, qTitle, qWriter, qContent, qPassword, null, null, qQno, 1, 1, qUserId);

		bService.answer(vo);
	}
}
