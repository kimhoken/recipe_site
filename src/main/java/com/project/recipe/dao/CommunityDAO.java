package com.project.recipe.dao;

import java.util.List;

import com.project.recipe.vo.CommunityVO;

public interface CommunityDAO {
    List<CommunityVO> CheckList();
    List<CommunityVO> noticeList();
    int communityInsert( CommunityVO com );
    CommunityVO communitySelect( int commuity_id );
    int communityUpdate( CommunityVO com );
    int communityDelete( int commuity_id );
}

