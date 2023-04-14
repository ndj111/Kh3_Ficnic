package com.kh3.model.qna;

import java.util.List;

public interface QnaCommentDAO {

	
	int qnaReply (QnaCommentDTO dto);

    int qnaCommentDelete(int no);

    int qnaCommentAllDelete(int no);

	List<QnaCommentDTO> getQnaCommentList(int no);

    
}
