package com.kh3.model.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAOImpl implements BoardDAO {

    @Inject
    private SqlSessionTemplate sqlSession;

    /* 해당 게시판 리스트 */
	@Override
	public List<BoardDTO> getBoardList(String bbs_id) {
		return sqlSession.selectList("siteBoardList", bbs_id);	
	}

	/* 해당 게시판 테이블 개수 카운트 */
	@Override
	public int getListCount(String field, String keyword, String category ,String bbs_id) {
	    Map<String, Object> map = new HashMap<String, Object>();
        map.put("field", field);
        map.put("keyword", keyword);
        map.put("category", category);
        map.put("bbs_id", bbs_id);

	   return this.sqlSession.selectOne("SiteBoardTotal", map);
		
	}

	/* 해당 게시판 검색 리스트 */
	@Override
	public List<BoardDTO> getBoardList(int startNo, int endNo, Map<String, Object> map) {
		map.put("startNo", startNo);
		map.put("endNo", endNo);
	   
		return this.sqlSession.selectList("SiteBoardList", map);
	}
	/* 해당 게시판 > 게시글 작성 */
	@Override
	public int insertBoardCont(Map<String, Object> map) {
		return this.sqlSession.insert("SiteBoardInsert",map);
	}
	
	/* 해당 게시판 > 해당 게시글 조회수 증가 */
	@Override
	public void updateBoardHit(Map<String, Object> map) {
		
		this.sqlSession.update("SiteBoardUpdateHit", map);
	}
	
	/* 해당 게시판 > 해당 게시글 출력 */
	@Override
	public BoardDTO getBoardCont(Map<String, Object> map) {
		
		return sqlSession.selectOne("SiteBoardDto",map);
	}

	/* 해당 게시판 - > 해당 게시글 수정 작업 */
	@Override
	public int modifyBoard(Map<String, Object> map) {
		return this.sqlSession.update("SiteBoardUpdate", map);
	}

	/* 해당 게시판 삭제 */
	@Override
	public int deleteBoard(Map<String, Object> map) {
		return this.sqlSession.delete("SiteBoardDelete", map);
	}


	/* 해당 게시판의 최소 헤드넘버 구하기 */
    @Override
    public int getMinHeadnum(String bbs_id) {
        return this.sqlSession.selectOne("SiteBoardGetMinHeadnum", bbs_id);
    }

    /* 해당 게시판의 최소 헤드넘버 구하기 (공지글) */
    @Override
    public int getMinHeadnumNotice(String bbs_id) {
        return this.sqlSession.selectOne("SiteBoardGetMinHeadnumNotice", bbs_id);
    }


}