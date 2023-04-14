package com.kh3.model.qna;

import java.util.List;
import java.util.Map;


public interface QnaDAO {

    int getQnaCount(Map<String, Object> map);

    List<QnaDTO> getQnaList(int startNo, int endNo, Map<String, Object> map);

    QnaDTO qnaView(int no);

    int qnaDelete(int no);
    
    // 마이페이지 문의글 리스트
	List<QnaDTO> siteQnaList(String id);
	
	// 문의글 수정
	int qnaModify(QnaDTO dto);
	
	// 문의글 추가
	int qnaWriteOk(QnaDTO dto);
	
	// 문의글 파일 삭제
	void deleteQnaImage(int qna_no, int img_num);


    // 관리자 상단 최근 3일 예약내역 가져오기
    List<QnaDTO> getRecentQnaList(String chk_date);
}