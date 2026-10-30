package com.project.recipe.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.recipe.common.AdminUtil;
import com.project.recipe.common.Paging;
import com.project.recipe.dao.RecipeDAO;
import com.project.recipe.dao.RecipeManagementDAO;
import com.project.recipe.dto.AdminRecipeDTO;
import com.project.recipe.vo.CookOrderVO;
import com.project.recipe.vo.MemberVO;
import com.project.recipe.vo.RecipeVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AdminRecipeController {

    private final HttpSession httpSession;
    private final AdminUtil adminUtil;
    private final RecipeManagementDAO recipeManagementDAO;
    private final RecipeDAO recipeDAO;


    private Map<String, Object> getRecipePage(AdminRecipeDTO dto) {
        dto.setCategory(
            adminUtil.categorymapping(dto.getCategory_name()));
        int totalcount = recipeManagementDAO.RecipeCount(dto);
        
        Paging paging = new Paging(dto.getPage(), 5, totalcount);

        dto.setPage(paging.getPage());
        dto.setSize(paging.getSize());
        dto.setOffset(paging.getOffset());

        List<RecipeVO> list = recipeManagementDAO.RecipeList(dto);


        Map<String, Object> result = new HashMap<>();

        result.put("list", list);
        result.put("totalcount", totalcount);
        result.put("paging", paging);

        return result;
    }

    // 레시피 페이징 함수
    private void RecipePaging(Model model, AdminRecipeDTO adminRecipeDTO) {
        
        model.addAllAttributes(getRecipePage(adminRecipeDTO));
        model.addAttribute("searchrecipe", adminRecipeDTO);
    }


    // 레시피 페이지 검색 및 조회
    @GetMapping("/admin/recipe")
    public String adminrecipepage(AdminRecipeDTO adminRecipeDTO, Model model) {

        MemberVO user = (MemberVO) httpSession.getAttribute("user");

        model.addAttribute("profileuser", user);

        RecipePaging(model, adminRecipeDTO);

        adminUtil.setContentPage(model, "recipe");
        return "member/adminpage";
    }

    // 레시피 상세 조회 함수
    @PostMapping("/admin/recipe")
    @ResponseBody
    public Map<String, Object> recipedetail(int recipe_id) {

        RecipeVO recipe = recipeManagementDAO.selectrecipe(recipe_id);
        List<CookOrderVO> list = recipeDAO.getCookOrderById(recipe_id);

        Map<String, Object> map = new HashMap<>();
        map.put("recipe", recipe);
        map.put("list", list);
        return map;
    }

    // 레시피 검색 및 페이징 처리 
    @PostMapping("/admin/recipe/search")
    @ResponseBody
    public Map<String, Object> recipesearch(AdminRecipeDTO adminRecipeDTO, Model model) {
        return getRecipePage(adminRecipeDTO);         
    }   

    // 레시피 추천 등록/ 해제 함수
    @PostMapping("/admin/recipe/recommend")
    @ResponseBody
    public Map<String, Object> reciperecommend(int recipe_id){
        RecipeVO recipe = recipeManagementDAO.selectrecipe(recipe_id);
       
        recipe.setRecommend(recipe.getRecommend() == 1 ? 0 : 1);

        int res = recipeManagementDAO.updateRecipe(recipe);

        Map<String,Object> map = new HashMap<>();

        map.put("result",res );
        map.put("title",recipe.getTitle());
        map.put("recommend",recipe.getRecommend() == 1 );

        return map;
        }

    // 레시피 공개/비공개 함수
    @PostMapping("/admin/private")
    @ResponseBody
    public Map<String, Object> recipestatus(int recipe_id) {

        RecipeVO recipe = recipeManagementDAO.selectrecipe(recipe_id);
        if (recipe.getStatus().equals("ACTIVE")) {
            recipe.setStatus("HIDDEN");
        } else if (recipe.getStatus().equals("HIDDEN")) {
            recipe.setStatus("ACTIVE");
        }

        int res = recipeManagementDAO.updateStatus(recipe);

        Map<String, Object> map = new HashMap<>();

        map.put("result", res);
        map.put("title", recipe.getTitle());
        return map;

    }

    // 레시피 삭제/복원 함수
    @PostMapping("/admin/recipedel")
    @ResponseBody
    public Map<String, Object> recipe_delete(int recipe_id) {

        RecipeVO recipe = recipeManagementDAO.selectrecipe(recipe_id);
        if (!recipe.getStatus().equals("DELETE")) {
            recipe.setStatus("DELETE");
        } else {
            recipe.setStatus("ACTIVE");
        }

        int res = recipeManagementDAO.updateStatus(recipe);

        Map<String, Object> map = new HashMap<>();

        map.put("result", res);
        map.put("title", recipe.getTitle());
        map.put("status", recipe.getStatus());

        return map;
    }


}
