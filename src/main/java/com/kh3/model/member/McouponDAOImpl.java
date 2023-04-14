package com.kh3.model.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class McouponDAOImpl implements McouponDAO {

    @Inject
    private SqlSessionTemplate sqlSession;
    
    // 회원 쿠폰내역 보여주기
	@Override
	public List<McouponDTO> getCouponView(String id) {
		return this.sqlSession.selectList("siteMcouponList", id);
	}

	// 사용한 회원 쿠폰 삭제하기
	@Override
	public void deleteMemberCoupon(Map<String, Object> couponMap) {
		this.sqlSession.delete("siteMemberCouponDelete", couponMap);
	}

	@Override
	public McouponDTO getCouponNum(Map<String, Object> couponMap) {
		return this.sqlSession.selectOne("siteMemberCouponNum", couponMap);
	}

	@Override
	public void updateMcouponNo(int coupon_no) {
		this.sqlSession.update("siteMCouponNumUpdate", coupon_no);
	}

	@Override
	public void mCouponDelete(int coupon_no) {
		this.sqlSession.delete("adminMCouponDelete", coupon_no);
	}




    /* 쿠폰을 이미 가지고 있는지 체크 */
    public int chkCouponHas(int coupon_no, String sess_id) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("coupon_no",coupon_no);
        map.put("sess_id", sess_id);

        return this.sqlSession.selectOne("siteCheckCouponHas", map);
    }


    /* 쿠폰 발급하기 */
    public int setAddCoupon(Map<String, Object> map) {
        return this.sqlSession.insert("siteAddCoupon", map);
    }


    /* 쿠폰 발급 후 다운로드 횟수 증가 */
    public void updateAddCoupon(int coupon_no) {
        this.sqlSession.update("siteUpdateAddCoupon", coupon_no);
    }
}