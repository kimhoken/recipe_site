package com.project.recipe.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.recipe.dao.GuideDAO;
import com.project.recipe.dto.GuideDTO;
import com.project.recipe.dto.GuideStepDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class GuideController {

    private final GuideDAO guideDao;

    @GetMapping("/guide_list.do")
    public String guideList(){
        return "guide/guide_list";
    }

    //전체보기,보관법,손질법...
    @ResponseBody
    @GetMapping("/guide_tab.do")
    public List<GuideDTO> guideTab(String tab) {

        Map<String, Object> map = new HashMap<>();
        map.put("tab", tab);

        return guideDao.guideTab(map);
    }

    //상세페이지
    @GetMapping("/guide_detail.do")
    public String detail(int guide_id, Model model) {

        GuideDTO guide = guideDao.Detail(guide_id);
        model.addAttribute("guide", guide);

        List<GuideStepDTO> stepList = guideDao.stepList(guide_id);
        model.addAttribute("stepList", stepList);
        
        return "guide/guide_detail";
    }

}
