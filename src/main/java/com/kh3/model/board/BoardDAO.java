package com.kh3.model.board;

import java.util.List;

public interface BoardDAO {

	List<BoardDTO> getBoardList(String bbs_id);
	

	int getListCount(String field,String keyword,String bbs_id);
	
	List<BoardDTO> getBoardList(int startNo, int endNo, String field, String keyword,String bbs_id);
}
