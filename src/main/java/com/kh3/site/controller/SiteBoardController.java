package com.kh3.site.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh3.model.board.BoardCategoryDAO;
import com.kh3.model.board.BoardConfDAO;
import com.kh3.model.board.BoardDAO;
import com.kh3.util.PageDTO;
import com.kh3.util.Paging;

@Controller
public class SiteBoardController {

	@Inject
	private BoardDAO board_Dao;
	
	@Inject
	private BoardCategoryDAO board_CategoryDao;
	
	@Inject
	private BoardConfDAO board_ConfDao; 
	
	
    // 한 페이지당 보여질 게시물의 수
    private final int rowsize = 3;

    // 전체 게시물의 수
    private int totalRecord = 0;

	
	private String path="site/board/";
	
	
	
	@RequestMapping("/site/board/board_list.do")
	public String board_list(HttpServletRequest request,Model model,@RequestParam("bbs_id") String bbs_id ) {
		
		// 처리 까먹음 
		String board_skin = "basic";
        
		
		String field = request.getParameter("field");
        String keyword = request.getParameter("keyword");
        
        
        if(field == null) field = "";
        if(keyword == null) keyword = "";
        
        // 페이징 처리
        int page; // 현재 페이지 변수
        if(request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }else{
            page = 1;
        }
        
        totalRecord = this.board_Dao.getListCount(field, keyword,bbs_id);
        
        PageDTO dto = new PageDTO(page, rowsize, totalRecord, field, keyword);
        
        // 페이지 이동 URL
        String pageUrl = request.getContextPath()+"site/board/board_list.do?field="+field+"&keyword="+keyword;

        model.addAttribute("List", this.board_Dao.getBoardList(bbs_id));
          
    	model.addAttribute("totalCount", totalRecord);
        model.addAttribute("paging", dto);
        model.addAttribute("field", field);
        model.addAttribute("keyword", keyword);
        model.addAttribute("pagingWrite", Paging.showPage(dto.getAllPage(), dto.getStartBlock(), dto.getEndBlock(), dto.getPage(), pageUrl));

        return "/site/board/"+board_skin+"/board_list";
	}
	
	
}
