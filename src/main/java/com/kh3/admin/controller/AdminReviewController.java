package com.kh3.admin.controller;

import java.io.File;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kh3.model.ficnic.FicnicDAO;
import com.kh3.model.ficnic.FicnicDTO;
import com.kh3.model.review.ReviewDAO;
import com.kh3.model.review.ReviewDTO;
import com.kh3.util.PageDTO;
import com.kh3.util.Paging;
import com.kh3.util.UploadFile;

@Controller
public class AdminReviewController {

    @Inject
    private ReviewDAO dao;

    @Inject
    private FicnicDAO fdao;


    // 리뷰 사진 업로드 설정
    private String reviewFolder = "/resources/data/review/";
    private String reviewSaveName = "review";


    // 한 페이지당 보여질 게시물의 수
    private final int rowsize = 10;

    // 전체 게시물의 수
    private int totalRecord = 0;



    // =====================================================================================
    // 리뷰 목록
    // =====================================================================================
    @RequestMapping("admin/review/review_list.do")
    public String list(Model model, HttpServletRequest request) {
        // 검색 처리
        String search_ficnic = request.getParameter("search_ficnic");
        if (search_ficnic == null) search_ficnic = "";

        String search_review = request.getParameter("search_review");
        if (search_review == null) search_review = "";

        String search_writer = request.getParameter("search_writer");
        if (search_writer == null) search_writer = "";

        Map<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("search_ficnic", search_ficnic);
        searchMap.put("search_review", search_review);
        searchMap.put("search_writer", search_writer);


        // 페이징 처리
        int page; // 현재 페이지 변수
        if (request.getParameter("page") != null && request.getParameter("page") != "") {
            page = Integer.parseInt(request.getParameter("page"));
        } else {
            page = 1;
        }
        totalRecord = this.dao.getReviewCount(searchMap);

        // 페이징 DTO
        PageDTO dto = new PageDTO(page, rowsize, totalRecord, searchMap);

        // 페이지 이동 URL
        String pageUrl = request.getContextPath() + "/admin/review/review_list.do?search_ficnic=" + search_ficnic + "&search_review=" + search_review + "&search_writer=" + search_writer;

        List<ReviewDTO> list = this.dao.getReviewList(dto.getStartNo(), dto.getEndNo(), searchMap);
        model.addAttribute("List", list);

        model.addAttribute("totalCount", totalRecord);
        model.addAttribute("paging", dto);
        model.addAttribute("search_ficnic", search_ficnic);
        model.addAttribute("search_review", search_review);
        model.addAttribute("search_writer", search_writer);
        model.addAttribute("pagingWrite", Paging.showPage(dto.getAllPage(), dto.getStartBlock(), dto.getEndBlock(), dto.getPage(), pageUrl));

        return "admin/review/review_list";
    }




    // =====================================================================================
    // 리뷰 내용 보기
    // =====================================================================================
    @RequestMapping("admin/review/review_view.do")
    public String view(Model model, @RequestParam("no") int no) {
        ReviewDTO dto = this.dao.reviewView(no);
        model.addAttribute("dto", dto);

        return "admin/review/review_view";
    }




    // =====================================================================================
    // 리뷰 수정 페이지
    // =====================================================================================
    @RequestMapping("admin/review/review_modify.do")
    public String update(@RequestParam("no") int no, Model model) {
        ReviewDTO dto = this.dao.reviewView(no);
        model.addAttribute("Modify", dto);

        return "admin/review/review_modify";
    }




    // =====================================================================================
    // 리뷰 수정 처리
    // =====================================================================================
    @RequestMapping("admin/review/review_modify_ok.do")
    public void updateOk(ReviewDTO dto, MultipartHttpServletRequest mRequest, HttpServletResponse response) throws Exception {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();


        // 파일저장 이름 >> thisFolder/saveName_일련번호_밀리세컨드.확장자
        List<String> upload_list = UploadFile.fileUpload(mRequest, reviewFolder, reviewSaveName);

        // 기존 파일 있으면 삭제 처리
        for(int i=0; i<upload_list.size(); i++) {
            String check_photo = mRequest.getParameter("ori_review_photo"+(i+1));
            if(check_photo != null && upload_list.get(i) != ""){
                File del_pimage = new File(mRequest.getSession().getServletContext().getRealPath(check_photo));
                if(del_pimage.exists()) del_pimage.delete();
            }
        }

        String modify_photo1 = mRequest.getParameter("ori_review_photo1");
        String modify_photo2 = mRequest.getParameter("ori_review_photo2");

        if(upload_list.get(0) != "") modify_photo1 = upload_list.get(0);
        if(upload_list.get(1) != "") modify_photo2 = upload_list.get(1);

        dto.setReview_photo1(modify_photo1);
        dto.setReview_photo2(modify_photo2);


        // 리뷰 수정
        int check = this.dao.reviewModify(dto);

        // 피크닉 평점 수정
        this.fdao.updateReviewPoint(dto.getFicnic_no());

        if(check > 0){
            out.println("<script> location.href='review_list.do';</script>");
        }else{
            out.println("<script>alert('리뷰 변경 중 에러가 발생하였습니다.'); history.back();</script>");
        }

    }




    // =====================================================================================
    // 리뷰 삭제 처리
    // =====================================================================================
    @RequestMapping("admin/review/review_delete.do")
    public void delete(@RequestParam("review_no") int review_no, @RequestParam("ficnic_no") int ficnic_no, HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        ReviewDTO dto = this.dao.reviewView(review_no);

        // 기존 파일 있으면 삭제 처리
        if(dto.getReview_photo1() != null){
            File del_pimage1 = new File(request.getSession().getServletContext().getRealPath(dto.getReview_photo1()));
            if(del_pimage1.exists()) del_pimage1.delete();
        }
        if(dto.getReview_photo2() != null){
            File del_pimage2 = new File(request.getSession().getServletContext().getRealPath(dto.getReview_photo2()));
            if(del_pimage2.exists()) del_pimage2.delete();
        }


        int check = this.dao.reviewDelete(review_no);

        if (check > 0) {
            this.dao.updateSeq(review_no);
            this.fdao.updateReviewPoint(ficnic_no);	
            out.println("<script> location.href='review_list.do';</script>");

        } else {
            out.println("<script>alert('리뷰 삭제 중 에러가 발생하였습니다.'); history.back();</script>");

        }
    }




    // =====================================================================================
    // 리뷰 등록 페이지
    // =====================================================================================
    @RequestMapping("admin/review/review_write.do")	
    public String reviewWrite(Model model) {
        LocalDate getDate = LocalDate.now();
        String reviewDate = getDate.format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));

        LocalTime getTime = LocalTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
        String nowTime = getTime.format(formatter);

        List<FicnicDTO> fdto = this.fdao.getFicnicList();
    	
    	String randomId = UUID.randomUUID().toString().replace("-", "");//-를 제거
    	randomId = randomId.substring(0,10);//randomId를 앞에서부터 10자리 잘라줌
        
    	model.addAttribute("randomId", randomId);
    	model.addAttribute("fdto", fdto);
    	model.addAttribute("reviewDate", reviewDate + " " + nowTime);

    	return "admin/review/review_write";
    }    
    



    // =====================================================================================
    // 리뷰 등록 처리
    // =====================================================================================
    @RequestMapping("admin/review/review_write_ok.do")
    public void reviewWriteOk(ReviewDTO dto, MultipartHttpServletRequest mRequest, HttpServletResponse response) throws Exception {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        // 파일저장 이름 >> thisFolder/saveName_일련번호_밀리세컨드.확장자
        List<String> upload_list = UploadFile.fileUpload(mRequest, reviewFolder, reviewSaveName);        
        for(int i=0; i<upload_list.size(); i++){
            switch (i) {
                case 0:
                    dto.setReview_photo1(upload_list.get(0));
                    break;
                case 1:
                	dto.setReview_photo2(upload_list.get(1));
                    break;
                default:
                    break;
            }
        }

        // 리뷰 등록
        int check = this.dao.writeOkReview(dto);

        if(check > 0){
            // 피크닉 평점 수정
            this.fdao.updateReviewPoint(dto.getFicnic_no());

        	// 피크닉 리뷰 갯수 수정
        	this.fdao.updateReviewCont(dto.getFicnic_no());

        	out.println("<script>location.href='review_list.do';</script>");
        }else{
            out.println("<script>alert('리뷰 등록 중 에러가 발생하였습니다.'); history.back();</script>");
        }

    }    
    
    
}
