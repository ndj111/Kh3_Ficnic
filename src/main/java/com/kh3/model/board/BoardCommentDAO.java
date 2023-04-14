package com.kh3.model.board;

import java.util.List;
import java.util.Map;

public interface BoardCommentDAO {


	List<BoardCommentDTO> getBoardCommList(Map<String, Object> map);
	
	int deleteBoardComm(Map<String, Object> map);

	int insertBoardComm(Map<String, Object> map);

	void updateCommentCount(Map<String, Object> map);

	void deleteBoardCommList(Map<String, Object> map);

	void updateCommentNum(Map<String, Object> map);

	BoardCommentDTO getNowComent(String bbs_id, int bdata_no, String bcomm_name);

    BoardCommentDTO getThisComent(String bbs_id, int bdata_no, int bcomm_no);
}
