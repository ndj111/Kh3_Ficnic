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

    // ??? ???????????? ????????? ???????????? ???
    private final int rowsize = 10;


    // ?????? ???????????? ???
    private int totalRecord = 0;
    
    // ?????? ?????? ????????? ??????
    private String reviewFolder = "/resources/data/review/";
    private String reviewSaveName = "review";
    
    // =====================================================================================
    // ??????????????? - ?????? ??????
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
		// ????????? ?????? URL
		String pageUrl = request.getContextPath()+"/mypage/mypage_reserv_list.do?getType="+getType;
		
		
		// ?????? ??????/??????
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
    	// ???????????? ?????? >> thisFolder/saveName_????????????_???????????????.?????????
        
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

        // ?????? ??????
        int res = this.rdao.writeOkReview(dto);
        
        int mileage = 500;
    	
        Map<String, Object> map = new HashMap<String, Object>();
    	
    	map.put("mileage", mileage);
    	map.put("sess_id", (String)session.getAttribute("sess_id"));
        
    	if(res>0) {
    		
    		
    		// ????????? ????????? ??????
    		this.mdao.updatePlusPoint(map);
    		
    		// ????????? ????????? ??????
    		this.pdao.plusPoint(map);
            
    		// ????????? ?????? ??????
            this.fdao.updateReviewPoint(dto.getFicnic_no());

        	// ????????? ?????? ?????? ??????
        	this.fdao.updateReviewCont(dto.getFicnic_no());
        	
    		out.println("<script>alert('???????????? ????????? ??????????????? ?????????????????????.');location.href='"+mRequest.getContextPath()+"/mypage/mypage_reserv_list.do';</script>");
    	}else {
    		out.println("<script>alert('????????? ?????? ??? ????????? ?????????????????????.');history.back()</script>");
    	}
    }
    
	/* ????????? ?????????.. */
    @RequestMapping("mypage/mypage_review_modify.do")
    public void myPage_modify(MultipartHttpServletRequest mRequest, ReviewDTO dto, HttpServletResponse response) throws IOException {
    	response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        
     // ???????????? ?????? >> thisFolder/saveName_????????????_???????????????.?????????
        List<String> upload_list = UploadFile.fileUpload(mRequest, reviewFolder, reviewSaveName);

        // ?????? ?????? ????????? ?????? ??????
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
    	
        // ?????? ??????
        int check = this.rdao.reviewModify(dto);

        // ????????? ?????? ??????
        this.fdao.updateReviewPoint(dto.getFicnic_no());

        if(check > 0){
            out.println("<script>alert('????????? ?????? ????????? ??????????????? ?????????????????????.');location.href='"+mRequest.getContextPath()+"/mypage/mypage_reserv_list.do';</script>");
        }else{
            out.println("<script>alert('????????? ?????? ??? ????????? ?????????????????????.'); history.back();</script>");
        }
    }
    /* ????????? ?????????.. */




    // =====================================================================================
    // ??????????????? - ?????? ?????????
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
    // ??????????????? - ?????? ?????????
    // =====================================================================================
    @RequestMapping("mypage/mypage_coupon_list.do")
    public String coupon_list(HttpSession session, Model model) {
    	List<McouponDTO> List =  this.mcouponDAO.getCouponView((String)session.getAttribute("sess_id"));

    	model.addAttribute("List", List);

    	return "site/mypage/mypage_coupon_list";
    }





    // =====================================================================================
    // ??????????????? - ????????? ??????
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
    // ??????????????? - ??? 1:1 ?????? ??????
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
    // ??????????????? - ???????????? ?????? ????????? ??????
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
    // ??????????????? - ???????????? ??????
    // =====================================================================================
    @RequestMapping("mypage/mypage_info_modifyOk.do")
    public void modifyOk(@Valid MemberDTO dto, BindingResult result, @RequestParam("member_pw") String member_pw, HttpSession session, 
    		HttpServletRequest request, @RequestParam("member_pw_re") String member_pw_re, HttpServletResponse response) throws IOException {

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

		session = request.getSession(); 
		String pw = (String)session.getAttribute("sess_pw");

        // ???????????? ???????????? ?????? ??????
        if (!member_pw.equals(member_pw_re)) {
            out.println("<script>alert('[????????????]??? ???????????? ????????????. ?????? ??????????????????.'); history.back();</script>");
        } 
        
        
        // ???????????? ????????? ??????
        else if (member_pw.length() > 0) {
        	// ????????? ??????????????? ??????,  ????????? ??????
            dto.setMember_pw(passwordEncoder.encode(member_pw));

            // ????????? ??????
            if (result.hasErrors()) {
                List<ObjectError> list = result.getAllErrors();
                for (ObjectError error : list) {
                    if (error.getDefaultMessage().equals("pw_re")) {
                        out.println("<script>alert('??????????????? ???????????? ??????, ??????????????? ????????? 1??? ?????? ????????? 6???~12?????? ?????????????????? ?????????.'); history.back();</script>");
                        break;
                    } else if (error.getDefaultMessage().equals("email")) {
                        out.println("<script>alert('????????? ????????? ???????????????. ?????? ????????? ?????????.'); history.back();</script>");
                        break;
                    } else if (error.getDefaultMessage().equals("phone")) {
                        out.println("<script>alert('????????? ???????????? ???????????????. ?????? ????????? ?????????.'); history.back();</script>");
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
                out.println("<script>alert('?????? ?????? ?????? ??? ????????? ?????????????????????.'); history.back();</script>");
            }


        // ????????? ????????? ?????? ??????????????? ??????
        }  else {
            // ????????? ??????
            if (result.hasErrors()) {
                List<ObjectError> list = result.getAllErrors();

                for (ObjectError error : list) {
                    if (error.getDefaultMessage().equals("email")) {
                        out.println("<script>alert('????????? ????????? ???????????????. ?????? ????????? ?????????.'); history.back();</script>");
                        break;
                    } else if (error.getDefaultMessage().equals("phone")) {
                        out.println("<script>alert('????????? ???????????? ???????????????. ?????? ????????? ?????????.'); history.back();</script>");
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
        	                out.println("<script>alert('?????? ?????? ?????? ??? ????????? ?????????????????????.'); history.back();</script>");
        	            }

        	        }

        	    }
    
    
    
    
    
 // =====================================================================================
    // ??????????????? - ????????????
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
			 out.println("<script>alert('???????????? ????????? ??????????????? ?????????????????????.\\n????????? Ficnic??? ????????? ????????? ???????????????.'); location.href='../main.do';</script>");
        } else {
             out.println("<script>alert('?????? ?????? ??? ????????? ?????????????????????.'); history.back();</script>");
		}
    	
        request.getSession().invalidate();
        request.getSession(true);

        out.println("<script>location.href='" + request.getContextPath() + "/';</script>");
    	
    }
    
    



}