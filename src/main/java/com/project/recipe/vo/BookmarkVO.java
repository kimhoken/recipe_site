package com.project.recipe.vo;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("bookmark")
public class BookmarkVO {
    private int bookmark_id, member_id, recipe_id;
    private String created_date, thumbnail, title, nickname;
}
