package com.kh3.model.qna;

import java.util.List;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository

public class QnaCommentDAOImpl implements QnaCommentDAO {
    @Inject
    private SqlSessionTemplate sqlSession;


    @Override
    public List<QnaCommentDTO> getQnaCommentList(int no) {
        return this.sqlSession.selectList("adminQnaCommentList", no);
    }


    @Override
    public int qnaReply(QnaCommentDTO dto) {
        int check = this.sqlSession.insert("adminQnaCommentReply", dto);
        if(check > 0) {
            return this.sqlSession.selectOne("adminQnaCommentReplyNow", dto);
        }else{
            return check;
        }
    }


    @Override
    public int qnaCommentDelete(int no) {
        return this.sqlSession.delete("adminQnaCommentDelete", no);
    }


    @Override
    public int qnaCommentAllDelete(int qna_no) {
        return this.sqlSession.delete("adminQnaCommentAllDelete", qna_no);
    }

}
