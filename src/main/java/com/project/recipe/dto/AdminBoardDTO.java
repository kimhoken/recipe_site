package com.project.recipe.dto;



import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper = true)
@AllArgsConstructor
@NoArgsConstructor
@Alias("adminboard")
public class AdminBoardDTO extends SearchDTO{
    private int community_id, view_count, comment_count;
    private String title, content, community_type, nickname, main_title, image;
    private Date created_date, updated_date;
}
