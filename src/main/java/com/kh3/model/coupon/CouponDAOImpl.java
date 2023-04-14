package com.kh3.model.coupon;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh3.model.ficnic.FicnicDTO;

@Repository
public class CouponDAOImpl implements CouponDAO {

    @Inject
    private SqlSessionTemplate sqlSession;


    // 쿠폰 목록 총 갯수
    @Override
    public int getCouponCount(Map<String, Object> searchMap) {
    	return this.sqlSession.selectOne("adminCouponCount", searchMap);    
    }


    // 쿠폰 목록
    @Override
    public List<CouponDTO> getCouponList(int startNo, int endNo, Map<String, Object> searchMap) {
    	Map<String, Object> map = new HashMap<String, Object>();
        map.put("startNo", startNo);
        map.put("endNo", endNo);
        map.put("search_type", searchMap.get("search_type"));
        map.put("search_name", searchMap.get("search_name"));

        return this.sqlSession.selectList("adminCouponList", map);
    }


    // 쿠폰 등록
    @Override
    public int couponWrite(CouponDTO dto) {
        return this.sqlSession.insert("adminCouponWriteOk", dto);
    }


    // 쿠폰 보기
    @Override
    public CouponDTO couponView(int no) {
        return this.sqlSession.selectOne("adminCouponView", no);
    }


    // 쿠폰 수정
    @Override
    public int couponModify(CouponDTO dto) {
        return this.sqlSession.update("adminCouponModifyOk", dto);
    }


    // 쿠폰 삭제
    @Override
    public int couponDelete(int no) {
        return this.sqlSession.delete("adminCoupondelete", no);
    }


    // 쿠폰 번호 재작업
    @Override
    public void updateSeq(int no) {
        this.sqlSession.update("adminCouponSequence", no);
    }




    /* 다운로드 가능한 쿠폰 정보 가져오기 */
    public CouponDTO getDownloadAbleCoupon(FicnicDTO fdto, String sess_id) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("fdto", fdto);
        map.put("sess_id", sess_id);

        return this.sqlSession.selectOne("siteDownloadAbleCoupon", map);
    }



}