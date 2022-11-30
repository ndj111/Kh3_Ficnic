package com.kh3.admin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh3.model.board.BoardConfDAO;
import com.kh3.model.board.BoardConfDTO;
import com.kh3.util.PageDTO;
import com.kh3.util.Paging;

@Controller
public class AdminBoardController {

    @Inject
    private BoardConfDAO board_ConfDao;



    // 한 페이지당 보여질 게시물의 수
    private final int rowsize = 10;

    // 전체 게시물의 수
    private int totalRecord = 0;



    // 게시판 설정 목록 페이지
    @RequestMapping("admin/board/board_list.do")
    public String board_list(Model model, HttpServletRequest request) {
        // 검색 처리
        String keyword = request.getParameter("keyword");
        if (keyword == null) keyword = "";

        // 페이징 처리
        int page; // 현재 페이지 변수
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        } else {
            page = 1;
        }
        totalRecord = this.board_ConfDao.getBoardConfCount(keyword);

        // 페이징 DTO
        Map<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("keyword", keyword);
        PageDTO dto = new PageDTO(page, rowsize, totalRecord, searchMap);

        // 페이지 이동 URL
        String pageUrl = request.getContextPath() + "/admin/board/board_list.do?keyword=" + keyword;


        model.addAttribute("List", this.board_ConfDao.getConfBoardList(dto.getStartNo(), dto.getEndNo(), keyword));

        model.addAttribute("totalCount", totalRecord);
        model.addAttribute("paging", dto);
        model.addAttribute("keyword", keyword);
        model.addAttribute("pagingWrite", Paging.showPage(dto.getAllPage(), dto.getStartBlock(), dto.getEndBlock(), dto.getPage(), pageUrl));

        return "/admin/board/board_list";
    }



    // 환경설정_게시판설정_게시판추가 페이지
    @RequestMapping("admin/board/board_write.do")
    public String board_write() {
        return "/admin/board/board_write";
    }



    // 환경설정_게시판설정_게시판추가 받은 데이터 처리
    @RequestMapping("admin/board/board_write_ok.do")
    public void board_writeOk(BoardConfDTO confdto, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();

        if (this.board_ConfDao.writeBoard(confdto) > 0) {
            out.println("<script>alert('게시판 생성 완료'); location.href='board_list.do';</script>");
        } else {
            out.println("<script>");
            out.println("alert('게시판 생성 실패')");
            out.println("history.back()");
            out.println("</script>");
        }
    }

    @RequestMapping("admin/board/board_modify.do")
    public String board_content(@RequestParam("board_no") int board_no, Model model) {

        model.addAttribute("Cont", this.board_ConfDao.getCont(board_no));
        model.addAttribute("modify", "m");

        return "/admin/board/board_write";
    }

    @RequestMapping("admin/board/board_modify_ok.do")
    public void board_modify_ok(BoardConfDTO dto, HttpServletResponse response) throws IOException {

        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();

        if (this.board_ConfDao.updateBoard(dto) > 0) {
            out.println("<script>");
            out.println("alert('게시판 수정 완료')");
            out.println("location.href='admin/board/board_list.do'");
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println("alert('게시판 수정 실패')");
            out.println("history.back()");
            out.println("</script>");
        }

    }

    @RequestMapping("admin/board/board_delete.do")
    public void board_delete(@RequestParam("board_no") int board_no, HttpServletRequest request,
            HttpServletResponse response) throws IOException {

        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();

        if (this.board_ConfDao.deleteBoard(board_no) > 0) {
            out.println("<script>");
            out.println("alert('게시판 삭제 완료')");
            out.println("location.href='" + request.getContextPath() + "/admin/board/board_list.do'");
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println("alert('게시판 삭제 실패')");
            out.println("history.back()");
            out.println("</script>");
        }
    }

}
