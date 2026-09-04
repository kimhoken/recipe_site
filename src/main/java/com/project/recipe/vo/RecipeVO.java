package com.project.recipe.vo;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Alias("recipe")
public class RecipeVO {
    private int recipe_id;
    private String title;
    private String thumbnail;
    private String cooking_time;
    private int view_count;
    private int like_count;
    private int member_id;
    private String status;
    private Date created_date;
    private Date updated_date;
    private int recommend;

    // cook_order 테이블
    private List<MultipartFile> orderImageList;
    private List<String> orderDescList;
}