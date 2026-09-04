package com.project.recipe.dao;

import org.apache.ibatis.annotations.Mapper;

import com.project.recipe.vo.TokenVO;

@Mapper 
public interface TokenDAO {

    int insertToken(TokenVO vo);

    TokenVO getToken(String token);

    int deletetoken(int token_id);
    
}
