package com.kh3.model.qna;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;



@Repository
public class QnaDAOImpl implements QnaDAO {

    @Inject
    private SqlSessionTemplate sqlSession;


    @Override
    public int getQnaCount(Map<String, Object> searchMap) {
        return this.sqlSession.selectOne("adminQnaCount", searchMap);
    }


    @Override
    public List<QnaDTO> getQnaList(int startNo, int endNo, Map<String, Object> searchMap) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("startNo", startNo);
        map.put("endNo", endNo);
        map.put("search_ficnic", searchMap.get("search_ficnic"));
        map.put("search_qna", searchMap.get("search_qna"));
        map.put("search_writer", searchMap.get("search_writer"));

        return this.sqlSession.selectList("adminQnaList", map);
    }


    @Override
    public QnaDTO qnaView(int no) {
        return this.sqlSession.selectOne("adminQnaView", no);
    }


    @Override
    public int qnaDelete(int no) {
        return this.sqlSession.delete("adminQnaDelete", no);
    }

    // 마이페이지 문의글 리스트
	@Override
	public List<QnaDTO> siteQnaList(String member_id) {
		return this.sqlSession.selectList("siteQnaList", member_id);
	}

	// 마이페이지 문의글 수정
	@Override
	public int qnaModify(QnaDTO dto) {
        return this.sqlSession.update("siteQnaModifyOk", dto);
	}


	@Override
	public int qnaWriteOk(QnaDTO dto) {
        return this.sqlSession.insert("siteQnaWriteOk", dto);
	}


	/* 피크닉 사진 삭제 */
	@Override
	public void deleteQnaImage(int qna_no, int img_num) {
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("qna_no", qna_no);
	    map.put("img_num", img_num);
	    this.sqlSession.update("siteDeleteQnaImage", map);
	}



    // 관리자 상단 최근 3일 예약내역 가져오기
	@Override
    public List<QnaDTO> getRecentQnaList(String chk_date) {
        return this.sqlSession.selectList("adminRecentQnaList", chk_date);
    }

}