package kr.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.member.entity.Member;
import kr.member.mapper.MemberMapper;

@RequestMapping("/member")
@Controller
public class MemberController {
	
	@Autowired
	private MemberMapper mapper;
	
	@RequestMapping("/memJoin.do")
	public String memJoin() {
		return "member/join";
	}

	@RequestMapping("/memRegisterCheck.do")
	@ResponseBody //Ajax에 응답할 return이다.
	public int memRegisterCheck(@RequestParam("memID") String memID) {
		Member m = mapper.registerCheck(memID);
		if(m != null) {
			return 0; //이미 존재하는 회원
		} 
		if(memID.trim().isEmpty() || memID.contains(" ")) {
			return 1; //아이디는 빈문자열을 사용할 수 없음
		}
		return 2; //사용 가능한 아이디
	}
	
	@RequestMapping("/memRegister.do")
	public String memRegister() {
		return null;
	}
	
}
