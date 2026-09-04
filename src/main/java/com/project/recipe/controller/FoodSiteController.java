package com.project.recipe.controller;

import java.util.*;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;



import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class FoodSiteController {
    

    private final HttpSession session;
    
    
    @GetMapping( value={"/", "/main_list.do"})
    public String food_main(Model model){
        
        return "main";
    }

    @PostMapping("/logout.do")
    @ResponseBody
    public Map<String, String> logout(@RequestBody Map<String, String> map) {
        session.removeAttribute("user");
        map.put("result", "success");
        return map;
    }

    

}
