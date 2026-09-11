package com.project.recipe.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.recipe.dao.CommunityDAO;
import com.project.recipe.vo.CommunityVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor  
public class CommunityController {
    
    private final HttpSession httpSession;
    private final CommunityDAO communityDAO;

    @GetMapping ("/list.do")
    public String CommunityPage(Model model){
        List<CommunityVO> communityList = communityDAO.CheckList();

        model.addAttribute("list",communityList);

        return "community/community_list";

    }



}
