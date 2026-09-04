package com.project.recipe.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Alias("notice")
public class NoticeVO {

    private int notice_id;
    private int member_id;

    private String title;
    private String content;

    private int view_count;
    private Date created_date;
}
