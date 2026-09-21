package com.project.recipe.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.recipe.dto.ChatbotaiDTO;
import com.project.recipe.dto.ChatbotResponseDTO;
import com.project.recipe.common.ChatbotaiService;
import com.project.recipe.common.OpenAIService;

import lombok.RequiredArgsConstructor;

@RestController 
@RequiredArgsConstructor 
public class ChatbotaiController {

    private final ChatbotaiService chatbotaiService;
    private final OpenAIService openAIService;
    
    // 챗봇 DB 검색 테스트
    @GetMapping("/api/chatbot/search")
    public List<ChatbotaiDTO> search(
            @RequestParam("keyword") String keyword) {

        return chatbotaiService.searchChatbot(keyword);
    }

    // OpenAI 키워드 추출 테스트
    @GetMapping("/api/chatbot/keywords")
    public List<String> extractKeywords(
            @RequestParam("question") String question) {

        return openAIService.extractKeywords(question);
    }

    @GetMapping("/api/chatbot/ask")
    public ChatbotResponseDTO askChatbot(
            @RequestParam("question") String question) {

        return chatbotaiService.askChatbot(question);
    }

    // 자주 묻는 질문 API 추가
    @GetMapping("/api/chatbot/popular")
    public List<ChatbotaiDTO> popularQuestions() {
        return chatbotaiService.selectPopularQuestions();
    }
}
