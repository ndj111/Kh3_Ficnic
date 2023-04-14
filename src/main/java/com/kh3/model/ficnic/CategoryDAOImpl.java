package com.kh3.model.ficnic;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class CategoryDAOImpl implements CategoryDAO {

    @Inject
    private SqlSessionTemplate sqlSession;



    // 카테고리 목록 (관리자)
    @Override
    public List<CategoryDTO> getCategoryList() {
        return this.sqlSession.selectList("adminCategoryList");
    }



    // 카테고리 정렬 순서 저장
    @Override
    public void setCategoryRank(String cateid, int rank) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("cateid", cateid);
        map.put("rank", rank);

        this.sqlSession.update("adminCategoryRank", map);
    }



    // 카테고리 추가
    @Override
    public int addCategory(String ps_ctid, String category_show, String category_name, String category_image) {
        int category_depth = 1;
        String category_id_up = "M";

        if(!ps_ctid.equals("00000000")) {
            category_depth = 2;
            category_id_up = ps_ctid;
        }

        int category_rank = this.sqlSession.selectOne("adminCategoryRankMax");

        // 카테고리 아이디 구하기
        Map<String, Object> getCateMap = new HashMap<String, Object>();
        getCateMap.put("ps_ctid", ps_ctid);
        getCateMap.put("category_depth", category_depth);

        int get_category_num = 1;
        if(this.sqlSession.selectOne("adminCategoryIdMax", getCateMap) != null) {
            get_category_num = this.sqlSession.selectOne("adminCategoryIdMax", getCateMap);
        }

        String set_cate_len = "";
        for(int i = (int)(Math.log10(get_category_num)+1); i<2; i++){
            set_cate_len += "0";
        }

        String category_id = "00000000";
        if(category_depth == 1) {
            category_id = set_cate_len + get_category_num + "000000";
        }else{
            category_id = ps_ctid.substring(0, 2) + set_cate_len + get_category_num + "0000";
        }


        CategoryDTO dto = new CategoryDTO();
        dto.setCategory_show(category_show);
        dto.setCategory_id(category_id);
        dto.setCategory_depth(category_depth);
        dto.setCategory_id_up(category_id_up);
        dto.setCategory_rank(category_rank);
        dto.setCategory_name(category_name);
        dto.setCategory_image(category_image);

        return this.sqlSession.insert("adminCategoryWrite", dto);
    }



    // 카테고리 수정
    @Override
    public int modifyCategory(String ps_ctid, String category_show, String category_name, String category_image) {
        CategoryDTO dto = new CategoryDTO();
        dto.setCategory_show(category_show);
        dto.setCategory_id(ps_ctid);
        dto.setCategory_name(category_name);
        dto.setCategory_image(category_image);

        return this.sqlSession.update("adminCategoryModify", dto);
    }



    // 카테고리 정보
    @Override
    public CategoryDTO getCategoryCont(String ps_ctid) {
        return this.sqlSession.selectOne("adminCategoryCont", ps_ctid);
    }



    // 카테고리 삭제
    @Override
    public int deleteCategory(String ps_ctid) {
        return this.sqlSession.delete("adminCategoryDelete", ps_ctid);
    }


    // 카테고리 번호 재지정
    @Override
    public void updateCategorySeq(int category_no) {
        this.sqlSession.update("adminCategorySeqUpdate", category_no);
    }


    // 카테고리 속한 상품 카테고리 수정
    @Override
    public void updateCategoryFicnic(String ps_ctid) {
        this.sqlSession.update("adminCategoryFicnicUpdate", ps_ctid);
        this.sqlSession.update("adminCategoryFicnicUpdate1", ps_ctid);
        this.sqlSession.update("adminCategoryFicnicUpdate2", ps_ctid);
        this.sqlSession.update("adminCategoryFicnicUpdate3", ps_ctid);
    }



    // 쿠폰 상세 내역에서 카테고리 정보 찾기
	@Override
	public String checkCategory(String coupon_use_value) {
		return this.sqlSession.selectOne("admincheckCategory", coupon_use_value);
	}




	///////////////////////////////////////////////////////////////////////////////////



    // 카테고리 목록 (사이트)
    @Override
    public List<CategoryDTO> getSiteCategoryList() {
        return this.sqlSession.selectList("siteCategoryList");
    }
    
    // 서브 카테고리 목록 (사이트)
    @Override
    public List<CategoryDTO> getSiteSubCategoryList(String category_no) {
        return this.sqlSession.selectList("siteSubCategoryList", category_no);
    }



	@Override
	public List<String> getChildList(String ficnic_category_no) {
		return this.sqlSession.selectList("SiteFicnicChildCategory", ficnic_category_no);
	}



	@Override
	public String getCategoryName(String ficnic_name) {
		return this.sqlSession.selectOne("siteFicnicName",ficnic_name);
	}






}