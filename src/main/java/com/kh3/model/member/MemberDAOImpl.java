package com.kh3.model.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;


@Repository
public class MemberDAOImpl implements MemberDAO {

    @Inject
    private SqlSessionTemplate sqlSession;


    @Override
    public int getMemberCount(Map<String, Object> searchMap) {
        return this.sqlSession.selectOne("adminMemberTotalCount", searchMap);
    }

    // 회원 전체 리스트 가져오기
    @Override
    public List<MemberDTO> getMemberList(int startNo, int endNo, Map<String, Object> searchMap) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("startNo", startNo);
        map.put("endNo", endNo);
        map.put("search_type", searchMap.get("search_type"));
        map.put("search_name", searchMap.get("search_name"));
        map.put("search_id", searchMap.get("search_id"));
        map.put("search_email", searchMap.get("search_email"));
        map.put("search_phone", searchMap.get("search_phone"));

        return this.sqlSession.selectList("adminMemberList", map);
    }



    // 회원 상세내역 리스트 가져오기
    @Override
    public MemberDTO getMemberView(int no) {
        return this.sqlSession.selectOne("adminMemberCont", no);
    }



    // 회원 아이디 중복 체크
    @Override
    public int checkId(String userId) {
        return this.sqlSession.selectOne("checkId", userId);
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
    public int modifyOk(MemberDTO dto) {
        return this.sqlSession.update("adminMemberModifyOk", dto);
    }
    
    // 마이페이지 회원 정보 수정
    @Override
    public int sitemodifyOk(MemberDTO dto) {
    	return this.sqlSession.update("siteMemberModifyOk", dto);
    }


    // 로그인 체크
	@Override
	public int loginCheck(MemberDTO dto) {
		return this.sqlSession.selectOne("siteMemberLogin", dto);
	}
	
	// 비밀번호 체크
	@Override
	public int pwCheck(MemberDTO dto) {
		return this.sqlSession.selectOne("siteMemberLoginPw", dto);
	}

	// 찾기 시 모든 조건 체크
	@Override
	public int findIdAll(MemberDTO dto) {
		return this.sqlSession.selectOne("siteMemberFindIdAll", dto);
	}

	
	// 찾기 시 이메일 먼저 체크
	@Override
	public int findIdEmail(MemberDTO dto) { 
		return this.sqlSession.selectOne("siteMemberFindIdEmail", dto);
	}

	// 결과 창 출력할 아이디
	@Override
	public String findId(MemberDTO dto) {
		return this.sqlSession.selectOne("siteMemberFindIdEnd", dto);
	}

	// 비밀번호 전부 검색
	@Override
	public int findPwAll(MemberDTO dto) {
		return this.sqlSession.selectOne("siteMemberFindPwAll", dto);
	}

	// 결과창 출력할 비밀번호
	@Override
	public String findPw(MemberDTO dto) {
		return this.sqlSession.selectOne("siteMemberFindPwEnd", dto);
	}

	@Override
	public int joinMember(MemberDTO dto) {
		return this.sqlSession.insert("siteMemberJoin", dto);
	}


	@Override
	public int checkEmail(String userEmail) {
        return this.sqlSession.selectOne("checkEmail", userEmail);
	}

	
	@Override
	public MemberDTO loginSession(String id) {
		return this.sqlSession.selectOne("loginSession", id);
	}

    // 예약 상세내역 회원정보 
	@Override
	public MemberDTO getReservMember(String member_id) {
        return this.sqlSession.selectOne("adminReservMember", member_id);
	}

	// 비번 업데이트
	@Override
	public int updatePw(MemberDTO dto) {
		return this.sqlSession.update("siteMemberUpdatePw", dto);
	}


	@Override
	public int pwLength(MemberDTO dto) {
		return this.sqlSession.selectOne("siteMemberPwLength", dto);
	}


	@Override
	public int secession(MemberDTO dto) {
		return this.sqlSession.update("siteMemberSecession", dto);
	}

	@Override
	public void updatePoint(Map<String, Object> pointMap) {
		this.sqlSession.update("SiteMemberUpdatePointMinus",pointMap);
		
	}



	// 관리자 상단 최근 3일간 회원가입 내역 가져오기
	@Override
    public List<MemberDTO> getRecentMemberList(String chk_date) {
	    return this.sqlSession.selectList("adminRecentMemberList", chk_date);
	}

	@Override
	public void updatePlusPoint(Map<String, Object> map) {
		this.sqlSession.update("reviewMileageUpdate", map);
		
	}
	

}