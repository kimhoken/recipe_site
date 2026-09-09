package com.project.recipe.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data 
@AllArgsConstructor
@NoArgsConstructor
@Alias("GuideStepDTO")
public class GuideStepDTO {
    
    private long step_id;
    private long guide_id;    //가이드번호
    private int step_num;     // 화면에 보여줄 순서
    private String step_image;   //조리단계 이미지
    private String step_content;   //조리 가이드 설명

}
