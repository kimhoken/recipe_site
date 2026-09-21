package com.project.recipe.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor  //Lombok이 매개변수가 없는 기본 생성자를 자동으로 만들어주는 어노테이션
@AllArgsConstructor
public class ChatbotaiDTO {

    private Long chat_id;

    private String category;

    private String question;

    private String answer;

    private String keywords;

    private String link_url;

    private String link_text;

    private String use_yn;

    private LocalDateTime created_at;

    private LocalDateTime updated_at;

    private Integer sort_order;    
    
}
