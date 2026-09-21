package com.project.recipe.common;


import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClient;

import com.project.recipe.dto.ChatbotaiDTO;

@Service
public class OpenAIService {

    @Value("${openai.api.key}")
    private String apiKey;

    private final RestClient restClient = RestClient.create();

    public List<String> extractKeywords(String question) {

        Map<String, Object> requestBody = Map.of(
            "model", "gpt-5.6-luna",
            "input",
            """
            다음 사용자 질문에서 웹사이트 DB 검색에 사용할 핵심 키워드만 추출해줘.

            규칙:
            - 핵심 키워드만 추출
            - 최대 5개
            - 조사나 불필요한 표현 제외
            - 비슷한 표현은 일반적인 단어로 변환
            - 쉼표(,)로만 구분
            - 설명은 하지 말 것

            사용자 질문:
            """ + question
        );

        Map<?, ?> response = restClient.post()
                .uri("https://api.openai.com/v1/responses")
                .header("Authorization", "Bearer " + apiKey)
                .header("Content-Type", "application/json")
                .body(requestBody)
                .retrieve()
                .body(Map.class);

        String result = extractOutputText(response);

        return Arrays.stream(result.split(","))
                .map(String::trim)
                .filter(keyword -> !keyword.isBlank())
                .toList();
    }

    public String generateAnswer(String question, List<ChatbotaiDTO> chatbotData) {

        // DB에서 검색된 정보를 AI에게 전달할 문자열로 변환
        StringBuilder context = new StringBuilder();

        for (ChatbotaiDTO data : chatbotData) {
            context.append("질문: ")
                .append(data.getQuestion())
                .append("\n");

            context.append("답변: ")
                .append(data.getAnswer())
                .append("\n\n");
        }

        Map<String, Object> requestBody = Map.of(
            "model", "gpt-5.6-luna",
            "input",
            """
            너는 요리 레시피 웹사이트의 고객지원 챗봇이야.

            아래의 [DB 정보]를 기준으로 사용자의 질문에 자연스럽게 답변해줘.

            규칙:
            - DB에 있는 정보를 우선하여 답변할 것
            - DB에 없는 사이트 기능이나 정책을 임의로 만들어내지 말 것
            - 짧고 친절하게 답변할 것
            - 사용자가 이해하기 쉬운 표현을 사용할 것
            - 링크나 URL은 임의로 만들지 말 것

            [사용자 질문]
            %s

            [DB 정보]
            %s
            """.formatted(question, context.toString())
        );

        Map<?, ?> response = restClient.post()
                .uri("https://api.openai.com/v1/responses")
                .header("Authorization", "Bearer " + apiKey)
                .header("Content-Type", "application/json")
                .body(requestBody)
                .retrieve()
                .body(Map.class);

        return extractOutputText(response);
    }

    private String extractOutputText(Map<?, ?> response) {

        if (response == null) {
            return "";
        }

        List<?> output = (List<?>) response.get("output");

        if (output == null || output.isEmpty()) {
            return "";
        }

        for (Object item : output) {

            if (!(item instanceof Map<?, ?> outputItem)) {
                continue;
            }

            List<?> content = (List<?>) outputItem.get("content");

            if (content == null) {
                continue;
            }

            for (Object contentItem : content) {

                if (!(contentItem instanceof Map<?, ?> contentMap)) {
                    continue;
                }

                if ("output_text".equals(contentMap.get("type"))) {
                    Object text = contentMap.get("text");

                    if (text != null) {
                        return text.toString();
                    }
                }
            }
        }

        return "";
    }
}