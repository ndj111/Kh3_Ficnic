package com.kh3.site.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh3.model.member.WishDAO;

@Controller
public class SiteWishController {

    @Inject
    private WishDAO wdao;



    // =====================================================================================
    // 찜 추가/삭제
    // =====================================================================================
    @RequestMapping("mypage/wish_ok.do")
    public void wishOk(
        HttpServletResponse response,
        @RequestParam(value = "wish_mode") String wish_mode,
        @RequestParam(value = "ficnic_no") int ficnic_no,
        @RequestParam(value = "sess_id") String sess_id) throws IOException {
        String result = "error";

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("ficnic_no", ficnic_no);
        map.put("sess_id", sess_id);

        if(wish_mode.equals("add")) {
            if(this.wdao.wishAdd(map) > 0) {
                result = "add_ok";
            }
        }else{
            if(this.wdao.wishDel(map) > 0) {
                result = "del_ok";
            }
        }

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.print(result);
    }




    // =====================================================================================
    // 찜 삭제하기
    // =====================================================================================
    @RequestMapping("mypage/wish_cancel.do")
    public void wishCancel(HttpSession session, HttpServletResponse response, @RequestParam(value = "ficnic_no") int ficnic_no) throws IOException {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("ficnic_no", ficnic_no);
        map.put("sess_id", (String) session.getAttribute("sess_id"));

        this.wdao.wishCancel(map);

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<script>location.href='mypage_wish_list.do';</script>");
    }

}
