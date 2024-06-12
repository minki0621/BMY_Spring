package kr.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	@RequestMapping("/") //WEB-INF에 바로 접근할 수 없으므로 요청에 따라 초기사이트 매핑해주기.
	public String index() { 
		return "index";
	}
}
