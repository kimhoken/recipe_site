package com.project.recipe.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.recipe.dao.CommunityDAO;
import com.project.recipe.vo.CommunityVO;
import com.project.recipe.vo.MemberVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor  
public class CommunityController {
    
    private final HttpSession httpSession;
    private final CommunityDAO communityDAO;

    @GetMapping ("/list.do")
    public String CommunityPage(Model model){

        MemberVO user = (MemberVO) httpSession.getAttribute("user");

        List<CommunityVO> communityList = communityDAO.CheckList();
        List<CommunityVO> noticeList = communityDAO.noticeList();

        model.addAttribute("user", user);
        model.addAttribute("community",communityList);
        model.addAttribute("notice", noticeList);

        return "community/community_list";

    }

    @GetMapping ("/communityInsert")
    public String communityInsert(Model model){

        MemberVO user = (MemberVO) httpSession.getAttribute("user");

        model.addAttribute("user", user);

        return "community/community_insertform";
    }



}
