package com.project.recipe.vo;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data 
@AllArgsConstructor 
@NoArgsConstructor 
@Alias ("community")
public class CommunityVO {

    private int community_id;
    private int member_id;
    private int recipe_id;
    private String target_type;
    private String title;
    private String content;
    private int view_count;
    private String status;

    private Date created_date;
    private Date update_date;

}
