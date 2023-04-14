package com.kh3.model.ficnic;

import java.util.List;

public interface CategoryDAO {

    List<CategoryDTO> getCategoryList();

    void setCategoryRank(String cateid, int rank);

    int addCategory(String ps_ctid, String category_show, String category_name, String category_image);

    int modifyCategory(String ps_ctid, String category_show, String category_name, String category_image);

    CategoryDTO getCategoryCont(String ps_ctid);

    int deleteCategory(String ps_ctid);

    void updateCategorySeq(int category_no);

    void updateCategoryFicnic(String ps_ctid);
    
    String checkCategory(String coupon_use_value);



    /////////////////////////////////////////////////////////////////////////////


    List<CategoryDTO> getSiteCategoryList();

    List<CategoryDTO> getSiteSubCategoryList(String category_no);

	List<String> getChildList(String ficnic_category_no);

	String getCategoryName(String ficnic_sub);

}
