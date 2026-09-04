package com.project.recipe.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.recipe.vo.ActivityVO;

@Mapper 
public interface ActivityDAO {

    //회원의 활동내역 조회 (레시피, 북마크, 댓글)
    List<ActivityVO> userActivity(int member_id);

}
