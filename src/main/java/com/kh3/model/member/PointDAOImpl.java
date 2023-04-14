package com.kh3.model.member;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class PointDAOImpl implements PointDAO {

    @Inject
    private SqlSessionTemplate sqlSession;
    
    // 회원 가입 포인트 적립
	@Override
	public void joinPoint(PointDTO pdto) {
		
		this.sqlSession.insert("joinPoint", pdto);
	}
	
	// 관리자 적립금 수정
	@Override
	public void modifyPoint(PointDTO pdto) {
		
		this.sqlSession.insert("modifyPoint", pdto);
	}
	
	// 적립금 내역 보여주기
	@Override
	public List<PointDTO> getPointView(String id) {
		return this.sqlSession.selectList("pointView", id);
	}

	@Override
	public void MinusPoint(Map<String, Object> pointMap) {
		
		this.sqlSession.insert("MinusPoint", pointMap);
		
	}

	@Override
	public void plusPoint(Map<String, Object> map) {
		this.sqlSession.update("plusPoint", map);
	}




}