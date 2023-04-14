package com.kh3.site.controller;


import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kh3.model.coupon.CouponDAO;
import com.kh3.model.coupon.CouponDTO;
import com.kh3.model.ficnic.CategoryDAO;
import com.kh3.model.ficnic.CategoryDTO;
import com.kh3.model.ficnic.FicnicDAO;
import com.kh3.model.ficnic.FicnicDTO;
import com.kh3.model.member.McouponDAO;
import com.kh3.model.member.McouponDTO;
import com.kh3.model.member.MemberDAO;
import com.kh3.model.member.MemberDTO;
import com.kh3.model.member.PointDAO;
import com.kh3.model.member.WishDAO;
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
public class SiteFicnicController {

    @Inject
    CategoryDAO cdao;

    @Inject
    FicnicDAO fdao;

    @Inject
    ReviewDAO rdao;
    
    @Inject
    QnaDAO qdao;
    
    @Inject
    McouponDAO mdao;

    @Inject
    WishDAO wdao;
    
    @Inject
    MemberDAO memberDAO;

    @Inject
    ReservDAO reservDAO;

    @Inject
    CouponDAO couponDAO;

    @Inject
    McouponDAO mcouponDAO;
    
    @Inject
    PointDAO pointDAO;
    
    // 문의 사진 업로드 설정
    private String qnaFolder = "/resources/data/qna/";
    private String qnaSaveName = "qna";


    // 한 페이지당 보여질 게시물의 수
    private final int rowsize = 12;

    // 전체 게시물의 수
    private int totalRecord = 0;




    // =====================================================================================
    // 카테고리 페이지
    // =====================================================================================
    @RequestMapping("ficnic/ficnic_category.do")
    public String categoryList(Model model) {
        List<CategoryDTO> list = cdao.getSiteCategoryList();
        model.addAttribute("cList", list);

        return "site/ficnic/ficnic_category";
    }




    // =====================================================================================
    // 피크닉 목록 페이지
    // =====================================================================================
    @RequestMapping("ficnic/ficnic_list.do")
    public String ficnic_List(
        @RequestParam(value = "category", required = false, defaultValue = "") String ficnic_category_no,
        @RequestParam(value = "sort", required = false, defaultValue = "popular") String sort,
        @RequestParam(value = "page", required = false, defaultValue = "1") int page,
        @RequestParam(value = "search", required = false, defaultValue = "") String search,
        HttpServletRequest request, HttpSession session, Model model) {

        String parent_category_no = "";
        int next_num = 0;
        String parent_str = "";

        String category_name = "";
        List<CategoryDTO> cList = null;
        CategoryDTO cdto = null;


        // -------------------------------------------------------
        // 검색 일때
        // -------------------------------------------------------
        if(!search.equals("") & ficnic_category_no.equals("")) {
            // 현재 카테고리 이름
            category_name = search + " 검색 결과";


        // -------------------------------------------------------
        // 일반 카테고리
        // -------------------------------------------------------
        }else{

            // 카테고리 정보
            cdto = cdao.getCategoryCont(ficnic_category_no);
            parent_category_no = (ficnic_category_no.substring(0, 2)) + "000000";

            // 카테고리 피크닉 불러오기 위한 설정
            next_num = cdto.getCategory_depth() * 2;
            parent_str = ficnic_category_no.substring(0, next_num);

            // 현재 카테고리 이름
            category_name = this.cdao.getCategoryName(parent_category_no);

            // 서브 카테고리 목록
            cList = cdao.getSiteSubCategoryList(parent_category_no);

        }



        // 세션 아이디 가져오기
        String sess_id = "";
        if(session.getAttribute("sess_id") != null) {
            sess_id = (String) session.getAttribute("sess_id");
        }

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("category_no", ficnic_category_no);
        map.put("next_num", next_num);
        map.put("parent_str", parent_str);
        map.put("sess_id", sess_id);
        map.put("sort", sort);
        map.put("search", search);


        totalRecord = fdao.getSiteListCount(map);
        PageDTO dto = new PageDTO(page, rowsize, totalRecord, map);

        // 페이지 이동 URL
        String pageUrl = request.getContextPath() + "/ficnic/ficnic_list.do?category=" + ficnic_category_no + "&sort=" + sort + "&search=" + search;


        // 카테고리 피크닉 목록
        List<FicnicDTO> fList = fdao.getSiteFicnicList(dto.getStartNo(), dto.getEndNo(), map);


        model.addAttribute("flist", fList);
        model.addAttribute("clist", cList);
        model.addAttribute("cdto", cdto);
        model.addAttribute("category_no", ficnic_category_no);
        model.addAttribute("parent_category_no", parent_category_no);
        model.addAttribute("category_name", category_name);

        model.addAttribute("sort", sort);
        model.addAttribute("search", search);

        model.addAttribute("totalCount", totalRecord);
        model.addAttribute("paging", dto);
        model.addAttribute("pagingWrite", Paging.showPage(dto.getAllPage(), dto.getStartBlock(), dto.getEndBlock(), dto.getPage(), pageUrl));

        return "site/ficnic/ficnic_list";
    }






    // =====================================================================================
    // 피크닉 랭킹 페이지
    // =====================================================================================
    @RequestMapping("ficnic/ficnic_rank.do")
    public String ficnic_rank(
        @RequestParam(value = "page", required = false, defaultValue = "1") int page,
        HttpServletRequest request, HttpSession session, Model model) {

        // 세션 아이디 가져오기
        String sess_id = "";
        if(session.getAttribute("sess_id") != null) {
            sess_id = (String) session.getAttribute("sess_id");
        }

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("page_type", "rank");
        map.put("sess_id", sess_id);


        totalRecord = fdao.getSiteListCount(map);
        PageDTO dto = new PageDTO(page, rowsize, totalRecord, map);

        // 페이지 이동 URL
        String pageUrl = request.getContextPath() + "/ficnic/ficnic_rank.do";


        // 카테고리 피크닉 목록
        List<FicnicDTO> fList = fdao.getSiteFicnicList(dto.getStartNo(), dto.getEndNo(), map);


        model.addAttribute("flist", fList);
        model.addAttribute("category_name", "실시간 랭킹 🏆");

        model.addAttribute("totalCount", totalRecord);
        model.addAttribute("paging", dto);
        model.addAttribute("pagingWrite", Paging.showPage(dto.getAllPage(), dto.getStartBlock(), dto.getEndBlock(), dto.getPage(), pageUrl));


        return "site/ficnic/ficnic_list";
    }






    // =====================================================================================
    // 신규 피크닉 페이지
    // =====================================================================================
    @RequestMapping("ficnic/ficnic_new.do")
    public String ficnic_new(
        @RequestParam(value = "page", required = false, defaultValue = "1") int page,
        HttpServletRequest request, HttpSession session, Model model) {

        // 세션 아이디 가져오기
        String sess_id = "";
        if(session.getAttribute("sess_id") != null) {
            sess_id = (String) session.getAttribute("sess_id");
        }


        LocalDate chkNowDate = LocalDate.now().minusDays(7L); // 오늘로부터 7일전 부터
        String newDate = chkNowDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));


        Map<String, Object> map = new HashMap<String, Object>();
        map.put("page_type", "new");
        map.put("new_date", newDate);
        map.put("sess_id", sess_id);


        totalRecord = fdao.getSiteListCount(map);
        PageDTO dto = new PageDTO(page, rowsize, totalRecord, map);

        // 페이지 이동 URL
        String pageUrl = request.getContextPath() + "/ficnic/ficnic_new.do";


        // 카테고리 피크닉 목록
        List<FicnicDTO> fList = fdao.getSiteFicnicList(dto.getStartNo(), dto.getEndNo(), map);


        model.addAttribute("flist", fList);
        model.addAttribute("category_name", "신규 피크닉 🔔");

        model.addAttribute("totalCount", totalRecord);
        model.addAttribute("paging", dto);
        model.addAttribute("pagingWrite", Paging.showPage(dto.getAllPage(), dto.getStartBlock(), dto.getEndBlock(), dto.getPage(), pageUrl));


        return "site/ficnic/ficnic_list";
    }







    // =====================================================================================
    // 피크닉 내용 보기 페이지
    // =====================================================================================
    @RequestMapping("ficnic/ficnic_view.do")
    public String ficnic_view(
        @RequestParam(value = "category", required = false, defaultValue = "") String ficnic_category_no,
        @RequestParam(value = "ficnic_no", required = false, defaultValue = "") int ficnic_no,
        HttpSession session, Model model) {

        String sess_id = "";
        if(session.getAttribute("sess_id") != null) {
            sess_id = (String) session.getAttribute("sess_id");
        }


        FicnicDTO dto = fdao.getFicnicCont(ficnic_no);

        // 조회수 늘리기
        fdao.updateFicnicHit(ficnic_no);


        if(ficnic_category_no.equals("") || ficnic_category_no == null) {
            ficnic_category_no = dto.getFicnic_category_no();
        }

        // 현재 카테고리 이름
        String parent_category_no = (ficnic_category_no.substring(0, 2)) + "000000";
        String category_name = this.cdao.getCategoryName(parent_category_no);


        // 위시리스트 체크
        String ficnic_wish = "N";
        if(session.getAttribute("sess_id") != null) {
            int chkWish = this.wdao.getFicnicInWish(ficnic_no, sess_id);
            if(chkWish > 0) ficnic_wish = "Y";
        }
       
        
        Map<String, Object> numListMap = new HashMap<String, Object>();
        numListMap.put("ficnic_no", ficnic_no);
        numListMap.put("getType", "");
        List<ReviewDTO> rList = rdao.getNumList(numListMap);


        // 리뷰 점수
        int cnt = 0;
        for (ReviewDTO rev : rList) {
            if (rev.getReview_point() > 9) cnt++;
        }

        int avg = 0;
        if (cnt > 0 && rList.size() > 0) {
            avg = (int) Math.round((double) cnt / (double) rList.size() * 100);
        }


        /* 앞단 보여질 option 처리 */
        List<HashMap<String, Object>> optionList = new ArrayList<HashMap<String, Object>>();

        String[] optionTitle = null;
        if (dto.getFicnic_option_title() != null) optionTitle = dto.getFicnic_option_title().split("★");

        Object[] optionPrice = null;
        if (dto.getFicnic_option_price() != null) optionPrice = dto.getFicnic_option_price().split("★");

        if (optionTitle != null && optionPrice != null) {
            cnt = 0;
            for (String value : optionTitle) {
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("title", value);
                map.put("price", Integer.parseInt((String) optionPrice[cnt]));

                if(cnt == 0) {
                    map.put("cls", "info");
                    map.put("btn", "plus");
                }else{
                    map.put("cls", "danger");
                    map.put("btn", "minus");
                }

                optionList.add(map);
                cnt++;
            }
        }



        /* 앞단 보여질 select_option 처리 */
        List<HashMap<String, Object>> selectList = new ArrayList<HashMap<String, Object>>();

        String[] selectTitle = null;
        if (dto.getFicnic_select_title() != null) selectTitle = dto.getFicnic_select_title().split("★");

        Object[] selectPrice = null;
        if (dto.getFicnic_select_price() != null) selectPrice = dto.getFicnic_select_price().split("★");

        if (selectTitle != null && selectPrice != null) {
            cnt = 0;
            for (String value : selectTitle) {
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("title", value);
                map.put("price", Integer.parseInt((String) selectPrice[cnt]));

                if(cnt == 0) {
                    map.put("cls", "info");
                    map.put("btn", "plus");
                }else{
                    map.put("cls", "danger");
                    map.put("btn", "minus");
                }

                selectList.add(map);
                cnt++;
            }
        }



        /* 앞단 보여질 info 처리 */
        List<HashMap<String, Object>> infoList = new ArrayList<HashMap<String, Object>>();

        String[] infoAll = null;
        if (dto.getFicnic_info() != null) infoAll = dto.getFicnic_info().split("★");

        if(infoAll != null) {
            cnt = 0;
            for (String ilist : infoAll) {
                String[] infoEpd = ilist.split("○");

                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("title", infoEpd[0]);
                map.put("cont", infoEpd[1]);

                if(cnt == 0) {
                    map.put("cls", "info");
                    map.put("btn", "plus");
                }else{
                    map.put("cls", "danger");
                    map.put("btn", "minus");
                }

                infoList.add(map);
                cnt++;
            }
        }



        /* 앞단 보여질 curriculum 처리 */
        List<HashMap<String, Object>> currList = new ArrayList<HashMap<String, Object>>();

        String[] currAll = null;
        if (dto.getFicnic_curriculum() != null) currAll = dto.getFicnic_curriculum().split("★");

        if(currAll != null) {
            cnt = 0;
            for (String clist : currAll) {
                String[] currEpd = clist.split("○");

                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("time", currEpd[0]);
                map.put("cont", currEpd[1]);

                if(cnt == 0) {
                    map.put("cls", "info");
                    map.put("btn", "plus");
                }else{
                    map.put("cls", "danger");
                    map.put("btn", "minus");
                }

                currList.add(map);
                cnt++;
            }
        }


        // 다운받을 수 있는 쿠폰 체크
        CouponDTO cdto = couponDAO.getDownloadAbleCoupon(dto, sess_id);


        // 오늘 날짜 넘기
        LocalDate getDate = LocalDate.now();
        String todayDate = getDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));


        model.addAttribute("dto", dto);
        model.addAttribute("cdto", cdto);
        model.addAttribute("rList", rList);

        model.addAttribute("category_name", category_name);
        model.addAttribute("ficnic_wish", ficnic_wish);
        model.addAttribute("count", rList.size());
        model.addAttribute("avg", avg);

        model.addAttribute("optionList", optionList);
        model.addAttribute("selectList", selectList);
        model.addAttribute("infoList", infoList);
        model.addAttribute("currList", currList);

        model.addAttribute("todayDate", todayDate);

        return "site/ficnic/ficnic_view";
    }




    // =====================================================================================
    // 피크닉 내용 보기 - 리뷰 목록 페이지
    // =====================================================================================
    @RequestMapping("ficnic/ficnic_review.do")
    public String ficnic_review(@RequestParam(value = "ficnic_no", required = false, defaultValue = "") int ficnic_no,
    		@RequestParam(value = "getType", required = false, defaultValue = "") String getType, 
    		@RequestParam(value = "page", required = false, defaultValue = "1") int page, Model model, HttpServletRequest request) {
        
    	// 정렬 설정
    	Map<String, Object> searchMap = new HashMap<String, Object>();
    	searchMap.put("ficnic_no", ficnic_no);
    	searchMap.put("getType", getType);
    	// 페이징
    	totalRecord = this.rdao.getSiteReviewCount(searchMap);

		PageDTO pdto = new PageDTO(page, rowsize, totalRecord, searchMap);
		
		// 정렬 쿼리
		List<ReviewDTO> rList = rdao.getNumList(pdto.getStartNo(), pdto.getEndNo(), searchMap);
		System.out.println("rlist>>>" + rList);
		System.out.println("pdto>>>" + pdto.getStartNo());

		// 페이지 이동 URL
		String pageUrl = request.getContextPath()+"/ficnic/ficnic_review.do?ficnic_no="+ficnic_no+"&getType="+getType;

    	FicnicDTO fdto = fdao.getFicnicCont(ficnic_no);
		int count = fdao.countAll(ficnic_no);
		int rcount = fdao.countReviewPoint(ficnic_no);
     
	    
        model.addAttribute("fdto", fdto);
        model.addAttribute("rList", rList);
		model.addAttribute("count", count);
		model.addAttribute("rcount", rcount);
		
		model.addAttribute("paging", pdto);
		model.addAttribute("page", page);
		model.addAttribute("getType", getType);
		model.addAttribute("pagingWrite",Paging.showPage(pdto.getAllPage(), pdto.getStartBlock(), pdto.getEndBlock(), pdto.getPage(), pageUrl));
		
        return "site/ficnic/ficnic_review";
        
    }



    // =====================================================================================
    // 피크닉 내용 보기 - 1:1 문의 작성 페이지
    // =====================================================================================
    @RequestMapping("ficnic/ficnic_qna.do")
    public String ficnic_qna(@RequestParam(value = "ficnic_no", required = false, defaultValue = "") int ficnic_no, Model model) {
    	FicnicDTO fdto = this.fdao.getFicnicCont(ficnic_no);
    	

    	model.addAttribute("fdto", fdto);
        return "site/ficnic/ficnic_qna_write";
    }


    // =====================================================================================
    // 1:1 문의 추가하기
    // =====================================================================================
    @RequestMapping("ficnic/mypage_qna_writeOk.do")
    public void qna_writeOk(HttpServletResponse response, MultipartHttpServletRequest mRequest, QnaDTO dto, HttpServletRequest request, HttpSession session) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        session = request.getSession();
        
        String id = (String) session.getAttribute("sess_id");
        String pw = (String) session.getAttribute("sess_pw");
        String name = (String) session.getAttribute("sess_name");
        
        dto.setMember_id(id);
    	dto.setQna_pw(pw);
    	dto.setQna_name(name);
        
        // 파일저장 이름 >> thisFolder/saveName_일련번호_밀리세컨드.확장자
        List<String> upload_list = UploadFile.fileUpload(mRequest, qnaFolder, qnaSaveName);        
        for(int i=0; i<upload_list.size(); i++){
            switch (i) {
                case 0:
                    dto.setQna_file1(upload_list.get(0));
                    break;
                case 1:
                	dto.setQna_file2(upload_list.get(1));
                    break;
                default:
                    break;
            }
        }

        // 문의글 등록
        int check = this.qdao.qnaWriteOk(dto);

        if(check > 0){
            out.println("<script>alert('1:1문의글이 정상적으로 등록되었습니다.'); location.href='ficnic_view.do?ficnic_no="+dto.getFicnic_no()+"';</script>");
        }else{
            out.println("<script>alert('1:1문의글 등록 중 에러가 발생하였습니다.'); history.back();</script>");
        }
    	
    }
    // mcouponDTO 에서 쿠폰리스트를 가져와서 매칭을 시키는데
    // 권한 설정을 어떻게 해주는가 
    // 1. 있는 쿠폰에 대한 리스트를 따로 set해주고
    // 2. 해당 쿠폰 리스트 객체를 복수개다
    // 복수개의 map을 어떻게 사용하는가 
    // List<String,List<String,Object>> map  = new HashMap<String,Object>();
    //
    public List<Map<String , Object>> getCouponLevel(List<McouponDTO> mList){
    	
    	 List<Map<String , Object>> list = new ArrayList<Map<String,Object>>();
    	
    	
		/* 이용될 권한들 기본 설정값 */
    	String COUPON_USE_TYPE = "cart"; // 쿠폰 사용구분 (cart/category/goods)
    	String COUPON_USE_VALUE = "";  // 쿠폰 사용 구분 값
    	String COUPON_PRICE_TYPE = "price"; // 할인 금액 구분 (price/percent)
    	int COUPON_PRICE_OVER = 0; // 최소 사용 금액
    	int COUPON_PRICE_MAX = 0; // 최대 할인 금액
    	String COUPON_DATE_TYPE = "free"; // 사용 기간 구분 (free/after/date)
    	int COUPON_DATE_VALUE = 0; // 사용 기간 구분 값
    	String COUPON_START_DATE = ""; // 사용 기간 시작
    	String COUPON_END_DATE = ""; // 사용 기간 끝
    	
    	// 보유한 쿠폰 개만큼
    	for(McouponDTO mcouponDTO : mList) {
    		
    		List<CouponDTO> clist = mcouponDTO.getCoupon_list();
    		
    	// 보유한 쿠폰의 권한 설정
    		for(CouponDTO val : clist) {
    			
    			if(mcouponDTO.getCoupon_no() == val.getCoupon_no()) {
    				
    				Map<String, Object> submap = new HashMap<String, Object>();
    				COUPON_USE_TYPE = val.getCoupon_use_type();
    				COUPON_USE_VALUE = val.getCoupon_use_value();
    		    	COUPON_PRICE_TYPE = val.getCoupon_price_type();
    		    	COUPON_PRICE_OVER = val.getCoupon_price_over();
    		    	COUPON_PRICE_MAX = val.getCoupon_price_max();
    		    	COUPON_DATE_TYPE = val.getCoupon_date_type();
    		    	COUPON_DATE_VALUE = val.getCoupon_date_value();
    		    	COUPON_START_DATE = val.getCoupon_start_date();
    		    	COUPON_END_DATE = val.getCoupon_end_date();
    		    	
    		    	submap.put("use_type", COUPON_USE_TYPE);
    		    	submap.put("use_value", COUPON_USE_VALUE);
    		    	submap.put("price_type", COUPON_PRICE_TYPE);
    		    	submap.put("price_over", COUPON_PRICE_OVER);
    		    	submap.put("price_max", COUPON_PRICE_MAX);
    		    	submap.put("date_type", COUPON_DATE_TYPE);
    		    	submap.put("date_value", COUPON_DATE_VALUE);
    		    	submap.put("start_date", COUPON_START_DATE);
    		    	submap.put("end_date", COUPON_END_DATE);
    		    	
    		    	list.add(submap);
    			}
    		}
    	}
    	return list;
    }
    
    @RequestMapping("ficnic/reserv_form.do")
    public String pay(
    		@RequestParam(value = "ficnic_no") int ficnic_no,
    		ReservDTO dto,
    		HttpServletRequest request,
    		HttpSession session,
    		Model model) throws ParseException {
    	
    	FicnicDTO fdto= this.fdao.getFicnicCont(ficnic_no);
    	
    	//기간 지난 회원 쿠폰 제거 
    	
    	List<McouponDTO> list =  mdao.getCouponView((String)session.getAttribute("sess_id"));
    	
    	// 현재 날짜/시간
        Date now = new Date();
 		
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        
       
        
    	for(McouponDTO val : list) {
    		
    		Map<String, Object> map = new HashMap<String, Object>();
    		
    		if(val.getMcoupon_start_date()!=null && now.compareTo(format.parse(val.getMcoupon_end_date())) > 0) {
    			map.put("sess_id",(String)session.getAttribute("sess_id"));
    			map.put("coupon_no",val.getCoupon_no());
    			mdao.deleteMemberCoupon(map);
    		}
    	}
    	
    	
    	// 회원 쿠폰 보유 여부
    	List<McouponDTO> mlist= mdao.getCouponView((String)session.getAttribute("sess_id"));
    	
    	MemberDTO memdto= memberDAO.getReservMember((String)session.getAttribute("sess_id"));
    	
    	
    	model.addAttribute("fdto", fdto);
    	model.addAttribute("dto", dto);
    	model.addAttribute("memdto", memdto);
    	model.addAttribute("mlist", mlist);
    	model.addAttribute("couponCount", mlist.size());
    	model.addAttribute("couponlevelList", getCouponLevel(mlist));
    	
    	return "site/reserv/reserv_form";
    }
    
    @RequestMapping("ficnic/ficnicCouponSelect.do")
    @ResponseBody
    public Map<String, Object> ficnicCouponSelect(
    		@RequestParam("coupon_no") int coupon_no
    		) throws IOException{

    	CouponDTO dto=this.couponDAO.couponView(coupon_no);
    	
    	
    	Map<String, Object> map = new HashMap<String,Object>(); 
    	
    	map.put("price_type", dto.getCoupon_price_type());
    	map.put("price_over", dto.getCoupon_price_over());
    	map.put("price_max", dto.getCoupon_price_max());
    	map.put("date_type", dto.getCoupon_date_type());
    	map.put("date_value", dto.getCoupon_date_value());
    	map.put("start_date", dto.getCoupon_start_date());
    	map.put("end_date", dto.getCoupon_end_date());
    	map.put("coupon_date", dto.getCoupon_date());
    	map.put("coupon_price", dto.getCoupon_price());
    	
    	return map;
    }
    
    
    
    
    @RequestMapping("ficnic/reserv_form_ok.do")
    public void reserv_form_ok(
    		@RequestParam( value = "canUsePoint", required = false, defaultValue = "0") int canUsePoint,
    		ReservDTO rDto ,
    		HttpServletRequest request,
    		HttpServletResponse response,
    		HttpSession session) throws IOException {
    	response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        int cnt = 0;
        boolean isNotHost=false;
        
        if(rDto.getReserv_total_price() == 0) isNotHost=true;
        
        
        
        // 중복체크 해당 상품 정보 불러오기
        
    	FicnicDTO fdto= this.fdao.getFicnicCont(Integer.parseInt(request.getParameter("ficnic_no")));
    	
    	
		
    	if(fdto.getFicnic_sale_price() != Integer.parseInt(request.getParameter("reserv_ficnic_sale_price"))) isNotHost =true;
    	
    	cnt = 0;
    	if(request.getParameter("reserv_ficnic_option_title") !=null && !request.getParameter("reserv_ficnic_option_title").equals("")) {
	    	for(String title : fdto.getFicnic_option_title().split("★")) {
	    		int price =Integer.parseInt(fdto.getFicnic_option_price().split("★")[cnt++]);
	    		if(title.equals(request.getParameter("reserv_ficnic_option_title"))) {
	    			if(price != Integer.parseInt(request.getParameter("reserv_ficnic_option_price"))) isNotHost =true;
	    		}
	    	}
    	}
    	
    	cnt=0;
    	if(request.getParameter("reserv_ficnic_select_title") !=null && !request.getParameter("reserv_ficnic_select_title").equals("")) {
	    	for(String title : fdto.getFicnic_select_title().split("★")) {
	    		int price =Integer.parseInt(fdto.getFicnic_select_price().split("★")[cnt++]);
	    		if(title.equals(request.getParameter("reserv_ficnic_select_title"))) {
	    			if(price != Integer.parseInt(request.getParameter("reserv_ficnic_select_price"))) isNotHost =true;
	    		}
	    	}
    	}
    	
    	
    	if(isNotHost) {
    		out.println("<script>alert('잘못된 접근을 하셨습니다.');history.back();</script>");
    	}else {
    	
        String checkSess = checkSess();
        rDto.setReserv_sess(checkSess);
        
        
        if(reservDAO.insertReserv(rDto)>0) {
           
        	// 사용한 쿠폰 제거
        	String selectCoupon = request.getParameter("select_coupon");
            if(selectCoupon!=null && !selectCoupon.equals("") ) {
            	Map<String, Object> couponMap = new HashMap<String, Object>();
                couponMap.put("coupon_no", Integer.parseInt(request.getParameter("select_coupon")));
                couponMap.put("sess_id", (String) session.getAttribute("sess_id")); 
                
                
                 
                //쿠폰 제거후 McouponNum 정렬
                McouponDTO mdto =  this.mdao.getCouponNum(couponMap);
                
                this.mdao.deleteMemberCoupon(couponMap);
                this.mdao.updateMcouponNo(mdto.getMcoupon_no());
            }
            // 사용한 마일리지 제거
            if(canUsePoint!=0) {
            	
                Map<String, Object> pointMap = new HashMap<String, Object>();
                pointMap.put("member_id", (String) session.getAttribute("sess_id"));
                pointMap.put("reserv_sess", rDto.getReserv_sess());
                pointMap.put("point_add", canUsePoint);
                
                pointDAO.MinusPoint(pointMap);
                
                memberDAO.updatePoint(pointMap);
            }
            
            out.println("<script>alert('예약 완료');location.href='"+request.getContextPath()+"/mypage/mypage_reserv_list.do';</script>");
        
	        }else {
	        	out.println("<script>alert('예약 실패');history.back();</script>");
	        }
	    }
    }

    
    public String checkSess() {
    	
    	boolean isTrue=false;  	
        
    	String sub="";
        
        // reservSess 재귀함수처리 
    	for(int i=0; i<6; i++) {
        	sub+= (int)(Math.random()*10)+1;
        }
    	
    	// 오늘 날짜 넘기
        LocalDate getDate = LocalDate.now();
        String todayDate = getDate.format(DateTimeFormatter.ofPattern("yyMMdd"));
    

        sub = todayDate+"-"+sub;
        
        List<ReservDTO> list =  reservDAO.getReservList(sub);
        
        for(ReservDTO val : list) {
        	if(sub.equals(val.getReserv_sess())){  		
        		isTrue=true;
        	}      	
        }
       if(isTrue) {
    	   return checkSess();
       }else {
    	   return sub;
       }
        
    }






    // =====================================================================================
    // 쿠폰 다운로드
    // =====================================================================================
    @RequestMapping("ficnic/download_coupon.do")
    public void download_coupon(
            HttpServletResponse response,
            @RequestParam(value = "coupon_no") int coupon_no,
            @RequestParam(value = "sess_id") String sess_id) throws IOException {
        String result = "error";

        // 쿠폰 정보
        CouponDTO dto = couponDAO.couponView(coupon_no);


        // 쿠폰을 이미 가지고 있는지 체크
        int chkCouponHas = mcouponDAO.chkCouponHas(coupon_no, sess_id);

        // 쿠폰 발급 갯수가 남아있는지 체크
        int chkCouponCnt = dto.getCoupon_max_ea() - dto.getCoupon_down_ea();


        // 쿠폰 발급 처리
        if(chkCouponHas > 0) {
            result = "has";

        }else if(chkCouponCnt <= 0) {
            result = "max";

        }else{
            String mcoupon_start_date = "";
            String mcoupon_end_date = "";

            if(dto.getCoupon_date_type().equals("date")) {
                mcoupon_start_date = dto.getCoupon_start_date();
                mcoupon_end_date = dto.getCoupon_end_date();

            }else if(dto.getCoupon_date_type().equals("after")) {
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                SimpleDateFormat stringFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

                Date set_coupon_start_date = new Date();
                LocalDate startNowDate = LocalDate.now();
                String startDay = startNowDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));        
                try {
                    set_coupon_start_date = dateFormat.parse(startDay + " 00:00:00");
                    mcoupon_start_date = stringFormat.format(set_coupon_start_date);
                } catch (ParseException e) {
                    e.printStackTrace();
                }

                Date set_coupon_end_date = new Date();
                LocalDate endNowDate = LocalDate.now().plusDays((long)dto.getCoupon_date_value());
                String endDay = endNowDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                try {
                    set_coupon_end_date = dateFormat.parse(endDay + " 23:59:59");
                    mcoupon_end_date = stringFormat.format(set_coupon_end_date);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }


            Map<String, Object> map = new HashMap<String, Object>();
            map.put("coupon_no", coupon_no);
            map.put("member_id", sess_id);
            map.put("mcoupon_start_date", mcoupon_start_date);
            map.put("mcoupon_end_date", mcoupon_end_date);

            if(mcouponDAO.setAddCoupon(map) > 0) {
                mcouponDAO.updateAddCoupon(coupon_no);
                result = "ok";
            }else{
                result = "error";
            }
        }


        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.print(result);
    }



}