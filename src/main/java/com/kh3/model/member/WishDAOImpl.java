package com.kh3.model.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class WishDAOImpl implements WishDAO {

    @Inject
    private SqlSessionTemplate sqlSession;


    // 위시리스트 목록
    @Override
    public List<WishDTO> getMemberWishList(String attribute) {
        return this.sqlSession.selectList("siteWishList", attribute);
    }


    // 위시리스트 체크
    public int getFicnicInWish(int ficnic_no, String sess_id) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("ficnic_no", ficnic_no);
        map.put("sess_id", sess_id);

        return this.sqlSession.selectOne("siteWishCheck", map);
    }


    // 위시리스트 등록
    public int wishAdd(Map<String, Object> map) {
        return this.sqlSession.insert("siteWishAdd", map);
    }


    // 위시리스트 삭제
    public int wishDel(Map<String, Object> map) {
        return this.sqlSession.delete("siteWishDel", map);
    }



    // 위시리스트 삭제
    @Override
    public int wishCancel(Map<String, Object> map) {
        return this.sqlSession.delete("siteWishCancel", map);
    }

    // 피크닉 삭제시 위시리스트 삭제
	@Override
	public void wishDelete(int ficnic_no) {
        this.sqlSession.delete("adminWishDelete", ficnic_no);
	}
}
