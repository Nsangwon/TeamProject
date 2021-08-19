package kr.co.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/error")
public class ErrorController {
	
	@RequestMapping("/400")
	public String error400() {
		return"/error/error404";
	}
	
	@RequestMapping("/403")
	public String error403() {
		return"/error/error404";
	}
	
	@RequestMapping("/404")
	public String error404() {
		return"/error/error404";
	}
	
	@RequestMapping("/405")
	public String error405() {
		return"/error/error404";
	}
	
	@RequestMapping("/500")
	public String error500() {
		return "/error/error500";
	}
	
	@RequestMapping("/503")
	public String error503() {
		return "/error/error500";
	}

}
