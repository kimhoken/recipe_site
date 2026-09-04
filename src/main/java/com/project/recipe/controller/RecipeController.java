package com.project.recipe.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.project.recipe.dao.RecipeDAO;
import com.project.recipe.vo.CookOrderVO;
import com.project.recipe.vo.RecipeVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class RecipeController {

    private final HttpSession session;
    private final RecipeDAO recipeDAO;

    // 레시피 목록 페이지
    @GetMapping(value="/recipe_list.do")
    public String recipeList(Model model) {
        
        model.addAttribute("recipeList", recipeDAO.getRecipeList());

        return "recipe/test/recipe_list";
    }

    // 레시피 상세 조회 페이지
    @GetMapping(value="/recipe_detail.do")
    public String recipeDetail(Model model, int recipe_id) {
        
        model.addAttribute("recipe", recipeDAO.getRecipeById(recipe_id));
        model.addAttribute("cookOrder", recipeDAO.getCookOrderById(recipe_id));

        return "recipe/test/recipe_detail";
    }

    // 레시피 등록 페이지
    @GetMapping(value="/recipe_insert.do")
    public String insertRecipe(Model model) {

        return "recipe/test/recipe_insert";
    }

    // 레시피 등록 
    @Transactional
    @PostMapping(value="/recipe_insert_pro.do")
    public String insertRecipePro(Model model, RecipeVO recipeVO, MultipartFile thumbnailFile) {
        recipeVO.setMember_id(1);

        recipeVO.setThumbnail(thumbnailFile.getOriginalFilename());

        recipeDAO.addRecipe(recipeVO);

        List<CookOrderVO> cookOrderList = new ArrayList<>();

        //조리 순서 이미지 리스트와 조리 순서 설명 리스트를 연결
        for (int i=0; i<recipeVO.getOrderImageList().size(); i++) {
            CookOrderVO cookOrder = new CookOrderVO();
            cookOrder.setRecipe_id(recipeVO.getRecipe_id());
            cookOrder.setCook_image(recipeVO.getOrderImageList().get(i).getOriginalFilename());
            cookOrder.setDescription(recipeVO.getOrderDescList().get(i));
            
            cookOrderList.add(cookOrder);
        }

        recipeDAO.addCookOrder(cookOrderList);
        
        return "recipe/test/recipe_insert_pro";
    }
}