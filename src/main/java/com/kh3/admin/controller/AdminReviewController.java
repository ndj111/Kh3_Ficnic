package com.kh3.admin.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kh3.model.review.ReviewDAO;
import com.kh3.model.review.ReviewDTO;

@Controller
public class AdminReviewController {

	
	@Inject
    private ReviewDAO dao;
	

	@RequestMapping("admin/review/review_list.do")
	public String list(Model model) {
		
		List<ReviewDTO> list = this.dao.getReviewList();
		
		model.addAttribute("List", list);
		
		return "admin/review/review_list";
		

}
	
	
	@RequestMapping("admin/review/review_view.do")
	public String view(Model model ,@RequestParam("no") int no) {
		
		ReviewDTO dto = this.dao.reviewView(no);
		
		model.addAttribute("dto", dto);
		
		return "admin/review/review_view";
	
	}
	
	
	
	@RequestMapping("admin/review/review_modify.do")
	public String update(@RequestParam("no") int no, Model model) {
		

		// 사원번호에 해당하는 상세내역을 조회하는 메서드 호출
		ReviewDTO dto = this.dao.reviewView(no);
		
		model.addAttribute("Modify", dto);
		

		return "admin/review/review_modify";
		
		
	}

		
	@RequestMapping("admin/review/review_modify_ok.do")
	public void updateOk(ReviewDTO dto, HttpServletResponse response) throws Exception {
		
		int check = this.dao.reviewModify(dto);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			out.println("<script>");
			out.println("alert('리뷰가 수정되었습니다.')");
			out.println("location.href='review_view.do?no="+dto.getReview_no()+"'");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('리뷰 수정에 실패했습니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		
	}
	
	
	@RequestMapping("admin/review/review_delete.do")
	public void delete(@RequestParam("no") int no, 
			HttpServletResponse response) throws Exception {
		
		int check = this.dao.reviewDelete(no);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			
			this.dao.updateSeq(no);
			
			out.println("<script>");
			out.println("alert('리뷰가 삭제되었습니다.')");
			out.println("location.href='review_list.do'");
			out.println("</script>");
			
		} else {
			out.println("<script>");
			out.println("alert('리뷰 삭제에 실패했습니다.')");
			out.println("history.back()");
			out.println("</script>");
			
		}
		
	}


	}
	
	
