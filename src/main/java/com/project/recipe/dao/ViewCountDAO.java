package com.project.recipe.dao;

import org.apache.ibatis.annotations.Param;

public interface ViewCountDAO {

    //  공통 조회 이력 확인
    int viewHistory(
            @Param("content_type") String content_type,
            @Param("content_id") int content_id,
            @Param("member_id") int member_id
    );

    //  공통 조회 이력 저장
    int viewInsert(
            @Param("content_type") String content_type,
            @Param("content_id") int content_id,
            @Param("member_id") int member_id
    );

    //  공지사항 조회수 증가
    int increaseNoticeViewCount(int notice_id);

    //  레시피 조회수 증가
    int increaseRecipeViewCount(int recipe_id);

    //  게시판 조회수 증가
    int increaseBoardViewCount(int board_id);

    int increaseReviewViewCount(int review_id);
}
