package kr.board.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

@Controller
public class BoardController {//BoardController 클래스는 servlet-context.xml에 의해 scan되며 컨테이너에 자동생성된다.
	
	@Autowired
	private BoardMapper mapper; // DI
	
	// /boardList.do 라는 클라이언트의 요청이 오면? 요청받고 메서드 실행 -> '핸들러 매핑'
	// HandlerMapping 클래스가 처리
	@RequestMapping("/boardList.do")
	public String boardList(Model model) { //return이 view페이지 경로니까 String타입
		
		List<Board> list = mapper.getLists();
		model.addAttribute("list", list);
		
		return "boardList"; // /WEB-INF/views/boardList.jsp -> forward
				
	}
}
