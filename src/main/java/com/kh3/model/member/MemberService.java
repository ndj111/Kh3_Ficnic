package com.kh3.model.member;

import javax.servlet.http.HttpSession;

public interface MemberService {

    public String loginSession(MemberDTO dto, HttpSession session);

    public void logout(HttpSession session);

}
