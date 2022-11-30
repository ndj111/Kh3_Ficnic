package com.kh3.model.member;

import java.util.List;


public interface MemberDAO {
	
	// 회원 전체 리스트
	List<MemberDTO> getMemberList();
	
	// 회원 상세 내역
	MemberDTO getMemberView(int no);
	
	// 회원 아이디 중복 체크
	int checkId(MemberDTO dto);

	// 회원 추가
	int writeOkMember(MemberDTO dto);
	
	// 회원 삭제
	int deleteMember(int no);
	
	// 회원 삭제 후 글번호 재작업
	void updateSequence(int no);
	
	// 회원 정보 수정
	int modifyOk(MemberDTO dto, String member_pw);
	

	
	
	
	
}
