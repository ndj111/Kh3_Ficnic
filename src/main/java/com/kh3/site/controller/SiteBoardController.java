package com.kh3.site.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kh3.model.board.BoardCategoryDAO;
import com.kh3.model.board.BoardCategoryDTO;
import com.kh3.model.board.BoardCommentDAO;
import com.kh3.model.board.BoardCommentDTO;
import com.kh3.model.board.BoardConfDAO;
import com.kh3.model.board.BoardConfDTO;
import com.kh3.model.board.BoardDAO;
import com.kh3.model.board.BoardDTO;
import com.kh3.util.PageDTO;
import com.kh3.util.Paging;
import com.kh3.util.UploadFile;

@Controller
public class SiteBoardController {

    @Inject
    private BoardDAO board_Dao;

    @Inject
    private BoardCategoryDAO board_CateDao;
    
    @Inject
    private BoardCommentDAO board_CommDao;

    @Inject
    private BoardConfDAO board_ConfDao;



    // 전체 게시물의 수
    private int totalRecord = 0;

    String board_skin = "basic";

    BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();





    // =====================================================================================
    // 게시판 권한 가져오기
    // =====================================================================================
    public Map<String, Object> getBoardLevel(BoardConfDTO dto, String sess_type) {
        Map<String, Object> map = new HashMap<String, Object>();

        String getList = dto.getBoard_level_list();
        String getView = dto.getBoard_level_view();
        String getWrite = dto.getBoard_level_write();
        String getComment = dto.getBoard_level_comment();
        String getNotice = dto.getBoard_level_notice();
        String getModify = dto.getBoard_level_modify();
        String getDelete = dto.getBoard_level_delete();

        String levelList = "Y";
        String levelView = "Y";
        String levelWrite = "Y";
        String levelComment = "Y";
        String levelNotice = "Y";
        String levelModify = "Y";
        String levelDelete = "Y";


        // 목록보기
        if(getList.equals("user") || getList.equals("admin")) {
            if(sess_type == null) levelList = "N";
            if(getList.equals("admin") && sess_type != null && !sess_type.equals("admin")) levelList = "N";
        }

        // 글보기
        if(getView.equals("user") || getView.equals("admin")) {
            if(sess_type == null) levelView = "N";
            if(getView.equals("admin") && sess_type != null && !sess_type.equals("admin")) levelView = "N";
        }

        // 모든 글 수정
        if(getModify.equals("user") || getModify.equals("admin")) {
            if(sess_type == null) levelModify = "N";
            if(getModify.equals("admin") && sess_type != null && !sess_type.equals("admin")) levelModify = "N";
        }

        // 글쓰기
        if(getWrite.equals("user") || getWrite.equals("admin")) {
            if(sess_type == null) levelWrite = "N";
            if(getList.equals("admin") && sess_type != null && !sess_type.equals("admin")) levelWrite = "N";
            if(levelModify.equals("Y")) levelWrite = "Y";
        }

        // 댓글쓰기
        if(getComment.equals("user") || getComment.equals("admin")) {
            if(sess_type == null) levelComment = "N";
            if(getComment.equals("admin") && sess_type != null && !sess_type.equals("admin")) levelComment = "N";
        }

        // 공지사항 쓰기
        if(getNotice.equals("user") || getNotice.equals("admin")) {
            if(sess_type == null) levelNotice = "N";
            if(getNotice.equals("admin") && sess_type != null && !sess_type.equals("admin")) levelNotice = "N";
        }

        // 모든 글 삭제
        if(getDelete.equals("user") || getDelete.equals("admin")) {
            if(sess_type == null) levelDelete = "N";
            if(getDelete.equals("admin") && sess_type != null && !sess_type.equals("admin")) levelDelete = "N";
        }


        map.put("list", levelList);
        map.put("view", levelView);
        map.put("write", levelWrite);
        map.put("comment", levelComment);
        map.put("notice", levelNotice);
        map.put("modify", levelModify);
        map.put("delete", levelDelete);

        return map;
    }





    // =====================================================================================
    // 게시판 목록 페이지
    // =====================================================================================
    @RequestMapping("/board/board_list.do")
    public String board_list(HttpServletRequest request, HttpServletResponse response, Model model,
        @RequestParam(value = "field", required = false, defaultValue = "") String field,
        @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
        @RequestParam(value = "category", required = false, defaultValue = "") String category,
        @RequestParam(value = "bbs_id", required = false, defaultValue = "") String bbs_id) throws IOException {

        // 해당 게시물 설정값 가져오기
        BoardConfDTO BoardConfdto = board_ConfDao.getBoardConfCont(bbs_id);
        if(BoardConfdto == null) {
            response.setContentType("text/html; charset=utf-8");
            PrintWriter out = response.getWriter();
            out.print("<script>alert('잘못된 게시판 아이디입니다.'); history.back();</script>");
        }
        board_skin = BoardConfdto.getBoard_skin();


        // 게시판 권한 가져오기
        HttpSession session = request.getSession();
        String sess_type = null;
        if(session.getAttribute("sess_type") != null) sess_type = (String) session.getAttribute("sess_type");
        Map<String, Object> bbs_level = getBoardLevel(BoardConfdto, sess_type);


        // 게시판 카테고리 가져오기
        List<BoardCategoryDTO> BoardCategory = null;
        if(BoardConfdto.getBoard_use_category().equals("Y")){
            BoardCategory = board_CateDao.getBoardCategoryList(bbs_id);
        }


        // 한 페이지당 보여질 게시물의 수
        int rowsize = BoardConfdto.getBoard_list_num();

        // 검색 설정
        if (field == null) field = "";
        if (keyword == null) keyword = "";
        if (category == null) category = "";

        // 페이징 처리
        int page = 1; // 현재 페이지 변수
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch(Exception e) {
                page = 1;
            }
        }

        totalRecord = this.board_Dao.getListCount(field, keyword, category, bbs_id);

        Map<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("field", field);
        searchMap.put("keyword", keyword);
        searchMap.put("category", category);
        searchMap.put("bbs_id", bbs_id);

        PageDTO dto = new PageDTO(page, rowsize, totalRecord, searchMap);

        // 페이지 이동 URL
        String pageUrl = request.getContextPath() + "/board/board_list.do?bbs_id=" + bbs_id + "&field=" + field + "&keyword=" + keyword;

        model.addAttribute("bbs_id", bbs_id);
        model.addAttribute("List", this.board_Dao.getBoardList(dto.getStartNo(), dto.getEndNo(), searchMap));
        model.addAttribute("conf", BoardConfdto);
        model.addAttribute("BoardCate", BoardCategory);
        model.addAttribute("totalCount", totalRecord);
        model.addAttribute("paging", dto);
        model.addAttribute("field", field);
        model.addAttribute("keyword", keyword);
        model.addAttribute("category", category);
        model.addAttribute("pagingWrite", Paging.showPage(dto.getAllPage(), dto.getStartBlock(), dto.getEndBlock(), dto.getPage(), pageUrl));
        model.addAttribute("level", bbs_level);  

        return "/site/board/" + board_skin + "/board_list";
    }





    // =====================================================================================
    // 게시물 작성 페이지
    // =====================================================================================
    @RequestMapping("/board/board_write.do")
    public String board_write(HttpServletRequest request, Model model) {
        String bbs_id = request.getParameter("bbs_id");
        if (bbs_id == null) bbs_id = "";

        BoardConfDTO BoardConfdto = board_ConfDao.getBoardConfCont(bbs_id);
        board_skin = BoardConfdto.getBoard_skin();


        // 게시판 권한 가져오기
        HttpSession session = request.getSession();
        String sess_type = null;
        if(session.getAttribute("sess_type") != null) sess_type = (String) session.getAttribute("sess_type");
        Map<String, Object> bbs_level = getBoardLevel(BoardConfdto, sess_type);


        // 게시판 카테고리 가져오기
        List<BoardCategoryDTO> BoardCategory = null;
        if(BoardConfdto.getBoard_use_category().equals("Y")){
            BoardCategory = board_CateDao.getBoardCategoryList(bbs_id);
        }


        model.addAttribute("conf", BoardConfdto);
        model.addAttribute("BoardCate", BoardCategory);
        model.addAttribute("level", bbs_level);

        return "/site/board/" + board_skin + "/board_write";
    }





    // =====================================================================================
    // 게시물 작성 처리
    // =====================================================================================
    @RequestMapping("/board/board_write_ok.do")
    public void board_write_ok(MultipartHttpServletRequest mrequest, HttpServletResponse response, BoardDTO dto) throws IOException {
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();


        // 게시물 헤드넘버 정하기
        int set_headnum = 0;

        if(dto.getBdata_use_notice() != null && dto.getBdata_use_notice().equals("Y")){
            set_headnum = 999;
            int min_headnum = board_Dao.getMinHeadnumNotice(dto.getBoard_id());
            if(min_headnum > 0) set_headnum = min_headnum - 1;
        }else{
            set_headnum = 2000000000;
            int min_headnum = board_Dao.getMinHeadnum(dto.getBoard_id());
            if(min_headnum > 0) set_headnum = min_headnum - 100;
        }

        dto.setBdata_headnum(set_headnum);


        if (mrequest.getParameter("bdata_use_secret") == null) {
            dto.setBdata_use_secret("N");
        }


        // 비밀번호 암호화 처리
        dto.setBdata_writer_pw(passwordEncoder.encode(dto.getBdata_writer_pw()));


        // config 테이블 id
        String bbs_id = mrequest.getParameter("board_id");
        String uploadPath = "/resources/data/board/" + bbs_id + "/";


        // 파일저장 이름 >> thisFolder/saveName_일련번호_밀리세컨드.확장자
        List<String> upload_list = UploadFile.fileUpload(mrequest, uploadPath, bbs_id);
        for(int i=0; i<upload_list.size(); i++){
            switch (i) {
                case 0:
                    dto.setBdata_file1(upload_list.get(0));
                    break;
                case 1:
                    dto.setBdata_file2(upload_list.get(1));
                    break;
                case 2:
                    dto.setBdata_file3(upload_list.get(2));
                    break;
                case 3:
                    dto.setBdata_file4(upload_list.get(3));
                    break;
                default:
                    break;
            }
        }


        Map<String, Object> map = new HashMap<String, Object>();
        map.put("bbs_id", bbs_id);
        map.put("dto", dto);

        if (this.board_Dao.insertBoardCont(map) > 0) {
            out.println("<script>location.href='" + mrequest.getContextPath() + "/board/board_list.do?bbs_id=" + bbs_id + "';</script>");
        } else {
            out.println("<script>alert('게시글 작성 실패'); history.back();</script>");
        }
    }





    // =====================================================================================
    // 게시물 수정 페이지
    // =====================================================================================
    @RequestMapping("/board/board_modify.do")
    public String board_modify(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
        String bbs_id = request.getParameter("bbs_id");

        // 해당 게시물 설정값 가져오기
        BoardConfDTO BoardConfdto = board_ConfDao.getBoardConfCont(bbs_id);
        board_skin = BoardConfdto.getBoard_skin();


        // 게시판 권한 가져오기
        HttpSession session = request.getSession();
        String sess_id = null;
        String sess_pw = null;
        String sess_type = null;
        if(session.getAttribute("sess_id") != null) sess_id = (String) session.getAttribute("sess_id");
        if(session.getAttribute("sess_pw") != null) sess_pw = (String) session.getAttribute("sess_pw");
        if(session.getAttribute("sess_type") != null) sess_type = (String) session.getAttribute("sess_type");
        Map<String, Object> bbs_level = getBoardLevel(BoardConfdto, sess_type);


        // 게시판 카테고리 가져오기
        List<BoardCategoryDTO> BoardCategory = null;
        if(BoardConfdto.getBoard_use_category().equals("Y")){
            BoardCategory = board_CateDao.getBoardCategoryList(bbs_id);
        }


        int bdata_no = 0;
        if (request.getParameter("bdata_no") != null) {
            bdata_no = Integer.parseInt(request.getParameter("bdata_no"));
        }

        if (bbs_id == null) bbs_id = "";

        /* 게시글 내용 출력 */
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("bbs_id", bbs_id);
        map.put("bdata_no", bdata_no);

        BoardDTO boardCont = board_Dao.getBoardCont(map);


        // 게시물 비밀번호 체크
        if(!bbs_level.get("modify").equals("Y") && (boardCont.getBdata_writer_id() == null && !boardCont.getBdata_writer_pw().equals(sess_pw)) || (boardCont.getBdata_writer_id() != null && !boardCont.getBdata_writer_id().equals(sess_id)) && !sess_type.equals("admin") ) {
            response.setContentType("text/html; enctype=utf-8");
            PrintWriter out = response.getWriter();

            if(request.getParameter("input_pw") == "" || request.getParameter("input_pw") == null) {
                out.println("<script>alert('게시물 비밀번호를 입력해주세요.'); history.back();</script>");
                return null;
            }

            Boolean isTrue = this.passwordEncoder.matches(request.getParameter("input_pw"), boardCont.getBdata_writer_pw());
            if (isTrue != true) {
                out.println("<script>alert('게시물 비밀번호가 일치하지 않습니다.'); history.back();</script>");
                return null;
            }else {
                session.setAttribute("sess_pw", boardCont.getBdata_writer_pw());
            }
        }


        model.addAttribute("conf", BoardConfdto);
        model.addAttribute("BoardCate", BoardCategory);
        model.addAttribute("Cont", boardCont);
        model.addAttribute("level", bbs_level);
        model.addAttribute("m", "m");

        return "/site/board/" + board_skin + "/board_write";
    }





    // =====================================================================================
    // 게시물 수정 처리
    // =====================================================================================
    @RequestMapping("/board/board_modify_ok.do")
    public void board_modify_ok(MultipartHttpServletRequest mrequest, BoardDTO Modifydto, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();

        String bbs_id = mrequest.getParameter("bbs_id");
        if (bbs_id == null) bbs_id = "";

        BoardConfDTO BoardConfdto = board_ConfDao.getBoardConfCont(bbs_id);
        board_skin = BoardConfdto.getBoard_skin();

        int bdata_no = 0;
        if (mrequest.getParameter("bdata_no") != null) {
            bdata_no = Integer.parseInt(mrequest.getParameter("bdata_no"));
        }

        if (mrequest.getParameter("bdata_use_secret") == null) {
            Modifydto.setBdata_use_secret("N");
        }


        Map<String, Object> map = new HashMap<String, Object>();
        map.put("bbs_id", bbs_id);
        map.put("bdata_no", bdata_no);
        map.put("dto", Modifydto);
        BoardDTO boardCont = board_Dao.getBoardCont(map);



        // 게시물 헤드넘버 정하기
        int set_headnum = 0;

        if(boardCont.getBdata_headnum() > 0 && !boardCont.getBdata_use_notice().equals(Modifydto.getBdata_use_notice())) {
            if(Modifydto.getBdata_use_notice() != null && Modifydto.getBdata_use_notice().equals("Y")){
                set_headnum = 999;
                int min_headnum = board_Dao.getMinHeadnumNotice(Modifydto.getBoard_id());
                if(min_headnum > 0) set_headnum = min_headnum - 1;
            }else{
                set_headnum = 2000000000;
                int min_headnum = board_Dao.getMinHeadnum(Modifydto.getBoard_id());
                if(min_headnum > 0) set_headnum = min_headnum - 100;
            }
            Modifydto.setBdata_headnum(set_headnum);
        }


        String uploadPath = "/resources/data/board/" + bbs_id + "/";

        String ori_file1 = mrequest.getParameter("ori_file1");
        String ori_file2 = mrequest.getParameter("ori_file2");
        String ori_file3 = mrequest.getParameter("ori_file3");
        String ori_file4 = mrequest.getParameter("ori_file4");

        // 파일저장 이름 >> thisFolder/saveName_일련번호_밀리세컨드.확장자
        List<String> upload_list = UploadFile.fileUpload(mrequest, uploadPath, bbs_id);
        for(int i=0; i<upload_list.size(); i++){

            // 기존 파일 있으면 삭제 처리
            String check_file = mrequest.getParameter("ori_file" + (i+1));
            if (check_file != null && upload_list.get(i) != "") {
                File del_pimage = new File(mrequest.getSession().getServletContext().getRealPath(check_file));
                if(del_pimage.exists()) del_pimage.delete();
            }

            switch (i) {
                case 0:
                    if (upload_list.get(0) != "") ori_file1 = upload_list.get(0);
                    Modifydto.setBdata_file1(ori_file1);
                    break;
                case 1:
                    if (upload_list.get(1) != "") ori_file2 = upload_list.get(1);
                    Modifydto.setBdata_file2(ori_file2);
                    break;
                case 2:
                    if (upload_list.get(2) != "") ori_file3 = upload_list.get(2);
                    Modifydto.setBdata_file3(ori_file3);
                    break;
                case 3:
                    if (upload_list.get(3) != "") ori_file4 = upload_list.get(3);
                    Modifydto.setBdata_file4(ori_file4);
                    break;
                default:
                    break;
            }
        }



        /* 수정된 내용 업데이트 */
        if (board_Dao.modifyBoard(map) > 0) {
            out.println("<script>location.href='" + mrequest.getContextPath() + "/board/board_view.do?bbs_id=" + bbs_id + "&bdata_no=" + bdata_no + "';</script>");
        } else {
            out.println("<script>alert('게시글 수정 실패'); history.back()</script>");
        }
    }





    // =====================================================================================
    // 게시물 삭제 처리
    // =====================================================================================
    @RequestMapping("/board/board_delete.do")
    public void board_delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();

        String bbs_id = "";
        int bdata_no = 0;

        /* 처리할 것 해당 게시판 게시글 삭제 및 댓글 삭제 */
        if (request.getParameter("bbs_id") != null) {
            bbs_id = request.getParameter("bbs_id");
        }
        if (request.getParameter("bdata_no") != null) {
            bdata_no = Integer.parseInt(request.getParameter("bdata_no"));
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("bbs_id", bbs_id);
        map.put("bdata_no", bdata_no);



        BoardConfDTO BoardConfdto = board_ConfDao.getBoardConfCont(bbs_id);
        BoardDTO boardCont = board_Dao.getBoardCont(map);


        // 게시판 권한 가져오기
        HttpSession session = request.getSession();
        String sess_id = null;
        String sess_pw = null;
        String sess_type = null;
        if(session.getAttribute("sess_id") != null) sess_id = (String) session.getAttribute("sess_id");
        if(session.getAttribute("sess_pw") != null) sess_pw = (String) session.getAttribute("sess_pw");
        if(session.getAttribute("sess_type") != null) sess_type = (String) session.getAttribute("sess_type");
        Map<String, Object> bbs_level = getBoardLevel(BoardConfdto, sess_type);


        // 게시물 비밀번호 체크
        if(!bbs_level.get("modify").equals("Y") && (boardCont.getBdata_writer_id() == null && !boardCont.getBdata_writer_pw().equals(sess_pw)) || (boardCont.getBdata_writer_id() != null && !boardCont.getBdata_writer_id().equals(sess_id))) {
            if(request.getParameter("input_pw") == "" || request.getParameter("input_pw") == null) {
                out.println("<script>alert('게시물 비밀번호를 입력해주세요.'); history.back();</script>");
            }

            Boolean isTrue = this.passwordEncoder.matches(request.getParameter("input_pw"), boardCont.getBdata_writer_pw());
            if (isTrue != true) {
                out.println("<script>alert('게시물 비밀번호가 일치하지 않습니다.'); history.back();</script>");
            }else {
                session.setAttribute("sess_pw", boardCont.getBdata_writer_pw());
            }
        }


        // 첨부파일 삭제
        if(boardCont.getBdata_file1() != null){
            File del_file1 = new File(request.getSession().getServletContext().getRealPath(boardCont.getBdata_file1()));
            if(del_file1.exists()) del_file1.delete();
        }
        if(boardCont.getBdata_file2() != null){
            File del_file2 = new File(request.getSession().getServletContext().getRealPath(boardCont.getBdata_file2()));
            if(del_file2.exists()) del_file2.delete();
        }
        if(boardCont.getBdata_file3() != null){
            File del_file3 = new File(request.getSession().getServletContext().getRealPath(boardCont.getBdata_file3()));
            if(del_file3.exists()) del_file3.delete();
        }
        if(boardCont.getBdata_file4() != null){
            File del_file4 = new File(request.getSession().getServletContext().getRealPath(boardCont.getBdata_file4()));
            if(del_file4.exists()) del_file4.delete();
        }


        /* 해당 게시글 삭제 */
        if (this.board_Dao.deleteBoard(map) > 0) {
            /* 해당 게시글 댓글 삭제 */
            this.board_CommDao.deleteBoardCommList(map);
            out.println("<script>location.href='" + request.getContextPath() + "/board/board_list.do?bbs_id=" + bbs_id
                    + "';</script>");
        } else {
            out.println("<script>alert('게시글 삭제 실패'); history.back()</script>");
        }
    }





    // =====================================================================================
    // 게시물 내용 보기 페이지
    // =====================================================================================
    @RequestMapping("/board/board_view.do")
    public String board_view(@RequestParam(value = "bdata_no", required = false, defaultValue = "0") int bdata_no,
            @RequestParam(value = "field", required = false, defaultValue = "") String field,
            @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
            @RequestParam(value = "category", required = false, defaultValue = "") String category,
            @RequestParam(value = "bbs_id", required = false, defaultValue = "") String bbs_id,
            HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();

        // 해당 게시물 설정값 가져오기
        BoardConfDTO BoardConfdto = board_ConfDao.getBoardConfCont(bbs_id);
        if(BoardConfdto == null) {
            out.print("<script>alert('잘못된 게시판 아이디입니다.'); history.back();</script>");
        }
        board_skin = BoardConfdto.getBoard_skin();


        // 게시판 권한 가져오기
        HttpSession session = request.getSession();
        String sess_type = "nomem";
        if(session.getAttribute("sess_type") != null) sess_type = (String) session.getAttribute("sess_type");
        Map<String, Object> bbs_level = getBoardLevel(BoardConfdto, sess_type);


        // 해당 게시판 해당 게시글 가져오기
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("bbs_id", bbs_id);
        map.put("bdata_no", bdata_no);

        board_Dao.updateBoardHit(map);
        BoardDTO BoardConDto = board_Dao.getBoardCont(map);


        // 비밀글 체크
        if(BoardConDto.getBdata_use_secret().equals("Y")){
            String sess_id = null;
            String sess_pw = null;
            String bdata_id = "nomem";

            if(session.getAttribute("sess_id") != null) sess_id = (String) session.getAttribute("sess_id");
            if(session.getAttribute("sess_pw") != null) sess_pw = (String) session.getAttribute("sess_pw");
            if(BoardConDto.getBdata_writer_id() != null) bdata_id = BoardConDto.getBdata_writer_id();

            if(!bdata_id.equals(sess_id) && !sess_type.equals("admin") && !BoardConDto.getBdata_writer_pw().equals(sess_pw)) {
                out.println("<script>location.href='board_pw_chk.do?bbs_id=" + bbs_id + "&bdata_no=" + bdata_no + "';</script>");
                return null;
            }
        }


        // 첨부파일 정리
        String[] imgArray = { "jpg", "jpeg", "gif", "bmp", "png", "JPG", "JPGE", "GIF", "BMP", "PNG", "tif" };
        List<String> fileCheck = new ArrayList<>(Arrays.asList(imgArray));

        if(BoardConDto.getBdata_file1() != null) {
            String file1Ext = BoardConDto.getBdata_file1().substring(BoardConDto.getBdata_file1().lastIndexOf(".") + 1);
            if(fileCheck.contains(file1Ext)){
                BoardConDto.setBdata_file1_img(BoardConDto.getBdata_file1());
            }else{
                BoardConDto.setBdata_file1_file(BoardConDto.getBdata_file1());
            }
        }

        if(BoardConDto.getBdata_file2() != null) {
            String file2Ext = BoardConDto.getBdata_file2().substring(BoardConDto.getBdata_file2().lastIndexOf(".") + 1);
            if(fileCheck.contains(file2Ext)){
                BoardConDto.setBdata_file2_img(BoardConDto.getBdata_file2());
            }else{
                BoardConDto.setBdata_file2_file(BoardConDto.getBdata_file2());
            }
        }

        if(BoardConDto.getBdata_file3() != null) {
            String file3Ext = BoardConDto.getBdata_file3().substring(BoardConDto.getBdata_file3().lastIndexOf(".") + 1);
            if(fileCheck.contains(file3Ext)){
                BoardConDto.setBdata_file3_img(BoardConDto.getBdata_file3());
            }else{
                BoardConDto.setBdata_file3_file(BoardConDto.getBdata_file3());
            }
        }

        if(BoardConDto.getBdata_file4() != null) {
            String file4Ext = BoardConDto.getBdata_file4().substring(BoardConDto.getBdata_file4().lastIndexOf(".") + 1);
            if(fileCheck.contains(file4Ext)){
                BoardConDto.setBdata_file4_img(BoardConDto.getBdata_file4());
            }else{
                BoardConDto.setBdata_file4_file(BoardConDto.getBdata_file4());
            }
        }


        // 한 페이지당 보여질 게시물의 수 -> 해당 게시물 설정값 가져와야한다.
        int rowsize = BoardConfdto.getBoard_list_num();

        // 검색 설정
        if (field == null) field = "";
        if (keyword == null) keyword = "";
        if (category == null) category = "";

        // 페이징 처리
        int page = 1; // 현재 페이지 변수
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch(Exception e) {
                page = 1;
            }
        }

        totalRecord = this.board_Dao.getListCount(field, keyword, category, bbs_id);

        Map<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("field", field);
        searchMap.put("keyword", keyword);
        searchMap.put("bbs_id", bbs_id);


        // 해당 게시판 해당 게시글 해당 댓글 리스트 가져오기
        List<BoardCommentDTO> BoardCommentList = board_CommDao.getBoardCommList(map);

        /* 게시글 설정값 DTO */
        /* 해당 게시판 리스트 출력 */
        List<BoardDTO> List = board_Dao.getBoardList(bbs_id);

        PageDTO dto = new PageDTO(page, rowsize, totalRecord, searchMap);

        // 페이지 이동 URL
        String pageUrl = request.getContextPath() + "/board/board_view.do?field=" + field + "&bdata_no=" + bdata_no
                + "&keyword=" + keyword + "&bbs_id=" + bbs_id;

        // 해당 게시판 해당 게시글 내용
        model.addAttribute("List", List);
        model.addAttribute("BoardConDto", BoardConDto);
        model.addAttribute("boardCommentList", BoardCommentList);

        model.addAttribute("bbs_id", bbs_id);
        /* 게시글 설정값 DTO */
        model.addAttribute("conf", BoardConfdto);

        /* 페이징처리 */
        model.addAttribute("totalCount", totalRecord);
        model.addAttribute("paging", dto);
        model.addAttribute("field", field);
        model.addAttribute("keyword", keyword);
        model.addAttribute("pagingWrite", Paging.showPage(dto.getAllPage(), dto.getStartBlock(), dto.getEndBlock(), dto.getPage(), pageUrl));
        model.addAttribute("level", bbs_level);

        return "/site/board/" + board_skin + "/board_view";
    }





    // =====================================================================================
    // 게시물 댓글 작성 처리
    // =====================================================================================
    @RequestMapping("/board/baord_comment_insert.do")
    public void baord_comment_insert(HttpSession session, HttpServletResponse response, HttpServletRequest request, BoardCommentDTO dto) throws IOException {
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();

        String bbs_id = request.getParameter("bbs_id");
        int bdata_no = 0;
        if (request.getParameter("bdata_no") != null) {
            bdata_no = Integer.parseInt(request.getParameter("bdata_no"));
        }


        // 비밀번호 암호화 처리
        dto.setBcomm_pw(passwordEncoder.encode(dto.getBcomm_pw()));


        // 해당 게시판 게시글 || 폼으로 부터 입력받은 dto 데이터
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("bbs_id", bbs_id);
        map.put("dto", dto);
        map.put("bdata_no", bdata_no);
        map.put("upDown", +1);

        if (board_CommDao.insertBoardComm(map) > 0) {
            /* 게시글 댓글 개수 증가처리 */
            this.board_CommDao.updateCommentCount(map);

            /* 방금 등록한 댓글 가져오기 */
            BoardCommentDTO nowBdata = this.board_CommDao.getNowComent(bbs_id, bdata_no, dto.getBcomm_name());
            out.println("Y☆" + nowBdata.getBcomm_no() + "☆" + nowBdata.getBdata_no() + "☆" + nowBdata.getBcomm_id() + "☆" + nowBdata.getBcomm_pw() + "☆" + nowBdata.getBcomm_type() + "☆" + nowBdata.getBcomm_name() + "☆" + nowBdata.getBcomm_cont() + "☆" + nowBdata.getBcomm_date());

        }else{
            out.println("N☆0");
        }
    }





    // =====================================================================================
    // 게시물 댓글 삭제 처리
    // =====================================================================================
    @RequestMapping("/board/baord_comment_delete.do")
    public void board_comment_delete(HttpSession session, HttpServletResponse response, HttpServletRequest request) throws IOException {
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();


        int bdata_no = 0;
        int bcomm_no = 0;
        String bbs_id = request.getParameter("bbs_id");
        String bcomm_pw = "";

        if (request.getParameter("bdata_no") != null) {
            bdata_no = Integer.parseInt(request.getParameter("bdata_no"));
        }
        if (request.getParameter("bcomm_no") != null) {
            bcomm_no = Integer.parseInt(request.getParameter("bcomm_no"));
        }
        if (request.getParameter("bcomm_pw") != null) {
            bcomm_pw = request.getParameter("bcomm_pw");
        }


        // 댓글 삭제 처리를 위한 map
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("bbs_id", bbs_id);
        map.put("bdata_no", bdata_no);
        map.put("bcomm_no", bcomm_no);
        map.put("bcomm_pw", bcomm_pw);
        map.put("upDown", -1);


        int result = 0;
        if(bcomm_pw != "") {
            BoardCommentDTO dto = this.board_CommDao.getThisComent(bbs_id, bdata_no, bcomm_no);
            Boolean isTrue = this.passwordEncoder.matches(bcomm_pw, dto.getBcomm_pw());

            if(isTrue == true){
                result = this.board_CommDao.deleteBoardComm(map);
            }else{
                result = -1;
            }
        }else{
            result = this.board_CommDao.deleteBoardComm(map);
        }

        if (result > 0) {
            /* 게시글 댓글 개수 감소처리 */
            this.board_CommDao.updateCommentCount(map);

            /* 게시글 삭제 시퀀스 업데이트 */
           // this.board_CommDao.updateCommentNum(map);

            out.print("Y");

        }else if(result == -1) {
            out.print("PW");

        } else {
            out.print("N");
        }
    }





    // =====================================================================================
    // 게시물 첨부파일 다운로드 처리
    // =====================================================================================
    @RequestMapping("/board/board_download.do")
    public void board_download(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=UTF-8");

        int bdata_no = 0;
        if(request.getParameter("bdata_no") != null){
            bdata_no = Integer.parseInt(request.getParameter("bdata_no"));
        }

        String bbs_id = request.getParameter("bbs_id");
        int file_no = Integer.parseInt(request.getParameter("bdata_file"));

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("bbs_id", bbs_id);
        map.put("bdata_no", bdata_no);
        BoardDTO dto = board_Dao.getBoardCont(map);

        String downloadFile = request.getSession().getServletContext().getRealPath("/resources/data/board/" + bbs_id + "/");
        String fileName = null;
        switch(file_no){
            case 1:
                if(dto.getBdata_file1() != null) {
                    fileName = dto.getBdata_file1().replace("/resources/data/board/"+bbs_id+"/", "");
                    downloadFile = downloadFile + fileName;
                }
                break;
            case 2:
                if(dto.getBdata_file2() != null) {
                    fileName = dto.getBdata_file2().replace("/resources/data/board/"+bbs_id+"/", "");
                    downloadFile = downloadFile + fileName;
                }
                break;
            case 3:
                if(dto.getBdata_file3() != null) {
                    fileName = dto.getBdata_file3().replace("/resources/data/board/"+bbs_id+"/", "");
                    downloadFile = downloadFile + fileName;
                }
                break;
            case 4:
                if(dto.getBdata_file4() != null) {
                    fileName = dto.getBdata_file4().replace("/resources/data/board/"+bbs_id+"/", "");
                    downloadFile = downloadFile + fileName;
                }
                break;
            default:
                break;
        }


        OutputStream out = response.getOutputStream();


        File file = new File(downloadFile);
        response.setHeader("Cache-Control", "no-cache");
        response.addHeader("Content-disposition", "attachement; fileName=" + fileName);

        FileInputStream in = new FileInputStream(file);
        byte[] buffer = new byte[1024 * 8];

        while (true) {
            int cnt = in.read(buffer);

            if (cnt == -1)
                break;
            out.write(buffer, 0, cnt);
        }
        in.close();
        out.close();
    }





    // =====================================================================================
    // 게시물 비밀번호 확인 페이지
    // =====================================================================================
    @RequestMapping("board/board_pw_chk.do")
    public String board_pwchk(Model model,
            @RequestParam(value = "bbs_id", required = false, defaultValue = "") String bbs_id,
            @RequestParam(value = "bdata_no", required = false, defaultValue = "") int bdata_no,
            @RequestParam(value = "bdata_writer_id", required = false, defaultValue = "") String bdata_writer_id) {

        // 해당 게시물 설정값 가져오기
        BoardConfDTO BoardConfdto = board_ConfDao.getBoardConfCont(bbs_id);
        board_skin = BoardConfdto.getBoard_skin();

        model.addAttribute("conf", BoardConfdto);
        model.addAttribute("bbs_id", bbs_id);
        model.addAttribute("bdata_no", bdata_no);
        model.addAttribute("bdata_writer_id", bdata_writer_id);

        return "/site/board/" + board_skin + "/board_pwd_chk";
    }





    // =====================================================================================
    // 게시물 비밀번호 확인 처리
    // =====================================================================================
    @RequestMapping("board/board_view_ok.do")
    public void board_view_ok(HttpServletResponse response, HttpServletRequest request,
            @RequestParam(value = "pwd", required = false, defaultValue = "") String pwd,
            @RequestParam(value = "bbs_id", required = false, defaultValue = "") String bbs_id,
            @RequestParam(value = "bdata_no", required = false, defaultValue = "0") int bdata_no,
            @RequestParam(value = "bdata_writer_id", required = false, defaultValue = "") String bdata_writer_id,
            @RequestParam(value = "field", required = false, defaultValue = "") String field,
            @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
            @RequestParam(value = "category", required = false, defaultValue = "") String category,
            @RequestParam(value = "page", required = false, defaultValue = "1") String page,
            HttpSession session) throws IOException {

        boolean isTrue = false;

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("bbs_id", bbs_id);
        map.put("bdata_no", bdata_no);

        BoardDTO dto = this.board_Dao.getBoardCont(map);

        response.setContentType("text/html; enctype=utf-8");
        PrintWriter out = response.getWriter();


        // 세션에 저장된 비밀번호로 체크
        if (dto.getBdata_writer_pw().equals(session.getAttribute("sess_pw"))) {
            out.println("<script>location.href='" + request.getContextPath() + "/board/board_view.do?bbs_id=" + bbs_id
                    + "&bdata_no=" + bdata_no + "&field="+field+"&keyword="+keyword+"&category="+category+"&page="+page+"';</script>");

        // 비회원이 작성한 글인 경우
        }else if (bdata_writer_id.equals("") || !session.getAttribute("sess_id").equals(dto.getBdata_writer_id())) {

            // 암호화된 비밀번호 체크
            isTrue = this.passwordEncoder.matches(pwd, dto.getBdata_writer_pw());

            if (isTrue == true) {
                session.setAttribute("sess_pw", dto.getBdata_writer_pw());
                out.println("<script>location.href='" + request.getContextPath() + "/board/board_view.do?bbs_id=" + bbs_id
                        + "&bdata_no=" + bdata_no + "&field="+field+"&keyword="+keyword+"&category="+category+"&page="+page+"';</script>");

            } else {
                out.println("<script>alert('비밀번호가 틀렸습니다.'); history.back();</script>");
            }

        // 회원이 작성한 글인 경우
        } else if(dto.getBdata_writer_id() != null && session.getAttribute("sess_id").equals(dto.getBdata_writer_id())) {
            out.println("<script>location.href='" + request.getContextPath() + "/board/board_view.do?bbs_id=" + bbs_id
                    + "&bdata_no=" + bdata_no + "&field="+field+"&keyword="+keyword+"&category="+category+"&page="+page+"';</script>");
        }

    }

}
