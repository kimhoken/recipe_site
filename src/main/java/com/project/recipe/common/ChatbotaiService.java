package com.project.recipe.common;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.recipe.dao.ChatbotaiDAO;
import com.project.recipe.dto.ChatbotaiDTO;
import com.project.recipe.dto.ChatbotResponseDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChatbotaiService {

    private final ChatbotaiDAO chatbotaiDAO;
    private final OpenAIService openAIService;

    public List<ChatbotaiDTO> searchChatbot(String question) {

        List<String> keywords = openAIService.extractKeywords(question);

        return chatbotaiDAO.searchChatbot(keywords);
    }

    public List<ChatbotaiDTO> selectPopularQuestions() {
        return chatbotaiDAO.selectPopularQuestions();
    }

    public ChatbotResponseDTO askChatbot(String question) {

        // AI로 검색 키워드 추출
        List<String> keywords = openAIService.extractKeywords(question);

        // DB 검색
        List<ChatbotaiDTO> chatbotData = chatbotaiDAO.searchChatbot(keywords);

        // 관련 정보가 없는 경우
        if (chatbotData.isEmpty()) {
            return new ChatbotResponseDTO(
                    "죄송해요. 해당 질문과 관련된 정보를 찾지 못했어요.",
                    null,
                    null);
        }

        // DB 정보를 기반으로 AI 답변 생성
        String answer = openAIService.generateAnswer(question, chatbotData);

        // 가장 관련 있는 검색 결과의 링크 사용
        ChatbotaiDTO data = chatbotData.get(0);

        return new ChatbotResponseDTO(
                answer,
                data.getLink_url(),
                data.getLink_text());
    }
}
