package com.kh3.site.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh3.model.board.BoardCategoryDAO;
import com.kh3.model.board.BoardConfDAO;
import com.kh3.model.board.BoardConfDTO;
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
	
	//해당 게시물 성정값 가져오기
	
	// 전체 게시물의 수
    private int totalRecord = 0;

	
	private String path="site/board/";
	
	HttpServletRequest request;
	String bbs_id = request.getParameter("bbs_id");
	
	
	@RequestMapping("/site/board/board_list.do")
	public String board_list(HttpServletRequest request,Model model) {
		
		// 처리 까먹음 
		String board_skin = "basic";
        
		
		String field = request.getParameter("field");
        String keyword = request.getParameter("keyword");
        String bbs_id = request.getParameter("bbs_id");
        
        BoardConfDTO BoardConfdto = board_ConfDao.getBoardCont(bbs_id);
        // 한 페이지당 보여질 게시물의 수 -> 해당 게시물 설정값 가져와야한다.
        int rowsize = BoardConfdto.getBoard_list_num();
        
        
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
        
        // 페이징 DTO
        
        Map<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("field", field);
        searchMap.put("keyword", keyword);
        searchMap.put("bbs_id", bbs_id);
        
        PageDTO dto = new PageDTO(page, rowsize, totalRecord,searchMap);
        
        // 페이지 이동 URL
        String pageUrl = request.getContextPath()+"site/board/board_list.do?field="+field+"&keyword="+keyword;

        model.addAttribute("List", this.board_Dao.getBoardList(dto.getStartNo(),dto.getEndNo(),searchMap));
       
        model.addAttribute("board", BoardConfdto);
    	model.addAttribute("totalCount", totalRecord);
        model.addAttribute("paging", dto);
        model.addAttribute("field", field);
        model.addAttribute("keyword", keyword);
        model.addAttribute("pagingWrite", Paging.showPage(dto.getAllPage(), dto.getStartBlock(), dto.getEndBlock(), dto.getPage(), pageUrl));

        return "/site/board/"+board_skin+"/board_list";
	}
	
	/* httpServletRequest로 받아온 매핑을  */
	@RequestMapping("/site/board/board_write.do")
	public String board_write(HttpServletRequest request,Model model) {
		
		
		String bbs_id = request.getParameter("bbs_id");
		if(bbs_id == null) bbs_id ="";
		
		BoardConfDTO BoardConfdto = board_ConfDao.getBoardCont(bbs_id);
		
		model.addAttribute("board", BoardConfdto);
		
		return "/site/board/"+BoardConfdto.getBoard_skin()+"/board_write";
	}
	
	
	
	
}
