package com.kh3.model.member;

import java.util.List;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAOImpl implements MemberDAO {

    @Inject
    private SqlSessionTemplate sqlSession;
    
    // 회원 전체 리스트 가져오기
	@Override
	public List<MemberDTO> getMemberList() {

		return this.sqlSession.selectList("adminMemberList"); 
	}
	

	// 회원 상세내역 리스트 가져오기
	@Override
	public MemberDTO getMemberView(int no) {
	
		return this.sqlSession.selectOne("adminMemberView", no);
	}
	
	// 회원 아이디 중복 체크
	@Override
	public int checkId(MemberDTO dto) {
		
		return this.sqlSession.selectOne("checkId", dto);
	}

	// 회원 등록하기
	@Override
	public int writeOkMember(MemberDTO dto) {
		
		return this.sqlSession.insert("adminMemberwriteOk", dto);
	}

	// 회원 삭제
	@Override
	public int deleteMember(int no) {
		
		return this.sqlSession.delete("adminMemberdelete", no);
	}

	// 회원 삭제 후 글번호 재작업
	@Override
	public void updateSequence(int no) {
		
		this.sqlSession.update("adminMemberSequence", no);
	}

	// 회원 정보 수정
	@Override
	public int modifyOk(MemberDTO dto, String member_pw) {
		
		return 0;
	}


   






}