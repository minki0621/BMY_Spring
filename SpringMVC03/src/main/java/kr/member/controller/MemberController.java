package kr.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public String memRegister(Member m, RedirectAttributes rttr, HttpSession session) {
		if(m.getMemID() == null || m.getMemID().equals("") || 
			m.getMemPassword() == null || m.getMemPassword().equals("") ||
			m.getMemName() == null || m.getMemName().equals("") ||
			m.getMemAge() == 0 || 
			m.getMemGender() == null || m.getMemGender().equals("") ||
			m.getMemEmail() == null || m.getMemEmail().equals("") ) {
			//누락메세지를 가지고 가기? => 객체바인딩(Model, HttpServletRequest, HttpSession)은 jsp에 하는데.. 어떡하지?
			rttr.addFlashAttribute("msgType", "메시지 누락 발생");
			rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
			
			return "redirect:/memJoin.do"; // ${smgType}, ${msg} 사용가능, Flash니까 단 한번!! 
		}
		m.setMemProfile(""); //사진이미지는 없다는 의미 -> "" (안그러면 null이 들어가니까 공백으로 넣어주자.)
		// 회원을 테이블에 저장
		int result = mapper.register(m);
		if(result == 1) { //회원가입 성공
			rttr.addFlashAttribute("msgType", "success");
			rttr.addFlashAttribute("msg", "회원가입이 정상적으로 완료되었습니다.");
			//회원가입 성공하면 바로 로그인 처리해주기
			session.setAttribute("user", m); //  ${!empty user} 체크해서 로그인 했냐 안했냐 확인 
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("msgType", "fale");
			rttr.addFlashAttribute("msg", "회원가입 실패 : 이미 존재하는 회원입니다.");
			return "memRegister.do";
		}
	}
	
}
