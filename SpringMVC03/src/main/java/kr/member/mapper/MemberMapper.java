package kr.member.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import kr.board.entity.Board;
import kr.member.entity.Member;

@Mapper //- Mybatis API
public interface MemberMapper {	 
	
     public Member registerCheck(String memID);
     
     
}
