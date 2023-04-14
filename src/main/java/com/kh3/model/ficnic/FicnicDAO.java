package com.kh3.model.ficnic;

import java.util.List;
import java.util.Map;



public interface FicnicDAO {
    /* 피크닉 리스트 */
    List<FicnicDTO> getFicnicList();

    /* 피크닉 검색 리스트 */
    List<FicnicDTO> getFicnicList(int startNo, int endNo, Map<String, Object> map);

    /* 피크닉 작성 */
    int writeFicnic(FicnicDTO dto);

    /* 피크닉 정보 */
    FicnicDTO getFicnicCont(int no);

    /* 피크닉 수정 */
    int modifyFicnic(FicnicDTO dto);

    /* 피크닉 삭제 */
    int deleteFicnic(int no);

    /* 피크닉 사진 삭제 */
    void deleteFicnicImage(int no, int img_no);

    /* 피크닉 검색 상품 개수 */
    int getListCount(Map<String, Object> map);

    /* 쿠폰 상세 내역에서 상품 정보 찾기 */
    String checkFicnic(String string);

    /* 사용자 피크닉 리스트 */
 	List<FicnicDTO> getSiteFicnicList(int startNo, int endNo, Map<String, Object> map);

 	/* 사용자 피크닉 리스트 개수 */
	int getSiteListCount(Map<String, Object> map);

    /* 리뷰 수정시 총점 수정 */
    void updateReviewPoint(int ficnic_no);


    /* 피크닉 지정 검색 리스트 (임시) */
    public List<FicnicDTO> getFicnicPopList(String search_keyword);
    
    /* 리뷰 등록시 리뷰 갯수 수정 */
	void updateReviewCont(int ficnic_no);
   
    /* 리뷰 count */
	int countAll(int ficnic_no);
	
	/* 리뷰 평점 sum */
	int countReviewPoint(int ficnic_no);


    /* 피크닉 조회수 늘리기 */
    void updateFicnicHit(int ficnic_no);
}
