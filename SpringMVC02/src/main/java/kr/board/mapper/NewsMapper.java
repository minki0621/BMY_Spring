package kr.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.board.entity.News;

@Mapper
public interface NewsMapper {
	
	public List<News> getNewsList();
	
}
