package kr.board.entity;

//@Data -> Lombok API :모든 메서드 불러오는 어노테이션 (개별호출 또한 가능 : 자동으로 Getter, Setter, toString, equals, hashCode 메서드가 생성)
public class Board {
	private int idx; // 번호
	private String title; //제목
	private String context; //내용
	private String writer; //작성자 
	private String indate; //작성일
	private int count; //조회수

}
