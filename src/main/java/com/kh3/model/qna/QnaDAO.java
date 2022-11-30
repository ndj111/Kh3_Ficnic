package com.kh3.model.qna;

import java.util.List;


public interface QnaDAO {

	
	List<QnaDTO> getReviewList();

	QnaDTO reviewView(int no);

    int reviewModify(QnaDTO dto);

    int reviewDelete(int no);

    void updateSeq(int no);
    
}