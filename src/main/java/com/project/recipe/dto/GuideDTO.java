package com.project.recipe.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data 
@AllArgsConstructor
@NoArgsConstructor
@Alias("GuideDTO")
public class GuideDTO {
    
    private long guide_id; //가이드번호
    private String title;  //제목
    private String sub_title; //작은제목
    private String image; //대표이미지
    private String tab;          // storage, trim, tip, etc
    

}
