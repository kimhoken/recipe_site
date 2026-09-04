package com.project.recipe.vo;

import java.time.LocalDateTime;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("token")
public class TokenVO {
    private int token_id, member_id;
    private String token, used;
    private LocalDateTime created_date, expire_date;
}
