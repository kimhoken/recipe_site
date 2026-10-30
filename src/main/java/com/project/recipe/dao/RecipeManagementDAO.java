package com.project.recipe.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.recipe.dto.AdminRecipeDTO;
import com.project.recipe.dto.MypageDTO;
import com.project.recipe.vo.RecipeVO;

public interface RecipeManagementDAO {
    int countUserRecipe(MypageDTO dto);
    
    List<RecipeVO> getUserRecipeList( MypageDTO dto);

    List<RecipeVO> recentlyUserRecipe( int member_id );

    List<RecipeVO> recentlyrecipe();

    int RecipeCount(AdminRecipeDTO dto);

    List<RecipeVO> RecipeList(AdminRecipeDTO dto);

    RecipeVO selectrecipe(@Param("recipe_id") int recipe_id);

    int updateRecipe(RecipeVO recipe);

    int updateStatus(RecipeVO recipe);

}
