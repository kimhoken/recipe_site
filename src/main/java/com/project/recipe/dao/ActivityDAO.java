package com.project.recipe.dao;

import java.util.List;

import com.project.recipe.vo.ActivityVO;
 
public interface ActivityDAO {

    //회원의 활동내역 조회 (레시피, 북마크, 댓글)
    List<ActivityVO> userActivity(int member_id);

}
