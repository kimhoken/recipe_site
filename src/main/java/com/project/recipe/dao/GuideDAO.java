package com.project.recipe.dao;

import java.util.List;
import java.util.Map;

import com.project.recipe.dto.GuideDTO;
import com.project.recipe.dto.GuideStepDTO;

public interface GuideDAO {
    
    List<GuideDTO> guideTab(Map<String, Object> map);   //tab들

    GuideDTO Detail(int guide_id); //가이드 상세 단건 조회

    List<GuideStepDTO> stepList(int guide_id); //가이드 상세 단계별 리스트 조회

    int guideInsert(GuideDTO guide);  // 가이드 작성

    int guideStepInsert(GuideStepDTO step); // 가이드 단계 작성

    int guideStepDelete(long guide_id); // 가이드 단계 삭제

    int guideDelete(long guide_id);   // 가이드 삭제

    int guideUpdate(GuideDTO guide);  // 가이드 수정

    GuideStepDTO guideStepDetail(long step_id); // 단계 하나 조회

    int guideStepUpdate(GuideStepDTO step); // 단계 수정

    int guideStepDeleteOne(long step_id); // 단계 하나 삭제
    
}
