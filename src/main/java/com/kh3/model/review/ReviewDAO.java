package com.kh3.model.review;

import java.util.List;
import java.util.Map;



public interface ReviewDAO {

    int getReviewCount(Map<String, Object> map);

    List<ReviewDTO> getReviewList(int startNo, int endNo, Map<String, Object> map);

    ReviewDTO reviewView(int no);

    int reviewModify(ReviewDTO dto);

    int reviewDelete(int no);

    void updateSeq(int no);
    
    List<ReviewDTO> getList();

	int writeOkReview(ReviewDTO dto);
	
	// 해당 회원의 리뷰 리스트
	List<ReviewDTO> getListSession(String member_id);
    
    // 해당 세션 예약 카운트
	int getSiteReviewCount(Map<String, Object> searchMap);

	// 해당 세션 예약 카운트
	List<ReviewDTO> getNumList(int startNo, int endNo, Map<String, Object> searchMap);
	
	// 해당 세션 예약 카운트
	List<ReviewDTO> getNumList(Map<String, Object> searchMap);

	
}
