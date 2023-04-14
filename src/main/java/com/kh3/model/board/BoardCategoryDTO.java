package com.kh3.model.board;

import lombok.Data;

@Data
public class BoardCategoryDTO {
    private int bcate_no;
    private String bcate_name;
    private int bcate_rank;
    private int bcate_article;
    private String bcate_date;
}
