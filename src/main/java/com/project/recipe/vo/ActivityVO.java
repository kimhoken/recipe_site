package com.project.recipe.vo;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("activity")
public class ActivityVO {
    
    private String member_id;
    private String activity_type, activity_title, created_date;
}
