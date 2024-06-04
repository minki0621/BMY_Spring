package kr.board.controller;

import java.util.ArrayList;
import java.util.List;

import javax.security.auth.login.LoginContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

@Controller
public class BoardController{	// new BoardController();
	// /boardList.do
	@Autowired
	private BoardMapper mapper; // DI
	
	@GetMapping("/")
	public String home() {
		return "home";
	}
	
	// HandlerMapping
	@RequestMapping("/boardList.do")
	public String boardList(Model model) {
		List<Board> list=mapper.getLists();
		model.addAttribute("list", list);
		return "boardList"; // /WEB-INF/views/boardList.jsp -> forward
	}
	
	
	@GetMapping("/boardForm.do")
	public String boardFrom() {
		return "boardForm"; // /WEB-INF/views/boardList.jsp -> forward
	}
	
	@GetMapping("/template.do")
	public String template() {
		return "template"; // /WEB-INF/views/boardList.jsp -> forward
	} 
	
	@PostMapping("/boardInsert.do")
	public String boardInsert(Board vo) { // title, content, writer => param수집(Board)
		mapper.boardInsert(vo);
		return "redirect:/boardList.do"; // redirect
	}
	
	@GetMapping("/boardContent.do")
	public String boardContent(@RequestParam("idx") int idx, Model model) {
		Board vo = mapper.boardContent(idx);
		//결과데이터를 넘겨야 하니까 객체 바인딩 필요 (Model 이용)
		model.addAttribute("vo", vo);
		
		return "boardContent";
	}
	
	@GetMapping("/boardDelete.do/{idx}")
	public String boardDelete(@PathVariable("idx") int idx) {
		mapper.boardDelete(idx);
		
		return "redirect:/boardList.do";
	}
	
	@GetMapping("/boardUpdateForm.do/{idx}")
	public String boardUpdateForm(@PathVariable("idx") int idx, Model model) {
		Board vo = mapper.boardContent(idx);
		model.addAttribute("vo", vo);
		
		return "boardUpdate"; // boardUpdate.jsp
	}
	
	@PostMapping("/boardUpdate.do")
	public String boardUpdate(Board vo) { //idx, title, content
		mapper.boardUpdate(vo); // 수정
		
		return "redirect:/boardList.do";
	}
	
}
