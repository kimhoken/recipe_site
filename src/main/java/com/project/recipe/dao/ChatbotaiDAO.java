package com.project.recipe.dao;

import java.util.List;

import com.project.recipe.dto.ChatbotaiDTO;

public interface ChatbotaiDAO {

    // 자주 묻는 질문 조회
    List<ChatbotaiDTO> selectPopularQuestions();

    // 사용자 질문과 관련된 챗봇 정보 검색
    List<ChatbotaiDTO> searchChatbot(List<String> keywords);
 
}
