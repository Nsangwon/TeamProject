package kr.co.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import kr.co.domain.ReviewPageTO;
import kr.co.domain.ReviewReplyVO;
import kr.co.service.ReviewReplyService;

@RestController
@RequestMapping("/review")
public class ReviewReplyRestController {

	@Autowired
	private ReviewReplyService rRService;
	
	@RequestMapping(value = "/reply", method = RequestMethod.PUT)
	public int update(@RequestBody Map<String, Object> map) {
		
		int reRno = Integer.parseInt(map.get("reRno").toString());
		String reWriter = map.get("reWriter").toString();
		String reContent = map.get("reContent").toString();
		int reStar = Integer.parseInt(map.get("reStar").toString());
		
		ReviewReplyVO vo = new ReviewReplyVO(reRno, -1, reWriter, reContent, null, null,reStar);
		
		int result = rRService.update(vo);
		
		return result ;
	}
	
	@RequestMapping(value = "/reply", method = RequestMethod.DELETE)
	public int delete(@RequestBody Map<String, Object> map) {
		
		int reRno = Integer.parseInt(map.get("reRno").toString());
		int result = rRService.delete(reRno);
		
		return result ;
	}
	
	@RequestMapping(value = "/reply/{reBno}/{curPage}", method = RequestMethod.GET)
	public ReviewPageTO<ReviewReplyVO> list(@PathVariable("curPage") int curPage ,
			@PathVariable("reBno") int reBno, Integer page){
		
		int amount  = rRService.getAmount(reBno);
		

		ReviewPageTO<ReviewReplyVO> to = new ReviewPageTO<ReviewReplyVO>(curPage);
		to.setAmount(amount);
		
		List<ReviewReplyVO> list = rRService.list(to.getStartNum() ,reBno);
		to.setList(list);
		
		return to;
	}
	
	@RequestMapping(value = "/reply/{reBno}", method = RequestMethod.GET)
	public ReviewPageTO<ReviewReplyVO> list(@PathVariable("reBno") int reBno, Integer page){
		if(page == null) {
			page =1;
		}
		int curPage  = page;
		
		int amount  = rRService.getAmount(reBno);
		ReviewPageTO<ReviewReplyVO> to = new ReviewPageTO<ReviewReplyVO>(curPage);
		to.setAmount(amount);
		
		List<ReviewReplyVO> list = rRService.list(to.getStartNum() ,reBno);
		
		to.setList(list);
		
		return to;
	}
	
	   @RequestMapping(value = "/reply", method = RequestMethod.POST, 
		         produces = "application/text;charset=utf8")
		   public String insert(@RequestBody Map<String, Object> map) {
		      int reBno = Integer.parseInt(map.get("reBno").toString());
		      String reWriter = map.get("reWriter").toString();
		      String reContent = map.get("reContent").toString();
		      int reStar = Integer.parseInt(map.get("reStar").toString());
		      
		      ReviewReplyVO vo =new ReviewReplyVO(-1, reBno, reWriter, reContent, null, null,reStar);
		      
		      for(int i = 0;i<30;i++) {
		    	  vo.setReContent(reContent+i);
		    	  rRService.insert(vo);
		      }
		      
		      return "입력 완료되엇습니다.";
		   }
}
