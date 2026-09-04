package com.project.recipe.dao;

import java.util.List;

import com.project.recipe.vo.ImgVO;

public interface ImgDAO {   

    int img_insert(ImgVO vo);

    ImgVO img_select(int img_id);

    List<ImgVO> img_select_inquiry(int inquiry_id); 

    int img_delete(int img_id);

    int img_insert_review(ImgVO vo);

    int img_update(ImgVO vo);
}
