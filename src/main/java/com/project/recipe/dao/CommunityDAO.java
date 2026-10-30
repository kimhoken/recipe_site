package com.project.recipe.dao;

import java.util.List;

import com.project.recipe.vo.CommunityVO;
import com.project.recipe.dto.AdminBoardDTO;
import org.apache.ibatis.annotations.Param;

public interface CommunityDAO {
    List<CommunityVO> CheckList();
    List<CommunityVO> noticeList();
    int communityInsert( CommunityVO com );
    CommunityVO communitySelect( int commuity_id );
    int communityUpdate( CommunityVO com );
    int communityDelete(CommunityVO community);

    int boardCount(AdminBoardDTO search);

    List<AdminBoardDTO> BoardSearch(AdminBoardDTO search);

    AdminBoardDTO adminBoardDetail(@Param("community_id") int community_id);

    int boardStatus(AdminBoardDTO community);
}

