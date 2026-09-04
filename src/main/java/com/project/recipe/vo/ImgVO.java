package com.project.recipe.vo;

import org.apache.ibatis.type.Alias;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Alias("img")
public class ImgVO {

    private Integer img_id, notice_id, inquiry_id, review_id;
    private String image_list ;
}