package com.kh3.model.board;

import java.util.List;

public interface BoardCategoryDAO {

    List<BoardCategoryDTO> getBoardCategoryList(String board_id);

    int boardCategoryWrite(String board_id, String bcate_name);

    int boardCategoryDelete(String board_id, int bcate_no);

    int boardCategorySeqUpdate(String board_id, int bcate_no);

    void boardCategoryModify(String board_id, String bcate_no, int bcate_rank, String bcate_name);

}
