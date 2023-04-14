package com.kh3.model.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class BoardConfDAOImpl implements BoardConfDAO {

    @Inject
    private SqlSessionTemplate sqlSession;



    @Override
    public int getBoardConfCount(String keyword) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("keyword", keyword);

        return this.sqlSession.selectOne("adminBoardConfTotal", map);
    }


    @Override
    public List<BoardConfDTO> getConfBoardList(int startNo, int endNo, String keyword) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("startNo", startNo);
        map.put("endNo", endNo);
        map.put("keyword", keyword);

        return this.sqlSession.selectList("adminBoardConfList", map);
    }


    @Override
    public int writeBoard(BoardConfDTO dto) {
        sqlSession.insert("adminBoardConfCategory", dto);
        sqlSession.insert("adminBoardConfComment", dto);
        sqlSession.insert("adminBoardConfData", dto);

        return sqlSession.insert("adminBoardConfWrite", dto);
    }


    @Override
    public int checkBoardId(String board_id) {
        return sqlSession.selectOne("adminBoardCheckId", board_id);
    }


    @Override
    public BoardConfDTO getCont(int board_no) {
        return sqlSession.selectOne("adminBoardConfCon", board_no);
    }



    @Override
    public int updateBoard(BoardConfDTO dto) {
        return sqlSession.update("adminBoardUpdate", dto);
    }



    @Override
    public int deleteBoard(int board_no) {
        BoardConfDTO dto = sqlSession.selectOne("adminBoardConfCon", board_no);

        sqlSession.update("adminBoardConfdelCategory", dto);
        sqlSession.update("adminBoardConfdelComment", dto);
        sqlSession.update("adminBoardConfdelData", dto);

        return sqlSession.delete("adminBoardConfdel", board_no);
    }




	@Override
	public BoardConfDTO getBoardConfCont(String bbs_id) {
		
		return sqlSession.selectOne("BoardConfCont", bbs_id);
	}

}