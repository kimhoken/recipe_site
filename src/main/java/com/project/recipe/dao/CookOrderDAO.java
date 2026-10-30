package com.project.recipe.dao;

import java.util.List;

import com.project.recipe.vo.CookOrderVO;

public interface CookOrderDAO {
    List<CookOrderVO> cookorderList(int recipe_id);
}