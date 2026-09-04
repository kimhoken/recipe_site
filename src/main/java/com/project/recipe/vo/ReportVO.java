package com.project.recipe.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Alias("report")
public class ReportVO {

    private Integer board_id, comment_id, recipe_id, review_id;

    private int report_id, member_id, admin_id, reported_count, report_count;

    private String target_type, reason, detail, status, admin_memo, report_title, nickname, name, email, profile_img;

    private Date created_date, processed_date;
}