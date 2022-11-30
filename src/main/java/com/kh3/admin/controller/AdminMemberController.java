package com.kh3.admin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh3.model.member.MemberDAO;
import com.kh3.model.member.MemberDTO;
import com.kh3.model.member.PointDAO;
import com.kh3.model.member.PointDTO;

@Controller
public class AdminMemberController {

	@Autowired
	private MemberDAO dao;
	
	@Autowired
	private PointDAO pdao;
	
	
	
	// 회원의 전체리스트 메핑
	@RequestMapping("admin/member/member_list.do")
	public String list(Model model) {
		
		List<MemberDTO> list = this.dao.getMemberList();
		model.addAttribute("List", list);
		
		return "admin/member/member_list";
	}
	
	
	
	// 회원 상세내역 메핑
	@RequestMapping("admin/member/member_view.do")
	public String view(Model model ,@RequestParam("no") int no) {
		
		MemberDTO dto = this.dao.getMemberView(no);
		model.addAttribute("dto", dto);
		
		return "admin/member/member_view";
	}
	
	
	
	// 회원 등록 페이지로 가는 메핑
	@RequestMapping("admin/member/member_write.do")
	public String write() {
			
		return "admin/member/member_write";
	}
	
	
	
	// 회원 등록 하는 메핑
	@RequestMapping("admin/member/memberWriteOk.do")
	public void writeOk(MemberDTO dto, PointDTO pdto, HttpServletResponse response) throws IOException {
		
		// 아이디 중복 체크
		int checkId = this.dao.checkId(dto);
		int check = this.dao.writeOkMember(dto);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		// 아이디 중복 체크
		if(checkId > 0) {
			
			out.println("<script>alert('중복된 아이디입니다. 다른 아이디로 입력해주세요.'); history.back();</script>");
		}else {
		
			if(check > 0) {
				// 회원 가입 포인트 적립
				this.pdao.joinPoint(pdto);
	            out.println("<script>alert('회원 등록 되었습니다.'); location.href='member_list.do';</script>");
			} else {
	
				out.println("<script>alert('회원 등록 중 에러가 발생하였습니다.'); history.back();</script>");
			}
		}
		}

	
	
	// 회원 정보 삭제 하는 메핑
	@RequestMapping("admin/member/member_delete.do")
	public void delete(@RequestParam("no") int no, HttpServletResponse response) throws IOException {
			
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

			int check = this.dao.deleteMember(no);
			this.dao.updateSequence(no);
				
			if(check > 0) {

				out.println("<script>alert('회원 정보가 삭제되었습니다.'); location.href='member_list.do';</script>");
			}else {

				out.println("<script>alert('회원 정보 삭제 중 에러가 발생하였습니다.'); history.back();</script>");
			}

			
		}
	
	
	
	// 회원 정보 수정페이지로 가는 메핑
	@RequestMapping("admin/member/member_modify.do")
	public String midify(Model model ,@RequestParam("no") int no) {
		
		MemberDTO dto = this.dao.getMemberView(no);
		model.addAttribute("member", dto);
		
		return "admin/member/member_modify";
	}
		
	
	
	// 회원 정보 수정하는 메핑
	@RequestMapping("admin/member/member_modifyOk.do")
	public void modifyOk(MemberDTO dto,@RequestParam("member_pw") String member_pw, HttpServletResponse response) throws IOException {
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		if(dto.getMember_pw().equals(null)) {
			
			int check = this.dao.modifyOk(dto, member_pw);
			if(check > 0) {
				out.println("<script>alert('회원 정보가 수정되었습니다.'); location.href='member_list.do';</script>");

			}else {
				out.println("<script>alert('회원 정보 수정 중 에러가 발생하였습니다.'); history.back();</script>");

			}
		}else {	// 비밀번호가 틀린 경우
			out.println("<script>");
			out.println("alert('비밀번호를 다시 확인해주세요.')");
			out.println("history.back()");
			out.println("</script>");
		}
		
	}
		
		
		
	
}
