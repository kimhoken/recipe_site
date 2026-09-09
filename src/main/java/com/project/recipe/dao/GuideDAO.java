package com.project.recipe.dao;

import java.util.List;
import java.util.Map;

import com.project.recipe.dto.GuideDTO;
import com.project.recipe.dto.GuideStepDTO;

public interface GuideDAO {
    
    List<GuideDTO> guideTab(Map<String, Object> map);   //tab들

    GuideDTO Detail(int guide_id); //가이드 상세 단건 조회

    List<GuideStepDTO> stepList(int guide_id); //가이드 상세 단계별 리스트 조회
    
}
