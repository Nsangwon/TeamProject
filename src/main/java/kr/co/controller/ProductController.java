package kr.co.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.domain.MemberDTO;
import kr.co.domain.OrderCheckVO;
import kr.co.domain.OrderVO;
import kr.co.domain.PageTO;
import kr.co.domain.ProdStockDTO;
import kr.co.domain.ProductVO;
import kr.co.service.ProdAttachService;
import kr.co.service.ProdStockService;
import kr.co.service.ProductService;
import kr.co.utils.Utils;

@Controller
@RequestMapping("/product")
public class ProductController {

	@Autowired
	private ServletContext sc;

	private String uploadPath = "resources" + File.separator + "uploads";

	@Autowired
	private ProductService prodService;

	@Autowired
	private ProdStockService prodStockService;

	@Autowired
	private ProdAttachService prodAttachService;

	@RequestMapping(value = "/prodInsert", method = RequestMethod.GET)
	public String insert() {

		return "/product/prodInsert";
	}
	
	/**
	 *  PRODUCT INSERT
	 */
	@RequestMapping(value = "/prodInsert", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	public String insert(ProductVO prodVO, ProdStockDTO prodStockDTO,
			@RequestParam("prodThumbnailFile") MultipartFile file, Model model) throws Exception {
		/* ?????? ??? ?????? */
		Map<String, Object> errors = new ConcurrentHashMap<String, Object>();

		if (!StringUtils.hasText(file.getOriginalFilename())) {
			errors.put("pordThumb", "?????? ???????????? ?????? ?????????");
		}

		if (!StringUtils.hasText(prodVO.getProdName())) {
			errors.put("prodName", "?????? ????????? ?????? ?????????");
		}

		if (!StringUtils.hasText(prodVO.getProdTitle())) {
			errors.put("prodTitle", "????????? ??????????????????");
		}

		if (prodVO.getProdPrice() == null || prodVO.getProdPrice() < 1000 || prodVO.getProdPrice() > 1000000) {
			errors.put("prodPrice", "????????? ????????? 1,000??? ~ 1,000,000??? ????????? ??????????????????");
		}

		if (prodVO.getProdContent() == null) {
			errors.put("prodContent", "??? ????????? ?????? ?????????.");
		}

		if (prodStockDTO.getProdStockLSize() == null || prodStockDTO.getProdStockSSize() > 9999
				|| prodStockDTO.getProdStockMSize() == null || prodStockDTO.getProdStockMSize() > 9999
				|| prodStockDTO.getProdStockLSize() == null || prodStockDTO.getProdStockLSize() > 9999) {
			errors.put("prodStock", "????????? ????????? 9999??? ????????? ??????????????????");
		}

		/* ????????? ????????? ???????????? ?????????????????? */
		if (!errors.isEmpty()) {
			model.addAttribute("errors", errors);
			return "product/prodInsert";
		} else {

			String oriName = file.getOriginalFilename();
			String uploadPath = sc.getRealPath(this.uploadPath);
			String filename = Utils.uploadFile(oriName, uploadPath, file);
			String filePath = File.separator + "resources" + File.separator + "uploads" + filename;
			prodVO.setProdThumbnail(filePath);

			prodService.insertProduct(prodVO);
			prodStockService.insertProdStock(prodStockDTO);
			prodAttachService.updateBno(prodVO.getProdBno());

//		prodVO ??? content?????? img ????????? ?????? ?????? ?????? ???????????? ??????
			Pattern imgPattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");
			Matcher getImgName = imgPattern.matcher(prodVO.getProdContent());

//		???????????? ???????????? ?????? ???????????? DB??? ????????? ????????? ???????????? ??????
			List<String> contentList = new ArrayList<String>();
			List<String> dbList = prodAttachService.getAttFilePath(prodVO.getProdBno());

//		??????????????? ?????? ????????? ?????? ???????????? DB ????????? ???????????? ???
			while (getImgName.find()) {
				String imgName = getImgName.group();
				int srdIdx = imgName.indexOf("src");
				int endIdx = imgName.indexOf(";");
				System.out.println(imgName);
				String imgRealName = imgName.substring(srdIdx + 5, endIdx - 21);
				System.out.println(imgRealName);

				int idx = imgRealName.indexOf("_");
				String test = imgRealName.substring(idx + 1);
				System.out.println(test);

				contentList.add(imgRealName);
			}

//		DB??? ???????????? ?????? ???????????? contentList??? ??????????????? ??????, ?????? ???????????????(true) ???????????? ???????????? ????????????(false) ?????? ???
			for (String dbImg : dbList) {
				boolean deleteUncontainsFile = contentList.contains(dbImg);
				if (!deleteUncontainsFile) {
					int realIdx = dbImg.indexOf("uploads");
					String realName = dbImg.substring(realIdx + 7);
					String realPath = sc.getRealPath(this.uploadPath);

					File f = new File(realPath, realName);
					System.out.println(f);
					f.delete();
				}

			}
		}

		return "redirect:/product/prodList/";
	}
	@ResponseBody
	@RequestMapping(value = "/prodNameDupCheck", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public int prodNameDupCheck(@RequestParam("prodName")String prodName) {
		
		int result = 0;
		
	 	String prodNameCheck = prodService.prodNameDupCheck(prodName);
	 	
	 	if (prodNameCheck != null) {
	 		result = 1;
	 	} else {
	 		result = 0;
	 	}
		
		return result;
	}
	/**
	 *  ATTACH IMG WHEN INSERT IN TO SUMMERNOTE
	 */
	@ResponseBody
	@RequestMapping(value = "/prodFile", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	public String uploadfile(MultipartHttpServletRequest request) throws Exception {

		MultipartFile file = request.getFile("file");
		String oriName = file.getOriginalFilename();

		String uploadPath = sc.getRealPath(this.uploadPath);

		String filename = Utils.uploadFile(oriName, uploadPath, file);

		String filePath = File.separator + "resources" + File.separator + "uploads" + filename;

		int bno = prodService.getBnoForAttach();
		prodAttachService.insertAttachInfo(filePath, bno);

		// return filePath as img src for summernote
		return File.separator + "resources" + File.separator + "uploads" + filename;
	}
	
	/**
	 *  PRODUCT UPDATE
	 */
	@RequestMapping(value = "/prodUpdate" , method = RequestMethod.POST , produces = "text/plain;charset=utf-8")
	public String update(ProductVO prodVO, ProdStockDTO prodStockDTO,
			@RequestParam("prodThumbnailFile") MultipartFile file ) throws Exception {

		
		 String oriName= file.getOriginalFilename();
		  //???????????? ????????? ?????????
		 if (oriName.equals("")) {
				String prodName = prodVO.getProdName();
				
				String thumnail= prodService.getThumnail(prodName);
				
				prodVO.setProdThumbnail(thumnail);
				
				prodService.updateProduct(prodVO);
				
				prodStockService.updateProdStock(prodStockDTO);
				
				return "redirect:/product/prodRead/"+prodName;
				
			}else {
			
			String uploadPath = sc.getRealPath(this.uploadPath);

			String filename = Utils.uploadFile(oriName, uploadPath, file);

			String filePath = File.separator + "resources" + File.separator + "uploads" + filename;
			prodVO.setProdThumbnail(filePath);

			String prodName = prodVO.getProdName();

			prodService.updateProduct(prodVO);

			prodStockService.updateProdStock(prodStockDTO);
			

			return "redirect:/product/prodRead/"+prodName;

				}
		}
	@RequestMapping(value = "/prodUpdate/{prodName}" , method = RequestMethod.GET , produces = "text/plain;charset=utf-8")
	public String update(@PathVariable("prodName") String prodName , Model model) {

		ProductVO vo = prodService.prodUpate(prodName);
		ProdStockDTO dto = prodStockService.prodStockRead(prodName);
		model.addAttribute("vo" , vo);
		model.addAttribute("dto" , dto);

		return "/product/prodUpdate";
	}
	
	@ResponseBody
	@RequestMapping(value = "/prodFileUpdate/{prodBno}" , method = RequestMethod.POST , produces = "text/plain;charset=utf-8")
	public String updateFile(MultipartHttpServletRequest request ,@PathVariable("prodBno") int bno) throws Exception {
		
		MultipartFile file = request.getFile("file");
		String oriName = file.getOriginalFilename();
		String uploadPath = sc.getRealPath(this.uploadPath);
		String filename = Utils.uploadFile(oriName, uploadPath, file);
		String filePath = File.separator + "resources" + File.separator + "uploads" + filename;
		
		//prodAttachService.UpdateAttachInfo(filePath, bno);
		//prodVO ??? content?????? img ????????? ?????? ?????? ?????? ???????????? ??????
		
		
		return filePath;
	}
	
	/**
	 *  PRODUCT LIST BY CATEGORY AND ORDERED LIST
	 */
	@RequestMapping(value = "/prodList", method = RequestMethod.GET, produces = "text/plain;charset=utf-8")
	public void prodList(@RequestParam(value = "prodCategory", required = false)  String prodCategory, 
			@RequestParam(value = "prodOrder", required = false) String prodOrder,
			String keyword,
			Model model) {
		int curPage = 1;
		
		int amount = prodService.getProdAmount();
		PageTO<ProductVO> to = new PageTO<ProductVO>(curPage);
		to.setAmount(amount);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("prodCategory", prodCategory);
		map.put("prodOrder", prodOrder);
		map.put("keyword", keyword);
		
		List<ProductVO> list = prodService.listProd(to.getStartNum(), map);
		to.setList(list);

		model.addAttribute("to", to);
		model.addAttribute("prodCategory", prodCategory);
		model.addAttribute("prodOrder", prodOrder);
		model.addAttribute("keyword", keyword);
	}
	@ResponseBody
	@RequestMapping(value = "/prodListScroll", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public List<ProductVO> prodList(@RequestBody Map<String, Object> param, Model model) {

		int curPage = (int) param.get("curPage");
		
		int amount = prodService.getProdAmount();
		PageTO<ProductVO> to = new PageTO<ProductVO>(curPage);
		to.setAmount(amount);
		
		
		String prodCategory = (String) param.get("prodCategory");
		String prodOrder = (String) param.get("prodOrder");
		String keyword = (String) param.get("keyword");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("prodCategory", prodCategory);
		map.put("prodOrder", prodOrder);
		map.put("keyword", keyword);
		
		List<ProductVO> list = prodService.listProd(to.getStartNum(), map);
	
		to.setList(list);

		return list;
	}

	/**
	 *  PRODUCT READ
	 */
	@RequestMapping(value = "/prodRead/{prodName}", method = RequestMethod.GET, produces = "text/plain;charset=utf-8")
	public String prodRead(@PathVariable("prodName") String prodName, Model model) {

		ProductVO vo = prodService.prodRead(prodName);
		ProdStockDTO dto = prodStockService.prodStockRead(prodName);

		model.addAttribute("vo", vo);
		model.addAttribute("dto", dto);

		return "/product/prodRead";
	}
	
	/**
	 *  DELETE FILE
	 */
	@RequestMapping(value = "/prodDelete/{prodName}", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	public String prodDelete(@PathVariable("prodName") String prodName, @RequestParam("prodBno") int prodBno) {
		List<String> attPathList = prodAttachService.getAttFilePath(prodBno);
		
		String realPath = sc.getRealPath(this.uploadPath);
		
		for (String data : attPathList) {
			
			String pre = data;
			int idx = data.lastIndexOf("uploads/");
			String realName = pre.substring(idx+8);
			
			File attFile = new File(realPath, realName);
			attFile.delete();
		}
		
		List<String> thumbPahtList = prodService.getThumbFilePath(prodName);
		
		for (String data : thumbPahtList) {
			
			String pre = data;
			int idx = data.lastIndexOf("uploads/");
			String realName = pre.substring(idx+8);
			
			File thumbFile = new File(realPath, realName);
			thumbFile.delete();
		}
		
		prodService.deleteProd(prodName);
		
		return "redirect:/product/prodList";
	}


	@RequestMapping(value = "/first", method = RequestMethod.GET)
	public void first() {

	}
	
	@RequestMapping(value = "/order" , method = RequestMethod.POST)
	public String order(OrderVO vo , HttpServletRequest request , String sample4_postcode, String sample4_roadAddress, String sample4_detailAddress) {
		HttpSession session = request.getSession();
		MemberDTO loginSession = (MemberDTO) session.getAttribute("login");
		String userAddress = "(" + sample4_postcode + ") " + sample4_roadAddress + " " + sample4_detailAddress;
		String userId = loginSession.getUserId();
		vo.setOrderUserId(userId);
		vo.setOrderUserAddress(userAddress);
		
		prodService.order(vo);
		
		return "redirect:/";
	}
	
	
	@RequestMapping(value = "/order", method = RequestMethod.GET)
	public String order(OrderCheckVO vo, Model model, HttpServletRequest request) {

		HttpSession session = request.getSession();
		MemberDTO loginSession = (MemberDTO) session.getAttribute("login");

		if (loginSession == null) {
			System.out.println("???????????? ????????? ???????????????.");

			return "/member/wrong_login_info";

		}

		String thumanail = prodService.getThumnail(vo.getProdName());

		model.addAttribute("thumanail", thumanail);

		model.addAttribute("vo", vo);

		return "/product/order";
	}

}
