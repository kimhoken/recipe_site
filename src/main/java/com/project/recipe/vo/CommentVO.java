package com.project.recipe.vo;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("comment")
public class CommentVO {
    private Integer comment_id, rating, target_id, member_id, recipe_id;
    private String content, status, created_date, nickname, thumbnail, target_type;

}
 
