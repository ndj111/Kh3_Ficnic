package com.kh3.site.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kh3.model.ficnic.FicnicDAO;

import com.kh3.model.member.McouponDAO;
import com.kh3.model.member.McouponDTO;
import com.kh3.model.member.MemberDAO;
import com.kh3.model.member.MemberDTO;

import com.kh3.model.member.PointDAO;
import com.kh3.model.member.PointDTO;
import com.kh3.model.member.WishDAO;
import com.kh3.model.member.WishDTO;
import com.kh3.model.qna.QnaDAO;
import com.kh3.model.qna.QnaDTO;
import com.kh3.model.reserv.ReservDAO;
import com.kh3.model.reserv.ReservDTO;
import com.kh3.model.review.ReviewDAO;
import com.kh3.model.review.ReviewDTO;
import com.kh3.util.PageDTO;
import com.kh3.util.Paging;
import com.kh3.util.UploadFile;


@Controller
public class SiteMypageController {

    @Autowired
    private PointDAO pdao;
    
    @Autowired
    private QnaDAO qdao;

  
    @Inject
    private WishDAO wdao;
    
	@Inject
	private ReservDAO reservDAO;
	
	@Autowired
	private MemberDAO mdao;

	@Inject
	private McouponDAO mcouponDAO;
	
	@Inject
	private ReviewDAO rdao;
	
	@Inject
	private FicnicDAO fdao;
    
    BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    // 한 페이지당 보여질 게시물의 수
    private final int rowsize = 10;


    // 전체 게시물의 수
    private int totalRecord = 0;
    
    // 리뷰 사진 업로드 설정
    private String reviewFolder = "/resources/data/review/";
    private String reviewSaveName = "review";
    
    // =====================================================================================
    // 마이페이지 - 예약 목록
    // =====================================================================================
    @RequestMapping("mypage/mypage_reserv_list.do")
    public String reserv_list(
    		@RequestParam( value = "page", required = false, defaultValue = "1") int page,
    		@RequestParam( value = "getType", required = false, defaultValue = "") String getType,
    		Model model,
    		HttpServletRequest request,
    		HttpSession session) throws ParseException {
   
    	
    	String member_id = (String) session.getAttribute("sess_id");
    	
    	Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("member_id", member_id);
		searchMap.put("getType", getType);
		
		totalRecord = this.reservDAO.getSiteReservCount(searchMap);

		PageDTO dto = new PageDTO(page, rowsize, totalRecord, searchMap);

		List<ReviewDTO> sessionList =this.rdao.getListSession(member_id);
		// 페이지 이동 URL
		String pageUrl = request.getContextPath()+"/mypage/mypage_reserv_list.do?getType="+getType;
		
		
		// 현재 날짜/시간
        Date now = new Date();
 		
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
 
		List<ReservDTO> reservList = reservDAO.getReservSessionList(member_id);
		  if(reservList.size()!=0) {	  
			  for(ReservDTO val : reservList) { 			
					  
				  if(val.getReserv_ficnic_date() !=null && now.compareTo(format.parse(val.getReserv_ficnic_date())) > 0 ) {
						  this.reservDAO.updateReserv_status(val); 
				  }
					  
			  } 
		  }
			 
		
		
		
		model.addAttribute("List", this.reservDAO.getBoardList(dto.getStartNo(), dto.getEndNo(), searchMap));
		model.addAttribute("sList", sessionList);
		model.addAttribute("paging", dto);
		model.addAttribute("page", page);
		model.addAttribute("getType", getType);
		model.addAttribute("pagingWrite",Paging.showPage(dto.getAllPage(), dto.getStartBlock(), dto.getEndBlock(), dto.getPage(), pageUrl));
		
        return "site/mypage/mypage_reserv_list";
    }
    
    @RequestMapping("mypage/mypage_review_write.do")
    public void myPage_review(MultipartHttpServletRequest mRequest,
    		HttpSession session,
    		ReviewDTO dto, HttpServletResponse response) throws IOException {
       
    	System.out.println(dto);
    	
    	
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
        int res = this.rdao.writeOkReview(dto);
        
        int mileage = 500;
    	
        Map<String, Object> map = new HashMap<String, Object>();
    	
    	map.put("mileage", mileage);
    	map.put("sess_id", (String)session.getAttribute("sess_id"));
        
    	if(res>0) {
    		
    		
    		// 피크닉 포인트 주기
    		this.mdao.updatePlusPoint(map);
    		
    		// 피크닉 적립금 내역
    		this.pdao.plusPoint(map);
            
    		// 피크닉 평점 수정
            this.fdao.updateReviewPoint(dto.getFicnic_no());

        	// 피크닉 리뷰 갯수 수정
        	this.fdao.updateReviewCont(dto.getFicnic_no());
        	
    		out.println("<script>alert('리뷰글이 등록이 정상적으로 처리되었습니다.');location.href='"+mRequest.getContextPath()+"/mypage/mypage_reserv_list.do';</script>");
    	}else {
    		out.println("<script>alert('리뷰글 등록 중 에러가 발생하였습니다.');history.back()</script>");
    	}
    }
    
	/* 미사용 메서드.. */
    @RequestMapping("mypage/mypage_review_modify.do")
    public void myPage_modify(MultipartHttpServletRequest mRequest, ReviewDTO dto, HttpServletResponse response) throws IOException {
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
    	dto.setReview_no(Integer.parseInt(mRequest.getParameter("rno")));
    	
        // 리뷰 수정
        int check = this.rdao.reviewModify(dto);

        // 피크닉 평점 수정
        this.fdao.updateReviewPoint(dto.getFicnic_no());

        if(check > 0){
            out.println("<script>alert('리뷰글 변경 처리가 정상적으로 완료되었습니다.');location.href='"+mRequest.getContextPath()+"/mypage/mypage_reserv_list.do';</script>");
        }else{
            out.println("<script>alert('리뷰글 변경 중 에러가 발생하였습니다.'); history.back();</script>");
        }
    }
    /* 미사용 메서드.. */




    // =====================================================================================
    // 마이페이지 - 위시 리스트
    // =====================================================================================
    @RequestMapping("mypage/mypage_wish_list.do")
    public String wish_list(
    		HttpSession session,
    		Model model
    		) {
    	
    	List<WishDTO> List=wdao.getMemberWishList((String)session.getAttribute("sess_id"));
   
    	model.addAttribute("List", List);
    	
        return "site/mypage/mypage_wish_list";
    }





    // =====================================================================================
    // 마이페이지 - 쿠폰 보관함
    // =====================================================================================
    @RequestMapping("mypage/mypage_coupon_list.do")
    public String coupon_list(HttpSession session, Model model) {
    	List<McouponDTO> List =  this.mcouponDAO.getCouponView((String)session.getAttribute("sess_id"));

    	model.addAttribute("List", List);

    	return "site/mypage/mypage_coupon_list";
    }





    // =====================================================================================
    // 마이페이지 - 적립금 내역
    // =====================================================================================
    @RequestMapping("mypage/mypage_point_list.do")
    public String point_list(Model model, HttpSession session, HttpServletRequest request) {
    	session = request.getSession();
    	String id = (String) session.getAttribute("sess_id");
    	
    	List<PointDTO> pList = this.pdao.getPointView(id);
    	model.addAttribute("pList", pList);
        return "site/mypage/mypage_point_list";
    }





    // =====================================================================================
    // 마이페이지 - 내 1:1 문의 목록
    // =====================================================================================
    @RequestMapping("mypage/mypage_qna_list.do")
    public String qna_list(Model model, HttpSession session, HttpServletRequest request) {
    	session = request.getSession();
    	String id = (String) session.getAttribute("sess_id");    	
    	
    	List<QnaDTO> qList = this.qdao.siteQnaList(id);
    	model.addAttribute("qList", qList);
        return "site/mypage/mypage_qna_list";
    }

    	
    

    // =====================================================================================
    // 마이페이지 - 회원정보 수정 페이지 이동
    // =====================================================================================
    @RequestMapping("mypage/mypage_info_modify.do")
    public String midify(Model model, HttpSession session, HttpServletRequest request) {
      
		
		  session = request.getSession(); 
		  String id = (String)
		  session.getAttribute("sess_id");
		  
		  MemberDTO dto = this.mdao.getReservMember(id); 
		  model.addAttribute("member", dto);
		 


        return "site/mypage/mypage_info_modify";
        
    }

    
 // =====================================================================================
    // 마이페이지 - 회원정보 수정
    // =====================================================================================
    @RequestMapping("mypage/mypage_info_modifyOk.do")
    public void modifyOk(@Valid MemberDTO dto, BindingResult result, @RequestParam("member_pw") String member_pw, HttpSession session, 
    		HttpServletRequest request, @RequestParam("member_pw_re") String member_pw_re, HttpServletResponse response) throws IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

		session = request.getSession(); 
		String pw = (String)session.getAttribute("sess_pw");

        // 비밀번호 일치하지 않는 경우
        if (!member_pw.equals(member_pw_re)) {
            out.println("<script>alert('[비밀번호]가 일치하지 않습니다. 다시 입력해주세요.'); history.back();</script>");
        } 
        
        
        // 비밀번호 입력한 경우
        else if (member_pw.length() > 0) {
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
            
            
            int check = this.mdao.sitemodifyOk(dto);
            if (check > 0) {
               out.println("<script> location.href='mypage_info_modify.do';</script>");
               session = request.getSession();
               session.setAttribute("sess_pw", dto.getMember_pw());
               session.setAttribute("sess_type", dto.getMember_type());
               session.setAttribute("sess_name", dto.getMember_name());
               session.setAttribute("sess_email", dto.getMember_email());
               session.setAttribute("sess_phone", dto.getMember_phone());
               session.setAttribute("sess_point", dto.getMember_point());
            } else {
                out.println("<script>alert('회원 정보 수정 중 에러가 발생하였습니다.'); history.back();</script>");
            }


        // 기존에 가지고 있던 비밀번호로 수정
        }  else {
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

            
            		dto.setMember_pw(pw);
                     	
        			int check = this.mdao.sitemodifyOk(dto);
        	        if (check > 0) {
        	               out.println("<script> location.href='mypage_info_modify.do';</script>");
        	               session = request.getSession();
        	               session.setAttribute("sess_pw", dto.getMember_pw());
        	               session.setAttribute("sess_type", dto.getMember_type());
        	               session.setAttribute("sess_name", dto.getMember_name());
        	               session.setAttribute("sess_email", dto.getMember_email());
        	               session.setAttribute("sess_phone", dto.getMember_phone());
        	               session.setAttribute("sess_point", dto.getMember_point());
        	        } else {
        	                out.println("<script>alert('회원 정보 수정 중 에러가 발생하였습니다.'); history.back();</script>");
        	            }

        	        }

        	    }
    
    
    
    
    
 // =====================================================================================
    // 마이페이지 - 회원탈퇴
    // =====================================================================================
    @RequestMapping("mypage/mypage_secession.do")
    public void secession(MemberDTO dto, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        
    	session = request.getSession(); 
		String id = (String)session.getAttribute("sess_id");
		 
		MemberDTO mdto = this.mdao.getReservMember(id);
		 
		
		int check = this.mdao.secession(mdto);
		 
		if(check > 0) {
			 out.println("<script>alert('회원탈퇴 처리가 정상적으로 완료되었습니다.\\n그동안 Ficnic을 이용해 주셔서 감사합니다.'); location.href='../main.do';</script>");
        } else {
             out.println("<script>alert('회원 탈퇴 중 에러가 발생하였습니다.'); history.back();</script>");
		}
    	
        request.getSession().invalidate();
        request.getSession(true);

        out.println("<script>location.href='" + request.getContextPath() + "/';</script>");
    	
    }
    
    



}