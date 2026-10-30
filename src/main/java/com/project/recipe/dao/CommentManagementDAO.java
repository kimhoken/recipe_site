package com.project.recipe.dao;

import java.util.List;

import com.project.recipe.dto.AdminCommentDTO;
import com.project.recipe.dto.MypageDTO;
import com.project.recipe.vo.CommentVO;

public interface CommentManagementDAO {

    List<CommentVO> userComment(int member_id);

    int countUserComment(MypageDTO mypageDTO);

    List<CommentVO> getUserCommentList(MypageDTO mypageDTO);

    int commentCount(AdminCommentDTO comment);

    List<AdminCommentDTO> CommentSearch(AdminCommentDTO comment);

    AdminCommentDTO selectComment(int comment_id);

    int CommentHidden(AdminCommentDTO Comment);
}
