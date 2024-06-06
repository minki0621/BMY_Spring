package kr.board.entity;

import lombok.Data;

@Data
public class News {
	private int idx;
	private String title;
	private String content;
	private String brand;
	private String indate;
	private int count;
	
}
