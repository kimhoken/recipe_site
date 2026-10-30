package com.project.recipe.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper = true)
@AllArgsConstructor
@NoArgsConstructor
@Alias("adminrecipe")
public class AdminRecipeDTO extends SearchDTO {
    private String category_name, category;
    private Boolean recommend;

}
