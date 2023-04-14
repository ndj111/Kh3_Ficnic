package com.kh3.site.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh3.model.member.MemberDAO;
import com.kh3.model.member.MemberDTO;
import com.kh3.model.member.MemberService;
import com.kh3.model.member.PointDAO;
import com.kh3.model.member.PointDTO;

@Controller
public class SiteMemberController {

    @Autowired
    private MemberDAO dao;

    @Autowired
    private PointDAO pdao;

    @Inject
    MemberService memberService;

    BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();




    // =====================================================================================
    // 로그인 페이지
    // =====================================================================================
    @RequestMapping("member/member_login.do")
    public String login() {
        return "site/member/member_login";
    }




    // =====================================================================================
    // 로그인 처리
    // =====================================================================================
    @RequestMapping("member/member_login_check.do")
    public void login_check(MemberDTO dto, HttpServletResponse response, HttpServletRequest request) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        String id = request.getParameter("member_id");
        String pw = request.getParameter("member_pw");

        dto.setMember_id(id);
        dto.setMember_pw(pw);

        MemberDTO mdto = this.dao.getReservMember(dto.getMember_id());

        boolean isTrue = false;

        // 아이디 체크
        int result = this.dao.loginCheck(dto);

        // 비밀번호 체크
        int check = this.dao.pwCheck(dto);
        
        if (result == 0) {
        	out.println("<script>alert('존재하지 않는 아이디입니다.'); history.back(); </script>");
  
		} else if (mdto.getMember_type().equals("exit")) {
	      	  out.println("<script>alert('탈퇴한 회원입니다.'); history.back(); </script>");
		}
        
        
      // 길이 체크
      int pw_length = this.dao.pwLength(dto); 
      
		// 아이디 일치하는 경우, 임시비밀번호 사용하는 경우 (길이가 20 아래) 로그인 가능함.
       if (pw_length < 20 && check == 1 && !mdto.getMember_type().equals("exit")) {
        	
        	 dto = this.dao.loginSession(id);

             HttpSession session = request.getSession();
             session.setAttribute("sess_id", dto.getMember_id());
             session.setAttribute("sess_pw", dto.getMember_pw());
             session.setAttribute("sess_type", dto.getMember_type());
             session.setAttribute("sess_name", dto.getMember_name());
             session.setAttribute("sess_email", dto.getMember_email());
             session.setAttribute("sess_phone", dto.getMember_phone());
             session.setAttribute("sess_point", dto.getMember_point());

             out.println("<script>alert('" + dto.getMember_name() + "님 안녕하세요 :)'); location.href='../main.do' </script>");
        
            // 암호화된 비밀번호인 경우
        } else if (pw_length > 50 && !mdto.getMember_type().equals("exit")){ // by.. 로 만든 암호화 비밀번호인 경우 기존 비밀번호랑 맞는지 비교
        	
        	isTrue = passwordEncoder.matches(dto.getMember_pw(), mdto.getMember_pw());
        	
        } else if (!mdto.getMember_type().equals("exit")) {
           
        	out.println("<script>alert('비밀번호를 다시 확인해주세요.'); history.back(); </script>");

        } else {
        	System.out.println("오류 발생");
        }

          if (isTrue == true && !mdto.getMember_type().equals("exit")) {	// 기존이랑 암호화 비교해서 true인 경우
            dto = this.dao.loginSession(id);

            HttpSession session = request.getSession();
            session.setAttribute("sess_id", dto.getMember_id());
            session.setAttribute("sess_pw", dto.getMember_pw());
            session.setAttribute("sess_type", dto.getMember_type());
            session.setAttribute("sess_name", dto.getMember_name());
            session.setAttribute("sess_email", dto.getMember_email());
            session.setAttribute("sess_phone", dto.getMember_phone());
            session.setAttribute("sess_point", dto.getMember_point());

            out.println("<script>alert('" + dto.getMember_name() + "님 안녕하세요 :)'); location.href='../main.do' </script>");
            
        } else if (!mdto.getMember_type().equals("exit")) {
           
        	out.println("<script>alert('비밀번호를 다시 확인해주세요.'); history.back(); </script>");
        	
        } else {
        	System.out.println("오류 발생");
        }
          

        	  

    }




    // =====================================================================================
    // 아이디 찾기
    // =====================================================================================
    @RequestMapping("member/member_find.do")
    public String find() {
        return "site/member/member_find";
    }




    // =====================================================================================
    // 비밀번호 찾기
    // =====================================================================================
    @RequestMapping("member/member_find_pw.do")
    public String findpw() {
        return "site/member/member_find_pw";
    }




    // =====================================================================================
    // 로그아웃 처리
    // =====================================================================================
    @RequestMapping("member/member_logout.do")
    public void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        request.getSession().invalidate();
        request.getSession(true);

        out.println("<script>location.href='" + request.getContextPath() + "/';</script>");
    }




    // =====================================================================================
    // 아이디 찾기 결과
    // =====================================================================================
    @RequestMapping("member/member_find_id_result.do")
    public String findidresult(Model model, HttpServletResponse response, MemberDTO dto) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        // 아이디 찾기 - 이메일 체크
        int check = this.dao.findIdEmail(dto);

        // 아이디 찾기 - 둘 다 맞는 경우
        int result = this.dao.findIdAll(dto);

        // 아이디 불러오기
        String id = this.dao.findId(dto);

        // 이메일 틀린 경우
        if (check == 0) {
            out.println("<script>alert('존재하지 않는 이메일입니다.'); history.back();</script>");

        // 이름이 틀릴 경우
        } else if (result == 0) {
            out.println("<script>alert('이름이 틀립니다.'); history.back();</script>");

        } else {
            model.addAttribute("id", id);
            return "site/member/member_find_id_result";
        }

        return null;
    }




    // =====================================================================================
    // 비밀번호 찾기 결과
    // =====================================================================================
    @RequestMapping("member/member_find_pw_result.do")
    public String findpwresult(Model model, HttpServletResponse response, MemberDTO dto, HttpServletRequest request) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        String id = request.getParameter("member_id");
        dto.setMember_id(id);

        // 비밀번호 찾기 - 이메일 체크
        int check = this.dao.findIdEmail(dto);

        // 비밀번호 찾기 - 둘 다 맞는 경우
        int result = this.dao.findPwAll(dto);

        // 비밀번호, 이메일 일치하는 경우 비밀번호 반환.
        /* String pw = this.dao.findPw(mdto); */

        // 이메일 틀린 경우
        if (check == 0) {
            out.println("<script>alert('존재하지 않는 이메일입니다.'); history.back();</script>");

            // 이름이 틀릴 경우
        } else if (result == 0) {
            out.println("<script>alert('아이디를 다시 확인해주세요.'); history.back();</script>");

            // 이메일 이름 둘 다 있는 경우
        } else if (result == 1) {

            // 임시 비밀번호 생성(UUID이용)
            String tempPw = UUID.randomUUID().toString().replace("-", "");// -를 제거
            tempPw = tempPw.substring(0, 10);// tempPw를 앞에서부터 10자리 잘라줌

            dto.setMember_pw(tempPw); // 임시비밀번호 담기

            // 임시 비밀번호 view로 넘겨줌.
            model.addAttribute("pw", tempPw);

            // 임시 비밀번호로 업데이트함.
            dto.setMember_id(id);
            dto.setMember_pw(tempPw);

            this.dao.updatePw(dto);

            return "site/member/member_find_pw_result";

        } else {
            out.println("<script>alert('오류'); history.back();</script>");

        }

        return null;
    }




    // =====================================================================================
    // 회원가입
    // =====================================================================================
    @RequestMapping("member/member_join.do")
    public String join() {
        return "site/member/member_join";
    }




    // =====================================================================================
    // 아이디 중복 체크
    // =====================================================================================
    @RequestMapping("member/memberIdCheck.do")
    @ResponseBody
    public int checkId(@RequestParam("paramId") String paramId) {
        return this.dao.checkId(paramId);
    }




    // =====================================================================================
    // 이메일 중복 체크
    // =====================================================================================
    @RequestMapping("member/memberMailCheck.do")
    @ResponseBody
    public int checkEmail(@RequestParam("paramEmail") String paramEmail) {
        return this.dao.checkEmail(paramEmail);
    }




    // =====================================================================================
    // 회원 가입 처리
    // =====================================================================================
    @RequestMapping("member/member_join_ok.do")
    public void joinOk(@Valid MemberDTO dto, BindingResult result, PointDTO pdto, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
 
        // 비밀번호 일치 확인
        if (!dto.getMember_pw().equals(dto.getMember_pw_re())) {
            out.println("<script>alert('비밀번호가 일치하지 않습니다. 다시 입력해주세요.'); location.href='member_join.do'; </script>");
        } 
        	

        // 암호화 설정
        dto.setMember_pw(passwordEncoder.encode(dto.getMember_pw()));
        dto.setMember_pw_re(passwordEncoder.encode(dto.getMember_pw_re()));

        // 유효성 검사
        if (result.hasErrors()) {
            List<ObjectError> list = result.getAllErrors();

            for (ObjectError error : list) {
                if (error.getDefaultMessage().equals("idchk_join")) {
                    out.println("<script>alert('사용 할수 없는 아이디입니다. 다른 아이디를 입력해주세요.'); history.back();</script>");
                    break;
                } else if (error.getDefaultMessage().equals("id")) {
                    out.println("<script>alert('아이디를 6자 이상 입력해주세요.'); history.back();</script>");
                    break;
                } else if (error.getDefaultMessage().equals("pw")) {
                    out.println("<script>alert('비밀번호는 영문자와 숫자, 특수기호가 적어도 1개 이상 포함된 6자~12자의 비밀번호여야 합니다.'); history.back();</script>");
                    break;
                } else if (error.getDefaultMessage().equals("email")) {
                    out.println("<script>alert('잘못된 이메일 형식입니다. 다시 입력해 주세요.'); history.back();</script>");
                    break;
                } else if (error.getDefaultMessage().equals("phone")) {
                    out.println("<script>alert('잘못된 전화번호 형식입니다. 다시 입력해 주세요.'); history.back();</script>");
                    break;
                } else if (error.getDefaultMessage().equals("mailchk_join")) {
                    out.println("<script>alert('이미 존재하는 이메일입니다. 다른 이메일을 입력하주세요.'); history.back();</script>");
                    break;
                }
            }
      

        } else { // 이상 없을 때 실행
            int check = this.dao.joinMember(dto);
            if (check > 0) {
                // 회원 가입 포인트 적립
                this.pdao.joinPoint(pdto);
                out.println("<script>alert('반갑습니다. "+dto.getMember_name()+"님 \\nFicnic 회원가입이 정상적으로 완료되었습니다.'); location.href='../main.do';</script>");
            } else {
                out.println("<script>alert('회원 가입 중 에러가 발생하였습니다.'); location.href='member_join.do' </script>");
            }
        }
    }
  



}


