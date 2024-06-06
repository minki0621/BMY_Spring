package kr.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.board.entity.News;
import kr.board.mapper.NewsMapper;

@Controller
public class NewsController {
	
	@Autowired
	private NewsMapper mapper; // DI
	
	@GetMapping("/getNewsList.do")
	public @ResponseBody List<News> getNewsList(){
	
		List<News> list = mapper.getNewsList();
		
		return list;
	}
	

}
