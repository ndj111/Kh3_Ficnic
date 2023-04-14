package com.kh3.model.ficnic;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;


@Repository
public class FicnicDAOImpl implements FicnicDAO {

    @Inject
    private SqlSessionTemplate sqlSession;


    /* 피크닉 상품 리스트 출력 */
    @Override
    public List<FicnicDTO> getFicnicList() {
        return this.sqlSession.selectList("adminFicnicList");
    }



    /* 피크닉 상품 등록 */
    @Override
    public int writeFicnic(FicnicDTO dto) {
        return this.sqlSession.insert("adminFicnicWrite", dto);
    }


	/* 사용자 해당 카테고리 피크닉 정보 찾기 */
	@Override
	public List<FicnicDTO> getSiteFicnicList(int startNo, int endNo, Map<String, Object> map) {
		map.put("startNo", startNo);
		map.put("endNo", endNo);

		return this.sqlSession.selectList("SiteFicnicCategoryList", map);
	}


	@Override
	public int getSiteListCount(Map<String, Object> map) {
		return this.sqlSession.selectOne("SiteFicnicSearchCount", map);
	}


	/* 피크닉 상품 정보 */
    @Override
    public FicnicDTO getFicnicCont(int no) {
        return this.sqlSession.selectOne("adminFicnicCont", no);
    }




    /* 피크닉 상품 수정 */
    @Override
    public int modifyFicnic(FicnicDTO dto) {
        return this.sqlSession.update("adminFicnicModify", dto);
    }



    /* 피크닉 상품 삭제 */
    @Override
    public int deleteFicnic(int no) {
        return this.sqlSession.delete("adminFicnicDelete", no);
    }



    /* 피크닉 사진 삭제 */
    public void deleteFicnicImage(int no, int img_no) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("no", no);
        map.put("img_no", img_no);
        this.sqlSession.update("adminDeleteFicnicImage", map);
    }



    /* 피크닉 상품 검색 개수 */
    @Override
    public int getListCount(Map<String, Object> map) {
        return this.sqlSession.selectOne("adminFicnicSearchCount", map);
    }



    /* 피크닉 검색 리스트 */
    @Override
    public List<FicnicDTO> getFicnicList(int startNo, int endNo, Map<String, Object> map) {
        map.put("startNo", startNo);
        map.put("endNo", endNo);
        return this.sqlSession.selectList("adminFicnicSearchList", map);
    }




    /* 쿠폰 상세 내역에서 상품 정보 찾기 */
    @Override
    public String checkFicnic(String coupon_use_value) {
        return this.sqlSession.selectOne("admincheckFicnic", coupon_use_value);
    }



    /* 리뷰 수정시 총점 수정 */
    public void updateReviewPoint(int ficnic_no) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("ficnic_no", ficnic_no);
        this.sqlSession.update("adminFIcnicUpdateReview", map);
    }




    /* 피크닉 지정 검색 리스트 (임시) */
    @Override
    public List<FicnicDTO> getFicnicPopList(String search_keyword) {
        return this.sqlSession.selectList("adminFicnicPopSearchList", search_keyword);
    }


    /* 리뷰 등록시 갯수 추가 수정 */
	@Override
	public void updateReviewCont(int ficnic_no) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("ficnic_no", ficnic_no);
        this.sqlSession.update("adminFicnicUpdateReviewCont", map);
	}


	@Override
	public int countReviewPoint(int ficnic_no) {
		return this.sqlSession.selectOne("siteFicnicPointCount", ficnic_no);
	}
	
	

	@Override
	public int countAll(int ficnic_no) {
		 return this.sqlSession.selectOne("siteFicnicCount", ficnic_no);
	}
	

    /* 피크닉 조회수 늘리기 */
    public void updateFicnicHit(int ficnic_no) {
        this.sqlSession.update("siteFicnicUpdateHit", ficnic_no);
    }

}