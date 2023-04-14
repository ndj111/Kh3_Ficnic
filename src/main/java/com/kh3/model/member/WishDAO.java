package com.kh3.model.member;

import java.util.List;
import java.util.Map;

public interface WishDAO {

    // 위시리스트 목록
	List<WishDTO> getMemberWishList(String attribute);

    // 위시리스트 체크
	int getFicnicInWish(int ficnic_no, String sess_id);

    // 위시리스트 등록
    int wishAdd(Map<String, Object> map);

    // 위시리스트 삭제
    int wishDel(Map<String, Object> map);


    // 위시리스트 삭제
    int wishCancel(Map<String, Object> map);
    
    // 피크닉 삭제시 위시리스트 삭제
	void wishDelete(int no);
}
