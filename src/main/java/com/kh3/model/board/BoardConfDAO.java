package com.kh3.model.board;

import java.util.List;

public interface BoardConfDAO {

    int getBoardConfCount(String keyword);

    List<BoardConfDTO> getConfBoardList(int startNo, int endNo, String keyword);

    int writeBoard(BoardConfDTO dto);

    BoardConfDTO getCont(int board_no);

    int updateBoard(BoardConfDTO dto);

    int deleteBoard(int board_no);

}
