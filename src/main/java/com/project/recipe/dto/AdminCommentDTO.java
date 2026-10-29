package com.project.recipe.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
@Alias("admincomment")
public class AdminCommentDTO extends SearchDTO {
    private int comment_id;
    private String nickname, title, content, thumbnail, type ;
    private double rating; 
    private Date created_date;
}
