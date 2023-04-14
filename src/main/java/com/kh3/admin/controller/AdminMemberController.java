package com.kh3.admin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

import com.kh3.model.member.McouponDAO;
import com.kh3.model.member.McouponDTO;
import com.kh3.model.member.MemberDAO;
import com.kh3.model.member.MemberDTO;
import com.kh3.model.member.PointDAO;
import com.kh3.model.member.PointDTO;
import com.kh3.util.PageDTO;
import com.kh3.util.Paging;

@Controller
public class AdminMemberController {

    @Autowired
    private MemberDAO dao;

    @Autowired
    private PointDAO pdao;

    @Autowired
    private McouponDAO cdao;

    BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    // 한 페이지당 보여질 게시물의 수
    private final int rowsize = 10;

    // 전체 게시물의 수
    private int totalRecord = 0;




    // =====================================================================================
    // 회원 목록
    // =====================================================================================
    @RequestMapping("admin/member/member_list.do")
    public String list(HttpServletRequest request, Model model) {
        // 검색 처리
        String search_type = request.getParameter("search_type");
        if (search_type == null) search_type = "";

        String search_name = request.getParameter("search_name");
        if (search_name == null) search_name = "";

        String search_id = request.getParameter("search_id");
        if (search_id == null) search_id = "";

        String search_email = request.getParameter("search_email");
        if (search_email == null) search_email = "";

        String search_phone = request.getParameter("search_phone");
        if (search_phone == null) search_phone = "";

        Map<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("search_type", search_type);
        searchMap.put("search_name", search_name);
        searchMap.put("search_id", search_id);
        searchMap.put("search_email", search_email);
        searchMap.put("search_phone", search_phone);


        // 페이징 처리
        int page; // 현재 페이지 변수
        if (request.getParameter("page") != null && request.getParameter("page") != "") {
            page = Integer.parseInt(request.getParameter("page"));
        } else {
            page = 1;
        }
        totalRecord = this.dao.getMemberCount(searchMap);


        // 페이징 DTO
        PageDTO dto = new PageDTO(page, rowsize, totalRecord, searchMap);

        // 페이지 이동 URL
        String pageUrl = request.getContextPath() + "/admin/member/member_list.do?search_type=" + search_type
                + "&search_name=" + search_name + "&search_id=" + search_id + "&search_email=" + search_email
                + "&search_phone=" + search_phone;

        List<MemberDTO> list = this.dao.getMemberList(dto.getStartNo(), dto.getEndNo(), searchMap);
        model.addAttribute("List", list);

        model.addAttribute("totalCount", totalRecord);
        model.addAttribute("paging", dto);
        model.addAttribute("search_type", search_type);
        model.addAttribute("search_name", search_name);
        model.addAttribute("search_id", search_id);
        model.addAttribute("search_email", search_email);
        model.addAttribute("search_phone", search_phone);
        model.addAttribute("pagingWrite", Paging.showPage(dto.getAllPage(), dto.getStartBlock(), dto.getEndBlock(), dto.getPage(), pageUrl));

        return "admin/member/member_list";
    }




    // =====================================================================================
    // 회원 내용보기
    // =====================================================================================
    @RequestMapping("admin/member/member_view.do")
    public String view(Model model, @RequestParam("no") int no, @RequestParam("id") String id) {
        MemberDTO dto = this.dao.getMemberView(no);
     
        List<McouponDTO> cdto = this.cdao.getCouponView(id);
        List<PointDTO> pdto = this.pdao.getPointView(id);

        model.addAttribute("dto", dto);
        model.addAttribute("cdto", cdto);
        model.addAttribute("pdto", pdto);

        return "admin/member/member_view";
    }




    // =====================================================================================
    // 회원 등록 페이지
    // =====================================================================================
    @RequestMapping("admin/member/member_write.do")
    public String write() {
        return "admin/member/member_write";
    }



    // =====================================================================================
    // 회원 등록 페이지 - 아이디 중복 체크
    // =====================================================================================
    @RequestMapping("admin/member/memberIdCheck.do")
    @ResponseBody
    public int checkId(@RequestParam("paramId") String paramId) {
        return this.dao.checkId(paramId);
    }



    // =====================================================================================
    // 회원 등록 페이지 - 이메일 중복 체크
    // =====================================================================================
    @RequestMapping("admin/member/memberMailCheck.do")
    @ResponseBody
    public int checkEmail(@RequestParam("paramEmail") String paramEmail) {
        return this.dao.checkEmail(paramEmail);
    }




    // =====================================================================================
    // 회원 등록 처리
    // =====================================================================================
    @RequestMapping("admin/member/memberWriteOk.do")
    public void writeOk(@Valid MemberDTO dto, BindingResult result, PointDTO pdto, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        // 비밀번호 일치 확인
        if (!dto.getMember_pw().equals(dto.getMember_pw_re())) {
            out.println("<script>alert('[비밀번호]가 일치하지 않습니다. 다시 입력해주세요.'); history.back();</script>");
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
        }else {
        	// 유효성 검사 이상 없을 때 실행
        	int check = this.dao.writeOkMember(dto);

        	if (check > 0) {
        		// 회원 가입 포인트 적립
        		this.pdao.joinPoint(pdto);
        		out.println("<script> location.href='member_list.do';</script>");
        	} else {
        		out.println("<script>alert('회원 등록 중 에러가 발생하였습니다.'); history.back();</script>");
        	}
        } 
    }




    // =====================================================================================
    // 회원 수정 페이지
    // =====================================================================================
    @RequestMapping("admin/member/member_modify.do")
    public String midify(Model model, @RequestParam("no") int no) {
        MemberDTO dto = this.dao.getMemberView(no);
        model.addAttribute("member", dto);

        return "admin/member/member_modify";
    }




    // =====================================================================================
    // 회원 수정 처리
    // =====================================================================================
    @RequestMapping("admin/member/member_modifyOk.do")
    public void modifyOk(@Valid MemberDTO dto, BindingResult result, PointDTO pdto,
                        @RequestParam("pw") String member_pw, @RequestParam("point") int member_point, HttpServletResponse response) throws IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        // 비밀번호 일치 확인
        if (!member_pw.equals(dto.getMember_pw_re())) {
            out.println("<script>alert('[비밀번호]가 일치하지 않습니다. 다시 입력해주세요.'); history.back();</script>");

        } else if (member_pw.length() > 0) {
        	
        	// 새로운 비밀번호로 수정,  암호화 설정
            dto.setMember_pw(passwordEncoder.encode(member_pw));

            // 유효성 검사
            if (result.hasErrors()) {
                List<ObjectError> list = result.getAllErrors();

                for (ObjectError error : list) {
                    if (error.getDefaultMessage().equals("pw_re")) {
                        out.println("<script>alert('비밀번호는 영문자와 숫자, 특수기호가 적어도 1개 이상 포함된 6자~12자의 비밀번호여야 합니다.'); history.back();</script>");
                        break;
                    } else if (error.getDefaultMessage().equals("email")) {
                        out.println("<script>alert('잘못된 이메일 형식입니다. 다시 입력해 주세요.'); history.back();</script>");
                        break;
                    } else if (error.getDefaultMessage().equals("phone")) {
                        out.println("<script>alert('잘못된 전화번호 형식입니다. 다시 입력해 주세요.'); history.back();</script>");
                        break;
                    }
                }
            }


            int point_add = 0;
            String point_type = "plus";

            // 적립금 빼기
            if (dto.getMember_point() > member_point) {
                point_add = dto.getMember_point() - member_point;
                point_type = "minus";

            // 적립금 더하기
            } else if (dto.getMember_point() < member_point) {
                point_add = member_point - dto.getMember_point();
            }

            // pointDTO에 저장
            pdto.setPoint_add(point_add);
            pdto.setPoint_type(point_type);

            // memberDTO에 저장
            dto.setMember_point(member_point);


            int check = this.dao.modifyOk(dto);
            if (check > 0) {
                // 적립금이 바뀌면 실행
                if (pdto.getPoint_add() > 0) {
                    // 관리자 수정 포인트 적립
                    this.pdao.modifyPoint(pdto);
                }
                out.println("<script> location.href='member_list.do';</script>");
            } else {
                out.println("<script>alert('회원정보 수정 중 에러가 발생하였습니다.'); history.back();</script>");
            }


        // 기존에 가지고 있던 비밀번호로 수정
        } else {
            // 유효성 검사
            if (result.hasErrors()) {
                List<ObjectError> list = result.getAllErrors();

                for (ObjectError error : list) {
                    if (error.getDefaultMessage().equals("email")) {
                        out.println("<script>alert('잘못된 이메일 형식입니다. 다시 입력해 주세요.'); history.back();</script>");
                        break;
                    } else if (error.getDefaultMessage().equals("phone")) {
                        out.println("<script>alert('잘못된 전화번호 형식입니다. 다시 입력해 주세요.'); history.back();</script>");
                        break;
                    }
                }
            }


            int point_add = 0;
            String point_type = "plus";

            // 적립금 빼기
            if (dto.getMember_point() > member_point) {
                point_add = dto.getMember_point() - member_point;
                point_type = "minus";

            // 적립금 더하기
            } else if (dto.getMember_point() < member_point) {
                point_add = member_point - dto.getMember_point();
            }

            // pointDTO에 저장
            pdto.setPoint_add(point_add);
            pdto.setPoint_type(point_type);

            // memberDTO에 저장
            dto.setMember_point(member_point);


            int check = this.dao.modifyOk(dto);
            if (check > 0) {
                // 적립금이 바뀌면 실행
                if (pdto.getPoint_add() > 0) {
                    // 관리자 수정 포인트 적립
                    this.pdao.modifyPoint(pdto);
                }
                out.println("<script> location.href='member_list.do';</script>");
            } else {
                out.println("<script>alert('회원정보 수정 중 에러가 발생하였습니다.'); history.back();</script>");
            }

        }

    }




    // =====================================================================================
    // 회원 삭제 처리
    // =====================================================================================
    @RequestMapping("admin/member/member_delete.do")
    public void delete(@RequestParam("no") int no, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        int check = this.dao.deleteMember(no);

        if (check > 0) {
            this.dao.updateSequence(no);
            out.println("<script> location.href='member_list.do';</script>");
        } else {
            out.println("<script>alert('회원정보 삭제 처리 중 에러가 발생하였습니다.'); history.back();</script>");
        }
    }

}
