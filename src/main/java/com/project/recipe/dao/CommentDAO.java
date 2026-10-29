package com.project.recipe.dao;

import java.util.List;
import java.util.Map;

import com.project.recipe.vo.CommentVO;

public interface CommentDAO {

    int insertComment(CommentVO community);
    
    int deleteComment(int comment_id);
    
    int update(CommentVO comment);
    
    // 댓글 목록 가져오는 함수 
    List<CommentVO> getList(int target_id, String target_type);    

    // 페이징 관련 함수 
    List<CommentVO> getListPaging(Map<String, Object> map);

    int commentCount(int target_id, String target_type);
   

}
