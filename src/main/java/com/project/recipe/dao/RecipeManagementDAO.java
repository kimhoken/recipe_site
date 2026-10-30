package com.project.recipe.dao;

import java.util.List;

import com.project.recipe.dto.MypageDTO;
import com.project.recipe.vo.RecipeVO;

public interface RecipeManagementDAO {
    int countUserRecipe(MypageDTO dto);
    
    List<RecipeVO> getUserRecipeList( MypageDTO dto);

    List<RecipeVO> recentlyUserRecipe( int member_id );

}
