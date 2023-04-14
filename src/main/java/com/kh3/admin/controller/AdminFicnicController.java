package com.kh3.admin.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kh3.model.ficnic.CategoryDAO;
import com.kh3.model.ficnic.CategoryDTO;
import com.kh3.model.ficnic.FicnicDAO;
import com.kh3.model.ficnic.FicnicDTO;
import com.kh3.model.member.WishDAO;
import com.kh3.model.review.ReviewDAO;
import com.kh3.model.review.ReviewDTO;
import com.kh3.util.PageDTO;
import com.kh3.util.Paging;
import com.kh3.util.UploadFile;

@Controller
public class AdminFicnicController {

    @Inject
    private FicnicDAO dao;

    @Inject
    private CategoryDAO cdao;
    
    @Inject
    private WishDAO wdao;

    @Inject
    ReviewDAO rdao;


    // 카테고리 업로드 설정
    private String categoryFolder = "/resources/data/category/";
    private String categorySaveName = "category";

    // 피크닉 업로드 설정
    private String ficnicFolder = "/resources/data/ficnic/";
    private String ficnicSaveName = "ficnic";


    // 한 페이지당 보여질 게시물의 수
    private final int rowsize = 10;

    // 전체 게시물의 수
    private int totalRecord = 0;



    // =====================================================================================
    // 피크닉 조회 및 검색 목록 페이지
    // =====================================================================================
    @RequestMapping("admin/ficnic/ficnic_list.do")
    public String ficnicList(
            @RequestParam(value = "search_location", required = false, defaultValue = "") String search_location,
            @RequestParam(value = "search_category", required = false, defaultValue = "") String search_category,
            @RequestParam(value = "search_name", required = false, defaultValue = "") String search_name,
            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
            Model model, HttpServletRequest request) {

        List<CategoryDTO> cList = cdao.getCategoryList();


        Map<String, Object> map = new HashMap<String, Object>();
        map.put("search_location", search_location);
        map.put("search_category", search_category);
        map.put("search_name", search_name);

        totalRecord = dao.getListCount(map);

        PageDTO dto = new PageDTO(page, rowsize, totalRecord, map);

        // 페이지 이동 URL
        String pageUrl = request.getContextPath() + "/admin/ficnic/ficnic_list.do?search_location=" + search_location + "&search_category=" + search_category + "&search_name=" + search_name;

        List<FicnicDTO> fList = dao.getFicnicList(dto.getStartNo(), dto.getEndNo(), map);

        model.addAttribute("flist", fList);
        model.addAttribute("clist", cList);
        model.addAttribute("totalCount", totalRecord);
        model.addAttribute("paging", dto);
        model.addAttribute("pagingWrite", Paging.showPage(dto.getAllPage(), dto.getStartBlock(), dto.getEndBlock(), dto.getPage(), pageUrl));

        model.addAttribute("search_location", search_location);
        model.addAttribute("search_category", search_category);
        model.addAttribute("search_name", search_name);
        model.addAttribute("page", page);

        return "admin/ficnic/ficnic_list";
    }




    // =====================================================================================
    // 피크닉 보기 페이지
    // =====================================================================================
    @RequestMapping("admin/ficnic/ficnic_view.do")
    public String ficnicView(@RequestParam("no") int no, Model model) {
        int cnt = 0;

        // 기존에 있던 해당 피크닉 상품 정보 불러와야한다.
        FicnicDTO fdto = this.dao.getFicnicCont(no);
        List<CategoryDTO> cList = cdao.getCategoryList();



        /* 앞단 보여질 option 처리 */
        List<HashMap<String, Object>> optionList = new ArrayList<HashMap<String, Object>>();

        String[] optionTitle = null;
        if (fdto.getFicnic_option_title() != null) optionTitle = fdto.getFicnic_option_title().split("★");

        Object[] optionPrice = null;
        if (fdto.getFicnic_option_price() != null) optionPrice = fdto.getFicnic_option_price().split("★");

        if (optionTitle != null && optionPrice != null) {
            cnt = 0;
            for (String value : optionTitle) {
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("title", value);
                map.put("price", Integer.parseInt((String) optionPrice[cnt]));

                if(cnt == 0) {
                    map.put("cls", "info");
                    map.put("btn", "plus");
                }else{
                    map.put("cls", "danger");
                    map.put("btn", "minus");
                }

                optionList.add(map);
                cnt++;
            }
        }



        /* 앞단 보여질 select_option 처리 */
        List<HashMap<String, Object>> selectList = new ArrayList<HashMap<String, Object>>();

        String[] selectTitle = null;
        if (fdto.getFicnic_select_title() != null) selectTitle = fdto.getFicnic_select_title().split("★");

        Object[] selectPrice = null;
        if (fdto.getFicnic_select_price() != null) selectPrice = fdto.getFicnic_select_price().split("★");

        if (selectTitle != null && selectPrice != null) {
            cnt = 0;
            for (String value : selectTitle) {
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("title", value);
                map.put("price", Integer.parseInt((String) selectPrice[cnt]));

                if(cnt == 0) {
                    map.put("cls", "info");
                    map.put("btn", "plus");
                }else{
                    map.put("cls", "danger");
                    map.put("btn", "minus");
                }

                selectList.add(map);
                cnt++;
            }
        }



        /* 앞단 보여질 info 처리 */
        List<HashMap<String, Object>> infoList = new ArrayList<HashMap<String, Object>>();

        String[] infoAll = null;
        if (fdto.getFicnic_info() != null) infoAll = fdto.getFicnic_info().split("★");

        if(infoAll != null) {
            cnt = 0;
            for (String ilist : infoAll) {
                String[] infoEpd = ilist.split("○");

                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("title", infoEpd[0]);
                map.put("cont", infoEpd[1]);

                if(cnt == 0) {
                    map.put("cls", "info");
                    map.put("btn", "plus");
                }else{
                    map.put("cls", "danger");
                    map.put("btn", "minus");
                }

                infoList.add(map);
                cnt++;
            }
        }



        /* 앞단 보여질 curriculum 처리 */
        List<HashMap<String, Object>> currList = new ArrayList<HashMap<String, Object>>();

        String[] currAll = null;
        if (fdto.getFicnic_curriculum() != null) currAll = fdto.getFicnic_curriculum().split("★");

        if(currAll != null) {
            cnt = 0;
            for (String clist : currAll) {
                String[] currEpd = clist.split("○");

                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("time", currEpd[0]);
                map.put("cont", currEpd[1]);

                if(cnt == 0) {
                    map.put("cls", "info");
                    map.put("btn", "plus");
                }else{
                    map.put("cls", "danger");
                    map.put("btn", "minus");
                }

                currList.add(map);
                cnt++;
            }
        }


        model.addAttribute("clist", cList);
        model.addAttribute("fdto", fdto);

        model.addAttribute("optionList", optionList);
        model.addAttribute("selectList", selectList);
        model.addAttribute("infoList", infoList);
        model.addAttribute("currList", currList);

        return "admin/ficnic/ficnic_view";
    }




    // =====================================================================================
    // 피크닉 등록 페이지
    // =====================================================================================
    @RequestMapping("admin/ficnic/ficnic_write.do")
    public String ficnicWrite(Model model, HttpServletRequest request) {
        List<CategoryDTO> cList = cdao.getCategoryList();
        model.addAttribute("clist", cList);

        return "admin/ficnic/ficnic_write";
    }




    // =====================================================================================
    // 피크닉 등록 처리
    // =====================================================================================
    @RequestMapping("admin/ficnic/ficnic_write_ok.do")
    public void ficnicWriteOk(FicnicDTO dto, MultipartHttpServletRequest mRequest, HttpServletResponse response) throws Exception {

        /* 다중 카테고리 처리 */
        String[] getCategorySub = null;
        if(mRequest.getParameterValues("ficnic_category_sub[]") != null){
            getCategorySub = mRequest.getParameterValues("ficnic_category_sub[]");
            for(int i=0; i<getCategorySub.length; i++){
                switch (i) {
                case 0:
                    dto.setFicnic_category_sub1(getCategorySub[i]);
                    break;
                case 1:
                    dto.setFicnic_category_sub2(getCategorySub[i]);
                    break;
                case 2:
                    dto.setFicnic_category_sub3(getCategorySub[i]);
                    break;
                default:
                    break;
                }
            }
        }


        /* 선택 옵션 처리 */
        String setOptionTitle = "";
        String setOptionPrice = "";
        if (dto.getFicnic_option_title() != null && !dto.getFicnic_option_title().equals(",")) {
            String[] getOptionTitle = mRequest.getParameterValues("ficnic_option_title");
            String[] getOptionPrice = mRequest.getParameterValues("ficnic_option_price");
            for(int i=0; i<getOptionTitle.length; i++){
                setOptionTitle += getOptionTitle[i] + "★";

                try {
                    if(Integer.parseInt(getOptionPrice[i]) > 0){
                        setOptionPrice += getOptionPrice[i] + "★";
                    }else{
                        setOptionPrice += "0★";
                    }
                }catch(NumberFormatException e) {
                    setOptionPrice += "0★";
                }
            }
            setOptionTitle = setOptionTitle.substring(0, setOptionTitle.length() - 1);
            setOptionPrice = setOptionPrice.substring(0, setOptionPrice.length() - 1);
        }
        dto.setFicnic_option_title(setOptionTitle);
        dto.setFicnic_option_price(setOptionPrice);


        /* 추가 선택 처리 */
        String setSelectTitle = "";
        String setSelectPrice = "";
        if (dto.getFicnic_select_title() != null && !dto.getFicnic_select_title().equals(",")) {
            String[] getSelectTitle = mRequest.getParameterValues("ficnic_select_title");
            String[] getSelectPrice = mRequest.getParameterValues("ficnic_select_price");
            for(int i=0; i<getSelectTitle.length; i++){
                setSelectTitle += getSelectTitle[i] + "★";

                try {
                    if(Integer.parseInt(getSelectPrice[i]) > 0){
                        setSelectPrice += getSelectPrice[i] + "★";
                    }else{
                        setSelectPrice += "0★";
                    }
                }catch(NumberFormatException e) {
                    setSelectPrice += "0★";
                }
            }
            setSelectTitle = setSelectTitle.substring(0, setSelectTitle.length() - 1);
            setSelectPrice = setSelectPrice.substring(0, setSelectPrice.length() - 1);
        }
        dto.setFicnic_select_title(setSelectTitle);
        dto.setFicnic_select_price(setSelectPrice);


        /* 피크닉 정보 처리 */
        String setInfoData = "";
        if (dto.getFicnic_info() != null && !dto.getFicnic_info().equals(",")) {
            String[] getInfoData = mRequest.getParameterValues("ficnic_info");

            int cnt = 0;
            for (String info : getInfoData) {
                if (cnt % 2 == 0) {
                    setInfoData += info + "○";
                } else {
                    setInfoData += info;
                    if (cnt != getInfoData.length - 1) setInfoData += "★";
                }
                cnt++;
            }
        }
        dto.setFicnic_info(setInfoData);


        /* 피크닉 커리큘럼 처리 */
        String setCurrData = "";
        if (dto.getFicnic_curriculum() != null && !dto.getFicnic_curriculum().equals(",")) {
            String[] getCurr = mRequest.getParameterValues("ficnic_curriculum");

            int cnt = 0;
            for (String info : getCurr) {
                if (cnt % 2 == 0) {
                    setCurrData += info + "○";
                } else {
                    setCurrData += info;
                    if (cnt != getCurr.length - 1) setCurrData += "★";
                }
                cnt++;
            }
        }
        dto.setFicnic_curriculum(setCurrData);



        // 파일저장 이름 >> thisFolder/saveName_일련번호_밀리세컨드.확장자
        List<String> upload_list = UploadFile.fileUpload(mRequest, ficnicFolder, ficnicSaveName);
        for(int i=0; i<upload_list.size(); i++){
            switch (i) {
                case 0:
                    dto.setFicnic_photo1(upload_list.get(0));
                    break;
                case 1:
                    dto.setFicnic_photo2(upload_list.get(1));
                    break;
                case 2:
                    dto.setFicnic_photo3(upload_list.get(2));
                    break;
                case 3:
                    dto.setFicnic_photo4(upload_list.get(3));
                    break;
                case 4:
                    dto.setFicnic_photo5(upload_list.get(4));
                    break;
                default:
                    break;
            }
        }



        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();

        if (this.dao.writeFicnic(dto) > 0) {
            out.println("<script>location.href='" + mRequest.getContextPath() + "/admin/ficnic/ficnic_list.do'</script>");
        } else {
            out.println("<script>alert('피크닉 등록 실패'); history.back()</script>");
        }
    }




    // =====================================================================================
    // 피크닉 수정 페이지
    // =====================================================================================
    @RequestMapping("admin/ficnic/ficnic_modify.do")
    public String ficnicModify(
            @RequestParam(value = "finic_category_no", required = false, defaultValue = "") String finic_category_no,
            @RequestParam(value = "ficnic_location", required = false, defaultValue = "") String ficnic_location,
            @RequestParam(value = "ficnic_address", required = false, defaultValue = "") String ficnic_address,
            @RequestParam(value = "ficnic_name", required = false, defaultValue = "") String ficnic_name,
            @RequestParam(value = "page", required = false, defaultValue = "1") int page,    		
    		@RequestParam("no") int no, Model model) {
        int cnt = 0;

        // 기존에 있던 해당 피크닉 상품 정보 불러와야한다.
        FicnicDTO fdto = this.dao.getFicnicCont(no);
        List<CategoryDTO> cList = cdao.getCategoryList();



        /* 앞단 보여질 option 처리 */
        List<HashMap<String, Object>> optionList = new ArrayList<HashMap<String, Object>>();

        String[] optionTitle = null;
        if (fdto.getFicnic_option_title() != null) optionTitle = fdto.getFicnic_option_title().split("★");

        Object[] optionPrice = null;
        if (fdto.getFicnic_option_price() != null) optionPrice = fdto.getFicnic_option_price().split("★");

        if (optionTitle != null && optionPrice != null) {
            cnt = 0;
            for (String value : optionTitle) {
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("title", value);
                map.put("price", Integer.parseInt((String) optionPrice[cnt]));

                if(cnt == 0) {
                    map.put("cls", "info");
                    map.put("btn", "plus");
                }else{
                    map.put("cls", "danger");
                    map.put("btn", "minus");
                }

                optionList.add(map);
                cnt++;
            }
        }



        /* 앞단 보여질 select_option 처리 */
        List<HashMap<String, Object>> selectList = new ArrayList<HashMap<String, Object>>();

        String[] selectTitle = null;
        if (fdto.getFicnic_select_title() != null) selectTitle = fdto.getFicnic_select_title().split("★");

        Object[] selectPrice = null;
        if (fdto.getFicnic_select_price() != null) selectPrice = fdto.getFicnic_select_price().split("★");

        if (selectTitle != null && selectPrice != null) {
            cnt = 0;
            for (String value : selectTitle) {
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("title", value);
                map.put("price", Integer.parseInt((String) selectPrice[cnt]));

                if(cnt == 0) {
                    map.put("cls", "info");
                    map.put("btn", "plus");
                }else{
                    map.put("cls", "danger");
                    map.put("btn", "minus");
                }

                selectList.add(map);
                cnt++;
            }
        }



        /* 앞단 보여질 info 처리 */
        List<HashMap<String, Object>> infoList = new ArrayList<HashMap<String, Object>>();

        String[] infoAll = null;
        if (fdto.getFicnic_info() != null) infoAll = fdto.getFicnic_info().split("★");

        if(infoAll != null) {
            cnt = 0;
            for (String ilist : infoAll) {
                String[] infoEpd = ilist.split("○");

                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("title", infoEpd[0]);
                map.put("cont", infoEpd[1]);

                if(cnt == 0) {
                    map.put("cls", "info");
                    map.put("btn", "plus");
                }else{
                    map.put("cls", "danger");
                    map.put("btn", "minus");
                }

                infoList.add(map);
                cnt++;
            }
        }



        /* 앞단 보여질 curriculum 처리 */
        List<HashMap<String, Object>> currList = new ArrayList<HashMap<String, Object>>();

        String[] currAll = null;
        if (fdto.getFicnic_curriculum() != null) currAll = fdto.getFicnic_curriculum().split("★");

        if(currAll != null) {
            cnt = 0;
            for (String clist : currAll) {
                String[] currEpd = clist.split("○");

                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("time", currEpd[0]);
                map.put("cont", currEpd[1]);

                if(cnt == 0) {
                    map.put("cls", "info");
                    map.put("btn", "plus");
                }else{
                    map.put("cls", "danger");
                    map.put("btn", "minus");
                }

                currList.add(map);
                cnt++;
            }
        }


        model.addAttribute("clist", cList);
        model.addAttribute("fdto", fdto);
        
        model.addAttribute("finic_category_no", finic_category_no);
        model.addAttribute("ficnic_location", ficnic_location);
        model.addAttribute("ficnic_address", ficnic_address);
        model.addAttribute("ficnic_name", ficnic_name);
        model.addAttribute("page", page);

        model.addAttribute("optionList", optionList);
        model.addAttribute("selectList", selectList);
        model.addAttribute("infoList", infoList);
        model.addAttribute("currList", currList);

        model.addAttribute("m", "m");

        return "admin/ficnic/ficnic_write";
    }




    // =====================================================================================
    // 피크닉 수정 처리
    // =====================================================================================
    @RequestMapping("admin/ficnic/ficnic_modify_ok.do")
    public void ficnicModifyOk(FicnicDTO dto, MultipartHttpServletRequest mRequest, HttpServletResponse response) throws Exception {

        /* 다중 카테고리 처리 */
        String[] getCategorySub = null;
        if(mRequest.getParameterValues("ficnic_category_sub[]") != null){
            getCategorySub = mRequest.getParameterValues("ficnic_category_sub[]");
            for(int i=0; i<getCategorySub.length; i++){
                switch (i) {
                case 0:
                    dto.setFicnic_category_sub1(getCategorySub[i]);
                    break;
                case 1:
                    dto.setFicnic_category_sub2(getCategorySub[i]);
                    break;
                case 2:
                    dto.setFicnic_category_sub3(getCategorySub[i]);
                    break;
                default:
                    break;
                }
            }
        }


        /* 선택 옵션 처리 */
        String setOptionTitle = "";
        String setOptionPrice = "";
        if (dto.getFicnic_option_title() != null && !dto.getFicnic_option_title().equals(",")) {
            String[] getOptionTitle = mRequest.getParameterValues("ficnic_option_title");
            String[] getOptionPrice = mRequest.getParameterValues("ficnic_option_price");
            for(int i=0; i<getOptionTitle.length; i++){
                setOptionTitle += getOptionTitle[i] + "★";
                if(Integer.parseInt(getOptionPrice[i]) > 0){
                    setOptionPrice += getOptionPrice[i] + "★";
                }else{
                    setOptionPrice += "0★";
                }
            }
        }
        dto.setFicnic_option_title(setOptionTitle);
        dto.setFicnic_option_price(setOptionPrice);


        /* 추가 선택 처리 */
        String setSelectTitle = "";
        String setSelectPrice = "";
        if (dto.getFicnic_select_title() != null && !dto.getFicnic_select_title().equals(",")) {
            String[] getSelectTitle = mRequest.getParameterValues("ficnic_select_title");
            String[] getSelectPrice = mRequest.getParameterValues("ficnic_select_price");
            for(int i=0; i<getSelectTitle.length; i++){
                setSelectTitle += getSelectTitle[i] + "★";
                if(Integer.parseInt(getSelectPrice[i]) > 0){
                    setSelectPrice += getSelectPrice[i] + "★";
                }else{
                    setSelectPrice += "0★";
                }
            }
        }
        dto.setFicnic_select_title(setSelectTitle);
        dto.setFicnic_select_price(setSelectPrice);


        /* 피크닉 정보 처리 */
        String setInfoData = "";
        if (dto.getFicnic_info() != null && !dto.getFicnic_info().equals(",")) {
            String[] getInfoData = mRequest.getParameterValues("ficnic_info");

            int cnt = 0;
            for (String info : getInfoData) {
                if (cnt % 2 == 0) {
                    setInfoData += info + "○";
                } else {
                    setInfoData += info;
                    if (cnt != getInfoData.length - 1) setInfoData += "★";
                }
                cnt++;
            }
        }
        dto.setFicnic_info(setInfoData);


        /* 피크닉 커리큘럼 처리 */
        String setCurrData = "";
        if (dto.getFicnic_curriculum() != null && !dto.getFicnic_curriculum().equals(",")) {
            String[] getCurr = mRequest.getParameterValues("ficnic_curriculum");

            int cnt = 0;
            for (String info : getCurr) {
                if (cnt % 2 == 0) {
                    setCurrData += info + "○";
                } else {
                    setCurrData += info;
                    if (cnt != getCurr.length - 1) setCurrData += "★";
                }
                cnt++;
            }
        }
        dto.setFicnic_curriculum(setCurrData);



        String ficnic_image1 = mRequest.getParameter("ori_ficnic_photo1");
        String ficnic_image2 = mRequest.getParameter("ori_ficnic_photo2");
        String ficnic_image3 = mRequest.getParameter("ori_ficnic_photo3");
        String ficnic_image4 = mRequest.getParameter("ori_ficnic_photo4");
        String ficnic_image5 = mRequest.getParameter("ori_ficnic_photo5");

        // 파일저장 이름 >> thisFolder/saveName_일련번호_밀리세컨드.확장자
        List<String> upload_list = UploadFile.fileUpload(mRequest, ficnicFolder, ficnicSaveName);
        for(int i=0; i<upload_list.size(); i++){

            // 기존 사진 있으면 삭제 처리
            String check_photo = mRequest.getParameter("ori_ficnic_photo" + (i+1));
            if (check_photo != null && upload_list.get(i) != "") {
                File del_pimage = new File(mRequest.getSession().getServletContext().getRealPath(check_photo));
                if(del_pimage.exists()) del_pimage.delete();
            }

            switch (i) {
                case 0:
                    if (upload_list.get(0) != "") ficnic_image1 = upload_list.get(0);
                    dto.setFicnic_photo1(ficnic_image1);
                    break;
                case 1:
                    if (upload_list.get(1) != "") ficnic_image2 = upload_list.get(1);
                    dto.setFicnic_photo2(ficnic_image2);
                    break;
                case 2:
                    if (upload_list.get(2) != "") ficnic_image3 = upload_list.get(2);
                    dto.setFicnic_photo3(ficnic_image3);
                    break;
                case 3:
                    if (upload_list.get(3) != "") ficnic_image4 = upload_list.get(3);
                    dto.setFicnic_photo4(ficnic_image4);
                    break;
                case 4:
                    if (upload_list.get(4) != "") ficnic_image5 = upload_list.get(4);
                    dto.setFicnic_photo5(ficnic_image5);
                    break;
                default:
                    break;
            }
        }


        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();

        if (this.dao.modifyFicnic(dto) > 0) {
            out.println("<script>location.href='" + mRequest.getContextPath() + "/admin/ficnic/ficnic_list.do'</script>");
        } else {
            out.println("<script>alert('피크닉 수정 실패'); history.back()</script>");
        }
    }




    // =====================================================================================
    // 피크닉 삭제 처리
    // =====================================================================================
    @RequestMapping("admin/ficnic/ficnic_delete.do")
    public void ficnicDelete(@RequestParam("no") int no, HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();

        // 기존 파일 있으면 삭제 처리
        FicnicDTO fdto = this.dao.getFicnicCont(no);

        if (fdto.getFicnic_photo1() != null) {
            File del_pimage = new File(request.getSession().getServletContext().getRealPath(fdto.getFicnic_photo1()));
            if (del_pimage.exists())
                del_pimage.delete();

        }
        if (fdto.getFicnic_photo2() != null) {
            File del_pimage = new File(request.getSession().getServletContext().getRealPath(fdto.getFicnic_photo2()));
            if (del_pimage.exists())
                del_pimage.delete();

        }
        if (fdto.getFicnic_photo3() != null) {
            File del_pimage = new File(request.getSession().getServletContext().getRealPath(fdto.getFicnic_photo3()));
            if (del_pimage.exists())
                del_pimage.delete();

        }
        if (fdto.getFicnic_photo4() != null) {
            File del_pimage = new File(request.getSession().getServletContext().getRealPath(fdto.getFicnic_photo4()));
            if (del_pimage.exists())
                del_pimage.delete();

        }
        if (fdto.getFicnic_photo5() != null) {
            File del_pimage = new File(request.getSession().getServletContext().getRealPath(fdto.getFicnic_photo5()));
            if (del_pimage.exists())
                del_pimage.delete();

        }

        if (this.dao.deleteFicnic(no) > 0) {

            // 해당 리뷰도 삭제
            Map<String, Object> searchMap = new HashMap<String, Object>();
            searchMap.put("ficnic_no", no);
            searchMap.put("getType", "");
            List<ReviewDTO> rList = rdao.getNumList(1, 9999, searchMap);

            for(int i=0; i<rList.size(); i++) {
                ReviewDTO dto = rList.get(i);

                // 기존 파일 있으면 삭제 처리
                if(dto.getReview_photo1() != null){
                    File del_pimage1 = new File(request.getSession().getServletContext().getRealPath(dto.getReview_photo1()));
                    if(del_pimage1.exists()) del_pimage1.delete();
                }
                if(dto.getReview_photo2() != null){
                    File del_pimage2 = new File(request.getSession().getServletContext().getRealPath(dto.getReview_photo2()));
                    if(del_pimage2.exists()) del_pimage2.delete();
                }
                
                rdao.reviewDelete(dto.getReview_no());
            }

            wdao.wishDelete(no);
            out.println("<script>location.href='" + request.getContextPath() + "/admin/ficnic/ficnic_list.do'</script>");
        } else {
            out.println("<script>alert('피크닉 삭제 실패'); history.back()</script>");
        }
    }




    // =====================================================================================
    // 이미지만 삭제
    // =====================================================================================
    @RequestMapping("admin/ficnic/ficnic_img_delete.do")
    public void ficnicImgDelete(@RequestParam("ficnic_no") int ficnic_no, @RequestParam("img_num") int img_num, HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();

        String chkResult = "N";

        // 기존 파일 있으면 삭제 처리
        FicnicDTO fdto = this.dao.getFicnicCont(ficnic_no);
        File del_pimage = null;

        switch (img_num) {
        case 1:
            if (fdto.getFicnic_photo1() != null) {
                del_pimage = new File(request.getSession().getServletContext().getRealPath(fdto.getFicnic_photo1()));
            }
        case 2:
            if (fdto.getFicnic_photo2() != null) {
                del_pimage = new File(request.getSession().getServletContext().getRealPath(fdto.getFicnic_photo2()));
            }
        case 3:
            if (fdto.getFicnic_photo3() != null) {
                del_pimage = new File(request.getSession().getServletContext().getRealPath(fdto.getFicnic_photo3()));
            }
        case 4:
            if (fdto.getFicnic_photo4() != null) {
                del_pimage = new File(request.getSession().getServletContext().getRealPath(fdto.getFicnic_photo4()));
            }
        case 5:
            if (fdto.getFicnic_photo5() != null) {
                del_pimage = new File(request.getSession().getServletContext().getRealPath(fdto.getFicnic_photo5()));
            }
        }

        if (del_pimage.exists()) {
            del_pimage.delete();
            chkResult = "Y";
        }

        this.dao.deleteFicnicImage(ficnic_no, img_num);

        out.println(chkResult);
    }





    ////////////////////////////////////////////////////////////////////////////////////////////////////





    // =====================================================================================
    // 카테고리 관리 목록 페이지
    // =====================================================================================
    @RequestMapping("admin/ficnic/category_list.do")
    public String categoryList(Model model) {
        List<CategoryDTO> list = cdao.getCategoryList();
        model.addAttribute("clist", list);

        return "admin/ficnic/category_list";
    }




    // =====================================================================================
    // 카테고리 정렬 순서 저장
    // =====================================================================================
    @RequestMapping("admin/ficnic/category_rank_ok.do")
    public void categoryRank(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String[] cateid = request.getParameterValues("category_id[]");
        for (int i = 0; i < cateid.length; i++) {
            cdao.setCategoryRank(cateid[i], i + 1);
        }

        PrintWriter out = response.getWriter();
        out.println("<script>location.href='category_list.do';</script>");
    }




    // =====================================================================================
    // 카테고리 추가
    // =====================================================================================
    @RequestMapping("admin/ficnic/category_write_ok.do")
    public void categoryWrite(MultipartHttpServletRequest mRequest, HttpServletResponse response) throws IOException {
        String ps_ctid = mRequest.getParameter("ps_ctid");
        String category_show = mRequest.getParameter("category_show");
        String category_name = mRequest.getParameter("category_name");

        // 파일저장 이름 >> thisFolder/saveName_일련번호_밀리세컨드.확장자
        String category_image = null;
        List<String> upload_list = UploadFile.fileUpload(mRequest, categoryFolder, categorySaveName);
        if (upload_list.size() > 0) {
            category_image = upload_list.get(0);
        }

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        int check = cdao.addCategory(ps_ctid, category_show, category_name, category_image);
        if (check > 0) {
            out.println("<script>location.href='category_list.do';</script>");
        } else {
            out.println("<script>alert('카테고리 등록 중 에러가 발생하였습니다.'); history.back();</script>");
        }
    }




    // =====================================================================================
    // 카테고리 수정
    // =====================================================================================
    @RequestMapping("admin/ficnic/category_modify_ok.do")
    public void categoryModify(MultipartHttpServletRequest mRequest, HttpServletResponse response) throws IOException {
        String ps_ctid = mRequest.getParameter("ps_ctid");
        String category_show = mRequest.getParameter("category_show");
        String category_name = mRequest.getParameter("category_name");

        // 파일저장 이름 >> thisFolder/saveName_일련번호_밀리세컨드.확장자
        String category_image = mRequest.getParameter("ori_category_image");
        List<String> upload_list = UploadFile.fileUpload(mRequest, categoryFolder, categorySaveName);
        System.out.println("upload_list.size() >>> " + upload_list.size());
        System.out.println("upload_list.get(0) >>> " + upload_list.get(0));
        if (upload_list.size() > 0 && !upload_list.get(0).equals("")) {
            // 기존 파일 있으면 삭제 처리
            if (category_image != null && !upload_list.get(0).equals("")) {
                File del_pimage = new File(mRequest.getSession().getServletContext().getRealPath(category_image));
                if (del_pimage.exists())
                    del_pimage.delete();
            }
            category_image = upload_list.get(0);
        }

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        int check = cdao.modifyCategory(ps_ctid, category_show, category_name, category_image);
        if (check > 0) {
            out.println("<script>location.href='category_list.do';</script>");
        } else {
            out.println("<script>alert('카테고리 수정 중 에러가 발생하였습니다.'); history.back();</script>");
        }
    }

    


    // =====================================================================================
    // 카테고리 삭제
    // =====================================================================================
    @RequestMapping("admin/ficnic/category_delete.do")
    public void categoryDelete(@RequestParam("ps_ctid") String ps_ctid, HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        CategoryDTO cdto = cdao.getCategoryCont(ps_ctid);

        // 기존 파일 있으면 삭제 처리
        if (cdto.getCategory_image() != null) {
            File del_pimage = new File(request.getSession().getServletContext().getRealPath(cdto.getCategory_image()));
            if (del_pimage.exists())
                del_pimage.delete();
        }

        int check = cdao.deleteCategory(ps_ctid);
        if (check > 0) {
            cdao.updateCategorySeq(cdto.getCategory_no());
            cdao.updateCategoryFicnic(ps_ctid);
            out.println("<script>location.href='category_list.do';</script>");
        } else {
            out.println("<script>alert('카테고리 삭제 중 에러가 발생하였습니다.'); history.back();</script>");
        }
    }

}