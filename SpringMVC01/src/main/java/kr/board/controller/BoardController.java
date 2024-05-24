package kr.board.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.board.entity.Board;

@Controller
public class BoardController {
	
	// /boardList.do 라는 클라이언트의 요청이 오면? 요청받고 메서드 실행 -> '핸들러 매핑'
	// HandlerMapping 클래스가 처리
	@RequestMapping("/boardList.do")
	public String boardList(Model model) { //return이 view페이지 경로니까 String타입
		
		Board vo = new Board();
		
		//임시로....
		vo.setIdx(1);
		vo.setTitle("게시판실습");
		vo.setContext("게시판내용");
		vo.setWriter("라파엘");
		vo.setIndate("2024-05-24");
		vo.setCount(0);
		
		List<Board> list = new ArrayList<Board>();
		list.add(vo);
		list.add(vo);
		list.add(vo);
		
		model.addAttribute("list", list); //객체바인딩
		
		return "boardList"; // /WEB-INF/views/boardList.jsp -> forward
				
	}
}
