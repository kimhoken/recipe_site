package com.project.recipe.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import com.project.recipe.vo.ImgVO;

public interface ImgDAO {   

    int img_insert(ImgVO vo);

    ImgVO img_select(@Param("target_id") int target_id,
                     @Param("target_type") String target_type);

    List<ImgVO> img_select_inquiry(int inquiry_id); 

    int img_delete(int target_id, String target_type);

    int img_insert_review(ImgVO vo);

    int img_update(ImgVO vo);
}

