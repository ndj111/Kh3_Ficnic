package com.kh3.model.ficnic;

import java.util.List;

import lombok.Data;

@Data
public class CategoryDTO {

    private int category_no;
    private String category_show;
    private String category_id;
    private int category_depth;
    private String category_id_up;
    private int category_rank;
    private String category_name;
    private String category_image;
    private List<CategoryDTO> sub_category;
    private String category_path;

}
