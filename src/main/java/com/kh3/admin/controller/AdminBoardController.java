package com.kh3.admin.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh3.model.board.BoardCategoryDAO;
import com.kh3.model.board.BoardCategoryDTO;
import com.kh3.model.board.BoardConfDAO;
import com.kh3.model.board.BoardConfDTO;
import com.kh3.util.PageDTO;
import com.kh3.util.Paging;

@Controller
public class AdminBoardController {

    @Inject
    private BoardConfDAO board_ConfDao;

    @Inject
    private BoardCategoryDAO bcate_dao;


    // 한 페이지당 보여질 게시물의 수
    private final int rowsize = 10;

    // 전체 게시물의 수
    private int totalRecord = 0;




    // =====================================================================================
    // 게시판 설정 목록
    // =====================================================================================
    @RequestMapping("admin/board/board_list.do")
    public String board_list(Model model, HttpServletRequest request) {

        // 검색 처리
        String keyword = request.getParameter("keyword");
        if (keyword == null) keyword = "";

        // 페이징 처리
        int page; // 현재 페이지 변수
        if (request.getParameter("page") != null && request.getParameter("page") != "") {
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




    // =====================================================================================
    // 게시판 설정 게시판 추가
    // =====================================================================================
    @RequestMapping("admin/board/board_write.do")
    public String board_write(HttpServletRequest request, Model model) {
        String dirPath = request.getSession().getServletContext().getRealPath("/WEB-INF/views/site/board");

        List<String> skinDirList = new ArrayList<String>();
        File[] files = new File(dirPath).listFiles();
        for(File f : files) {
            if(f.isDirectory() && !f.getName().equals("basic")) {
                skinDirList.add(f.getName());
            }
        }

        model.addAttribute("skin_dir", skinDirList);

        return "/admin/board/board_write";
    }




    // =====================================================================================
    // 게시판 설정 게시판 추가 처리
    // =====================================================================================
    @RequestMapping("admin/board/board_write_ok.do")
    public void board_writeOk(BoardConfDTO confdto, HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();


        // 게시판 아이디 중복 체크
        int chkBoardId = this.board_ConfDao.checkBoardId(confdto.getBoard_id());
        if(chkBoardId > 0) {
            out.println("<script>alert('이미 등록된 게시판 아이디입니다.\\n다른 게시판 아이디를 입력하세요.'); history.back();</script>");
        }

        if (chkBoardId == 0 && this.board_ConfDao.writeBoard(confdto) > 0) {

            // 데이터 폴더 생성
            String dirPath = request.getSession().getServletContext().getRealPath("/resources/data/board/" + confdto.getBoard_id());
            File dirDir = new File(dirPath);
            dirDir.mkdirs();

            // 데이터 폴더에 더미 txt파일 생성
            File txtFile = new File(dirPath + "/" + confdto.getBoard_name() + "_게시판_업로드_폴더.txt");
            System.out.println("txtFile >>> " + txtFile);
            txtFile.createNewFile();

            out.println("<script>location.href='board_list.do';</script>");

        } else {
            out.println("<script>alert('게시판 생성 실패'); history.back();</script>");
        }
    }




    // =====================================================================================
    // 게시판 설정 수정
    // =====================================================================================
    @RequestMapping("admin/board/board_modify.do")
    public String board_content(@RequestParam("board_no") int board_no, HttpServletRequest request, Model model) {
        String dirPath = request.getSession().getServletContext().getRealPath("/WEB-INF/views/site/board");

        List<String> skinDirList = new ArrayList<String>();
        File[] files = new File(dirPath).listFiles();
        for(File f : files) {
            if(f.isDirectory() && !f.getName().equals("basic")) {
                skinDirList.add(f.getName());
            }
        }

        model.addAttribute("skin_dir", skinDirList);

        model.addAttribute("Cont", this.board_ConfDao.getCont(board_no));
        model.addAttribute("modify", "m");

        return "/admin/board/board_write";
    }




    // =====================================================================================
    // 게시판 설정 수정 처리
    // =====================================================================================
    @RequestMapping("admin/board/board_modify_ok.do")
    public void board_modify_ok(BoardConfDTO dto, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();

        if (this.board_ConfDao.updateBoard(dto) > 0) {
            out.println("<script>alert('게시판 수정 완료'); location.href='board_list.do';</script>");
        } else {
            out.println("<script>alert('게시판 수정 실패'); history.back();</script>");
        }
    }




    // =====================================================================================
    // 게시판 설정 게시판 삭제 처리
    // =====================================================================================
    @RequestMapping("admin/board/board_delete.do")
    public void board_delete(@RequestParam("board_no") int board_no, HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();

        String config_id = request.getParameter("bbs_id");

        /* 데이터 폴더 경로설정 */
        String homedir = request.getSession().getServletContext().getRealPath("/resources/data/board/" + config_id);

        File path = new File(homedir);

        if (this.board_ConfDao.deleteBoard(board_no) > 0) {
            FileUtils.deleteDirectory(path);
            out.println("<script>alert('게시판 삭제 완료'); location.href='board_list.do';</script>");
        } else {
            out.println("<script>alert('게시판 삭제 실패'); history.back();</script>");
        }
    }




    // =====================================================================================
    // 게시판 설정 카테고리 목록
    // =====================================================================================
    @RequestMapping("admin/board/board_category.do")
    public String board_category(@RequestParam("board_id") String board_id, Model model) {
        List<BoardCategoryDTO> list = this.bcate_dao.getBoardCategoryList(board_id);
        model.addAttribute("bcate", list);

        return "/admin/board/board_category";
    }




    // =====================================================================================
    // 게시판 설정 카테고리 수정 처리
    // =====================================================================================
    @RequestMapping("admin/board/board_category_modify.do")
    public void bcate_modify(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();

        String board_id = request.getParameter("board_id");
        String[] bcate_no = request.getParameterValues("bcate_no[]");
        String[] bcate_name = request.getParameterValues("bcate_name[]");

        for (int i = 0; i < bcate_no.length; i++) {
            bcate_dao.boardCategoryModify(board_id, bcate_no[i], i + 1, bcate_name[i]);
        }

        out.println("<script>location.href='board_category.do?board_id=" + board_id + "';</script>");
    }




    // =====================================================================================
    // 게시판 설정 카테고리 추가 처리
    // =====================================================================================
    @RequestMapping("admin/board/board_category_write.do")
    public void bcate_write(@RequestParam("board_id") String board_id, @RequestParam("bcate_name") String bcate_name, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();

        int check = this.bcate_dao.boardCategoryWrite(board_id, bcate_name);
        if (check > 0) {
            out.println("<script>location.href='board_category.do?board_id=" + board_id + "';</script>");
        } else {
            out.println("<script>alert('게시판 카테고리 등록 중 에러가 발생하였습니다.'); history.back();</script>");
        }
    }




    // =====================================================================================
    // 게시판 설정 카테고리 삭제 처리
    // =====================================================================================
    @RequestMapping("admin/board/board_category_delete.do")
    public void bcate_delete(@RequestParam("board_id") String board_id, @RequestParam("bcate_no") int bcate_no,
            HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();

        int check = this.bcate_dao.boardCategoryDelete(board_id, bcate_no);
        if (check > 0) {
            this.bcate_dao.boardCategorySeqUpdate(board_id, bcate_no);
            out.println("<script>location.href='board_category.do?board_id=" + board_id + "';</script>");
        } else {
            out.println("<script>alert('게시판 카테고리 삭제 중 에러가 발생하였습니다.'); history.back();</script>");
        }
    }

}
