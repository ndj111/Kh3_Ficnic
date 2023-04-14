package com.kh3.model.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class BoardCategoryDAOImpl implements BoardCategoryDAO {

    @Inject
    private SqlSessionTemplate sqlSession;



    // 게시판 카테고리 목록 가져오기
    @Override
    public List<BoardCategoryDTO> getBoardCategoryList(String board_id) {
        return this.sqlSession.selectList("adminBoardCategoryList", board_id);
    }


    // 게시판 카테고리 등록
    @Override
    public int boardCategoryWrite(String board_id, String bcate_name) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("board_id", board_id);
        map.put("bcate_name", bcate_name);

        return this.sqlSession.insert("adminBoardCategoryWrite", map);
    }


    // 게시판 카테고리 삭제
    @Override
    public int boardCategoryDelete(String board_id, int bcate_no) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("board_id", board_id);
        map.put("bcate_no", bcate_no);

        return this.sqlSession.delete("adminBoardCategoryDelete", map);
    }


    @Override
    public int boardCategorySeqUpdate(String board_id, int bcate_no) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("board_id", board_id);
        map.put("bcate_no", bcate_no);

        return this.sqlSession.update("adminBoardCategorySeqUpdate", map);
    }


    @Override
    public void boardCategoryModify(String board_id, String bcate_no, int bcate_rank, String bcate_name) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("board_id", board_id);
        map.put("bcate_no", bcate_no);
        map.put("bcate_rank", bcate_rank);
        map.put("bcate_name", bcate_name);

        this.sqlSession.update("adminBoardCategoryModify", map);
    }

}