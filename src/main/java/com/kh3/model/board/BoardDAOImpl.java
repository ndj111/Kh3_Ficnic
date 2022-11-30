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

	@Override
	public List<BoardDTO> getBoardList(String bbs_id) {
		return sqlSession.selectList("siteBoardList", bbs_id);	
	}

	@Override
	public int getListCount(String field, String keyword,String bbs_id) {
		 Map<String, Object> map = new HashMap<String, Object>();
	        map.put("field", field);
	        map.put("keyword", keyword);
	        map.put("bbs_id", bbs_id);

	   return this.sqlSession.selectOne("sitebbsTotal", map);
		
	}

	@Override
	public List<BoardDTO> getBoardList(int startNo, int endNo, String field, String keyword,String bbs_id) {
		 Map<String, Object> map = new HashMap<String, Object>();
	        map.put("startNo", startNo);
	        map.put("endNo", endNo);
	        map.put("field", field);
	        map.put("keyword", keyword);
	        map.put("bbs_id", bbs_id);

	        return this.sqlSession.selectList("sitebbsList", map);
	}





}