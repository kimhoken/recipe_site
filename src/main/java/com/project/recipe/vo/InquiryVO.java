package com.project.recipe.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Alias("inquiry")
public class InquiryVO {

    private Integer inquiry_id, member_id, admin_id, img_id;
    private String title, content, status, answer_content, guest_name, guest_email, guest_password, type, inquiry_code, nickname;
    private Date answered_date, created_date;

}
