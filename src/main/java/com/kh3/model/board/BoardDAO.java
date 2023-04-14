package com.kh3.model.board;

import java.util.List;
import java.util.Map;

public interface BoardDAO {

	// 해당 게시판 리스트 출력
	List<BoardDTO> getBoardList(String bbs_id);
	
	// 해당 게시판 검색 게시글 개수
	int getListCount(String field, String keyword, String category, String bbs_id);
	
	// 해당 게시판 검색 리스트 출력
	List<BoardDTO> getBoardList(int startNo, int endNo,Map<String, Object> map);

	// 해당 게시판 게시글 작성
	int insertBoardCont(Map<String, Object> map);

	// 해당 게시글 조회수 증가
	void updateBoardHit(Map<String, Object> map);

	// 해당 게시판의 해당 게시글 출력 
    BoardDTO getBoardCont(Map<String, Object> map);
    
    // 해당 게시판 수정
	int modifyBoard(Map<String, Object> map);

	// 해당 게시판 삭제
	int deleteBoard(Map<String, Object> map);

    // 해당 게시판의 최소 헤드넘버 구하기
    int getMinHeadnum(String bbs_id);

    // 해당 게시판의 최소 헤드넘버 구하기 (공지글)
    int getMinHeadnumNotice(String bbs_id);

}
