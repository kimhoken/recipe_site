package com.project.recipe.vo;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Alias("cookOrder")
public class CookOrderVO {
    private int cook_order_id;
    private int cook_order;
    private String cook_image;
    private String description;
    private int recipe_id;
}