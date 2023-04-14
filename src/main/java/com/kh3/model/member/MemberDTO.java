package com.kh3.model.member;

import javax.validation.constraints.AssertTrue;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;


import lombok.Data;

@Data
public class MemberDTO {

	private int member_no;
	private String member_type;
	private int member_point;
	private String member_joindate;
	
	
	@Size(min=6, message = "id")
    private String member_id;
    
    @Pattern(regexp = "(02|010)-\\d{3,4}-\\d{4}", message = "phone")
    private String member_phone;
    
    @Pattern(regexp = "(?=.*[0-9])(?=.*[a-z])(?=.*\\W)(?=\\S+$).{6,12}", message = "pw")
    private String member_pw;
    
    @Size(min=2, max=8, message = "name")
    private String member_name;
    
    @Pattern(regexp = "^[A-Za-z0-9_\\.\\-]+@[A-Za-z0-9\\-]+\\.[A-Za-z0-9\\-]+$", message = "email")
    private String member_email;
    
    // DB 아이디 중복 체크 변수
    @AssertTrue(message = "idchk_join")
    private boolean idchk_join;
    
    // DB 이메일 중복 체크 변수
    @AssertTrue(message = "mailchk_join")
    private boolean mailchk_join;
    
    // 비밀번호 확인 체크 변수
    @Pattern(regexp = "(?=.*[0-9])(?=.*[a-z])(?=.*\\W)(?=\\S+$).{6,12}", message = "pw_re")    
    private String member_pw_re;
    
}