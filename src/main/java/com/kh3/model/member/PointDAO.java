package com.kh3.model.member;

import java.util.List;
import java.util.Map;

public interface PointDAO {
	
	// 회원 가입 포인트 적립
	void joinPoint(PointDTO pdto);
	
	// 관리자 적립금 수정
	void modifyPoint(PointDTO pdto);
	
	// 회원 적립금 내역보여주기
	List<PointDTO> getPointView(String id);

	// 사용한 적립금 등록하기
	void MinusPoint(Map<String, Object> pointMap);

	// 리뷰 작성시 적립금 등록
	void plusPoint(Map<String, Object> map);
	

}
