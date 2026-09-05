package com.project.recipe.dao;

import java.util.List;

import com.project.recipe.vo.CookOrderVO;
import com.project.recipe.vo.RecipeVO;

public interface RecipeDAO {
    List<RecipeVO> getRecipeList(); // 레시피 목록 조회
    RecipeVO getRecipeById(int recipe_id); // 레시피 상세 조회

    List<CookOrderVO> getCookOrderById(int recipe_id); // 레시피 조리 순서 조회

    int addRecipe(RecipeVO recipeVO); // 레시피 등록
    int addCookOrder(List<CookOrderVO> cookOrderList); // 레시피 조리 순서 등록
}
