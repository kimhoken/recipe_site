package com.project.recipe.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.recipe.dao.CommentDAO;
import com.project.recipe.vo.CommentVO;
import com.project.recipe.vo.MemberVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CommentController {

    private final CommentDAO commentDAO;
    private final HttpSession httpSession;

   
    @PostMapping("/comment/insert")
    @ResponseBody
    public Map<?, ?> commentInsert(CommentVO comment){
        MemberVO user = (MemberVO) httpSession.getAttribute("user");

        if (user == null) {
            return Map.of("result", "loginRequired");
        }

        comment.setMember_id(user.getMember_id());

        int result = commentDAO.insertComment(comment);

        return Map.of("result", result > 0 ? "success" : "fail");
    }

    @PostMapping("/comment/delete")
    @ResponseBody
    public Map<String, Object> recommentDelete(int comment_id){

        Map<String, Object> map =new HashMap<>();

        int result = commentDAO.deleteComment( comment_id ) ;
        map.put("result", result);
        return map;
    }
    
    @PostMapping("/comment/update")
    @ResponseBody
    public Map<String, String> recommentUpdate(CommentVO comment) {
        MemberVO user = (MemberVO) httpSession.getAttribute("user");

        if (user == null) {
            return Map.of("result", "loginRequired");
        }
        
        if (comment.getComment_id() == null
                || comment.getContent() == null
                || comment.getContent().isBlank()) {
            return Map.of("result", "fail");
        }
        
        comment.setMember_id(user.getMember_id());
        comment.setContent(comment.getContent().trim());

        int result = commentDAO.update(comment);

        return Map.of("result", result > 0 ? "success" : "fail");
    }


}
